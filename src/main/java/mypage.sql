select *
from news;

select *
from news_comment;

select *
from stocks;

select *
from stocks_comment;

-- 댓글 아이디, 댓글 내용, 댓글이 속한 게시글 아이디
-- 게시글 아이디, 게시글 제목

select nc.seq as ncseq, nc.user_id as ncuser_id, nc.content, nc.write_date, nc.del as ncdel, n.seq as nseq, n.title
from news_comment nc, news n
where nc.post_num = n.seq
	and nc.user_id= "aaa"
order by nc.write_date desc;
           
select distinct(nc.seq as ncseq), nc.content, nc.write_date, n.seq as nseq, n.title
from news n, news_comment nc
where n.seq in
          ( select post_num
           from news_comment
           where user_id="aaa");
           
	
select nc.seq as ncseq, nc.user_id as ncuser_id, nc.content, nc.write_date, nc.del as ncdel, n.seq as nseq, n.title
from news_comment nc, news n
where nc.post_num = n.seq and nc.user_id="aaa" and nc.del=0
order by nc.write_date desc
limit (2 * 10), 2


update news_comment
set del=0
where del=1

--

select sc.seq as scseq, sc.user_id, sc.content, sc.write_date, sc.del, s.Symbol, s.Market, s.Name
from stocks_comment sc, stocks s
where sc.post_num = s.Symbol
	and sc.user_id= "aaa"
order by sc.write_date desc;

select sc.seq as scseq, sc.user_id, sc.content, sc.write_date, sc.del, s.Symbol, s.Market, s.Name
from stocks_comment sc, stocks s
where sc.post_num = s.Symbol
	and sc.user_id=#{user_id}
order by sc.write_date desc
limit

--

select * from stocks_like where user_id="aaa";

insert into stocks_like(Symbol, user_id) values("227100", "aaa");

select *
from stocks
where Symbol in 
	(select Symbol
	from stocks_like
	where user_id="aaa")
	
select *
from stocks
where Symbol in 
	(select Symbol
	from stocks_like
	where user_id=#{user_id})