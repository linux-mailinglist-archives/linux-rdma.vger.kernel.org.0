Return-Path: <linux-rdma+bounces-3811-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680A092E0A5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 09:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9F5281674
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jul 2024 07:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376E484DEA;
	Thu, 11 Jul 2024 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hkEQxA3W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E38770E6
	for <linux-rdma@vger.kernel.org>; Thu, 11 Jul 2024 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682236; cv=none; b=pGuMoYOhsy7aAII5r1inlZnuL8Uytv36UbA7AwrVeLSj5p7C76+/B84WFbzQCH365NKjXQiHVhWs0a1IESFAnKvoUnKvxSt9czk+6DTGGqV1rLtNqlPOAwqNMENAg2yesgEVEa0E1sLB5TBtN2U2GagXYbP68hK/z9cV9eKKuOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682236; c=relaxed/simple;
	bh=7BojsyZhxct1U3JFi/Q2xiGBxmO7GLZvORpW4w9QZNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agWb+NQ+is2+imc3GthjtX0mhfK8WfifwBdF9NpH3c8f2T1itGNhl+FmvwSd6mFsd1oCt9K1JN9UPLIyjkdfi4/GjXBY5kxKU9omWLXQVjsiU+Pjv02AcqUJUk2HlrUP0WhMD21CczUj14RU9lQdKLAMDBvmG6BHeNTvTHAuYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hkEQxA3W; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=A9vh4ZRt5tnRgEEm6GPRBBgGjGW6zpq6uTuPIj+wURM=;
	b=hkEQxA3WM7m4tSVIWoyKef0oZlxYfgsSjzPMznRV2pGaf4/ftw87GU2usfaIav
	4nzrqvVacCuuJbmyDEwXA8WE03rM/CCpxdUqZSutfb4EyYE+QWM26cRDD2s/m+Pm
	Kiijk++qeZSJ3UgW4pKsdYNvwnmjTjl2jzX7YRThQNeZE=
Received: from localhost (unknown [125.33.20.250])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wDn97NIg49ma3QtBQ--.6504S2;
	Thu, 11 Jul 2024 15:01:29 +0800 (CST)
Date: Thu, 11 Jul 2024 15:01:28 +0800
From: Honggang LI <honggangli@163.com>
To: Greg Sword <gregsword0@gmail.com>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
	rpearsonhpe@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
Message-ID: <Zo-DSIrjIGavnuTD@fc39>
References: <20240711014006.11294-1-honggangli@163.com>
 <CAEz=Lcvxr4LRhesrWdrodMn2JAG32RzOKTPd=wh470tvH_rG6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEz=Lcvxr4LRhesrWdrodMn2JAG32RzOKTPd=wh470tvH_rG6w@mail.gmail.com>
X-CM-TRANSID:_____wDn97NIg49ma3QtBQ--.6504S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw4fKw17Ar43WrWfZFW8Zwb_yoW5XF4fpr
	WkJr98Gr4DXr1jgw4qg3W5Zry7Cry8GrWDGrs5trWrJayrWr13XFW5AryayFWrKrnrGr1q
	yw4DJF18Aw15AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPfHbUUUUU=
X-CM-SenderInfo: 5krqwwxdqjzxi6rwjhhfrp/xtbBDw0ZRWVOFJznDQAAsX

On Thu, Jul 11, 2024 at 11:06:06AM +0800, Greg Sword wrote:
> Subject: Re: [PATCH] RDMA/rxe: Restore tasklet call for rxe_cq.c
> From: Greg Sword <gregsword0@gmail.com>
> Date: Thu, 11 Jul 2024 11:06:06 +0800
> 
> On Thu, Jul 11, 2024 at 9:41 AM Honggang LI <honggangli@163.com> wrote:
> >
> > If ib_req_notify_cq() was called in complete handler, deadlock occurs
> > in receive path.
> >
> > rxe_req_notify_cq+0x21/0x70 [rdma_rxe]
> > krping_cq_event_handler+0x26f/0x2c0 [rdma_krping]
> 
> What is rdma_krping? What is the deadlock?

https://github.com/larrystevenwise/krping.git

> Please explain the deadlock in details.

   88 int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
   89 {
   90         struct ib_event ev;
   91         int full;
   92         void *addr;
   93         unsigned long flags;
   94 
   95         spin_lock_irqsave(&cq->cq_lock, flags);  // Lock!
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   96 
   97         full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
   98         if (unlikely(full)) {
   99                 rxe_err_cq(cq, "queue full\n");
  100                 spin_unlock_irqrestore(&cq->cq_lock, flags);
  101                 if (cq->ibcq.event_handler) {
  102                         ev.device = cq->ibcq.device;
  103                         ev.element.cq = &cq->ibcq;
  104                         ev.event = IB_EVENT_CQ_ERR;
  105                         cq->ibcq.event_handler(&ev, cq->ibcq.cq_context);
  106                 }
  107 
  108                 return -EBUSY;
  109         }
  110 
  111         addr = queue_producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
  112         memcpy(addr, cqe, sizeof(*cqe));
  113 
  114         queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
  115 
  116         if ((cq->notify & IB_CQ_NEXT_COMP) ||
  117             (cq->notify & IB_CQ_SOLICITED && solicited)) {
  118                 cq->notify = 0;
  119                 cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		      call the complete handler   krping_cq_event_handler()
  120         }
  121 
  122         spin_unlock_irqrestore(&cq->cq_lock, flags);



static void krping_cq_event_handler(struct ib_cq *cq, void *ctx)
{
        struct krping_cb *cb = ctx;
        struct ib_wc wc;
        const struct ib_recv_wr *bad_wr;
        int ret;

        BUG_ON(cb->cq != cq);
        if (cb->state == ERROR) {
                printk(KERN_ERR PFX "cq completion in ERROR state\n");
                return;
        }
        if (cb->frtest) {
                printk(KERN_ERR PFX "cq completion event in frtest!\n");
                return;
        }
        if (!cb->wlat && !cb->rlat && !cb->bw)
                ib_req_notify_cq(cb->cq, IB_CQ_NEXT_COMP);
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        while ((ret = ib_poll_cq(cb->cq, 1, &wc)) == 1) {
                if (wc.status) {

static int rxe_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags)
{
        struct rxe_cq *cq = to_rcq(ibcq);
        int ret = 0;
        int empty;
        unsigned long irq_flags;

        spin_lock_irqsave(&cq->cq_lock, irq_flags);
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Deadlock


