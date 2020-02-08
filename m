Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EF0156584
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2020 17:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBHQjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Feb 2020 11:39:04 -0500
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:6069
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727341AbgBHQjE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Feb 2020 11:39:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bELiVUCfqw7KxIAvY55orZTlyUfx/IHRHM017+XHhegLeGdW1JIEPmy0G4dV8Ru1K3C/8gRNo9WYRVtSvoBvsPCpSoE1h9r7eWs+klTYTmn9JmuMzTKL+n4Zi7J5HJLejbJq16yr36FnTDuXco90RKGq4l/GcG7GVHoB78ZTvl8oAaCPFKTpg95E4avtNxhBi3WUwgsN+J82T3korOytD6BYXfN+lCQ9si2jJFKPiBBqecrmpGs4MNUsEU41pgkRSjsrchbynYDCmG+dMGsEMYG0WIBgmp0ZiY0mcatad2WzJSpJSbYuZ+v8AI3qrv96OOQQOAzRcwx9szEiWf7hag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE3fwH6RDp4WjeB9sgFTyHyHEEuQU4t+C+bKbfzo4VU=;
 b=nZ50Td+Jml3bCSzsSTSid0wXSlSSK+/vo28dYJE7+jrd8dZ7hOxnMJHmuwaKJxboVgCN/E5Xk7wVrsP2MVTB34Aw3BTkpuo//bcd9/+T8zuYoAzNFEuagiU0RrW9eUaWRGXHXZ9Hhdh66Kw2MZ4M5bvz7ADtHSFxdC0IxOw+7aL4VduyJ7Mwp6DUJRAeJfHY2q5IibC3cEoDVDS77besc84ETRC8y4BQswxzbtOiZRlGWqu9EWVTsBxZwmc4bEh1eIUt1d+pQVRY944BnG7T6pY/p3+HZoXRMVqdMZHyP6I3PaBoIkDOA0WuBiWIQ0XnYU1ll7q2BE3MZKrHemSUUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CE3fwH6RDp4WjeB9sgFTyHyHEEuQU4t+C+bKbfzo4VU=;
 b=bYz2t58NGMT4TuWKCDg3XhqBXvfyxOpB0bXvkNtcmiom+ZCX/+k9d4AF6c8of+klZ7w+f/2ITwEOu+zpcvI1772L/tUnJg6qTedXk52pc9gId1qRXe4pHLKazuCHh0rXJkHDAThN6wvszmc1hmfyYeEsicpjii28OXy5iLmL/sA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2550.namprd12.prod.outlook.com (52.132.143.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Sat, 8 Feb 2020 16:38:58 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2707.027; Sat, 8 Feb 2020
 16:38:58 +0000
Subject: Re: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>
References: <20200207182457.GM23346@mellanox.com>
 <20e3149e-4240-13e7-d16e-3975cfbe4d38@amd.com>
 <20200208135405.GO23346@mellanox.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7a2792b1-3d9f-c921-28ac-8c2475684869@amd.com>
Date:   Sat, 8 Feb 2020 17:38:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200208135405.GO23346@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::20) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by ZR0P278CA0033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Sat, 8 Feb 2020 16:38:55 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 640d367c-a926-4cf4-59e1-08d7acb5653a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2550:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2550F8217B66B5967A17C72F831F0@DM5PR12MB2550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39850400004)(366004)(396003)(136003)(346002)(199004)(189003)(5660300002)(36756003)(66946007)(52116002)(2616005)(66476007)(8936002)(16526019)(6666004)(2906002)(4326008)(81166006)(66556008)(8676002)(186003)(81156014)(54906003)(66574012)(478600001)(316002)(7416002)(31696002)(86362001)(6916009)(31686004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2550;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VBuGduLug/BYj2PhFN6VgNP/ael/YjTiWfov1ia1kuzrU5RDl9KDyHq78wyHblI3ZZ6kWrqdgr9mcnYJE9qvfKVi1H500mBSMrbUJ44jg3a/2O0jK3l3+lh8yM1VxZNBvP2DnkRnRb2ADg5QsXXLzXttyDPQR5b8pityZRmH2IjJOk7/m2DvCr6E8plvSoMxF/0AqjUGfffQBAynxo/tEIkN8OoOtLMO0JFghbSNJBsr+00J5TFaD8t/vrb+z3b+ZKfwZEPmEpGO5Y7dyQwAnvo8bP6KoFyUxvEWxDg8GShfv3Bn2Xq6WqGItJL5s8RHTLYvcqgsEpESD7ua2Y1+dAFC12JH2ebSfn2SgdHKpoZrrWm/k6WR07NFUwuaWZ6R7HE1I+99C6kGophCeuzkSbyK8eNOOiSRyuw7dgghgg4hVSKcPGQ3js7SK7yY9Gf
X-MS-Exchange-AntiSpam-MessageData: 2FqLxrlS9IHuSRDf1HTuKZ4RR30r4lMU7bj0YjdWBfPm3cy0XCLWRVd+fwm+coxbZP1SKRPVJpqzYh+Et4iPDQFCkCbAyMr3V4ayooWQOqwPL+6wp6/CLOW0HLP+lSrx4zF9u+dnGyDuTbXlJhZn/2AcYDHthx/AON8XC7J6WiBPB5cRt4NwpTRdlToewIeTAD2iGGxiZvgg0kbcMulgZQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 640d367c-a926-4cf4-59e1-08d7acb5653a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 16:38:58.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pzsBSEKN1WsULxO4TZ+vyDIS2wpgaVax//rly2rJV8HTNuWTD74MxdhX5wbzMY4t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2550
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 08.02.20 um 14:54 schrieb Jason Gunthorpe:
> On Sat, Feb 08, 2020 at 02:10:59PM +0100, Christian König wrote:
>>> For patch sets, we've seen a number of attempts so far, but little has
>>> been merged yet. Common elements of past discussions have been:
>>>    - Building struct page for BAR memory
>>>    - Stuffing BAR memory into scatter/gather lists, bios and skbs
>>>    - DMA mapping BAR memory
>>>    - Referencing BAR memory without a struct page
>>>    - Managing lifetime of BAR memory across multiple drivers
>> I can only repeat Jérôme that this most likely will never work correctly
>> with get_user_pages().
> I suppose I'm using 'get_user_pages()' as something of a placeholder
> here to refer to the existing family of kernel DMA consumers that call
> get_user_pages to work on VMA backed process visible memory.
>
> We have to have something like get_user_pages() because the kernel
> call-sites are fundamentally only dealing with userspace VA. That is
> how their uAPIs are designed, and we want to keep them working.
>
> So, if something doesn't fit into get_user_pages(), ie because it
> doesn't have a VMA in the first place, then that is some other
> discussion. DMA buf seems like a pretty good answer.

Well we do have a VMA, but I strongly think that get_user_pages() is the 
wrong approach for the job.

What we should do instead is to grab the VMA for the addresses and then 
say through the vm_operations_struct: "Hello I'm driver X and want to do 
P2P with you. Who are you? What are your capabilities? Should we use 
PCIe or shortcut through some other interconnect? etc etc ect...".

>> E.g. you have memory which is not even CPU addressable, but can be shared
>> between GPUs using XGMI, NVLink, SLI etc....
> For this kind of memory if it is mapped into a VMA with
> DEVICE_PRIVATE, as Jerome has imagined, then it would be part of this
> discussion.

I think what Jerome had in mind with its P2P ideas around HMM was that 
we could do this with anonymous memory which was migrated to a GPU 
device. That turned out to be rather complicated because you would need 
to be able to figure out to which driver you need to talk to for the 
migrated address, which in turn wasn't related to the VMA in any way.

What you have here is probably a rather different use case since the 
whole VMA is belonging to a driver. That makes things quite a bit easier 
to handle.

>> So we need to figure out how express DMA addresses outside of the CPU
>> address space first before we can even think about something like extending
>> get_user_pages() for P2P in an HMM scenario.
> Why?

Because that's how get_user_pages() works. IIRC you call it with 
userspace address+length and get a filled struct pages and VMAs array in 
return.

When you don't have CPU addresses for you memory the whole idea of that 
interface falls apart. So I think we need to get away from 
get_user_pages() and work more high level here.

> This is discussion is not exclusively for GPU. We have many use
> cases that do not have CPU invisible memory to worry about, and I
> don't think defining how DMA mapping works for cpu-invisible
> interconnect overlaps with figuring out how to make get_user_pages
> work with existing ZONE_DEVICE memory types.
>
> ie the challenge here is how to deliver the required information to
> the p2pdma subsystem so a get_user_pages() call site can do a DMA map.
>
> Improving the p2pdma subsystem to handle more complex cases like CPU
> invisible memory and interconnect is a different topic, I think :)

Well you can of course ignore those, but P2P over PCIe is actually only 
a rather specific use case and I would say when we start to tackle this 
we should come up with something that works in all areas.

Regards,
Christian.

>
> Regards,
> Jason

