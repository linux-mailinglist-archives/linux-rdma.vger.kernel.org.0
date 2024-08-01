Return-Path: <linux-rdma+bounces-4168-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A65944DE3
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 16:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B38A286CF2
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9940E1A488A;
	Thu,  1 Aug 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hn36Lisc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AD171658;
	Thu,  1 Aug 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522232; cv=fail; b=ggjWCaAQBm+Cx0DpGnzPxQXbR5k/9uhNuih8Vfku8un2MSn50BjeGAD9bERzr585edykX0eu54jU+axyTgFnwatTkukCmJz5I2ej+l0Kzc9XRnbaZIE5jBX12+6oHfd/eA4HXFaT8w/LgBQ/2tOmHtilehGvKI9oCnZl6fVDdF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522232; c=relaxed/simple;
	bh=uwcwbFptrwa5BgPvdHRaKpysrekOeUgOwnfXSvrediY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z3AKgPfGAwT04PvnyBGiIGeQYwY8dk7S4zq99hfIDDfXthkfsLdGiEqMkqC92i5TeCATvRglQFqbKY56O3FjpA4AQ7mRnicre3sJDkUPR1LY50XoufprpE/k3CXGxBe1s8zFYl/daUBCXhJ5tMbjFgE+dPRI5o9ktq3PNPoVvm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Hn36Lisc; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIcwrmRFM9m4nJiDoPHfK8vJvvCwO2bdjgE4Iv0zJgcwxfGfCpFo/HzYKiEHgaDPt/dSvoJa/1l4TUHO5o8ACQxR7MlkcNKRlaVft2mAkpA+ggs8fL9wq1OrWgd+j2YRdASGnkvXESvVUNc+bcbBvaZdf16XpWY3rYEi3b6hwuzQzcJjnGQCrVgFOEC53zqRuMaYYlOU9edHRNVhxDtjZhqoi2I2QkZhDrsSGtL1Uhlz2jHHTTWv8vlBq2qiSpbl0WRLCSkfbTh6A2WT0EPQphgS+lO48eSr5QNn/3fkYmgjm+BlCThxQPk1UK2EMmxhEylrHEWGqEsTBZf9aYSU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYBLs8wA4l4k3a6d01Wcl+Ac32LGkFmsLzMeXrC3wI4=;
 b=iteGcVkuB8VNiD3XIYZFPQLvlb6UZqLThV9Ucta0c4DGIgCJPwaiurcSzcEFymmrGAEgSioIEsoyDmgF9cos5pW7XXkgsOOLHdEgWbcGxCfx+hUcKbuMNDafblOcBraaSla/AvvtnwHLKG16diqnNXBToqrvEZvTIo+2/Ry4sltHaQbzIRtsdMljhX5eg7b2Bg0g/dPKwTaU2w6q7MIbxonQ+ENTTrksynlyQPIAQtIeUndyu1K+mxR5CHiYiHVRLzXYYEJmL+0sJurTzaaqBInEqVN8FlStEECqGTgfn8uw3duz2WA0ZgjzKUhex3U2VYTZk0UiRw8lm2Xie+xPpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYBLs8wA4l4k3a6d01Wcl+Ac32LGkFmsLzMeXrC3wI4=;
 b=Hn36LiscyFqnavrunxNfkJfX8tlB3g4QBih5jxAWo/gsADjFEuILfvn395J6xzCK4E5W1YhM6ETnlZVGuPNUYpVMHZnzJrSvb4h7iqgSxNNCbTBuZzWXdUnUkcOzI41IeUEaGm6Emm4MPpGKC4UkoPOuEaNPfOKvRTY3m/QARHduah/LvyE7xgmxseTQ//08YTc80CkME3BkWojs/8ymq9jTRNjG9jphllKwaaAT47KaxG/+T2oPosH4hQf5tB8tf87fAUR8rOl+LgGWWHYvezxAQmfS2zHrOVS9njxG//2BJLDefTrCLXDBWooWVdeL7S+sMhLeBWMnrvMBoqVyEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DM4PR12MB6470.namprd12.prod.outlook.com (2603:10b6:8:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 1 Aug
 2024 14:23:45 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 14:23:45 +0000
Date: Thu, 1 Aug 2024 11:23:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev,
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, shiju.jose@huawei.com,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
Message-ID: <20240801142344.GN3371438@nvidia.com>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch>
 <20240729134512.0000487f@Huawei.com>
 <20240729133839.GDZqebX1LXB-Pt7_iO@fat_crate.local>
 <20240729152943.000009af@Huawei.com>
 <20240729145850.GD3371438@nvidia.com>
 <20240730131930.GCZqjoYm89oz7CXyJg@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730131930.GCZqjoYm89oz7CXyJg@fat_crate.local>
