Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63570EFFFE
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Nov 2019 15:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfKEOh3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 09:37:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:51842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbfKEOh3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 09:37:29 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2268621928;
        Tue,  5 Nov 2019 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572964647;
        bh=jG7PU+kHK2Tigh7f3kzwXop6gRnAxGSL2gIY74vLEMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L9AohikAZ76GxVvwzEwtd7hlS3l/+Kryy4cLgbtYAwXRxbvxrJfS7LZMM+nlbfozK
         /BDi8KxpxmLIo4T5o+wdzZPr/LobOdCCBjW6c93enP3EXdyjC5JHGlioRQxphFBO3Q
         SnFHf5s70vWUrixPJqQuTxUJ80z6JaXBHMXSvwrE=
Date:   Tue, 5 Nov 2019 16:37:24 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     "Liuyixian (Eason)" <liuyixian@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Bugfix for flush cqe in case softirq
 and multi-process
Message-ID: <20191105143724.GD6763@unreal>
References: <f8f29a6a-b473-6c89-8ec7-092fd53aea16@huawei.com>
 <20190910075216.GX6601@unreal>
 <94ad1f56-afc6-ec78-4aa2-85d03c644031@huawei.com>
 <0d4ce391-6619-783d-55a8-fa2524af7b9c@huawei.com>
 <20190923050125.GK14368@unreal>
 <1224a3a0-50fb-dd6a-f22e-833e74ec77c3@huawei.com>
 <f1845894-a5c3-9630-15c2-6e1d806071e1@huawei.com>
 <20191015080036.GC6957@unreal>
 <ae1e81ba-cdd1-c1c5-a585-b0bfe9936000@huawei.com>
 <2a0ae88d-908f-df4b-11ea-26e639b7b338@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a0ae88d-908f-df4b-11ea-26e639b7b338@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 05, 2019 at 10:06:20AM +0800, Liuyixian (Eason) wrote:
