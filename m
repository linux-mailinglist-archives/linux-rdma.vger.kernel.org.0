Return-Path: <linux-rdma+bounces-14286-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32321C3D5EF
	for <lists+linux-rdma@lfdr.de>; Thu, 06 Nov 2025 21:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F4C188CF28
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Nov 2025 20:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF832B9BA;
	Thu,  6 Nov 2025 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pRdHebZT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFED3043AD;
	Thu,  6 Nov 2025 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461307; cv=fail; b=texk5Dn7Cu7oH+i0kRp1xuHXGRyM03peaqHupzoBy5ITGfDOT8zZhJvRYnqJoyuzhBzeQ1svKAcAI+gkCBKG8MKqZg349BvKuGxRQErWdM4CO/Prahb8YRmDvEQo8RXyJbKoxDBbZcjprOAjgzIQewCFZ5HhHzNQuDyvtVgY+98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461307; c=relaxed/simple;
	bh=saViRBSYGQD/H9+MPVKU7BcIMTkHFwK8T+W+wsoDLLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GyzW7G01hVx4Ekdc+AQny77C9aBxeL1zJYIqpfRtcMrnWcMHcZYjPgael3goWGKxaInOdr1o23TxSBwxQZWkDg3Ri/Mh287D8Y4en+lKPNYt9EHizwTNs2VSjcyLljpcK66o86WyfAe+z+/OnI1loc+ampdB2N1QSuajM7DTXfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pRdHebZT; arc=fail smtp.client-ip=40.93.196.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siscO6r0nSEmJC+6CtQGVU+UOz5T5b6ZeTLNY2EmVhBgv2PIoOASLXZK8AYC4kxkL/UnJxTT8Y49anHPfmGsRyXmVF4DqPP33eFwic4aIcxYGPKXClXhgUfkTXfuetzonRnLwHHgxgLOs/FIKzoxWttMBZs3YQ7GV3YQLIl/rphrTjcjB3hydF68ClknEbmxrQot0Ib6RCljyycz+19jCogMN6UOnjp2sxmCSw8uqlVB7azrtpSOeb67SrDMDwOGAy74vdajUcgG2mjiPrvEnxMVvYqmjQGl3q449KzxH85UGDj8Vb7zIOGBTI6fTm2nDXjiyQa45bWNOnPeiyRzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhb7BPdH70xcuNod0R5kyK2egKSNweuQW35kisBqYpo=;
 b=E4/onS6ZN7QqiV6rKylBgR2NIC1+NWQvgGdQrATnTVDKc2Npd/fgwQJlYrrgv9lxG54wssrFVcDs4KIPRhGbA9l7rdhXCdrXu5nQz5+JzNyNRt1w55IAQAMMHz1RyRUAzEDPQtrA18givA3Q4uF++8a9A9mLvv2R5vznVE8Z8vbfT+p8fcqnnufIn445HtGz3JtiIFUq/Qkoou73lHcmVI/LDIeUO5VjjLxswUCPdB3522glzdhfPtvAaUc7GgwZwdh7AiIRmzxHMGfA84WBmD/FWxZDUyY6ojxY+RXihCP21ckn1kVj0cLEvciaLHmE2a137+mGaCoAQ7DtIY3Djg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhb7BPdH70xcuNod0R5kyK2egKSNweuQW35kisBqYpo=;
 b=pRdHebZTGv11T7nrM0ZpxhD/b9ojM3x1vLO4bVQCOx+bJi6oNQQqQCYEfdGwsIxgkd/2Mujlkq+fJGlCsSjZtYDgnCcNuxzRfwyEDxC2PBGBXzj5n/ozt2oVND8e+JcDpHGnlNRz0d/KH7Ut3KlSZBR391wilE1eCbFZM7bQv8pJ1soKLKxoTtykUzMK3YVLry3LGE+99CXnsBAAsiXh0402Ve6IjgGmtUtztTCbuValBJ83u2iLjHAjmddOdT+SfCH+xFhCwBJkCXjEkl3Xh9c4dFvE2xpCAJ3I/jPnTsC+qY0kyaHyHlD2ggxsBBB0KVaZUJH2lVFRjLyoW9LvKg==
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
Subject: [PATCH v2 2/3] iommu/amd: Don't call report_iommu_fault()
Date: Thu,  6 Nov 2025 16:34:58 -0400
Message-ID: <2-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
In-Reply-To: <0-v2-25fc75484cab+ab-iommu_set_fault_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0741.namprd03.prod.outlook.com
 (2603:10b6:408:110::26) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SN7PR12MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: dd24b312-92a5-4bb1-2ba7-08de1d73f567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lHtfvcZ+BjirXdYATX/pX8iZuZWMUdtgRodlMtGG9ELFOROlRF27ZjJIKZvn?=
 =?us-ascii?Q?A11xVVALtaKAEl6G2Kr9XlAqtL5W9yFCLdlsEP/ig2uNKprmCCttsbL95lBf?=
 =?us-ascii?Q?jL0dxEh2kuLRIqzAtYFB6cqTyl903NbhXVSAx/JQNkCACDV5Neim5yTyNxhJ?=
 =?us-ascii?Q?2cC5bP7imAd7OpVdHhahJgVwJ+YIsoD+jEbiDZo52WMQxkpJhJwDVxbs4DOa?=
 =?us-ascii?Q?LXFmBkwh47GwDLKXjdrOBm5NbSUfrFr78RQzNR3SRoZKfnmIXSPA2c+6HtB+?=
 =?us-ascii?Q?Z9Xqe5ZNaqEKt+8RaKuJUaqkCdfHBIB3QAtbcUQbd+s+oOVSUfWh2SVQpLIt?=
 =?us-ascii?Q?9bdqfyyL/3+sdBIXtH1bXki8x6tIVVBgM4VcUP/A08V5Kj3viq3bUbJn1ahB?=
 =?us-ascii?Q?i/WwzQ0e3/pqydyuIQ0XEyCJTZDI+nlSSe6MPm5IgVc2GiwltMRDCd23CsEY?=
 =?us-ascii?Q?9UPzGFccHZLTsCWZiCiwKT4dndWwcvkXp9z7Fm9Mn/m5ml1XNmQtzFK3f3MO?=
 =?us-ascii?Q?yNuRC/Cr5bzRuvo/+FYiIzOV5ZQ4FfoNJ02tPyX1oFSv2SPMciCVbRSRGajS?=
 =?us-ascii?Q?voi9fAfOV/BLENCJmYyg6QqxCFdFTqjKst1M+FNakRnQJtJyS1Zknb75MvHs?=
 =?us-ascii?Q?cIkIrevWP61oF3uIozz+FXkLwirYK6nEig7Vv59i7l/7fRuCU3ws0oGJ3Xas?=
 =?us-ascii?Q?qcIPHChJKSZfwluMaaOCKyzo4JvM8Fm7bfoF1dflUTZNUMcqQNQfXfrAaZ4U?=
 =?us-ascii?Q?cYQ7UXwcyhMVGsCdb7VZAy7bv2jvugqTwWcH0CVzTZHIncnYu1I3ZWCsUDNt?=
 =?us-ascii?Q?3l7w/259DSTsV9KwOEw3tssEWdwxWLYzFdH3Rsa4IMrORL4CPTLbnEkuzq17?=
 =?us-ascii?Q?uheHHaMupNWW8DAR44+xhEXG6sJVQEGlSGvLZV/ULGgC6yHp6jUtm8L4QYkN?=
 =?us-ascii?Q?jCQHf10l0i0DLR64vEjBVwORPFh1UdRegnKkJIwPcIDEI65f+LxNPQk6s+mu?=
 =?us-ascii?Q?ndvqhVMRFj1U67mQy9MlHxo8Cxp9ecte7ayPccEMIAXygrvu1jhWVszsj7DW?=
 =?us-ascii?Q?cceDv0VEu3LdD7IulH45L3d/IhPlnUe412n+WejQOkvtou3DjmjvZe+edUHi?=
 =?us-ascii?Q?OFRdU5vrXwuxBr5oxb9/VqUThG4z/WtXtciXUsZcekcPKW78eCg9C6vZO7T9?=
 =?us-ascii?Q?dEN+UGUoO72DJDTP8wbXiptbZ3yizOCCRqbITVzWDJwaAS0/aqh7yCzsTuSp?=
 =?us-ascii?Q?mazJGPqDZWnIylSTm9vTcYCUadrg5s7hZes6YiD8ZFatcKJB6BqGPZTgySGr?=
 =?us-ascii?Q?QEsrdWcuzhPh1S+l8ZHDeQ0Xld4+75LmumP6qkIs+6gLgODQvIGY9PzjJrjc?=
 =?us-ascii?Q?s9N54tVcu475U3zIhN0+KM5JNRd0hptywy+OFsMDSdFnJuXvvYR3+7E+z1T+?=
 =?us-ascii?Q?polzqB/nksifkWYIanUUZVZspipQAfcn27NDWG+qlqkWnBH1OHU2fzyxuDgb?=
 =?us-ascii?Q?a2kV4EFK69UuFyw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ljrhLXu8VROTxdtfdnGjfphwC7SwksaJIh7sSbXqCQechX88mt+jl8g6jy6?=
 =?us-ascii?Q?htYW4we6rRWhaSIOqf7b3BFc9TFWVKsEj3T7YGadh6AFzkUmOOP6IlfjPbO0?=
 =?us-ascii?Q?T7f3CgE9P3eaqSnfQosnOp6GWe72Yx3ajpRMixcUQeyyFrb+qWRSMCWcsMW3?=
 =?us-ascii?Q?98p8MyL7tAmqn3dOn+dEfgz7atzJ/wwNWhMKx3H0J+lcVsqEUrCRl13xjl5P?=
 =?us-ascii?Q?ToRZn/FGjISxEx0i8tolXSg2xj4KpB+LDTeL1O5Y8Fi9sf1jF1Kp9IbQwq3i?=
 =?us-ascii?Q?5+cBRL2epRcja8l/yLwVlvYPwpsHnfzRpQ/pS8e6bpmJPkX/cYCiLVYvJsvK?=
 =?us-ascii?Q?NuyfUAcTO79c3RsvKI+YWZxtX/P2sZHcD9/49jFY6QSPVaj+X38nnTLyN538?=
 =?us-ascii?Q?ns8QnL7DhOhr+bZCPG7GDmQJ6tj5FN1JgulkoSbstkCjQ2o8eJm1L2zCMiFH?=
 =?us-ascii?Q?VBiAODYaGy4M22a17KOv4ipdAZbjdfBMLdvJNI86g1rqdrVFKSTQ/Di11Zoo?=
 =?us-ascii?Q?tBQIKKiGxdPC34Xq4y/tw7GGX20/pnjroPV/45LbPp9OspB42s9ZaXiuhmoF?=
 =?us-ascii?Q?cPQILElJb787gHU9N8Ai6N+sgNnCUbMYd6xy7mlRjbUNGSbiGA0Xr2gKaOkl?=
 =?us-ascii?Q?uBlGN/YimNUKkXP76pc8p288r575l/OMonLDlZMIe2Pb28qzp5d+zoSuTWKm?=
 =?us-ascii?Q?Cbck7cDArR8OqF14A8vVl0JbM9zEjuMZ/E+VtyJIdEkfzjerc3uICvGMpiqD?=
 =?us-ascii?Q?1MoIqY6Ges+zXzQ0SrA6O/B6f6LtHwIbpHZ9z4dUzXDysCasnjbFCCNZPgD7?=
 =?us-ascii?Q?p+k7LU6ra3i5ZH2vm0EhRQVXTVCIpu5EMOtpzUqZwdDg/jf2C00YxtyN+Ah/?=
 =?us-ascii?Q?BYVbjAecmUR/LUXgTr0LDyHCjBr31IrxhB0KS728cCpdmKnDFU3FhE5oJsxW?=
 =?us-ascii?Q?ILeI6DvfbrU2fXtdkivia07Wkkxp+JYTzz2GXIjemRh5Ldgf/A8e07zU9U+i?=
 =?us-ascii?Q?TfJ7nK8ps/3qJYKXcUR26NlhJZHrGh0xhIggK0gHQTwMAhSp8Ja92s34PYn6?=
 =?us-ascii?Q?DvgmhnmyX6ng9Ul1fc/+7neOfbmpDvOAkI4DE7/7fDkMHqeYmvn0kIntAXeV?=
 =?us-ascii?Q?j7jyRDPm9HpuJz7EgWcJ09uAc1+lMTmfnnIsSm979ojnGqDu/IEMS27+liYb?=
 =?us-ascii?Q?aHk9B6dVLLSo16j86Lb8jdAYcAd0VpL322PqJBEecro0H2RZnI7xWqyNb9ED?=
 =?us-ascii?Q?FMpYdGo3dprnuJmQgVPzbzqL5hrEU5O4k1TOWsvSKE0iUUnrUU+yggpMnaoq?=
 =?us-ascii?Q?AIBVU4vWnnKTlCPe87MBg1XzLDS3wqOhRA50kmdjcVSiY/xc3IFlZ9WGrKXS?=
 =?us-ascii?Q?liGI3eFVZpqAKzcSK6rRXCb0eHHywV8Lg+q0gk03EjJNdcIvVs0k2+Jcm3tm?=
 =?us-ascii?Q?j7Srqe+9fQWUty6vbq/EgXl79MGtcUJNr3U/EFJ4AMqowV2BU2uURQBgZxTK?=
 =?us-ascii?Q?oprRPPP5T04NSbeW24x5WuH5CD56gvvV/CZip2fK2zH5dP2UhnS1P6sKzepe?=
 =?us-ascii?Q?5YWHdrYdt2XEUCbMKn4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd24b312-92a5-4bb1-2ba7-08de1d73f567
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 20:35:01.0463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tNmEd5UcuK1m7o2sA2RKD7UtFEqSHGRKqZscu7iMkiZbF9U1wuxvR6cWhjfFQYV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7108

This old style API is only used by drivers/gpu/drm/msm,
drivers/remoteproc/omap_remoteproc.c, and
drivers/remoteproc/qcom_q6v5_adsp.c none are used on x86 HW.

Remove the dead code to discourage new users.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1cee8..d4d9a5dbfa6333 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -854,13 +854,6 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 						   PCI_FUNC(devid), domain_id);
 				goto out;
 			}
-
-			if (!report_iommu_fault(&dev_data->domain->domain,
-						&pdev->dev, address,
-						IS_WRITE_REQUEST(flags) ?
-							IOMMU_FAULT_WRITE :
-							IOMMU_FAULT_READ))
-				goto out;
 		}
 
 		if (__ratelimit(&dev_data->rs)) {
-- 
2.43.0


