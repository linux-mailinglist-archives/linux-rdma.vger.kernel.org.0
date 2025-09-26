Return-Path: <linux-rdma+bounces-13666-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1523BA23CE
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 04:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CABD3AB432
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Sep 2025 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48DA262FC0;
	Fri, 26 Sep 2025 02:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Kg88IMRj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36186261B80;
	Fri, 26 Sep 2025 02:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854655; cv=none; b=aYERrE5pvJL9kKRbWSNSm1+Cu8X3zEmy6CIe7teVWcJjssB9T650FENfJfZK5+KVrqrqfucE6y/GNJybNq6iI2OqyUrOiue/MFR/5+vm8IW5ftsBGrhDJys4sZtb/gQcHmJHxMHyuu44Lyxe7Y6h/2acoFp5kdTknmvBELe0GTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854655; c=relaxed/simple;
	bh=/udMnapIHTCpHoAnc7xqh5vUpmIkXgo9vnmB1oioYJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=m7v4Yy6kWTyKL8vhDSM/ujL92IGQetN+C8BI0guevpz7YOE7YOYYayXpQoobF0HtLs6CQSPHa7dlN+NAZ3AJOqKdBR3nnkVBOuxuIWOBAs8NGZCNlUlGMDos910rSthg7HGhetjtDqqftO4sAvmoJEkqo5WNQ6r9ZFdQydoPkWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Kg88IMRj; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758854642; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2CQ+xRfB/5MjspUDiPRIa1Fl8PKQZuSj45XqTftZtcc=;
	b=Kg88IMRj0QRbCn72RqRFT8Ap4HFchKT14MKcL5oIssJk0uxqGoQ7SPfe5tSQxZmztRm09+krjpvK7eD7uC8BMZiNjf48c9VmsX0FzVydgkGYUaL9JnL7glYdd47jdKA66p67qHD+xbtwWpjwXxXl7z36cGKaBwlHjYFbm/75Y60=
