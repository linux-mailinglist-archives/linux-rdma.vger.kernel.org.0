Return-Path: <linux-rdma+bounces-13981-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF527BFD8AF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 19:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273B53B3B7D
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 17:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C4B28725B;
	Wed, 22 Oct 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JGqdO3M0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211EA1B7F4;
	Wed, 22 Oct 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153184; cv=fail; b=VH7GFtRsDqxE3PHD8M9XaawH/GX9UEGkf3pIFnishhwzSkfFOynacdHGN2XbDVPez9NFobWMBtf12HSJL7ZQhLMOLIQZPLDhGSRysWSWoX4PhZ6sMG53xlPxrbBQGUeuv4ak5PXZQX4JkJRIGg2xURQ2NTOiWluyMSrAM6CCSSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153184; c=relaxed/simple;
	bh=kSS36jdvOrEn13beLlrLZOEWyZLEgxGtxq9gxV7q0sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lscq/7Ij7da2+fLv7IPTlaClHaDnZsngZw0kD/loHUHxSbu/K7Mjb4wun5JB9b3nQMyHuye5FobFqkjBjWnkvy73Y1xtpo45xpxuFbt2IfI1T1x4fMyJqrtDXONzW2gb0qe5mRoCEchpdZysv/qDKXEzQ59Tqp+QdjbQ6O3K7cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JGqdO3M0; arc=fail smtp.client-ip=40.107.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3zMGqz550wRfXU/+spEay/qOaRDXsr0pcxaL6L8awiAtSnYzSVLCceFpANSek7wWRFpC+Aw6oDRv7rn2nd/yzDkZCnFd+ogMIZqq+BPzy/Mvy37dXKAeUIa2uGASyi+G/yrN9jHs72CNaZkdkK3r6iLS0bEPCgqNFdEuI7vUA7HyfQTDP6Ie9cefFmWIZB4MSY8kzn0tkToasNeRUHxXaLKu2nLNsHAfixQ81gv5YGqDpMGJDcUsMsioLViEe6HKMW8u3ruqZPIyWH+inOgRwoFrW40pJ6SBfzxJ5gbLQrgX6hnS4yG4Bo1tuYbUz4pne/go03uCCnzJn/WmKeBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ek+jCZxQhzbjsE1wMxRi29Ac88OEtu6I9QS178o8CxU=;
 b=NRYNEa61Bp6C2kXZn0ibudJLYdtUFyMyK+1Q2D4iUCKj7HRyHP0Zm0x4WYnE0AOb/l9VIV9DWj5rEiIveV5vXJ3ERIdmABtIai83KXjQ1+DOpPJ8t+DJvRzEHyryZeZXGDh/569F3dZajoex0X9V1fRUAWy/9bDTOYjcOZ+IkHD0EjntLBfEdiPRqcDpaKGEoBscAmyUcDHujEZpOjFyB7r+nvBD4d7OniYCXSWUc38G4uO9HyofpbrZZ37Ev63+eZIEJ/5YCCLFuC+cUx4iIXECIH3zQ0Gihosoag2szU5EeYfhomUA3VuN1wBhanhm2j56hlVy8h6lDDQzqAKotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek+jCZxQhzbjsE1wMxRi29Ac88OEtu6I9QS178o8CxU=;
 b=JGqdO3M0IK9uluku+Xc87R9ltrBB5SULb0ftMGZvLocaGCubqBFvTmQll+dZLD0PZ6N9rOyr3GSTUCvGPKiaVzm6IDRvafhPVov9uFrSj/iByxnD58AVZWIo8LGUxnK2B3kEVxepSESZ3lmRrddNuEjyu/HOvbof+M0YDrlWeeCRPSAnj8sz/qQpfzuHd8BrvG/jLqDxFjRferIJ2h7IyZPj8QKnmVdgCqVTowq008JR9/R6VFr9nN5OTV85Azi5O//ysK1dn1KUnSuflpu3jRNek02rJilMaxfw5cTyQ43B9qFM1gcz7MI0Qf0k84R7Wt8li/opmKs17XgLXg8IwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 22 Oct
 2025 17:12:54 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 17:12:54 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Benvenuti <benve@cisco.com>,
	Heiko Stuebner <heiko@sntech.de>,
	iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>
