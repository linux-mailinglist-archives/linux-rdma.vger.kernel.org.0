Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A39646573
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 00:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLGXxi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 18:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLGXxh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 18:53:37 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2872C6F0F6;
        Wed,  7 Dec 2022 15:53:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYHkxzn3EZeRsC+LYuiyYNjcZw5fxFk8ZYpXDO1a03QSahxnMRCSdb77Mxcvea4/kWczLpDwetSZ8jhvobKLfN7WrmdO3vTYgBEILWDPBeZ1U4zicF1gsM8hpYS33r2VPGICvENme9JvNgmbLm8U99++fTHqWBet/jdx9EG3P/QgoDdw3ul3wbRoUQUQbrYVBnKMuD+i4p2y5J8tcHzWxu061i17Ai2dN+fQXuKbJoP0WNFSPkwEnIs0u68OEg5zmE47g+JM44FwuY2NMKd9/GXbtTH+YNCfNiYpBWJFjLvYs72YzcdbsdpgvU27vM9T8SyskfhKSHoestD1yNNOiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9g4BE88M2mbjmts5OX68z5DtkEZr781TBsQ9jd8XD8=;
 b=G/5aIhEpAOWbSEnU99Qp54kHoKHAe26MpNhza8c/ra+YM7/kf42YbhcMAfP7ahIzWZS1tTmqYm7VZMEYODplM2WuAclGa6o5z7lvZ7njM1kBa1OpxQjLmYVr/wqSg41MRA5nUZiSUtu1mADfFMaxWXX+WZc1GC7OmqcBpo7imvFW9Z2uIq9aiPdKxWIji3XK3reFFV+2cFEL+MZ8KihqHszqIaxEuaYotZCJ43U+Dr7i+6Nwbur0a2Cc1O175CmxRmlmJyo6On0fV1uAJWWXgiBvLuIiadBopDB1t62nfknq6TXKdtfL/uTBeXKq4n6yDis4UW7Xo5NUCJUvl0i0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9g4BE88M2mbjmts5OX68z5DtkEZr781TBsQ9jd8XD8=;
 b=lvdU5RkJo5igbJRmVJi/DccLqEFbVbPvynSA6pR3qETL7fGkzjb2bo971br7NIfMpg+Ll/HaiS6p5YPGQAbuhQG+KGuocQ9bXWYf/6kY3PPG9w8RaXptP2oQNE3mUHYwwbmzw3pSE9Z/RGeW7aJNuwzDDuaScd1/bNeij7jLLPRO5R58Q0ss3Qy9d4Cvk5IrWbqBVgpSNw+5AXPu4HLoBPQyyXpwOBLOMerlddfAPG/s0P9SVq/B0Fcqxi43RW0hjwPDUKyh+pOTrYxdPa5OaK7O5faBr+3Z9I87w1lq9Pdolyf/B1i4u01x1VNfCPTYaQ3M9wYiat6Z7nSHtmsHog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 23:53:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 23:53:33 +0000
