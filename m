Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C610353B794
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jun 2022 13:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbiFBLES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jun 2022 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiFBLER (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jun 2022 07:04:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60E2985AC
        for <linux-rdma@vger.kernel.org>; Thu,  2 Jun 2022 04:04:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s13so4847494ljd.4
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jun 2022 04:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QfSC/2hfUsl5vwFCS9rI6p/4wJcyOodMNpttnltU6WI=;
        b=GgLLEhB+9zXlOoIPidd47V7c+eZKS9BHci7fYdCSgs8a6yU4ULYPniE6WVpFhAo/BT
         yyehEctf1BHwlmylphF9ecI24UabJ6Wn1/sxrhMI2fEXbQqtj+WgcP4AZ+ll/G07/Lz2
         MfPQVmWl+6q7AE2DESh7RS7eJBCyQ9y78Ia3KZHN4hh1EX+/ecqavElDphuL5/cALjTr
         4GVvqAur66IpvVtlHf/Nq6X2mYqBDuaXKkdxSztE+pJkANuZMVkUY7PSB+9gINyTcme0
         1YBRhenyO5mFq8/CFl6qc9nDdH7YUZb+N7+A/nrPangTVLH/ePjpz36OXxG0IFn2/wEu
         iOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QfSC/2hfUsl5vwFCS9rI6p/4wJcyOodMNpttnltU6WI=;
        b=nvWhyANHa3NBOiqo7jG0KxBdcNQ5f3CBFeCT5W+eWasuh5Jwwm4OLLm0QEQWQZZ0h6
         wINZg+UzBPsDQGyNSzVg7z9QJXntH+zN0bYkgET/r9RlWAQZewQYnMI+V34iPVm5/qAD
         3BuBSTJlxb4rVzYl2rkSpVZ7cj49Yw0bwMiikcUj2Qjhguoace+pTXrdLuu/wv2nLDNp
         wx64+IgbwvDzrVjzia+MJYQOjCTyAL6J+q3vdse7cBIBYFVT9bC1Y1mEil3+EtQ64MXM
         onF+eGUuFlHUpqpH6pCrIHnkWQy05jIj89UEMjerz6N/SZI26rTUmUJIJIuAgvhwq3Oe
         0Yuw==
X-Gm-Message-State: AOAM533MA6lyswYtOxxC3GZxpmk3X2RUmLNTWV/Jjx0PZP75AWYkftcB
        t6xbyA0RSTgA25vBZkGXatmDfJgy8ly4JfnBoMolwQ==
X-Google-Smtp-Source: ABdhPJwmvx5nj+kCsECiwcNaEpGugdJJ7zYhJsgjLvD8mBT3XNWii9iRiEivezD5IuAZ512yobkeTRiK5lm3hfkEvYU=
X-Received: by 2002:a2e:87c6:0:b0:255:617a:6505 with SMTP id
 v6-20020a2e87c6000000b00255617a6505mr6632865ljj.280.1654167853268; Thu, 02
 Jun 2022 04:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJpMwyjL4iWSSLh_pgWEqLT7oCLgMAFCAdZTJ0w1Rv-gkDNDFQ@mail.gmail.com>
 <bb958406-14a1-e785-a525-9c1d5132f10e@gmail.com> <CAJpMwyj2YFyPqHprFUHvGHMBDgT7fFu72WSdXU0KZM8BMgm_7Q@mail.gmail.com>
 <3fb832ea-5933-690d-5b81-ae3cc7ffe2c7@gmail.com>
In-Reply-To: <3fb832ea-5933-690d-5b81-ae3cc7ffe2c7@gmail.com>
From:   Haris Iqbal <haris.iqbal@ionos.com>
Date:   Thu, 2 Jun 2022 13:04:02 +0200
Message-ID: <CAJpMwyiZS=TqCRd=atngCd3MCmK-G2wcV4ahUVXEkG8aW0+xow@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 7:37 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> On 6/1/22 11:15, Haris Iqbal wrote:
> > On Tue, May 31, 2022 at 7:12 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
> >>
> >> On 5/30/22 06:05, Haris Iqbal wrote:
> >>> Hi Bob,
> >>>
> >>> I have a query. After the following patch,
> >>>
> >>> https://marc.info/?l=linux-rdma&m=163163776430842&w=2
> >>>
> >>> If I send a IB_WR_REG_MR wr with flag set to IB_ACCESS_LOCAL_WRITE,
> >>> rxe will set the mr->rkey to 0 (mr->lkey will be set to the key I send
> >>> in wr).
> >>>
> >>> Afterwards, If I have to invalidate that mr with IB_WR_LOCAL_INV,
> >>> setting the .ex.invalidate_rkey to the key I sent previously in the
> >>> IB_WR_REG_MR wr, the invalidate would fail with the following error.
> >>>
> >>> rkey (%#x) doesn't match mr->rkey
> >>> (function rxe_invalidate_mr)
> >>>
> >>> Is this desired behaviour? If so, how would I go about invalidating
> >>> the above MR?
> >>>
> >>> Regards
> >>> -Haris
> >>
> >> I think that the first behavior is correct. If you don't do this then the
> >> MR is open for RDMA operations which you didn't allow.
> >>
> >> The second behavior is more interesting. If you are doing a send_with_invalidate
> >> from a remote node then no reason you should allow the remote node to do
> >> anything to the MR since it didn't have access to begin with. For a local invalidate MR
> >> If you read the IBA it claims that local invalidate operations should provide
> >> the lkey, rkey and memory handle as parameters to the operation and that the
> >> lkey should be invalidated and the rkey if there is one should be invalidated. But
> >> ib_verbs.h only has one parameter labeled rkey.
> >>
> >> The rxe driver follows most other providers and always makes the lkey and rkey the same
> >> if there is an rkey else the rkey is set to zero. So rxe_invalidate_mr should compare
> >> to the lkey and not the rkey for local invalidate. And then move the MR to the FREE state.
> >>
> >> This is a bug. Fortunately the majority of use cases for physical memory regions are
> >> for RDMA access.
> >
> > Thanks for the response Bob. I understand now.
> >
> >>
> >> Feel free to submit a patch or I will if you don't care to. The rxe_invalidate_mr() subroutine
> >> needs have a new parameter since it is shared by local and remote invalidate operations and
> >> they need to behave differently. Easiest is to have an lkey and rkey parameter. The local
> >> operation would set the lkey and the remote operation the rkey.
> >
> > Do you mean something like this?
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h
> > b/drivers/infiniband/sw/rxe/rxe_loc.h
> > index 0e022ae1b8a5..1e6a6d8d330b 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > @@ -77,7 +77,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
> > access, u32 key,
> >                          enum rxe_mr_lookup_type type);
> >  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> >  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> > +int rxe_invalidate_mr(struct rxe_qp *qp, u32 lkey, u32 rkey);
> >  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
> >  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
> >  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> > b/drivers/infiniband/sw/rxe/rxe_mr.c
> > index fc3942e04a1f..cbdb8fa9a08e 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -576,20 +576,27 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
> > access, u32 key,
> >         return mr;
> >  }
> >
> > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> > +int rxe_invalidate_mr(struct rxe_qp *qp, u32 lkey, u32 rkey)
> >  {
> >         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> >         struct rxe_mr *mr;
> >         int ret;
> >
> > -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> > +       mr = rxe_pool_get_index(&rxe->mr_pool, (lkey ? lkey : rkey) >> 8);
> >         if (!mr) {
> > -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> > +               pr_err("%s: No MR for key %#x\n", __func__, (lkey ?
> > lkey : rkey));
> >                 ret = -EINVAL;
> >                 goto err;
> >         }
> >
> > -       if (rkey != mr->rkey) {
> > +       if (lkey && lkey != mr->lkey) {
> > +               pr_err("%s: lkey (%#x) doesn't match mr->lkey (%#x)\n",
> > +                       __func__, lkey, mr->lkey);
> > +               ret = -EINVAL;
> > +               goto err_drop_ref;
> > +       }
> > +
> > +       if (rkey && rkey != mr->rkey) {
> >                 pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> >                         __func__, rkey, mr->rkey);
> >                 ret = -EINVAL;
> > diff --git a/drivers/infiniband/sw/rxe/rxe_req.c
> > b/drivers/infiniband/sw/rxe/rxe_req.c
> > index 9d98237389cf..478b86f59f6c 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_req.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> > @@ -550,7 +550,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp,
> > struct rxe_send_wqe *wqe)
> >                 if (rkey_is_mw(rkey))
> >                         ret = rxe_invalidate_mw(qp, rkey);
> >                 else
> > -                       ret = rxe_invalidate_mr(qp, rkey);
> > +                       ret = rxe_invalidate_mr(qp, rkey, 0);
> >
> >                 if (unlikely(ret)) {
> >                         wqe->status = IB_WC_LOC_QP_OP_ERR;
> > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> > b/drivers/infiniband/sw/rxe/rxe_resp.c
> > index d995ddbe23a0..48b474703aa7 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > @@ -803,7 +803,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
> >         if (rkey_is_mw(rkey))
> >                 return rxe_invalidate_mw(qp, rkey);
> >         else
> > -               return rxe_invalidate_mr(qp, rkey);
> > +               return rxe_invalidate_mr(qp, 0, rkey);
> >  }
> >
> > Another alternate way would be to separate the invalidate into 2
> > functions. One for local and the other for remote.
> > That way it will be clearer and we avoid the weird use of ternary
> > operator in rxe_pool_get_index and the print afterwards.
> > Something like this?
> >
> > diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h
> > b/drivers/infiniband/sw/rxe/rxe_loc.h
> > index 0e022ae1b8a5..4da57abbbc8c 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> > @@ -77,7 +77,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
> > access, u32 key,
> >                          enum rxe_mr_lookup_type type);
> >  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> >  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> > +int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey);
> > +int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey);
> >  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
> >  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
> >  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c
> > b/drivers/infiniband/sw/rxe/rxe_mr.c
> > index fc3942e04a1f..1c7179dd92eb 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> > @@ -576,41 +576,72 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int
> > access, u32 key,
> >         return mr;
> >  }
> >
> > -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> > +static int rxe_invalidate_mr(struct rxe_mr *mr)
> > +{
> > +       if (atomic_read(&mr->num_mw) > 0) {
> > +               pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
> > +                       __func__);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> > +               pr_warn("%s: mr->type (%d) is wrong type\n", __func__,
> > mr->type);
> > +               return -EINVAL;
> > +       }
> > +
> > +       mr->state = RXE_MR_STATE_FREE;
> > +       return 0;
> > +}
> > +
> > +int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey)
> >  {
> >         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> >         struct rxe_mr *mr;
> >         int ret;
> >
> > -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> > +       mr = rxe_pool_get_index(&rxe->mr_pool, lkey >> 8);
> >         if (!mr) {
> > -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> > +               pr_err("%s: No MR for lkey %#x\n", __func__, lkey);
> >                 ret = -EINVAL;
> >                 goto err;
> >         }
> >
> > -       if (rkey != mr->rkey) {
> > -               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> > -                       __func__, rkey, mr->rkey);
> > +       if (lkey != mr->lkey) {
> > +               pr_err("%s: lkey (%#x) doesn't match mr->lkey (%#x)\n",
> > +                       __func__, lkey, mr->lkey);
> >                 ret = -EINVAL;
> >                 goto err_drop_ref;
> >         }
> >
> > -       if (atomic_read(&mr->num_mw) > 0) {
> > -               pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
> > -                       __func__);
> > +       ret = rxe_invalidate_mr(mr);
> > +
> > +err_drop_ref:
> > +       rxe_put(mr);
> > +err:
> > +       return ret;
> > +}
> > +
> > +int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey)
> > +{
> > +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> > +       struct rxe_mr *mr;
> > +       int ret;
> > +
> > +       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> > +       if (!mr) {
> > +               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> >                 ret = -EINVAL;
> > -               goto err_drop_ref;
> > +               goto err;
> >         }
> >
> > -       if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> > -               pr_warn("%s: mr->type (%d) is wrong type\n", __func__,
> > mr->type);
> > +       if (rkey != mr->rkey) {
> > +               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> > +                       __func__, rkey, mr->rkey);
> >                 ret = -EINVAL;
> >                 goto err_drop_ref;
> >         }
> >
> > -       mr->state = RXE_MR_STATE_FREE;
> > -       ret = 0;
> > +       ret = rxe_invalidate_mr(mr);
> >
> >  err_drop_ref:
> >         rxe_put(mr);
> > diff --git a/drivers/infiniband/sw/rxe/rxe_req.c
> > b/drivers/infiniband/sw/rxe/rxe_req.c
> > index 9d98237389cf..e7dd9738a255 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_req.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> > @@ -550,7 +550,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp,
> > struct rxe_send_wqe *wqe)
> >                 if (rkey_is_mw(rkey))
> >                         ret = rxe_invalidate_mw(qp, rkey);
> >                 else
> > -                       ret = rxe_invalidate_mr(qp, rkey);
> > +                       ret = rxe_invalidate_mr_local(qp, rkey);
> >
> >                 if (unlikely(ret)) {
> >                         wqe->status = IB_WC_LOC_QP_OP_ERR;
> > diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> > b/drivers/infiniband/sw/rxe/rxe_resp.c
> > index d995ddbe23a0..234e7858fb12 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> > @@ -803,7 +803,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
> >         if (rkey_is_mw(rkey))
> >                 return rxe_invalidate_mw(qp, rkey);
> >         else
> > -               return rxe_invalidate_mr(qp, rkey);
> > +               return rxe_invalidate_mr_remote(qp, rkey);
> >  }
> >
> > I tested both with rnbd/rtrs and both works fine.
> > Let me know which one looks better. I will send that one as a patch.
>
> I like the second one better. May want to hold off until the merge window closes
> to send it.
>
> Zhu is the rxe maintainer so be sure to copy him and Jason.

Thanks Bob. I prefer the second one too.
I will keep the patch ready and send it out when the merge window
closes. Will copy Zhu and Jason too.

>
> Bob
> >
> >>
> >> Bob
>
