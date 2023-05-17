Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDB7705C0F
	for <lists+linux-rdma@lfdr.de>; Wed, 17 May 2023 02:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjEQAla (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 May 2023 20:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEQAl3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 May 2023 20:41:29 -0400
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4392696
        for <linux-rdma@vger.kernel.org>; Tue, 16 May 2023 17:41:27 -0700 (PDT)
Message-ID: <4e67b67a-c89e-314d-c481-e24027c38c9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684284086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCQMu3pcn35Ic8i9pcE/gIVbYC9FThH5oc4Mjk549No=;
        b=AZ3oAx1IcK9V9sJOE0bb3VN1BaDa3Gz7sryY8/CNpRy142DR4mtJPS048i2wd6XoyucHl0
        5wE+BZSFIK06iyXk7my5HtH/oRRLnUxKwZbkPDj7vfCVd6EtSAg0XEOfK038KNSQIHsmey
        eqlJ+9LwxQiEG54gaFETuJrVVPJ84q0=
Date:   Wed, 17 May 2023 08:41:22 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Convert spin_{lock_bh,unlock_bh} to
 spin_{lock_irqsave,unlock_irqrestore}
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20230510035056.881196-1-guoqing.jiang@linux.dev>
 <ZGQbwBeIqk6YMKuf@nvidia.com>
 <5d1aa20f-2cd0-5400-69e9-057ede404ae4@gmail.com>
 <ZGQiMsBAWhyACuxK@nvidia.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <ZGQiMsBAWhyACuxK@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 5/17/23 08:39, Jason Gunthorpe wrote:
> On Tue, May 16, 2023 at 07:32:35PM -0500, Bob Pearson wrote:
>> On 5/16/23 19:11, Jason Gunthorpe wrote:
>>> On Wed, May 10, 2023 at 11:50:56AM +0800, Guoqing Jiang wrote:
>>>> We need to call spin_lock_irqsave/spin_unlock_irqrestore for state_lock
>>>> in rxe, otherwsie the callchain
>>>>
>>>> ib_post_send_mad
>>>> 	-> spin_lock_irqsave
>>>> 	-> ib_post_send -> rxe_post_send
>>>> 				-> spin_lock_bh
>>>> 				-> spin_unlock_bh
>>>> 	-> spin_unlock_irqrestore
>>>>
>>>> caused below traces during run block nvmeof-mp/001 test.
>>> ..
>>>   
>>>> Fixes: f605f26ea196 ("RDMA/rxe: Protect QP state with qp->state_lock")
>>>> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
>>>> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>   drivers/infiniband/sw/rxe/rxe_comp.c  | 26 +++++++++++--------
>>>>   drivers/infiniband/sw/rxe/rxe_net.c   |  7 +++---
>>>>   drivers/infiniband/sw/rxe/rxe_qp.c    | 36 +++++++++++++++++----------
>>>>   drivers/infiniband/sw/rxe/rxe_recv.c  |  9 ++++---
>>>>   drivers/infiniband/sw/rxe/rxe_req.c   | 30 ++++++++++++----------
>>>>   drivers/infiniband/sw/rxe/rxe_resp.c  | 14 ++++++-----
>>>>   drivers/infiniband/sw/rxe/rxe_verbs.c | 25 ++++++++++---------
>>>>   7 files changed, 86 insertions(+), 61 deletions(-)
>>> Applied to for-rc, thanks
>>>
>>> Jason
>> You didn't mention it but this shouldn't have applied/compiled without
>> fixing the overlap of these two patches. ??
> oh, I fixed it, it is trivial

Thanks for the fixing and review.

Guoqing
