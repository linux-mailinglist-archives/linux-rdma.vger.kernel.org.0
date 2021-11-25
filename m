Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88945DFE9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349696AbhKYRnu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:43:50 -0500
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:65152
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232137AbhKYRlr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:41:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihjhy0L+MdfI+cGLzC0Pj+rnauMFvfA94A0ipdvSaPPgc2n4Geh3Fki6FDtEOMxEZhK2UhGTLXeeM/zSDQYYIgoaFqTQfVWuuS7msRv2KU3mqXox5cSrMmi5175Km4doQ2ndGdULbpcnbHfXdXUVlIScGzRzPQ4Gv9US1fZCK2r0uieegt3R3vhLjZnE/ejSJi2zIlxspzRZZLZt6YTtCxhbfQlY4tOTsnZp3q5Wm4y4U51IKGh4wOlaenZ34uD7lX19K+OQc7VnOehqYP8dV79nrGahZiTYwGBgrv59HxXmXqBYu0CNicUXhq0VC1ZUgIxnavkquGVSo2is6JFOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUplnGMHltB+V1aFYc9sj0Dhd0a6q8cPQftyihfbIWs=;
 b=ng97U06nrFg79HKC6ZzVCOCiNEwOr1HlzCqcrPMhdjrvqDZSGD1VfAAjwRvJwXmHFv+8881nmLK8PetLCy93JyguCIfETRVoNrJHfUWQ3wcr1RAY86WhblY26AqLJzx6b+QF3rWzbWo/d1siJskvZQua31qGRxXfQi8dbv8/xcgTJ6FmvcfDwJpQWzZIsP90NXT9njwr9+OPWn+iPQnKsRtGKRIKh2lC/nHFwloHz21d+vyq80kH2R8ov1VcAoZ69lnYlo9gnmXdkao47o8IW2pqGgqQs6mapWCBzVWok3Rj2AFcEMD6y6BgkVaDuX7XHenNeRnFmVqcbwCgHE275Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUplnGMHltB+V1aFYc9sj0Dhd0a6q8cPQftyihfbIWs=;
 b=h7WBgr2wHUuh9IZmS1VX+V72WtX6ilsMucsYJd5RXae+l3+k2pHZgTFnVQ+1+KMDs/taat5jEPNJAK5ubzekTvMozYS5KmlmFrBEUKeOUPil7savICbyX0v5zSvYH9DSNbfFiCadfxLSACbXvpx3lOElK8NI/phHKex5M7W1L+Xs66FE16xlF5+HweuqilX4KgfzJiNBWL76nqVxWNce3wCfqkkbF7rZG8FnYLks7ENRlxBJb5rMFGUopwxJ2IZ0hm9LaI7J/ovzFTX8np4Oubzs5R//pjfgam+boaCuE8lswJ6xzOHIzXB5s4BwOzMAldKY/1myk35mt0CKaNVJcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 25 Nov
 2021 17:37:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:37:42 +0000
Date:   Thu, 25 Nov 2021 13:37:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next] RDMA/siw: Use helper function to set
 sys_image_guid
