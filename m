Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA6D3A29B7
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 13:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFJLEQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Jun 2021 07:04:16 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:34781 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhFJLEP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Jun 2021 07:04:15 -0400
Received: by mail-ed1-f54.google.com with SMTP id cb9so32512747edb.1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Jun 2021 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Mf4HMbGwfvgArOWAB2VgZ2ESphtEylXG9ttYGGOkAA=;
        b=T0mf2kgY288i4NoGGWC35R6YltgjMAAB7aR6eaTtPtF4ZkRtFFgl/q5hi1REXDHy2H
         OFc+/RNqdYIWw7eioiVZVySXCGqtrILtbmlU+2I9wCLMagzSHUJs3YRlLbHXz5SMJAjM
         O4Fxa868mP+DjVHyG0pf1AxXdwbEz2uLU2TzdPWpMP+EuRwyxv+OqJNK6cOG24GEi4oI
         EwR86qKJ+ne/7uyrvKg6juTrwv3iiXCo33YQnuubXxM36FxLyqq8je746DXKn5NgscMG
         Gw5XFrAEgckC9kVz66BxfCarIZTbCNyH6wcrlfg8VZUwDuGjodn33etuq1/AfcGnE4r0
         tQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Mf4HMbGwfvgArOWAB2VgZ2ESphtEylXG9ttYGGOkAA=;
        b=QxfIChWnX20rDAJmH6SF5txHH5SM+LLoBVOnQawvvW0pHeAamT1o2kj9EP9TKPjSiJ
         8ePI3wb4bfZIjaG34aW3UR29PHF/Qy1lZmLrsXfzsbAxU/+CqSAuEl+b9SVKJPo1us+U
         lpmEi9xf9RmKfvgLKSvzUDDub8nScGdDiffXfODOWpZlJhQzMHsFuvU0jyjY+XS+QCUk
         SAyBjdjWW0nfBcdpKuh7XGX0kkSfwDztYRTTKFapsFgLbgTTUtQNAoi2TCjIv6UVDERT
         MzlU5uE0gfMaSEwPvgoEk3Cz8j/SYkLHjOcxRiD+V2DaYGMfy/TVhYJnXYtqk3/5OuT1
         5Muw==
X-Gm-Message-State: AOAM530khohur+9iQNYCAgJAqiPheA03Fm4tQWphyNixcBVrYKnbVDRs
        dDHlhWN5vH9Q9J3/pzCThPtsJEnLPnjk5DgKTL8a+A==
X-Google-Smtp-Source: ABdhPJxmEPaXNZQCvcNTUV2OsVwOvkiW9i28NPNeKZi/sHDdmqiA2lx2JaXTHUdM8m9z8QoobwNWeU++pAQOdwdC80M=
X-Received: by 2002:a05:6402:48f:: with SMTP id k15mr4014604edv.262.1623322878316;
 Thu, 10 Jun 2021 04:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210608103039.39080-1-jinpu.wang@ionos.com> <20210608103039.39080-4-jinpu.wang@ionos.com>
 <YMG99IVNqCK8OIVX@unreal>
In-Reply-To: <YMG99IVNqCK8OIVX@unreal>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 10 Jun 2021 13:01:07 +0200
Message-ID: <CAMGffE=dUEnVrtYLy2xVYdm0Jb=JEnfBYvUB1ZZavx5a1BpnDA@mail.gmail.com>
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

On Thu, Jun 10, 2021 at 9:23 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Tue, Jun 08, 2021 at 12:30:38PM +0200, Jack Wang wrote:
> > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > When using rdma_rxe, post_one_recv() returns
> > NOMEM error due to the full recv queue.
> > This patch increase the number of WR for receive queue
> > to support all devices.
>
> Why don't you query IB device to get max_qp_wr and set accordingly?
>
> Thanks
Hi Leon,

We don't want to set the max_qp_wr, it will consume lots of memory.
this patch is only for service connection
used control messages.

For IO connection, we do query and max_qp_wr of the device, but still
we need to set the minimum to
reduce the memory consumption.

Thanks! Regards
>
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 ++++---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 2 +-
> >  2 files changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index cd53edddfe1f..acf0fde410c3 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -1579,10 +1579,11 @@ static int create_con_cq_qp(struct rtrs_clt_con *con)
> >       lockdep_assert_held(&con->con_mutex);
> >       if (con->c.cid == 0) {
> >               /*
> > -              * One completion for each receive and two for each send
> > -              * (send request + registration)
> > +              * Two (request + registration) completion for send
> > +              * Two for recv if always_invalidate is set on server
> > +              * or one for recv.
> >                * + 2 for drain and heartbeat
> > -              * in case qp gets into error state
> > +              * in case qp gets into error state.
> >                */
> >               max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> >               max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index 04ec3080e9b5..bb73f7762a87 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1656,7 +1656,7 @@ static int create_con(struct rtrs_srv_sess *sess,
> >                * + 2 for drain and heartbeat
> >                */
> >               max_send_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> > -             max_recv_wr = SERVICE_CON_QUEUE_DEPTH + 2;
> > +             max_recv_wr = SERVICE_CON_QUEUE_DEPTH * 2 + 2;
> >               cq_size = max_send_wr + max_recv_wr;
> >       } else {
> >               /*
> > --
> > 2.25.1
> >
