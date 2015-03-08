package co.working.service.impl;

import co.working.dao.ICommonDao;
import co.working.model.Resume;
import co.working.model.ResumeDetail;
import co.working.service.ICommonService;
import co.working.util.CommonUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

@Service("resumeService")
public class ResumeServiceImpl implements ICommonService<Resume ,Integer> {

	private ICommonDao<Resume, Integer> resumeDao;


    public ICommonDao<Resume, Integer> getResumeDao() {
		return resumeDao;
	}
    @Autowired
	public void setResumeDao(ICommonDao<Resume, Integer> resumeDao) {
		this.resumeDao = resumeDao;
	}

    public void save(Resume resume) {
        this.getResumeDao().merge(resume);
    }

    public List<Resume> findAllByExample(Resume resume){
        return this.getResumeDao().findByExample(resume);
    }

	public Resume findExampleById(int id) {
		return this.getResumeDao().get(Resume.class, id);
	}
    public void update(Resume resume) {
        this.getResumeDao().update(resume);
    }
    public void delete(int id){
        Resume resume=new Resume();
        resume.setId(id);
        this.getResumeDao().delete(resume);
        resume=null;
    }
    public void delete(Resume resume){
        this.getResumeDao().delete(resume);
    }
    public int getCount(String paramName,Object obj){
		int total=0;
		List<Resume> list=findAllByCriteria(paramName,obj);
		if(list!=null&&list.size()>0)
			total=list.size();
		return total;
    }
    public List<Resume> findAllByCriteria(String paramName,Object obj){
        DetachedCriteria criteria=DetachedCriteria.forClass(Resume.class);
        criteria.add(Property.forName(paramName).eq(obj));
        return this.getResumeDao().findByCriteria(criteria);
    }
    public List<Resume> findAllByCriteria(String paramName,Object obj,int firstResult,int maxResults){
        DetachedCriteria criteria=DetachedCriteria.forClass(Resume.class);
        criteria.add(Property.forName(paramName).eq(obj));
        return this.getResumeDao().findByCriteria(criteria,firstResult,maxResults);
    }
    
    public Resume get(int id){
    	return this.getResumeDao().get(Resume.class, id);
    }
    
	public List<Resume> findByNamedParam(String queryString,
			String[] paramNames, Object[] values) {
		return this.getResumeDao().findByNamedParam(queryString, paramNames, values);
	}
	public List<Resume> findExampleByCriteriaAndMap(Map<String,Map<String,Object>> map){
        DetachedCriteria criteria=DetachedCriteria.forClass(Resume.class);
		if(map!=null&&map.size()>0){
			Set<Entry<String, Map<String,Object>>> set =map.entrySet();
			Iterator<Entry<String, Map<String,Object>>> it=set.iterator();
			while(it.hasNext()){
				Entry<String, Map<String,Object>> entry= it.next();
				String key=entry.getKey();
				if(key.equals("like")){
					Map<String,Object> submap=entry.getValue();
					if(submap!=null&&submap.size()>0){
						Set<String>	subset=submap.keySet();
						for(String subkey:subset){
							Object obj=submap.get(subkey);
					        criteria.add(Property.forName(subkey).like("%"+obj+"%"));
					        obj=null;
						}
						subset=null;
					}else{
						continue;
					}
					submap=null;
				}else if(key.equals("eq")){
					Map<String,Object> submap=entry.getValue();
					if(submap!=null&&submap.size()>0){
						Set<String>	subset=submap.keySet();
						for(String subkey:subset){
							Object obj=submap.get(subkey);
					        criteria.add(Property.forName(subkey).eq(obj));
					        obj=null;
						}
						subset=null;
					}else{
						continue;
					}
					submap=null;
				}else{
					continue;
				}

			}
		}
        return resumeDao.findByCriteria(criteria);	
	}
	@SuppressWarnings("unchecked")
	public JSONObject findAllResume(int i, int rows) {
		SessionFactory sf=resumeDao.getSessionFactory();
		Session session=sf.openSession();
		Query query=session.createQuery("from Resume resume");
		List<Resume> elist=query.list();
		int count=0;
		if(elist!=null&&elist.size()>0)
			count=elist.size();
		else
			count=0;
		List<Resume> list=query.setMaxResults(rows).setFirstResult(i).list();
		JSONObject data=new JSONObject();
		data.accumulate("total", count);
		if(list!=null&&list.size()>0){
			JSONArray arr=new JSONArray();
   			SimpleDateFormat sff=new SimpleDateFormat("yyyy-MM-dd");
			for(Resume re:list){
				JSONObject obj=new JSONObject();
				 obj.accumulate("resumeId",re.getId());
				 obj.accumulate("name",re.getName());
				 obj.accumulate("public_flag",re.getPublic_flag()==null?false:re.getPublic_flag());
				 obj.accumulate("compeletepercent",getResumePercent(re)+"%");
				 if(re.getCreationdate()!=null)
					 obj.accumulate("creationdate",sff.format(re.getCreationdate()));
				 else
					 obj.accumulate("creationdate",""); 
				 obj.accumulate("defaultResumeFlag",re.isDefaultResumeFlag());
				 obj.accumulate("userId",re.getUser().getId());
				 obj.accumulate("userName",re.getUser().getName()==null?"":re.getUser().getName());
				 obj.accumulate("resumeDetailId",re.getResumeDetail().getId());
				arr.add(obj);
			}
			data.accumulate("rows", arr);
		}else{
			data.accumulate("rows", "");
		}
		session.close();
		return data;
	}
    /*
     * 计算简历百分比
     * */
    private Double getResumePercent(Resume resume){
    	Double pe=0.0;
    	if(resume!=null&&resume.getId()!=0){
    		ResumeDetail rd=resume.getResumeDetail();
    		if(rd!=null){
    			pe=CommonUtil.getPercent(rd);
    		}
    		resume.setCompeletepercent(pe);
    		if(pe.equals(1%1.0)){
    			resume.setCompeleteflag(true);
    		}
    	}
    	return pe;
    }
	public void deleteAll(List<Resume> list) {
		resumeDao.deleteAll(list);
	}
	public void merge(Resume resume) {
		resumeDao.merge(resume);
	}
    
}
