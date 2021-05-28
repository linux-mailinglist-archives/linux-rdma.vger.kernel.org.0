Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBC3394472
	for <lists+linux-rdma@lfdr.de>; Fri, 28 May 2021 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhE1Ou0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbhE1OuZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 28 May 2021 10:50:25 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508DFC061574
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 07:48:50 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id r1-20020a4aa2c10000b029023e8c840a7fso978109ool.12
        for <linux-rdma@vger.kernel.org>; Fri, 28 May 2021 07:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=i6faKy2PDLHF7/ZsBlwJ7sQerk6grfa47MPMD8DkX+A=;
        b=lj/T7uSCLCkPnMYXmg0/VIoeGQ62puFytJCyagv1gQoYvvVZr58NM77jveiGI1Ze+s
         5AUrBmVfzq29Qm4T1UlLN/CGgMQi+ziYVkDBh0G/UVjZhCMa+HBHsjEJcJ3M/k/w6+UN
         oW2Ot9pEufB2ted67dkGVQXZ7LT2XpwK3wf4w8tBVBzavW0Tt5tiw6asaXr4ibULHL1p
         FTlMPq79kJElCKqPE2jbLuB7/Ps0SvCMxOBklVFaB0DfDoCNz2CRLz9m4ulBneS+iJHf
         el2XZxmpSKKDxCKCgsCcOCtN30H+T0h7xbFa9hr2jtjcwsINbvsqNZmUjEoqpPb1CYRw
         yKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=i6faKy2PDLHF7/ZsBlwJ7sQerk6grfa47MPMD8DkX+A=;
        b=takYyF70SQfc1kfLsNkhIb/ni01scgDAYi3MMnobqBoM+QQpDItM7iInlzDVdZglwY
         XpKmYsNyYzE+BWEsWcg3+iU73AY4jx3WpwM7jbFbNF3YOfYAwpUj9kGtAFAM5A8FvYPF
         Y5VKv4LGk8NXfy2TtLCGmKBHoZ2cPnfDPq7V4cWalg9eqgFVJCIhmfRK2wXauhl0Qt11
         3zE9NCHObPxAV1fdGddyo0vpKVKBR5Nrif52GzZkzPP8j8qsD5z5cgbM0U2wwzqvdT9N
         Cf+qjyS/ipOkOPgeGxha6rFyy7tpnhmcSz2prkkYb15vZ/tTY/AYXspW7nz8ngFBXwZY
         TnpQ==
X-Gm-Message-State: AOAM533nDelJH+7TaGc442pHCkMcb7ERt1uYgcjRs+WvHuFga64kc1Le
        v3xI6XJXV8m/SeRkC+7+ruEB75SIZUs=
X-Google-Smtp-Source: ABdhPJxchvWNXenvL6NyQRd73wW09TnPhi5Tt/rw++RCmgIYM0DtjaI8775rK0Cimu3xPmti8PCurw==
X-Received: by 2002:a4a:9199:: with SMTP id d25mr7190929ooh.29.1622213329435;
        Fri, 28 May 2021 07:48:49 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:b0a2:8078:e58a:4032? (2603-8081-140c-1a00-b0a2-8078-e58a-4032.res6.spectrum.com. [2603:8081:140c:1a00:b0a2:8078:e58a:4032])
        by smtp.gmail.com with ESMTPSA id m66sm1156702oia.28.2021.05.28.07.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 07:48:49 -0700 (PDT)
Subject: Re: [PATCH for-next v3 1/3] RDMA/rxe: Add a type flag to rxe_queue
 structs
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210527194748.662636-1-rpearsonhpe@gmail.com>
 <20210527194748.662636-2-rpearsonhpe@gmail.com>
 <CAD=hENfX_N-pDgLXzYMTfi1=Qa+W6beGDrsvcVDiNRb0Tm-idA@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <1c2498d9-2a46-fd2c-3505-ae5e32995fcc@gmail.com>
Date:   Fri, 28 May 2021 09:48:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAD=hENfX_N-pDgLXzYMTfi1=Qa+W6beGDrsvcVDiNRb0Tm-idA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/28/2021 3:31 AM, Zhu Yanjun wrote:
> On Fri, May 28, 2021 at 3:47 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>> To create optimal code only want to use smp_load_acquire() and
>> smp_store_release() for user indices in rxe_queue APIs since
>> kernel indices are protected by locks which also act as memory
>> barriers. By adding a type to the queues we can determine which
>> indices need to be protected.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_cq.c    |  4 +++-
>>   drivers/infiniband/sw/rxe/rxe_qp.c    | 12 ++++++++----
>>   drivers/infiniband/sw/rxe/rxe_queue.c |  8 ++++----
>>   drivers/infiniband/sw/rxe/rxe_queue.h | 13 ++++++++++---
>>   drivers/infiniband/sw/rxe/rxe_srq.c   |  4 +++-
>>   5 files changed, 28 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
>> index b315ebf041ac..1d4d8a31bc12 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
>> @@ -59,9 +59,11 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
>>                       struct rxe_create_cq_resp __user *uresp)
>>   {
>>          int err;
>> +       enum queue_type type;
>>
>> +       type = uresp ? QUEUE_TYPE_TO_USER : QUEUE_TYPE_KERNEL;
> When is QUEUE_TYPE_TO_USER used? and when is QUEUE_TYPE_FROM_USER is used?
>
> Zhu Yanjun


QUEUE_TYPE_FROM_USER is used for user space send, recv and shared 
receive work queues. QUEUE_TYPE_TO_USER is used for user space 
completion queues. QUEUE_TYPE_KERNEL is used for kernel verbs consumers 
for any queue.

Bob

>
