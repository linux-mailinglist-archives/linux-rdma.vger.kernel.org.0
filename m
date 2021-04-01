Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4903351FC9
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Apr 2021 21:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhDAT2L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Apr 2021 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhDAT2D (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Apr 2021 15:28:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3DCC0319C0
        for <linux-rdma@vger.kernel.org>; Thu,  1 Apr 2021 12:09:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b16so3107384eds.7
        for <linux-rdma@vger.kernel.org>; Thu, 01 Apr 2021 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jstjIVFVKJTqhlzgHV7MXKS9fCGKk+Lgc+r0oEHOkBM=;
        b=GDq0iTjNAcDbvwtgtgR/3QYL4IwSzGiBukR2OrGWZvtJ+sB20TJAn7Nkx7oIeEum93
         8Uq0A1TnvdvSUPcccnfD5Vhjp2yBi6vWDXgCo4voZ7VR60UxcOOAjTJAwyYsoesY1yUg
         2qut8dvckJejr1SKvII1a9LJE0p0TxfDu1v3/FL22RHHIUUXqjVBFdoRlBUn5t/Mn4rd
         pmXuLtRPksw0DbuTiLcEmNVNQspcsRkqUTH9PGNcl7HMwB8pEkQ2rlDOtYV9FY4K2yij
         FEfGTzpe36obAZvs48BKlfRcibeB4/0KTLsWdmSnpzBk9++8SUPpJbP91Qr/JhgkjxL6
         DegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jstjIVFVKJTqhlzgHV7MXKS9fCGKk+Lgc+r0oEHOkBM=;
        b=OWkc8SQh7tj5Sv/VwMGLhISpSF/oJ+YkTJxqoxh0Uv5tjB5r1jW9po0U2bIYgYTbuj
         emO/Aid4+EMa8Ys5fwZKnFxakbaKk2YBsZjNGy/C/1YSh7BJsjB/cWp+KOpXMCdxV/Nm
         kv3Dsmsgy3IbHvQZBgbjNXO287i+696VkQx3KOzWYCWc1E6prq0BkNT3N188iP4kU3Qi
         qHa0Bqm5TkL6bUH1fGEE59HKFJFY0fiPFXKrPq+CBP4yIoMg3qM0WeuGMRUdcGvCFS+n
         lkyNrV4ebRbzhgiuVCUTmGrIxZ5tv2s9JZe5Yt9xjAV0xrLk6Lat0yb3NIFBltsTFrPP
         2E3Q==
X-Gm-Message-State: AOAM530+l1b7RkjnXo1PN5vv7t7s8qsoYf+Vk5GLFvyUbaaSYJAP+el0
        tdbwG00j8Izn/opANyjl2EX/1UpFoHiLLS7TtqW0Og==
X-Google-Smtp-Source: ABdhPJwMGN4ysRgLGHlANwP8FHlqWzJgwutF78kobI0/r5pD4JyT+vnxjwl9Wk915btb8vlb1/0WuX27bJ4OIAy6LtM=
X-Received: by 2002:aa7:c497:: with SMTP id m23mr11527667edq.74.1617304197555;
 Thu, 01 Apr 2021 12:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210325153308.1214057-1-gi-oh.kim@ionos.com> <20210325153308.1214057-15-gi-oh.kim@ionos.com>
 <20210401184617.GA1650879@nvidia.com>
In-Reply-To: <20210401184617.GA1650879@nvidia.com>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Thu, 1 Apr 2021 21:09:22 +0200
Message-ID: <CAJX1YtaDy5n7g=vKbD3XVcqrg3NusLXBgO30JA0cKU3V+3RpNA@mail.gmail.com>
Subject: Re: [PATCH for-next 14/22] RDMA/rtrs-clt: Print more info when an
 error happens
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, leon@kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Haris Iqbal <haris.iqbal@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 1, 2021 at 8:46 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Thu, Mar 25, 2021 at 04:33:00PM +0100, Gioh Kim wrote:
> > From: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> >
> > Client prints only error value and it is not enough for debugging.
> >
> > 1. When client receives an error from server:
> > the client does not only print the error value but also
> > more information of server connection.
> >
> > 2. When client failes to send IO:
> > the client gets an error from RDMA layer. It also
> > print more information of server connection.
> >
> > Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
> >  drivers/infiniband/ulp/rtrs/rtrs-clt.c | 31 ++++++++++++++++++++++----
> >  1 file changed, 27 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > index 1519191d7154..a41864ec853d 100644
> > +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
> > @@ -440,6 +440,11 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
> >       req->in_use = false;
> >       req->con = NULL;
> >
> > +     if (unlikely(errno)) {
> > +             rtrs_err_rl(con->c.sess, "IO request failed: error=%d path=%s [%s:%u]\n",
> > +                         errno, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
> > +     }
> > +
> >       if (notify)
> >               req->conf(req->priv, errno);
> >  }
> > @@ -1026,7 +1031,8 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
> >                                      req->usr_len + sizeof(*msg),
> >                                      imm);
> >       if (unlikely(ret)) {
> > -             rtrs_err(s, "Write request failed: %d\n", ret);
> > +             rtrs_err_rl(s, "Write request failed: error=%d path=%s [%s:%u]\n",
> > +                         ret, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
> >               if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
> >                       atomic_dec(&sess->stats->inflight);
> >               if (req->sg_cnt)
> > @@ -1144,7 +1150,8 @@ static int rtrs_clt_read_req(struct rtrs_clt_io_req *req)
> >       ret = rtrs_post_send_rdma(req->con, req, &sess->rbufs[buf_id],
> >                                  req->data_len, imm, wr);
> >       if (unlikely(ret)) {
> > -             rtrs_err(s, "Read request failed: %d\n", ret);
> > +             rtrs_err_rl(s, "Read request failed: error=%d path=%s [%s:%u]\n",
> > +                         ret, kobject_name(&sess->kobj), sess->hca_name, sess->hca_port);
> >               if (sess->clt->mp_policy == MP_POLICY_MIN_INFLIGHT)
> >                       atomic_dec(&sess->stats->inflight);
> >               req->need_inv = false;
> > @@ -2465,12 +2472,28 @@ static int init_sess(struct rtrs_clt_sess *sess)
> >       mutex_lock(&sess->init_mutex);
> >       err = init_conns(sess);
> >       if (err) {
> > -             rtrs_err(sess->clt, "init_conns(), err: %d\n", err);
> > +             char str[NAME_MAX];
> > +             int err;
> > +             struct rtrs_addr path = {
> > +                     .src = &sess->s.src_addr,
> > +                     .dst = &sess->s.dst_addr,
> > +             };
> > +             rtrs_addr_to_str(&path, str, sizeof(str));
>
> Coding style is to have new lines after variable blocks.
>
> Jason

Hi Jason,

Ok, I will fix it in v3.
Thank you for the review.
