Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD05201B9C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 21:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbgFSTs4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 15:48:56 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:14642
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390375AbgFSTsz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 15:48:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjqRvSqGbXssnrzhqaOQDhYCY+axUg8FIuBlcPhVcb+BioKprfeBQtnnawr6bhMG4ISvmM4GyjOX6bXg6cUVPPnySMhkdUZ+IDdG2KXOH4vOrhr6gvVVE2GIMvqSYy5yjpG83HLLx+ONsvtjTRePqtHd9NgQmF2RNq4xKsfFfi2d+E7/VowCsZlbFljnXEKiP6u1CjufCN0EAZrsK0gLv/29OR2Q5wtTQm3HAk13wwdqio69KZapJSzfoOW//jsX6DddkGoF3u2n1xHXvw8gi+/8vlmKXlEep7rbJ+Kedl1gQq9l+1R4kUyraQgvTcivy0Z1CwR/SWpuXvWBfRjZtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY2s5Ok5u8FVj8sjo2EsGqQ5oy1A54oDL4muzRtBbzU=;
 b=aT5SQMqmrviLIslpS5xLjP+X+GGPrqCC05m8oRsW0orwbHMmv2fFPtPIlgwA0dfN9mSqGHriosZva/uRSeb8UTq6I4fKsVagsjOvlvgU69gNIJN+F8UCTRT3Za92iCJazGjWAI1aZ+p7dOVxDp+Dhz8AwAdStAzFHqLMQVVn9vxQ2vobU7VQ69/8xhYrAczJiP3idPSjccfQNBWm+YzJRIj2QR+kojB/4lVti7TAZdHyIwwczDrpGPXrHtsSmEeKRYFabaFmA5wMvy4npQICTK7eXY4xrik4z+ltAJftOuPALMyInxu/44lYgWNuqyopPrF175s8gVQqzChWUCLIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hY2s5Ok5u8FVj8sjo2EsGqQ5oy1A54oDL4muzRtBbzU=;
 b=P4zvyX3CeWE/8rrxv8TjIoY83At7/msQJE08cKhbgHIhaJQD0cxbCYOPCTjm0ad+3c0puk6462+0Ocn6qiUyDViXAuFiCvfFzqB0Dz8Av9FFVf6GBjLy3hIWpmYel0koc9ZjQxfK4WGtde79fTelL8OEJsdwkvZDgQdaNmGPRqg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 19:48:51 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 19:48:51 +0000
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jerome Glisse <jglisse@redhat.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
References: <20200617152835.GF6578@ziepe.ca>
 <20200618150051.GS20149@phenom.ffwll.local> <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca> <20200619180935.GA10009@redhat.com>
 <20200619181849.GR6578@ziepe.ca>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <56008d64-772d-5757-6136-f20591ef71d2@amd.com>
