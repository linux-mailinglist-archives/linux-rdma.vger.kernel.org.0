Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA3935C814
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238947AbhDLOBu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 10:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhDLOBu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Apr 2021 10:01:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D61C061574
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 07:01:32 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id e7so15188044edu.10
        for <linux-rdma@vger.kernel.org>; Mon, 12 Apr 2021 07:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGZgklZirKwKgGJLAF/lrnlmIrj9ObW+nIt06MhjI0g=;
        b=HjF6NAzyhYmue7yBDQuIO76N928VbrWD8S9IzzGZSicA3PdNN8oIJYjygo74bdoZMS
         V0L/Yt7/PUCST9fWtrc454C8XyiK37iLFcV3DHdIgiJVLf+2LgXP4fivSCUpGoJn00TI
         R+tq2NOuqkwA+ayfVJAmTPNX7YLzt7+xZ0c6POAl4ekey2ovNTPbGel5EbbGPOKfONTo
         l1Y6q1F/8Eu/h/ORxVSF1AUAB6/KoJePX+q0jto7U6N7APQpFcpRqSMtyveBtwq2DV8O
         WbZWtVEQBegKrF9aYo7HhFoU4oaBSzCE53fHLPAv9eMYbbF3cJ8GQGReMAxjCFBi0Mwd
         ruvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGZgklZirKwKgGJLAF/lrnlmIrj9ObW+nIt06MhjI0g=;
        b=YdwCfKNfJnAWz4dXFTWhoHELYEOypjAKs6mIfFdlBVQplfml/DW97XP+nhHaoDYhRY
         eUFq6eKw1wWVcQ+Qu/yfYiqS6kmbKxQkMvzuMfSUzWJP0SyxlsIrNv1Nlv6kUxoo0L4h
         aNtFGYthAR0IobKKG7tE4dTgnlcRGHpt6lyOnttKcLKfjA4a3J6fteHYY+ngaBi5zMIn
         6jgsmuDigmcT1j59TRp7qaHq37M7L0UkRB5U/USg6+EdtTVJjbnOo+xM1yIrN3X/f7yO
         6CmWjPX1VU7nUXCtKSvEnM7EyPmRiVxYz71FazxDj5AC+dwB9vXytyOFrbh74QhiXHEZ
         7DKQ==
X-Gm-Message-State: AOAM530VNlghVePYHxkWXpvySloCs2a1Wcub9FTNZafb4kvDa1ajQT48
        D5+WJYH+qDgg2divh5nWHcW3wvbEkZA7dCZn3VBLOg==
X-Google-Smtp-Source: ABdhPJwX6y5vUZigm0pCX8sfs/9CE7ZzQZi33lR0JXtlW3IO6gK5feMi796iyIdHQqd8VdQqFhQzq0hP+GBUm4UzetI=
X-Received: by 2002:a05:6402:1c04:: with SMTP id ck4mr29298457edb.74.1618236091109;
 Mon, 12 Apr 2021 07:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210406123639.202899-1-gi-oh.kim@ionos.com> <20210406123639.202899-2-gi-oh.kim@ionos.com>
 <YGxXD/TODlXHp2sK@unreal> <CAMGffE=oEGRqtxCOhzFp157K==i_JWFY3BMtbVN9YrOpuvo44A@mail.gmail.com>
 <YHQ/7MTKGD/UO4pW@unreal> <CAMGffEn8AYhtO8WF4sWjPu2uVgZDL4aRiT+sPjqtK6VaGsk3bQ@mail.gmail.com>
In-Reply-To: <CAMGffEn8AYhtO8WF4sWjPu2uVgZDL4aRiT+sPjqtK6VaGsk3bQ@mail.gmail.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Mon, 12 Apr 2021 16:00:55 +0200
Message-ID: <CAJX1YtZJ3sJy5fu_6v-sbqx3yLsPTh_SbvRQo9Yz1k48KxXpCA@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 1/3] RDMA/rtrs-clt: Print more info when an
 error happens
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 12, 2021 at 2:54 PM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>
> On Mon, Apr 12, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Apr 12, 2021 at 02:22:51PM +0200, Jinpu Wang wrote:
> > > On Tue, Apr 6, 2021 at 2:41 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > On Tue, Apr 06, 2021 at 02:36:37PM +0200, Gioh Kim wrote:
> > > > > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> > > > >
> > > > > Client prints only error value and it is not enough for debugging.
> > > > >
> > > > > 1. When client receives an error from server:
> > > > > the client does not only print the error value but also
> > > > > more information of server connection.
> > > > >
> > > > > 2. When client failes to send IO:
> > > > > the client gets an error from RDMA layer. It also
> > > > > print more information of server connection.
> > > > >
> > > > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > > ---
> > > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 33 ++++++++++++++++++++++----
> > > > >  1 file changed, 29 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > index 5062328ac577..a534b2b09e13 100644
> > > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > > @@ -437,6 +437,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> > > > >       req->in_use = false;
> > > > >       req->con = NULL;
> > > > >
> > > > > +     if (unlikely(errno)) {
> > > >
> > > > I'm sorry, but all your patches are full of these likely/unlikely cargo
> > > > cult. Can you please provide supportive performance data or delete all
> > > > likely/unlikely in all rtrs code?
> > >
> > > Hi Leon,
> > >
> > > All the likely/unlikely from the non-fast path was removed as you
> > > suggested in the past.
> > > This one is on IO path, my understanding is for the fast path, with
> > > likely/unlikely macro,
> > > the compiler will optimize the code for better branch prediction.
> >
> > In theory yes, in practice. gcc 10 generated same assembly code when I
> > placed likely() and replaced it with unlikely() later.

Even-thought gcc 10 generated the same assembly code,
there is no guarantee for gcc 11 or gcc 12.

I am reviewing rtrs source file and have found some unnecessary likely/unlikely.
But I think likely/unlikely are necessary for extreme cases.
I will have a discussion with my colleagues and inform you of the result.
