Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FA436A4A9
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Apr 2021 06:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhDYEfa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 25 Apr 2021 00:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDYEfa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 25 Apr 2021 00:35:30 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD328C061574
        for <linux-rdma@vger.kernel.org>; Sat, 24 Apr 2021 21:34:49 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id l17so22001708oil.11
        for <linux-rdma@vger.kernel.org>; Sat, 24 Apr 2021 21:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uk59IlBVJwf7NfwTsHEDbKPT6har7olY0VCo6F4zLXM=;
        b=Qm2zDwOv0ORkk4V+VtI05syzxdORkJPA50NmGwiZmtBSiUtxYYHqNT6cPpu42JSPs8
         yuYX2yJZMGLmrTkzZiyHjB+CU/DWWV22yi6U5aPwWvjRzEAUwF3OfMUCiJd4KbL03our
         jhxoMCsM3NyR0LKDnw9w+5hzTqt/lU0DL94w3rZ7dLIHaV891lYn5Ot3+g136yck8Q+y
         zCFBRDCSN8bcM1K/DKUF/Qvwts58QZz6vFGJDmFZLzFa2rNPD084vQwShLf/oBujHsPV
         F2cs0eDOmwzwKYpBtg5+ezMokvEx3aUgZBVTz0nXo//OIN7WtCUm+Gg9tmDYCEUtXGuX
         KkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uk59IlBVJwf7NfwTsHEDbKPT6har7olY0VCo6F4zLXM=;
        b=d6SzFXU43d72Ki162WZgOkLQ03VsI51yJqxOwnWBCegCgwu7wtlY80G49QBgbqOG6P
         tuvLyxjcSrGeXqHIa2TIre9xmzNwss46+2ooseTdvzfZR+4Qf/inzc4Nvgb1PlebrZf3
         cfDbRnleusstspq/ltS6ASjdxd9rYaqLGUSni/S95sBX4yFA9w9/eFmMCRqUwLkUkTox
         hAhjjWy34zmPgNdLlJkUzaV19bHTBoU0mBxyAckyF4x/RcaQDckTTgW8vjW98d9Faf8y
         81lvy+OCncm2zXNakJZd0TUueaJEiSBiZQySqvyMbjsADwrv+sPENUL8m3SPUCspU3o/
         C8Ng==
X-Gm-Message-State: AOAM532PfE1J81VZ7J55GdYuHGjPsT+mZQsiQ8pmmy1iE75oSIacEw1V
        lh+WnKct4UT/e7jJyRKsRIcfo/tkZ7D/n+i9SKXANRmIv/k=
X-Google-Smtp-Source: ABdhPJxu6h1S4T8Jm4ZgA9nGg4DS8ua1syKjuF6wfI8fHcrp+NQow8TDkDq6c3RkP6vKf8zVnLygUKqUv4WtQ+pwqhI=
X-Received: by 2002:a05:6808:8c6:: with SMTP id k6mr8805129oij.163.1619325289004;
 Sat, 24 Apr 2021 21:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210422161341.41929-1-rpearson@hpe.com> <20210422161341.41929-7-rpearson@hpe.com>
In-Reply-To: <20210422161341.41929-7-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Sun, 25 Apr 2021 12:34:37 +0800
Message-ID: <CAD=hENch84JXK3h_+g_Np_uwR0qmqR6659QYNq9ZAALV+wUj+g@mail.gmail.com>
Subject: Re: [PATCH for-next v5 06/10] RDMA/rxe: Move local ops to subroutine
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Apr 23, 2021 at 12:13 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Simplify rxe_requester() by moving the local operations
> to a subroutine. Add an error return for illegal send WR opcode.
> Moved next_index ahead of rxe_run_task which fixed a small bug where
> work completions were delayed until after the next wqe which was not
> the intended behavior.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 89 +++++++++++++++++------------
>  1 file changed, 54 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 0d4dcd514c55..0cf97e3db29f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -555,6 +555,56 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>                           jiffies + qp->qp_timeout_jiffies);
>  }
>
> +static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)

rxe_do_local_ops if not used out of softroce.

