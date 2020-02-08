Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B51315647C
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Feb 2020 14:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBHNLP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Feb 2020 08:11:15 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:6191
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727118AbgBHNLP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 8 Feb 2020 08:11:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbdqEKBqelBKx8uYTV5w1fWA2l4Of+J0xqTmczjh4CzXKPiiWnC3Vd0Eic0ivQ9X1RGH4B+LPhtgrOTFa5m/M0IhbKewS1EPwyFqsek8m2illAHFcfd5t9iVtA+eqZi44dhnUKdQOH46/fPVWlVxvguUEiZzqS5BwcT6YG/HXrfFFoRpg2kZWGKzTzfw9Nq3TCvtKVrFpgz9B8nR0RcaYzChBvBWvSnAQl7Qw2DtQcbiI+OUYoiP3mhnHztP8c+BYZbR0hXrerUsbCU/asF8us3/SMsZsM2/gUTVnFVU1pxnGvm/tfTxYsBBotN0gmznd2rkRzcYXqsJ78SC6eiwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URA3bN9q/RTVirzvibU6Z/szJv1VZ99Xt62gKsiYGwA=;
 b=Cqu/DX8qWTLJudDIK4Ux4InZTjuLb+TgHOx77yyCieIHlbc95bHf+TQcLzzZdVGrZ4GObwtwUUe2z5aCyAD0X0+RY4fjOYohy+0X72dbM0unoLuFEzuotzEVT7TOHsDgs7d5124L+k60wShQ9NJXSLZf3ZG9Zu9h+ShM3ADFsibWt/Q6cefqWzk09Ct6XwNjMUcGJisa/LZ5gdI2AjRuw/kAJ9GTz7Bh/S0kmrXr2rRZ1C3y3g4AFPuj6B/jRg+iq+ejtlYiUltqADqVPMB0BrqVmtkSUx1N4jGegn3Vc0Ebypc6khhrldVA/O5XCbsTX+q3md4WX0xdtR55PbqJQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URA3bN9q/RTVirzvibU6Z/szJv1VZ99Xt62gKsiYGwA=;
 b=NYlrtpoMyyD7qFaI31JxA/K2neAd0DCGe4iejy76oyV9HDf+z2nX89bVFnl0NKlwd7MaMl1iQYETNl0dFXXHnfpwnEkYCkZzdWBI/m46rH8SLChMHEHPxDexILje4wwpauFOtP9J8KLoqH7z2tP1ey/itNBJdHbhmu6cx5lKaMk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB2343.namprd12.prod.outlook.com (52.132.140.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Sat, 8 Feb 2020 13:11:06 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2707.027; Sat, 8 Feb 2020
 13:11:06 +0000
Subject: Re: [LSF/MM TOPIC] get_user_pages() for PCI BAR Memory
To:     Jason Gunthorpe <jgg@mellanox.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Stephen Bates <sbates@raithlin.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ira Weiny <iweiny@intel.com>, Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Don Dutile <ddutile@redhat.com>
References: <20200207182457.GM23346@mellanox.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <20e3149e-4240-13e7-d16e-3975cfbe4d38@amd.com>
Date:   Sat, 8 Feb 2020 14:10:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200207182457.GM23346@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17)
 To DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FRYP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Sat, 8 Feb 2020 13:11:03 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9046224d-7e34-4315-7f4f-08d7ac985b79