>
>
> On 2019/10/28 17:34, Liuyixian (Eason) wrote:
> >
> >
> > On 2019/10/15 16:00, Leon Romanovsky wrote:
> >> On Sat, Oct 12, 2019 at 11:53:36AM +0800, Liuyixian (Eason) wrote:
> >>>
> >>>
> >>> On 2019/9/24 11:54, Liuyixian (Eason) wrote:
> >>>>
> >>>>
> >>>> On 2019/9/23 13:01, Leon Romanovsky wrote:
> >>>>> On Fri, Sep 20, 2019 at 11:55:56AM +0800, Liuyixian (Eason) wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2019/9/11 21:17, Liuyixian (Eason) wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 2019/9/10 15:52, Leon Romanovsky wrote:
> >>>>>>>> On Tue, Sep 10, 2019 at 02:40:20PM +0800, Liuyixian (Eason) wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 2019/9/8 16:03, Leon Romanovsky wrote:
> >>>>>>>>>> On Thu, Sep 05, 2019 at 08:31:11PM +0800, Weihang Li wrote:
> >>>>>>>>>>> From: Yixian Liu <liuyixian@huawei.com>
> >>>>>>>>>>>
> >>>>>>>>>>> Hip08 has the feature flush cqe, which help to flush wqe in workqueue
> >>>>>>>>>>> (sq and rq) when error happened by transmitting producer index with
> >>>>>>>>>>> mailbox to hardware. Flush cqe is emplemented in post send and recv
> >>>>>>>>>>> verbs. However, under NVMe cases, these verbs will be called under
> >>>>>>>>>>> softirq context, and it will lead to following calltrace with
> >>>>>>>>>>> current driver as mailbox used by flush cqe can go to sleep.
> >>>>>>>>>>>
> >>>>>>>>>>> This patch solves this problem by using workqueue to do flush cqe,
> >>>>>>>>>>
> >>>>>>>>>> Unbelievable, almost every bug in this driver is solved by introducing
> >>>>>>>>>> workqueue. You should fix "sleep in flush path" issue and not by adding
> >>>>>>>>>> new workqueue.
> >>>>>>>>>>
> >>>>>>>>> Hi Leon,
> >>>>>>>>>
> >>>>>>>>> Thanks for the comment.
> >>>>>>>>> Up to now, for hip08, only one place use workqueue in hns_roce_hw_v2.c
> >>>>>>>>> where for irq prints.
> >>>>>>>>
> >>>>>>>> Thanks to our lack of desire to add more workqueues and previous patches
> >>>>>>>> which removed extra workqueues from the driver.
> >>>>>>>>
> >>>>>>> Thanks, I see.
> >>>>>>>
> >>>>>>>>>
> >>>>>>>>> The solution for flush cqe in this patch is as follow:
> >>>>>>>>> While flush cqe should be implement, the driver should modify qp to error state
> >>>>>>>>> through mailbox with the newest product index of sq and rq, the hardware then
> >>>>>>>>> can flush all outstanding wqes in sq and rq.
> >>>>>>>>>
> >>>>>>>>> That's the whole mechanism of flush cqe, also is the flush path. We can't
> >>>>>>>>> change neither mailbox sleep attribute or flush cqe occurred in post send/recv.
> >>>>>>>>> To avoid the calltrace of flush cqe in post verbs under NVMe softirq,
> >>>>>>>>> use workqueue for flush cqe seems reasonable.
> >>>>>>>>>
> >>>>>>>>> As far as I know, there is no other alternative solution for this situation.
> >>>>>>>>> I will be very grateful if you reminder me more information.
> >>>>>>>>
> >>>>>>>> ib_drain_rq/ib_drain_sq/ib_drain_qp????
> >>>>>>>>
> >>>>>>> Hi Leon,
> >>>>>>>
> >>>>>>> I think these interfaces are designed for application to check that all wqes
> >>>>>>> have been processed by hardware, so called drain or flush. However, it is not
> >>>>>>> the same as the flush in this patch. The solution in this patch is used
> >>>>>>> to help the hardware generate flush cqes for outstanding wqes while qp error.
> >>>>>>>
> >>>>>> Hi Leon,
> >>>>>>
> >>>>>> What's your opinion about above? Do you have any further comments?
> >>>>>
> >>>>> My opinion didn't change, you need to read discussions about ib_drain_*()
> >>>>> functions, how and why they were introduced. It is a way to go.
> >>>>>
> >>>>> Thanks
> >>>>
> >>>> Hi Leon,
> >>>>
> >>>> Thanks a lot! I will dig those functions for my problem.
> >>>>
> >>>
> >>> Hi Leon,
> >>>
> >>> I have analysis the mechanism of ib_drain_(qp, sq, rq), that's okay to use
> >>> it instead of our flush cqe as both of them are calling modify qp to error
> >>> state in flush path.
> >>>
> >>> However, both ib_drain_* and flush cqe will face the same problem as declared
> >>> in previous emails, that is, in NVME case, post verbs will be called under
> >>> **softirq**, which will result to calltrace as mailbox used in modify qp
> >>> (flush path) can sleep, this is not allowed under softirq.
> >>>
> >>> Thus, to resolve above calltrace (sleep in softirq), using workqueue as in
> >>> this patch seems is a reasonable solution regardless of ib_drain_qp or
> >>> flush cqe is called in the workqueue.
> >>>
> >>> I think it is not a good idea to fix sleep in flush path (actually referred
> >>> to mailbox used in modify qp) as the mailbox is such a mature mechanism.
> >>
> >> No, it is not reasonable solution.
> >>
> >
> > Hi Leon,
> >
> >      I have explained this issue better in another patch set and pruned other logic.
> >      Thanks a lot for your review!
> >
> > Best regards.
> > Eason
> >
>
> Hi Doug and Loen,
>
> I just want to make sure that you know the above mentioned patch set is on:
> https://patchwork.kernel.org/project/linux-rdma/list/?series=194423
>
> Sorry to reply your last comment so late as I analyzed all possible solutions with
> your comment, and found that I haven't describe our problem clear enough and accurate,
> thus, I made this new patch set with simple logic and detailed commit message. I hope
> I have clearly explained this problem .

Hi,

I'm confident that Doug and/or Jason will review it very soon.

Thanks

>
> Thanks.
>
>
>
>