Cc: patches@lists.linux.dev
Subject: [PATCH 3/3] iommu: Allow drivers to say if they use report_iommu_fault()
Date: Wed, 22 Oct 2025 14:12:52 -0300
Message-ID: <3-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <0-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0043.namprd15.prod.outlook.com
 (2603:10b6:208:237::12) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5b4650-f624-4841-4bbc-08de118e3cb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l5aGC1tQ1I8vxTrRJDH/bbqcvfmDgZiVjRq/jnPAEZ+/57mfpD+8Ww1brHnN?=
 =?us-ascii?Q?3/RKm8bvpR4ktYuwoMqhK4C5a/sf0aKgWrU4zRYx2UCorJfyrhQGEPYVl0OT?=
 =?us-ascii?Q?/qMqMf6ZW1qyPjoPWN2jTqcP6mROsmFabOnfyVsb7/wJlfHDkOMnT/L2c81k?=
 =?us-ascii?Q?qPQNamM5io8+fhzS1WwgG2G1idEWiJTk7tD4P/ua/SiOdHO9PBQo9VnGzS9T?=
 =?us-ascii?Q?uWHIfZ2nsb5X3BXjo/HTyKzk+epqEnTjNDomV1y4/K4V0CQMIgdAWmugZNyF?=
 =?us-ascii?Q?mAWt/VMa5HvOEjCgMyhkMSuIooorguNXNQQK+g5O1GE9l3M5kj9IPavFn18n?=
 =?us-ascii?Q?6v3u9Yw6pdp7rnGj25DgKPeSk7aearC3Ai7FpgTJv0rkLYAO/v4G85mNel+U?=
 =?us-ascii?Q?qTbHfbi3GahinDmwWtcWsRroN8Zkv8W/mm/3QJry0DqTXvVvtljOa4vfhW5H?=
 =?us-ascii?Q?7iLBORA+8SZKLWGH93grCThfDMeVZqj0OHSy2jRxA3JPsJlnC25Ui2DZnCFc?=
 =?us-ascii?Q?GZXmXiGv00+u2hR8mOj+BP7QFTYfOrZGVcitGFdYUydEfOML2mKPST90seVM?=
 =?us-ascii?Q?Fs+nKgrTRLaDHdcPe8awEtnpQz/bDlRREK66NHb60NF2EU4YNvknuRRTFdZ2?=
 =?us-ascii?Q?Moi8GYh6a3mpAtR7iTvlYiMyDRgb8qsqNPkvpCv/4xvnGzIeltoUM0ONQbgo?=
 =?us-ascii?Q?t+9lO1UbIb2KjcN0h9u0Zk/w0l1aUhCDFWdT7TMfaQFfpA54CIwT73RHy6NE?=
 =?us-ascii?Q?6mc9vHu2CieA+fRzOocNNUW4mu7DzwOcHAjvH6Gy6H+TGxrChGeHAXSXoiox?=
 =?us-ascii?Q?rRdsSpl/EYj+NSaStc2FvkNfY/y116nbfOHhnxAnjXc5vx1zqVO2T+Efo0Fj?=
 =?us-ascii?Q?AsCJIJf1Cu9MBzFhGanD9DMf5wkTBmnCaKB5jkNQ/hRF1h+nwHD5elUk/va6?=
 =?us-ascii?Q?U5I7ZEOMwvT7uHIqJz8rCp2d6HjK4AjAK6gpFO83RGXw1lHwkkvrI9k+QPXe?=
 =?us-ascii?Q?SsAwfefUOmyUCocIeIESUw/YQLdgEgT4Dqv1kNhY5iKHKdgJeugTydPewzpO?=
 =?us-ascii?Q?N8dFvJG8oaPL0eqYF+h6aa/9vWeb9EQw8q2TNo7fwq3rDGojTx/i2vvQJk9l?=
 =?us-ascii?Q?1MJMR7i+ksgtZBC6ragxQ4FK1ENH99LcfMq56iX4fTPyPtHYho4pVXL8RUIZ?=
 =?us-ascii?Q?t9o2qI75RJD+zM2TSXqb+uJ0lAHTe8Zr1Vy8cc2ArecupD8P1zvKJ7Hwus9W?=
 =?us-ascii?Q?PVKf2aGSDHzZwKGHXN6ZagBTX7ke3cozBuvzXZnWNYkIGMkTV0TvbI2BmCSV?=
 =?us-ascii?Q?RDp1r2PK3fypwi2cG2yKslHpPKLS+Jm7Ah6oeGzfoftU7Kw/14oA+DaqUC0G?=
 =?us-ascii?Q?Yaab1vlgzeTYfMtfi23Msq8Y64ZMkqRrnQuzV4mSxU/Gr0haYChX5d0zb+xl?=
 =?us-ascii?Q?MdTNqxnpW6H42WilhqFFXJviZq8MzIlYFnQQ3YrPtaHeSsoHozRMc4a7gFlU?=
 =?us-ascii?Q?kp4BymhVPBrU7nM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rxB/RsMU2wGc18RiCmU05pspys2Zzm34wCOR/VRbnYsj2vCzjWUZXFwpu06x?=
 =?us-ascii?Q?b3DojHi2WfIoEL6QTUZJ/Guho79xW33OTr83CgiNiXohpUn8PSnRKpzoWnsS?=
 =?us-ascii?Q?I8gFXejRDxoO5Foa/lHSe5tnW6bRePIePQ672DT5+HvQCRzmYlj5lGpk0zYI?=
 =?us-ascii?Q?bKp3TRFdSHiiu5AqdWYLY/W4SSqEDCHTsAmFWevazdHjbPSq1vnLACE5jv4C?=
 =?us-ascii?Q?LZgaAIX38cq8AP2mK91GRyZBb3njjMr2AN3InOvXcNoUI3TzsXUzlleVhDAC?=
 =?us-ascii?Q?EfBnoHetmDH3couo5nWXveeRYbYrx78F4eHRMK481n+a+LuvTDKPKRGHsd1v?=
 =?us-ascii?Q?+1Pf5jRXwU5Ysz5eS9GCuNEPeGhjn3BV7zY4xECgo7lNZjg9PX+sK7H/cENJ?=
 =?us-ascii?Q?wG2vdHM2VmD53erURX8RlOrXhYntbCPaiFAY4CS81DVWeczmlwjOmim1HLzC?=
 =?us-ascii?Q?NTdIfJLTbV6BnGjUNvwlQxgRNY3ZqXZbQypM/+3eYh9KTacR0FWr+1lGDagO?=
 =?us-ascii?Q?SOi8vlf9tknX3+y/TNUT/pUDq1NvJCqcGgfmBPh0Owym6FOX5Lg8kMT0Ze0f?=
 =?us-ascii?Q?ltsS1dMjyTmSVFoNpIpW6AkJh82BkCuI67wk6FDnj/1qZjT6Yoohi/Gnq/0h?=
 =?us-ascii?Q?6JevoCNNsPYb0BzyYJJpt8R1kzxmVmWJjACXaHq1nrSBx9XzMNBfcFCtZbzY?=
 =?us-ascii?Q?Lmoluw1BUZTIoxNJzDYszxU9Z6BjRMmeeXqT8Ia0SAlin9JRInBq+0YaCj3K?=
 =?us-ascii?Q?wIy4LNKfFYzzupebHjVhoBc7sGEc/An9/mCpjsi6MF0hyoFSLVRqJWJyJoDu?=
 =?us-ascii?Q?oDvrHnt0e49B8/V9bkSMRwZ6IVtxAaeCTeLXV6w2kJDIs//pf3N8XR1Pvfql?=
 =?us-ascii?Q?DW65tmiDHwrsNEide20KuAzwJLWs090KqVNdOaE/o3DwuGFryrfB/mGkbG/L?=
 =?us-ascii?Q?SoMWBCrl0JxN8C0Dkuv2CkVEvyJZS4jtjf3PeE13fGqyxCeH5I4fQMMOgKQM?=
 =?us-ascii?Q?1HKSeE4xatvmdC0sF8MveZocDDqbTaI9DQhujmipQG8KhTWNIk2fyQEGhFwo?=
 =?us-ascii?Q?N2Ouybknmky3Gm+oWRcmuuuCINUNme47yg3I0wKLtZQYf4xNLakv9LznlwHd?=
 =?us-ascii?Q?PC1hQY3GNc65v1ejsZ+SPcI47eeO1LcCj8LK1CUVtqjFSw6PuW5CO29UJJKv?=
 =?us-ascii?Q?lw6cjyWGTvzrcWR5LwusEiKt2oPgMS7blgsJBSVxlOLjw/ZRVtJ7b5Sm2KKo?=
 =?us-ascii?Q?OWQm5HqFYEdpjWonPRrn0d5IIugD5w3yQmwGThi+5vUSnlcwnn0W/jqihH6p?=
 =?us-ascii?Q?oC7pP5oN37+DqcfmlxDlfdjg4rBL/ObWNOhr0JDZYQXb747AzKjfuto6c6hf?=
 =?us-ascii?Q?nb1s1e7JxiDM0hdo2glESpBqd1RRRLcvk06/w8NQCRicdg8vaFy6INPl67BF?=
 =?us-ascii?Q?O0ArbJuuV4EFJjOnd+z0jl5GmO5CJICSKF6FTiOpnv5Zv5p5fbzosOHJZzXo?=
 =?us-ascii?Q?TrBs9nPcYUa3ZL+EPoTEefzbjTPcQ4sM2FqL9x7w4hJIpNvqPR0rSm4HPQZ2?=
 =?us-ascii?Q?O4TpbSdhtMunbG75IfU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5b4650-f624-4841-4bbc-08de118e3cb1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 17:12:53.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avopQOXnISs8RTvITcLiI6C5wGVKP/gJc97eTbTMEDo/pUCftk7ZQmEu0pZHDQ91
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125

