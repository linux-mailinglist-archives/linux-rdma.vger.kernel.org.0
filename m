Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE453AAD6
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jun 2022 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348240AbiFAQPb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jun 2022 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiFAQPa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Jun 2022 12:15:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435C41F95
        for <linux-rdma@vger.kernel.org>; Wed,  1 Jun 2022 09:15:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a15so3547701lfb.9
        for <linux-rdma@vger.kernel.org>; Wed, 01 Jun 2022 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOM4sxtlBuB0wvE7Wc+vvHmqMyhOGEIMI1EufoY+h/k=;
        b=OXDXqxN8a36I9JuGoPZ1hARW11nFjpVkEAGHn3l7ouLGG7rtbcOpN6VwEAdDYBHkor
         2V9LIBbEtq7qTpj7hBlwdnjYoL/JNZmbvv+upwLsybQoQOtxk9+j0SITtWzSrJv6pezX
         hmFI5Pp/2FpRp6QT8QXWJoMHzMxytO/QiD8h4ChPstOnaEILlv6mouShyMZ2w0e7a1zl
         SwsKoukmx94qYIKf3AIWn365YYRUuA5f9b/+WrOF3QkGnCdTg8yMHNgZqAo+RQR+BDGj
         UNPV/R98MVtnUDcavscQclEi1u/Gv5DIo4ZHiIGJUAkqQUdhe9sjJrzLCWPkV4uDCQzr
         l61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOM4sxtlBuB0wvE7Wc+vvHmqMyhOGEIMI1EufoY+h/k=;
        b=Vkxa9sNGXWTVu5tmZgVlh3ikMSlaNneWj1JXAtiPiVgWpfXLs+m2k4Ql5zJMpReCY4
         ofFegT9Vq9pzy3wQQmlFO2+x1OLRlQb4oasohxgjVrkJipAN8zMpK/DlVr2mMick1OCE
         vWts2FJhkfRYAjbwXnIibfVYnp0xxZm6FGWiMldVAgRyOZpN1wtwNp6S2695OC4aXQ5f
         k6Z90ZdNW7lyIVcBcSNpFMMDJqmPAZrYqOjoJJdd/8LWsJzTwdpAo8IuNviX16VaHhFH
         GQBFu0HzcbLIBanYOXe1zkm286lOIFchTXl67/2mdMPrB4+1B5ppqOT6uyyF7KA/wsJE
         466w==
X-Gm-Message-State: AOAM532Ge9ijwpMBLUayPsLCR15a8KdcnUPIU2u3pld+Jp3N2dtmdFyY
        lX+G6Yr4IitXlp58o3y6VzktFDUGgcTMq7H4aFufmg==
X-Google-Smtp-Source: ABdhPJy2hq5vN43Ljkw3PM/y+C8aiGIF1NfaseZ6iR9MOCvqTSKm4Ou/UdD8xMuPBBHX8XzjMcBgx3PTxAJpxLwjVZo=
X-Received: by 2002:a05:6512:114e:b0:478:f40f:8d7d with SMTP id
 m14-20020a056512114e00b00478f40f8d7dmr162649lfg.177.1654100126918; Wed, 01
 Jun 2022 09:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJpMwyjL4iWSSLh_pgWEqLT7oCLgMAFCAdZTJ0w1Rv-gkDNDFQ@mail.gmail.com>
 <bb958406-14a1-e785-a525-9c1d5132f10e@gmail.com>
