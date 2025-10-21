Return-Path: <linux-rdma+bounces-13966-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC63BF8039
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 20:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E90B4080E8
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Oct 2025 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306EF35581F;
	Tue, 21 Oct 2025 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bkhPNNdz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CF1346E65
	for <linux-rdma@vger.kernel.org>; Tue, 21 Oct 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070041; cv=none; b=P5u2Kb4L1m/2PMa3/X4r0Wogp6hXkVwphpv/eqKtvJuhZTW2rQuaLoofHoilfWyhUEoH3yi8AiIpEJwUnLBhWqL7Zltvou+9zIyJnHFJR2p0aQojQyLR8fj4QRG6tW93IQnnj432PSeksn0WR8C5HgwTmrBzHZI8WfmRrJBm6XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070041; c=relaxed/simple;
	bh=wIC+/v6WIBNXrJXaUwY53IJCUxv+gMYg/LTYvVG7PCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcNWDOSi5/PtDjAQZiDrafy11rKA4qvPaJ+VdjxUZpk0kW8CFIX+s5MvFtMnKxGaepXKpr3FolhW6F6QBSZ1kR6FvttqHHHmEQDL23XyGmNyyMVC+KlvvajusqfO/mFlUBJ4O8nU/hrN0mrgi1IX01x9RBSKNZy3edyLEXVyrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bkhPNNdz; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <35b05f34-543b-4180-a18e-3ba4fbbd16b5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761070035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eivMlnTEpQdEK++a6Em9MLcXy6/3SwbeKxkmKvE1PYU=;
	b=bkhPNNdzpT6G1AhPKdfNarlvPxzvcTB7c/rhY/8S1U8d62gojgjhqySKib2xq2iIt6o1iv
	oCcg3otzzr8cK8RyD0HF+EhF0MFj4VmlrSUALbc1dW+/feCH75/HaZ6YnWBS8fHbgkbMO0
	gQ2uciQU2+KskUa57uAIbSimEH7Jouk=
Date: Tue, 21 Oct 2025 11:06:55 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: fix null deref on srq->rq.queue after resize
 failure
To: Junxian Huang <huangjunxian6@hisilicon.com>,
 Yi Liu <asatsuyu.liu@gmail.com>, linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>
References: <CANQ=Xi1JW2zFuYzNCw9Ft7WhseiHk4w1prYKmBc-Hbn1N32XNQ@mail.gmail.com>
 <91be3a58-c7e4-7250-9826-a8294386f2a0@hisilicon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <91be3a58-c7e4-7250-9826-a8294386f2a0@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/21/25 6:42 AM, Junxian Huang wrote:
> 
> 
> On 2025/10/21 10:20, Yi Liu wrote:
>> A NULL pointer dereference can occur in rxe_srq_chk_attr() when
>> ibv_modify_srq() is invoked twice in succession under certain error
>> conditions. The first call may fail in rxe_queue_resize(), which leads
>> rxe_srq_from_attr() to set srq->rq.queue = NULL. The second call then
>> triggers a crash (null deref) when accessing
>> srq->rq.queue->buf->index_mask.
>>
>> Call Trace:
>> <TASK>
>> rxe_modify_srq+0x170/0x480 [rdma_rxe]
>> ? __pfx_rxe_modify_srq+0x10/0x10 [rdma_rxe]
>> ? uverbs_try_lock_object+0x4f/0xa0 [ib_uverbs]
>> ? rdma_lookup_get_uobject+0x1f0/0x380 [ib_uverbs]
>> ib_uverbs_modify_srq+0x204/0x290 [ib_uverbs]
>> ? __pfx_ib_uverbs_modify_srq+0x10/0x10 [ib_uverbs]
>> ? tryinc_node_nr_active+0xe6/0x150
>> ? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
>> ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x2c0/0x470 [ib_uverbs]
>> ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
>> ? uverbs_fill_udata+0xed/0x4f0 [ib_uverbs]
>> ib_uverbs_run_method+0x55a/0x6e0 [ib_uverbs]
>> ? __pfx_ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x10/0x10 [ib_uverbs]
>> ib_uverbs_cmd_verbs+0x54d/0x800 [ib_uverbs]
>> ? __pfx_ib_uverbs_cmd_verbs+0x10/0x10 [ib_uverbs]
>> ? __pfx___raw_spin_lock_irqsave+0x10/0x10
>> ? __pfx_do_vfs_ioctl+0x10/0x10
>> ? ioctl_has_perm.constprop.0.isra.0+0x2c7/0x4c0
>> ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
>> ib_uverbs_ioctl+0x13e/0x220 [ib_uverbs]
>> ? __pfx_ib_uverbs_ioctl+0x10/0x10 [ib_uverbs]
>> __x64_sys_ioctl+0x138/0x1c0
>> do_syscall_64+0x82/0x250
>> ? fdget_pos+0x58/0x4c0
>> ? ksys_write+0xf3/0x1c0
>> ? __pfx_ksys_write+0x10/0x10
>> ? do_syscall_64+0xc8/0x250
>> ? __pfx_vm_mmap_pgoff+0x10/0x10
>> ? fget+0x173/0x230
>> ? fput+0x2a/0x80
>> ? ksys_mmap_pgoff+0x224/0x4c0
>> ? do_syscall_64+0xc8/0x250
>> ? do_user_addr_fault+0x37b/0xfe0
>> ? clear_bhb_loop+0x50/0xa0
>> ? clear_bhb_loop+0x50/0xa0
>> ? clear_bhb_loop+0x50/0xa0
>> entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fix by aligning the error handling path in rxe_srq_from_attr() with
>> rxe_cq_resize_queue(), which also uses rxe_queue_resize(): do not
>> nullify the queue when resize fails.
>>
>> Reported-by: Liu Yi <asatsuyu.liu@gmail.com>
>> Link: https://paste.ubuntu.com/p/Zhj65q6gr9/
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Tested-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> drivers/infiniband/sw/rxe/rxe_srq.c | 2 --
>> 1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c
>> b/drivers/infiniband/sw/rxe/rxe_srq.c
>> index 3661cb627d28..2764dc00e2f3 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_srq.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_srq.c
>> @@ -182,8 +182,6 @@ int rxe_srq_from_attr(struct rxe_dev *rxe, struct
>> rxe_srq *srq,
>> return 0;
>>
>> err_free:
>> - rxe_queue_cleanup(q);
>> - srq->rq.queue = NULL;
>> return err;
> 
> A minor suggestion, this err_free label doesn’t seem necessary any more.
> You can return directly at the place where you jump to err_free currently.

Thanks a lot. It might be better to return immediately when an error 
occurs, but keeping the current state unchanged could also be a valid 
option.

Best Regards,
Yanjun.Zhu

> 
> Junxian
> 
>> }
>>
>> --
>> 2.34.1
>>


