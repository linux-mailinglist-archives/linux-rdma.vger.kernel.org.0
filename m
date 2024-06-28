Return-Path: <linux-rdma+bounces-3560-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC17891B926
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 09:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7578F1F23C43
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2024 07:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A28E145324;
	Fri, 28 Jun 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v+on2P6b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049BC148
	for <linux-rdma@vger.kernel.org>; Fri, 28 Jun 2024 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561485; cv=none; b=NSkUGelB2wN/2DxZ8QZDS7nkHS1lhUn/fr1uwqjMlwrEMtpFSnvzwZRZdUVhok7EGOohnA5L49LVnRYL+Zp13hnXtXKKw4hP15D5vuxGFtsxA4YNFEpVDWLJsWrwukgZ417guFSC4O487TdbPNh/5Edm0BG/xYVwrGtJFofxT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561485; c=relaxed/simple;
	bh=w1+N5w9tuw9P2bWefrIa1jOUi6yMbsWDcntSow2e86o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tL9uHGPY6zJsK8DHJLJghMTdMCm+8bExZn1FnKgzCwCNSrG2bWAIDdNJGEFuL6qHM22M5f3w3nQVyfelSfCeQE/UD/uCTXvWt2XdqRxM3CuisFZ8uDFFLVX4efN24JLTIhIwGp4QCLnPKqYCiQ/Z9zu64w6xH7QWTwLtcXfno7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v+on2P6b; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: anand.a.khoje@oracle.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719561479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ow9DZSi3OdvJbzDq/MxF59b5LtvOqbCNC3S2td/yhJ4=;
	b=v+on2P6bYSunCDPl++eZqGgiiOrbrQqUYZhnwVwT3gOtoRbYLBFy4HGLPvy8LfiGUpP1p8
	JEw2zNHNYx85CmtggEdetACuoVRBdaLP6HTWexh0kWEOf0TdRyTP/WKMjsbdhUWKIUJgeK
	EIH0+fTp3THyoUM3ok9oGWlJatVpFEo=
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: saeedm@mellanox.com
X-Envelope-To: leon@kernel.org
X-Envelope-To: tariqt@nvidia.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: davem@davemloft.net
X-Envelope-To: rama.nichanamatlu@oracle.com
X-Envelope-To: manjunath.b.patil@oracle.com
Message-ID: <1e60b5ae-8015-41c5-a60d-e2a5b0d7c01b@linux.dev>
Date: Fri, 28 Jun 2024 15:57:53 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6] net/mlx5: Reclaim max 50K pages at once
To: Anand Khoje <anand.a.khoje@oracle.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: saeedm@mellanox.com, leon@kernel.org, tariqt@nvidia.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com
References: <20240627182443.19254-1-anand.a.khoje@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240627182443.19254-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/6/28 2:24, Anand Khoje 写道:
> In non FLR context, at times CX-5 requests release of ~8 million FW pages.
> This needs humongous number of cmd mailboxes, which to be released once
> the pages are reclaimed. Release of humongous number of cmd mailboxes is
> consuming cpu time running into many seconds. Which with non preemptible
> kernels is leading to critical process starving on that cpu’s RQ.
> To alleviate this, this change restricts the total number of pages
> a worker will try to reclaim maximum 50K pages in one go.
> The limit 50K is aligned with the current firmware capacity/limit of
> releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES + MLX5_PAGES_TAKE
> device command.
> 
> Our tests have shown significant benefit of this change in terms of
> time consumed by dma_pool_free().
> During a test where an event was raised by HCA
> to release 1.3 Million pages, following observations were made:
> 
> - Without this change:
> Number of mailbox messages allocated was around 20K, to accommodate
> the DMA addresses of 1.3 million pages.
> The average time spent by dma_pool_free() to free the DMA pool is between
> 16 usec to 32 usec.
>             value  ------------- Distribution ------------- count
>               256 |                                         0
>               512 |@                                        287
>              1024 |@@@                                      1332
>              2048 |@                                        656
>              4096 |@@@@@                                    2599
>              8192 |@@@@@@@@@@                               4755
>             16384 |@@@@@@@@@@@@@@@                          7545
>             32768 |@@@@@                                    2501
>             65536 |                                         0
> 
> - With this change:
> Number of mailbox messages allocated was around 800; this was to
> accommodate DMA addresses of only 50K pages.
> The average time spent by dma_pool_free() to free the DMA pool in this case
> lies between 1 usec to 2 usec.
>             value  ------------- Distribution ------------- count
>               256 |                                         0
>               512 |@@@@@@@@@@@@@@@@@@                       346
>              1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
>              2048 |                                         0
>              4096 |                                         0
>              8192 |                                         1
>             16384 |                                         0
> 
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> ---
> Changes in v6
>   - Added comments to explain usage os negative MAX_RECLAIM_NPAGES
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> index d894a88..972e8e9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> @@ -608,6 +608,11 @@ enum {
>   	RELEASE_ALL_PAGES_MASK = 0x4000,
>   };
>   
> +/* This limit is based on the capability of the firmware as it cannot release
> + * more than 50000 back to the host in one go.
> + */
> +#define MAX_RECLAIM_NPAGES (-50000)
> +
>   static int req_pages_handler(struct notifier_block *nb,
>   			     unsigned long type, void *data)
>   {
> @@ -639,7 +644,16 @@ static int req_pages_handler(struct notifier_block *nb,
>   
>   	req->dev = dev;
>   	req->func_id = func_id;
> -	req->npages = npages;
> +
> +	/* npages > 0 means HCA asking host to allocate/give pages,
> +	 * npages < 0 means HCA asking host to reclaim back the pages allocated.
> +	 * Here we are restricting the maximum number of pages that can be
> +	 * reclaimed to be MAX_RECLAIM_NPAGES. Note that MAX_RECLAIM_NPAGES is
> +	 * a negative value.
> +	 * Since MAX_RECLAIM is negative, we are using max() to restrict
> +	 * req->npages (and not min ()).
> +	 */

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,
Zhu Yanjun

> +	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
>   	req->ec_function = ec_function;
>   	req->release_all = release_all;
>   	INIT_WORK(&req->work, pages_work_handler);


