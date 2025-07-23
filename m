Return-Path: <linux-rdma+bounces-12431-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97318B0F919
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC571CC2CA1
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464F225A23;
	Wed, 23 Jul 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wgMimTeA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2044.outbound.protection.outlook.com [40.107.102.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68D223DC0;
	Wed, 23 Jul 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291946; cv=fail; b=ryA723Dxzrk1TcwhXxOGgBQtdnqwsuZnJ2rcj6W3OWrGl7FNd9EFvRuD4cpa4XQWIKXic0XZHhHSGSiluCo5+K3ws3Rx5o1ZJyU7LdLCVrLCdNwbOv8ATDGikfvS+WhTyVbw/ek1LwOCoJh4hzPyjBw2H6f59F6QswhmPa0q7wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291946; c=relaxed/simple;
	bh=nwe4n1jslWdRsh8TT24lHkQlTAxVDSYwcSul61MoSZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIScLdoFg1pv3ePaL2EgxmIKIs2G+7OCl205vDuT1dLVsPkNLo9ocFErxmy0Ke9NqcGYFxilRLn8ROzAAo8n8NK14a0Z7gMJ30ghCFbXzA0ZIQMvlcUa3oS8RTq2t1Mwf5n3U+HC+v+8VKGt4RuAGEwBDtgLRXO1f8KcW/jgSx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wgMimTeA; arc=fail smtp.client-ip=40.107.102.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfY263CzwoJc0UCyCq8pt5+A5KL4s7DvYXZYJTvtZ/q2JVSkhGCgjizhZbat9I6MC7l4Lam2gr6m1fjNnwDUt3IKlrLnMjjt38IoV+8DXcmCLUr35I0vfyIvLhnq4nz/3oZtqwkXugAYbkKhUprEIRvzzLU8pQsgW2zf7o87/8dIrCgF81dmV43SaO5wiRbENwSDjffuaqdITboLsv7OhFTw7JCfS/DYP864ePtUb98xYFKdtvOTLfntWVmIsUrT/4Wy4JQ5QhYAF+zuJv7G7k42NwENwIlvJ2Trudx6Nq2GtonFQSMSEitq4QFM2FcgDKTyo6Gi3SaAhPw0fhd8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zIBqCpzJABVFWlOshMNx3Oyu/y12bn2cV+0Yquf//M=;
 b=Wn//LM7WKViEEdQShCwMpJagBvAWi7F6aEflGy76FKrtAQx8vEutERXugXFb7B+mnGsewRmm9wdyDR7jOth9bB1eSqIRqKQgy6dwUnjs9+vVe3LfZWs+hvF6LS+f2H/DR/kCIH7nAXR2md+xCY8LttikY6u8a4aD1Igp07PkDAX6HtoNbOawSZIcUHRhewZB0iLjLU6vbRbrw440ohEyU7zQYBZPdHTuE8xk3Pop+6XDT4UQ3pZnGltr0Qq79jLsAwsEBCRS6z90mVjui8+hR/aVS1WMJY2MQegUANJzFMkpMDqJ1GOShCJpSCguRpnKprHkYfrbPZZOoetDt+8JYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zIBqCpzJABVFWlOshMNx3Oyu/y12bn2cV+0Yquf//M=;
 b=wgMimTeA9JMD5FkaNgg2Zn+N1T4166eo/Nd2O9q7k5kY/+jRVw1+4IhmagNNkKiUSIT3huHcDhDwDTmDgG6yT81ug5ex27l4+WgKuKLQ+s9Q6BNUZ8YL+1BspHGu7gGEEwgXdenVGJ9Gc894KqedudEqngDtEfom5kPuKmPpEpM=
Received: from CH0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:610:cd::27)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:32:21 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:610:cd:cafe::7a) by CH0PR03CA0112.outlook.office365.com
 (2603:10b6:610:cd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 17:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:32:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:07 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:32:03 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v4 02/14] net: ionic: Update LIF identity with additional RDMA capabilities
