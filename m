Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054A8229829
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 14:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgGVMWq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 08:22:46 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:4459 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMWq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 08:22:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 79A043FB74;
        Wed, 22 Jul 2020 14:22:39 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=nqgRMESF;
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
        with ESMTP id ygew381WBbSP; Wed, 22 Jul 2020 14:22:37 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 1D2A33FA4C;
        Wed, 22 Jul 2020 14:22:34 +0200 (CEST)
Received: from [192.168.0.100] (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 707CF362551;
        Wed, 22 Jul 2020 14:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1595420555; bh=G7u6a12bq9gh8uGWI2guaWEbwbsqMI9cCcPMphjVZ80=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nqgRMESFob0dAoyHzLTGHjsOw5Y/jTNgRSR3aSP/q1TWDb3YFQkv1WWKr+QEMixVF
         nR9dt+SAR1Nt4o0nye9v72oJNclbl7sjq30SrdZKMwBQAHierJd3OdKBmE7TIrBRzu
         dJoL7CK1tGA5DNZ+1i7UVkRu4n3fOb1OZQBJLSH8=
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
 <92393d26-d863-aac6-6d27-53cad6854e13@shipmail.org>
 <CAKMK7uF8jpyuCF8uUbEeJUedErxqRGa8JY+RuURg7H1XXWXzkw@mail.gmail.com>
 <8fd999f2-cbf6-813c-6ad4-131948fb5cc5@shipmail.org>
 <CAKMK7uH0rcyepP2hDpNB-yuvNyjee1tPmxWUyefS5j7i-N6Pfw@mail.gmail.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <df5414f5-ac5c-d212-500c-b05c7c78ce84@shipmail.org>
Date:   Wed, 22 Jul 2020 14:22:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uH0rcyepP2hDpNB-yuvNyjee1tPmxWUyefS5j7i-N6Pfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2020-07-22 13:39, Daniel Vetter wrote:
> On Wed, Jul 22, 2020 at 12:31 PM Thomas Hellström (Intel)
> <thomas_os@shipmail.org> wrote:
>>
>> On 2020-07-22 11:45, Daniel Vetter wrote:
>>> On Wed, Jul 22, 2020 at 10:05 AM Thomas Hellström (Intel)
>>> <thomas_os@shipmail.org> wrote:
>>>> On 2020-07-22 09:11, Daniel Vetter wrote:
>>>>> On Wed, Jul 22, 2020 at 8:45 AM Thomas Hellström (Intel)
>>>>> <thomas_os@shipmail.org> wrote:
>>>>>> On 2020-07-22 00:45, Dave Airlie wrote:
>>>>>>> On Tue, 21 Jul 2020 at 18:47, Thomas Hellström (Intel)
>>>>>>> <thomas_os@shipmail.org> wrote:
>>>>>>>> On 7/21/20 9:45 AM, Christian König wrote:
>>>>>>>>> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
>>>>>>>>>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellström (Intel)
>>>>>>>>>> wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
>>>>>>>>>>>> Comes up every few years, gets somewhat tedious to discuss, let's
>>>>>>>>>>>> write this down once and for all.
>>>>>>>>>>>>
>>>>>>>>>>>> What I'm not sure about is whether the text should be more explicit in
>>>>>>>>>>>> flat out mandating the amdkfd eviction fences for long running compute
>>>>>>>>>>>> workloads or workloads where userspace fencing is allowed.
>>>>>>>>>>> Although (in my humble opinion) it might be possible to completely
>>>>>>>>>>> untangle
>>>>>>>>>>> kernel-introduced fences for resource management and dma-fences used
>>>>>>>>>>> for
>>>>>>>>>>> completion- and dependency tracking and lift a lot of restrictions
>>>>>>>>>>> for the
>>>>>>>>>>> dma-fences, including prohibiting infinite ones, I think this makes
>>>>>>>>>>> sense
>>>>>>>>>>> describing the current state.
>>>>>>>>>> Yeah I think a future patch needs to type up how we want to make that
>>>>>>>>>> happen (for some cross driver consistency) and what needs to be
>>>>>>>>>> considered. Some of the necessary parts are already there (with like the
>>>>>>>>>> preemption fences amdkfd has as an example), but I think some clear docs
>>>>>>>>>> on what's required from both hw, drivers and userspace would be really
>>>>>>>>>> good.
>>>>>>>>> I'm currently writing that up, but probably still need a few days for
>>>>>>>>> this.
>>>>>>>> Great! I put down some (very) initial thoughts a couple of weeks ago
>>>>>>>> building on eviction fences for various hardware complexity levels here:
>>>>>>>>
>>>>>>>> https://gitlab.freedesktop.org/thomash/docs/-/blob/master/Untangling%20dma-fence%20and%20memory%20allocation.odt
>>>>>>> We are seeing HW that has recoverable GPU page faults but only for
>>>>>>> compute tasks, and scheduler without semaphores hw for graphics.
>>>>>>>
>>>>>>> So a single driver may have to expose both models to userspace and
>>>>>>> also introduces the problem of how to interoperate between the two
>>>>>>> models on one card.
>>>>>>>
>>>>>>> Dave.
>>>>>> Hmm, yes to begin with it's important to note that this is not a
>>>>>> replacement for new programming models or APIs, This is something that
>>>>>> takes place internally in drivers to mitigate many of the restrictions
>>>>>> that are currently imposed on dma-fence and documented in this and
>>>>>> previous series. It's basically the driver-private narrow completions
>>>>>> Jason suggested in the lockdep patches discussions implemented the same
>>>>>> way as eviction-fences.
>>>>>>
>>>>>> The memory fence API would be local to helpers and middle-layers like
>>>>>> TTM, and the corresponding drivers.  The only cross-driver-like
>>>>>> visibility would be that the dma-buf move_notify() callback would not be
>>>>>> allowed to wait on dma-fences or something that depends on a dma-fence.
>>>>> Because we can't preempt (on some engines at least) we already have
>>>>> the requirement that cross driver buffer management can get stuck on a
>>>>> dma-fence. Not even taking into account the horrors we do with
>>>>> userptr, which are cross driver no matter what. Limiting move_notify
>>>>> to memory fences only doesn't work, since the pte clearing might need
>>>>> to wait for a dma_fence first. Hence this becomes a full end-of-batch
>>>>> fence, not just a limited kernel-internal memory fence.
>>>> For non-preemptible hardware the memory fence typically *is* the
>>>> end-of-batch fence. (Unless, as documented, there is a scheduler
>>>> consuming sync-file dependencies in which case the memory fence wait
>>>> needs to be able to break out of that). The key thing is not that we can
>>>> break out of execution, but that we can break out of dependencies, since
>>>> when we're executing all dependecies (modulo semaphores) are already
>>>> fulfilled. That's what's eliminating the deadlocks.
>>>>
>>>>> That's kinda why I think only reasonable option is to toss in the
>>>>> towel and declare dma-fence to be the memory fence (and suck up all
>>>>> the consequences of that decision as uapi, which is kinda where we
>>>>> are), and construct something new&entirely free-wheeling for userspace
>>>>> fencing. But only for engines that allow enough preempt/gpu page
>>>>> faulting to make that possible. Free wheeling userspace fences/gpu
>>>>> semaphores or whatever you want to call them (on windows I think it's
>>>>> monitored fence) only work if you can preempt to decouple the memory
>>>>> fences from your gpu command execution.
>>>>>
>>>>> There's the in-between step of just decoupling the batchbuffer
>>>>> submission prep for hw without any preempt (but a scheduler), but that
>>>>> seems kinda pointless. Modern execbuf should be O(1) fastpath, with
>>>>> all the allocation/mapping work pulled out ahead. vk exposes that
>>>>> model directly to clients, GL drivers could use it internally too, so
>>>>> I see zero value in spending lots of time engineering very tricky
>>>>> kernel code just for old userspace. Much more reasonable to do that in
>>>>> userspace, where we have real debuggers and no panics about security
>>>>> bugs (or well, a lot less, webgl is still a thing, but at least
>>>>> browsers realized you need to container that completely).
>>>> Sure, it's definitely a big chunk of work. I think the big win would be
>>>> allowing memory allocation in dma-fence critical sections. But I
>>>> completely buy the above argument. I just wanted to point out that many
>>>> of the dma-fence restrictions are IMHO fixable, should we need to do
>>>> that for whatever reason.
>>> I'm still not sure that's possible, without preemption at least. We
>>> have 4 edges:
>>> - Kernel has internal depencies among memory fences. We want that to
>>> allow (mild) amounts of overcommit, since that simplifies live so
>>> much.
>>> - Memory fences can block gpu ctx execution (by nature of the memory
>>> simply not being there yet due to our overcommit)
>>> - gpu ctx have (if we allow this) userspace controlled semaphore
>>> dependencies. Of course userspace is expected to not create deadlocks,
>>> but that's only assuming the kernel doesn't inject additional
>>> dependencies. Compute folks really want that.
>>> - gpu ctx can hold up memory allocations if all we have is
>>> end-of-batch fences. And end-of-batch fences are all we have without
>>> preempt, plus if we want backwards compat with the entire current
>>> winsys/compositor ecosystem we need them, which allows us to inject
>>> stuff dependent upon them pretty much anywhere.
>>>
>>> Fundamentally that's not fixable without throwing one of the edges
>>> (and the corresponding feature that enables) out, since no entity has
>>> full visibility into what's going on. E.g. forcing userspace to tell
>>> the kernel about all semaphores just brings up back to the
>>> drm_timeline_syncobj design we have merged right now. And that's imo
>>> no better.
>> Indeed, HW waiting for semaphores without being able to preempt that
>> wait is a no-go. The doc (perhaps naively) assumes nobody is doing that.
> preempt is a necessary but not sufficient condition, you also must not
> have end-of-batch memory fences. And i915 has semaphore support and
> end-of-batch memory fences, e.g. one piece is:
>
> commit c4e8ba7390346a77ffe33ec3f210bc62e0b6c8c6
> Author: Chris Wilson <chris@chris-wilson.co.uk>
> Date:   Tue Apr 7 14:08:11 2020 +0100
>
>      drm/i915/gt: Yield the timeslice if caught waiting on a user semaphore
>
> Sure it preempts, but that's not enough.

Yes, i915 would fall in the "hardware with semaphores" category and 
implement memory fences different from the end-of-batch fences.

>
>>> That's kinda why I'm not seeing much benefits in a half-way state:
>>> Tons of work, and still not what userspace wants. And for the full
>>> deal that userspace wants we might as well not change anything with
>>> dma-fences. For that we need a) ctx preempt and b) new entirely
>>> decoupled fences that never feed back into a memory fences and c) are
>>> controlled entirely by userspace. And c) is the really important thing
>>> people want us to provide.
>>>
>>> And once we're ok with dma_fence == memory fences, then enforcing the
>>> strict and painful memory allocation limitations is actually what we
>>> want.
>> Let's hope you're right. My fear is that that might be pretty painful as
>> well.
> Oh it's very painful too:
> - We need a separate uapi flavour for gpu ctx with preempt instead of
> end-of-batch dma-fence.
> - Which needs to be implemented without breaking stuff badly - e.g. we
> need to make sure we don't probe-wait on fences unnecessarily since
> that forces random unwanted preempts.
> - If we want this with winsys integration we need full userspace
> revisions since all the dma_fence based sync sharing is out (implicit
> sync on dma-buf, sync_file, drm_syncobj are all defunct since we can
> only go the other way round).
> Utter pain, but I think it's better since it can be done
> driver-by-driver, and even userspace usecase by usecase. Which means
> we can experiment in areas where the 10+ years of uapi guarantee isn't
> so painful, learn, until we do the big jump of new
> zero-interaction-with-memory-management fences become baked in forever
> into compositor/winsys/modeset protocols.
>   With the other approach of
> splitting dma-fence we need to do all the splitting first, make sure
> we get it right, and only then can we enable the use-case for real.

Again, let me stress, I'm not advocating for splitting the dma-fence in 
favour of the preempt ctx approach. My question is rather: Do we see the 
need for fixing dma-fence as well, with the motivation that fixing all 
drivers to adhere to the dma-fence restrictions might be just as 
painful. So far the clear answer is no, it's not worth it, and I'm fine 
with that.

>
> That's just not going to happen, at least not in upstream across all
> drivers. Within a single driver in some vendor tree hacking stuff up
> is totally fine ofc.

Actually, due to the asynchronous restart, that's not really possible 
either. It's all or none.

> -Daniel

/Thomas


