package co.working.dao.impl;

import co.working.model.CommonReference;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository("referenceDao")
public class ReferenceDaoImpl  extends ICommonDaoImpl<CommonReference, Integer>{

	public ReferenceDaoImpl() {
		super(CommonReference.class);
	}

	@Override
	public <T> T get(Class<T> entityClass, Integer id) {
		// TODO Auto-generated method stub
		return super.get(entityClass, id);
	}

	@Override
	public <T> List<T> findByExample(T exampleEntity) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity);
	}

	@Override
	public List<CommonReference> find(String queryString, Object... values) {
		// TODO Auto-generated method stub
		return super.find(queryString, values);
	}

	@Override
	public <T> List<T> findByExample(T exampleEntity, int firstResult,
			int maxResults) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity, firstResult, maxResults);
	}

	@Override
	public List<CommonReference> findByNamedParam(String queryString,
			String[] paramNames, Object[] values) {
		// TODO Auto-generated method stub
		return super.findByNamedParam(queryString, paramNames, values);
	}

	@Override
	public List<CommonReference> findByCriteria(DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria);
	}

	@Override
	public List<CommonReference> findByCriteria(DetachedCriteria criteria,
			int firstResult, int maxResults) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria, firstResult, maxResults);
	}


	@Override
	public void delete(CommonReference entity) {
		// TODO Auto-generated method stub
		super.delete(entity);
	}

	@Override
	public void deleteAll(Collection<CommonReference> entities) {
		// TODO Auto-generated method stub
		super.deleteAll(entities);
	}

	@Override
	public void update(CommonReference entity) {
		// TODO Auto-generated method stub
		super.update(entity);
	}

	@Override
	public void updateAll(Collection<CommonReference> entities) {
		// TODO Auto-generated method stub
		super.updateAll(entities);
	}

	@Override
	public <T> List<T> findAll(Class<T> entityClass) {
		// TODO Auto-generated method stub
		return super.findAll(entityClass);
	}

	
   
}
