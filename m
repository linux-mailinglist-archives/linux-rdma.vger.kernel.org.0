Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9413789C8
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 13:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhEJLbj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 07:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbhEJLGD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 07:06:03 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704D4C061574
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 03:55:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w15so20222044ljo.10
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ds6mF6OY7Rorjeq2urEHkQxjNfm66R7NIc5SQcAKQDw=;
        b=VSciqoDZM+4RO+6aCl7U78XN6ufJNqc9r36+12sx6inno0VgM4lfc4b1xmv++Veczv
         1TZ2vhWQtETcB1fw1oSeDlfse5WaIpA2oOh4jwuQDITJ7BFwXYql92g5Zq/KAV1TI7WO
         Z2vdHAKxu1YetARDmKu9vXa8D0m9Fsi0sHTffXv2osvf1NTQ0eyB41uN9gLnwA5gSYPm
         e8qVwjQrOaQ6aGc+m5QHIry+PZ6Sp9EC4zuVLCeHfe6VRB+zbbO92wSEmpaTHRm7FPxe
         VETW3aVxpbufwxGwfe0qwSXK2/pf7n4n0nQ75yu++mrwSKR9q+c067JqpGsr7Xdcxowf
         F/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ds6mF6OY7Rorjeq2urEHkQxjNfm66R7NIc5SQcAKQDw=;
        b=Pkg1Z3lPavmoMKhgHzUY0mLSoV7/AREANabNy2iF3D0n033MSDnNuCH51ZHvfXcFcW
         gETc7VeSxQ4PXDGKtoEKF1Swpo6xl1Y2VidQpwisZWGRBygTx6f1S29XdQL+3SKyU9tx
         /FK5DJy6pXeqPTO0MQlnJzYYWNNBHcMw8xcTHWVCSOEIJxMxAbLMOZwdR1AUa5tkvviX
         FP35tdlL92ZzoC39hJunbwtwxmAWYNrrnclVWc+gTSfrx8pEdQbSN0Dzm8IXB1kCmdmI
         JHzo4ImUjhlcmwOF9skLSuFY990nFKIOdnImEzqXpbXO0QlZ1uDWxGq4hT/gcSSdHxcH
         hLiA==
X-Gm-Message-State: AOAM532PhHE4a6oaRgt5T64vCQq1OpzO0xH1KdhYgwIJ7/h0LjVlXbO/
        BvBOFz4q3MtWYXnM0hACBpmfy3a2X5wF/st83CNfSA==
X-Google-Smtp-Source: ABdhPJxFftBGLDh3qRn32uflYXAxBkiUtF4/Swq/KXk16uGWlgmkOpCxxargBInvC0R0/GJtUI3ilCGK/XxjyC4zo5Q=
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr11742174ljn.489.1620644152937;
 Mon, 10 May 2021 03:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210503114818.288896-1-gi-oh.kim@ionos.com> <20210503114818.288896-5-gi-oh.kim@ionos.com>
 <YJfHDvkc4BK7plTK@unreal>
In-Reply-To: <YJfHDvkc4BK7plTK@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 10 May 2021 12:55:42 +0200
Message-ID: <CAJpMwygX36AhWH=_qCAPzcHh4BSLL6eA_1Tw0J6Sa25k9qg7Mw@mail.gmail.com>
Subject: Re: [PATCH for-next 04/20] RDMA/rtrs-srv: Add error messages for
 cases when failing RDMA connection
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 9, 2021 at 1:27 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 03, 2021 at 01:48:02PM +0200, Gioh Kim wrote:
> > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > It was difficult to find out why it failed to establish RDMA
> > connection. This patch adds some messages to show which function
> > has failed why.
> >
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index 3d09d01e34b4..df17dd4c1e28 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> >        * If this request is not the first connection request from the
> >        * client for this session then fail and return error.
> >        */
> > -     if (!first_conn)
> > +     if (!first_conn) {
> > +             pr_err("Error: Not the first connection request for this session\n");
> >               return ERR_PTR(-ENXIO);
> > +     }
> >
> >       /* need to allocate a new srv */
> >       srv = kzalloc(sizeof(*srv), GFP_KERNEL);
> > @@ -1812,6 +1814,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> >       srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> >       if (IS_ERR(srv)) {
> >               err = PTR_ERR(srv);
> > +             pr_err("get_or_create_srv(), error %d\n", err);
> >               goto reject_w_err;
> >       }
> >       mutex_lock(&srv->paths_mutex);
> > @@ -1850,11 +1853,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> >                       mutex_unlock(&srv->paths_mutex);
> >                       put_srv(srv);
> >                       err = PTR_ERR(sess);
> > +                     pr_err("RTRS server session allocation failed: %d\n", err);
> >                       goto reject_w_err;
> >               }
> >       }
> >       err = create_con(sess, cm_id, cid);
> >       if (err) {
> > +             rtrs_err((&sess->s), "create_con(), error %d\n", err);
> >               (void)rtrs_rdma_do_reject(cm_id, err);
>
> Unrelated to this change, but this (void) casting should be go.

Hi Leon

We wanted to explicitly signal that the code is ignoring the return
value of the function. Is there a strong reason for the casting to be
removed?

>
> Thanks
>
> >               /*
> >                * Since session has other connections we follow normal way
> > @@ -1865,6 +1870,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> >       }
> >       err = rtrs_rdma_do_accept(sess, cm_id);
> >       if (err) {
> > +             rtrs_err((&sess->s), "rtrs_rdma_do_accept(), error %d\n", err);
> >               (void)rtrs_rdma_do_reject(cm_id, err);
> >               /*
> >                * Since current connection was successfully added to the
> > --
> > 2.25.1
> >
