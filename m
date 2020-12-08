Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9D2D2258
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 05:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgLHExg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 23:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgLHExf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Dec 2020 23:53:35 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF56C061749
        for <linux-rdma@vger.kernel.org>; Mon,  7 Dec 2020 20:52:55 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 11so14774093oty.9
        for <linux-rdma@vger.kernel.org>; Mon, 07 Dec 2020 20:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SDk7vCV2eYXQhzr+fHp0uCLO+EUulAZ6ufMLH/oB4zc=;
        b=fKtOnxSY8O4pxWOAjVm9BoV4acRkhZJ9F2v9kRkHpr8KcBVVBHRA8bCdkOl/j9+wH8
         cCmPTz9pR0gkZtmTST+4U3k2j5mAaQIJ6C14mS+eOaWBuKKLi5eQkKKi6jQg5vylMu9F
         R8iC6KQtBOge4c2EXG8aoJFNHSIrm1CflzQC0ekatmHo9iCw1kqcwuQRspFho7JnIE9E
         0h1JYsX5QGl9YyaQgbYhctxJCl59LIfoCsEjeP8FsX2a6+zEYTuiCqAAJaafKVDsXP/Z
         dEok2Ecz8XInZKXSv4TJEPzVR4xyYHZHSPS+nwfGAe/lW6yxDsAmcGFIbrcSfTPgZfi/
         ZnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SDk7vCV2eYXQhzr+fHp0uCLO+EUulAZ6ufMLH/oB4zc=;
        b=nU0MXxhmUc9VLsL6v4FH9tqKM0gYzkRglWwA00fmNSsXuqDTr7zRBGqHbmaDs5Jw2C
         MVMai4DPHS4s3Bsd8Lq1+mnTVpqsvSHW5khkaa7usg/YQj4IeNcIu8lpDr22odZzGmLl
         V4mISkDWA1ayoJpGQz54idtMe5W4vDdeUhYAWfmLgQppst9wZ80T8hvOqy3MkZ/fMlxF
         kah5jh9AYMbLPCAX8wLXyxT2Tk6lXG6iym0iHZ7GgUnC9uuXp0dp71GoNLrm1caLC6WZ
         7IVKC5VZKkMCMTnjeVsDdX8XVwx3syDLXoDg9Y+EXuNEa7OyCzL2kbdSDkEJzdqcyITW
         +cJg==
X-Gm-Message-State: AOAM5319gTInrpm7j+HKpWR8IEDVTU+ml/g8q6aN+dcGru/U4SYW6Pa0
        20eXNf/JpxCAK/yE6j1DoKqMEw3Nm7c=
X-Google-Smtp-Source: ABdhPJws1t+vm8T/Mb/7ZyI32cGRrdtf7D2nuoGHKGSqxUVXbVtR+X7gMRevSOBeanaE6mBEnz7bCg==
X-Received: by 2002:a9d:682:: with SMTP id 2mr15636399otx.39.1607403174894;
        Mon, 07 Dec 2020 20:52:54 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:8cc9:46e:d08d:ce3b? (2603-8081-140c-1a00-8cc9-046e-d08d-ce3b.res6.spectrum.com. [2603:8081:140c:1a00:8cc9:46e:d08d:ce3b])
        by smtp.gmail.com with ESMTPSA id g12sm70554oos.8.2020.12.07.20.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:52:54 -0800 (PST)
