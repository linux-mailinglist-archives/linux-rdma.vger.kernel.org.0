Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF353897DB
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 22:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhESU1q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 16:27:46 -0400
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:31617
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229379AbhESU1q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 16:27:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXioMTPGtTwPV9fLdCTLt2goC6yXST62jxqkhnTVdruaKCnglxjphERlLDkX/CTKToHFlQAtU0axANTuLJtLB/xEEg7F5Q0FWpheqNLSDDKdpGOPOPOswEWlxYCHzU7NXdOiNlts6TY+9HiUTCU2ExBxK5pzQzCZdje+++rqHH8pGAFZvqRQBgdg9frccOmcdLfjcTSbc51gm5qTktdhhLEPF+DbI2pqlkfsCe+DBio5apa6Sxf55LlLlXavV9iZOtmibt4LaPR5hi9RRx/S9DXy0BUbU50ABVTuvRu/d9shIwf6flfnDjB7iU6yhObPOfI171dzIg7Z9zWvdsgLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Uyj0To2996qmfdmLAsYQOuyrTHAzkvlvsNy87Qvp3s=;
 b=l5Y/5JzPS/GUWLJsDFsPGB/JL8jkQA3Dh5fWRdAUzI2TLHhflg0nrmMNISBxjpVOssqzPHyUBZ17FBfS8JfJKhRKoarjB5ins81vu5YQ2AoY8ThqJbzjzWn4mXrDt2Upl8sPPniPvc5gfl+hVIraGR9L2UjTcnba46UygQ3oXvq/xysGci2rAQcpIp1O/BsFKJaJhDZPxu2b24mOggPVRajSXlzWRqU7ZHT09p4sIPdMOtZepfW1QZRfBRqFd6Y5iT4qz7OA+y4Bw5/Ec6odSXqAZi9xJ8CZlh2X1Ynerswv+3oPwRTXqTEgM7sfYoo4P60CU2AxhlPRf3Rlr6ksPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Uyj0To2996qmfdmLAsYQOuyrTHAzkvlvsNy87Qvp3s=;
 b=S2YcmyLBusZtj8YOJ+USfaaCBQZ+mswwgAok6zUDPSwVZt2UIi7IUT++uWOKYdB1CMFCCEX/yUWDmZLxyxQn2w/xDZptSOOXdMzpAWC5fPz+MJq5tM5aT4S4gsmJkhfsS3BQJrRPke+t35XK8vSO4RBrGTiHoAWwTmjJYcOMOeNBiwC4yQbnv5/usr6sQyNB3n2dk+u2kzo53+PkAy1FXFFtfgXsAyfT20C4KodvQnLH9oKQrGDbzyWLNVoqn3Fto6AqQI+xGCa4UQOgWqxYK0OtAMXZvf1VDdWxocNzpkCZ1bXvi8T+OVXovSLXIatcDZWODHKRvLrmhJlJOuPEgA==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1338.namprd12.prod.outlook.com (2603:10b6:3:71::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 20:26:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 20:26:25 +0000
Date:   Wed, 19 May 2021 17:26:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <20210519202623.GU1002214@nvidia.com>
References: <4237ab8a-a851-ecdf-ec41-4e798a2da156@cornelisnetworks.com>
 <20210514130247.GA1002214@nvidia.com>
 <47acc7ec-a37f-fa20-ea67-b546c6050279@cornelisnetworks.com>
 <20210514143516.GG1002214@nvidia.com>
 <CH0PR01MB71533DE9DBEEAEC7C250F8F8F2509@CH0PR01MB7153.prod.exchangelabs.com>
 <20210514150237.GJ1002214@nvidia.com>
 <YKTDPm6j29jziSxT@unreal>
 <0b3cc247-b67b-6151-2a32-e4682ff9af22@cornelisnetworks.com>
 <20210519182941.GQ1002214@nvidia.com>
 <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ceb34ec-eafb-697e-672c-17f9febb2e82@cornelisnetworks.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:208:23b::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:208:23b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 20:26:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljSlr-00AtSM-VF; Wed, 19 May 2021 17:26:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc68aa2c-d227-44fb-5aa7-08d91b045fbf
X-MS-TrafficTypeDiagnostic: DM5PR12MB1338:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13380DC0AD6C50398CE822EFC22B9@DM5PR12MB1338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gnf1Itk52xXy4Hp9GzXvXwiVAypzA4ZBdjNL5ENQUXPNDvh1SE/PHskdcU20CeQMm50YAFG9dBAJMUVmpYeTOqvb02TcFO9TJk2eNEdhXF/JGo/M7pwF4R7m4x8Kk3d9SBlLQ4m+jAGUhpQVZpwLfo/cnkPdBJoi+z94/SgbD1qlucnaCzDYT0caoQod/bXEB6ykbMuNtSCeS8afREZmIGF/F/OZNMoMMpIaYK1MSJx1nJnQnB9NW/F1Yr8FwPpQ+Mw49PHXD2+YswZy0YpNpuXEeHjoS1KL9VGjotxn3DjZLml/l0RKPT/jbfPqoJNDxcDXH+4gnPAEu1NDzhpQw3mcqNUuPtxvvXrPIIObkXC4NR4PZTHygjRdnZ4Lpr10eLkkx5psZ1ybggLyRxszMrAvERpPEM9s/qiHmjfxvN64gm+5PX2fk3bqH7o3KM9BoBlki/IBff1NGGvnYnRNAYwhOFtLGDH31KIPmFQ3nNzKKw8siT+Ew9m/dh+duUg8zwDBue2mzQZfSYCVbVWil8A/stDtWnI438Vv89vGvzbY7Oh9vmTwaQ3M38QW48520jgivgT17Z4tMs65/lRgMx02knvmEbUwLseSRoQkYW8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(26005)(9786002)(2616005)(9746002)(6916009)(8676002)(426003)(186003)(8936002)(86362001)(53546011)(38100700002)(1076003)(54906003)(316002)(478600001)(66946007)(66556008)(66476007)(5660300002)(4326008)(36756003)(83380400001)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KoG9Vd9LUpA7ZEu4/odZPkDiPasSVK8VBkmZonBu+umDnRSfQNcIYr6rwLYp?=
 =?us-ascii?Q?i43SvBQoo6dSEqy6k9vCOSzd/aqhdTvnbLGDX4cxJSn5uSNPjzELv5SATNOB?=
 =?us-ascii?Q?zdnA/Bm8WaXrEO1kIP4TevIoW9v4dJwb2LaAr7DcEh2QAMArq1qqpHPBKr6g?=
 =?us-ascii?Q?5Bhp1iDDqdYhHacWchj2QvSM5YBjpExGKllNVD2eA+g9meUj2Iu045/Fvijf?=
 =?us-ascii?Q?NmOQYMexbPAMHMJ9EfOa0yMBFwkzJO5WFCNC6K/Yc7+BVFxR2Nc5e2aOZKTx?=
 =?us-ascii?Q?gRTUiH5anYiSdlNowTgjswqUigyZionb5CzE9JgLj9hD/CsQHfi/yMQhaiGb?=
 =?us-ascii?Q?XbgAtEUlO3bMlVSRiNHR93KQCxUWyfwHNHvQg4dpMfIp/nTF8lwRNhHiE5E7?=
 =?us-ascii?Q?TzZpUYvEs41ogr9zo3yjzHG7TKKl+CiB66FCNMwTvQSVYiL1DkDQT/sUvqSV?=
 =?us-ascii?Q?AmUtzUl7VQXOZVM/gZ677sO0nvqS3pN7cBUkGUUbTlrvP+cBRNCDfY9ggRvn?=
 =?us-ascii?Q?4K/hDOm0MqhJXEemYUfzvanq5L2UXJLx9lKlNt9bLA8tITGHEbyJwPn31CST?=
 =?us-ascii?Q?uNg1RlwRS9wHuHdBC9wMems39mHZtQHj0IP9SAQXoN9G+DYtq/C18k01Xqbf?=
 =?us-ascii?Q?SxZ8nLZPmx2IsskBjiisVeDfHRmBt1ow1myi7EuIaRyvu7fcx7ql+crpAlWJ?=
 =?us-ascii?Q?lq3ccDPUfK0A8YYoYqj64gSnKXPXp8ewYy0B18Vkr9foJmUHJtmyg3MySu7K?=
 =?us-ascii?Q?tLrewn6zrxPTjb/TxDjL0XNhpWSOS8gJhHvQ4EUIQhQlaznTHn2UhSAZf9Oi?=
 =?us-ascii?Q?cddpPGsmnUYo03P0p1MVMOq1ZiuiaUEKYqk3Y6kfZyx3KB4+7lHtXwbylD7b?=
 =?us-ascii?Q?djiig2pllihKzVXS7HdVmxUZXOLUek+3Hjt8HXwEj8ysFM2fhplG7tZVpzY0?=
 =?us-ascii?Q?gVHYe0kseRtyb5VqfAIyc0PnS/8Ts1xYVuDetyeT5WwMxLdOfXHDuaJZKBoF?=
 =?us-ascii?Q?ikUR8i+2EakEfiXkjEST5JfY/TU2z96WHOEViYik/EubUllqHzhsp6qs7rHK?=
 =?us-ascii?Q?qBLSkBNsmodYlLQwPD4/6EMFhLbhrtnrFwFPVplIYS+vdgu1ZjCW0qIM0UU3?=
 =?us-ascii?Q?XoZBQVrS/OJ3kDmctJPbL+VpJFlkenQ2hCXtGExlkQJrYQS2oUSM+Zyy/hh2?=
 =?us-ascii?Q?lxFpDlWQIo5V5f22d6kvgfD5wyXmzQlj8Vn+gpCH0SmcyZnbpIKu8p/iXGVW?=
 =?us-ascii?Q?nSFGjHZPEC4hpnBIDDmTvfH1W8k3to5+CtcRj+HcRTgrdkURBD7XqP1DxIy4?=
 =?us-ascii?Q?HAQPC13t/+QXK/8I6Fj7CABh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc68aa2c-d227-44fb-5aa7-08d91b045fbf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 20:26:25.1100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8L8p9ffqFtgMrj1LofsBk3cNnOoLUo932zj19dYbMnLx/3ZupUW89Az+5CgMGBHB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1338
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 03:49:31PM -0400, Dennis Dalessandro wrote:
> On 5/19/21 2:29 PM, Jason Gunthorpe wrote:
> > On Wed, May 19, 2021 at 07:56:32AM -0400, Dennis Dalessandro wrote:
> > 
> > > Perhaps the code can be enhanced to move more stuff into the driver's own
> > > structs as Jason points out, but that should happen first. For now I still
> > > don't understand why the core can't optionally make the allocation per node.
> > 
> > Because I think it is wrong in the general case to assign all
> > allocations to a single node?
> 
> If by general case you mean for all drivers, sure, totally agree. We aren't
> talking about all drivers though, just the particular case of rdmavt.

I think it is wrong for rdmavt too and your benchmarks have focused on
a specific case with process/thread affinities that can actually
benefit from it.

I don't want to encourage other drivers to do the same thing.

The correct thing to do today in 2021 is to use the standard NUMA
memory policy on already node-affine threads. The memory policy goes
into the kernel and normal non-_node allocations will obey it. When
combined with an appropriate node-affine HCA this will work as you are
expecting right now.

However you can't do anything like that while the kernel has the _node
annotations, that overrides the NUMA memory policy and breaks the
policy system!

The *only* reason to override the node behavior in the kernel is if
the kernel knows with high certainty that allocations are only going
to be touched by certain CPUs, such as because it knows that the
allocation is substantially for use in a CPU pinned irq/workqeueue or
accessed via DMA from a node affine DMA device.

None of these seem true for the QP struct.

Especially since for RDMA all of the above is highly situational. The
IRQ/WQ processing anything in RDMA should be tied to the comp_vector,
so without knowing that information you simply can't do anything
correct at allocation time. 

The idea of allocating every to the HW's node is simply not correct
design. I will grant you it may have made sense ages ago before the
NUMA stuff was more completed, but today it does not and you'd be
better to remove it all and use memory policy properly than insist we
keep it around forever.

Jason
