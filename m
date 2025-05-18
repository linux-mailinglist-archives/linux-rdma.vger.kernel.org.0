Return-Path: <linux-rdma+bounces-10390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB9EABAE1B
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 07:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662F8168C86
	for <lists+linux-rdma@lfdr.de>; Sun, 18 May 2025 05:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66FA43AB7;
	Sun, 18 May 2025 05:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRG9bfEg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6222CCC1;
	Sun, 18 May 2025 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747547650; cv=none; b=jLzDVIL5kKGOLeWmHqq5Cln5pEzMsTIrOTkJ3h2fOdiCJg087LWiD2UbB/cx5rwHc9AUZA/PGKsDN1/vArINP0VJwl9y7TjOXBa+QjiGeZx3rUTEpnwWrITw8kYb+qY+0NdkfBk1aLaU+qmPu/QbvvTiKJBTtMCHinqg6Q7OCtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747547650; c=relaxed/simple;
	bh=HKijH+l8r2JIjzcjY11uRVRuriWLr0tcYHUO52jPr4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZQaKlbyxojYaCFiasuWPUVDMoyp2AD/JGUjuGURbYtUk42uD3/J6oObFrB2GZDFQZFvRcm869brqkvJgWUEYpWPJKKthxLvlM9NxVCgfp/q8/5sd3NjeULOZVmynzsF+FVflblr9eUe+FpfXl44R/1+skzHpmnaF3GU5h8nF7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRG9bfEg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576C3C4CEE9;
	Sun, 18 May 2025 05:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747547649;
	bh=HKijH+l8r2JIjzcjY11uRVRuriWLr0tcYHUO52jPr4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRG9bfEgxdeCGqXi1BStiBxrBxyFC0juJXcmn5BXuPjpOTeuoIT36XmZ080UMnPp4
	 vgcGNzQXGte41aXvVYDkCb6JLzLeeJ04WOSh3VTNKsR3Do5W49tgcbvSN37GcOFaqo
	 43wptfjXsAoPiMWakEdbbqb1seq/ZIYFxLdvVaMS1kVRtJgjUy9gl0hpLOCkElzNza
	 v48ajgPE1U3S+DgBtf4ELhaWCKBZRfVxlEdYYgteJtFmNJHLpOICZmCtWcbyaaJluf
	 gWjcym3+nez7RpmvUEcyRoepGMHgMHNYPG9RZgLv6Vujx86GwmRS/dR8ilH4/mNv0b
	 5uwbOJd34ugag==
Date: Sun, 18 May 2025 08:54:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
	zyjzyj2000@gmail.com, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH for-next v3 2/2] RDMA/rxe: Enable asynchronous prefetch
 for ODP MRs
Message-ID: <20250518055405.GA7435@unreal>
References: <20250513050405.3456-1-dskmtsd@gmail.com>
 <20250513050405.3456-3-dskmtsd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513050405.3456-3-dskmtsd@gmail.com>

On Tue, May 13, 2025 at 05:04:05AM +0000, Daisuke Matsuda wrote:
> Calling ibv_advise_mr(3) with flags other than IBV_ADVISE_MR_FLAG_FLUSH
> invokes asynchronous request. It is best-effort, and thus can safely be
> deferred to the system-wide workqueue.
> 
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_odp.c | 84 ++++++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index 4c98a02d572c..0f3b281a265f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -425,6 +425,73 @@ enum resp_states rxe_odp_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>  	return RESPST_NONE;
>  }

<...>

> +static int rxe_init_prefetch_work(struct ib_pd *ibpd,
> +				  enum ib_uverbs_advise_mr_advice advice,
> +				  u32 pf_flags, struct prefetch_mr_work *work,
> +				  struct ib_sge *sg_list, u32 num_sge)

There is no need one-time called function. It can be embedded into rxe_ib_advise_mr_prefetch().

> +{

<...>

> @@ -475,6 +542,8 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>  				     u32 flags, struct ib_sge *sg_list, u32 num_sge)
>  {

<...>

> +	queue_work(system_unbound_wq, &work->work);

How do you ensure that this work isn't running after RXE is destroyed?

Thanks

> +
> +	return 0;
>  }
>  
>  int rxe_ib_advise_mr(struct ib_pd *ibpd,
> -- 
> 2.43.0
> 

