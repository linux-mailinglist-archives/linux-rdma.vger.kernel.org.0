Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9693D391B8D
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhEZPUw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbhEZPUs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 11:20:48 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80241C061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 08:19:13 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so1335545otp.4
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UHSZKXVSk1nyV/F9zlxOHu5ZYsTzGiJN2q0kl5SGanM=;
        b=OYY6pzz7FzmriX3OxfxXEUdW+iv5Az5ceKjnlMKCpByvZZatMUSn+lEbQc7aRnENHO
         o1vIdNp2XPxaUzyARWmZmd9EEbgTEixciiftJ3Cjg80DgEsKQ295fBwkJm/B4C9yDyiB
         EcFo1IAv3MxnW3zqXu778T6flJ/aKn9Iqox4BHpCJ9nxaKrPSVdJcfz6Wl4eJFmFv3xc
         XTfrB3xdbk8XJNwLerU6Ti5xTqAS0MEwjZ0ult90ihKjs0d9DgMfP+o8rBzFk8EYOHAJ
         6VvT44cLQ8fnApDJoohMcomTUJIfEY0LAJtvYVe6QYHo7ONddCT35JpsrJVEkpCN4Q9p
         NoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UHSZKXVSk1nyV/F9zlxOHu5ZYsTzGiJN2q0kl5SGanM=;
        b=LaOe25NcP4/oUXpiD5vLDpsZZFdp0734veSzkgW82i231Z1D+5b/A/2Mc977Gs6Xtz
         JWaJVHJZ+ToKttJqU4icbrDj/w4kAgWlFBq1EEPPcJdnJu5koe4fBk8wJJtDPm8XHtg5
         EBAZt7oCfIYRz3jc3ytthSrSP/djOOkcmFus6BUI46Er2Ofxujyijnul04yyzNYj89Hl
         LXySa+cbqis0h2QSzrBTbxSMuhvp7KRVQJtP00kes6YSKXR1BdT1Z+rLXDIDLGj8/pvF
         Uo2KpfiAfzOf5CE3s1dSDXAIUa/dlSzfe5Cw9yc/Ji5bic+9WgN5rWA6VbxpdLYhYgLt
         qm8g==
X-Gm-Message-State: AOAM53117KP23kT+09CsGs4trftxedf9H7Ye2Pqb+Nzh811t/i/6GSmp
        NZrbNY0W39f67RvYruEupbDdC4CL5MxNlw==
X-Google-Smtp-Source: ABdhPJyx+aql6ujGc8OusNlijehQpI+QIKwOPdfp3qLM+TGnzTv6ey9wFvDLlyHsj9/biARG043+QQ==
X-Received: by 2002:a05:6830:30b0:: with SMTP id g16mr2742300ots.301.1622042352559;
        Wed, 26 May 2021 08:19:12 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:9c3e:91a9:fec:4490? (2603-8081-140c-1a00-9c3e-91a9-0fec-4490.res6.spectrum.com. [2603:8081:140c:1a00:9c3e:91a9:fec:4490])
        by smtp.gmail.com with ESMTPSA id a6sm2047688oon.20.2021.05.26.08.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 08:19:12 -0700 (PDT)
Subject: Re: [PATCH for-next] RDMA/rxe: Fix memory ordering problem for resize
 cq
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, zyj2020@gmail.com,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210525201111.623970-1-rpearsonhpe@gmail.com>
 <CAD=hENdFca7919P37UGKt0bsph7TMTBomytJ93coivdpELhAJA@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <964d6d22-e633-76fd-c2e1-b05a1a21eeb0@gmail.com>
Date:   Wed, 26 May 2021 10:19:01 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAD=hENdFca7919P37UGKt0bsph7TMTBomytJ93coivdpELhAJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/26/2021 12:53 AM, Zhu Yanjun wrote:
> On Wed, May 26, 2021 at 6:27 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>> The rxe driver has recently begun exhibiting failures in the python
>> tests that are due to stale values read from the completion queue
>> producer or consumer indices. Unlike the other loads of these shared
>> indices those in queue_count() were not protected by smp_load_acquire().
>>
>> This patch replaces loads by smp_load_acquire() in queue_count().
>> The observed errors no longer occur.
>>
>> Reported-by: Zhu Yanjun <zyj2020@gmail.com>
>> Fixes: d21a1240f516 ("RDMA/rxe: Use acquire/release for memory ordering")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_queue.h | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
>> index 2902ca7b288c..5cb142282fa6 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
>> @@ -161,8 +161,22 @@ static inline unsigned int index_from_addr(const struct rxe_queue *q,
>>
>>   static inline unsigned int queue_count(const struct rxe_queue *q)
>>   {
>> -       return (q->buf->producer_index - q->buf->consumer_index)
>> -               & q->index_mask;
>> +       u32 prod;
>> +       u32 cons;
>> +       u32 count;
>> +
>> +       /* make sure all changes to queue complete before
>> +        * changing producer index
>> +        */
>> +       prod = smp_load_acquire(&q->buf->producer_index);
>> +
>> +       /* make sure all changes to queue complete before
>> +        * changing consumer index
>> +        */
>> +       cons = smp_load_acquire(&q->buf->consumer_index);
>> +       count = (prod - cons) % q->index_mask;
> % is different from &. Not sure it is correct to use % instead of & in
> the original source code.
>
> Zhu Yanjun

When I went to fix this I realized that this is the first version of 
this change. It is actually fixed in v2.

Bob

>
>> +
>> +       return count;
>>   }
>>
>>   static inline void *queue_head(struct rxe_queue *q)
>> --
>> 2.30.2
>>