Date: Wed, 23 Jul 2025 23:01:37 +0530
Message-ID: <20250723173149.2568776-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: d2476e09-f3a8-4a1b-9d82-08ddca0ee0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?35zU/Bcv+EXSs2BU+E41ucg5Cy56ebfHYpqsrekN5BjE++wRnx4KfiegjB0V?=
 =?us-ascii?Q?kI2l4KOzeDUay6hjnL+ffEHWFly+BdAp0SIf2g7mhLFeGoUyjn0u3gDUCFoJ?=
 =?us-ascii?Q?0sFoWlYGct4tHVQhRDR+z+qEw1wljrXiq9kwxs3Mh+p8qgWUyIAz2uMZ64x7?=
 =?us-ascii?Q?31QGz9sLDZnIhgagfpR4Sb1Mj+ASQ5cyOInBYlDXKQbwwa+Q6DoiyRqoWn3y?=
 =?us-ascii?Q?WWOFFxn7Hs/M1HZKCL568j4B9Ixkg20AksCG3BPE6dauqbCA2M7Z+oU1TBDc?=
 =?us-ascii?Q?pOP70DtomrIfP/0HCY1MqeoBQDHF4+Ff2at/emxx9wFXvLz2JwRidN1UGnLB?=
 =?us-ascii?Q?xRsSDhwe0os5l3v8uBEC1K7/QXfrFtsnHtKX4hRQggC4xlRRCqhcAgcus01k?=
 =?us-ascii?Q?BXtG4JvOnKmEBuJGN5QJT/0+2NvlMe60Vo5W4y19rgfT5bL9WFf0Yk8QaMN7?=
 =?us-ascii?Q?FT9Bf5/k2iEr9cEtbuwW4+ddZo4r/71HtG5KanL/K2r0LJw3IuwZK8I4BL6X?=
 =?us-ascii?Q?XpXbgLUdgrTlhrIme/34UV0wBcwvwBkIq/wvzv4ssc3nivhxp/aJecFwEo1Y?=
 =?us-ascii?Q?WLRU5VQep19o2D0hIlOTX+/c00Ux6l+i+4revxaTUMggPDhK43n9JDLCvb/S?=
 =?us-ascii?Q?hoio9hFL8Msp2oaxe2/Ic3DQ+66yPTS0sHXVPyFTGoAJAXdhtEPKPdW9423u?=
 =?us-ascii?Q?Evtju/IpkImC6L8pjRgyU5Wsys4W6Q3ACLYGKRXwtU6lk1955gysTXhxx1FK?=
 =?us-ascii?Q?p5onDj5yFK8tWmVKnxRfU9exVaXGoHlShv42S1y6uVJHfhbVzyrIDJWhD8PN?=
 =?us-ascii?Q?oG4vE8cabgkza1w+4af7+Bi5stwsZ3CSvRdxuVePF/M/92X9OIzM4dAUvLcE?=
 =?us-ascii?Q?hWHc9UvWTtOq2MG+jD2dzQ4sAzn5HoIxjGI+ysMMNStyIVlYfVflXso2SEnU?=
 =?us-ascii?Q?VAwTvAfZHORJWm1nwLd76SSMZ++9upOuwrHo4i8Knl51w3g+alJFd9+WKV0O?=
 =?us-ascii?Q?FLF7nZgDmKCfskOW1jkmdXCEVNDktfKZhvOe81Tmi8AeeDlqWOSrE61QIVgJ?=
 =?us-ascii?Q?EqAhY1tYkSHKsxPFEj+/U430JDUFJLHy5oyDGH9XZ0DHL3EvpRTDmvO70qnf?=
 =?us-ascii?Q?EN4GD9Ee4FJM3OOfVPMub68uJ6S1c+3hNIPwQA0KxxkGaljDJoSPWekkSY7m?=
 =?us-ascii?Q?yKSRVw4SNf5YmYmfndxXJ9N1XoStJW3i78dzdHVfMe237UMRNjqtx0SSNoBv?=
 =?us-ascii?Q?7fj0SqDavI1fC1xsNa0oecKgU+FDEZY+s2pjgEm6MJcoUv+LdRb+Fgs03z9k?=
 =?us-ascii?Q?qLrPNvdbdgvYEPvkLvUimBYCmGb+aTPeUjFhSk7p78PEgFjrpgL0OHR/2iGt?=
 =?us-ascii?Q?Ma6bMXZO/WZ5t/YoLV1CIK2HysrbzGwERKkK0bNK6KuiHxBN5jdCxx1/3Nhj?=
 =?us-ascii?Q?gLWkC58ZIyW6lc5gfaXOhDOCfG/TcrtMqHYK3R1VkBtV69QVHeHM51AJ51LK?=
 =?us-ascii?Q?xKPOknWJ92EEnLIyZ9eY0iSHWKrev7gbI3AS5zE9p/fOLL1bGqHC/G4DUg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:20.7330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2476e09-f3a8-4a1b-9d82-08ddca0ee0e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649

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


