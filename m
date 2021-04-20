Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D035C36526D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhDTGjj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 02:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhDTGji (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Apr 2021 02:39:38 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D4C06174A
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 23:39:06 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso12421720otl.0
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 23:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtnXUAO5hiCxVW++EYBndUSoT5nv1RWRm4FQURM2q8g=;
        b=HPnJF18PE4ON+A/PtpF4cki1Mh0uenhQxrRBJMCCZ0Pn0DuAcJ/hvJL4eTV/KH14oa
         olWWlKCFs4X76FaDi1Xfto7SmUi6H4TbI25cwaUS6NqjTCU08H/6smgXPY/5nygIzZnF
         33+xt/3v+Q4ud0r1Ho4wUB1bnYvgjEejVz6JJI9HmpmdCuYywl47Wc6tUXFoDangziM2
         lsCXEcezalKkDngzFztbgZHCrYbHSS8wjVQ8WprOyiVMff8couPogego8GUUENj9uQDL
         S4kFasgU61LTWLjdPNnyGLM7goqiCVi3Kpu0P+lPxS8ZjwcGo2CFVxn8LhkKatM4oKk/
         Axbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtnXUAO5hiCxVW++EYBndUSoT5nv1RWRm4FQURM2q8g=;
        b=KDSQF5JwTD50ccgRUDMi4aye3egKElyd+P+3S+y5LXyzBFOsWRoWRMHcpJ9labYQFW
         vxeIR9Eff8OuG3Jbo2w+D9jVz/SsQOBlci8w02dxcaMyQp8v43cOqOaAUhApDSMp2MxL
         NbTheh+GwiEtSPNKlNSLrHFEagzp+dr/8QubJ0zeSRsoSIl/4+O82KDGhfezP2W0TMnY
         1aNP1jxB8tANb7d6cwwgBRb4zHtC0gU2RkGEiDVZ/t159YTbQt4PiAT7VDGOs63wVYyj
         65EpFkkTUlZlTGWSTSRMWfhXyvHPjzsRwRbpsmYSvOgP3o1E+qWG7RUXbk0oSm5MsxPz
         b+/w==
X-Gm-Message-State: AOAM531nfCTccS8XPhNJcKknVMh7Xrm37BkznJOgov6V1hmtoHaO4ffg
        k3xWEvn/U4YmtSEyXa8hjca4hCr/Hw+5dj8cY1g=
X-Google-Smtp-Source: ABdhPJzDoCO6x5cq9n1k2csY3JCh1ZY7NB74qmrtXhhpeMhQfgWA5EIeBrVSntNeN3+O02XB3nTdO+Fn4UV9YhH5Nlg=
X-Received: by 2002:a05:6830:1beb:: with SMTP id k11mr3395130otb.59.1618900745894;
 Mon, 19 Apr 2021 23:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210415025429.11053-1-rpearson@hpe.com> <20210415025429.11053-9-rpearson@hpe.com>
In-Reply-To: <20210415025429.11053-9-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 20 Apr 2021 14:38:54 +0800
Message-ID: <CAD=hENfNCVjsXn-qbVXoHWxKCDPOj5muhpSeJp5Lz8Rt=ZxdNA@mail.gmail.com>
Subject: Re: [PATCH for-next v2 8/9] RDMA/rxe: Implement invalidate MW operations
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 15, 2021 at 10:55 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>
> Implement invalidate MW and cleaned up invalidate MR operations.
>
> Added code to perform remote invalidate for send with invalidate.
> Added code to perform local invalidation.
> Deleted some blank lines in rxe_loc.h.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h   | 23 ++++-----
>  drivers/infiniband/sw/rxe/rxe_mr.c    | 59 +++++++++++++++++------
>  drivers/infiniband/sw/rxe/rxe_mw.c    | 67 +++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_req.c   | 22 +++++----
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 52 +++++++++++++--------
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 23 +++++----
>  6 files changed, 178 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index e6f574973298..7f1117c51e30 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -76,41 +76,34 @@ enum copy_direction {
>         from_mr_obj,
>  };
>
> +enum lookup_type {
> +       lookup_local,
> +       lookup_remote,
> +};
> +

https://www.kernel.org/doc/Documentation/process/coding-style.rst
"

12) Macros, Enums and RTL
-------------------------

Names of macros defining constants and labels in enums are capitalized.

"
Zhu Yanjun

