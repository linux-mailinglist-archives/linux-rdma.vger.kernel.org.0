Return-Path: <linux-rdma+bounces-13724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A650ABA7C7C
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 03:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C4E3B1DF3
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Sep 2025 01:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4441E1FF61E;
	Mon, 29 Sep 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CHzHYqLg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3942F2E;
	Mon, 29 Sep 2025 01:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759110669; cv=none; b=SoFvXURs8zOzIDuJ+LpeYgWdlEW5eNRiUkFttN58Fbsi0Z41UeW0DMFWwN5avhaj34uMZCCTlpwB8d5Dapqzfdq3Ype1lLK0WlYoiNaGl0IXlnV/ce9izQfWbTpprRWRYaUIIpUdax6/0J81xLYZeKAqPffPKZCElac3+yyo65o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759110669; c=relaxed/simple;
	bh=QPLiG3/EaSBK7ty8Ofz3g15Hll54Bo9Sr+73BNfJa6Q=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipQL0wEwn4h6gCK+O/56ookfEgeUtlE7+9QwT4laJx/jAZV9N+4rZ8VVw/tVNTsEi/ikDb2x+myV52GlmyAQYG7OnCCzRyhCYUPnmaetnv3r5hVs1DtmnB9JUfOOqgo/mvREUoG0Rlh0Uo9h9EJHN16xSA/G+0R5R/xMtl3lYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CHzHYqLg; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759110654; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=9aorilP5lRAQIaWXx/azi+eQ3upGhw4CPgjfhTO+Sro=;
	b=CHzHYqLgqUtZ+U8hRZFXvzMFo2FAC3SIlCnHPN1KGU8M2Iqmot7mm8NVV9U6O9Jx7oJ3C7yZUqv5QG41ROZI8cCA/k/4tUTVJVD4jsgBpPnlys+bACeKN3zzMJuZ/Otd9PZufNQkS091+XOV7WodKgCfw7yHsVsvFD4qZU2YDIs=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WozqZKo_1759110652 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Sep 2025 09:50:53 +0800
Date: Mon, 29 Sep 2025 09:50:52 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] net/smc: handle -ENOMEM from
 smc_wr_alloc_link_mem gracefully
Message-ID: <aNnl_CfV0EvIujK0@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
 <20250929000001.1752206-3-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929000001.1752206-3-pasic@linux.ibm.com>

