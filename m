Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2CC36DCCD
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Apr 2021 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbhD1QRj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Apr 2021 12:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbhD1QRj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Apr 2021 12:17:39 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F19C061573
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 09:16:53 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i26so8244069oii.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Apr 2021 09:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GmPgqPKl7v+RpFMtVO3PSlzHvOIpfokVLlElwKEa+mg=;
        b=uiaEGcQ8JZEc5FhBnyFGB/0e5a64NC25JMizSXJz8YJ4Lcg9gQVOmq/WRolfWX84bd
         KNj4hCD5BdrJ3WcW2yrxxgHgg/aIQ3z8yFVKkC+oPdoh+JKbviBbG+xsTopaFcJv+fca
         NtiDpnwY4+mPOmv2UW9T0vcERq2CfbZ6u35k2Zj+GlNvygdnP2dnqB525UL//J/dcI5r
         65Ag/apoVnTKrkPvf6a+p91p5ptefEP2mWypD1h9Xvu40ZZCJYnwlpjCi3Z/wRNcd1Xo
         RFj0aBIbLXCA8caRpvnrBks2/PUjrDH5u1RGGXA/YrzEJ8fRHV7nOD5sW91WhLzEBPA7
         WIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GmPgqPKl7v+RpFMtVO3PSlzHvOIpfokVLlElwKEa+mg=;
        b=MRGcEuJIhun2tapIOzJNK3GK/DYnVzVhbkiyWRtbEcoX2ZxpPjc9uLnOjheG2tU4yJ
         VScGyjOMqKe+dvDeXJUtn9oW2umSx92g3QrbEtnRn2WE5Y7cPesM92s0tuGisJ2iPYDf
         shOrqX2/fQ4tqlERz050TKd4ildIjhf8fI+h99a/8yXydxHIZj+aRPT9dI608G+9SInB
         6uQImRIbVfyqXZC+u8U9OujFHXl1CWA0nJuaVqPREzlcbY22Nd4Nd/+DhB6pUNK9/jGT
         YrYqHppbhAh3WU+1/yhE0L+I3CWZcr4LSfgjOPAdWVoKGAHUGjs2CEwBM3AvxjPRRApw
         R5rA==
X-Gm-Message-State: AOAM531XKG3tClbHhTFGpHQ/PSWpsh6FYnzD/5KQseNgXcx4pHjFvNJS
        XVWl+cV+Wnu51XzVgohBsno=
X-Google-Smtp-Source: ABdhPJz/6ABeweTmJBljqpQnGiIA5sOh2Ym0Gq4L8NtoZzxGSQ/OlU3uIbBRBSRbflxJL8yH/KeGEg==
X-Received: by 2002:aca:4d8b:: with SMTP id a133mr21622220oib.170.1619626612598;
        Wed, 28 Apr 2021 09:16:52 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:dcc:55b8:efe8:ecc6? (2603-8081-140c-1a00-0dcc-55b8-efe8-ecc6.res6.spectrum.com. [2603:8081:140c:1a00:dcc:55b8:efe8:ecc6])
        by smtp.gmail.com with ESMTPSA id x36sm73771ott.66.2021.04.28.09.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 09:16:52 -0700 (PDT)
Subject: Re: [PATCH for-next v5 06/10] RDMA/rxe: Move local ops to subroutine
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
References: <20210422161341.41929-1-rpearson@hpe.com>
 <20210422161341.41929-7-rpearson@hpe.com>
 <CAD=hENch84JXK3h_+g_Np_uwR0qmqR6659QYNq9ZAALV+wUj+g@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <c36b5faf-ffc3-c5c7-4577-867c662857b7@gmail.com>
Date:   Wed, 28 Apr 2021 11:16:44 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAD=hENch84JXK3h_+g_Np_uwR0qmqR6659QYNq9ZAALV+wUj+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/24/2021 11:34 PM, Zhu Yanjun wrote:
> On Fri, Apr 23, 2021 at 12:13 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>> Simplify rxe_requester() by moving the local operations
>> to a subroutine. Add an error return for illegal send WR opcode.
>> Moved next_index ahead of rxe_run_task which fixed a small bug where
>> work completions were delayed until after the next wqe which was not
>> the intended behavior.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_req.c | 89 +++++++++++++++++------------
>>   1 file changed, 54 insertions(+), 35 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>> index 0d4dcd514c55..0cf97e3db29f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>> @@ -555,6 +555,56 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>>                            jiffies + qp->qp_timeout_jiffies);
>>   }
>>
>> +static int do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
> rxe_do_local_ops if not used out of softroce.


Same issue. I am trying to be consistent with the original style (which 
mostly I wrote). Static names

don't need to be elaborate.

