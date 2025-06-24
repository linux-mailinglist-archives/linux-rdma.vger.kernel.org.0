Return-Path: <linux-rdma+bounces-11570-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D731AE6457
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8631F3AEF3A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E594293C5D;
	Tue, 24 Jun 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xFmpBG2K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DB0292910;
	Tue, 24 Jun 2025 12:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767225; cv=fail; b=ffOBK8oVfMHRPmjA28TUGoqcOeWmAyPXkyS6YXetgBdok4+p29W5Rz34BcYd9SIZezZ+x5pE0dGRAiIYav89ax8FpIlxYo4PQiJrrnVOjOyAyPzIM2kWuhj9igE7Wfo8MEJ7Q5SBiu/RWEVviEAMDaVuCGVUD07NCpv6Hh2+Dv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767225; c=relaxed/simple;
	bh=nwe4n1jslWdRsh8TT24lHkQlTAxVDSYwcSul61MoSZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kqp7fyXnEavdvKMjw4aIL+ifuRJsy6pHEoATNiD4kWqs4nZM/35EcqFOuF8DEjTGPZXLYG8m1u/0DH/3wYZIfuUnO5y/VpDDeuZcLgBAFTxEo6nASTdGnpQCi6e1djjl8JO+j6+GCTyzoahP9YcW4cfSoI5YGA3uoK3UD1cwRwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xFmpBG2K; arc=fail smtp.client-ip=40.107.237.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKKQQ8MXEpyze2tp8+7nQ2fgbSPTcC31rc9FbLy/+SODvCa0gMzyEFupeB//if0No586B9bnJVrL87uTlHTQyGHZJsfxOSRJW+O5OJmJqodkzogfU5XXV/ncoGb/RykPfATWxn3k2BcKk/FchoAb1VYCP65dnJFYl1HgquT/sb+oic3URZNoBh/qNKHOnTilXXQ65qpl+brBAfePVcmI9hyO270uf6SDLDCZmJp6ERLb2pc1w9VJrfr56/uQcYUK9I2Quw4/E+obqvU3VNLjM2SrbBii+VDApguWURvdEDWgQ4SirLyFsHiN8KUjDOG8RcHu3DFg/F5OiTU09y/QoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zIBqCpzJABVFWlOshMNx3Oyu/y12bn2cV+0Yquf//M=;
 b=qadWGMq8x25qRKxK+E76tLLRO0TxZ830XMYiB+98M7qQXnY4+5OtnRn1FPPucMlMTpWbrAgda6RfscweCxMg5FfPcOU9JMypXhpBJqgY9I0KzzfWXtaz/hiJAbEwQjtVfzCHuL12EnllZ2k+b8ax9KtNjdZJHvRk3N0MQH/mVufP+dRXNnP5rRnbMSVbDUoMU4BWEpHDZouwTfu4cSFzNel/4EVd4jBIaRHfib1Kc3yjJHLAG0A95BSFufPbHJR1rJcFtUSfVka7wE/pewptwTXJ2ir7JOgU9fXoJ5xa682ho++TVvSPRgJBseuL/r3pipAAfWGz+ts27PfESK4paw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zIBqCpzJABVFWlOshMNx3Oyu/y12bn2cV+0Yquf//M=;
 b=xFmpBG2KrvyMwHLEKdUc1WfF1WgxGJStygDdxDvcRnFin2MlgwSBKcIpJm5JPbJhmlcrXSku3Iz3csc/GAz3pWM3VFaWlv9uRkXSWEeknc0NM7vLkIHM+bwUHxNsWipzqCiVSPuO2MO42nzfTRzl7CYJvCw2eZJh5YUAjyxCAx4=
Received: from MN2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:208:134::38)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Tue, 24 Jun
 2025 12:13:37 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::8a) by MN2PR16CA0025.outlook.office365.com
 (2603:10b6:208:134::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Tue,
 24 Jun 2025 12:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:13:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:35 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:13:31 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v3 02/14] net: ionic: Update LIF identity with additional RDMA capabilities
