Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747EF57538F
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 18:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbiGNQ5g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 12:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiGNQ5f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 12:57:35 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6904B0EF
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:57:35 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w81so3153841oiw.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XstdQzT78z4D442NCdtE38h9amdJfx4/2kOUrHQKgKI=;
        b=N+CBgGi4yNScItMfiGRIIAzqqobNg/6pgfz0fkYaEWRs/6SNrDITw9tvhwDpYVnLGt
         DCpGvpDVsB4VyCaZ1eGL0LkZKKEzpVtTQTGlBylA/g6NwkgfrnPGAqvbzAgDe6A8Cgz2
         wiHn8tMwnFcFaxlIvrq0FJC4QRlRsoqAjRRVQgtlxeCwfs1QNREvAmNVrP1Oy+W9qIp6
         aeU2OkBNwagAyTjxQmk9GWgSw5D3ovtnunbZZs3BWKG09X/d4Fk6r6IRJimZ+91flUlr
         o87TycjqI6sv2NmaslQHduLCZ8BSkRVbuxkQy2bQN9/VabKXfr+SrvdtqgXn1qGNKvDc
         mhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XstdQzT78z4D442NCdtE38h9amdJfx4/2kOUrHQKgKI=;
        b=U1Ui5fM8aRlqFWBSxL1g+/v4uaVfBjWcdv5m2pyQ6K6SS3oFbneg0P7m7rJ9adRioL
         LIo4FA8wcqbU1m1YGw+9FN1z6z6fEcAW7nSC4bpu/T7aX0N89AVBSzBSxdex5jmbv0J4
         YgB85BIMKaKkGEupOPabcoGORw90mmmEg6ccI6PteU1FvsTmAfGOOYVkH5mKAY3LCt9K
         Qfazo0L4nSx3iEvUV5dx4q5+miJpN8Z74/ARz8YAokni9FsyAChaTQoH6aq1rOkxuC3T
         mZMXqgO/Jqs7IqjjIaO0pzPyhrfHI4UXVLY8nk0Jzji85J2BSkFXnm24qiE4oL6BhbKd
         sDYw==
X-Gm-Message-State: AJIora+uJrXQrWXBBfZJzXMbHO40glt2av/mv7J6A2PZJbh25cucVdpR
        qPmTICKiZ3iIogqw7n+tybE=
X-Google-Smtp-Source: AGRyM1voQHWAp+5FOzbjY494A2voJH0ZqZcQPMI23x75ax5zYRNbzhn1gtDV28JlaI82UNhFl3NoAA==
X-Received: by 2002:aca:5e05:0:b0:337:bd43:860b with SMTP id s5-20020aca5e05000000b00337bd43860bmr4734044oib.181.1657817854454;
        Thu, 14 Jul 2022 09:57:34 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id c11-20020a056870478b00b0010c8b6e70ffsm1063363oaq.37.2022.07.14.09.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:57:33 -0700 (PDT)
Message-ID: <db269f1b-cd63-0fb0-fc9d-9c8cac33a4cc@gmail.com>
Date:   Thu, 14 Jul 2022 11:57:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in
 rxe_qp_do_cleanup
Content-Language: en-US
To:     Haris Iqbal <haris.iqbal@ionos.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20220705225414.315478-1-yanjun.zhu@linux.dev>
 <CAJpMwyg8YF30W_43oKD=cQ8b9pWaSh-aPON4u50b2VG==WXBwQ@mail.gmail.com>
 <1a57273c-0427-959d-8ed4-9be1e1c7b9bd@linux.dev>
 <CAJpMwyh7LCdaejvymwxvoSJWTjL=sHEmVb65Khz-aXEhBn+fjg@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJpMwyh7LCdaejvymwxvoSJWTjL=sHEmVb65Khz-aXEhBn+fjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/6/22 08:11, Haris Iqbal wrote:
> On Wed, Jul 6, 2022 at 3:10 PM Yanjun Zhu <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2022/7/5 18:35, Haris Iqbal 写道:
>>> On Tue, Jul 5, 2022 at 8:28 AM <yanjun.zhu@linux.dev> wrote:
>>>>
>>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>>
>>>> The function rxe_create_qp calls rxe_qp_from_init. If some error
>>>> occurs, the error handler of function rxe_qp_from_init will set
>>>> both scq and rcq to NULL.
>>>>
>>>> Then rxe_create_qp calls rxe_put to handle qp. In the end,
>>>> rxe_qp_do_cleanup is called by rxe_put. rxe_qp_do_cleanup directly
>>>> accesses scq and rcq before checking them. This will cause
>>>> null-ptr-deref error.
>>>>
>>>> The call graph is as below:
>>>>
>>>> rxe_create_qp {
>>>>    ...
>>>>    rxe_qp_from_init {
>>>>      ...
>>>>    err1:
>>>>      ...
>>>>      qp->rcq = NULL;  <---rcq is set to NULL
>>>>      qp->scq = NULL;  <---scq is set to NULL
>>>>      ...
>>>>    }
>>>>
>>>> qp_init:
>>>>    rxe_put{
>>>>      ...
>>>>      rxe_qp_do_cleanup {
>>>>        ...
>>>>        atomic_dec(&qp->scq->num_wq); <--- scq is accessed
>>>>        ...
>>>>        atomic_dec(&qp->rcq->num_wq); <--- rcq is accessed
>>>>      }
>>>> }
>>>>
>>>> Fixes: 4703b4f0d94a ("RDMA/rxe: Enforce IBA C11-17")
>>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>> ---
>>>> V1->V2: Describe the error flows.
>>>> ---
>>>>   drivers/infiniband/sw/rxe/rxe_qp.c | 10 ++++++----
>>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> index 22e9b85344c3..b79e1b43454e 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>>>> @@ -804,13 +804,15 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>>>>          if (qp->rq.queue)
>>>>                  rxe_queue_cleanup(qp->rq.queue);
>>>>
>>>> -       atomic_dec(&qp->scq->num_wq);
>>>> -       if (qp->scq)
>>>> +       if (qp->scq) {
>>>> +               atomic_dec(&qp->scq->num_wq);
>>>>                  rxe_put(qp->scq);
>>>> +       }
>>>>
>>>> -       atomic_dec(&qp->rcq->num_wq);
>>>> -       if (qp->rcq)
>>>> +       if (qp->rcq) {
>>>> +               atomic_dec(&qp->rcq->num_wq);
>>>>                  rxe_put(qp->rcq);
>>>> +       }
>>>>
>>>>          if (qp->pd)
>>>>                  rxe_put(qp->pd);
>>>> --
>>>> 2.34.1
>>>
>>> Looks good.
>>>
>>> Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
>>>
>>> Should the check for "rxe_cleanup_task(&qp->comp.task);" also happen
>>> in this commit? or would it be covered in a different one?
>>
>> It is in a different commit. I will send it out very soon.
> 
> Okay. Thank you!
> 
>>
>> Zhu Yanjun
>>
>>>
>>>>
>>

Agreed.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
