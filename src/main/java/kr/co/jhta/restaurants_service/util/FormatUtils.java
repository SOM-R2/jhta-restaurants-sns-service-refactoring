package kr.co.jhta.restaurants_service.util;

public class FormatUtils {

	public static double getDouble(double value) {
		
        double formattedValue = Double.parseDouble(String.format("%.1f", value));

		return formattedValue;
	}

}