Message-ID: <20211125173741.GC504001@nvidia.com>
References: <20211124102336.427637-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124102336.427637-1-kamalheib1@gmail.com>
X-ClientProxiedBy: BL1PR13CA0142.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0142.namprd13.prod.outlook.com (2603:10b6:208:2bb::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.13 via Frontend Transport; Thu, 25 Nov 2021 17:37:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIgn-00278p-T5; Thu, 25 Nov 2021 13:37:41 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc5c38b6-d541-4f2c-1816-08d9b03a48e0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53497C1B43BB9F801D3F6FE3C2629@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZGvUilkrJpZEKTGyw2e2sqvDHRWp3EtyhpvW4ufn7Puqs1ZAmnR1TrNzD0X0YV5Oz46/xEPel9PzGn6+1jbWQFi2IWGLwLMQQ/oEZf8NSFHRHXjwQl8h034YwPHOhiLOBOrCe9pnHUysHI59lIDREWZSmrCGZ7D90O+X8sNkRp/lg4Co/d1Vrl6uWPkeC0S//fohIagn1algvRsy7ff5IO3E5XROZvRORjVgOUlx7JziTQn2a2Ws1VH7po0JpdP4rYT3HNcp/b25btZHiDeFphQZHqGvHd3vwQrZynVnkh0LT/qoL4zDxH3Ej7tEeoXE2ecSFWe27kDzyScPk+nRIPdr5Fzy8B9uq4zD0bVXILiHvrNi+IAF2R+jlXtm6kSBi68hYsNpCInp7hpDLrNQ3p5nxzcrTYZIPPP6tD6iuRCxPAJM4r8FlVDfpDchGGvSZov66Cuv5HdIBgMYulUYzzdMgT98jLxsxj+7WS06ecYW6E+kj3UM95bkd7aJw7iDeYNs8Gt0jBCahNo6JJ5aFWQGZ+8uPuLqfCzYQSZDmu6/ztUqlKbX4QgR0mpM9mFTkfXvGMLLz4TglaDpSQGoITrlaT6Kgk68LmPYih0rWrjYKcV3jnlHRZLqA4Zs/NCLSFgKbFPBuIt381xkI9p50AB6ndf0x0i5XIR8rgTkFD0cnQKRVFRFbq6MOmASx/wyKObKmDgTmmkxCtfNLi71Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66556008)(4744005)(66946007)(316002)(2906002)(36756003)(83380400001)(66476007)(2616005)(1076003)(4326008)(426003)(33656002)(8676002)(508600001)(8936002)(5660300002)(38100700002)(26005)(186003)(9746002)(9786002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ynJuS8rkQRgY4noazW4UnKiN3vdYLeciochiCz5MoRS8+wvywI0o0WoHviwY?=
 =?us-ascii?Q?SvCWBDeZ3DcMpjhm3sMyaiCn0uluAcExmR/y4yyFHx/YssNUYBHOWwRN0Th4?=
 =?us-ascii?Q?rDMRm3AUGqbOv/MY9Q/7ZhWtq0sGcnWxp+WnqEP+tIwpanRrjq0421lsJxqc?=
 =?us-ascii?Q?eIbjVRv4rpEsQg6WACHRV5CHbo7tK7CE0WG5Pt4m1PPMf6jCZoGTws8K27W3?=
 =?us-ascii?Q?/LU7bCGGh3Ep0fl4hqyutIYf7Naz9MHhkX/SZXyzLjadny5IdYnmSGYozqco?=
 =?us-ascii?Q?zEUQSzEYCXoW6lpN5m53jAMWh+ZNv1qjGKkHWtBMt/KQONw12sfBnJ0d+pFG?=
 =?us-ascii?Q?Q7xAy0DAg9fOsdaFeIfaSwSN3LKb2NP2jIbOLRh4G4TQBCkP4DkUycnOty86?=
 =?us-ascii?Q?FJpTPYrT5/wn/qpymb8JDC+VjjHTT1I5gby+awynxbfI9u6Vm743YO/Njj5N?=
 =?us-ascii?Q?1bBVXZXWpFuYqKAq4Vu8nYWM9wKtdx5F6wd5uFqffRwx6BaucOfVn4aHskd5?=
 =?us-ascii?Q?TcIh84d+8nQ0ItP4w4X8T21lotkTTihhm5nTqvAVtq7913zo5c3ATCzB+0ug?=
 =?us-ascii?Q?3kJtjiCx4qGvNHt+mdcYAz83DOgA3iZ6ozGfMTAZMGecJDPNmkutU/16S9WS?=
 =?us-ascii?Q?QgR0noDOX4L4CjfowE1mhjyTFfsmWcokmxaWlHpz/DmCT9caTWajdcQ972+Z?=
 =?us-ascii?Q?V79zqPytPu8leeRrlQsEObsGp/X+kLoyVzf9MKogWOIDXmJZJg0t/VllSBxf?=
 =?us-ascii?Q?rB8j1jWjBDFi/GqBEes8ufwIJeAcm1C6CnN+CCZUM869BIrjaeBRcVQ/o8B2?=
 =?us-ascii?Q?KQqY/VEUTa1di2dkDczaV23x+AtuKhsOVnx9A/QH95BnC8DqZdhil71OYzrM?=
 =?us-ascii?Q?WgygbiwTlmsm/pSKhC5Ax3jYRmBgYT0NaWeMcj0liFu0795uyOf8m/JbICj5?=
 =?us-ascii?Q?hMpsovMV0aWnmHuanSjg2fVLEOpYo7GXQNtTAzR1NqIArVal21b2Y6oSf4nx?=
 =?us-ascii?Q?y2CbogtId3wqp9uL7dB08mwMq9ATN5U7gLvhDTgUNdCNlfdT9IrAg5pNN639?=
 =?us-ascii?Q?unxgPOUdQ1W6kzpHTByuUfvVrLxZpzyEBRUyJmiV4PiMMHRRwmHt4+1sCsTt?=
 =?us-ascii?Q?cAdj6YlRGv6+8j5R6t01zGyt2EKkQY1g/wcSIuTrhoYs9389lr/Z36/+QwFu?=
 =?us-ascii?Q?5LWG856NqZqNBi8/R2/Q9owvIMx1/wKZpo4Nwlg5u7+PRMCDdpr//7bURCjo?=
 =?us-ascii?Q?lZxS7JqIb72OxK67OPD5aojHwnsxL9qlkMfb/P8EO16NeAjRwiwzpa3aVqCf?=
 =?us-ascii?Q?1OGcQlZTqOn4Pyjs4RpaKjDdVUnDJvMHAdG/4A5OIUTaSGrR3rERajCJh1up?=
 =?us-ascii?Q?8dHJPJKL6QkIG/M4wJE0/wHeGBdPMv9CtiCZ1FFr1gSSw4k9jEwUZPj/REON?=
 =?us-ascii?Q?Lwu25o6vnhST8W+GXEB0TKjPa7lkPY3hZN41hLkzydeWaKiFSxTgsYtjcGkH?=
 =?us-ascii?Q?Fy4ZeNiwlnO1UmeLpfq2xGU7uxxDaT0w23DALIz6+h3OgeBkm8a9e/1BDbc3?=
 =?us-ascii?Q?F0XgUUHa7vcuXElhpIY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5c38b6-d541-4f2c-1816-08d9b03a48e0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:37:42.8366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdhoA8fd7EptZN8JqvFXFR2JbKHeUguJS6G/yqlUA/3h6sby2189NjAy0GeAh5ih
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 24, 2021 at 12:23:36PM +0200, Kamal Heib wrote:
> Use the addrconf_addr_eui48() helper function to set the sys_image_guid,
> Also make sure the GUID is valid EUI-64 identifier.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Acked-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_verbs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
