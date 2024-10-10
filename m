Return-Path: <linux-rdma+bounces-5364-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26799985BE
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 14:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7FA28327A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 12:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D4F1C3F35;
	Thu, 10 Oct 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mlR14Sw3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D111C2DD5;
	Thu, 10 Oct 2024 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728562684; cv=none; b=EYHub44X9XrTUkdRRlFUmUYou4cGZim+fQfhF68BRtbzDsRq+i/ORmJzFY0bJeN++u3hoFyiieOfvMS9SC48R+1clpREZkXvBTdNawI2cpFVwEx2+Bv6I2ahCWJcjM2E361VFRq2ty5IJKNY0V6IJD8UWG6TNcYUu9G5L1fcCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728562684; c=relaxed/simple;
	bh=BSLkpupPmbeeazmrVZJIeAn8XkcdnLm+q8pU1MdPBt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQe7NK0F5LAgAGsHjT+USBWFpoRkHTuEvz3kqrsuIGSqhfd+qKmwZPTQf9PLlsNYFRblbakC6P0nLAgfTPmKSSPzEMWlxp0ivz1+Yzw5NqOTA94BVWC2nSxhHKMxF8+lgxPAJb/qYKhhSmQ161x2s2F9PRyQi1GYuAWmzWJ4DKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mlR14Sw3; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728562677; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Ancs41G/Yo8Fu4D+eEqUSzpEahc9fplNPE1QT5yaBMA=;
	b=mlR14Sw36jFRNSSkQ1vKNqgWAszxRa/XrNAiALb/hLyRUr6LtAEneLWY0YYP9LrpAAT/8cZVIbmqKIsi82H5IOMZZKd5+HFe+VwpHhrIysZI+FPOVdpvJm0brInT2IPu/2RInAT/F05G0PJQ0C9klTJ+Ts545+syHi/v1xKRPl4=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WGmON1P_1728562676 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 20:17:57 +0800
Date: Thu, 10 Oct 2024 20:17:56 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Kai Shen <KaiShen@linux.alibaba.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, guwen@linux.alibaba.com,
	kuba@kernel.org
Cc: davem@davemloft.net, tonylu@linux.alibaba.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: Fix memory leak when using percpu refs
Message-ID: <20241010121756.GF14069@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241010115624.7769-1-KaiShen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010115624.7769-1-KaiShen@linux.alibaba.com>

On 2024-10-10 11:56:24, Kai Shen wrote:
>This patch adds missing percpu_ref_exit when releasing percpu refs.
>When releasing percpu refs, percpu_ref_exit should be called.
>Otherwise, memory leak happens.
>
>Fixes: 79a22238b4f2 ("net/smc: Use percpu ref for wr tx reference")
>Signed-off-by: Kai Shen <KaiShen@linux.alibaba.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>


>---
> net/smc/smc_wr.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
>index 0021065a600a..994c0cd4fddb 100644
>--- a/net/smc/smc_wr.c
>+++ b/net/smc/smc_wr.c
>@@ -648,8 +648,10 @@ void smc_wr_free_link(struct smc_link *lnk)
> 	smc_wr_tx_wait_no_pending_sends(lnk);
> 	percpu_ref_kill(&lnk->wr_reg_refs);
> 	wait_for_completion(&lnk->reg_ref_comp);
>+	percpu_ref_exit(&lnk->wr_reg_refs);
> 	percpu_ref_kill(&lnk->wr_tx_refs);
> 	wait_for_completion(&lnk->tx_ref_comp);
>+	percpu_ref_exit(&lnk->wr_tx_refs);
> 
> 	if (lnk->wr_rx_dma_addr) {
> 		ib_dma_unmap_single(ibdev, lnk->wr_rx_dma_addr,
>@@ -912,11 +914,13 @@ int smc_wr_create_link(struct smc_link *lnk)
> 	init_waitqueue_head(&lnk->wr_reg_wait);
> 	rc = percpu_ref_init(&lnk->wr_reg_refs, smcr_wr_reg_refs_free, 0, GFP_KERNEL);
> 	if (rc)
>-		goto dma_unmap;
>+		goto cancel_ref;
> 	init_completion(&lnk->reg_ref_comp);
> 	init_waitqueue_head(&lnk->wr_rx_empty_wait);
> 	return rc;
> 
>+cancel_ref:
>+	percpu_ref_exit(&lnk->wr_tx_refs);
> dma_unmap:
> 	if (lnk->wr_rx_v2_dma_addr) {
> 		ib_dma_unmap_single(ibdev, lnk->wr_rx_v2_dma_addr,
>-- 
>2.31.1
>

