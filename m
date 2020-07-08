Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F27218A00
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 16:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgGHOUb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 10:20:31 -0400
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:63362
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729526AbgGHOUa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 10:20:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvj2PP0na+gTtbpYd/TrDvMhP+wlYlf/s9oiRPdeUsAjNmrTQbkuFUgtW/S9YNV8RVtuqBtqXia6oNLCj3u0FZIwqh/7EvbM4l3fsa9UecUAcBfldXsWKxDyZEfEIzbBJjAbpPx1cWiMXUvrwiYpwNeIFaosJ0sE89oDdcG+BjPrp8bWWx9p7u9Y52GnGgLKBHal4rGj7Xj6TkSD2k93QEybSBfLHH4Ay3VeVDb6y6znzdik0uYTXkgtlftjZxCgSMobXX9lfOfQLj9RWxYEalxwri2JdDYPD8jwGkABMWlLUjRDyP7izz8Q3T/ZfsbdjFYqjHVU6R9cni2VQWTtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhWjMNohkgfFPxeJeztfbDhDPW33e2u/cK4cAtfQRlw=;
 b=DAA5QvapSpQB0Cmnk2tPk+uVxwUvwnqJFJ+MQeuuzoMj+/K34eHY7Dz1ZoJpk0VqROiVEUuQws0CeYqFV3mSmJru/XQI5y+Ylj+NGxJk9Jp0CdN01Eqsqxr0whSjh9tdn4+UxLaRAw9tltxOCvMU+efAZCMJyOxQoaG6WUORKWMSvcS1PcQzI1/XYLuX8HB1i606InjQVIyhwv1kVb8/zqZviYw1oSbBCEjzb0rUwb3OrsIv1G71J28htvefNT3hWkLTyannXrFvjyrhJb3axer0kcmvjnDgaX6MVQWIBZM1hlyVPXOC+gNNOk1T45kk7ibBGa1yTkFBXjozf+jvOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhWjMNohkgfFPxeJeztfbDhDPW33e2u/cK4cAtfQRlw=;
 b=cFSZhlr4tjBT5WROVW7EQykA7Gvj2ptCGx+peKuJu7tIZ0wCM57MenDq5veraDJv0KCBGb6pcpxbbjls9nWgf4CEsnh26RSU42Gv5xkILeW/kHwDKTUBvrULCtSxaaU84L2GR2o/s35arj0UPULzNlETt2lVzuE1INfgt7dCKao=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Wed, 8 Jul
 2020 14:20:25 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 14:20:25 +0000
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
References: <20200702131000.GW3278063@phenom.ffwll.local>
 <20200702132953.GS25301@ziepe.ca>
 <11e93282-25da-841d-9be6-38b0c9703d42@amd.com>
 <20200702181540.GC3278063@phenom.ffwll.local>
 <20200703120335.GT25301@ziepe.ca>
 <CAKMK7uGqABchpPLTm=vmabkwK3JJSzWTFWhfU+ywbwjw-HgSzw@mail.gmail.com>
 <20200703131445.GU25301@ziepe.ca>
 <f2ec5c61-a553-39b5-29e1-568dae9ca2cd@amd.com>
 <MW3PR11MB45553DB31AD67C8B870A345FE5660@MW3PR11MB4555.namprd11.prod.outlook.com>
 <d28286c7-b1c1-a4a8-1d38-264ed1761cdd@amd.com>
 <20200708094934.GI3278063@phenom.ffwll.local>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <14659513-8164-dcae-e4f9-f0a199aee542@amd.com>
