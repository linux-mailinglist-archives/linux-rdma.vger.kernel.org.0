Return-Path: <linux-rdma+bounces-3167-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DE5909E35
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 17:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398261F21652
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 15:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3014292;
	Sun, 16 Jun 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dfbe3lhl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C772179BF;
	Sun, 16 Jun 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718552660; cv=none; b=CcM8eQHAVziF6pjUzMf0ZQnJ8gonlHb91VkuHKv+vhmxQhSNFxK4sNpWl/eKJhrTv6U7LgwFTJbYUZ6BeEZv/uFlw3u0p6ptxrX6SVhWdls9er/vLHT2+KSo6t1+V4aI7ZiPdGK6DCgcHZl5ty8cnNx0CdispEfMCG5jB2Lz3Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718552660; c=relaxed/simple;
	bh=/irIHAYFaxTK8wcj4zsIWLumVlfAjRePyWyjf7Y2SiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAP/4pHvHt36UkEum+FNknR3M07uzQY7zaivZeTbp9Utn85YXB9/wiWhy0mn1nC1vfYGt6G6e6XoEqQtoT7iJdmMHV7ns4odoxnuDqj4tstPkLnRFwQ2YvCkuyYWZMPmG/gufZ2HWaCWzrhOiVbao7rDwbOi5IoA370n0KpZ9mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dfbe3lhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46955C2BBFC;
	Sun, 16 Jun 2024 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718552659;
	bh=/irIHAYFaxTK8wcj4zsIWLumVlfAjRePyWyjf7Y2SiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dfbe3lhl1fZO5Kgb69QmPQEI1DjAiuKn1UUN3Ga72HiIYY8ID6QDRUaq6xJvgvByd
	 Ev464kN3QKSi3uLQKmX1IVkaWUSluZpYro3R6TorvLrGKYbFA2mUvo1nQM22teQWKW
	 zNYargskyUdPo2uVd1O+M4+ljk+mSLELhtKzNrIqEAKZu+3U+TpLUS9+STziHbFJTL
	 g/12cILYDrMGfWPrnIJdAeA1r5DjpAPXcusaRMp/y+bP6af8AlApckQn0AFq/2Yogv
	 LyT6OTrmYsRfcJk1q+dZZee5xVpBb/lp4ULi0gpsniEUAvMPQIOtzSevdLuagqfqzD
	 sDBzKVc2uLiRg==
Date: Sun, 16 Jun 2024 18:44:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, saeedm@mellanox.com, davem@davemloft.net
Subject: Re: [PATCH v3] net/mlx5 : Reclaim max 50K pages at once
Message-ID: <20240616154415.GA57288@unreal>
References: <20240614080135.122656-1-anand.a.khoje@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614080135.122656-1-anand.a.khoje@oracle.com>

On Fri, Jun 14, 2024 at 01:31:35PM +0530, Anand Khoje wrote:
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
> Changes in v3:
>    - Shifted the logic to function req_pages_handler() as per
>      Leon's suggestion.
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

The title has extra space:
"net/mlx5 : Reclaim max 50K pages at once" -> "net/mlx5: Reclaim max 50K pages at once"

But the code looks good to me.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

