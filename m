Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40306549B4F
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jun 2022 20:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244360AbiFMSTQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Jun 2022 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbiFMSS6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 13 Jun 2022 14:18:58 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670BE1D0589
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jun 2022 07:21:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y29so6365190ljd.7
        for <linux-rdma@vger.kernel.org>; Mon, 13 Jun 2022 07:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IlthB635wzc9fqZq5yKuBVt2toUYQygSkeTv1btRsKg=;
        b=hX4ySJwMaYkvIizUYGNbDR5RcpJ7Pre7fEXFPHZkkt7/O3joh3hvd6x3njdSI+pqP7
         FWVNdrQsZWDk0UUe9WW6Eg2kmNZSXt8iH94du+0Nur1cN38e7bgchnNKb5/QrTSN+Fa5
         ntn1IyUUF8OuawOSDPZQcWQw5oDr86wVeSW+9a+XY2IARdN0VkfaBJMSMg8ibGhsg9tl
         o3YT4ynlhyCJ+zjucIwKsnap3Va+mJq7jYNRr754e37wpHWDOT99ZFwC1nnediJ56HSJ
         /E9/3/s659NzrCl1wlGOkI9LjPyV6F3S8v2I16g51g9XQoiiyB42G0UDbuyI2Dl3ONv4
         t6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IlthB635wzc9fqZq5yKuBVt2toUYQygSkeTv1btRsKg=;
        b=FptoM+STvoer3DrGS7VnNr/Iovv/YBguCweRyA3JqTjh2HW4VhnPe3fRjF31PiHpB+
         sQNvURgvfU4skKRT5qSTsjCySfIOIkeHg1EuqZ2IXk/H4yfIQt0n+MlTaZHRDxi4DbSG
         v/Y0uJyGVLb1YMbjOm6SQexIrs76+9JgGgX2A9mZwYDFWMuJfWvi5mMHocjFMiqRtqDY
         nqz78zUnX04P0s9fRDy1pFvHw1b9X5JWia3vqW6TUrTLp0Sf/JfOz7qyjMUrhFbbNhoH
         OfZwR6A903q382r1PamgJXC+3nbrSb39K45HARiHbcj+FykV1m5Cih1gjSPguLslC9oJ
         G/lQ==
X-Gm-Message-State: AOAM530eRQ0Cl3mpxhxo3gTsxVZaigZE6DmtnjizdZ5YsABub2PhTHM1
        SyXnL3Q3tnOU9aD5fH90O9Uz0jujv0EIybkGDdM=
X-Google-Smtp-Source: ABdhPJwrnYSE6aaX68BPaNfmAthkjdjsdJdwpKpQT81r3VrrM7UcsmRwQjZQpMogGveo0TCmRd1w3bGbI3ZEWnwhofs=
X-Received: by 2002:a05:651c:1713:b0:258:e7a2:ff91 with SMTP id
 be19-20020a05651c171300b00258e7a2ff91mr9030544ljb.368.1655130062175; Mon, 13
 Jun 2022 07:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220609120322.144315-1-haris.phnx@gmail.com> <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
In-Reply-To: <d4223faa-0ac4-707a-1323-3d3ad769706b@fujitsu.com>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Mon, 13 Jun 2022 16:20:36 +0200
Message-ID: <CAE_WKMy-rGgh_6_=OY_77pXNmV73tmww18eb4+XLpp_DtyASdA@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote versions
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "leon@kernel.org" <leon@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        "aleksei.marov@ionos.com" <aleksei.marov@ionos.com>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 13, 2022 at 4:20 AM lizhijian@fujitsu.com
<lizhijian@fujitsu.com> wrote:
>
>
>
> On 09/06/2022 20:03, Md Haris Iqbal wrote:
> > Currently rxe_invalidate_mr does invalidate for both local ops, and rem=
ote
> > ones. This means that MR being invalidated is compared with rkey for bo=
th,
> > which is incorrect. For local invalidate, comparison should happen with
> > lkey,
> Just checked that IBTA SPEC =E2=80=9D10.6.5=E2=80=9C says that consumer *=
must* L_Key, R_Key ...
> Not sure whether we should concern these.

There are multiple things to consider here.. Since the wr for
invalidate can have only one invalidate_rkey, there is probably no way
to send lkey and rkey both as mentioned in the spec.

One way to make this work (mlx does this maybe?) is to always make
rkey and lkey same and NOT make this dependent on access. Whether an
MR is open for RDMA operations or not can be checked through the
access permissions. I am guessing this is how it was working before.


