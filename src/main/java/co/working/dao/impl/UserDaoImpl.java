package co.working.dao.impl;

import co.working.model.User;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository("userDao")
public class UserDaoImpl extends ICommonDaoImpl<User, Integer> {

    public UserDaoImpl() {
        super(User.class);
    }

    @SuppressWarnings("hiding")
	@Override
    public <User> User get(Class<User> entityClass, Integer id) {
        return super.get(entityClass, id);
    }

    @Override
    public void merge(User entity) {
         super.merge(entity);
    }

    @SuppressWarnings("hiding")
	@Override
    public <User> List<User> findByExample(User user) {
        return super.findByExample(user);
    }

	@Override
	public void update(User user) {
		super.update(user);
	}

	@Override
	public List<User> find(String queryString,
			Object... values) {
		// TODO Auto-generated method stub
		return super.find(queryString, values);
	}

	@SuppressWarnings("hiding")
	@Override
	public <User> List<User> findByExample(User exampleEntity, int firstResult,
			int maxResults) {
		// TODO Auto-generated method stub
		return super.findByExample(exampleEntity, firstResult, maxResults);
	}

	@Override
	public List<User> findByNamedParam(String queryString,
			String[] paramNames, Object[] values) {
		// TODO Auto-generated method stub
		return super.findByNamedParam(queryString, paramNames, values);
	}

	@Override
	public List<User> findByCriteria(
			DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria);
	}

	@Override
	public List<User> findByCriteria(
			DetachedCriteria criteria, int firstResult, int maxResults) {
		// TODO Auto-generated method stub
		return super.findByCriteria(criteria, firstResult, maxResults);
	}

	@Override
	public void delete(User entity) {
		// TODO Auto-generated method stub
		super.delete(entity);
	}

	@Override
	public void deleteAll(Collection<User> entities) {
		// TODO Auto-generated method stub
		super.deleteAll(entities);
	}

	@Override
	public void updateAll(Collection<User> entities) {
		// TODO Auto-generated method stub
		super.updateAll(entities);
	}
	
}
