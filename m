Return-Path: <linux-rdma+bounces-14075-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC159C114CE
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 21:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67E0D35232A
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 20:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD4431D72E;
	Mon, 27 Oct 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbpaV0Wa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDCC31BCAE
	for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595484; cv=none; b=DUocNxcRTYRMTF118HKkjpKEMcP/fTdYMXTAfTp+9z7btwJ0cQlFc2T4Kw099ourqr/FemMd/LH86hq7ODDF5zM0BbPaQ+k4/CON9iYlytdJO1jOtJg7oeH2EhtMm9lXcSgdA9mvr2tgoJWDH9TCcvGHsKRnsbhDIl1y7x9GW7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595484; c=relaxed/simple;
	bh=5Tr0X6lSxSEUZErvOOuRUu37jg8MG3xnP+F0dsmSt+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiDVREwLZpEyFcQJLNDTWdRu5T9g8L8QCl9uhjEYSaXc5WYC5uST0XthYVx7gGAotdIqr8wlLzCz5bgNxhv2yWPYoM95Vv7U8ja3UZ4MUqW3A071xWbx0UjqxmjGdCVnJn9LRSIoax4LZW7FphMX2xTh41FUBGWiZO9E62z0VuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbpaV0Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713DDC4CEF1;
	Mon, 27 Oct 2025 20:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595483;
	bh=5Tr0X6lSxSEUZErvOOuRUu37jg8MG3xnP+F0dsmSt+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbpaV0Wa025JE2iyyw61+tzcacjt6kAEpD4jxR2ZgQxGzdF2m6er8OwCFNa7pnxSa
	 +OQfQGr6lX5JWa9qTGqwcsV48Aznx6qx7fxJ60SWRtES2veyUnZg0SLJMsxL4hqTnS
	 3OC2BQ/Sa0wboswU9Dh1i64AeohtSNmD7W1L/AO6dk7bpGmoPRx0vijfGOreMqDfjv
	 HvZdYonQbUxObIbH8AfydaN+UvtbmczGS6uRHxuaPX0iGHGnRYRQVeMHOE5v4Dyu/z
	 u0AjVzCoNYdJZzY+oP9fnhXlYPvhfxZK+zzFD4e5SdROMV2IDrNLShupl7H/uPZ3SU
	 K0+D56o8IE4Jw==
Date: Mon, 27 Oct 2025 22:04:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	Liu Yi <asatsuyu.liu@gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix null deref on srq->rq.queue after
 resize failure
Message-ID: <20251027200438.GP12554@unreal>
References: <20251027174306.254381-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027174306.254381-1-yanjun.zhu@linux.dev>

On Mon, Oct 27, 2025 at 10:43:06AM -0700, Zhu Yanjun wrote:
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
> Root cause: 
>    The queue is released when the first failure of rxe_cq_resize_queue.
> Thus, when rxe_cq_resize_queue is called again, the above call trace
> will occur.
> 
> Fix:
> Aligning the error handling path in rxe_srq_from_attr() with
> rxe_cq_resize_queue(), which also uses rxe_queue_resize(): do not
> nullify the queue when resize fails.

Did these two paragraphs come from AI? They don't add any new
information, let's remove them.

> 
> Reported-by: Liu Yi <asatsuyu.liu@gmail.com>
> Closes: https://paste.ubuntu.com/p/Zhj65q6gr9/

Link in "Closes" tag should point to report and not to some random
place.

> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Tested-by: Liu Yi <asatsuyu.liu@gmail.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_srq.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

It is second version of previously sent patch. Please add changelog.

Thanks

