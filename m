Return-Path: <linux-rdma+bounces-13954-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 25250BF4896
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 05:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF170351A83
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 03:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF421D6193;
	Tue, 21 Oct 2025 03:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aviynrN0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC168F9D9
	for <linux-rdma@vger.kernel.org>; Tue, 21 Oct 2025 03:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018521; cv=none; b=RTA0i/cmtaNFemmO0nNuv0YJtFxaWBYswtEI1vzEbAIoGZeEamp9s5l+ye5NBGqqKJDlHisc0Zz+pst6Ep4xmNN6VfpmDWipJfVeV3ePeJ34dbFm1pp8CJwFelBnfx1DWDDMVhFB7H9YrnsIgiJ+kKcSoAyOl/Q+ObIqfyR3OJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018521; c=relaxed/simple;
	bh=WVDIvd1zuT7oEu/eKwsGtuxe0fQM5raoUXXO0GjQ6S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0LcZj2SFcUXSmUZP2nql9pNxLGvlCV1uY5jPvo71tGUWTBAgsLPctyD1+2Db3Njz/wTjeOGnLErtizmsk70Q5ceMwy2HKkO3RfgXGAVZTWSQ630TGuiH0ODuuMzuIMBpIGIq0d/afzTL/ltBOFhQoVpMo6tMBSUWIytDtgqptY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aviynrN0; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96e2ecce-35d7-4172-b401-5a0e612cbf71@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761018516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMXbS6es6g2JT35P/d1v3ATV7eTW/BgcRaDn81m5li8=;
	b=aviynrN0FLvfOWZwB1iUm3FcD+KCHRjmROQZWzHq9le2yEy0IHu8VRFmL8MV7MyUQzOUbE
	EY0vHa5CvtJi6zqmzgGltj+0DwQ4bOyuz7xYWKIF1QJKc0Uk4lttuUzJKIYZU0OTcxTGRa
	0TSBFVO46Tvg+rzGLmTgbSoIHZ8IZMA=
Date: Mon, 20 Oct 2025 20:48:25 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: fix null deref on srq->rq.queue after resize
 failure
To: Yi Liu <asatsuyu.liu@gmail.com>, linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
References: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/20 19:20, Yi Liu 写道:
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

Thanks a lot. You are the author of this commit.
Signed-off-by: Liu Yi <asatsuyu.liu@gmail.com>

Please Jason && Leon also comment on this commit.
Thanks a lot.

Yanjun.Zhu

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
> 
> --
> 2.34.1


