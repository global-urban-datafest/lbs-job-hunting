package co.working.dao.impl;

import co.working.model.HireInfo;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository("hireInfoDao")
public class HireInfoDaoImpl extends ICommonDaoImpl<HireInfo, Integer> {

	public HireInfoDaoImpl() {
		super(HireInfo.class);
	}

	@SuppressWarnings("hiding")
	@Override
	public <HireInfo> HireInfo get(Class<HireInfo> entityClass, Integer id) {
		// TODO Auto-generated method stub
		return super.get(entityClass, id);
	}

	@SuppressWarnings("hiding")
	@Override
	public <HireInfo> List<HireInfo> findByExample(HireInfo exampleEntity) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity);
	}

	@Override
	public List<HireInfo> find(String queryString, Object... values) {
		// TODO Auto-generated method stub
		return super.find(queryString, values);
	}

	@SuppressWarnings("hiding")
	@Override
	public <HireInfo> List<HireInfo> findByExample(HireInfo exampleEntity, int firstResult,
			int maxResults) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity, firstResult, maxResults);
	}

	@Override
	public List<HireInfo> findByNamedParam(String queryString,
			String[] paramNames, Object[] values) {
		// TODO Auto-generated method stub
		return super.findByNamedParam(queryString, paramNames, values);
	}

	@Override
	public List<HireInfo> findByCriteria(DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria);
	}

	@Override
	public List<HireInfo> findByCriteria(DetachedCriteria criteria,
			int firstResult, int maxResults) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria, firstResult, maxResults);
	}

	@Override
	public void merge(HireInfo entity) {
		// TODO Auto-generated method stub
		super.merge(entity);
	}

	@Override
	public void delete(HireInfo entity) {
		// TODO Auto-generated method stub
		super.delete(entity);
	}

	@Override
	public void deleteAll(Collection<HireInfo> entities) {
		// TODO Auto-generated method stub
		super.deleteAll(entities);
	}

	@Override
	public void update(HireInfo entity) {
		// TODO Auto-generated method stub
		super.update(entity);
	}

	@Override
	public void updateAll(Collection<HireInfo> entities) {
		// TODO Auto-generated method stub
		super.updateAll(entities);
	}

	@Override
	public HireInfo save(HireInfo entity) {
		// TODO Auto-generated method stub
		return super.save(entity);
	}

	@SuppressWarnings("hiding")
	@Override
	public <HireInfo> List<HireInfo> findAll(Class<HireInfo> entityClass) {
		// TODO Auto-generated method stub
		return super.findAll(entityClass);
	}

	@Override
	public void saveOrUpdate(HireInfo entity) {
		// TODO Auto-generated method stub
		super.saveOrUpdate(entity);
	}
	

}
