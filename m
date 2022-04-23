Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96DF50C768
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Apr 2022 06:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiDWEho (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 23 Apr 2022 00:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiDWEhe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 23 Apr 2022 00:37:34 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219662F0
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 21:34:38 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id a10so11234420oif.9
        for <linux-rdma@vger.kernel.org>; Fri, 22 Apr 2022 21:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ITS/CGcJRISKXrgk90SzhGTR2zRduvHLGbKs2f2bItk=;
        b=qcFmY8pgDWkUbGCV16Kf+U1qoTc1bNen8OpeH3K2Qol5gVVZsbCyExQdJcKXQE8HhH
         PGND6zCdM0b14C0JaPXXHWQeUem0TpvYbREVV0tU7aIoVyQn1I7AtBTR5H8QJzl7kxHk
         o+/+nXpHqMvT9lXQ/cFK8OLlwDmL+sqcY8EovNETGWlxFPSLlBN4Pc+arMpiCKmScOmu
         DqdxgbJbXVUh9XtzPuV2jG7m8lvhRv9YQCmXfBonQ2hwZfxnK4BDIHeQt5wAvDQCaVGk
         TW5sp8L0nKxrg2DhPC+/csvzTvl3ywDyDNiylU+PB2DeiY9EOoa1BiPiHwYj5PVPhdlr
         erdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ITS/CGcJRISKXrgk90SzhGTR2zRduvHLGbKs2f2bItk=;
        b=3KYQg+rYtH9GWUz8S2OtVjsQdIU3ofb4az2E3ACkdcBk3Zk7B7ZG3n7ml6mmKKsDGY
         FleptjIKl45QuJ1AL71bU1nsZm02jakDhsYraCb5wMIE5EgnkQ3nFVbaqDyRXNAvfj+N
         78C7bGBoOgp8AInzkcgZ3gFzqzGVV2sddNJQ0XizoSlsuqPixD0oplBfMZukr9FSJ0Ar
         vcXGpseVLD5H1szQ+SL3an252Jqq4AjGzolkgGVL6tUdlKe7jCWCS8LjBolw4HsvQqvw
         g6l9G6G341RT+APP9iI7gYszHfddVY4QFCzvmcuVGQ2PpNHhMOTw19hTCk4IT7N7NLoc
         0gsQ==
X-Gm-Message-State: AOAM5337iZ7zJvoRcQRvQ1J9sjnrRixWPsF9OQe3LbqHhIWHof7BLUL6
        8Z8Ax1M34e47Ecb9cuVxMxU0CN6RxWA=
X-Google-Smtp-Source: ABdhPJyMPTIQJAMUzSbWoFpuy4NhD/PChB0jwXzxFhPjoOq4MYBcCMgdu1EUAtM0Af+GTT9eJ2Ugog==
X-Received: by 2002:a05:6808:1828:b0:322:4891:8832 with SMTP id bh40-20020a056808182800b0032248918832mr8192106oib.172.1650688477573;
        Fri, 22 Apr 2022 21:34:37 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e508:94f4:5ee:8557? (2603-8081-140c-1a00-e508-94f4-05ee-8557.res6.spectrum.com. [2603:8081:140c:1a00:e508:94f4:5ee:8557])
        by smtp.gmail.com with ESMTPSA id g16-20020a4a9250000000b0033a7783dda8sm1606378ooh.48.2022.04.22.21.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 21:34:37 -0700 (PDT)
Message-ID: <3f43b00d-dff0-45df-3f46-c428d6155152@gmail.com>
Date:   Fri, 22 Apr 2022 23:34:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: much about ah objects in rxe
Content-Language: en-US
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <983bec37-4765-b45e-0f73-c474976d2dfc@gmail.com>
 <20220422210025.GL2120790@nvidia.com>
 <387a0976-9f6f-29d3-347f-0ae551821b34@gmail.com>
 <CAD=hENe6mQhOEp976UX+cR9Yf74gABcSnt7iXmitVV3sGcVzfA@mail.gmail.com>
 <5fc18e8e-25f9-5398-f0c8-e546466e08f3@gmail.com>
 <CAD=hENetRAy359Gj7-prCRjKkovz3_+xQT-Dt26Rr9YD0uGGFA@mail.gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <CAD=hENetRAy359Gj7-prCRjKkovz3_+xQT-Dt26Rr9YD0uGGFA@mail.gmail.com>
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

On 4/22/22 21:35, Zhu Yanjun wrote:
> On Sat, Apr 23, 2022 at 9:48 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>
>> On 4/22/22 20:18, Zhu Yanjun wrote:
>>> On Sat, Apr 23, 2022 at 6:11 AM Bob Pearson <rpearsonhpe@gmail.com> wrote:
>>>>
>>>> On 4/22/22 16:00, Jason Gunthorpe wrote:
>>>>> On Fri, Apr 22, 2022 at 01:32:24PM -0500, Bob Pearson wrote:
>>>>>> Jason,
>>>>>>
>>>>>> I am confused a little.
>>>>>>
>>>>>>  - xa_alloc_xxx internally takes xa->xa_lock with a spinlock but
>>>>>>    has a gfp_t parameter which is normally GFP_KERNEL. So I trust them when they say
>>>>>>    that it releases the lock around kmalloc's by 'magic' as you say.
>>>>>>
>>>>>>  - The only read side operation on the rxe pool xarrays is in rxe_pool_get_index() but
>>>>>>    that will be protected by a rcu_read_lock so it can't deadlock with the write
>>>>>>    side spinlocks regardless of type (plain, _bh, _saveirq)
>>>>>>
>>>>>>  - Apparently CM is calling ib_create_ah while holding spin locks. This would
>>>>>>    call xa_alloc_xxx which would unlock xa_lock and call kmalloc(..., GFP_KERNEL)
>>>>>>    which should cause a warning for AH. You say it does not because xarray doesn't
>>>>>>    call might_sleep().
>>>>>>
>>>>>> I am not sure how might_sleep() works. When I add might_sleep() just ahead of
>>>>>> xa_alloc_xxx() it does not cause warnings for CM test cases (e.g. rping.)
>>>>>> Another way to study this would be to test for in_atomic() but
>>>>>
>>>>> might_sleep should work, it definately triggers from inside a
>>>>> spinlock. Perhaps you don't have all the right debug kconfig enabled?
>>>>>
>>>>>> that seems to be discouraged and may not work as assumed. It's hard to reproduce
>>>>>> evidence that ib_create_ah really has spinlocks held by the caller. I think it
>>>>>> was seen in lockdep traces but I have a hard time reading them.
>>>>>
>>>>> There is a call to create_ah inside RDMA CM that is under a spinlock
>>>>>
>>>>>>  - There is a lot of effort trying to make 'deadlocks' go away. But the read side
>>>>>>    is going to end as up rcu_read_lock so there soon will be no deadlocks with
>>>>>>    rxe_pool_get_index() possible. xarrays were designed to work well with rcu
>>>>>>    so it would better to just go ahead and do it. Verbs objects tend to be long
>>>>>>    lived with lots of IO on each instance. This is a perfect use case for rcu.
>>>>>
>>>>> Yes
>>>>>
>>>>>> I think this means there is no reason for anything but a plain spinlock in rxe_alloc
>>>>>> and rxe_add_to_pool.
>>>>>
>>>>> Maybe, are you sure there are no other xa spinlocks held from an IRQ?
>>>>>
>>>>> And you still have to deal with the create AH called in an atomic
>>>>> region.
>>>>
>>>> There are only 3 references to the xarrays:
>>>>
>>>>         1. When an object is allocated. Either from rxe_alloc() which is called
>>>>            an MR is registered or from rxe_add_to_pool() when the other
>>>>            objects are created.
>>>>         2. When an object is looked up from rxe_pool_get_index()
>>>>         3. When an object is cleaned up from rxe_xxx_destroy() and similar.
>>>>
>>>> For non AH objects the create and destroy verbs are always called in process
>>>> context and non-atomic and the lookup routine is normally called in soft IRQ
>>>> context but doesn't take a lock when rcu is used so can't deadlock.
>>>
>>> Are you sure about this? There are about several non AH objects.
>>> You can make sure that all in process context?
>>>
>>> And you can ensure it in the future?
>>
>> I added the line
>>
>>         WARN_ON(!in_task());
>>
>> to rxe_alloc and rxe_add_to_pool
>>
>> and it never triggered. I would be theoretically possible for someone to try
> 
> Your test environment does not mean that all the test environments
> will not trigger this.
> 
>> to write a module that responds to an interrupt in some wigit and then
>> tries to start a verbs session. But it would be very strange. It is reasonable
>> to just declare that the verbs APIs are not callable in interrupt (soft or hard)
> 
> This will limit verbs APIs use.
Not really. The verbs APIs are written assuming that they are in process context.
Just look at the code. You could never allocate memory without GFP_ATOMIC but
that is not the case there are GFP_KERNELs all over the place. No one could use
tasklets or mutexes because they schedule. No one could ever sleep. If you want to
make the rdma verbs APIs callable from interrupt handlers be my guest but you have
a huge job to fix all the places in all the providers that make the opposite assumption.
> 
>> context. I believe this is tacitly understood and currently is true. It is a
>> separate issue whether or not the caller is in 'atomic context' which includes
>> holding a spinlock and implies that the thread cannot sleep. the xarray code
>> if you look at the code for xa_alloc_cyclic() does take the xa_lock spinlock around
>> _xa_alloc_cyclic() but they also say in the comments that they release that lock
>> internally before calling kmalloc() and friends if the gfp_t parameter is
>> GFP_KERNEL so that it is safe to sleep.  However cma.c calls ib_create_ah() while
>> holding spinlocks (happens to be spin_lock_saveirq() but that doesn't matter here
>> since any spinlock makes it bad to call kmalloc()). So we have to use GFP_ATOMIC
>> for AH objects.
>>
>> It is clear that the assumption of the verbs APIs is that they are always called
>> in process context.
> 
> How to ensure that they are not called in interrupt context? And some
> kernel modules 
> also use the rdma.
Kernel modules can and do use rdma but they use the verbs API from process context.
Any system call ends up in kernel code in process context.
> 
>>>
>>>>
>>>> For AH objects the create call is always called in process context but may
>>>
>>> How to ensure it?
>>
>> Same way. It is true now see the WARN_ON above.
>>>
>>>> or may not hold an irq spinlock so hard interrupts are disabled to prevent
>>>> deadlocking CMs locks. The cleanup call is also in process context but also
>>>> may or may not hold an irq spinlock (not sure if it happens). These calls
>>>> can't deadlock each other for the xa_lock because there either won't be an
>>>> interrupt or because the process context calls don't cause reentering the
>>>> rxe code. They also can't deadlock with the lookup call when it is using rcu.
>>>
>>> From you, all the operations including create, destroy and lookup are
>>> in process context or soft IRQ context.
>>> How to ensure it? I mean that all operations are always in process or
>>> soft IRQ context, and will not violate?
>>> Even though in different calls ?
>>
>> We have no way to get into interrupt context. We get called from above through
>> the verbs APIs in process context and from below by NAPI passing network packets
>> to us in softirq context. We also internally defer work to tasklets which are
>> always soft IRQs. Unless someone outside of the rdma-core subsystem called into
>> verbs calls from interrupt context (weird) it can never happen. And has never
>> happened. Again don't get confused with irqsave spinlocks. They are used in
>> process or soft irq context sometimes and disable hardware interrupts to prevent
>> a deadlock with another spinlock in a hardware interrupt handler. But we don't
>> have any code that runs in hardware interrupt context to worry about. 
>> cma does either but many people use irqsave spinlocks when they are not needed.
> 
> How to verify that many people use unnecessary irqsave spinlock?

Please read https://www.kernel.org/doc/html/v4.13/kernel-hacking/locking.html
especially look at the "Table of locking requirements". The only place where _saveirq
(SLIS) is really required is when two different interrupt handlers are sharing data.
All other cases are correctly addressed with plain, _bh and _irq (not _irqsave) spinlocks.
Nevertheless it is in widespread use all over the place. People are just lazy.
> 
> Zhu Yanjun
> 
>>>
>>> Zhu Yanjun
>>>
>>>>
>>>>>
>>>>>> To sum up once we have rcu enabled the only required change is to use GFP_ATOMIC
>>>>>> or find a way to pre-allocate for AH objects (assuming that I can convince myself
>>>>>> that ib_create_ah really comes with spinlocks held).
>>>>>
>>>>> Possibly yes
>>>>>
>>>>> Jason
>>>>
>>

