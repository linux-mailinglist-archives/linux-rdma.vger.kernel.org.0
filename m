Return-Path: <linux-rdma+bounces-10133-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C74AAF24B
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFCF1BA76DB
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B601821504D;
	Thu,  8 May 2025 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bewruuh4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66B22144D6;
	Thu,  8 May 2025 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680454; cv=fail; b=t8VMLVkNSlG6oyuX/PntK2uLE4y2yQIZzGE6uu48b0BTKkvBKZH1IOmr8O7BIhmQHjvvNXr6LwbB+rlTbpU6Yf0m+hILwl0uAKt7i9FEeRMnggUUeKZSkGnW/3z/zacrkFfWByssNFY5aXxJOMMj2KFxdcGBpqIHOSwKftE5QXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680454; c=relaxed/simple;
	bh=8p4t1fCLt1KHn//oXmVq5U+F3+9RBnbA2c/fY218Q6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDkYXtrLUhMKiIS7Nf/6ZVO2oBnZtIoZbaWmzngD1QNWFU3ZxB8V1hRN8NYy4xcOhKRAXMOn5++C6MxSPIlrJ4/N3D3CDdJ0djEfpeTHWADTCBRiqkjaFIGPLZ1kX6Jqu+Z0en9oRUK3aUL9cZHZErohFis2QXvSYF3a035fblk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bewruuh4; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTPt+GIi4Eru74r5/3ZSa2V2iqv6wWdGM5Tvhc5OC90J70aCWehvFYLBHKKKI5UcWYXQTrQr+eMmPm6twjpC0SQY5nSLK/N/BOuMVCkl7GwXFLGxK/fuqbLiywVjYzz2U/jqzTJxF1iuxumP2Sbdtgc6hxieZjC4Q+Wy+n/cX22Qz2wF86qCWnHe/d0YNONGpyd9yhBe+gDlPBQjS9qGI5uXEa6brfkP2dOzOzq8JtKl4Et5GdOv45s2iZyL0lAy7pGgMmBmRzF+MMRKW6Ip6a7ytM4pKUSEsavAFge0kxy0sBd0c+SDGBNDOQXqABGHbMUsRlNkagxHjrI3E1VWbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZSVZ2YKj7dfjDtPRBHrcBqRBP7XJBHLZXP7XiuhDlA=;
 b=oxFrRkomYOeVLflYhWDH9KvKN1HC9dmG0Yfo6T0jtxGhliwmj2kTBZsvRoYh7LBsSNMsIXS7ilYTI5stRXEtU9F08KlbqC89hnkR7oq/aaEmCvrojYHRicquWUltoazHxpDkJnLdTaXi3rGsEb7oOyLy/7Xertgs1qZKnnqTc501/mdwxKnfauxhdEHZMjt4DH5eHPbOs4oFOS238NqTA/K2AIBbpvj3bFDltA/upevUmb/08MGS7QT8L77iArVc+u2GECbxWBNni7xv8HgwiFEwZUrKwCz6WCnnfs69R99+H6V9iLws9kRcYTTPrhRGJ5Zfmxmj8linmgWb+zW6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZSVZ2YKj7dfjDtPRBHrcBqRBP7XJBHLZXP7XiuhDlA=;
 b=Bewruuh44RoOYbAVVzw2Cvug7MoMy2zgRv22kVHXa1llYNFQqdD21gvAAaFXJ4pyZDgqahO7kYktCThfgGYjaD2IOrhdGEThXJJ0IXAfVI3HGPux/0KuPX29g+qFG0zab7n8vBai6Lard8VStlIZZ5h/Cz07vbgdPjPm6f2pdrQ=
Received: from BY5PR17CA0070.namprd17.prod.outlook.com (2603:10b6:a03:167::47)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.37; Thu, 8 May
 2025 05:00:44 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::c8) by BY5PR17CA0070.outlook.office365.com
 (2603:10b6:a03:167::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Thu,
 8 May 2025 05:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:00:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:00:42 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:00:38 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 02/14] net: ionic: Update LIF identity with additional RDMA capabilities
