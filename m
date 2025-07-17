Return-Path: <linux-rdma+bounces-12234-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D99B08567
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 08:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F84F583D46
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4621C192;
	Thu, 17 Jul 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QMSQrik3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F921B9CE;
	Thu, 17 Jul 2025 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734961; cv=fail; b=JHl3g//0c1OzCZGWDzUlh7wkrn8hFEpwO1bDOe5DXiF7mBTwa2aLecpXKbR7TN7dzBHicWL9TFKca9nzJpeJOWTNkKSjyN0AC5F/SGbjnZEUB4mzxpS6S0eLzPyKT8vM2Fr2hvVISMEBSGyZFhkYk5Nb/w9PV0/NkJHADHgJw4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734961; c=relaxed/simple;
	bh=ju12GB3fjXAgxc1VOwCTlqilVfI6Fd1MAI0e1ax9yt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk3jznS0H1eWqplbRnAR8SDEf45R9RfC+LsXYcKh81pGoVUqUMtuAaWKOvf4K6VYMmuR4uk4X7oA9/37UlJkWO+OjOCtbzVD87b9RrJQjFswar20AgbbrtAwm/LlazgL3SHtloJR0Gi4/LCInmj/pthSmrbY1ghIpNai32aJcn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QMSQrik3; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+zCnPW5qoxjaKJijdMljZUslxcD+RWY6vlvF2xDUkiBfa0ZYPnMnUEIyYWW/URtCnADu7YG1XY+Wfuk9K98TkrdYJh2zQDDBA5XpWZMhh1cSpXHdO5uNCqCAvXCWIeeqn1NdoHvUVx3pG8CsyMjAH92Frhr7b4Hzu+Au4XtMNsAOIHpBZSALsxll7kxWtoYlex0HcN1AsKt7VL0bVZcINIGI4AoEcHEaGxcP9HFpTcc4Kah4NCAYM7geFoz+S4ZQAan6BHvNKyyzs4+VkHg49T89kYea9feJXWmHRgdDwXdMl44rfMyGFb3JpjmenF8lfQM5OMoY9KprJ0rq+LU2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9dTr8rDEcg+xspgNQrAjemL/+BblZVnEs5JwAFx7WQ=;
 b=vLaiK7E4JJaCECtILS2nyoA3MnVLAC9aNfkdYS0bNgOwdJ9A9SE2enUMHo9RcO6W+CzjMEb7xXOE8Uc94zARv7X3Ar+DMC1TaGhSJYrasGDhon2qrbzssWJZOEkdFq4XWyOm58NsDegqXT14GQfoXTGz9e0xZHDMm0KoGwQxgYThIZK4wLKTJFxauLoxItbqUJgoZ1m17u6ZS1uifZKedRIpYw/2Owc//41/XZeuwzv1/ssESuJAwAMCaGwwR7IKpQu2VJFZGY35u/KThd5InjgL2FSMIrTVwk2NxaYYsIALNk5T/rbV74DAr623ZkSFMLCKOOztmNe/8w4pzZcC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9dTr8rDEcg+xspgNQrAjemL/+BblZVnEs5JwAFx7WQ=;
 b=QMSQrik3WRtztujZSA6CcXv2/Cfaejzr7MM+XKdi5nEXNb724CG31V+puDUMj3xLxmxq+1FWHgj8fgFpyWuklQ2uS3T7H8OgDuQrxHDaEBQsaMGJyoM7uDWXXvvZWd7nKERYIMAplT3FLwjxyNgq8T/umXVqeOi0s6Y3anizsvm71W8jLc2mqEGtqB3pm4XYTewMNon39RXlS9GTeOihCWBnaCs6VtKFcLiaL6MJTWOfj+e4QacSGvqT7HjXbc+fct1QIPs3AP5ADBNOc8FKwcZOwtuJI398UC8iGRvnu1bQx+NGYwruRSOI3mrTbPLTUjmoHllh0jPUdA8y+1XOcA==
