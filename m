Return-Path: <linux-rdma+bounces-14665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F2C761E0
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 20:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 073BA4E104E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 19:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5783002CA;
	Thu, 20 Nov 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ARbU2HsT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D392E9EDD;
	Thu, 20 Nov 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667992; cv=fail; b=lhrrV5HwABaZYjQAbdsG2fKlTheh2UggILvjGYogq3J6Jej58VbU86FNNm892tIWZ0we9MXU17c2r/jsbgg+NR1pS6lg3LpUBKBcB8GJk8ut/065ZOzEdt5nJn+JavgV4bTUs0iO9rz4JppwajSGlsjU3Qdqqj8A/AxTBnNpBRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667992; c=relaxed/simple;
	bh=a7Ax+Yppx4sR06ZdgpuBgpBzZ1KcHfH9MK5sICBANxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tWf52f0XVquSLDzhLPpH3NOPVOpne66dwsYZ6bmeItZx3OhXYIXKwwsZD7HdPJoE/LBVTKRUDflh+GQRoEam1NKekOUVM5i4BgT9Qk7PrXvyMAVBKY/mtNRFIa4gnIQUMPL1aI9HdWKYh8kOFKDM16UyRx0uEEVo6whq9y4/btI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ARbU2HsT; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiXL5d7IIjp6rAoSo+ZwGCqxL8JYUv6OjuCiQTqtSjfPa0XejTIJvQvxwWiuN6L3lh9h6AD8aIGGLva+NGm2E6Pbvq9IhWICrFxd44n36C7DYHVAd2Pcn61iNg80zgHIIUKAMXubdfTNACqzXKjtXYCeMZOvK8btH7J1sYiv2QSxtowV58qr3RszqoRp4vh9VqAuw40G4Jcd0NrMTiR5Sqx2UIY6iYoM5rYQBZi50KOGPUoYUrbsXRf7OCKUvwUGGyqxJ/qXMjzRSNgV/zk39aNy2hQl5yZByI8y/s1w6F7fucPbm6VfSrdxzjcgalo8vFrldUDPc7Zwnfd0PrOSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrKyptjz6cNmuGFVbRBpKvvpe//IznQPvngnXo/D0zE=;
 b=h30aTjONQoHTs2q6MLS04+WiaY0i6a0Y85IQ8/AXxUUBvtMbHg9iyLQIXa4p30JeaT4qiD3z+yBBg49feBm8WOsxT7m89k5NaOSMCLvD/9+qYj96jraAQ/KPFm2uyFD2vpkIlVcEzVUil7vGw63l+E2WHAoK2MuZKYrAtZopq8A8YpdwsNe2cfXkB6Vky+SZ3UI67sy7Y7NEWl+oTlxpsOpE9NENAr90dIZI/qjXgccE1bC6nzJmibtu1gyiYE79UwlqvesFmnLZE0ukRtd5LmDEWqXmaa3rEHBvc4356JBzeE9nG7W+lRs+BaolQ9Oaj4f09lu7K6pW5e7lrXZU4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrKyptjz6cNmuGFVbRBpKvvpe//IznQPvngnXo/D0zE=;
 b=ARbU2HsTVurivnuXOyo8RKIlusvCiQIbO8h8sfbNlhuITvH0L+RnZt6IPhw33q+aDgH5tMIK9K/n8xSqQPlE+L15xcS+11uZxpNTX3isvqtpc75a/B4XXuWW5HBn8VlGgCq6k1q8JUgWOQJfsEgEqgKfKpm+zJn6VjIqZO/7gP1RmH1St+ICc7axpPdJmDWPuJ2X0m1QC8n3cimCs94DB9ng5320dwcXfIHYi7tGtLRm1u2T+ZQu8jSIbj2tRdXgHKUv3pohpGK31Xc0EjSzzXJ+nhqTdhWQxC8QFmhuVbmA1xHXg4phNAc91clXgTGZwap1mLX1Qs1yF0PZljY/fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 19:46:27 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 19:46:27 +0000
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
	Kevin Tian <kevin.tian@intel.com>,
	patches@lists.linux.dev,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 1/3] RDMA/usnic: Remove iommu_set_fault_handler()
