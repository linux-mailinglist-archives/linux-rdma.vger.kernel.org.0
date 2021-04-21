Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF9366486
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 06:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhDUEZv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 00:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhDUEZq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 00:25:46 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E7C06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 21:24:44 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id e25so11270002oii.2
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 21:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sqlbO0dgcV9iVk4AeWRXq0KSrCi+BQQdVUL0R8zjidI=;
        b=TJAYA31bDOBdJewkW11lIcUes2cmyJAdJWZKrtZvTXyDgTDGC07wfdFLYmQeV2p71u
         pnppKdj9vBDJo63TGhhCDy5PNNETffNTavYkTVGCCG6RiscuTdhcZYTWAD54gdvy1boQ
         PjYOvYnUIPqmSCQdygMq8HV9QBVrJvtu0sGnU/aOeEe5op/Un+LCFyGvrVq6GEGB8Cqz
         nVl0CC4QCr+ErcR1EtRaLNJM9ryRGUnDFzJy/znwem9C+RMcNFhyk5g/Zyt1bHtAaG5H
         QUWMFeG3txYVeqM6OQ7NV+hYA83OdyYSlUllXFBjW4LaswPd6hMQdm8jW7nCWVQG3Iid
         LH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqlbO0dgcV9iVk4AeWRXq0KSrCi+BQQdVUL0R8zjidI=;
        b=kxhT+3rUs4E6yzd2V+j3g15/hB6XCCzsAtAtmv0ESJxVEt7HYXa3jedKm1QDmqAbJS
         U8m+pSSEAFu6bSsFhKvQYusv1eB4c1NUAx2XHNWzQyAFFXS7RRvOxfNCgN1LXxSWK/PF
         l2ONPZwtJ1MZz4cKGVjaoTrOuAYL2dxtLv4pO6jXDqknIJQ18NQDsRQPWU6xjbukKYd+
         pUht8j3cK5e/xpv82qh/OUYCFkWYzQB261k+P8aJB2spGlMJbd+nay37slWGw50cZcF6
         D/AxsvKnJsvR1Q3ZHU8iDPImFXhFsTP88QwX8AOgmZ0d7cB1rADw/Vsx/h+JgzVjnhoW
         XxPQ==
X-Gm-Message-State: AOAM533m/D/DvPsmBxR8i/RewHyxr7OcNvrVAZeJx/vNwfbGgn3NJW4k
        XLYx7S+N2ctECU2zWP8EHM0e1PnaPJ8=
X-Google-Smtp-Source: ABdhPJwvwewNdqORkpSpcBeULziRkx8OsfkpX+Egdb7VbCrvtbK8oMXHcbSbSPCyldnO/+ORqdt9RA==
X-Received: by 2002:aca:f2c1:: with SMTP id q184mr5383063oih.29.1618979083810;
        Tue, 20 Apr 2021 21:24:43 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:b446:281e:a20a:b0d2? (2603-8081-140c-1a00-b446-281e-a20a-b0d2.res6.spectrum.com. [2603:8081:140c:1a00:b446:281e:a20a:b0d2])
        by smtp.gmail.com with ESMTPSA id m133sm262524oia.22.2021.04.20.21.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 21:24:43 -0700 (PDT)
Subject: Re: [PATCH for-next v2 7/9] RDMA/rxe: Add support for bind MW work
 requests
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210415025429.11053-1-rpearson@hpe.com>
 <20210415025429.11053-8-rpearson@hpe.com>
 <CAD=hENf8SA2==WhtufkcesuJH7cMys8vPNj4_1a=OAaE2GREOA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <7e799159-f39d-755d-cf5b-a58367e54d19@gmail.com>
