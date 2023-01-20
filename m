Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428436748ED
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 02:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjATBiW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 20:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjATBiV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 20:38:21 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B74A55BD
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 17:38:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id rl14so7076449ejb.2
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 17:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kqJLYoh6NZA7yR+TO0eBZkkHCCukPpb3N4wrfWRjT4k=;
        b=I2X1txqCfSO4oSmidW/4PvmGN96MhFWtfSJA05uJx+5dojwW6ZATA0/MDnGYlJIdKl
         ifuyrMocgIDRelAEi9Llor646RtBDQf+4Y66ITvRg4sul2jJQ/rwMP9gjULJke05cINq
         NOmB+aSibYPj7ut5aYI9kXkWZbCYX8IOINrt1vlhI+rrdEYf0GRC/S1qMWBo9THH35Cl
         zDRwuQojpLMDmzAk9f+559/OfVC1TrL9EyaUOsyw6WW0+u+qbvpN6S52BklIFbFHid83
         8ZS8T9wfrrixiBacMtd8rgARSclLnE3ZKzpmbiWgv+BzXm/dbdq5GD90Xlk3R64c7zXZ
         1ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqJLYoh6NZA7yR+TO0eBZkkHCCukPpb3N4wrfWRjT4k=;
        b=0K7MWNnvKihNvjnfd2BtpEn2m/b9OM3GRjtfY6Rl8uGm0BElvbDdQAeyEEaEe2Wxjl
         nmqZ9WjCjHS/79l7TOnwkdRu8kinixm5aV1jeQIX6MVdj0FC8k8ML6A5TuEDMw+vjrSN
         jKAK9swZw+zHF/Heel8ZfsO7dwOy+PRrEZLqSncWh0XTlo2emXdqciLL4vNhK3VTcG/Y
         xsI2G6aICw97RpO0rwhdne5Br37oi+sO0cH69jeSrlTUuyWnedh0qQcDSG0ELSlUSgEb
         tIIEhz2BbZFiy8IVi/MG9AJd6OaXdrjWP8M0Z2mjaKEMZ2k6TkX11lje5Uneq9oHSMU4
         YMtA==
X-Gm-Message-State: AFqh2kppf0xNDRViuCsNAhj7+63eRHuWcA6R9Sb2ZMyusAiQgBKclGaE
        dYK/azH384TfqcToAMY87VhmU5tmvCzjm6qv2P8=
X-Google-Smtp-Source: AMrXdXtYYNQTymPP2r2wspuuI/BThHhk9c0OgTQJ58KuPjiyinEtNcwW+gFLrWZC5MozEP4aKv9HVuGMyBvS/TBTfRg=
X-Received: by 2002:a17:907:7652:b0:7c1:275d:976c with SMTP id
 kj18-20020a170907765200b007c1275d976cmr1721848ejc.280.1674178697640; Thu, 19
 Jan 2023 17:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20230119190653.6363-1-rpearsonhpe@gmail.com>
In-Reply-To: <20230119190653.6363-1-rpearsonhpe@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Fri, 20 Jan 2023 09:38:05 +0800
Message-ID: <CAD=hENcdkWchRrvH+KXLXZoaQcZPpnCdV9V9T9mmzkJ13DJKUA@mail.gmail.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Handle zero length cases correctly
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     jgg@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 20, 2023 at 3:09 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Currently the rxe driver, in rare situations, can respond incorrectly
> to zero length operations which are retried. The client does not
> have to provide an rkey for zero length RDMA operations so the rkey
> may be invalid. The driver saves this rkey in the responder resources
> to replay the rdma operation if a retry is required so the second pass
> will use this (potentially) invalid rkey which may result in memory
> faults.
>
> This patch corrects the driver to ignore the provided rkey if the
> reth length is zero and make sure to set the mr to NULL. In read_reply()
> if the length is zero the MR is set to NULL. Warnings are added in
> the routines in rxe_mr.c to catch NULL MRs when the length is non-zero.
>

There is a patch in the following link:

https://patchwork.kernel.org/project/linux-rdma/patch/20230113023527.728725-1-baijiaju1990@gmail.com/

Not sure whether it is similar or not.

Zhu Yanjun

> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c   |  9 +++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c | 36 +++++++++++++++++++++-------
>  2 files changed, 36 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 072eac4b65d2..134a74f315c2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -267,6 +267,9 @@ void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length)
>         int m, n;
>         void *addr;
>
> +       if (WARN_ON(!mr))
> +               return NULL;
> +
>         if (mr->state != RXE_MR_STATE_VALID) {
>                 rxe_dbg_mr(mr, "Not in valid state\n");
>                 addr = NULL;
> @@ -305,6 +308,9 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, int length)
>         if (length == 0)
>                 return 0;
>
> +       if (WARN_ON(!mr))
> +               return -EINVAL;
> +
>         if (mr->ibmr.type == IB_MR_TYPE_DMA)
>                 return -EFAULT;
>
> @@ -349,6 +355,9 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>         if (length == 0)
>                 return 0;
>
> +       if (WARN_ON(!mr))
> +               return -EINVAL;
> +
>         if (mr->ibmr.type == IB_MR_TYPE_DMA) {
>                 u8 *src, *dest;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index c74972244f08..a528dc25d389 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -457,13 +457,23 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
>         return RESPST_CHK_RKEY;
>  }
>
> +/* if the reth length field is zero we can assume nothing
> + * about the rkey value and should not validate or use it.
> + * Instead set qp->resp.rkey to 0 which is an invalid rkey
> + * value since the minimum index part is 1.
> + */
>  static void qp_resp_from_reth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>  {
> +       unsigned int length = reth_len(pkt);
> +
>         qp->resp.va = reth_va(pkt);
>         qp->resp.offset = 0;
> -       qp->resp.rkey = reth_rkey(pkt);
> -       qp->resp.resid = reth_len(pkt);
> -       qp->resp.length = reth_len(pkt);
> +       qp->resp.resid = length;
> +       qp->resp.length = length;
> +       if (length)
> +               qp->resp.rkey = reth_rkey(pkt);
> +       else
> +               qp->resp.rkey = 0;
>  }
>
>  static void qp_resp_from_atmeth(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
> @@ -512,8 +522,8 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>
>         /* A zero-byte op is not required to set an addr or rkey. See C9-88 */
>         if ((pkt->mask & RXE_READ_OR_WRITE_MASK) &&
> -           (pkt->mask & RXE_RETH_MASK) &&
> -           reth_len(pkt) == 0) {
> +           (pkt->mask & RXE_RETH_MASK) && reth_len(pkt) == 0) {
> +               qp->resp.mr = NULL;
>                 return RESPST_EXECUTE;
>         }
>
> @@ -592,6 +602,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>         return RESPST_EXECUTE;
>
>  err:
> +       qp->resp.mr = NULL;
>         if (mr)
>                 rxe_put(mr);
>         if (mw)
> @@ -966,7 +977,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>         }
>
>         if (res->state == rdatm_res_state_new) {
> -               if (!res->replay) {
> +               if (qp->resp.length == 0) {
> +                       mr = NULL;
> +                       qp->resp.mr = NULL;
> +               } else if (!res->replay) {
>                         mr = qp->resp.mr;
>                         qp->resp.mr = NULL;
>                 } else {
> @@ -980,9 +994,13 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>                 else
>                         opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST;
>         } else {
> -               mr = rxe_recheck_mr(qp, res->read.rkey);
> -               if (!mr)
> -                       return RESPST_ERR_RKEY_VIOLATION;
> +               if (qp->resp.length == 0) {
> +                       mr = NULL;
> +               } else {
> +                       mr = rxe_recheck_mr(qp, res->read.rkey);
> +                       if (!mr)
> +                               return RESPST_ERR_RKEY_VIOLATION;
> +               }
>
>                 if (res->read.resid > mtu)
>                         opcode = IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE;
> --
> 2.37.2
>