Date: Thu, 8 May 2025 10:29:45 +0530
Message-ID: <20250508045957.2823318-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: e48eacaf-15c9-49c0-d118-08dd8ded4991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z527fyLFnTAz6GTYwsraz31liNcMgqsybl0kNkFhsuEgC3vN3C0e6If/a+20?=
 =?us-ascii?Q?apxMT27eYVEAxCBn35GFPTJd1Aj6EhwvdI5RK96ofdWkoXRJEwhxS3XVxgLl?=
 =?us-ascii?Q?Eqh0dJZJnruPCLW8ZyYXOvxkClRiEdLvG+GzytDPUroG7olSVVyS0Y7nQ1eK?=
 =?us-ascii?Q?M/jXgEJjUP9I1z4d7dtQqeejcfD349PqnErh/jZvyEurznLH/hYahjH7GS5T?=
 =?us-ascii?Q?msc5RT7xrT1atVYBFgGLQOM2aoJXGJY5LmC3QqkQgOtB9Wtbbpe39sDrPQJ+?=
 =?us-ascii?Q?bruapnPHNr8Vfyjh5m2iTptMoBLGuRZx6MGWBERaiYLhJm37qSozfqcF+gwo?=
 =?us-ascii?Q?TYn1yYK7CloABePy1EgDh5Dng6KOX2A6/OUHP6kYx+DnK/qdPQ+82EqSDCFT?=
 =?us-ascii?Q?Yz23VuTbYQO2TLp8w0IxgvOVQys3Tz16p5BvE1nj31XHvH/wOLooTqvIHBTc?=
 =?us-ascii?Q?94npRzMvfqRTqLHQ62sYJZiW5aWBh8QfOWfXwbUpD3atNMDgqATqT3yMwURo?=
 =?us-ascii?Q?BzWUcfgW4ROkNFlN+alnlNNCxacmdZE6cP64U+Ujq8wFz/FJudq6XNY/4RDl?=
 =?us-ascii?Q?QG1+zWdaeR80CLCu0o29JVJjMgA35i0w68fm5s7LjKvS4FZufv+jfGcpMwMM?=
 =?us-ascii?Q?A36uGG1b6vZ8eptIvRJfuAXt70FLZtipaKiiRhiC8GPiI9/+CbplY1IDM0NS?=
 =?us-ascii?Q?RTvcRU+9T7K9r9EEjZe7YhcDZKXEx3k+3b5jHFzi9CFpSKQc6swnnUT0FOqX?=
 =?us-ascii?Q?diQtegSnEs+9rMwUxUHTb3E3i52lDLJNYPo0J0xiV289UbiEjagk6iPgaud/?=
 =?us-ascii?Q?FgaYKpZvmDtBQh+leWNaHDYBF+Ox/75pCa5IcfOaVVgBzNKR3zfNX2nA0ZB/?=
 =?us-ascii?Q?6RBQU6yZk2pJsRTuwFvVWSxrHaGdwJR1xtpgF7u6MYmy+a/8NIK/smtnwnbT?=
 =?us-ascii?Q?lQtbAusVr+gVo9+p/njn3EWRpkqmw1Vr7EnzX5LZu0so3OX5cZBiBO2evtB0?=
 =?us-ascii?Q?StMHSMQQxwlN/xMSf0IyB78MLXJuM0YIrqonsJM0Yxx9f/xy6vNFk3ypPFd0?=
 =?us-ascii?Q?vpqt1f1n4ci6wWHmKS5TV8CcsP6tHjpUYOnB9OJGOjRGuBfMWvR4QRfkrGqo?=
 =?us-ascii?Q?TMozjihlDVWZWfl6/HJxAUH+/W+/FTfkDcy2JteoqbBvfAEsxwksmGWMQL45?=
 =?us-ascii?Q?NNv7SJ+AMsfBkA+Kl6SHgFTz3gjLmbgxa4lu9+HRs4baZnbjKuK8mUtkBFMB?=
 =?us-ascii?Q?rTglYOaXoItXJ2WYl8luz3P50fhdQ/8HUyeq/ddETonNI1OXKwjaCwolhXzE?=
 =?us-ascii?Q?jO8cEA5pMHI52L+HPIByuPbbCl1WexM3JWI+pbE2lAI8xyH+oLO9/OtCWmp5?=
 =?us-ascii?Q?sdkcHY3t6vbTu/Rn3dl1h2Qp4+8lcrR5C7JVJvPKWmJe6Bc1G1A8hcdv7N1T?=
 =?us-ascii?Q?HR1Q/Sch0Em0bsMJldhrJlFfzXmwRbLX61Z3MbC9hqo/yq/he7mKzLNXXUOg?=
 =?us-ascii?Q?daEG7pEbGNdxl4x1r2Cwla/G7LBf2wsT2h1JBJwN9rX29lov6FhsmJn1qg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:00:43.6078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e48eacaf-15c9-49c0-d118-08dd8ded4991
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

