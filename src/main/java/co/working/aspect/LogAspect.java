package co.working.aspect;

import org.apache.struts2.ServletActionContext;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;

public class LogAspect {

    public void beforeDo() {

        System.out.println("IP:" + ServletActionContext.getRequest().getLocalAddr());
    }

    public void afterDo(JoinPoint joinPoint) {

        System.out.println(joinPoint.getSignature().getName());
    }

    public void finallyDo() {

    }

    public void throwDo() {
    }

    public Object aroundDo(ProceedingJoinPoint joinPoint) throws Throwable {

        Object result = joinPoint.proceed();

        return result;

    }

}
