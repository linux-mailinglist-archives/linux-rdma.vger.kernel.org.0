Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19A710C350
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Nov 2019 05:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfK1E7d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Nov 2019 23:59:33 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44071 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1E7d (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Nov 2019 23:59:33 -0500
Received: by mail-vs1-f66.google.com with SMTP id p6so11494501vsj.11
        for <linux-rdma@vger.kernel.org>; Wed, 27 Nov 2019 20:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwai5oTW2bQ1eWRb873S9jfTQbd174poDORijQeYdKY=;
        b=aIKXM44PBPhTgm7lgE9RNKHHEgo8pZ58y+Lp7f5OALee/QSx+NmrfL7cdiuMRNDA+o
         8PcrnucWRguv5X7sDXOFOTkfumVTmesgrW9yt+OaoidD6gIJj6Nxoktr0EnJZ5twttHt
         VdpPKj+HmSjdEp9QRH2xjygdk3ozuuRXSyE7/PWmdcqTujYl2+EKAapY6E6EQ8bgVUWC
         ligIEpkcw/DonspK2o5fplNK0znS5FsPaaTqd73aKwzUUBKUljEqMbKtOio/kc2YRrJ6
         CWuRq+79y12XTP0gYf8VbK0zy27fm2T2+tluQ93Rlyo4/6Y+qFAEN0B3Dn9PbzzoOjUi
         lCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwai5oTW2bQ1eWRb873S9jfTQbd174poDORijQeYdKY=;
        b=hYgXTVeFoX6rzWG9SByjbJLA5u5kvN4j3DbfZ8QbROua2DPTLi3JlMsC8kqTg1IeOG
         Fybd76RN3KGYVn9R99gkPN1ouUpf2Nt1Zdfkyv4tk6cVu+AAQBYXJHnkyg+JsQTYqp0R
         xhXL37y5RC2Qjih8B2dOG7HvYZ7bvO0uEQK/6OX8Xa/3UxzsQ5/FydYwA863BX3bXfAc
         dVDLKUip3BchxyBWXoSj2N0S0v3yjV3lrhi52Oo1XNvETeIcEWqDv8wA7PrRgEsTD7eU
         +AtwL1dDz5ncdiHuX4OBSGL0lf1ieDZBbQUE18uA7JgXVm8PA3Q1HyPn/akWQwcoGBBW
         3w5w==
X-Gm-Message-State: APjAAAWXbYQ9LjkC4wUxo/6aB+kWCVAAPD9+3BC2mKG5Ej/7y8/SBtPA
        +OmPlf1F/irOUX3PLO5SO6l17uPbgqXxsEQjlPM=
X-Google-Smtp-Source: APXvYqwmA8LHcYkF9ECLswuFTHA9TIWEf/YjuznBoSPyEInQvrFT+dWVyB2CHEsLk1i/nb0OGINf2hB/yGnGbBERzpg=
X-Received: by 2002:a05:6102:1261:: with SMTP id q1mr15895080vsg.182.1574917170974;
 Wed, 27 Nov 2019 20:59:30 -0800 (PST)
MIME-Version: 1.0
References: <1574655875-3475-1-git-send-email-yanjun.zhu@oracle.com> <20191127200751.GB23284@ziepe.ca>
In-Reply-To: <20191127200751.GB23284@ziepe.ca>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 28 Nov 2019 13:06:51 +0800
Message-ID: <CAD=hENfecFwAzdor=H160OTQKfEWt1qHqJLLtQN2zb3R993_og@mail.gmail.com>
Subject: Re: [PATCHv2 1/1] RDMA/core: avoid kernel NULL pointer error
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Zhu Yanjun <yanjun.zhu@oracle.com>, dledford@redhat.com,
        michael.j.ruhl@intel.com, ira.weiny@intel.com, rostedt@goodmis.org,
        leon@kernel.org, kamalheib1@gmail.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 28, 2019 at 4:07 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Sun, Nov 24, 2019 at 11:24:35PM -0500, Zhu Yanjun wrote:
> > When the interface related with IB device is set to down/up over and
> > over again, the following call trace will pop out.
> > "
> >  Call Trace:
> >   [<ffffffffa039ff8d>] ib_mad_completion_handler+0x7d/0xa0 [ib_mad]
> >   [<ffffffff810a1a41>] process_one_work+0x151/0x4b0
> >   [<ffffffff810a1ec0>] worker_thread+0x120/0x480
> >   [<ffffffff810a709e>] kthread+0xce/0xf0
> >   [<ffffffff816e9962>] ret_from_fork+0x42/0x70
> >
> >  RIP  [<ffffffffa039f926>] ib_mad_recv_done_handler+0x26/0x610 [ib_mad]
> > "
> > From vmcore, we can find the following:
> > "
> > crash7lates> struct ib_mad_list_head ffff881fb3713400
> > struct ib_mad_list_head {
> >   list = {
> >     next = 0xffff881fb3713800,
> >     prev = 0xffff881fe01395c0
> >   },
> >   mad_queue = 0x0
> > }
> > "
> >
> > Before the call trace, a lot of ib_cancel_mad is sent to the sender.
> > So it is necessary to check mad_queue in struct ib_mad_list_head to avoid
> > "kernel NULL pointer" error.
> >
> > From the new customer report, when there is something wrong with IB HW/FW,
> > the above call trace will appear. It seems that bad IB HW/FW will cause
> > this problem.
> >
> > Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
> > V1->V2: Add new bug symptoms.
> >  drivers/infiniband/core/mad.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
> > index 9947d16..43f596c 100644
> > +++ b/drivers/infiniband/core/mad.c
> > @@ -2279,6 +2279,17 @@ static void ib_mad_recv_done(struct ib_cq *cq, struct ib_wc *wc)
> >               return;
> >       }
> >
> > +     if (unlikely(!mad_list->mad_queue)) {
> > +             /*
> > +              * When the interface related with IB device is set to down/up,
> > +              * a lot of ib_cancel_mad packets are sent to the sender. In
> > +              * sender, the mad packets are cancelled.  The receiver will
> > +              * find mad_queue NULL. If the receiver does not test mad_queue,
> > +              * the receiver will crash with "kernel NULL pointer" error.
> > +              */
> > +             return;
> > +     }
>
> I feel like this patch was sent already?
>
> It is not possible for mad_queue to be NULL here without another bug,
> so this can't be the right fix.
>
> This is because:
>
>                 mad_priv->header.mad_list.mad_queue = recv_queue;
>                 mad_priv->header.mad_list.cqe.done = ib_mad_recv_done;
>                 recv_wr.wr_cqe = &mad_priv->header.mad_list.cqe;
>
> And then we do
>
>         struct ib_mad_list_head *mad_list =
>                 container_of(wc->wr_cqe, struct ib_mad_list_head, cqe);
>
> So there is no point where the mad_list could be legimiately NULL'd
> before getting here, something else must be happening, you must figure
> out and describe how the NULL is happening.

Yes. From the kernel source code, this bug does not occur. But from
the bug symptoms, it is possible that this bug is caused by the HW/FW.
From the commit logs, in 2 scenarios,  this bug will occur. One is to
set IB interface down/up over and over again, the other is bad IB
device.
After the bad IB device is replaced, this bug did not appear again.

The reason that I sent this patch again is to let the developer
suspect the HW/FW when this bug occurs again. I can not check the
HW/FW since I can not access these IB devices and FW source code.

Just as a reminder, not to expect to merge this patch into mainline.

Zhu Yanjun

>
> Jason
