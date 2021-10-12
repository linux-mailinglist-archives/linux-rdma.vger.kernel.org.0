Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350CE42A959
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJLQ0w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 12:26:52 -0400
Received: from mail-bn1nam07on2086.outbound.protection.outlook.com ([40.107.212.86]:36098
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229495AbhJLQ0w (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 12:26:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2G7RoxDl3LHJWVAGLNUzIE779yRwDB5XZD1q6E8XzK6Rv3FmQqZtoW4FjdOr+X73SiCV09f85aunuUM1EpZ0x69wZ5AUJnpx+ze54AqOgn5VrP8IKQ5KHuMYSVNxPEOX3DLs5tsxbX8Y7AmPSlPUOI02n58rty5TwtFLnFi6BlqpSZUpOUyDp5pBtD8eUPvdxtdshX9mzPvt2FE4oG1xeSawCqTPq7qeMU3K1MgoRzFGg4Oz2KY1lnD/dmqMYr+rmaynGXuxb70jZe6ZBo93Lbvy6NLkHChpAsBI+INeA1M1pqSe1aIEZqXMfCZUfy/ZMGQe8VRJo9nZcVQ04SWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1wU9mUT3ZTWK9uSEqHEcnYzqWbPPb0fuw5NVx0RtpI=;
 b=EOwMO2J9aPP9qcIlq+QGA+CEyQq7m9RSVzWgNKpVfShr0FlBFPXHzaixKvXHRVxx2WldAv4+nZsTjqdDSzMk9zH1bKIWx5sfOuysm812VgYqzDbFu/rbShMVD/B4rvhXBLSuQTTNPTtjY01GQbCszIGhLEgK70AsMa5HeTSm/X848I8vnM0Ik0yN+hXQCmuvaRlP93COvldGPMF11NW/HCyvQwA99gSjsN4j6Oj+y5wAElXLXX5AqU9aYrTGkB0Xa+kB6zZf3PaNPf+HvGWcviHYePLLch/w0z5Lr//Le7K4kmWbQ+x8RopZFPRqI/Rz+yfud2JOtMU2XshZsJcxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1wU9mUT3ZTWK9uSEqHEcnYzqWbPPb0fuw5NVx0RtpI=;
 b=SXjvmGnC3o72o+DwaL7S1vbg3uTjnr1Wx5P9XI5VTDbyBR3asK5wHC7mdZtHlF8at73StabzvQRfjso21kacw1s4aDhJ5DU9lEfpoQF329U5is8AXDkGeEjKJ8o9f7XpDUms/REeO6/MRBGisGMXKVxnPFd/agelOGrjdGwt3F/rAsc2ql5Gzzvf7LGapewWHKDKUWe8MnMpzigys7UzKcv9jw/I/WeCjrPZ1BUQ8zbrsebegMimnFEggFP3LfL+tiqjW/j6RK35pkyc1LByY8rIlgGwnu2ImjVwby78BWKhphH8A8kVXFXFVCKffjD1tBEnuR8ud3FmjW9tsItpSQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Tue, 12 Oct
 2021 16:24:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.014; Tue, 12 Oct 2021
 16:24:49 +0000
Date:   Tue, 12 Oct 2021 13:24:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA/mlx4: Return missed an error if device
 doesn't support steering
Message-ID: <20211012162448.GA3386147@nvidia.com>
References: <91c61f6e60eb0240f8bbc321fda7a1d2986dd03c.1634023677.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91c61f6e60eb0240f8bbc321fda7a1d2986dd03c.1634023677.git.leonro@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:208:32b::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:32b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Tue, 12 Oct 2021 16:24:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1maKa8-00ECuf-74; Tue, 12 Oct 2021 13:24:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35523d60-739e-4b5c-2ad9-08d98d9ccfbd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB504593435873F38D1C196A66C2B69@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iNMYZ01AzBYTF2J2jbW5uS7OArZB5LVsUmKCL8Q67bVinQsFqDrukMZOZBxIISGxDkI3rhb6zswxjkHRJSL4etEEQGqr234/Oql36d9y+cuTZvnUBztGF39UBk9l5b2BrnGkpkCazHJKMvbAiNpXkQpPiWBs6jBqVAhLSjuADO4n6b9tdGEzK+qo4XNK0pQEUY0RMoRetScKqRYTM7/lu01Ei2hGbN2yFSX5nTWIFquTEojvI4+I3zsEmO2Ew3qK0lBmAZOdWfOhe5eDFOQhbURZ9JQStruWPu3P+ZrpcTeI8kq4UEF3i5T8lu4pV4ajG37fF6WkDdjBfbQtwzxOxM6x6ANjfNvLYL7Mvrf2d8OhLIbAXgaM8FhvdHgH/Xdud7dNMd7Y1uBPha69L253jIgT27iC9oLsZJz0wIEarJF88jSod1onRY4qZIiUq1UHgPMwWVsfkhFzVJ3lj0pDjLMej2FGUThea6u6fK4iqyd548gbQOYd/LsyQqNbL+1seAc/h1Ufemh+uoLHKmA4vj3Oxakke9EfwyaA6ycWerCY+GTrjOuddf/9JgWxqud4EMvRcA0+WmQZhTFuKaHyqVqDvIpOwQ6tNzXkSd5ackx5+GS7jHyPX64Ei3jba/GYSuHVeyFDL8AnRaulf7XYdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(83380400001)(107886003)(36756003)(2616005)(186003)(33656002)(54906003)(426003)(8936002)(4326008)(9746002)(9786002)(316002)(26005)(8676002)(86362001)(1076003)(2906002)(6916009)(508600001)(66556008)(5660300002)(66946007)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tm1WKCO7DzTEiE+W1sAnh8QwlMlTTvzsxpdmTAPR6F4pmGPWGM++4BmkGSt9?=
 =?us-ascii?Q?s+yiRY4tgWT4uS6Ewxu0OS2njLPwp3fQD8KTzXhDk9HHJZVNX20DLdeuhnPK?=
 =?us-ascii?Q?bR3YM1kOs4U73agt7EMR3gg6yr+HQYUku61qcPQJIsRrFsqPyL8dkqBaBWhU?=
 =?us-ascii?Q?cem2mDIktGN2F81D1beNe4esHK6eTgTYUztUFu8+VFREEB/fRzbKPnnYRfL9?=
 =?us-ascii?Q?iQ1XZuv3cq5ChzhtoWxIhEN2ynG7T2Ap3Iqqy/TpHSlQdqL0Z/5VWL15v3z6?=
 =?us-ascii?Q?tIR9sHAeNPbAVfsbjoQ2PQSYLmDHQ06e0mhZw8SQmWA4n7tnwqJS95bNY9zg?=
 =?us-ascii?Q?GtGyDxYStBZZmxbj1W/LAOkSaIarb0tBIfO72b0Nvs9a/b88toV/eTZFLM7E?=
 =?us-ascii?Q?L/9ItW0X0lnPrO5lBgkZN9n6JYtVWARAA1X1DqJa69hQVyYb0adoqC9Crc5Q?=
 =?us-ascii?Q?M5iO7vqfR73T3wv4of5+fme3i/p1SIFD8GzQ+gJ0Cwfjmw5sh0f4e8Qh+0tq?=
 =?us-ascii?Q?Ss2h1aWjrzSarRgHK7omUSzAmsFd9uQlIB3V0m7e94yalW9VieLyq+dH6hxS?=
 =?us-ascii?Q?36EzEYWlCnZqmSY0M69qt6KG6cfV+OuT3WfgSW8j49LF6lTczdxsauPBVPql?=
 =?us-ascii?Q?AAQ65QXTPQs+KTK7vb3LLeKyQkyjKLd+oy2DbFpVkq8xrFixI0YaRVkyiqe3?=
 =?us-ascii?Q?DFNZ5zMWe0dZ94GPd/28kdOloKW9nfKGM0b7E//7yyZ78LkCSvCBhkHiLwcM?=
 =?us-ascii?Q?Y/RwjVQ/tIvIDkGJhPGMLoGcvTTkWiB3KCtmt9xyv2jl8lkogr+jbz2Ca5KF?=
 =?us-ascii?Q?1FX7aUwvQSYg6yl5Sg2L/mFlO7qv7iSCP6T3/RKRgcR1LIB3xV8rahIJc2Ba?=
 =?us-ascii?Q?moqNDPSFycJM0+V6FjUp1XqoI3aY4fCOAPrm+Woe01JNUZiJ/vdEpfX2qkMW?=
 =?us-ascii?Q?dhzrsR1gR16WHFTu0bRevXXISMItJMDXKuAQJ3DZz7WS3/6+OCg1IaaHLFcs?=
 =?us-ascii?Q?soZ0/oz3ZmTI3vW1vr3wgUI3O6RKxCqZfa6ogfFuL8r6FHWpDtVKBv/vwixg?=
 =?us-ascii?Q?9G0i62GSMWF1xK5PgiuSSDOtKexryPx/+rZcO7vbDmRYTmOjsSgzQRbISzKv?=
 =?us-ascii?Q?d9rIAcKEXZ2gq7y4OhQn3y3OEnpo1HCVM2JRLqAF1VhgX4x0BNo7FWNbjt0I?=
 =?us-ascii?Q?qkOqlYsrvwfYGtTGkkXNWHONdFFQr2tAOKA9VtNoMcSg4nnOruuMw885V0zd?=
 =?us-ascii?Q?Y7nBGTgWUoW0lci8zcXDfbzKXrEYMoXVh3cXRLQ7FzbajaWKLA11I83frl2B?=
 =?us-ascii?Q?1yqIKDAiPLvnGzu0uJFIelm8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35523d60-739e-4b5c-2ad9-08d98d9ccfbd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 16:24:49.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4J3chPO57PnbzN5AgHKYnq0HVLWVAGZcNyxGw9xx8Q7403AYHGVdaXtPIdzbPrl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 12, 2021 at 10:28:43AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The error flow fixed in this patch is not possible because all kernel
> users of create QP interface check that device supports steering before
> set IB_QP_CREATE_NETIF_QP flag.
> 
> Fixes: c1c98501121e ("IB/mlx4: Add support for steerable IB UD QPs")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx4/qp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
