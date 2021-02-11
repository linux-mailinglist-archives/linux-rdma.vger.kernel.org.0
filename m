Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB056318715
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Feb 2021 10:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhBKJ1d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Feb 2021 04:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBKJYr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Feb 2021 04:24:47 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D5C0613D6
        for <linux-rdma@vger.kernel.org>; Thu, 11 Feb 2021 01:24:06 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id t5so6166978eds.12
        for <linux-rdma@vger.kernel.org>; Thu, 11 Feb 2021 01:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdIoLPjtjHCF4QLJlHOhOHVI5Wmj61G/ZetVeVSckKQ=;
        b=JcEInpsxK3bfGp2TmICNWWqAnlUMd58feNOhehF9uKKEL82McmmiV8LwIHKCBZ2ran
         CT/at6Wqrw6mNarC80rHHHrqXEWob+USru2QoLSz5V15XgvV1awMWDw2gSprYvFSBByW
         WpjHNmAe1yjk36t1TuCgPQt2D+FubpaDKlC+XM/GWseFllTB+J+QHFSgOGGK2rEl5M5X
         lf8oBt1npdsTmTOKCegeb5jCuoMlQFpPnKldfg6u2DVbY/5DLQSHhxJ5Ysc5XDfDPG9j
         el44jj+TSaLQjVFIF0rlfynaXV2Ij5k20pRBOGCajF5/sHmR5rhBJeMkVJT6cSNHkkqh
         CLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdIoLPjtjHCF4QLJlHOhOHVI5Wmj61G/ZetVeVSckKQ=;
        b=Lclc3yj+jrHu9XViifhPFSpAkxD2vcQhDRQaVYTwLToHdr7rdj7BahV8QFcSRrvU9X
         cg1O0MNb56LrkZQD2UcgYmsOS5I/0CclvW8bt1fN0wURDWplKNSWg8gmjoERADZ8W370
         T2ShHqlmHY2r3wcLCiYdp07l25Mq7I/A++RegYBRkZciXic/gTNAvK6dLtgwx3SSyBLD
         qYt+1hJ0LJ2PS4LrFs0UrVrNXeP7g5l1Kf6dRaETx1mb3N3kP98QV2mUs0J9S7+xlopF
         ltjZVvRrOOCO7lJ6m4mtJivcPQ7kMxH2rjO0BOmsBzeg7lMLj21Nq8MW4ElwZrmtuVq4
         c8nw==
X-Gm-Message-State: AOAM5331bC9UCBbomHXUXLUHOQtBxipuRitTBliowyoiBmdohYhId0ov
        dh8PFZI4T2+DjNHVs0pWoECzIp//eJNo5LeM5Yl8Z6Dot6M=
X-Google-Smtp-Source: ABdhPJyDkUN3qheiZsm1vVBHo0pGs8lXkQZxubbqjbm3+e3ECfJS0l7NZ4hte16QFZTj7B9za6mSRDkJXjhr8TOE/OM=
X-Received: by 2002:a05:6402:54b:: with SMTP id i11mr7444025edx.262.1613035445062;
 Thu, 11 Feb 2021 01:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20210211065526.7510-1-jinpu.wang@cloud.ionos.com>
 <20210211065526.7510-3-jinpu.wang@cloud.ionos.com> <20210211084300.GB1275163@unreal>
In-Reply-To: <20210211084300.GB1275163@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 11 Feb 2021 10:23:54 +0100
Message-ID: <CAMGffEnxs4NXODsYKyXyRvfUUwyF+bX_XO7JfA_pyFSawwo-fQ@mail.gmail.com>
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

