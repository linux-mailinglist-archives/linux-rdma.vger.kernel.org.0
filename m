Return-Path: <linux-rdma+bounces-14077-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C17C118FE
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 22:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BDC1A26E7A
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F171E32B981;
	Mon, 27 Oct 2025 21:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dmlgRp6o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E70A26C3A7
	for <linux-rdma@vger.kernel.org>; Mon, 27 Oct 2025 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761600571; cv=none; b=Z61w1lnA3SG6hAz33+hJ3t64lDxP4CtiUKmh0rfvV7rz0M9afS26uWiI4nyvJHqJbsMOD/XPdSEk2y5OnX2ZMn1tywT8b9BWpQ1BRRlQJPVT8s2pC6fTZzUAMyw3dsKuzmkgxFGvR2PzBP4pA81tJM0Jzihh1jIH/RMt6+v+ImE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761600571; c=relaxed/simple;
	bh=S3m+WXU90lLWlcDT0JwlTX6CNWdIh8kElpS1K11DAK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQbZAN5RpLjcXUssvzt95JyEZyLoK4hIE/fgdLs1GXfh3x7rk2hnMUediN0Ihd6CcXxyH1ZljJJRlt0ObJIkLUq5RrVHjuCsGD0aaCuEDovm/UDIM9muFyPk4EfSALWHmz1/EDvjlEOmq0367T1tLCaGIkO9aqIV9ldWfTlHjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dmlgRp6o; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <08fbf2f3-8f1d-41ed-9afa-79b187d7a483@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761600566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpqG6pkeO9OytR8HJSMGSYSoDtfHLQk2Ym7DNZ6M8hs=;
	b=dmlgRp6ond+czDaXBwi9Mx3IXdk1dKnQwTOwOD/GpV/XQqJFd1o7qm1gda3J9WC9m6wtzs
	gAe996lmuehAqC1k2+0U3V1UQM3dCsbz8s9SvrOZZaMCekmAtguh1GfnWtHZk/HMMQqVAA
	7acZ5fGEcCggmNTVxqBgqgGCRI0arnA=
Date: Mon, 27 Oct 2025 14:29:23 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Fix null deref on srq->rq.queue after
 resize failure
To: Leon Romanovsky <leon@kernel.org>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
 Liu Yi <asatsuyu.liu@gmail.com>
References: <20251027174306.254381-1-yanjun.zhu@linux.dev>
 <20251027200438.GP12554@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20251027200438.GP12554@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/27/25 1:04 PM, Leon Romanovsky wrote:
> On Mon, Oct 27, 2025 at 10:43:06AM -0700, Zhu Yanjun wrote:
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
>> Root cause:
>>     The queue is released when the first failure of rxe_cq_resize_queue.
>> Thus, when rxe_cq_resize_queue is called again, the above call trace
>> will occur.
>>
>> Fix:
>> Aligning the error handling path in rxe_srq_from_attr() with
>> rxe_cq_resize_queue(), which also uses rxe_queue_resize(): do not
>> nullify the queue when resize fails.
> 
> Did these two paragraphs come from AI? They don't add any new
> information, let's remove them.
> 
>>
>> Reported-by: Liu Yi <asatsuyu.liu@gmail.com>
>> Closes: https://paste.ubuntu.com/p/Zhj65q6gr9/
> 
> Link in "Closes" tag should point to report and not to some random
> place.
> 
>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>> Tested-by: Liu Yi <asatsuyu.liu@gmail.com>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_srq.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> It is second version of previously sent patch. Please add changelog.

OK. I will send the 3rd patch.

Yanjun.Zhu
> 
> Thanks


