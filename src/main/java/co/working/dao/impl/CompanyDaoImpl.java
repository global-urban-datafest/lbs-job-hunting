package co.working.dao.impl;

import co.working.model.Company;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository("companyDao")
public class CompanyDaoImpl extends ICommonDaoImpl<Company, Integer> {

    public CompanyDaoImpl() {
        super(Company.class);
    }

	@SuppressWarnings("hiding")
	@Override
	public <Company> Company get(Class<Company> entityClass, Integer id) {
		// TODO Auto-generated method stub
		return super.get(entityClass, id);
	}

	@SuppressWarnings("hiding")
	@Override
	public <Company> List<Company> findByExample(Company exampleEntity) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity);
	}

	@Override
	public List<Company> find(String queryString, Object... values) {
		// TODO Auto-generated method stub
		return super.find(queryString, values);
	}

	@SuppressWarnings("hiding")
	@Override
	public <Company> List<Company> findByExample(Company exampleEntity, int firstResult,
			int maxResults) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity, firstResult, maxResults);
	}

	@Override
	public List<Company> findByNamedParam(String queryString,
			String[] paramNames, Object[] values) {
		// TODO Auto-generated method stub
		return super.findByNamedParam(queryString, paramNames, values);
	}

	@Override
	public List<Company> findByCriteria(DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria);
	}

	@Override
	public List<Company> findByCriteria(DetachedCriteria criteria,
			int firstResult, int maxResults) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria, firstResult, maxResults);
	}


	@Override
	public void delete(Company entity) {
		// TODO Auto-generated method stub
		super.delete(entity);
	}

	@Override
	public void deleteAll(Collection<Company> entities) {
		// TODO Auto-generated method stub
		super.deleteAll(entities);
	}

	@Override
	public void update(Company entity) {
		// TODO Auto-generated method stub
		super.update(entity);
	}

	@Override
	public void updateAll(Collection<Company> entities) {
		// TODO Auto-generated method stub
		super.updateAll(entities);
	}

	@Override
	public void merge(Company entity) {
		// TODO Auto-generated method stub
		super.merge(entity);
	}

	@Override
	public Company save(Company entity) {
		// TODO Auto-generated method stub
		return super.save(entity);
	}

	@SuppressWarnings("hiding")
	@Override
	public <Company> List<Company> findAll(Class<Company> entityClass) {
		// TODO Auto-generated method stub
		return super.findAll(entityClass);
	}

	@Override
	public void saveOrUpdate(Company entity) {
		// TODO Auto-generated method stub
		super.saveOrUpdate(entity);
	}
	
	
    
}