X-ClientProxiedBy: BLAPR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:208:32a::20) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DM4PR12MB6470:EE_
X-MS-Office365-Filtering-Correlation-Id: b31c2f65-0cb5-4d39-9981-08dcb2358d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxK/aWFvwcHFEfLi1NrwshlnJ/xoX/M9A7pNjUtG6KYR0O8cxyVWG2wEvjwM?=
 =?us-ascii?Q?v3gTvp9zfU31lobnOkD43MFGsDbDhL0Yv2VPpjGf93anzq3hiC+D2PtS0yr/?=
 =?us-ascii?Q?mSItCpTNXp2HHQZV2cYe1CFmkOQmjzOfrles3Wk+0xWfRilEgAUdnG9wjnVz?=
 =?us-ascii?Q?CRStoQV78Uoi9nJCdAe0YsQ+lh1Kox4Q+Sk9tEB60aPHwmctUMO08rUNB6pz?=
 =?us-ascii?Q?7l/Jx/bVjRmCqHzCj/+yK5Uk4eH7Nn7f54FTu1xdBCWGWMnOkh23cQSlWmlp?=
 =?us-ascii?Q?Yy9/kLDa1KUH11ZQpDt5WEVFH+xZx/m6zjCWf7jZhghzz/mmAhtu2KUrpaq6?=
 =?us-ascii?Q?LH/kuxKRfPTF6U2jS5HSdLDasL3yTz3A9aGldm/sgvBWAGTWL4Mm98Di/Rx1?=
 =?us-ascii?Q?pvz8PxDIHj6XgphdLmwXSX9Rf4oKnz3pSkDjPTT3/GL0cJTX7AHDLJjmf6kQ?=
 =?us-ascii?Q?YslURIjZGxTd0BH5+tAprYxHZtiINqDL7WHf8VFJEZPbzGkuHT7eXoxD3uxl?=
 =?us-ascii?Q?JLIiHK4mY0QUsjGzr84h6OqQfj5tphvVKRFAt3w9gOVP0esK/eBjjlafWvnX?=
 =?us-ascii?Q?1B0cIAcUB6O5vA9Z1fEyvON/EF5yja3wPr9NBXzVi5/OncJRTRV6vPTPck8S?=
 =?us-ascii?Q?Z5+87GgupaA3twEQccaBZFMRQdm2t2ShAV20GQVVkqzXyh7iP6K991Nml/yk?=
 =?us-ascii?Q?OzZrLGdqkRSg4rDjvoIituj2i9E99VaCtlzSYJHVdpCs/U9Ny/f7bCfJHVZU?=
 =?us-ascii?Q?fgf800Rdi5wqTBjGRKxokJRF9c67YDjLvQNLRyIUZk1/cqZGQd7oEeonftt/?=
 =?us-ascii?Q?+EBj2vXJZmhPmX760NSajrymKDBV+7MWKHnxnUNAgwi1jmT6IqTHqB0p3Wpj?=
 =?us-ascii?Q?3LdwHEDLzs3sIPH2QTmXdFVv4atXkYE2AJ/EIkYMFQLTKRAY09b7xp+HVmuO?=
 =?us-ascii?Q?cPN0KYO3DrWKu3ZVCR3rrM9C45mPorm4k9VBoMUU1KdiSG5qyOmSSZCbG+Vf?=
 =?us-ascii?Q?RhReaEzHLrmA0S3eebKnHrd20IVeWOKQC3Un1ghjmdpSgbHyRvRcoZb38wsg?=
 =?us-ascii?Q?YgKyDiCBCU/QuX6Vy9fNP4ZVIN0O8fwMXDpjat2eLl1DObjsaC5uGdqI0OSy?=
 =?us-ascii?Q?y6J7WIPPKmaqjwwFQKlDFwU9Eys/plV166JT6JAzTC3QLG1R7gKoJSrtvVQf?=
 =?us-ascii?Q?ffoQ5t1zSkOO6cvqaIAmjlpKoziKgckFyqib2f6TpiOCjG92L4pZeEvGYejJ?=
 =?us-ascii?Q?VDc6QPpnwngKWCvXSrZVZoRKdJ1xjBr+YvhX6rDR8IZ0fMp2MzbP7RKBjeui?=
 =?us-ascii?Q?04GZdH+sN6FTrR5ZAbHg7DRH5dCWu4/iuauf5l8bHcBghvMSGioG5Z4l14Zu?=
 =?us-ascii?Q?a8kj++c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BUcxKVn7LgZ7m7UaMik4Pq8ZJtG3+1HDzXu4di5rHjIck1lm6vqM+hVFTg89?=
 =?us-ascii?Q?lTV/oRyesCQXVBaYTOvp8X2DEAgvjdqtu2nD+qVa0VEEyQL+5k5xu7C7lwSK?=
 =?us-ascii?Q?gs8nHjz3+twbN11DyEH24k/y3SizQkpltKBGYaU+TZpVveqYepdXyET38001?=
 =?us-ascii?Q?0MHOrbFC+58XPTYbrF57RRN1ONI6dXH9bcqVhSydfK++lGW9y/KYbu2NR2Kk?=
 =?us-ascii?Q?8u7pIQXxA6v5GAV9mNxsWem5qIkf4bs2g0yhJgTVZiPjD3DLiKE+TJ/xPDm+?=
 =?us-ascii?Q?/m5g5wuQ/Wp6DcN4gYSfu72mir3gfGCtG1MfJcy9CXuwIaGNmzNmbuaCq389?=
 =?us-ascii?Q?hEljFZhWH4Ln0OgoPt0hpJSWPOFsMvZTyNwfgik2GH3lJyV/tKtaB/yUJoEm?=
 =?us-ascii?Q?SfIfvrmpRGUOkxOFK/vrr3l5vGgRPocTifuksJNO8oa8E+HIy8O+wCNY66yr?=
 =?us-ascii?Q?LJDBO+hsl9ItRkdJJiVC6m/iVpiylVvw/yda1/OVzcGKmV5zz4PNnlmoUKh6?=
 =?us-ascii?Q?roFNPBrzJ0xCLHOFNfTm1okgYkHKmoiDNTn5aoF/7R1RpjWTgK0d+OZ3ynZV?=
 =?us-ascii?Q?xJqjSasNi5UuM3OsEJ6REWRqpfCMiZSiziwRwXwc8rCb7skJo+/Xk5XV5L9C?=
 =?us-ascii?Q?0Lj5/OKfURpm8CPPK8bFjhn6C4n/drkdNlXmDXdv9YNjDTDMfjJl4D4NFBjL?=
 =?us-ascii?Q?Kd7YG2cWKQinsRcAhnmbgPAs2FvOy+vPNHmuvUMX13Bs2esiIRTNMzUVirlZ?=
 =?us-ascii?Q?tK19ur6XWSAzD0Ac0FnZAtH6CEcKNfy4MHHbk4oV+t3tPJGjPwxLoXWVu23v?=
 =?us-ascii?Q?f1nw/QqXmY/TiRRhRqh3j8JIS8J4CgEKFfdDHBdrp/UCAAAvw39O0oKBC68j?=
 =?us-ascii?Q?Lh0bYrheC0eCJe2TTrW+9aCdyDqnUjbXSRFvJjTUByRnUQzU/RAgs0RfWIzM?=
 =?us-ascii?Q?vsmKMz/wUQqJ5QGLsd3h9++TsH8Tk4XCB2pukHjw9YEST86eFP8q1nBbzeVP?=
 =?us-ascii?Q?GCNPr2WrOAafqAJXFaazZX6DXaidGA25fWd8j6wKlBvJv5F1VjcmiEkTxuRp?=
 =?us-ascii?Q?qHLQ0xVL0L8jdJZS+1U/UPTnjTGocY5SGoko/clQwfh/FR1c9tBf9Pq+NJ/V?=
 =?us-ascii?Q?eUgS9s5F6/UUPjmdo0xSNHgbwxTZ4tXFBabk6Dybg1fKwrv77qcR5PwazD97?=
 =?us-ascii?Q?ZnTxd+REquMmK1eP5fE8bzu8g0+gQlx2yj4gwvhp5513ybOw1VkTAv1xCvet?=
 =?us-ascii?Q?g46F5zCi7RAET6hcDh2TCpmiVfFNtL4IQugf9Wiw/F1vpoMjaWQjBH10ERIz?=
 =?us-ascii?Q?9xg1RbV8O5pe2gcsJ4HisQpbykSANJsLsiqmeDVj8J9H0XiWqkNyNqjiBX5n?=
 =?us-ascii?Q?4hl+WzO6gk5GG8vHFab0kYqR1LOdz0hL9eSPFmzE2RlWeoMiNCPuVLYditTl?=
 =?us-ascii?Q?4sC5P6u3VnWnomwmtqJljGowrWI80rVIOmeZoLkSowrInkv9jf79tPKvJsNN?=
 =?us-ascii?Q?mms6k3YD8FFcvoQUX6LeYSlJxVUIjNwl8hKg1WOBamrCDXsSUYO8ytn/rTHC?=
 =?us-ascii?Q?zh5qDfyFCdScn5uJ0VA8QQoYm1lq8LosNojOA9B4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31c2f65-0cb5-4d39-9981-08dcb2358d1d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 14:23:45.1362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10hajEx6ZhOi00DEEv8/UOX5PwCrey0Y9Sj9tyaNEZsfB6B1E1IloJfQWtzwqYnD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6470

On Tue, Jul 30, 2024 at 03:19:30PM +0200, Borislav Petkov wrote:
> On Mon, Jul 29, 2024 at 11:58:50AM -0300, Jason Gunthorpe wrote:
> > Like continuous memory scrubbing and EDAC is not really fwctl since it
> > is part of the main mission of a memory device. However evaluating the
> > memory to measure current ECC error rate for data collection and
> > debugging would be appropriate for fwctl.
> 
> fwctl?
> 
> What's that? Something to do with "firmware"? If so, how does this thing have
> anything to do with RAS stuff?

https://lore.kernel.org/linux-rdma/6-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com/
https://lore.kernel.org/r/20240718213446.1750135-1-dave.jiang@intel.com

Jonathan is concerned that Dave exposed some of the scrubber FW RPCs
through fwctl.

> We have rasdaemon for that where all the RAS controlling and evaluation goes
> into.

Sure

Jaso 

