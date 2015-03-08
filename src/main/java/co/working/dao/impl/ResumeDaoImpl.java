package co.working.dao.impl;

import co.working.model.Resume;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository("resumeDao")
public class ResumeDaoImpl extends ICommonDaoImpl<Resume, Integer> {

    public ResumeDaoImpl() {
        super(Resume.class);
    }

	@SuppressWarnings("hiding")
	@Override
	public <Resume> Resume get(Class<Resume> entityClass, Integer id) {
		// TODO Auto-generated method stub
		return super.get(entityClass, id);
	}

	@SuppressWarnings("hiding")
	@Override
	public <Resume> List<Resume> findByExample(Resume exampleEntity) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity);
	}

	@Override
	public List<Resume> find(String queryString, Object... values) {
		// TODO Auto-generated method stub
		return super.find(queryString, values);
	}

	@SuppressWarnings("hiding")
	@Override
	public <Resume> List<Resume> findByExample(Resume exampleEntity, int firstResult,
			int maxResults) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity, firstResult, maxResults);
	}

	@Override
	public List<Resume> findByNamedParam(String queryString,
			String[] paramNames, Object[] values) {
		// TODO Auto-generated method stub
		return super.findByNamedParam(queryString, paramNames, values);
	}

	@Override
	public List<Resume> findByCriteria(DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria);
	}

	@Override
	public List<Resume> findByCriteria(DetachedCriteria criteria,
			int firstResult, int maxResults) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria, firstResult, maxResults);
	}

	@Override
	public void merge(Resume entity) {
		// TODO Auto-generated method stub
		 super.merge(entity);
	}

	@Override
	public void delete(Resume entity) {
		// TODO Auto-generated method stub
		super.delete(entity);
	}

	@Override
	public void deleteAll(Collection<Resume> entities) {
		// TODO Auto-generated method stub
		super.deleteAll(entities);
	}

	@Override
	public void update(Resume entity) {
		// TODO Auto-generated method stub
		super.update(entity);
	}

	@Override
	public void updateAll(Collection<Resume> entities) {
		// TODO Auto-generated method stub
		super.updateAll(entities);
	}


    @Override
    public Resume save(Resume entity) {
        return super.save(entity);
    }
}
