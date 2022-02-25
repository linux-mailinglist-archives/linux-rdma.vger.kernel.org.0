Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606AC4C4FF7
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 21:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiBYUql (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 15:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbiBYUqk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 15:46:40 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C762A21BC65
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 12:46:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcvcn1XKZNizxwKT7k9oP9hStc7g6DV/Rw6Hbfs0U+QFOAqKpTf8V8KjjmQEF5qvCWmHu9+JBeZ5eDARcckpTAZ/e9bfMqk9A4nvEXYA2YCJNHmGioVGEXtg/XQU1pH7EGNKP+qU50OK2aLKpUisFLeVEDn86TLtvVhn4p2rYAAlcBZbyn0pahcWAypKfuHmm6BOzullGca5w6f8HZTxPijL26H518kiHxByxi5nuPE+W74NaTYnjEFXk/V8tCA0ID7vk+ur6bw46zbhGsOXnD3blCmZd7+RkUecPtaIZqLw+2EGcFVpSzidmrmAOdwcJ4A04lRlZ0BYjjztD1iUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pBSeLYZZCpUy9cII61rA2UUG/KGNTNSrCV8M2XDrTQ=;
 b=Am6AJL6GmIN4QvIu7vgppYNrwrTyeIoD6ir295Yky2mexiBGKX4r72zK2gccUBgSGZ7+qqpYnLesH7TkX0m1SRdhtdOi+V+b6eIY7nRu+H2kwQJ7GwucyLsbgmS6+GIjyTUfYiRuNRAK21/4MmScVcE2Oa5zBHXBXXyyvun4m40z3dpnQer9tXIsMbOMFQ8qStcU3lu0KoD8d/Kpj8u57Ge9wY5GRL2XofmMdc8LDL1RCce93gxXEvgrppzhc6LJi97EifLdttNuybCw/qk5C8kOGwMXCXGYKo6Ho3z1qi3lgDGQrwu4OEOgP8bXQcXNhLaAWhKM9UR2EoiV6nLTow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pBSeLYZZCpUy9cII61rA2UUG/KGNTNSrCV8M2XDrTQ=;
 b=XjLrqoh06TslERW0XUM2pAs1xEW8hUZOmTsQ+5PcfN1LTDfXzYWb4FfBNsHzKjvAs31KBErhxh+Dt/Ww/0RXMSoUe7bOynRL36I79BrI4qknq6lcoXQ4wZ6V7qEcDII/HuQHIhh9Y9Q08YyF3N+54Eub5OyHDYhkWRM/CS6IZ3ROmZwTun2HBb8vbAbU7JJAXr4Mk+fn8vZlS9JQq+TTPgg8uW6RIj5WgrVvCNZ9/X7DxpIGVZDU2FdFckcJjSzvRoUWsTVe7MhDbfiVgt8p57hFr5dobUbmeiHFYmDKroGBG8WYV3CdQFT1crXCOOim9ATP1+1bHelPQpwTsP2jNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1343.namprd12.prod.outlook.com (2603:10b6:300:7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 20:46:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 20:46:04 +0000
Date:   Fri, 25 Feb 2022 16:46:03 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v10 00/11] Fix race conditions in rxe_pool
Message-ID: <20220225204603.GC219866@nvidia.com>
References: <20220225195750.37802-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225195750.37802-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BL0PR0102CA0011.prod.exchangelabs.com
 (2603:10b6:207:18::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51097659-a6c5-45ec-2e0a-08d9f89fd733
X-MS-TrafficTypeDiagnostic: MWHPR12MB1343:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1343AB3AB8CA7ADCB7F45649C23E9@MWHPR12MB1343.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cam8aNwjit3imzHl6xMH8gGAfjIEwJ6uBp7UQOK9r2vV4WUDLBBoKxohypKiOnZRjUu+nXlrgRezJHSMAgLFS5v7YoeiTl91wykMpZygG6GivSyfuiZVpGkuxSWiEyfV2YFacDxOFLG13MtEMHeeL0ddbFUheBuNxKm1O32QA/wnx6F18LasH3TD/qffjmdoFDXu11yz4ErRB7RsDswWnOgt/OhaitLPEJ7Af40N7/C43RYPXnaSFq/aKrawml64HHFkmKUCWY2Zv4iD/eXSoVlk5aSnJj2aSDkE4lAoWbOFZ1Mx5Z2xYBgrkknVJgMfe/q6iVPxFYXkbh8R7Hch4tLH/BrpXTGpzWsEgnUVUKGX+pO1oTwvY/tPw8+YJlLMcKmhyM/A44Ys/gwFkIka49LZhmf2djBIi4OJqwqEaESci3HoZioPcJiAZ794jIPezHoXFAgUvguoSVJ7AHSz0ArpGHZhcWp6T2bkqJWn+SnDXjWTQcLAlweJHiu84RkysdFLp6AmhdN298eBl7yW49LG4nq8YgfVnjxG8NFfdHiKLPNEUcCJRA8kKIE4DohapceLRYG/Cs6bxxAf2OPo5GHYBTyRxMCAhigC5HrMPNikpdqeQ1PmBDVOoyOhSLD1Dl6YLCUeVyG9H8dMHMDzbdi3najyrwTWkyG5GCT/WEt0ZNsnqUllojQFcf4Xzm1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(316002)(83380400001)(4744005)(8936002)(86362001)(6916009)(66556008)(4326008)(8676002)(5660300002)(26005)(1076003)(66946007)(186003)(66476007)(2616005)(6486002)(508600001)(6512007)(6506007)(36756003)(33656002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vltAze3VMkF+QLe4nprzfzG7J5gkALZcO6M/44O9KcgVlKPkGI+K6WgxsCCp?=
 =?us-ascii?Q?OLeXSJg79JHffvTDeN12GH0T0x/yvroR3RAi1U9s+SSWkgkCcrgDN3JorhA1?=
 =?us-ascii?Q?qD/lOAsoW6+N0N1NKjjLnJDwvjbXrq34MU/9xn01urC5m7wNAziuQfgRSjtX?=
 =?us-ascii?Q?9vxNDldDb/Ve41EyGrLYo0YsIkMSb/v4SQBB5EQxE9bvGB7rr096rzMDeEkr?=
 =?us-ascii?Q?hg/Yr4YRhtFPe1DG1KAQLSF3u9eooy19oaTR9GXRxVIY0jnjldVFpXyY4JXg?=
 =?us-ascii?Q?vztDDFXKC/RE7QjVJm59//fGu7y6GP6gQGQY3IqiKonqvtHsLChbdCZh05fp?=
 =?us-ascii?Q?V8ia1Iw6Gcm3+++l7H38auJCJ935iQjAFVRd79W0fnL4gKCzYpxAtYNAqYzM?=
 =?us-ascii?Q?WodjkAQUIL7rSytMN1csVEa21hjYEkEKugqGBd7mLkkoeyojfWqZPlkMv9SD?=
 =?us-ascii?Q?RwtGyw4p3kW/ktzuE8AtFHWF5MgHTFBGgfUlwr08e41DnxpOnyq+MSao8tq0?=
 =?us-ascii?Q?juUeIUwE6Lj2tfrM1ceVuCGC/W2ArELGqfWTAwzrll1rXNw8IeacH0/6wOET?=
 =?us-ascii?Q?ckaBQIyNAK3kKRaKzDTtgXTcLC+tK58ZVkW/IK7hUf7ucJ59891mu/mVfWNM?=
 =?us-ascii?Q?ClfDbCeP9j2xcWD1pRmP/nOMenhnlOTkhdVzwoqDQQxyIlOuyoCNbuoYbg2G?=
 =?us-ascii?Q?jhEh2OnlfoTfdB1jbqBy05appx3uBBCrQmp9wODkWgy9F7/OATAWbcnqv/58?=
 =?us-ascii?Q?w+hZ1o/w2B8sAOMi9qyVupFhQAS7eGo+zlTEU7rDzudSDSQIJL8x2Tqm7gON?=
 =?us-ascii?Q?p7h+Aq8jn+1NPevoIBFdfLQxlwxHY/ybd+mY+27dMBOWM4coJgfZcFWYHSKq?=
 =?us-ascii?Q?33sBmcZ5wZzx+Yepnl8IWjqCDnSWwdWRwwLOegDx/Vrj1wcVSD4OHedfqycp?=
 =?us-ascii?Q?GwgBwoVgyh0MW6GQIAiX1GjOkyzgZteuz3JfrAFSq2VKlSveQPofJFLbkQcX?=
 =?us-ascii?Q?64Y+OkRiMS/H2sBsTd/nHwPiKgWHaqVDyyfeYZ4KYsAaHvT2Obq8J0iiGNv4?=
 =?us-ascii?Q?P8hdsy+wrz3zbbaRTr/UZBxKZzzoiHhF60vti4UfTwPi1rakcb1pwl2eOKV1?=
 =?us-ascii?Q?Bq0GlfoOAK9kErDF6skSpfyYdxROLKWL5zVZdyfUvmLtEn3ZMJ7SlsL8cF8Y?=
 =?us-ascii?Q?SqFFiFqhLXwCoY0WHBGWW1aO/GecMtkND4Pt8h9j3nWiZifYIOKhEYjoe2sP?=
 =?us-ascii?Q?v3HcatgqFiHaRAuQ+yJ+vP5rlanaUaoMPyXxQ4cmiehjMoifxZiQ/Ivx3C2Q?=
 =?us-ascii?Q?GCv/sm2jo9kWR0Jhl1mbHyArJG7S8iCYiyQFCZs9+q+P7FT93hgqNQof8o7j?=
 =?us-ascii?Q?bvGMrR7tkxGoBLiRK1OEUz69M/hzNmKjchqlWL6wW2ihBNLxCmRhfT3NGsaV?=
 =?us-ascii?Q?EZWN/1VEwyTYevaJ1rYtajWnEpRUN2olEsMpSgSJq2LjQPP9GcOnns+hBvqp?=
 =?us-ascii?Q?/4DnXgq/pRkvEOuXvS2Xg/vvDCQP8BMHprdnXdJAuCEXbAy6xSg7YCwArrJP?=
 =?us-ascii?Q?c2SmBKnp1tJ8589zz18=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51097659-a6c5-45ec-2e0a-08d9f89fd733
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 20:46:04.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spgEBmD5mNyyhlspmA4S5wrp3Bqx50Tn7gLS2YquiOqaLJVZnTZpLs08ZjkCx3C3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1343
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 25, 2022 at 01:57:40PM -0600, Bob Pearson wrote:
> There are several race conditions discovered in the current rdma_rxe
> driver.  They mostly relate to races between normal operations and
> destroying objects.  This patch series
>  - Makes several minor cleanups in rxe_pool.[ch]
>  - Replaces the red-black trees currently used by xarrays for indices
>  - Corrects several reference counting errors
>  - Adds wait for completions to the paths in verbs APIs which destroy
>    objects.
>  - Changes read side locking to rcu.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> v10
>   Rebased to current wip/jgg-for-next.
>   Split some patches into smaller ones.

Before I look at this, can I apply it without the last two mcast
patches?

Thanks,
Jason
