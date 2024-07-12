Return-Path: <linux-rdma+bounces-3845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0977992F666
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 09:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2650E1C22CF9
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2024 07:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE92E13DBA0;
	Fri, 12 Jul 2024 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXE/sLwS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECFC8F58;
	Fri, 12 Jul 2024 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720770236; cv=none; b=mmS3sR+37tf863fUAp96/oFnwY74YfKsyZ+nlzk+4Ktcww8rZFyFm+EpzS5gy9+Q0WxQCDGLVyESUbS9G2JsXwTnrzCTuFahbrIYON15mQ99tNtqmWVQpKvoC9qgar75R2TiLHhnjqG/J15cEj+a6ICImncJvUr4iM+M3Ts+iOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720770236; c=relaxed/simple;
	bh=lzaWmIZ+RB3H7kwGYmW9hQxX80Gmx1edTEPc27Cixmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMTweSwFuImmFapi7IT37/AH3XSTwqAU9e8nnkxBuh3FErBZZ2iWxUjIJP5PPOL/h9WHuNl/6scTE8YLCY6Ld+RrK3dCwJMimeTYmOX6aD/iZUxu+SZFvqEcvK/pblR2DsBzMdBt5TS+TjmJ+X1EcxAPJXfogG4b4HbNgvbPUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXE/sLwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BEDC3277B;
	Fri, 12 Jul 2024 07:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720770236;
	bh=lzaWmIZ+RB3H7kwGYmW9hQxX80Gmx1edTEPc27Cixmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXE/sLwSVkNc8tuXlKyjNyKH+HLiW2Azc8SHHMEtMhmFi59eE5pTGTuJpDswPHelF
	 j4irCvasPZFeireyM//BGL5j4CQB1VrCdNnXAZD779Wlvunv6khbY8LfI/dCYaKS/G
	 F+1c19taBUgfg+LqPonKhUjbK7oEg5vF0ZF0qgZrR0x4IbL5K8EczSY6HP9F/pUvos
	 wEtEgLCIWYI742a4Kmon0+cjjICVCBiGeDN66yuP4qHZiAAypjxrPVv1oRc9Wso6dr
	 iYTzxkjEYDJtLdyDugfOgMAU93jAgFYr3i0A8R9kyGeQ5Q5B4hTlqenKxPrfkVrFeo
	 0EsPsWc4JysiQ==
Date: Fri, 12 Jul 2024 00:43:54 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, saeedm@mellanox.com, leon@kernel.org,
	tariqt@nvidia.com, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com
Subject: Re: [PATCH net-next] net/mlx5: Reclaim max 50K pages at once
Message-ID: <ZpDeuoUlVoUON8Em@x130.lan>
References: <20240711151322.158274-1-anand.a.khoje@oracle.com>
 <ZpCI0mGJaNDFjMno@x130>
 <c8d99dba-89e9-4bf2-b436-f1a29cd573bb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8d99dba-89e9-4bf2-b436-f1a29cd573bb@oracle.com>

On 12 Jul 10:18, Anand Khoje wrote:
>
>On 7/12/24 07:07, Saeed Mahameed wrote:
>>On 11 Jul 20:43, Anand Khoje wrote:
>>>In non FLR context, at times CX-5 requests release of ~8 million 
>>>FW pages.
>>>This needs humongous number of cmd mailboxes, which to be released once
>>>the pages are reclaimed. Release of humongous number of cmd mailboxes is
>>>consuming cpu time running into many seconds. Which with non preemptible
>>>kernels is leading to critical process starving on that cpu’s RQ.
>>>To alleviate this, this change restricts the total number of pages
>>>a worker will try to reclaim maximum 50K pages in one go.
>>>The limit 50K is aligned with the current firmware capacity/limit of
>>>releasing 50K pages at once per MLX5_CMD_OP_MANAGE_PAGES + 
>>>MLX5_PAGES_TAKE
>>>device command.
>>
>>Where do you see this FW limit? currently we don't have it in the driver,
>>the driver requests from FW to reclaim exactly as many pages as the FW
>>already sent in the initial event. It is up to the FW to decide how many
>>pages out of those it actually release to the driver.
>>
>Hi Saeed,
>
>We have a confirmation from Vendor i.e. nVidia that the current limit 
>of maximum pages firmware will release is 50K.
>

Interesting I will try to find out next week, this should've been
advertised by FW somewhere.

