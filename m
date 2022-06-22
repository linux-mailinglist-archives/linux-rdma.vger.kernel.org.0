Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BC3554C4D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jun 2022 16:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357211AbiFVOMd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jun 2022 10:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357924AbiFVOMa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jun 2022 10:12:30 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0E138DAB
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jun 2022 07:12:29 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a2so28014102lfg.5
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jun 2022 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HE2RiMrFRUWYn+AfThB1299RuVVXDc/N4p+KwM7qp8s=;
        b=iNCIul0UCZt9woTXykdusizepfiLJtyCQxJgq24SOZYTktnnCugp+qVY4t98DPCaZn
         LuQjy/Q0kZNNEEkWzk7F0qZ+QA0AhlaVOCu5jAeaRcbEu832phMars+bJVlxaFFw5UNc
         hhJk4RWDP2W4XJAFBiIdoTIfRLKlZo5vogHuV9uSoSrt38jO2yejUrYHvjUGFLytpQZ8
         fxGTLxwNdewfGjtNBaHwglHDNa146Z013U9536T9QAKGA6RPw04S4GEAJghiORsoJcVI
         wN14YZ0qv9cyS3UudxpFme105txuOiTQ5L7DMwNjvJDQK96RRHmi//eez35zNpII9Npl
         qOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HE2RiMrFRUWYn+AfThB1299RuVVXDc/N4p+KwM7qp8s=;
        b=XaNAXNeYtbrLTQu2wnCFAyJXGukIcybtsqD2X89bmsOI/S8J97G5nwiG8cv7saN8Cf
         7+QCSPLb7wbLQiF9rM215DX1IZhG0SCjfEBetXhXIVDSEyeDQf5cX5oGaq+rBLZYJgWt
         kbBWwFzMjHwRHMJdNM8qM2aTejE9eBS54yBsPdHAw5ogB284pgk24L5f4VU8iWhBJDpK
         Q8ZIfzUD7KSFFHkDHofcOSO0tLL7U4TkZhhJvlUtlrGhaWoHP1jnSQ/2iPe2qebi6QIm
         ugDPiws9wYOzsmraKDylBqh719WmMG3sOU6lBcWoCYzVyMEdeDaIzNAl6yydWwAXo47E
         Uthg==
X-Gm-Message-State: AJIora8FHIrtg4eja3FbwtEjVtKJkL4bIbD6WrxBIMEPYBkIxZJgkD6o
        0t+Nrs2tsUb3liMpdzRN2I0fmoQIKawVoQWSqSQIS4quLSk5r8bP
X-Google-Smtp-Source: AGRyM1t2854+oXDMU67V3odIdJBNtO17El8wZGEseG7dkp2sISCUJMahszR63+tPsWk4jv16SXNvI/A+afe/Lw5jSCU=
X-Received: by 2002:a05:6512:2607:b0:47d:ad86:2761 with SMTP id
 bt7-20020a056512260700b0047dad862761mr2343952lfb.133.1655907147770; Wed, 22
 Jun 2022 07:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220616140908.666092-1-haris.phnx@gmail.com>
In-Reply-To: <20220616140908.666092-1-haris.phnx@gmail.com>
From:   haris iqbal <haris.phnx@gmail.com>
Date:   Wed, 22 Jun 2022 16:12:01 +0200
Message-ID: <CAE_WKMypM1pTCpQV_yJUwa9DzVZnB9grCM=kiVt_6m3HD98eiA@mail.gmail.com>
Subject: Re: [PATCH v2] RDMA/rxe: Split rxe_invalidate_mr into local and
 remote versions
To:     linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leon@kernel.org>, jgg@ziepe.ca,
        zyjzyj2000@gmail.com, haris.iqbal@ionos.com,
        Jinpu Wang <jinpu.wang@ionos.com>, aleksei.marov@ionos.com,
        rpearsonhpe@gmail.com
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

On Thu, Jun 16, 2022 at 4:09 PM Md Haris Iqbal <haris.phnx@gmail.com> wrote:
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
> v1 -> v2
> give a better name to key variable in function rxe_do_local_ops
>
>  drivers/infiniband/sw/rxe/rxe_loc.h  |  3 +-
>  drivers/infiniband/sw/rxe/rxe_mr.c   | 59 +++++++++++++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_req.c  | 10 ++---
>  drivers/infiniband/sw/rxe/rxe_resp.c |  2 +-
>  4 files changed, 53 insertions(+), 21 deletions(-)
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
> index 9d98237389cf..ef193a8a7158 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -541,16 +541,16 @@ static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>  static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>  {
>         u8 opcode = wqe->wr.opcode;
> -       u32 rkey;
> +       u32 key;
>         int ret;
>
>         switch (opcode) {
>         case IB_WR_LOCAL_INV:
> -               rkey = wqe->wr.ex.invalidate_rkey;
> -               if (rkey_is_mw(rkey))
> -                       ret = rxe_invalidate_mw(qp, rkey);
> +               key = wqe->wr.ex.invalidate_rkey;
> +               if (rkey_is_mw(key))
> +                       ret = rxe_invalidate_mw(qp, key);
>                 else
> -                       ret = rxe_invalidate_mr(qp, rkey);
> +                       ret = rxe_invalidate_mr_local(qp, key);
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
>

ping.
