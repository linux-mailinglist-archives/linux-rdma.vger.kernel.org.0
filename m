Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E956336E4EC
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 08:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhD2Gcq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Apr 2021 02:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2Gcp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Apr 2021 02:32:45 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEECCC06138B
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 23:31:59 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id r3so12136023oic.1
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 23:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R2nSjjbTqGnPL1ziWw2B3g52MXTQIl8E2JX8VoeuOaE=;
        b=Mfc4yiFdy3dbGC+6twiY708WUedkhQxQksBsSxGFQBFCxxMvOEYWQ3CYClyQexzgyB
         QkZVeQAwcYiv4dN68NPBSRJ8q7uFv03MVeZn8Nu1yihWL7pHUy9Iu6fEIQSloVK8RzEx
         ACJV4ZCLPz5XEFHNgaNb6ghugBQ0kQdceGtD/uXeMYdhEFjIVm0l8hGuHQ7GAXkS9Sz4
         vg+H5ydn7W5uvELY9eFcT5SkOn3ODe04XqG6FWzXlzylabUqFVNKva/EvCbAOffFI+2H
         +60tWOI44Wc/LCa7pJZT42v3leUlihgKEHsasMgUdWYpYq/lD92a1t63ruVQf+vYoCpt
         KqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R2nSjjbTqGnPL1ziWw2B3g52MXTQIl8E2JX8VoeuOaE=;
        b=iUi+Hn1XTgXci+/SwbC/0X/ppM5vxrPAt7D7FqGxRc+illAnnso/WrehNgvmM63Sn1
         VLEPjCkEwpAO+sZESbAAhDvGCs5x7AxRZ9CbtNGxL0eOwR2m4nDPXxIGd4fIY0p4qfHM
         VVpiVY+sunlMC0hudxrxQgJIjHzPIaKczFUrswfezK66HfrzASUiT1r3YdNKXS5Pu4fQ
         qtwjH91w2vTBrKAxhFeM/Dpzz14PDySblbLCjhcaXnRbl/ptMYVBgnPYnA6t/2YUOdku
         e1xCf5jozltYAtdQvjwMeMocdl5BoFM9V6YOfeXnP6isHOTsxSEWrhPyvQ4QsEsGZeMB
         tlZQ==
X-Gm-Message-State: AOAM531mCpNmals7BytaaqZpj91OKXEs5UlsrQECbPJpG+IzibV+2Tgt
        ajmHGniM4Kxj1QBQMkAW7C1Q0j6NDlgIfTvZHXw=
X-Google-Smtp-Source: ABdhPJzOINoCQPRS2IgCYBBU8jHbHLOwKN8FRf2I0yGAdnXxjx9AhZzqNw8CDgRKc8ix8P0OFfKXvblb/i39Gpvge3Y=
X-Received: by 2002:aca:4b90:: with SMTP id y138mr23289979oia.169.1619677919153;
 Wed, 28 Apr 2021 23:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <37e1d1ec-67fe-4878-3793-a324ac613f7f@gmail.com> <254c00b2-0a1d-b349-e964-11989905aacb@gmail.com>
In-Reply-To: <254c00b2-0a1d-b349-e964-11989905aacb@gmail.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Date:   Thu, 29 Apr 2021 14:31:47 +0800
Message-ID: <CAD=hENecDckJeODMVhjnjNdchstdpSrqTo+=_oP6M6qN8f9u6g@mail.gmail.com>
Subject: Re: [PATCH for-next v5 09/10] RDMA/rxe: Implement memory access
 through MWs
To:     "Pearson, Robert B" <rpearsonhpe@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 29, 2021 at 12:10 AM Pearson, Robert B
<rpearsonhpe@gmail.com> wrote:
>
>
> On 4/24/2021 11:23 PM, Zhu Yanjun wrote:
> > On Fri, Apr 23, 2021 at 12:13 AM Bob Pearson <rpearsonhpe@gmail.com>
> > wrote:
> >> Add code to implement memory access through memory windows.
> >>
> >> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> >> ---
> >> v3:
> >> Adjusted patch for collisions with v3 of "RDMA/rxe: Implement
> >> invalidate MW operations" patch.
> >> v2:
> >> Removed a copy of changes in ea4922518940 "Fix missing acks from
> >> responder"
> >> that was submitted separately.
> >> ---
> >> drivers/infiniband/sw/rxe/rxe_loc.h | 1 +
> >> drivers/infiniband/sw/rxe/rxe_mw.c | 23 +++++++++++
> >> drivers/infiniband/sw/rxe/rxe_resp.c | 55 +++++++++++++++++++--------
> >> drivers/infiniband/sw/rxe/rxe_verbs.h | 11 ++++++
> >> 4 files changed, 75 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h
> >> b/drivers/infiniband/sw/rxe/rxe_loc.h
> >> index bc0e484f8cde..076e1460577f 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> >> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> >> @@ -94,6 +94,7 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct
> >> ib_udata *udata);
> >> int rxe_dealloc_mw(struct ib_mw *ibmw);
> >> int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
> >> int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey);
> >> +struct rxe_mw *lookup_mw(struct rxe_qp *qp, int access, u32 rkey);
> >> void rxe_mw_cleanup(struct rxe_pool_entry *arg);
> >>
> >> /* rxe_net.c */
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c
> >> b/drivers/infiniband/sw/rxe/rxe_mw.c
> >> index 00490f232fde..6ed36845c693 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> >> @@ -312,6 +312,29 @@ int rxe_invalidate_mw(struct rxe_qp *qp, u32 rkey)
> >> return ret;
> >> }
> >>
> >> +struct rxe_mw *lookup_mw(struct rxe_qp *qp, int access, u32 rkey)
> > will this function lookup_mw be used outside of softroce?
> > If not, how about changing the name from lookup_mw to rxe_lookup_mw?
> >
> > Thanks
> > Zhu Yanjun
>
> I would think the opposite is correct. If a name is used outside of the
> driver then the prefix reduces the chance
>
> of a collision with some more global name. If it is only used locally in
> the driver this is less of an issue. Mostly
>
> I have been following the rule that if a name is shared between files in
> rxe then add the prefix and if it is local

