Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC47F378EA8
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240789AbhEJNXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbhEJMSA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 08:18:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F16C06138B
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 05:16:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i9so16445525lfe.13
        for <linux-rdma@vger.kernel.org>; Mon, 10 May 2021 05:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6gOSHiD+UzD+cG7iL/76BOgqjhoiZTuyZgWkhCpF/w=;
        b=hvUex4YFYsl6a8imPcf2vlgCm+hQc26jFZ+0KimjUgookUMwM6+FNr8dOoCgNCh/3n
         +2xSAkgcLl4YX7OOwy+NPB0d+p+L2KkrcqtiqO3UioJroWjK8icTf+M3EUXC+KTDu6yc
         3TF5HDak/wIc/Mlt348Sq5Zvq85rd1kk2OOjokGVrfWLWq3tCbVfc40yQaBLp5wc9b8b
         7ZTAfrZGaZMm4j2ULva8C9IvIGV7Hbu64GvP+MkmcXZNTOFKLRk6iO8shLbliMHbosvZ
         i/UO4MXeUUI4TacKc3794A0bf+4qzdFoUL+/dVA/f/7hnwbcoxYvNc6x3z3bZ1yH47og
         D0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6gOSHiD+UzD+cG7iL/76BOgqjhoiZTuyZgWkhCpF/w=;
        b=JFxi58GX++RzLRwvEeP352AGcpCTwptXVwho2vwqn3yNIyAZHHlifCoLN1n7qerQLJ
         kmdMmPLGCUOo5DAOGtkxgVowC81A6QjZsCm3z7b87WGLReKI7KJO5WRivxVI7XkfMS9Z
         E7oFEgnKsiRaidNIhypEionQqpxJScesDvWhUZKF5Gb+TTL5tw0soJI1WdyGClAEt2pk
         lLW1P/A3pMXc/hNVF7+eeqJRswbctU9wE6urOP0QHj0HAsGPXXKLdk1tY/AosK+zkjQw
         eYZth4SL08v8wbcp7rNEMY97mwKYvwLnrJpPVRxj6coHDz81xylwKp4XQvagVeaAhR0B
         XFWg==
X-Gm-Message-State: AOAM532Btv65FGmXJYgAFpm5jRT3ApYBb2YMLY5QmBlnIK1UEF0Vgevr
        jw8saZtJqV6wRmo9BFjkRRyYie0QHH9BIHptyByfGQ==
X-Google-Smtp-Source: ABdhPJyP6kEr5FzJad73wkCxHrh9E3EK93rUjZi9zY9BZD4kzrgjIOA0HjtTUr1r67gUJvmPJA34Mt6DcN1R9B3VD64=
X-Received: by 2002:a19:df54:: with SMTP id q20mr17295921lfj.109.1620648972917;
 Mon, 10 May 2021 05:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210503114818.288896-1-gi-oh.kim@ionos.com> <20210503114818.288896-5-gi-oh.kim@ionos.com>
 <YJfHDvkc4BK7plTK@unreal> <CAJpMwygX36AhWH=_qCAPzcHh4BSLL6eA_1Tw0J6Sa25k9qg7Mw@mail.gmail.com>
 <YJkhIcw4xMfd9Dgm@unreal>
In-Reply-To: <YJkhIcw4xMfd9Dgm@unreal>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Mon, 10 May 2021 14:16:02 +0200
Message-ID: <CAJpMwyjhtNQ+k2NUa7iuDSde_XdG4fBSaxyOuB9jmur013F+1w@mail.gmail.com>
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

On Mon, May 10, 2021 at 2:03 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, May 10, 2021 at 12:55:42PM +0200, Haris Iqbal wrote:
> > On Sun, May 9, 2021 at 1:27 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Mon, May 03, 2021 at 01:48:02PM +0200, Gioh Kim wrote:
> > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > >
> > > > It was difficult to find out why it failed to establish RDMA
> > > > connection. This patch adds some messages to show which function
> > > > has failed why.
> > > >
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> > > > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > index 3d09d01e34b4..df17dd4c1e28 100644
> > > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > > @@ -1356,8 +1356,10 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > > >        * If this request is not the first connection request from the
> > > >        * client for this session then fail and return error.
> > > >        */
> > > > -     if (!first_conn)
> > > > +     if (!first_conn) {
> > > > +             pr_err("Error: Not the first connection request for this session\n");
> > > >               return ERR_PTR(-ENXIO);
> > > > +     }
> > > >
> > > >       /* need to allocate a new srv */
> > > >       srv = kzalloc(sizeof(*srv), GFP_KERNEL);
> > > > @@ -1812,6 +1814,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > > >       srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> > > >       if (IS_ERR(srv)) {
> > > >               err = PTR_ERR(srv);
> > > > +             pr_err("get_or_create_srv(), error %d\n", err);
> > > >               goto reject_w_err;
> > > >       }
> > > >       mutex_lock(&srv->paths_mutex);
> > > > @@ -1850,11 +1853,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > > >                       mutex_unlock(&srv->paths_mutex);
> > > >                       put_srv(srv);
> > > >                       err = PTR_ERR(sess);
> > > > +                     pr_err("RTRS server session allocation failed: %d\n", err);
> > > >                       goto reject_w_err;
> > > >               }
> > > >       }
> > > >       err = create_con(sess, cm_id, cid);
> > > >       if (err) {
> > > > +             rtrs_err((&sess->s), "create_con(), error %d\n", err);
> > > >               (void)rtrs_rdma_do_reject(cm_id, err);
> > >
> > > Unrelated to this change, but this (void) casting should be go.
> >
> > Hi Leon
> >
> > We wanted to explicitly signal that the code is ignoring the return
> > value of the function. Is there a strong reason for the casting to be
> > removed?
>
> "Don't write useless code and don't assume that the kernel developers
> are first year college students" - is this strong enough reason for you?

I am all for simple and minimum code; but this casting does have a
decent reason.

Anyway if the RDMA code style calls for this to be removed; will
remove them in a separate patch and send out with the next batch of
patches.

>
> Your (void) casting doesn't give anything extra, just churn and even
> more suspicious review over such code.
>
> Thanks