report_iommu_fault() is an older API that has been superseded by
iommu_report_device_fault() which is capable to support PRI.

Only two external drivers consume this, drivers/remoteproc and
drivers/gpu/drm/msm. Ideally they would move over to the new APIs, but for
now protect against accidentally mix and matching the wrong components.

The iommu drivers support either the old iommu_set_fault_handler() via the
driver calling report_iommu_fault(), or they are newer server focused
drivers that call iommu_report_device_fault().

Include a flag in the domain_ops if it calls report_iommu_fault() and
block iommu_set_fault_handler() on iommu's that can't support it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c   | 1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 1 +
 drivers/iommu/iommu.c                   | 6 +++++-
 drivers/iommu/ipmmu-vmsa.c              | 1 +
 drivers/iommu/mtk_iommu.c               | 1 +
 drivers/iommu/mtk_iommu_v1.c            | 1 +
 drivers/iommu/omap-iommu.c              | 1 +
 drivers/iommu/rockchip-iommu.c          | 1 +
 drivers/iommu/sun50i-iommu.c            | 1 +
 include/linux/iommu.h                   | 3 +++
 10 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4ced4b5bee4df3..5ce8f82ddb534b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1644,6 +1644,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.report_iommu_fault_supported = true,
 		.attach_dev		= arm_smmu_attach_dev,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index c5be95e560317e..3163a23fcbaa4f 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -598,6 +598,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.device_group	= generic_device_group,
 	.of_xlate	= qcom_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.report_iommu_fault_supported = true,
 		.attach_dev	= qcom_iommu_attach_dev,
 		.map_pages	= qcom_iommu_map,
 		.unmap_pages	= qcom_iommu_unmap,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 59244c744eabd2..34546a70fb5279 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2005,6 +2005,9 @@ EXPORT_SYMBOL_GPL(iommu_group_has_isolated_msi);
  * This function should be used by IOMMU users which want to be notified
  * whenever an IOMMU fault happens.
  *
