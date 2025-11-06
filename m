Return-Path: <linux-rdma+bounces-14285-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1621C3D5E9
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 21:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43007188C4FE
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 20:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF513304BB2;
	Thu,  6 Nov 2025 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CQCfDGhw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27727F171;
	Thu,  6 Nov 2025 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461305; cv=fail; b=XSNtArggB3lP3S/dnAkFK9aKBKct4aTLDcDYeDT1euBatJ1f9CCeVT7i55A/+gqQeC9dRfOT3n+f3B8eb1Sin+BfLr/iB6s5dTWW0tTqo0Fr7ASwPYiyZkrCJ/14+vnZ8RBHw13eUQ8gzocgUXiBY6C5wjaHhuVbVohG0jllf0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461305; c=relaxed/simple;
	bh=5DAnhPX0ppfFoDJVimzDBrLUU/gkGs8mAFeyO1NPGiw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lHmdwADwyKB/hXit1rxA1Ar9LwZL5m0XCH2JSn0nj5R6NYOieT1TDwlHbfgPC/Pv0Qux3ihPVfM0k6Y9TPWB7zZMQ0B/LAwv9MozrC/iXoyS9J3+8pMedGwcMe6t1/MkE7dBMq+Glvrs1PpHmxt2c9ZqyS0z7GENyeCUkrSC31k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CQCfDGhw; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5czvbWuL3mZu6W8qjEDhAq2N2tqRkpeke/g6RyF226mD8FTlxqIY2mFQ1gAwJ5+IfbwpQXb95WSgVgSTWe32xRZOPaggL4aBCNj94C35ODxIWHtn2hFBTutwPofbOlgO6WVQC9hXyd3jeNjn/POYbAyXG+lHl7tVzfXFXTjc+2JhjgtAIdOWf9URg9WoowqZ/UVUNl5cwI3XvZXqudu/3a9sL88LelgAR/iJS9/SUUXtvdGhj9TphyEt+r4zrJmQjz5zq7Yr851XtDmX8WJ/TyAH7LdKj3fOFuIY5r2MMmcI3MorVejjord2Il2Puf0+7SDKbR5kDOe4P5S0I1CEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2ihODDEvLX8mAtUPTU2wOVCebb0knhHKT7OEISaHNQ=;
 b=CJlpydQLgz9LP+r8EH7On/Ain4ALyzv0MjH+Y2npO7BqdI3d3bUe0LYSmwV/9gQTdWov1ZnuLKmg5uhebE/3AtTu0aslKmb1OzN/mNI3z+tRZpB3sgb/NW1BkBUUlr8FrmJU5i6JqiEyNXBNyOmyjNQ0eW/vxcZHYLqhl5BRZuh8VwP2hp2CDQ00mO7WmyfhsdTzczinKEsW45FdZrjXHCIZlZBjvGYIq5J2MYFVUeZLzhtXFuk0/rt30KLFhEUaOdqvTIUTD0AYYUGWLyyEhEPWZz/4sXnchIxXBqx5tt9YNgkFb2ypDig8SmlGNKcbaeBMGrvkKvo2adiDzOKlnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2ihODDEvLX8mAtUPTU2wOVCebb0knhHKT7OEISaHNQ=;
 b=CQCfDGhwpR1IIwGbwNsvm2b/k+9KC7/vWv6KpurNGONYb3KqBLmf7wCfnCq/bUQZwlhIIikljMd+Uthlk4dWntlP48wOa10sz8dAW4Wf/KLsNg6Q1xYFAisDf+LtERe76yrNPpWbfnzC9v4r9APTHu/mG/ETzFGsYbc5Ve/0aJITGagh3SyiVRvE/VGq6zqt6IcU34hn6e0/yvcEJDTDiaHaSW+hbMpGwF0BC7dIpLNq1Pu3UjM54rOhBzSuqJspWSNlsoUzD2wr1lZ8c1hzq6bQapKoBl4K0EADjXU135/8RMZ2PpNqO6lrEt0IEbks5d+xaqQMy5DdhnG4CRlSmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 6 Nov
 2025 20:35:00 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 20:35:00 +0000
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
Subject: [PATCH v2 0/3] Cleanup around iommu_set_fault_handler()
Date: Thu,  6 Nov 2025 16:34:56 -0400
Message-ID: <0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e83ee0-ed88-4247-99de-08de1d73f545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZU8vnOJrAvJ07mx7B2jDOKB5TudGpq19LQAin5lWyAmYOoCXJn7VLhbiKus1?=
 =?us-ascii?Q?OCsd0QW37a+/lUvsrDrH2QcEPXa49QlM6sBwe27nH3gGA/UTKySu1QcAWlVg?=
 =?us-ascii?Q?h3eQikLk1ekrH9v8qzrKdtt6iRgXIwvADF1LfoYzbLO0qSIRTltd+dt90FJ7?=
 =?us-ascii?Q?f3hGSfW/W19NI3CabnXiNVZIEz8E+e8AWa8OY9T5xgESf/DVWaMjEQAUKUmO?=
 =?us-ascii?Q?j9pqPsAtxbzo1cUzNr3ABIT6xfC4/A+ir8WavTBvBa7e0bSiwNouJoKmOqNQ?=
 =?us-ascii?Q?bF7st3ndVd5UuEULS5yluFSHnsBJ75CeSukpBqp6WrhL2NMW1P61rSrLGQJn?=
 =?us-ascii?Q?xKx9x83PdPSL2tPOUSNwsTt+bTzputCcwJyLk2MVkfxsM8eoZQSw5QQyUmJi?=
 =?us-ascii?Q?FayxQREzyUVoTQ3QJDGGXQq+ZkHNU39P6FPawgc/ZsuR93kmC8ElKgPaqD6m?=
 =?us-ascii?Q?r3ga681WqrkvGjvFnWDqQiMbHgncn/x3kj49ZVlqJ5q5GtcJ0LtkptCn9Ydr?=
 =?us-ascii?Q?olpxEkhWG8eXT2R4E/cFkORh9nVsqbZ4amDZx1YBbIDwz1MuqYRB1jSq4uLQ?=
 =?us-ascii?Q?9zMLR48sO9WG/ZrFN1OYTVodzeEq5Dqr1oxp0Gmct0KUBHiL26oPt6PVDsHE?=
 =?us-ascii?Q?IyrvhEK45Jc9d8v5TkrbiGWQbtdyK5wnu0DISi4b477HcFjbQbd9OBIoDTOA?=
 =?us-ascii?Q?XYtyxy7R5yc3ZtIoUEStTwZlyTcOoNks0EdKbjScQL1i+8/imAF+u6DvXwmH?=
 =?us-ascii?Q?W8I3KjpIaniBu3ANSNR7ioveuDN+tNpAltLVo1jZ55HEPn/qYQpD5rfNDd+o?=
 =?us-ascii?Q?wGG5GeXvRYYzP4I2lVjm3IpN2Ze3iUqF8Wx44Oz0qonPa+E7ROkmSfaAA+gk?=
 =?us-ascii?Q?SV4OAOxDpUUL2AMiKbDpJ/6JKnXKnzcgasrRMB27yNISIBP+yxmsE/Qdiyvz?=
 =?us-ascii?Q?kzIRn8XfLyqpKdWU2C91PM4hAPK0NjN4MXyOdE+KqLAu2VHdgRWsu68sgAwR?=
 =?us-ascii?Q?3LUmefdJ+gmyTLEvjki7n4rsAGdRwoASijDehffI4qFk3fAYpULNmyRP7CbY?=
 =?us-ascii?Q?6z56YhB07ofgVb/cEGlDvbhXLaI4aBWPXRplxmOnE+kH40JK4otW63ApyDGp?=
 =?us-ascii?Q?VOhj/RHUlAFIgXv6XCMFnCcZQLltpty5eUQRubfoVl79nc3d+p/qlJqLwKE1?=
 =?us-ascii?Q?2Y9DH18Ggbs+HKYF3Py5N/oI42aYJe7Mr9vgN9FMZCoD98JpE5HueBZwTq56?=
 =?us-ascii?Q?I3yGtfSXoxw9S+N2bUMMi6oicWfGBGinBerMqjVhgBVDeU0RtFyU16CF0bzm?=
 =?us-ascii?Q?XEQCHs9EsKUwQ3JuyiIjhK4UIweQNmyc0vP5H+WJSLw1LcwJlZv93u9zu2CX?=
 =?us-ascii?Q?uRAlhTAQdR0FpYCpKbCbzI4MpZJvo4Tge+VlJFuRGpYc33Vwj6CMwW7RWJOd?=
 =?us-ascii?Q?WiBDtiw5cuPjPpq4oeAmFRfxgO/0fLRwPYoWqZL0Ts4oK4pUIJI+eAzmpC7f?=
 =?us-ascii?Q?pnpItEdzoPoblYRyH75vkpIJEtuRQdWkWoK8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgSHpEPyG5aEQT+EC3mBX0z41Lnx/UT259IZJyNFJ2NmJPpRq4Py1MNPdpVj?=
 =?us-ascii?Q?EyBS2aWfG58SQq/8poSSlK3sVs5QCBtsm+f8jIWesjnYug9NDa1OyyjRlc8A?=
 =?us-ascii?Q?O9GfNAOSw5panc6XAhcghq1LSMdmfx9AMwblptkEH/QzxzfV3jDUffJ5Np9H?=
 =?us-ascii?Q?NZelr1nFAW46fC7Fks+/qQTpnVZsai8ikXynNK4l7anA1PVhfpDQxo5lHdd+?=
 =?us-ascii?Q?OoWiy6gdI/oc/nbSByQ4J/QphSNX2wkCaHvgFladTSm9ISllYPbop+ZXs1ql?=
 =?us-ascii?Q?YG5EhYSGO5v0t2CCLk3bqQC54PXzJBTPCgLhweCbXrA6M0T6a3O+4S+7bPix?=
 =?us-ascii?Q?eUrVJiyKrIt0Zhe+/T0gfawn4GZRBcw6gbfjdvos/Dkt7tpzVyMOXTy7Dfa+?=
 =?us-ascii?Q?5dRggabVXSXnASHNaxj7JAGfLNJJXsvuO1BIDzAs1c6SfDRKQA8MdsMCqWhY?=
 =?us-ascii?Q?h8yKl8swHDDIAGp0vKaswl+vGXjdk2+nzHTRMSxUcfSaDpwYW2s5ZRxjyZaS?=
 =?us-ascii?Q?OdltdJIKMIbnQ7ses6xVULO7fwoaMiM+NK53JWWl0t7PJsm6Yctzc4joffJl?=
 =?us-ascii?Q?XAvZWjNW/2DE3mMUQTGB2Aug4ODOG0cT05xDbdPwccD+/F9ZC3REKBT0HZf1?=
 =?us-ascii?Q?RaWETdd7uaBq9Nw38blyVo25w3kBq84dWbgK5EBjwU8yJf3JuM6MV3KSge0t?=
 =?us-ascii?Q?22rJsNGZmkS63b+yDXYIDGQ9VEfQGo9Ivg+HzyEWvcdlWPnWa9W8+eniNRa9?=
 =?us-ascii?Q?blgwzGxkXmn9ECuVtxKK/j8QBHAfKm+9qEs0Nk8Z1jYqYOUBJIGMRzl12UKL?=
 =?us-ascii?Q?WWe/GiL5pxm/1y/D/5aNsvt4J/YDDdRC7a3Awt+fQrBD2FPKKd1vHSafhCaD?=
 =?us-ascii?Q?M4/vWzWrk2S8FnZzaWM3Xbgr/v30S3TafrPRoO8XQ9RrVwfGRRHsOpq0I1nI?=
 =?us-ascii?Q?/BBC3T7ts0FUco3BmDZPFPRXIwiOKqY9pyO1oFqdzdg/TMlB3bDG0QvbKAjM?=
 =?us-ascii?Q?j/2giO1YaBjYqq4qqrGsW+AZRESZ/6p0tJiC7Orw7wfRWCKQJGWXa13lYfNI?=
 =?us-ascii?Q?gNQw+Z+IPAhJhu8fpINsOI1yH9fFrU9dgtL6gTw8kq74EjjJZK/U24NA0p/O?=
 =?us-ascii?Q?iblqvBUILAVTcl/0hEoLMBbJbgHRAbvn3okE8vJUJPRuKQof19JGr2kh7Xe5?=
 =?us-ascii?Q?8nHgEU0UUFmwwWZseK7ybhMBZ0plXWzjRzGkmnicbGwcWxCGtEFBDAi2SMBC?=
 =?us-ascii?Q?wNEUeHNevYLU/PJdDnRvott2ESpI+uXNO4gHHO/ax9K3r0Y+nQ/D6qYn0egP?=
 =?us-ascii?Q?e8BJpw8rxZH8YePeVH7x/PE/voWJz4Jgy/FqrX5aEdbLko9cVQH9Dhk7QArF?=
 =?us-ascii?Q?/dRnb0zkdzf8EHdic+deo1hDCHEh1p0isFDxVf+I1Q80y7Q4hmxLLoE+dNlV?=
 =?us-ascii?Q?O7VDebOycNU1JpIMzhWbmMUbFjtw2CH0CE6ueqTaCTGiZYkn2OdtwQjeQwGu?=
 =?us-ascii?Q?ZYGEAa+eamYywmBh599qxN0qScMnCckYenklo78lGp/wW0igIpshWhXu2zrA?=
 =?us-ascii?Q?B0GSsvn/KzfMGDYSnb4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e83ee0-ed88-4247-99de-08de1d73f545
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:35:00.8033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBEx087QZQ8FrtbHyAB2YQk89JqjgdDG0GhbonqKpEj8vlolWi7mMfCA7/YOx61B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108

