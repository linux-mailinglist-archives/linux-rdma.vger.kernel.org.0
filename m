Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65472183F8
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 11:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGHJim (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 05:38:42 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:23873
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727932AbgGHJim (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 05:38:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4BWyrhDzNH/wGj8hNm+JBQn8EI5LgBzixErGp/Yb3SeJJOhorZDplJcYyEhDCtV9TTO5kOkKhEkEWKtkPJiokrb8wbmd7cBHb/BAw0kakK6/XRPqVLqBC4eP05D+vnHxACeNA4r8y6IbjSnl0pRJnyeYaUwPINIQYIKMAw1CLMVVWlRNpv5/Q5CIClP5ReWhEn8KbjsdF2dDFbDouhOxUlVqxo/w8JLt0SArgxepCGMQMEs1SRw4syk62CRcwgDv3PSS7xQjqBeubb6zWpuaq0CQCid61u5nRm+QoKxvWnEII6OJyn8bKKZacWltM4BKn0E1vNOtKKl6PwFU7VQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j20SdRDqoS2Rwjw0JY0jDwKzia8WEIaFIInTNiK5w8=;
 b=mhE1an6nXYp2Pol6mzW0J5VRGzFFkVNyvpKHjdLRJEWLRcevPqxfa/kpipL5cuX+2YuI1tXV6V8fUl4ukkDXHPZdyZHthk1aiEVGNbgbDFGNamUbie6qF9xV4ANNqm1E1TiXp9cBqNBEyeQsZA7IOBVWEXHJRDs6om1SHz2qxVCpMDoNh1zvpdNlfO+PQ/XWxNXFs863U2IiIEqM96NE8VyujtGDDxgwlnR5AVKUMfR+y/sq9KV5EHqQog0woGQDGrBmRsqUP0FZ9dBDkJGXyXLeZmOw+ZSYDkUl5b3707ntHY44TdoaZJZ0qacKNdNADj3hXfAP2C5SAqH+6w+3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j20SdRDqoS2Rwjw0JY0jDwKzia8WEIaFIInTNiK5w8=;
 b=oXIxVxp8ZZoHsNaEU9IEMcIkqFuHUAKFS85UUlSKTtUksr5CmnrJvG/BtKzV0PvnQkLKOC+65UDowi+jiU9q9G4jUYg+pE1EBc0w9DGS8Gih0DcaQisEI3SuhRhdtvwJ1B9deNU2Wp3FUI8okz6v63mG6p485Dp2hyMTHblfhUE=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3726.namprd12.prod.outlook.com (2603:10b6:208:168::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Wed, 8 Jul
 2020 09:38:37 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 09:38:37 +0000
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
References: <20200701123904.GM25301@ziepe.ca>
 <34077a9f-7924-fbb3-04d9-cd20243f815c@amd.com>
 <CAKMK7uFf3_a+BN8CM7G8mNQPNtVBorouB+R5kxbbmFSB9XbeSg@mail.gmail.com>
 <20200701171524.GN25301@ziepe.ca>
 <20200702131000.GW3278063@phenom.ffwll.local>
 <20200702132953.GS25301@ziepe.ca>
 <11e93282-25da-841d-9be6-38b0c9703d42@amd.com>
 <20200702181540.GC3278063@phenom.ffwll.local>
 <20200703120335.GT25301@ziepe.ca>
 <CAKMK7uGqABchpPLTm=vmabkwK3JJSzWTFWhfU+ywbwjw-HgSzw@mail.gmail.com>
 <20200703131445.GU25301@ziepe.ca>
 <f2ec5c61-a553-39b5-29e1-568dae9ca2cd@amd.com>
 <MW3PR11MB45553DB31AD67C8B870A345FE5660@MW3PR11MB4555.namprd11.prod.outlook.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d28286c7-b1c1-a4a8-1d38-264ed1761cdd@amd.com>
Date:   Wed, 8 Jul 2020 11:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <MW3PR11MB45553DB31AD67C8B870A345FE5660@MW3PR11MB4555.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0302CA0021.eurprd03.prod.outlook.com
 (2603:10a6:205:2::34) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0302CA0021.eurprd03.prod.outlook.com (2603:10a6:205:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 09:38:35 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 722c98ac-e1aa-42bf-e73a-08d82322b08a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3726:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37267A161CD30E9B62CA617C83670@MN2PR12MB3726.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvvMVJBeRMwSmyI3WBQA1Ms0HtfusFgdwzuRZZyzO0OQtaZ87orp4Iuj/wRR2WQPZoi1b7B5KX5X4vmvOTj0l4Ua7wa48RUvMlmzlrrCqEidUXpyJv819cl0FlGZqGjXwtEW5Cbtebq60DWvwaiOcZn45wMZH+QMzxgGbXsi8j2r/r8cvwTjWf+Xzvxl6xTBp/Hzsc0Z3MFoiy6YZ7Pho4twyHMuUcKrWXlb9iV9I/osJoFoep3XK+POV1aH9g/V7d45AxXWbSCFWyCIESkuosmMsNROJnScHJTj8m0Ai0gCw7GzAK3d8yN/FLUJvE6mihcmdiWm7jd4IF7hoPrnHhlg2E166kHhdOoJGkZ2RTU3IQdci/XVw2Yx5i5EFiaCt6gySHxEJSFsdzZOXtMK05SRK+76dDZZ5+Qb7+bGAQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(86362001)(478600001)(316002)(4326008)(966005)(66574015)(31696002)(8936002)(6486002)(110136005)(186003)(52116002)(16526019)(31686004)(66946007)(2616005)(66476007)(66556008)(8676002)(2906002)(54906003)(83380400001)(36756003)(5660300002)(6666004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: w+gmZ9RXETQEjNfBxiachwz2xY8S6UrygRCJnxPMC7ZdLyT609ZkL+ewtugC85xnA0QtKcYD/8pgkIpIs/FRlpM+cb9cQjWYANIRpm6x1f3EtN9bNKfTc8VurNU9xzPWIGsfxhGxCMozXcCS9Dq4wUUdR3hYA7mQkKuvxLwO+L7iE8IGQ2XfMGqgDyIzihWjDvBjXEP2Zz1J/kHDSozRRKzFA0TIxuWdfxacbO5He2U028YWxUYLOAtqgcuTIqShViqhcxdD3vcQJTgIBc8WWn1/qsIehrtG7ku5I0KDYeXpxm9lKX6X+x6YNo8404Ho5hjpU1QEPdkofTAGNxvwyHEXvmcvfMLSpymLGB+ncXBZr4cT410tGQdO27ug4klYLL4rj2qcN4dS+E+RwIftJyQuwcQBYnqwRDzBIjMX1QkBHllOzLUp//1+3AGO06nacTkwDWNRt9bEzKg1rY/qA485mA80yOJy/I4Oh7efU3LjacI9EiMeP9bMul/MiFLUzr5bLUhbu5je9gEzoNPhSbrw8cnB0bJwR88auyoJjaVMpv7248e4cOdGf4vH7JwI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 722c98ac-e1aa-42bf-e73a-08d82322b08a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 09:38:37.4016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPgd7Bx/30iPBiWPfIp3XpfI7cu2keRrDQE+t144ScQWBjJZxs4IoUcPDIWdYxmL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3726
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 07.07.20 um 23:58 schrieb Xiong, Jianxin:
>> -----Original Message-----
>> From: Christian König <christian.koenig@amd.com>
>> Am 03.07.20 um 15:14 schrieb Jason Gunthorpe:
>>> On Fri, Jul 03, 2020 at 02:52:03PM +0200, Daniel Vetter wrote:
>>>
>>>> So maybe I'm just totally confused about the rdma model. I thought:
>>>> - you bind a pile of memory for various transactions, that might
>>>> happen whenever. Kernel driver doesn't have much if any insight into
>>>> when memory isn't needed anymore. I think in the rdma world that's
>>>> called registering memory, but not sure.
>>> Sure, but once registered the memory is able to be used at any moment
>>> with no visibilty from the kernel.
>>>
>>> Unlike GPU the transactions that trigger memory access do not go
>>> through the kernel - so there is no ability to interrupt a command
>>> flow and fiddle with mappings.
>> This is the same for GPUs with user space queues as well.
>>
>> But we can still say for a process if that this process is using a DMA-buf which is moved out and so can't run any more unless the DMA-buf is
>> accessible again.
>>
>> In other words you somehow need to make sure that the hardware is not accessing a piece of memory any more when you want to move it.
>>
> While a process can be easily suspended, there is no way to tell the RDMA NIC not to process posted work requests that use specific memory regions (or with any other conditions).
>
> So far it appears to me that DMA-buf dynamic mapping for RDMA is only viable with ODP support. For NICs without ODP, a way to allow pinning the device memory is still needed.

And that's exactly the reason why I introduced explicit pin()/unpin() 
functions into the DMA-buf API: 
https://elixir.bootlin.com/linux/latest/source/drivers/dma-buf/dma-buf.c#L811

It's just that at least our devices drivers currently prevent P2P with 
pinned DMA-buf's for two main reasons:

a) To prevent deny of service attacks because P2P BARs are a rather rare 
resource.

b) To prevent failures in configuration where P2P is not always possible 
between all devices which want to access a buffer.

Regards,
Christian.

>
> Jianxin
>
>> Christian.
>>
>>> Jason

