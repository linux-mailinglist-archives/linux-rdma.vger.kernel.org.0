Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9660B526929
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383078AbiEMSWM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 14:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352044AbiEMSWL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 14:22:11 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91316D44
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 11:22:10 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-e656032735so11571427fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=k0RcPcYmjQSPX+6UiWkE09gsHGdkxGFXxS0kz8QCF6E=;
        b=Hr6lbIrVVv4sr+ynhlu3Tyhiu5njiilYw4vw8B252BWmT5Sh/4u+AYIrNOaR7pAquQ
         JwmOjNTDLs4mKpSV1i2tU+Lrf6Ca1GvFclK6BnBXGsOOHHKFcBsH+wPrxv7c6HKN8Jkw
         yUFYzI2/GDCbWkLJo5gtldP+kvE1xD08awCK9uPYS5msC426Jc+B5bf4rMiR6Cy9Lgrc
         JbTA6xVz1jEhUvQkQxIg+O0+tmPu3dHGtWIBOWto64cYjjk9Sq0rjhbN9ucoqE4Isa9f
         kOFimIgrqz06ctGRHIw3OEd6wK8UoNMFWPRSK0W/wpssiUyvlUrfbZp3DDOnJlgEe/U+
         J0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k0RcPcYmjQSPX+6UiWkE09gsHGdkxGFXxS0kz8QCF6E=;
        b=eZNAujWyWQA0Ks3zR5lmc5GoJl3HeAoTOH/SJGPdOaoKgWReHk48BFU/pzpCuHUyMT
         PoLFplMZfi9xTIXhMjVcpb9ptKF8OgA0mVQdelm9D4p3GruKIKm0JGNflNjNBgSVYfmV
         /wiUDY7R3QLXdESx8c4a2E8hKWyt63biWCMp+EgdNEheQS0wh+5lAtcavUYlZgWviB/R
         X6/A+oDMh8ZX8zyvYDcpsRktpOR9DKcFVDxJqBPttA/THFHxVygwaNFjvwU6GZoVHD3Y
         kinryKiMkECR/Ino65MX7qIFfUn/ZbRcO8O4JXw4cJhrsxb3yq9m8ODl0Lfu2KSAYPAo
         4Fow==
X-Gm-Message-State: AOAM533ibNgG5E9unL/iK/J2m2pHyLvw18g39jenLNDcODIZ1ePTZV4S
        ShFgGyLqBFxEEVSxsJdZT0Q=
X-Google-Smtp-Source: ABdhPJyBz6+G/dSNXR5YSdv6rI+EnR2LzcfDsnBEXQz4eePYqxmsdU+VZcWslqSTGwgerPni6KOBuQ==
X-Received: by 2002:a05:6870:560e:b0:ed:8a0a:df0a with SMTP id m14-20020a056870560e00b000ed8a0adf0amr8811058oao.119.1652466129882;
        Fri, 13 May 2022 11:22:09 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7fc0:37e:f57e:caea? (2603-8081-140c-1a00-7fc0-037e-f57e-caea.res6.spectrum.com. [2603:8081:140c:1a00:7fc0:37e:f57e:caea])
        by smtp.gmail.com with ESMTPSA id w1-20020a056830060100b006060322125esm1258516oti.46.2022.05.13.11.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 11:22:09 -0700 (PDT)
Message-ID: <25c4e1f7-54eb-456b-8020-b3b1e24a9ecb@gmail.com>
Date:   Fri, 13 May 2022 13:22:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix rnr retry behavior
Content-Language: en-US
To:     Yanjun Zhu <yanjun.zhu@linux.dev>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220512194901.76696-1-rpearsonhpe@gmail.com>
 <e587f531-0650-1548-1fe0-04d0152a5082@linux.dev>
 <36f6e476-9762-6d39-e167-abb8dcc9f2bb@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <36f6e476-9762-6d39-e167-abb8dcc9f2bb@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/22 08:38, Yanjun Zhu wrote:
