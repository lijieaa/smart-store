package com.jpm.common.service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jpm.common.dao.CrudDao;
import com.jpm.common.entity.DataEntity;
import com.jpm.common.utils.StringUtils;
import io.swagger.models.auth.In;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @description: CrudService基类
 * @author: 李杰
 * @create: 2018-08-02 15:53
 **/
@Transactional(readOnly = true)
public abstract class CrudService<D extends CrudDao<T ,PK>, T extends DataEntity<T,PK>,PK extends Serializable> extends BaseService {
    private static Logger logger = LoggerFactory.getLogger(CrudService.class);
    /**
     * 持久层对象
     */
    @Autowired
    protected D dao;

    /**
     * 获取单条数据
     * @param id
     * @return
     */
    public T find(PK id){
        return dao.select(id);
    };

    /**
     * 获取单条数据
     * @param entity
     * @return
     */
    public T find(T entity){
        return dao.select(entity);
    };


    /**
     * 插入数据
     * @param entity
     * @return
     */
    @Transactional(readOnly = false)
    public int add(T entity){
        return dao.insert(entity);
    };

    /**
     * 更新数据
     * @param entity
     * @return
     */
    @Transactional(readOnly = false)
    public int update(T entity){
        return dao.update(entity);
    };


    /**
     * 批量删除
     * @param ids
     * @return
     */
    @Transactional(readOnly = false)
    public int remove(PK[] ids){
        return dao.delete(ids);
    }

    /**
     * 分页查询
     * @param data
     * @return
     */
    public PageInfo findPage(Integer page,Integer rows,Map data){

        PageHelper.startPage(page, rows);
        List<T> list = dao.selectAll(data);
        PageInfo pageInfo = new PageInfo(list);
        return pageInfo;
    }


    /**
     * JgGrid分页查询
     * @param data
     * @return
     */
    public PageInfo findJgGridPage(Map data){
        //分页
        String page = (String) data.get("page");
        String rows = (String) data.get("rows");
        int pageNum = Integer.parseInt(page);
        int pageSize = Integer.parseInt(rows);
        PageHelper.startPage(pageNum, pageSize);

        //排序
        String sidx = (String) data.get("sidx");
        String sord = (String) data.get("sord");
        if(null!=sidx&&null!=sord&&!sidx.equals("")&&!sord.equals("")){
            sidx+=" "+sord;
            logger.info(sidx);

            String orderByClause = StringUtils.toUnderScoreCase(sidx);
            logger.info(orderByClause);

            data.put("orderByClause",orderByClause);
        }
        List<T> list = dao.selectAll(data);
        PageInfo pageInfo = new PageInfo(list);
        return pageInfo;
    }

    /**
     * 查询所有
     * @param data 实体用于条件筛选
     * @return
     */
    public List<T> findAll(Map data){
        List<T> list = dao.selectAll(data);
        return list;
    }
}
