Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0E6321436
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 11:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhBVKcv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 05:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbhBVKcs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Feb 2021 05:32:48 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10762C06178A
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 02:32:08 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hs11so28510783ejc.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Feb 2021 02:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6qp4hnpWRV0sIkZxOycVwSUTkgXwV4ydIu26hjmQos=;
        b=jdLgdI+ixAhClIxuE3DLhOi/sTLGkTKeeEZnhVklqmRyWxm10d2sLqVF9S3xkEfqC0
         W6n7sGUEXA8vQRPpn/+n8/xxVGBR2eH6PVN22dh/mjcDAc561vlukNtk64NYDfsy1IfV
         mAYmDJ2/XrffmwUJ2r8mrnitXaoHFcPUuDfgObHpTP3H3KfWGNkaKvHWzvXHuu5mtX5R
         unSbB6zXSrSFS3luvKLph5ngMtC2Lf3h+RxmyadDv7CYWNA+DcEEH2yHbf82AZtkpjA2
         b22LHcKm8e2okwpvlNiACE7D7+XMkOl2s1GZlhR77yu2Yb4c/gQ6l0I5d/lsUva2hPyg
         t0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6qp4hnpWRV0sIkZxOycVwSUTkgXwV4ydIu26hjmQos=;
        b=hHclOh4Kl7+9cL3nFOwRiqPhLER1EOaJUbfmctkoR7NZGrWLon7N4A1vSrQ6K0ULzW
         6hw2yLw0W9NilDBsiv22/71L972nB3M/wvMl+nGF5QCJ6R2h4GBzMXxlTap4MSRHuCSS
         capI6zfaniNXx7XuQHLEvv8a4oimBpKrIKo8s+FOasoDqSxcm8PMvLQ+xrZa19jdoAlz
         Lbmf0jOuObZErbldn+7rO/kvmbq+hkyvTbzux01650C779zacibVRVKqfvw4OlWXjucH
         Vl6rEp2EzDyhi1fCMW9n4IURHOSqrnr7zxWO6DJFVsoX+/h5GE74GzGsMXGP855Bb/sx
         CpJw==
X-Gm-Message-State: AOAM531RtueWo9VPtOuuRhm62pwqXH5huN3dvr2PyjR/EG/3nxHlX2Vo
        yx2BjFXTUyEfhvWoNROdGgodBSIjMW5tNbT8y9cf38dQsYw=
X-Google-Smtp-Source: ABdhPJyUiGDWwBwNnIhAkRzRvLtI6db36YgEhBcbPRIcreEiV04cOpox8qYT3k2LinO/SOvnIZV/puqM1WOOh2FMMGE=
X-Received: by 2002:a17:906:2804:: with SMTP id r4mr3968913ejc.521.1613989926607;
 Mon, 22 Feb 2021 02:32:06 -0800 (PST)
