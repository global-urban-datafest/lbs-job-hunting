package co.working.dao.impl;

import co.working.model.ResumeDetail;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository("resumeDetailDao")
public class ResumeDetailDaoImpl extends ICommonDaoImpl<ResumeDetail, Integer> {

    public ResumeDetailDaoImpl() {
        super(ResumeDetail.class);
    }

	@Override
	public SessionFactory getSessionFactory() {
		// TODO Auto-generated method stub
		return super.getSessionFactory();
	}

	@Override
	public Class<ResumeDetail> getPersistentClass() {
		// TODO Auto-generated method stub
		return super.getPersistentClass();
	}
	@SuppressWarnings("hiding")
	@Override
	public <ResumeDetail> ResumeDetail get(Class<ResumeDetail> entityClass, Integer id) {
		// TODO Auto-generated method stub
		return super.get(entityClass, id);
	}
	@SuppressWarnings("hiding")
	@Override
	public <ResumeDetail> List<ResumeDetail> findByExample(ResumeDetail exampleEntity) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity);
	}

	@Override
	public List<ResumeDetail> find(String queryString, Object... values) {
		// TODO Auto-generated method stub
		return super.find(queryString, values);
	}
	@SuppressWarnings("hiding")
	@Override
	public <ResumeDetail> List<ResumeDetail> findByExample(ResumeDetail exampleEntity, int firstResult,
			int maxResults) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity, firstResult, maxResults);
	}

	@Override
	public List<ResumeDetail> findByNamedParam(String queryString,
			String[] paramNames, Object[] values) {
		// TODO Auto-generated method stub
		return super.findByNamedParam(queryString, paramNames, values);
	}

	@Override
	public List<ResumeDetail> findByCriteria(DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria);
	}

	@Override
	public List<ResumeDetail> findByCriteria(DetachedCriteria criteria,
			int firstResult, int maxResults) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria, firstResult, maxResults);
	}

	@Override
	public void merge(ResumeDetail entity) {
		// TODO Auto-generated method stub
		 super.merge(entity);
	}

	@Override
	public void delete(ResumeDetail entity) {
		// TODO Auto-generated method stub
		super.delete(entity);
	}

	@Override
	public void deleteAll(Collection<ResumeDetail> entities) {
		// TODO Auto-generated method stub
		super.deleteAll(entities);
	}

	@Override
	public void update(ResumeDetail entity) {
		// TODO Auto-generated method stub
		super.update(entity);
	}

	@Override
	public void updateAll(Collection<ResumeDetail> entities) {
		// TODO Auto-generated method stub
		super.updateAll(entities);
	}

	@SuppressWarnings("hiding")
	@Override
	public <ResumeDetail> List<ResumeDetail> findAll(Class<ResumeDetail> entityClass) {
		// TODO Auto-generated method stub
		return super.findAll(entityClass);
	}
    @Override
    public ResumeDetail save(ResumeDetail resumeDetailesume) {
        return super.save(resumeDetailesume);
    }
}
