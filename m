Return-Path: <linux-rdma+bounces-3640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAAB926F96
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 08:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E941C22118
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jul 2024 06:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BA31A0734;
	Thu,  4 Jul 2024 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O+PSGRqO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD511A00F5
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jul 2024 06:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720074578; cv=fail; b=QcFeZyGQfHBxLXLBbc9SaOgSsKe8ufRgdDT56ba0HgJzqYF1oufETt+uyW7N2ZT7XapGCmYd/W+r7k+2GbrLnI3AzwkAUeZlkj+VHP/3gSd9Md27wy06LH6iJ/Aq2hrVM2LRbD+pRkFQX4hEImd4x0fb427bGBstUwQMiBnfpeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720074578; c=relaxed/simple;
	bh=65hwnlxBqcjAaHj2muVe2eBgS8PZEt1b3IXEJ8AW7R0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWZBfDkjuKCzU/wmY10bCaGFqPlgrmDqQ2Z1a6BT4HTN2UX9r4CTuXNMNcwmKO56FodzZyj7oH5f8RyQZyKxRuMvrauVleJJgwc/1UTF8nEmJm44G694TN+mUo5dRVkEz9a4WpPH8iWqZts34u9yJFRqFyxl+KZCFmONFBtzmCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O+PSGRqO; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAFDiFaBc8LjMEgLN6E555D91AZrMM9hibFzp/isea3UzH+JE1rXz6koyiI/CntZRqPX7wROE19fGhosao/QyubmO5Ov4ag51blEjmw2b7gL7NFDEF6LiM4SodGy/gTpLW7cqlgrOQK8E2at3MCNDh4ECHPRqduiSGW2fDwUzswfXw+O7W72GcjB0pUFaTzYx0cTiTdIIGSEBJsDjLCSPHig8IvWhgDg/t18EHa1Rmp1OaiwwwBCDjBIvf6iCZdAlDPU8TPzyjJADOR6drtMA5NaPPOx7d3EJ6/3Vkn7VLD3VsrLWRm0gjRbGlbS0x117cDs/UES5MHzeItdEtCEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jShCplHsm6BgwbFbmJdCKkMKgW8tNTboSDFt6lPf/aA=;
 b=YJunPtTKOYOvUdqkXR34wAoseWjsP+qwXxvDCF5j54MdYf8Eda/0oHQK/loJpY0I7ga1TVrvaN5kKkjnO88vmryueC35ReNKCvn/Hy/NkHoPJiAx/ItjrTAAqfx0MhIyEjfXhGa/gVUVaAfIIesbZ94bAL9mUwyFKLlOJAxUSjsPlAiJRt9C+HfE0pPYdA2NFjd2Tf8PgguPtKx5JMLAH8ovZ8Vh0YeAvVx0dZ82JFyr5RREBumg7dffQ+Xpd0OBLdOo8zFKdZaFa2d+afm3Rt/6Z/NGV2AXQ3xuVHs3qC1s1RlExEUOqFDA5gCpnExBBWqjocWYXk8NFFVMgBObyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jShCplHsm6BgwbFbmJdCKkMKgW8tNTboSDFt6lPf/aA=;
 b=O+PSGRqO+utwfrPHs/74OS2kYMk7rfKboskObhzd+uUsJUiV5yBiKQmRAYzD+a1P4+GU6bb7j5srwd1M+TT8HZobi87yPzSLbdRtfwb9hHXsrSQ2111SEp0638qS6+/sIHVyQ11G7gb9s7i4XDo8Kmq/5FdSsKfdupcgKbceagU9YBifeO0jpBycflHkWdMA4c0wC64nYFoWUFBEGRhK5oDXZhPsSuH/QWMz4VT1gLC9lWQERorspmbjCKfQvvtHdNApxia2C/pESYouSFmPWPfaXuohClD9EzGmAVFqEhFd1jTP5wXNbB03begqajbe5/DDcfzNiEO5OrrWO5gPvg==