Subject: Re: [linux-rdma/rdma-core] rxe extended verbs support (#878)
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <linux-rdma/rdma-core/pull/878@github.com>
 <linux-rdma/rdma-core/pull/878/review/546359978@github.com>
 <CS1PR8401MB0821D8F4700390086C961177BCCE0@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <eee069aa-b7dd-4822-dbbc-078be8c518b4@gmail.com>
Date:   Mon, 7 Dec 2020 22:52:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CS1PR8401MB0821D8F4700390086C961177BCCE0@CS1PR8401MB0821.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/7/20 1:42 PM, Pearson, Robert B wrote:
> 
> 
> From: Jason Gunthorpe <notifications@github.com>
> Sent: Monday, December 7, 2020 11:17 AM
> To: linux-rdma/rdma-core <rdma-core@noreply.github.com>
> Cc: Pearson, Robert B <robert.pearson2@hpe.com>; Author <author@noreply.github.com>
> Subject: Re: [linux-rdma/rdma-core] rxe extended verbs support (#878)
> 
> 
> @jgunthorpe requested changes on this pull request.
> 
> ________________________________
> 
> In providers/rxe/rxe_queue.h<https://github.com/linux-rdma/rdma-core/pull/878#discussion_r537679241>:
> 
>>       atomic_store(
> 
>             &q->consumer_index,
> 
>             (atomic_load_explicit(&q->consumer_index, memory_order_relaxed) +
> 
>              1) &
> 
>                q->index_mask);
> 
>  }
> 
> 
> 
> +/* Must hold producer_index lock */
> 
> +static inline uint32_t load_producer_index(struct rxe_queue *q)
> 
> +{
> 
> +       return atomic_load_explicit(&q->producer_index,
> 
> +                                  memory_order_relaxed);
> 
> +}
> 
> +
> 
> +/* Must hold producer_index lock */
> 
> +static inline void store_producer_index(struct rxe_queue *q, uint32_t index)
> 
> +{
> 
> +       /* flush writes to work queue before moving index */
> 
> +       atomic_thread_fence(memory_order_release);
> 
> +       atomic_store(&q->producer_index, index);
> 
> This combination is just atomic_store_explicit(... memory_order_release);
> 
> ________________________________
> 
> In providers/rxe/rxe_queue.h<https://github.com/linux-rdma/rdma-core/pull/878#discussion_r537679461>:
> 
>> +                                memory_order_relaxed);
> 
> +}
> 
> +
> 
> +/* Must hold producer_index lock */
> 
> +static inline void store_producer_index(struct rxe_queue *q, uint32_t index)
> 
> +{
> 
> +       /* flush writes to work queue before moving index */
> 
> +       atomic_thread_fence(memory_order_release);
> 
> +       atomic_store(&q->producer_index, index);
> 
> +}
> 
> +
> 
> +/* Must hold consumer_index lock */
> 
> +static inline uint32_t load_consumer_index(struct rxe_queue *q)
> 
> +{
> 
> +       return atomic_load_explicit(&q->consumer_index,
> 
> +                                  memory_order_relaxed);
> 
> I suspect this should be memory_order_acquire
> 
> ________________________________
> 
> In providers/rxe/rxe_queue.h<https://github.com/linux-rdma/rdma-core/pull/878#discussion_r537679679>:
> 
>> +     atomic_store(&q->producer_index, index);
> 
> +}
> 
> +
> 
> +/* Must hold consumer_index lock */
> 
> +static inline uint32_t load_consumer_index(struct rxe_queue *q)
> 
> +{
> 
> +       return atomic_load_explicit(&q->consumer_index,
> 
> +                                  memory_order_relaxed);
> 
> +}
> 
> +
> 
> +/* Must hold consumer_index lock */
> 
> +static inline void store_consumer_index(struct rxe_queue *q, uint32_t index)
> 
> +{
> 
> +       /* flush writes to work queue before moving index */
> 
> +       atomic_thread_fence(memory_order_release);
> 
> +       atomic_store(&q->consumer_index, index);
> 
> atomic_store_explicit
> 
> ________________________________
> 
> In providers/rxe/rxe.c<https://github.com/linux-rdma/rdma-core/pull/878#discussion_r537680251>:
> 
>> @@ -162,20 +162,144 @@ static int rxe_dereg_mr(struct verbs_mr *vmr)
> 
>         return 0;
> 
>  }
> 
> 
> 
> +static int cq_start_poll(struct ibv_cq_ex *current,
> 
> +                       struct ibv_poll_cq_attr *attr)
> 
> +{
> 
> +       struct rxe_cq *cq = container_of(current, struct rxe_cq, vcq.cq_ex);
> 
> +
> 
> +       pthread_spin_lock(&cq->lock);
> 
> +
> 
> +       atomic_thread_fence(memory_order_acquire);
> 
> atomic_thread_fence/atomic_XX pairs should always be merged into an atomic_XX_explicit operation for performance
> 
> ________________________________
> 
> In providers/rxe/rxe.c<https://github.com/linux-rdma/rdma-core/pull/878#discussion_r537680632>:
> 
>> +
> 
> +       if (attr->wc_flags & IBV_WC_EX_WITH_SL)
> 
> +              cq->vcq.cq_ex.read_sl
> 
> +                      = cq_read_sl;
> 
> +
> 
> +       if (attr->wc_flags & IBV_WC_EX_WITH_DLID_PATH_BITS)
> 
> +              cq->vcq.cq_ex.read_dlid_path_bits
> 
> +                      = cq_read_dlid_path_bits;
> 
> +
> 
> +       return &cq->vcq.cq_ex;
> 
> +
> 
> +err_unmap:
> 
> +       if (cq->mmap_info.size)
> 
> +              munmap(cq->queue, cq->mmap_info.size);
> 
> +err_destroy:
> 
> +       (void)ibv_cmd_destroy_cq(&cq->vcq.cq);
> 
> No (void) please
> 
> —
> You are receiving this because you authored the thread.
> Reply to this email directly, view it on GitHub<https://github.com/linux-rdma/rdma-core/pull/878#pullrequestreview-546359978>, or unsubscribe<https://github.com/notifications/unsubscribe-auth/ARXBUZWZIICJ6IQJYHRZJYLSTUEYJANCNFSM4TT4I57Q>.
> 

Jason,

This is the first time I have ever used the atomic_xx APIs so apologies if I got this wrong.
I updated the PR to what I think is correct and removed the 2 (void) casts.

There are two types of memory access issues. (1) Between kernel and user space there is no explicit locking and
synchronization is achieved by separate producer and consumer indices which must be atomic and need to fence
memory operations accessing the WC and WR structs before changing the indices. This uses acquire/release
memory ordering. (2) Between separate user threads there is explicit locking which provides a memory barrier so relaxed memory ordering can be used. The existing code was a bit of a hodge-podge. I think it is correct now
but it needs a look over. If I understand this correctly most of this turns into no-ops for X86_64 architectures
so I can't really test this.

Synchronization between kernel threads is also protected by spinlocks. The current PR is complete as far as user
space is concerned but a similar exercise will be required to optimize the atomic accesses in the kernel driver and
fix up the inline functions in (kernel)rxe_queue.h to match the user space ones. It may make sense to move rxe_queue.h into kernel_headers/rdma/ or merge with rdma_user_rxe.h. Thoughts?

Bob
