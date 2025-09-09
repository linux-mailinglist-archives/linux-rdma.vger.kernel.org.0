Return-Path: <linux-rdma+bounces-13173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA28B49F9C
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 05:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5478B4E6E3A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 03:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0C624EA90;
	Tue,  9 Sep 2025 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="T/RuqLXR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9E1A9FA8;
	Tue,  9 Sep 2025 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386858; cv=none; b=NhdimknraXvfwes0vlueWpC6Kkka8NhF3inqWek12w4i3bWEPEnGRhoKiIKDHxuQe4lkbXG600yEj6ynH4orqy3bLpCPjChg2jXfKaHxm8W2aRK4n7JXB2DPzlR0M2bgRz+o9kgKWkTtgO4TquoCZ/yeASErkjRnqoLovUzVkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386858; c=relaxed/simple;
	bh=NfFKRrbMY180gKH5/k3BgxsRzM1shYeRTXAI0vZsyZ4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5ys7nSxP4oCva1sXX8eN/vDxYDXe1hc+PFwKawOrmAnH8HppBsqGtzKUWpI/lLpBkHEl/vTootNdEZRE/QGLvwudJX5jQP1nSCvuJRu8YijKfdexJzCSXGjLiMAKufCAB/t5IXU52VENLfv3sfeCQ8iyt9PWQxNVzW7NhuK2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=T/RuqLXR; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757386851; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=WwXArvLBuHr1pJLV0X+3gsDYjBANT2MX4WT8+PUoGkk=;
	b=T/RuqLXR3Vjdo9juLxJwujnhiYLSg5Ir2z8Haz1wbE/UeaqHiV5wVE4c6TOugHQxLRNcJ1TbexRNMDxqCg38ESZoENlw/QCpPTSuoZ859+e5uyEHOTb2ZBO8E0OAlUt5xZmX1Tw5dpBlaYViD66A/9Mehx3DbRvqhyAEtjc/qX8=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wnc5Yhj_1757386850 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 11:00:50 +0800
Date: Tue, 9 Sep 2025 11:00:50 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <aL-YYoYRsFiajiPW@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250908220150.3329433-1-pasic@linux.ibm.com>
 <20250908220150.3329433-2-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908220150.3329433-2-pasic@linux.ibm.com>

On 2025-09-09 00:01:49, Halil Pasic wrote:
>Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
>SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
>get replaced with lgr->pref_send_wr and lgr->max_recv_wr respective.
                            ^                       ^
                            better to use the same prefix

I personally prefer max_send_wr/max_recv_wr.

>
>While at it let us also remove a confusing comment that is either not
>about the context in which it resides (describing
>qp_attr.cap.pref_send_wr and qp_attr.cap.max_recv_wr) or not applicable
                ^
I haven't found pref_send_wr in qp_attr.cap

>any more when these values become configurable.
>
>Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>---
> Documentation/networking/smc-sysctl.rst | 37 +++++++++++++++++++++++++
> include/net/netns/smc.h                 |  2 ++
> net/smc/smc_core.h                      |  6 ++++
> net/smc/smc_ib.c                        |  7 ++---
> net/smc/smc_llc.c                       |  2 ++
> net/smc/smc_sysctl.c                    | 22 +++++++++++++++
> net/smc/smc_sysctl.h                    |  2 ++
> net/smc/smc_wr.c                        | 32 +++++++++++----------
> net/smc/smc_wr.h                        |  2 --
> 9 files changed, 90 insertions(+), 22 deletions(-)
>
>diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
>index a874d007f2db..d533830df28f 100644
>--- a/Documentation/networking/smc-sysctl.rst
>+++ b/Documentation/networking/smc-sysctl.rst
>@@ -71,3 +71,40 @@ smcr_max_conns_per_lgr - INTEGER
> 	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
> 
> 	Default: 255
>+
>+smcr_pref_send_wr - INTEGER
>+	So called work request buffers are SMCR link (and RDMA queue pair) level
>+	resources necessary for performing RDMA operations. Since up to 255
>+	connections can share a link group and thus also a link and the number
>+	of the work request buffers is decided when the link is allocated,
>+	depending on the workload it can a bottleneck in a sense that threads
>+	have to wait for work request buffers to become available. Before the
>+	introduction of this control the maximal number of work request buffers
>+	available on the send path used to be hard coded to 16. With this control
>+	it becomes configurable. The acceptable range is between 2 and 2048.
>+
>+	Please be aware that all the buffers need to be allocated as a physically
>+	continuous array in which each element is a single buffer and has the size
>+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
>+	like before having this control.
>+	this control.

The final 'this control' looks unwanted.


