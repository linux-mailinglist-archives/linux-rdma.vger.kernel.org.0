Return-Path: <linux-rdma+bounces-14664-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11030C761DA
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 20:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEC6D4E138F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 19:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403502D47E2;
	Thu, 20 Nov 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LxUfF5Zi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012000.outbound.protection.outlook.com [52.101.48.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9256122579E;
	Thu, 20 Nov 2025 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667990; cv=fail; b=N+ILnVz0gcTA9iOG9+m4Y5bPlNX0mS0jfU3SY+WfgRZUJ6Dh1IdWiT64anY18ucd8gOyGq2u4tDBAuh1N+QUiN3JwQlPqbmhAxmlRvr7tMhcSVdYAm2wsttpSZFL+YHflxZUDWV2paqbUw55bx8VDJuGKMXJmyJKTXoov4olT/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667990; c=relaxed/simple;
	bh=5iCYWvOeGeDlJOVP7IiHaWl4RCc6jGlAkLNdpBDKX08=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T1q7gJNjWyJLqpYKe8E1XKAOlNMqhVxEkhSB3E48sbUT1gC/ShMR7wQsAFaZe9zSQniuKHpT1Hm7K5Gfya7oV0zt+txYX6vJXfYyU/4diCxHIF6UW9kZw8y7X83WS3Ma489R3Ld6Ir+vlN5dNI+1/eWCi1rsjOjlST1mkyfEbZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LxUfF5Zi; arc=fail smtp.client-ip=52.101.48.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGuxhLPJu6VCuvKCiK/OAmQdNcah+++Xua8RW9aHjwgeEDOCQX7emryQCzFTOdAW9hX6+T/uTuWCGN1C4vMY0WniMzAGUhen2xPU17jIekd3h5ERvp2RIpcwbZ4d8CBlWNtKKCVRUzO3avVRQ+c3at9FZWTfkrr5MVqyIcWnvZMeX7Esc69yhEalGZqs4fDvOxHCDaysS4fvywUGj3Zll+Y3VKRUG9CHTaajmOrLF3yRm/CBrHF+l4dc0AEfvH3HF5WAu5zHIUFozpU5aImKac2Qo5fK4NxqmeNqzp+1VwKc2ldJmnqGKhm575JiipG56mazr6yjE4FcW6u4skid1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1s4Ao0GRZQPw7FSxP3Dz7P79cEUvoJzTmfciTXnkVw=;
 b=UEHYVRqX2dFjcsenxXis4drbY2nTU/tksjBx7qfVeBrgeOQQ4Q+ca8wtzXk2rBK6kS9pViKELAo7EzERXlzjejlXA6+TjRkTwfl+mBOdHCIPsceJtOZAI4HxWRSqEad+jyDGZEURCUt/K1cmEc1vyI3YmW3eTwLTfcbDgZ9PD9ceDYy9WNLHEK/GLfIIcFn/yD7CVm/vHuIloaTAaMy8NnSPx9bTnVnOqwZ9grvi9JdrrHE+kDY0Gub7kRXOrvmxfFma0GGSc6S4dVPWJi8yLl4lG23OdIgpaixleoQBAKtZ32bKaelmU3v7NaIY8Dv22g7gxUokZtO8e7dNsKfA1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1s4Ao0GRZQPw7FSxP3Dz7P79cEUvoJzTmfciTXnkVw=;
 b=LxUfF5Zi+wVFR/PXBU4uXLe5uM2E1K8mnKb4dcsbJ5XujZuh70S2K3rP5aLyhNRADlc2xpm2YtT7VzI0mxSBd5UQf33SYrXo8atwPAhWcxkRdbIYCGghFUYyKOMUOatMxGzZuQP58AEPL2Dii5BoKGpcLA0+NMANrc55A+IcbDlyKxDeuuJiHZAdrDfeTw9yi670iyxPS5zUzGvZgfsJ+B2NeRWbJjd3MpynhZ3T9mDaZJsFZ4aMYQHePxtdiAC/hwE4386hZJ6gE/WNYNzgytV/znjwA64Omgr81LFYNNA6G6d3LiOzCHLNCmgU/abkN96R8RDJfTMI7GZFNWl0wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 19:46:25 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 19:46:25 +0000
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
Subject: [PATCH v3 0/3] Cleanup around iommu_set_fault_handler()
Date: Thu, 20 Nov 2025 15:46:21 -0400
Message-ID: <0-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|MN0PR12MB6101:EE_
X-MS-Office365-Filtering-Correlation-Id: e57eead6-beae-4389-6428-08de286d7d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ktiZbdTJZ6lXL7GkHn1n8sW3avcbdqdgAl0VyBRcSU2p2iu+iAT1tttFE//L?=
 =?us-ascii?Q?VgaJaioH1Vywz0QwzmSe9UqvDoe+91bchrH2WpwO7NtKbhUV/ox43GAYxhi2?=
 =?us-ascii?Q?N1DvWolcvNQdzSox0iLDDsModk08G8bLfFNM9KX9M0TKnQ3xHPJX7b7LeNTk?=
 =?us-ascii?Q?4Ozx94Yz45QNWAZJYCK2Hn/s75nXn2B10tS/9p55onRjGJ8vh2DVu9WCu+aa?=
 =?us-ascii?Q?UFAAcbepEbiIu2ZqmZIq3W0NpLJ5qPcV5LF9GCZDVbbGB0Gl9ruOncBPW+UL?=
 =?us-ascii?Q?fv2CuRUHUIwIwRNX0ZK++6G5li/ixzQTX93Com0pQcrIuKZZUQiZGluT7/n4?=
 =?us-ascii?Q?wE1NpgXvjcog6SL4LWtZ+lOJga7CSiafiA/TvT/1McWfZx40K1q0R2h3r7H0?=
 =?us-ascii?Q?3L2mqLHJYWYrinpfEAmtDVFBzeUllgWqqCPRn2pv2U5kCg1mqReWiQ4yFAVu?=
 =?us-ascii?Q?o9tJ1lTsASg1t/kqBous/hJrswT4vMizEu9Ebe8qOrmxo7LhkfvMZlrmdxIF?=
 =?us-ascii?Q?Q4zePS93xyGLsRk3h1LzvP/qDb2RL3tLZdhIopvRA/7geLYt+rdZ5vii9rEI?=
 =?us-ascii?Q?A7gJbB/N7uA45+odQjccEmpBO+qbIfx+YzG5P09bS0IMTMPCV3pzFUJL0hwW?=
 =?us-ascii?Q?HNqnAF0QxnNYrZdSs21i4BJu0tE4U9Mh6hhHg61qhx9MB0lSc0fRJuIjCr1w?=
 =?us-ascii?Q?M434/5J8X3+qxU494/AtWc/De9DTILNVTC9EgQEUHsqJXHFI5WnPFDUNqWIg?=
 =?us-ascii?Q?eQ1yYyM+L4HqZiGBXIU0BFGIKRNHF53F05+pALcL1gPd3kkEJhRZuNoUaFrS?=
 =?us-ascii?Q?bsvdo42cTlCmVc+wl6yBMVjP3aKkFetpvWlqaa2hx0pePT11jcOY/epz1m8k?=
 =?us-ascii?Q?dNLHuXnaJgp4CNDlZZhx9tzlmMiPkqhOh2xlxaI8mkQCDx7SJyaIPLhMz+hU?=
 =?us-ascii?Q?0G+dttqS8Ul4DAEZfrqS9nrhSuzxlGmEyLCBfy0cutBgsVG9+OsAwd4XZ8KV?=
 =?us-ascii?Q?BHgdlSiCcpBNyb9XKqNJLc2zRkpNJTguh0aei72eDLd4jJYTxicT4oUdUKNV?=
 =?us-ascii?Q?lxS2ZCrykufcXbxdi86hZFZ1N2seZgdj2vfgnh4aV7QCFVzAaeCu6PEgCnEM?=
 =?us-ascii?Q?ZZgGVUEZHisZAbCImWzCHF5IUcmeUA80n37I80jAF09Xs+i1DgH2OpCSd6K2?=
 =?us-ascii?Q?kuUMHCiQW98YXP3EPg0F89fIl9WWtMzTucO5osb58do4xcA6Xeh+4To6rRvT?=
 =?us-ascii?Q?G97+AsytuVX65jy7tmx2R0hiccA29nd7ytwiRzIMsEsDM1vNrJTWp4GjgVcS?=
 =?us-ascii?Q?glo40ScgxLTzI4r+dj78FPxmIhBI3owzELq7ozp096IEN9p7hxhslE4zEZbv?=
 =?us-ascii?Q?YHuxP0y2cL/50ZFJxO26tsr9/wn1LxjQXjyz2gUFgZiZxksA48q/1uQg22pr?=
 =?us-ascii?Q?lwjORpeinHGx6CJVjQjK51FNiOd1r974wXTSC7Cf/IgP3o78QykmjmLLVyHT?=
 =?us-ascii?Q?6Yq6D5LZUqaW+AdLxhR8xI4m4HL0mZJ61G14?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDcKkLOXP6hUeTVWM9yFlZtCEG3dlSkrI0ZLkaJOd+L5nP5dwKrRgzf5Mvwg?=
 =?us-ascii?Q?ll+52EWyivvo9WHivPz0g6YQJDj1hMZeUO4ZJaL86d4O+zqFDlCLLrn3e2kj?=
 =?us-ascii?Q?EwN6AfkElnqYQvBR6E13hwBzyWxmVS3jVz9OFnAntxHHUOqA+Tyrm1FmMZf8?=
 =?us-ascii?Q?qPoJj9TEmR+ohCDAW3thqxiUo1YmboFs9mKNU1JTr36CuxPozCJ4GAB4J02Q?=
 =?us-ascii?Q?iX5naY2vZJNmea37XZO25GTmMRI4DjWlrLnAKgMWBbbrCrDUI6rgAFiVm5Vs?=
 =?us-ascii?Q?pkayIJJL/AtdT1Z7GThUeZl7nAjmTiYZTuMNw59eGYVzGRvqCEAzRm86aX6O?=
 =?us-ascii?Q?E9HfhWWU26QVfojd+rQ0+sp0G8VcjodCSBVLFKWhW5zaEjW4o8pvgB7jTb+W?=
 =?us-ascii?Q?qkI+7ynPTwo/emoJ2I2rErGGq137TeAfktDJqzReKFAmrXSIjf8tI5jueEc8?=
 =?us-ascii?Q?mn8cZq2oYNSaSWlHCj5xpx4U1oDX+pGf1jphTgadEAMlaLegX1y+UrrMmLAU?=
 =?us-ascii?Q?vcNYSyc6wY9wfIXEb/Yht5mXgvLqajSWy/ZTuu90bSn5ms8KQbsbk3GagnPg?=
 =?us-ascii?Q?LRfCkrr2Fv7WcV66AXCH66SmAHgK/wmIMFmUkb7fKpk6fhqkSpmh8WvBV5uG?=
 =?us-ascii?Q?8ZkfgQ+LhdiIge8eYU9iymRH1PMc2s2vJLnzhJiwr0fI4O4aqw/YRAG/+tAE?=
 =?us-ascii?Q?iVIgP/uLquO7v0+zKLlM8hMxIamIit+LMO0K+MRVDjaluFTENvhNVHXyEpHA?=
 =?us-ascii?Q?gBJDwROn1Ok5LSYLEJ3RuXVBFTsnFGEpX+BEVdxNd9CL1xUV83x6bYOdOyW1?=
 =?us-ascii?Q?Zb2ZWQh5965bajzVDhUJcncRFOFVz8iKVveVPUY1b7qydzD1wwHCc+AJCQzA?=
 =?us-ascii?Q?8eQhYUKrqxBHEoYywu/w987sKnowQIe//GDL2Pl5ZmDfAx4c/hY9b3qZ2a9h?=
 =?us-ascii?Q?rW3XLcUcxkT41944eEOiaZBHoi3bsrxLPlcCVFh+MmkN0BCVzpfztaKJS3lL?=
 =?us-ascii?Q?FX/0R/fmlK6MY37rMbdNVCpDvI752wI+ubY+q7Zhd3RDPCvV7m98zQPzeJ+y?=
 =?us-ascii?Q?l78nSH4ovhfK+CCYNGMd1vWwCwSTx4UrNl+CgnGdyUsuUeoX1VzHKoZCbvuV?=
 =?us-ascii?Q?qdk8WmzdBtT+WxzOi4nOi/uMTpMZM15+jtaXYwRbWAlpPODiew6bS9JlNBo/?=
 =?us-ascii?Q?AIZWckWiGM1ymBrGk8CyEvYiBNBe/zkU3CaSNU+mjAHnd7toT4mS1RR5j5RZ?=
 =?us-ascii?Q?VWe9pDvRUDFpCJ9Fpua5M7JoJ9eqTbPTHG1Rj4dfABOU9ww5x7yPB32IQRov?=
 =?us-ascii?Q?MrQ/gDBO5UFu6EFowHG7h/P0Np0YYK3ZnLtikiWJrlLh6zsErIbkuDu6P2JN?=
 =?us-ascii?Q?1AzWKpLNfX5eezQIBTKHFneQ6jIIHCI4TbPJH2zQV98L5C+h866/xrZ5q36U?=
 =?us-ascii?Q?oMFIkf9ns65wNRL45MRWJjo+40ncrCFMvE1sm0QP4Ay233Sh6AZjgWFQEDc6?=
 =?us-ascii?Q?6R7SDrdta3ZSCFzHex8iGzNQwAhfM5z8FWcarUW3wZxzoA+064NrfW1ASuTd?=
 =?us-ascii?Q?DicpLKZfUdnQ2nrc3fk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e57eead6-beae-4389-6428-08de286d7d03
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:46:25.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7MzpJFknY5PgW7M3WErljmLzT4NSpYyrW7XUPrZmo4Fx72cSYvEUOcw4FvOD2lQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6101

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

v3:
 - Go back to the v1 version of the AMD, removing the print was the right
   thing, explain in the commit message.
v2: https://patch.msgid.link/r/0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com
 - Revise commit messages
 - Move report_iommu_fault_supported into the struct iommu_ops
 - Put back the pr_err in the AMD driver
v1: https://patch.msgid.link/r/0-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com

Jason Gunthorpe (3):
  RDMA/usnic: Remove iommu_set_fault_handler()
  iommu/amd: Don't call report_iommu_fault()
  iommu: Allow drivers to say if they use report_iommu_fault()

 drivers/infiniband/hw/usnic/usnic_uiom.c | 13 -------------
 drivers/iommu/amd/iommu.c                | 24 ------------------------
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
 12 files changed, 16 insertions(+), 38 deletions(-)


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
-- 
2.43.0


