Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEEE530829
	for <lists+linux-rdma@lfdr.de>; Mon, 23 May 2022 05:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiEWDvU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 May 2022 23:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353499AbiEWDvT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 22 May 2022 23:51:19 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E36DDEB8
        for <linux-rdma@vger.kernel.org>; Sun, 22 May 2022 20:51:17 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-f1eafa567cso13519706fac.8
        for <linux-rdma@vger.kernel.org>; Sun, 22 May 2022 20:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kL8Owk8JlhQcUDx6AfCEIiEcEmD3iCNCJKY2L2kdQvM=;
        b=IUI9lh27Z1ZaG7xjEjGZPJsQ9vcSgKS+0Sgmct8/ibpS5VJEawq1qpRpAU6RWWVxHw
         2+4btxthcpAAHRsOUh2HrJofHKfFjUQ0j2bgHymBOVgAlL19/YhmIGdBspAP7HEQ+4R0
         qSbVcwB8qAuuCYOh/8zt2H49PG/ifehrXRcNYkAJCwbRusoC1sHEgE8mqqGIJOe4hMkf
         /YUiyR8h2JiD+SYpwzW0RMjEBHiL1Z32eA+3t/4zu35qhAToJo3Z9M5LWT9AgMh8a3SZ
         RFqG9/25Crqy+n++CkBWvFILT5xQzwou+ev+po2WlqR0ntOXi1TqdIHbv7ffpOaq6eWR
         sD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kL8Owk8JlhQcUDx6AfCEIiEcEmD3iCNCJKY2L2kdQvM=;
        b=OKFQuMtIJBsrDrrXCee22m6sKn2cIhjehFWPpS9C4C1n1aBrkrWv9i4nj5uyeRU7kv
         X3lKpn0Ib7Z7cxtZVMsEpglw5gMTb6epsSI59FiuKmqrv7hVR1HiUm2z8cR04LN2aYUn
         OWh8MGvNtNKXq0oty73PI+k7g0EM77ZlpXob57szAlv4IXrSsT8AYj10tZ1FZoQpa1RJ
         L5ZYnFwI9OgwkUMg2uGab3qKkJibJ44brYYexXd150JmQeCIsoixw8Pg3WqpTAhrYuoJ
         EIpYoA+kRJc1nPR5Jgct3kNNKP5MQCRfy5A5Wqu7co5/7ZkhQgMhrdEsPFS/maaz/RA4
         zEIg==
X-Gm-Message-State: AOAM531GXQxC6rCyacStuuvmbtaU56T4L3YH0ozcD6YB4q9OlRxYk31/
        tHzEET7FJRRUgIOKMPEmyuw=
X-Google-Smtp-Source: ABdhPJxl/HifViPh13RyI38MnmT5bCvzX/kgQ1sNpNnp3i0PMdQjRwphbkHgrn/hUSVZiS2N1i7siw==
X-Received: by 2002:a05:6870:c59b:b0:f1:231c:c82c with SMTP id ba27-20020a056870c59b00b000f1231cc82cmr10784651oab.217.1653277876613;
        Sun, 22 May 2022 20:51:16 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id p187-20020acabfc4000000b0032b4ae1fc2csm559660oif.21.2022.05.22.20.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 20:51:16 -0700 (PDT)
Message-ID: <e81610d6-7896-03d6-91f9-15d68c7b8192@gmail.com>
Date:   Sun, 22 May 2022 22:51:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH for-next] RDMA/rxe: Fix incorrect fencing
Content-Language: en-US
To:     Haris Iqbal <haris.iqbal@ionos.com>
Cc:     jgg@nvidia.com, zyjzyj2000@gmail.com, jhack@hpe.com,
        frank.zago@hpe.com, linux-rdma@vger.kernel.org
References: <20220522223345.9889-1-rpearsonhpe@gmail.com>
 <CAJpMwyjjbZtG152GAZZV_t6sn8bw6J0tSGaaY_9LTdw0Ve7gEg@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAJpMwyjjbZtG152GAZZV_t6sn8bw6J0tSGaaY_9LTdw0Ve7gEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/22/22 18:59, Haris Iqbal wrote:
