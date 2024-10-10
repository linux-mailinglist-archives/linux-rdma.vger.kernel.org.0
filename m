Return-Path: <linux-rdma+bounces-5357-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EBC99811C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB9C328504C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2024 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B801BFE12;
	Thu, 10 Oct 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RTlEWZy3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA631BFDEC;
	Thu, 10 Oct 2024 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550461; cv=none; b=drVezU8UVPb5hi5pbk0N+yCy729YojhvHIq3jPvhxd4CbBZFN98AFTC/7kE4ib/ivtSP9hk3jSTCW+E91wuzEROL5ceDGY9nh/Yu7Lao0gzNVudyKNER8kpRes4GsXCvJGSXxcA0+MQwyIC0qRUITOuRiD5qhQrpkO68J295Wrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550461; c=relaxed/simple;
	bh=P/INDdNQO7VbXU91HTWbmPyf8H4Xm1o1MpPD1xSOJPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jO7gW+66O6tQacIQUh3JZSzD8BiEILeW8jr9CTEb5Gmc/Pc7v9pGzqDDf9neksp253b2faGLcnu93cw3gIbVBkEJUy5wlDAgJCTZPKhc6leBYbmLhJeowYJZTs2g2A08AVWvXlH346fZNm+/cVIklmrP1pYzUsBycyXDmxN7VuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RTlEWZy3; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728550451; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=IKH0A29e6mh84toXJRAb5HCwGuS9iqHE0EFJVHFiafk=;
	b=RTlEWZy3/y/kbStJqxfGuexeKxXUZfS7SZy+JrT9z6w6RtX4ubblP8+YsTZ5Gl04iEQZHm448a2NHZGY9ZUaespAWEXniYCnDyFg75giYH1tsYlZ4jmVtxPFwRVakqyay97iLOJhOquGRlpd0Gp2a4WZJidNRchW7Ux4+SZZoI0=
Received: from 30.221.131.25(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WGlohJL_1728550437 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Oct 2024 16:54:10 +0800
Message-ID: <19b24dd9-c89e-4900-9981-7c76179b1f49@linux.alibaba.com>
Date: Thu, 10 Oct 2024 16:53:56 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1] net/smc: Fix memory leak in percpu refs
To: Kai Shen <KaiShen@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, kuba@kernel.org
Cc: davem@davemloft.net, tonylu@linux.alibaba.com, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20241009035542.121951-1-KaiShen@linux.alibaba.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20241009035542.121951-1-KaiShen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/10/9 11:55, Kai Shen wrote:
> This patch adds missing percpu_ref_exit when releasing percpu refs.
> When releasing percpu refs, percpu_ref_exit should be called.
> Otherwise, memory leak happens.
> 
> Signed-off-by: Kai Shen <KaiShen@linux.alibaba.com>
> ---
>   net/smc/smc_wr.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 0021065a600a..994c0cd4fddb 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -648,8 +648,10 @@ void smc_wr_free_link(struct smc_link *lnk)
>   	smc_wr_tx_wait_no_pending_sends(lnk);
>   	percpu_ref_kill(&lnk->wr_reg_refs);
>   	wait_for_completion(&lnk->reg_ref_comp);
> +	percpu_ref_exit(&lnk->wr_reg_refs);
>   	percpu_ref_kill(&lnk->wr_tx_refs);
>   	wait_for_completion(&lnk->tx_ref_comp);
> +	percpu_ref_exit(&lnk->wr_tx_refs);
>   
>   	if (lnk->wr_rx_dma_addr) {
>   		ib_dma_unmap_single(ibdev, lnk->wr_rx_dma_addr,
> @@ -912,11 +914,13 @@ int smc_wr_create_link(struct smc_link *lnk)
>   	init_waitqueue_head(&lnk->wr_reg_wait);
>   	rc = percpu_ref_init(&lnk->wr_reg_refs, smcr_wr_reg_refs_free, 0, GFP_KERNEL);
>   	if (rc)
> -		goto dma_unmap;
> +		goto cancel_ref;
>   	init_completion(&lnk->reg_ref_comp);
>   	init_waitqueue_head(&lnk->wr_rx_empty_wait);
>   	return rc;
>   
> +cancel_ref:
> +	percpu_ref_exit(&lnk->wr_tx_refs);
>   dma_unmap:
>   	if (lnk->wr_rx_v2_dma_addr) {
>   		ib_dma_unmap_single(ibdev, lnk->wr_rx_v2_dma_addr,

Hi, Kai.

I think this is a fix to 79a22238b4f2 ("net/smc: Use percpu ref for wr tx reference").
So send it to net please and add a fix tag. Thanks!

