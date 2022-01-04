Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C93483EF3
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 10:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiADJP4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 04:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiADJPz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 04:15:55 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606BC061761
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 01:15:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id bm14so145896806edb.5
        for <linux-rdma@vger.kernel.org>; Tue, 04 Jan 2022 01:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLgaaw9gwkhZQiqvKmgMmxsUxIbcPmxB20v5ikdfHSc=;
        b=hjLPt0RZv/I/DnHZ9r+C0PyOHKxl79NMFL+LiACBouZAIPH3NYmij4OmjaOUECdEQl
         78ZQCw0RqJ89Q/72am0Qx0g1BTPePSetx/0o5e8abwehcN8O7y51rr4kPEXeNHrfWT6M
         ebO1Xu/qUyhwuR+DRisZOvK/ypsLV30q1bSjl8xcnOg+gmC0NKR1/Om61pCjwPlJNCNL
         4fufE7/UaNmXSlXoSQesslwTQqEI49m2vvxECBMf01BqqS/eylg8dM65XmdvgCk6AmR9
         UgW3DswIpaPpAUO9cxGzOO29RTIcrPjpnif10ofKvXG65ukIZWdeoC9NC7XRdDtpGEXP
         FPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLgaaw9gwkhZQiqvKmgMmxsUxIbcPmxB20v5ikdfHSc=;
        b=mlOO8ewfykoZLMk0nxbN5tPuXUUb2dr9T+O0qZHqrxU/7DXkwvMXxJZ4n7WMC/ROsF
         mkytPZbazlPQpBOufsodHI5PGYwHDNL3yd5ZQ413fJxWeLqzema1W3c10mihkshKDmed
         37bMJJMqIyZtzW6xkLl8zqe6dX5+VcufgSXJAsgGTRq7jrEv7sQD06qlDnHfmFgxT8Us
         mfU6v7RpewE77dfbjHTussu4IJ4G+S0tRqJlNG+S8qHB8SJmag0uh5bH8Emn2G4fDXhL
         V8jQE7IKgJjDXUCxWO/VlSYkGeVVOs2vyQYMrmZupSuomIwxFqwk537QKoy6ieNWt9A0
         2bkQ==
X-Gm-Message-State: AOAM5336jlrRd/T5oiYIp0Fz6Ak7+0pfLmVAgB9dCtNQBft3sDjpZ6th
        cVyVpgQq+L5beCM/f46MBiMg81oZsHmzECCWV4Vg6A==
X-Google-Smtp-Source: ABdhPJw2Axf7EQWI71t0TyM7wzNsg+940FL5QH+johQi7zhpu5z/hK+UCGum7lqErIZfQ0+yN/gkZmDHSPLGYJwOPy0=
X-Received: by 2002:a17:907:da8:: with SMTP id go40mr39791093ejc.78.1641287753817;
 Tue, 04 Jan 2022 01:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20220103133339.9483-1-jinpu.wang@ionos.com> <20220103133339.9483-4-jinpu.wang@ionos.com>
 <0bf78ddd-b8b6-3a00-4a5a-1f499703a72a@linux.dev>
In-Reply-To: <0bf78ddd-b8b6-3a00-4a5a-1f499703a72a@linux.dev>
From:   Vaishali Thakkar <vaishali.thakkar@ionos.com>
Date:   Tue, 4 Jan 2022 10:15:43 +0100
Message-ID: <CAKw44h5iUQfb2sdp9m143JeDcPVqp_7nxNakF8swZCv=t+81OQ@mail.gmail.com>
Subject: Re: [PATCHv2 for-next 3/5] RDMA/rtrs-clt: Rename rtrs_clt_sess to rtrs_clt_path
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 4, 2022 at 7:52 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
>

Thanks for the reviews, Guoqing.

> On 1/3/22 9:33 PM, Jack Wang wrote:
>
> [ .. ]
>
> > -static int post_recv_sess(struct rtrs_clt_sess *sess)
> > +static int post_recv_path(struct rtrs_clt_path *clt_path)
>
> How about rename it to post_recv_clt_path to make it obviously if you
> has the same change to post_recv_sess in rtrs-srv.c?
>
> [ ... ]
>
> > @@ -1378,13 +1383,14 @@ static int alloc_sess_reqs(struct rtrs_clt_sess *sess)
> >               if (!req->sge)
> >                       goto out;
> >
> > -             req->mr = ib_alloc_mr(sess->s.dev->ib_pd, IB_MR_TYPE_MEM_REG,
> > -                                   sess->max_pages_per_mr);
> > +             req->mr = ib_alloc_mr(clt_path->s.dev->ib_pd,
> > +                                   IB_MR_TYPE_MEM_REG,
> > +                                   clt_path->max_pages_per_mr);
> >               if (IS_ERR(req->mr)) {
> >                       err = PTR_ERR(req->mr);
> >                       req->mr = NULL;
> >                       pr_err("Failed to alloc sess->max_pages_per_mr %d\n",
>
> s/sess/clt_path/

Good catch.

> > -                            sess->max_pages_per_mr);
> > +                            clt_path->max_pages_per_mr);
> >                       goto out;
> >               }
> >
>
> [ ... ]
>
> > -static int create_con(struct rtrs_clt_sess *sess, unsigned int cid)
> > +static int create_con(struct rtrs_clt_path *clt_path, unsigned int cid)
>
> Could you rename it to create_clt_con? Because the function name appears
> in both client and server.

I think renaming the functions with the same name on client and
server side should be a seperate patch/series as these patches
are only for fixing the incorrect naming.

