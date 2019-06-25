
select 
a.MK_GRID_ID    网格  ,
a.STATE    状态  ,
a.STATE_DATE    设备状态修改时间  ,
a.SERV_STATE    设备状态  ,
a.OLD_FLAG    计费用户标识信息  ,
to_char(a.NEW_DATE,'yyyymmdd')     新装时间  ,
a.SERV_ID    用户ID  ,
a.ACC_NBR    号码  ,
a.ACCT_ID    账户ID  ,
a.MAIN_SERV_FLAG    产品  ,
a.IS_RHTC    是否融合  ,
a.ACCT_IS_KD    账户下是否有宽带  ,
a.OFFER_MAIN_ID    主套餐  ,
a.RHTC_OFFER_ID    融合套餐ID  ,
a.RHTC_OFFER_NAME    融合套餐名称  ,
a.RHTC_OFFFER_GRADE    融合套餐档次  ,
a.RHTC_FINISH_TIME    融合套餐竣工时间  ,
a.RHTC_COMP_INST_ID    融合套餐ID  ,
a.BXL_OFFER_TYPE    不限量类型  ,
a.ACCT_YD    账户下移动数  ,
a.ACCT_KD    账户下宽带数  ,
a.ACCT_GH    账户下固话数  ,
a.ACCT_ITV    账户下ITV数  ,
a.ACCT_QT    账户下其他数  ,
a.IS_FK    是否副卡  ,
a.DISCOUNT_OFFER_TYPE    打折套餐类型  ,
a.DISCOUNT_OFFER_GRADE    打折套餐档次  ,
a.IS_D3Z    是否打3折  ,
a.COMP_INST_ID    融合套餐共用套子  ,
a.IS_NO_KD    是否没有宽带  ,
IS_DZR    是否单转融  ,
b.cust_name 用户名,
b.yyb 营业部,
b.new_dw 经营单元
from dm_790.R_KSB_KDJZ_D_LIST@sjjs  a
left join serv_inst b 
on a.serv_id=b.serv_id 
where day_id='20190621' --省里的数据日期，一般来说，当天可以查昨天的数据
and to_char(new_date,'yyyymmdd')<'20190619' --这里输入你要查哪个日期之前的
