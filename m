Return-Path: <linux-rdma+bounces-4952-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B30979697
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 14:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8E8282272
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Sep 2024 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15571C57B6;
	Sun, 15 Sep 2024 12:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YHuJKnXD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A9E13DDA7
	for <linux-rdma@vger.kernel.org>; Sun, 15 Sep 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726403251; cv=none; b=FCV4KAbVHyRKco45FNBP3t6I1WuZxUzGTXs8gQ7YQj82yiGibrgyncy1lqQ4h4UdKoOHK5bJlbrHfuCOn55COS4Tm2UOLTtHa835SN9GY7yzQ0W6VIKn8eMgV5eAyMkOXaQ+8yL+baxMgQH8TPXaLL/2K7q+345FDF8Eg2Bu768=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726403251; c=relaxed/simple;
	bh=Ce4h2HPfNlJIOTyFSvaETwrISLOcDgh1a7M9wOkfeXY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=p3lzD/PPCOjnZmT+wnzOpMIgylJm/L05O/ROSZRFRWHai7e7wQpu5JL+PjAuAr5aOTrSP/gwrmrkJx/HSG2i2jf8iV1Jwxeqt5FQlKo39g12Tb5iWwdpScbnSmpsAcvVS5wSONUf+bK5OAL1iTILSZORCsadGR+9XRvwZ+Jelvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YHuJKnXD; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db1b4d0c-9745-4c85-811d-15b33d4c9db0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726403245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRBIYsp7uqKcgL2OfS7qQ3ZoClBanyMKYnsJ9CqcqL8=;
	b=YHuJKnXD05m7g8hi65/vvbWucVhkVcWSaDXqT7ZmNUYAmOXuzmWtUaD6Vmn9KlRrIQi5ZN
	X5EfZ5htbA1JUwKDZXNJvUWTTQzhspyeIzW3zG+lDlvo/ejhZGS54dabtILKhnYxzM0aWT
	UUWXDWWPUdyuGjlgo15JvIXW/WH2cQ4=
Date: Sun, 15 Sep 2024 20:26:50 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Honggang LI <honggangli@163.com>, Greg Sword <gregsword0@gmail.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
 rpearsonhpe@gmail.com, linux-rdma@vger.kernel.org
References: <20240711014006.11294-1-honggangli@163.com>
 <CAEz=Lcvxr4LRhesrWdrodMn2JAG32RzOKTPd=wh470tvH_rG6w@mail.gmail.com>
 <Zo-DSIrjIGavnuTD@fc39> <5eafd503-0baa-48bb-ae4d-aa24b1e97c92@linux.dev>
In-Reply-To: <5eafd503-0baa-48bb-ae4d-aa24b1e97c92@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/7/12 7:25, Zhu Yanjun 写道:
> 在 2024/7/11 9:01, Honggang LI 写道:
>> On Thu, Jul 11, 2024 at 11:06:06AM +0800, Greg Sword wrote:
>>> Subject: Re: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
>>> From: Greg Sword <gregsword0@gmail.com>
>>> Date: Thu, 11 Jul 2024 11:06:06 +0800
>>>
>>> On Thu, Jul 11, 2024 at 9:41 AM Honggang LI <honggangli@163.com> wrote:
>>>>
>>>> If ib_req_notify_cq() was called in complete handler, deadlock occurs
>>>> in receive path.
>>>>
>>>> rxe_req_notify_cq+0x21/0x70 [rdma_rxe]
>>>> krping_cq_event_handler+0x26f/0x2c0 [rdma_krping]
>>>
>>> What is rdma_krping? What is the deadlock?
>>
>> https://github.com/larrystevenwise/krping.git
>>
>>> Please explain the deadlock in details.
>>
>>     88 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int 
>> solicited)
>>     89 {
>>     90         struct ib_event ev;
>>     91         int full;
>>     92         void *addr;
>>     93         unsigned long flags;
>>     94
>>     95         spin_lock_irqsave(&cq->cq_lock, flags); // Lock!
>>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>     96
>>     97         full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>>     98         if (unlikely(full)) {
>>     99                 rxe_err_cq(cq, "queue full\n");
>>    100 spin_unlock_irqrestore(&cq->cq_lock, flags);
>>    101                 if (cq->ibcq.event_handler) {
>>    102                         ev.device = cq->ibcq.device;
>>    103                         ev.element.cq = &cq->ibcq;
>>    104                         ev.event = IB_EVENT_CQ_ERR;
>>    105 cq->ibcq.event_handler(&ev, cq->ibcq.cq_context);
>>    106                 }
>>    107
>>    108                 return -EBUSY;
>>    109         }
>>    110
>>    111         addr = queue_producer_addr(cq->queue, 
>> QUEUE_TYPE_TO_CLIENT);
>>    112         memcpy(addr, cqe, sizeof(*cqe));
>>    113
>>    114         queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
>>    115
>>    116         if ((cq->notify & IB_CQ_NEXT_COMP) ||
>>    117             (cq->notify & IB_CQ_SOLICITED && solicited)) {
>>    118                 cq->notify = 0;
>>    119 cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>               call the complete handler krping_cq_event_handler()

Today I moved krping_cq_event_handler into a workqueue. And this krping 
can work well in SoftRoCE.

That is, I modifed the source code of krping and moved this 
krping_cq_event_handler into the system workqueue.

Then I run the krping tests on SoftRoCE. The krping tests work well on 
SoftRoCE.

Zhu Yanjun

>>    120         }
>>    121
>>    122         spin_unlock_irqrestore(&cq->cq_lock, flags);
>>
>>
>>
>> static void krping_cq_event_handler(struct ib_cq *cq, void *ctx)
>> {
>>          struct krping_cb *cb = ctx;
>>          struct ib_wc wc;
>>          const struct ib_recv_wr *bad_wr;
>>          int ret;
>>
>>          BUG_ON(cb->cq != cq);
>>          if (cb->state == ERROR) {
>>                  printk(KERN_ERR PFX "cq completion in ERROR state\n");
>>                  return;
>>          }
>>          if (cb->frtest) {
>>                  printk(KERN_ERR PFX "cq completion event in 
>> frtest!\n");
>>                  return;
>>          }
>>          if (!cb->wlat && !cb->rlat && !cb->bw)
>>                  ib_req_notify_cq(cb->cq, IB_CQ_NEXT_COMP) >         
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> IMO, here, we can use a BH workqueue to execute this notification? Or 
> add an event handler?
>
> Please reference other ULP kernel modules.
>
> Thanks,
> Zhu Yanjun
>
>>          while ((ret = ib_poll_cq(cb->cq, 1, &wc)) == 1) {
>>                  if (wc.status) {
>>
>> static int rxe_req_notify_cq(struct ib_cq *ibcq, enum 
>> ib_cq_notify_flags flags)
>> {
>>          struct rxe_cq *cq = to_rcq(ibcq);
>>          int ret = 0;
>>          int empty;
>>          unsigned long irq_flags;
>>
>>          spin_lock_irqsave(&cq->cq_lock, irq_flags);
>>     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Deadlock
>>
>
-- 
Best Regards,
Yanjun.Zhu


