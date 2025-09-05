Return-Path: <linux-rdma+bounces-13107-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3E9B44C75
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 05:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 940BF7AA937
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 03:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0BD239594;
	Fri,  5 Sep 2025 03:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BtP78sm/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA225CA5A;
	Fri,  5 Sep 2025 03:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757043943; cv=none; b=m2d66Vu5ApYSTD3Q2D/3F5bPVQU6nKdaHdT4oILaxq5zG3sgY1n2RXgFf8aAbDsCN49U5uGynd8Cvjg0HHj5JnHcQTt5RYeWDdz4TlAVSo6j5d9jCebOUYCDuv6yz5rzFicTqnpNr2oTDzVk06/NsclcLVxA2l1zMIp4FaTVpX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757043943; c=relaxed/simple;
	bh=ODcJLz2yv8LUx5SB/Se6fulN0/HliBGOLlqT4v+rlYg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwKLg7BbqseHsY84koTNUrxZpLVrNb4OmqDS+erfEASUXKp3CdWB/dZhBrWfJzzX6/lQ+/YFBPJouffZR6+SCU+YoCrzYI9SinFmYfXB1f1juJfUDH4eq2jcwDucoEjM30/XPAlg+aHh9HPzXA4YMF1cQ3qvGNS8F6Re0WgBVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BtP78sm/; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757043937; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=sUZboZ9UiPIP5KDhPN/lk7f2r5hzY8YgBdcI7qMPvJE=;
	b=BtP78sm/Jrf5YHEwlz6HCxpVGSVoFPo1KMq/KNuIQz4SMbOtrCUX9a+qeFB4GAfCK5fLpfkBKwEM89S1k1EKB3HR1EA+fDOWzPn0kgsUX4EtIiu0j5D1SO2grd2UjuUNHXhEtP5hvIjgJJWIT59rcvfi6E+oV/hC0/7l0iJd4qw=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WnJ07mG_1757043936 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 05 Sep 2025 11:45:36 +0800
Date: Fri, 5 Sep 2025 11:45:36 +0800
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
Subject: Re: [PATCH net-next 1/2] net/smc: make wr buffer count configurable
Message-ID: <aLpc4H_rHkHRu0nQ@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250904211254.1057445-1-pasic@linux.ibm.com>
 <20250904211254.1057445-2-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250904211254.1057445-2-pasic@linux.ibm.com>

On 2025-09-04 23:12:52, Halil Pasic wrote:
>Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
>SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
>get replaced with lgr->max_send_wr and lgr->max_recv_wr respective.

Hi Halil,

I think making the WR buffer count configurable helps make SMC more flexible.

However, there are two additional issues we need to consider:

1. What if the two sides have different max_send_wr/max_recv_wr configurations?
IIUC, For example, if the client sets max_send_wr to 64, but the server sets
max_recv_wr to 16, the client might overflow the server's QP receive
queue, potentially causing an RNR (Receiver Not Ready) error.

2. Since WR buffers are configurable, it’d be helpful to add some
monitoring methods so we can keep track of how many WR buffers each QP
is currently using. This should be useful now that you introduced a fallback
retry mechanism, which can cause the number of WR buffers to change
dynamically.


Some other minor issues in the patch itself, see below

>
>While at it let us also remove a confusing comment that is either not
>about the context in which it resides (describing
>qp_attr.cap.max_send_wr and qp_attr.cap.max_recv_wr) or not applicable
>any more when these values become configurable .
>
>Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>---
> Documentation/networking/smc-sysctl.rst | 37 +++++++++++++++++++++++++
> net/smc/smc.h                           |  2 ++
> net/smc/smc_core.h                      |  4 +++
> net/smc/smc_ib.c                        |  7 ++---
> net/smc/smc_llc.c                       |  2 ++
> net/smc/smc_sysctl.c                    | 22 +++++++++++++++
> net/smc/smc_wr.c                        | 32 +++++++++++----------
> net/smc/smc_wr.h                        |  2 --
> 8 files changed, 86 insertions(+), 22 deletions(-)
>
>diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
>index a874d007f2db..c687092329e3 100644
>--- a/Documentation/networking/smc-sysctl.rst
>+++ b/Documentation/networking/smc-sysctl.rst
>@@ -71,3 +71,40 @@ smcr_max_conns_per_lgr - INTEGER
> 	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
> 
> 	Default: 255
>+
>+smcr_max_send_wr - INTEGER

