Return-Path: <linux-rdma+bounces-12734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A17B25AF7
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFE9188478B
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E690D226D1B;
	Thu, 14 Aug 2025 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ww0kV8KJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342712264A1;
	Thu, 14 Aug 2025 05:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149974; cv=fail; b=RNnSCTRCnwMdblrgEfiAWOpkGnoeMOSXKtWO6fAjDFjA0MHnEyLDo2cshxdYoR+pwEie82YrZmTwWidl944mblHeIyTEL6j930Z+zhKWaHg+ug6rhjg9il2/4rUFHWw93YoL31SOjrHcCV3EQvN7FPIHsuiX2AHuaVcStQas2t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149974; c=relaxed/simple;
	bh=2IcA+ZewbIPBFTMAhKNmsUJSwq3Ue4LkutemY7k5U4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVfUHMevA5s95g7zPKRSp4PZRC1JK8mnckVAaj5bVSjPGiCZeLE74SHp7nQO0BvZUIK8r3JrujzXpWRl3nrgfJSKpO+kXFSrmCJuX7I2O6PluS8l7R3nkC28pThOcd1xPfdWTre97p9nRMJR3U2fUtLHn0I8MWOWJp7H/6cpomU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ww0kV8KJ; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gq/dBi2QW2a0kNSTUHslreR4lgo0HTpNFulbIEUAsrAAHNMU4qxo9X/azVnl5yS9r4s0jnqMuxkxNxrhptkc9kyZAOETxUwOCXnz1RGNtKQu3VZGRalD05sSvO8okPhwrEuAkGkbCDLbxo59BKUek1sQymqKVp6b+k/4lmw+Vq90nrC+1+t2i6ORp9fBbgOEgfe4azTprqUoEaLMdqL/mZQ034ZOCWI3G6gKtSs29+oHGJesYEAyN5jWM7Gb3Fp3wDQNIUhvlYFwJEdYvIM3kDx4jb3aCnPkU7qb2yk3QSMJNwDB9cdz7F6bDHO0jSZqjikOoKw5cWWmEz40kX+u1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi+wCB2dAlASJvVCJ4PZ5ZY4vvQzdKDiY6XUBQjouFY=;
 b=Tyt2Nmck8yqN28QIrhGsp8I0Y7e1fLWxIBUoc9Cv+a1b0GQNUiquITrsCqGLbDZ5LBr1SZ5YYkk3elW2uYD4eh9oRBbWGKHqbNpMdEJFFo87+ogrLZcAzH/c3TURbmGJtR0DGH3f3LL9jYCsnyr+5/UOAIDyHtdpTNHnFn/jff4dA54Gvb+INVj24wcSzwO7ojCzWYInOBazDI8ZrRMQXnytMYlG63FWIVUt1z5NfqaOxQVUXmkaXOXYdFuskJ7FpstCfhwGDCoM4YwM07lVoBv8ZJaReAd9ht+A4UgLRqFPyrVWGPkilgcPbRxEeh/XJ/j964L2IH/fo8nUPE3qOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi+wCB2dAlASJvVCJ4PZ5ZY4vvQzdKDiY6XUBQjouFY=;
 b=ww0kV8KJrS35QOJ5SkjSAweDKzUbG3H4+4UHLrkWaRhXlp/9ZDwNjK/RDefSJJMbGmxKGNTSOAEPTcA9XcQz4DgTCi2w1gF5JK5GjgkS4CHUthFq7NqGPjwg1pvbygWpyKp0J+RoL7m6BYXC30FIBZFmQC8PkW8jvNzkRJUyBUY=