On 2025-09-29 02:00:01, Halil Pasic wrote:
>Currently if a -ENOMEM from smc_wr_alloc_link_mem() is handled by
>giving up and going the way of a TCP fallback. This was reasonable
>before the sizes of the allocations there were compile time constants
>and reasonably small. But now those are actually configurable.
>
>So instead of giving up, keep retrying with half of the requested size
>unless we dip below the old static sizes -- then give up! In terms of
>numbers that means we give up when it is certain that we at best would
>end up allocating less than 16 send WR buffers or less than 48 recv WR
>buffers. This is to avoid regressions due to having fewer buffers
>compared the static values of the past.
>
>Please note that SMC-R is supposed to be an optimisation over TCP, and
>falling back to TCP is superior to establishing an SMC connection that
>is going to perform worse. If the memory allocation fails (and we
>propagate -ENOMEM), we fall back to TCP.
>
>Preserve (modulo truncation) the ratio of send/recv WR buffer counts.
>
>Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>Reviewed-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
>---
> Documentation/networking/smc-sysctl.rst |  8 ++++--
> net/smc/smc_core.c                      | 34 +++++++++++++++++--------
> net/smc/smc_core.h                      |  2 ++
> net/smc/smc_wr.c                        | 28 ++++++++++----------
> 4 files changed, 46 insertions(+), 26 deletions(-)
>
>diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
>index 5de4893ef3e7..4a5b4c89bc97 100644
>--- a/Documentation/networking/smc-sysctl.rst
>+++ b/Documentation/networking/smc-sysctl.rst
>@@ -85,7 +85,9 @@ smcr_max_send_wr - INTEGER
> 
> 	Please be aware that all the buffers need to be allocated as a physically
> 	continuous array in which each element is a single buffer and has the size
>-	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
>+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
>+	with half of the buffer count until it is ether successful or (unlikely)
>+	we dip below the old hard coded value which is 16 where we give up much
> 	like before having this control.
> 
> 	Default: 16
>@@ -103,7 +105,9 @@ smcr_max_recv_wr - INTEGER
> 
> 	Please be aware that all the buffers need to be allocated as a physically
> 	continuous array in which each element is a single buffer and has the size
>-	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
>+	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails, we keep retrying
>+	with half of the buffer count until it is ether successful or (unlikely)
>+	we dip below the old hard coded value which is 16 where we give up much
> 	like before having this control.
> 
> 	Default: 48
>diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>index be0c2da83d2b..e4eabc83719e 100644
>--- a/net/smc/smc_core.c
>+++ b/net/smc/smc_core.c
>@@ -810,6 +810,8 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
> 	lnk->clearing = 0;
> 	lnk->path_mtu = lnk->smcibdev->pattr[lnk->ibport - 1].active_mtu;
> 	lnk->link_id = smcr_next_link_id(lgr);
>+	lnk->max_send_wr = lgr->max_send_wr;
>+	lnk->max_recv_wr = lgr->max_recv_wr;
> 	lnk->lgr = lgr;
> 	smc_lgr_hold(lgr); /* lgr_put in smcr_link_clear() */
> 	lnk->link_idx = link_idx;
>@@ -836,27 +838,39 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
> 	rc = smc_llc_link_init(lnk);
> 	if (rc)
> 		goto out;
>-	rc = smc_wr_alloc_link_mem(lnk);
>-	if (rc)
>-		goto clear_llc_lnk;
> 	rc = smc_ib_create_protection_domain(lnk);
> 	if (rc)
>-		goto free_link_mem;
>-	rc = smc_ib_create_queue_pair(lnk);
>-	if (rc)
>-		goto dealloc_pd;
>+		goto clear_llc_lnk;
>+	do {
>+		rc = smc_ib_create_queue_pair(lnk);
>+		if (rc)
>+			goto dealloc_pd;
>+		rc = smc_wr_alloc_link_mem(lnk);
>+		if (!rc)
>+			break;
>+		else if (rc != -ENOMEM) /* give up */
>+			goto destroy_qp;
>+		/* retry with smaller ... */
>+		lnk->max_send_wr /= 2;
>+		lnk->max_recv_wr /= 2;
>+		/* ... unless droping below old SMC_WR_BUF_SIZE */
>+		if (lnk->max_send_wr < 16 || lnk->max_recv_wr < 48)
>+			goto destroy_qp;
>+		smc_ib_destroy_queue_pair(lnk);
>+	} while (1);
>+
> 	rc = smc_wr_create_link(lnk);
> 	if (rc)
>-		goto destroy_qp;
>+		goto free_link_mem;
> 	lnk->state = SMC_LNK_ACTIVATING;
> 	return 0;
> 
>+free_link_mem:
>+	smc_wr_free_link_mem(lnk);
> destroy_qp:
> 	smc_ib_destroy_queue_pair(lnk);
> dealloc_pd:
> 	smc_ib_dealloc_protection_domain(lnk);
>-free_link_mem:
>-	smc_wr_free_link_mem(lnk);
> clear_llc_lnk:
> 	smc_llc_link_clear(lnk, false);
> out:
>diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
>index 8d06c8bb14e9..5c18f08a4c8a 100644
>--- a/net/smc/smc_core.h
>+++ b/net/smc/smc_core.h
>@@ -175,6 +175,8 @@ struct smc_link {
> 	struct completion	llc_testlink_resp; /* wait for rx of testlink */
> 	int			llc_testlink_time; /* testlink interval */
> 	atomic_t		conn_cnt; /* connections on this link */
>+	u16			max_send_wr;
>+	u16			max_recv_wr;

Here, you've moved max_send_wr/max_recv_wr from the link group to individual links.
This means we can now have different max_send_wr/max_recv_wr values on two
different links within the same link group.

Since in Alibaba we doesn't use multi-link configurations, we haven't tested
this scenario. Have you tested the link-down handling process in a multi-link
setup?

Otherwise, the patch looks good to me.

Best regards,
Dust

> };
> 
> /* For now we just allow one parallel link per link group. The SMC protocol
>diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
>index 883fb0f1ce43..5feafa98ab1a 100644
>--- a/net/smc/smc_wr.c
>+++ b/net/smc/smc_wr.c
>@@ -547,9 +547,9 @@ void smc_wr_remember_qp_attr(struct smc_link *lnk)
> 		    IB_QP_DEST_QPN,
> 		    &init_attr);
> 
>-	lnk->wr_tx_cnt = min_t(size_t, lnk->lgr->max_send_wr,
>+	lnk->wr_tx_cnt = min_t(size_t, lnk->max_send_wr,
> 			       lnk->qp_attr.cap.max_send_wr);
>-	lnk->wr_rx_cnt = min_t(size_t, lnk->lgr->max_recv_wr,
>+	lnk->wr_rx_cnt = min_t(size_t, lnk->max_recv_wr,
> 			       lnk->qp_attr.cap.max_recv_wr);
> }
> 
>@@ -741,51 +741,51 @@ int smc_wr_alloc_lgr_mem(struct smc_link_group *lgr)
> int smc_wr_alloc_link_mem(struct smc_link *link)
> {
> 	/* allocate link related memory */
>-	link->wr_tx_bufs = kcalloc(link->lgr->max_send_wr,
>+	link->wr_tx_bufs = kcalloc(link->max_send_wr,
> 				   SMC_WR_BUF_SIZE, GFP_KERNEL);
> 	if (!link->wr_tx_bufs)
> 		goto no_mem;
>-	link->wr_rx_bufs = kcalloc(link->lgr->max_recv_wr, link->wr_rx_buflen,
>+	link->wr_rx_bufs = kcalloc(link->max_recv_wr, link->wr_rx_buflen,
> 				   GFP_KERNEL);
> 	if (!link->wr_rx_bufs)
> 		goto no_mem_wr_tx_bufs;
>-	link->wr_tx_ibs = kcalloc(link->lgr->max_send_wr,
>+	link->wr_tx_ibs = kcalloc(link->max_send_wr,
> 				  sizeof(link->wr_tx_ibs[0]), GFP_KERNEL);
> 	if (!link->wr_tx_ibs)
> 		goto no_mem_wr_rx_bufs;
>-	link->wr_rx_ibs = kcalloc(link->lgr->max_recv_wr,
>+	link->wr_rx_ibs = kcalloc(link->max_recv_wr,
> 				  sizeof(link->wr_rx_ibs[0]),
> 				  GFP_KERNEL);
> 	if (!link->wr_rx_ibs)
> 		goto no_mem_wr_tx_ibs;
>-	link->wr_tx_rdmas = kcalloc(link->lgr->max_send_wr,
>+	link->wr_tx_rdmas = kcalloc(link->max_send_wr,
> 				    sizeof(link->wr_tx_rdmas[0]),
> 				    GFP_KERNEL);
> 	if (!link->wr_tx_rdmas)
> 		goto no_mem_wr_rx_ibs;
>-	link->wr_tx_rdma_sges = kcalloc(link->lgr->max_send_wr,
>+	link->wr_tx_rdma_sges = kcalloc(link->max_send_wr,
> 					sizeof(link->wr_tx_rdma_sges[0]),
> 					GFP_KERNEL);
> 	if (!link->wr_tx_rdma_sges)
> 		goto no_mem_wr_tx_rdmas;
>-	link->wr_tx_sges = kcalloc(link->lgr->max_send_wr, sizeof(link->wr_tx_sges[0]),
>+	link->wr_tx_sges = kcalloc(link->max_send_wr, sizeof(link->wr_tx_sges[0]),
> 				   GFP_KERNEL);
> 	if (!link->wr_tx_sges)
> 		goto no_mem_wr_tx_rdma_sges;
>-	link->wr_rx_sges = kcalloc(link->lgr->max_recv_wr,
>+	link->wr_rx_sges = kcalloc(link->max_recv_wr,
> 				   sizeof(link->wr_rx_sges[0]) * link->wr_rx_sge_cnt,
> 				   GFP_KERNEL);
> 	if (!link->wr_rx_sges)
> 		goto no_mem_wr_tx_sges;
>-	link->wr_tx_mask = bitmap_zalloc(link->lgr->max_send_wr, GFP_KERNEL);
>+	link->wr_tx_mask = bitmap_zalloc(link->max_send_wr, GFP_KERNEL);
> 	if (!link->wr_tx_mask)
> 		goto no_mem_wr_rx_sges;
>-	link->wr_tx_pends = kcalloc(link->lgr->max_send_wr,
>+	link->wr_tx_pends = kcalloc(link->max_send_wr,
> 				    sizeof(link->wr_tx_pends[0]),
> 				    GFP_KERNEL);
> 	if (!link->wr_tx_pends)
> 		goto no_mem_wr_tx_mask;
>-	link->wr_tx_compl = kcalloc(link->lgr->max_send_wr,
>+	link->wr_tx_compl = kcalloc(link->max_send_wr,
> 				    sizeof(link->wr_tx_compl[0]),
> 				    GFP_KERNEL);
> 	if (!link->wr_tx_compl)
>@@ -906,7 +906,7 @@ int smc_wr_create_link(struct smc_link *lnk)
> 		goto dma_unmap;
> 	}
> 	smc_wr_init_sge(lnk);
>-	bitmap_zero(lnk->wr_tx_mask, lnk->lgr->max_send_wr);
>+	bitmap_zero(lnk->wr_tx_mask, lnk->max_send_wr);
> 	init_waitqueue_head(&lnk->wr_tx_wait);
> 	rc = percpu_ref_init(&lnk->wr_tx_refs, smcr_wr_tx_refs_free, 0, GFP_KERNEL);
> 	if (rc)
>-- 
>2.48.1

