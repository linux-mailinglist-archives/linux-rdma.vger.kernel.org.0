Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545E160B910
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Oct 2022 22:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJXUCF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Oct 2022 16:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiJXT7y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Oct 2022 15:59:54 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BFBEF5A6;
        Mon, 24 Oct 2022 11:22:56 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id l145so12026653ybl.0;
        Mon, 24 Oct 2022 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TeS6XPUczdie4eaqlnOAPlW0FEt9n83emArYqVPwRrM=;
        b=MUuO8OU2rCTih/P8ZXCE1En7f8qvqedrL5Zg0+aqoOYOMiR2/uvsU/6rFlwXQ987pm
         eJ/6bAgtyALmwdxjViA8c2Kngbn6/UrWmFhgRiZhUqyj0lF3UB5ON5HOObVza9tZWTFq
         wHcQgPn9Fkd63xw03RQqLScorHbhIc+pscx/p0ZWRzMCGYCcDAvbWfeSinL6EwPq2xMY
         kOs117u5NX/vwU9FPfxFvS/zCUHNG5hnjRSkU5F+inrLVyRxuEVg7UvqvvLdF37peObA
         WML5j7U4J0JAiMWP813vILnOiFJ7IkJylnRY962aKRz88IdaMpZnwNj4Gvv61GETK+bH
         AQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TeS6XPUczdie4eaqlnOAPlW0FEt9n83emArYqVPwRrM=;
        b=CfxjfbkNQyOSGcWoHPWFwAOjQh2jd6i92qU2JGDnOVfc5jJkugIb2pcMkhCCvauOwJ
         Rd0kt6HGcYFVCYf5AaeiVcBJZH9hZxnMEMMiJh0LnOvl39AlwoQXMeIO8UGizsA3SlDT
         pJgPwB2PdeX4bWBQccw3wU+He4MFS4gAEU+sYofisHQt0z/EznIBv/SXa/3lOlNAF86p
         B1PL7nYoGxr+ldF/35pV3lo+z9qRkNWO4T+N9FOQPJJPumoNZRilKMKcaoR7eVe4JguX
         wGKHg9aO84eVvZiQNN/uwO6trj/6G/hBGLUWAZkHdbSKefN6yL4q9DX4Pr+xj3vwzPpy
         lPzg==
X-Gm-Message-State: ACrzQf0/Leb4vLJWjl4Q1/oVV4z+cTDTYop046Jt8Rqn2UJelYvzAbX8
        /35nvV+GakXZXFbtOIu0VBniGsxMxDQ=
X-Google-Smtp-Source: AMsMyM5iAenOVsfgunXXqN+ep1GsVEnASgexy2VPyFIROANfq4+1wRAhwLxxEMICOB7wBNaSSfvWhQ==
X-Received: by 2002:a05:6830:61ce:b0:661:6fa:92bc with SMTP id cc14-20020a05683061ce00b0066106fa92bcmr16769316otb.178.1666620573452;
        Mon, 24 Oct 2022 07:09:33 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1e0:e60:c33:b344? (2603-8081-140c-1a00-01e0-0e60-0c33-b344.res6.spectrum.com. [2603:8081:140c:1a00:1e0:e60:c33:b344])
        by smtp.gmail.com with ESMTPSA id p15-20020a4adc0f000000b0047f94999318sm297oov.29.2022.10.24.07.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 07:09:32 -0700 (PDT)
Message-ID: <454431b3-0e65-6181-0849-4b0bc7d7ad3d@gmail.com>
Date:   Mon, 24 Oct 2022 09:09:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [for-next PATCH v2 1/2] RDMA/rxe: Remove unnecessary mr testing
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Li Zhijian <lizhijian@fujitsu.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1666338764-2-1-git-send-email-lizhijian@fujitsu.com>
 <1666338764-2-2-git-send-email-lizhijian@fujitsu.com>
 <CAD=hENeGMKri0nYMtcu98K2j3D+ZBkxO6fFX5cvvyJsEghrrmQ@mail.gmail.com>
 <1846f2e1-ff13-5fa2-240f-fd7749921ce2@fujitsu.com>
 <30ff25c4-ce66-eac4-eaa2-64c0db203a19@gmail.com>
 <CAD=hENeTnLGN5KKi_Cwni6FDb77prijHVjCjfdvhrjXdp7bdjQ@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENeTnLGN5KKi_Cwni6FDb77prijHVjCjfdvhrjXdp7bdjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/23/22 21:25, Zhu Yanjun wrote:
> On Mon, Oct 24, 2022 at 2:05 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> On 10/21/22 20:09, Li Zhijian wrote:
>>>
>>>
>>> On 21/10/2022 22:39, Zhu Yanjun wrote:
>>>> On Fri, Oct 21, 2022 at 3:53 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
>>>>> Before the testing, we already passed it to rxe_mr_copy() where mr could
>>>>> be dereferenced. so this checking is not exactly correct.
>>>>>
>>>>> I tried to figure out the details how/when mr could be NULL, but failed
>>>>> at last. Add a WARN_ON(!mr) to that path to tell us more when it
>>>>> happends.
>>>> If I get you correctly, you confronted a problem,
>>> Not exactly,  I removed the mr checking since i think this checking is not correct.
>>> the newly added WARN_ON(!mr) is the only once place where the mr can be NULL but not handled correctly.
>>> At least with/without this patch, once WARN_ON(!mr) is triggered, kernel will go something wrong.
>>>
>>> so i want to place this  WARN_ON(!mr) to point to the problem.
>>>
>>> Thanks
>>> Zhijian
>>>
>>>>   but you can not figure it out.
>>>> So you send it upstream as a patch?
>>>>
>>>> I am not sure if it is a good idea.
>>>>
>>>> Zhu Yanjun
>>>>
>>>>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>>>>> ---
>>>>>   drivers/infiniband/sw/rxe/rxe_resp.c | 4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> index ed5a09e86417..218c14fb07c6 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>>>>> @@ -778,6 +778,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>>>          if (res->state == rdatm_res_state_new) {
>>>>>                  if (!res->replay) {
>>>>>                          mr = qp->resp.mr;
>>>>> +                       WARN_ON(!mr);
>>>>>                          qp->resp.mr = NULL;
>>>>>                  } else {
>>>>>                          mr = rxe_recheck_mr(qp, res->read.rkey);
>>>>> @@ -811,8 +812,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>>>>>
>>>>>          rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
>>>>>                      payload, RXE_FROM_MR_OBJ);
>>>>> -       if (mr)
>>>>> -               rxe_put(mr);
>>>>> +       rxe_put(mr);
>>>>>
>>>>>          if (bth_pad(&ack_pkt)) {
>>>>>                  u8 *pad = payload_addr(&ack_pkt) + payload
>>>>> --
>>>>> 2.31.1
>>>>>
>>>
>>
>> Li is correct that the only way mr could be NULL is if qp->resp.mr == NULL. So the
> 
> What I am concerned about is if "WARN_ON(!mr);" should be added or not.
> IMO, if the root cause remains unclear, this should be a problem.
> Currently this problem is not fixed. It is useless to send a debug
> statement to the maillist.

Li was fixing a bug that no one ever saw. mr is not NULL in this case.

Bob
> 
> Zhu Yanjun
> 
>> 'if (mr)' is not needed if that is the case. The read_reply subroutine is reached
>> from a new rdma read operation after going through check_rkey or from a previous
>> rdma read operations from get_req if qp->resp.res != NULL or from a duplicate request
>> where the previous responder resource is found. In all these cases the mr is set.
>> Initially in check_rkey where if it can't find the mr it causes an RKEY_VIOLATION.
>> Thereafter the rkey is stored in the responder resources and looked up for each
>> packet to get an mr or cause an RKEY_VIOLATION. So the mr can't be NULL. I think
>> you can leave out the WARN and just drop the if (mr).
>>
>> Bob
>>