In-Reply-To: <bb958406-14a1-e785-a525-9c1d5132f10e@gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Wed, 1 Jun 2022 18:15:15 +0200
Message-ID: <CAJpMwyj2YFyPqHprFUHvGHMBDgT7fFu72WSdXU0KZM8BMgm_7Q@mail.gmail.com>
Subject: Re: RDME/rxe: Fast reg with local access rights and invalidation for
 that MR
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 31, 2022 at 7:12 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 5/30/22 06:05, Haris Iqbal wrote:
> > Hi Bob,
> >
> > I have a query. After the following patch,
> >
> > https://marc.info/?l=linux-rdma&m=163163776430842&w=2
> >
> > If I send a IB_WR_REG_MR wr with flag set to IB_ACCESS_LOCAL_WRITE,
> > rxe will set the mr->rkey to 0 (mr->lkey will be set to the key I send
> > in wr).
> >
> > Afterwards, If I have to invalidate that mr with IB_WR_LOCAL_INV,
> > setting the .ex.invalidate_rkey to the key I sent previously in the
> > IB_WR_REG_MR wr, the invalidate would fail with the following error.
> >
> > rkey (%#x) doesn't match mr->rkey
> > (function rxe_invalidate_mr)
> >
> > Is this desired behaviour? If so, how would I go about invalidating
> > the above MR?
> >
> > Regards
> > -Haris
>
> I think that the first behavior is correct. If you don't do this then the
> MR is open for RDMA operations which you didn't allow.
>
> The second behavior is more interesting. If you are doing a send_with_invalidate
> from a remote node then no reason you should allow the remote node to do
> anything to the MR since it didn't have access to begin with. For a local invalidate MR
> If you read the IBA it claims that local invalidate operations should provide
> the lkey, rkey and memory handle as parameters to the operation and that the
> lkey should be invalidated and the rkey if there is one should be invalidated. But
> ib_verbs.h only has one parameter labeled rkey.
>
> The rxe driver follows most other providers and always makes the lkey and rkey the same
> if there is an rkey else the rkey is set to zero. So rxe_invalidate_mr should compare
> to the lkey and not the rkey for local invalidate. And then move the MR to the FREE state.
>
> This is a bug. Fortunately the majority of use cases for physical memory regions are
> for RDMA access.

Thanks for the response Bob. I understand now.

>
> Feel free to submit a patch or I will if you don't care to. The rxe_invalidate_mr() subroutine
> needs have a new parameter since it is shared by local and remote invalidate operations and
> they need to behave differently. Easiest is to have an lkey and rkey parameter. The local
> operation would set the lkey and the remote operation the rkey.

Do you mean something like this?

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h
b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0e022ae1b8a5..1e6a6d8d330b 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
access, u32 key,
                         enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 lkey, u32 rkey);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
b/drivers/infiniband/sw/rxe/rxe_mr.c
index fc3942e04a1f..cbdb8fa9a08e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -576,20 +576,27 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
access, u32 key,
        return mr;
 }

-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
+int rxe_invalidate_mr(struct rxe_qp *qp, u32 lkey, u32 rkey)
 {
        struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
        struct rxe_mr *mr;
        int ret;

-       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+       mr = rxe_pool_get_index(&rxe->mr_pool, (lkey ? lkey : rkey) >> 8);
        if (!mr) {
-               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
+               pr_err("%s: No MR for key %#x\n", __func__, (lkey ?
lkey : rkey));
                ret = -EINVAL;
                goto err;
        }

-       if (rkey != mr->rkey) {
+       if (lkey && lkey != mr->lkey) {
+               pr_err("%s: lkey (%#x) doesn't match mr->lkey (%#x)\n",
+                       __func__, lkey, mr->lkey);
+               ret = -EINVAL;
+               goto err_drop_ref;
+       }
+
+       if (rkey && rkey != mr->rkey) {
                pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
                        __func__, rkey, mr->rkey);
                ret = -EINVAL;
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c
b/drivers/infiniband/sw/rxe/rxe_req.c
index 9d98237389cf..478b86f59f6c 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -550,7 +550,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp,
struct rxe_send_wqe *wqe)
                if (rkey_is_mw(rkey))
                        ret = rxe_invalidate_mw(qp, rkey);
                else
-                       ret = rxe_invalidate_mr(qp, rkey);
+                       ret = rxe_invalidate_mr(qp, rkey, 0);

                if (unlikely(ret)) {
                        wqe->status = IB_WC_LOC_QP_OP_ERR;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
b/drivers/infiniband/sw/rxe/rxe_resp.c
index d995ddbe23a0..48b474703aa7 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -803,7 +803,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
        if (rkey_is_mw(rkey))
                return rxe_invalidate_mw(qp, rkey);
        else
-               return rxe_invalidate_mr(qp, rkey);
+               return rxe_invalidate_mr(qp, 0, rkey);
 }

Another alternate way would be to separate the invalidate into 2
functions. One for local and the other for remote.
That way it will be clearer and we avoid the weird use of ternary
operator in rxe_pool_get_index and the print afterwards.
Something like this?

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h
b/drivers/infiniband/sw/rxe/rxe_loc.h
index 0e022ae1b8a5..4da57abbbc8c 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -77,7 +77,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
access, u32 key,
                         enum rxe_mr_lookup_type type);
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
 int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
