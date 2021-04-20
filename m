Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C41365264
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 08:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhDTGeu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 02:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhDTGet (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Apr 2021 02:34:49 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA7C06174A
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 23:34:19 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so28985162oti.9
        for <linux-rdma@vger.kernel.org>; Mon, 19 Apr 2021 23:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sNmbNR2kd1mw8aQKfGhrLUx0ZVD1272q9EY3LDkDOjM=;
        b=aDuGtLks6PWpeagxWmB6AQJahbV7GKxv3WlG7HpQwQo59uqC1mPhtcV6jKKJ613UJO
         WV1t/DPT2coGqcCeNqcVDGYR2+f7goOyTUzvidoIHqMUFllk5KXiMPnvaSP7r62yGAIE
         3Rq5CsWwqUTlTXM6+YDWHvvaWLKchCi8mJ4et2qq//aeZRmcsRrqw1f0pKSxeJ/fC45i
         4IwCxeWue/niqVljIQS0PS2EKDGJON2lKDVBRGVtzUb8qh0RFIOxfIGyzJI3011ZGzOb
         suJHkZpeuTDU2j5hqemoCJ8sy/t4f4qdxRmKybGNDBzfMfmfmgUbRPpiSzSqRMnVLTKo
         iKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sNmbNR2kd1mw8aQKfGhrLUx0ZVD1272q9EY3LDkDOjM=;
        b=TdOoge6qLPAJr949K04A8m4lUa9oa+5Nal9lD8vloQjoQ11feoHy0q3sp63i0Lmo3e
         0/rk7zTj+6Xb+2HUHXI/7nQqpbLhHN9PqWBg+4LQ+2IS9wphkGHrc+uy0ktznnviIXoT
         EPGTTbmXOVne/pV6ZJvcqKPOzSHC/xcC7hzskviv91p8MbbrwOOx7TYvx9Sh1m9yvaIJ
         TZHZLejYB9y5kPNfqb4h1Ksw8Uir62cWb7D+eBdbUf+D8sU9DeOAAD+0ixYtvuM3+y8v
         xTJaTcIkFCDi4H9R27cA4Wt994uChuG081r3bk+UYsKC46ENKQY7zdoAKgVSNvcYycjQ
         slGQ==
X-Gm-Message-State: AOAM532KHsZVcE04KuEfW5PFdyuhvHiGl6bn53YreoLkVGeUHNjOPgAL
        QkG9hFVC1+6iqHap0N8FqhgzXD7AQksGT+mQ1A8=
X-Google-Smtp-Source: ABdhPJyM4lJZ7FZdiQSqdwOIN0uBN9gJNVqII5b8c2iFeY0NoIY/JonqelvlXP2uLc3O5KPRRnv/SvcE393llCGKPEQ=
X-Received: by 2002:a9d:74ca:: with SMTP id a10mr17618326otl.53.1618900458533;
 Mon, 19 Apr 2021 23:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210415025429.11053-1-rpearson@hpe.com> <20210415025429.11053-10-rpearson@hpe.com>
In-Reply-To: <20210415025429.11053-10-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Tue, 20 Apr 2021 14:34:07 +0800
Message-ID: <CAD=hENfnffpYsxVNFUXDEedcGJ5oq3x-SrhKT23Y=6wiYYa3Tg@mail.gmail.com>
Subject: Re: [PATCH for-next v2 9/9] RDMA/rxe: Implement memory access through MWs
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
> Add code to implement memory access through memory windows.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
> v2:
>   Removed a copy of changes in ea4922518940 "Fix missing acks from responder"
>   that was submitted separately.
>
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
>  drivers/infiniband/sw/rxe/rxe_mw.c    | 23 +++++++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c  | 55 +++++++++++++++++++--------
>  drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++
>  4 files changed, 75 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 7f1117c51e30..99158d11dae7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -104,6 +104,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
>  int rxe_dealloc_mw(struct ib_mw *ibmw);
>  int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>  int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
> +struct rxe_mw *lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
>  void rxe_mw_cleanup(struct rxe_pool_entry *arg);
>
>  /* rxe_net.c */
> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> index 4c1830b4a8bf..e443e4672e00 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> @@ -314,6 +314,29 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
>         return ret;
>  }
>
> +struct rxe_mw *lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
> +{
> +       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> +       struct rxe_pd *pd = to_rpd(qp->ibqp.pd);
> +       struct rxe_mw *mw;
> +       int index = rkey >> 8;
> +
> +       mw = rxe_pool_get_index(&rxe->mw_pool, index);
> +       if (!mw)
> +               return NULL;
> +
> +       if (unlikely((mw_rkey(mw) != rkey) || mw_pd(mw) != pd ||
> +                    (mw->ibmw.type == IB_MW_TYPE_2 && mw->qp != qp) ||
> +                    (mw->length == 0) ||
> +                    (access && !(access & mw->access)) ||
> +                    mw->state != RXE_MW_STATE_VALID)) {
> +               rxe_drop_ref(mw);
> +               return NULL;
> +       }
> +
> +       return mw;
> +}
> +
>  void rxe_mw_cleanup(struct rxe_pool_entry *elem)
>  {
>         struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 21adc9209107..9410b8576abe 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -394,6 +394,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>                                    struct rxe_pkt_info *pkt)
>  {
>         struct rxe_mr *mr = NULL;
> +       struct rxe_mw *mw = NULL;
>         u64 va;
>         u32 rkey;
>         u32 resid;
> @@ -405,6 +406,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>         if (pkt->mask & (RXE_READ_MASK | RXE_WRITE_MASK)) {
>                 if (pkt->mask & RXE_RETH_MASK) {
>                         qp->resp.va = reth_va(pkt);
> +                       qp->resp.offset = 0;
>                         qp->resp.rkey = reth_rkey(pkt);
>                         qp->resp.resid = reth_len(pkt);
>                         qp->resp.length = reth_len(pkt);
> @@ -413,6 +415,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>                                                      : IB_ACCESS_REMOTE_WRITE;
>         } else if (pkt->mask & RXE_ATOMIC_MASK) {
>                 qp->resp.va = atmeth_va(pkt);
> +               qp->resp.offset = 0;
>                 qp->resp.rkey = atmeth_rkey(pkt);
>                 qp->resp.resid = sizeof(u64);
>                 access = IB_ACCESS_REMOTE_ATOMIC;
> @@ -432,18 +435,36 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>         resid   = qp->resp.resid;
>         pktlen  = payload_size(pkt);
>
> -       mr = lookup_mr(qp->pd, access, rkey, lookup_remote);
> -       if (!mr) {
> -               state = RESPST_ERR_RKEY_VIOLATION;
> -               goto err;
> -       }
> +       if (rkey_is_mw(rkey)) {
> +               mw = lookup_mw(qp, access, rkey);
> +               if (!mw) {
> +                       pr_err("%s: no MW matches rkey %#x\n", __func__, rkey);
> +                       state = RESPST_ERR_RKEY_VIOLATION;
> +                       goto err;
> +               }
>
> -       if (unlikely(mr->state == RXE_MR_STATE_FREE)) {
> -               state = RESPST_ERR_RKEY_VIOLATION;
> -               goto err;
> +               mr = mw->mr;
> +               if (!mr) {
> +                       pr_err("%s: MW doesn't have an MR\n", __func__);
> +                       state = RESPST_ERR_RKEY_VIOLATION;
> +                       goto err;
> +               }
> +
> +               if (mw->access & IB_ZERO_BASED)
> +                       qp->resp.offset = mw->addr;
> +
> +               rxe_drop_ref(mw);
> +               rxe_add_ref(mr);
> +       } else {
> +               mr = lookup_mr(qp->pd, access, rkey, lookup_remote);
> +               if (!mr) {
> +                       pr_err("%s: no MR matches rkey %#x\n", __func__, rkey);
> +                       state = RESPST_ERR_RKEY_VIOLATION;
> +                       goto err;
> +               }
>         }
>
> -       if (mr_check_range(mr, va, resid)) {
> +       if (mr_check_range(mr, va + qp->resp.offset, resid)) {
>                 state = RESPST_ERR_RKEY_VIOLATION;
>                 goto err;
>         }
> @@ -477,6 +498,9 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
>  err:
>         if (mr)
>                 rxe_drop_ref(mr);
> +       if (mw)
> +               rxe_drop_ref(mw);
> +
>         return state;
>  }
>
> @@ -501,8 +525,8 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
>         int     err;
>         int data_len = payload_size(pkt);
>
> -       err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt), data_len,
> -                         to_mr_obj, NULL);
> +       err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
> +                         payload_addr(pkt), data_len, to_mr_obj, NULL);
>         if (err) {
>                 rc = RESPST_ERR_RKEY_VIOLATION;
>                 goto out;
> @@ -521,7 +545,6 @@ static DEFINE_SPINLOCK(atomic_ops_lock);
>  static enum resp_states process_atomic(struct rxe_qp *qp,
>                                        struct rxe_pkt_info *pkt)
>  {
> -       u64 iova = atmeth_va(pkt);
>         u64 *vaddr;
>         enum resp_states ret;
>         struct rxe_mr *mr = qp->resp.mr;
> @@ -531,7 +554,7 @@ static enum resp_states process_atomic(struct rxe_qp *qp,
>                 goto out;
>         }
>
> -       vaddr = iova_to_vaddr(mr, iova, sizeof(u64));
> +       vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
>
>         /* check vaddr is 8 bytes aligned. */
>         if (!vaddr || (uintptr_t)vaddr & 7) {
> @@ -655,8 +678,10 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>                 res->type               = RXE_READ_MASK;
>                 res->replay             = 0;
>
> -               res->read.va            = qp->resp.va;
> -               res->read.va_org        = qp->resp.va;
> +               res->read.va            = qp->resp.va +
> +                                         qp->resp.offset;
> +               res->read.va_org        = qp->resp.va +
> +                                         qp->resp.offset;
>
>                 res->first_psn          = req_pkt->psn;
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index b286a14ec282..9f35e2c042d0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -183,6 +183,7 @@ struct rxe_resp_info {
>
>         /* RDMA read / atomic only */
>         u64                     va;
> +       u64                     offset;
>         struct rxe_mr           *mr;
>         u32                     resid;
>         u32                     rkey;
> @@ -470,6 +471,16 @@ static inline u32 mr_rkey(struct rxe_mr *mr)
>         return mr->ibmr.rkey;
>  }
>
> +static inline struct rxe_pd *mw_pd(struct rxe_mw *mw)

inline
Can we remove inline keyword and let the compile to decide it?

> +{
> +       return to_rpd(mw->ibmw.pd);
> +}
> +
> +static inline u32 mw_rkey(struct rxe_mw *mw)

inline
the same.

Zhu Yanjun
> +{
> +       return mw->ibmw.rkey;
> +}
> +
>  int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
>
>  void rxe_mc_cleanup(struct rxe_pool_entry *arg);
> --
> 2.27.0
>
