Return-Path: <linux-rdma+bounces-13980-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0B3BFD8BB
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 19:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12B83B0620
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 17:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE50288C34;
	Wed, 22 Oct 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="giFfGPQ6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012040.outbound.protection.outlook.com [40.107.209.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79128725B;
	Wed, 22 Oct 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153181; cv=fail; b=HbSy5OHmbQ0puKeiRu5lj6qR/6N/7L8Joi0ZBq8tLFY6QZBdaLh50DJTd8/RC7sejhIJ++1ySlTz92tU0ljlZhaQ10CapwVhNwkV4GYdhNMonew3PTj1MM5/6nII915OodYvbdzGoHeFpv8Pr5qHAxIybqp53r2upbi0B6nHVUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153181; c=relaxed/simple;
	bh=3S1OY5gYCHEzCQQCX2wMh4bSeFrV+W9kZZJh/X4cqms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZLuiaEAdX2Ni/tZ/+U3sOkd4YFkehfF5+hTsTH3wTDqW44hfiQ06nJ7pi+EuQ9dEa00GrkMeCEZBCz+B9PQNRmWh62j/LRfvL7DmE4Rt2I7bJUTQ8tcrO0+FwmX4psESzvzPUm5Eyj19fd/xrtambDjIFn5BN9ayR69BpSdV81g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=giFfGPQ6; arc=fail smtp.client-ip=40.107.209.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBlx0+41eqQQOp112CQsSGeNJVNJWGifog5i9dhDWQ2DE3xO0bBPVLL5AwNdKVWW62WhhRz58mLXaD6SFifmvsXgd0p42SsnLhnJhX2dV3DrVgrq6X4wBLuerd+bAChmKQRY4hyr4s67+gIH+AjYcNnKD2gqavAHjNph1mhCWvEWm0lZUVEWNQg+QZLcMKmGDC1IeCrZ2aZq6JDz024uEcvglortGSydJnddJhFFryTnqFAtkgYEWAB6fQUIIRgL2u0lPzh0AJ2JUgw+lZNLo/bR869kkShXMwSOCQrBGtCwlXnk+ttJQ0x6UT715RIKy0yXK5Wc4fa9v46VfcmWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbwZnxuB9IcJ5eMRnkmIgBrPsgTiM988Bs07y1THEKA=;
 b=IzQUDwUrgYc34HLGgQ4/JuICxsMIvQsJeQFpaK63QHVeE1xuG5QtuqHHKlm9vo2zmBI5cCy5nC9hMrb21wbtWG0lqyyKUBAjKOeZ3vzJXOXW2MAQ6lATwATdKWlPG64Ui2rjyjqC4v2O/7CAHOiwQD/L1VkrC+rxYffdtYhq31tYp23LuFnC7gOX5uOz/L9lT8Jx7eGZwjNXYigWtnNQe4D5fWUVGBp4lCNFYNujvBa0h6xKDG9Qr7jvEQcyb863JTeX+wAIVvcaQYPOp2CVZichsz620rM+qJ5+OyCcng88qFYRZakG5QRi0q9eYrwEFGAJ9c+HO2zhTFtkmrm0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbwZnxuB9IcJ5eMRnkmIgBrPsgTiM988Bs07y1THEKA=;
 b=giFfGPQ6P7KqkoPDE2XGw29bTkQkeWUZ/ubgJK2y6HGa8BOUzypOQ9XQO9gH+GA2S5uTaqs4EfsLour0n34bmZ/qKK9v06csXOeJGmzJhcYX4Q0xX833Dzj6ucFrjwSxLP7xe5TVWIqCB0m3OSu/pYpBBImDCDBCwOAaa60QmOdywqrym8dbln2hts8JhznuCv/VEi7WdmMsU9+T/bczjhPtaMmPHKuR1UnQHPBztjEPrFZ49PGU/QBOyJw0qfegauXUG+qnePW1Nw2TDvIu+YmVmXr7v77ZI+6P1Ylq25ttVolksJ0Z9Gf95+1VQzD9T87XX2hUkyhhItdkzXEJvw==
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
Subject: [PATCH 1/3] RDMA/usnic: Remove iommu_set_fault_handler()
Date: Wed, 22 Oct 2025 14:12:50 -0300
Message-ID: <1-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <0-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0281.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::16) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1661be58-2b32-4ef7-62c3-08de118e3cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iZfwkcJaxBBZtj0C6FDprD7x3PUKMsLoUlcqaTIu1fdNcvPjeFfyJJSClu2Q?=
 =?us-ascii?Q?jI8gJdrFTEjutYJb587ZzoRYdNqfZkhLZQdIMI34AmBhsGUYZo6vAy8zQoFY?=
 =?us-ascii?Q?Hjq3AKzQKMpHMBunik6qw9epltSj6XEUhaBDCODM6SiPjDjnJcTb/fbbJ+3W?=
 =?us-ascii?Q?gwbRZR8DdfeLZNgDlLiIuVXC1diYxghlhN3VblaPBGAri/R7YZ4HX5S+lUm9?=
 =?us-ascii?Q?LfkoD2x48ftDJ4pt+ZmnfKi53v+GQmSJkytRYHARd6FN4gSlN8necwdcsE/c?=
 =?us-ascii?Q?8ZK8BJJM4z1EoDGo/c9VTNT1TbLsFf3u6EIC4ua8/R247sljB+s8YxWZ0cRZ?=
 =?us-ascii?Q?IdpvfWPks3iS+xO4uyzbS7OZJNM8mFqtiO4L2sqZSwEjIxJlEkplunZy/Jy6?=
 =?us-ascii?Q?wtqR7VMzuWqzNQCqHrKB1O+A+juMrNJ4o3dF9qzfVed2NpxaIzEFRs6WUQ1z?=
 =?us-ascii?Q?K/JSTLEaAVdEKlRxkdu+pT/JkrHOujulYko38kfjxFmlcyVIBDUFjSvITFUZ?=
 =?us-ascii?Q?9YXtkGiX53O8A7of5qafqauZUGgYSpp32sro43MHoOHph5hkYTg0sZ6aBuAI?=
 =?us-ascii?Q?hfQKqoaCjSav+qKrmJtrYadtvECZB4Gvbtlyt8BquczJjl3377bm3EH9AW2i?=
 =?us-ascii?Q?CsTcKI5z1XoVsHpEd+p0cFTkszzqRHKcdVYDbgkGBtxhqNsdCD6tSuX+QOY6?=
 =?us-ascii?Q?qPYngVWbP5LyFZIS2zaLv4JiUCOWTohmWgRfxo58oNM5vvWQHjSBoicJHNrq?=
 =?us-ascii?Q?a3qCX+FFydWyuvX1XRBbkXIWhG+QydsFrXmuB1xX6eFK0Mb9SPfPxtL7nuxd?=
 =?us-ascii?Q?cdEhTIC4gp/bRo1C0WePCcyYtAQWa6Ept/ig/dhhmHcL2Wq2xAWtMEw28H2H?=
 =?us-ascii?Q?L5rzN8oS8WWZE+OFG/q/fNEPj7DFDhI1tBkkue46fcDbyaChRK9CREDQTFM/?=
 =?us-ascii?Q?vovmwzSu+bQ/MzSfG4ctz3z6PyOLKU+U9RZUThEwWRw6WJFNh0K/iQZmmXpY?=
 =?us-ascii?Q?8rvt2S+8ldtqC1LT+olA9k102VmSUWTKW08GZFC5CHsCwk31NnhrEABLRtJq?=
 =?us-ascii?Q?YhhQZf+bW9lQFcbWLWXQokiFDfzhxkAGC3RrX9ivMqjibuOMKr5yhNyQk+wH?=
 =?us-ascii?Q?nKYtNYjm9wWZjVqGMickDoPxa5uPh0cKyCFnPsNtaxFfkc7bMkccTW7Fb/XE?=
 =?us-ascii?Q?o4DuOnZTMqpYfUFKAxXWz6wpaNNKfbyLqTNlfl2BtJxYtqC0wDl09iKiaT9K?=
 =?us-ascii?Q?y3+M4J0V6g4Dmn7FANv5TRy1AjVB/2aB/zAEN6sylYYj243S0UrXBSslwjel?=
 =?us-ascii?Q?ItPuYfqvyglsSGjNW/py+d6yc/N+zaHUTW/dm9dApCi0ewpP7myluqw3sytv?=
 =?us-ascii?Q?k5J+gbt8mH9PuXXmLdXS+YGWjKqcD2H3MVwWnWAuPlJ9YQTh9+FLr3REVstV?=
 =?us-ascii?Q?gQz6KVvwGr1LnfJzaXwnChIk/oFrET6JpXKP9G8z2i/O8IsZmO4CGcO5jHSn?=
 =?us-ascii?Q?RglsZVO+dSGmvhk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DpXw27rww2vOhK6sL36pMO5/IZwMOzCdyjO6YBiDjp5KMRspmsLD9O11uQKc?=
 =?us-ascii?Q?GD0vucCzLZdwnxBSuYytwYATy2vBV3TbGYJvYNG50ZCzbtXn+ufqgRGm11RU?=
 =?us-ascii?Q?xT7YqP/eFs5t/kCxhbbS4lBrQ+p9ftwMJKZ0qP9KuvQDsLf5ZvHQThN2B5ON?=
 =?us-ascii?Q?ed29k1MHRZrxF4a21KO4UZ1/rPqT4aNg1mzZTtuNyjSxDbYi6ULEH5rLBTBy?=
 =?us-ascii?Q?zJ+NT2zuP7u2ijiP5QkYtEKVWOr2nbtw8U5S2idFMAr8HB9NckEyPPG6Rdwl?=
 =?us-ascii?Q?MmV9Rd32TDVo+k47dUyXuP4Mjjc8TlwI4jjfDMOjCzSIiUWmxVqKkNBLfHs7?=
 =?us-ascii?Q?dA56DQ6CAxFu+Gs9/vY+KBc3rIXkSLB/yt4w+0CwkEgU09gcF3lnoe2ptYZ8?=
 =?us-ascii?Q?jtFwJt4WgeNeHpJ/Lgue1wVgavh3y1Jb+8S051rfCXxcVLORd1xNRdwIuPJN?=
 =?us-ascii?Q?20bGO0mHakoM6/ppdlY3rw1pvWHe7iBhWfPZLVF2s23cLg5XknH39y242D38?=
 =?us-ascii?Q?e8ACUp/MKKuE86wSRIxXR6iJDrceA750dGk1Q4lp9T1RbSsTm6LXy+k1uqRV?=
 =?us-ascii?Q?omvxS1ydC0TE9W98Z47oDsVHcddMPwR0HpOBbWmgncuPmEUoMJKjpQx6GbEO?=
 =?us-ascii?Q?6rw0DmeOcpVzEuXLBs8EWS+vKcfkaSNXZRIUzlNctWkyBIfihtDtTHW3+/ec?=
 =?us-ascii?Q?ElgX3cvAeSoyWZ9WXmchh9YViEhpxtQYlLJR+NIWARmHaI4EDQkM3yjq/bht?=
 =?us-ascii?Q?G4oTME9x6RpbgiqkxvyO8r+M/bmw4m+xk2KN4b4+8uWtotmIb9p6m9Q5Zndp?=
 =?us-ascii?Q?4TCGoA9dULGFCUt6ZxmtrDVbZWd8fMYUL9yPh26P8uar+ba1ilLs9Ju2ZOTh?=
 =?us-ascii?Q?NTOlxo2J/NDtNvtDYGQ67C9JgvEoYc0vLBEOljsCOrn/y24gNPpBMKsWwI4I?=
 =?us-ascii?Q?QllN+JmphTDk84unaOgy0vhas7zeAjed4uXtCv+QYfrQ41i9zlGSFo7Yo6MG?=
 =?us-ascii?Q?miXXqyRjKpl0Krw5TjJGP3ZEBhYu4I4gp3zdXjzAPRHhqS1dyhXfEpDVMo2u?=
 =?us-ascii?Q?9aBcJw9pPzvTLrwFsx31BSera2wiGHukMAT3Aquk5QGY5dEThbizSyxZqxGQ?=
 =?us-ascii?Q?Trfd/sqfHNDzsY08ZGgnrhTUn03K5NDcAHXNkzWZOETInvRZvFphuC4Hn5Vx?=
 =?us-ascii?Q?mh7XTQvBtSOMC80I9dEwZFdhFqXyKfdh0tzX5WzNAPeA5DcDTFNbxFoWUK10?=
 =?us-ascii?Q?SxMw4BM+sii8XuIfxA6+qszlMyqdnJxBgFDFaJsxfBC6IgAEFANaYNQB7VOZ?=
 =?us-ascii?Q?C61n7oj6XC7jxxOC/9H5GD7ArccfJaJHklyMwRpxBvoyZqLF2bCADCILtc9g?=
 =?us-ascii?Q?LVONtls7TsK/GuKn/hl3Pj8mL1+lx9TbKv0RKIha6plH4vc72yUvL7Msx0ZM?=
 =?us-ascii?Q?aF5MBdeXMgJOpMnbbkV6AwsLYQjmQLSh8hr1gCD0OA4UiG67tbbaFtUQp5SG?=
 =?us-ascii?Q?FO9302i2ZYD3t51nzYad3GekHMFc+yodhoHPmc4EFbphJ6GcCu44wS/MXk5c?=
 =?us-ascii?Q?UDygoVduiRoTJuU5mgg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1661be58-2b32-4ef7-62c3-08de118e3cbf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 17:12:53.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQrUpw6VkO98I6Cr9cbk82FwUhw5AlgBIrY3lhc7e92zKx8Ku4sq6Yh2QZpNJpB4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125