Received: from BN7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:408:34::17)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Thu, 14 Aug
 2025 05:39:28 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::42) by BN7PR06CA0040.outlook.office365.com
 (2603:10b6:408:34::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Thu,
 14 Aug 2025 05:39:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:39:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 13 Aug
 2025 22:39:24 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:39:20 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>, "Simon
 Horman" <horms@kernel.org>
Subject: [PATCH v5 02/14] net: ionic: Update LIF identity with additional RDMA capabilities
Date: Thu, 14 Aug 2025 11:08:48 +0530
Message-ID: <20250814053900.1452408-3-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
References: <20250814053900.1452408-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0de651-f2b5-445d-5664-08dddaf4eef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7KkbpfybfbgAQXaaYeui8LOXS3Qd4Rn6ua9CI0lV2/Rq81xOYumuO/VcdA3R?=
 =?us-ascii?Q?VABG94jo9lDcfwBwy+7tjvbSvM6eeZ/r+ReIzecil83FcOdkvXy1/EhhYcbE?=
 =?us-ascii?Q?UplaUkZCKZX+Dlb6OJo91C5r0wnp7x06wZrsQpL5DeDOeU2ve/rSbFxMLbz1?=
 =?us-ascii?Q?HrqcKgr2VMiHEPNAauOerkr0eX1jBadgLvZ6EKJ6asvd8lDSM/Xm1Naoj3xC?=
 =?us-ascii?Q?EkX4mjoPCLWTWI3plsveq407m375G0ys0slqkAk8/mmEhdOk3mnr3yJYg0qx?=
 =?us-ascii?Q?1oX/tuWbZE3I8RURIgJsqNay9N/rDKxWJkKujtrIE6geeavvMbkkjIDzQwOk?=
 =?us-ascii?Q?hrCo8UF1sd5zrKLilsU26cuMt0uW6DO1ry65i8r05hJHDYbgymcYQOWgHp6T?=
 =?us-ascii?Q?N56M/F+AgK1GPJ7NGjy2B+C3MqS0yI0xJ9Av9KcsR9fxiZzme311FOZyXu7h?=
 =?us-ascii?Q?40mDcMjZMcJUeMKqMwA8R47M5F6aj63c8kSyHkQKxr12cNf1PYHnTXY+nivp?=
 =?us-ascii?Q?t7C7briKYLJXDZmCZLf3oUxapIKEjTy7aKlQxe7OZJ+VfMldyxgZ2KwX78oW?=
 =?us-ascii?Q?rPwdYiRqw3yMwoMEfF9Tyoc1pawPIZWP7dzPcJ/+I18RioSsYGGzl/zfBFPh?=
 =?us-ascii?Q?6dpSSsYX56paFpIbpD26OJfAn+PqzkVLrM9Rd3OFoUAPYhhOKlEEP4aXTHvH?=
 =?us-ascii?Q?I8MBlmcJmzDw7VmXRvpXPVvj0JvpExwLsBAgGd6WR2tpowDmNqz9ANCNNQIF?=
 =?us-ascii?Q?tYkG0Gh1N+czU99IQZ+2DuK5b1rrQK+JiD0e9hwch9oUoE9xdcpnalJ4XArW?=
 =?us-ascii?Q?xlRIhwB24EAp45gYwVMyWGshJkdO8+AitPTdwqldV2LMQrxsVZEKs1Eh30wF?=
 =?us-ascii?Q?LczF8EBrxC3Hyj/v+WiApXtlT2U487S4afMZ9V0XLX793ffu+N3Q2kUgwcD2?=
 =?us-ascii?Q?MdSeJmwhyK1j1jtpdCA7zz671bdZyffh/2Kw75/CME/dDHTxhMqtsyeT12LN?=
 =?us-ascii?Q?tK/63dnjH3SzSAw9M07X8wU7/S6a6oM62BXqyM4ps8hYmOvKY/S+oUBytkSo?=
 =?us-ascii?Q?JfNb2BfNgk/CmzNRk96OQU3J4wAWCQXicE3EvF9sDC6d27UrwR6de1kwdR81?=
 =?us-ascii?Q?wFGPWi9zmxq5HSs+EDLQbN3EloMzToiXUIhQS/2TBrCuPi/jPhwUBYEnRqQ2?=
 =?us-ascii?Q?Ay6ime7daVPOASTssdS4n5yARTZxA8FO5qbeYX3S+fboJ8a0o9F+ZIJu58Pa?=
 =?us-ascii?Q?wtYNBBTJ2cAegybNwQBAYbe5aoFvelB9OViHQvbDvjz6RoUyEBVI70yzf58n?=
 =?us-ascii?Q?yS/57Wc/zhzacw2nUe9pyIV9AgcVyZ+REauWpaOU6EbtRbSNDQtNeCLsKhSr?=
 =?us-ascii?Q?IryOsxBkyJmr5c45acGbmogo6HV3opfjCpZwJ5tWZDrp8bqBhJIitniSFkgN?=
 =?us-ascii?Q?I4bXdPmOb7LhdUBeIgX0FsX96faUBlTD1kgk1usyQ53l240FeDtUHs2o81U6?=
 =?us-ascii?Q?U+afXZZBsbbUmFg90jc4UeZrjkCKAEbme0kP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:39:27.2103
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0de651-f2b5-445d-5664-08dddaf4eef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170

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


