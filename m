Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2307850C303
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Apr 2022 01:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbiDVWvI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Apr 2022 18:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbiDVWu7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Apr 2022 18:50:59 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543322D9C1
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 15:12:12 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id r8so10559859oib.5
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wJPu8AYXD55GgbVR4+nMsOTtY9cvNPCjQE/JVbEu4x4=;
        b=arufFou4uVlOhjKtDSPGs2PFSYFVNhv3qb4Yp9tcHKzvXnqGCw3aWoLA1XIWg0/k4y
         SQYG1ZnqrME6PLJEqpW/8bMln3BV3Su7x6ic2hX1j8O9SLSEosOLdHYlUw7FVHFItdfK
         lFl818MjmOwqdlDqsQkqENIr6ATflV5RIUCzMT2weuBowBejLlULY+5vkkHzC8powbuO
         hJzN2BlhCLEsbT8z2iZuvk5ycClESP77Q4gVeJ5hyEU85oAAIdAzj/HrDwn7PXdcYqRh
         gdfe+1PNfFhTuqru/Y+HW5E0nstqtAOMZJhWuWnl58hzfSZa+zukOPtgFUcg+9pKebKP
         ojrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wJPu8AYXD55GgbVR4+nMsOTtY9cvNPCjQE/JVbEu4x4=;
        b=cJtgrYDzTnIJbo5QdHHy/xt0GwNKo4kd5Xnt7p9iQ46l057thaUKF3rBuVWW8yhkbs
         8SkWYgFqtp2h+63VFVnv1nyCsgQ+TDZC/0Ry8D+aKhq7Obj6yHl6jBN3GFN0B3i1GZuA
         nBQJF/0lyqe75BB4dnbUPVfZuL7wMf7/uokGBpb6wSBkF0wBCdlxBjVc7wWpJ3RUTzQ+
         QroXOLxfLJPFOGRuvb6Jlz64dVTSdEBkOpi+9j66dYqlGTzVcBxnSVZFCUOLGfw7OC8x
         EQxgwjY50DOf7frM6CIVLUSaCMXNsj5Sdm8/U31k5ES9MB7yzJIy+rO6IqV63Bf2A9a3
         a25w==
X-Gm-Message-State: AOAM530hOFXMeQhVMveAyOK01RFxFMcAdZRpIpUrk8J40gPJkG8K9Lng
        WUyvG9i/e7OM2OEsWZcEqqg=
X-Google-Smtp-Source: ABdhPJwZvHbDwfvQoUAw3VsTSNGqcihdTWhZc0SEVikhrhPtQFErLR9LJbMus6CD6dJqe3o67LMZpw==
X-Received: by 2002:a05:6808:3086:b0:325:16a:1c25 with SMTP id bl6-20020a056808308600b00325016a1c25mr450241oib.117.1650665503415;
        Fri, 22 Apr 2022 15:11:43 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e508:94f4:5ee:8557? (2603-8081-140c-1a00-e508-94f4-05ee-8557.res6.spectrum.com. [2603:8081:140c:1a00:e508:94f4:5ee:8557])
        by smtp.gmail.com with ESMTPSA id n62-20020acaef41000000b002ef646e6690sm1231879oih.53.2022.04.22.15.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 15:11:43 -0700 (PDT)
Message-ID: <387a0976-9f6f-29d3-347f-0ae551821b34@gmail.com>
Date:   Fri, 22 Apr 2022 17:11:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: much about ah objects in rxe
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <983bec37-4765-b45e-0f73-c474976d2dfc@gmail.com>
 <20220422210025.GL2120790@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220422210025.GL2120790@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/22/22 16:00, Jason Gunthorpe wrote:
> On Fri, Apr 22, 2022 at 01:32:24PM -0500, Bob Pearson wrote:
>> Jason,
>>
>> I am confused a little.
>>
>>  - xa_alloc_xxx internally takes xa->xa_lock with a spinlock but
>>    has a gfp_t parameter which is normally GFP_KERNEL. So I trust them when they say
>>    that it releases the lock around kmalloc's by 'magic' as you say.
>>
>>  - The only read side operation on the rxe pool xarrays is in rxe_pool_get_index() but
>>    that will be protected by a rcu_read_lock so it can't deadlock with the write
>>    side spinlocks regardless of type (plain, _bh, _saveirq)
>>
>>  - Apparently CM is calling ib_create_ah while holding spin locks. This would
>>    call xa_alloc_xxx which would unlock xa_lock and call kmalloc(..., GFP_KERNEL)
>>    which should cause a warning for AH. You say it does not because xarray doesn't
>>    call might_sleep().
>>
>> I am not sure how might_sleep() works. When I add might_sleep() just ahead of
>> xa_alloc_xxx() it does not cause warnings for CM test cases (e.g. rping.)
>> Another way to study this would be to test for in_atomic() but
> 
> might_sleep should work, it definately triggers from inside a
> spinlock. Perhaps you don't have all the right debug kconfig enabled?
> 
>> that seems to be discouraged and may not work as assumed. It's hard to reproduce
>> evidence that ib_create_ah really has spinlocks held by the caller. I think it
>> was seen in lockdep traces but I have a hard time reading them.
> 
> There is a call to create_ah inside RDMA CM that is under a spinlock
>  
>>  - There is a lot of effort trying to make 'deadlocks' go away. But the read side
>>    is going to end as up rcu_read_lock so there soon will be no deadlocks with
>>    rxe_pool_get_index() possible. xarrays were designed to work well with rcu
>>    so it would better to just go ahead and do it. Verbs objects tend to be long
>>    lived with lots of IO on each instance. This is a perfect use case for rcu.
> 
> Yes
> 
>> I think this means there is no reason for anything but a plain spinlock in rxe_alloc
>> and rxe_add_to_pool.
> 
> Maybe, are you sure there are no other xa spinlocks held from an IRQ?
> 
> And you still have to deal with the create AH called in an atomic
> region.

There are only 3 references to the xarrays:

	1. When an object is allocated. Either from rxe_alloc() which is called
	   an MR is registered or from rxe_add_to_pool() when the other
	   objects are created.
	2. When an object is looked up from rxe_pool_get_index()
	3. When an object is cleaned up from rxe_xxx_destroy() and similar.

For non AH objects the create and destroy verbs are always called in process
context and non-atomic and the lookup routine is normally called in soft IRQ
context but doesn't take a lock when rcu is used so can't deadlock.

For AH objects the create call is always called in process context but may
or may not hold an irq spinlock so hard interrupts are disabled to prevent
deadlocking CMs locks. The cleanup call is also in process context but also
may or may not hold an irq spinlock (not sure if it happens). These calls
can't deadlock each other for the xa_lock because there either won't be an
interrupt or because the process context calls don't cause reentering the
rxe code. They also can't deadlock with the lookup call when it is using rcu.

> 
>> To sum up once we have rcu enabled the only required change is to use GFP_ATOMIC
>> or find a way to pre-allocate for AH objects (assuming that I can convince myself
>> that ib_create_ah really comes with spinlocks held).
> 
> Possibly yes
> 
> Jason