Date:   Tue, 20 Apr 2021 23:24:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAD=hENf8SA2==WhtufkcesuJH7cMys8vPNj4_1a=OAaE2GREOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/20/21 9:32 AM, Zhu Yanjun wrote:
> On Thu, Apr 15, 2021 at 10:55 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> Add support for bind MW work requests from user space.
>> Since rdma/core does not support bind mw in ib_send_wr
>> there is no way to support bind mw in kernel space.
>>
>> Added bind_mw local operation in rxe_req.c
>> Added bind_mw WR operation in rxe_opcode.c
>> Added bind_mw WC in rxe_comp.c
>> Added additional fields to rxe_mw in rxe_verbs.h
>> Added do_dealloc_mw() subroutine to cleanup an mw
>> when rxe_dealloc_mw is called.
>> Added code to implement bind_mw operation in rxe_mw.c
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>> v2:
>>   Dropped kernel support for bind_mw in rxe_mw.c
>>   Replaced umw with mw in rxe_send_wr.
>>
>>  drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
>>  drivers/infiniband/sw/rxe/rxe_loc.h    |   1 +
>>  drivers/infiniband/sw/rxe/rxe_mw.c     | 204 ++++++++++++++++++++++++-
>>  drivers/infiniband/sw/rxe/rxe_opcode.c |   7 +
>>  drivers/infiniband/sw/rxe/rxe_req.c    |   9 ++
>>  drivers/infiniband/sw/rxe/rxe_verbs.h  |  15 +-
>>  6 files changed, 232 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>> index 2af26737d32d..bc5488af5f55 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>> @@ -103,6 +103,7 @@ static enum ib_wc_opcode wr_to_wc_opcode(enum ib_wr_opcode opcode)
>>         case IB_WR_RDMA_READ_WITH_INV:          return IB_WC_RDMA_READ;
>>         case IB_WR_LOCAL_INV:                   return IB_WC_LOCAL_INV;
>>         case IB_WR_REG_MR:                      return IB_WC_REG_MR;
>> +       case IB_WR_BIND_MW:                     return IB_WC_BIND_MW;
>>
>>         default:
>>                 return 0xff;
>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>> index edf575930a98..e6f574973298 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>> @@ -110,6 +110,7 @@ int advance_dma_data(struct rxe_dma_info *dma, unsigned int length);
>>  /* rxe_mw.c */
>>  int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata);
>>  int rxe_dealloc_mw(struct ib_mw *ibmw);
>> +int rxe_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe);
>>  void rxe_mw_cleanup(struct rxe_pool_entry *arg);
>>
>>  /* rxe_net.c */
>> diff --git a/drivers/infiniband/sw/rxe/rxe_mw.c b/drivers/infiniband/sw/rxe/rxe_mw.c
>> index 69128e298d44..6ced54126b72 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_mw.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_mw.c
>> @@ -29,6 +29,29 @@ int rxe_alloc_mw(struct ib_mw *ibmw, struct ib_udata *udata)
>>         return 0;
>>  }
>>
>> +static void do_dealloc_mw(struct rxe_mw *mw)
>> +{
>> +       if (mw->mr) {
>> +               struct rxe_mr *mr = mw->mr;
>> +
>> +               mw->mr = NULL;
>> +               atomic_dec(&mr->num_mw);
>> +               rxe_drop_ref(mr);
>> +       }
>> +
>> +       if (mw->qp) {
>> +               struct rxe_qp *qp = mw->qp;
>> +
>> +               mw->qp = NULL;
>> +               rxe_drop_ref(qp);
>> +       }
>> +
>> +       mw->access = 0;
>> +       mw->addr = 0;
>> +       mw->length = 0;
>> +       mw->state = RXE_MW_STATE_INVALID;
>> +}
>> +
>>  int rxe_dealloc_mw(struct ib_mw *ibmw)
>>  {
>>         struct rxe_mw *mw = to_rmw(ibmw);
>> @@ -36,7 +59,7 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
>>         unsigned long flags;
>>
>>         spin_lock_irqsave(&mw->lock, flags);
>> -       mw->state = RXE_MW_STATE_INVALID;
>> +       do_dealloc_mw(mw);
>>         spin_unlock_irqrestore(&mw->lock, flags);
>>
>>         rxe_drop_ref(mw);
>> @@ -45,6 +68,185 @@ int rxe_dealloc_mw(struct ib_mw *ibmw)
>>         return 0;
>>  }
>>
>> +static int check_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>> +                        struct rxe_mw *mw, struct rxe_mr *mr)
>> +{
>> +       if (mw->ibmw.type == IB_MW_TYPE_1) {
>> +               if (unlikely(mw->state != RXE_MW_STATE_VALID)) {
>> +                       pr_err_once(
>> +                               "attempt to bind a type 1 MW not in the valid state\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               /* o10-36.2.2 */
>> +               if (unlikely((mw->access & IB_ZERO_BASED))) {
>> +                       pr_err_once("attempt to bind a zero based type 1 MW\n");
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       if (mw->ibmw.type == IB_MW_TYPE_2) {
>> +               /* o10-37.2.30 */
>> +               if (unlikely(mw->state != RXE_MW_STATE_FREE)) {
>> +                       pr_err_once(
>> +                               "attempt to bind a type 2 MW not in the free state\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               /* C10-72 */
>> +               if (unlikely(qp->pd != to_rpd(mw->ibmw.pd))) {
>> +                       pr_err_once(
>> +                               "attempt to bind type 2 MW with qp with different PD\n");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               /* o10-37.2.40 */
>> +               if (unlikely(!mr || wqe->wr.wr.mw.length == 0)) {
>> +                       pr_err_once(
>> +                               "attempt to invalidate type 2 MW by binding with NULL or zero length MR\n");
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       if (unlikely((wqe->wr.wr.mw.rkey & 0xff) == (mw->ibmw.rkey & 0xff))) {
>> +               pr_err_once("attempt to bind MW with same key\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* remaining checks only apply to a nonzero MR */
>> +       if (!mr)
>> +               return 0;
>> +
>> +       if (unlikely(mr->access & IB_ZERO_BASED)) {
>> +               pr_err_once("attempt to bind MW to zero based MR\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* C10-73 */
>> +       if (unlikely(!(mr->access & IB_ACCESS_MW_BIND))) {
>> +               pr_err_once(
>> +                       "attempt to bind an MW to an MR without bind access\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* C10-74 */
>> +       if (unlikely((mw->access &
>> +                     (IB_ACCESS_REMOTE_WRITE | IB_ACCESS_REMOTE_ATOMIC)) &&
>> +                    !(mr->access & IB_ACCESS_LOCAL_WRITE))) {
>> +               pr_err_once(
>> +                       "attempt to bind an writeable MW to an MR without local write access\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* C10-75 */
>> +       if (mw->access & IB_ZERO_BASED) {
>> +               if (unlikely(wqe->wr.wr.mw.length > mr->length)) {
>> +                       pr_err_once(
>> +                               "attempt to bind a ZB MW outside of the MR\n");
>> +                       return -EINVAL;
>> +               }
>> +       } else {
>> +               if (unlikely((wqe->wr.wr.mw.addr < mr->iova) ||
>> +                            ((wqe->wr.wr.mw.addr + wqe->wr.wr.mw.length) >
>> +                             (mr->iova + mr->length)))) {
>> +                       pr_err_once(
>> +                               "attempt to bind a VA MW outside of the MR\n");
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int do_bind_mw(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>> +                     struct rxe_mw *mw, struct rxe_mr *mr)
>> +{
>> +       u32 rkey;
>> +       u32 new_rkey;
>> +
>> +       rkey = mw->ibmw.rkey;
>> +       new_rkey = (rkey & 0xffffff00) | (wqe->wr.wr.mw.rkey & 0x000000ff);
>> +
>> +       mw->ibmw.rkey = new_rkey;
>> +       mw->access = wqe->wr.wr.mw.access;
>> +       mw->state = RXE_MW_STATE_VALID;
>> +       mw->addr = wqe->wr.wr.mw.addr;
>> +       mw->length = wqe->wr.wr.mw.length;
>> +
>> +       if (mw->mr) {
>> +               rxe_drop_ref(mw->mr);
>> +               atomic_dec(&mw->mr->num_mw);
>> +               mw->mr = NULL;
>> +       }
>> +
>> +       if (mw->length) {
>> +               mw->mr = mr;
>> +               atomic_inc(&mr->num_mw);
>> +               rxe_add_ref(mr);
>> +       }
>> +
>> +       if (mw->ibmw.type == IB_MW_TYPE_2) {
>> +               rxe_add_ref(qp);
>> +               mw->qp = qp;
>> +       }
>> +
>> +       return 0;
> 
> Is it necessary to return 0?
> 
> no others invalid value.
> 
> Zhu Yanjun

Good catch. It was left over from the past. I'll get rid of it.

Bob
