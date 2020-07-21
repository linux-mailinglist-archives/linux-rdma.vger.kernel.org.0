Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F0D228179
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jul 2020 15:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgGUN70 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Jul 2020 09:59:26 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:4225
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726942AbgGUN7Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 21 Jul 2020 09:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrZ3lIT9V0thjVmeLeA2jsEuUOlv0qye4upjsur2Pyt6i3JUWInQJrnPQ009x1IXMeJL/KQm03w/xLj7Gf9xzwZan+eqv48hWoS9NnwInVCoVsQYefDMyYtQWJicSfUi1/X0GMSjrkYgADqSxoycgKOYQhkko1YhDklIKN6bfSudHhwehZ/Md+BKMTGmb22FU0rT470RZYum3tuFrmEKt8LoH1bPjSWU17SQWtVQ4k7zhsI0ftaXhMJelJ656ly1chUUkc9M7fIvYfvQdVPLsniBywha3qhC2dgdp7PetofI2S15bVwTK3N2jgrzplyhHbc3VNwSci5N1/4IdJq50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1eSOFrKHl+ZoCrLbZQd20Pqo9TlM1qpLLV8LiD0BMg=;
 b=eYTbFRXIf78qcPCADEzTZXMqRiROgXU3PElfvJd0RC3Vkl5m6AHqOnHiUMEgW5ENQ073SNY6S2hWIj3/mDxQ3qHJMvHiI5+0HCVOusqgUhW7Jn0GAPuYCDvOk2b50RrZrnzMy1aKiSVDUbBZ3qIQO1isAJ9el9fFlIO/nhGdD+xQbga+WEH61kJuDPA4rkM1mnToj/dQSn5UxIAy14tpyPYJletzluGGqHU4NXlrPclD+HR6sbwQ4Uy3MapJs8AWQgG+02Qjc0q9RLxsSqpSE2gFNePI3stxLys1UjkkH/hpxjd7mkDQlCtYZ9x/4yGV4lVy23Iw2t6u28/N0sZEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1eSOFrKHl+ZoCrLbZQd20Pqo9TlM1qpLLV8LiD0BMg=;
 b=z9NW9roCuoW1oYSl/GpWfxRhdlBHu9uPzqvIhS3xWcN4/bY+7wt04NNu548vvB0eSCZhlyknMjuVL1y7X7DEARJZxm34lBfHQFyWOnMc6k2JcSJAo9/skW5IsWAbaOGVEXJ2nFWccifjyeps6n8hnsf/J1MYpc/N/pNOFWxWFxo=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3764.namprd12.prod.outlook.com (2603:10b6:a03:1ac::17)
 by BYAPR12MB2773.namprd12.prod.outlook.com (2603:10b6:a03:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 13:59:18 +0000
Received: from BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::bc19:eb90:1151:fc7a]) by BY5PR12MB3764.namprd12.prod.outlook.com
 ([fe80::bc19:eb90:1151:fc7a%3]) with mapi id 15.20.3216.020; Tue, 21 Jul 2020
 13:59:18 +0000
