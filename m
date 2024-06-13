Return-Path: <linux-rdma+bounces-3134-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F6907BF6
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 21:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A25F1F24149
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jun 2024 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1920214D281;
	Thu, 13 Jun 2024 19:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7QnFhPG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56EE14C596;
	Thu, 13 Jun 2024 19:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305394; cv=none; b=BtdJL8JByOkur+D4BTRXjeGEV3PO/OO99F2qP86LVqJ58oheVC11XQ4Uhe2+as+lb3KpAInyKCXLfflPVWEQrVZWZRBqEt7FZAKn8b1XmZknvtGFr5TOCdRVebbcwSM+KACxlrpfyoa/xgGcJcCQFLoU/zwIT29PczWLDrx37Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305394; c=relaxed/simple;
	bh=J7cjlLIue33fN1P81zj/HS/X682Np1JLj5Zw5G6EfkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr8A9WaqgZ6DpUj5QHd0kSq1XpN/L2fazLPORkaibrMxR+GRuA7WI8jFCTm/TTRQ0FteQny/v9DokAMHhhashmvTV0HiEA1nR7buR1PfG/IKhLwKpWPu6eOuqsigwrDk2a1dXjHPaAQtcgSXsgkOEabCiPTFP2FHbqpzmG0sH2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7QnFhPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DBDC3277B;
	Thu, 13 Jun 2024 19:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718305394;
	bh=J7cjlLIue33fN1P81zj/HS/X682Np1JLj5Zw5G6EfkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7QnFhPG9ILAFLaiY8xJltIu9yOXrDIpcrJrxDVTpPeWDMCbemzGp4vKOr07V8CU3
	 UqYVzuz2EgiVKLdBKBEY54YtYKRke5XwRPYt+cNFU0IR7+dk4qmHJv7ZEN+6PDGnp2
	 IPoJSdp/Zw6ctrLZ5BPnZcvdhjq3ltOKNPzm0slGnY83YlOlAWQ/YJ1FNxl/l5fwui
	 w2MnWCnjsNoBppM3cvKlUE+QN82H7VP6Zibl4O4nqiYJasTN2fLcE4TiT0/8TwA/Ki
	 cPkrOVLptbWzRt0l4NrE2VH27GwrWmbp3ns0KCU2DX/gUyKmW5zq3O+pZ//PuyfeU0
	 3+IyrFWlBLx3Q==
Date: Thu, 13 Jun 2024 22:03:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, rama.nichanamatlu@oracle.com,
	manjunath.b.patil@oracle.com
Subject: Re: [PATCH v2] RDMA/mlx5 : Reclaim max 50K pages at once
Message-ID: <20240613190309.GI4966@unreal>
References: <20240613121252.93315-1-anand.a.khoje@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613121252.93315-1-anand.a.khoje@oracle.com>

On Thu, Jun 13, 2024 at 05:42:52PM +0530, Anand Khoje wrote:
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
> ---
> Changes in v2:
>  - In v1, CPUs were yielded if more than 2 msec are spent in
>    mlx5_free_cmd_msg(). The approach to limit the time spent is changed
>    in this version.
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> index 1b38397..b1cf97d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> @@ -482,12 +482,16 @@ static int reclaim_pages(struct mlx5_core_dev *dev, u32 func_id, int npages,
>  	return err;
>  }
>  
> +#define MAX_RECLAIM_NPAGES -50000
>  static void pages_work_handler(struct work_struct *work)
>  {
>  	struct mlx5_pages_req *req = container_of(work, struct mlx5_pages_req, work);
>  	struct mlx5_core_dev *dev = req->dev;
>  	int err = 0;
>  
> +	if (req->npages < MAX_RECLAIM_NPAGES)
> +		req->npages = MAX_RECLAIM_NPAGES;

I like this change more than previous variant with yield.
Regarding the patch:
1. Please limit the number of pages in req_pages_handler() and not int pages_work_handler().
2. Patch title should be "net/mlx5: Reclaim max 50K pages at once" and not "RDMA...".
3. You should run get_maintainer.pl script to find the right maintainers and add them to the TO or CC list.

And I still think that you will get better performance by parallelizing the reclaim process.

Thanks

> +
>  	if (req->release_all)
>  		release_all_pages(dev, req->func_id, req->ec_function);
>  	else if (req->npages < 0)
> -- 
> 1.8.3.1
> 
> 

