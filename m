Return-Path: <linux-rdma+bounces-15042-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D07ACC5B86
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 02:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB6413018F41
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Dec 2025 01:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9705262808;
	Wed, 17 Dec 2025 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pPu8gcAd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC5225771;
	Wed, 17 Dec 2025 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765935879; cv=fail; b=rU8IZ75GcZYrEdTOdAcQhYmYJG54ODeMTFNTaW6j3aC0Fn8XqOdS2OGw2tyu0DadOp6p1y+fxHaqPDgFJRZKAzF4zHsMdmNZsnM/UDzLrzhCoylROZOMt5qsANUqC6rNE994qnHhjknJ2FxpqyGKW6B5yGRIFmKmm7pojV5qTh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765935879; c=relaxed/simple;
	bh=LCGQZWORHIXBQBcZJKyaj/xDmqc/cpe2WzTPO4Sp/e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rHaFMkXtLLiho00ONJH3iz16V+zXWFSQWte+xkaV8XgWDcUdF5LSH/pAuO9KE1rtfJ8CP3rZnpYouUCfYFt1CvZA92MDwaIWeQ3pDAUKR9OJceYDesOBS6YdaJNRZ7f9dsa1px0Y9rcBS7freSf96tXhTiyWTDs+k7mA/ISNkGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pPu8gcAd; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqYCW3PLWj/1qDf6UtCIuH+mvsERqzP9y5jJzwIAfrV9g6HvguePkLArejifRBeuCBDsMJltmMPrxbC/7zm/H0qiNcm2QN0JecxHGn0oeOPo460TXRbzlDUaPGvoOAevDqWpeHGGJsVXnVaC6Uzc8x+wXOFfDw6WzJGNGDadaWQ5pTNH9/vrdES8UD/7/kazkQpn4k4ZjP+O/Er6k0ieC7JfFFXRd7wzwEZLLK9wMoJ5lVkpDYQbuzMgaCnCisQOQ/c6BhvVsmeC217wIdvu0ZCMZjK7Yf800+H0TGw7ha/az+ptDEn5Z+ez/vlRgNXbxoKkfUHVUvZcDDJSo71M+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+gls7yCQU09Qfc13gvqoKomGybeuG9afSyljL7xFxU=;
 b=PEf/aWk/Z6XKXt8IlcipcZUHO47G7yfcaDAvHNQZT7N58ymUDxrMTM9CXXxAcDmK2B1TDs8jinj9RgFBorWf0C0HufdHw4RKM5atH2n829yMHWe8m4o0hLJ3dU9zni6T4/CqtBoOX31Juv5rTu6jim7sh/rTYwINQ0UmkwVLbKDCRJRT0xsQiMPNmOK0FoLPcERmKGQh+5+DMBlAsg3ChE5qtRz/B9CYuIOQwzxwO7mO45Ar4d+y+HcaHw1qmkIHe0fp17iE02ZV+tSRMpiqFaKPAHphakULBS1zQxA+HQLPznTuxqIVXyDXV7prkj4mQZZkw0PCfC5JD/Vzye6WgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+gls7yCQU09Qfc13gvqoKomGybeuG9afSyljL7xFxU=;
 b=pPu8gcAdp9D0m/Hr9t8ApE98/ezYrRYy5Iz9LhIp78NAD6qyTQOdmj+lo3VXo9NDHiNdA8J89+ROfK7k0p6a8o2lWKruOp/1NIavzl5qQxy6emomDwWYY+oo13lq9U2yCAIYQPm2ZOysurA6RcYpEQOZudZ7H5SyJvFmqw6c6e/ylifftg6ntFtzdUK7d0bTmJTCJC0/cgm9YNefvYWVfg4jaVrAMfKcI5l5Xhk4h4Rdn5ZLsoJSAS8t3+W50adN2mVO9yaV1eNS+dfCK68+sNLm7j2Ow3by2Ow2IoI6XlAil0NRNuVWvv8a/vzEvMy5BMdIWBkbnj6zUrWm5HwByw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Wed, 17 Dec
 2025 01:44:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 01:44:35 +0000