>
>> +{
>> +       u8 opcode = wqe->wr.opcode;
>> +       struct rxe_dev *rxe;
>> +       struct rxe_mr *mr;
>> +       u32 rkey;
>> +
>> +       switch (opcode) {
>> +       case IB_WR_LOCAL_INV:
>> +               rxe = to_rdev(qp->ibqp.device);
>> +               rkey = wqe->wr.ex.invalidate_rkey;
>> +               mr = rxe_pool_get_index(&rxe->mr_pool, rkey >> 8);
>> +               if (!mr) {
>> +                       pr_err("No MR for rkey %#x\n", rkey);
>> +                       wqe->state = wqe_state_error;
>> +                       wqe->status = IB_WC_LOC_QP_OP_ERR;
>> +                       return -EINVAL;
>> +               }
>> +               mr->state = RXE_MR_STATE_FREE;
>> +               rxe_drop_ref(mr);
>> +               break;
>> +       case IB_WR_REG_MR:
>> +               mr = to_rmr(wqe->wr.wr.reg.mr);
>> +
>> +               rxe_add_ref(mr);
>> +               mr->state = RXE_MR_STATE_VALID;
>> +               mr->access = wqe->wr.wr.reg.access;
>> +               mr->ibmr.lkey = wqe->wr.wr.reg.key;
>> +               mr->ibmr.rkey = wqe->wr.wr.reg.key;
>> +               mr->iova = wqe->wr.wr.reg.mr->iova;
>> +               rxe_drop_ref(mr);
>> +               break;
>> +       default:
>> +               pr_err("Unexpected send wqe opcode %d\n", opcode);
>> +               wqe->state = wqe_state_error;
>> +               wqe->status = IB_WC_LOC_QP_OP_ERR;
>> +               return -EINVAL;
>> +       }
>> +
>> +       wqe->state = wqe_state_done;
>> +       wqe->status = IB_WC_SUCCESS;
>> +       qp->req.wqe_index = next_index(qp->sq.queue, qp->req.wqe_index);
>> +
>> +       if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
>> +           qp->sq_sig_type == IB_SIGNAL_ALL_WR)
>> +               rxe_run_task(&qp->comp.task, 1);
>> +
>> +       return 0;
>> +}
>> +
>>   int rxe_requester(void *arg)
>>   {
>>          struct rxe_qp *qp = (struct rxe_qp *)arg;
>> @@ -594,42 +644,11 @@ int rxe_requester(void *arg)
>>                  goto exit;
>>
>>          if (wqe->mask & WR_LOCAL_OP_MASK) {
>> -               if (wqe->wr.opcode == IB_WR_LOCAL_INV) {
>> -                       struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
>> -                       struct rxe_mr *rmr;
>> -
>> -                       rmr = rxe_pool_get_index(&rxe->mr_pool,
>> -                                                wqe->wr.ex.invalidate_rkey >> 8);
>> -                       if (!rmr) {
>> -                               pr_err("No mr for key %#x\n",
>> -                                      wqe->wr.ex.invalidate_rkey);
>> -                               wqe->state = wqe_state_error;
>> -                               wqe->status = IB_WC_MW_BIND_ERR;
>> -                               goto exit;
>> -                       }
>> -                       rmr->state = RXE_MR_STATE_FREE;
>> -                       rxe_drop_ref(rmr);
>> -                       wqe->state = wqe_state_done;
>> -                       wqe->status = IB_WC_SUCCESS;
>> -               } else if (wqe->wr.opcode == IB_WR_REG_MR) {
>> -                       struct rxe_mr *rmr = to_rmr(wqe->wr.wr.reg.mr);
>> -
>> -                       rmr->state = RXE_MR_STATE_VALID;
>> -                       rmr->access = wqe->wr.wr.reg.access;
>> -                       rmr->ibmr.lkey = wqe->wr.wr.reg.key;
>> -                       rmr->ibmr.rkey = wqe->wr.wr.reg.key;
>> -                       rmr->iova = wqe->wr.wr.reg.mr->iova;
>> -                       wqe->state = wqe_state_done;
>> -                       wqe->status = IB_WC_SUCCESS;
>> -               } else {
>> +               ret = do_local_ops(qp, wqe);
>> +               if (unlikely(ret))
>>                          goto exit;
>> -               }
>> -               if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
>> -                   qp->sq_sig_type == IB_SIGNAL_ALL_WR)
>> -                       rxe_run_task(&qp->comp.task, 1);
>> -               qp->req.wqe_index = next_index(qp->sq.queue,
>> -                                               qp->req.wqe_index);
>> -               goto next_wqe;
>> +               else
>> +                       goto next_wqe;
>>          }
>>
>>          if (unlikely(qp_type(qp) == IB_QPT_RC &&
>> --
>> 2.27.0
>>