The handler in usnic just prints a fault report message, the iommu drivers
all do a better job of that these days. Just remove the use of this old
API.

Acked-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/usnic/usnic_uiom.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 3fbf99757b1148..f7fb6246c83aba 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -51,17 +51,6 @@
 	((void *) &((struct usnic_uiom_chunk *) 0)->page_list[1] -	\
 	(void *) &((struct usnic_uiom_chunk *) 0)->page_list[0]))
 
-static int usnic_uiom_dma_fault(struct iommu_domain *domain,
-				struct device *dev,
-				unsigned long iova, int flags,
-				void *token)
-{
-	usnic_err("Device %s iommu fault domain 0x%p va 0x%lx flags 0x%x\n",
-		dev_name(dev),
-		domain, iova, flags);
-	return -ENOSYS;
-}
-
 static void usnic_uiom_put_pages(struct list_head *chunk_list, int dirty)
 {
 	struct usnic_uiom_chunk *chunk, *tmp;
@@ -450,8 +439,6 @@ struct usnic_uiom_pd *usnic_uiom_alloc_pd(struct device *dev)
 		return ERR_CAST(domain);
 	}
 
-	iommu_set_fault_handler(pd->domain, usnic_uiom_dma_fault, NULL);
-
 	spin_lock_init(&pd->lock);
 	INIT_LIST_HEAD(&pd->devs);
 
-- 
2.43.0


