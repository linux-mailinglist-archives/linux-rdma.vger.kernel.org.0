Return-Path: <linux-rdma+bounces-3841-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C5F92F383
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 03:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FA6B23477
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 01:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37187539A;
	Fri, 12 Jul 2024 01:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it2zKVl7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46CF4414;
	Fri, 12 Jul 2024 01:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720748244; cv=none; b=F8ft4O1AG98bdoh9FdhvwOEg++3P9O66zLbZZ1Z/a6KrcAoQH9IhHDNvrEYxC+BEQUoZZDXnS0amtBpf1ELtoTa0nZrvgF8NWqInNJg2+qoXHp/9pJL7iqJuuyoXZuLSb0pRKLWi4jU+sI5Dk5g2NA69KDoM/5EVhrSSL6hFQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720748244; c=relaxed/simple;
	bh=vJTqTjhMKKJ/e8b0iJ8xcitxIe0iZVFSU5OyjZ/gx7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTMtwKwMfA4dN54d99GLhJNPaQOH8/xa/s6rNL/XnX1/ABRx9aY0Mz5nDp1vQ6i6ZT+tlGbVNY2Sx+8H7e1xCRzI3JuNltZYV0z21Zsw8YY5k3apwtvC3PxA79Xj4oUiP/U1uCTlf0dk6vkMg0gqRZIeaTw2/l5ULyobQjuNYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it2zKVl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD67C116B1;
	Fri, 12 Jul 2024 01:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720748243;
	bh=vJTqTjhMKKJ/e8b0iJ8xcitxIe0iZVFSU5OyjZ/gx7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=it2zKVl7Y6K0QT6ulsvxcC32LLD8PMIwRJgRIZSs5//DYymBuQKogF/QdSWC5s1JV
	 or3hOsTYqtZSN6TXhruh3+NZ3rITW9GpSVev3Q9rsL6DS4bXYvz5h/Q4+PMGFs7HRs
	 RXBR1jZlat7BGsVONg1Q+mh9oXLFYFiRVYeL8MvGJG+oMHgTfNqs1gLfwfriIEoLXU
	 oPp4UxV683o8mU9ADpJwc6K02AGQvQAximdwGGUAoMELkbQ/3J7sOgQN3hz3oA1yXU
	 wfWQnF8GTlLwn/8bow1Fe0KIjNve3SeFB1b6Xwj67B8bNnJktHCZb8eRacS4hJ8juw
	 9frVwQnCQfeTw==
Date: Thu, 11 Jul 2024 18:37:22 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, saeedm@mellanox.com, leon@kernel.org,
	tariqt@nvidia.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com
Subject: Re: [PATCH net-next] net/mlx5: Reclaim max 50K pages at once
Message-ID: <ZpCI0mGJaNDFjMno@x130>
References: <20240711151322.158274-1-anand.a.khoje@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240711151322.158274-1-anand.a.khoje@oracle.com>

On 11 Jul 20:43, Anand Khoje wrote:
>In non FLR context, at times CX-5 requests release of ~8 million FW pages.
>This needs humongous number of cmd mailboxes, which to be released once
>the pages are reclaimed. Release of humongous number of cmd mailboxes is
>consuming cpu time running into many seconds. Which with non preemptible
>kernels is leading to critical process starving on that cpu’s RQ.
>To alleviate this, this change restricts the total number of pages
>a worker will try to reclaim maximum 50K pages in one go.
>The limit 50K is aligned with the current firmware capacity/limit of
>releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES + MLX5_PAGES_TAKE
>device command.

Where do you see this FW limit? currently we don't have it in the driver,
the driver requests from FW to reclaim exactly as many pages as the FW
already sent in the initial event. It is up to the FW to decide how many
pages out of those it actually release to the driver.

>
>Our tests have shown significant benefit of this change in terms of
>time consumed by dma_pool_free().
>During a test where an event was raised by HCA
>to release 1.3 Million pages, following observations were made:
>
>- Without this change:
>Number of mailbox messages allocated was around 20K, to accommodate
>the DMA addresses of 1.3 million pages.
>The average time spent by dma_pool_free() to free the DMA pool is between
>16 usec to 32 usec.
>           value  ------------- Distribution ------------- count
>             256 |                                         0
>             512 |@                                        287
>            1024 |@@@                                      1332
>            2048 |@                                        656
>            4096 |@@@@@                                    2599
>            8192 |@@@@@@@@@@                               4755
>           16384 |@@@@@@@@@@@@@@@                          7545
>           32768 |@@@@@                                    2501
>           65536 |                                         0
>
>- With this change:
>Number of mailbox messages allocated was around 800; this was to
>accommodate DMA addresses of only 50K pages.
>The average time spent by dma_pool_free() to free the DMA pool in this case
>lies between 1 usec to 2 usec.
>           value  ------------- Distribution ------------- count
>             256 |                                         0
>             512 |@@@@@@@@@@@@@@@@@@                       346
>            1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
>            2048 |                                         0
>            4096 |                                         0
>            8192 |                                         1
>           16384 |                                         0
>

Sounds like you only release 50k pages out of the 1.3M! what happens to the
rest? eventually we need to release them and waiting for driver unload
isn't an option.

My theory here of what happened before the patch:
1. FW: event to request to release 1.3M;
2. driver: prepare a FW command to release 1.3M, send it to FW with 1.3M;
3. FW: release 50K;
4. goto 1;

After the patch:
1. FW: event to request to release 1.3M;
2. driver: prepare a FW command to release 50k**, send it to FW with 50k*;
3. FW: release 50K; Driver didn't ask for more. no event required.
4. Done;

After your patch it seems like there 1.25M pages that are lingering in FW
ownership with no use.

>Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>---
> drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 16 +++++++++++++++-
> 1 file changed, 15 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>index d894a88..972e8e9 100644
>--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>@@ -608,6 +608,11 @@ enum {
> 	RELEASE_ALL_PAGES_MASK = 0x4000,
> };
>
>+/* This limit is based on the capability of the firmware as it cannot release
>+ * more than 50000 back to the host in one go.
>+ */
>+#define MAX_RECLAIM_NPAGES (-50000)
>+
> static int req_pages_handler(struct notifier_block *nb,
> 			     unsigned long type, void *data)
> {
>@@ -639,7 +644,16 @@ static int req_pages_handler(struct notifier_block *nb,
>
> 	req->dev = dev;
> 	req->func_id = func_id;
>-	req->npages = npages;
>+
>+	/* npages > 0 means HCA asking host to allocate/give pages,
>+	 * npages < 0 means HCA asking host to reclaim back the pages allocated.
>+	 * Here we are restricting the maximum number of pages that can be
>+	 * reclaimed to be MAX_RECLAIM_NPAGES. Note that MAX_RECLAIM_NPAGES is
>+	 * a negative value.
>+	 * Since MAX_RECLAIM is negative, we are using max() to restrict
>+	 * req->npages (and not min ()).
>+	 */
>+	req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
> 	req->ec_function = ec_function;
> 	req->release_all = release_all;
> 	INIT_WORK(&req->work, pages_work_handler);
>-- 
>1.8.3.1
>
>

