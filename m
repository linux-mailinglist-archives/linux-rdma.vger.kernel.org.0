Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F983A2AF1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 14:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJMCq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 08:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbhFJMCo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 08:02:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27D5C061574
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jun 2021 05:00:46 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id u24so32664552edy.11
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jun 2021 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcvJl6MCFxrWcO4K6w+mnKiRaj93inA4ZMAmvdNzmQk=;
        b=hEGq9CospTmaQDoOsSGxtwWM+rHJlPzUKU71pYWwsOMpQqXQ5LWBGmgjjU6dx3dQSA
         ui52pumyrzZ8gPOCtCgEWLMMWtPnnyWkZEP39GXeLm7D9qDPrSGFXsPS3pyjbXnanZkZ
         Z8lt4Ft9Qmyxq+uQW8Fz1xeL8fCkbdyxoPiCMGYgmlzhSq9oOFXDlKsFYGkdU/kdhsF8
         5GgI5+it9AszNbfZrSPlyaz6K3jnuyizwFIJZbPZjH2D2zeoRooFl47VrT2gHnCr6LPA
         YbjT89whtEnECSl2/91w5n3zoP7MxO6/0ouKTdfPMAo2+jw0rOskfYseSnM8XUzoVEE/
         ivfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcvJl6MCFxrWcO4K6w+mnKiRaj93inA4ZMAmvdNzmQk=;
        b=aFEQCcv4WthZFt+C/rJ0PPuULz+el4kECabznlRq8Rg1AP/uZtlN9fU621PNQ3moog
         46XHsoGpeDTAj6bAdVZgYFj/LXjyADsvKEgVZip2sTP+hoT6nP8ccErwawvC1htC3dt4
         LPuESppeQ3bQuOxNYeR+Dd6/jWRVJCrEBrNczr0kL6T82bOByLsLcO8MgYrQyLRf1Nce
         0KCdFVAkL7AdTkdBUJfSX2Jn8tmFjTMtzyPBL55CaTUjqcPzrweJ6pU8nsu0WroKcYjA
         ka7IhQ7MSz6x93xNxAT7SVB16jlnz2J/iMsrOBzqcvpD/3bocketrKtXl7pQioYy9dH0
         ZjYw==
X-Gm-Message-State: AOAM533Xwas1oApod8WOOY+18LLop9rscwItokJSboltNSgmVCy7Ko6E
        WFl2LieoHDcludcQLjvhWv/V9Qmwyj6AJylETlcVwg==
X-Google-Smtp-Source: ABdhPJwnRlgeAhszGJBkzZ9jNL8AGu4QMk+FAyZKaIsUOYUeozw4mVL/59Lah42M4MS9JbPFZlc0yjiIppOLzgk3ipM=
X-Received: by 2002:a05:6402:cb1:: with SMTP id cn17mr4362810edb.42.1623326445203;
 Thu, 10 Jun 2021 05:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210608103039.39080-1-jinpu.wang@ionos.com> <20210608103039.39080-4-jinpu.wang@ionos.com>
 <YMG99IVNqCK8OIVX@unreal> <CAMGffE=dUEnVrtYLy2xVYdm0Jb=JEnfBYvUB1ZZavx5a1BpnDA@mail.gmail.com>
 <YMH7zI0VZ4u1EfoJ@unreal>
In-Reply-To: <YMH7zI0VZ4u1EfoJ@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 10 Jun 2021 14:00:34 +0200
Message-ID: <CAMGffEnyLoOKcP0K2sy5ECiouLDdNjnquMQ=-YHMjpqVNJRkug@mail.gmail.com>
Subject: Re: [PATCH for-next 3/4] RDMA/rtrs: RDMA_RXE requires more number of WR
To:     Leon Romanovsky <leon@kernel.org>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Gioh Kim <gi-oh.kim@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 10, 2021 at 1:47 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jun 10, 2021 at 01:01:07PM +0200, Jinpu Wang wrote:
> > On Thu, Jun 10, 2021 at 9:23 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Tue, Jun 08, 2021 at 12:30:38PM +0200, Jack Wang wrote:
> > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > >
> > > > When using rdma_rxe, post_one_recv() returns
> > > > NOMEM error due to the full recv queue.
> > > > This patch increase the number of WR for receive queue
> > > > to support all devices.
> > >
> > > Why don't you query IB device to get max_qp_wr and set accordingly?
> > >
> > > Thanks
> > Hi Leon,
> >
> > We don't want to set the max_qp_wr, it will consume lots of memory.
> > this patch is only for service connection
> > used control messages.
>
> OK, so why don't you set min(your_define, max_qp_wr)?
>
> Thanks
Ok, will fix it.

Thx.
>
> >
> > For IO connection, we do query and max_qp_wr of the device, but still
> > we need to set the minimum to
> > reduce the memory consumption.
> >
> > Thanks! Regards
> > >
> > > >
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
> > > >  2 files changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > index cd53edddfe1f..acf0fde410c3 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > > @@ -1579,10 +1579,11 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
> > > >       lockdep_assert_held(&con->con_mutex);
> > > >       if (con->c.cid == 0) {
> > > >               /*
> > > > -              * One completion for each receive and two for each send
> > > > -              * (send request + registration)
> > > > +              * Two (request + registration) completion for send
> > > > +              * Two for recv if always_invalidate is set on server
> > > > +              * or one for recv.
> > > >                * + 2 for drain and heartbeat
> > > > -              * in case qp gets into error state
> > > > +              * in case qp gets into error state.
> > > >                */
> > > >               max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > > >               max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > index 04ec3080e9b5..bb73f7762a87 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -1656,7 +1656,7 @@ static int create_con(struct rtrs_srv_sess *sess,
> > > >                * + 2 for drain and heartbeat
> > > >                */
> > > >               max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > > > -             max_recv_wr = SERVICE_CON_QUEUE_DEPTH + 2;
> > > > +             max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > > >               cq_size = max_send_wr + max_recv_wr;
> > > >       } else {
> > > >               /*
> > > > --
> > > > 2.25.1
> > > >