MIME-Version: 1.0
References: <20210219115019.38981-1-jinpu.wang@cloud.ionos.com> <YDH8ckNx/sEPlePt@unreal>
In-Reply-To: <YDH8ckNx/sEPlePt@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 22 Feb 2021 11:31:55 +0100
Message-ID: <CAMGffEk7Qn9W+tjvb4S-aHs7N0DtkwNRR76X3Lf6zjfRujTP5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] RDMA/rtrs: Use new shared CQ mechanism
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Feb 21, 2021 at 7:23 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Feb 19, 2021 at 12:50:18PM +0100, Jack Wang wrote:
> > Has the driver use shared CQs providing ~10%-20% improvement during
> > test.
> > Instead of opening a CQ for each QP per connection, a CQ for each QP
> > will be provided by the RDMA core driver that will be shared between
> > the QPs on that core reducing interrupt overhead.
> >
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 +++++-----
> >  drivers/infiniband/ulp/rtrs/rtrs-pri.h |  1 +
> >  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 10 +++++-----
> >  drivers/infiniband/ulp/rtrs/rtrs.c     | 11 +++++++----
> >  4 files changed, 18 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 0a08b4b742a3..4e9cf06cc17a 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -325,7 +325,7 @@ static void rtrs_rdma_error_recovery(struct rtrs_clt_con *con)
> >
> >  static void rtrs_clt_fast_reg_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -     struct rtrs_clt_con *con = cq->cq_context;
> > +     struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
> >
> >       if (unlikely(wc->status != IB_WC_SUCCESS)) {
> >               rtrs_err(con->c.sess, "Failed IB_WR_REG_MR: %s\n",
> > @@ -345,7 +345,7 @@ static void rtrs_clt_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> >       struct rtrs_clt_io_req *req =
> >               container_of(wc->wr_cqe, typeof(*req), inv_cqe);
> > -     struct rtrs_clt_con *con = cq->cq_context;
> > +     struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
> >
> >       if (unlikely(wc->status != IB_WC_SUCCESS)) {
> >               rtrs_err(con->c.sess, "Failed IB_WR_LOCAL_INV: %s\n",
> > @@ -586,7 +586,7 @@ static int rtrs_post_recv_empty_x2(struct rtrs_con *con, struct ib_cqe *cqe)
> >
> >  static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -     struct rtrs_clt_con *con = cq->cq_context;
> > +     struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
> >       struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> >       u32 imm_type, imm_payload;
> >       bool w_inval = false;
> > @@ -2241,7 +2241,7 @@ static int init_conns(struct rtrs_clt_sess *sess)
> >
> >  static void rtrs_clt_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -     struct rtrs_clt_con *con = cq->cq_context;
> > +     struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
> >       struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> >       struct rtrs_iu *iu;
> >
> > @@ -2323,7 +2323,7 @@ static int process_info_rsp(struct rtrs_clt_sess *sess,
> >
> >  static void rtrs_clt_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -     struct rtrs_clt_con *con = cq->cq_context;
> > +     struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
> >       struct rtrs_clt_sess *sess = to_clt_sess(con->c.sess);
> >       struct rtrs_msg_info_rsp *msg;
> >       enum rtrs_clt_state state;
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > index 8caad0a2322b..1b31bda9ca78 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
> > @@ -91,6 +91,7 @@ struct rtrs_con {
> >       struct ib_cq            *cq;
> >       struct rdma_cm_id       *cm_id;
> >       unsigned int            cid;
> > +     u16                     cq_size;
> >  };
> >
> >  struct rtrs_sess {
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > index d071809e3ed2..37ba121564a2 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> > @@ -199,7 +199,7 @@ static void rtrs_srv_wait_ops_ids(struct rtrs_srv_sess *sess)
> >
> >  static void rtrs_srv_reg_mr_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -     struct rtrs_srv_con *con = cq->cq_context;
> > +     struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
> >       struct rtrs_sess *s = con->c.sess;
> >       struct rtrs_srv_sess *sess = to_srv_sess(s);
> >
> > @@ -720,7 +720,7 @@ static void rtrs_srv_stop_hb(struct rtrs_srv_sess *sess)
> >
> >  static void rtrs_srv_info_rsp_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -     struct rtrs_srv_con *con = cq->cq_context;
> > +     struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
> >       struct rtrs_sess *s = con->c.sess;
> >       struct rtrs_srv_sess *sess = to_srv_sess(s);
> >       struct rtrs_iu *iu;
> > @@ -862,7 +862,7 @@ static int process_info_req(struct rtrs_srv_con *con,
> >
> >  static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -     struct rtrs_srv_con *con = cq->cq_context;
> > +     struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
> >       struct rtrs_sess *s = con->c.sess;
> >       struct rtrs_srv_sess *sess = to_srv_sess(s);
> >       struct rtrs_msg_info_req *msg;
> > @@ -1110,7 +1110,7 @@ static void rtrs_srv_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> >       struct rtrs_srv_mr *mr =
> >               container_of(wc->wr_cqe, typeof(*mr), inv_cqe);
> > -     struct rtrs_srv_con *con = cq->cq_context;
> > +     struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
> >       struct rtrs_sess *s = con->c.sess;
> >       struct rtrs_srv_sess *sess = to_srv_sess(s);
> >       struct rtrs_srv *srv = sess->srv;
> > @@ -1167,7 +1167,7 @@ static void rtrs_rdma_process_wr_wait_list(struct rtrs_srv_con *con)
> >
> >  static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
> >  {
> > -     struct rtrs_srv_con *con = cq->cq_context;
> > +     struct rtrs_srv_con *con = to_srv_con(wc->qp->qp_context);
> >       struct rtrs_sess *s = con->c.sess;
> >       struct rtrs_srv_sess *sess = to_srv_sess(s);
> >       struct rtrs_srv *srv = sess->srv;
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs.c b/drivers/infiniband/ulp/rtrs/rtrs.c
> > index d13aff0aa816..d5ec78280937 100644
> > --- a/drivers/infiniband/ulp/rtrs/rtrs.c
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs.c
> > @@ -218,14 +218,15 @@ static int create_cq(struct rtrs_con *con, int cq_vector, u16 cq_size,
> >       struct rdma_cm_id *cm_id = con->cm_id;
> >       struct ib_cq *cq;
> >
> > -     cq = ib_alloc_cq(cm_id->device, con, cq_size,
> > -                      cq_vector, poll_ctx);
> > +     cq = ib_cq_pool_get(cm_id->device, cq_size,
> > +                         cq_vector, poll_ctx);
> >       if (IS_ERR(cq)) {
> >               rtrs_err(con->sess, "Creating completion queue failed, errno: %ld\n",
> >                         PTR_ERR(cq));
> >               return PTR_ERR(cq);
> >       }
> >       con->cq = cq;
> > +     con->cq_size = cq_size;
> >
> >       return 0;
> >  }
> > @@ -273,8 +274,9 @@ int rtrs_cq_qp_create(struct rtrs_sess *sess, struct rtrs_con *con,
> >       err = create_qp(con, sess->dev->ib_pd, max_send_wr, max_recv_wr,
> >                       max_send_sge);
> >       if (err) {
> > -             ib_free_cq(con->cq);
> > +             ib_cq_pool_put(con->cq, con->cq_size);
> >               con->cq = NULL;
> > +             con->cq_size = 0;
>
> It is better do not clear fields that not used, it hides bugs.
> Other than that.
I feel rewinding on the error path by resetting the cq_size is the
right thing to do.
>
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Thanks for the review!
