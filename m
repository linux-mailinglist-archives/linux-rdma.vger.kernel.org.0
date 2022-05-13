Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C737A526955
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 20:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383178AbiEMSco (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 14:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383354AbiEMScn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 14:32:43 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DCE5AA71
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 11:32:37 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id y63so11110833oia.7
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 11:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=GTKqL2p/XmjbXI8PSxsVqtO/yvkyVCccAONNEZqwHjQ=;
        b=LWpoHgbXWD7XrAMikSyC2kszWh/uzOnJ288K7nnnqyWy7j9kWdEneXwa7HQMyrTEhi
         QIF8cxrWsb/St7mz8IMOOgqZznpSv9pGAG/jCM530REqz0ooXxfJ5UQ9Bwvd8JWKl7dD
         LperTeNAnoYPAlwoGB60KL/Fq6w9HFQtoXM3Vv3ZFtoMPs1meexMnR1/riaFyXJn0w94
         XD08C2R8h0lIW2agIBWNCi+dY6meuDWFAxDQXQAvI/UjFAiPDtXclilQjHjrIp0caL9n
         Ao5hW0QJSa+W/DaJOT1QBzUyxX60RA2Rt+LaF6nC2v68PgnrawK2rzg3jAJucY89r8uN
         hGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GTKqL2p/XmjbXI8PSxsVqtO/yvkyVCccAONNEZqwHjQ=;
        b=lBGThhQtOY+LjLnnwU0Q03Yln88V4qKOvVEZJsMufnoNoBA0XZ4Bgfoh7PM4JD8XOn
         4CUbbDm4US45xpMXqfz+9HxFMu50KHD3p/3sW+DAYpwK4+JPfG/ww7llX62iWFnexr9C
         Ay4VI8Rnahk62S+WGwJTPa+PzZrV/mQtLRA/71w3S9wBAVsmFceFz+K0AyL4OIR3fOwx
         cGc0puELKpTNDwgICBwRZjvNQou7K1NT/d6aMqsEjjKJ9yc/3xqFQmDG0gb/hb2viX3L
         ITdYXulPf0Hsxl7ptSO8CLnFhbdHWEYf5kvCKwChSj3UOhVnpoR9Jd/lXESnsh7IJYlP
         xWAg==
X-Gm-Message-State: AOAM530Z1X82ABKAW4VMzfHX+2MaMqHMLUO8vewIba37k6eKwXqxhh3o
        NPergYPIRhQC+c4M8LltGBA=
X-Google-Smtp-Source: ABdhPJwE3mKY6zEY8LnEE6f9JFqQ+Vi5Sx3qVM4dZqxPwpOL/CCY5s6FKB7wF3pRI+vZTQUiTiaZ9Q==
X-Received: by 2002:a05:6808:249:b0:326:5ccd:1688 with SMTP id m9-20020a056808024900b003265ccd1688mr8144249oie.9.1652466756746;
        Fri, 13 May 2022 11:32:36 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7fc0:37e:f57e:caea? (2603-8081-140c-1a00-7fc0-037e-f57e-caea.res6.spectrum.com. [2603:8081:140c:1a00:7fc0:37e:f57e:caea])
        by smtp.gmail.com with ESMTPSA id g18-20020a056870c15200b000d6c86ea98dsm1554073oad.1.2022.05.13.11.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 11:32:36 -0700 (PDT)
Message-ID: <9e94d77b-af2c-b647-a12b-77da5c363337@gmail.com>
Date:   Fri, 13 May 2022 13:32:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH for-rc] RDMA/rxe: Fix rnr retry behavior
Content-Language: en-US
To:     Tom Talpey <tom@talpey.com>, jgg@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
References: <20220512194901.76696-1-rpearsonhpe@gmail.com>
 <ca817696-530e-f94f-dcfa-68f1980d31eb@talpey.com>
 <d3ac03f3-f11f-59e1-5dec-d0670b214e72@gmail.com>
 <249855a1-867e-606e-56f9-6f99a79c828d@talpey.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <249855a1-867e-606e-56f9-6f99a79c828d@talpey.com>
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

