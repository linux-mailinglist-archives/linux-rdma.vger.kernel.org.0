Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F27531A64
	for <lists+linux-rdma@lfdr.de>; Mon, 23 May 2022 22:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243631AbiEWSp0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 May 2022 14:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243637AbiEWSkn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 May 2022 14:40:43 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8C3185CA8
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 11:22:21 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-f189b07f57so19520317fac.1
        for <linux-rdma@vger.kernel.org>; Mon, 23 May 2022 11:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XgJtp0ZAe9cNq8PJHpg1FHohQWaJqVqdB8ogKmb1Rdc=;
        b=M+f8wxZdzDit17+OLBb8tL+JpZa3Z/aIR4pDvX5MHns2MV0sAE4WrwLqXm6W/Tyw5V
         hcMucoHN699PmjWESNIMPyYDYJ3SE/vBJMmFd/4Xw2wxNibCU44Nsd45LR1J6idlGkxI
         GpUCfK9r5072LnqRciy016f5zNuaUNdt+JWseoE4E0frcMQwBLBX/HtD0xIscvqRXxjN
         tQ0RnX1IvO4T3j37uKojcG78FU4vtr4GATLITd+ML6BqKmBMO5dj4TB+HCwUjWah/yjA
         em5DMvkylfaVjErVGk5GI8NOwwWiCp5/KJDncUytCHB7VmvkACtkrdCQ08WYXS+0+0IP
         Pp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XgJtp0ZAe9cNq8PJHpg1FHohQWaJqVqdB8ogKmb1Rdc=;
        b=W5lt5vWc6deOs6E1mEl9ubbeAh8uHAYOlUbnwhErwkZafWfHvmkFSquw/4EaCh8gtr
         YWIAVE9bA6QaUDF88I45hJSYeruk/Bu2d0+5kTMscZf1aRty6tD+3x/TFkYs90NIXnsz
         C1Qxl7st7n/u4KpPBgmk/7oVRff3EzUWEkp/QOFC/K4RtlGE6ibeiHo3fi/Dm4BW+UXM
         NrXd42UP8oeKZNaHoeoxLAzGbZrxvP0gM7Fizk0OTYeqy28M3khL20wzDlbLxOYudaT5
         Tao7pM/2LENAV6l4Ak8xjojcFVAPzCjJGpZ/gI7np399JZx5v28ctznzYdFv+0twro0W
         kkNA==
X-Gm-Message-State: AOAM531p68Ao6kJREw/fUrOrplIw+c/lKxaSNdPTB9oIXcO8dR6/wVW9
        TtGk+Gupz0kPUHjbSVk6k3k=
X-Google-Smtp-Source: ABdhPJwG2yaz8tCfA9RCmqwFeNEfA0ewnsOxP1LGYezmXqZSSRD5jbUbqgLNrUJVpZ4pi17yof9xuw==
X-Received: by 2002:a05:6870:434d:b0:e5:9115:cb15 with SMTP id x13-20020a056870434d00b000e59115cb15mr193129oah.53.1653330140350;
        Mon, 23 May 2022 11:22:20 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id x25-20020a9d6d99000000b0060603221280sm4270100otp.80.2022.05.23.11.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 11:22:19 -0700 (PDT)
Message-ID: <aa01e627-04fe-b331-b367-07cbb8731b8d@gmail.com>
Date:   Mon, 23 May 2022 13:22:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH for-next] RDMA/rxe: Fix incorrect fencing
Content-Language: en-US
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        frank.zago@hpe.com, linux-rdma@vger.kernel.org,
        Aleksei Marov <aleksei.marov@ionos.com>,
        Jinpu Wang <jinpu.wang@ionos.com>
References: <20220522223345.9889-1-rpearsonhpe@gmail.com>
 <CAJpMwyjjbZtG152GAZZV_t6sn8bw6J0tSGaaY_9LTdw0Ve7gEg@mail.gmail.com>
 <e81610d6-7896-03d6-91f9-15d68c7b8192@gmail.com>
 <CAJpMwyhsf_C6dosUH81_5aD4fd5XHNPD94B3NE=TT+fSBAKW1g@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJpMwyhsf_C6dosUH81_5aD4fd5XHNPD94B3NE=TT+fSBAKW1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/23/22 03:05, Haris Iqbal wrote:
