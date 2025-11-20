Return-Path: <linux-rdma+bounces-14667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9433C761EC
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 20:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9619D4E11DF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 19:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B339A242D76;
	Thu, 20 Nov 2025 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pGkrqpcN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39322579E;
	Thu, 20 Nov 2025 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667994; cv=fail; b=jKUQO707UCOtZng7+EK8+c4sBp+FjnbyURBFxEGsMRsecn4vbfpWsYAvQe1Rf2J7cYG61rwhwnRQkR65DR8PElyWyjYN4nJ4S4hBzwiPMls27prHSJ3SFc2acWhlRUVXRV1hAqpCnY61kxOyrkLGHtJXt6BCPxBxEbwY5AYKjVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667994; c=relaxed/simple;
	bh=j2Wma9iNzPpLiaCac33xq32fvsk/C3C6mt6T0A4qOUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tZ0iU+GYLpFOEQaOdhinwkU0nD2xnk7gpxLdp5MtXmwu5yCgns5ZTfjYc1RES8cNuzrhwkvjo6dFX+F8zpe64Uu6Lsb+pZclsVfOBicevyfes0gvhAVvsbKi23shvcwT2KUyFixhAYm5YxYLNMKBtEsAFzTQhS8KNE4zBCw3cD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pGkrqpcN; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W58+MASIqltE/uK9UORoUBX41/XQUODiISssGRmWsLN7/xm5YW37qOb9xVsgJUDKg61BBIBP1d5OgX0OuE1uDr/7JUkaTKtQVf27eIZc7UnkoQrfJaQZmE4uquPLIK5Ret8yIaPNIzX40xJvBZmbXLUKXUcG3qywMD4G4NvBbtRPgCDYMNYbd+QIlJgFBKznZj3c6fNi7lm1BwTQu/7DzoRPzgxCDc2HfcsRNj5MbUdFRipzkfpPBpFgQq55NCUoGel1cqz+70VpcYsdJIHn6qI69X0jzxHQ/pq+qy/30KViCzEphIh38c4hslT/5sV+U68rHQxRAYEAeuz2aTPXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwksIaZUBHrk3Cpx19gRVJDQJrhMprXvxB9Quh9oIcE=;
 b=bGdkHfq1ZJWz1ruKgZbBLoyqBu8KEcBN2MggEQ+Pm11eUjPKRnn9zqEcrScde2OIYhuPqSpi5onifprkeP82AZlbGjYpqzFJmUhjDHGjj7QP7bGmMBGwZOxF2PiEFwRL7+INdyvt/5SorsdN2+XDngEELIMc006kEgnh5zfRX38XXowcOEhMGQx/jAe8FTPryjlfx68F5nqW8ZEtyKPhz0EAD+gQPiXB6m8PF7+MWfk/HmYacz32yILpKs4wOGvtG8sT2CNocmXVhJDqVeNGr3Ta3bHe0DNqYLH5/BHwAAw6CfXWwFRT7z3IbaAcyp9sQJaCrJLQVDeMYSJ5OaPB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwksIaZUBHrk3Cpx19gRVJDQJrhMprXvxB9Quh9oIcE=;
 b=pGkrqpcNEMWN9pOfFQN4hVy7SgrGFIECXdxwGEOAHXiYtyj9VWGgWDtx9so8JYTs0jrSiIYt/U9UBeAvbd/5/YZzc1CE7oPlZPTFY4j/C0/zXsErlijJFSsXPfAAFylrugMfbNQXTSE5rklAPOSutkmEbmQJRl/NQFdiUOCJF22nNKSRsv7zpulaMncJHXDlQNGdkXoju3OavfDnl7M3tyJ1apwTojO/14z+ZRX/gffYWUccj+q1QYYp90cYw4L1ryvex7m3x4j/sEiEutqfQ1Te8iqFggaGdSLYGdHNXLPJARICsL6xMb/CTiK/16AebZsEkCydAygv5bd8wUloiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Thu, 20 Nov
 2025 19:46:28 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 19:46:28 +0000
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
Subject: [PATCH v3 3/3] iommu: Allow drivers to say if they use report_iommu_fault()
Date: Thu, 20 Nov 2025 15:46:24 -0400
Message-ID: <3-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <0-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: a361fd4f-040c-4276-2b75-08de286d7ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1U5rSgFnDKWDa8+TMlTEifqJ5i+RP0n7I17DYpxoXellj578q4U4Ec6cwQcf?=
 =?us-ascii?Q?h8snwhx+eYZ8uz0JEFYCUWcSPEmsVblL/xEQ1XTN3yWPwjr9leJVSMh2mAAw?=
 =?us-ascii?Q?6aKYDZP+5/vqvAXxhjf+KlcGyBiCafz2dv4pAVIjuCX9kTOPN7FAaDLJXgYL?=
 =?us-ascii?Q?/CH0Pw+qmkUu6S4Nkm+uEi5xAgEmhdsXgUXM3Kq7CLbncOoyfeJ2Po/gQRCR?=
 =?us-ascii?Q?DNxn2GTp3TT/mXKeZqeZAS1I7m38i3ymcaUaRP5aoJ4uugyVJ0ed/S7OfY6J?=
 =?us-ascii?Q?pfblqn5zGpJOsB39tAvd53+JPQd5POK5gPxg0kPzq439uyrQt19Dr+D+QDgo?=
 =?us-ascii?Q?t9IWJNbaLcWJ4cjq/nl4fjzZRXe2dytw9Fu0S317PgG/J9Z6HRiZ69/vfBc4?=
 =?us-ascii?Q?K0jHU/H3i/K4pXuaWqBe7n/dBgszHsbQcUa5Wslzw7K8NUGudzfa5s4NCZQ7?=
 =?us-ascii?Q?P7MMDBTPeAY97jzOIHsAviP8VRiI8g+FlRc10OcU8fs3Ds3NrexvkQBlKDIC?=
 =?us-ascii?Q?3xbws1nT4uEfB6zF/fRSVjl4jj1RoYejKgpb42eWI7SsbuKSHAObS5sZXxmg?=
 =?us-ascii?Q?G8WWa+r1l1DJDvhpucLF+H0FWZQuWGDYtE4FD39JI7lsK9ZNSnSwt/LlyUH4?=
 =?us-ascii?Q?zsLArBONYqYDF82GaLpgnJHC3rIDQsGDcGIn+J7S41Q5R1Bp2gHrgFZOO2rg?=
 =?us-ascii?Q?ISA/mWMg6iKPwfPnVLtwdAjGWgaBtHY5mFwZNc0TfbmTNhWVFkQwtmJcJ/Sd?=
 =?us-ascii?Q?biAvNlOe640R4rkdvDCYUCuWBVzmmrxadVbyBx2co+ltSgt/i+3hCSEmdzPL?=
 =?us-ascii?Q?9BfRyTineXgI/w3V+oV9UG7qLulZyg73g3XFdoGr8ql3x3pr8UVoWJS97y5K?=
 =?us-ascii?Q?Lh2gXW1m8ivn2QoKoKpCubCQc0YyQ4R5BT6RFsHJLH7MOsdYzW2Y+pKdCdvq?=
 =?us-ascii?Q?oAyrZT+vWr3iYbWCy1XEYiwAOhyirIRwX7XHgsRbAqCe0i8ll5YCDocfdqxt?=
 =?us-ascii?Q?QhLIwiZD4NzsuEAzl7wTExFWwmiy7I+6fHOq7mvH54Cf7qxTTVrOKzxSbx5o?=
 =?us-ascii?Q?R44eFJoMS/ul/zw8duTW7VnPjkOf8eVbnOOgpx3dKU+tseyNpdl0tQV+GSmq?=
 =?us-ascii?Q?xvbphrGqYjRNg7G6d0cQnrNpMLaBGCzreQ7S+f6zaN6s0BtXlaZzmHE/VmVo?=
 =?us-ascii?Q?CBQgmpKXvPPalrN8l8fPnVz2VM1/Q8PNK5UIgVezjCzAF9+DPMVxCTG26I+1?=
 =?us-ascii?Q?2sLYuhGcCYQcAwhNs9uSWyNOuTiGTcuoOUTLJW6nl0ge+wa8/BaRT8dKuGYR?=
 =?us-ascii?Q?ZnGd5nNob8Do1d9No5MLdpHhsaEzAjRnH86GBjsq3xR8m8pYElDQ5qjTzPYB?=
 =?us-ascii?Q?NW3CGQ/q+dI5R+XY9YcDCBUZ8kwYTQLk9T6UlBzX8ThFFvcr2iEtTYj2lku/?=
 =?us-ascii?Q?z94sUSUbYRwvLLcyINc467QCJGnMykVCA7lSpNymLUnF27jKOwHXV3srHna4?=
 =?us-ascii?Q?SW2W6n1U8Rq2XF0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/GxmzxXkApRnaluvJRu3jkBjWN5lJOq1QqjIWOH7Q7818OhzG0onUHl2L7DJ?=
 =?us-ascii?Q?3d2fzg+KNosqS1JRRwHSJEFYG/DpjUT79jHBTLOGIoBGzK0SrOf5qC5mPhFe?=
 =?us-ascii?Q?nEYzVoUlgNG27IF/zgKhSgnWdXAl43Cnl84FPhIIppxK8oK67i6a4a5ATtUv?=
 =?us-ascii?Q?AeNr2ksmLboGBuresR394QaRDjR7vdhmtfENnsoZKP/Jt+IX72wqBPyhq7cc?=
 =?us-ascii?Q?5ptPU5Ec/vULVwytNcbXkC6Eiwf2a4H0m/L5OXkY6e0851Dq87Ez5gEm7/J+?=
 =?us-ascii?Q?NFkeelUPZCgUNP9eOEtaMqDfvsyEOPhalf3lxeYW11Mk7WTN+7iRcasP8aBI?=
 =?us-ascii?Q?gByrQ+1u6H0gzLLvMErgkf0EKsktbezTkDnL3Me0It7ZM7MfpVRj/ZmFbstX?=
 =?us-ascii?Q?fSmtTAQTWpZzvxnyr9tsP2xYzawiTJ7cHIh7X9z66188ki4yXDC5sFlaBmQz?=
 =?us-ascii?Q?QAsiPZveDxC6338hLJxWlyn/3q4v3dU3M+SpO2gqiVPXsUxBNca8IJ8ZvSJl?=
 =?us-ascii?Q?3U9Y5k7PlhN8KJtAVUz2jmynKjhEwuJLoh7oW7f2qRHc2yy42RPYMTvGrB1Q?=
 =?us-ascii?Q?Ak7E1yyVyp7FqTAImB6bl+fMF06C2Oks+jgx83w4ySP6XPcs+4KeF4HC3ike?=
 =?us-ascii?Q?5zBv2Van0YHuq8dcXhqFa3C0vRuf+8vZSKniBZVQcjoKyKropdhIkdRC6UH2?=
 =?us-ascii?Q?0qbzIfreVKeaykAr2lXjEd4AG+Rxex+6PwHQzMAuDvTCY26MQL6I+KEc5nFS?=
 =?us-ascii?Q?kUBkir7zqIbs6MVnJQ5xYcj/jIcYTv8r4SMdl/cAxbkYyTOonFAGKYDPMGAH?=
 =?us-ascii?Q?HL0Jaypy4pHTK45NKZshOF2gwGBNTpLDxSI+Z/yiyW2gGtccq0/1Qi72jMf5?=
 =?us-ascii?Q?Koham6yjv101muqlI1NXmQo8ynI1SYAvjSbsElIQjNllyYailQzpv2QxgXRk?=
 =?us-ascii?Q?XiNoyvdZGJ2+XoMixVNHKX5xsQlXluO+tBRSPmWoFZRdYjokHr9AvBKwmyer?=
 =?us-ascii?Q?1EPi2vfxplL68XDzwd9QtdnM+V6Jz5WTZBZgGVOaeUvtGu2BYSW8im+p3jiY?=
 =?us-ascii?Q?bzLM2HmJtMUoHPEgD/oa8vGngyBGUtJFg0m3skbCw0B34/jHdsBIMmhmz0vy?=
 =?us-ascii?Q?Lt3nxKcPoiTATyFXFJZwe+wwydzgaxTdj/q/oP6942GtE2BIZiQnnpbIvsJh?=
 =?us-ascii?Q?fN2XhhjSuyJT1up/AEt8LZWxCBhIAceX3NPFXHogspkzjzLFFdWUxphNNudh?=
 =?us-ascii?Q?Rd/5djA3vdVx4oDOw2q4PL5uHkV6598a9pFiBYv1+s4dIea1p3twaLfFcUnv?=
 =?us-ascii?Q?R61fjOADm828jyBkMsKjK15Yb6N18zoy9ex76foERBTXRuaj8pihtlo7NlRZ?=
 =?us-ascii?Q?l8aCiksH5+Izk5+eD2Qr2t4tSilJdOtSlGJD8uy4sDFNegr6v8HeNZeq4aE6?=
 =?us-ascii?Q?DtRNV4/Yl066fsx1hVJ8apgSI9aQD/SW6SbO9xxdLc6pt+9/jEVyRQM+WZ9r?=
 =?us-ascii?Q?FwG8z3vtbypic1fJe0rB8gYgDyKUOShPGaL+2nOsM3YCbLU1t5oNh5ZECVeL?=
 =?us-ascii?Q?QA0EypUpy7lebgkrin4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a361fd4f-040c-4276-2b75-08de286d7ec9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 19:46:27.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73Roy7+/QbPiL19ITHL7dbXPx2hUIk8k2iNy5AKm6D16jFwogJ5RaTfdTv54Y4gK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
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