Received: from PH7PR03CA0020.namprd03.prod.outlook.com (2603:10b6:510:339::29)
 by BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 06:49:14 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::e7) by PH7PR03CA0020.outlook.office365.com
 (2603:10b6:510:339::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Thu,
 17 Jul 2025 06:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Thu, 17 Jul 2025 06:49:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 23:48:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 23:48:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 16
 Jul 2025 23:48:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Oren Sidi <osidi@nvidia.com>
Subject: [PATCH mlx5-next 3/3] net/mlx5: Expose cable_length field in PFCC register
Date: Thu, 17 Jul 2025 09:48:15 +0300
Message-ID: <1752734895-257735-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752734895-257735-1-git-send-email-tariqt@nvidia.com>
References: <1752734895-257735-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|BY5PR12MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fdc8e9e-4222-466c-ca3e-08ddc4fe0ab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1c5o7+hchViZrKVskxrImqvTgcdSdxhB5imLvrlzJEASI1mZpSSfi7Mq094u?=
 =?us-ascii?Q?5zDbhrBY8kB70994NGb7TjCP1eMQPegKJqbGHLGbousecfUVQwwMqhDugaEo?=
 =?us-ascii?Q?ZxiaNt24PI9naWGnNE8hXJh1lewU8Td6/Yi7Y9Wu6IGBq3GPwjO9BNgZoQEH?=
 =?us-ascii?Q?WfTPtdF+gf5Z4Unvn5fJKKVzNU/hb0yeDx4H5Zq7RqgIrNsgrE948PwQjWHK?=
 =?us-ascii?Q?fkNhPJbyC/E5mhot5uebN8ljkxzYJJalPgNSTvemC5FC+8DJJng/0+go1rT9?=
 =?us-ascii?Q?CofbKaD6fyJJmQtFl6BijmklSkpn+pcsjuG2BwZZQgVrEacO2Sji+a/Q0x19?=
 =?us-ascii?Q?S/gmS0g9hQK8/T9Eltg6/zheK7RswACf3xMpae8P9n4e5e5h2+BZAuk942+s?=
 =?us-ascii?Q?nvJ7FI4aG6NeCdnSWEt5H8Ku4ZFMJ3dgmQyklfZvcyRhle/Y5G4KKpeaS+Jc?=
 =?us-ascii?Q?Dt2mctEJ6eD2krFhGIC9hvRqhEWe9FS/rZr/f3LjUCEMXaVfUS5VVcgHdbt3?=
 =?us-ascii?Q?R8FNWk+mgMv0fP7voCcmq/KQP1U1TxKSMxVB948X/4m4aCRESGOqifz/3Nq7?=
 =?us-ascii?Q?azOjrvCtOObmVPCr9jazF0z941Ud8zfn/kiOYGhG9L9cre2ITN3XyVRwYEbP?=
 =?us-ascii?Q?8v3TiUxXf1Ms/mxMJ2JLKGbJLkRoQanDpCazLXcOm1e5yeTPFksNo9ABkyED?=
 =?us-ascii?Q?GCc+1ia8tj/e9fbFb0jt5cw21LoEWoFvW05I9ZfHuGMZcm32u2zOtDx9dqkS?=
 =?us-ascii?Q?od/ckX89fB6cFSAKQmCAdZ5ey0s8rnSTduy9ouq+XMYYHtg0AlbpI6Fx6Dz7?=
 =?us-ascii?Q?Mifp6mSs+8cMdqPFCvFY0O9tYTtaX7NtQkadDkrddJGVkTT5mMTnj2WBXCDn?=
 =?us-ascii?Q?TcSUEMIBHcQOPNb4jkGD/3fe2GZb7vBVHAiozE5BlWTHWZuWysbJbDU/VCWP?=
 =?us-ascii?Q?h0uBwgqgwvJwjtFTenJWdClB3N4hWTM3qJcE1bEl52bNgNCVPGjCxlTcBO8Y?=
 =?us-ascii?Q?C5RhHQooO3NY0jS4MLNd36fiIz7FRAPKp5HAXcby84CQPJ/megwHC21u99o0?=
 =?us-ascii?Q?b7YAFQ+iJjUWLDLs7ZgMp+GaHqxNJ/VOtaOKQv4JhbADhwDF+LLt0dqmUmMZ?=
 =?us-ascii?Q?mkPiq836MwGPaEWej5ulYmWdWUu4wZMi6gGq8rzfxS/bvPhWgzloDD/+WgXz?=
 =?us-ascii?Q?sa0LCG0/0ZuA4QXEDqCKDV6uH7VLKGIXfkql9+41PS9Wly7cAzuVoXsK68rT?=
 =?us-ascii?Q?Lc/mpLqxHzAqwl90jJbFxAJcnlrxURqrjiS260dcYCfdiSrhHJnyPJFRrIZe?=
 =?us-ascii?Q?nlbNpEkcTjfpbOm56xc2fAz4MbXa5yoeZMaWlyr2xJ8lVHyKRUucKIfAcXl8?=
 =?us-ascii?Q?1rml8w1lkrS8i/jj05P9XTKSEO60wevc4NTqC5HiA3V4qxJGrz0EmLfoTHzi?=
 =?us-ascii?Q?A/vkJ2dRNjT3qT8nB1Rc5uX3bGb9xPGe8nw+JFYaBgqRPHkWoU8uAQipARkn?=
 =?us-ascii?Q?HkBONNowSfm2rPSGJOWVOhggVaw4RT7+36VK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:49:13.5433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fdc8e9e-4222-466c-ca3e-08ddc4fe0ab3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177

From: Oren Sidi <osidi@nvidia.com>

Introduce new "cable_length" field in PFCC register and related fields
to enhance rx buffer configuration management:
1. cable_length: Shifts cable length handling to fw by storing a
   manually entered length from user in PFCC.cable_length
2. lane_rate_oper: In a case where PFCC.cable_length is not supported,
   helps compute a default cable length

Signed-off-by: Oren Sidi <osidi@nvidia.com>
Reviewed-by: Alex Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index e1220aa1e7dc..ed4130e49c27 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -9994,6 +9994,10 @@ struct mlx5_ifc_pude_reg_bits {
 	u8         reserved_at_20[0x60];
 };
 
+enum {
+	MLX5_PTYS_CONNECTOR_TYPE_PORT_DA = 0x7,
+};
+
 struct mlx5_ifc_ptys_reg_bits {
 	u8         reserved_at_0[0x1];
 	u8         an_disable_admin[0x1];
@@ -10030,7 +10034,8 @@ struct mlx5_ifc_ptys_reg_bits {
 	u8         ib_link_width_oper[0x10];
 	u8         ib_proto_oper[0x10];
 
-	u8         reserved_at_160[0x1c];
+	u8         reserved_at_160[0x8];
+	u8         lane_rate_oper[0x14];
 	u8         connector_type[0x4];
 
 	u8         eth_proto_lp_advertise[0x20];
@@ -10485,7 +10490,8 @@ struct mlx5_ifc_pfcc_reg_bits {
 	u8	   buf_ownership[0x2];
 	u8	   reserved_at_6[0x2];
 	u8         local_port[0x8];
-	u8         reserved_at_10[0xb];
+	u8         reserved_at_10[0xa];
+	u8	   cable_length_mask[0x1];
 	u8         ppan_mask_n[0x1];
 	u8         minor_stall_mask[0x1];
 	u8         critical_stall_mask[0x1];
@@ -10514,7 +10520,10 @@ struct mlx5_ifc_pfcc_reg_bits {
 	u8         device_stall_minor_watermark[0x10];
 	u8         device_stall_critical_watermark[0x10];
 
-	u8         reserved_at_a0[0x60];
+	u8	   reserved_at_a0[0x18];
+	u8	   cable_length[0x8];
+
+	u8         reserved_at_c0[0x40];
 };
 
 struct mlx5_ifc_pelc_reg_bits {
@@ -10615,7 +10624,9 @@ struct mlx5_ifc_mtutc_reg_bits {
 struct mlx5_ifc_pcam_enhanced_features_bits {
 	u8         reserved_at_0[0x10];
 	u8         ppcnt_recovery_counters[0x1];
-	u8         reserved_at_11[0xc];
+	u8         reserved_at_11[0x7];
+	u8	   cable_length[0x1];
+	u8	   reserved_at_19[0x4];
 	u8         fec_200G_per_lane_in_pplm[0x1];
 	u8         reserved_at_1e[0x2a];
 	u8         fec_100G_per_lane_in_pplm[0x1];
-- 
2.31.1