> On Mon, May 23, 2022 at 5:51 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> On 5/22/22 18:59, Haris Iqbal wrote:
>>> On Mon, May 23, 2022 at 12:36 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>
>>>> Currently the rxe driver checks if any previous operation
>>>> is not complete to determine if a fence wait is required.
>>>> This is not correct. For a regular fence only previous
>>>> read or atomic operations must be complete while for a local
>>>> invalidate fence all previous operations must be complete.
>>>> This patch corrects this behavior.
>>>>
>>>> Fixes: 8700e3e7c4857 ("Soft RoCE (RXE) - The software RoCE driver")
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>  drivers/infiniband/sw/rxe/rxe_req.c | 42 ++++++++++++++++++++++++-----
>>>>  1 file changed, 36 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>>>> index ae5fbc79dd5c..f36263855a45 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>>>> @@ -163,16 +163,41 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
>>>>                      (wqe->state != wqe_state_processing)))
>>>>                 return NULL;
>>>>
>>>> -       if (unlikely((wqe->wr.send_flags & IB_SEND_FENCE) &&
>>>> -                                                    (index != cons))) {
>>>> -               qp->req.wait_fence = 1;
>>>> -               return NULL;
>>>> -       }
>>>> -
>>>>         wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
>>>>         return wqe;
>>>>  }
>>>>
>>>> +/**
>>>> + * rxe_wqe_is_fenced - check if next wqe is fenced
>>>> + * @qp: the queue pair
>>>> + * @wqe: the next wqe
>>>> + *
>>>> + * Returns: 1 if wqe is fenced (needs to wait)
>>>> + *         0 if wqe is good to go
>>>> + */
>>>> +static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>>>> +{
>>>> +       unsigned int cons;
>>>> +
>>>> +       if (!(wqe->wr.send_flags & IB_SEND_FENCE))
>>>> +               return 0;
>>>> +
>>>> +       cons = queue_get_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
>>>> +
>>>> +       /* Local invalidate fence (LIF) see IBA 10.6.5.1
>>>> +        * Requires ALL previous operations on the send queue
>>>> +        * are complete.
>>>> +        */
>>>> +       if (wqe->wr.opcode == IB_WR_LOCAL_INV)
>>>> +               return qp->req.wqe_index != cons;
>>>
>>>
>>> Do I understand correctly that according to this code a wr with opcode
>>> IB_WR_LOCAL_INV needs to have the IB_SEND_FENCE also set for this to
>>> work?
>>>
>>> If that is the desired behaviour, can you point out where in spec this
>>> is mentioned.
>>
>> According to IBA "Local invalidate fence" (LIF) and regular Fence behave
>> differently. (See the referenced sections in the IBA.) For a local invalidate
>> operation the fence bit fences all previous operations. That was the old behavior
>> which made no distinction between local invalidate and other operations.
>> The change here are the other operations with a regular fence which should only
>> requires read and atomic operations to be fenced.
>>
>> Not sure what you mean by 'also'. Per the IBA if the LIF is set then you have
>> strict invalidate ordering if not then you have relaxed ordering. The kernel verbs
>> API only has one fence bit and does not have a separate LIF bit so I am
>> interpreting them to share the one bit.
> 
> I see. Now I understand. Thanks for the explanation.
> 
> I do have a follow-up question. For a IB_WR_LOCAL_INV wr, without the
> fence bit means relaxed ordering. This would mean that the completion
> for that wr must take place "before any subsequent WQE has begun
> execution". From what I understand, multiple rxe_requester instances
> can run in parallel and pick up wqes and execute them. How is the
> relaxed ordering criteria fulfilled?

The requester is a tasklet. There is one tasklet instance per QP. Tasklets can only
run on a single cpu so not in parallel. The tasklets for multiple cpus each
execute a single send queue in order.
> 
>>
>> Bob
>>>
>>> Thanks.
>>>
>>>
>>>> +
>>>> +       /* Fence see IBA 10.8.3.3
>>>> +        * Requires that all previous read and atomic operations
>>>> +        * are complete.
>>>> +        */
>>>> +       return atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
>>>> +}
>>>> +
>>>>  static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
>>>>  {
>>>>         switch (opcode) {
>>>> @@ -636,6 +661,11 @@ int rxe_requester(void *arg)
>>>>         if (unlikely(!wqe))
>>>>                 goto exit;
>>>>
>>>> +       if (rxe_wqe_is_fenced(qp, wqe)) {
>>>> +               qp->req.wait_fence = 1;
>>>> +               goto exit;
>>>> +       }
>>>> +
>>>>         if (wqe->mask & WR_LOCAL_OP_MASK) {
>>>>                 ret = rxe_do_local_ops(qp, wqe);
>>>>                 if (unlikely(ret))
>>>>
>>>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
>>>> --
>>>> 2.34.1
>>>>
>>