Received: from 30.221.116.140(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0Woq-QMi_1758854641 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 10:44:01 +0800
Message-ID: <1aa764d0-0613-499e-bc44-52e70602b661@linux.alibaba.com>
Date: Fri, 26 Sep 2025 10:44:00 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/smc: make wr buffer count
 configurable
To: Halil Pasic <pasic@linux.ibm.com>
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-2-pasic@linux.ibm.com>
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
In-Reply-To: <20250921214440.325325-2-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/9/22 05:44, Halil Pasic 写道:
> Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
> SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
> get replaced with lgr->max_send_wr and lgr->max_recv_wr respective.
> 
> While at it let us also remove a confusing comment that is either not
> about the context in which it resides (describing
> qp_attr.cap.max_send_wr and qp_attr.cap.max_recv_wr) or not applicable
> any more when these values become configurable.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  Documentation/networking/smc-sysctl.rst | 36 +++++++++++++++++++++++++
>  include/net/netns/smc.h                 |  2 ++
>  net/smc/smc_core.h                      |  6 +++++
>  net/smc/smc_ib.c                        |  7 ++---
>  net/smc/smc_llc.c                       |  2 ++
>  net/smc/smc_sysctl.c                    | 22 +++++++++++++++
>  net/smc/smc_sysctl.h                    |  2 ++
>  net/smc/smc_wr.c                        | 32 +++++++++++-----------
>  net/smc/smc_wr.h                        |  2 --
>  9 files changed, 89 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
> index a874d007f2db..c94d750c7c84 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -71,3 +71,39 @@ smcr_max_conns_per_lgr - INTEGER
>  	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
>  
>  	Default: 255
> +
> +smcr_max_send_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the send path used to be hard coded to 16. With this control
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physically
> +	continuous array in which each element is a single buffer and has the size
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 16
> +
> +smcr_max_recv_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can a bottleneck in a sense that threads
> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the receive path used to be hard coded to 16. With this control
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physically
> +	continuous array in which each element is a single buffer and has the size
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 48

Notice that the ratio of smcr_max_recv_wr to smcr_max_send_wr is set to 3:1, with the
intention of ensuring that the peer QP's smcr_max_recv_wr is three times the local QP's
smcr_max_send_wr and the local QP's smcr_max_recv_wr is three times the peer QP's
smcr_max_send_wr, rather than making the local QP's smcr_max_recv_wr three times its own
smcr_max_send_wr. The purpose of this design is to guarantee sufficient receive WRs on
the side to receive incoming data when peer QP doing RDMA sends. Otherwise, RNR (Receiver
Not Ready) may occur, leading to poor performance(RNR will drop the packet and retransmit
happens in the transport layer of the RDMA).

Let us guess a scenario that have multiple hosts, and the multiple hosts have different
smcr_max_send_wr and smcr_max_recv_wr configurations, mesh connections between these hosts.
It is difficult to ensure that the smcr_max_recv_wr/smcr_max_send_wr is 3:1 on the connected
QPs between these hosts, and it may even be hard to guarantee the smcr_max_recv_wr > smcr_max_send_wr
on the connected QPs between these hosts.

Therefore, I believe that if these values are made configurable, additional mechanisms must be
in place to prevent RNR from occurring. Otherwise we need to carefully configure smcr_max_recv_wr
and smcr_max_send_wr, or ensure that all hosts capable of establishing SMC-R connections are configured
smcr_max_recv_wr and smcr_max_send_wr with the same values.

Regards,
Guangguan Wang

> diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
> index fc752a50f91b..6ceb12baec24 100644
> --- a/include/net/netns/smc.h
> +++ b/include/net/netns/smc.h
> @@ -24,5 +24,7 @@ struct netns_smc {
>  	int				sysctl_rmem;
>  	int				sysctl_max_links_per_lgr;
>  	int				sysctl_max_conns_per_lgr;
> +	unsigned int			sysctl_smcr_max_send_wr;
> +	unsigned int			sysctl_smcr_max_recv_wr;
>  };
>  #endif
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 48a1b1dcb576..ab2d15929cb2 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -33,6 +33,8 @@
>  					 * distributions may modify it to a value between
>  					 * 16-255 as needed.
>  					 */
> +#define SMCR_MAX_SEND_WR_DEF	16	/* Default number of work requests per send queue */
> +#define SMCR_MAX_RECV_WR_DEF	48	/* Default number of work requests per recv queue */
>  
>  struct smc_lgr_list {			/* list of link group definition */
>  	struct list_head	list;
> @@ -361,6 +363,10 @@ struct smc_link_group {
>  						/* max conn can be assigned to lgr */
>  			u8			max_links;
>  						/* max links can be added in lgr */
> +			u16			max_send_wr;
> +						/* number of WR buffers on send */
> +			u16			max_recv_wr;
> +						/* number of WR buffers on recv */
>  		};
>  		struct { /* SMC-D */
>  			struct smcd_gid		peer_gid;
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 0052f02756eb..e8d35c22c525 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -669,11 +669,6 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
>  		.recv_cq = lnk->smcibdev->roce_cq_recv,
>  		.srq = NULL,
>  		.cap = {
> -				/* include unsolicited rdma_writes as well,
> -				 * there are max. 2 RDMA_WRITE per 1 WR_SEND
> -				 */
> -			.max_send_wr = SMC_WR_BUF_CNT * 3,
> -			.max_recv_wr = SMC_WR_BUF_CNT * 3,
>  			.max_send_sge = SMC_IB_MAX_SEND_SGE,
>  			.max_recv_sge = lnk->wr_rx_sge_cnt,
>  			.max_inline_data = 0,
> @@ -683,6 +678,8 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
>  	};
>  	int rc;
>  
> +	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
> +	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;
>  	lnk->roce_qp = ib_create_qp(lnk->roce_pd, &qp_attr);
>  	rc = PTR_ERR_OR_ZERO(lnk->roce_qp);
>  	if (IS_ERR(lnk->roce_qp))
> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index f865c58c3aa7..f5d5eb617526 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -2157,6 +2157,8 @@ void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc)
>  	init_waitqueue_head(&lgr->llc_msg_waiter);
>  	init_rwsem(&lgr->llc_conf_mutex);
>  	lgr->llc_testlink_time = READ_ONCE(net->smc.sysctl_smcr_testlink_time);
> +	lgr->max_send_wr = (u16)(READ_ONCE(net->smc.sysctl_smcr_max_send_wr));
> +	lgr->max_recv_wr = (u16)(READ_ONCE(net->smc.sysctl_smcr_max_recv_wr));
>  }
>  
>  /* called after lgr was removed from lgr_list */
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index 2fab6456f765..7b2471904d04 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -29,6 +29,8 @@ static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
>  static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
>  static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
>  static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
> +static unsigned int smcr_max_wr_min = 2;
> +static unsigned int smcr_max_wr_max = 2048;
>  
>  static struct ctl_table smc_table[] = {
>  	{
> @@ -99,6 +101,24 @@ static struct ctl_table smc_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> +	{
> +		.procname	= "smcr_max_send_wr",
> +		.data		= &init_net.smc.sysctl_smcr_max_send_wr,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &smcr_max_wr_min,
> +		.extra2		= &smcr_max_wr_max,
> +	},
> +	{
> +		.procname	= "smcr_max_recv_wr",
> +		.data		= &init_net.smc.sysctl_smcr_max_recv_wr,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= &smcr_max_wr_min,
> +		.extra2		= &smcr_max_wr_max,
> +	},
>  };
>  
>  int __net_init smc_sysctl_net_init(struct net *net)
> @@ -130,6 +150,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
>  	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>  	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>  	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
> +	net->smc.sysctl_smcr_max_send_wr = SMCR_MAX_SEND_WR_DEF;
> +	net->smc.sysctl_smcr_max_recv_wr = SMCR_MAX_RECV_WR_DEF;
>  	/* disable handshake limitation by default */
>  	net->smc.limit_smc_hs = 0;
>  
> diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
> index eb2465ae1e15..8538915af7af 100644
> --- a/net/smc/smc_sysctl.h
> +++ b/net/smc/smc_sysctl.h
> @@ -25,6 +25,8 @@ static inline int smc_sysctl_net_init(struct net *net)
>  	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>  	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>  	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
> +	net->smc.sysctl_smcr_max_send_wr = SMCR_MAX_SEND_WR_DEF;
> +	net->smc.sysctl_smcr_max_recv_wr = SMCR_MAX_RECV_WR_DEF;
>  	return 0;
>  }
>  
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index b04a21b8c511..f5b2772414fd 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -34,6 +34,7 @@
>  #define SMC_WR_MAX_POLL_CQE 10	/* max. # of compl. queue elements in 1 poll */
>  
>  #define SMC_WR_RX_HASH_BITS 4
> +
>  static DEFINE_HASHTABLE(smc_wr_rx_hash, SMC_WR_RX_HASH_BITS);
>  static DEFINE_SPINLOCK(smc_wr_rx_hash_lock);
>  
> @@ -547,9 +548,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
>  		    IB_QP_DEST_QPN,
>  		    &init_attr);
>  
> -	lnk->wr_tx_cnt = min_t(size_t, SMC_WR_BUF_CNT,
> +	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->max_send_wr,
>  			       lnk->qp_attr.cap.max_send_wr);
> -	lnk->wr_rx_cnt = min_t(size_t, SMC_WR_BUF_CNT * 3,
> +	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->max_recv_wr,
>  			       lnk->qp_attr.cap.max_recv_wr);
>  }
>  
> @@ -741,50 +742,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
>  int smc_wr_alloc_link_mem(struct smc_link *link)
>  {
>  	/* allocate link related memory */
> -	link->wr_tx_bufs = kcalloc(SMC_WR_BUF_CNT, SMC_WR_BUF_SIZE, GFP_KERNEL);
> +	link->wr_tx_bufs = kcalloc(link->lgr->max_send_wr,
> +				   SMC_WR_BUF_SIZE, GFP_KERNEL);
>  	if (!link->wr_tx_bufs)
>  		goto no_mem;
> -	link->wr_rx_bufs = kcalloc(SMC_WR_BUF_CNT * 3, link->wr_rx_buflen,
> +	link->wr_rx_bufs = kcalloc(link->lgr->max_recv_wr, link->wr_rx_buflen,
>  				   GFP_KERNEL);
>  	if (!link->wr_rx_bufs)
>  		goto no_mem_wr_tx_bufs;
> -	link->wr_tx_ibs = kcalloc(SMC_WR_BUF_CNT, sizeof(link->wr_tx_ibs[0]),
> -				  GFP_KERNEL);
> +	link->wr_tx_ibs = kcalloc(link->lgr->max_send_wr,
> +				  sizeof(link->wr_tx_ibs[0]), GFP_KERNEL);
>  	if (!link->wr_tx_ibs)
>  		goto no_mem_wr_rx_bufs;
> -	link->wr_rx_ibs = kcalloc(SMC_WR_BUF_CNT * 3,
> +	link->wr_rx_ibs = kcalloc(link->lgr->max_recv_wr,
>  				  sizeof(link->wr_rx_ibs[0]),
>  				  GFP_KERNEL);
>  	if (!link->wr_rx_ibs)
>  		goto no_mem_wr_tx_ibs;
> -	link->wr_tx_rdmas = kcalloc(SMC_WR_BUF_CNT,
> +	link->wr_tx_rdmas = kcalloc(link->lgr->max_send_wr,
>  				    sizeof(link->wr_tx_rdmas[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_rdmas)
>  		goto no_mem_wr_rx_ibs;
> -	link->wr_tx_rdma_sges = kcalloc(SMC_WR_BUF_CNT,
> +	link->wr_tx_rdma_sges = kcalloc(link->lgr->max_send_wr,
>  					sizeof(link->wr_tx_rdma_sges[0]),
>  					GFP_KERNEL);
>  	if (!link->wr_tx_rdma_sges)
>  		goto no_mem_wr_tx_rdmas;
> -	link->wr_tx_sges = kcalloc(SMC_WR_BUF_CNT, sizeof(link->wr_tx_sges[0]),
> +	link->wr_tx_sges = kcalloc(link->lgr->max_send_wr, sizeof(link->wr_tx_sges[0]),
>  				   GFP_KERNEL);
>  	if (!link->wr_tx_sges)
>  		goto no_mem_wr_tx_rdma_sges;
> -	link->wr_rx_sges = kcalloc(SMC_WR_BUF_CNT * 3,
> +	link->wr_rx_sges = kcalloc(link->lgr->max_recv_wr,
>  				   sizeof(link->wr_rx_sges[0]) * link->wr_rx_sge_cnt,
>  				   GFP_KERNEL);
>  	if (!link->wr_rx_sges)
>  		goto no_mem_wr_tx_sges;
> -	link->wr_tx_mask = bitmap_zalloc(SMC_WR_BUF_CNT, GFP_KERNEL);
> +	link->wr_tx_mask = bitmap_zalloc(link->lgr->max_send_wr, GFP_KERNEL);
>  	if (!link->wr_tx_mask)
>  		goto no_mem_wr_rx_sges;
> -	link->wr_tx_pends = kcalloc(SMC_WR_BUF_CNT,
> +	link->wr_tx_pends = kcalloc(link->lgr->max_send_wr,
>  				    sizeof(link->wr_tx_pends[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_pends)
>  		goto no_mem_wr_tx_mask;
> -	link->wr_tx_compl = kcalloc(SMC_WR_BUF_CNT,
> +	link->wr_tx_compl = kcalloc(link->lgr->max_send_wr,
>  				    sizeof(link->wr_tx_compl[0]),
>  				    GFP_KERNEL);
>  	if (!link->wr_tx_compl)
> @@ -905,7 +907,7 @@ int smc_wr_create_link(struct smc_link *lnk)
>  		goto dma_unmap;
>  	}
>  	smc_wr_init_sge(lnk);
> -	bitmap_zero(lnk->wr_tx_mask, SMC_WR_BUF_CNT);
> +	bitmap_zero(lnk->wr_tx_mask, lnk->lgr->max_send_wr);
>  	init_waitqueue_head(&lnk->wr_tx_wait);
>  	rc = percpu_ref_init(&lnk->wr_tx_refs, smcr_wr_tx_refs_free, 0, GFP_KERNEL);
>  	if (rc)
> diff --git a/net/smc/smc_wr.h b/net/smc/smc_wr.h
> index f3008dda222a..aa4533af9122 100644
> --- a/net/smc/smc_wr.h
> +++ b/net/smc/smc_wr.h
> @@ -19,8 +19,6 @@
>  #include "smc.h"
>  #include "smc_core.h"
>  
> -#define SMC_WR_BUF_CNT 16	/* # of ctrl buffers per link */
> -
>  #define SMC_WR_TX_WAIT_FREE_SLOT_TIME	(10 * HZ)
>  
>  #define SMC_WR_TX_SIZE 44 /* actual size of wr_send data (<=SMC_WR_BUF_SIZE) */