>>>
>>>Our tests have shown significant benefit of this change in terms of
>>>time consumed by dma_pool_free().
>>>During a test where an event was raised by HCA
>>>to release 1.3 Million pages, following observations were made:
>>>
>>>- Without this change:
>>>Number of mailbox messages allocated was around 20K, to accommodate
>>>the DMA addresses of 1.3 million pages.
>>>The average time spent by dma_pool_free() to free the DMA pool is 
>>>between
>>>16 usec to 32 usec.
>>>          value  ------------- Distribution ------------- count
>>>            256 |                                         0
>>>            512 |@                                        287
>>>           1024 |@@@                                      1332
>>>           2048 |@                                        656
>>>           4096 |@@@@@                                    2599
>>>           8192 |@@@@@@@@@@                               4755
>>>          16384 |@@@@@@@@@@@@@@@                          7545
>>>          32768 |@@@@@                                    2501
>>>          65536 |                                         0
>>>
>>>- With this change:
>>>Number of mailbox messages allocated was around 800; this was to
>>>accommodate DMA addresses of only 50K pages.
>>>The average time spent by dma_pool_free() to free the DMA pool in 
>>>this case
>>>lies between 1 usec to 2 usec.
>>>          value  ------------- Distribution ------------- count
>>>            256 |                                         0
>>>            512 |@@@@@@@@@@@@@@@@@@                       346
>>>           1024 |@@@@@@@@@@@@@@@@@@@@@@                   435
>>>           2048 |                                         0
>>>           4096 |                                         0
>>>           8192 |                                         1
>>>          16384 |                                         0
>>>
>>
>>Sounds like you only release 50k pages out of the 1.3M! what happens 
>>to the
>>rest? eventually we need to release them and waiting for driver unload
>>isn't an option.
>>
>>My theory here of what happened before the patch:
>>1. FW: event to request to release 1.3M;
>>2. driver: prepare a FW command to release 1.3M, send it to FW with 1.3M;
>>3. FW: release 50K;
>>4. goto 1;
>>
>>After the patch:
>>1. FW: event to request to release 1.3M;
>>2. driver: prepare a FW command to release 50k**, send it to FW with 
>>50k*;
>>3. FW: release 50K; Driver didn't ask for more. no event required.
>>4. Done;
>>
>>After your patch it seems like there 1.25M pages that are lingering in FW
>>ownership with no use.
>>
>We have tested this case, here are our observations:
>
>1. FW: event to request to release 1.3M;
>2. driver: prepare a FW command to release 50k**, send it to FW with 50k*;
>3. FW: release 50K; Driver didn't ask for more. no event required.
>4. goto 1 with 1.25M request to release in a new EQE.
>
>It goes on till fw releases all pages from its ownership.
>
>I hope that answers your doubt.
>

I see, I think now the issue is clear to me, I got confused by the commit
message a bit, I thought the page allocator gets overwhelmed by the 8M
pages the FW is trying to release back to the host, but this has nothing to
do directly with releasing 8M pages, it is just the unnecessary driver allocation
of the very large command outbox from the dma_pool to accommodate the 8M page
addresses the FW needs to fill on reclaim, when the FW will only fill up to
50k.

Maybe improve the commit message a bit? Just explain about the unnecessary
alloc/free of the extra mailboxes for the large outbox buffer, since the FW
is limited and will never use this memory, so it's an unnecessary overhead.

Anyway, feel free to add:
Acked-by: Saeed Mahameed <saeedm@nvidia.com>

>Thanks,
>
>Anand
>
>>>Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
>>>Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>>>Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>---
>>>drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 16 
>>>+++++++++++++++-
>>>1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>>diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c 
>>>b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>>index d894a88..972e8e9 100644
>>>--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>>+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
>>>@@ -608,6 +608,11 @@ enum {
>>>    RELEASE_ALL_PAGES_MASK = 0x4000,
>>>};
>>>
>>>+/* This limit is based on the capability of the firmware as it 
>>>cannot release
>>>+ * more than 50000 back to the host in one go.
>>>+ */
>>>+#define MAX_RECLAIM_NPAGES (-50000)
>>>+
>>>static int req_pages_handler(struct notifier_block *nb,
>>>                 unsigned long type, void *data)
>>>{
>>>@@ -639,7 +644,16 @@ static int req_pages_handler(struct 
>>>notifier_block *nb,
>>>
>>>    req->dev = dev;
>>>    req->func_id = func_id;
>>>-    req->npages = npages;
>>>+
>>>+    /* npages > 0 means HCA asking host to allocate/give pages,
>>>+     * npages < 0 means HCA asking host to reclaim back the pages 
>>>allocated.
>>>+     * Here we are restricting the maximum number of pages that can be
>>>+     * reclaimed to be MAX_RECLAIM_NPAGES. Note that 
>>>MAX_RECLAIM_NPAGES is
>>>+     * a negative value.
>>>+     * Since MAX_RECLAIM is negative, we are using max() to restrict
>>>+     * req->npages (and not min ()).
>>>+     */
>>>+    req->npages = max_t(s32, npages, MAX_RECLAIM_NPAGES);
>>>    req->ec_function = ec_function;
>>>    req->release_all = release_all;
>>>    INIT_WORK(&req->work, pages_work_handler);
>>>-- 
>>>1.8.3.1
>>>
>>>

