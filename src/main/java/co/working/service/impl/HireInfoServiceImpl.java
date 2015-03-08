package co.working.service.impl;

import co.working.dao.ICommonDao;
import co.working.model.HireInfo;
import co.working.service.ICommonService;
import net.sf.json.JSONObject;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

@Service("hireinfoService")
public class HireInfoServiceImpl implements ICommonService<HireInfo, Integer> {
	private ICommonDao<HireInfo, Integer> hireInfoDao;
	@Autowired
	public void setHireInfoDao(@Qualifier("hireInfoDao")ICommonDao<HireInfo, Integer> hireInfoDao) {
		this.hireInfoDao = hireInfoDao;
	}
	 public void save(HireInfo hireinfo) {
		 hireInfoDao.merge(hireinfo);
	    }

	    public List<HireInfo> findAllByExample(HireInfo hireinfo){
	        return hireInfoDao.findByExample(hireinfo);
	    }

	    public List<HireInfo> findAllByCriteria(String paramName,Object value){
	        DetachedCriteria criteria=DetachedCriteria.forClass(HireInfo.class);
	        criteria.add(Property.forName(paramName).eq(value) );
	        return hireInfoDao.findByCriteria(criteria);
	    }
	    public List<HireInfo> findAllByCriteria(String paramName,Object value,int firstResult,int maxResult){
	        DetachedCriteria criteria=DetachedCriteria.forClass(HireInfo.class);
	        criteria.add(Property.forName(paramName).eq(value) );
	        return hireInfoDao.findByCriteria(criteria,firstResult,maxResult);
	    }
		public HireInfo findExampleById(int id) {
			return hireInfoDao.get(HireInfo.class, id);
		}
	    public void update(HireInfo hireinfo) {
	    	hireInfoDao.merge(hireinfo);
	    }
	    public void delete(int id){
	    	HireInfo hireinfo=new HireInfo();
	    	hireinfo.setId(id);
	        hireInfoDao.delete(hireinfo);
	        hireinfo=null;
	    }
	    public void delete(HireInfo hireinfo){
	    	hireInfoDao.delete(hireinfo);
	    }
		public List<HireInfo> findByNamedParam(String queryString,
				String[] paramNames, Object[] values) {
			return hireInfoDao.findByNamedParam(queryString, paramNames, values);
		}
		@SuppressWarnings("hiding")
		public <HireInfo> List<HireInfo> findByExample(HireInfo exampleEntity, int firstResult,
				int maxResults) {
			return hireInfoDao.findByExample(exampleEntity, firstResult, maxResults);
		}
		public int getCount(String paramName,Object value){
			int total=0;
			List<HireInfo> list=findAllByCriteria(paramName,value);
			if(list!=null&&list.size()>0)
				total=list.size();
			return total;
		}
		public HireInfo get(int id) {
			return hireInfoDao.get(HireInfo.class, id);
		}
		
		public List<HireInfo> findExampleByCriteriaAndMap(Map<String,Map<String,Object>> map){
	        DetachedCriteria criteria=DetachedCriteria.forClass(HireInfo.class);
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
	        return hireInfoDao.findByCriteria(criteria);	
		}
		public List<HireInfo> findExampleByCriteriaAndMap(Map<String,Map<String,Object>> map, int firstResult,
				int maxResults){
	        DetachedCriteria criteria=DetachedCriteria.forClass(HireInfo.class);
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
	        return hireInfoDao.findByCriteria(criteria,firstResult,maxResults);	
		}
		public JSONObject findAllHireinfo(int i, int rows) {
			SessionFactory sf=hireInfoDao.getSessionFactory();
			Session session=sf.openSession();
			
			session.close();
			return null;
		}
}