> On Mon, May 23, 2022 at 12:36 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> Currently the rxe driver checks if any previous operation
>> is not complete to determine if a fence wait is required.
>> This is not correct. For a regular fence only previous
>> read or atomic operations must be complete while for a local
>> invalidate fence all previous operations must be complete.
>> This patch corrects this behavior.
>>
>> Fixes: 8700e3e7c4857 ("Soft RoCE (RXE) - The software RoCE driver")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_req.c | 42 ++++++++++++++++++++++++-----
>>  1 file changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
>> index ae5fbc79dd5c..f36263855a45 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_req.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
>> @@ -163,16 +163,41 @@ static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
>>                      (wqe->state != wqe_state_processing)))
>>                 return NULL;
>>
>> -       if (unlikely((wqe->wr.send_flags & IB_SEND_FENCE) &&
>> -                                                    (index != cons))) {
>> -               qp->req.wait_fence = 1;
>> -               return NULL;
>> -       }
>> -
>>         wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
>>         return wqe;
>>  }
>>
>> +/**
>> + * rxe_wqe_is_fenced - check if next wqe is fenced
>> + * @qp: the queue pair
>> + * @wqe: the next wqe
>> + *
>> + * Returns: 1 if wqe is fenced (needs to wait)
>> + *         0 if wqe is good to go
>> + */
>> +static int rxe_wqe_is_fenced(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
>> +{
>> +       unsigned int cons;
>> +
>> +       if (!(wqe->wr.send_flags & IB_SEND_FENCE))
>> +               return 0;
>> +
>> +       cons = queue_get_consumer(qp->sq.queue, QUEUE_TYPE_FROM_CLIENT);
>> +
>> +       /* Local invalidate fence (LIF) see IBA 10.6.5.1
>> +        * Requires ALL previous operations on the send queue
>> +        * are complete.
>> +        */
>> +       if (wqe->wr.opcode == IB_WR_LOCAL_INV)
>> +               return qp->req.wqe_index != cons;
> 
> 
> Do I understand correctly that according to this code a wr with opcode
> IB_WR_LOCAL_INV needs to have the IB_SEND_FENCE also set for this to
> work?
> 
> If that is the desired behaviour, can you point out where in spec this
> is mentioned.

According to IBA "Local invalidate fence" (LIF) and regular Fence behave
differently. (See the referenced sections in the IBA.) For a local invalidate
operation the fence bit fences all previous operations. That was the old behavior
which made no distinction between local invalidate and other operations.
The change here are the other operations with a regular fence which should only
requires read and atomic operations to be fenced.

Not sure what you mean by 'also'. Per the IBA if the LIF is set then you have
strict invalidate ordering if not then you have relaxed ordering. The kernel verbs
API only has one fence bit and does not have a separate LIF bit so I am
interpreting them to share the one bit.

Bob
> 
> Thanks.
> 
> 
>> +
>> +       /* Fence see IBA 10.8.3.3
>> +        * Requires that all previous read and atomic operations
>> +        * are complete.
>> +        */
>> +       return atomic_read(&qp->req.rd_atomic) != qp->attr.max_rd_atomic;
>> +}
>> +
>>  static int next_opcode_rc(struct rxe_qp *qp, u32 opcode, int fits)
>>  {
>>         switch (opcode) {
>> @@ -636,6 +661,11 @@ int rxe_requester(void *arg)
>>         if (unlikely(!wqe))
>>                 goto exit;
>>
>> +       if (rxe_wqe_is_fenced(qp, wqe)) {
>> +               qp->req.wait_fence = 1;
>> +               goto exit;
>> +       }
>> +
>>         if (wqe->mask & WR_LOCAL_OP_MASK) {
>>                 ret = rxe_do_local_ops(qp, wqe);
>>                 if (unlikely(ret))
>>
>> base-commit: c5eb0a61238dd6faf37f58c9ce61c9980aaffd7a
>> --
>> 2.34.1
>>

