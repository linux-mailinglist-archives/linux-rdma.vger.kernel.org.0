Return-Path: <linux-rdma+bounces-3428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B39C79146D6
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 11:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 511EE1F24A19
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 09:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEAC135414;
	Mon, 24 Jun 2024 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5xr7yrX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5412A18E29;
	Mon, 24 Jun 2024 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223082; cv=none; b=hi/BVZ+VtGYwUjBHoOqUmsi2g07np/yVEnsX4G7EO8/736SggAlUNAoUSy9pAjAU2jb4r8eaCvF4qPwGIzjQhN5jhoN8GvdlD4Rid9UxL+cwDVbzOHtCvmZ60U7TGfIzjJkWnp0SE6Gx9gDcOsGr/N/btTeaPjvldYBSCZ/MBjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223082; c=relaxed/simple;
	bh=PCS2eND6dMFRmJ0JLYMJ4gA10c9zYgjNA+oAXwfioCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvBvyO1x87LR6hVBDmBZVWh2+uqBFK35Sl7noWPi28F/livNmOB1llqSMuY4wP2tmP1w3sY720E3U3ujwLS2+RBUtoPtZES9bXDCfNG7xKhdGuSaEwfFOhZ2U4dL4xeygDjUtdkkTXTv3OvDYgznz6gb3+be41IdmMgmXJr69JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5xr7yrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1720CC2BBFC;
	Mon, 24 Jun 2024 09:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719223081;
	bh=PCS2eND6dMFRmJ0JLYMJ4gA10c9zYgjNA+oAXwfioCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I5xr7yrXbJ8Qc0ndufSrQMupRZDo3MF/ERahKv94iV6hBOvlFGq/TxzGQ+6cp3CTI
	 Oqt+I0HS1CXrwhwAb3MqCrkjuNzyBdf8NsVGvkUDD8zWDl36I+S4WO2dA2beim7Hq7
	 u0426QL0TWD3ENp2k3pF7J3aqTtg4eKIR2eLdRb7pgqOkcFpkW1daqwqBTA+8i95eW
	 YVQ2ZtWQ+n2j4wVTzWkzr/3jwSvS6oBNeN7AZCJ1KexEu+qJ+zto84T68b4YremBl/
	 NCnnwXhv6JEcWrlL3H+R7eFBzwxzdI7nRsjCbLKT4rremQoRZnPa2NcUBvgmCeH0i5
	 4VyyJVFPGvoaQ==
Date: Mon, 24 Jun 2024 12:57:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, saeedm@mellanox.com, tariqt@nvidia.com,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net
Subject: Re: [PATCH v4] net/mlx5: Reclaim max 50K pages at once
Message-ID: <20240624095757.GD29266@unreal>
References: <20240619132827.51306-1-anand.a.khoje@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240619132827.51306-1-anand.a.khoje@oracle.com>

On Wed, Jun 19, 2024 at 06:58:27PM +0530, Anand Khoje wrote:
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
>            value  ------------- Distribution ------------- count
>              256 |                                         0
>              512 |@                                        287
>             1024 |@@@                                      1332
>             2048 |@                                        656
>             4096 |@@@@@                                    2599
>             8192 |@@@@@@@@@@                               4755
>            16384 |@@@@@@@@@@@@@@@                          7545
>            32768 |@@@@@                                    2501
>            65536 |                                         0
> 
> - With this change:
> Number of mailbox messages allocated was around 800; this was to
> accommodate DMA addresses of only 50K pages.
> The average time spent by dma_pool_free() to free the DMA pool in this case
> lies between 1 usec to 2 usec.
>            value  ------------- Distribution ------------- count
>              256 |                                         0
>              512 |@@@@@@@@@@@@@@@@@@                       346
>             1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
>             2048 |                                         0
>             4096 |                                         0
>             8192 |                                         1
>            16384 |                                         0
> 
> Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changes in v4:
>   - Fixed a nit in patch subject.
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> index dcf58ef..06eee3a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> @@ -608,6 +608,7 @@ enum {
>  	RELEASE_ALL_PAGES_MASK = 0x4000,
>  };
>  
> +#define MAX_RECLAIM_NPAGES -50000
>  static int req_pages_handler(struct notifier_block *nb,
>  			     unsigned long type, void *data)
>  {
> @@ -639,9 +640,13 @@ static int req_pages_handler(struct notifier_block *nb,
>  
>  	req->dev = dev;
>  	req->func_id = func_id;
> -	req->npages = npages;
>  	req->ec_function = ec_function;
>  	req->release_all = release_all;
> +	if (npages < MAX_RECLAIM_NPAGES)
> +		req->npages = MAX_RECLAIM_NPAGES;
> +	else
> +		req->npages = npages;
> +

BTW, this can be written as:
	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);

Thanks

>  	INIT_WORK(&req->work, pages_work_handler);
>  	queue_work(dev->priv.pg_wq, &req->work);
>  	return NOTIFY_OK;
> -- 
> 1.8.3.1
> 

