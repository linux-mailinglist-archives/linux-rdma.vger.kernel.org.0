Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C7229121
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 08:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGVGpx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 02:45:53 -0400
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:62746 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGVGpx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 02:45:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id BA2DC3FA20;
        Wed, 22 Jul 2020 08:45:49 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=IdhAYh9/;
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
        with ESMTP id DfDVw8gpZJyP; Wed, 22 Jul 2020 08:45:48 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 4BF723FA0A;
        Wed, 22 Jul 2020 08:45:44 +0200 (CEST)
Received: from [192.168.0.100] (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C3EB3362551;
        Wed, 22 Jul 2020 08:45:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1595400345; bh=CfYWORW5irF9hSdSvqJ1BW8dv25ifAxkvvNEXf35iGE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IdhAYh9/iCj3hv8jgW4r4N66W3AM5qTSwCTUvlztwUg+zQtwpneu0WAQnOqzeqnp2
         Q7tdq0RClmP0P1gtrXnq0t2oaCou4Pps5e9OM1DmmS8VMEi0gIPsQnLGnZltZKZ8QP
         cVXIdTX2jhjJ+l0Lbzu9x8QeAknalbSuh2hW/xHc=
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     Dave Airlie <airlied@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
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
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <805c49b7-f0b3-45dc-5fe3-b352f0971527@shipmail.org>
Date:   Wed, 22 Jul 2020 08:45:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPM=9twUWeenf-26GEvkuKo3wHgS3BCyrva=sNaWo6+=A5qdoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2020-07-22 00:45, Dave Airlie wrote:
> On Tue, 21 Jul 2020 at 18:47, Thomas Hellström (Intel)
> <thomas_os@shipmail.org> wrote:
>>
>> On 7/21/20 9:45 AM, Christian König wrote:
>>> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
>>>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellström (Intel)
>>>> wrote:
>>>>> Hi,
>>>>>
>>>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
>>>>>> Comes up every few years, gets somewhat tedious to discuss, let's
>>>>>> write this down once and for all.
>>>>>>
>>>>>> What I'm not sure about is whether the text should be more explicit in
>>>>>> flat out mandating the amdkfd eviction fences for long running compute
>>>>>> workloads or workloads where userspace fencing is allowed.
>>>>> Although (in my humble opinion) it might be possible to completely
>>>>> untangle
>>>>> kernel-introduced fences for resource management and dma-fences used
>>>>> for
>>>>> completion- and dependency tracking and lift a lot of restrictions
>>>>> for the
>>>>> dma-fences, including prohibiting infinite ones, I think this makes
>>>>> sense
>>>>> describing the current state.
>>>> Yeah I think a future patch needs to type up how we want to make that
>>>> happen (for some cross driver consistency) and what needs to be
>>>> considered. Some of the necessary parts are already there (with like the
>>>> preemption fences amdkfd has as an example), but I think some clear docs
>>>> on what's required from both hw, drivers and userspace would be really
>>>> good.
>>> I'm currently writing that up, but probably still need a few days for
>>> this.
>> Great! I put down some (very) initial thoughts a couple of weeks ago
>> building on eviction fences for various hardware complexity levels here:
>>
>> https://gitlab.freedesktop.org/thomash/docs/-/blob/master/Untangling%20dma-fence%20and%20memory%20allocation.odt
> We are seeing HW that has recoverable GPU page faults but only for
> compute tasks, and scheduler without semaphores hw for graphics.
>
> So a single driver may have to expose both models to userspace and
> also introduces the problem of how to interoperate between the two
> models on one card.
>
> Dave.

Hmm, yes to begin with it's important to note that this is not a 
replacement for new programming models or APIs, This is something that 
takes place internally in drivers to mitigate many of the restrictions 
that are currently imposed on dma-fence and documented in this and 
previous series. It's basically the driver-private narrow completions 
Jason suggested in the lockdep patches discussions implemented the same 
way as eviction-fences.

The memory fence API would be local to helpers and middle-layers like 
TTM, and the corresponding drivers.  The only cross-driver-like 
visibility would be that the dma-buf move_notify() callback would not be 
allowed to wait on dma-fences or something that depends on a dma-fence.

So with that in mind, I don't foresee engines with different 
capabilities on the same card being a problem.

/Thomas


