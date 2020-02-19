Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566AB1638B5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2020 01:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgBSAuX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 19:50:23 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:47067 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBSAuX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 19:50:23 -0500
Received: by mail-vk1-f194.google.com with SMTP id u6so6107678vkn.13
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 16:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rRjCgPpAb/ScVsjhoSI/rmQoWuzPsTWkHq8r7G/t8vM=;
        b=CqwSFrLUcOjFDYkNOLzUqB+ScbUlN0Ar1UqTQVMjgj7a8mB9NPd6/nFxyTexj/kiiU
         yudZOXrKXRUFILdYM5D+YCKj63Z7lwp8YPuPgKdUDsmMvB7ksJsLzlG6WEabVgOoqTJk
         V8G6FPCqAX2M/tDYr6QKkSSbVJzqvMEuQ3Z39M5Lt4je2kqjs9EdOqlRuIisX3G+t5m+
         E4svqZjThNUK9nmug77QH0XNsLRO15pzjUwGjGwiNSKEFZ+3fv7XdfsNaV7Hv38m7duU
         i3gWWXfni6Pn1+63Izrj+YiTo2nXMV/hAov/xxAIzoJjC9ytiiA+UGlCAw5gcFELvGSf
         HwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRjCgPpAb/ScVsjhoSI/rmQoWuzPsTWkHq8r7G/t8vM=;
        b=abS6CJyc3C7XUQHHqGuwFD7KRnqhVAZPEvhIEjzzMSlxbgJTdQ4C8w2q9IdCLSdY+C
         EzqutUV1/2O1914nTOWAtpbeB/2tQFkdHGUIEqaL8R6bK6Momdx0qaBt5RfBHrBpdTzt
         uWIwh2kv7lkIcpy+DRExbQGqayJyVLBvzE4IcBFhmd8ADagyg4vgVdeZnVEuKeqzU55R
         eapsa4DHspYbG8OtFVDmP1oa4UAzFtgBTeRVdHNsY9IqONJ84yooS1nPw2IOvSDAmXaC
         YFtoXaYJdnc7AhKD2zfjabE8tbrY9oyPkCOveunf5ctTKMQSrKjJUyFeJFkm0Y0VyNZS
         onbw==
X-Gm-Message-State: APjAAAVz76ksQF9Nm8hgOa/5+/uCC1c+YUfwX4lSZsC+0EMjDK5TyLOp
        MJHRFkK2/uP1ce0WM4IrNB0URONLbLAig9X8pUg=
X-Google-Smtp-Source: APXvYqxUVaHrlwhIjbHEQtm9mIzaexuEkKvN2Z9rq8pphTGWJQof5A35hCE1E2amky/4SNma8QGe/6V9ZPwzvWzCixc=
X-Received: by 2002:a1f:6012:: with SMTP id u18mr9684591vkb.77.1582073421008;
 Tue, 18 Feb 2020 16:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20200217205714.26937-1-bvanassche@acm.org> <CAD=hENff-t-xCrYOnCFLMKYgKDodxEamm-Z++U4W202MprEWDg@mail.gmail.com>
 <20200218130942.GB3846@unreal>
In-Reply-To: <20200218130942.GB3846@unreal>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Wed, 19 Feb 2020 08:50:09 +0800
Message-ID: <CAD=hENfcwDYGwEKG+zz3S7C35y8wrcz=UEvL3WvTnHfZvTeJ-g@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix configuration of atomic queue pair attributes
To:     Leon Romanovsky <leonro@mellanox.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Thanks. I am fine with it.

On Tue, Feb 18, 2020 at 9:09 PM Leon Romanovsky <leonro@mellanox.com> wrote:
>
> On Tue, Feb 18, 2020 at 05:53:56PM +0800, Zhu Yanjun wrote:
> > Sorry, when max_rd_atomic will be set to 0?
>
> User can set it.
> ib_uverbs_ex_modify_qp()
>  -> modify_qp()
>   -> ib_modify_qp_with_udata()
>    -> _ib_modify_qp()
>     -> ib_security_modify_qp()
>      -> .modify_q()
>       -> rxe_modify_qp()
>        -> rxe_qp_from_attr()
>
> >
> > Thanks,
> > Zhu Yanjun
> >
> > On Tue, Feb 18, 2020 at 4:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > From the comment above the definition of the roundup_pow_of_two() macro:
> > >
> > >      The result is undefined when n == 0.
> > >
> > > Hence only pass positive values to roundup_pow_of_two(). This patch fixes
> > > the following UBSAN complaint:
> > >
> > > UBSAN: Undefined behaviour in ./include/linux/log2.h:57:13
> > > shift exponent 64 is too large for 64-bit type 'long unsigned int'
> > > Call Trace:
> > >  dump_stack+0xa5/0xe6
> > >  ubsan_epilogue+0x9/0x26
> > >  __ubsan_handle_shift_out_of_bounds.cold+0x4c/0xf9
> > >  rxe_qp_from_attr.cold+0x37/0x5d [rdma_rxe]
> > >  rxe_modify_qp+0x59/0x70 [rdma_rxe]
> > >  _ib_modify_qp+0x5aa/0x7c0 [ib_core]
> > >  ib_modify_qp+0x3b/0x50 [ib_core]
> > >  cma_modify_qp_rtr+0x234/0x260 [rdma_cm]
> > >  __rdma_accept+0x1a7/0x650 [rdma_cm]
> > >  nvmet_rdma_cm_handler+0x1286/0x14cd [nvmet_rdma]
> > >  cma_cm_event_handler+0x6b/0x330 [rdma_cm]
> > >  cma_ib_req_handler+0xe60/0x22d0 [rdma_cm]
> > >  cm_process_work+0x30/0x140 [ib_cm]
> > >  cm_req_handler+0x11f4/0x1cd0 [ib_cm]
> > >  cm_work_handler+0xb8/0x344e [ib_cm]
> > >  process_one_work+0x569/0xb60
> > >  worker_thread+0x7a/0x5d0
> > >  kthread+0x1e6/0x210
> > >  ret_from_fork+0x24/0x30
> > >
> > > Cc: Moni Shoua <monis@mellanox.com>
> > > Fixes: 8700e3e7c485 ("Soft RoCE driver")
> > > Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> > > ---
> > >  drivers/infiniband/sw/rxe/rxe_qp.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> > > index ec21f616ac98..6c11c3aeeca6 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> > > @@ -590,15 +590,16 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
> > >         int err;
> > >
> > >         if (mask & IB_QP_MAX_QP_RD_ATOMIC) {
> > > -               int max_rd_atomic = __roundup_pow_of_two(attr->max_rd_atomic);
> > > +               int max_rd_atomic = attr->max_rd_atomic ?
> > > +                       roundup_pow_of_two(attr->max_rd_atomic) : 0;
> > >
> > >                 qp->attr.max_rd_atomic = max_rd_atomic;
> > >                 atomic_set(&qp->req.rd_atomic, max_rd_atomic);
> > >         }
> > >
> > >         if (mask & IB_QP_MAX_DEST_RD_ATOMIC) {
> > > -               int max_dest_rd_atomic =
> > > -                       __roundup_pow_of_two(attr->max_dest_rd_atomic);
> > > +               int max_dest_rd_atomic = attr->max_dest_rd_atomic ?
> > > +                       roundup_pow_of_two(attr->max_dest_rd_atomic) : 0;
> > >
> > >                 qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
> > >
