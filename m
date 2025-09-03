Return-Path: <linux-rdma+bounces-13049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39835B414DE
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FA1174BC9
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A52D8762;
	Wed,  3 Sep 2025 06:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OdFnYJc+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427C2D7DF3;
	Wed,  3 Sep 2025 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880252; cv=fail; b=nxPbVED8c1gV710yRC7Z2tcHCniEiL/OkkPyDJG++CHX93LuprG45BmufjS2mMDLjOVIpsV9WBG736AM+PSYrBbioa89F/iVSdOS2QdwIRrIxHD3HnUav3cOfKITQ4RbIu3YgLrKyKTnSWW1aos3HsIREiBrGL9RFxRWtJXW81E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880252; c=relaxed/simple;
	bh=2IcA+ZewbIPBFTMAhKNmsUJSwq3Ue4LkutemY7k5U4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rh6vrFJh5K7fY9HlG8bC4KuYxMNNzOKE7GpMllbg4eN1PmY0HjS+jYk7tpYpyAdFo8L7FCzDDsB6BX+tmHfYMEppqIHmWfrteE17hDaX6k1CBPldgl5+3IEqmp1pgWyrjDzYCuone8dk/Vch890iIdqyaodbxCYCVgiYg8FZdlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OdFnYJc+; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMNOvoAI+pJ4nvbLorIESgzrYCzR7eT7BH2ymEI6jC9kWVnboP8FXMR0NGLwYd0RlnLnjuRy/JeavFlPzDvy2hJDbwdze07LYtBBtLv8NvldmbevWUBVRExVImuDYnLbfo6h7TMpnEMaGSnPf/5V8lqDE6radocJIsV2kYVBSjvCGOfC/eL7HRB6lqhOy5xHwIrRU3OOlQN2DAQJ3A2VTmN+hbRJClfL5EX1+HLX3EwrbozcNxLiz7979VA9G2+PpcKlole2cOjNXSiCcmdQVFIGa52/s7AP4Z+3gcd4VVncboPp/eni9jk0hjk/6ZDus3N2SyOq5LgclfkNMBwTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi+wCB2dAlASJvVCJ4PZ5ZY4vvQzdKDiY6XUBQjouFY=;
 b=d0wrLtH6581cCA+o4AQCM8TkX3zvrlMEOABD/pUImYfmhv/4ohKkRuuARIVQKJQAmI90LraVc3nRAdaEkny2L1X3lmJ01IpGxHd0o+sWmyE6Yq9LPBkVrYiA78ZK54AtkE3Z36KNtNfQrgLGX+gVF/Hf+CLDeWkaJcvqZtgLkq37N+cfdp1txeQRseY37fnBG02BjXTSmWOyS7jfjMI7BYrhWFK4f5KA811GwzZ54hJ+b4f3u+K57Rmu4bz/MMfMbmBzfHyCnXVRnGQR0wKjUcyieWN034XBy31NsIAID0OBvSh9fdVInbYqeDo0Fd7Yc61nSyt0guVyGmvpTiWvCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi+wCB2dAlASJvVCJ4PZ5ZY4vvQzdKDiY6XUBQjouFY=;
 b=OdFnYJc+nuKi/wX2+UqmVwq3Dv+XwYcmgj42IKnLXqrrRHlIYbY125gL9bnjDKrrtvdEIP+jYmqNyqeFVjT94x0h9KXoOqiHnCYublmbpfXHdZtAFRlJeYuOnIX9TzM63DKKlbTif81DKgLXQH1ujkLnslBQMHiEqIyGRdDl7Fk=
Received: from CH2PR07CA0053.namprd07.prod.outlook.com (2603:10b6:610:5b::27)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Wed, 3 Sep
 2025 06:17:27 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::bb) by CH2PR07CA0053.outlook.office365.com
 (2603:10b6:610:5b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Wed,
 3 Sep 2025 06:17:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 3 Sep 2025 06:17:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:25 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:17:21 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH v6 02/14] net: ionic: Update LIF identity with additional RDMA capabilities
