Return-Path: <linux-rdma+bounces-15214-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3852CDDC0F
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 13:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 716E83010297
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 12:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6331ED7A;
	Thu, 25 Dec 2025 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daEpoIN3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839031ED69;
	Thu, 25 Dec 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766666018; cv=none; b=QCEIROrVfgLoT4lkMfzgYA6nPNNt8TTnxsPhdZBNUPO1cz6UeJGdEvGWe3C0IxZqSACVDeWi4RqmT00QroOAGQSv6QTYIq53j5z/gVpCi8grdK92KP7iedyBQULyRyAw2vr7EBsXZa+mOPE5Zl43UeKN9ke5CZrnWObWrXWX7+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766666018; c=relaxed/simple;
	bh=hI4mtnlsg3wXmrphX1mt2jXkTCC0fKFnHALNWd7IqpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUJ/2h2O5pl8DqFFMB4TLz6s/K0RicDKiJc4jwooOcP2WIXGbEWdLCuxUxLp5d40Y6OsqGEQRn8OMCf6ACSkI65/cJnInZcoDh0ZpmJeuX7rS8xX27xqpap+11yfQIriNuXGz7kbJP7dCS5rI44W4QHdQqk8BpGCb1CjlesWwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daEpoIN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DA6C4CEF1;
	Thu, 25 Dec 2025 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766666017;
	bh=hI4mtnlsg3wXmrphX1mt2jXkTCC0fKFnHALNWd7IqpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=daEpoIN34L2O2dZjuS605468W/wvpNVt88Nualq1ROG+XTxDIr/HgzyCd3oH5tZrJ
	 aPtTzXLsfBFPn8WNSEFOhhUXJ9xlDhqNkHvgySIVPrLH+GgGvpb9iHoPpPAVfggNge
	 rRVNwVnGQoQ3NGGnxnrtTbh+Jl49JL+2q37S7Ml1p7VUFBI4S3Fm6fryI0g2Y9ODmV
	 s1RZ4/9g0/oVhbhjRBFZ1uo1z8Do/9fkzfZmChaxKGl8A1UWgwWnhMExJ+1K7a8e4L
	 OM2miWq2su7sux4oAKH0VXAR9Ee5yMEhWKNlH959NqXJ6NFf3DKZE78TrH8FR9g8e4
	 1Fe3Y0vLH3y2A==
Date: Thu, 25 Dec 2025 14:33:32 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Honggang LI <honggangli@163.com>
Cc: haris.iqbal@ionos.com, jinpu.wang@ionos.com, jgg@ziepe.ca,
	danil.kipnis@cloud.ionos.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] RDMA/rtrs: client: Fix clt_path::max_pages_per_mr
 calculation
Message-ID: <20251225123332.GI11869@unreal>
References: <20251224095030.156465-1-honggangli@163.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224095030.156465-1-honggangli@163.com>

On Wed, Dec 24, 2025 at 05:50:30PM +0800, Honggang LI wrote:
> If device max_mr_size bits in the range [mr_page_shift+31:mr_page_shift]
> are zero, the `min3` function will set clt_path::max_pages_per_mr to
> zero.
> 
> `alloc_path_reqs` will pass zero, which is invalid, as the third parameter
> to `ib_alloc_mr`.
> 
> v1 -> v2:
> Correct the commit message and set max_pages_per_mr to U32_MAX
> as Michael Gur suggested.

Please put changelog under --- marker, below Signed-off-by tags.

> Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> Signed-off-by: Honggang LI <honggangli@163.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> index 71387811b281..e477d2c0ff35 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> @@ -1464,6 +1464,8 @@ static void query_fast_reg_mode(struct rtrs_clt_path *clt_path)
>  	mr_page_shift      = max(12, ffs(ib_dev->attrs.page_size_cap) - 1);
>  	max_pages_per_mr   = ib_dev->attrs.max_mr_size;
>  	do_div(max_pages_per_mr, (1ull << mr_page_shift));
> +	if ((u32)max_pages_per_mr == 0)
> +		max_pages_per_mr = U32_MAX;

It is "max_pages_per_mr = min_not_zero((u32)max_pages_per_mr, U32_MAX)"

Thanks

>  	clt_path->max_pages_per_mr =
>  		min3(clt_path->max_pages_per_mr, (u32)max_pages_per_mr,
>  		     ib_dev->attrs.max_fast_reg_page_list_len);
> -- 
> 2.52.0
> 

