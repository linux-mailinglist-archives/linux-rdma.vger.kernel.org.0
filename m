Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C9201B46
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Jun 2020 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbgFSTal (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Jun 2020 15:30:41 -0400
Received: from mail-bn8nam12on2070.outbound.protection.outlook.com ([40.107.237.70]:48698
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388777AbgFSTai (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Jun 2020 15:30:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3kvAFSPvTSR38BIBIfO1Ku9Z4hvQ3bKjeINWxzFgXu69fxs6eN4s09+bDtDZCTqK8P3WOWmgo4MLPKBCw0W9CEMBjhHTbWpGama9sIIVzg/qe/M5kVKgDEmGDuJL0kVkH1WOO7OHW/N7BsOICB7bSzsm9h0WwhOrKRewbyAqt1kFe/PX/RH7ioXt2vlHllTrQQ9lF+rMmy7RjJx3AoCxpTTAhI/dGOBit7vrwk/uyKOceLvsOaiVGYZgHS9mkewrpxHW5ZXNffRVjCHQZpliUBysAJKUK+PEqyJSb8GImo1Al+nDdSh5RbIA9ne3bg01Qq6op6V1AZJ/lZUdYdCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvjLtakuII4qwZT9yWE0Upm0ewz1wEZiQEZgDFPl3rc=;
 b=RknV5sYkiUY0i8CaHV69NqQYSamNbm/xNC1BTMq3JOZFD4mio039iJ9r6tuS2ESzTK/ocT54ZZMwi/XT1GCQTjRno3ZW/j8edkS5XIt+3rmj53Vz+/I8FEwJmG4rWu4cC7VLck7cm/xLm71m8UrSA3SbK/0tY7MEH7NGlZGBG0l/YgvGsCLmkMnJ7ztxmUlzD92rIlzWTPSQxsREEdZcFALvXukTm59vrlf2/SWrlpJu8aP4ZdX7l5cvP6jVgipkCMnfMXV7UNSyTWKCFe7CsdQ4H6l55XblHQTf8Ohkk6Obr8QpJN0H1j/EoDmOtMWP/E1Pc558BunJzzIAsBNDnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvjLtakuII4qwZT9yWE0Upm0ewz1wEZiQEZgDFPl3rc=;
 b=VMHrdCgpRGybdC1pdU0XNGrzDAmsDcSaFzGwB8A5KTpfWMLCRNvUc6Nyqta+2AmfoLRNOukGKZfv93OGvaSfQmlgaaUyY03tfBn3ROlLA1vovQJllvA3Tq65tuSO/EvnzD6jopPJip5hwJKvVeHy904qC570McFa7HzQ3UjiCJs=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Fri, 19 Jun
 2020 19:30:35 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 19:30:35 +0000
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep
 annotations
To:     Alex Deucher <alexdeucher@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= 
        <thomas_os@shipmail.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>
References: <CAKMK7uE7DKUo9Z+yCpY+mW5gmKet8ugbF3yZNyHGqsJ=e-g_hA@mail.gmail.com>
 <20200617152835.GF6578@ziepe.ca> <20200618150051.GS20149@phenom.ffwll.local>
 <20200618172338.GM6578@ziepe.ca>
 <CAKMK7uEbqTu4q-amkLXyd1i8KNtLaoO2ZFoGqYiG6D0m0FKpOg@mail.gmail.com>
 <20200619113934.GN6578@ziepe.ca>
 <CAKMK7uE-kWA==Cko5uenMrcnopEjq42HxoDTDywzBAbHqsN13g@mail.gmail.com>
 <20200619151551.GP6578@ziepe.ca>
 <CAKMK7uEvkshAM6KUYZu8_OCpF4+1Y_SM7cQ9nJWpagfke8s8LA@mail.gmail.com>
 <20200619172308.GQ6578@ziepe.ca> <20200619180935.GA10009@redhat.com>
 <CADnq5_Pw_85Kzh1of=MbDi4g9POeF3jO4AJ7p2FjY5XZW0=vsQ@mail.gmail.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <86f7f5e5-81a0-5429-5a6e-0d3b0860cfae@amd.com>
Date:   Fri, 19 Jun 2020 15:30:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CADnq5_Pw_85Kzh1of=MbDi4g9POeF3jO4AJ7p2FjY5XZW0=vsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::15) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YTXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Fri, 19 Jun 2020 19:30:33 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d87c7a3a-4337-43dc-9853-08d814873cdd
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2512DBA209E7BE4311ADF81192980@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xZz4cPf0E+IOuBmkCQ3S++fNyziA9Pq64W9G4wYDGTrNX7T/E+jlwmmTcuxdeABWMPlEioKTQu8PixCjZNnrotvglcqpVmJtZvr9EENsd6AzGjKAGz5qAklmRwdWo9/37L6KLYXdBZjdMnFndNa6Bi4/u+Ux8aUEjFmdGgbDPcu7G6YCHeTKwSsn69YxaSd6a3dspXtOMbEfqNvq3Ay9/r+Wffb55V8sxYvuOUIoZjEZBUb7WB37NFUrYhT8eY/ELVcycPH51rpIozwQAbsbNi1S9bv+qpGMATO6lVAdClMmT1cmAhL3rWixHNpwzBwqgFvMTytjbMohgLVzpguluCZI7KF1g0i0i2l83B8DKLmjwgz61uyWmP3l12x6RGvIPUpc5GtTnqVMF66xS5q9p4QF4zVo9RhNLB8ojAyCAvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(66946007)(66476007)(66556008)(52116002)(26005)(186003)(16526019)(83380400001)(316002)(16576012)(54906003)(44832011)(956004)(2616005)(86362001)(31696002)(66574015)(53546011)(31686004)(478600001)(8936002)(7416002)(36756003)(6486002)(8676002)(110136005)(2906002)(5660300002)(4326008)(966005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4jHeby2L7xpwW+2kztpdjD5Lp4yauBWGp68OfHn0TTG4071baxB0HW90ItqNnRquY141cw5qp3MI9JbfGm/PcHJcPyEqYIphB1N0nbzIo7+S8N+l3OErtyZpLSNv4Ee6rN4PPFE5JBo/1Xuw/byNW6whFt+3w8K5ieBxj31Pb52BssqS6tLyavIA6LzpxIFeZYknDHV8yOGWOCOOtrcIJSizT6GpzGdBfDZtbt5jlpu+/6pcHmbfJlzb4qkoc53puEIAhXvT6DaToD0dOh+j7bcUo1ANbIelh4gIglGWwmj8eLAMo4xqJe/hxL5kdjF5rFSjMx6b2Nmms0/kp4hQWYYgEq1zDmhvppCUGcFXEVC5xvZSMIbJfhVg6ykTRe+17yCtZd7WHJUSp0YQW0L02DJ04t+rkvta6xjQhcqGgrSM7q7GjXSpnUsIrz9hBydpkNJZ0iAiMBI7nKgWGavhI6jRcbgET9eEiToHpEjppI7NDRplW3lDF0XNDQv6lgR9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87c7a3a-4337-43dc-9853-08d814873cdd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 19:30:34.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtUIWjKt+9EwCo8J2gmm4KOpNCDOW2qykHmmrL2/MJZbcomdAIzbTYeHrm96Q6VXbMSHzqgKJwvqUPtnO00t0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Am 2020-06-19 um 3:11 p.m. schrieb Alex Deucher:
> On Fri, Jun 19, 2020 at 2:09 PM Jerome Glisse <jglisse@redhat.com> wrote:
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
>>
>> For nouveau the notifier do not need to wait for anything it can update
>> the GPU page table right away. Modulo needing to write to GPU memory
>> using dma engine if the GPU page table is in GPU memory that is not
>> accessible from the CPU but that's never the case for nouveau so far
>> (but i expect it will be at one point).
>>
>>
>> So i see this as 2 different cases, the user ptr case, which does pin
>> pages by the way, where things are synchronous. Versus the HMM cases
>> where everything is asynchronous.
>>
>>
>> I probably need to warn AMD folks again that using HMM means that you
>> must be able to update the GPU page table asynchronously without
>> fence wait. The issue for AMD is that they already update their GPU
>> page table using DMA engine. I believe this is still doable if they
>> use a kernel only DMA engine context, where only kernel can queue up
>> jobs so that you do not need to wait for unrelated things and you can
>> prioritize GPU page table update which should translate in fast GPU
>> page table update without DMA fence.
> All devices which support recoverable page faults also have a
> dedicated paging engine for the kernel driver which the driver already
> makes use of.  We can also update the GPU page tables with the CPU.

We have a potential problem with CPU updating page tables while the GPU
is retrying on page table entries because 64 bit CPU transactions don't
arrive in device memory atomically.

We are using SDMA for page table updates. This currently goes through a
the DRM GPU scheduler to a special SDMA queue that's used by kernel-mode
only. But since it's based on the DRM GPU scheduler, we do use dma-fence
to wait for completion.

Regards,
  Felix


>
> Alex
>
>>
>>>> Full disclosure: We are aware that we've designed ourselves into an
>>>> impressive corner here, and there's lots of talks going on about
>>>> untangling the dma synchronization from the memory management
>>>> completely. But
>>> I think the documenting is really important: only GPU should be using
>>> this stuff and driving notifiers this way. Complete NO for any
>>> totally-not-a-GPU things in drivers/accel for sure.
>> Yes for user that expect HMM they need to be asynchronous. But it is
>> hard to revert user ptr has it was done a long time ago.
>>
>> Cheers,
>> Jérôme
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
