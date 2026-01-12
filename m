Return-Path: <linux-rdma+bounces-15441-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8773CD10FA6
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 08:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18270301F3C5
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 07:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291873382F1;
	Mon, 12 Jan 2026 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrF2oNEL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC030E0C8;
	Mon, 12 Jan 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204361; cv=none; b=TBFlgCplS9m8CSxdk+/5AWJHMIlRpkBHf3JU9+pj4JP6DlEJbAjHH+WZTCgkC6rSzc+FaIHpXn84VzdqDBwN62cxgb5avT7PdBvXET3WO7fpuA1PUvPDrLr5avNxYAAHPFANwN6o7OdWcK8/X6KVLvmqSmRNT2Natsag2S1GsLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204361; c=relaxed/simple;
	bh=JEC7pphw0qokqSp892LJCerrq8WA4pGMUmDcKri+ihs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADuQDns7AOj7qOg06aQyn+vAO2pLXWuVedVOLiz2DhXrY+vmx0N0B7hK7fCMY0CpnVTCOGocMBkqi3AKffzfpTOGkAn/nFLxipGyz062WsrOMDg01/PbL19yeqXZVf0qZoKarpOcg5zOh9kcEhuySoIV1paeV/NHpHC2l2stnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrF2oNEL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DD1C116D0;
	Mon, 12 Jan 2026 07:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768204360;
	bh=JEC7pphw0qokqSp892LJCerrq8WA4pGMUmDcKri+ihs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrF2oNELgFMTrp+Qkyr4G6HiPJ+A6St6I5lC9PmkgeJHlhfXhSr5NFibC4Hr008+c
	 TDA3j+Ipya07dlMSi1cT01rhOLFaVM6nlYLnip5qEomL8MiFPPGCJA1Sm3kqCPAY5L
	 ECS5cSlD+xpuogERcrQZtAdpaZcl1mbrfdJ+fkTotRe3upKNsEya+drjvws8BTf6zB
	 Zkmktd/utMox5+5FE60RGYeZWaVyHVxoAv84gk8gac95+JZ7cHqaUZ1MBzEU7QAU4W
	 BOTmK+97XNLlVr5JweTlDJdPgnV9ciwtWa8kNJtq/gaFOJEYomv8gDXw9FA4qODb0n
	 mpASgL6/ttczg==
Date: Mon, 12 Jan 2026 09:52:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, shirazsaleem@microsoft.com,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: take CQ type from the device
 type
Message-ID: <20260112075233.GB14378@unreal>
References: <1767962250-2118-1-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1767962250-2118-1-git-send-email-kotaranov@linux.microsoft.com>

On Fri, Jan 09, 2026 at 04:37:30AM -0800, Konstantin Taranov wrote:
> From: Konstantin Taranov <kotaranov@microsoft.com>
> 
> Get CQ type from the used gdma device. The MANA_IB_CREATE_RNIC_CQ
> flag is ignored. It was used in older kernel versions where
> the mana_ib was shared between ethernet and rnic.
> 
> Fixes: d4293f96ce0b ("RDMA/mana_ib: unify mana_ib functions to support any gdma device")
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mana/cq.c b/drivers/infiniband/hw/mana/cq.c
> index 1becc8779..2dce1b677 100644
> --- a/drivers/infiniband/hw/mana/cq.c
> +++ b/drivers/infiniband/hw/mana/cq.c
> @@ -24,6 +24,7 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  
>  	cq->comp_vector = attr->comp_vector % ibdev->num_comp_vectors;
>  	cq->cq_handle = INVALID_MANA_HANDLE;
> +	is_rnic_cq = mana_ib_is_rnic(mdev);
>  
>  	if (udata) {
>  		if (udata->inlen < offsetof(struct mana_ib_create_cq, flags))
> @@ -35,8 +36,6 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  			return err;
>  		}
>  
> -		is_rnic_cq = !!(ucmd.flags & MANA_IB_CREATE_RNIC_CQ);

You need to add code which prohibits future use of this BIT(0) in ucmd.flags for backward compatibility
and maybe delete MANA_IB_CREATE_RNIC_CQ from UAPI too.

Thanks

> -
>  		if ((!is_rnic_cq && attr->cqe > mdev->adapter_caps.max_qp_wr) ||
>  		    attr->cqe > U32_MAX / COMP_ENTRY_SIZE) {
>  			ibdev_dbg(ibdev, "CQE %d exceeding limit\n", attr->cqe);
> @@ -55,7 +54,6 @@ int mana_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  							  ibucontext);
>  		doorbell = mana_ucontext->doorbell;
>  	} else {
> -		is_rnic_cq = true;
>  		buf_size = MANA_PAGE_ALIGN(roundup_pow_of_two(attr->cqe * COMP_ENTRY_SIZE));
>  		cq->cqe = buf_size / COMP_ENTRY_SIZE;
>  		err = mana_ib_create_kernel_queue(mdev, buf_size, GDMA_CQ, &cq->queue);
> -- 
> 2.43.0
> 

