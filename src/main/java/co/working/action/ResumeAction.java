package co.working.action;

import com.opensymphony.xwork2.ActionSupport;
import co.working.service.impl.ResumeServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

@Controller("resumeAction")
@Scope("prototype")
public class ResumeAction extends ActionSupport {

	private static final long serialVersionUID = 1L;		
		private ResumeServiceImpl resumeService;

		public ResumeServiceImpl getResumeService() {
			return resumeService;
		}
		@Autowired
		public void setResumeService(@Qualifier("resumeService")ResumeServiceImpl resumeService) {
			this.resumeService = resumeService;
		}
		
		
}
