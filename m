Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFB0391B9F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 May 2021 17:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhEZPY6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 May 2021 11:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbhEZPY5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 May 2021 11:24:57 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678B8C061574
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 08:23:25 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id y76so1849519oia.6
        for <linux-rdma@vger.kernel.org>; Wed, 26 May 2021 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ASQtTVaNH64wW4Ov4ISUvXp2qGlk+nBhDHUAL3+a/gU=;
        b=rRtZIQoU/P6lKkiuf/RENqr390ngQ4v9xhGJBHJvXco7jWHYzEyBEc1iddGnuBPct9
         bhHAtfoJ4fkkfqw5K4M1QP3c5h3OrOkXPa2H40Dg6t4g2kqdbfcUfTBudnVgil/sitXQ
         RJ4MlHRhqlm+eyJVFE1/ewuGLU5b8g2dWXj70gLIkU3JanVdVwbpXc0Z9zdF0YSUEAcB
         pdHjMVJZPAjVUQvQJCltZ70g9hB7mNE7v1f9C0Dua1+Le/Sz7AM4QmwVACgt2OeDXUFf
         vWUApvGl2ilTeIfLUSaDBb44AYQh3DdLE4yxcobZtTqagv/dOLmEDd2mD2U1Mrt3wyt8
         h+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ASQtTVaNH64wW4Ov4ISUvXp2qGlk+nBhDHUAL3+a/gU=;
        b=SxkY3jsVagulwy3ZRaWnn9o5iUOmKfQ/Fs+HtMbsZpUIcZt9anntq7+PwC/kvAdV/8
         uOXYRs4gRXNPrD9CAlvF1WpFZ0RzjoS5PFmIHNle95QxfCvW4b1lFG7OKbk5xMBCVgFH
         RwTCyWQzV/qg/S2dt1WX+VDMC9TlhrdtebZsjFjN+JFHA5DMuAMQCpn8CTGfVN5dvyKI
         /CDlhJvM0F4J4K9wc9NK/+NvfzyoZOYz1SRlSkhN/kd1o1oJv90Hsts+/7DqpkMEGWHq
         i3s9KBHdZ7UIlhOerjKShHogxUmVUD2Xcy2Hf14N06cdHRhqzzN7/R4oFlCS/hXfPibF
         CDyg==
X-Gm-Message-State: AOAM532TYouIyJgG3gm0o6OjdKgBZNQ5YWboFJMbYOJ+ES2STKP6BDne
        w3OAlPH/p9mq29ohw9ncxra+eyfgu9SeEA==
X-Google-Smtp-Source: ABdhPJyG6FEiJ00c8Zj+J6SyOEA5Ce4OTe99GTbWGEvKjvyI2TV8YqBjKrSrxvhKNRYh7bZElqnP0w==
X-Received: by 2002:aca:ed8d:: with SMTP id l135mr2364387oih.4.1622042604465;
        Wed, 26 May 2021 08:23:24 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:9c3e:91a9:fec:4490? (2603-8081-140c-1a00-9c3e-91a9-0fec-4490.res6.spectrum.com. [2603:8081:140c:1a00:9c3e:91a9:fec:4490])
        by smtp.gmail.com with ESMTPSA id p3sm4124215oov.2.2021.05.26.08.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 08:23:24 -0700 (PDT)
Subject: Re: [PATCH for-next v2 2/2] RDMA/rxe: Protect user space index
 loads/stores
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
References: <20210526045139.634978-1-rpearsonhpe@gmail.com>
 <20210526045139.634978-3-rpearsonhpe@gmail.com>
 <CAD=hENfw3vbiKpBeRuTukQMMoiDBuyOJ2M-0CobN=ozjP9X_8A@mail.gmail.com>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Message-ID: <ad212084-2a9f-f619-dd8d-ef35e99ed823@gmail.com>