On Thu, Feb 11, 2021 at 9:43 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Feb 11, 2021 at 07:55:24AM +0100, Jack Wang wrote:
> > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > While adding a path from the client side to an already established
> > session, it was possible to provide the destination IP to a different
> > server. This is dangerous.
> >
> > This commit adds an extra member to the rtrs_msg_conn_req structure, named
> > first_conn; which is supposed to notify if the connection request is the
> > first for that session or not.
> >
> > On the server side, if a session does not exist but the first_conn
> > received inside the rtrs_msg_conn_req structure is 1, the connection
> > request is failed. This signifies that the connection request is for an
> > already existing session, and since the server did not find one, it is an
> > wrong connection request.
> >
> > Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
> > Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > Reviewed-by: Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c |  5 +++++
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
> >  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  4 +++-
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 21 ++++++++++++++++-----
> >  4 files changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 7644c3f627ca..a110e520b0a4 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -31,6 +31,8 @@
> >   */
> >  #define RTRS_RECONNECT_SEED 8
> >
> > +#define FIRST_CONN 0x01
> > +
> >  MODULE_DESCRIPTION("RDMA Transport Client");
> >  MODULE_LICENSE("GPL");
> >
> > @@ -1660,6 +1662,7 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
> >               .cid_num = cpu_to_le16(sess->s.con_num),
> >               .recon_cnt = cpu_to_le16(sess->s.recon_cnt),
> >       };
> > +     msg.first_conn = sess->for_new_clt ? (FIRST_CONN & 0xff) : 0;
>
> Why do you need this "&"? You can directly set FIRST_CONN.
you're right, will change.
>
> >       uuid_copy(&msg.sess_uuid, &sess->s.uuid);
> >       uuid_copy(&msg.paths_uuid, &clt->paths_uuid);
> >
> > @@ -2662,6 +2665,7 @@ struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
> >                       err = PTR_ERR(sess);
> >                       goto close_all_sess;
> >               }
> > +             sess->for_new_clt = true;
> >               list_add_tail_rcu(&sess->s.entry, &clt->paths_list);
> >
> >               err = init_sess(sess);
> > @@ -2913,6 +2917,7 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt *clt,
> >       if (IS_ERR(sess))
> >               return PTR_ERR(sess);
> >
> > +     sess->for_new_clt = false;
> >       /*
> >        * It is totally safe to add path in CONNECTING state: coming
> >        * IO will never grab it.  Also it is very important to add
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> > index a97a068c4c28..3f1a05373470 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> > @@ -143,6 +143,7 @@ struct rtrs_clt_sess {
> >       int                     max_send_sge;
> >       u32                     flags;
> >       struct kobject          kobj;
> > +     bool                    for_new_clt;
>
> Let's not add bool to structs.
ok, will change to u8.
>
> >       struct rtrs_clt_stats   *stats;
> >       /* cache hca_port and hca_name to display in sysfs */
> >       u8                      hca_port;
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > index d5621e6fad1b..8caad0a2322b 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > @@ -188,7 +188,9 @@ struct rtrs_msg_conn_req {
> >       __le16          recon_cnt;
> >       uuid_t          sess_uuid;
> >       uuid_t          paths_uuid;
> > -     u8              reserved[12];
> > +     u8              first_conn : 1;
> > +     u8              reserved_bits : 7;
> > +     u8              reserved[11];
> >  };
> >
> >  /**
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index e13e91c2a44a..2538a84fe5fc 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -1333,10 +1333,12 @@ static void free_srv(struct rtrs_srv *srv)
> >  }
> >
> >  static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> > -                                        const uuid_t *paths_uuid)
> > +                                       const uuid_t *paths_uuid,
> > +                                       bool first_conn)
> >  {
> >       struct rtrs_srv *srv;
> >       int i;
> > +     int err = -ENOMEM;
>
> You can avoid this "err" thing and return ERR or NULL directly and check
> IS_ERR_OR_NULL() later. Or you shouldn't overwrite an error after
> get_or_create_srv() call.
Sounds good, will change.

>
> >
> >       mutex_lock(&ctx->srv_mutex);
> >       list_for_each_entry(srv, &ctx->srv_list, ctx_list) {
> > @@ -1346,12 +1348,20 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> >                       return srv;
> >               }
> >       }
> > +     /*
> > +      * If this request is not the first connection request from the
> > +      * client for this session then fail and return error.
> > +      */
> > +     if (!first_conn) {
> > +             err = -ENXIO;
> > +             goto err;
> > +     }
>
> Are you sure that this check not racy?
I can't see how a function parameter check can be racy, can you elaborate?
>
> Thanks
Thanks for the review.!
>
> >
> >       /* need to allocate a new srv */
> >       srv = kzalloc(sizeof(*srv), GFP_KERNEL);
> >       if  (!srv) {
> >               mutex_unlock(&ctx->srv_mutex);
> > -             return NULL;
> > +             goto err;
> >       }
> >
> >       INIT_LIST_HEAD(&srv->paths_list);
> > @@ -1386,7 +1396,8 @@ static struct rtrs_srv *get_or_create_srv(struct rtrs_srv_ctx *ctx,
> >
> >  err_free_srv:
> >       kfree(srv);
> > -     return NULL;
> > +err:
> > +     return ERR_PTR(err);
> >  }
> >
> >  static void put_srv(struct rtrs_srv *srv)
> > @@ -1787,12 +1798,12 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> >               goto reject_w_econnreset;
> >       }
> >       recon_cnt = le16_to_cpu(msg->recon_cnt);
> > -     srv = get_or_create_srv(ctx, &msg->paths_uuid);
> > +     srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> >       /*
> >        * "refcount == 0" happens if a previous thread calls get_or_create_srv
> >        * allocate srv, but chunks of srv are not allocated yet.
> >        */
> > -     if (!srv || refcount_read(&srv->refcount) == 0) {
> > +     if (IS_ERR(srv) || refcount_read(&srv->refcount) == 0) {
> >               err = -ENOMEM;
> >               goto reject_w_err;
> >       }
> > --
> > 2.25.1
> >