> +{
> +       u8 opcode = wqe->wr.opcode;
> +       struct rxe_dev *rxe;
> +       struct rxe_mr *mr;
> +       u32 rkey;
> +
> +       switch (opcode) {
> +       case IB_WR_LOCAL_INV:
> +               rxe = to_rdev(qp->ibqp.device);
> +               rkey = wqe->wr.ex.invalidate_rkey;
> +               mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> +               if (!mr) {
> +                       pr_err("No MR for rkey %#x\n", rkey);
> +                       wqe->state = wqe_state_error;
> +                       wqe->status = IB_WC_LOC_QP_OP_ERR;
> +                       return -EINVAL;
> +               }
> +               mr->state = RXE_MR_STATE_FREE;
> +               rxe_drop_ref(mr);
> +               break;
> +       case IB_WR_REG_MR:
> +               mr = to_rmr(wqe->wr.wr.reg.mr);
> +
> +               rxe_add_ref(mr);
> +               mr->state = RXE_MR_STATE_VALID;
> +               mr->access = wqe->wr.wr.reg.access;
> +               mr->ibmr.lkey = wqe->wr.wr.reg.key;
> +               mr->ibmr.rkey = wqe->wr.wr.reg.key;
> +               mr->iova = wqe->wr.wr.reg.mr->iova;
> +               rxe_drop_ref(mr);
> +               break;
> +       default:
> +               pr_err("Unexpected send wqe opcode %d\n", opcode);
> +               wqe->state = wqe_state_error;
> +               wqe->status = IB_WC_LOC_QP_OP_ERR;
> +               return -EINVAL;
> +       }
> +
> +       wqe->state = wqe_state_done;
> +       wqe->status = IB_WC_SUCCESS;
> +       qp->req.wqe_index = next_index(qp->sq.queue, qp->req.wqe_index);
> +
> +       if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
> +           qp->sq_sig_type == IB_SIGNAL_ALL_WR)
> +               rxe_run_task(&qp->comp.task, 1);
> +
> +       return 0;
> +}
> +
>  int rxe_requester(void *arg)
>  {
>         struct rxe_qp *qp = (struct rxe_qp *)arg;
> @@ -594,42 +644,11 @@ int rxe_requester(void *arg)
>                 goto exit;
>
>         if (wqe->mask & WR_LOCAL_OP_MASK) {
> -               if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
> -                       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> -                       struct rxe_mr *rmr;
> -
> -                       rmr = rxe_pool_get_index(&rxe->mr_pool,
> -                                                wqe->wr.ex.invalidate_rkey >> 8);
> -                       if (!rmr) {
> -                               pr_err("No mr for key %#x\n",
> -                                      wqe->wr.ex.invalidate_rkey);
> -                               wqe->state = wqe_state_error;
> -                               wqe->status = IB_WC_MW_BIND_ERR;
> -                               goto exit;
> -                       }
> -                       rmr->state = RXE_MR_STATE_FREE;
> -                       rxe_drop_ref(rmr);
> -                       wqe->state = wqe_state_done;
> -                       wqe->status = IB_WC_SUCCESS;
> -               } else if (wqe->wr.opcode == IB_WR_REG_MR) {
> -                       struct rxe_mr *rmr = to_rmr(wqe->wr.wr.reg.mr);
> -
> -                       rmr->state = RXE_MR_STATE_VALID;
> -                       rmr->access = wqe->wr.wr.reg.access;
> -                       rmr->ibmr.lkey = wqe->wr.wr.reg.key;
> -                       rmr->ibmr.rkey = wqe->wr.wr.reg.key;
> -                       rmr->iova = wqe->wr.wr.reg.mr->iova;
> -                       wqe->state = wqe_state_done;
> -                       wqe->status = IB_WC_SUCCESS;
> -               } else {
> +               ret = do_local_ops(qp, wqe);
> +               if (unlikely(ret))
>                         goto exit;
> -               }
> -               if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
> -                   qp->sq_sig_type == IB_SIGNAL_ALL_WR)
> -                       rxe_run_task(&qp->comp.task, 1);
> -               qp->req.wqe_index = next_index(qp->sq.queue,
> -                                               qp->req.wqe_index);
> -               goto next_wqe;
> +               else
> +                       goto next_wqe;
>         }
>
>         if (unlikely(qp_type(qp) == IB_QPT_RC &&
> --
> 2.27.0
>
