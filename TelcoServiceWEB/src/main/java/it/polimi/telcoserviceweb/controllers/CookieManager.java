package it.polimi.telcoserviceweb.controllers;

import org.apache.commons.lang.StringEscapeUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

public class CookieManager {
    /**
     * makes the sp, vp, op, sd cookies expire (used after the creation of the order)
     */
    public static void makeOrderCookieExpire(HttpServletRequest request, HttpServletResponse response) {
        Arrays.stream(request.getCookies()).forEach(cookie -> {
            switch (cookie.getName()) {
                case "sp":
                case "vp":
                case "op":
                case "sd":
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                    break;
            }
        });
    }

    /**
     * makes the sp, vp, op, sd cookies expire (used after the creation of the order)
     */
    public static void makeOrderToSeeCookieExpire(HttpServletRequest request, HttpServletResponse response) {
        Arrays.stream(request.getCookies()).forEach(cookie -> {
            if ("order_to_see".equals(cookie.getName())) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        });
    }

    /**
     * returns the map of the order info from the cookies
     */
    public static Map<String, Object> getOrderInfoCookie(HttpServletRequest request) throws ParseException {
        String[] ids = new String[4];

        // getting the order infos
        Arrays.stream(request.getCookies()).forEach(cookie -> {
            switch (cookie.getName()) {
                case "sp":
                    ids[0] = cookie.getValue();
                    break;
                case "vp":
                    ids[1] = cookie.getValue();
                    break;
                case "op":
                    ids[2] = cookie.getValue();
                    break;
                case "sd":
                    ids[3] = cookie.getValue();
                    break;
            }
        });
        return generateCookieMap(ids[0], ids[1], ids[2], ids[3]);
    }

    /**
     * generates the map of the order info from
     */
    public static Map<String, Object> generateCookieMap(String sp, String vp, String op, String sd) throws ParseException, NumberFormatException {
        final Map<String, Object> cookies = new HashMap<>();

        cookies.put("service_package", Integer.parseInt(sp));
        cookies.put("validity_period", Integer.parseInt(vp));
        if (op != null && !op.isEmpty() && !op.equals("null")) {
            cookies.put("optional_products", Arrays.stream(op.replaceAll("\\[", "").replaceAll("]", "")
                    .split("-")).filter(x -> !x.equals("")).map(Integer::parseInt).collect(Collectors.toList()));
        }
        cookies.put("start_date_subscription", (new SimpleDateFormat("yyyy-MM-dd")).parse(StringEscapeUtils.escapeJava(sd)));

        return cookies;
    }
}
