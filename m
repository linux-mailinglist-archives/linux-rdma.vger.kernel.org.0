Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48AB2287BF
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 19:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGURqi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 13:46:38 -0400
Received: from pio-pvt-msa1.bahnhof.se ([79.136.2.40]:39086 "EHLO
        pio-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGURqf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Jul 2020 13:46:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id CB49A41421;
        Tue, 21 Jul 2020 19:46:32 +0200 (CEST)
Authentication-Results: pio-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b="frDUmX6P";
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
        with ESMTP id 2pG5veMOGOdo; Tue, 21 Jul 2020 19:46:31 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id B8F983F3B9;
        Tue, 21 Jul 2020 19:46:26 +0200 (CEST)
Received: from [192.168.0.100] (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id F165136010A;
        Tue, 21 Jul 2020 19:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1595353586; bh=4uB31R2+QdLg394hPLx29A25rPq/9GLfA0vttAkzBpo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=frDUmX6Pb56r4nJFS91NmtvI7DLzeVhvjaHlEz2Xvk+tfoPGQteOV/5DOErazBDCW
         IA3s0raY3MXcOdWP58C+hrLKx9k+xPlQlWoYful1aGabjti0/uWInAu7ikzGlVMFNk
         AKA8JWBHfIhnINvYQnCl7wjhvT3kkO+EFiEACWis=
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Stone <daniels@collabora.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Steve Pronovost <spronovo@microsoft.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Jesse Natalie <jenatali@microsoft.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200707201229.472834-4-daniel.vetter@ffwll.ch>
 <20200709123339.547390-1-daniel.vetter@ffwll.ch>
 <93b673b7-bb48-96eb-dc2c-bd4f9304000e@shipmail.org>
 <20200721074157.GB3278063@phenom.ffwll.local>
 <3603bb71-318b-eb53-0532-9daab62dce86@amd.com>
 <57a5eb9d-b74f-8ce4-7199-94e911d9b68b@shipmail.org>
 <2ca2c004-1e11-87f5-4bd8-761e1b44d21f@amd.com>
 <74727f17-b3a5-ca12-6db6-e47543797b72@shipmail.org>
 <CAKMK7uFfMi5M5EkCeG6=tjuDANH4=gDLnFpxCYU-E-xyrxwYUg@mail.gmail.com>
 <ae4e4188-39e6-ec41-c11d-91e9211b4d3a@shipmail.org>
 <f8f73b9f-ce8d-ea02-7caa-d50b75b72809@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>
Message-ID: <6ed364c9-893b-8974-501a-418585eb4def@shipmail.org>
Date:   Tue, 21 Jul 2020 19:46:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f8f73b9f-ce8d-ea02-7caa-d50b75b72809@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2020-07-21 15:59, Christian König wrote:
> Am 21.07.20 um 12:47 schrieb Thomas Hellström (Intel):
...
>> Yes, we can't do magic. As soon as an indefinite batch makes it to 
>> such hardware we've lost. But since we can break out while the batch 
>> is stuck in the scheduler waiting, what I believe we *can* do with 
>> this approach is to avoid deadlocks due to locally unknown 
>> dependencies, which has some bearing on this documentation patch, and 
>> also to allow memory allocation in dma-fence (not memory-fence) 
>> critical sections, like gpu fault- and error handlers without 
>> resorting to using memory pools.
>
> Avoiding deadlocks is only the tip of the iceberg here.
>
> When you allow the kernel to depend on user space to proceed with some 
> operation there are a lot more things which need consideration.
>
> E.g. what happens when an userspace process which has submitted stuff 
> to the kernel is killed? Are the prepared commands send to the 
> hardware or aborted as well? What do we do with other processes 
> waiting for that stuff?
>
> How to we do resource accounting? When processes need to block when 
> submitting to the hardware stuff which is not ready we have a process 
> we can punish for blocking resources. But how is kernel memory used 
> for a submission accounted? How do we avoid deny of service attacks 
> here were somebody eats up all memory by doing submissions which can't 
> finish?
>
Hmm. Are these problems really unique to user-space controlled 
dependencies? Couldn't you hit the same or similar problems with 
mis-behaving shaders blocking timeline progress?

/Thomas



