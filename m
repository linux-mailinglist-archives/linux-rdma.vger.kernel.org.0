Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984A1526664
	for <lists+linux-rdma@lfdr.de>; Fri, 13 May 2022 17:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382195AbiEMPnA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 May 2022 11:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382207AbiEMPm6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 May 2022 11:42:58 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A8B326C0
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 08:42:52 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id k25-20020a056830169900b00605f215e55dso5200940otr.13
        for <linux-rdma@vger.kernel.org>; Fri, 13 May 2022 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=PkJPsRBjGRiYk3mE4GV/YrpFid4hgGjc8pJq/HAkkik=;
        b=OD//0aeuZLgbkLNr13hwSR+gUYoZyqND5uIggu596bpJFM2b2foNkypyn8N8S+2+kM
         rTaEnSK0G+MH7V3wyFk0UMMtoOXHnpasQ1xCEcQPgHOFZtv2j1XWZno+T7BRSmRNK5KH
         VfwaLp3avRHx/pRRQMfVOFn1ZY3LiHp9z/CeBVEknpq8s7Sg0zqQQO1uqJSGVskKcbSP
         MafwpzumPt4H+wbll0eXQGR8W6B/9mYGOBjDjdgu8RtwgVMV8Cpo8Umf8vb3O9e63Mdx
         Md3Y18Hg8iF5y+UqRi2y2/8jQ/RP8QOkFImABGWPe2tB++kSEey5ZBAOKT5CPUvTEmdI
         wPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PkJPsRBjGRiYk3mE4GV/YrpFid4hgGjc8pJq/HAkkik=;
        b=j/lMJRvmkbbHeQOg890h/H+y1x69vwp+XFkpx7epBb9Nb+yQorHB3aV/PUt4BZuc4h
         G099IIjfV/8lyc8vD5cIMvWHKTjMinVI67/bUIX6BPCrHZ5tEUpNLF/SAmeYx7fiUlws
         tkxtfWXR7BeHhsZVIQeoHWmgdOZHKIgT/DiY3ShyGTKy6e8+Q5eYdvHYHA+auLrTN33L
         SJNyR7ajuZVpG8wr6Du6Uf7/ykFuJv5P6WmxkS/8A0/9Fww7Wxk4OrURAK108jMlqOlQ
         RRuIIMgSod4iYKhQFd5M20yBfiaJ4qLS0s1vPXic10qCv9YGAwYGiOuAeAhiks71BpGb
         FNTg==
X-Gm-Message-State: AOAM5337u/Et4purwkkVCYREuw8plVUCc3dtnqlW1JCTVkyxiDO1P12+
        shGmp3BCLFOoNn4/ELAR4LijaGtI+/E=
X-Google-Smtp-Source: ABdhPJwplWPsezRllnL76nRSXPhlD9U5dlTUT1gz0TGH7ORLXzU/K9ij6Ov125UK67zcqrCUo7EM8g==
X-Received: by 2002:a9d:c67:0:b0:605:da22:8181 with SMTP id 94-20020a9d0c67000000b00605da228181mr2060935otr.149.1652456571357;
        Fri, 13 May 2022 08:42:51 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7f98:64fc:d1b4:c63a? (2603-8081-140c-1a00-7f98-64fc-d1b4-c63a.res6.spectrum.com. [2603:8081:140c:1a00:7f98:64fc:d1b4:c63a])
        by smtp.gmail.com with ESMTPSA id s124-20020aca5e82000000b00325cda1ffb8sm1089502oib.55.2022.05.13.08.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 08:42:51 -0700 (PDT)
Message-ID: <29797ad1-01dd-eabd-fde0-511ba79ce4cc@gmail.com>
Date:   Fri, 13 May 2022 10:42:50 -0500
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

I see them consistently. It is just luck of timing. If you add print statements
to show when the retry timer fires and when the rnr timer fires you should see that
all the retry sequences are a result of the retry timer and not the rnr timer.
This means that you are not allowing the requested rnr delay for the responder.
In my traces most of the time the retry timer fires and the test ends and the qp
is torn down deleting the rnr timer before it ever times out. Occasionally the
retry timer fires too early and the test fails. This is still a bug and it should
be fixed.

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