Date:   Fri, 19 Jun 2020 15:48:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200619181849.GR6578@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::41) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YTOPR0101CA0028.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 19:48:50 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b31f8f3-21d1-47e8-e8b4-08d81489ca69
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23666F033A1C836299F9904592980@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFaPyrdjkcHTiVW5mxRZ1bAm2sGkOtkPfbaFXp49135XROOYLmzA96AOnxTN9GNzwWG3GCh5Wu8l914CpTgMTuPhjoOGC0uYCWGJV4WvseEQgZjX+ecl5kXBuSpnMd6QOU7XpZFUZCI0Jg+mAp0LBUB/edxPaMhCwpFHM3Ay5ZZYfZGVwosQi5sOevHwaXIVSpJX344TK5JuWlw2o3Ou2YwoD/uIq6bA1ie3tic51ipxs5n9HKlpz3PSS0C7lvass9a9fV1h1rePUOnIu3Gf1tbu//8o7OyTPvkpqAtfR2rpXnSFEQjAtgpsfunLmmVIZInaeTvT3Lc6xFYWT2W5d1k0c+lmXHaVLhzTnEuuGCafFrH9L9MVp0cXKanNKCPMRXMCcXbzxN+yQKaRswJUjSszL6LwB5c8uTD2+poPWZo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(83380400001)(66476007)(66556008)(966005)(66946007)(7416002)(16526019)(2616005)(4326008)(36756003)(110136005)(31696002)(8936002)(956004)(6486002)(86362001)(2906002)(54906003)(478600001)(8676002)(316002)(186003)(16576012)(26005)(31686004)(52116002)(5660300002)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pr3VWPwyk0cvydYqAZZkmQvEYteaGvklT7Gh18MyvmWsg8Zcw8I4d6CWtr8wh7IXTVVV1ZJg+pBGZaAarHjbdA+yu6r0boX4CaNJDnx0B5JOjdPO6Pp8NsBJb8UwV3Xr5hc83zTGXljN2VtsZKACVSUS8M5fepya1uRZEAnFNr29c6FTiZisq8lKbQ4c2Jd/P3Yk6FoV47lS+yoDrtPxPl/+bqs7svDLxQm/uJXpUzWzFNEMQzTiUO8pYEoNqv9D5fS4upsd7Y+ibQgAYdrQOW/mSpj+IzWGbmLEFF2yDWF9X0a0NWWQeDGev2HAEEM6J5/pekIinRD2w4XceS6ZBrrdYChruDLZWFamr7q6tQR97kIM0d95RYjaO35576F5xvaLrcpYa0nGZiXYwm1UeD0Fx2ww4I6wMjgP/rdgCB1fAsz1Hn73Vpq8MyMAZPdHrppKxF4a5sAjhYsGCKu/pR68zoas5vs29ryIbM9LR3qAo9WCN2XGpKNnmKnyeyat
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b31f8f3-21d1-47e8-e8b4-08d81489ca69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 19:48:51.5066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIMlq/N4DeJBMh4B2sfOovlW4tV4ECy4iXIEbqcQZIBq+Abw0vKvoE6uCcsQ6qB0GrjMDD+gLzSqBIugPf1KUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 2020-06-19 um 2:18 p.m. schrieb Jason Gunthorpe:
> On Fri, Jun 19, 2020 at 02:09:35PM -0400, Jerome Glisse wrote:
>> On Fri, Jun 19, 2020 at 02:23:08PM -0300, Jason Gunthorpe wrote:
>>> On Fri, Jun 19, 2020 at 06:19:41PM +0200, Daniel Vetter wrote:
>>>
>>>> The madness is only that device B's mmu notifier might need to wait
>>>> for fence_B so that the dma operation finishes. Which in turn has to
>>>> wait for device A to finish first.
>>> So, it sound, fundamentally you've got this graph of operations across
>>> an unknown set of drivers and the kernel cannot insert itself in
>>> dma_fence hand offs to re-validate any of the buffers involved?
>>> Buffers which by definition cannot be touched by the hardware yet.
>>>
>>> That really is a pretty horrible place to end up..
>>>
>>> Pinning really is right answer for this kind of work flow. I think
>>> converting pinning to notifers should not be done unless notifier
>>> invalidation is relatively bounded. 
>>>
>>> I know people like notifiers because they give a bit nicer performance
>>> in some happy cases, but this cripples all the bad cases..
>>>
>>> If pinning doesn't work for some reason maybe we should address that?
>> Note that the dma fence is only true for user ptr buffer which predate
>> any HMM work and thus were using mmu notifier already. You need the
>> mmu notifier there because of fork and other corner cases.
> I wonder if we should try to fix the fork case more directly - RDMA
> has this same problem and added MADV_DONTFORK a long time ago as a
> hacky way to deal with it.
>
> Some crazy page pin that resolved COW in a way that always kept the
> physical memory with the mm that initiated the pin?
>
> (isn't this broken for O_DIRECT as well anyhow?)
>
> How does mmu_notifiers help the fork case anyhow? Block fork from
> progressing?

How much the mmu_notifier blocks fork progress depends, on quickly we
can preempt GPU jobs accessing affected memory. If we don't have
fine-grained preemption capability (graphics), the best we can do is
wait for the GPU jobs to complete. We can also delay submission of new
GPU jobs to the same memory until the MMU notifier is done. Future jobs
would use the new page addresses.

With fine-grained preemption (ROCm compute), we can preempt GPU work on
the affected adders space to minimize the delay seen by fork.

With recoverable device page faults, we can invalidate GPU page table
entries, so device access to the affected pages stops immediately.

In all cases, the end result is, that the device page table gets updated
with the address of the copied pages before the GPU accesses the COW
memory again.Without the MMU notifier, we'd end up with the GPU
corrupting memory of the other process.

Regards,
  Felix


>
>> I probably need to warn AMD folks again that using HMM means that you
>> must be able to update the GPU page table asynchronously without
>> fence wait.
> It is kind of unrelated to HMM, it just shouldn't be using mmu
> notifiers to replace page pinning..
>
>> The issue for AMD is that they already update their GPU page table
>> using DMA engine. I believe this is still doable if they use a
>> kernel only DMA engine context, where only kernel can queue up jobs
>> so that you do not need to wait for unrelated things and you can
>> prioritize GPU page table update which should translate in fast GPU
>> page table update without DMA fence.
> Make sense
>
> I'm not sure I saw this in the AMD hmm stuff - it would be good if
> someone would look at that. Every time I do it looks like the locking
> is wrong.
>
> Jason
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