Date:   Wed, 26 May 2021 10:23:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAD=hENfw3vbiKpBeRuTukQMMoiDBuyOJ2M-0CobN=ozjP9X_8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 5/26/2021 5:19 AM, Zhu Yanjun wrote:
> On Wed, May 26, 2021 at 12:52 PM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>> Modify the queue APIs to protect all user space index loads
>> with smp_load_acquire() and all user space index stores with
>> smp_store_release(). Base this on the types of the queues which
>> can be one of ..KERNEL, ..FROM_USER, ..TO_USER. Kernel space
>> indices are protected by locks which also provide memory barriers.
>>
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>> v2:
>>    In v2 use queue type to selectively protect user space indices.
>> ---
>>   drivers/infiniband/sw/rxe/rxe_queue.h | 168 ++++++++++++++++++--------
>>   1 file changed, 117 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
>> index 4512745419f8..6e705e09d357 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
>> @@ -66,12 +66,22 @@ static inline int queue_empty(struct rxe_queue *q)
>>          u32 prod;
>>          u32 cons;
>>
>> -       /* make sure all changes to queue complete before
>> -        * testing queue empty
>> -        */
>> -       prod = smp_load_acquire(&q->buf->producer_index);
>> -       /* same */
>> -       cons = smp_load_acquire(&q->buf->consumer_index);
>> +       switch (q->type) {
>> +       case QUEUE_TYPE_FROM_USER:
>> +               /* protect user space index */
>> +               prod = smp_load_acquire(&q->buf->producer_index);
>> +               cons = q->buf->consumer_index;
>> +               break;
>> +       case QUEUE_TYPE_TO_USER:
>> +               prod = q->buf->producer_index;
>> +               /* protect user space index */
>> +               cons = smp_load_acquire(&q->buf->consumer_index);
>> +               break;
>> +       case QUEUE_TYPE_KERNEL:
>> +               prod = q->buf->producer_index;
>> +               cons = q->buf->consumer_index;
>> +               break;
>> +       }
>>
>>          return ((prod - cons) & q->index_mask) == 0;
>>   }
>> @@ -81,95 +91,151 @@ static inline int queue_full(struct rxe_queue *q)
>>          u32 prod;
>>          u32 cons;
>>
>> -       /* make sure all changes to queue complete before
>> -        * testing queue full
>> -        */
>> -       prod = smp_load_acquire(&q->buf->producer_index);
>> -       /* same */
>> -       cons = smp_load_acquire(&q->buf->consumer_index);
>> +       switch (q->type) {
>> +       case QUEUE_TYPE_FROM_USER:
>> +               /* protect user space index */
>> +               prod = smp_load_acquire(&q->buf->producer_index);
>> +               cons = q->buf->consumer_index;
>> +               break;
>> +       case QUEUE_TYPE_TO_USER:
>> +               prod = q->buf->producer_index;
>> +               /* protect user space index */
>> +               cons = smp_load_acquire(&q->buf->consumer_index);
>> +               break;
>> +       case QUEUE_TYPE_KERNEL:
>> +               prod = q->buf->producer_index;
>> +               cons = q->buf->consumer_index;
>> +               break;
>> +       }
>>
>>          return ((prod + 1 - cons) & q->index_mask) == 0;
>>   }
>>
>> -static inline void advance_producer(struct rxe_queue *q)
>> +static inline unsigned int queue_count(const struct rxe_queue *q)
>>   {
>>          u32 prod;
>> +       u32 cons;
>>
>> -       prod = (q->buf->producer_index + 1) & q->index_mask;
>> +       switch (q->type) {
>> +       case QUEUE_TYPE_FROM_USER:
>> +               /* protect user space index */
>> +               prod = smp_load_acquire(&q->buf->producer_index);
>> +               cons = q->buf->consumer_index;
>> +               break;
>> +       case QUEUE_TYPE_TO_USER:
>> +               prod = q->buf->producer_index;
>> +               /* protect user space index */
>> +               cons = smp_load_acquire(&q->buf->consumer_index);
>> +               break;
>> +       case QUEUE_TYPE_KERNEL:
>> +               prod = q->buf->producer_index;
>> +               cons = q->buf->consumer_index;
>> +               break;
>> +       }
> The above source code appears in the functions queue_count, queue_full
> and queue_empty.
> So is it possible to use a seperate function to implement it?
>
> Thanks
> Zhu Yanjun

Maybe, but I was trying to keep this inline. It won't save anything at 
runtime.

Bob

>
>> +
>> +       return (prod - cons) & q->index_mask;
>> +}
>> +
>> +static inline void advance_producer(struct rxe_queue *q)
>> +{
>> +       u32 prod;
>>
>> -       /* make sure all changes to queue complete before
>> -        * changing producer index
>> -        */
>> -       smp_store_release(&q->buf->producer_index, prod);
>> +       if (q->type == QUEUE_TYPE_FROM_USER) {
>> +               /* protect user space index */
>> +               prod = smp_load_acquire(&q->buf->producer_index);
>> +               prod = (prod + 1) & q->index_mask;
>> +               /* same */
>> +               smp_store_release(&q->buf->producer_index, prod);
>> +       } else {
>> +               prod = q->buf->producer_index;
>> +               q->buf->producer_index = (prod + 1) & q->index_mask;
>> +       }
>>   }
>>
>>   static inline void advance_consumer(struct rxe_queue *q)
>>   {
>>          u32 cons;
>>
>> -       cons = (q->buf->consumer_index + 1) & q->index_mask;
>> -
>> -       /* make sure all changes to queue complete before
>> -        * changing consumer index
>> -        */
>> -       smp_store_release(&q->buf->consumer_index, cons);
>> +       if (q->type == QUEUE_TYPE_TO_USER) {
>> +               /* protect user space index */
>> +               cons = smp_load_acquire(&q->buf->consumer_index);
>> +               cons = (cons + 1) & q->index_mask;
>> +               /* same */
>> +               smp_store_release(&q->buf->consumer_index, cons);
>> +       } else {
>> +               cons = q->buf->consumer_index;
>> +               q->buf->consumer_index = (cons + 1) & q->index_mask;
>> +       }
>>   }
>>
>>   static inline void *producer_addr(struct rxe_queue *q)
>>   {
>> -       return q->buf->data + ((q->buf->producer_index & q->index_mask)
>> -                               << q->log2_elem_size);
>> +       u32 prod;
>> +
>> +       if (q->type == QUEUE_TYPE_FROM_USER)
>> +               /* protect user space index */
>> +               prod = smp_load_acquire(&q->buf->producer_index);
>> +       else
>> +               prod = q->buf->producer_index;
>> +
>> +       return q->buf->data + ((prod & q->index_mask) << q->log2_elem_size);
>>   }
>>
>>   static inline void *consumer_addr(struct rxe_queue *q)
>>   {
>> -       return q->buf->data + ((q->buf->consumer_index & q->index_mask)
>> -                               << q->log2_elem_size);
>> +       u32 cons;
>> +
>> +       if (q->type == QUEUE_TYPE_TO_USER)
>> +               /* protect user space index */
>> +               cons = smp_load_acquire(&q->buf->consumer_index);
>> +       else
>> +               cons = q->buf->consumer_index;
>> +
>> +       return q->buf->data + ((cons & q->index_mask) << q->log2_elem_size);
>>   }
>>
>>   static inline unsigned int producer_index(struct rxe_queue *q)
>>   {
>> -       u32 index;
>> +       u32 prod;
>> +
>> +       if (q->type == QUEUE_TYPE_FROM_USER)
>> +               /* protect user space index */
>> +               prod = smp_load_acquire(&q->buf->producer_index);
>> +       else
>> +               prod = q->buf->producer_index;
>>
>> -       /* make sure all changes to queue
>> -        * complete before getting producer index
>> -        */
>> -       index = smp_load_acquire(&q->buf->producer_index);
>> -       index &= q->index_mask;
>> +       prod &= q->index_mask;
>>
>> -       return index;
>> +       return prod;
>>   }
>>
>>   static inline unsigned int consumer_index(struct rxe_queue *q)
>>   {
>> -       u32 index;
>> +       u32 cons;
>>
>> -       /* make sure all changes to queue
>> -        * complete before getting consumer index
>> -        */
>> -       index = smp_load_acquire(&q->buf->consumer_index);
>> -       index &= q->index_mask;
>> +       if (q->type == QUEUE_TYPE_TO_USER)
>> +               /* protect user space index */
>> +               cons = smp_load_acquire(&q->buf->consumer_index);
>> +       else
>> +               cons = q->buf->consumer_index;
>>
>> -       return index;
>> +       cons &= q->index_mask;
>> +
>> +       return cons;
>>   }
>>
>> -static inline void *addr_from_index(struct rxe_queue *q, unsigned int index)
>> +static inline void *addr_from_index(struct rxe_queue *q,
>> +                               unsigned int index)
>>   {
>>          return q->buf->data + ((index & q->index_mask)
>>                                  << q->buf->log2_elem_size);
>>   }
>>
>>   static inline unsigned int index_from_addr(const struct rxe_queue *q,
>> -                                          const void *addr)
>> +                               const void *addr)
>>   {
>>          return (((u8 *)addr - q->buf->data) >> q->log2_elem_size)
>> -               & q->index_mask;
>> -}
>> -
>> -static inline unsigned int queue_count(const struct rxe_queue *q)
>> -{
>> -       return (q->buf->producer_index - q->buf->consumer_index)
>> -               & q->index_mask;
>> +                               & q->index_mask;
>>   }
>>
>>   static inline void *queue_head(struct rxe_queue *q)
>> --
>> 2.30.2
>>