+int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey);
+int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey);
 int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
 int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
 int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
b/drivers/infiniband/sw/rxe/rxe_mr.c
index fc3942e04a1f..1c7179dd92eb 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -576,41 +576,72 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
access, u32 key,
        return mr;
 }

-int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
+static int rxe_invalidate_mr(struct rxe_mr *mr)
+{
+       if (atomic_read(&mr->num_mw) > 0) {
+               pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
+                       __func__);
+               return -EINVAL;
+       }
+
+       if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
+               pr_warn("%s: mr->type (%d) is wrong type\n", __func__,
mr->type);
+               return -EINVAL;
+       }
+
+       mr->state = RXE_MR_STATE_FREE;
+       return 0;
+}
+
+int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey)
 {
        struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
        struct rxe_mr *mr;
        int ret;

-       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+       mr = rxe_pool_get_index(&rxe->mr_pool, lkey >> 8);
        if (!mr) {
-               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
+               pr_err("%s: No MR for lkey %#x\n", __func__, lkey);
                ret = -EINVAL;
                goto err;
        }

-       if (rkey != mr->rkey) {
-               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
-                       __func__, rkey, mr->rkey);
+       if (lkey != mr->lkey) {
+               pr_err("%s: lkey (%#x) doesn't match mr->lkey (%#x)\n",
+                       __func__, lkey, mr->lkey);
                ret = -EINVAL;
                goto err_drop_ref;
        }

-       if (atomic_read(&mr->num_mw) > 0) {
-               pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
-                       __func__);
+       ret = rxe_invalidate_mr(mr);
+
+err_drop_ref:
+       rxe_put(mr);
+err:
+       return ret;
+}
+
+int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey)
+{
+       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
+       struct rxe_mr *mr;
+       int ret;
+
+       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
+       if (!mr) {
+               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
                ret = -EINVAL;
-               goto err_drop_ref;
+               goto err;
        }

-       if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
-               pr_warn("%s: mr->type (%d) is wrong type\n", __func__,
mr->type);
+       if (rkey != mr->rkey) {
+               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
+                       __func__, rkey, mr->rkey);
                ret = -EINVAL;
                goto err_drop_ref;
        }

-       mr->state = RXE_MR_STATE_FREE;
-       ret = 0;
+       ret = rxe_invalidate_mr(mr);

 err_drop_ref:
        rxe_put(mr);
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c
b/drivers/infiniband/sw/rxe/rxe_req.c
index 9d98237389cf..e7dd9738a255 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -550,7 +550,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp,
struct rxe_send_wqe *wqe)
                if (rkey_is_mw(rkey))
                        ret = rxe_invalidate_mw(qp, rkey);
                else
-                       ret = rxe_invalidate_mr(qp, rkey);
+                       ret = rxe_invalidate_mr_local(qp, rkey);

                if (unlikely(ret)) {
                        wqe->status = IB_WC_LOC_QP_OP_ERR;
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
b/drivers/infiniband/sw/rxe/rxe_resp.c
index d995ddbe23a0..234e7858fb12 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -803,7 +803,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
        if (rkey_is_mw(rkey))
                return rxe_invalidate_mw(qp, rkey);
        else
-               return rxe_invalidate_mr(qp, rkey);
+               return rxe_invalidate_mr_remote(qp, rkey);
 }

I tested both with rnbd/rtrs and both works fine.
Let me know which one looks better. I will send that one as a patch.

>
> Bob
