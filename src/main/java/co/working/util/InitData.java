package co.working.util;

import co.working.model.CommonReference;
import co.working.service.impl.ReferenceServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.util.List;

@Component("initData")
public class InitData {

	private ReferenceServiceImpl referenceService;

	public ReferenceServiceImpl getReferenceService() {
		return referenceService;
	}
	@Autowired
	public void setReferenceService(@Qualifier("referenceService")ReferenceServiceImpl referenceService) {
		this.referenceService = referenceService;
	}
	/*
	 * 初始化基础REFERENCE数据
	 * */
	public void  init(CommonReference comref){
        referenceService.save(comref);
	}
	
	public void  init(List<CommonReference> list){
		if(list!=null&&list.size()>0){
			for(CommonReference ref:list){
				referenceService.save(ref);
			}
		}
	}
}
