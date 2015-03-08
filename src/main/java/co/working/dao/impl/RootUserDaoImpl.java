package co.working.dao.impl;

import co.working.model.RootUser;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository("rootUserDao")
public class RootUserDaoImpl extends ICommonDaoImpl<RootUser, Integer> {
		public RootUserDaoImpl(){
			super(RootUser.class);
		}

		@SuppressWarnings("hiding")
		@Override
		public <RootUser> RootUser get(Class<RootUser> entityClass, Integer id) {
			// TODO Auto-generated method stub
			return super.get(entityClass, id);
		}

		@SuppressWarnings("hiding")
		@Override
		public <RootUser> List<RootUser> findByExample(RootUser exampleEntity) {
			// TODO Auto-generated method stub
			return super.findByExample(exampleEntity);
		}

		@Override
		public List<RootUser> find(String queryString, Object... values) {
			// TODO Auto-generated method stub
			return super.find(queryString, values);
		}

		@SuppressWarnings("hiding")
		@Override
		public <RootUser> List<RootUser> findByExample(RootUser exampleEntity, int firstResult,
				int maxResults) {
			// TODO Auto-generated method stub
			return super.findByExample(exampleEntity, firstResult, maxResults);
		}

		@Override
		public List<RootUser> findByNamedParam(String queryString,
				String[] paramNames, Object[] values) {
			// TODO Auto-generated method stub
			return super.findByNamedParam(queryString, paramNames, values);
		}

		@Override
		public List<RootUser> findByCriteria(DetachedCriteria criteria) {
			// TODO Auto-generated method stub
			return super.findByCriteria(criteria);
		}

		@Override
		public List<RootUser> findByCriteria(DetachedCriteria criteria,
				int firstResult, int maxResults) {
			// TODO Auto-generated method stub
			return super.findByCriteria(criteria, firstResult, maxResults);
		}

		@Override
		public void merge(RootUser entity) {
			// TODO Auto-generated method stub
			super.merge(entity);
		}

		@Override
		public void delete(RootUser entity) {
			// TODO Auto-generated method stub
			super.delete(entity);
		}

		@Override
		public void deleteAll(Collection<RootUser> entities) {
			// TODO Auto-generated method stub
			super.deleteAll(entities);
		}

		@Override
		public void update(RootUser entity) {
			// TODO Auto-generated method stub
			super.update(entity);
		}

		@Override
		public void updateAll(Collection<RootUser> entities) {
			// TODO Auto-generated method stub
			super.updateAll(entities);
		}

		@Override
		public RootUser save(RootUser entity) {
			// TODO Auto-generated method stub
			return super.save(entity);
		}

		@SuppressWarnings("hiding")
		@Override
		public <RootUser> List<RootUser> findAll(Class<RootUser> entityClass) {
			// TODO Auto-generated method stub
			return super.findAll(entityClass);
		}

		@Override
		public void saveOrUpdate(RootUser entity) {
			// TODO Auto-generated method stub
			super.saveOrUpdate(entity);
		}
		
}