Why call it max ? But not something like smcr_send_wr_cnt ?

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
>+
>+	Default: 16
>+
>+smcr_max_recv_wr - INTEGER
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
>diff --git a/net/smc/smc.h b/net/smc/smc.h
>index 2c9084963739..ffe48253fa1f 100644
>--- a/net/smc/smc.h
>+++ b/net/smc/smc.h
>@@ -33,6 +33,8 @@
> 
> extern struct proto smc_proto;
> extern struct proto smc_proto6;
>+extern unsigned int smc_ib_sysctl_max_send_wr;
>+extern unsigned int smc_ib_sysctl_max_recv_wr;
> 
> extern struct smc_hashinfo smc_v4_hashinfo;
> extern struct smc_hashinfo smc_v6_hashinfo;
>diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>index 48a1b1dcb576..b883f43fc206 100644
>--- a/net/smc/smc_core.h
>+++ b/net/smc/smc_core.h
>@@ -361,6 +361,10 @@ struct smc_link_group {
> 						/* max conn can be assigned to lgr */
> 			u8			max_links;
> 						/* max links can be added in lgr */
>+			u16			max_send_wr;
>+						/* number of WR buffers on send */
>+			u16			max_recv_wr;
>+						/* number of WR buffers on recv */
> 		};
> 		struct { /* SMC-D */
> 			struct smcd_gid		peer_gid;
>diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
>index 0052f02756eb..e8d35c22c525 100644
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
>+	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
>+	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;
> 	lnk->roce_qp = ib_create_qp(lnk->roce_pd, &qp_attr);
> 	rc = PTR_ERR_OR_ZERO(lnk->roce_qp);
> 	if (IS_ERR(lnk->roce_qp))
>diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
>index f865c58c3aa7..91c936bf7336 100644
>--- a/net/smc/smc_llc.c
>+++ b/net/smc/smc_llc.c
>@@ -2157,6 +2157,8 @@ void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc)
> 	init_waitqueue_head(&lgr->llc_msg_waiter);
> 	init_rwsem(&lgr->llc_conf_mutex);
> 	lgr->llc_testlink_time = READ_ONCE(net->smc.sysctl_smcr_testlink_time);
>+	lgr->max_send_wr = (u16)(READ_ONCE(smc_ib_sysctl_max_send_wr));
>+	lgr->max_recv_wr = (u16)(READ_ONCE(smc_ib_sysctl_max_recv_wr));
> }
> 
> /* called after lgr was removed from lgr_list */
>diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
>index 2fab6456f765..01da1297e150 100644
>--- a/net/smc/smc_sysctl.c
>+++ b/net/smc/smc_sysctl.c
>@@ -29,6 +29,10 @@ static int links_per_lgr_min = SMC_LINKS_ADD_LNK_MIN;
> static int links_per_lgr_max = SMC_LINKS_ADD_LNK_MAX;
> static int conns_per_lgr_min = SMC_CONN_PER_LGR_MIN;
> static int conns_per_lgr_max = SMC_CONN_PER_LGR_MAX;
>+unsigned int smc_ib_sysctl_max_send_wr = 16;
>+unsigned int smc_ib_sysctl_max_recv_wr = 48;
>+static unsigned int smc_ib_sysctl_max_wr_min = 2;
>+static unsigned int smc_ib_sysctl_max_wr_max = 2048;
> 
> static struct ctl_table smc_table[] = {
> 	{
>@@ -99,6 +103,24 @@ static struct ctl_table smc_table[] = {
> 		.extra1		= SYSCTL_ZERO,
> 		.extra2		= SYSCTL_ONE,
> 	},
>+	{
>+		.procname       = "smcr_max_send_wr",
>+		.data		= &smc_ib_sysctl_max_send_wr,
>+		.maxlen         = sizeof(int),
>+		.mode           = 0644,
>+		.proc_handler   = proc_dointvec_minmax,
>+		.extra1		= &smc_ib_sysctl_max_wr_min,
>+		.extra2		= &smc_ib_sysctl_max_wr_max,
>+	},
>+	{
>+		.procname       = "smcr_max_recv_wr",
>+		.data		= &smc_ib_sysctl_max_recv_wr,
>+		.maxlen         = sizeof(int),
>+		.mode           = 0644,
>+		.proc_handler   = proc_dointvec_minmax,

It's better to use tab instead of space before those '=' here.

Best regards,
Dust


