package co.working.action;

import com.opensymphony.xwork2.ActionSupport;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.StandardChartTheme;
import org.jfree.data.general.DefaultPieDataset;
import org.springframework.stereotype.Controller;

import java.awt.*;

@Controller("chartAction")
public class ChartAction extends ActionSupport {

	private static final long serialVersionUID = 1L;
	private JFreeChart chart;
	
	public JFreeChart getChart() {
		return chart;
	}

	public void setChart(JFreeChart chart) {
		this.chart = chart;
	}

	@Override
	public String execute() throws Exception {
		//设置数据
        DefaultPieDataset data = new DefaultPieDataset();
        data.setValue("Java", new Double(43.2));
        data.setValue("Visual Basic", new Double(1.0));
        data.setValue("C/C++", new Double(17.5));
        data.setValue("tangjun", new Double(60.0));
      //创建主题样式  
        StandardChartTheme standardChartTheme=new StandardChartTheme("CN");  
        //设置标题字体  
        standardChartTheme.setExtraLargeFont(new Font("隶书",Font.BOLD,20));  
        //设置图例的字体  
        standardChartTheme.setRegularFont(new Font("宋书",Font.PLAIN,15));  
        //设置轴向的字体  
        standardChartTheme.setLargeFont(new Font("宋书",Font.PLAIN,15));  
        //应用主题样式  
        ChartFactory.setChartTheme(standardChartTheme); 
        chart=ChartFactory.createPieChart("柱状图", data, false, false, false);
        
        return SUCCESS;
	}
	
}
