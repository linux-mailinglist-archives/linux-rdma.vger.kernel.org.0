Return-Path: <linux-rdma+bounces-3824-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B6A92E9D5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89D41C23293
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6FE15ECFD;
	Thu, 11 Jul 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a2/o8lY3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700E15ECE6
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720705590; cv=none; b=qZBvhcoH/R3PTDlOd7bKMp+ythc3kHr5VOV2IrU59nEOy3kO7OJBkUmt9JpCB2mX3GCWe+M+VfEDwh7ZQOyW6dlGDxQEv9pEvWarWxfaeMDAExwdZLKX+++VN5DS38BUSqMKLFQkB6LlEp/daGou1LW/lrnuNCb3DHBIX7Muybs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720705590; c=relaxed/simple;
	bh=KdVLUreI8Kfa3MlDzyUKgiLIZzx1DF0YUKX8WwhGVMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4OZMpyixrYexrKLiV1LMMZc9hR16FqmlbJx5ugEFJvPQNvuy90zeNO2cRx5cDGYgx4EhDUFKG661x+iUsYgUyX6ySFcrJJc2UCSJqyA1h+7GzOHNtGZAfPffKHdvFtP3i5JfdAXa0gSN5SCIknJc3uq2Gtlu9zbMbRI9QE5/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a2/o8lY3; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: honggangli@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720705585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIJjDKjEnsDfrhYZxW4W9kBTakwxTw3O9HlxjEk1S+Q=;
	b=a2/o8lY3JF/E6MuLjPZEOcEDfp91pZvSasPdO3e3AeH5N3I4qt1O/WPx7Gf96p6Tm+ZEvO
	wpzR8Y7NTvGKHzRHhQYbzLqFuRJDP5ka9b8Hl7NeA0oJ79AoxINKSp1dfFRqVlPNtgsOB0
	zPmwxNk9To7fGAEIGosuxG0vlnp/zDg=
X-Envelope-To: gregsword0@gmail.com
X-Envelope-To: zyjzyj2000@gmail.com
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: leon@kernel.org
X-Envelope-To: rpearsonhpe@gmail.com
X-Envelope-To: linux-rdma@vger.kernel.org
Message-ID: <ebcebbc3-24c0-4a44-a08a-dc1ef2d1458b@linux.dev>
Date: Thu, 11 Jul 2024 15:46:24 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
To: Honggang LI <honggangli@163.com>, Greg Sword <gregsword0@gmail.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 rpearsonhpe@gmail.com, linux-rdma@vger.kernel.org
References: <20240711014006.11294-1-honggangli@163.com>
 <CAEz=Lcvxr4LRhesrWdrodMn2JAG32RzOKTPd=wh470tvH_rG6w@mail.gmail.com>
 <Zo-DSIrjIGavnuTD@fc39>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <Zo-DSIrjIGavnuTD@fc39>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/7/11 9:01, Honggang LI 写道:
> On Thu, Jul 11, 2024 at 11:06:06AM +0800, Greg Sword wrote:
>> Subject: Re: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
>> From: Greg Sword <gregsword0@gmail.com>
>> Date: Thu, 11 Jul 2024 11:06:06 +0800
>>
>> On Thu, Jul 11, 2024 at 9:41 AM Honggang LI <honggangli@163.com> wrote:
>>>
>>> If ib_req_notify_cq() was called in complete handler, deadlock occurs
>>> in receive path.
>>>
>>> rxe_req_notify_cq+0x21/0x70 [rdma_rxe]
>>> krping_cq_event_handler+0x26f/0x2c0 [rdma_krping]
>>
>> What is rdma_krping? What is the deadlock?
> 
> https://github.com/larrystevenwise/krping.git
> 
>> Please explain the deadlock in details.

I read the discussion carefully. I have the following:
1). This problem is not from RXE. It seems to be related with krping 
modules. As such, the root cause is not in RXE. It is not good to fix 
this problem in RXE.

2). In the kernel upstream, tasklet is marked obsolete and has some 
design flaws. So replacing workqueue with tasklet in RXE does not keep 
up with the kernel upstream.

https://patchwork.kernel.org/project/linux-rdma/cover/20240621050525.3720069-1-allen.lkml@gmail.com/
In this link, there are some work to replace tasklet with BH workqueue.
As such, it is not good to replace workqueue with tasklet.

 From the above, to now I can not agree with you. This is just my 2-cent 
suggestions.

I am not sure if others have better suggestions about this commit or not.

Zhu Yanjun
> 
>     88 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>     89 {
>     90         struct ib_event ev;
>     91         int full;
>     92         void *addr;
>     93         unsigned long flags;
>     94
>     95         spin_lock_irqsave(&cq->cq_lock, flags);  // Lock!
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>     96
>     97         full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>     98         if (unlikely(full)) {
>     99                 rxe_err_cq(cq, "queue full\n");
>    100                 spin_unlock_irqrestore(&cq->cq_lock, flags);
>    101                 if (cq->ibcq.event_handler) {
>    102                         ev.device = cq->ibcq.device;
>    103                         ev.element.cq = &cq->ibcq;
>    104                         ev.event = IB_EVENT_CQ_ERR;
>    105                         cq->ibcq.event_handler(&ev, cq->ibcq.cq_context);
>    106                 }
>    107
>    108                 return -EBUSY;
>    109         }
>    110
>    111         addr = queue_producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
>    112         memcpy(addr, cqe, sizeof(*cqe));
>    113
>    114         queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
>    115
>    116         if ((cq->notify & IB_CQ_NEXT_COMP) ||
>    117             (cq->notify & IB_CQ_SOLICITED && solicited)) {
>    118                 cq->notify = 0;
>    119                 cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
>                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 		      call the complete handler   krping_cq_event_handler()
>    120         }
>    121
>    122         spin_unlock_irqrestore(&cq->cq_lock, flags);
> 
> 
> 
> static void krping_cq_event_handler(struct ib_cq *cq, void *ctx)
> {
>          struct krping_cb *cb = ctx;
>          struct ib_wc wc;
>          const struct ib_recv_wr *bad_wr;
>          int ret;
> 
>          BUG_ON(cb->cq != cq);
>          if (cb->state == ERROR) {
>                  printk(KERN_ERR PFX "cq completion in ERROR state\n");
>                  return;
>          }
>          if (cb->frtest) {
>                  printk(KERN_ERR PFX "cq completion event in frtest!\n");
>                  return;
>          }
>          if (!cb->wlat && !cb->rlat && !cb->bw)
>                  ib_req_notify_cq(cb->cq, IB_CQ_NEXT_COMP);
> 		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          while ((ret = ib_poll_cq(cb->cq, 1, &wc)) == 1) {
>                  if (wc.status) {
> 
> static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
> {
>          struct rxe_cq *cq = to_rcq(ibcq);
>          int ret = 0;
>          int empty;
>          unsigned long irq_flags;
> 
>          spin_lock_irqsave(&cq->cq_lock, irq_flags);
> 	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Deadlock
> 


