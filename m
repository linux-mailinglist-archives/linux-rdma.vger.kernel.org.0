Return-Path: <linux-rdma+bounces-4674-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417B7967416
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 02:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC77282712
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Sep 2024 00:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968F118E3F;
	Sun,  1 Sep 2024 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="is2K1aAK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ABC200C7;
	Sun,  1 Sep 2024 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725152134; cv=fail; b=mLy0Qnmra0X/uuAA2epTCeneMm+sqc7p+d/ZCoeIIGBlN7IQL+GWKSyuQRSE8OME628T7JIr/kAf9h51AeeTxr12589Yndg1O+kTvEfQJ1JFaGRWA5k59yINLhrJ4jhtGvPajLxeUmne8/XotUymXsKHLdIGGEijnKtJueKfPUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725152134; c=relaxed/simple;
	bh=PYwVrfahoCcediw6aq5UXiUTJO1PuvY1owRQpjR6Qrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcYlYYr+oQuXHvJlRJOYaIpgwIhXQLlpcjStWbloy2Uc19UOSfoFQOqGoQs6UL5INZd88VeihJxbF/Z71y6+QdFqkQmW7mbbM7r5QcDUwW6N2fe9fqg82d+yErM9Vgm4u2BhDenSmeDIr0aTAuQk2THeinGcNoyjijngSSRwF68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=is2K1aAK; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FurrdoFMDN2WyJQGD2NU+ruBTcSIJsRxe9XxnuKcoC2RYBtacHAeLZ5BPfyyl6sisWZywLzyvUaA61BE5s2AizS3x+l79KapsMeyQwR0rEYe/2gFEt4hZU6YV5qmCAB/3JOdciJK4+/RLvsL8GqocfRNTq56d6vkHBhapAttUT19Wyq6ptFGYQrLTHMVxWUunVz2Rai12wXyUtSzufeiAHNPCo47ltRpoIyuprSaEweoMw1drY5Ig2GEmUPI3oSLxQcjhHrm+/p6+A/BD+zlfzp4iYAnuF77nv5+cLK0W9uwjy0R54tL8XX3girag67juC/Vr/pMwPrSWDhCyOfIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4pSR3GelWnmpD6+Wj85C+OLM0Sq0NKSszDdY5ZQrJ0=;
 b=sU7eQLLFRnotgtsJfN9Q5LU3O0cVIMIk/2T0wti8gFR3hRH0aUOj/QG1ngPyrigu8OQRwTCdNuGZZe/r5CT56l6gfQ0vEBR7Gg4hYi4gy+epy0MI5q9nJtyauMSloChZ/jt4yZxRTDXoGXHG0XUo074MB28/ijVfqW8IHfb68hxwpkfUbG+ID4oqve8JThOu4dL4jyBoxKfOWNk2mRdfz2oCLhijbOjbuFKQlYcv9j33BcNbso+Wi2Zeu+kNOG+zOz3cJ0CmrmPfSHwlVZgyFCuDIqVRv2AP+WsbBHVCyXNl/hLCmfZWwXOTj+AAp4VUEGhLS7No2EaFKmJ1F1bxBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4pSR3GelWnmpD6+Wj85C+OLM0Sq0NKSszDdY5ZQrJ0=;
 b=is2K1aAKQKC5Am6VISai5B8rsnVZOdUfW0051mc9HEOvs/am8Jjxt/jdKCKisvkCsbfdSI8SMKk3lwlSvA4b85Hy+p9rxQzkEDaaUBD8Amo+NnYhBPUR1jXkUvr5S02Gx3Rr9eC6Dw2q9Fs8JrdBPfiEZ5YMMloG1a8g5bOYBtFlBqdlsyDkbVPUDn0TUYE3RpkIBriBN6fhLTIX92NePHuD7JuVEAK0EcsHCAvMnsUahe87t+G3p9BwBsI2s5doeqDi4cpQPrhZ2jKY7wq+OoW4w4NTG/JdGw6GAcO1r9M97DblXsnisiCZz9eDPBI0N9H/uJzdmUX5wOHc/7os9Q==