>  u8 rxe_get_next_key(u32 last_key);
>  void rxe_mr_init_dma(struct rxe_pd *pd, int access, struct rxe_mr *mr);
> -
>  int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
>                      int access, struct ib_udata *udata, struct rxe_mr *mr);
> -
>  int rxe_mr_init_fast(struct rxe_pd *pd, int max_pages, struct rxe_mr *mr);
> -
>  int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr, int length,
>                 enum copy_direction dir, u32 *crcp);
> -
>  int copy_data(struct rxe_pd *pd, int access,
>               struct rxe_dma_info *dma, void *addr, int length,
>               enum copy_direction dir, u32 *crcp);
> -
>  void *iova_to_vaddr(struct rxe_mr *mr, u64 iova, int length);
> -
> -enum lookup_type {
> -       lookup_local,
> -       lookup_remote,
> -};
> -
>  struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>                          enum lookup_type type);
> -
>  int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length);
> -
> -void rxe_mr_cleanup(struct rxe_pool_entry *arg);
> -
>  int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey);
> +void rxe_mr_cleanup(struct rxe_pool_entry *arg);
>
>  /* rxe_mw.c */
>  int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
>  int rxe_dealloc_mw(struct ib_mw *ibmw);
>  int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
> +int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
>  void rxe_mw_cleanup(struct rxe_pool_entry *arg);
>
>  /* rxe_net.c */
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 7f2cfc1ce659..0f1791ed0350 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -55,21 +55,6 @@ static void rxe_mr_init(int access, struct rxe_mr *mr)
>         mr->map_shift = ilog2(RXE_BUF_PER_MAP);
>  }
>
> -void rxe_mr_cleanup(struct rxe_pool_entry *arg)
> -{
> -       struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
> -       int i;
> -
> -       ib_umem_release(mr->umem);
> -
> -       if (mr->map) {
> -               for (i = 0; i < mr->num_map; i++)
> -                       kfree(mr->map[i]);
> -
> -               kfree(mr->map);
> -       }
> -}
> -
>  static int rxe_mr_alloc(struct rxe_mr *mr, int num_buf)
>  {
>         int i;
> @@ -540,3 +525,47 @@ struct rxe_mr *lookup_mr(struct rxe_pd *pd, int access, u32 key,
>
>         return mr;
>  }
> +
> +int rxe_invalidate_mr(struct rxe_qp *qp, u32 rkey)
> +{
> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> +       struct rxe_mr *mr;
> +       int ret;
> +
> +       mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> +       if (!mr) {
> +               pr_err("%s: No MR for rkey %#x\n", __func__, rkey);
> +               ret = -EINVAL;
> +               goto err;
> +       }
> +
> +       if (rkey != mr->ibmr.rkey) {
> +               pr_err("%s: rkey (%#x) doesn't match mr->ibmr.rkey (%#x)\n",
> +                       __func__, rkey, mr->ibmr.rkey);
> +               ret = -EINVAL;
> +               goto err_drop_ref;
> +       }
> +
> +       mr->state = RXE_MR_STATE_FREE;
> +       ret = 0;
> +
> +err_drop_ref:
> +       rxe_drop_ref(mr);
> +err:
> +       return ret;
> +}
> +
> +void rxe_mr_cleanup(struct rxe_pool_entry *arg)
> +{
> +       struct rxe_mr *mr = container_of(arg, typeof(*mr), pelem);
> +       int i;
> +
> +       ib_umem_release(mr->umem);
> +
> +       if (mr->map) {
> +               for (i = 0; i < mr->num_map; i++)
> +                       kfree(mr->map[i]);
> +
> +               kfree(mr->map);
> +       }
> +}
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> index 6ced54126b72..4c1830b4a8bf 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -247,6 +247,73 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>         return ret;
>  }
>
> +static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
> +{
> +       if (unlikely(mw->state == RXE_MW_STATE_INVALID))
> +               return -EINVAL;
> +
> +       /* o10-37.2.26 */
> +       if (unlikely(mw->ibmw.type == IB_MW_TYPE_1))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static void do_invalidate_mw(struct rxe_mw *mw)
> +{
> +       struct rxe_qp *qp;
> +       struct rxe_mr *mr;
> +
> +       /* valid type 2 MW will always have a QP pointer */
> +       qp = mw->qp;
> +       mw->qp = NULL;
> +       rxe_drop_ref(qp);
> +
> +       /* valid type 2 MW will always have an MR pointer */
> +       mr = mw->mr;
> +       mw->mr = NULL;
> +       atomic_dec(&mr->num_mw);
> +       rxe_drop_ref(mr);
> +
> +       mw->access = 0;
> +       mw->addr = 0;
> +       mw->length = 0;
> +       mw->state = RXE_MW_STATE_FREE;
> +}
> +
> +int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
> +{
> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> +       unsigned long flags;
> +       struct rxe_mw *mw;
> +       int ret;
> +
> +       mw = rxe_pool_get_index(&rxe->mw_pool, rkey >> 8);
> +       if (!mw) {
> +               ret = -EINVAL;
> +               goto err;
> +       }
> +
> +       if (rkey != mw->ibmw.rkey) {
> +               ret = -EINVAL;
> +               goto err_drop_ref;
> +       }
> +
> +       spin_lock_irqsave(&mw->lock, flags);
> +
> +       ret = check_invalidate_mw(qp, mw);
> +       if (ret)
> +               goto err_unlock;
> +
> +       do_invalidate_mw(mw);
> +err_unlock:
> +       spin_unlock_irqrestore(&mw->lock, flags);
> +err_drop_ref:
> +       rxe_drop_ref(mw);
> +err:
> +       return ret;
> +}
> +
>  void rxe_mw_cleanup(struct rxe_pool_entry *elem)
>  {
>         struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 243602584a28..66fc208d0ec1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -558,25 +558,25 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>  static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>  {
>         u8 opcode = wqe->wr.opcode;
> -       struct rxe_dev *rxe;
>         struct rxe_mr *mr;
> -       u32 rkey;
>         int ret;
> +       u32 rkey;
>
>         switch (opcode) {
>         case IB_WR_LOCAL_INV:
> -               rxe = to_rdev(qp->ibqp.device);
>                 rkey = wqe->wr.ex.invalidate_rkey;
> -               mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
> -               if (!mr) {
> -                       pr_err("No MR for rkey %#x\n", rkey);
> +               if (rkey_is_mw(rkey))
> +                       ret = rxe_invalidate_mw(qp, rkey);
> +               else
> +                       ret = rxe_invalidate_mr(qp, rkey);
> +
> +               if (ret) {
>                         wqe->state = wqe_state_error;
>                         wqe->status = IB_WC_LOC_QP_OP_ERR;
> -                       return -EINVAL;
> +                       return ret;
>                 }
> -               mr->state = RXE_MR_STATE_FREE;
> -               rxe_drop_ref(mr);
>                 break;
> +
>         case IB_WR_REG_MR:
>                 mr = to_rmr(wqe->wr.wr.reg.mr);
>
> @@ -588,14 +588,16 @@ static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>                 mr->iova = wqe->wr.wr.reg.mr->iova;
>                 rxe_drop_ref(mr);
>                 break;
> +
>         case IB_WR_BIND_MW:
>                 ret = rxe_bind_mw(qp, wqe);
>                 if (ret) {
>                         wqe->state = wqe_state_error;
>                         wqe->status = IB_WC_MW_BIND_ERR;
> -                       return -EINVAL;
> +                       return ret;
>                 }
>                 break;
> +
>         default:
>                 pr_err("Unexpected send wqe opcode %d\n", opcode);
>                 wqe->state = wqe_state_error;
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 2b220659bddb..21adc9209107 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -35,6 +35,7 @@ enum resp_states {
>         RESPST_ERR_TOO_MANY_RDMA_ATM_REQ,
>         RESPST_ERR_RNR,
>         RESPST_ERR_RKEY_VIOLATION,
> +       RESPST_ERR_INVALIDATE_RKEY,
>         RESPST_ERR_LENGTH,
>         RESPST_ERR_CQ_OVERFLOW,
>         RESPST_ERROR,
> @@ -68,6 +69,7 @@ static char *resp_state_name[] = {
>         [RESPST_ERR_TOO_MANY_RDMA_ATM_REQ]      = "ERR_TOO_MANY_RDMA_ATM_REQ",
>         [RESPST_ERR_RNR]                        = "ERR_RNR",
>         [RESPST_ERR_RKEY_VIOLATION]             = "ERR_RKEY_VIOLATION",
> +       [RESPST_ERR_INVALIDATE_RKEY]            = "ERR_INVALIDATE_RKEY_VIOLATION",
>         [RESPST_ERR_LENGTH]                     = "ERR_LENGTH",
>         [RESPST_ERR_CQ_OVERFLOW]                = "ERR_CQ_OVERFLOW",
>         [RESPST_ERROR]                          = "ERROR",
> @@ -751,6 +753,14 @@ static void build_rdma_network_hdr(union rdma_network_hdr *hdr,
>                 memcpy(&hdr->ibgrh, ipv6_hdr(skb), sizeof(hdr->ibgrh));
>  }
>
> +static int invalidate_rkey(struct rxe_qp *qp, u32 rkey)
> +{
> +       if (rkey_is_mw(rkey))
> +               return rxe_invalidate_mw(qp, rkey);
> +       else
> +               return rxe_invalidate_mr(qp, rkey);
> +}
> +
>  /* Executes a new request. A retried request never reach that function (send
>   * and writes are discarded, and reads and atomics are retried elsewhere.
>   */
> @@ -790,6 +800,14 @@ static enum resp_states execute(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
>                 WARN_ON_ONCE(1);
>         }
>
> +       if (pkt->mask & RXE_IETH_MASK) {
> +               u32 rkey = ieth_rkey(pkt);
> +
> +               err = invalidate_rkey(qp, rkey);
> +               if (err)
> +                       return RESPST_ERR_INVALIDATE_RKEY;
> +       }
> +
>         /* next expected psn, read handles this separately */
>         qp->resp.psn = (pkt->psn + 1) & BTH_PSN_MASK;
>         qp->resp.ack_psn = qp->resp.psn;
> @@ -822,13 +840,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>         memset(&cqe, 0, sizeof(cqe));
>
>         if (qp->rcq->is_user) {
> -               uwc->status             = qp->resp.status;
> -               uwc->qp_num             = qp->ibqp.qp_num;
> -               uwc->wr_id              = wqe->wr_id;
> +               uwc->status             = qp->resp.status;
> +               uwc->qp_num             = qp->ibqp.qp_num;
> +               uwc->wr_id              = wqe->wr_id;
>         } else {
> -               wc->status              = qp->resp.status;
> -               wc->qp                  = &qp->ibqp;
> -               wc->wr_id               = wqe->wr_id;
> +               wc->status              = qp->resp.status;
> +               wc->qp                  = &qp->ibqp;
> +               wc->wr_id               = wqe->wr_id;
>         }
>
>         if (wc->status == IB_WC_SUCCESS) {
> @@ -883,27 +901,14 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>                         }
>
>                         if (pkt->mask & RXE_IETH_MASK) {
> -                               struct rxe_mr *rmr;
> -
>                                 wc->wc_flags |= IB_WC_WITH_INVALIDATE;
>                                 wc->ex.invalidate_rkey = ieth_rkey(pkt);
> -
> -                               rmr = rxe_pool_get_index(&rxe->mr_pool,
> -                                                        wc->ex.invalidate_rkey >> 8);
> -                               if (unlikely(!rmr)) {
> -                                       pr_err("Bad rkey %#x invalidation\n",
> -                                              wc->ex.invalidate_rkey);
> -                                       return RESPST_ERROR;
> -                               }
> -                               rmr->state = RXE_MR_STATE_FREE;
> -                               rxe_drop_ref(rmr);
>                         }
>
> -                       wc->qp                  = &qp->ibqp;
> -
>                         if (pkt->mask & RXE_DETH_MASK)
>                                 wc->src_qp = deth_sqp(pkt);
>
> +                       wc->qp                  = &qp->ibqp;
>                         wc->port_num            = qp->attr.port_num;
>                 }
>         }
> @@ -1314,6 +1319,13 @@ int rxe_responder(void *arg)
>                         }
>                         break;
>
> +               case RESPST_ERR_INVALIDATE_RKEY:
> +                       /* RC - Class J. */
> +                       qp->resp.goto_error = 1;
> +                       qp->resp.status = IB_WC_REM_INV_REQ_ERR;
> +                       state = RESPST_COMPLETE;
> +                       break;
> +
>                 case RESPST_ERR_LENGTH:
>                         if (qp_type(qp) == IB_QPT_RC) {
>                                 /* Class C */
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index 7da47b8c707b..b286a14ec282 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -286,6 +286,13 @@ struct rxe_map {
>         struct rxe_phys_buf     buf[RXE_BUF_PER_MAP];
>  };
>
> +static inline int rkey_is_mw(u32 rkey)
> +{
> +       u32 index = rkey >> 8;
> +
> +       return (index >= RXE_MIN_MW_INDEX) && (index <= RXE_MAX_MW_INDEX);
> +}
> +
>  struct rxe_mr {
>         struct rxe_pool_entry   pelem;
>         struct ib_mr            ibmr;
> @@ -311,23 +318,23 @@ struct rxe_mr {
>         u32                     max_buf;
>         u32                     num_map;
>
> -       struct rxe_map          **map;
> -
>         atomic_t                num_mw;
> +
> +       struct rxe_map          **map;
>  };
>
>  enum rxe_mw_state {
> -       RXE_MW_STATE_INVALID = RXE_MR_STATE_INVALID,
> -       RXE_MW_STATE_FREE = RXE_MR_STATE_FREE,
> -       RXE_MW_STATE_VALID = RXE_MR_STATE_VALID,
> +       RXE_MW_STATE_INVALID    = RXE_MR_STATE_INVALID,
> +       RXE_MW_STATE_FREE       = RXE_MR_STATE_FREE,
> +       RXE_MW_STATE_VALID      = RXE_MR_STATE_VALID,
>  };
>
>  struct rxe_mw {
> -       struct                  ib_mw ibmw;
> -       struct                  rxe_pool_entry pelem;
> +       struct ib_mw            ibmw;
> +       struct rxe_pool_entry   pelem;
>         spinlock_t              lock;
>         enum rxe_mw_state       state;
> -       struct rxe_qp           *qp;    /* Type 2 only */
> +       struct rxe_qp           *qp; /* Type 2 only */
>         struct rxe_mr           *mr;
>         int                     access;
>         u64                     addr;
> --
> 2.27.0
>
