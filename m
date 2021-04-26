Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B555136B06A
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Apr 2021 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbhDZJUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Apr 2021 05:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbhDZJUv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Apr 2021 05:20:51 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2782C061574
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 02:20:08 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id m13so55811968oiw.13
        for <linux-rdma@vger.kernel.org>; Mon, 26 Apr 2021 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPu+ezYeFlB45Vh/sTLB83HgmTcVPeMSD1gh/BdnWTk=;
        b=nvn8a1wyB2F/bF7N3xEK+rM3IlEf64GWZx94vz2USibSbhlZegLQlxzdsgPhfOzDwK
         /xcrO4l2mf5/v2EcV24mcTdolCnkHSTFja/ILX7QGWmDeC+lqQmVwmZc+LFfjFO8LVeD
         7cEA/hKDRz3ZBGwRBkZDbyoQVtxawvGgnEPWRAf9zD8QDi+T1RUoTnWFZSBNLNjnZJUb
         pKejgHxJmGzHhCPhJ5R9bpAO/3AlS+bOkNyc0Uq95LhVEDKIOse+ELrvqwTixBHzHsm5
         6/qgdGuxlh2GbrR1kpVtnpnZe7QHO0CYPxw5TkEa5DmFUQ65RGV2oBJ/0H02LlQy9ZXu
         zqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPu+ezYeFlB45Vh/sTLB83HgmTcVPeMSD1gh/BdnWTk=;
        b=X3pob18vLZ85OBy+W/sAnaVg3j3gzsIUYWmBbr6+kK3FFQupGib/VhrKkhYm3FwCJc
         lySyjllT0lmSAR3nMxDj5AHRZqO0NfOnGpskUMCLW282qaSk/YV0DZ69UR6/RQBBYKWM
         ZsVZ/shpFUIXse4tv2BRPPrprk57u3YXlOOOu+KpYixSP3ixBqKYuiCCega8w1AzfpYU
         hp2/aB/4OSpgxFp2zjjezL17F2Za7xcq172OnzbwUNYVg2ON28xuen70L67o0xUJ0A+3
         /oZAmFmn1dSfBoanTN+Vt8SFfScytXEAzjfwKzOhlwDKdkLcCDu4oy/9V1dweDGoerRQ
         Wv1g==
X-Gm-Message-State: AOAM530uInYAfn4+KScCEl3yVvrSBEVEvvFkbbF3fBkGQIIUJ4hAfQmW
        rwb8JUDslG3XdLUUD0FVAP/NZvI0/eIhcErhQgg=
X-Google-Smtp-Source: ABdhPJyKaXDwydbhnBsEiPa4XNbX5FhQJWocMmsaNev2eUKZ3Duos8sZ7XRHdA7guE9QkTOgWVH4d0Qa06/cWM22kzU=
X-Received: by 2002:aca:fd06:: with SMTP id b6mr2981357oii.89.1619428808291;
 Mon, 26 Apr 2021 02:20:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210422161341.41929-1-rpearson@hpe.com> <20210422161341.41929-11-rpearson@hpe.com>
In-Reply-To: <20210422161341.41929-11-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Mon, 26 Apr 2021 17:19:57 +0800
Message-ID: <CAD=hENfJQSBDmrHW4D6rJ36yBu5P1aa0gaJhBeKhxmaUt2DSyg@mail.gmail.com>
Subject: Re: [PATCH for-next v5 10/10] Subject: [PATCH for-next v4 10/10]
 RDMA/rxe: Disallow MR dereg and invalidate when bound
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 23, 2021 at 12:13 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Check that an MR has no bound MWs before allowing a dereg or invalidate
> operation.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
> v5:
>   Fix typo in v4 fix.

Thanks, Bob

After removing "Subject: [PATCH for-next v4 10/10] " in the subject
line and changing the function names to rxe_xxx in this V5,
I am fine with this series.

Please wait for the comments from Jason Gunthorpe and Leon Romanovsky.

Zhu Yanjun

>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> v4:
>   Added this patch to check mr->num_mw to disallow
>   dereg and invalidate operations when MR has MW's
>   bound.
>
> Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 25 +++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 11 -----------
>  3 files changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 076e1460577f..93dbd81222e8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -87,6 +87,7 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
>  int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> +int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
>  void rxe_mr_cleanup(struct rxe_pool_entry *arg);
>
>  /* rxe_mw.c */
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index f871879e5f80..6a2377030f52 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -546,6 +546,13 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
>                 goto err_drop_ref;
>         }
>
> +       if (atomic_read(&mr->num_mw) > 0) {
> +               pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
> +                       __func__);
> +               ret = -EINVAL;
> +               goto err_drop_ref;
> +       }
> +
>         mr->state = RXE_MR_STATE_FREE;
>         ret = 0;
>
> @@ -555,6 +562,24 @@ int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
>         return ret;
>  }
>
> +int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> +{
> +       struct rxe_mr *mr = to_rmr(ibmr);
> +
> +       if (atomic_read(&mr->num_mw) > 0) {
> +               pr_warn("%s: Attempt to deregister an MR while bound to MWs\n",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +
> +       mr->state = RXE_MR_STATE_ZOMBIE;
> +       rxe_drop_ref(mr_pd(mr));
> +       rxe_drop_index(mr);
> +       rxe_drop_ref(mr);
> +
> +       return 0;
> +}
> +
>  void rxe_mr_cleanup(struct rxe_pool_entry *arg)
>  {
>         struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index d22f011a20f3..89f8f00215d6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -913,17 +913,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>         return ERR_PTR(err);
>  }
>
> -static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> -{
> -       struct rxe_mr *mr = to_rmr(ibmr);
> -
> -       mr->state = RXE_MR_STATE_ZOMBIE;
> -       rxe_drop_ref(mr_pd(mr));
> -       rxe_drop_index(mr);
> -       rxe_drop_ref(mr);
> -       return 0;
> -}
> -
>  static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>                                   u32 max_num_sg)
>  {
> --
> 2.27.0
>
