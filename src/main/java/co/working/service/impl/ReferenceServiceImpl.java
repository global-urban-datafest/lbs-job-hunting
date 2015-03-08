package co.working.service.impl;

import co.working.common.TableName;
import co.working.dao.ICommonDao;
import co.working.model.CommonReference;
import co.working.service.ICommonService;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service("referenceService")
public class ReferenceServiceImpl implements ICommonService<CommonReference,Integer> {

	private ICommonDao<CommonReference,Integer> referenceDao;
	
	

    public ICommonDao<CommonReference,Integer> getReferenceDao() {
		return referenceDao;
	}
    @Autowired
	public void setReferenceDao(@Qualifier("referenceDao")ICommonDao<CommonReference,Integer> referenceDao ) {
		this.referenceDao = referenceDao;
	}
    
    public  List<CommonReference> findAllByCriteria(String tableName){
        DetachedCriteria criteria=DetachedCriteria.forClass(CommonReference.class);
        criteria.add(Property.forName("tableName").eq(tableName) );
    	return this.getReferenceDao().findByCriteria(criteria);
    }
    public  List<CommonReference> findAll(Class<CommonReference> entityClass){
        return this.getReferenceDao().findAll(entityClass);
    }
	public void save(CommonReference entity) {
		 this.getReferenceDao().merge(entity);
	}
    public void initBaseReference(HttpSession session){
        /*性别*/
       List<CommonReference>  sexs=findAllByCriteria(TableName.SEX.getName());
        if(session.getAttribute("sexs")!=null)
            session.removeAttribute("sexs");
        session.setAttribute("sexs",sexs);
        sexs=null;
        /*证件类型*/
        List<CommonReference>  documenttypes=findAllByCriteria(TableName.DOCUMENTTYPE.getName());
        if(session.getAttribute("documenttypes")!=null)
            session.removeAttribute("documenttypes");
        session.setAttribute("documenttypes",documenttypes);
        documenttypes=null;
        /*当前收入*/
        List<CommonReference>  salarys=findAllByCriteria(TableName.CURRENTSALERY.getName());
        if(session.getAttribute("salarys")!=null)
            session.removeAttribute("salarys");
        session.setAttribute("salarys",salarys);
        salarys=null;
        /*当前工作状况*/
        List<CommonReference> jobstatuses=findAllByCriteria(TableName.JOBSTATUS.getName());
        if(session.getAttribute("jobstatuses")!=null)
            session.removeAttribute("jobstatuses");
        session.setAttribute("jobstatuses",jobstatuses);
        jobstatuses=null;
        /*语言*/
        List<CommonReference>  languages=findAllByCriteria(TableName.LANGUAGE.getName());
        if(session.getAttribute("languages")!=null)
            session.removeAttribute("languages");
        session.setAttribute("languages",languages);
        languages=null;
        /*婚姻状态*/
        List<CommonReference>  marriagestatuses=findAllByCriteria(TableName.MARRIAGESTATUS.getName());
        if(session.getAttribute("marriagestatuses")!=null)
            session.removeAttribute("marriagestatuses");
        session.setAttribute("marriagestatuses",marriagestatuses);
        marriagestatuses=null;
        /*政治状态*/
        List<CommonReference>  polictictypes=findAllByCriteria(TableName.POLITICTYPE.getName());
        if(session.getAttribute("polictictypes")!=null)
            session.removeAttribute("polictictypes");
        session.setAttribute("polictictypes",polictictypes);
        polictictypes=null;
        /*职位类型*/
        List<CommonReference>  positiontypes=findAllByCriteria(TableName.POSITIONTYPE.getName());
        if(session.getAttribute("positiontypes")!=null)
            session.removeAttribute("positiontypes");
        session.setAttribute("positiontypes",positiontypes);
        positiontypes=null;
        /*工作类型*/
        List<CommonReference>  worktypes=findAllByCriteria(TableName.WORKTYPE.getName());
        if(session.getAttribute("worktypes")!=null)
            session.removeAttribute("worktypes");
        session.setAttribute("worktypes",worktypes);
        worktypes=null;
        /*工作年限*/
        List<CommonReference>  workyears=findAllByCriteria(TableName.WORKYEAR.getName());
        if(session.getAttribute("workyears")!=null)
            session.removeAttribute("workyears");
        session.setAttribute("workyears",workyears);
        workyears=null;
        /*公司大小*/
        List<CommonReference>  companysizes=findAllByCriteria(TableName.COMPANYSIZE.getName());
        if(session.getAttribute("companysizes")!=null)
            session.removeAttribute("companysizes");
        session.setAttribute("companysizes",companysizes);
        companysizes=null;
        /* 公司类型*/
        List<CommonReference>  companytypes=findAllByCriteria(TableName.COMPANYTYPE.getName());
        if(session.getAttribute("companytypes")!=null)
            session.removeAttribute("companytypes");
        session.setAttribute("companytypes",companytypes);
        companytypes=null;
    }
}
