declare
  n       number := 11; --号码的总共位数
  n1      number; -- 尾数第几位相同的
  check1  number := 0; --每位依次相减的结果
  nbr     varchar(11) := '18979073222'; --需要判断的号码
  nbr_lev number; --号码的级别
begin
  loop
    dbms_output.put_line('n=' || n);
    check1 := abs(substr(nbr, n, 1) - substr(nbr, n - 1, 1));
    dbms_output.put_line('check1=' || check1);
    n := n - 1;
    exit WHEN check1 > 0;
  end loop;
  dbms_output.put_line('尾数' || to_char(11 - n) || '位相同');
end;




CREATE OR REPLACE FUNCTION mob_lev
/*
需求:判断尾数相同号码的吉祥号
coded by zzl 
*/
(nbr in varchar2)
return varchar2
is
  n       number := 11; --号码的总共位数
  check1  number := 0; --每位依次相减的结果
  nbr_lev varchar2(30); --号码的级别
begin
loop
    check1 := abs(substr(nbr, n, 1) - substr(nbr, n - 1, 1));
    n := n - 1;
    exit WHEN check1 > 0;
  end loop;
 nbr_lev := to_char(11-n)||','||substr(nbr,11,1);
 --返回结果： (尾数相同的位数,相同尾数的号码是多少)
return nbr_lev;
end;


---以下为将临时代码编写成存储过程

CREATE OR REPLACE FUNCTION mob_lev2
/*
需求：判断是否为顺序号码 ，如 18979071234 等
*/
(nbr in varchar2)
return varchar2
is
  n       number := 11; --号码的总共位数
  check1  number := 0; --每位依次相减的结果
  nbr_lev varchar2(30); --号码的级别
begin
loop
    check1 := abs(substr(nbr, n, 1) - substr(nbr, n - 1, 1)+1);
    n := n - 1;
    exit WHEN check1 > 0;
  end loop;
 nbr_lev := to_char(11-n)||','||substr(nbr,11,1);
return nbr_lev;
end;




select code,mob_lev(code),mob_lev2(code),
(case when substr(mob_lev(code),1,1)>=5 and substr(mob_lev(code),3,1) in (0,6,8,9) and code not like'%444444' then 10
    when (substr(mob_lev(code),1,1)=5 and substr(mob_lev(code),3,1) not  in (0,6,8,9))      
      or (substr(mob_lev(code),1,1)=4 and substr(mob_lev(code),3,1)    in (0,6,8,9))   
      or code like '%444444'  then 9
    when substr(mob_lev(code),1,1)=4  and substr(mob_lev(code),3,1)<>4  
         or substr(mob_lev2(code),1,1)=7   --bcdefgh
         or substr(mob_lev2(code),1,1)=3 and substr(code,6,3)=substr(code,9,3)   --xyzxyz
         then 8
       when (substr(mob_lev(code),1,1)=3 and substr(mob_lev(code),3,1) in ('6','8','9','0'))  --*666 *888 *999  *444         
       or    (substr(mob_lev(code),1,1)=4 and substr(mob_lev(code),3,1) in ('4'))  --*666 *888 *999  *444
       or  ( substr(mob_lev(code),1,1)=2 and substr(code,6,2)=substr(code,8,2) and substr(code,8,2)=substr(code,9,2) ) -- xy,xy,xy 
     then 7
       end) 号码级别
from omgcode@zhzy    where
    category='12' --此条件表示手机
   and locationid between '279' and '285'
and substr(mob_lev(code),1,1)=2 and substr(code,6,2)=substr(code,8,2) and substr(code,8,2)=substr(code,9,2) 
 
 and 
(
--
substr(mob_lev(code),1,1)>=3 
--or substr(mob_lev2(code),1,1)>=4
) 

18979 07 30 22

select code  from omgcode@zhzy    where
    category='12' --此条件表示手机
    and code  like  '1897907%'
    and servicestatus not in (20,3)
   and locationid between '279' and '285'



select   mob_lev('18979073022') from dual   

select acc_nbr, mob_lev(acc_nbr)
  from serv_inst
 where product_id = 80000045
   and substr(mob_lev2(acc_nbr), 1, 1) = 3
and substr(acc_nbr,6,3)=substr(acc_nbr,9,3)


18179 013 654
