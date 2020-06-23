Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2D0205B09
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387411AbgFWSod (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 14:44:33 -0400
Received: from mail-eopbgr680073.outbound.protection.outlook.com ([40.107.68.73]:6784
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733211AbgFWSoc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 14:44:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGal9rzS+ZdPHXN7ity1AHUOetLZQru5okq+C9fleXbHVJDrRvvcPo33UhLADbZlWEfOEgeaSE+bZyq5bWg3UZNxjDD3VThjc/15F+XF5Tq552xNNoyujq/lvkPvaYWGYJUZZ2j1jLAo7c+LshjBu3K6d9v+aXKVWrxcCXGxkp0oYpfvJETIPX2XsqUs68qj01l4DhrzU2AoU3LohPobZCWpUEZRAu6XhYOAVUtCOrHb5YmB+Il79gZg8wNPemU++D+GLEdAKa5w55kDtP+jFt2ar2pf8lAVFdNKSnqapW1vpeFqJ96erruOEYTYQNt2SS2MDm09qMy1N3E+5XfSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpyBSe/Mausy9Q9xIlp7WqOYfXTTTSgy65o5X07mAKM=;
 b=HNdq8F6xleENe7a0pZgWR5s85wVpS50pzQbLn/b+sy/h38pXltpM2ColMbdisZ9BxiOmapuqC9RFc5uyMOc42wXMvrwQMBhkySnWq3CleWa5u9xM3zCoEWUYuZfSoNK/jasWAHLIESAme3z4k78GczjoXMM97jWvyElbQNq/IwpGFFky00d3sptEm5NVtreEvcv/iQLy4qMYz0TB0AlWt0HzsCfceSZPTJdGlPCsn/F5a8uCH6MOs2YWHnb1vLFkVEoQEPxjfttYmmG6qo/zOSgIbBd0/CZIyuovBJIBH/Amfpco+fw4Cb/m33UuOHmghECUvqKhjK6wU3xDcgqTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpyBSe/Mausy9Q9xIlp7WqOYfXTTTSgy65o5X07mAKM=;
 b=ROSFSatg70lKkNykuMQz6dONdWh7lr1th0C8qaX4x8a/YCYy4E5l9JMXD/6/xMGbkb0BnEs7ffYiCoGKrROX6DrYwuTmSSRMnFqrP9qzVQ4hOPpXGYW5WWYCv2FPiyZtRc3aHoY/W9iQsJWgJ/sidqkw5BoFIxmTuCYSQB/uzok=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2510.namprd12.prod.outlook.com (2603:10b6:802:28::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 18:44:27 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Tue, 23 Jun 2020
 18:44:27 +0000
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
 <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
 <20200611083430.GD20149@phenom.ffwll.local> <20200611141515.GW6578@ziepe.ca>
 <4702e170-fd02-88fa-3da4-ea64252fff9a@amd.com>
 <CAKMK7uHBKrpDWu+DvtYncDK=LOdGJyMK7t6fpOaGovnYFiBUZw@mail.gmail.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <99758c09-262a-e9a1-bf65-5702b35b4388@amd.com>
Date:   Tue, 23 Jun 2020 14:44:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAKMK7uHBKrpDWu+DvtYncDK=LOdGJyMK7t6fpOaGovnYFiBUZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQBPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::20) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YQBPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 23 Jun 2020 18:44:26 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a4870c98-7a4d-47d7-1d96-08d817a57535
X-MS-TrafficTypeDiagnostic: SN1PR12MB2510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB251032784C27E3E494F690B292940@SN1PR12MB2510.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBeOa6qdsFFSxtV0/6Nc8Iw3gHKVMfqr7+7YcwWO2Q3oCnPnZC0mUvZhL7gb/RwDHpePXor/BR3Qj1PlnGCMNcIEmcK/akI5tqfO1Pr22474uScXqCabvSWaTDq+g9JrbVx3S5/rwD5A4817CU+0RQd2SR5ZkkHCz536aFZB6jOUbXFxlpzG0QTR3uCLJKlRDnWfZuRIDDPX+Ij0ghVrl8tAxt0SOO4ST9ynAbLZ3GkLg7v6/p2DkIP/6V/jb9PUSYhiRnyO3eq67o1nCX9w8zjixFAHqT6RxI/Iym2clnVeFuAO/Wa7yeM4EiKVyjaj/VAL5KwfWRup4jfJd730b0GQW1g5+dI+AvnY6XT0LdZYgY+vCF9I9jyKh+TwYMiIuUsN7svKE/1h4Mr3PAS7uUrzP7te9RNiNG0LaFJfSiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(8676002)(6486002)(86362001)(7416002)(54906003)(316002)(8936002)(44832011)(956004)(2616005)(31696002)(5660300002)(478600001)(4326008)(16576012)(52116002)(31686004)(16526019)(6916009)(83380400001)(36756003)(66476007)(66946007)(2906002)(66556008)(966005)(53546011)(186003)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +Fjeaie/hiKPDNe2T5bo173L+87sd5OK/IjavYHGlvcsOFCiTW9Dc+nuYiqN8o7Isj6qyL1ZFJfDkwdPfkd456XysI0mv9hd1z0uGXDCDZkgR2L8lFBD7JbtujXuWdiXBzzvk7rkh3l/L0y2l+3j7fChqwl1BZg++mcTPG9nMYbIg16q9PVroebiwS5k021ZcRhmYM2GoYV8pUCimIawuOauJpNo821jDp5yxoj5LcBL+oegEANFncIxewy/UMDIiqgaKLi9YQvGt1AwGie8uwB9hViK0iCzXXUj6e51GURPLRqDk6JantIKWvp9E4m82E+cWi6I8ySm3Z2CvzUlRKCpNWZX0WVqZwDSCfTaQlIIKZnwagz1aTvaJUKxaSUY3+2g2mEpf0UofKdOtZjltJ7lkBeyoGAzGJxVzJj4mjEFfCTdvND3ijnkCb0LAxwSFmlNHLADQBcUiwRtKUIH4fQLzBRN/ruplLNCaI3knVGSsT/kMFsR1lDMbx193R1A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4870c98-7a4d-47d7-1d96-08d817a57535
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 18:44:27.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ip46S6apHT4+o/d11JZkRyfUzTFQUMVgDK7tOuGMMHaW5r8fehi0XWVnuqaIwyctV32ywaGomPhASixdzwXt/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2510
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 2020-06-23 um 3:39 a.m. schrieb Daniel Vetter:
> On Fri, Jun 12, 2020 at 1:35 AM Felix Kuehling <felix.kuehling@amd.com> wrote:
>> Am 2020-06-11 um 10:15 a.m. schrieb Jason Gunthorpe:
>>> On Thu, Jun 11, 2020 at 10:34:30AM +0200, Daniel Vetter wrote:
>>>>> I still have my doubts about allowing fence waiting from within shrinkers.
>>>>> IMO ideally they should use a trywait approach, in order to allow memory
>>>>> allocation during command submission for drivers that
>>>>> publish fences before command submission. (Since early reservation object
>>>>> release requires that).
>>>> Yeah it is a bit annoying, e.g. for drm/scheduler I think we'll end up
>>>> with a mempool to make sure it can handle it's allocations.
>>>>
>>>>> But since drivers are already waiting from within shrinkers and I take your
>>>>> word for HMM requiring this,
>>>> Yeah the big trouble is HMM and mmu notifiers. That's the really awkward
>>>> one, the shrinker one is a lot less established.
>>> I really question if HW that needs something like DMA fence should
>>> even be using mmu notifiers - the best use is HW that can fence the
>>> DMA directly without having to get involved with some command stream
>>> processing.
>>>
>>> Or at the very least it should not be a generic DMA fence but a
>>> narrowed completion tied only into the same GPU driver's command
>>> completion processing which should be able to progress without
>>> blocking.
>>>
>>> The intent of notifiers was never to endlessly block while vast
>>> amounts of SW does work.
>>>
>>> Going around and switching everything in a GPU to GFP_ATOMIC seems
>>> like bad idea.
>>>
>>>> I've pinged a bunch of armsoc gpu driver people and ask them how much this
>>>> hurts, so that we have a clear answer. On x86 I don't think we have much
>>>> of a choice on this, with userptr in amd and i915 and hmm work in nouveau
>>>> (but nouveau I think doesn't use dma_fence in there).
>> Soon nouveau will get company. We're working on a recoverable page fault
>> implementation for HMM in amdgpu where we'll need to update page tables
>> using the GPUs SDMA engine and wait for corresponding fences in MMU
>> notifiers.
> Can you pls cc these patches to dri-devel when they show up? Depending
> upon how your hw works there's and endless amount of bad things that
> can happen.

Yes, I'll do that.


>
> Also I think (again depending upon how the hw exactly works) this
> stuff would be a perfect example for the dma_fence annotations.

We have already applied your patch series to our development branch. I
haven't looked into what annotations we'd have to add to our new code yet.


>
> The worst case is if your hw cannot preempt while a hw page fault is
> pending. That means none of the dma_fence will ever signal (the amdkfd
> preempt ctx fences wont, and the classic fences from amdgpu might be
> also stall). At least when you're unlucky and the fence you're waiting
> on somehow (anywhere in its dependency chain really) need the engine
> that's currently blocked waiting for the hw page fault.

Our HW can preempt while handling a page fault, at least on the GPU
generation we're working on now. On other GPUs we haven't included in
our initial effort, we will not be able to preempt while a page fault is
in progress. This is problematic, but that's for reasons related to our
GPU hardware scheduler and unrelated to fences.


>
> That in turn means anything you do in your hw page fault handler is in
> the critical section for dma fence signalling, which has far reaching
> implications.

I'm not sure I agree, at least for KFD. The only place where KFD uses
fences that depend on preemptions is eviction fences. And we can get rid
of those if we can preempt GPU access to specific BOs by invalidating
GPU PTEs. That way we don't need to preempt the GPU queues while a page
fault is in progress. Instead we would create more page faults.

That assumes that we can invalidate GPU PTEs without depending on
fences. We've discussed possible deadlocks due to memory allocations
needed on that code paths for IBs or page tables. We've already
eliminated page table allocations and reservation locks on the PTE
invalidation code path. And we're using a separate scheduler entity so
we can't get stuck behind other IBs that depend on fences. IIRC,
Christian also implemented a separate memory pool for IBs for this code
path.

Regards,
  Felix


> -Daniel
>
>> Regards,
>>   Felix
>>
>>
>>> Right, nor will RDMA ODP.
>>>
>>> Jason
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
