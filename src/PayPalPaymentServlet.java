import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/PayPalPaymentServlet")
public class PayPalPaymentServlet extends HttpServlet {

    private static final String CLIENT_ID = "AeMwkK7mhxBwJ-cBW4_mZemtj8uIvx_2MM4Almo5kOLbuV49wnYeF6Pp1ZeQAgqTfM53Z_FcRdsvUhhj";
    private static final String CLIENT_SECRET = "ENA1gR0cJ1dwF8HpFHOTRiutr9S2EpRAeMRWj5au6TYf-7XkWS4cc-FI3N6-v3SFohzVacoeKcm1CoC8";
    private static final String PAYPAL_API = "https://sandbox.paypal.com";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String amount = request.getParameter("amount");

        String accessToken = getAccessToken();

        String paymentApprovalUrl = createPayment(accessToken, amount);

        if (paymentApprovalUrl != null) {
            response.sendRedirect(paymentApprovalUrl);
        } else {
            response.getWriter().println("Payment creation failed.");
        }
    }

    private String getAccessToken() throws IOException {
        URL url = new URL(PAYPAL_API + "/v1/oauth2/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Basic " + encodeBase64(CLIENT_ID + ":" + CLIENT_SECRET));
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        conn.setDoOutput(true);

        String requestBody = "grant_type=client_credentials";
        OutputStream os = conn.getOutputStream();
        os.write(requestBody.getBytes());
        os.flush();
        os.close();

        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            String jsonResponse = response.toString();
            String accessToken = jsonResponse.split("\"access_token\":\"")[1].split("\"")[0];
            return accessToken;
        }

        return null;
    }


    private String createPayment(String accessToken, String amount) throws IOException {
        URL url = new URL(PAYPAL_API + "/v1/payments/payment");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + accessToken);
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        String requestBody = "{\n" +
                "  \"intent\": \"sale\",\n" +
                "  \"redirect_urls\": {\n" +
                "    \"return_url\": \"http://localhost:8888/Paypal/PaymentSuccessServlet\",\n" +
                "    \"cancel_url\": \"http://localhost:8888/Paypal/PaymentCancelServlet\"\n" +
                "  },\n" +
                "  \"payer\": {\n" +
                "    \"payment_method\": \"paypal\"\n" +
                "  },\n" +
                "  \"transactions\": [\n" +
                "    {\n" +
                "      \"amount\": {\n" +
                "        \"total\": \"" + amount + "\",\n" +
                "        \"currency\": \"USD\"\n" +
                "      },\n" +
                "      \"description\": \"Payment description.\"\n" +
                "    }\n" +
                "  ]\n" +
                "}";

        OutputStream os = conn.getOutputStream();
        os.write(requestBody.getBytes());
        os.flush();
        os.close();

        int responseCode = conn.getResponseCode();
        if (responseCode == 201) {
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            JSONObject jsonResponse = new JSONObject(response.toString());
            JSONArray links = jsonResponse.getJSONArray("links");

            for (int i = 0; i < links.length(); i++) {
                JSONObject link = links.getJSONObject(i);
                if ("approval_url".equals(link.getString("rel"))) {
                    return link.getString("href");
                }
            }
        } else {
            System.out.println("Error response from PayPal: " + responseCode);
        }

        return null;
    }

    private String encodeBase64(String value) {
        return java.util.Base64.getEncoder().encodeToString(value.getBytes());
    }
}
