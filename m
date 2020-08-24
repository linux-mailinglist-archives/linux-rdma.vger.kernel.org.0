Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7729F24F6B4
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 11:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgHXJDZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 05:03:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730801AbgHXJCm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Aug 2020 05:02:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74AED2072D;
        Mon, 24 Aug 2020 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259761;
        bh=eqhPnroEFm63WMb2dmScY3sAzX0fZC2lD0Qneohj33k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqQhrlJnzJrPHWSxh5Ogbry1PDf2O4VtcZUfjdd0zCpOM8TGNpbEWUmJdndHOTSo2
         0QzpTAQQf0Sf5l1XAj4cc/BeWWsK3GjdxxBsX6o98PDwwgOUZROgX6RrhgIAkcvU6R
         jTD1HaZ1qUOM9EVHUxPrpB7YxkwIsnMcx9+AC9MI=
Date:   Mon, 24 Aug 2020 12:02:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH v3 17/17] rdma_rxe: minor cleanups
Message-ID: <20200824090237.GJ571722@unreal>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-18-rpearson@hpe.com>
 <a153a775-9b53-3ccc-4c2a-ec76f863d1a1@gmail.com>
 <abf9804c-8fc7-7f2d-f73d-0c9260f5cf60@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abf9804c-8fc7-7f2d-f73d-0c9260f5cf60@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 21, 2020 at 11:05:43PM -0500, Bob Pearson wrote:
> On 8/21/20 9:14 PM, Zhu Yanjun wrote:
> > On 8/21/2020 6:46 AM, Bob Pearson wrote:
> >> Added vendor_part_id
> >> Fixed bug in rxe_resp.c at RKEY_VIOLATION: failed to ack bad rkeys
> >> Fixed failure to init mr in rxe_resp.c at check_rkey
> >> Fixed failure to allow invalidation of invalid MWs
> >>
> >> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe.c       |  1 +
> >>   drivers/infiniband/sw/rxe/rxe_mw.c    | 20 ++++++++++++--------
> >>   drivers/infiniband/sw/rxe/rxe_param.h |  1 +
> >>   drivers/infiniband/sw/rxe/rxe_resp.c  |  9 ++++++---
> >>   4 files changed, 20 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> >> index 10f441ac7203..11b043edd647 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe.c
> >> @@ -43,6 +43,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
> >>       rxe->max_inline_data            = RXE_MAX_INLINE_DATA;
> >>         rxe->attr.vendor_id            = RXE_VENDOR_ID;
> >> +    rxe->attr.vendor_part_id        = RXE_VENDOR_PART_ID;
> >>       rxe->attr.max_mr_size            = RXE_MAX_MR_SIZE;
> >>       rxe->attr.page_size_cap            = RXE_PAGE_SIZE_CAP;
> >>       rxe->attr.max_qp            = RXE_MAX_QP;
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
> >> index 4178cf501a2b..a443deae35a3 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
> >> @@ -28,7 +28,6 @@ static void rxe_set_mw_rkey(struct rxe_mw *mw)
> >>       pr_err_once("unable to get random rkey for mw\n");
> >>   }
> >>   -/* this temporary code to test ibv_alloc_mw, ibv_dealloc_mw */
> >>   struct ib_mw *rxe_alloc_mw(struct ib_pd *ibpd, enum ib_mw_type type,
> >>                  struct ib_udata *udata)
> >>   {
> >> @@ -326,9 +325,12 @@ int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
> >>     static int check_invalidate_mw(struct rxe_qp *qp, struct rxe_mw *mw)
> >>   {
> >> -    if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
> >> -        pr_err_once("attempt to invalidate a MW that is not valid\n");
> >> -        return -EINVAL;
> >> +    /* run_test requires invalidate to work when !valid so don't check */
> >> +    if (0) {
> >> +        if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
> >> +            pr_err_once("attempt to invalidate a MW that is not valid\n");
> >> +            return -EINVAL;
> >> +        }
> >>       }
> >>         /* o10-37.2.26 */
> >> @@ -344,9 +346,11 @@ static void do_invalidate_mw(struct rxe_mw *mw)
> >>   {
> >>       mw->qp = NULL;
> >>   -    rxe_drop_ref(mw->mr);
> >> -    atomic_dec(&mw->mr->num_mw);
> >> -    mw->mr = NULL;
> >> +    if (mw->mr) {
> >> +        rxe_drop_ref(mw->mr);
> >> +        atomic_dec(&mw->mr->num_mw);
> >> +        mw->mr = NULL;
> >> +    }
> >>         mw->access = 0;
> >>       mw->addr = 0;
> >> @@ -378,7 +382,7 @@ int rxe_mw_check_access(struct rxe_qp *qp, struct rxe_mw *mw,
> >>       struct rxe_pd *pd = to_rpd(mw->ibmw.pd);
> >>         if (unlikely(mw->state != RXE_MEM_STATE_VALID)) {
> >> -        pr_err_once("attempt to access a MW that is not in the valid state\n");
> >> +        pr_err_once("attempt to access a MW that is not valid\n");
> >>           return -EINVAL;
> >>       }
> >>   diff --git a/drivers/infiniband/sw/rxe/rxe_param.h b/drivers/infiniband/sw/rxe/rxe_param.h
> >> index e1d485bdd6af..beaa3f844819 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_param.h
> >> +++ b/drivers/infiniband/sw/rxe/rxe_param.h
> >> @@ -107,6 +107,7 @@ enum rxe_device_param {
> >>         /* IBTA v1.4 A3.3.1 VENDOR INFORMATION section */
> >>       RXE_VENDOR_ID            = 0XFFFFFF,
> >> +    RXE_VENDOR_PART_ID        = 1,
> >
> > RXE_VENDOR_PART_ID can be zero.
> >
> > Zhu Yanjun
> >
> >>   };
> >>     /* default/initial rxe port parameters */
> >> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> index d6e957a34910..bf7ef56aaf1c 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> >> @@ -392,8 +392,8 @@ static enum resp_states check_length(struct rxe_qp *qp,
> >>   static enum resp_states check_rkey(struct rxe_qp *qp,
> >>                      struct rxe_pkt_info *pkt)
> >>   {
> >> -    struct rxe_mr *mr;
> >> -    struct rxe_mw *mw;
> >> +    struct rxe_mr *mr = NULL;
> >> +    struct rxe_mw *mw = NULL;
> >>       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
> >>       u64 va;
> >>       u32 rkey;
> >> @@ -1368,7 +1368,10 @@ int rxe_responder(void *arg)
> >>                   /* Class C */
> >>                   do_class_ac_error(qp, AETH_NAK_REM_ACC_ERR,
> >>                             IB_WC_REM_ACCESS_ERR);
> >> -                state = RESPST_COMPLETE;
> >> +                if (qp->resp.wqe)
> >> +                    state = RESPST_COMPLETE;
> >> +                else
> >> +                    state = RESPST_ACKNOWLEDGE;
> >>               } else {
> >>                   qp->resp.drop_msg = 1;
> >>                   if (qp->srq) {
> >
> >
> >
> I would agree but the pyverbs tests do not agree. If someone will fix the test I would be happy to leave it zero.

So please fix the pyverbs, together with SIW.
I don't like the idea of setting vendor_part_id randomly.

From IBTA, "A3.3.1 VENDOR INFORMATION":
A vendor that produces a generic controller (i.e., one that supports a standard
I/O protocol such as SRP), which does not have vendor specific device drivers,
may use the value of 0xFFFFFF in the VendorID field.
However, such a value prevents the vendor from ever providing vendor specific
drivers for the product

Thanks