report_iommu_fault() is an older API that has been superseded by
iommu_report_device_fault() which is capable to support PRI.

Only four external drivers consume this via iommu_set_fault_handler()
  drivers/remoteproc/omap_remoteproc.c
  drivers/remoteproc/qcom_q6v5_adsp.c
  drivers/gpu/drm/msm
  drivers/infiniband/hw/usnic

Remove the use in usnic as the iommu driver logging is good enough these
days.

Remove generation support from the AMD iommu driver since msm and two
remoteproc drivers are not used on AMD x86 CPUs.

Fail iommu_set_fault_handler() if the underlying iommu driver does not
support it.

v2:
 - Revise commit messages
 - Move report_iommu_fault_supported into the struct iommu_ops
 - Put back the pr_err in the AMD driver
v1: https://patch.msgid.link/r/0-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Jason Gunthorpe (3):
  RDMA/usnic: Remove iommu_set_fault_handler()
  iommu/amd: Don't call report_iommu_fault()
  iommu: Allow drivers to say if they use report_iommu_fault()

 drivers/infiniband/hw/usnic/usnic_uiom.c | 13 -------------
 drivers/iommu/amd/iommu.c                |  7 -------
 drivers/iommu/arm/arm-smmu/arm-smmu.c    |  1 +
 drivers/iommu/arm/arm-smmu/qcom_iommu.c  |  1 +
 drivers/iommu/iommu.c                    |  6 +++++-
 drivers/iommu/ipmmu-vmsa.c               |  1 +
 drivers/iommu/mtk_iommu.c                |  1 +
 drivers/iommu/mtk_iommu_v1.c             |  1 +
 drivers/iommu/omap-iommu.c               |  1 +
 drivers/iommu/rockchip-iommu.c           |  1 +
 drivers/iommu/sun50i-iommu.c             |  1 +
 include/linux/iommu.h                    |  3 +++
 12 files changed, 16 insertions(+), 21 deletions(-)


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.43.0


