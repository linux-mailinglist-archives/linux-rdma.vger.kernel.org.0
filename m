Return-Path: <linux-rdma+bounces-14287-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED53C3D5F5
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B8624E7352
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF253328F9;
	Thu,  6 Nov 2025 20:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ISkdjELM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52168329E72;
	Thu,  6 Nov 2025 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461308; cv=fail; b=kKkLO26H2jAzxR7kDWrgMSpQps7aDzjZecVlUnlgetyDSatBPy6xlBxKz+EBvS+hLuYjY2KtQxiyGicYprEqky28igGSYxQjym7irKe7rT81RoRflbsuaOWbU3Z+zC4ovZiEl5uO163PhDrqFfFDS4DjcBzhf4OdJCZmR7VApjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461308; c=relaxed/simple;
	bh=zyvUJEdGi6r8zUYQaSD3OXiXB16dr0Y4dtvSkbgXwZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PFRDH+v+XA8Kzs/+SnAQM/yRL3Y7fXpCVyqDnj2UEiPgRjbOmzEvnBTs7dZYSjdsK1f2pqn8woaCdStHpAhdBkzOtDJbUvaz4o2QcupOknDsBrwUiVjLwJYKJtyXu0O2ltrGbCU9aEQ09bs9X+8N0bf1XOhgNRb3iWYz3M6jQLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ISkdjELM; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXFgJIF3/hcq7NVlgQJ/9ctWMZXjJ5IWKh7Y9xxKyXUNULh8wzm0+zdX2+ALQnRVZkZiCSuMFNWcAtsWBmsYLuoxCoLFTvb0w6YyhPG9FGW8xQu0fjvXeeatAuBrFXWOz8GJV92IH34qTpIpgR7cHIObSy8QprWSpLT2l00X+LfVXYKJytxZcvhwyzB/w2VsQFosVc49LpMRSu/X5X4NHkc1mN9TGWmv3MzS7saOOfbjvuiXUTHxYf2rU2NrZ6KqtsVRSVTPzgTFsRmF0CwhOkaJjGJo2dQes24Nljl6RfPUibO64wBZ28HEBB48raVizAJkbvOg6A075viz1MFpgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My24LlDJyOsjOyX8HI6wIQkfNsPWTSeEWuzPouIkp08=;
 b=bo6G+8mPiS84Q/xe93yPYWgfFp2CJIS0Qwa9Dup4Pxpba5Y6BZN/ECvd9SkmGQiJvWejHcpl6a77/KfO4JOTOx2Z+qB9ZP+tqRyrMW/2i5RBAXbIaPCK+gj/szRmiLilxaY2xNQaqnKVAFoHkEprRfTNLoZFJangDWjgB4uaNgYMBs5Dv6SYFpW42RFGdS5M+SHRWa663F7J2PWrW0QitqIKZUIBxClNHDfGfWh4eklmJgslE9A20U/+NX2MiyyUmZxGTFNHMqwjtwHzyOJj0M+dWmIKDSD38LQsJ2JMHRkPRUuaOO2Vlb8I3Uc26t5zh0/cZgvXHs/9GNwjDoyN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My24LlDJyOsjOyX8HI6wIQkfNsPWTSeEWuzPouIkp08=;
 b=ISkdjELMiKyC9tG1kaztAzlRNTz7BFKeT2JIEO0f433L4SDd1buprlhdkpoIJzkByS/i+KU9BQW5s96h/LvMZe6xMBJmZmZmNtfL6xhuGRn6GPUGbMGkaZhdEAek/YZcyEyCOlRw66JUNYcZzO1/HO3JV1bhyoV5UZCYMfVfBeTttd3fKKHqk7GgBxIVW1g9+rfnezOKT0r+Zk6qgi+sj5BM9uF+WOaten0/xSzpu8uRYI5iXPeS40dIaVEO9cItkWYPBXjY51tK0Sxy06OSbyJKNUrt/w9keGyWVwjY7GLntNv64b68kvLWUjIwYt+2iULTUGPTEk2NAmQZwX6akQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 6 Nov
 2025 20:35:01 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 20:35:01 +0000
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
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 1/3] RDMA/usnic: Remove iommu_set_fault_handler()
Date: Thu,  6 Nov 2025 16:34:57 -0400
Message-ID: <1-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:208:236::28) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 350bd9b5-babe-4d75-603b-08de1d73f584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/hNNiGNxQVSb1k+oxM3VGNepS8TVQUQyQWfK5qQcnCnAxC46Q8ER5JTDc0So?=
 =?us-ascii?Q?Z1m+WiwboVmoz+Q6CihwJxZVKOAs9XThRVk6tEOwjaC9KMYzKsG9gCyXRrG4?=
 =?us-ascii?Q?eLNHtz5wpAYex4gDEtdbRVjuLtjgBix4/TnGrxWR+tQi0p7DwQlIZqv8pleM?=
 =?us-ascii?Q?8M8MKOEXS9PCLzl1/NmohrWrJyh16VlgKn885rUFYSApbumhc98qeKaVS50T?=
 =?us-ascii?Q?RwVdqamy8IrxSPg3+lNELZWr6L1yDqxl11JVSeVx5JhnuIA5da0Sr2fApy7Z?=
 =?us-ascii?Q?wGy/U47hSdkO7WB4dBwqsi/VBjr72avLjK/T3NAiIdj6Cmo1ppeDalCG1Dvu?=
 =?us-ascii?Q?Ju8qV2zkAhfHdL0ssT42WOwlOBfz3TmRr3pIOJ9Fh/9co5/TBew/klBNJiHd?=
 =?us-ascii?Q?peZ6e9HtAtoNAyN3IRE4bGUhNTWTh9hH1NE7XI7wr63vnpsPD96g6syw/Do2?=
 =?us-ascii?Q?X9hHNWPKTkffYgEFvIlMy5lPGVxJgdGk2SZF8Kkb3fesnVNsPpf63yynGcE7?=
 =?us-ascii?Q?bIJQfa/ozDHIadBUi2BGH1rzMuGPD1Q4VRL2N71e6yzNqLDLt4qyDhzfnr3f?=
 =?us-ascii?Q?a+c4IDzAjU9lPRJyK9QHYHMmfjes3XBPURCX9+ii0wLe95dqzmEgkVkqDEXy?=
 =?us-ascii?Q?sB5mFPWlHtVxYdXBevEwqJXFEEncTEzWAJVdCbMJIzovL4iHnnFQJmmYnisu?=
 =?us-ascii?Q?4LHBZUIEu6tyxvwIOl4dRVXESwCerE4vrqRrYApHEQz9ZkVuJ3vZyScN7y1N?=
 =?us-ascii?Q?Uuycv+tCpqHDsIHgUZbhYVVovSlgxDkqwgBilzofIukpo0ykk1K+eGIqtzfx?=
 =?us-ascii?Q?MnS2HmGk25DnmmrcGxR9/9pQnpV2H/JuuHkc6eSkGIFBXvL4aVQDZ9JlgPA9?=
 =?us-ascii?Q?TQfFRmg1/mdDUqqpiLZS4Q5AmVYl2NS0AsUnD/axhZoKMOUG9eDRi7lKuNhR?=
 =?us-ascii?Q?q1UhlyYfToyIHrMH90Opy5aIPoAsHfeuymAjafuZPGd6IXpbAtH4MpMIgYtI?=
 =?us-ascii?Q?GppNGv5xJEjnwYU9N82URuyCN83XTXwjpRJdYMoTyYXFxT0snXe+Nv1KQNGh?=
 =?us-ascii?Q?IJNr/uMiD5Nu0kaeqopWVIDv8L+1n4f6pPtk/ynkoyX02rlv+SH0s/6uQpjN?=
 =?us-ascii?Q?Drt62MenA4oO3g1dJ9eZAg8ruWnrakmgt2gVYGmpVXB6FNCkfo9dxo3VHsRx?=
 =?us-ascii?Q?0cnmPkNJA7nFJyZJDcw1tbAyVI1EdREW6GR92gBP5G/g3QkDggo91kpfeqnk?=
 =?us-ascii?Q?YHm5zE0MzkWvEZhmks3BIh4mnZuH5dKx37Z6sWBPq4Asru9qMo/HLi5IkVsn?=
 =?us-ascii?Q?p0OwvK71Nh3J+rpks7uzljgNAm6Q1P1eBpWW7qqR/PXi1iEpfCnL2XdlcuQD?=
 =?us-ascii?Q?XCHkY8ceASSA/PGgKRVw+TElSYFF9E4QuMmI5E+ELOGl6YSi1oclDvVuRckb?=
 =?us-ascii?Q?gZMy2aJx+uFVcf2XV07EUC2XA+1v4cOEMMh/0hDZ4Qz+OZi4IXJGozOKfnfi?=
 =?us-ascii?Q?+VPuizSLZ9ZLPnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NJNZpA6r43uGTdgadsolTzcWYr/wDpET0RpZlNUlehGPvTCZG6UUHPdKEi0p?=
 =?us-ascii?Q?21eSNZDWtQtFjDZS3+5GOfmgMH7WTyBzmGeyu/2A0hhIkO8XfVje7FOe2twM?=
 =?us-ascii?Q?FQ3n9ZMRxQsymyT+UUDMEVXca93qdGM6yb1XGl6TdD8sadcOkeJUMySbiBK4?=
 =?us-ascii?Q?BXwm4jHAtIUzK2aGLxid1LZzz5kVWvd6tVVSn5Ws5FuSU3TQQ2T9tGiTyT8o?=
 =?us-ascii?Q?AoUJRsIhcG0wEmNU+wwog7wH2rqaC/4AqEAUeW+PnJU24m4YZh9S3XzKJQO/?=
 =?us-ascii?Q?ZESlQRYvYFrHPRYgHgBMCZnY7egyeDqTh6SOMH8bRiEauNEvKIhxp9wMAwSp?=
 =?us-ascii?Q?itLcFuOJAUZrkdzQNk7XRqs4UnkL/n6G2Ab8e9N2wVusvrpaovaEbRDUzw7Y?=
 =?us-ascii?Q?3L3Rjtbg0q0XF3s/In/fP3zk2ylZFcgpcBj3zQkH/DSyBu/0mQY3gnG8TiG4?=
 =?us-ascii?Q?KiLK2ewZr4YNgeRcyMuUwg4hgbcMfOj00jxvuKTiaocRm1sweuqjBHWJe1cQ?=
 =?us-ascii?Q?ID0T+0YgXNAizzo4Od2xSRQTApICcuk/8R53XuBV32WhIdUvETZOZytP08UG?=
 =?us-ascii?Q?7myVA18XC4v6R1Ba/Lcz7gHsDgEWooXtgfcCRX1Qv43tj6iRXKkbXPbUXiMf?=
 =?us-ascii?Q?ONyLUXC6XCqdVn2vcSLp7Dd7WTkH3i9uw2HcZnw2vEwg6E8hdq3SVGXXwXrp?=
 =?us-ascii?Q?wenMVH9lQHlbK+2dys7Gb92ndOnSIlqh+vbO0Sv+XFB+73EPFI0LWsdqpPSq?=
 =?us-ascii?Q?+xhg+dY0TBNfKNlhF9l4/XQNgaTT8GhynDGO7RogQoRkGXkb1AX5YXvQE+Ox?=
 =?us-ascii?Q?rydvF8EGHA3SWc46EYsgmxcX3c4aNZHvz9Jin6Xj08zuZRR9u83ydd0zTM29?=
 =?us-ascii?Q?PuFwX/nnYIEjFBJSV4z97dT73aMbon+SaU8tAvGqBDZgNS/W2msJzia1VEAA?=
 =?us-ascii?Q?9BJXhhEoclv0NvU7FqhevPX2pm4YzZzeQkxNEhWWJOgoi4CT5naUxD49/ZZZ?=
 =?us-ascii?Q?MVAW9Dy/Vrp9IJlvVpJhG6L3k4USgWqvIV1EJ7nt0CavH84PgE12kU1HDZCk?=
 =?us-ascii?Q?bLna2NDjMMS5AROMIC/xssvGucrVYDOVZ5SF03jKXiV8NQIkGXZTqWpgTqev?=
 =?us-ascii?Q?V2o6D5DzDyBf2ynYWDIhP/93qECjPCZAF7Ble2xXtyFQLwfwXCXwyj1dtmUd?=
 =?us-ascii?Q?/e4vEYm/YxdHJkIk7N+3w6DQoX3R7h+rwoR/uG8xeoLtYwbCzdfoFzzWdTaz?=
 =?us-ascii?Q?H+gFKQOXVXCpViId3kdyeUgZYqUEEcSChLq52kyMoB+ZTn3punRlwbLALUVm?=
 =?us-ascii?Q?sA/EpuNlzG3pJVua+d+WVMz6HYwHzlvIfde/zH1dMeauzhhQV0Brt8K06ky9?=
 =?us-ascii?Q?3DS3oGwCe7RBY6Qhwu8sUlSwiKeFE8BCbOF9EPvIMUBbD4lIfOy+V0WhmtHc?=
 =?us-ascii?Q?/EPG9khTAbqy0PF0gzuQ6pl3eLZhSLVp0pDGZXg+UWXOsN1bAvefhbO3J5JS?=
 =?us-ascii?Q?dsFlPL6GPbYgGPq25J0fXXTvuQfDw/venyQCUjRLqEDTAfLRsCa/Siy3JNvA?=
 =?us-ascii?Q?A9h1um90PPhkpoFAdUs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350bd9b5-babe-4d75-603b-08de1d73f584
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:35:01.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syDgtu60NZt3FhIKphPz9VczI8/s093USABYwRQaN2GkRv1i6vr/yK0UhysmGCSf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108

The handler in usnic just prints a fault report message, the iommu drivers
all do a better job of that these days. Just remove the use of this old
API.

Acked-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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


