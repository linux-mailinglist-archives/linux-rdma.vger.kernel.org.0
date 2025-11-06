Return-Path: <linux-rdma+bounces-14288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A3C3D5FB
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 21:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 24B444E7177
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 20:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C748C335080;
	Thu,  6 Nov 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FJLmR9wr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EFA3321C7;
	Thu,  6 Nov 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461310; cv=fail; b=ftF0AFCjYVwrgh/UQJfGRM4DbPfie2M91E6SWp3l8ux1JJWhG4EFgjJbAzoxSpXaTTkpUDXNjnILH4NGA9c7x+a9Y8iotucv0fa24vPL9uBpy3LHKoV6kj7Tc1OF5K8nM38PpejmVJ8MlYIiu2y+CO/oQIbfuxOeGmTOpc7CYxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461310; c=relaxed/simple;
	bh=/zp5jfVIid89e1t6cQsTsxt+n98wjbO6xxc/yFNvYkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KLbOZ1/6u9uiV3KuLMuyq7s6y2VEcGLBjXlLEdLL+xmg4vHfdgdD3ZCPYvkwErOmXAmd2H7gN4c12DQ4xPlA1tgiP3bGRzH8mUiuPX32bI5hlfqUHZQ5QWoknGKHIIrSnFD2jluzIaHDy3vGQLuQeFGjJZ/xFQ8th9YQxT2muLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FJLmR9wr; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9zJ8Ut2dYLOxnbryLJJJTn2s0XilS1SD6QmQiyUpav90bJKOMyqN9lSdAdVeHGY6HVcMMSQboaV/5nsnBguC6VwmYXeNN810KHahr2gMrSNh5qjhWgO0POsS85oK9qMUQde8xxhw5C+UHUJbyQNZ9eqKPrM25Rj6UWGlx0HXS3XbjKlq7wdPcVvTCRbjgU51amQVsK9MhIzH+p2RAfkq4CFa2KzIdEQ9rEYjvROjwcpW8jW0RZuF3vyVvjXwrcakWfd7jz/ZcQJ8o43Fqzy7uKh1Vc41KkfoItvhrx3Ffd7E2E0Nvy2itw1Ywf5BqnBoSjH1S46kunPMhsAr2NNdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjGlaHIz69o8hPoDvfMqSpAmwihFcxv4HwAXIJoZdfA=;
 b=i31JSNNHz0yuXBsBWVDM6iFbJX09r+Pf+AzGr2mpQzsVGcdCVbToPN2i4ji5tnRQHv57N0tLQ+JD62tWpTiHK1Ax/4skyFgazAJQ2l+sAD1hCdV+cm6fxXodsbKHztNCS0l9f4q1BkXyK8hx7m3W/QllOKmWMOgnJI4+1pR6jmeY9lYYHBXzKsW52mDs2XQZn9Tz/GEV19YLbJyRZIYhcBRDKmDXWNDy9iJ0MscMJEMzrZ3hXqFF/SQk4wiIV9uuSk7HOjpOAUeRdq3ikzrkOayIMaQKvbBqtGP00M/Dg5NkDa2JZv+bUelMSy0YPmgQGkbnUt2LWkzLPIIhsHOoqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjGlaHIz69o8hPoDvfMqSpAmwihFcxv4HwAXIJoZdfA=;
 b=FJLmR9wrfkaeId8YRDKYCIDrSuvzI5wQwMjeWyjdNB+SigZDHUcsdCoBdaoFaTgRfNTasmvYD5U5be8XrC0GPiDtoAr2y3DvuR6iJJ0o/X/gePgHEqpRLT9DMCV2o8uwLqxUl673lYOYm5NfEdMxQkxfA7/F52NqUyXQ3Sds9/Z9b89Yikp2lQzO7TOKf8OzxIOqtw0m77RpjIZLUa9C0sMuTpgGYKdOJaAmMaTJyW+Xa79zE0Gid4XTEg9ei1Hs5nXRJ/V8xcBDeoo+w1e0gIwIQdqpMKeOqn/wSkIgd1hJp1b9Y2o9oMBcZBTZOOhtNxT7hGpgdWKGiWRXOo2cJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SN7PR12MB7108.namprd12.prod.outlook.com (2603:10b6:806:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 6 Nov
 2025 20:35:02 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Thu, 6 Nov 2025
 20:35:02 +0000
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
Subject: [PATCH v2 3/3] iommu: Allow drivers to say if they use report_iommu_fault()
Date: Thu,  6 Nov 2025 16:34:59 -0400
Message-ID: <3-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::22) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b919955-67cd-45a4-6d0b-08de1d73f596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Auc7sGIIt5n8LnyZiKQpy7WKLHnpLDn6xmPBHv4A4TbnyLQqwCLJBSSAIELN?=
 =?us-ascii?Q?qIok8e83r/pvECkL764znxbmy72fhyqZCipI+SxfAhTFCb5GhJCRsP+hnbnW?=
 =?us-ascii?Q?J+bob6Y/UDrkP/c+tWfB5wFPTiGcXCNgz9W9LOjN/KEavLJF4x1Z++FSFxmV?=
 =?us-ascii?Q?OOsC2Gr7pPR82plZ3BNNLSxzjT051IpAmEZjA9ggPtW0C2Tt0TLwbcfLGNFy?=
 =?us-ascii?Q?DVmg8Y6K1pIE5XQGHAFF0SzC0spgXQt767suXMT+gn6t+LcNUvjljW38OQa8?=
 =?us-ascii?Q?xm6WSHJAHnZEntiPE7Fp2xxvaR2q3Gz2BdaNdWwZxCvN3tBx067Orz7h7Dt7?=
 =?us-ascii?Q?GuYAY+1DueLpvxnSLLu3pl3bhLrSYSFxvpw4VuHVHvfp7pp1N7I5VxPzDVgh?=
 =?us-ascii?Q?GyqTT2L5KFVnZjHBjiDghcYBfXnBLmzV4ZTEGF+QP6hV9FHTKJUzOPvCEEAY?=
 =?us-ascii?Q?zN9TjNYtmTOWnr/s+YkxPaA5OPKbUXjSx9T4aCbcA85t35XGew/v5cYpKTcH?=
 =?us-ascii?Q?iTBeVrHj749Qq/GkuhCCvs/CIuGSW9QP4l0BSLQ1OqsHj0T1dkUZl/fWszFa?=
 =?us-ascii?Q?tm0AIrKk0MubC4VtLVtIL6AExTM3VXXYqByC4ChNlHLQgg15HvhLa5qrxl3A?=
 =?us-ascii?Q?9RR9T0dRdHg+GtUQ/Dq8VE9ZY2LlPrb2KJcvffZIafsajm2ox3OFRwzDTWQ0?=
 =?us-ascii?Q?nWQFxtVmhOypU+EjfEmShdK6rIBDbeaBsq1Eqjba29SErtnc9WyfyQ6iHmI5?=
 =?us-ascii?Q?O/njRj8kAL4Q3BYGZ+PjxXf6br7v0avnAhAT1fsNnd1nFgSdwbs8CELOW2cF?=
 =?us-ascii?Q?o+MfBu+1qXd02tVeaX9NB3JSReivOvRXkR+gQubSnOBhaSAfH79E+7O10hES?=
 =?us-ascii?Q?spx8B1RA/dIjw+Q/Z3y2rv33KEeUmhsBUMalT9Bp7puvGvSui2nt2+QVuIgk?=
 =?us-ascii?Q?aHDNvhU4eSd5GB2j4MZ1xWlNISN2xnxIgAqZCap5mLvXhZTIYzBjCUkuJP8F?=
 =?us-ascii?Q?tObsZAZHJvm+1eNZR0sJ9+VwaQWtsHRkKiW8pAk/qF4R+IU6qwrsiaUyp1mG?=
 =?us-ascii?Q?CB5ZdOEKtN5/eHkVLV5GCmK2OvXsHt+Wo8OrWK2HS6GlP0RcIGiB2ETVgC5p?=
 =?us-ascii?Q?5Rvhs1FYYfhLGz93ljEOP5CnlhEIZ09XEhIOn+i0pgBoIOO804rdVskATqns?=
 =?us-ascii?Q?6IbHmguiD2BCTDZg/ZpRBrGXEPqNSycOVOAYL3FMRd5RIsPrP6wmHt2jRSWM?=
 =?us-ascii?Q?zAcqe5HpCpjYecJJqUw75vUZFyDmZPi+Tm/Io/XJsIJghPDBl13OJVue05tp?=
 =?us-ascii?Q?0sJ/RZ3rGhhuKW3D1ojxTyNCrK8+mwITyKKFtn8opUOriJ2aT6g/Krd6/TbO?=
 =?us-ascii?Q?xiz1B7ENyfvHUYvtTrFMEp9IwBXCq0Nga5BMPEBKs4pnHTIzMF6NivZgyqS6?=
 =?us-ascii?Q?+ne78nuJrTf+Dal8WBL5DoBKOhDn2mfhbC4gn5r9d0R0TUyJKgd20/8Vr9yR?=
 =?us-ascii?Q?N8sDIjeqv0IyVUE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7+jFhWT5eHxVVTW6nt2bJXv1GKIzovNYohBZBp6Z1M7ovm4nl+UP89U9lVE8?=
 =?us-ascii?Q?NcbHy/7aPPC86PPCBsVIDAefbItahF62pt9xrrmLhdtYs4lckTgacWK4mzvL?=
 =?us-ascii?Q?3lEmV5xPQxZGKakEmvIHZ+aD5TV5Bc/aNGB7/p6l/q1A/fqVOIhQuyDg+fxL?=
 =?us-ascii?Q?48qQeAazFfxFJ9RCR9wHwYShl7Ou76TTSKaeJAUbykuVkw4ewiKe22T/c5Uc?=
 =?us-ascii?Q?9yUOzEdqg28xftrhrrxeKI408q3WIwarsmYf6oLXUeQiS87TQd0lGPB43fMs?=
 =?us-ascii?Q?/NDA5/Kc+M4UFmDab6uLfjA5DTPIjJ940/qBsXE//rxGBDD1TIiOsbVoAbez?=
 =?us-ascii?Q?BkTMITr17KxQ2ELBV1z/pgXFToDnC3ALop98fC4dH8P6Jhc6LNF8MXDW0e6v?=
 =?us-ascii?Q?qKRe1xg0jhdURLxBjBzvGE9fD3Zok7k0TTL6egFB66o0DvdLjdGbyuCUjDPY?=
 =?us-ascii?Q?2h9M/Q7AzMksreb4aoP6+3j/ZkuyO7z1EvVRwpjnbwPdF9c1uCB+1M83z5MA?=
 =?us-ascii?Q?bkmOR/R4L2ZQrnEKI7lPL7dM12A938mAB3PqtGheZfTUs3eUQCQ42YVVK/hL?=
 =?us-ascii?Q?ihfSAv0oPjJTiM6i7SYFLSHwY6Xi/lsiyNnDvzNqP+Si6Q9QoefxCjidvc7F?=
 =?us-ascii?Q?oygcRsP5ARuZsbe2gXYmR+AizWxs8/1Zf04BZzvwXQVLNn6j4DAjHc68n+M7?=
 =?us-ascii?Q?JctYrYufYCEd+b4HVXx39wDzRjjQxgxoxF+yOVppaYDWDZJdT9z5hfN1dat4?=
 =?us-ascii?Q?gdJ2HuWcwUXmkmxTd9BvT5pma/UYrh3N6UC/ESjHy3BRprtd3i466SOfbIi8?=
 =?us-ascii?Q?T9J5248QjnUAmw1bGeW2R0AQmfAb7QCemnhqP7vWPPTVQIF3eoyyC9cXBR3S?=
 =?us-ascii?Q?xMyn0gwigJPG+keagRQQPyomiwE0ysq9Z7S6CplrDU8x60ABHbZGMH+gow26?=
 =?us-ascii?Q?YYx0/XzGRx+KVv3yvGcK778bXJKkQzt6nA6q6uUTkyqZT5welzhsiw3ZS4AF?=
 =?us-ascii?Q?RELtuMorvX9QCOBj7sZwQ6ccqPEH5ptU9K6WR1GgQqgixzuVR4Km8Cpzh9pG?=
 =?us-ascii?Q?Y30n9pkUc2dZfezV863LXPPdP6IpRtwWwJN1rycY1UTFqs8Bued0u3ygobng?=
 =?us-ascii?Q?38COjSSDT9XEuqnpwUDytbFcPEwZScZq+BrzaFKwN6xI4/Rkmo4651jimzVn?=
 =?us-ascii?Q?E63d5kknTTazCnjOx+iEM9A7WnIuC1a8VLK2ypPo9DogKBmTrzT/w9wNOCXQ?=
 =?us-ascii?Q?srKRBk78tJdzA3xp2bb7RfcQctnne0vd4FB/33nAdEND50tP/1lamMEVQD0V?=
 =?us-ascii?Q?SzJItBO/xNapaD1jIqsgEkYiHiBd+6evYVoYZeFc+7I7+sA4DZS34zYtGkQO?=
 =?us-ascii?Q?z2ccLPT8XC6d7zJJisHpGv+dHK4YLeliIEVtBjf6bVaSHPzY2makpbwgvHTy?=
 =?us-ascii?Q?ZKSiBSJsS2e+WPZxWeQm+Bxua7e5VLeeXepqm3W6rmxewSkZuVFeSWWGYLpF?=
 =?us-ascii?Q?to8Hw0jRO/ABulJdRMDckU5cgmewOtnHSwmKUDGkvA9e+XD9hSlKshKDQfGa?=
 =?us-ascii?Q?erltcnWb6foEuv4wpkc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b919955-67cd-45a4-6d0b-08de1d73f596
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:35:01.4070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijoR5zFUspLJGictDbbGfdJf1qV7yxezHHkchjfJSkvlDvQs7X3ujChZtRYtkJ4n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108

