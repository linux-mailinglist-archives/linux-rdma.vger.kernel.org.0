Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B02227C09
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 11:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGUJqx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 05:46:53 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:60874 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUJqx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 05:46:53 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2020 05:46:51 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 2E7FE3F3E9;
        Tue, 21 Jul 2020 11:38:00 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="en/VWZSM";
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q15ipVI6XZhD; Tue, 21 Jul 2020 11:37:58 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id C30833F3B9;
        Tue, 21 Jul 2020 11:37:55 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id E425936014B;
        Tue, 21 Jul 2020 11:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1595324275; bh=rdzugGQ6Q9Agqo6R+Fh5pEZGhB20QIfSEgKjrW00F48=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=en/VWZSMbYYN7d820IYSTfPIg3fhtGHvwFmwCEDY854RehayzBtDZ/qc0p1IDDASl
         rt5w6NoqrBbdMP/4trFe26XK2u9uHHmjFK/sYw/EMbSeVkt03+IATpYq4ZXwRn+Az7
         6QetESjqQbQJ8zr9+16q7NP1Cm/wLXJ+s++ICCrQ=
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Steve Pronovost <spronovo@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        linux-media@vger.kernel.org,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
 <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <74727f17-b3a5-ca12-6db6-e47543797b72@shipmail.org>
Date:   Tue, 21 Jul 2020 11:37:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 7/21/20 10:55 AM, Christian König wrote:
> Am 21.07.20 um 10:47 schrieb Thomas Hellström (Intel):
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
>>>>>> What I'm not sure about is whether the text should be more 
>>>>>> explicit in
>>>>>> flat out mandating the amdkfd eviction fences for long running 
>>>>>> compute
>>>>>> workloads or workloads where userspace fencing is allowed.
>>>>> Although (in my humble opinion) it might be possible to completely 
>>>>> untangle
>>>>> kernel-introduced fences for resource management and dma-fences 
>>>>> used for
>>>>> completion- and dependency tracking and lift a lot of restrictions 
>>>>> for the
>>>>> dma-fences, including prohibiting infinite ones, I think this 
>>>>> makes sense
>>>>> describing the current state.
>>>> Yeah I think a future patch needs to type up how we want to make that
>>>> happen (for some cross driver consistency) and what needs to be
>>>> considered. Some of the necessary parts are already there (with 
>>>> like the
>>>> preemption fences amdkfd has as an example), but I think some clear 
>>>> docs
>>>> on what's required from both hw, drivers and userspace would be really
>>>> good.
>>>
>>> I'm currently writing that up, but probably still need a few days 
>>> for this.
>>
>> Great! I put down some (very) initial thoughts a couple of weeks ago 
>> building on eviction fences for various hardware complexity levels here:
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fthomash%2Fdocs%2F-%2Fblob%2Fmaster%2FUntangling%2520dma-fence%2520and%2520memory%2520allocation.odt&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C8978bbd7823e4b41663708d82d52add3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637309180424312390&amp;sdata=tTxx2vfzfwLM1IBJSqqAZRw1604R%2F0bI3MwN1%2FBf2VQ%3D&amp;reserved=0 
>>
>
> I don't think that this will ever be possible.
>
> See that Daniel describes in his text is that indefinite fences are a 
> bad idea for memory management, and I think that this is a fixed fact.
>
> In other words the whole concept of submitting work to the kernel 
> which depends on some user space interaction doesn't work and never will.

Well the idea here is that memory management will *never* depend on 
indefinite fences: As soon as someone waits on a memory manager fence 
(be it eviction, shrinker or mmu notifier) it breaks out of any 
dma-fence dependencies and /or user-space interaction. The text tries to 
describe what's required to be able to do that (save for non-preemptible 
gpus where someone submits a forever-running shader).

So while I think this is possible (until someone comes up with a case 
where it wouldn't work of course), I guess Daniel has a point in that it 
won't happen because of inertia and there might be better options.

/Thomas