Date: Thu, 20 Nov 2025 15:46:22 -0400
Message-ID: <1-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <0-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:208:239::12) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: a96c500f-b0a2-4705-6e61-08de286d7d2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dF1PHsy6GRLGjB1eVe1VV8uhvjdAtzgSlW789nTQp5pbD1EKYVhUIEf2dLUa?=
 =?us-ascii?Q?LV+xp3bILrz6F3w7hz2BMEcdOKUDBXh5dUK3YNTQUpml92jsX80PkeMW9aEC?=
 =?us-ascii?Q?KSy1zC7syhcb4VPm+0fnvH3AY5P6yzBzHH8kan/MmVdakgF+XWcuqVx4HdxL?=
 =?us-ascii?Q?azguLLDTTP0HxjmV+fBi/PV7noERvw5//x56NV2UfKwJ0BpU/s0J5QLIXoq3?=
 =?us-ascii?Q?mhbdxdd/YsM548NkBrAb0gYzRLhIhF0V8TqzswQ2WtUfVYVEEiD3ZnZP8YOC?=
 =?us-ascii?Q?JmOrBMsJCl2X0AI3PdSgiXNBM9W1aJrd11uQIpOkfoDEQmXlbUyNu6+GrIaS?=
 =?us-ascii?Q?dJmYBKvwFSKBPtMFrE2Y4j0avkkcxs5VZN8Cav7+YKNl1VLqDHMfcOf5P2sd?=
 =?us-ascii?Q?iSjmgQNoANKDGDi5DLMmBIJdoUwcdqiNjPB94A321LSrgYTrCIlJyEm/re+c?=
 =?us-ascii?Q?di1Bo7Yc8l1OscirRCwhqm+2aLQyDV89N7qY/SnvI1aiAqoFggCnsN6gUE16?=
 =?us-ascii?Q?I0KjEkFjTAoQYnanDsCmWPkMswghsWzL51oSRkDH/CMoQ4zz6RxpvIDUnvNE?=
 =?us-ascii?Q?2cvr21ahZi2lJ22Nl84AfZBAqFBtytYnIJ+D94RrVGjUNv54E9AX6Ah9ZtgH?=
 =?us-ascii?Q?/oZBhWF8JYqAsmZT4nhoc71yEPy0IeFQQDckNBXcZxIuAe2TfggSWpRycmQA?=
 =?us-ascii?Q?5DFLLspHWodypwMt43S7s00Of5uK+8Xbdea0EiW6Iy5KXXbkvBAGfTARFafC?=
 =?us-ascii?Q?qk9H1vde7Y3acU3JWpYkdJTVXiWrBowsIHw5HPS5CLrVDoku2EuXROGTT7VZ?=
 =?us-ascii?Q?vOJwVch6cmWis0SOxzuUf1LaCyICcedya363WTjSfowmEmPN+YTRcHBpiaRR?=
 =?us-ascii?Q?hag3vddPYMDOLuaqYjgOHuKoKsygIawcXyHEBdqK/CYRlIV4pOoYLgDprH7Z?=
 =?us-ascii?Q?QNnPqANcfgt8s0PorZN8rp4PX9kYWEvBF9svTQ8WrtqcbcQLWbNaHjKHfdP7?=
 =?us-ascii?Q?f6I/DdnwiTjFqyWgiOfVQVaBxWZ/qKHRxqugDXUj75URyCtohZ4w5ffxzKXq?=
 =?us-ascii?Q?ESl4tIYs2vk5Qvqa/3+ZtKuSKwjIwt9pmk+epOsQVM7CJwosTes7/aqdpBGf?=
 =?us-ascii?Q?VOzvJ2vFyaW6AhcSp92xO+ouL74wIILZ8BywEzKYeDmXfiOHmYBvQiEJxJ9P?=
 =?us-ascii?Q?wUtpgSM7ypIhFxh4DwesmXdEzOeMP2h3epd57U9UpLv4oLqGfcxgAJgepQdI?=
 =?us-ascii?Q?xs5h/JGqnV01HSJF5MexkLT5vYvjaPZdqYv6LASaD9QmjcASR1RdC9s8aN0P?=
 =?us-ascii?Q?zo5kr1lIhFM/FF60hr757sPPoLIYAI4JeuFCM5gx7cGSEcQ8WT63CGZRXwO2?=
 =?us-ascii?Q?++RfUq70jajQ3NSEv93UK0l5M4z1E1cwSztDsTsGLkF3LtGkcCLK5g1o0I/1?=
 =?us-ascii?Q?VjfJsIviu6e+J9wGqyPyJzBQHJ5DbcfmOiaWr8IrgvtAUlEThkDGx1QU4fdU?=
 =?us-ascii?Q?vQjSwFjX5omGqRw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RGlPHjDFbrBxcG+C9N/LHjqlls1Uy2YcwC9ThDri72VUUVTGaXMVcnHDfAK+?=
 =?us-ascii?Q?FN88b2b8UP8ACdkaWz+EHrWxAiu1q4KY38XovINlroAGTDVCZI4dGY3BccWi?=
 =?us-ascii?Q?m6iwzjliTKSZHECvQFJ5fD7Pv/v2wgvS73TXncToPB9rJVYr7Dawkw4WeSPK?=
 =?us-ascii?Q?zxiaDX0PKXMLWLFkLRJP5irpZhG1NH+vF0wU8sGWdD2WqW1fEjSqMm/MlKZR?=
 =?us-ascii?Q?dUBpx539d8seF3dhHC8Tpv1Sk6gMj9y5HEElljTDydIUf0rjLbJnjYE5eeyt?=
 =?us-ascii?Q?HsdNaHr3vFpwwgKNIjdaVCQL6eUYrplxEeBkrwknri2wi35VL5S3+i8cgpUO?=
 =?us-ascii?Q?TeDuX53Rc+yNxi/tJGPGASqrxHaxnZPw5nr/8Se+oYTRStjn7tQG5D0rh2wV?=
 =?us-ascii?Q?tqD00HWq/AkA4JB4eg5oqyLarJwyfmtpHS3cyRaCR9wwKEhTqcvA1Fa2Ju1M?=
 =?us-ascii?Q?fKpUSNJwaGEKcYQpC9MmDTp6DqWdjelH5iXRSEGwsGWcpYlAV40wlhTwv4gk?=
 =?us-ascii?Q?e1lptvj7EJtjUnayhZn5rRRDQ5fZXwPHY0zugnkh9zlzvw49UBIeNvZiHMJa?=
 =?us-ascii?Q?N7Mlo91KKSrJ3BeGPDx33n4LIZAKl4nl98xscNnhf8rs5f3Uu/UtnnjtK4zb?=
 =?us-ascii?Q?/LEcmawIxt7hZhCJdt7VU8Aw3XjxMSwRoqOHqyY8FkOcCraZ1n2HzJ9/Liof?=
 =?us-ascii?Q?t1cKs56zK+ABsfVsT2Wur1lyWZsT3TPP0Dk/NaD13SfG0CD7LJXN/GM/fQGO?=
 =?us-ascii?Q?PgUeFL4ZmeqKGxIe7lQQwignSE6mQ/jcmGsDKQPYHCvXMqyTZi1Ut1huZTmG?=
 =?us-ascii?Q?uop1EdpO8vr9bgBfN10HPcxc97qarubiv65n++T+blsQgfKC+X8ipAAKrQ8d?=
 =?us-ascii?Q?on6ybyyonsI/OBLbdBKUhS1Nh+lgr7Fmn6s4xj54UkvkWKDmC/ktqki50c08?=
 =?us-ascii?Q?zCOjWPnLMgOxfh+AA+EVadfqLBAQvgOwKUQ5V8uTV1Esxw0Oen1paNUWf29W?=
 =?us-ascii?Q?Cfdq0M9p4eMNRlnLrM19TrMIL4a2AiazeLlVyW48ocX1jjwjqbS+aP2L8PUW?=
 =?us-ascii?Q?jJFg6efy6h1wu/cfYk3ZWlyNSxNdY89gpbKVqc1JpeoAM6olBOWuHf8w2PKE?=
 =?us-ascii?Q?/Hbd7krkZcWthc4TrU1G0hQRYhkANsVXV5ILqOW+IzBaLDezDNfMpgqWSp93?=
 =?us-ascii?Q?xne3F+IxSLHBJb619PzSQPWuTZ1NyWZhQNrGzwRkgFQcEM/eorQb5SY7IIkV?=
 =?us-ascii?Q?1QcLkzFdDpoyg/pgmruQM9KlMdGEwvXbiS+yW8oGWYtFZXA/w8EdayPqOnz3?=
 =?us-ascii?Q?Gbzagg6+z0G6es8PMeKt1Bk7wrPteIDT4hK8GmZHe9xDUPfHLjFsSUIzKkFR?=
 =?us-ascii?Q?dt3yFt+BP41ccrRI1HmDfjBKJ7zKgoNzWasww+QVs7W691gDtrkwxA4qwV8S?=
 =?us-ascii?Q?ehgvZgQmH/PLUL6yzy2aZx/rUfx0BlzaUCxlJHqmVW91PwiUSVJxQw+fPFx6?=
 =?us-ascii?Q?KpupMLbNoK80u8yAextQpSn/gh28aK13qGf3xSK9UIjue1ZtPatodlVF1xaw?=
 =?us-ascii?Q?VIJBjdu2IioreGrZRtA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96c500f-b0a2-4705-6e61-08de286d7d2e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:46:27.4184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wbRwO94rnDJ36fZ+w4citcVj0xSOwKpXwrR0gxvh1N9Kf1dOGnlYHjq20+n+8iK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

The handler in usnic just prints a fault report message, the iommu drivers
all do a better job of that these days. Just remove the use of this old
API.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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


