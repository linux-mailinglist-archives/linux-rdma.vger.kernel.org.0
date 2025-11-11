Return-Path: <linux-rdma+bounces-14390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF1C4D92E
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 13:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D91E1898CF6
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Nov 2025 12:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA6D358D2E;
	Tue, 11 Nov 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpaIRAL1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76554358D23
	for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862503; cv=none; b=LZG7rh4hOd4AquUCJMyxIfFyUyUxUAsr1ObklgLXSU80LpKVQAAOZ4S3HcX/L/LRWY4qolfbDpvSflolMuMOCxJl731/yVBKjMJZkC0s5EerW5IssMEiWh3xt6vkqVBbRbNr7a1bJ3plW+BTq0jjvHR7TBK8ojO6kb+MVNKUL4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862503; c=relaxed/simple;
	bh=o7XOb8G37vtEbK4N1cSqzLbZKZqT2mPouP9tq/3KFns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbGratwDeihdBN4NNxTi4ckoSCygUEhOQzoqQJUv0RP0/UOAlls5yOm0MR5YosuLbu3W7BijGqgMp9jrUnAxLGz8wxgpHi/YMQQ2sH0fRlNy9BxEKcpe54drN/qDyp9UOsddteKPH7JZi3IIJD2Xkzl6tLBi7e6vabFzXDYjvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpaIRAL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83841C19421;
	Tue, 11 Nov 2025 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762862503;
	bh=o7XOb8G37vtEbK4N1cSqzLbZKZqT2mPouP9tq/3KFns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EpaIRAL1TpWYNEIsjhGVKcyygOyswQMlePu4oIJq66Jz2ZbrIXZ2f3ObRjZwQV/Mw
	 j10MTNsyUqT3n3hXMX1MzwYr9Sh+/naTwHZTGhgN5B24xPNJ6amNwiU2f25vHiOv/n
	 LU/yPUhtrdt7UYk5a6XWbie8nbiopdNze7fhw3y7X9kSxt9sShvhvvpSJiCAMvPj6Q
	 WCmOFjXZ147P6RkW10KxrYpXw5liKRKffobMcdbmt+ulpu9Ge6FmJaNSy+RNnrVT+V
	 RNAKXpFalo9QhKloqK45Nrf0rfLRDkQoxpnhe4Mo2TOVxE7Gu/5xy8MW6bPsvRk/wG
	 HEtzkPLRd4E0w==
Date: Tue, 11 Nov 2025 14:01:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Prevent soft lockup during large user memory
 region cleanup
Message-ID: <20251111120136.GP15456@unreal>
References: <20251111070107.2627-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111070107.2627-1-lirongqing@baidu.com>

On Tue, Nov 11, 2025 at 03:01:07PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When a process exits with numerous large, pinned memory regions consisting
> of 4KB pages, the cleanup of the memory region through __ib_umem_release()
> may cause soft lockups. This is because unpin_user_page_range_dirty_lock()

Do you have soft lookup splat?

> is called in a tight loop for unpin and releasing page without yielding the
> CPU.
> 
> Fix the soft lockup by adding cond_resched() calls in __ib_umem_release
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/infiniband/core/umem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index c5b6863..70c1520 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -59,6 +59,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
>  		unpin_user_page_range_dirty_lock(sg_page(sg),
>  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
>  
> +	cond_resched();
>  	sg_free_append_table(&umem->sgt_append);
>  }
>  
> -- 
> 2.9.4
> 

