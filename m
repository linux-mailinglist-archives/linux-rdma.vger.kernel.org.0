Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175875450CF
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jun 2022 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiFIP2h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Jun 2022 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344645AbiFIP2g (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Jun 2022 11:28:36 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7664BBA8
        for <linux-rdma@vger.kernel.org>; Thu,  9 Jun 2022 08:28:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id g25so26539193ljm.2
        for <linux-rdma@vger.kernel.org>; Thu, 09 Jun 2022 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drx4sxec8ZHPD+KUFNoQ4E89+D1e5qGHzCb9v2htbu4=;
        b=RGpUdYXoNNXLxqN8MBjnXnHjrRVysmYF78wmTDSZ0iGbTVaXHoWNfA7tHT3TiA59DH
         gTHI34QS1u94k4f6n/KODG9u0hV7vxDyyQrPECh+opTDgsDPRRLHtFjUYEQ9xA94m6GL
         U8r9yvKYUdmA6lhlYEWS07TdfFtlzACjlhMcJHlHpHC20khMDrJu3MCotcq2XoQX8Iii
         RqvNZcmn5LcsqFEfXItq65A+lInXesmHqtXUXYLDVWYslcK4qnrsnnb9gj2t57DDYqaK
         80ObfJ5ROdTRWfYsZS/SdUaGtNFBRjTObxp4OpssyLqouk6Fn+gvfiSRKV/fXIyv8KKz
         ZR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drx4sxec8ZHPD+KUFNoQ4E89+D1e5qGHzCb9v2htbu4=;
        b=wIUjFrI3fQfxgTW9YzSeA9a2QZbbhKiaCpXhLWOobby4O8jzcDMcTynprytLEa1MUs
         b46VVfOqfdshJ54yDRFVDNmzDcumqSizJmGoLoWofaaVB76rah3JlSzJZiKLg3lPoHym
         SrXmKbMXvN4tiWBhAJMYYTfZGR7cwew2HJgP/USXVvQacjcAb2m9Eyxs4xD3kvBRwxYn
         JbMNb6nYAa35LbLz6Yb2PqiCj5uibho6Gn0QWaeJxjchybm7az8pX5PaDsOUaTxcvMGs
         3FvEP7wakRczDo1hOlblHSeotQFCa2Hrglaaz87tC+sscAngd5zTmdiCeXmOnS3BkDbh
         rknQ==
X-Gm-Message-State: AOAM531I6FjItWA5Kd0AS0XOq7kSxG5FGW8HDitvgBA8toIK6cTZQ2kN
        QWgFFh1LhJWOZNrb8lh1wHLlBwrBkETW2hukcXcMFpwGj3oYbgIYR/4=
X-Google-Smtp-Source: ABdhPJyayHfAzO25S0bIleD9JKaM3XGdSBrcbfc3LgJjRi4YmpkGrgU1izzGC5HF5Pdw5vzep+a0G7WaRPjERGqZN2I=
X-Received: by 2002:a2e:87d2:0:b0:255:6e60:bc7e with SMTP id
 v18-20020a2e87d2000000b002556e60bc7emr22934046ljj.368.1654788512339; Thu, 09
 Jun 2022 08:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220609120322.144315-1-haris.phnx@gmail.com>
In-Reply-To: <20220609120322.144315-1-haris.phnx@gmail.com>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Thu, 9 Jun 2022 17:28:06 +0200
Message-ID: <CAE_WKMygQFs=zdvD+6GaroTNb5Q7SK598d=i22=-gZQr9okDZw@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Split rxe_invalidate_mr into local and remote versions
To:     linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, Leon Romanovsky <leon@kernel.org>,
        jgg@ziepe.ca, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        aleksei.marov@ionos.com, rpearsonhpe@gmail.com,
        zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 9, 2022 at 2:03 PM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
>
> Currently rxe_invalidate_mr does invalidate for both local ops, and remote
> ones. This means that MR being invalidated is compared with rkey for both,
> which is incorrect. For local invalidate, comparison should happen with
> lkey, and for the remote one, it should happen with rkey.
>
> This commit splits the rxe_invalidate_mr into local and remote versions.
> Each of them does comparison the right way as described above (with lkey
> for local, and rkey for remote).
>
> Fixes: 3902b429ca14 ("RDMA/rxe: Implement invalidate MW operations")
> Cc: rpearsonhpe@gmail.com
> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  3 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c   | 59 +++++++++++++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_req.c  |  2 +-
>  drivers/infiniband/sw/rxe/rxe_resp.c |  2 +-
>  4 files changed, 49 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 0e022ae1b8a5..4da57abbbc8c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -77,7 +77,8 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>                          enum rxe_mr_lookup_type type);
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> +int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey);
> +int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey);
>  int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>  int rxe_mr_set_page(struct ib_mr *ibmr, u64 addr);
>  int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata);
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index fc3942e04a1f..1c7179dd92eb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -576,41 +576,72 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>         return mr;
>  }
>
> -int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> +static int rxe_invalidate_mr(struct rxe_mr *mr)
> +{
> +       if (atomic_read(&mr->num_mw) > 0) {
> +               pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +
> +       if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> +               pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
> +               return -EINVAL;
> +       }
> +
> +       mr->state = RXE_MR_STATE_FREE;
> +       return 0;
> +}
> +
> +int rxe_invalidate_mr_local(struct rxe_qp *qp, u32 lkey)
>  {
>         struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>         struct rxe_mr *mr;
>         int ret;
>
> -       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> +       mr = rxe_pool_get_index(&rxe->mr_pool, lkey >> 8);
>         if (!mr) {
> -               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> +               pr_err("%s: No MR for lkey %#x\n", __func__, lkey);
>                 ret = -EINVAL;
>                 goto err;
>         }
>
> -       if (rkey != mr->rkey) {
> -               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> -                       __func__, rkey, mr->rkey);
> +       if (lkey != mr->lkey) {
> +               pr_err("%s: lkey (%#x) doesn't match mr->lkey (%#x)\n",
> +                       __func__, lkey, mr->lkey);
>                 ret = -EINVAL;
>                 goto err_drop_ref;
>         }
>
> -       if (atomic_read(&mr->num_mw) > 0) {
> -               pr_warn("%s: Attempt to invalidate an MR while bound to MWs\n",
> -                       __func__);
> +       ret = rxe_invalidate_mr(mr);
> +
> +err_drop_ref:
> +       rxe_put(mr);
> +err:
> +       return ret;
> +}
> +
> +int rxe_invalidate_mr_remote(struct rxe_qp *qp, u32 rkey)
> +{
> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> +       struct rxe_mr *mr;
> +       int ret;
> +
> +       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> +       if (!mr) {
> +               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
>                 ret = -EINVAL;
> -               goto err_drop_ref;
> +               goto err;
>         }
>
> -       if (unlikely(mr->type != IB_MR_TYPE_MEM_REG)) {
> -               pr_warn("%s: mr->type (%d) is wrong type\n", __func__, mr->type);
> +       if (rkey != mr->rkey) {
> +               pr_err("%s: rkey (%#x) doesn't match mr->rkey (%#x)\n",
> +                       __func__, rkey, mr->rkey);
>                 ret = -EINVAL;
>                 goto err_drop_ref;
>         }
>
> -       mr->state = RXE_MR_STATE_FREE;
> -       ret = 0;
> +       ret = rxe_invalidate_mr(mr);
>
>  err_drop_ref:
>         rxe_put(mr);
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 9d98237389cf..e7dd9738a255 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -550,7 +550,7 @@ static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>                 if (rkey_is_mw(rkey))
>                         ret = rxe_invalidate_mw(qp, rkey);
>                 else
> -                       ret = rxe_invalidate_mr(qp, rkey);
> +                       ret = rxe_invalidate_mr_local(qp, rkey);
>
>                 if (unlikely(ret)) {
>                         wqe->status = IB_WC_LOC_QP_OP_ERR;
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index f4f6ee5d81fe..01411280cd73 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -818,7 +818,7 @@ static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
>         if (rkey_is_mw(rkey))
>                 return rxe_invalidate_mw(qp, rkey);
>         else
> -               return rxe_invalidate_mr(qp, rkey);
> +               return rxe_invalidate_mr_remote(qp, rkey);
>  }
>
>  /* Executes a new request. A retried request never reach that function (send
> --
> 2.25.1

Missed adding Zhu. Adding now.

>