X-MS-TrafficTypeDiagnostic: DM5PR12MB2343:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2343003CF1A9FA9DF30BA5F5831F0@DM5PR12MB2343.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03077579FF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(6666004)(4326008)(16526019)(966005)(186003)(316002)(2616005)(5660300002)(54906003)(7416002)(36756003)(66946007)(66476007)(66556008)(478600001)(66574012)(45080400002)(31686004)(81166006)(81156014)(8676002)(8936002)(2906002)(86362001)(52116002)(6486002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2343;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiJHhH7vbe78GtDcgK2UYP0z6SoEbxCIm/yz81L7H6l5wsraHDvWlmCIQeDg7jzTeL+vHAVTHNkOUSb3jKFGQ+JHsOgJL/mMvU4wVfPrYOTVQaX2FsF1fLwPSOlSTQaPOZdbsae8fv/AxekC47c1vmiD9KdBZxEG9fCx5f8v58zsvRK50rWCJHWS+bYcIh/eWIeJdYTumohvVSgK7Fkv40APk8F+otvG/+49L902/vzXUXVAFvXosVVU8se7+KMaLX6wARoCD70cBONhHcUn4/w0HvMKVluA4u/0/kLDPgZVRa+zUDqxWgl/CIpCexK8FtjaSt7ub0My003ZWZ0stSyOHx6yAXTUdhPE+kDjVZhBDAc9LmhifAfn2ASmapV3VQBIl6SialO2x719cHN0pD+OCXoRPeE2wXTPzczrO/EUkA5uXAR6ZGZPdhgogH50IKYHbCfCyNkDeEpvBb3JiYqO9v52qPZGoxGoVj6nazyKm1yCVUZ24/SamCatWzorOaOE7cCcGUis3wxOxjcVzEchdlb6MtmiRAHNSNFJeJgcsHgUl3dr9M+C+D8ep89EbGhOedPnkjTjnPQdlvfZZQ==
X-MS-Exchange-AntiSpam-MessageData: 2iSPJMaOzHOVEWMGBhVsn2F1I7Ur/+Nyubaeot+cHT61a9CIaR1x7kKYEfCfZiyYuo2QqrQvNFLAKZCYxj2edx1nVfYk1fZ2Zq9d1/3lFAtzR5/HjeWgRAb0TK85vPFXrTs24LHjGqVm4bOT442en3uaMyiTO4etvizgGIRP5JFmOyNqbLyDUk7ShB6MlrtufrqihEkyY2hKwflDVXzCAA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9046224d-7e34-4315-7f4f-08d7ac985b79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2020 13:11:06.7239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vZu4thHHnFVuDg0u0ECJ3GGbrz2Zs+gke96T2ZR8sKwISNfyQvKdOG8hqNWS3sF/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2343
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Am 07.02.20 um 19:24 schrieb Jason Gunthorpe:
> Many systems can now support direct DMA between two PCI devices, for
> instance between a RDMA NIC and a NVMe CMB, or a RDMA NIC and GPU
> graphics memory. In many system architectures this peer-to-peer PCI-E
> DMA transfer is critical to achieving performance as there is simply
> not enough system memory/PCI-E bandwidth for data traffic to go
> through the CPU socket.
>
> For many years various out of tree solutions have existed to serve
> this need. Recently some components have been accpeted into mainline,
> such as the p2pdma system, which allows co-operating drivers to setup
> P2P DMA transfers at the PCI level. This has allowed some kernel P2P
> DMA transfers related to NVMe CMB and RDMA to become supported.
>
> A major next step is to enable P2P transfers under userspace
> control. This is a very broad topic, but for this session I propose to
> focus on initial cases of supporting drivers can setup a P2P transfer
> from a PCI BAR page mmap'd to userspace. This is the basic starting
> point for future discussions on how to adapt get_user_pages() IO paths
> (ie O_DIRECT, net zero copy TX, RDMA, etc) to support PCI BAR memory.
>
> As all current drivers doing DMA from user space must go through
> get_user_pages() (or its new sibling hmm_range_fault()), some
> extension of the get_user_pages() API is needed to allow drivers
> supporting P2P to see the pages.
>
> get_user_pages() will require some 'struct page' and 'struct
> vm_area_struct' representation of the BAR memory beyond what today's
> io_remap_pfn_range()/etc produces.
>
> This topic has been discussed in small groups in various conferences
> over the last year, (plumbers, ALPSS, LSF/MM 2019, etc). Having a
> larger group together would be productive, especially as the direction
> has a notable impact on the general mm.
>
> For patch sets, we've seen a number of attempts so far, but little has
> been merged yet. Common elements of past discussions have been:
>   - Building struct page for BAR memory
>   - Stuffing BAR memory into scatter/gather lists, bios and skbs
>   - DMA mapping BAR memory
>   - Referencing BAR memory without a struct page
>   - Managing lifetime of BAR memory across multiple drivers

I can only repeat Jérôme that this most likely will never work correctly 
with get_user_pages().

One of the main issues is that if you want to cover all use cases you 
also need to take into account P2P operations which are hidden from the CPU.

E.g. you have memory which is not even CPU addressable, but can be 
shared between GPUs using XGMI, NVLink, SLI etc....

Since you can't get a struct page for something the CPU can't even have 
an address for the whole idea of using get_user_pages() fails from the 
very beginning.

That's also the reason why for GPUs we opted to use DMA-buf based 
sharing of buffers between drivers instead.

So we need to figure out how express DMA addresses outside of the CPU 
address space first before we can even think about something like 
extending get_user_pages() for P2P in an HMM scenario.

Regards,
Christian.

>
> Based on past work, the people in the CC list would be recommended
> participants:
>
>   Christian König <christian.koenig@amd.com>
>   Daniel Vetter <daniel.vetter@ffwll.ch>
>   Logan Gunthorpe <logang@deltatee.com>
>   Stephen Bates <sbates@raithlin.com>
>   Jérôme Glisse <jglisse@redhat.com>
>   Ira Weiny <iweiny@intel.com>
>   Christoph Hellwig <hch@lst.de>
>   John Hubbard <jhubbard@nvidia.com>
>   Ralph Campbell <rcampbell@nvidia.com>
>   Dan Williams <dan.j.williams@intel.com>
>   Don Dutile <ddutile@redhat.com>
>
> Regards,
> Jason
>
> Description of the p2pdma work:
>   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flwn.net%2FArticles%2F767281%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C942df05e20d14566df3708d7abfb0dbb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637166967083315894&amp;sdata=j5YBrBF2zIjn0oZwbBn5%2BYabv8uWaawwtkVIWnO2GPs%3D&amp;reserved=0
>
> Discussion slot at Plumbers:
>   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flinuxplumbersconf.org%2Fevent%2F4%2Fcontributions%2F369%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C942df05e20d14566df3708d7abfb0dbb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637166967083325894&amp;sdata=TbXLNXBDExHiViEE%2FYRpavsJ%2Fd68KOfg8xp%2BKk1ZJJU%3D&amp;reserved=0
>
> DRM work on DMABUF as a user facing object for P2P:
>   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg32469.html&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C942df05e20d14566df3708d7abfb0dbb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637166967083325894&amp;sdata=LBVbNR5bsknqL4MQf9RUyh7TDD9nD6yR5KJvKx5STds%3D&amp;reserved=0

