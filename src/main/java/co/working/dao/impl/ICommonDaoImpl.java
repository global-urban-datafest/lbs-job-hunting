package co.working.dao.impl;

import co.working.dao.ICommonDao;
import org.apache.log4j.Logger;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.orm.hibernate4.HibernateTemplate;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

//T 实体类    PK表示主键
public class ICommonDaoImpl<T, PK extends Serializable> implements ICommonDao<T, PK> {
	private Logger log = Logger.getLogger(ICommonDaoImpl.class);
    //所要操作的实体类
    private Class<T> persistentClass;
    //hibernateTemplcate工具类
    private HibernateTemplate hibernateTemplate;
    //sessionFactory
    private SessionFactory sessionFactory;

    public SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    @Required
    @Autowired
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
        this.hibernateTemplate = new HibernateTemplate(sessionFactory);
    }

    public HibernateTemplate getHibernateTemplate() {
        return hibernateTemplate;
    }

    public void setHibernateTemplate(HibernateTemplate hibernateTemplate) {
        this.hibernateTemplate = hibernateTemplate;
    }

    public Class<T> getPersistentClass() {
        return persistentClass;
    }

    public void setPersistentClass(Class<T> persistentClass) {
        this.persistentClass = persistentClass;
    }

    //提供参数为  实体类 的构造方法
    public ICommonDaoImpl(final Class<T> persistentClass) {
        this.persistentClass = persistentClass;
    }

    //提供参数为  实体类，sessionfactory 的构造方法
    public ICommonDaoImpl(final Class<T> persistentClass, SessionFactory sessionFactory) {
        this.persistentClass = persistentClass;
        this.sessionFactory = sessionFactory;
        this.sessionFactory = sessionFactory;
    }

    @SuppressWarnings("hiding")
	@Override
    public <T> T get(Class<T> entityClass, PK id) {
    	log.info("get data by id ,the id is"+id);
        return this.getHibernateTemplate().get(entityClass, id);
    }
    @SuppressWarnings("hiding")
    @Override
    public <T> List<T> findByExample(T exampleEntity) {
       	log.info("find  datas by example class ,the classEntity is"+exampleEntity.toString());
        return this.getHibernateTemplate().findByExample(exampleEntity);
    }

    @SuppressWarnings("unchecked")
	@Override
    public List<T> find(String queryString, Object... values) {
        return (List<T>)this.getHibernateTemplate().find(queryString, values);
    }

    @SuppressWarnings("hiding")
	@Override
    public <T> List<T> findByExample(T exampleEntity, int firstResult, int maxResults) {
        return this.getHibernateTemplate().findByExample(exampleEntity,firstResult,maxResults);
    }

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByNamedParam(String queryString, String[] paramNames,
			Object[] values) {
		// TODO Auto-generated method stub
		return (List<T>)this.getHibernateTemplate().findByNamedParam(queryString, paramNames, values);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByCriteria(DetachedCriteria criteria) {
		// TODO Auto-generated method stub
		return (List<T>)this.getHibernateTemplate().findByCriteria(criteria);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByCriteria(DetachedCriteria criteria, int firstResult,
			int maxResults) {
		// TODO Auto-generated method stub
		return (List<T>)this.getHibernateTemplate().findByCriteria(criteria, firstResult, maxResults);
	}

	@Override
	public void merge(T entity) {
		// TODO Auto-generated method stub
		 this.getHibernateTemplate().merge(entity);
	}

	@Override
	public void delete(T entity) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().delete(entity);
	}

	@Override
	public void deleteAll(Collection<T> entities) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().deleteAll(entities);
	}

	@Override
	public void update(T entity) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().update(entity);
	}

	@Override
	public void updateAll(Collection<T> entities) {
		if(entities!=null&&entities.size()>0){
			for(T entity:entities){
				update(entity);
			}
		}
	}

    @Override
    public T save(T entity) {
         this.getHibernateTemplate().save(entity);
         return entity;
    }

    @Override
	public <T> List<T> findAll(Class<T> entityClass) {
		// TODO Auto-generated method stub
		return this.getHibernateTemplate().loadAll(entityClass);
	}

	@Override
	public void saveOrUpdate(T entity) {
		this.getHibernateTemplate().saveOrUpdate(entity);;
	}
	
}