Date:   Wed, 8 Jul 2020 16:20:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200708094934.GI3278063@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0059.eurprd03.prod.outlook.com (2603:10a6:208::36)
 To MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR03CA0059.eurprd03.prod.outlook.com (2603:10a6:208::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Wed, 8 Jul 2020 14:20:24 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 89d10fc7-9ecd-4b72-fe90-08d8234a0e96
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3966A1FA731E200EE2CB52E883670@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lI76Lgbx9PXOTijiwaCUBVeOxqGxQD065GKCugPl5kM4tF1ntWOh/KpF3H2M+3u7IXttFKL4DGYWR5f22CE9XRnAO9DjGEF8A6nNOybePDn6QicGnS/kzF8z8V4B7+eMS4trUdeoJx3nxPlbDcYEE/BOm7Vt+QdXP1j7Taozc36UyWcFud0IiBhrSEfs5764L3Td4Qfm2vnB94NuRmKKKlgwJ24wwDqPBdHj1Bhfkl7Thg8pdCOmOYMb+YEOXBH9XztikqfUa0hI9vWZg8ofd3F8/Xnnu6UTO6ETAnWB6Hn7hlcSvTpMn/FmPyMw052EsBn0yR9sFbEmQfjfMghiJd2gfjfTIapOB7cYiZCijraLxzzf+cXa6dVuHQhe4VquTmYDw0EoxQZZ7S6JyI+0aCyVj7XyUqofM37G3PdlpSSJ4Gi3EH4Pq+vy7cxyRyh8ZIqeObUzu+lPDhfpnA1Lcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(396003)(39850400004)(376002)(316002)(186003)(2616005)(66476007)(5660300002)(36756003)(16526019)(8676002)(66946007)(66556008)(86362001)(54906003)(478600001)(8936002)(6916009)(2906002)(31696002)(6486002)(66574015)(45080400002)(966005)(31686004)(83380400001)(4326008)(52116002)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eiIFygPxTYSN4OoFj4uSdHa66R8pCZggTaqqrQLMTIErQCwxRCPUYOIAzt2O5QO2MUXiSukAdcaxKUf2LIpPh+gWJI8HkNYq4u/QYjSMVJGXwONR5VW00YF4QEs+Cv9ANTmcy4Bx85Lga3Gvs7SqQ43P3utNYXw24oRzv0dnR4GfeSOZyrdf6HANONBTkjydR5aw3v8U4vfjd52gnNhxuesBUMN0mYV/Eejjd3W65ykGDKHv2JCfJkfHLk1vbEgGjYzAciYCnAEq9t3oCJIBjkQbkKGVn2ibMJoA0+kNcGL7fkAFJM7jfm0b4tacBeoJP4kfDJguTXMfooKZSmf6MyP48vfjjZbJDYbq1i0bf0W8hKFdK+SjgaFTa7XF9XoiBu+hLyIucvIXis2EUuqu4hYY7F8SZUTY5klkknsexHlEIgDwU8nzbzIRT9QrmLuP6hUxsoN7RgZumFKMwz4Vd1HW5HxVbfGJpgWje9ZtT/zYN4tKbOXsjezamRqefBJXoRDTYp5QpiWN2fH1XKr9LXhqsaFWi/0hNmyYWr+GQuU8ijR1+MYZadIF+hMpESMS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89d10fc7-9ecd-4b72-fe90-08d8234a0e96
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 14:20:25.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UIlFG/T/59l8ibYtpseL6k+9lo+QGz3gqo2/2pNEixRGcaBJxC6rJkxpkLCgZHY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 08.07.20 um 11:49 schrieb Daniel Vetter:
> On Wed, Jul 08, 2020 at 11:38:31AM +0200, Christian König wrote:
>> Am 07.07.20 um 23:58 schrieb Xiong, Jianxin:
>>>> -----Original Message-----
>>>> From: Christian König <christian.koenig@amd.com>
>>>> Am 03.07.20 um 15:14 schrieb Jason Gunthorpe:
>>>>> On Fri, Jul 03, 2020 at 02:52:03PM +0200, Daniel Vetter wrote:
>>>>>
>>>>>> So maybe I'm just totally confused about the rdma model. I thought:
>>>>>> - you bind a pile of memory for various transactions, that might
>>>>>> happen whenever. Kernel driver doesn't have much if any insight into
>>>>>> when memory isn't needed anymore. I think in the rdma world that's
>>>>>> called registering memory, but not sure.
>>>>> Sure, but once registered the memory is able to be used at any moment
>>>>> with no visibilty from the kernel.
>>>>>
>>>>> Unlike GPU the transactions that trigger memory access do not go
>>>>> through the kernel - so there is no ability to interrupt a command
>>>>> flow and fiddle with mappings.
>>>> This is the same for GPUs with user space queues as well.
>>>>
>>>> But we can still say for a process if that this process is using a DMA-buf which is moved out and so can't run any more unless the DMA-buf is
>>>> accessible again.
>>>>
>>>> In other words you somehow need to make sure that the hardware is not accessing a piece of memory any more when you want to move it.
>>>>
>>> While a process can be easily suspended, there is no way to tell the RDMA NIC not to process posted work requests that use specific memory regions (or with any other conditions).
>>>
>>> So far it appears to me that DMA-buf dynamic mapping for RDMA is only viable with ODP support. For NICs without ODP, a way to allow pinning the device memory is still needed.
>> And that's exactly the reason why I introduced explicit pin()/unpin()
>> functions into the DMA-buf API:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Flatest%2Fsource%2Fdrivers%2Fdma-buf%2Fdma-buf.c%23L811&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C6d785861acc542a2f53608d823243a7c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637297985792135311&amp;sdata=bBrkDynlACE9DAIlGntxXhE1unr%2FBxw5IRTm6AtV6WQ%3D&amp;reserved=0
>>
>> It's just that at least our devices drivers currently prevent P2P with
>> pinned DMA-buf's for two main reasons:
>>
>> a) To prevent deny of service attacks because P2P BARs are a rather rare
>> resource.
>>
>> b) To prevent failures in configuration where P2P is not always possible
>> between all devices which want to access a buffer.
> So the above is more or less the question in the cover letter (which
> didn't make it to dri-devel). Can we somehow throw that limitation out, or
> is that simply not a good idea?

At least for the AMD graphics drivers that's most certain not a good idea.

We do have an use case where buffers need to be in system memory because 
P2P doesn't work.

And by pinning them to VRAM you can create a really nice deny of service 
attack against the X system.

> Simply moving buffers to system memory when they're pinned does simplify a
> lot of headaches. For a specific custom built system we can avoid that
> maybe, but I think upstream is kinda a different thing.

Yes, agree completely on that. Customers which are willing to take the 
risk can easily do this themselves.

But that is not something we should probably do for upstream.

Regards,
Christian.

>
> Cheers, Daniel
>
>> Regards,
>> Christian.
>>
>>> Jianxin
>>>
>>>> Christian.
>>>>
>>>>> Jason

