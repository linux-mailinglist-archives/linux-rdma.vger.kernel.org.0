Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC15E751A7C
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jul 2023 09:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjGMH5B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jul 2023 03:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjGMH4s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jul 2023 03:56:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CC72D4A;
        Thu, 13 Jul 2023 00:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYKZ9VRBG5ZaCtw1sekmaRGqS2lpJmKSHOB9ER8k8aiLtqpg5SSIbgxL+/lKN/XLjJ+evXA9sFxtrIh5MRbWr/nrRb6uAv2aiCLBSy7ISZEuEllkmPs0TTXJfuf8fbUCMBxWivdkk7tDn1zbdWU89Ea4zrJU4XBqc57ESRTVWDWItiYVMjcRPf3M43stW20Z4Mt6zqpmlvLXv/0z2TsTAYM5HAvf3/nQ0B5CyvH6HML/HQW0P0Ykd4teXiaFH/PWFwpbbz72qz22/UNYAO4nVOfUrEL5nvoySVIDJpaoHZRUrVmJeNZV4U8Lbb+W+6o+g8/+EdWwet4Fekdee8pmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75Sn0RswHC90HNakDwbcXX2WA5rs4TSpsI1SiNVrGr8=;
 b=HHqDxihqvuNCxQkIny/+UhMUr3UWR4jcjHMVpRXcKv67wEUB8bPCdDKXfpUs+orDpcBRkf4XePMrX0n2k2JZL/Jrkn7bZzQnsEWrFb9huf9M9Pmjbf1O6CW6DTO6ATedqQQXNXBQkFL2OOj4O+KIHYzSvyz221yoc5qDWgQSUDCd1PEIcJpzm42zSquO9ey9DURDDUMpOJZqQXD5ek8FY4wUdjnkqon4YY86EAIqr0G9EuwX3vkYdgShQLa9IHknOumTQmzidh+iA8VQfeYnzGNuT7023mYKhKoBnIziNBpkpfIJXUqOouV3Ya4s9YQEn/BwlBlPVZ6Yq2NTXchMXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75Sn0RswHC90HNakDwbcXX2WA5rs4TSpsI1SiNVrGr8=;
 b=OfSuYhzirT/1Xxz4sYY5AjB7CZRg4977qI4aXsXdV7mwacwvy8UBX1zAKuc+5IIEWibPg2ynWND/YJUAmFJD8JJs6zGUXJNt04RI8C9aTVNRgcGeHHSAtMCBwV59HhLgpSACwRsZCzk8c9AtgwAOEokfn2llLvZ7gAGjDfnZfiU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 07:56:33 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::669f:5dca:d38a:9921%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 07:56:32 +0000