report_iommu_fault() is an older API that has been superseded by
iommu_report_device_fault() which is capable to support PRI.

Only two external drivers consume this, drivers/remoteproc and
drivers/gpu/drm/msm. Ideally they would move over to the new APIs, but for
now protect against accidentally mix and matching the wrong components.

The iommu drivers support either the old iommu_set_fault_handler() via the
driver calling report_iommu_fault(), or they are newer server focused
drivers that call iommu_report_device_fault().

Include a flag in the iommu_ops if the driver calls report_iommu_fault()
and block iommu_set_fault_handler() for domain's of iommu drivers that
can't support it.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
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
index 4ced4b5bee4df3..f68a0576b9a3a6 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1643,6 +1643,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.owner			= THIS_MODULE,
+	.report_iommu_fault_supported = true,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= arm_smmu_attach_dev,
 		.map_pages		= arm_smmu_map_pages,
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index c5be95e560317e..173d5957796790 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -597,6 +597,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.probe_device	= qcom_iommu_probe_device,
 	.device_group	= generic_device_group,
 	.of_xlate	= qcom_iommu_of_xlate,
+	.report_iommu_fault_supported = true,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
 		.map_pages	= qcom_iommu_map,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 59244c744eabd2..8d9086a37671e1 100644
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
+		    !domain->owner->report_iommu_fault_supported))
 		return;
 
 	domain->cookie_type = IOMMU_COOKIE_FAULT_HANDLER;
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ffa892f6571406..04a5836bf36000 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -884,6 +884,7 @@ static const struct iommu_ops ipmmu_ops = {
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
 			? generic_device_group : generic_single_device_group,
 	.of_xlate = ipmmu_of_xlate,
+	.report_iommu_fault_supported = true,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
 		.map_pages	= ipmmu_map,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0e0285348d2b8e..ccf6fdeb64a261 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1018,6 +1018,7 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.of_xlate	= mtk_iommu_of_xlate,
 	.get_resv_regions = mtk_iommu_get_resv_regions,
 	.owner		= THIS_MODULE,
+	.report_iommu_fault_supported = true,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_attach_device,
 		.map_pages	= mtk_iommu_map,
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 10cc0b1197e801..3dd6222d210921 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -581,6 +581,7 @@ static const struct iommu_ops mtk_iommu_v1_ops = {
 	.release_device	= mtk_iommu_v1_release_device,
 	.device_group	= generic_device_group,
 	.owner          = THIS_MODULE,
+	.report_iommu_fault_supported = true,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= mtk_iommu_v1_attach_device,
 		.map_pages	= mtk_iommu_v1_map,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 5c6f5943f44b1f..7ba67600f32915 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1723,6 +1723,7 @@ static const struct iommu_ops omap_iommu_ops = {
 	.release_device	= omap_iommu_release_device,
 	.device_group	= generic_single_device_group,
 	.of_xlate	= omap_iommu_of_xlate,
+	.report_iommu_fault_supported = true,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= omap_iommu_attach_dev,
 		.map_pages	= omap_iommu_map,
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 0861dd469bd866..932b5a62bac572 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1173,6 +1173,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.release_device = rk_iommu_release_device,
 	.device_group = generic_single_device_group,
 	.of_xlate = rk_iommu_of_xlate,
+	.report_iommu_fault_supported = true,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
 		.map_pages	= rk_iommu_map,
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index de10b569d9a940..13c37b1be481d7 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -848,6 +848,7 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.domain_alloc_paging = sun50i_iommu_domain_alloc_paging,
 	.of_xlate	= sun50i_iommu_of_xlate,
 	.probe_device	= sun50i_iommu_probe_device,
+	.report_iommu_fault_supported = true,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= sun50i_iommu_attach_device,
 		.flush_iotlb_all = sun50i_iommu_flush_iotlb_all,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c30d12e16473df..941e4971b05fd3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -659,6 +659,8 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
  *                    no user domain for each PASID and the I/O page faults are
  *                    forwarded through the user domain attached to the device
  *                    RID.
+ * @report_iommu_fault_supported: True if the domain supports
+ *                                iommu_set_fault_handler()
  */
 struct iommu_ops {
 	bool (*capable)(struct device *dev, enum iommu_cap);
@@ -710,6 +712,7 @@ struct iommu_ops {
 	struct iommu_domain *release_domain;
 	struct iommu_domain *default_domain;
 	u8 user_pasid_table:1;
+	u8 report_iommu_fault_supported:1;
 };
 
 /**
-- 
2.43.0


