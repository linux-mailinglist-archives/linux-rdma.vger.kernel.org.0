Return-Path: <linux-rdma+bounces-2751-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EC48D7442
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 10:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3091E1C20A2E
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2671D543;
	Sun,  2 Jun 2024 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT5yTiIg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAEC1CAA6
	for <linux-rdma@vger.kernel.org>; Sun,  2 Jun 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717316380; cv=none; b=h6oq1molaZd/r101ocZUscCOwy/ac3t6ZgxoKFEBMFz2xSjKpnd9HPfV8fTYiOp/5LT+wyZ+ybS+VABg2KELwnTqMWSrlokIJna5y+Xo0hvrhqlViAAC3is3S4cjr5dh+SFgTVgBCk5/f8hfIopgr2egBmHfLZ5T56lyFE071H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717316380; c=relaxed/simple;
	bh=fw7vZEUkP0roXDhN8/W5VJS4D7GNGUGCHJWCO+zC1K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeFZVL8OKsEMJRUn773TxTfqC55svHYbQz6CD7BjYVGKhXgyH5ISnmPzXGrY6nZ/lOib8QwKaAd1WNlZmt/KLEdhZhvdE5/KlnEtAcb2noP/2XqLukfOQFlsR9dknZ+76GHXfZvP2GgI8HOhtrPag1Vxy01t9hyADvczNwxA9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT5yTiIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEB6C2BBFC;
	Sun,  2 Jun 2024 08:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717316380;
	bh=fw7vZEUkP0roXDhN8/W5VJS4D7GNGUGCHJWCO+zC1K0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HT5yTiIgutNM4vgdRUv/29MheyHTayPZRgOXn+xJb8Rb0FiQAybOXHZqphlMKooQi
	 9GMn7bplO2oObwkWiFl+uj/LQZau+/iFHC1iALen0o3E12iIOOmoILKfzQJORsFPde
	 E6Jt3W/o4ybzPogHClThfJoBdxDj2/Lo66kzt3DH7YEQG5R9UacqQT37eVlRk2T9Eo
	 GulNzvSZrNHXrpWsDmMm+1azcoavmIvPE83MJqLOfKy+mnSN5t1HUBxcwElJ4nNNBB
	 V2N1CkJEZHAwVwm8oOn0E9vCNGBD0blO1Fzh8q23VMuBBtGAVvdeKT2vdcistE8Xw2
	 5oiAFNnTC1iPA==
Date: Sun, 2 Jun 2024 11:19:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
	Jason Gunthorpe <jgg@ziepe.ca>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>, Oren Duer <ooren@nvidia.com>
Subject: Re: [PATCH rfc] rdma/verbs: fix a possible uaf when draining a srq
 attached qp
Message-ID: <20240602081934.GJ3884@unreal>
References: <20240526083125.1454440-1-sagi@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526083125.1454440-1-sagi@grimberg.me>

On Sun, May 26, 2024 at 11:31:25AM +0300, Sagi Grimberg wrote:
> ib_drain_qp does not do drain a shared recv queue (because it is
> shared). However in the absence of any guarantees that the recv
> completions were consumed, the ulp can reference these completions
> after draining the qp and freeing its associated resources, which
> is a uaf [1].
> 
> We cannot drain a srq like a normal rq, however in ib_drain_qp
> once the qp moved to error state, we reap the recv_cq once in
> order to prevent consumption of recv completions after the drain.
> 
> [1]:
> --
> [199856.569999] Unable to handle kernel paging request at virtual address 002248778adfd6d0
> <....>
> [199856.721701] Workqueue: ib-comp-wq ib_cq_poll_work [ib_core]
> <....>
> [199856.827281] Call trace:
> [199856.829847]  nvmet_parse_admin_cmd+0x34/0x178 [nvmet]
> [199856.835007]  nvmet_req_init+0x2e0/0x378 [nvmet]
> [199856.839640]  nvmet_rdma_handle_command+0xa4/0x2e8 [nvmet_rdma]
> [199856.845575]  nvmet_rdma_recv_done+0xcc/0x240 [nvmet_rdma]
> [199856.851109]  __ib_process_cq+0x84/0xf0 [ib_core]
> [199856.855858]  ib_cq_poll_work+0x34/0xa0 [ib_core]
> [199856.860587]  process_one_work+0x1ec/0x4a0
> [199856.864694]  worker_thread+0x48/0x490
> [199856.868453]  kthread+0x158/0x160
> [199856.871779]  ret_from_fork+0x10/0x18
> --
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Note this patch is not yet tested, but sending it for visibility and
> early feedback. While nothing prevents ib_drain_cq to process a cq
> directly (even if it has another context) I am not convinced if all
> the upper layers don't have any assumptions about a single context
> consuming the cq, even if it is while it is drained. It is also
> possible to to add ib_reap_cq that fences the cq poll context before
> reaping the cq, but this may have other side-effects.

Did you have a chance to test this patch?
I looked at the code and it seems to be correct change, but I also don't
know about all ULP assumptions.

Thanks

> 
> This crash was seen in the wild, and not easy to reproduce. I suspect
> that moving the nvmet_wq to be unbound expedited the teardown process
> exposing a possible uaf for srq attached qps (which nvmet-rdma has a
> mode of using).
> 
> 
>  drivers/infiniband/core/verbs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 94a7f3b0c71c..580e9019e96a 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -2962,6 +2962,17 @@ void ib_drain_qp(struct ib_qp *qp)
>  	ib_drain_sq(qp);
>  	if (!qp->srq)
>  		ib_drain_rq(qp);
> +	else {
> +		/*
> +		 * We cannot drain a srq, however the qp is in error state,
> +		 * and will not generate new recv completions, hence it should
> +		 * be enough to reap the recv cq to cleanup any recv completions
> +		 * that may have placed before we drained. Without this nothing
> +		 * guarantees that the ulp will free resources and only then
> +		 * consume the recv completion.
> +		 */
> +		ib_process_cq_direct(qp->recv_cq, -1);
> +	}
>  }
>  EXPORT_SYMBOL(ib_drain_qp);
>  
> -- 
> 2.40.1
> 
> 

