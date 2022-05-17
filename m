Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E3D52A755
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245701AbiEQPtz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 11:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234543AbiEQPty (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 11:49:54 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E7641625
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 08:49:53 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-e93bbb54f9so24635661fac.12
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 08:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=DCLPc007/G8BE0CDiUR3ANcpXy1E1MPUQES0+bWb7xA=;
        b=Mpt4FZ2MatYK3BxA23B425yl7eHC2ApKDLEjs6Z7YlNB53Cl1HD+XEI78BqWSK7g1X
         rQJMn+opc9KzPKecw0TLG2NvkdZOKB/tYxRSsdZIAsLot+V4SdQNYWcb1rIdxM1CL6gm
         cPDS84OW8i4o9W8tdZ49qYy4af6Io4Pi0uVbRcGnwRM+1mA4rzDoMlNcbN8IV7+xH+ER
         2ghJ7RSDB6IH2RmzavMyJu9XUUKePon2heieaBUWXnSOXTSl6S1s3EoBCP2ubO0bRBMg
         JO6TFonnC0nvVM9SRIN/7DbImLpzzjzWYYeVyZhfUty4+teK3aC9zne2lmkdeiVq7sdT
         m96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DCLPc007/G8BE0CDiUR3ANcpXy1E1MPUQES0+bWb7xA=;
        b=ZVsSsxZ7T3+1bg4gipCY7Q2aadaREsKGQEwe9GuKZbbLl4FBbbinJQwKMIwb/g7iEo
         DzxsgW03rDcM7c+uCJupi71auhfNzRc63ugak8Z2AOKLQ/ks5dzYO9UDUtQ8joQyo8Mi
         s/wgjjgalDWiRjFGLQfORofA3HQAK3u3RWfFAF61I06JuPcolI9Luky+wmoQ8V63cbME
         lPUaQ4sJ+3zLrGWy4GPCx9EtESb73SsT9X7xTwRFE4krfoBFw2cQPiTKCxNjRY1Rn0Wz
         42/ZM+loSKbD7pMYufmxrS7OreuqGcv/nA4C/DV5ksFOU8nJ5apfx/eUEUKosyJ8Ba+P
         sq1A==
X-Gm-Message-State: AOAM533VtNT/l1BxrwnDrUAITsgBrKOe9MWMvhfCrwQDvn0AkAunpkAJ
        0xNtQbuD57UyUg/77a+thHJ4X+aR87U=
X-Google-Smtp-Source: ABdhPJyhdG1Qh04EWy0gsTrKt6/xZkchzgvJZgIXnV2fEq0KT0/xrbpCPvLphsZE0JtBzxi6FnVM2w==
X-Received: by 2002:a05:6870:3456:b0:e9:23d3:e701 with SMTP id i22-20020a056870345600b000e923d3e701mr13146535oah.11.1652802592891;
        Tue, 17 May 2022 08:49:52 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d310:a4f5:635f:2e00? (2603-8081-140c-1a00-d310-a4f5-635f-2e00.res6.spectrum.com. [2603:8081:140c:1a00:d310:a4f5:635f:2e00])
        by smtp.gmail.com with ESMTPSA id i25-20020a9d6519000000b0060603221251sm23083otl.33.2022.05.17.08.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 08:49:52 -0700 (PDT)
Message-ID: <599adff3-63f3-8ebf-46aa-307619837859@gmail.com>
Date:   Tue, 17 May 2022 10:49:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/1] RDMA/rxe: Compact the function
 free_rd_atomic_resource
Content-Language: en-US
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20220517190800.122757-1-yanjun.zhu@linux.dev>
 <c9e99081-f6aa-0167-77ff-57533b107e90@gmail.com>
 <f3a827f0-69bd-7bae-21cf-02a88063d39d@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <f3a827f0-69bd-7bae-21cf-02a88063d39d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/17/22 10:14, Yanjun Zhu wrote:
> 
> 在 2022/5/17 22:51, Bob Pearson 写道:
>> On 5/17/22 14:08, yanjun.zhu@linux.dev wrote:
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>
>>> Compact the function and move it to the header file.
>> I have two issues with this patch.
>>
>> There is no advantage of having an inline function in a header file
>> that is only called once. The compiler is perfectly capable of (and does)
>> inlining a static function in a .c file if only called once. This just
>> makes the code harder to read.
> 
> When this function is put into the header file, this function can be included into the caller function file.
> 
> The compiler does not need to call this function in different file. In theory, this can increase
> 
> the compile speed.
> 
> Why do you insist on putting this function in .c file?

I don't insist. I just don't like them. Jason is correct the subroutine is in rxe_qp.c
and there are two calls in rxe_resp.c and one in rxe_qp.c. Given there are three calls
I would prefer to not do anything. The responder resources code

	alloc_rd_atomic_resources()
	free_rd_atomic_resources()
	free_rd_atomic_resource()
	cleanup_rd_atomic_resources()

is mostly called by rxe_qp.c so they are in the right place. The 2-3 instructions
you might save by inlining free_rd_atomic_resource() just aren't worth it in the
tens of thousands of instructions in the response to an rdma_read or atomic request.

To Jason's question. 8a1a0be894da and 290c4a902b79 are already in for-rc. There
isn't any res.read.mr left.

Bob

> 
> Zhu Yanjun
> 
>>
>> There is a patch in for-rc that gets rid of read.mr in favor of an rkey.
>> This patch is out of date.
>>
>> Bob
>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_loc.h  | 11 ++++++++++-
>>>   drivers/infiniband/sw/rxe/rxe_qp.c   | 15 ++-------------
>>>   drivers/infiniband/sw/rxe/rxe_resp.c |  4 ++--
>>>   3 files changed, 14 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
>>> index 409efeecd581..6517b4f104b1 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
>>> @@ -145,7 +145,16 @@ static inline int rcv_wqe_size(int max_sge)
>>>           max_sge * sizeof(struct ib_sge);
>>>   }
>>>   -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res);
>>> +static inline void free_rd_atomic_resource(struct resp_res *res)
>>> +{
>>> +    if (res->type == RXE_ATOMIC_MASK) {
>>> +        kfree_skb(res->atomic.skb);
>>> +    } else if (res->type == RXE_READ_MASK) {
>>> +        if (res->read.mr)
>>> +            rxe_drop_ref(res->read.mr);
>>> +    }
>>> +    res->type = 0;
>>> +}
>>>     static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
>>>   {
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> index 5f270cbf18c6..b29208852bc4 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> @@ -126,24 +126,13 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
>>>           for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>>>               struct resp_res *res = &qp->resp.resources[i];
>>>   -            free_rd_atomic_resource(qp, res);
>>> +            free_rd_atomic_resource(res);
>>>           }
>>>           kfree(qp->resp.resources);
>>>           qp->resp.resources = NULL;
>>>       }
>>>   }
>>>   -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
>>> -{
>>> -    if (res->type == RXE_ATOMIC_MASK) {
>>> -        kfree_skb(res->atomic.skb);
>>> -    } else if (res->type == RXE_READ_MASK) {
>>> -        if (res->read.mr)
>>> -            rxe_drop_ref(res->read.mr);
>>> -    }
>>> -    res->type = 0;
>>> -}
>>> -
>>>   static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
>>>   {
>>>       int i;
>>> @@ -152,7 +141,7 @@ static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
>>>       if (qp->resp.resources) {
>>>           for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>>>               res = &qp->resp.resources[i];
>>> -            free_rd_atomic_resource(qp, res);
>>> +            free_rd_atomic_resource(res);
>>>           }
>>>       }
>>>   }
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> index c369d78fc8e8..923a71ff305c 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>> @@ -663,7 +663,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>            */
>>>           res = &qp->resp.resources[qp->resp.res_head];
>>>   -        free_rd_atomic_resource(qp, res);
>>> +        free_rd_atomic_resource(res);
>>>           rxe_advance_resp_resource(qp);
>>>             res->type        = RXE_READ_MASK;
>>> @@ -977,7 +977,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>>>       }
>>>         res = &qp->resp.resources[qp->resp.res_head];
>>> -    free_rd_atomic_resource(qp, res);
>>> +    free_rd_atomic_resource(res);
>>>       rxe_advance_resp_resource(qp);
>>>         skb_get(skb);