>+
>+	Default: 16
>+
>+smcr_pref_recv_wr - INTEGER
>+	So called work request buffers are SMCR link (and RDMA queue pair) level
>+	resources necessary for performing RDMA operations. Since up to 255
>+	connections can share a link group and thus also a link and the number
>+	of the work request buffers is decided when the link is allocated,
>+	depending on the workload it can a bottleneck in a sense that threads
>+	have to wait for work request buffers to become available. Before the
>+	introduction of this control the maximal number of work request buffers
>+	available on the receive path used to be hard coded to 16. With this control
>+	it becomes configurable. The acceptable range is between 2 and 2048.
>+
>+	Please be aware that all the buffers need to be allocated as a physically
>+	continuous array in which each element is a single buffer and has the size
>+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
>+	like before having this control.
>+
>+	Default: 48
>diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
>index fc752a50f91b..830817fc7fd7 100644
>--- a/include/net/netns/smc.h
>+++ b/include/net/netns/smc.h
>@@ -24,5 +24,7 @@ struct netns_smc {
> 	int				sysctl_rmem;
> 	int				sysctl_max_links_per_lgr;
> 	int				sysctl_max_conns_per_lgr;
>+	unsigned int			sysctl_smcr_pref_send_wr;
>+	unsigned int			sysctl_smcr_pref_recv_wr;
> };
> #endif
>diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>index 48a1b1dcb576..78d5bcefa1b8 100644
>--- a/net/smc/smc_core.h
>+++ b/net/smc/smc_core.h
>@@ -33,6 +33,8 @@
> 					 * distributions may modify it to a value between
> 					 * 16-255 as needed.
> 					 */
>+#define SMCR_MAX_SEND_WR_DEF	16	/* Default number of work requests per send queue */
>+#define SMCR_MAX_RECV_WR_DEF	48	/* Default number of work requests per recv queue */
> 
> struct smc_lgr_list {			/* list of link group definition */
> 	struct list_head	list;
>@@ -361,6 +363,10 @@ struct smc_link_group {
> 						/* max conn can be assigned to lgr */
> 			u8			max_links;
> 						/* max links can be added in lgr */
>+			u16			pref_send_wr;
>+						/* number of WR buffers on send */
>+			u16			pref_recv_wr;
>+						/* number of WR buffers on recv */
> 		};
> 		struct { /* SMC-D */
> 			struct smcd_gid		peer_gid;
>diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>index 0052f02756eb..2f8f214fc634 100644
>--- a/net/smc/smc_ib.c
>+++ b/net/smc/smc_ib.c
>@@ -669,11 +669,6 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
> 		.recv_cq = lnk->smcibdev->roce_cq_recv,
> 		.srq = NULL,
> 		.cap = {
>-				/* include unsolicited rdma_writes as well,
>-				 * there are max. 2 RDMA_WRITE per 1 WR_SEND
>-				 */
>-			.max_send_wr = SMC_WR_BUF_CNT * 3,
>-			.max_recv_wr = SMC_WR_BUF_CNT * 3,
> 			.max_send_sge = SMC_IB_MAX_SEND_SGE,
> 			.max_recv_sge = lnk->wr_rx_sge_cnt,
> 			.max_inline_data = 0,
>@@ -683,6 +678,8 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
> 	};
> 	int rc;
> 
>+	qp_attr.cap.max_send_wr = 3 * lnk->lgr->pref_send_wr;
>+	qp_attr.cap.max_recv_wr = lnk->lgr->pref_recv_wr;
> 	lnk->roce_qp = ib_create_qp(lnk->roce_pd, &qp_attr);
> 	rc = PTR_ERR_OR_ZERO(lnk->roce_qp);
> 	if (IS_ERR(lnk->roce_qp))
>diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
>index f865c58c3aa7..1098bdc3557b 100644
>--- a/net/smc/smc_llc.c
>+++ b/net/smc/smc_llc.c
>@@ -2157,6 +2157,8 @@ void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc)
> 	init_waitqueue_head(&lgr->llc_msg_waiter);
> 	init_rwsem(&lgr->llc_conf_mutex);
> 	lgr->llc_testlink_time = READ_ONCE(net->smc.sysctl_smcr_testlink_time);
>+	lgr->pref_send_wr = (u16)(READ_ONCE(net->smc.sysctl_smcr_pref_send_wr));
>+	lgr->pref_recv_wr = (u16)(READ_ONCE(net->smc.sysctl_smcr_pref_recv_wr));
> }
> 
> /* called after lgr was removed from lgr_list */
>diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
>index 2fab6456f765..f320443e563b 100644
>--- a/net/smc/smc_sysctl.c
>+++ b/net/smc/smc_sysctl.c
>@@ -29,6 +29,8 @@ static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
> static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
> static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
> static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
>+static unsigned int smcr_max_wr_min = 2;
>+static unsigned int smcr_max_wr_max = 2048;
> 
> static struct ctl_table smc_table[] = {
> 	{
>@@ -99,6 +101,24 @@ static struct ctl_table smc_table[] = {
> 		.extra1		= SYSCTL_ZERO,
> 		.extra2		= SYSCTL_ONE,
> 	},
>+	{
>+		.procname	= "smcr_pref_send_wr",
>+		.data		= &init_net.smc.sysctl_smcr_pref_send_wr,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= proc_dointvec_minmax,
>+		.extra1		= &smcr_max_wr_min,
>+		.extra2		= &smcr_max_wr_max,
>+	},
>+	{
>+		.procname	= "smcr_pref_recv_wr",
>+		.data		= &init_net.smc.sysctl_smcr_pref_recv_wr,
>+		.maxlen		= sizeof(int),
>+		.mode		= 0644,
>+		.proc_handler	= proc_dointvec_minmax,
>+		.extra1		= &smcr_max_wr_min,
>+		.extra2		= &smcr_max_wr_max,
>+	},
> };
> 
> int __net_init smc_sysctl_net_init(struct net *net)
>@@ -130,6 +150,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
> 	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
> 	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
> 	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
>+	net->smc.sysctl_smcr_pref_send_wr = SMCR_MAX_SEND_WR_DEF;
>+	net->smc.sysctl_smcr_pref_recv_wr = SMCR_MAX_RECV_WR_DEF;
> 	/* disable handshake limitation by default */
> 	net->smc.limit_smc_hs = 0;
> 
>diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
>index eb2465ae1e15..5d17c6082cc2 100644
>--- a/net/smc/smc_sysctl.h
>+++ b/net/smc/smc_sysctl.h
>@@ -25,6 +25,8 @@ static inline int smc_sysctl_net_init(struct net *net)
> 	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
> 	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
> 	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
>+	net->smc.sysctl_smcr_pref_send_wr = SMCR_MAX_SEND_WR_DEF;
>+	net->smc.sysctl_smcr_pref_recv_wr = SMCR_MAX_RECV_WR_DEF;
> 	return 0;
> }
> 
>diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
>index b04a21b8c511..606fe0bec4ef 100644
>--- a/net/smc/smc_wr.c
>+++ b/net/smc/smc_wr.c
>@@ -34,6 +34,7 @@
> #define SMC_WR_MAX_POLL_CQE 10	/* max. # of compl. queue elements in 1 poll */
> 
> #define SMC_WR_RX_HASH_BITS 4
>+
> static DEFINE_HASHTABLE(smc_wr_rx_hash, SMC_WR_RX_HASH_BITS);
> static DEFINE_SPINLOCK(smc_wr_rx_hash_lock);
> 
>@@ -547,9 +548,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
> 		    IB_QP_DEST_QPN,
> 		    &init_attr);
> 
>-	lnk->wr_tx_cnt = min_t(size_t, SMC_WR_BUF_CNT,
>+	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->pref_send_wr,
> 			       lnk->qp_attr.cap.max_send_wr);
>-	lnk->wr_rx_cnt = min_t(size_t, SMC_WR_BUF_CNT * 3,
>+	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->pref_recv_wr,
> 			       lnk->qp_attr.cap.max_recv_wr);
> }
> 
>@@ -741,50 +742,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
> int smc_wr_alloc_link_mem(struct smc_link *link)
> {
> 	/* allocate link related memory */
>-	link->wr_tx_bufs = kcalloc(SMC_WR_BUF_CNT, SMC_WR_BUF_SIZE, GFP_KERNEL);
>+	link->wr_tx_bufs = kcalloc(link->lgr->pref_send_wr,
>+				   SMC_WR_BUF_SIZE, GFP_KERNEL);
> 	if (!link->wr_tx_bufs)
> 		goto no_mem;
>-	link->wr_rx_bufs = kcalloc(SMC_WR_BUF_CNT * 3, link->wr_rx_buflen,
>+	link->wr_rx_bufs = kcalloc(link->lgr->pref_recv_wr, SMC_WR_BUF_SIZE,
> 				   GFP_KERNEL);

Why change wr_rx_buflen to SMC_WR_BUF_SIZE ? wr_rx_buflen depends on
SMCV1 or SMCV2.

If this is mistake, we need the change the comments in sysctl.rst as
well.

Best regards,
Dust

