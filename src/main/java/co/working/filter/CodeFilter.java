package co.working.filter;

import javax.servlet.*;
import java.io.IOException;

public class CodeFilter implements Filter {

    public void destroy() {
        // TODO Auto-generated method stub
    }

    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding("gb2312");
        response.setCharacterEncoding("gb2312");
        chain.doFilter(request, response);

    }

    public void init(FilterConfig arg0) throws ServletException {
        // TODO Auto-generated method stub
    }

}