Date: Tue, 16 Dec 2025 21:44:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: Avihai Horon <avihaih@nvidia.com>, Eli Cohen <eli@mellanox.co.il>,
	Leon Romanovsky <leonro@nvidia.com>,
	Amit Matityahu <mitm@nvidia.com>, patches@lists.linux.dev,
	Roland Dreier <rolandd@cisco.com>, stable@vger.kernel.org,
	syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/cm: Fix leaking the multicast GID table reference
Message-ID: <20251217014434.GB148079@nvidia.com>
References: <0-v1-4285d070a6b2+20a-rdma_mc_gid_leak_syz_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-4285d070a6b2+20a-rdma_mc_gid_leak_syz_jgg@nvidia.com>
X-ClientProxiedBy: BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a1e108-8ee9-4fce-bd94-08de3d0dd527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ysT8E0MZpBMHNkQ9nEAWJhD0bXj5IlCqTSuaMUvua/YmFGwlitG2XdLjPauS?=
 =?us-ascii?Q?SrqBczK8CYkz00U0GNQx3gd2oVyhLweWgPWzGhVOTSwnBLQaJ/1AGNTNffAs?=
 =?us-ascii?Q?lVSrAMZpNtHDhWjQ6sOBE6ykXoKt32ug6FtH9zzqqxk98Y8jMuQG40uC+v6Q?=
 =?us-ascii?Q?sT6KgpgHniveWA792U1kmfrGCrgaLme42TBSjtFgsViTk+1TboCe4fL7XZ6o?=
 =?us-ascii?Q?H5noeCaJdZ4KMctTyNNbo8v9OuAPALojI15/jSvxLSnKMARhk6SaYwF66Fyq?=
 =?us-ascii?Q?Ls/mZfmJWnMGLtPUTpeIB3733DBSuQ3n4NNLXbAFAaR4rE7bM1ElYMio7qWs?=
 =?us-ascii?Q?F0bFtsZlCwBiDfduvrqt30+YTDKL1bvIbv/XzBrrCobFi6KtpgUZ/Lr2COY/?=
 =?us-ascii?Q?wlINWVqeprt7z3CeLLZC57lXFSWCRcGcC9UNd7mbB6PwPoQpylMBjhWAo+IW?=
 =?us-ascii?Q?5V7r+6tlxyfN55lTcGrG2GyfpWb3B9dAzVs2hPtF3IfQUdQTkqIS0f6B43FB?=
 =?us-ascii?Q?3YwDW6xnSFi5ZLCFgYdT9JXBprNtFiun2f7UeqxKHlAGIrBTrCOR6SaVThUG?=
 =?us-ascii?Q?ADDhHcET8J/aMUKK3JKBpwzV+h4PMlpz7GplKkMW0G4JXFEGYgAmFRQwXp/W?=
 =?us-ascii?Q?SNBT1O7PpBIv2yoB8GwSjsPQejzuiAUILAlIBkew76IyqNeGiy2EuP8ItWXj?=
 =?us-ascii?Q?pbZNl+Oaqjd5T8kaCTSizP506/GvOfKg+BngBuP4UuZ2X090NKaWZSW1cESQ?=
 =?us-ascii?Q?+Sqwf0J+L/abzVKhnQluceww9fOsONH0IFTUsht7c8OVtQTSobKiXUXTmPxE?=
 =?us-ascii?Q?o+vtZFKTOhVBsfIHCsyhLhykSyAmIAKrX3YaaSJK6tCdNank7VoQf98Gtm9j?=
 =?us-ascii?Q?qug3xl+ZTNSsLK+l0yqdPFSDqBtm6cCsZAFYcJsThmIutHoqBjNdM6W6bf4v?=
 =?us-ascii?Q?RGXBX79iduXfqRYRyO0455Cm43QqWbO2L/gKwCap7vn9HNPZVOGuDt6Gk9cf?=
 =?us-ascii?Q?ia3HgA6laN1SadysbB6E10jz5myHSSCZ5UkECLgaQyP4hdK6+m/ObjAuUlCf?=
 =?us-ascii?Q?4PYOQnfutQW650Ht5GQYJ7K9atc5sVYzb6iRuFMrrR80Oj0hetssGBSzWRGo?=
 =?us-ascii?Q?RnbzEX2nZWwSI9nrRdU8H3I1+A7rqfyKSyDmfH0QeOZaE96prCVF30odaYtY?=
 =?us-ascii?Q?fCK7peBt9ra3VyLHT9ExtY2AdR8YIw3X4HrNpz/bD9FbA4MSfAYtLwKWkEx+?=
 =?us-ascii?Q?mTz36H3WXsibjUovMWfwARFAcQx/JJVc69STnEM48+aXRxF5YB1h1YbYSjt6?=
 =?us-ascii?Q?uk6rNMFGELNRK/4Kdk1A7PowHGCcuS3PgOmYAZGzAwLCBrIo3mIHi/ORCa7K?=
 =?us-ascii?Q?SatN7E8H3tYI1j/7UJviVf0YTRne73qSnMm4uMzoNPMU/LY+AqkQqPTwu43Z?=
 =?us-ascii?Q?TzxAhxT0nwC8Xg6BxguuFh51Mp6214mGuM1bROJ3fA/Vn45E4p7pjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lSyKH4vnpqUJ00bbfmTZhhdCvaaGbAd8viCihCpT1bEarsnBhTcGYhDGHqIH?=
 =?us-ascii?Q?Wg/DFcuyTK9ukF3RtGWPVVMzVT38DknQjBTVV9IgW8BEZuyRHmw8EXnnxF7X?=
 =?us-ascii?Q?9/3FZk4FN8dhORZPzwqqO4jb+x7bNRFp8PewvgXXGkAQX+oCdj+NTdciJiy+?=
 =?us-ascii?Q?zGQFJSPvkL2nhd2kMmRcTPIZTXRjVbTu4qZWUI3SHcBmTqr7tg9hL5++5Rk6?=
 =?us-ascii?Q?i+zMbc9onQyoXJX/s0rdfCkKdByktJB61ahu9EnsuGvs1tYX1oZw5Q/UNeXJ?=
 =?us-ascii?Q?HL8Q1aTW2GJ3VzAFnxUzmJWwdnFyhCXcqSyvhcqVxHTVf4mcTS6jY33KXbnN?=
 =?us-ascii?Q?NUSUipNP6m/y444yz3cVQnJX2bLFwMG5tOFw60aA5wtPWqJm5qBvGxoW1zCO?=
 =?us-ascii?Q?pYQpe/Ti3p6Wu0E82O4Hc3rUG0i5pZq1TjYWtSo7ehcvpsRm7jiZIwzR01Fv?=
 =?us-ascii?Q?EoidvfV2M1Im++jbZg2p1Mv/+6g1qnj8yfOWb48BTQh7a0Rqv3oozzS95KEI?=
 =?us-ascii?Q?wMCGjbb8ZVrSD2J7HjWAqX0a1PVV/ePMIKHmOZLN+LlqVDMsfhQYgCOHk515?=
 =?us-ascii?Q?ZFsaJfVcE6Z7c/0PtmzHtrkGGxFrL5pYRZVG0tjtp0ECRn8SeleZniVY1E5L?=
 =?us-ascii?Q?WJDwFu3hvikRsvPWRKBAz33Zgz/MdEr4+NovMPW2fza2Gt2g4fEbIIAHEOd0?=
 =?us-ascii?Q?k1QhYKtXROAsdmjSOttgSgbr2jeNGfQQR1FeIKZOyyAGk5WmRDs6/wSDwIPE?=
 =?us-ascii?Q?unsk8eUSQzPJ6bUZYyFLHT9I05aaYggBrtnbyjtS4vV9/a+AOk6ugysIHwLB?=
 =?us-ascii?Q?u/a4VNS+GlHBhS/DfLAbT8MrV5yOcICv8q8t9pLUx6VH4MM4VFGwIOWnzMGy?=
 =?us-ascii?Q?WWe+qM3kQr3xcawgUMB1GMfgg8eTC0zzbBAlnIJAdYeh99Ved8Fs5OkDL6dy?=
 =?us-ascii?Q?ra1bHmgdc1Z4dQCszMiV/3fewIvWkG0ef/JjdcB94Laj/sJXOSBNGvlNRCU8?=
 =?us-ascii?Q?jE2GOsvtNcIxpidmkwssVCkfkI+SiuUSKbHl3883qBywwIiY0BN7gXsBFmXJ?=
 =?us-ascii?Q?0csdBxPBOqwApG1yP25bsRXpDy+xGg6uybyxxFUbzJ/IB16F/CjyG6RGCnVy?=
 =?us-ascii?Q?Ws6lOGGtg8n6eLL7cLdrAk2KYw/lGsX6TUy492z+Y5+KiEd7EO1isalH2Cak?=
 =?us-ascii?Q?Fz06+YeKrh6bm+S7iDD1VXnkT2DqSgizQpkXVYlFpgS7WOsaVQTZFkE4mzae?=
 =?us-ascii?Q?QTZlGJiGyLQX4Oj0LCuR7it1QG3K4xyttOYjYM9n1EcYGOE14m9MmW693Joj?=
 =?us-ascii?Q?u58XvPLizqDUtFJrwwXFbqdKnYN99bMHAFDUG4RVp5bw0STNS4GPkLpvzp7K?=
 =?us-ascii?Q?AgB0+xdHtbbd+EzEXXMhpaePmpLAyVUlGqV7LaHjLo8C5loqdYHQ6dHkNQ03?=
 =?us-ascii?Q?Xsr8Cjz5rwzOjDtRa7XzChVPevUBT7VFvisu7MTVN21Xhxm0F2MHUYBh7Neb?=
 =?us-ascii?Q?o8KFs8tBVqrlHMNr05/JtWlBKkBYYkii4KgMFe948jQcV3A7zNz0xwM9FRdK?=
 =?us-ascii?Q?Ljp/XxKFZzw1+mZ12Ro=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a1e108-8ee9-4fce-bd94-08de3d0dd527
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 01:44:35.7964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jglb8dQTx+SEEs1DBnFrw5Tk6EP7slJKxyxXqiPPy8B4gXwVGABmulZUUwGCLmn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

On Fri, Nov 28, 2025 at 08:53:21PM -0400, Jason Gunthorpe wrote:
> If the CM ID is destroyed while the CM event for multicast creating is
> still queued the cancel_work_sync() will prevent the work from running
> which also prevents destroying the ah_attr. This leaks a refcount and
> triggers a WARN:
> 
>    GID entry ref leak for dev syz1 index 2 ref=573
>    WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 release_gid_table drivers/infiniband/core/cache.c:806 [inline]
>    WARNING: CPU: 1 PID: 655 at drivers/infiniband/core/cache.c:809 gid_table_release_one+0x284/0x3cc drivers/infiniband/core/cache.c:886
> 
> Destroy the ah_attr after canceling the work, it is safe to call this
> twice.
> 
> Cc: stable@vger.kernel.org
> Fixes: fe454dc31e84 ("RDMA/ucma: Fix use-after-free bug in ucma_create_uevent")
> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68232e7b.050a0220.f2294.09f6.GAE@google.com
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-rc with the missing hunk

Jason