Date:   Wed, 7 Dec 2022 19:53:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haoyue Xu <xuhaoyue1@hisilicon.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 0/6] Bugfix for GID and PBL page
Message-ID: <Y5EnfM+Lkwo9EXS7@nvidia.com>
References: <20221126102911.2921820-1-xuhaoyue1@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126102911.2921820-1-xuhaoyue1@hisilicon.com>
X-ClientProxiedBy: MN2PR16CA0009.namprd16.prod.outlook.com
 (2603:10b6:208:134::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edc4789-d43c-4ec2-c152-08dad8ae4013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ob58UjgyJUJgkMBuIpixtHPaOia+l/FNguHVq0Q/u3d33+F/ZYXLkVX6MJJ/5QTspe30/Cx6VvvsHlmBsPEDpOntf1oVIxFPEzG89wI88unJVma+o4B0OZ+EhR7Uvb9cakwiQUigaeJZLMpUl2lh771zwyruuHGzPqoUjmFo4L9OgmyW8FhVeDG/gIDRkxoi+MBvs5uG0rf+Y+rO1htvarrEalTshHW9yoRYiUHGDw4K9BLh0k9G4D/EPh6e3sJMZ3l1A25Bf5NXHW+GwxV9/8nk906lXMRSAH/5UMICWvm7DYATqstSusgg5HYRGK1IsSWe5YckVrzlnvwVZV5/QNtIXjcqrggVX7geVsDRZ+uO/DZbjykN5SJFBDyU0UCunpTc0L24y3ds1LwkTFAFewFZFHoeXWW+De3vB/f/Ff83LF5xLe2urP9gj3EYoMf5jXDCcPANzqneKXoi7Khpq6sGZ2gKmrqY+xEPE/qeVg2eyQTPGE6hgPTFQ/nCZN1BhirBwllcUsJh1CghxO6rDNw3reDhGeuNmENzigeSxoiGLzsOouV47SOAOm/qebqLvb3HVCqOEfhFDLzd/5ouzvpj0k1+Ln4LABlSU4etixTIu+sz28D8szuwrEc8+WdctXRJeB5iHb3tEJzcpvl+j5EFkm2qbuvA99m8q3k+Y90eal3DWnQz8+HJV0IhBWPe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199015)(36756003)(8936002)(86362001)(41300700001)(4744005)(4326008)(5660300002)(2906002)(66476007)(6486002)(316002)(66556008)(8676002)(38100700002)(2616005)(66946007)(6916009)(186003)(478600001)(6512007)(26005)(6506007)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gXewrnvygT0PbD5FqUUtX4Xm9qYe5SsQBv1F7jDo0/f/H0zApHxTUWxJDgTS?=
 =?us-ascii?Q?Y7IhwIDWw1XfrEV2BU/ZP1jb3UPOXoF3FsHfQO+zoGLDHze6F47QpBfin4pG?=
 =?us-ascii?Q?tP6ZibXdixp3B7XrtMz/C04LHcEpisS2V1MEVAVjXjUWvpiTR+H+bW8Xi903?=
 =?us-ascii?Q?HutSV3CZM0FvuIauJ+i7SErNsDDQzCorcHqjx+6+e6rqwQ7HZ3g5IMh1CoBU?=
 =?us-ascii?Q?SAz71zpKbK51LyZrquk8ozUBaIbFwsljYTr6wcoeOolzc+/kB47ZMjCdpJTU?=
 =?us-ascii?Q?j+cPU/6KIXvD5DQcC/KpZKWoQUScjb8RIHKAs023KRdVWuTL7NzsB344wgCs?=
 =?us-ascii?Q?DK03yAG6H4aT/qcRWOVnBH7VNTlcMmglxJAYg84OU5C0CKYZD1xsRCdT0pXB?=
 =?us-ascii?Q?VzlZNRpTUQrmakfPEwxAXqC58PXf0MRidGPyvYYeGqtoCoI27AGtBxvT8hwT?=
 =?us-ascii?Q?PVCs/qfEDeoAboj03k5/d8gJs5r30Y8u1+eOhKmROJUrXvXmr26J6/TYlfDX?=
 =?us-ascii?Q?dHsv9PcD20gaMAtW7Q67YAF+xfL1ZNtE3ld0O18nXY2kCiDWIT6u1FT4W+x1?=
 =?us-ascii?Q?X1p2L+Ie09w+biTtFbHXFOjPvagnP81nYDosaE1VEwQHdNkJKwEBx+4ssja+?=
 =?us-ascii?Q?soJVHAJMqY17gzVnuezmV0NO2WjcPtCk2wS8rcjoBQDTZHSk7nwjRPKlWypR?=
 =?us-ascii?Q?3/O7kxwHcr3e8wuzuHkhBDlR3XNe4ReqX1hUUxmVNRg77AMliBAcprKappQQ?=
 =?us-ascii?Q?8bJPKkAGoMPAIlIxdbXF0XR0bLbYzSUe0DzD29OnwCLMcGVKKSyMtv25ea8B?=
 =?us-ascii?Q?iR935hNsTEQvZ6aICsnDeReFe5shznGJMfaeGf4brSHclhmFLzdKdVfuWQc0?=
 =?us-ascii?Q?RNiKB7WZ1XuDZY4gacQ/DDz8XCdYzTZqys8NNV8A7Z3x6JOcIHO2xT6hsBOM?=
 =?us-ascii?Q?cGmElqlRg40Kd9W0JZ/wNe5IINRNPUxVoDR836McKS6wxAWSF+LnjxJuA1XQ?=
 =?us-ascii?Q?5xY/xOGi5TR5JDfVodi/kWakTtVRwLAnLGH0yaiSyVcUxgzh1yRMxAkZ14Lg?=
 =?us-ascii?Q?S13MpGUQcqvTDAtgnXO7GMKPQ0lNDqcqVOxKvCBqXPfoGvmF+pcXFd8NDX82?=
 =?us-ascii?Q?25XhBuViABDc/cz18kPPnICo0582TN8/V6mqNyJwiPi8NmvyucNsatT+cX8l?=
 =?us-ascii?Q?HqsSi/KLidUfPQ32GAbR50Ro67/23JUuPeAav9DKbxJNpY3PjGp0LeNLeQVS?=
 =?us-ascii?Q?0Tb0k7SPReEnEQ4MafdQZiEXorw5hGbz36RheUxqAvo0Zc4bUyH/zLGvr9OM?=
 =?us-ascii?Q?iU+XdA1LrYFMwNp5xuUou529ydXQcUoi/26Tmz8Xmg0tquXyNV08KD1Zh5Zp?=
 =?us-ascii?Q?ggA3GUQwBoYbc7EP6ZNumn3YMkb9Z1bZr87+h21I+GWUl4xqkFBqqsbe8vC6?=
 =?us-ascii?Q?xdRNyEKzwi2WV2AM2KvED3F40mXR2uqMzPkWSlNkewB0eZOphMVvvt9LRM5K?=
 =?us-ascii?Q?xIZlNRSvvV69Eu37S6Zr0P6GUyWaocm9DnSDaAlrx3LJ/Ei3v9/cN3EJxLDZ?=
 =?us-ascii?Q?mujQVfBnpoTH7Tlr4pNbW4GDgmgsMTyZsQl6YCrK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edc4789-d43c-4ec2-c152-08dad8ae4013
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 23:53:33.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SzHtt50SCh+CURieWlGlHQsqjRM4ByVBL5ZjpOecacZTtX9CUNDK6+xmBb4d5OY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 26, 2022 at 06:29:05PM +0800, Haoyue Xu wrote:
> This patch set mainly fixes the GID problem caused by free mr.
> The second and third patches fix the error on the PBL.
> The last three patches fix minor errors found while running
> the rdma-core tests.
> 
> 1.#1: The GID problem caused by free mr
> 2.#2-#3: Fix the error on the PBL
> 3.#4-#5: Two minor return errors
> 4.#6: The default caps error
> 
> Chengchang Tang (5):
>   RDMA/hns: Fix AH attr queried by query_qp
>   RDMA/hns: Fix PBL page MTR find
>   RDMA/hns: Fix page size cap from firmwall
>   RDMA/hns: Fix error code of CMD
>   RDMA/hns: Fix XRC caps on HIP08
> 
> Yixing Liu (1):
>   RDMA/hns: Fix the gid problem caused by free mr

Applied to for-next

Thanks,
Jason