Message-ID: <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com>
Date:   Thu, 13 Jul 2023 09:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     David Ahern <dsahern@kernel.org>,
        Samiullah Khawaja <skhawaja@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>, logang@deltatee.com,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20230710215906.49514550@kernel.org>
 <20230711050445.GA19323@lst.de> <ZK1FbjG+VP/zxfO1@ziepe.ca>
 <20230711090047.37d7fe06@kernel.org>
 <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca>
 <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db41867-404f-4812-5bec-08db8376abce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iv1+xGFHSASJ5LdkvDUM6KBesydpRzU1pgT9HPXmfj+OyXKhbJKaN02qFmVhYXOVizjWC47i0nz3VZ+VWIu3QoI/JHoO5sPRGmxHLkGBZc1bGpu4hjH2IdR3F2Zb/6GkGqa28ZnyefUd3CtXZKCO2IwqhE9be7gXxSwPKA0WD+gmYeCDqFQijY8gAoOnRr9Zie8oL0OWs6S2pipzxlgmqXmD7s5iZRqDu9ZsegFV9wYkpJGSqCjnCALvlrtP27DD8fJTELOZW7ov8OAbQTaCcgbN0ImXenvxv+VzLxCDLTZU/LPRy0ldTC0mXG28iUYd2irRkb43l1R4R6LM1PKRFu64X8NFVVzYKV1G+KfhP1Xymb75nzJjpdyklvGTS/SzO9ZVLhnz8tp5C/fdZqMsZ4ziFvKaq4G24VM84EI9TNGsYPCZL8OmVGIyRRTpeqMM3/Mq9om5fn1q/aWpXGIIT/NtEBg8jCWnGtjH2wdPP1SU2B1PWNRY6qM3G6BLMKFGwI5tCtcd+4x5Vri/wxg9kQAS98QU7HG8yn60GyFsHSm/82uULR0ZGCBD0lcB+c4ZVWBPFO3j0TwFTriamaNNgVt9T2na6lhKbaHWePiBPy58c1GI+eZECR3WPEKC6BgONnnN1k8zQ5aLRduaqL2bHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(41300700001)(31686004)(4326008)(7416002)(2906002)(66946007)(66556008)(7406005)(66476007)(5660300002)(478600001)(31696002)(316002)(86362001)(38100700002)(8936002)(6666004)(8676002)(6486002)(6512007)(36756003)(83380400001)(6506007)(53546011)(186003)(110136005)(54906003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVA2U05QOU9vOElTWHdjb0JSVFNGS2phaG1xdisva1U4N01JTlExS3dSb1NU?=
 =?utf-8?B?YllHWmZPZzJPSnlDU1A3TWxmNE9HQVpOSzM3MGJaTnY2d3hNdGdySmFJOExi?=
 =?utf-8?B?YlZhN3BXeE8rekRMWmNRVmVPbnZJTmtLbVhJMjAwSDdENGNwU0R2VmlKQUIv?=
 =?utf-8?B?OXE4Rms3cWhEYmlXTkZhZ3RCTmpnUkxRR1NCTGFwQnp5bVo5WWxrS0ZoeE4y?=
 =?utf-8?B?dnZXSkloMjJTcWNXbW5xV29XMVN0bis0Vld0SUMvWmlTbkVrYy8rTXBXckxl?=
 =?utf-8?B?Z2s4OHZvTkZnUHpQVllqa3BoTmk4MzM4YlhoU29KVEFVNWhoRUptdFpKUTBi?=
 =?utf-8?B?V1JsQ2ovdTVzUWc5Qmx0NXI1c25ITVB0Qm5PUHNMYlE5UWpVaVIwM2lYTHpt?=
 =?utf-8?B?ZS9RdmIycFFYOWlMRzlpckduK0Z0b0UyYzIwRHBNZ0VhbktXSnVrMzdsRkM2?=
 =?utf-8?B?YWg4TVp0WHJnSDZYeFdBUyt1em8zZHAyNnQyTFZXaFAra3laS2kzUHFLRUxj?=
 =?utf-8?B?MGxLNkZMRngzdmtocGlPQXMzTkZMUEl4SjRFS1ZWM3N3TU5MYktuU25jL2gy?=
 =?utf-8?B?WVI3YWhHVEdpeUhrbjA3aXNxbDlpSzBuSnJWUVNzVzFFS2l4T3NUMnhjK054?=
 =?utf-8?B?eGdMQVBIOUJmd08xd2kzcmE5Z0dkY1IrTzVlWDNqK0Y3dEM1UEp6NXo1Rk1L?=
 =?utf-8?B?YTJycExMWDk1NnpFbDZydytDSDA3OTM3Qm9xTUx4WTFiNmJwbGxhOWI5SkFn?=
 =?utf-8?B?VUlWcmtzMHJISGRiYlhlOGZBckh4M1huUG9uTGdCNmJ2cVArNllBaVM3dkVP?=
 =?utf-8?B?UmhJQnovRmdIa0xDT1NLOGNVWmRqMm5PMFNuOGk0V3JJL280aUhFSmxOQlh5?=
 =?utf-8?B?Q2Z6aXJWdFdXRFBBLzhDZUJEaWpwSTVWK2VrWkMvYW5xVTBNWFI4WDIrMFRO?=
 =?utf-8?B?czlhTmxPbEVzOWpRS2QwTzFBNlJRS2U3M04zazZ2anRxczdvVXBCNEN6ZVRK?=
 =?utf-8?B?ZWhiK1IyaktWU3FUR3NVM3dKc1dhU2hxZ0ltSzgwZzExSUp5M3lEc0ZseFNH?=
 =?utf-8?B?TXpVK2lIOGxUcUJCZkhsc3orNFlVUGR4dkludmxFWkovZ095N210SkQ3QWx5?=
 =?utf-8?B?dnNMVEdHcFZoWWdJV3BDb1V6QWdtMEN5NkZOczJsUHIyRDJvWU5Hc1VPTENR?=
 =?utf-8?B?NTRiNzBDWXNORDFMSHlBc2NRY3BCSkNpNGlUWVJwVVR5S0F3S1NMSFMyMHZ5?=
 =?utf-8?B?OVQ2S01ETmlqV3RTZTRlNWJBVjU4MkVrQm5nUURsWTR3Q1FHM1dKc0hWOXBy?=
 =?utf-8?B?cnZ1d0pTQVpMWjF6V2h1Q00ySHNXSkZPSXBWMUVZVUxCZG9yZDlnMmVmc2kw?=
 =?utf-8?B?T1dTTDN4U0RER0xSVWNyMHFlVitQTmZkenpnNmVGUHRPNWxpV092ZDROVDJJ?=
 =?utf-8?B?OUJrcU95NVM3dlFCM0RjQTJmbERnbHJqU29MUzE2bVc2SmtUeEdTaE55Qmc5?=
 =?utf-8?B?ZXVYb2VVdndzV05OOGdPRGg1UmhBdTlJcVgrb29LeHlJZThZTG1YaTl6MEYr?=
 =?utf-8?B?SWgwMndrNGJtU2drOEVvaDh0Tm5CTEF5a3pOUFBIN3VJRFBTZEREN3ZYRGtl?=
 =?utf-8?B?QnVPRk90cjc5enBEU2pNZjFWQkhNWFZFWHlHSkI2aCsybmE5VnpwM1psTW9C?=
 =?utf-8?B?S1Fja29vUldaWjc1L1ZtbTk2OENzMy9SYldjdk9UR3JMMkQrd2pKaTdocWR4?=
 =?utf-8?B?TEJ3U09zZDRYUTVHMUxiSDBYREN4TE5Wa1U4S1IwUC9zdVpvZVRmOUFWWnl2?=
 =?utf-8?B?T0QxMjhQWlhTUkJVUUJQTTM2RUlDNzBacUJ1V3RrSUhwQXBkbTNjRldjSGVX?=
 =?utf-8?B?S0tMNk9hNXVIVURzVXludm96blc0Qis2a2VENHV3c04zYVlJbE1kdTFucGcx?=
 =?utf-8?B?S1pyRWRQZGZQUWFMOFh2QWVBQ0kwOHMzNXZOOXZWbmpFb1FzTDBMdGUwNGxu?=
 =?utf-8?B?MWZNQVNTNFcrNXlnc2sxUDhidWU0YlJNVjVtd3RxcUplOEpSY2NNU2JRTjUw?=
 =?utf-8?B?T1dzaEpBbUU2RnZnYkJsTk1SbWtXQW5GSTNYUG1vUG5PNTJIdnNmejRybXR1?=
 =?utf-8?B?elo3QURlV0VQbW9QQm95VHREN0lzRGdDZnJPYmlMZ3BHeFRlc3ZORG16SlZn?=
 =?utf-8?Q?OG5cD7XQNl2RmiYhT5gy/KTkBmMzXcXmOW8G3T4VSEq8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db41867-404f-4812-5bec-08db8376abce
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 07:56:31.7572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFzm5HPPfWQ/s/kgXDjqcmrF/AllwORf/lK6hZCxFGmp2BANiSHzgK+J8rRrqMS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 12.07.23 um 22:16 schrieb Mina Almasry:
> On Wed, Jul 12, 2023 at 6:01 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>> On Tue, Jul 11, 2023 at 08:42:24PM -0700, Mina Almasry wrote:
>>
>>> 1. The device memory driver would be the p2pdma provider. It would
>>> expose a user API which allocates a device memory region, calls
>>> pci_p2pdma_add_resource() and pci_p2pmem_publish() on it, and returns
>>> a reference to it to the userspace.
>> This is not quite right, if you convert any of the GPU drivers to use
>> P2PDMA you are going to need to restructure the p2pmem stuff to
>> seperate the genalloc. The GPU driver must continue to be the owner
>> and allocator of the MMIO memory it already controls, we can't have
>> two allocators working in parallel.
>>
>> The genalloc stuff supports the special NVMe use case, I don't know of
>> anything else that would like to work that way.
>>
> I think maybe you misunderstood the proposal. AFAICT the genalloc
> stuff works for us, although there are other issues with p2pdma that I
> need to solve.
>
> The proposal was that the uapi in step #1 allocates a region of GPU
> memory, and sets up a p2pdma provider for this region of memory. From
> the perspective of the GPU, the memory is allocated, and in use by the
> user. The p2pdma provider uses genalloc to give out 4K regions with
> struct pages to in-kernel allocators from this memory region. Why
> would that not work?

Oh well, where should I start.

struct page is used in the various I/O  subsystems instead of DMA 
addresses because it allows for a wider range of operations.

For example when a page is acquired using get_user_pages() somebody can 
use the rmap to figure out where a page is mapped and eventually unmap 
it, map it read only or change the caching attributes etc...

Then you have the ability to grab a reference to a page, this for 
example allows I/O operations to complete and not access freed memory 
even when the application has already long died.

Then a very common use case is that you need to fallback to a CPU copy 
because the data inside the page isn't aligned or outside the physical 
reach of a device.

The are just numerous issues with what I listed above, for example some 
of those use cases only work with pagecache pages.

Approaching it from the user side, with GPUs there is usually no 
guarantee that stuff is coherent. E.g. a network card wouldn't 
automatically see the results of a calculation.

Then GPUs usually have tons of memory which isn't CPU accessible or even 
PCIe bus accessible. So a bounce buffer done with a CPU copy won't work, 
you need to bounce this with a hw assisted copy. Or you have inter 
device connections. For example ethernet over HDMI links would be able 
to access all of the internal GPU resources.

Then GPUs often need to shuffle memory around, e.g. similar 
functionality to ___GFP_MOVABLE. Just with stuff not CPU accessible nor 
mapped into CPU page tables.

...

I mean I can go with this list for quite some time :)