+ * This is a legacy API not supported by all drivers. New users should look
+ * to using domain->iopf_handler for the modern API.
+ *
  * The fault handler itself should return 0 on success, and an appropriate
  * error code otherwise.
  */
@@ -2012,7 +2015,8 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 					iommu_fault_handler_t handler,
 					void *token)
 {
-	if (WARN_ON(!domain || domain->cookie_type != IOMMU_COOKIE_NONE))
+	if (WARN_ON(!domain || domain->cookie_type != IOMMU_COOKIE_NONE ||
+		    !domain->ops->report_iommu_fault_supported))
 		return;
 
 	domain->cookie_type = IOMMU_COOKIE_FAULT_HANDLER;
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ffa892f6571406..770fa248e30477 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -885,6 +885,7 @@ static const struct iommu_ops ipmmu_ops = {
 			? generic_device_group : generic_single_device_group,
 	.of_xlate = ipmmu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.report_iommu_fault_supported = true,
 		.attach_dev	= ipmmu_attach_device,
 		.map_pages	= ipmmu_map,
 		.unmap_pages	= ipmmu_unmap,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0e0285348d2b8e..0f44993eaadce3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1019,6 +1019,7 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.get_resv_regions = mtk_iommu_get_resv_regions,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.report_iommu_fault_supported = true,
 		.attach_dev	= mtk_iommu_attach_device,
 		.map_pages	= mtk_iommu_map,
 		.unmap_pages	= mtk_iommu_unmap,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 10cc0b1197e801..279e7acfd5c6d3 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -582,6 +582,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.device_group	= generic_device_group,
 	.owner          = THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.report_iommu_fault_supported = true,
 		.attach_dev	= mtk_iommu_v1_attach_device,
 		.map_pages	= mtk_iommu_v1_map,
 		.unmap_pages	= mtk_iommu_v1_unmap,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 5c6f5943f44b1f..3f3193de3ecd86 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1724,6 +1724,7 @@ static const struct iommu_ops omap_iommu_ops = {
 	.device_group	= generic_single_device_group,
 	.of_xlate	= omap_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.report_iommu_fault_supported = true,
 		.attach_dev	= omap_iommu_attach_dev,
 		.map_pages	= omap_iommu_map,
 		.unmap_pages	= omap_iommu_unmap,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0861dd469bd866..0053f5aa2cb781 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1174,6 +1174,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.device_group = generic_single_device_group,
 	.of_xlate = rk_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.report_iommu_fault_supported = true,
 		.attach_dev	= rk_iommu_attach_device,
 		.map_pages	= rk_iommu_map,
 		.unmap_pages	= rk_iommu_unmap,
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index de10b569d9a940..29b230050906a2 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -849,6 +849,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.of_xlate	= sun50i_iommu_of_xlate,
 	.probe_device	= sun50i_iommu_probe_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.report_iommu_fault_supported = true,
 		.attach_dev	= sun50i_iommu_attach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
 		.iotlb_sync_map = sun50i_iommu_iotlb_sync_map,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473df..e2bf7885287fac 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -714,6 +714,8 @@ struct iommu_ops {
 
 /**
  * struct iommu_domain_ops - domain specific operations
+ * @report_iommu_fault_supported: True if the domain supports
+ *                                iommu_set_fault_handler()
  * @attach_dev: attach an iommu domain to a device
  *  Return:
  * * 0		- success
@@ -751,6 +753,7 @@ struct iommu_ops {
  * @free: Release the domain after use.
  */
 struct iommu_domain_ops {
+	bool report_iommu_fault_supported : 1;
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
 			     ioasid_t pasid, struct iommu_domain *old);
-- 
2.43.0