Firmware sends the RDMA capability in a response for LIF_IDENTIFY
device command. Update the LIF indentify with additional RDMA
capabilities used by driver and firmware.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_if.h    | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 830c8adbfbee..02cda3536dcb 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_if.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_if.h
@@ -494,6 +494,16 @@ union ionic_lif_config {
 	__le32 words[64];
 };
 
+/**
+ * enum ionic_lif_rdma_cap_stats - LIF stat type
+ * @IONIC_LIF_RDMA_STAT_GLOBAL:     Global stats
+ * @IONIC_LIF_RDMA_STAT_QP:         Queue pair stats
+ */
+enum ionic_lif_rdma_cap_stats {
+	IONIC_LIF_RDMA_STAT_GLOBAL = BIT(0),
+	IONIC_LIF_RDMA_STAT_QP = BIT(1),
+};
+
 /**
  * struct ionic_lif_identity - LIF identity information (type-specific)
  *
@@ -513,10 +523,10 @@ union ionic_lif_config {
  *	@eth.config:             LIF config struct with features, mtu, mac, q counts
  *
  * @rdma:                RDMA identify structure
- *	@rdma.version:         RDMA version of opcodes and queue descriptors
+ *	@rdma.version:         RDMA capability version
  *	@rdma.qp_opcodes:      Number of RDMA queue pair opcodes supported
  *	@rdma.admin_opcodes:   Number of RDMA admin opcodes supported
- *	@rdma.rsvd:            reserved byte(s)
+ *	@rdma.minor_version:   RDMA capability minor version
  *	@rdma.npts_per_lif:    Page table size per LIF
  *	@rdma.nmrs_per_lif:    Number of memory regions per LIF
  *	@rdma.nahs_per_lif:    Number of address handles per LIF
@@ -526,12 +536,17 @@ union ionic_lif_config {
  *	@rdma.rrq_stride:      Remote RQ work request stride
  *	@rdma.rsq_stride:      Remote SQ work request stride
  *	@rdma.dcqcn_profiles:  Number of DCQCN profiles
- *	@rdma.rsvd_dimensions: reserved byte(s)
+ *	@rdma.udma_shift:      Log2 number of queues per queue group
+ *	@rdma.rsvd_dimensions: Reserved byte
+ *	@rdma.page_size_cap:   Supported page sizes
  *	@rdma.aq_qtype:        RDMA Admin Qtype
  *	@rdma.sq_qtype:        RDMA Send Qtype
  *	@rdma.rq_qtype:        RDMA Receive Qtype
  *	@rdma.cq_qtype:        RDMA Completion Qtype
  *	@rdma.eq_qtype:        RDMA Event Qtype
+ *	@rdma.stats_type:      Supported statistics type
+ *	                       (enum ionic_lif_rdma_cap_stats)
+ *	@rdma.rsvd1:           Reserved byte(s)
  * @words:               word access to struct contents
  */
 union ionic_lif_identity {
@@ -557,7 +572,7 @@ union ionic_lif_identity {
 			u8 version;
 			u8 qp_opcodes;
 			u8 admin_opcodes;
-			u8 rsvd;
+			u8 minor_version;
 			__le32 npts_per_lif;
 			__le32 nmrs_per_lif;
 			__le32 nahs_per_lif;
@@ -567,12 +582,16 @@ union ionic_lif_identity {
 			u8 rrq_stride;
 			u8 rsq_stride;
 			u8 dcqcn_profiles;
-			u8 rsvd_dimensions[10];
+			u8 udma_shift;
+			u8 rsvd_dimensions;
+			__le64 page_size_cap;
 			struct ionic_lif_logical_qtype aq_qtype;
 			struct ionic_lif_logical_qtype sq_qtype;
 			struct ionic_lif_logical_qtype rq_qtype;
 			struct ionic_lif_logical_qtype cq_qtype;
 			struct ionic_lif_logical_qtype eq_qtype;
+			__le16 stats_type;
+			u8 rsvd1[162];
 		} __packed rdma;
 	} __packed;
 	__le32 words[478];
-- 
2.34.1


