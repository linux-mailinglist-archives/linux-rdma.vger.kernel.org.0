Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291C92292EF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 10:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgGVIFi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 04:05:38 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:1885 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVIFh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 04:05:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 80C113F89C;
        Wed, 22 Jul 2020 10:05:32 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=r+A/yXu5;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LtesimML5tCB; Wed, 22 Jul 2020 10:05:31 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 5B1263FA05;
        Wed, 22 Jul 2020 10:05:28 +0200 (CEST)
Received: from [192.168.0.100] (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id BEE22362551;
        Wed, 22 Jul 2020 10:05:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1595405130; bh=VTus/6AbWlsqqDyaiMd7dlOgvwrBywZ/lvDt+28dCLo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=r+A/yXu5rtcZQfoAKsafVO1QlKXWNGPFT6uP5+exKqizL8J/rQF8uiKJQ0zVlPbIK
         FP0AJc/S0rSKtFRE2FqJff27OQ3sWeh3/qtxGAcuh3DzYaek2xCKQXWbnIHjLcE8ek
         /LXRFJt0OoVOz7g0k5t0JMTWBWAG81ghURGd4Q9U=
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
 <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
 <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
 <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org>
Date:   Wed, 22 Jul 2020 10:05:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uHhhxBC2MvnNnU9FjxJaWkEcP3m5m7AN3yzfw=wxFsckA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2020-07-22 09:11, Daniel Vetter wrote:
> On Wed, Jul 22, 2020 at 8:45 AM Thomas Hellström (Intel)
> <thomas_os@shipmail.org> wrote:
>>
>> On 2020-07-22 00:45, Dave Airlie wrote:
>>> On Tue, 21 Jul 2020 at 18:47, Thomas Hellström (Intel)
>>> <thomas_os@shipmail.org> wrote:
>>>> On 7/21/20 9:45 AM, Christian König wrote:
>>>>> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
>>>>>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellström (Intel)
>>>>>> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
>>>>>>>> Comes up every few years, gets somewhat tedious to discuss, let's
>>>>>>>> write this down once and for all.
>>>>>>>>
>>>>>>>> What I'm not sure about is whether the text should be more explicit in
>>>>>>>> flat out mandating the amdkfd eviction fences for long running compute
>>>>>>>> workloads or workloads where userspace fencing is allowed.
>>>>>>> Although (in my humble opinion) it might be possible to completely
>>>>>>> untangle
>>>>>>> kernel-introduced fences for resource management and dma-fences used
>>>>>>> for
>>>>>>> completion- and dependency tracking and lift a lot of restrictions
>>>>>>> for the
>>>>>>> dma-fences, including prohibiting infinite ones, I think this makes
>>>>>>> sense
>>>>>>> describing the current state.
>>>>>> Yeah I think a future patch needs to type up how we want to make that
>>>>>> happen (for some cross driver consistency) and what needs to be
>>>>>> considered. Some of the necessary parts are already there (with like the
>>>>>> preemption fences amdkfd has as an example), but I think some clear docs
>>>>>> on what's required from both hw, drivers and userspace would be really
>>>>>> good.
>>>>> I'm currently writing that up, but probably still need a few days for
>>>>> this.
>>>> Great! I put down some (very) initial thoughts a couple of weeks ago
>>>> building on eviction fences for various hardware complexity levels here:
>>>>
>>>> https://gitlab.freedesktop.org/thomash/docs/-/blob/master/Untangling%20dma-fence%20and%20memory%20allocation.odt
>>> We are seeing HW that has recoverable GPU page faults but only for
>>> compute tasks, and scheduler without semaphores hw for graphics.
>>>
>>> So a single driver may have to expose both models to userspace and
>>> also introduces the problem of how to interoperate between the two
>>> models on one card.
>>>
>>> Dave.
>> Hmm, yes to begin with it's important to note that this is not a
>> replacement for new programming models or APIs, This is something that
>> takes place internally in drivers to mitigate many of the restrictions
>> that are currently imposed on dma-fence and documented in this and
>> previous series. It's basically the driver-private narrow completions
>> Jason suggested in the lockdep patches discussions implemented the same
>> way as eviction-fences.
>>
>> The memory fence API would be local to helpers and middle-layers like
>> TTM, and the corresponding drivers.  The only cross-driver-like
>> visibility would be that the dma-buf move_notify() callback would not be
>> allowed to wait on dma-fences or something that depends on a dma-fence.
> Because we can't preempt (on some engines at least) we already have
> the requirement that cross driver buffer management can get stuck on a
> dma-fence. Not even taking into account the horrors we do with
> userptr, which are cross driver no matter what. Limiting move_notify
> to memory fences only doesn't work, since the pte clearing might need
> to wait for a dma_fence first. Hence this becomes a full end-of-batch
> fence, not just a limited kernel-internal memory fence.

For non-preemptible hardware the memory fence typically *is* the 
end-of-batch fence. (Unless, as documented, there is a scheduler 
consuming sync-file dependencies in which case the memory fence wait 
needs to be able to break out of that). The key thing is not that we can 
break out of execution, but that we can break out of dependencies, since 
when we're executing all dependecies (modulo semaphores) are already 
fulfilled. That's what's eliminating the deadlocks.

>
> That's kinda why I think only reasonable option is to toss in the
> towel and declare dma-fence to be the memory fence (and suck up all
> the consequences of that decision as uapi, which is kinda where we
> are), and construct something new&entirely free-wheeling for userspace
> fencing. But only for engines that allow enough preempt/gpu page
> faulting to make that possible. Free wheeling userspace fences/gpu
> semaphores or whatever you want to call them (on windows I think it's
> monitored fence) only work if you can preempt to decouple the memory
> fences from your gpu command execution.
>
> There's the in-between step of just decoupling the batchbuffer
> submission prep for hw without any preempt (but a scheduler), but that
> seems kinda pointless. Modern execbuf should be O(1) fastpath, with
> all the allocation/mapping work pulled out ahead. vk exposes that
> model directly to clients, GL drivers could use it internally too, so
> I see zero value in spending lots of time engineering very tricky
> kernel code just for old userspace. Much more reasonable to do that in
> userspace, where we have real debuggers and no panics about security
> bugs (or well, a lot less, webgl is still a thing, but at least
> browsers realized you need to container that completely).

Sure, it's definitely a big chunk of work. I think the big win would be 
allowing memory allocation in dma-fence critical sections. But I 
completely buy the above argument. I just wanted to point out that many 
of the dma-fence restrictions are IMHO fixable, should we need to do 
that for whatever reason.

/Thomas


>
> Cheers, Daniel
>
>> So with that in mind, I don't foresee engines with different
>> capabilities on the same card being a problem.
>>
>> /Thomas
>>
>>
>