We are not on the same page. What I said is about debugging and
 maintenance easily.

Zhu Yanjun

>
> to a file (e.g. static) then drop it. Here I broke that and will make
> this change. If a routine is frequently used
>
> for example to_rdev() then the prefix just gets in the way of clarity.
> The shared names are declared in rxe_loc.h.
>
> The common names are defined in rxe_verbs.h.
>
> Bob
>
> >
> >> +{
> >> + struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> >> + struct rxe_pd *pd = to_rpd(qp->ibqp.pd);
> >> + struct rxe_mw *mw;
> >> + int index = rkey >> 8;
> >> +
> >> + mw = rxe_pool_get_index(&rxe->mw_pool, index);
> >> + if (!mw)
> >> + return NULL;
> >> +
> >> + if (unlikely((mw_rkey(mw) != rkey) || mw_pd(mw) != pd ||
> >> + (mw->ibmw.type == IB_MW_TYPE_2 && mw->qp != qp) ||
> >> + (mw->length == 0) ||
> >> + (access && !(access & mw->access)) ||
> >> + mw->state != RXE_MW_STATE_VALID)) {
> >> + rxe_drop_ref(mw);
> >> + return NULL;
> >> + }
> >> +
> >> + return mw;
> >> +}
> >> +
> >> void rxe_mw_cleanup(struct rxe_pool_entry *elem)
> >> {
> >> struct rxe_mw *mw = container_of(elem, typeof(*mw), pelem);
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c
> >> b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> index 759e9789cd4d..9c8cbfbc8820 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> @@ -394,6 +394,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
> >> struct rxe_pkt_info *pkt)
> >> {
> >> struct rxe_mr *mr = NULL;
> >> + struct rxe_mw *mw = NULL;
> >> u64 va;
> >> u32 rkey;
> >> u32 resid;
> >> @@ -405,6 +406,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
> >> if (pkt->mask & (RXE_READ_MASK | RXE_WRITE_MASK)) {
> >> if (pkt->mask & RXE_RETH_MASK) {
> >> qp->resp.va = reth_va(pkt);
> >> + qp->resp.offset = 0;
> >> qp->resp.rkey = reth_rkey(pkt);
> >> qp->resp.resid = reth_len(pkt);
> >> qp->resp.length = reth_len(pkt);
> >> @@ -413,6 +415,7 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
> >> : IB_ACCESS_REMOTE_WRITE;
> >> } else if (pkt->mask & RXE_ATOMIC_MASK) {
> >> qp->resp.va = atmeth_va(pkt);
> >> + qp->resp.offset = 0;
> >> qp->resp.rkey = atmeth_rkey(pkt);
> >> qp->resp.resid = sizeof(u64);
> >> access = IB_ACCESS_REMOTE_ATOMIC;
> >> @@ -432,18 +435,36 @@ static enum resp_states check_rkey(struct
> >> rxe_qp *qp,
> >> resid = qp->resp.resid;
> >> pktlen = payload_size(pkt);
> >>
> >> - mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
> >> - if (!mr) {
> >> - state = RESPST_ERR_RKEY_VIOLATION;
> >> - goto err;
> >> - }
> >> + if (rkey_is_mw(rkey)) {
> >> + mw = lookup_mw(qp, access, rkey);
> >> + if (!mw) {
> >> + pr_err("%s: no MW matches rkey %#x\n", __func__, rkey);
> >> + state = RESPST_ERR_RKEY_VIOLATION;
> >> + goto err;
> >> + }
> >>
> >> - if (unlikely(mr->state == RXE_MR_STATE_FREE)) {
> >> - state = RESPST_ERR_RKEY_VIOLATION;
> >> - goto err;
> >> + mr = mw->mr;
> >> + if (!mr) {
> >> + pr_err("%s: MW doesn't have an MR\n", __func__);
> >> + state = RESPST_ERR_RKEY_VIOLATION;
> >> + goto err;
> >> + }
> >> +
> >> + if (mw->access & IB_ZERO_BASED)
> >> + qp->resp.offset = mw->addr;
> >> +
> >> + rxe_drop_ref(mw);
> >> + rxe_add_ref(mr);
> >> + } else {
> >> + mr = lookup_mr(qp->pd, access, rkey, RXE_LOOKUP_REMOTE);
> >> + if (!mr) {
> >> + pr_err("%s: no MR matches rkey %#x\n", __func__, rkey);
> >> + state = RESPST_ERR_RKEY_VIOLATION;
> >> + goto err;
> >> + }
> >> }
> >>
> >> - if (mr_check_range(mr, va, resid)) {
> >> + if (mr_check_range(mr, va + qp->resp.offset, resid)) {
> >> state = RESPST_ERR_RKEY_VIOLATION;
> >> goto err;
> >> }
> >> @@ -477,6 +498,9 @@ static enum resp_states check_rkey(struct rxe_qp *qp,
> >> err:
> >> if (mr)
> >> rxe_drop_ref(mr);
> >> + if (mw)
> >> + rxe_drop_ref(mw);
> >> +
> >> return state;
> >> }
> >>
> >> @@ -501,8 +525,8 @@ static enum resp_states write_data_in(struct
> >> rxe_qp *qp,
> >> int err;
> >> int data_len = payload_size(pkt);
> >>
> >> - err = rxe_mr_copy(qp->resp.mr, qp->resp.va, payload_addr(pkt),
> >> data_len,
> >> - RXE_TO_MR_OBJ, NULL);
> >> + err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
> >> + payload_addr(pkt), data_len, RXE_TO_MR_OBJ, NULL);
> >> if (err) {
> >> rc = RESPST_ERR_RKEY_VIOLATION;
> >> goto out;
> >> @@ -521,7 +545,6 @@ static DEFINE_SPINLOCK(atomic_ops_lock);
> >> static enum resp_states process_atomic(struct rxe_qp *qp,
> >> struct rxe_pkt_info *pkt)
> >> {
> >> - u64 iova = atmeth_va(pkt);
> >> u64 *vaddr;
> >> enum resp_states ret;
> >> struct rxe_mr *mr = qp->resp.mr;
> >> @@ -531,7 +554,7 @@ static enum resp_states process_atomic(struct
> >> rxe_qp *qp,
> >> goto out;
> >> }
> >>
> >> - vaddr = iova_to_vaddr(mr, iova, sizeof(u64));
> >> + vaddr = iova_to_vaddr(mr, qp->resp.va + qp->resp.offset, sizeof(u64));
> >>
> >> /* check vaddr is 8 bytes aligned. */
> >> if (!vaddr || (uintptr_t)vaddr & 7) {
> >> @@ -655,8 +678,10 @@ static enum resp_states read_reply(struct rxe_qp
> >> *qp,
> >> res->type = RXE_READ_MASK;
> >> res->replay = 0;
> >>
> >> - res->read.va = qp->resp.va;
> >> - res->read.va_org = qp->resp.va;
> >> + res->read.va = qp->resp.va +
> >> + qp->resp.offset;
> >> + res->read.va_org = qp->resp.va +
> >> + qp->resp.offset;
> >>
> >> res->first_psn = req_pkt->psn;
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h
> >> b/drivers/infiniband/sw/rxe/rxe_verbs.h
> >> index 74fcd871757d..f426bf30f86a 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> >> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> >> @@ -183,6 +183,7 @@ struct rxe_resp_info {
> >>
> >> /* RDMA read / atomic only */
> >> u64 va;
> >> + u64 offset;
> >> struct rxe_mr *mr;
> >> u32 resid;
> >> u32 rkey;
> >> @@ -480,6 +481,16 @@ static inline u32 mr_rkey(struct rxe_mr *mr)
> >> return mr->ibmr.rkey;
> >> }
> >>
> >> +static inline struct rxe_pd *mw_pd(struct rxe_mw *mw)
> > rxe_mw_pd
> No. See above.
> >
> >> +{
> >> + return to_rpd(mw->ibmw.pd);
> >> +}
> >> +
> >> +static inline u32 mw_rkey(struct rxe_mw *mw)
> > rxe_mw_rkey
> No.
> >
> >> +{
> >> + return mw->ibmw.rkey;
> >> +}
> >> +
> >> int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name);
> >>
> >> void rxe_mc_cleanup(struct rxe_pool_entry *arg);
> >> --
> >> 2.27.0
> >>
