Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B8210B5B
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2020 14:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbgGAM4D (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Jul 2020 08:56:03 -0400
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:35937
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730388AbgGAM4D (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Jul 2020 08:56:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqQzBtLEJGdUmXlTagnG4JLM19jnnZ+a5seNnnqTBB+SKtuSTK5btyweiDaWrbnotvjM9F64Hxai9Whyk7N/tbEtccnB/xfSibFR1jWXSCRj75fKkNQkc++L5XvekhviMg2pbjjQDdMd9A8oPoyb9VydptLdl8V9PypD99KVrq0OBTm8AsosdsPJ8YeMIaFjyCm5hv3I25YJ6N8wjqJTqlG/umyFwa9FQm+erF7zDempGDyGdNe7TT63V13+CDSy8quYUcJjt5SAGg7tkrDsLZVyvtQwjhfFYVB1gAO980bki8LH9kv3oc5pK269PMt7X12CcthOPSvJNPuRoZtl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8qATa1AhLI+m9DjSI+QccLrU3LB68gUYAfiEIF2aKE=;
 b=ml5y3ByUcViB2CJgNOzEfePgja1/Hdqb+mmC73j/kUwIRRsY/x9fuwqJVQkZI9MOtL9GMKtzm87+J1wRJcE1+njeOP5L00dmKp2CtuPealSRY5Up1MPpY2sWcrJ14xQi63pcG8mEd4L3aKqqSj8ufiKvOzHz/pUWF4y5eJ3FLStnA+mKAqnVeHZ0TsNO4MKS3LTEaQZt4yf3zCFOUfyJwt21EwjRt5y8ZZcopA4g3q58GKrQgwMoLZA8KpntegAihFNKiQ5ZXMQsCEeMKK+Z937cqPb5kqDeTxbYiFe0/pluXpPbmCtPul/3FhV9AJtlnVbHSZwcYmJvwC12yREmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8qATa1AhLI+m9DjSI+QccLrU3LB68gUYAfiEIF2aKE=;
 b=ChXXrqpBedsWZjyB8SOubBG8WCh32KgCBb5UZEPa4QrbeWbCozqSz06OUHTf/aPWRIVzP4Z5qPezwOyqyCZ+rglNPDYx/oTI+wDc7tFlvSVJwOALEz4PrPyWdf0nSgHSKuNqPLFvs2d3l4KpDci+85EI/DWLs6FruxdkqcWUa9A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Wed, 1 Jul
 2020 12:55:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.021; Wed, 1 Jul 2020
 12:55:55 +0000
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca>
 <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200630173435.GK25301@ziepe.ca>
 <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <9b4fa0c2-1661-6011-c552-e37b05f35938@amd.com>
 <20200701123904.GM25301@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <34077a9f-7924-fbb3-04d9-cd20243f815c@amd.com>
Date:   Wed, 1 Jul 2020 14:55:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200701123904.GM25301@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0082.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Wed, 1 Jul 2020 12:55:54 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 251afa5e-bd1e-473d-8526-08d81dbe17e0
X-MS-TrafficTypeDiagnostic: MN2PR12MB4239:
X-Microsoft-Antispam-PRVS: <MN2PR12MB42394842F4A566BEF4BF0327836C0@MN2PR12MB4239.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /q13NElfkwUZ1qQUjw6js4b3uvaj+LeRI5vXrauzq2tBJzW1Dq7wvi3xADkiThNf0kc6COU88P0yglYYrUlIlX87WmziRUn2144e7IIUjKnyRfN9joEtmI3s/O6lJKf2CKo+2kuUcygM3zZ1sAKMqemc9hbPHobA6Wu1Ury95zWwwW0M2AU1gVTIa607ZnjOIRCIRXTpENiJU1L0rDLlkfD0daT8WHCOgtLB1NAlytPqgjYqdP3QlVrKKbASLV6gmG3xOvcAiCc9GVD0iCT4aDNBYG1+y0lH81EjAPKtRfcOIEBD752coWO6Z8bYTZwnRTKREhZD+VDjvp9/2cCBHtfOZjKfQu2fygb4r4n4D2o4OrUcIUZagITi6fPf4BxS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(8676002)(66574015)(4326008)(53546011)(36756003)(6916009)(52116002)(31686004)(2616005)(31696002)(8936002)(186003)(66556008)(16526019)(66476007)(6486002)(86362001)(66946007)(83380400001)(5660300002)(316002)(54906003)(478600001)(6666004)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QC97BGNz/KjHj2FL4BkwkSRZiAoFbt4oHynlgW+0/BxmjSNdjpKJAbl04R1cYhSsGsXwBFgPMzd/M/LcTpfC7/1cixVeTwAiEif3eSjgInHsuNKRklvcFId4VwNl/wXBXYzspicchGM8zJsh8b9hvCUn283FjhF89M7KNQgELIksjR/WoUGqxPndMxI+InfS9FbXowwuscsQEBMN6RdzCqFrh7m1s5/6WIddO1BoswlMf3hemUrYcfveT0uADxgCfkZ9eJ0YSrP3GerqvIcVJt2ZOPcZlidnGDCloYQpzR0gdodUN9Xs7JUeJuYYRY+Z3rMic+YUFwSD6ZJhOf9GvAiA78yZxu+mqQBIhs1sS11/zf7e3t1ykssbS1UKBH6h4nLTPHiIztZbQ4muI4BSgC01F8RIJcAgyOa8gFo4cLuaOBhtpEUgG7N0jgSNeqPDMuWE8p32bHWCdDSZ3Bn1TjmMNU9bvv+UgJOl2fOYGmGbMg7xbWAJDr6m9EibKt0NjugLqFvWo4UDamKjINYGahB3BIIeATEig7ZgZ++T170ZLpYjVX+TQlU0ZkrgyFQB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251afa5e-bd1e-473d-8526-08d81dbe17e0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 12:55:55.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUnTIDz5VrbpYDYTweSfl0NLaNQKfkCttmfbwuHgFBAl+tHOdFfOJHE0fYwfAKk4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 01.07.20 um 14:39 schrieb Jason Gunthorpe:
> On Wed, Jul 01, 2020 at 11:03:06AM +0200, Christian König wrote:
>> Am 30.06.20 um 20:46 schrieb Xiong, Jianxin:
>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>> Sent: Tuesday, June 30, 2020 10:35 AM
>>>> To: Xiong, Jianxin <jianxin.xiong@intel.com>
>>>> Cc: linux-rdma@vger.kernel.org; Doug Ledford <dledford@redhat.com>; Sumit Semwal <sumit.semwal@linaro.org>; Leon Romanovsky
>>>> <leon@kernel.org>; Vetter, Daniel <daniel.vetter@intel.com>; Christian Koenig <christian.koenig@amd.com>
>>>> Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
>>>>
>>>> On Tue, Jun 30, 2020 at 05:21:33PM +0000, Xiong, Jianxin wrote:
>>>>>>> Heterogeneous Memory Management (HMM) utilizes
>>>>>>> mmu_interval_notifier and ZONE_DEVICE to support shared virtual
>>>>>>> address space and page migration between system memory and device
>>>>>>> memory. HMM doesn't support pinning device memory because pages
>>>>>>> located on device must be able to migrate to system memory when
>>>>>>> accessed by CPU. Peer-to-peer access is possible if the peer can
>>>>>>> handle page fault. For RDMA, that means the NIC must support on-demand paging.
>>>>>> peer-peer access is currently not possible with hmm_range_fault().
>>>>> Currently hmm_range_fault() always sets the cpu access flag and device
>>>>> private pages are migrated to the system RAM in the fault handler.
>>>>> However, it's possible to have a modified code flow to keep the device
>>>>> private page info for use with peer to peer access.
>>>> Sort of, but only within the same device, RDMA or anything else generic can't reach inside a DEVICE_PRIVATE and extract anything useful.
>>> But pfn is supposed to be all that is needed.
>>>
>>>>>> So.. this patch doesn't really do anything new? We could just make a MR against the DMA buf mmap and get to the same place?
>>>>> That's right, the patch alone is just half of the story. The
>>>>> functionality depends on availability of dma-buf exporter that can pin
>>>>> the device memory.
>>>> Well, what do you want to happen here? The RDMA parts are reasonable, but I don't want to add new functionality without a purpose - the
>>>> other parts need to be settled out first.
>>> At the RDMA side, we mainly want to check if the changes are acceptable. For example,
>>> the part about adding 'fd' to the device ops and the ioctl interface. All the previous
>>> comments are very helpful for us to refine the patch so that we can be ready when
>>> GPU side support becomes available.
>>>
>>>> The need for the dynamic mapping support for even the current DMA Buf hacky P2P users is really too bad. Can you get any GPU driver to
>>>> support non-dynamic mapping?
>>> We are working on direct direction.
>>>
>>>>>>> migrate to system RAM. This is due to the lack of knowledge about
>>>>>>> whether the importer can perform peer-to-peer access and the lack
>>>>>>> of resource limit control measure for GPU. For the first part, the
>>>>>>> latest dma-buf driver has a peer-to-peer flag for the importer,
>>>>>>> but the flag is currently tied to dynamic mapping support, which
>>>>>>> requires on-demand paging support from the NIC to work.
>>>>>> ODP for DMA buf?
>>>>> Right.
>>>> Hum. This is not actually so hard to do. The whole dma buf proposal would make a lot more sense if the 'dma buf MR' had to be the
>>>> dynamic kind and the driver had to provide the faulting. It would not be so hard to change mlx5 to be able to work like this, perhaps. (the
>>>> locking might be a bit tricky though)
>>> The main issue is that not all NICs support ODP.
>> You don't need on-demand paging support from the NIC for dynamic mapping to
>> work.
>>
>> All you need is the ability to stop wait for ongoing accesses to end and
>> make sure that new ones grab a new mapping.
> Swap and flush isn't a general HW ability either..
>
> I'm unclear how this could be useful, it is guarenteed to corrupt
> in-progress writes?
>
> Did you mean pause, swap and resume? That's ODP.

Yes, something like this. And good to know, never heard of ODP.


On the GPU side we can pipeline things, e.g. you can program the 
hardware that page tables are changed at a certain point in time.

So what we do is when we get a notification that a buffer will move 
around is to mark this buffer in our structures as invalid and return a 
fence to so that the exporter is able to wait for ongoing stuff to finish.

The actual move then happens only after the ongoing operations on the 
GPU are finished and on the next operation we grab the new location of 
the buffer and re-program the page tables to it.

This way all the CPU does is really just planning asynchronous page 
table changes which are executed on the GPU later on.

You can of course do it synchronized as well, but this would hurt our 
performance pretty badly.

Regards,
Christian.

>
> Jason