Date: Tue, 24 Jun 2025 17:43:03 +0530
Message-ID: <20250624121315.739049-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624121315.739049-1-abhijit.gangurde@amd.com>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc13bea-3741-4af2-4293-08ddb3188c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZbLL8OuELga+6lwEy+9A6zOwKNAJIZmuLk20w5JFJYCWbEmqrVKkqPRi4im?=
 =?us-ascii?Q?5d9bqN1BZMr2p3AglBre0nKlkDNEJdqY1/Z2KRyixqdpcJ5OQQJt+llsjtVC?=
 =?us-ascii?Q?Eonxunp4BgO9ILBYJD3/3g9ViBFwTho8BWnqYy5oceoyqHXTXrdvCQPXeZ+q?=
 =?us-ascii?Q?QF4tMyQe4Uc5Kt0baAYDTo/0QQ9SJ8H8uhZ6j8oUbtVM8unZjYNzyOuuL7yH?=
 =?us-ascii?Q?92nKhOMLXeniwcfZkd3speqSXp9ks3RPwUJeYcXoiTIp01f6uAGmDPVgvrBF?=
 =?us-ascii?Q?TEQV9vBuTUMc8BNwJmE8Qn//tC8zysU/eaa7kXcJZdjK9NZToDuaPq0WIWMU?=
 =?us-ascii?Q?cDEV+BHp0K0vA1tGGMsBrS6e1aI/OdO24EdU8nOE2gOxJtSzgA39nSClxr1s?=
 =?us-ascii?Q?XhKnBafSoL8gT95r2npxo7wSbsC4WpdiBhP612ASAV/T4Ah8e9LbIu/pvy/p?=
 =?us-ascii?Q?z+pdkhyjd+JhfdLVAp2D3Bse2Kb2t35bcctNYjAYuIIbj4iqSanFHWqnOHbD?=
 =?us-ascii?Q?BLopYmkdpkceddCz/p6/dYQy9gWw7phN7K77Gb+NxqmPDW9AXvP9IS5GDNqm?=
 =?us-ascii?Q?SktvBOs/4Qs3NoYRTHv+xQCdGTal2dHQo2k/6jvzDvmWM5Gf0E5zpoAGamof?=
 =?us-ascii?Q?fX6sQXBvO+LPSAh9PEdQCsJW6j+LM/yOBt3P8X5JU7PU1zB5BWHTlKlL529M?=
 =?us-ascii?Q?8JmBNZuL08iKj3GsNuhlZKQEpWV4+zk0LyYiUV7pNeFW6t5nysATN1Z8tuYs?=
 =?us-ascii?Q?QUzLSraRTcrZxbHp4nNbCwFaObUMZwdTjLpw14yqJSmmMxVtwNPL/Sq00OHP?=
 =?us-ascii?Q?2ZBNw9X5m5Y02bOtT20TEpfriuFCJ/JId5dJQupu4MZpN40iF1JBe3kY8t8h?=
 =?us-ascii?Q?6wBH7dB/lTC2GDqN78IUUfJ6zABB6iyp/OdAyB6ymSBo37yqoztNW9/CxkbE?=
 =?us-ascii?Q?2nbKdcfRxqeoRAixyHG3c+j41a30rUACcxC/5FVCDJ2o2VUTeJhpiE77zxso?=
 =?us-ascii?Q?WPtudlvp8lA+NDERQ5TDLAXJGhNuq19CDsgRVFg6Ent7/5DqL2sSOc8kKA/+?=
 =?us-ascii?Q?3ADf7QkkOX5hu2f/p1DSF+3A1htGlt3xFr5q5JYUoH04meuYfSN5IpHzTaYq?=
 =?us-ascii?Q?s3ESFVN7nxtHeD11k3Z4hEpEBN39m1y/30GEclbUPHAs5BbRTEVZLuSNZEwK?=
 =?us-ascii?Q?RcXRkD/2a+4iWNh9cLCkrCwcikKleCKCsm3IHepnXU2AXgyB3FcNQmDuxL2M?=
 =?us-ascii?Q?pGAWF+q77/Y4GZD4IAX5iTuO7u7QBOFuUg5Y+hLVsPowAosrw7B8i426iSLb?=
 =?us-ascii?Q?JrJmgtKnPisA1YDtmF9mwkPiJY5scQ5alehb8vsHNAAf1609nev5RMrI8sYo?=
 =?us-ascii?Q?RkyimVAOIvTU6NDrAqMeMYbhv0qC43TmwdXYJzijeC9VylFXDDdD3Haa2lqZ?=
 =?us-ascii?Q?Byztqub6c9qk7n8nUM/KT6ICL5tuFz+hvnLjjZymYEvDvmaOk9MW55TfmT0w?=
 =?us-ascii?Q?kbz4Xb2qY35ydMx6opJWGmtJCqYUk1IakoxjMqQcCa1o0/Es7hEpK9NIFw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:13:36.6716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc13bea-3741-4af2-4293-08ddb3188c13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483

Firmware sends the RDMA capability in a response for LIF_IDENTIFY
device command. Update the LIF indentify with additional RDMA
capabilities used by driver and firmware.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_if.h    | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index f1ddbe9994a3..59d6e97b3986 100644
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
2.43.0


