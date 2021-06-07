Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C8A39E191
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 18:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFGQOE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 12:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGQOD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 12:14:03 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C792AC061787
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 09:11:55 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id q5-20020a9d66450000b02903f18d65089fso1035451otm.11
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 09:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1MzLUrdkaUn2Z4b3GgiYenodX/ligUGd1uLkUnO4H1o=;
        b=gBN2ylVPntc/ZpJVuORkon8g9DRqmHsD6+aFrCboH/J7UmFtHwSxPH02RqcmAH6mtp
         GIAcgJb0jQQbSPt6AkCp79oLRwNkj+UgRQizqf3xjmLuiK2i05sA3Zk+mxcBgzdxtsVZ
         1PboF7yVx6Wo+tSrvQw5aXR01cTZ1C1QzYuCFG4znBQ8Ss3FlWKe63lYztd/2hJv8wpj
         7vXxinAUnYLAqI94jiTtVPtzgS4kDS6aB59QWHCWV4ppGkHPfLCUhsc2xfpY0BZfvJym
         7xpwtLQVefikNzNI9eMJQQBu7S0Kqhg4cNsEJcm4I+OQwhC2Ba1Z0/ImHlzIORKJ5ZMb
         27Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1MzLUrdkaUn2Z4b3GgiYenodX/ligUGd1uLkUnO4H1o=;
        b=sdNdEk+jxnw+YhufmWsigIEyBD3c5UTka+O+rVxBTGq+EzO6UCHg5iZEjGgHPi6byM
         VKixZ6FkOh4dewREAkDVXmcy5kd98Uxcd66u75i76Id14VnR2uq+CQ8K6wh7sQ982oIM
         0mRpuKzpgH9LDOBYQ33wPguJ3tFa6mtkisxyiai5pyQ50ubL0p6U89OKvCyDJ516BkEW
         bq9p8STxZtotyuqJnzxf1MdhCp695X0DaO9MN8C8SxT2WwXM+P2g0nT+cK+yDITypEN8
         zvdIfLoY3xDxk4ufWK6eAY+yly2W82tiK5ul/iGnyEtT/80RumVz1UnlUpaIph+3t70w
         C4zA==
X-Gm-Message-State: AOAM533N7gUcb0+Gkm9Gkndx0uhTTK+ESzHkNsfmY62kWsF/DxUkwwUe
        0x8rKc7W9Q6M7EfTx32uJ9gmpGtGhuE=
X-Google-Smtp-Source: ABdhPJxbqLJGcfbkEuDYMtt3cSo2qGEQiRTdBtSoTHK/XTKA+3VwmCzlzJXh8ooLQ+YJFNPxre1I3w==
X-Received: by 2002:a05:6830:1d72:: with SMTP id l18mr2358387oti.150.1623082314874;
        Mon, 07 Jun 2021 09:11:54 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:415a:f1da:2582:537? (2603-8081-140c-1a00-415a-f1da-2582-0537.res6.spectrum.com. [2603:8081:140c:1a00:415a:f1da:2582:537])
        by smtp.gmail.com with ESMTPSA id 7sm2405126oti.30.2021.06.07.09.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 09:11:54 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix qp reference counting for atomic
 ops
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210604230558.4812-1-rpearsonhpe@gmail.com>
 <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <c6d5c37c-b0b3-ba08-7d08-0e7ae78d795a@gmail.com>
Date:   Mon, 7 Jun 2021 11:11:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAD=hENcwwjS8X2R24+cFRyyrA5_k=F5LuC4bx1tzCVW969uvuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 6/7/2021 3:16 AM, Zhu Yanjun wrote:
> On Sat, Jun 5, 2021 at 7:07 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>> Currently the rdma_rxe driver attempts to protect atomic responder
>> resources by taking a reference to the qp which is only freed when the
>> resource is recycled for a new read or atomic operation. This means that
>> in normal circumstances there is almost always an extra qp reference
>> once an atomic operation has been executed which prevents cleaning up
>> the qp and associated pd and cqs when the qp is destroyed.
>>
>> This patch removes the call to rxe_add_ref() in send_atomic_ack() and the
>> call to rxe_drop_ref() in free_rd_atomic_resource(). If the qp is
> Not sure if it is a good way to fix this problem by removing the call
> to rxe_add_ref.
> Because taking a reference to the qp is to protect atomic responder resources.

There is no good way to 'protect' responder resources. They are there to 
recover from a lost response packet which can occur multiple times. The 
peer can retry the atomic request an unpredictable number of times. 
There are no acks for response packets. So the QP just has to leave it 
in place until the max number of read/atomic requests has been received 
and then it re-uses the responder resource. So to 'protect' the 
responder resource means you have to leave the QP around potentially 
forever which is the root cause of the bug. In fact you should treat a 
retry of a read/atomic the same as a new request and when the QP is 
destroyed it stops responding to new requests.

There is a reference to the QP taken by a received packet which lasts 
until the packet is freed to prevent kernel seg faults if the QP is 
destroyed while a request is in process of being responded to.

>
> Removing rxe_add_ref is to decrease the protection of the atomic
> responder resources.
>
> Zhu Yanjun
>
>> destroyed while a peer is retrying an atomic op it will cause the
>> operation to fail which is acceptable.
>>
>> Reported-by: Zhu Yanjun <zyjzyj2000@gmail.com>
>> Fixes: 86af61764151 ("IB/rxe: remove unnecessary skb_clone")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_qp.c   | 1 -
>>   drivers/infiniband/sw/rxe/rxe_resp.c | 2 --
>>   2 files changed, 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
>> index 34ae957a315c..b6d83d82e4f9 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
>> @@ -136,7 +136,6 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
>>   void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
>>   {
>>          if (res->type == RXE_ATOMIC_MASK) {
>> -               rxe_drop_ref(qp);
>>                  kfree_skb(res->atomic.skb);
>>          } else if (res->type == RXE_READ_MASK) {
>>                  if (res->read.mr)
>> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
>> index 2b220659bddb..39dc39be586e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
>> @@ -966,8 +966,6 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>>                  goto out;
>>          }
>>
>> -       rxe_add_ref(qp);
>> -
>>          res = &qp->resp.resources[qp->resp.res_head];
>>          free_rd_atomic_resource(qp, res);
>>          rxe_advance_resp_resource(qp);
>> --
>> 2.30.2
>>
