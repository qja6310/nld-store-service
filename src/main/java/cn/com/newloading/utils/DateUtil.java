package cn.com.newloading.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class DateUtil {

	/**
	 * Date转String
	 * @param time  时间
	 * @param format  输出格式
	 * @return
	 */
	public static String dateToString(Date time,String format) {
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		String dateString = formatter.format(time);
		return dateString;
	}

	/**
	 * 指定格式
	 * @param time
	 * @return
	 */
	public static String dateToString(Date time) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateString = formatter.format(time);
		return dateString;
	}

	/**
	 * String转Date
	 * @param time  时间
	 * @param format  时间格式
	 * @return
	 */
	public static Date stringToDate(String time,String format) {
		DateFormat df = new SimpleDateFormat(format);
		Date date = null;
		try {
			date = df.parse(time);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 时间格式转换
	 * @param time
	 * @param iFormat  输入格式
	 * @param oFormat  输出格式
	 * @return
	 */
	public static String dataFormatting(String time,String iFormat,String oFormat) {
		SimpleDateFormat sdf = new SimpleDateFormat(iFormat, Locale.ENGLISH);
		SimpleDateFormat formatter = new SimpleDateFormat(oFormat);
		Date date = null;
		try {
			date = sdf.parse(time);
			time = formatter.format(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return time;
	}

	/**
	 * 获取当前的年份
	 * @return
	 */
	public static String currentYear(){
		return dateToString(new Date(),"yyyy");
	}

	/**
	 * 判断字符串日期，按指定格式是否合法
	 *
	 * 例子: isValidateDate("2013-01-01","yyyyMMdd")= false
	 * isValidateDate("20130230","yyyyMMdd")= false
	 * isValidateDate("20130228","yyyyMMdd")= true
	 *
	 * @param date
	 *            字符串日期
	 * @param fmt
	 *            日期格式
	 * @return 合法返回true;否则返回false
	 */
	public static boolean isValidateDate(String date, String fmt) {
		SimpleDateFormat sdf = new SimpleDateFormat(fmt);
		// 严格日期格式检查
		sdf.setLenient(false);
		try {
			sdf.parse(date);
			return true;
		} catch (ParseException e) {
			return false;
		}
	}

	/**
	 * 当前日期加几天
	 * @param dateStr
	 * @param x
	 * @return
	 */
	public static String getDateStrAddXDays(String dateStr,int x) {
		int intYear = Integer.parseInt(dateStr.substring(0, 4));
		int intMonth = Integer.parseInt(dateStr.substring(4, 6));
		int intDate = Integer.parseInt(dateStr.substring(6, 8));
		Calendar cal = Calendar.getInstance();
		cal.set(intYear, intMonth - 1, intDate);
		cal.add(Calendar.DATE, x);
		Date date = cal.getTime();
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
		return df.format(date);
	}
}
