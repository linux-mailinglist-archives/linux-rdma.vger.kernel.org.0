Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB69629505
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 10:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiKOJ6a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 04:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiKOJ61 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 04:58:27 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4998EB45
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 01:58:26 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h12so16810526ljg.9
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 01:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mr6Q8XoatHPPPeEgQ0gN+33bEpsZOGHpMy9/Y5mysus=;
        b=gK92YcvNIHT5FfKjR43Ae35ludx2Z5ADl2Gj4J3BOp23Ms/xFidDQEud4dMYm3nkqF
         CZoLGMyzMTW84G2oUM+fT3WZkyOReSglfBbExfaVqvJdzDTAEOBz1Idlk0DuyKRWJ2x1
         ceX8prjkRA1C2zZxv62Rwv1sPJ88ZH6tl9dp8GhE0FBAInxXFux4F+/lnl4xXnv2L107
         736R8DWrwxa+EFSLI/w/WKCf8I67oGyHGt9HZMbUkLU0TtOFinSWVkNPZmWI9Z23k2u+
         SFvLSZ8xprkGZJJI6aF8I2ACFxQsAShqhK0Fo/N6HBq2AFsNuy6UELNXahgvD7I14HVq
         wHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mr6Q8XoatHPPPeEgQ0gN+33bEpsZOGHpMy9/Y5mysus=;
        b=Af3Em9yv3fxCMyJ0EFhUaEg7M6pdK3jIB8l02uZKyPmkcLL4vZcRJnhSdBBiU/winx
         MF0TDwUicSbeMxik+YG6ASlsBlJdlff1NgLXBbdWxuZk68Q1tc9dq6hvndN3GmV1Js6Q
         v3OHMz47ZmjKtVPRs9L74/OnR7mN2MFuY7PNJ86PbxSd1dhhR9JsOw14mVGzRYjzJ8Oq
         lxFeYx6ckDrRK9fqXkXhKDQcb2ingkHpN0LLCDmxCoIznBe593GzYR/Jfhf/SqnzIva3
         LdWurIhLxDT+MF7i1tV6mCMn5ly8jqwJXAfvVx59PHt3k4iqjkpm0KwPWt2e0vRF0S2r
         ItEQ==
X-Gm-Message-State: ANoB5pnabKk1HN2SeC+EM9Af10CHuVhXScxs58doc9hXsh3jEIhvarwr
        MyVdtdb+ygw793HcEJnl3F8FndFJtCp/FfxK0JzIDQ==
X-Google-Smtp-Source: AA0mqf6AgHSlsXAggIAXfCPN0y97UnysVdQnPCLlFqWzstciOXUr0UNFb5v4V8zUo2zESevS4IH3X031w7WgdER2Jic=
X-Received: by 2002:a2e:a0cb:0:b0:26c:4fb:b084 with SMTP id
 f11-20020a2ea0cb000000b0026c04fbb084mr5226009ljm.383.1668506304501; Tue, 15
 Nov 2022 01:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20221113010823.6436-1-guoqing.jiang@linux.dev>
 <20221113010823.6436-9-guoqing.jiang@linux.dev> <CAJpMwygWQgq+NicnOwJRU-zn32t55KtKQO5q6-68YqtCvd19iQ@mail.gmail.com>
 <CAMGffEn64htbjrgCorEXXiZM8TLjEUo0ixzz+BU7nN5QAprLBA@mail.gmail.com>
In-Reply-To: <CAMGffEn64htbjrgCorEXXiZM8TLjEUo0ixzz+BU7nN5QAprLBA@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 15 Nov 2022 10:58:13 +0100
Message-ID: <CAMGffEmEGVJFGY6NEg+NvPG_h5A4J7oKtDhEw13=Kdn+13Fdrg@mail.gmail.com>
Subject: Re: [PATCH RFC 08/12] RDMA/rtrs: Kill recon_cnt from several structs
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 15, 2022 at 10:53 AM Jinpu Wang <jinpu.wang@ionos.com> wrote:
>
> On Tue, Nov 15, 2022 at 10:39 AM Haris Iqbal <haris.iqbal@ionos.com> wrote:
> >
> > On Sun, Nov 13, 2022 at 2:08 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
> > >
> > > Seems the only relevant comment about recon_cnt is,
> > >
> > > /*
> > >  * On every new session connections increase reconnect counter
> > >  * to avoid clashes with previous sessions not yet closed
> > >  * sessions on a server side.
> > >  */
> > >
> > > However, it is not clear how the recon_cnt avoid clashed at these places
> > > in the commit since no where checks it.
> >
> > It does seem redundant. This predates my time, so I don't know if
> > there was a change which removed the usage of this. I tried to search
> > in commit history, but couldn't.
> >
> > @Jinpu Your thoughts?
Sorry for sending an empty reply.
I checked a bit, and also can find a reason why the recon_cnt was
added, it is not checked on the server side.
I think it's ok to remove it. But we can simply remove the field in
rtrs_msg_conn_req, commented below.

