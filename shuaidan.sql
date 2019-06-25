 

select a.offer_name 套餐,
       u.prod_offer_name 智能组网礼包,
       to_char(u.create_date, 'yyyymmdd') 智能组网礼包时间,
       c.cust_name 用户名,
       c.acc_nbr 号码,
       c.user_acc 宽带账号,
       c.mobile_phone 联系电话,
       c.address_detail 地址,
       
       to_char(c.finish_time, 'yyyymmdd') 新装时间,
       c.product_name 产品类型,
       t.party_name 促销人,
       t.org_name 促销人营业厅,
       t.promo_dw 促销人营业部,
       t.oper_dw 
  from DM_790.R_FB_ZWTC_D_LIST@SJJS a

  left join ywzx_zzl.serv_inst c
    on a.serv_id = c.serv_id
  left join (SELECT c.order_item_id,
  a.spare_fld0,
                    a.prod_inst_id,
                    a.acc_nbr,
                    e.party_name,
                    decode(t2.org_code,'3605101010042',t3.org_code,t2.org_code) org_code ,
                    decode(t2.org_name,'城东营业厅稽核虚拟经营团队',t3.ayx_org_name,t2.org_name) org_name,
                 --   (case when i.ayx_org_name is not null then i.ayx_org_name else g.org_name end ) org_name ,
                   h.dw promo_dw,
                   t4.dw oper_dw 
               FROM CRMDB.ACCESS_PROD_INST@tocrmdg A
               JOIN CRMDB.OFFER_PROD_INST_REL@tocrmdg B
                 ON A.COMP_INST_ID = B.MCOMP_INST_ID
               JOIN CRMDB.l_PROD_OFFER_INST@tocrmdg C
                 ON B.PROD_OFFER_INST_ID = C.PROD_OFFER_INST_ID
               JOIN CRMDB.PROD_OFFER@tocrmdg D
                 ON C.PROD_OFFER_ID = D.PROD_OFFER_ID
               join (select * from  crmdb.l_order_party@tocrmdg
               where relation_type_id in (699913,
                                           703111,
                                           706707,
                                           707007,
                                           707807,
                                           700614,
                                           700708,
                                           700907,
                                           701907))       e
                 on c.order_item_id = e.order_id
               left join crmdb.party@tocrmdg f
                 on e.party_id = f.party_id
               left join crmdb.organization@tocrmdg g
                 on f.org_id = g.party_id
               left join ywzx_zzl.dw_org_v h
                 on g.org_code = h.org_code
                 left join crmdb.l_order_item@tocrmdg t1
                 on c.order_item_id=t1.order_item_Id 
                 left join crmdb.organization@tocrmdg t2
                 on t1.sys_depart_id=t2.party_id
                 left join ywzx_zzl.crm_ayx_order_t t3
                 on c.order_item_id=t3.order_item_id 
left join ywzx_zzl.dw_org_v t4
on  decode(t2.org_code,'3605101010042',t3.org_code,t2.org_code)=t4.org_code
left join ywzx_zzl.yyb_org_v t5
on  decode(t2.org_code,'3605101010042',t3.org_code,t2.org_code)=t5.org_code
              WHERE  
              a.acc_nbr='10433833897'
and c.prod_offer_id = 30043561
                and c.state_cd = '001'
                and e.relation_type_cd = '002'
                     and A.LAN_ID = 3
                AND B.LAN_ID = 3
                AND C.LAN_ID = 3) t
    on a.serv_id = t.spare_fld0
  left join (select *
               from ywzx_zzl.prod_offer_view1
              where prod_offer_id in
                    (30044884, 30044886, 30046675, 30044887)) u
    on a.serv_id = u.prod_inst_id
 where to_char(a.finish_time, 'yyyymmdd') between '20180501' and '20180516'
   and a.offer_id in (30044884, 30044886)
   and a.offer_name <> '天翼智能组网'
   and a.day_id = '20180516'
