create or replace view dev_2019se02_yyb_rpt_v as
select
to_date(a.day_id,'yyyymmdd') the_date,
a.seq,
a.day_id ,
a.new_dw,
a.short_name,
        a.yyb depart_name,
       a.mob  mob1,
      nvl( b.MOB ,0) mob,
      nvl( b.MOBx,0) mobx,
       to_per(b.MOBX, a.mob) mob_per,
       a.kd kd1,
         nvl(   B.KD ,0) kd,
      nvl( B.KDX ,0) kdx,
       to_per(B.KDX, a.kd) kd_per ,
       a.itv itv1,
nvl( B.ITV ,0) itv,
       nvl(B.ITVX ,0) itvx,
       to_per(B.ITVX, a.itv) itv_per,
       a.trans trans1,
        nvl(B.TRANS ,0) trans,
        to_per(b.trans,a.trans) trans_per,
        a.ORANGE ORANGE1,
        nvl(b.orange,0) orange,
                nvl(b.orange,0) orangex,
        to_per(b.orange,a.orange) orange_per,
      a.JF jf1,
       b.fen_v ,
       to_per(b.fen_v,a.jf) jf_per,

     nvl(to_per1_au(b.MOBX, a.mob)*15,0)+
     nvl( to_per1_au(b.trans,a.trans)*15,0)+
      nvl( to_per1_au(B.KDX, a.kd)*15,0)+
       nvl(to_per1_au(B.ITVX, a.itv)*15,0)+
       nvl(to_per1_au(b.fen_v,a.jf) *40,0)  scores

  from ywzx_zzl.DEV_2019SE02_yyb_v a
  left join
  (

select new_date,
      (case when zq_depart_name is not null then zq_depart_name else   depart_name2 end) depart_name2,
       depart_name1,
       sum(decode(type1, 'MOB', IS_COUNT, 0)) MOB,
       sum(decode(type1, 'MOB', IS_COUNTX, 0)) MOBx,
       sum(decode(type1, 'KD', IS_COUNT, 0)) KD,
       sum(decode(type1, 'KD', IS_COUNTX, 0)) KDX,
       sum(decode(type1, 'ITV', IS_COUNT, 0)) ITV,
       sum(decode(type1, 'ITV', IS_COUNTX, 0)) ITVX,
sum(decode(type1, 'TRANS', IS_COUNT, 0)) TRANS,
       sum(decode(type1, 'TRANS', IS_COUNTX, 0)) TRANSX,
sum(decode(type1, 'ORANGE', IS_COUNT, 0)) ORANGE,
       sum(decode(type1, 'ORANGE', IS_COUNTX, 0)) ORANGEX ,
sum(case when type1 in ('MOB','KD','ITV') THEN FEN_V END) FEN_V
  from SP_2019_LIST_V
 GROUP BY new_date,       (case when zq_depart_name is not null then zq_depart_name else   depart_name2 end), depart_name1

 )    b
 ON A.yyb||A.DAY_ID=B.depart_name2||B.NEW_DATE;