> >
> > >
> > > Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> > > ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 8 --------
> > >  drivers/infiniband/ulp/rtrs/rtrs-pri.h | 3 ---
> > >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 7 +------
> > >  3 files changed, 1 insertion(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > index 5ffc170dae8c..dcc8c041a141 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > > @@ -1802,7 +1802,6 @@ static int rtrs_rdma_route_resolved(struct rtrs_clt_con *con)
> > >                 .version = cpu_to_le16(RTRS_PROTO_VER),
> > >                 .cid = cpu_to_le16(con->c.cid),
> > >                 .cid_num = cpu_to_le16(clt_path->s.con_num),
> > > -               .recon_cnt = cpu_to_le16(clt_path->s.recon_cnt),
> > >         };
> > >         msg.first_conn = clt_path->for_new_clt ? FIRST_CONN : 0;
> > >         uuid_copy(&msg.sess_uuid, &clt_path->s.uuid);
> > > @@ -2336,13 +2335,6 @@ static int init_conns(struct rtrs_clt_path *clt_path)
> > >         unsigned int cid;
> > >         int err;
> > >
> > > -       /*
> > > -        * On every new session connections increase reconnect counter
> > > -        * to avoid clashes with previous sessions not yet closed
> > > -        * sessions on a server side.
> > > -        */
> > > -       clt_path->s.recon_cnt++;
> > > -
> > >         /* Establish all RDMA connections  */
> > >         for (cid = 0; cid < clt_path->s.con_num; cid++) {
> > >                 err = create_con(clt_path, cid);
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > > index a2420eecaf5a..c4ddaeba1c59 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > > @@ -109,7 +109,6 @@ struct rtrs_path {
> > >         struct rtrs_con **con;
> > >         unsigned int            con_num;
> > >         unsigned int            irq_con_num;
> > > -       unsigned int            recon_cnt;
> > >         unsigned int            signal_interval;
> > >         struct rtrs_ib_dev      *dev;
> > >         int                     dev_ref;
> > > @@ -177,7 +176,6 @@ struct rtrs_sg_desc {
> > >   * @version:      RTRS protocol version
> > >   * @cid:          Current connection id
> > >   * @cid_num:      Number of connections per session
> > > - * @recon_cnt:    Reconnections counter
> > >   * @sess_uuid:    UUID of a session (path)
> > >   * @paths_uuid:           UUID of a group of sessions (paths)
> > >   *
> > > @@ -196,7 +194,6 @@ struct rtrs_msg_conn_req {
> > >         __le16          version;
> > >         __le16          cid;
> > >         __le16          cid_num;
> > > -       __le16          recon_cnt;
> > >         uuid_t          sess_uuid;
> > >         uuid_t          paths_uuid;
> > >         u8              first_conn : 1;
We can remove it from protocol, this break compatibility with older kernel.
> > > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > index 4c883c57c2ef..e2ea09a8def7 100644
> > > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > > @@ -1712,7 +1712,6 @@ static int create_con(struct rtrs_srv_path *srv_path,
> > >  static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
> > >                                            struct rdma_cm_id *cm_id,
> > >                                            unsigned int con_num,
> > > -                                          unsigned int recon_cnt,
> > >                                            const uuid_t *uuid)
> > >  {
> > >         struct rtrs_srv_path *srv_path;
> > > @@ -1768,7 +1767,6 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
> > >
> > >         srv_path->s.con_num = con_num;
> > >         srv_path->s.irq_con_num = con_num;
> > > -       srv_path->s.recon_cnt = recon_cnt;
> > >         uuid_copy(&srv_path->s.uuid, uuid);
> > >         spin_lock_init(&srv_path->state_lock);
> > >         INIT_WORK(&srv_path->close_work, rtrs_srv_close_work);
> > > @@ -1818,7 +1816,6 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > >         struct rtrs_srv_sess *srv;
> > >
> > >         u16 version, con_num, cid;
> > > -       u16 recon_cnt;
> > >         int err = -ECONNRESET;
> > >         bool alloc_path = false;
> > >
> > > @@ -1848,7 +1845,6 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > >                 pr_err("Incorrect cid: %d >= %d\n", cid, con_num);
> > >                 goto reject_w_err;
> > >         }
> > > -       recon_cnt = le16_to_cpu(msg->recon_cnt);
> > >         srv = get_or_create_srv(ctx, &msg->paths_uuid, msg->first_conn);
> > >         if (IS_ERR(srv)) {
> > >                 err = PTR_ERR(srv);
> > > @@ -1885,8 +1881,7 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
> > >                         goto reject_w_err;
> > >                 }
> > >         } else {
> > > -               srv_path = __alloc_path(srv, cm_id, con_num, recon_cnt,
> > > -                                   &msg->sess_uuid);
> > > +               srv_path = __alloc_path(srv, cm_id, con_num, &msg->sess_uuid);
> > >                 if (IS_ERR(srv_path)) {
> > >                         mutex_unlock(&srv->paths_mutex);
> > >                         put_srv(srv);
> > > --
> > > 2.31.1
> > >
