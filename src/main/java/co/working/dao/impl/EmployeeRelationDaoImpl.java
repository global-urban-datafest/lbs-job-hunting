package co.working.dao.impl;

import co.working.model.EmployeeRelation;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository("employeeDao")
public class EmployeeRelationDaoImpl extends ICommonDaoImpl<EmployeeRelation, Integer> {

    public EmployeeRelationDaoImpl() {
        super(EmployeeRelation.class);
    }

	@SuppressWarnings("hiding")
	@Override
	public <EmployeeRelation> EmployeeRelation get(Class<EmployeeRelation> entityClass, Integer id) {
		// TODO Auto-generated method stub
		return super.get(entityClass, id);
	}

	@SuppressWarnings("hiding")
	@Override
	public <EmployeeRelation> List<EmployeeRelation> findByExample(EmployeeRelation exampleEntity) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity);
	}

	@Override
	public List<EmployeeRelation> find(String queryString, Object... values) {
		// TODO Auto-generated method stub
		return super.find(queryString, values);
	}

	@SuppressWarnings("hiding")
	@Override
	public <EmployeeRelation> List<EmployeeRelation> findByExample(EmployeeRelation exampleEntity, int firstResult,
			int maxResults) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity, firstResult, maxResults);
	}

	@Override
	public List<EmployeeRelation> findByNamedParam(String queryString,
			String[] paramNames, Object[] values) {
		// TODO Auto-generated method stub
		return super.findByNamedParam(queryString, paramNames, values);
	}

	@Override
	public List<EmployeeRelation> findByCriteria(DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria);
	}

	@Override
	public List<EmployeeRelation> findByCriteria(DetachedCriteria criteria,
			int firstResult, int maxResults) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria, firstResult, maxResults);
	}

	@Override
	public void merge(EmployeeRelation entity) {
		// TODO Auto-generated method stub
		super.merge(entity);
	}

	@Override
	public void delete(EmployeeRelation entity) {
		// TODO Auto-generated method stub
		super.delete(entity);
	}

	@Override
	public void deleteAll(Collection<EmployeeRelation> entities) {
		// TODO Auto-generated method stub
		super.deleteAll(entities);
	}

	@Override
	public void update(EmployeeRelation entity) {
		// TODO Auto-generated method stub
		super.update(entity);
	}

	@Override
	public void updateAll(Collection<EmployeeRelation> entities) {
		// TODO Auto-generated method stub
		super.updateAll(entities);
	}

	@Override
	public EmployeeRelation save(EmployeeRelation entity) {
		// TODO Auto-generated method stub
		return super.save(entity);
	}

	@SuppressWarnings("hiding")
	@Override
	public <EmployeeRelation> List<EmployeeRelation> findAll(Class<EmployeeRelation> entityClass) {
		// TODO Auto-generated method stub
		return super.findAll(entityClass);
	}

	@Override
	public void saveOrUpdate(EmployeeRelation entity) {
		// TODO Auto-generated method stub
		super.saveOrUpdate(entity);
	}

	@Override
	public SessionFactory getSessionFactory() {
		// TODO Auto-generated method stub
		return super.getSessionFactory();
	}
	
}