Subject: Re: [Linaro-mm-sig] [PATCH 1/2] dma-buf.rst: Document why indefinite
 fences are a bad idea
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>, Daniel Vetter <daniel@ffwll.ch>
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f8f73b9f-ce8d-ea02-7caa-d50b75b72809@amd.com>
Date:   Tue, 21 Jul 2020 15:59:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <ae4e4188-39e6-ec41-c11d-91e9211b4d3a@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0137.eurprd04.prod.outlook.com
 (2603:10a6:208:55::42) To BY5PR12MB3764.namprd12.prod.outlook.com
 (2603:10b6:a03:1ac::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:208:55::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 13:59:14 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3347e7f9-b40c-406a-8fb5-08d82d7e427d
X-MS-TrafficTypeDiagnostic: BYAPR12MB2773:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB27734EB7C6155426A96AC46883780@BYAPR12MB2773.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l14VUsFKTFKWT74xk6GoxHgXX898LKQi8MfCTMcCFN0k5uEeh8edSKb/4fElkkc0zNn94jA9ISjOvGo0XgyW5XelmJgx3SJrxK8mM7o2uWctxQGtWtKRQzu8iVwI+ZMOwto9l5vynFhllT5V7YA30XFf5Mtq/Sx39zXIG6GFXVekvauCiUH+paIay4yZhmdIWmUMgDtwYZj/wi+4zN91AAC0PmfGZDSDT/8yMPTNvJjML1t9buA/kXR726nu/foRd3n5NRmwB4uQLN3+Sxr4POjQrE2UWKbi2feRj0xR3Iev/Q2dG7110Pt62s82Qfc1D7aH2TzNcwfCJz2n/ogxc1UuKmQYptvc2hBmeWvHTcXyQEuDqi4oBhoOrzkbX12ARwCI+4ZRsgrr7r+MDD1CgDKbAXxP3SdnQmpDHf9BEv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3764.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(6666004)(53546011)(186003)(2906002)(5660300002)(478600001)(16526019)(6486002)(966005)(4326008)(110136005)(316002)(54906003)(66574015)(31696002)(2616005)(8936002)(7416002)(52116002)(8676002)(66556008)(36756003)(45080400002)(86362001)(31686004)(83380400001)(66476007)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R9h9Cz9RrQMijEwUA8iSn5Gm2Lw/lP2HTrlD5UFcraikwTq4yL6ZmwOdCkUumPNvynvc+ZKwrDohMCMaEV+mr3zRnenXjIfiuLmcs6VVR25W/mK4TCVnsUDjz5/MF938ffuMdo/+sNpkVKi3ZiNwcb/Z3CXVQ7nk+J21cbtJ6h2W95Zu6kvt1AGug5qclWKHqPnNto2Yzjpnv6ZAa5SOaIq43Nqdn3efMi5H5i83aKx0DnxSusfwQWk/EVY3CaZZjzqPGaAigE30zLmg0uKuekJHz71HaDpX/5M+QdLjrgyIenlVnekSoIcj4ps3T6g3TruoWeq9Gh5bn95UYDgZ0EcwC91w19Hzl18t5IuJJcgRW5OvwdpgAwu4Jux7e7gYd5vFrT01kMbYmISUupfYmW+bsyoHAQbRroThVIeRpflMZgXbmpS+xibQ9gtUdoO9mxCrHWRTfOSG7LYcamJP13+yfLCE1kZDHWF1CWneApg3tZ+KuAYGPydT/vWLKUFFP1qBfRDN5HI/BOTimEoT6XtYoBb8ZKXpm9IoT5rnouPn0vyMjCWcszdkPa17OKkc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3347e7f9-b40c-406a-8fb5-08d82d7e427d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3764.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 13:59:18.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RoS/lQrY0iANUX1xcFX7Vi6ZTlrLiIpdprkt4yQipAm6KvDT902qsDDF8R4ulGj1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2773
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 21.07.20 um 12:47 schrieb Thomas Hellström (Intel):
>
> On 7/21/20 11:50 AM, Daniel Vetter wrote:
>> On Tue, Jul 21, 2020 at 11:38 AM Thomas Hellström (Intel)
>> <thomas_os@shipmail.org> wrote:
>>>
>>> On 7/21/20 10:55 AM, Christian König wrote:
>>>> Am 21.07.20 um 10:47 schrieb Thomas Hellström (Intel):
>>>>> On 7/21/20 9:45 AM, Christian König wrote:
>>>>>> Am 21.07.20 um 09:41 schrieb Daniel Vetter:
>>>>>>> On Mon, Jul 20, 2020 at 01:15:17PM +0200, Thomas Hellström (Intel)
>>>>>>> wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 7/9/20 2:33 PM, Daniel Vetter wrote:
>>>>>>>>> Comes up every few years, gets somewhat tedious to discuss, let's
>>>>>>>>> write this down once and for all.
>>>>>>>>>
>>>>>>>>> What I'm not sure about is whether the text should be more
>>>>>>>>> explicit in
>>>>>>>>> flat out mandating the amdkfd eviction fences for long running
>>>>>>>>> compute
>>>>>>>>> workloads or workloads where userspace fencing is allowed.
>>>>>>>> Although (in my humble opinion) it might be possible to completely
>>>>>>>> untangle
>>>>>>>> kernel-introduced fences for resource management and dma-fences
>>>>>>>> used for
>>>>>>>> completion- and dependency tracking and lift a lot of restrictions
>>>>>>>> for the
>>>>>>>> dma-fences, including prohibiting infinite ones, I think this
>>>>>>>> makes sense
>>>>>>>> describing the current state.
>>>>>>> Yeah I think a future patch needs to type up how we want to make 
>>>>>>> that
>>>>>>> happen (for some cross driver consistency) and what needs to be
>>>>>>> considered. Some of the necessary parts are already there (with
>>>>>>> like the
>>>>>>> preemption fences amdkfd has as an example), but I think some clear
>>>>>>> docs
>>>>>>> on what's required from both hw, drivers and userspace would be 
>>>>>>> really
>>>>>>> good.
>>>>>> I'm currently writing that up, but probably still need a few days
>>>>>> for this.
>>>>> Great! I put down some (very) initial thoughts a couple of weeks ago
>>>>> building on eviction fences for various hardware complexity levels 
>>>>> here:
>>>>>
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fthomash%2Fdocs%2F-%2Fblob%2Fmaster%2FUntangling%2520dma-fence%2520and%2520memory%2520allocation.odt&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C0af39422c4e744a9303b08d82d637d62%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637309252665326201&amp;sdata=Zk3LVX7bbMpfAMsq%2Fs2jyA0puRQNcjzliJS%2BC7uDLMo%3D&amp;reserved=0 
>>>>>
>>>>>
>>>> I don't think that this will ever be possible.
>>>>
>>>> See that Daniel describes in his text is that indefinite fences are a
>>>> bad idea for memory management, and I think that this is a fixed fact.
>>>>
>>>> In other words the whole concept of submitting work to the kernel
>>>> which depends on some user space interaction doesn't work and never 
>>>> will.
>>> Well the idea here is that memory management will *never* depend on
>>> indefinite fences: As soon as someone waits on a memory manager fence
>>> (be it eviction, shrinker or mmu notifier) it breaks out of any
>>> dma-fence dependencies and /or user-space interaction. The text 
>>> tries to
>>> describe what's required to be able to do that (save for 
>>> non-preemptible
>>> gpus where someone submits a forever-running shader).
>> Yeah I think that part of your text is good to describe how to
>> untangle memory fences from synchronization fences given how much the
>> hw can do.
>>
>>> So while I think this is possible (until someone comes up with a case
>>> where it wouldn't work of course), I guess Daniel has a point in 
>>> that it
>>> won't happen because of inertia and there might be better options.
>> Yeah it's just I don't see much chance for splitting dma-fence itself.

Well that's the whole idea with the timeline semaphores and waiting for 
a signal number to appear.

E.g. instead of doing the wait with the dma_fence we are separating that 
out into the timeline semaphore object.

This not only avoids the indefinite fence problem for the wait before 
signal case in Vulkan, but also prevents userspace to submit stuff which 
can't be processed immediately.

>> That's also why I'm not positive on the "no hw preemption, only
>> scheduler" case: You still have a dma_fence for the batch itself,
>> which means still no userspace controlled synchronization or other
>> form of indefinite batches allowed. So not getting us any closer to
>> enabling the compute use cases people want.

What compute use case are you talking about? I'm only aware about the 
wait before signal case from Vulkan, the page fault case and the KFD 
preemption fence case.

>
> Yes, we can't do magic. As soon as an indefinite batch makes it to 
> such hardware we've lost. But since we can break out while the batch 
> is stuck in the scheduler waiting, what I believe we *can* do with 
> this approach is to avoid deadlocks due to locally unknown 
> dependencies, which has some bearing on this documentation patch, and 
> also to allow memory allocation in dma-fence (not memory-fence) 
> critical sections, like gpu fault- and error handlers without 
> resorting to using memory pools.

Avoiding deadlocks is only the tip of the iceberg here.

When you allow the kernel to depend on user space to proceed with some 
operation there are a lot more things which need consideration.

E.g. what happens when an userspace process which has submitted stuff to 
the kernel is killed? Are the prepared commands send to the hardware or 
aborted as well? What do we do with other processes waiting for that stuff?

How to we do resource accounting? When processes need to block when 
submitting to the hardware stuff which is not ready we have a process we 
can punish for blocking resources. But how is kernel memory used for a 
submission accounted? How do we avoid deny of service attacks here were 
somebody eats up all memory by doing submissions which can't finish?

> But again. I'm not saying we should actually implement this. Better to 
> consider it and reject it than not consider it at all.

Agreed.

Same thing as it turned out with the Wait before Signal for Vulkan, 
initially it looked simpler to do it in the kernel. But as far as I know 
the solution in userspace now works so well that we don't really want 
the pain for a kernel implementation any more.

Christian.

>
> /Thomas
>
>

