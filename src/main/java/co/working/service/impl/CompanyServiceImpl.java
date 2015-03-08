package co.working.service.impl;

import co.working.dao.ICommonDao;
import co.working.model.Company;
import co.working.service.ICommonService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

@Service("companyService")
public class CompanyServiceImpl implements ICommonService<Company, Integer> {
	private ICommonDao<Company, Integer> companyDao;
	@Autowired
	public void setCompanyDao(@Qualifier("companyDao")ICommonDao<Company, Integer> companyDao) {
		this.companyDao = companyDao;
	}
	public void save(Company company){
		companyDao.save(company);
	}
	public List<Company> findExampleByCriteria(String paramName,Object obj,int firstResult,int maxResults){
        DetachedCriteria criteria=DetachedCriteria.forClass(Company.class);
        criteria.add(Property.forName(paramName).eq(obj));
        return companyDao.findByCriteria(criteria,firstResult,maxResults);	
	}
	public List<Company> findExampleByCriteria(String paramName,Object obj){
        DetachedCriteria criteria=DetachedCriteria.forClass(Company.class);
        criteria.add(Property.forName(paramName).eq(obj));
        return companyDao.findByCriteria(criteria);	
	}
	public List<Company> findByExample(Company company){
		return companyDao.findByExample(company);
	}
	public void update(Company company){
		 companyDao.merge(company);
	}
	public Company findExampleById(int id) {
		return companyDao.get(Company.class, id);
	}
	
	public List<Company> findExampleByCriteriaAndMap(Map<String,Map<String,Object>> map){
        DetachedCriteria criteria=DetachedCriteria.forClass(Company.class);
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
        return companyDao.findByCriteria(criteria);	
	}
	
	public Company get(int id) {
		return companyDao.get(Company.class, id);
	}
	
	@SuppressWarnings("unchecked")
	public JSONObject findAllCompany(int i, int rows) {
		SessionFactory sf=companyDao.getSessionFactory();
		Session session=sf.openSession();
		Query query=session.createQuery("from Company company");
		List<Company> elist=query.list();
		int count=0;
		if(elist!=null&&elist.size()>0)
			count=elist.size();
		else
			count=0;
		List<Company> list=query.setMaxResults(rows).setFirstResult(i).list();
		JSONObject data=new JSONObject();
		data.accumulate("total", count);
		if(list!=null&&list.size()>0){
			JSONArray arr=new JSONArray();
   			SimpleDateFormat sff=new SimpleDateFormat("yyyy-MM-dd");
			for(Company co:list){
				JSONObject obj=new JSONObject();
				 obj.accumulate("id",co.getId());
				 obj.accumulate("cpy_loginName",co.getCpy_loginName()==null?"":co.getCpy_loginName());//登录名
				 obj.accumulate("companyName",co.getCompanyName()==null?"":co.getCompanyName());//公司名
				 obj.accumulate("companyDesc",co.getCompanyDesc()==null?"":co.getCompanyDesc());//公司描述
				 obj.accumulate("legalPerson",co.getLegalPerson()==null?"":co.getLegalPerson());//法人代表
				 obj.accumulate("companyURL",co.getCompanyURL()==null?"":co.getCompanyURL());//公司网址
				 obj.accumulate("companyTel",co.getCompanyTel()==null?"":co.getCompanyTel());//公司电话
				 obj.accumulate("companyEmail",co.getCompanyEmail()==null?"":co.getCompanyEmail());//公司email
				 obj.accumulate("cpy_hot_flag",co.isCpy_hot_flag());//是否为热门公司
				 obj.accumulate("companyAddress",co.getCompanyAddress()==null?"":co.getCompanyAddress());//公司地址
				 if(co.getLastLoginDate()==null)
					 obj.accumulate("lastLoginDate","");//上次登录信息
				 else
					 obj.accumulate("lastLoginDate",sff.format(co.getLastLoginDate()));//上次登录信息
				 if(co.getCreationDate()==null)
					 obj.accumulate("creationDate","");//创建时间
				 else
					 obj.accumulate("creationDate",sff.format(co.getCreationDate()));//创建时间
				arr.add(obj);
			}
			data.accumulate("rows", arr);
		}else{
			data.accumulate("rows", "");
		}
		session.close();
		return data;
	}
	public void merge(Company company) {
		companyDao.merge(company);
	}
}
