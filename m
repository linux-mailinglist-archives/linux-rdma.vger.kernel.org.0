Return-Path: <linux-rdma+bounces-14074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05116C0FDB7
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 19:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 252774FEA6D
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 18:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7902F316911;
	Mon, 27 Oct 2025 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qBJbYBOl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76226314D36
	for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588498; cv=none; b=un8SLle0SKkvCF9rx2H9DsDnuCNiCnKF0IZ4ct1x5KOwloFbAx9TV7IIGR9JfQvWg4d4LKRCkD8NNPh62AdGqQict9XSIlPbyd8Xj6cbph9CbVwEmCvo4qyeeLYaatK6Kpekb9bPMLKdr517vKxC3gceBQTXZzIwRWXgyUJp2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588498; c=relaxed/simple;
	bh=KCJqccZEYfr/KtuGoPZYCtW1Wc3s33epIv15R2m37gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nD4Sko7vLalKRn8kyh5MgH+KO42lQqAK0meK28fftUqyHjl0UcTxBMqD4XdgKylVsMnpxaXgM5XXeiS71f7huumcR+QxcoTIjEYWKYIS55OMlukmPr9LNcLm5PqeWO+RJtt86t5skUfsvSJgOZvm9GVJOBrtqx4Xl3OfDFTiAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qBJbYBOl; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <467b218f-9309-44bc-b3d1-bcf95a0610bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761588491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nREHhIDGZoJApWESD3lFDKt+tFOiDiqltoER8Tw9WV4=;
	b=qBJbYBOlluLlyfXtBqbhvEc8yMpwyfaLNEdfbEt96UsLH39ZZndMwgmJ0Ne2l4KvnKIlbh
	/ErdhwF+1yvmSembRUXtcdQkYk3XvQEvffippt/5vvFpvtAI8aYbmdZQ0MKt1Cts/E6k50
	WewV/KLIpMGUUlU1nhR6am+RcaLliUI=
Date: Mon, 27 Oct 2025 11:08:06 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix null deref on srq->rq.queue after
 resize failure
To: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: Liu Yi <asatsuyu.liu@gmail.com>
References: <20251027174306.254381-1-yanjun.zhu@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20251027174306.254381-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/27/25 10:43 AM, Zhu Yanjun wrote:
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
>     The queue is released when the first failure of rxe_cq_resize_queue.
> Thus, when rxe_cq_resize_queue is called again, the above call trace
> will occur.
> 
> Fix:
> Aligning the error handling path in rxe_srq_from_attr() with
> rxe_cq_resize_queue(), which also uses rxe_queue_resize(): do not
> nullify the queue when resize fails.

This commit is based on the repository 
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next.

Yanjun.Zhu

> 
> Reported-by: Liu Yi <asatsuyu.liu@gmail.com>
> Closes: https://paste.ubuntu.com/p/Zhj65q6gr9/
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Tested-by: Liu Yi <asatsuyu.liu@gmail.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   drivers/infiniband/sw/rxe/rxe_srq.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
> index 3661cb627d28..2a234f26ac10 100644
> --- a/drivers/infiniband/sw/rxe/rxe_srq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_srq.c
> @@ -171,7 +171,7 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
>   				       udata, mi, &srq->rq.producer_lock,
>   				       &srq->rq.consumer_lock);
>   		if (err)
> -			goto err_free;
> +			return err;
>   
>   		srq->rq.max_wr = attr->max_wr;
>   	}
> @@ -180,11 +180,6 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct rxe_srq *srq,
>   		srq->limit = attr->srq_limit;
>   
>   	return 0;
> -
> -err_free:
> -	rxe_queue_cleanup(q);
> -	srq->rq.queue = NULL;
> -	return err;
>   }
>   
>   void rxe_srq_cleanup(struct rxe_pool_elem *elem)


