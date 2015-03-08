package co.working.dao;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

public interface ICommonDao<T, PK extends Serializable> {

    public <T> T get(final Class<T> entityClass, PK id);

    public <T> List<T> findByExample(final T exampleEntity);

    public <T> List<T> findAll(final Class<T> entityClass);

    public List<T> find(final String queryString, final Object... values);

    public <T> List<T> findByExample(final T exampleEntity, int firstResult, int maxResults);

    public List<T> findByNamedParam(final String queryString, final String[] paramNames, final Object[] values);

    public List<T> findByCriteria(final DetachedCriteria criteria);

    public List<T> findByCriteria(final DetachedCriteria criteria, final int firstResult, final int maxResults);


    public void merge(final T entity);

    public void delete(final T entity);

    public void deleteAll(final Collection<T> entities);

    public void update(final T entity);

    public void updateAll(final Collection<T> entities);

    public T save(final T entity);

    public void saveOrUpdate(final T entity);

    public SessionFactory getSessionFactory();
}
