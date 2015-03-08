/**
 * @author tonyli
 *
 */
package co.working.util.convert;

import com.opensymphony.xwork2.conversion.impl.DefaultTypeConverter;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

public class DateConverter extends DefaultTypeConverter {

	@Override
	public Object convertValue(Map<String, Object> context, Object value,
			Class toType) {
		if (toType == Date.class) {
			// 浏览器向服务器提交时，进行String to Date的转换
			Date date = null;
			String dateString = null;
			String[] params = (String[]) value;
			dateString = params[0];
				try{
						 date =new SimpleDateFormat("MM/dd/yyyy").parse(dateString);
					} catch (Exception e) {
						return null;
					}
				return date;
			}else
		if (toType == String.class) {
			// 服务器向浏览器输出时，进行Date to String的类型转换
			Date date = (Date) value;
			return new SimpleDateFormat("MM/dd/yyyy").format(date);//
		} else
		return null;
	}

}