Return-Path: <linux-rdma+bounces-15215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7BBCDDCBA
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 13:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA77B3040743
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Dec 2025 12:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C67325486;
	Thu, 25 Dec 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuN+22bN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029AA324B32;
	Thu, 25 Dec 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766667019; cv=none; b=WTVXibL+EkgJQwuG9qACwV1TMPj3Pe8h5tb5OqPa9tXk2Pb8jbHLcOnInt85CvJ+8XGfxx8mHKyW3LuCYwdSPDElgsC+xq2DHvdcwdutre1KJQl0ttgECVkwmo1wIL1CLq7SJdvL62zVJ2o/NZWHcDb8vkfB2+fTUbGB5Vr6VsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766667019; c=relaxed/simple;
	bh=auK0WAIK1+aYoZs3CUmnhmvJRbjGC5SkGUKn/CV7p8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULhCysfHmyyPDp8zNBiFzCuAXhfY/O3zD3CO2qs8MlQvaIEdQ9EADgMdgLogQ1DTE7MEUgxT0H5p9p3VnwV4OYfpf4khf/KWuRprc5mMq1+46Pr+T61HcxCsg7BFBy4X/PSopTUb0kqRqJNDYs74IBO76OD4VQwcKyShxrqlqzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuN+22bN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A786C4CEF1;
	Thu, 25 Dec 2025 12:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766667018;
	bh=auK0WAIK1+aYoZs3CUmnhmvJRbjGC5SkGUKn/CV7p8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WuN+22bN6DpbeT0m3PNNCGTxbN10EsaX4YppmOInjYnWH/ryrCkdJ4OfBvOEOlMyT
	 rBlioQfOpPEm0hD4W5YU9HWC5gMQ9grLOkwwH72r6h84XSQE1PqegW9+GpDuaTLIcs
	 LJpQjV01o5PBGdOT7xbaJWO+FZfOYdh9fLW0tlNyiVTifFhMq2R5BBuKzTeqRvch7a
	 JliwLcGQ42e19OaPTWl+IeEtEREaSBDhhxN8CnQAlrHRqr7YIzAydTcHwo4QTGHCyx
	 yLCeDjz+29kwEMsdA42ZsPAKtrQq6pMFfsSz1XLksikETzgN4TwlLPjIADo2VM0Lm/
	 x6YnxhFqxRAfw==
Date: Thu, 25 Dec 2025 14:50:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Align struct rxe_sge and struct ib_sge
Message-ID: <20251225125014.GK11869@unreal>
References: <20251225071959.3037-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225071959.3037-1-yanjun.zhu@linux.dev>

On Thu, Dec 25, 2025 at 02:19:59AM -0500, Zhu Yanjun wrote:
> Replace struct ib_sge with struct rxe_sge in struct rxe_resp_info.
> No functional changes.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index fd48075810dd..f1f6dda22b70 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -222,7 +222,7 @@ struct rxe_resp_info {
>  	/* SRQ only */
>  	struct {
>  		struct rxe_recv_wqe	wqe;
> -		struct ib_sge		sge[RXE_MAX_SGE];
> +		struct rxe_sge		sge[RXE_MAX_SGE];

I would expect extra changes in addition to this one. For example, in
the SRQ code which allocates the WQE size. Maybe in other places too.

Thanks

>  	} srq_wqe;
>  
>  	/* Responder resources. It's a circular list where the oldest
> -- 
> 2.39.5
> 

