Return-Path: <linux-rdma+bounces-15749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB314D3C1D3
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 955015A6608
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614193B8D6F;
	Tue, 20 Jan 2026 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="clQMnfGa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD43D3323;
	Tue, 20 Jan 2026 08:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896005; cv=fail; b=reMii7dOrIgtEjC8Hjxb5cq486RU8L7ZyDxuQPDNoAuP6EVmXuPmJpVva+/wU2RGwO3/2FangW7zuFhhfKnir+cWSeQ9eZLKZbcu7nXvt0qECCqhVEyJtclA/IPVoHGLSgliqSuCGaXAjl9D5fTdpohpFbqpbzUwCw3x8VcV8qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896005; c=relaxed/simple;
	bh=Sptc0TU21fQynisSQ9mTFa4fKgQFbxTFK6nWxDLgGO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qykq+MDWVOhdWriy9zb1yVZcp6YXNQOst1N+vy3vLBJckS1emISpSuHWPgZtmRDHHd850+8drSn6YNJWztJR9juwdd5WZnKZ8wUFI2PQrfAzYg3JxtlIx25sJHhJ4Q9Cn/YVP7n8luAhjJSOEYxQBBUm3jrULXPkEVtK9sTT6O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=clQMnfGa; arc=fail smtp.client-ip=52.101.85.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiMRnXpUW8aTJ0jJjmc8waJAb+0gFV/pO1LpSTirAyhLA1ID3tkWeTu7cbZhZ/u26euzBVRMhnZdJisSwcZJhcfLSZqLDM7EPJir/6R+l2viZptZOOUqoH9B44Y/zmAyR+DCXaURXzgNCVMLi+qkRGvKIPpZ+ObbbEol2/kSRzlPgSPX1p1h2ph+0g3IsGbezNDjMQFlGhSO0PP0cPqRMIypqgmOTlXVcXWb/inm4ftFcsrEuB7eZaac9fr6OwpyZIMeNm1nTVw/VFEhvB6aA78TrUH8ISB1Y6ICVMweRdPCGNjME8Uqua1uQ+yQGVD206oFtQ4jfNGs9OHZvaLm8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VYqAbuXnyKkNVO28OFDutXcuh5y+RSVFM/GYhUSvi0=;
 b=unBztIIQqILKmGe+ccsNbLDEeiCN6YcUdzTKz47KQ2MxtcqwS+fFmbDpXGkpKWhjihhITAoYZ9EJpu4XPQm0a+g2uM7lf6XzDmIhbMrypV7vDVVFNewMuuWY15J0SDKnIagD80b5tcFAXI3VSazH4K98ZEPRN+lk6ddx8YQ0W96IoQWh6aHFAsbgJIbLuL14xaCVkxCJBqfAbA7drpuZW7exO6PGz1bFkvjMfJo7GmnzAl/0aBmLNvtbel9s/NpgF8yiyec9HLH2Og76yx28IpEHBSZd9ucVU6ri0xKgSM5zhBF7FHP60T8AvXHQB7ejIE2c41I0iViei9VK+Tsj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VYqAbuXnyKkNVO28OFDutXcuh5y+RSVFM/GYhUSvi0=;
 b=clQMnfGa6g+iJDJ5NalWgy+CeSQj+wmmFH8vWuLZFRcNuB0f/ar4eF5Jz1AK9v9cqTmAqnOhJlKYeiglJQVOl+hlGIVD/hnJUy/vu3oZlaumUBHUx2blBRjf1ytngIRpbgTEKNzre3BqPQlyOwn5BMYfwmsx1y2kXDN7rVr2/CcjIuAasF8Fqzu6615iVS6AcyItSDydEhbLtq+Uc8YhtKAAsgYIUQF/QlHsvliX83zS42Xl/ucXw9kbLGzuPhfHzvXjWfFdB7pJ4l203dyMsYl7CmWpNIiJ/iXoaT3HO6R239H7eQyeqMWy90iJDMzkF6hpmzWvxcNNFLGmqH3kqw==
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:59:59 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::cb) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 07:59:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 07:59:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:59:48 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:59:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:59:41 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V5 14/15] net/mlx5: qos: Enable cross-device scheduling
Date: Tue, 20 Jan 2026 09:57:57 +0200
Message-ID: <1768895878-1637182-15-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: fc37ccfc-b87c-4639-4d82-08de57f9e8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9HAmIgzdT6fCMkYXUKB+SYK0AqsQ51u43qQAYrlG91PH+zy2TE0m2bURGKI1?=
 =?us-ascii?Q?ozEn+cYNAjqiHSHfPHwJLRhU4yqpEuWkh5rUux0+0gBbszdEtYF88QvhAatF?=
 =?us-ascii?Q?KiZJDzi7qsSU45outt6O3cZ8tit5RDCsIOiFhIOpeumkRmtz23uYkgua0G1N?=
 =?us-ascii?Q?0h3FMtjtaNVvwyG+z6BVRtVCaNIws3JsAAXegk4RabdynQ75CMoiluLS0MZs?=
 =?us-ascii?Q?V7nPFeWicuKqWHtqawUCkCwvCUwcATTVWsdj9CuXAGRXAMRyDCa1H7qVnMAZ?=
 =?us-ascii?Q?EKpnTcJ1SZeGpLj2bNBwKzA5Usm+OoaMUyqtYCAtsHZdrk9N7mVAtR8VQRRk?=
 =?us-ascii?Q?tu4hjygM/S0N4rc17LcmXnKnSaW/iEknqjhmyJyMwB+1lz+L63RWQGB9rbUO?=
 =?us-ascii?Q?4LG8EGtr0/n4a7QIL/13t5BaXBsFHYzp/3WR63orFOi+9Cjiz4Mugo/YZbOH?=
 =?us-ascii?Q?vfLJT+E8pDau8IIWsRg8AIqpJ5plGCgl+l7p0tk48hjIPl49iAlqor5T9Tiq?=
 =?us-ascii?Q?wZe4vFnCI3+S+eGRvjWhJINmZYi6ybln616CKbWkPcx7zsN1JbnFinZoLs05?=
 =?us-ascii?Q?tQh8d/DaAvGbPXyuiXGAjpdRkgzQQWPdL2j+7BW+LGqXQfVyS65c5KvqR5ZD?=
 =?us-ascii?Q?SzZ7EBTrm3YcbQiE3mLgMMdriiMaLTkfTdFvRyy0DxLDtTTkn4LPjDUJq9VF?=
 =?us-ascii?Q?YhIgd33T8qEaaS7TGEwSedXMkmBl8XkVi37rzpFm370mQA8Q+1ZUV3itR55S?=
 =?us-ascii?Q?qERaTF+wqq44b+ov0qntz1cuzB2QpNSuFyGjsIDrZtOnsG6nj4kUKGFTHE6o?=
 =?us-ascii?Q?qiJT59HarGFBgwyyG24MEkrHTlZBrxXmM8gas1EJwVAN4vgH5TY+nd3j56n0?=
 =?us-ascii?Q?D+91u6tYb24mIGPDZrBh9fFbSUt6DWNV5Fth7Qd5CkIMEUT0dZcJ3kuEt3sd?=
 =?us-ascii?Q?YK7A8Px998kXPGD/x59pswP1fX6J3nUc45x3yM15NzRN2r96xKfBJtnHHGqy?=
 =?us-ascii?Q?JC5n7W9S8un1EeU7jQYvKBibf6pd5fQ3+iUUBPRb6ZPBaqArhYMmeznUp0+a?=
 =?us-ascii?Q?QIh4qbQIoy8bQA/Os+1v5NX4RrfsYY8q8CaCpvoLIh1XIUqd7Wip49f9ibB9?=
 =?us-ascii?Q?ElZ1mG++cNUENkDmeNVqEQ6sp7P75iT6ObIwblDgHx0owqVi7LQvkasEfmO3?=
 =?us-ascii?Q?3wmEb1O/CVJuwqSl3X39v6izNWyv+ttNW81MD+GVPTltk2cKtoEC3Ha4g6zA?=
 =?us-ascii?Q?bgxYlHSn11xnTcxHKJyjOCY37HHW1XY0QTEXr74cM59F5++uRfejMEDfB42p?=
 =?us-ascii?Q?TAGAHNO8+Lf2AicQom9sRSGpl8SEOuxJEsOxT8Mqp7WMp+xvTMNTN9gT/0AZ?=
 =?us-ascii?Q?lo9JLIzczS0YZi0syfzeMEOg8il/tFOpTLe3Vk4bOPjU78VniIqxM55C4GpM?=
 =?us-ascii?Q?hRcQQUMMdToMj0HLPRdVnRoJx6cJj3Y0loWCbpztd2sgqTL1RlOj6Yjf94VD?=
 =?us-ascii?Q?beJWhVDIBKVw7kytC/4rTjh58Nz/+JkDqI353aGXLA7FsRCoHuIGiBofdatC?=
 =?us-ascii?Q?phlzpX/Vp2AQmWfSVL6lYwu2J747xY9g1lIsf10yTbOlowaTCRNoPLpDAC5O?=
 =?us-ascii?Q?ZaoZgGqpYkAzGIo8W4Rn00qblDwXkWq3+HEerA+RNPVliEN994pakf+pZePb?=
 =?us-ascii?Q?q2NOHA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:59:59.4347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc37ccfc-b87c-4639-4d82-08de57f9e8b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746

From: Cosmin Ratiu <cratiu@nvidia.com>

Enable the new devlink feature.
All rate nodes will be stored in the shared device, when available.
The shared instance lock will additionally be acquired by all rate
manipulation code to protect against concurrent execution across
different functions of the same physical device.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index ea77fbd98396..a040c81b10ce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -385,6 +385,7 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.rate_node_del = mlx5_esw_devlink_rate_node_del,
 	.rate_leaf_parent_set = mlx5_esw_devlink_rate_leaf_parent_set,
 	.rate_node_parent_set = mlx5_esw_devlink_rate_node_parent_set,
+	.supported_cross_device_rate_nodes = true,
 #endif
 #ifdef CONFIG_MLX5_SF_MANAGER
 	.port_new = mlx5_devlink_sf_port_new,
-- 
2.44.0