> >   {
> >       struct rtrs_clt_con *con;
> >
> > @@ -1601,28 +1609,28 @@ static int create_con(struct rtrs_clt_sess *sess, unsigned int cid)
> >       /* Map first two connections to the first CPU */
> >       con->cpu  = (cid ? cid - 1 : 0) % nr_cpu_ids;
> >       con->c.cid = cid;
> > -     con->c.path = &sess->s;
> > +     con->c.path = &clt_path->s;
> >       /* Align with srv, init as 1 */
> >       atomic_set(&con->c.wr_cnt, 1);
> >       mutex_init(&con->con_mutex);
> >
> > -     sess->s.con[cid] = &con->c;
> > +     clt_path->s.con[cid] = &con->c;
> >
> >       return 0;
> >   }
> >
>
> [ ... ]
>
> > -static inline bool xchg_sessions(struct rtrs_clt_sess __rcu **rcu_ppcpu_path,
> > -                              struct rtrs_clt_sess *sess,
> > -                              struct rtrs_clt_sess *next)
> > +static inline bool xchg_sessions(struct rtrs_clt_path __rcu **rcu_ppcpu_path,
> > +                              struct rtrs_clt_path *clt_path,
> > +                              struct rtrs_clt_path *next)
>
> Now, it is used to exchange paths instead of sessions, right?
>
> >   {
> > -     struct rtrs_clt_sess **ppcpu_path;
> > +     struct rtrs_clt_path **ppcpu_path;
> >
> >       /* Call cmpxchg() without sparse warnings */
> >       ppcpu_path = (typeof(ppcpu_path))rcu_ppcpu_path;
> > -     return sess == cmpxchg(ppcpu_path, sess, next);
> > +     return clt_path == cmpxchg(ppcpu_path, clt_path, next);
> >   }
>
> [ ... ]
>
> > @@ -2375,31 +2387,32 @@ static int init_conns(struct rtrs_clt_sess *sess)
> >   static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
> >   {
> >       struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
> > -     struct rtrs_clt_sess *sess = to_clt_sess(con->c.path);
> > +     struct rtrs_clt_path *clt_path = to_clt_path(con->c.path);
> >       struct rtrs_iu *iu;
> >
> >       iu = container_of(wc->wr_cqe, struct rtrs_iu, cqe);
> > -     rtrs_iu_free(iu, sess->s.dev->ib_dev, 1);
> > +     rtrs_iu_free(iu, clt_path->s.dev->ib_dev, 1);
> >
> >       if (wc->status != IB_WC_SUCCESS) {
> > -             rtrs_err(sess->clt, "Sess info request send failed: %s\n",
> > +             rtrs_err(clt_path->clt, "*Sess*  info request send failed: %s\n",
>
> Path info, same as below.
>
> [ ... ]
>
> >       if (wc->status != IB_WC_SUCCESS) {
> > -             rtrs_err(sess->clt, "Sess info response recv failed: %s\n",
> > +             rtrs_err(clt_path->clt, "Path info response recv failed: %s\n",
> >                         ib_wc_status_msg(wc->status));
> >               goto out;
> >       }
> >       WARN_ON(wc->opcode != IB_WC_RECV);
> >
> >       if (wc->byte_len < sizeof(*msg)) {
> > -             rtrs_err(sess->clt, "Sess info response is malformed: size %d\n",
> > +             rtrs_err(clt_path->clt, "Path info response is malformed: size %d\n",
> >                         wc->byte_len);
> >               goto out;
> >       }
>
> [ ... ]
>
> > @@ -2533,33 +2548,34 @@ static int rtrs_send_sess_info(struct rtrs_clt_sess *sess)
> >       /* Prepare for getting info response */
> >       err = rtrs_iu_post_recv(&usr_con->c, rx_iu);
> >       if (err) {
> > -             rtrs_err(sess->clt, "rtrs_iu_post_recv(), err: %d\n", err);
> > +             rtrs_err(clt_path->clt, "rtrs_iu_post_recv(), err: %d\n", err);
> >               goto out;
> >       }
> >       rx_iu = NULL;
> >
> >       msg = tx_iu->buf;
> >       msg->type = cpu_to_le16(RTRS_MSG_INFO_REQ);
> > -     memcpy(msg->sessname, sess->s.sessname, sizeof(msg->sessname));
> > +     memcpy(msg->sessname, clt_path->s.sessname, sizeof(msg->sessname));
>
> Pls check if it is pathname.

Will do. Actually sessname is correctly named at a bunch of places
so didn't require renaming. But I'll double check again.

Thanks for all other comments. Will address them in the next version
of a patchset.

> [ ... ]
>
>
> >   /**
> > - * init_sess() - establishes all session connections and does handshake
> > - * @sess: client session.
> > + * init_pathi() - establishes all path connections and does handshake
>
> s/init_pathi/init_path, maybe it would be better to call it
> init_clt_path here.
>
> > + * @clt_path: client path.
> >    * In case of error full close or reconnect procedure should be taken,
> >    * because reconnect or close async works can be started.
> >    */
> > -static int init_sess(struct rtrs_clt_sess *sess)
> > +static int init_path(struct rtrs_clt_path *clt_path)
>
> [ ... ]
>
> > -     if (sess->reconnect_attempts >= clt->max_reconnect_attempts) {
> > +     if (clt_path->reconnect_attempts >= clt->max_reconnect_attempts) {
> >               /* Close a*session*  completely if max attempts is reached */
>
> I guess it is close a path now.
>
> > -             rtrs_clt_close_conns(sess, false);
> > +             rtrs_clt_close_conns(clt_path, false);
> >               return;
> >       }
>
> [ ... ]
>
> Thanks,
> Guoqing
