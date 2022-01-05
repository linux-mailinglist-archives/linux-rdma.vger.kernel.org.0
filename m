Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D357C4858DF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 20:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbiAETG7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 14:06:59 -0500
Received: from mail-dm3nam07on2069.outbound.protection.outlook.com ([40.107.95.69]:3040
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243343AbiAETGj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 14:06:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPw/Y1kLboOS6ZUUHQpD9klbstDQpo5pSUQYyV2qvfu+k7rNmUhQs2GIlDKQKwTLBvJn1/F79z56m3VFKXMCYH7SLP/tuw6nNn5S6F+VOSrenhHU+6S3dIy22v/S1XX1p/E+RW+EV343WSCfcy7EsHeHsQu1UFlymjObY26bn+fGBOBf6MX6jBwAegjBwwXg/l1hi3Qg4yUPMUT6SYc/GBlVBNDnfTdLk7JW0XbY+PzDz7xyIWq70bK2K48CXwMiDhdsXK72RiKuryqB69hkXBOcHQrI7U+0y6l+uNSTW4bCcjyyGqFbCNNatcJJPNdwDsRqaMOo8lWm5qOqhFJp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9w9MbWwhj7AkL0EkVe1UlEi5NQZcn49ih4SKBVNPbw=;
 b=Crw2jEKwRJIX3VaBlOfnG4OH09gQmYaxefrQWj/auDYFoeI8PgHgOFsCVVtYq8okuZvbPm8gZRBUvJtc5LO2TQ5rtcLdJ/srS2tuEq3QzAOoQrFiV6dJVtl541k5cm1GfbV5zqMhkFb3NFU7iJoXG6VOWW9R7Pf25LEV8DO0c6eMJC5+IyAqZSiBxIZ00WTigycMzSo92jis2qEkK/5PMW/RR12f1B1LsTkDyzKkpJj2tibxYaH0qDEFksVjfYSyFc6k5bVkejHnEklGVUNgbNJi90mwlZheIDp905c57KJmvxEab0LqwaSHrJkc1N8Y3VAIls1/CX7vX3B4SbFqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9w9MbWwhj7AkL0EkVe1UlEi5NQZcn49ih4SKBVNPbw=;
 b=KJaeO8GJbSGjuklv2AYEa+dsLehMaZLPQAfl5n74nXNDJUTBHzwsLGL6UULAumRChOSSmZxxXJyxgBLYnfEHERBQdmQ/MYaviFHNlkK8HYtbTdB8rrTCBhNoUBPkT+jhPFh3w5hmdB0S0RgfboM/VdRoRYBKVTIEbOuFfEmA+gnJtfZShnd2fOYURhPMzBhEJc7QfB5wALYXINGG7bZj09Y3KN9EhHcharbS4eQAosdXhMxaDEpA3Jo7SmEB5K7NC3NTDU6gse8tf8L+VTp3Buif87+HVkijizoKJI6b1kjXIH6gM+/uPvKDS5SCIP1bCrBlmmOnM7b5GJa5yS/H8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 19:06:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 19:06:37 +0000
Date:   Wed, 5 Jan 2022 15:06:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dust Li <dust.li@linux.alibaba.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: print wc status on CQE error and
 dump needed
Message-ID: <20220105190633.GC2861973@nvidia.com>
References: <20211227123806.47530-1-dust.li@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227123806.47530-1-dust.li@linux.alibaba.com>
X-ClientProxiedBy: SJ0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afff5ff3-8744-47ca-e4cd-08d9d07e7f36
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53014F87BB75A4A5DF76959CC24B9@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNzO6aQlUkUMvylsBvDDMCCEhxZXXEMBv5D7dQOUaX8sN840Ckc1jEmw18Cs6CrljXufxF09KYRzfV3E6TVgI9u5lr/DWFcJthKk2uC3kPe9buDyTh3O25Osj2fvICzeyfrOXENNfzEcBoIfT5P5bFSywi2fYIMlQZUYroz0nSjfDbBKVi1wrIihY3ZQof1VN9xg/SuGkerJy5+gMOoD0pPAvE1iz6H9Ogd1ZhejF9epTT8Y/KJPFtobIFxGW3E2DhbObVNC6f9bEixfUSKAd1BlAoGgq94W6xLhCwIooS2WeMPaNFuMX7dx0KCI40hTjLMJ2bRadj51nwsEq0VVjJfgzGq/6clrJPXUZG75YPfWG62gvvbC5SzmLhBXA2WLojgZM/SkDmWz9fDSIhX9ZTWCHCCojILZCPPHeaSRfk8Cw13FxXsMoh7tY0qvlgHGxtV4iqxXrOM4jCoErmHfxdAQcPFUEqvZ+m/PHwuFwjdtuYuCXIiGBUkGYYI8G2CH3Wm9uH57M8O0eUKAO2qLWKpN7Vz+haOYtum1tgCjBIdw7G2fKghOWNFZH7v7SazlS83xy1RSWSdKNQT+vb971Sm2CqWVnCORhOcVwAqNIrzid89Z3PaLz/pmtAP5qrHQXnf4ALLJQGC+bJnGJHH2XZ7g9pC4XZGQX8BuPlMZxJ/CDXt/2HSKeCYfS1qLF6G0mKFCv+r0IAiSV2eLIjW95A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(38100700002)(8936002)(6506007)(6512007)(8676002)(2616005)(66476007)(86362001)(66946007)(6486002)(66556008)(186003)(4326008)(33656002)(5660300002)(508600001)(2906002)(26005)(36756003)(83380400001)(6666004)(1076003)(6916009)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LX4UZXWk/VvkZEZYt6d5yXo8tKHhKh4ZRBJS/SfVujo+fuWUGhiEY/OD46wp?=
 =?us-ascii?Q?1QTQltLUmYqHzyyo71FcpZnDNM3IGMApxcKLHm/Ivy3/5z1bDjlXC1kW4udz?=
 =?us-ascii?Q?5zcWg/fxEE4y+EjKdQzgI2VQnjsMyG4bV+ol4c4kQourSWgsr7V9UdPc+Csj?=
 =?us-ascii?Q?E/NEwNwGJ4pmeW+9FiOHLQbZzZ7tyDZj1JUdlhpffKejyIK36LwbACNfNxf7?=
 =?us-ascii?Q?Swqjd7Qk1e48SYPhByfDgiqsoDlaRF69455+3AJtBjTAJxrU8H0UkmSHPzYQ?=
 =?us-ascii?Q?XlRaxP6KEgTMQ/2dJSY2Iw8+GkLXJPmjfiZ1riBtBIFwxEu7DYCl/hXvlNIJ?=
 =?us-ascii?Q?mOvwkS31aGdDnZV82LZFB3vyYMwklXBBu4oAS7soc3+smg9NJZ0SFrNWfGJQ?=
 =?us-ascii?Q?wfsnkglSuHojPMvc1LJskBh3rp9UoJVFAQhgFSdbmAEdN3BNSxdlmIjVgeGN?=
 =?us-ascii?Q?X0yRTNYusO5qTtsU5bumMRIILWiruZUWxYjh0GbOiWXDlTJ90KVOxz2T7d/+?=
 =?us-ascii?Q?ZBwK4UVweRGuKOzl2IyZbm7NsJjLKs1ZDjyrtzQr2fcgWKmQHjilrndAjfon?=
 =?us-ascii?Q?er0/ruqdweZDwVexorunDPOfF0XnxVR7bh71flyEF6iH2AywV3YXdbYUVe82?=
 =?us-ascii?Q?joWUE6HUwLMObYvkFppVUCkLBl15nARcEev20UkX7kqWUJT3exXmuMlQPpGf?=
 =?us-ascii?Q?PClQq2zDOsGMsPCI/gSCMw9KzFbDBgPb8jIEL74lQudMi3CNxvcpG9KQ9kLt?=
 =?us-ascii?Q?vsxpySLKHWC2tMpnbjOltvQpIoR7dG5LB84zkdkQhansRhUwB7vwXZdEiG8l?=
 =?us-ascii?Q?1LR98788jdR/j7Z/GByIgXlcLLDvjgmumuupFaCZT0SVcCRBGM2SEtMFEoy7?=
 =?us-ascii?Q?2OxwkXoukdZbpV3J6+raE6fkgeolhYfrLVmL8/bUjeawu9kyfSDcykSriOW7?=
 =?us-ascii?Q?UZivE4K9pQVbRipNcWnEoDxtoujZMTPlk1sSXo0XJf5BW5YvUNmYcWYpnPON?=
 =?us-ascii?Q?aSyetlwsz+qffoM8HfT+nPalqFBcwzmV54IZwnKe8/GvLJNLLsvIhpgpTodE?=
 =?us-ascii?Q?a5dHJuLibDrh/8rgy/qPgedNm4tR5c549pkMmvCX2Hi4odtN3T2NkTusOVUE?=
 =?us-ascii?Q?vBQf/FOo3zojFPXHKILOTTL7giTRWglrC9thxCy3xeXLZQobMbhUQpSKVPIu?=
 =?us-ascii?Q?QhYApMtL2fSBIOElAvZy3KcDsEvoM2dWUWUM816JzTsGFArH1C81nlyr3QV/?=
 =?us-ascii?Q?JfRqBVEI7CvhDA//bvZ28BBxKgVY0FQlHbPVHTbQFsq2Vd+5W1cVew/KVeVb?=
 =?us-ascii?Q?ZdB1NFqvT6Z4BMbaA2DmsBbrMmiaYXzuBhbRIkywXvqWv+7sYbLLIUiXqAe1?=
 =?us-ascii?Q?UUfb1Jgh+Jrc1Ur3Vf94xfmDiyd0pfKr29K6VKRhja2FUzhHOzTCIpkf0Vx2?=
 =?us-ascii?Q?skcay2KX/JP/HLqvDRfphL/pJUbkspttraJhsMWzwWNQMXiD84jsLe30AaKk?=
 =?us-ascii?Q?mhpAtCwqClwc786Ahd7ttP4Br5IcthoK4xefJ6KPqlTTP6xEw50f0FZ6sVpn?=
 =?us-ascii?Q?bnby4SrOM+jrHVySrC8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afff5ff3-8744-47ca-e4cd-08d9d07e7f36
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 19:06:37.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GmCAnHNuKCCg083kiVH7hVU2SpLXFwMfDZp+2LTLxwF+1wt8Ix4meavtrHtd/W8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 27, 2021 at 08:38:06PM +0800, Dust Li wrote:
> mlx5_handle_error_cqe() only dump the content of the CQE
> which is raw hex data, and not straighforward for debug.
> Print WC status message when we got CQE error and dump is
> need.
> 
> Here is an example of how the dmesg log looks like with this:
> [166755.330649] infiniband mlx5_0: mlx5_handle_error_cqe:333:(pid 0): WC error: 10, message: remote access error
> [166755.332323] infiniband mlx5_0: dump_cqe:272:(pid 0): dump error cqe
> [166755.332944] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [166755.333574] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [166755.334202] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [166755.334837] 00000030: 00 00 00 00 00 00 88 13 08 03 61 b3 1e a1 42 d3
> 
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> Acked-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/cq.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
