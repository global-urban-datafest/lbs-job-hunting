package co.working.service.impl;

import co.working.dao.ICommonDao;
import co.working.model.EmployeeRelation;
import co.working.service.ICommonService;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.Map.Entry;

@Service("employeeService")
public class EmployeeServiceImpl implements ICommonService<EmployeeRelation, Integer> {
	private ICommonDao<EmployeeRelation, Integer> employeeDao;
	@Autowired
	public void setCompanyDao(@Qualifier("employeeDao")ICommonDao<EmployeeRelation, Integer> employeeDao) {
		this.employeeDao = employeeDao;
	}
	
	public List<EmployeeRelation> findExampleByCriteria(String paramName,Object object){
	    DetachedCriteria criteria=DetachedCriteria.forClass(EmployeeRelation.class);
	    criteria.add(Property.forName(paramName).eq(object) );
		return employeeDao.findByCriteria(criteria);
	}
	
	public List<EmployeeRelation> findExampleByCriteria(String paramName,Object object,int firstResult,int maxResults){
	    DetachedCriteria criteria=DetachedCriteria.forClass(EmployeeRelation.class);
	    criteria.add(Property.forName(paramName).eq(object) );
		return employeeDao.findByCriteria(criteria, firstResult, maxResults);
	}
	
	public  List<EmployeeRelation> findByExample(EmployeeRelation exampleEntity) {
		return employeeDao.findByExample(exampleEntity);
	}
	
	public  List<EmployeeRelation> findByExample(EmployeeRelation exampleEntity, int firstResult,
			int maxResults) {
		return employeeDao.findByExample(exampleEntity, firstResult, maxResults);
	}

	public  EmployeeRelation get(Integer id) {
		return employeeDao.get(EmployeeRelation.class, id);
	}
	
	public List<EmployeeRelation> findByNamedParam(String queryString,
			String[] paramNames, Object[] values) {
		return employeeDao.findByNamedParam(queryString, paramNames, values);
	}
	
	public void merge(EmployeeRelation entity) {
		employeeDao.merge(entity);
	}
	
	public void delete(EmployeeRelation entity) {
		// TODO Auto-generated method stub
		employeeDao.delete(entity);
	}

	public void deleteAll(Collection<EmployeeRelation> entities) {
		// TODO Auto-generated method stub
		employeeDao.deleteAll(entities);
	}

	public void update(EmployeeRelation entity) {
		// TODO Auto-generated method stub
		employeeDao.update(entity);
	}

	public void updateAll(Collection<EmployeeRelation> entities) {
		// TODO Auto-generated method stub
		employeeDao.updateAll(entities);
	}

	public EmployeeRelation save(EmployeeRelation entity) {
		return employeeDao.save(entity);
	}

	public  List<EmployeeRelation> findAll(Class<EmployeeRelation> entityClass) {
		return employeeDao.findAll(entityClass);
	}

	public void saveOrUpdate(EmployeeRelation entity) {
		employeeDao.saveOrUpdate(entity);
	}
	@SuppressWarnings("unchecked")
	public List<Object> findExampleByNativeSql(String sql,int firstResult,int maxResults) {
			SessionFactory sf=employeeDao.getSessionFactory();
			Session session=sf.openSession();
			List<Object> list=session.createSQLQuery(sql)
					.addScalar("viewFlag")
					.addScalar("sendDate")
					.addScalar("positionName")
					.addScalar("workplace")
					.addScalar("refdesc")
					.addScalar("hotflag")
					.addScalar("realname")
					.addScalar("resumeId")
					.addScalar("hireinfoId")
					.addScalar("companyId")
					.setFirstResult(firstResult)
					.setMaxResults(maxResults)
					.list();
			session.close();
			return list;
	}
	@SuppressWarnings("unchecked")
	public int getCountByNativeSql(String sql) {
			int count=0;
			SessionFactory sf=employeeDao.getSessionFactory();
			Session session=sf.openSession();
			List<Object> list=session.createSQLQuery(sql).list();
			if(list!=null)
				count=list.size();
			session.close();
			return count;
	}
	
	public List<EmployeeRelation> findExampleByCriteriaAndMap(Map<String,Map<String,Object>> map){
        DetachedCriteria criteria=DetachedCriteria.forClass(EmployeeRelation.class);
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
        return employeeDao.findByCriteria(criteria);	
	}
}