On 5/13/22 12:43, Tom Talpey wrote:
> On 5/13/2022 11:33 AM, Bob Pearson wrote:
>> On 5/13/22 08:04, Tom Talpey wrote:
>>>
>>> On 5/12/2022 3:49 PM, Bob Pearson wrote:
>>>> Currently the completer tasklet when it sets the retransmit timer or the
>>>> nak timer sets the same flag (qp->req.need_retry) so that if either
>>>> timer fires it will attempt to perform a retry flow on the send queue.
>>>> This has the effect of responding to an RNR NAK at the first retransmit
>>>> timer event which does not allow for the requested rnr timeout.
>>>>
>>>> This patch adds a new flag (qp->req.need_rnr_timeout) which, if set,
>>>> prevents a retry flow until the rnr nak timer fires.
>>>
>>> The new name is a little confusing, nobody "needs" an RNR timeout. :)
>>> But it seems really odd (and maybe fragile) to have two flags. To me,
>>> setting need_retry to "-1", or anything but 0 or 1, would be better.
>>> After all, if the RNR NAK timer goes off, the code will generally retry, right? So it seems more logical to merge these.
>> I am trying to cleanup pyverbs runs which sometimes fail with rnr retry errors.
>> In this specific case the rnr timeout value is set a lot longer than the retry timeout.
> 
> Interesting. I was not aware that was possible, and I'm skeptical.
> But perhaps that's another matter.

It would make sense. The retry timer handles NIC to NIC failures which are fast.
Basically a network transit time or two. RNR recovery requires software to intervene
and post a recv WR.
 