Date: Wed, 3 Sep 2025 11:45:54 +0530
Message-ID: <20250903061606.4139957-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1a479c-afc2-40e0-832a-08ddeab18dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2zB4ZU5M4rGvNOshhxNE5QRtSWZ5UXFEDToOJq9QE3A+Zr2q/LikOGrqPsp0?=
 =?us-ascii?Q?zy/cPrernKF+Z3glxWcJ7gUSLwUCCAl6uWk0lP5SffgwnLkSWVYubsoTrZmL?=
 =?us-ascii?Q?Nh19fM4SuMqCDMQ1ujADqqdLN3sSaoGPlHn3i81ANcZG9YugNeOKDzFKc/bz?=
 =?us-ascii?Q?uDcGaNbzs0eE4hhTdXdRRgobKLXtM8YNV0fmnFamehFjLoBnTFcqrtJN1Xuk?=
 =?us-ascii?Q?r6qWNJeFy5vXMhtk47Vfm47+TeTSigsFp20jZWRbOBubY/I698RewRF9dTrL?=
 =?us-ascii?Q?C6WH0+JZblAjIEikzRPTSl0yZoQ3k+mqEgDwtYKjBCHvStBH/jCO0A8JvEwW?=
 =?us-ascii?Q?LVIdhBS6kxno2O6P2T+bMFdDe49UsCN7SOgODnxZQX1mEKUXKb4OW+kPDDCf?=
 =?us-ascii?Q?cpoiRaR+oUI3MQcqYWgQgS+gFa//gLvrJh1Kf45y7r/lAZGcss7dX7pwkhjS?=
 =?us-ascii?Q?ai0ZzeaiBLre9f/Dpn+tc/HMJRiG8Q2LBGo8Ic1y7Vgk+LQmAUILPrpEsGNY?=
 =?us-ascii?Q?B6RCSFQ4rEtb8m4T+aFNS/VnCvs6A8F2rTANKzCAsDdHJwNOn7NMQ7kJxdWH?=
 =?us-ascii?Q?X7WFW5xhOCqpWilGg0e6VKVN22xSfi2JJ8WdluVauDqHqg6OScEqvPSpb4ea?=
 =?us-ascii?Q?wZbxewfEirccIAUNogeW1wVT+HJaxkTLI0r88UtYenvL2nShXi9yeuZQWhzO?=
 =?us-ascii?Q?+evpH8lmUuLqhorT75f5BBHR/tDqdiWA6B+q3m/8x6WVvv1P2T5Lt52l+fLb?=
 =?us-ascii?Q?VPPRP+1LZnNixWdwHVbntO5Q00WahQ7tgAInKWL1foroMdtKE4CnPqGeXOvx?=
 =?us-ascii?Q?B9RFCIZOJL8o5h939Mw2C1CrvIzDno9/bT3dZZK/h2t1pR/kTK8DKWcKKqWG?=
 =?us-ascii?Q?Z+oACISQJEnS7sKpQ4xEjp2X7+Mc1/L8GDeCoGBaYQBwy1hp181TStdfvc6G?=
 =?us-ascii?Q?3KSiJ2RsLQsVHwnANy+pnf7h27/kIM6G2CsCeh+bhDdzibz/DeVyZm5+I8JJ?=
 =?us-ascii?Q?li81jwDyiTW4Y15C+IlMdaN4ez63Amm/Zvopy/DsjaA6jC6ELJDqtYWJ5VrN?=
 =?us-ascii?Q?KYr/8nl9piE7QyZ3vjhW5KnzWzgFtkSXgzXdVBihEXbrfLWfnm89s3Nh5ln/?=
 =?us-ascii?Q?gsyUANXE6RdblBx1RMg/ciWf9oypulQiTaAk4C0B6q0aKxrGIdmCrW9lN0+8?=
 =?us-ascii?Q?d8RCjVq5VroVYMffgORhN4QqfaqAvAC5KCrRhOJigm1y1J/FHeVrB3xFFCFG?=
 =?us-ascii?Q?frNplc6hziNGY5OdRgewZSfoFs/d3ys0+ogXxMknasgIf/WxwydyRDF1m+xx?=
 =?us-ascii?Q?eNNIIDJzxAII/dK39Vj9dudwkZiyaYuU8OFu7YLTt6UAZPuKsGA/9pt0refY?=
 =?us-ascii?Q?WvaIEBZp0qtKiZK5Qu7spQCQrqovpD1lWZT3Z5lwRcuBAL6bmIanZ4UBwQLl?=
 =?us-ascii?Q?l9fnAeheU5UZN8WKb/ceHsY/G4V8xsJsrM3g1e9OTlDlIZJb8Djw13b6UmHO?=
 =?us-ascii?Q?nJ4mStbDc9sAgX1qKHYqob9L6USy7pevU+WE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:17:26.7244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1a479c-afc2-40e0-832a-08ddeab18dee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

Firmware sends the RDMA capability in a response for LIF_IDENTIFY
device command. Update the LIF indentify with additional RDMA
capabilities used by driver and firmware.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_if.h    | 29 +++++++++++++++----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_if.h b/drivers/net/ethernet/pensando/ionic/ionic_if.h
index 9886cd66ce68..77c3dc188264 100644
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


