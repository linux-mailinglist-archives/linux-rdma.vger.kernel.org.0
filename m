Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD72548D3
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgH0POS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Aug 2020 11:14:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:51965 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgH0Ljg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Aug 2020 07:39:36 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f479b750000>; Thu, 27 Aug 2020 19:39:33 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Thu, 27 Aug 2020 04:39:33 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Thu, 27 Aug 2020 04:39:33 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 11:39:28 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 27 Aug 2020 11:39:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCsGPGAbKMNSejwl5W3isd304ANkzU2S1CneY5OI3ZH+zjgJWGJXGzjfWVVM7J2t+Ro8wiGVhOAW0Xo1toNuhMM5RxtyDNLBxGr9MBd7YDyUcx93aknPL0gMhCtDMFLEXhC5nZVOn/MrUpA4JGpey2hNYqsbgjQEoj+QbenLn682+g3RS9MGzeqCwRLojDIXs7VWsG00rkGzFuOTBIe/2a1FzhWsU+03YqcqmHcK8RJKIRkrqpcYbWrykKTTlw1Da2OIat1hYYWfTyh/TZLrpzG37IJp5iH+FElAL4aX3P7uKL0G8y2tpJsYvzbrS+RDJcQxqQUaLBQxh3Q/qHwWtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8wBb5baUKGgkuBGhqaz28Q1+BSi22yNsWcWrZsLHkQ=;
 b=k0Yb3juy67HlPCeB0NWI74HZE41nGcT14GiXgKNQQ0O2YcvR82f02WRWnXDv5+B+BNoFxdsx95Rvf8MdEj4RC2JlW3C/7WDdxpkY3CiFluS6Nz8pwJtLx8GxJXsyTruhtzQPQfA4QZtZnj3kW54JC18RApya0o1u9CPExYeLm1mZC63LVcd53B088hXlrPsTXm6dwETPr0g1QfuD8nOzTXE+ec2ENy7mPzAkNe6pYturU7Qabe7OGoSz0ymqwhXCEG+0y4HTLaZRq5/k5ew/WH2d3WMEvAvnRIoa/4PS5ZiSjc5UMlRcbpbiaeFpbXmex8vodhK5/CLHWW6v5F4ZwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3514.namprd12.prod.outlook.com (2603:10b6:5:183::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 27 Aug
 2020 11:39:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.032; Thu, 27 Aug 2020
 11:39:26 +0000
Date:   Thu, 27 Aug 2020 08:39:25 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Roland Dreier <rolandd@cisco.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-next 00/14] Cleanup locking and events in ucma
Message-ID: <20200827113925.GA3996328@nvidia.com>
References: <20200818120526.702120-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200818120526.702120-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR19CA0071.namprd19.prod.outlook.com
 (2603:10b6:208:19b::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0071.namprd19.prod.outlook.com (2603:10b6:208:19b::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 11:39:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kBGFZ-00Glde-3I; Thu, 27 Aug 2020 08:39:25 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc2153a-5e7f-4ff6-cb4c-08d84a7dd9f1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35140FABF791591D77F7EBA5C2550@DM6PR12MB3514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYDlSwpzJFxwdwogK4pmAWcPjoggS0zk99gnROHMvQQj9/DOWyhhohC9Qo7L9MZqpYDcHg65fquN28MqjHwDcRIcE49xYzMXrCoWg7/4JGZxpkeJnUr2XnpOq3YPqfbVvwqtBOXChkBVZjBJ5T9u5v4I2HgxglE5ZTzDVU6mz3SMyudmZqTTBmpZndmEq1W7DSo30tjlu32gscEjZlgPGcPD7VuJRv9GGEvpbwKAy05DiSMzEfZlBS5XLw94MG4YAGmzqnFM7ocm+x6Xn0N6Ndgg/Nj3zyN6qbPlwfeTsKVU4DQJ2G9ggxVNYFzTVeKjU/cugM0+Ve5hjQ25HzqHGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(66476007)(186003)(8936002)(426003)(2616005)(26005)(86362001)(2906002)(8676002)(9786002)(9746002)(478600001)(54906003)(36756003)(1076003)(33656002)(83380400001)(316002)(4326008)(5660300002)(6916009)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: f3xMMWcvv8dogyXqYy9mbdOTi3npmYH1HiQybK8oJVzVl3tVSuImzIVA2GUWiwrul8ZBRD5+vqBQsLUT2jsBtunyghzc9cemGaMSZ0YTAvF2cXi0gIL3qfG8iX08tnpXzw+oU6OXj4DLqxfKnqINEK4He8GCnUHfiHmdrf+aVRfR8U80hJkARZRTlpT/EO3cfPrgJo6dKUBg+UEUbjfv0ssMtgZAHpiklrjkvGaya+gXw2zOfdHCP2BdD3T7/rU9EptaEdhi2OtSa+M/lHEmbUu90aZnfvgbmJ6dNEmqPO3VdkWiTx7VGKrF2ADz2Vh1aKLocghb4OC3wPexhOUjBR+kvJDdjCpb+wj0b+WACzuwwA5GrKl+Pt0jy/IZU1AuFKuQc4LDA0CClqiOe6P8y3m53Ps837lkwV7u7OKvRERehNTDTOSEXbS8wNa+EaWuR+IbOrjt08oG1QDaBRBqp3Zhrjn1Xtgl2O2FCxPcQKB/GMNLuVJUxQDP7FvADGD4NQC6b0stRsSDSv00gBk2SDhmz8qi7tzPjC46BdvKmry4UR0jWu/aYzipG/jOLaZWsRi4Y8Mv9FayvChApZfSXML9peaLF5KrMn3aKVt5D04WIGCNV133c37yZNE+IOl4HZIK26Zoz76ieXPF1Je+Sw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc2153a-5e7f-4ff6-cb4c-08d84a7dd9f1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 11:39:26.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l4FxKwtmeo4lyt/BwjOFs9nQmhCPjEqPFLZKs0H7xZSJI3MNJGeLVrrgymbBxlrZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3514
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598528373; bh=G8wBb5baUKGgkuBGhqaz28Q1+BSi22yNsWcWrZsLHkQ=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=VsK+9WZqqiP7uREvnTrss9vHn/oxC7qPZIau0NKY48NH0EUYv8N18ZJx2F82zY80h
         1UT2B+eXhEHyndnvfd5DD8qPRVsHT8t53G/L8Z2Bx35DUcxMndWXFS18nHeM+A+XS4
         2oeIcXwim4UymUQ5u4NOa9ZAmyH9Qd2HQvz7axThTe53NnbTVTnEZ9g/erBz8HhqUx
         4wGcqWWo/FXpI9EmcHCIJxH0XksUHQ9JReMDKLqN39H/Ld15sCHq5GiARvOHPsCVyA
         idQxvBe7PCtitwLPbyazIlO71N8sBVcudyd1biMOiycy+FXIjBryauDUZkhLkatbPw
         rjphKtm1F5zIQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 18, 2020 at 03:05:12PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> >From Jason:
> 
> Rework how the uevents for new connections are handled so all the locking
> ends up simpler and a work queue can be removed. This should also speed up
> destruction of ucma_context's as a flush_workqueue() was replaced with
> cancel_work_sync().
> 
> The simpler locking comes from narrowing what file->mut covers and moving
> other data to other locks, particularly by injecting the handler_mutex
> from the RDMA CM core as a construct available to ULPs. The handler_mutex
> directly prevents handlers from running without creating any ABBA locking
> problems.
> 
> Fix various error cases and data races caused by missing locking.
> 
> Thanks
> 
> Jason Gunthorpe (14):
>   RDMA/ucma: Fix refcount 0 incr in ucma_get_ctx()
>   RDMA/ucma: Remove unnecessary locking of file->ctx_list in close
>   RDMA/ucma: Consolidate the two destroy flows
>   RDMA/ucma: Fix error cases around ucma_alloc_ctx()
>   RDMA/ucma: Remove mc_list and rely on xarray
>   RDMA/cma: Add missing locking to rdma_accept()
>   RDMA/ucma: Do not use file->mut to lock destroying
>   RDMA/ucma: Fix the locking of ctx->file
>   RDMA/ucma: Fix locking for ctx->events_reported
>   RDMA/ucma: Add missing locking around rdma_leave_multicast()
>   RDMA/ucma: Change backlog into an atomic
>   RDMA/ucma: Narrow file->mut in ucma_event_handler()
>   RDMA/ucma: Rework how new connections are passed through event
>     delivery
>   RDMA/ucma: Remove closing and the close_wq

Applied to for-next

Jason
