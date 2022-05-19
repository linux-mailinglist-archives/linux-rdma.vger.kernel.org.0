Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B3952D57A
	for <lists+linux-rdma@lfdr.de>; Thu, 19 May 2022 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239554AbiESOCi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 May 2022 10:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbiESOCA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 May 2022 10:02:00 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C398B5E154
        for <linux-rdma@vger.kernel.org>; Thu, 19 May 2022 07:00:59 -0700 (PDT)
Message-ID: <f46194ce-edf9-e6d0-78ce-7401c48ef233@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652968857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Uon3dEbBl+tAkG5Ji2syvjbQEmQ5072gBJVJSFT2YQ=;
        b=M6AeeksoYpeJsreG8wPuK/05r/DI3+j52XxfVcRGCxPes636MkoS1/CcHBPHRNceo66gWP
        cS5OtWrfmJT/OH2aAjFhSdTNVPi3g+iHQ6ACT2t63pwIPPhxbLrNHuTXo/7u3BGvdKXb2F
        Xd5sb7HfCdBZoRX7V40ryEcYDd/kaQc=
Date:   Thu, 19 May 2022 22:00:38 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Compact the function
 free_rd_atomic_resource
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20220517190800.122757-1-yanjun.zhu@linux.dev>
 <c9e99081-f6aa-0167-77ff-57533b107e90@gmail.com>
 <f3a827f0-69bd-7bae-21cf-02a88063d39d@linux.dev>
 <599adff3-63f3-8ebf-46aa-307619837859@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <599adff3-63f3-8ebf-46aa-307619837859@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/5/17 23:49, Bob Pearson 写道:
> On 5/17/22 10:14, Yanjun Zhu wrote:
>> 在 2022/5/17 22:51, Bob Pearson 写道:
>>> On 5/17/22 14:08, yanjun.zhu@linux.dev wrote:
>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>
>>>> Compact the function and move it to the header file.
>>> I have two issues with this patch.
>>>
>>> There is no advantage of having an inline function in a header file
>>> that is only called once. The compiler is perfectly capable of (and does)
>>> inlining a static function in a .c file if only called once. This just
>>> makes the code harder to read.
>> When this function is put into the header file, this function can be included into the caller function file.
>>
>> The compiler does not need to call this function in different file. In theory, this can increase
>>
>> the compile speed.
>>
>> Why do you insist on putting this function in .c file?
> I don't insist. I just don't like them. Jason is correct the subroutine is in rxe_qp.c
> and there are two calls in rxe_resp.c and one in rxe_qp.c. Given there are three calls
> I would prefer to not do anything. The responder resources code
>
> 	alloc_rd_atomic_resources()
> 	free_rd_atomic_resources()
> 	free_rd_atomic_resource()
> 	cleanup_rd_atomic_resources()
>
> is mostly called by rxe_qp.c so they are in the right place. The 2-3 instructions
> you might save by inlining free_rd_atomic_resource() just aren't worth it in the
> tens of thousands of instructions in the response to an rdma_read or atomic request.

The above 4 functions are in rxe_qp.c because these functions will use 
qp as parameter.

Now free_rd_atomic_resource will not use qp as paramter and other files 
also will call this function.

As such it is a good idea to put this function free_rd_atomic_resource 
to the head file.

Zhu Yanjun

>
> To Jason's question. 8a1a0be894da and 290c4a902b79 are already in for-rc. There
> isn't any res.read.mr left.
>
> Bob
>
>> Zhu Yanjun
>>
>>> There is a patch in for-rc that gets rid of read.mr in favor of an rkey.
>>> This patch is out of date.
>>>
>>> Bob
>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_loc.h  | 11 ++++++++++-
>>>>    drivers/infiniband/sw/rxe/rxe_qp.c   | 15 ++-------------
>>>>    drivers/infiniband/sw/rxe/rxe_resp.c |  4 ++--
>>>>    3 files changed, 14 insertions(+), 16 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>>>> index 409efeecd581..6517b4f104b1 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>>>> @@ -145,7 +145,16 @@ static inline int rcv_wqe_size(int max_sge)
>>>>            max_sge * sizeof(struct ib_sge);
>>>>    }
>>>>    -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res);
>>>> +static inline void free_rd_atomic_resource(struct resp_res *res)
>>>> +{
>>>> +    if (res->type == RXE_ATOMIC_MASK) {
>>>> +        kfree_skb(res->atomic.skb);
>>>> +    } else if (res->type == RXE_READ_MASK) {
>>>> +        if (res->read.mr)
>>>> +            rxe_drop_ref(res->read.mr);
>>>> +    }
>>>> +    res->type = 0;
>>>> +}
>>>>      static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
>>>>    {
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> index 5f270cbf18c6..b29208852bc4 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> @@ -126,24 +126,13 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
>>>>            for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>>>>                struct resp_res *res = &qp->resp.resources[i];
>>>>    -            free_rd_atomic_resource(qp, res);
>>>> +            free_rd_atomic_resource(res);
>>>>            }
>>>>            kfree(qp->resp.resources);
>>>>            qp->resp.resources = NULL;
>>>>        }
>>>>    }
>>>>    -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
>>>> -{
>>>> -    if (res->type == RXE_ATOMIC_MASK) {
>>>> -        kfree_skb(res->atomic.skb);
>>>> -    } else if (res->type == RXE_READ_MASK) {
>>>> -        if (res->read.mr)
>>>> -            rxe_drop_ref(res->read.mr);
>>>> -    }
>>>> -    res->type = 0;
>>>> -}
>>>> -
>>>>    static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
>>>>    {
>>>>        int i;
>>>> @@ -152,7 +141,7 @@ static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
>>>>        if (qp->resp.resources) {
>>>>            for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>>>>                res = &qp->resp.resources[i];
>>>> -            free_rd_atomic_resource(qp, res);
>>>> +            free_rd_atomic_resource(res);
>>>>            }
>>>>        }
>>>>    }
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> index c369d78fc8e8..923a71ff305c 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>> @@ -663,7 +663,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>>             */
>>>>            res = &qp->resp.resources[qp->resp.res_head];
>>>>    -        free_rd_atomic_resource(qp, res);
>>>> +        free_rd_atomic_resource(res);
>>>>            rxe_advance_resp_resource(qp);
>>>>              res->type        = RXE_READ_MASK;
>>>> @@ -977,7 +977,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>>>>        }
>>>>          res = &qp->resp.resources[qp->resp.res_head];
>>>> -    free_rd_atomic_resource(qp, res);
>>>> +    free_rd_atomic_resource(res);
>>>>        rxe_advance_resp_resource(qp);
>>>>          skb_get(skb);
