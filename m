Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EAE021B5B7
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 15:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgGJNB0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 09:01:26 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:7589
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbgGJNBZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 10 Jul 2020 09:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJkzxDsVxd6UWgRY7nMqJaKwlXKR11wXCEl60F7mqXjKv2dgpITL8xW0uZ1B/94WXGkHUAqlaSSH2xAcZ14pASWckhLnhwHyui+uK+rWbnA60CioyzgrpyH0SK2LlBasF4xYsrawnVbqXJPc4Qvuz1vD5yPcGJMuWMgpyseJxG4a9L2RnBR8vTBl2KU6UwVYimABFPHnczFlwJh55ugxBnGKnIJCeHY9RWQqDEs3E2VHAuVaQzIeM092vEkvQUXAJU+KpEE6/TccsG5kbau6zYtNpVKFYglLJR2kt9ODWjE8FdtJNul08iq30zmiVfPfj9R063T/m1BzQ4GeVdPSog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvoj0UPxl5sV1BKedq5MB5ya7NKN4pwFxxf9skzqc5A=;
 b=QJIRHdMM49AUpfb9tPhRVBiUJBgz3TRJrvjnEUrrxO7ahcuLHjMY+22l7s59GcibLz2oL1wEEKemfjY2LRmaCjWPDRm1SsI5e8ZKVsa6DvsWSt6INeR0REjlYrY8L0pM0Tcn2AUvA/ArXY6SV3j92va5KXwcIzLoPDhs8FDyrcewKxC0WE+XG7HwZnlhRwIGqBAS0mS4Uv0/sUSGlCXpDgjHgE8r7aHXiJ1A/oprFnH1tD6TTaOXQ0/bHnbA7jWWmRQUrDWsTLqR0RCnHEekMy+menTR6hltJIkdfk2bw+pEdoT9+Yrs/ONhWQxz5UrSe5WwqJO20ktT/namX9qCbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvoj0UPxl5sV1BKedq5MB5ya7NKN4pwFxxf9skzqc5A=;
 b=fRAELXzYpnbCo7qdLnST2p6fw9QAzWJJ3pHGCDDfJtQ4RbYkzJvQg/W5jugk3cNsP8afARLtjTSLbmeXSQ2Rts0brdR4953pbSbnj7kFTI0e9pfTiZKHZUhmqAcC0PjIP1S0TQ6AEEKXipQdbSE/vInn/jIkFYI0B7/bCchozDU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3837.namprd12.prod.outlook.com (2603:10b6:208:166::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 13:01:18 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 13:01:17 +0000
Subject: Re: [PATCH 02/25] dma-fence: prime lockdep annotations
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=c3=b6m?= <thomas.hellstrom@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        amd-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20200707201229.472834-1-daniel.vetter@ffwll.ch>
 <20200707201229.472834-3-daniel.vetter@ffwll.ch>
 <20200709080911.GP3278063@phenom.ffwll.local>
 <20200710124357.GB23821@mellanox.com>
 <5c163d74-4a28-1d74-be86-099b4729a2e0@amd.com>
 <20200710125453.GC23821@mellanox.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4f4a2cf7-f505-8494-1461-bd467870481e@amd.com>
Date:   Fri, 10 Jul 2020 15:01:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200710125453.GC23821@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0112.eurprd05.prod.outlook.com
 (2603:10a6:207:2::14) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR05CA0112.eurprd05.prod.outlook.com (2603:10a6:207:2::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Fri, 10 Jul 2020 13:01:15 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 654f8270-9a84-4446-88d7-08d824d15574
X-MS-TrafficTypeDiagnostic: MN2PR12MB3837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3837B2385A43A1D20210668F83650@MN2PR12MB3837.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xRLiOYHxG5vTItW5egYmGcyj2/QGyI/CtGDYhznnJ7R+Ntr6izpVJGlvR2P5oHalT33iFcyv6YGRb2WmeJpjZQ5I9z1OJ9w7X8cLtBVD6HBh1cPUKxD2YVSQE0LxnfdaByHrLlGKePgoYk5aLhNJAi/hYVAOUtaZcLDniru2cWZ4XbfoxA+pK77voQkO16Jp0ws7LPv89gBoRszWMaMZ++2mqF+TShGO+MIQ/77L1zVeqMewzntInmm/7VzlHcPmx1WfL4x+sap0Z7SM5jWgXLJKSlB0VdrNqG2UFmJAOU9TF/Q+3O6d6PGEMCImX/T0lMdjCR6HuPDApZrqdqXJHhqkr5f8qTymcd11j6z2STYzY+jlX+beKCz6l7Bv7gf7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(31696002)(86362001)(5660300002)(186003)(2906002)(52116002)(31686004)(6486002)(54906003)(6666004)(6916009)(16526019)(83380400001)(66556008)(66946007)(36756003)(316002)(478600001)(4326008)(7416002)(66574015)(8936002)(8676002)(2616005)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Cp/XSdTj4fK0jBEt08abf2CDWwk/t//b6f9CU9BkqlDdICPd/8+QeMo30jSK3XW+ZWMRu2HlyjHQYolwSukXWY/5pTgyhZ9wjEuQ//evrWRgws1MXibgHuGF2qEbf3tZVWFBObiukkm9SrxKl+o8RN5hfq6TfWOjlxDTyb8W/M/5LPadF4m5GsPnBf4Sn/CEMjXKTl4BY/x98q++otSIneHE3u/UjQ15Iw/eiZhJ20pW5ClvxZgRVUClZ+o4ySL5ABP6P/QS2BHkU1MWXfYSihv2c7rgwhL7HSUzPNVCFkIEkNmzVbL8xSNQAAT6Tdc7P8LaGYMBCj3rzYnsCKyAn32pM8ooURKAUcdMiQsK+i5LzxVgajHwZsQU6LDtu9VSZqnPPeQa306sdXe/+dUvI0xCDPgcfNsN5pKxV723OzkPslEE26SbO0dNKIjJaSP1Lh9x3kmdAunHvP+qwvkZ2ZPWm2PYMPuBLIVj9wbfTKuk716/HKE934Mf4xoTmtxkr2BXYtOVpmZVbvVmnmsy5nhxFLBA4UPixetKQp25luyXPYckWV0nj9s3p7k5EW7B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 654f8270-9a84-4446-88d7-08d824d15574
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:01:17.7848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdzPPeSxnFTZhRMskH2h0e3xvWnqWdX/cpk660JRGnCwVgVSA5HIezqnQF9Rag7X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3837
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 10.07.20 um 14:54 schrieb Jason Gunthorpe:
> On Fri, Jul 10, 2020 at 02:48:16PM +0200, Christian König wrote:
>> Am 10.07.20 um 14:43 schrieb Jason Gunthorpe:
>>> On Thu, Jul 09, 2020 at 10:09:11AM +0200, Daniel Vetter wrote:
>>>> Hi Jason,
>>>>
>>>> Below the paragraph I've added after our discussions around dma-fences
>>>> outside of drivers/gpu. Good enough for an ack on this, or want something
>>>> changed?
>>>>
>>>> Thanks, Daniel
>>>>
>>>>> + * Note that only GPU drivers have a reasonable excuse for both requiring
>>>>> + * &mmu_interval_notifier and &shrinker callbacks at the same time as having to
>>>>> + * track asynchronous compute work using &dma_fence. No driver outside of
>>>>> + * drivers/gpu should ever call dma_fence_wait() in such contexts.
>>> I was hoping we'd get to 'no driver outside GPU should even use
>>> dma_fence()'
>> My last status was that V4L could come use dma_fences as well.
> I'm sure lots of places *could* use it, but I think I understood that
> it is a bad idea unless you have to fit into the DRM uAPI?

It would be a bit questionable if you use the container objects we came 
up with in the DRM subsystem outside of it.

But using the dma_fence itself makes sense for everything which could do 
async DMA in general.

> You are better to do something contained in the single driver where
> locking can be analyzed.
>
>> I'm not 100% sure, but wouldn't MMU notifier + dma_fence be a valid use case
>> for things like custom FPGA interfaces as well?
> I don't think we should expand the list of drivers that use this
> technique.
> Drivers that can't suspend should pin memory, not use blocked
> notifiers to created pinned memory.

Agreed totally, it's a complete pain to maintain even for the GPU drivers.

Unfortunately that doesn't change users from requesting it. So I'm 
pretty sure we are going to see more of this.

Christian.

>
> Jason