> 
>> As discussed earlier the retry timer is never cleared so it continuously fires at about
>> 40 times a second. The failing test is intentionally setting up a situation where the
>> receiver is not ready and then it is. The retry timeout usually acts as though it
>> were the rnr retry and 'fixes' the problem and the test passes. Since the retry timer
>> is just randomly firing it sometimes happens too soon and the receiver isn't ready yet
>> which leads to the failed test.
>>
>> Logic says that if you receive an rnr nak the target is waiting for that specific send
>> packet to be resent and no other so we shouldn't be responding to a spurious retry
>> timeout.
>>
>> You are correct that the retry sequence can be shared but it shouldn't start until the
>> rnr timer has fired once an rnr nak is seen. This patch does exactly that by blocking
>> the retry sequence until the rnr timer fires.
>>
>> If you don't like 'need_rnr_timeout' perhaps you would accept 'wait_rnr_timeout' instead.
>> Overloading need_retry is less clear IMHO. You don't need the retry until the rnr timer
>> has fired then you do. If you really want to just use one variable we are basically
>> implementing a state machine with 3 states and it should get an enum to define the states.
> 
> I guess I do prefer the latter enum approach. To elaborate on what I
> meant by fragile, it appears that with the two-field approach, only
> three states are valid. It can never be the case that both are set,
> yet here is your hunk in rxe_requester:
> 
>   if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {
> 
> The part after the && will always evaluate to true, right? The code
> clears need_rnr_timeout wherever it sets need_retry. So this is testing
> for an impossible case.

Wrong. In the RNR path things are as you say but if the retry timer fires,
independently of receiving an RNR NAK, need_retry is set and need_rnr_timeout
may or may not be true. If we did receive an RNR NAK then we should ignore
the state of the retry timer until the rnr timer goes off.

Bob
> 
> That said, if you don't agree, the name needs to be less confusing.
> I guess I'd suggest "rnr_timer_running".
> 
>> Once this issue is resolved I will fix the spurious retries to make them a lot less likely.
> 
> Excellent. RoCE suffers from congestion enough without pouring
> gasoline on the fire.
> 
> Tom.
> 
>>>
>>>> This patch fixes rnr retry errors which can be observed by running the
>>>> pyverbs test suite 50-100X. With this patch applied they do not occur.
>>>>
>>>> Link: https://lore.kernel.org/linux-rdma/a8287823-1408-4273-bc22-99a0678db640@gmail.com/
>>>> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_comp.c  | 4 +---
>>>>    drivers/infiniband/sw/rxe/rxe_qp.c    | 1 +
>>>>    drivers/infiniband/sw/rxe/rxe_req.c   | 6 ++++--
>>>>    drivers/infiniband/sw/rxe/rxe_verbs.h | 1 +
>>>>    4 files changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
>>>> index 138b3e7d3a5f..bc668cb211b1 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
>>>> @@ -733,9 +733,7 @@ int rxe_completer(void *arg)
>>>>                    if (qp->comp.rnr_retry != 7)
>>>>                        qp->comp.rnr_retry--;
>>>>    -                qp->req.need_retry = 1;
>>>> -                pr_debug("qp#%d set rnr nak timer\n",
>>>> -                     qp_num(qp));
>>>> +                qp->req.need_rnr_timeout = 1;
>>>
>>> Suggest req.need_rnr_retry = -1  (and keep the useful pr_debug!)
>>>
>>>>                    mod_timer(&qp->rnr_nak_timer,
>>>>                          jiffies + rnrnak_jiffies(aeth_syn(pkt)
>>>>                            & ~AETH_TYPE_MASK));
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> index 62acf890af6c..1c962468714e 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> @@ -513,6 +513,7 @@ static void rxe_qp_reset(struct rxe_qp *qp)
>>>>        atomic_set(&qp->ssn, 0);
>>>>        qp->req.opcode = -1;
>>>>        qp->req.need_retry = 0;
>>>> +    qp->req.need_rnr_timeout = 0;
>>>>        qp->req.noack_pkts = 0;
>>>>        qp->resp.msn = 0;
>>>>        qp->resp.opcode = -1;
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>>>> index ae5fbc79dd5c..770ae4279f73 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>>>> @@ -103,7 +103,8 @@ void rnr_nak_timer(struct timer_list *t)
>>>>    {
>>>>        struct rxe_qp *qp = from_timer(qp, t, rnr_nak_timer);
>>>>    -    pr_debug("qp#%d rnr nak timer fired\n", qp_num(qp));
>>>> +    qp->req.need_retry = 1;
>>>> +    qp->req.need_rnr_timeout = 0;
>>>
>>> Simply setting need_retry = 1 would suffice, if suggestion accepted.
>>>
>>>>        rxe_run_task(&qp->req.task, 1);
>>>>    }
>>>>    @@ -624,10 +625,11 @@ int rxe_requester(void *arg)
>>>>            qp->req.need_rd_atomic = 0;
>>>>            qp->req.wait_psn = 0;
>>>>            qp->req.need_retry = 0;
>>>> +        qp->req.need_rnr_timeout = 0;
>>>>            goto exit;
>>>>        }
>>>>    -    if (unlikely(qp->req.need_retry)) {
>>>> +    if (unlikely(qp->req.need_retry && !qp->req.need_rnr_timeout)) {
>>>
>>> This would become (unlikely (qp->req.rnr_retry > 0)) ...
>>>
>>>>            req_retry(qp);
>>>>            qp->req.need_retry = 0;
>>>>        }
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> index e7eff1ca75e9..ab3186478c3f 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
>>>> @@ -123,6 +123,7 @@ struct rxe_req_info {
>>>>        int            need_rd_atomic;
>>>>        int            wait_psn;
>>>>        int            need_retry;
>>>> +    int            need_rnr_timeout;
>>>
>>> Drop
>>>
>>>>        int            noack_pkts;
>>>>        struct rxe_task        task;
>>>>    };
>>>>
>>>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
>>>
>>>
>>> Tom.
>>
>>

