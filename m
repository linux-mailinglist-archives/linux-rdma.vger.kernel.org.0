Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5475251B505
	for <lists+linux-rdma@lfdr.de>; Thu,  5 May 2022 03:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbiEEBH5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 May 2022 21:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiEEBHy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 May 2022 21:07:54 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7DB483A3
        for <linux-rdma@vger.kernel.org>; Wed,  4 May 2022 18:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7Vcbwj+EftHoqA6Cu7JTh0byebZ3B9BUMCdmzetW2P6KyGO+cLykG+t/94AQnG1koDTNw4RUMigR7Cn3JcDBpyI9MD5sSVeQ1EmpMma6PBqwGskKvAH6IkzCPLaGeeIyD9a6/0/Auh8AjwqgZXY0GSnCSEN0lkE/5TvEwCJNlBH+cry5/4TAlYL6SYdGfrI5a0Mii05dPZIYVggGzP+IWZ66y4mtmRZSvlDO/KXIugoNaw+ySG9lp9HhPp7/zu0MtId2V0/lu4HD8AtBe7wYZvrhXoZu6S/eVy62QQk/WHWSR70ShnyRy7yBzZ/xJvFCZ+d4yxSF3XAv9t5IC4g0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLzUHsBxpD+xNXdN7hTz6kUv6X43UTPJs0l39SFzYR8=;
 b=VsGafiBe7NSVpt5siJ82JiOF8phRg9koC9BYCBv+FVVzRvGVrtw70XjfqrQFbZUgi5kNfPJfw2I+6zhoAXPvoRMfV2Q5K7E38DhZxPRiBY8O+JWvbQnNEvrez5yFQXeBeEuGGA+BTs8NZacwnGbsjpCDJkmKtMCHkLtXEpDOQEm6s7wEPueqvwwM/zW76+OCt/KvfR+qjqVOp7iWpfy0O4+UhTOOqv46J6JS7+VBkdutS9svFkcH9fBgxf6tfTn3Wrzos0Llq1YZ512WN5xWQuRRUfIu1eI5CoT03izg2yGI4eBXN0zN+n0shfAvoBvb03zlAcfouJuYvc+CDokzug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLzUHsBxpD+xNXdN7hTz6kUv6X43UTPJs0l39SFzYR8=;
 b=TuLtQFD5dxZWTLy1MO/MWRlH/pDSqTfDicT9P5lorpxWCKEgrh5ZhaNy5P17uALPIUV9lthj7xZeYPSdKd2PrUIVysokxxTXPC/mKMtsSQY6hrIlCqWafG0Xc6yUuahkWW5jzA1cMoSeumPgqxjzSv433AYBiOW///vP5A90PqKvUBV1Kg6WhW5fP7yqA1CFzxZgYdpAvPq5V6clnNhd1e5FGetkxNWtRKKwgX23PA/5uHnSj6j9pduy/Nw8ezpyjk16eVAfEa0Zmd6m55yXbV42KSxRIqKJD3T3Izida+GyI281Ybm4MyfvEi3TRQA2+uHN0YA54b3qoU4avC7Y5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 01:04:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 01:04:03 +0000
