Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85F3227B02
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 10:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgGUIrV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 04:47:21 -0400
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:13814 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUIrV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 04:47:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id D68C23FA36;
        Tue, 21 Jul 2020 10:47:18 +0200 (CEST)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=cfyygOmS;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
        DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
        URIBL_BLOCKED=0.001] autolearn=ham autolearn_force=no
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xxeMSWhjAfgq; Tue, 21 Jul 2020 10:47:17 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 7D82A3F9E7;
        Tue, 21 Jul 2020 10:47:15 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id CC59B36014B;
        Tue, 21 Jul 2020 10:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1595321234; bh=hkvhvfi+JM5OBDtRUXrbQuN3JiHLZIObnsH22OCtN8w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cfyygOmSajTjenzL9cXVdGG96y6lgmTbUKCjVuFw82RLrwHeoGBU5cn0KXg8YsS8h
         YKNgp4ieMf+U+RCdhVHHVDMnwiUl/E1dxMV0R8mgb7kxAM5+y+xKebL1Yf3BX4g1hl
         4HmPvZMeCBWn3jekYn0VjQxbnQfT37gTupSD2Mdo=
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
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
Date:   Tue, 21 Jul 2020 10:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 7/21/20 9:45 AM, Christian König wrote:
> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellström (Intel) 
>> wrote:
>>> Hi,
>>>
>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
>>>> Comes up every few years, gets somewhat tedious to discuss, let's
>>>> write this down once and for all.
>>>>
>>>> What I'm not sure about is whether the text should be more explicit in
>>>> flat out mandating the amdkfd eviction fences for long running compute
>>>> workloads or workloads where userspace fencing is allowed.
>>> Although (in my humble opinion) it might be possible to completely 
>>> untangle
>>> kernel-introduced fences for resource management and dma-fences used 
>>> for
>>> completion- and dependency tracking and lift a lot of restrictions 
>>> for the
>>> dma-fences, including prohibiting infinite ones, I think this makes 
>>> sense
>>> describing the current state.
>> Yeah I think a future patch needs to type up how we want to make that
>> happen (for some cross driver consistency) and what needs to be
>> considered. Some of the necessary parts are already there (with like the
>> preemption fences amdkfd has as an example), but I think some clear docs
>> on what's required from both hw, drivers and userspace would be really
>> good.
>
> I'm currently writing that up, but probably still need a few days for 
> this.

Great! I put down some (very) initial thoughts a couple of weeks ago 
building on eviction fences for various hardware complexity levels here:

https://gitlab.freedesktop.org/thomash/docs/-/blob/master/Untangling%20dma-fence%20and%20memory%20allocation.odt

/Thomas