Received: from SN7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::35)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Thu, 4 Jul
 2024 06:29:33 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::67) by SN7P222CA0025.outlook.office365.com
 (2603:10b6:806:124::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26 via Frontend
 Transport; Thu, 4 Jul 2024 06:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 06:29:33 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 23:29:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Jul 2024
 23:29:18 -0700
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 3 Jul
 2024 23:29:16 -0700
From: Mark Zhang <markzhang@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Mark Zhang
	<markzhang@nvidia.com>
Subject: [RFC RESEND iproute2-next 1/2] rdma: update uapi header
Date: Thu, 4 Jul 2024 09:29:00 +0300
Message-ID: <20240704062901.1906597-2-markzhang@nvidia.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20240704062901.1906597-1-markzhang@nvidia.com>
References: <20240704062901.1906597-1-markzhang@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a9f875-75fa-4c1c-2336-08dc9bf2ab36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GLO5h9VTOnBLVZrjpbrqKJd4rkeFCG4gwN6Vqkn5Pfr2sxAsCHa9A/8Mdtgl?=
 =?us-ascii?Q?J+NM3a1PZPOqmERF8YhH6Lrf+lg7hDmm5WG44qJsjSr65bQjxrS9C1dXfq0L?=
 =?us-ascii?Q?uvkVx6zM7QoFuVQVe0BeFBgwXVdWQF6JKiym0YeNeSznRe8Mjc58dfj/GuQ8?=
 =?us-ascii?Q?HHPqEC3EdeF+ih59OPTKRoMFcszKqP6YClPv5/zLqshCmoxiLoKA2VrYQ8kf?=
 =?us-ascii?Q?xNZYRkTY8UroTx0lp2QMv3Egbh/HjEZ8BDy/qPfWCVZqA0c5+3FALhc6gsoU?=
 =?us-ascii?Q?SgHDJNf/OheUi4lyYo6NGq8msBFNIT49aFJiq0B7uZhZmaPsa6f+afRPgVhV?=
 =?us-ascii?Q?nGWuRBpvo5XUQFjKfvEDNf9sMfhEGpyXd0kJuUMG9ZbF3bqcso5BmlUQX7Jm?=
 =?us-ascii?Q?y7ULE4EAZS1PsVxdgPWivAL0MnuaCOlEdq+cXjiEKEl515cX3MkqSxxzfF/2?=
 =?us-ascii?Q?7JK7HEg6FPFLI95BK74FGSGw/sMt8Q+jDg98uI4D5i6lCicWLPDCUhCA6kUD?=
 =?us-ascii?Q?Y1aORqRLxB+RA+q0UYMufWxsfrqgyAEiUFh+Q1XFHWtRQXASW5JVZGLX4F+z?=
 =?us-ascii?Q?Fsmi3bUx9YEP/awHT5FKJ0RzepnDBIbHtjEBqPcV4Sj6L4P253N324fDvg2N?=
 =?us-ascii?Q?MiZaKq/NLUaf1DGyE9/udHKAjv/5xH/uBeq1I1Nj2SA36O5a0A12xvEbK4Xi?=
 =?us-ascii?Q?ST7riE3NDecUIG0n+tsJ4ciO3i+zaP8a1Fv2po0hjHjuW5Fpd1fmJRjo01+K?=
 =?us-ascii?Q?W2VHqFbft1OotTSr/Nf7BWGIVs7d7plHf5R2jJQQMIp2/18nFA45v01NcK+J?=
 =?us-ascii?Q?Q7K9rZvYM0BqxN02ZI08E8qP4NJGsP48b9GPAayNJ4w/Yvbkf5EbsCZGudED?=
 =?us-ascii?Q?F83Dh1OUI6McEOAdIt+z2udHbFuZxbea9VgmaDKPwN5oojf+6nJQy0et6NwJ?=
 =?us-ascii?Q?2P7N8a/dnVoKse/qcNF1E5phDvKF3iIE5xXCouzM5r6/Agfb0iXp9ueZMNo3?=
 =?us-ascii?Q?Ih+HUtZo8Uz2wnBw0SjStihDc4PAOXJiQ6U5gcrGPJz8vu0wk0db9X/lfAU2?=
 =?us-ascii?Q?Q69KH5BGnVrS+8KQJ9Lj+eEBV7P4V4QREikXfIRk2y67vklB08Gcvd/2bR3e?=
 =?us-ascii?Q?4ZlJwRrOl0jVISdVapJTidk+l9sEu0a9y1D/LfLSaRhkXJrgfdOy99J+FcKz?=
 =?us-ascii?Q?y/jVpo3zTEs2j2EocT/mSWuXMeel3vgheH56QHt6GFcroGqSVTYAuwoc22x8?=
 =?us-ascii?Q?yQcbC65KWk58Y1xAwUuccWuHBRaMzD9tO0EPjtA6PWlBqmUIMGhzYodBuF3Z?=
 =?us-ascii?Q?WKjM45zPZNz3VbPLTIWsvt1TJGmo91CitstrJBDrT3DtQh364ofJeNeboZwX?=
 =?us-ascii?Q?O8J4eu2WYh0r9s2tDSLvRUFhhqhL8uSoOswDXPf7BQJemi3zU49l0SW/RwOn?=
 =?us-ascii?Q?SVMg8qCv6HYIL+5rdebVT7YPcCLXurqb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 06:29:33.5204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a9f875-75fa-4c1c-2336-08dc9bf2ab36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412

Update rdma_netlink.h file upto kernel commit 294424839b5e
("RDMA/nldev: Add support to dump device type and parent device if exists")

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index a6c8a52d..aea1d5ef 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -301,6 +301,10 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_RES_SRQ_GET_RAW,
 
+	RDMA_NLDEV_CMD_NEWDEV,
+
+	RDMA_NLDEV_CMD_DELDEV,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -564,6 +568,10 @@ enum rdma_nldev_attr {
 	 */
 	RDMA_NLDEV_ATTR_RES_SUBTYPE,		/* string */
 
+	RDMA_NLDEV_ATTR_DEV_TYPE,		/* u8 */
+
+	RDMA_NLDEV_ATTR_PARENT_NAME,		/* string */
+
 	/*
 	 * Always the end
 	 */
@@ -602,4 +610,9 @@ enum rdma_nl_counter_mask {
 	RDMA_COUNTER_MASK_QP_TYPE = 1,
 	RDMA_COUNTER_MASK_PID = 1 << 1,
 };
+
+/* Supported rdma device types. */
+enum rdma_nl_dev_type {
+	RDMA_DEVICE_TYPE_SMI = 1,
+};
 #endif /* _RDMA_NETLINK_H */
-- 
2.26.3