Date:   Wed, 4 May 2022 22:04:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     yanjun.zhu@linux.dev
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Optimize the mr pool struct
Message-ID: <20220505010401.GA225416@nvidia.com>
References: <20220428041028.1363139-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428041028.1363139-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: MN2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::38) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 97a66ec9-b111-45d2-efaa-08da2e3324de
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB340322E9D2542238A693EB57C2C29@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7EIbT8X7lj8Qfz+H/TFV1VRt11fcWbdOpvHYv38GVGvr+pBy/GSKqoVqegMK+/keYSxCNjmxFWgQWGeXYvi7sfeZfCiWvBTTKMdWNp9kweuYypFetTVVA6ORy/7XfWErZ+ZcihywxjFgs0c5ugidgwUMlIIjJUKVYAxEu+hao0YqQPEE5Ir7L+gYyatG6YBnQcK+5TmtM5AJZ5pK6dZC61eXBRgM/JkiIccp5BV8jHqlq8UEJ4UmYpTySnRfmakaiPh+Bi3XnytG7s3ndFlEQaLintUuvQMXt/En38FzAWNMNAWTFFo6UKw1nmlC1FbW054YqLwzlcSvUExJVCuU5v0FdnJTlCh+CyVI1pQdFjf8XuAqKhVtbOXKcSyR8eUtSejOIEtSs3bBZXCRBfGNpk7CSZEpRBg6GecWFZort3mX2kQjLgQYWRYOzoXtkjrw4oiV50q/qkekwUo2k9gMpNG5IdyQgsH5uVHvEypQ2M68oKOOpUqp4MPxvPuReugLPoRCJndkbEnXH8mXM2our8DukfSOrP3f+rEng7eI2T9XXh4pL5mYwxm2lvZs4kURgH6SJhOuHlBLrD948aNMOxgae8PlcNwBEIX4CGr0aHYYR7/LO3mvIts4fCUwYFw7OP5zYSkx3HjhPnP+6I71HKEUXFYbiBbCSjEXsrm0w3KUKJD6tj3xFIarzcD9a/N7rZ7HBhHGs2u0J7+/WRAF8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(2906002)(83380400001)(6506007)(33656002)(6512007)(4744005)(8936002)(26005)(38100700002)(316002)(186003)(2616005)(5660300002)(6916009)(1076003)(36756003)(4326008)(66556008)(66476007)(8676002)(66946007)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xYjXm+QyPQcBulrvTOHjbyAhW/XnMLQcA0LB9Zbh7Hx7DVnWePuiu1bJzyN?=
 =?us-ascii?Q?YEIPeIrx1hnEq9kpgHWsq1IzRI5gmJNty7NBVMjUxsddD5jBKY2IIXmQgTgQ?=
 =?us-ascii?Q?o/lgJGG4FhRQm6v4aka4njejh1xU+B1Ze8Ld1WaB/93NmbDV8IZnPfbBITLp?=
 =?us-ascii?Q?WovQBsbRcj4oYjJcFhnPjQIBF4MckvYOQLNafoscWUcgKe4/RHXM7toXv7jF?=
 =?us-ascii?Q?6DXRqf2zAZwwESJJAZtmhNgZ1P9U0/P00KRRlr3HGGFT2OtnrkTEyDyAbDJ7?=
 =?us-ascii?Q?I1o9A0FVXwe3pemJOqObybOoy4RvGKxkx/zmHrRSQWrWkfeShHKttAnajAUW?=
 =?us-ascii?Q?PGSYmlYpQ/poPlMvhVC6EZUbF3fIGavbu1fzjSTysBPux9o33PEp8l7fTsVc?=
 =?us-ascii?Q?jsdCkrh1fXs802CmInX0KLzHPntPcsjAiDq3sg2aTVZlsvhUqS7t7AFr5jSy?=
 =?us-ascii?Q?j8qe4qO4LlnXyzAYce6cVcjVK4pNUlhX1qXFPHUjE3//il3UKSqs01TS9B3D?=
 =?us-ascii?Q?btISmE3ZPXpcqcnAmHJ859NIMt2ShD1U8F0vu0ocmpfW8UMn0XggxM8Vtqu8?=
 =?us-ascii?Q?RCXD3YhLbf14YYiUnD7kSZnC/ZK0Sff3hned2lJooSMOMg7CLPfK4tzRwKSM?=
 =?us-ascii?Q?ei4i7u15zofkUrTZ6k7V8GPLRuNCGmIz9KhyyUMu4aQE68d1/XBT5oBy1WFX?=
 =?us-ascii?Q?sC5M1IfyuuISPaojjLAb46Q0IYN6QbhVCCYeqc1WW4oxliAVAIdj5Ja5K9h/?=
 =?us-ascii?Q?9kIDJ2KDfK3IJ7xq/VjvLQKo50cUyMDzYOPGCX9mLqaKl2QsCEjlM/r8MCXM?=
 =?us-ascii?Q?jSxkbIvqY2W2Os4WXHExX6ActiivvLBQkVhesxDu3Vt9vB09V27DrfXoTLWV?=
 =?us-ascii?Q?gbXt2U0FKV7lD5WHKtqdvsBmbDmosLcDLXkglLBHryK5IHl2Uk6DRKdKJhnr?=
 =?us-ascii?Q?wHGmUDIifyuUWRRrxBhPsPve/6KqNoUjEfz9uKGrAOdkD55HcTwFicmf/cEK?=
 =?us-ascii?Q?X//iP0J/5zgsW6dMWA9GBV4GidmR7fLjyIa4Dok/uarYIqGNkD/veOjj4mHD?=
 =?us-ascii?Q?1ifzF/4HIwQww+RJ/RCDJk98GHc24nDFZtOI6jZxK0e4FVpq0RDcq+aA4QDv?=
 =?us-ascii?Q?5qBvRBMZKSQxEOlbPUe1GhTIrjLAidJg2VhinnDWw/VvDwpc3/fRVW7Sskg+?=
 =?us-ascii?Q?Ol+ybJMSIHli9Jxh1CnHajU6DFNRIMBA3to52yVhc0xcstZkmRyHHUbniYvQ?=
 =?us-ascii?Q?CT/Yzg7fi2JcY9AEGMYWJhb/cNvW71dumEFq7/4nVTxFyrT9/qBog0tOItNR?=
 =?us-ascii?Q?TrEem/mCjyboxlVuJY7wfRepfPt3AggdivEAH2H32eimK/YyKNXblELihl6A?=
 =?us-ascii?Q?3v5XPTn2VgP5/8XZzmR4AXc7rlYouKA3NeKhyp/ujrrBv6Q2Cp8P6QSCvMqL?=
 =?us-ascii?Q?gMF1DPBcTX4ZgmtBySQ84FqIANZCkHt64YIfG6oEy5UDvMDXnsLXJ1I0xJc4?=
 =?us-ascii?Q?V//0bUF7eM6CbHz+PjP9vJ8l34tm8ajp+ZBCMyytlx2i8OZFR0nrwPX2xsod?=
 =?us-ascii?Q?BT8Q14dj7LXmezyjU5OOoqFI4L+5c0JK1HU27/rK3gP7SXPXLOvS6Qttj6ay?=
 =?us-ascii?Q?Wrnbe/PuzZRNUPWuTBFH90jSo4T2wGDPLsIiRnS1riGcvBJXrOwN6uMBhoFr?=
 =?us-ascii?Q?Q2bTRifWelIwiXS85ThDGZiXJygBChzPMWEqJng2Toc3GosPQ4Nu7s28o6FT?=
 =?us-ascii?Q?XIFX7XkQDQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a66ec9-b111-45d2-efaa-08da2e3324de
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 01:04:02.9095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hF/iGgQnd9O2V6JvWkL/bRtOp+e+BbPl4kp2KwxJYeTh0EM0b0MAPVB6vokQyvhQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 28, 2022 at 12:10:28AM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Based on the commit c9f4c695835c ("RDMA/rxe: Reverse the sense of
> RXE_POOL_NO_ALLOC"), only the mr pool uses the RXE_POOL_ALLOC,
> As such, replace this flags with pool type to save memory.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 9 +++------
>  drivers/infiniband/sw/rxe/rxe_pool.h | 5 -----
>  2 files changed, 3 insertions(+), 11 deletions(-)

Applied to for-next, thanks

Jason