> 
> 
> 在 2022/5/13 10:40, Yanjun Zhu 写道:
>> 在 2022/5/13 3:49, Bob Pearson 写道:
>>> Currently the completer tasklet when it sets the retransmit timer or the
>>> nak timer sets the same flag (qp->req.need_retry) so that if either
>>> timer fires it will attempt to perform a retry flow on the send queue.
>>> This has the effect of responding to an RNR NAK at the first retransmit
>>> timer event which does not allow for the requested rnr timeout.
>>>
>>> This patch adds a new flag (qp->req.need_rnr_timeout) which, if set,
>>> prevents a retry flow until the rnr nak timer fires.
>>>
>>> This patch fixes rnr retry errors which can be observed by running the
>>> pyverbs test suite 50-100X. With this patch applied they do not occur.
>>
>> Do you mean that running run_tests.py for 50-100times can reproduce this bug? I want to reproduce this problem.
> 
> Running run_tests.py for 50-100times, I can not reproduce this problem

I went back and looked. The occasionally failing test case is:

	test_rdmacm_async_traffic_external_qp

This test is normally skipped for rxe because of a hack in <path to rdma-core>/tests/base.py. I sent you
a patch that enables these tests a few days ago.

It randomly causes an rnr retry about 1/3 of the time. Most of these are repaired by the retry timer
going off. A few ~1-2% are not.

Bob
> 
> Zhu Yanjun
> 
>>
>> Thanks a lot.
>> Zhu Yanjun
>>
>>>
>>> Link: https://lore.kernel.org/linux-rdma/a8287823-1408-4273-bc22-99a0678db640@gmail.com/
>>> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>> ---
>>>   drivers/infiniband/sw/rxe/rxe_comp.c  | 4 +---
>>>   drivers/infiniband/sw/rxe/rxe_qp.c    | 1 +
>>>   drivers/infiniband/sw/rxe/rxe_req.c   | 6 ++++--
>>>   drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>>>   4 files changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>>> index 138b3e7d3a5f..bc668cb211b1 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>>> @@ -733,9 +733,7 @@ int rxe_completer(void *arg)
>>>                   if (qp->comp.rnr_retry != 7)
>>>                       qp->comp.rnr_retry--;
>>> -                qp->req.need_retry = 1;
>>> -                pr_debug("qp#%d set rnr nak timer\n",
>>> -                     qp_num(qp));
>>> +                qp->req.need_rnr_timeout = 1;
>>>                   mod_timer(&qp->rnr_nak_timer,
>>>                         jiffies + rnrnak_jiffies(aeth_syn(pkt)
>>>                           & ~AETH_TYPE_MASK));
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> index 62acf890af6c..1c962468714e 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>> @@ -513,6 +513,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
>>>       atomic_set(&qp->ssn, 0);
>>>       qp->req.opcode = -1;
>>>       qp->req.need_retry = 0;
>>> +    qp->req.need_rnr_timeout = 0;
>>>       qp->req.noack_pkts = 0;
>>>       qp->resp.msn = 0;
>>>       qp->resp.opcode = -1;
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>>> index ae5fbc79dd5c..770ae4279f73 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>>> @@ -103,7 +103,8 @@ void rnr_nak_timer(struct timer_list *t)
>>>   {
>>>       struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
>>> -    pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
>>> +    qp->req.need_retry = 1;
>>> +    qp->req.need_rnr_timeout = 0;
>>>       rxe_run_task(&qp->req.task, 1);
>>>   }
>>> @@ -624,10 +625,11 @@ int rxe_requester(void *arg)
>>>           qp->req.need_rd_atomic = 0;
>>>           qp->req.wait_psn = 0;
>>>           qp->req.need_retry = 0;
>>> +        qp->req.need_rnr_timeout = 0;
>>>           goto exit;
>>>       }
>>> -    if (unlikely(qp->req.need_retry)) {
>>> +    if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {
>>>           req_retry(qp);
>>>           qp->req.need_retry = 0;
>>>       }
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> index e7eff1ca75e9..ab3186478c3f 100644
>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>> @@ -123,6 +123,7 @@ struct rxe_req_info {
>>>       int            need_rd_atomic;
>>>       int            wait_psn;
>>>       int            need_retry;
>>> +    int            need_rnr_timeout;
>>>       int            noack_pkts;
>>>       struct rxe_task        task;
>>>   };
>>>
>>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
>>