> Looking at the code, that seems to be how p2pdma
> works today. The p2pdma provider does p2pdma_add_resource() on a chunk
> of its memory, and the genalloc allocates memory from that chunk?

Well this is how it works for NVMe, that doesn't mean this way works for 
GPUs or acceleration devices.

Regards,
Christian.

>
> The actual issues I see with this approach are:
>
> 1. There is no way for the p2pdma provider to relinquish back the
> memory it has provided via pci_p2pdma_add_resource(), in the case that
> the user crashed or would like to free the GPU buffer. I would need to
> add a pci_p2pdma_remove_resource(). Would that be  acceptable?
>
> 2. The p2pdma semantics seem to be global to the pci device. I.e., 1
> GPU can export 1 p2pdma resource at a time (the way I'm reading the
> API). This is not usable for my use case. I would need multiple users
> to be able to use the uapi in step #1 simultaneously. I would need the
> same pci device to export different p2pdma resources simultaneously
> and the p2pdma clients would need to be able to import some of the
> resources. I would likely need to add an api like this:
>
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 8318a97c9c61..c9d754713fdc 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -19,6 +19,33 @@ struct scatterlist;
>   #ifdef CONFIG_PCI_P2PDMA
>   int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>                  u64 offset);
> +
> +/* Adds a resource similar to pci_p2pdma_add_resource, and returns a file
> + * handle referring to this resource. Multiple such resources can be exported
> + * by the same pci device.
> + */
> +struct file *pci_p2pdma_add_resource_with_handle(struct pci_dev *pdev,
> +               int bar,
> +               size_t size,
> +               u64 offset);
> +
> +/* Remove a resource added via pci_p2pdma_add_resource_with_handle() */
> +struct file *pci_p2pdma_remove_resource_with_handle(
> +               struct file *p2pdma_resource_file);
> +
> +/* Allocates memory from a resource created using
> + * pci_p2pdma_add_resource_with_handle()
> + */
> +void *pci_alloc_p2pmem_from_handle(struct file *p2pdma_resource_file,
> +               size_t size);
> +
> +/* Frees p2pmem to a resource created using
> + * pci_p2pdma_add_resource_with_handle()
> + */
> +void pci_free_p2pmem_to_handle(struct pci_dev *p2pdma_resource_file,
> +               void *addr,
> +               size_t size);
> +
>
> Looking for feedback from anyone knowledgeable, but the p2pdma
> maintainers as well if possibl.
>
>>> 2. The NIC driver would be the p2pdma client and orchestrator. It
>>> would expose a user API which binds an rxq to a pci device. Prior to
>>> the bind the user API would check that the pci device has published
>>> p2p memory (pci_has_p2pmem()), and check the the p2p mem is accessible
>>> to the driver (pci_p2pdma_distance() I think), etc.
>> This doesn't fit the programming model for GPUs at all. You don't want
>> to get packets landing in random GPU memory that a kernel side
>> allocator selects, you want packets landing in GPU memory owned by a
>> specific process that owns the TCP connection.
>>
> I think this comment is maybe a side effect of the misunderstanding.
> In the proposal, the user allocates a GPU buffer using the API in step
> #1, and then binds the memory to the NIC rx queue using the API
> specified in step #2. We use flow steering & RSS to steer this user's
> TCP traffic to the buffer owned by them.
>
>> This is why DMABUF is used here as it gives a handle to the GPU
>> memory. What you want is to get the P2P pages either directly from the
>> DMABUF or via pin_user_pages() on the DMABUF's mmap.
>>
>>> AFAICT, all the concerns brought up in this thread are sidestepped by
>>> using p2pdma. I need not allocate struct pages in the core dma-buf
>>> code anymore (or anywhere), and I need not allocate pgmaps. I would
>>> just re-use the p2pdma support.
>> Well, as I said it is going to be a big ask to P2P enable any of the
>> DRM drivers.
>>
>> And you still have the netmem vs zone_device struct page conflict to
>> figure out
>>
>> But it is alot closer to reasonable than this RFC.
>>
>> Jason

