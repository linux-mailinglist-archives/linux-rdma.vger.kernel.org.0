Return-Path: <linux-rdma+bounces-14067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D07CAC0E0DD
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 14:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C32F34DF1F
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 13:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA3C2550AD;
	Mon, 27 Oct 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTleKIi+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC4D253B40
	for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571858; cv=none; b=TMsrRT5dU/XkXiJkBPCfOtcefXX836Mhe43X4KlPqkW9ub5wzJwgz50pzBGavX0/TscRPMFbb0u9xFIwooJRO8s+D5uQDqVEG3fpq5eeBNEC6EoyL2+o8FYzxcT1c3W8g+Co3GvP0bgxc76kyh0e01bfbrPrI49jicgPZXRaQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571858; c=relaxed/simple;
	bh=82sD9ds0a5e5pJWuGDP/Q5yUzmDxXYpQQFg67P7XJn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtaJkUyKpmzUn58U0EI+Y6MHUQpvAe3Aa244IOUJOmeDZJ//YHryZkZaNamuTF/bKq/XWa/MvNi4rxC3X6JhGGjUos3C5oVOQNB3F0cUj+7DNpj3UaUK+6NK4FCeOocDF2PXv4yyomTCSX+kT6EbqvuB5CEP9KkYINv8j8E4JgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTleKIi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D173EC4CEF1;
	Mon, 27 Oct 2025 13:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761571858;
	bh=82sD9ds0a5e5pJWuGDP/Q5yUzmDxXYpQQFg67P7XJn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTleKIi+yrJT/phZ7NLYoDHOhKsWcTpWaI5jn0pXik0mQknXoMpwqVbPvd6ztdOGO
	 qgrp7UuK2uMnsJ40/ki5KwldUOquDE3TPC+F2oWHQ4HO/pk2h632SLde5O4GJiLizU
	 CEljWqXVp/Wwjq/uUV/lN0rndWuTNMjP0kWRUVUySJpm31GhQEabom3/u0toEOqv4H
	 pjk1WaXffFmkkDvrXKjYYTo657KLsZNBTHyG34cCsx7DHDuLgwUJVKSfBFYSejMquF
	 CKslsLii3ibG5IIlZLKj5W4ojKdJdGwyubC3EarsvKqy0Wx3t5rTcs6Fixv/xQNmfc
	 rTPp3Y0Rh8SXQ==
Date: Mon, 27 Oct 2025 15:30:53 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Yi Liu <asatsuyu.liu@gmail.com>
Cc: linux-rdma@vger.kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/rxe: fix null deref on srq->rq.queue after resize
 failure
Message-ID: <20251027133053.GK12554@unreal>
References: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>

On Tue, Oct 21, 2025 at 10:20:26AM +0800, Yi Liu wrote:
> A NULL pointer dereference can occur in rxe_srq_chk_attr() when
> ibv_modify_srq() is invoked twice in succession under certain error
> conditions. The first call may fail in rxe_queue_resize(), which leads
> rxe_srq_from_attr() to set srq->rq.queue = NULL. The second call then
> triggers a crash (null deref) when accessing
> srq->rq.queue->buf->index_mask.
> 
> Call Trace:
> <TASK>
> rxe_modify_srq+0x170/0x480 [rdma_rxe]
> ? __pfx_rxe_modify_srq+0x10/0x10 [rdma_rxe]
> ? uverbs_try_lock_object+0x4f/0xa0 [ib_uverbs]
> ? rdma_lookup_get_uobject+0x1f0/0x380 [ib_uverbs]
> ib_uverbs_modify_srq+0x204/0x290 [ib_uverbs]
> ? __pfx_ib_uverbs_modify_srq+0x10/0x10 [ib_uverbs]
> ? tryinc_node_nr_active+0xe6/0x150
> ? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
> ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x2c0/0x470 [ib_uverbs]
> ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
> ? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
> ib_uverbs_run_method+0x55a/0x6e0 [ib_uverbs]
> ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
> ib_uverbs_cmd_verbs+0x54d/0x800 [ib_uverbs]
> ? __pfx_ib_uverbs_cmd_verbs+0x10/0x10 [ib_uverbs]
> ? __pfx___raw_spin_lock_irqsave+0x10/0x10
> ? __pfx_do_vfs_ioctl+0x10/0x10
> ? ioctl_has_perm.constprop.0.isra.0+0x2c7/0x4c0
> ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
> ib_uverbs_ioctl+0x13e/0x220 [ib_uverbs]
> ? __pfx_ib_uverbs_ioctl+0x10/0x10 [ib_uverbs]
> __x64_sys_ioctl+0x138/0x1c0
> do_syscall_64+0x82/0x250
> ? fdget_pos+0x58/0x4c0
> ? ksys_write+0xf3/0x1c0
> ? __pfx_ksys_write+0x10/0x10
> ? do_syscall_64+0xc8/0x250
> ? __pfx_vm_mmap_pgoff+0x10/0x10
> ? fget+0x173/0x230
> ? fput+0x2a/0x80
> ? ksys_mmap_pgoff+0x224/0x4c0
> ? do_syscall_64+0xc8/0x250
> ? do_user_addr_fault+0x37b/0xfe0
> ? clear_bhb_loop+0x50/0xa0
> ? clear_bhb_loop+0x50/0xa0
> ? clear_bhb_loop+0x50/0xa0
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fix by aligning the error handling path in rxe_srq_from_attr() with
> rxe_cq_resize_queue(), which also uses rxe_queue_resize(): do not
> nullify the queue when resize fails.
> 
> Reported-by: Liu Yi <asatsuyu.liu@gmail.com>
> Link: https://paste.ubuntu.com/p/Zhj65q6gr9/
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Tested-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> drivers/infiniband/sw/rxe/rxe_srq.c | 2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c
> b/drivers/infiniband/sw/rxe/rxe_srq.c
> index 3661cb627d28..2764dc00e2f3 100644
> --- a/drivers/infiniband/sw/rxe/rxe_srq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_srq.c
> @@ -182,8 +182,6 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct
> rxe_srq *srq,
> return 0;
> 
> err_free:
> - rxe_queue_cleanup(q);
> - srq->rq.queue = NULL;
> return err;
> }

This patch is badly formatted and doesn't apply.

Applying: RDMA/rxe: fix null deref on srq->rq.queue after resize failure
Patch failed at 0001 RDMA/rxe: fix null deref on srq->rq.queue after resize failure
error: git diff header lacks filename information when removing 1 leading pathname component (line 6)
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Press any key to continue...


> 
> --
> 2.34.1

