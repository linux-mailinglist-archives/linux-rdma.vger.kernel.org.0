Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BF3318779
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 10:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhBKJx7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 04:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhBKJtm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 04:49:42 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DEAC061574
        for <linux-rdma@vger.kernel.org>; Thu, 11 Feb 2021 01:49:01 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id l25so9058541eja.9
        for <linux-rdma@vger.kernel.org>; Thu, 11 Feb 2021 01:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWEX9JbzoDP3/6H8H0ovx0SdlSmP9zTyYLpyVpGZQCU=;
        b=XzD7y4Ocqg0Na4Ui1qMz5IGGzgkdYgovM4y9X+JyMwhCxu7Tpjg5lvozELei6bYBP0
         E182/oKNNUyY27ZjY0aM30Sh4OxitlBOuOsqAVulCS2JFMm9VWH1+nAXvd7UVPprd5Eh
         rFvwKZYSs4JJ9NlvAzLXQB1r8pdEWOEhLSeAcvCd6jHsss3EskNB3N8BGRZOkqFEBhy4
         Yxqf3cvFpRWfmNzlJBxLN6taWj2BDp4P+g28mEQvSJK8eYeXixnbidbv9nyQbBxcD4rz
         I9oMLIIVWzUIxFNBedfjHcdOsNltPwDuqT2qgLVIu7MtTzB1QkWLIoZm3LnnkZnvNrQs
         ZyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWEX9JbzoDP3/6H8H0ovx0SdlSmP9zTyYLpyVpGZQCU=;
        b=qg1v91TCEKfibIVSzPMZQJGloZ2kdSTOFf5mIl7yIDsFkuuknpYk8TKdxpVgdjRu2E
         t/dSlyBL897zIAOu7s4h4AGjCXT9xcwgz1O6kuMhCHefTUmH6t0i9lrPD45+oXsaN2zn
         BPnJSuJjA7jI4sPwYSFdRqkax1qa+UhjEMw0YLvQR7SG9f61MoCSeN01IdesauawkJzG
         IL1Xx/9IdxtyNUnwIxzSKTQtkBSmk2YPkj/KpbMcLUdHgl1YDgx5huowbAjJTifi4LLK
         Fi2+5nC/4YRV6/ZuM+sqXrV/cdVAjh/YLbqyoOKkyBUFkxYlm+676mgsfK011gSfuIIE
         znug==
X-Gm-Message-State: AOAM532ZC8RpqPnvIYaHZrGYOa/J9fYvBTHfGb35JqVyTD3uegxT9ZAv
        B3p3Of7N77mmMsIrgv143r6fwdDGfn7seQHmhlwNzQ==
X-Google-Smtp-Source: ABdhPJwJppJ+dZh8+9JpmxPMYwk98kScdLL36hrnma7/KZTAHcE/O7Uu9tC6v8up2QkeGF4jUVxpsuop38VGrE/zELw=
X-Received: by 2002:a17:906:d93:: with SMTP id m19mr7580175eji.212.1613036939203;
 Thu, 11 Feb 2021 01:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
 <20210211065526.7510-3-jinpu.wang@cloud.ionos.com> <20210211084300.GB1275163@unreal>
 <CAMGffEnxs4NXODsYKyXyRvfUUwyF+bX_XO7JfA_pyFSawwo-fQ@mail.gmail.com> <20210211093658.GE1275163@unreal>
In-Reply-To: <20210211093658.GE1275163@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 11 Feb 2021 10:48:48 +0100
Message-ID: <CAMGffEkz=qpdgBNsds2cGArgKSBDEYdPcCaU95vop6zGoannbA@mail.gmail.com>
Subject: Re: [PATCH for-next 2/4] RDMA/rtrs: Only allow addition of path to an
 already established session
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 11, 2021 at 10:37 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Feb 11, 2021 at 10:23:54AM +0100, Jinpu Wang wrote:
> > On Thu, Feb 11, 2021 at 9:43 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Thu, Feb 11, 2021 at 07:55:24AM +0100, Jack Wang wrote:
> > > > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > >
> > > > While adding a path from the client side to an already established
> > > > session, it was possible to provide the destination IP to a different
> > > > server. This is dangerous.
> > > >
> > > > This commit adds an extra member to the rtrs_msg_conn_req structure, named
> > > > first_conn; which is supposed to notify if the connection request is the
> > > > first for that session or not.
> > > >
> > > > On the server side, if a session does not exist but the first_conn
> > > > received inside the rtrs_msg_conn_req structure is 1, the connection
> > > > request is failed. This signifies that the connection request is for an
> > > > already existing session, and since the server did not find one, it is an
> > > > wrong connection request.
> > > >
> > > > Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> > > > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > > > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > > > Reviewed-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> > > > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > > > ---
> > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c |  5 +++++
> > > >  drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
> > > >  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  4 +++-
> > > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 21 ++++++++++++++++-----
> > > >  4 files changed, 25 insertions(+), 6 deletions(-)
>
> <...>
>
> > > >
> > > >       mutex_lock(&ctx->srv_mutex);
> > > >       list_for_each_entry(srv, &ctx->srv_list, ctx_list) {
> > > > @@ -1346,12 +1348,20 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > > >                       return srv;
> > > >               }
> > > >       }
> > > > +     /*
> > > > +      * If this request is not the first connection request from the
> > > > +      * client for this session then fail and return error.
> > > > +      */
> > > > +     if (!first_conn) {
> > > > +             err = -ENXIO;
> > > > +             goto err;
> > > > +     }
> > >
> > > Are you sure that this check not racy?
> > I can't see how a function parameter check can be racy, can you elaborate?
>
> get_or_create_srv() itself is protected with mutex_lock, but it can be called
> in parallel by rtrs_rdma_connect(), this is why I asked.

I think again, still can't see how it could be racy.
Thanks!
>
> Thanks
>
> > >
> > > Thanks
> > Thanks for the review.!
> > >
> > > >
> > > >       /* need to allocate a new srv */
> > > >       srv = kzalloc(sizeof(*srv), GFP_KERNEL);
> > > >       if  (!srv) {
> > > >               mutex_unlock(&ctx->srv_mutex);
> > > > -             return NULL;
> > > > +             goto err;
> > > >       }
> > > >
> > > >       INIT_LIST_HEAD(&srv->paths_list);
> > > > @@ -1386,7 +1396,8 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > > >
> > > >  err_free_srv:
> > > >       kfree(srv);
> > > > -     return NULL;
> > > > +err:
> > > > +     return ERR_PTR(err);
> > > >  }
> > > >
> > > >  static void put_srv(struct rtrs_srv *srv)
> > > > @@ -1787,12 +1798,12 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > > >               goto reject_w_econnreset;
> > > >       }
> > > >       recon_cnt = le16_to_cpu(msg->recon_cnt);
> > > > -     srv = get_or_create_srv(ctx, &msg->paths_uuid);
> > > > +     srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> > > >       /*
> > > >        * "refcount == 0" happens if a previous thread calls get_or_create_srv
> > > >        * allocate srv, but chunks of srv are not allocated yet.
> > > >        */
> > > > -     if (!srv || refcount_read(&srv->refcount) == 0) {
> > > > +     if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
> > > >               err = -ENOMEM;
> > > >               goto reject_w_err;
> > > >       }
> > > > --
> > > > 2.25.1
> > > >