Received: from BN8PR07CA0031.namprd07.prod.outlook.com (2603:10b6:408:ac::44)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Sun, 1 Sep
 2024 00:55:29 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:ac:cafe::1c) by BN8PR07CA0031.outlook.office365.com
 (2603:10b6:408:ac::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21 via Frontend
 Transport; Sun, 1 Sep 2024 00:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.2 via Frontend Transport; Sun, 1 Sep 2024 00:55:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 31 Aug
 2024 17:55:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 31 Aug 2024 17:55:25 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 31 Aug 2024 17:55:23 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <dsahern@gmail.com>, <leonro@nvidia.com>
CC: <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	Chiara Meiohas <cmeiohas@nvidia.com>, Michael Guralnik
	<michaelgur@nvidia.com>
Subject: [RFC iproute2-next 1/4] rdma: Update uapi header
Date: Sun, 1 Sep 2024 03:54:53 +0300
Message-ID: <20240901005456.25275-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240901005456.25275-1-michaelgur@nvidia.com>
References: <20240901005456.25275-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 54050190-e476-4476-278b-08dcca20c62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwlHzfcOGyYz/94fbe9nUZwB6NuNfMiTnctGyjx/8qi9Gc/an+4ww9gjicZ4?=
 =?us-ascii?Q?8wNh5RU97sRLuv473m42tAsgVhced56C/U3Wvefaoxu8j7icouUlla/I2gnx?=
 =?us-ascii?Q?XhKgzAu47JxxH/Te2QPs/Oo0RqqI1HWEDeHddRzjcUq1Lb6cmBw+uCoca4sl?=
 =?us-ascii?Q?mf5ZPId0NNlnv/F/HR8mQN/C9LxllqhIQUjNHS3hDQiivBdntrMjeL4lp7M0?=
 =?us-ascii?Q?MaIl5o72kUK113jDFuFKkYEP4YeEG8NQSScIpy2L9bmSKsCFhz2arvnnguF/?=
 =?us-ascii?Q?35QW3hFFyp3fO4t7sUffwAQyihTCYta5l+8huTc/aq0yb4YR9ooUxBB5KKHD?=
 =?us-ascii?Q?L++MbIom7EhF3Y0B72wxDllewmWZeAeAHfN6tR+2ULPA2gplbsFAcLmSi1wH?=
 =?us-ascii?Q?v3bm5iWxmDa4//RpUYUagqeasCX1J9KhEMAEU4pwYSR8FMWu1vySy5sMx83V?=
 =?us-ascii?Q?wm6pWflE9gfiF3/6lrl39MtnlNDUvJ9spzNIhhU2mIV5a2S2bgBF9qICZDFo?=
 =?us-ascii?Q?IpeJ50l6BZRkDIN9OFn/JcJ8yuH45Ou24DUCE2XRsvGHRQhztmy/AwX7de5c?=
 =?us-ascii?Q?lSkSEMFqq6Z2GhlaojRmodvmebtOCoOjAe15cTmOPC9O3bA4wHmphEKlNzM/?=
 =?us-ascii?Q?Zo4z4UMcB+GXUKtjooJw7fJWjAjxSRiTCVl/KsDsOJSdAGVU2osaPSLwlEpi?=
 =?us-ascii?Q?U4NID0DnbFFyQ8A+zrpGj508/8yvJQ9IdRJt+FPVcMVHxeaTwal8bLbH2lP1?=
 =?us-ascii?Q?o7w9jyBNHc2MauJhud7PNJSmXvTjttOB0k6fmWuCz+VEadCyyH+YidcvhE4u?=
 =?us-ascii?Q?GcIEt3/LS/CxdXGTPRroxo0bEw/zawx93UCA9y/KcDNmqdJvGx50JXigrfWt?=
 =?us-ascii?Q?emvHzdBZWacWfZjEWZv6ILCNEdGUgzxQzbPvA2+a4hqHfeEIi7AUdIG4hraJ?=
 =?us-ascii?Q?uQAtEV5VvPU3y3MJu9f/hRead6grCxwkfC9EM1lOozsf48FGJgNkfD02Idnl?=
 =?us-ascii?Q?vkCWQad1645hKJAWqngLcd0kR1CA0cIOAYDCoSOi4rE/DGgfMUErlh2O8ry7?=
 =?us-ascii?Q?AGn5lxmnFM4EcerwloBUXiRCnyz5iWvYwluAu0lTm1hSw6QbPAofusUR1SGB?=
 =?us-ascii?Q?1VSqozH+DnqBco7UcPJeU/7fNeiPRK9pf7vom/vPLQ6UNwR3VjFGUaIPKTkM?=
 =?us-ascii?Q?9vHS/YaRv1rog17gWobVmkT2Ru64ECymX6WDo9hI4xJ21q+T3j/a30bIVSuN?=
 =?us-ascii?Q?NNilwDteuG763/aCB3vDRbl3Co7PCc2sr5KS2RsKaze3mVyp84JmhfZ61Oph?=
 =?us-ascii?Q?6MJeMlTI88IyjyeAyoVnnb4RF5IZ2kbf8yFv+S7Ei+u8/YUE8f41ng5APcBA?=
 =?us-ascii?Q?iwDjuH39EF2rj4UVm9rewynlAUFFi8XN1A4NBl8RoI7wGQhDLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2024 00:55:29.0152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54050190-e476-4476-278b-08dcca20c62a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722

From: Chiara Meiohas <cmeiohas@nvidia.com>

Signed-off-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 rdma/include/uapi/rdma/rdma_netlink.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/rdma/include/uapi/rdma/rdma_netlink.h b/rdma/include/uapi/rdma/rdma_netlink.h
index a6aadb1e..d9337f1e 100644
--- a/rdma/include/uapi/rdma/rdma_netlink.h
+++ b/rdma/include/uapi/rdma/rdma_netlink.h
@@ -15,6 +15,7 @@ enum {
 enum {
 	RDMA_NL_GROUP_IWPM = 2,
 	RDMA_NL_GROUP_LS,
+	RDMA_NL_GROUP_NOTIFY,
 	RDMA_NL_NUM_GROUPS
 };
 
@@ -305,6 +306,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_DELDEV,
 
+	RDMA_NLDEV_CMD_MONITOR,
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -574,6 +577,10 @@ enum rdma_nldev_attr {
 
 	RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE,	/* u8 */
 
+	RDMA_NLDEV_ATTR_EVENT_TYPE,		/* u8 */
+
+	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
+
 	/*
 	 * Always the end
 	 */
@@ -624,4 +631,14 @@ enum rdma_nl_name_assign_type {
 	RDMA_NAME_ASSIGN_TYPE_USER = 1, /* Provided by user-space */
 };
 
+/*
+ * Supported monitored event types.
+ */
+enum rdma_nl_event_type {
+	RDMA_REGISTER_EVENT,
+	RDMA_UNREGISTER_EVENT,
+	RDMA_NETDEV_ATTACH_EVENT,
+	RDMA_NETDEV_DETACH_EVENT,
+};
+
 #endif /* _RDMA_NETLINK_H */
-- 
2.17.2