>
>
>
> > and for the remote one, it should happen with rkey.
> >
> > This commit splits the rxe_invalidate_mr into local and remote versions=
.
> > Each of them does comparison the right way as described above (with lke=
y
> > for local, and rkey for remote).
> >
> > Fixes: 3902b429ca14 ("RDMA/rxe: Implement invalidate MW operations")
> > Cc: rpearsonhpe@gmail.com
> > Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_loc.h  |  3 +-
> >   drivers/infiniband/sw/rxe/rxe_mr.c   | 59 +++++++++++++++++++++------=
-
> >   drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
> >   drivers/infiniband/sw/rxe/rxe_resp.c |  2 +-
> >   4 files changed, 49 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/s=
w/rxe/rxe_loc.h
> > index 0e022ae1b8a5..4da57abbbc8c 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > @@ -77,7 +77,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int acces=
s, u32 key,
> >                        enum rxe_mr_lookup_type type);
> >   int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> >   int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> > +int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey);
> > +int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey);
> >   int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
> >   int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
> >   int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw=
/rxe/rxe_mr.c
> > index fc3942e04a1f..1c7179dd92eb 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -576,41 +576,72 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int a=
ccess, u32 key,
> >       return mr;
> >   }
> >
> > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> > +static int rxe_invalidate_mr(struct rxe_mr *mr)
> > +{
> > +     if (atomic_read(&mr->num_mw) > 0) {
> > +             pr_warn("%s: Attempt to invalidate an MR while bound to M=
Ws\n",
> > +                     __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (unlikely(mr->type !=3D IB_MR_TYPE_MEM_REG)) {
> > +             pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr=
->type);
> > +             return -EINVAL;
> > +     }
> > +
> > +     mr->state =3D RXE_MR_STATE_FREE;
> > +     return 0;
> > +}
> > +
> > +int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey)
> >   {
> >       struct rxe_dev *rxe =3D to_rdev(qp->ibqp.device);
> >       struct rxe_mr *mr;
> >       int ret;
> >
> > -     mr =3D rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> > +     mr =3D rxe_pool_get_index(&rxe->mr_pool, lkey >> 8);
> >       if (!mr) {
> > -             pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> > +             pr_err("%s: No MR for lkey %#x\n", __func__, lkey);
> >               ret =3D -EINVAL;
> >               goto err;
> >       }
> >
> > -     if (rkey !=3D mr->rkey) {
> > -             pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> > -                     __func__, rkey, mr->rkey);
> > +     if (lkey !=3D mr->lkey) {
> > +             pr_err("%s: lkey (%#x) doesn't match mr->lkey (%#x)\n",
> > +                     __func__, lkey, mr->lkey);
> >               ret =3D -EINVAL;
> >               goto err_drop_ref;
> >       }
> >
> > -     if (atomic_read(&mr->num_mw) > 0) {
> > -             pr_warn("%s: Attempt to invalidate an MR while bound to M=
Ws\n",
> > -                     __func__);
> > +     ret =3D rxe_invalidate_mr(mr);
> > +
> > +err_drop_ref:
> > +     rxe_put(mr);
> > +err:
> > +     return ret;
> > +}
> > +
> > +int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey)
> > +{
> > +     struct rxe_dev *rxe =3D to_rdev(qp->ibqp.device);
> > +     struct rxe_mr *mr;
> > +     int ret;
> > +
> > +     mr =3D rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> > +     if (!mr) {
> > +             pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> >               ret =3D -EINVAL;
> > -             goto err_drop_ref;
> > +             goto err;
> >       }
> >
> > -     if (unlikely(mr->type !=3D IB_MR_TYPE_MEM_REG)) {
> > -             pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr=
->type);
> > +     if (rkey !=3D mr->rkey) {
> > +             pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> > +                     __func__, rkey, mr->rkey);
> >               ret =3D -EINVAL;
> >               goto err_drop_ref;
> >       }
> >
> > -     mr->state =3D RXE_MR_STATE_FREE;
> > -     ret =3D 0;
> > +     ret =3D rxe_invalidate_mr(mr);
> >
> >   err_drop_ref:
> >       rxe_put(mr);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/s=
w/rxe/rxe_req.c
> > index 9d98237389cf..e7dd9738a255 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_req.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> > @@ -550,7 +550,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, stru=
ct rxe_send_wqe *wqe)
> >               if (rkey_is_mw(rkey))
> >                       ret =3D rxe_invalidate_mw(qp, rkey);
> >               else
> > -                     ret =3D rxe_invalidate_mr(qp, rkey);
> > +                     ret =3D rxe_invalidate_mr_local(qp, rkey);
>
> if this rkey would implies *lkey* or *rkey*, shall we give it a new bette=
r name ?

True. We can change this to just "key" maybe.

Also, I do not know about mw, but can this problem occur for mw also?
Does that also need a patch?

>
>
> Thanks
> Zhijian
>
> >
> >               if (unlikely(ret)) {
> >                       wqe->status =3D IB_WC_LOC_QP_OP_ERR;
> > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/=
sw/rxe/rxe_resp.c
> > index f4f6ee5d81fe..01411280cd73 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > @@ -818,7 +818,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 r=
key)
> >       if (rkey_is_mw(rkey))
> >               return rxe_invalidate_mw(qp, rkey);
> >       else
> > -             return rxe_invalidate_mr(qp, rkey);
> > +             return rxe_invalidate_mr_remote(qp, rkey);
> >   }
> >
> >   /* Executes a new request. A retried request never reach that functio=
n (send
