Return-Path: <linux-rdma+bounces-9716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFBAA98757
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDB35A1C79
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB326C384;
	Wed, 23 Apr 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jqnwjrM5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6826B2C1;
	Wed, 23 Apr 2025 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404232; cv=fail; b=hRKdCEa3xFf8f2ZeePGKv38ynXej7MJEvMMeRIWHyaLbxklQnkj+xOgw+J74kfYOv/jZCuHXlnSA0+XjtNWUbl/CGCtqQ686T/kmnBVqkSRycR2EQI+mDV02UyquJRWdZjS8zSe/oqEl/j7dFxDF/YX/kbUjjdyUd8AzWEhwQ+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404232; c=relaxed/simple;
	bh=YRhJfJSphZdadKXuKk144SQNPraMShrSBtN6qYOJbqM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HY5D2hqWZqtE10xpj5RkRyiqbXeSGQbbyXgcUM5mVxH9HFcas6f9cSQt/tIrllo402nQh/kRZYB/62Ka5C8OHTROvq2tB2WerUhwB67AglSAZnXtLeS82WnG7o21pEgLnBvFFUA0lJbxY/Yu5O4oa59hVyjqftUZfeaL9TOLq/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jqnwjrM5; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+siv9WFfR+C6IkN0E4Hgnt+SaTTWdCF4my8Ta5AqWEGD3dsuuaKvfTQ6etwe1/Li9O3YQ2r+zmSqLX/h9TLZp6Lf5EQhR/J0Ud6pnIHv1lTxM2X/OV/HC6C2wg5Jz89c4K1DEumEQHZ2TrBmgXrtW9gADbGuVJIiOz/ZjlKFih/DDjk7hNbolVF34Q5I+zmccOYp9JvIUKkDJPtABS21kvMLG6L/O4TAC/GWPhBMIewYjtfULKuspzdR67LC2rDOnzptziyGFgdpe7nsCX6BSUK/EdxPqQr9mH6uJyOGT9TL4/k079deQk2wHqSwI3k9KOk2ELC6UL/17pNEnrxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=midAmLzx3jTtif984LOhNyZh1TlHyKWlhPyvkY92V4Y=;
 b=yK9TlIYBq6TJ35PR9CBrKIRcOG5oGJgPeJpnDLUNDYJTJuMpxivPUYcl+C53kgZp/Ld3cLecklT2P9J9O192EU7dy1gexuArofrR/iQM1ugQ6ew4F6F4/7MLBpMEQQz83HMhc7m8quSWHUdV6pNg5b6So5HkQ6gjQu1jkNjA6S/23Ixt+GCKQn0vLaZ5VIcFtYvcVtTuj91rFCCzCq/xTVO41m7tHZjwZt8SG5fjkTlmXUsfehYS0G4SzEAMVI+6IlWJ2FHVeQR7qp2ZtEkgu5bl2UElswQgugoKmzpLD3/6lWJQJ9tqankHdb2rv8Opk1H5FoNlA9F74P/5haLY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=midAmLzx3jTtif984LOhNyZh1TlHyKWlhPyvkY92V4Y=;
 b=jqnwjrM5ikHs+u425HtGetcwjk0iMQCRLxvJKLAfkit7npCdEAinciyws7o84/76O8iwFJ8YWyR86Lyxm/Frjz3f9LZPEFSh4eEObRovbclq8dR7lvfV8RWdFDI9xbsy4rmb398LedZPfrDAtrEORdxfkkJEWWkOCbBjghyqzzg=
Received: from BYAPR02CA0026.namprd02.prod.outlook.com (2603:10b6:a02:ee::39)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.38; Wed, 23 Apr
 2025 10:30:26 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::9e) by BYAPR02CA0026.outlook.office365.com
 (2603:10b6:a02:ee::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 10:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:30:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:30:23 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:30:18 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH 01/14] net: ionic: Rename neqs_per_lif to reflect rdma capability
Date: Wed, 23 Apr 2025 15:59:00 +0530
Message-ID: <20250423102913.438027-2-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423102913.438027-1-abhijit.gangurde@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e5a87e-aaf5-4b24-e026-08dd8251dbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QM3etj0F0PQb/HJ16e1u5x8r+tJ6M8j/wP2cf6/u7E3kUdG0CqYjw4f/FWZd?=
 =?us-ascii?Q?bn4lW/f6i2SiJRd1kfnmR7BLMZAzQjOSE4CHdkx63Ji1LASDRth4QYGU56La?=
 =?us-ascii?Q?wI8kiqCEl8Y0QKyaIoLzzd6vGJla8ngpSQY3p3kpdf4DJ0wLCho/gq3NvZ1A?=
 =?us-ascii?Q?tfpYijHRpY8pWr5raMdPCB3RAovJjvE8eNQKGI117gg0kZWoOaC6Np4M31bP?=
 =?us-ascii?Q?epWR7uGRuy8Y4eQ6WttHEiFqai5ps9PDmECDfK/nql70OQP2YFgp0jccfb8D?=
 =?us-ascii?Q?vutfo6qwHcEtLyOw8mNcVcwDNCSWTcshcu7yknIFyhFqOSBDro6r8CxNYAEe?=
 =?us-ascii?Q?bNia7CFttViYGBHzPFaRm8jMiyaR5FgHdOlgm0kewsxVpnKS20UkgthCL1PZ?=
 =?us-ascii?Q?rIiKZcbi+3nel1WyUJ/aV4+47XaiFQEkdXkDOSlaZK3a/6hXvabiQyu/umh1?=
 =?us-ascii?Q?94+HQptIfNX8676wXyxEZubgjCG2WL50nie1O36VLAKcWUDgIAGl5cBv7lmq?=
 =?us-ascii?Q?rujV1MLqDFIlGvU5t4WCMA1QHSSntgy3UP2+ETPxqHSvKbYqGosgO5FaCQhL?=
 =?us-ascii?Q?aPLll9USfr7IYHs1crja9L2KnxekRhNYGgNT+rYCeVzOnk0kR7apRPIvKJ8g?=
 =?us-ascii?Q?5aPo9SJniA4DjZ3I7j48gv/s7cOCMkkh853NWHHATFfwuvJroaRPW8LxHAfy?=
 =?us-ascii?Q?M9pPmoCHA1Ht+QGwFatSTMoQTxjNgL4SUSFOWSz0jc7kDcgV3GCqZpLn9W/j?=
 =?us-ascii?Q?KeDHTdzx4yOiIVMATezLCKtc478CVv3hFkYkv62P8Jv1HD8v+jPne9tJYKha?=
 =?us-ascii?Q?EAu2SQiwtboUnUHVnJpo9hnRrYvzonuqTDVf1ji1oUgHpvqh03Kp8DWcCtbN?=
 =?us-ascii?Q?9NTs2irBMTZERI1YbZ6loTzxOeAp/Qz34ZwRB4dyVym8SElPimrZdwd7gd3a?=
 =?us-ascii?Q?fDpJ2joYv4hhuB668wNGgJz0+A1MSmMYIKr37R+bNLhtZneVOtVCMgQDeEdK?=
 =?us-ascii?Q?EC9PwZAikhHXEjgNPMjl21mchSRFzil8ng39izj9QogEWAWYHqJxdL/ZureX?=
 =?us-ascii?Q?2xEBvQEJItlIdY5iGGIWBSzLpmbQe1x+BU8Zc0Vl3OCLbwlqOaSFj2B5tEIB?=
 =?us-ascii?Q?WWP8QYKtLltPWZbpTWyH5l2VLh9PrMQ2u4D0v8IlSTMqZKVcHK+cs/2YZtT2?=
 =?us-ascii?Q?io28jLfeSyQT3DG9Bb7CtpjpnwHBLRHF8uZoFDJndOdShUlgAZ/1OGTy95e6?=
 =?us-ascii?Q?LB98qH/+aqYP6A9yMtIDaSDrTN1rSaKji/v0epOB1UeODBrssH7Yt5Xx3yFl?=
 =?us-ascii?Q?wuLC+z2hNmRtI3jMlIzdYh+0NFE1X66JZ4EEydxbVnwFylkHU47ZS450YtIg?=
 =?us-ascii?Q?MIIqjlqJpwNxC4xU69a5VUmQ00AnS8HDP/3LhRBIcxI3AImX0Khn+onUArDS?=
 =?us-ascii?Q?FMDjT75v1q0yUPoOHFGfISaf6AWhUNTbNVNie+gXnfVRuGKqMiKbVp7PgrHl?=
 =?us-ascii?Q?e2f+me9hL0C2iIWz7WXot1tc9e42eBp1T2LL/A/wJ+ZOZYhmD5nF6FStUA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:30:24.9342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e5a87e-aaf5-4b24-e026-08dd8251dbf0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

RDMA event queues are named as eqs in current ionic device and lif
structure. Rename these variables to reflect RDMA capability.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  2 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 20 +++++++++----------
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 04f00ea94230..013e1ce72d0d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -50,7 +50,7 @@ struct ionic {
 	struct workqueue_struct *wq;
 	struct ionic_lif *lif;
 	unsigned int nnqs_per_lif;
-	unsigned int neqs_per_lif;
+	unsigned int nrdma_eqs_per_lif;
 	unsigned int ntxqs_per_lif;
 	unsigned int nrxqs_per_lif;
 	unsigned int nintrs;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 7707a9e53c43..0a99a72376ae 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -3267,7 +3267,7 @@ int ionic_lif_alloc(struct ionic *ionic)
 	lif->netdev->max_mtu =
 		le32_to_cpu(lif->identity->eth.max_frame_size) - VLAN_ETH_HLEN;
 
-	lif->neqs = ionic->neqs_per_lif;
+	lif->nrdma_eqs = ionic->nrdma_eqs_per_lif;
 	lif->nxqs = ionic->ntxqs_per_lif;
 
 	lif->index = 0;
@@ -4022,19 +4022,20 @@ int ionic_lif_size(struct ionic *ionic)
 {
 	struct ionic_identity *ident = &ionic->ident;
 	unsigned int nintrs, dev_nintrs;
+	unsigned int nrdma_eqs_per_lif;
 	union ionic_lif_config *lc;
 	unsigned int ntxqs_per_lif;
 	unsigned int nrxqs_per_lif;
-	unsigned int neqs_per_lif;
 	unsigned int nnqs_per_lif;
-	unsigned int nxqs, neqs;
+	unsigned int nrdma_eqs;
 	unsigned int min_intrs;
+	unsigned int nxqs;
 	int err;
 
 	/* retrieve basic values from FW */
 	lc = &ident->lif.eth.config;
 	dev_nintrs = le32_to_cpu(ident->dev.nintrs);
-	neqs_per_lif = le32_to_cpu(ident->lif.rdma.eq_qtype.qid_count);
+	nrdma_eqs_per_lif = le32_to_cpu(ident->lif.rdma.eq_qtype.qid_count);
 	nnqs_per_lif = le32_to_cpu(lc->queue_count[IONIC_QTYPE_NOTIFYQ]);
 	ntxqs_per_lif = le32_to_cpu(lc->queue_count[IONIC_QTYPE_TXQ]);
 	nrxqs_per_lif = le32_to_cpu(lc->queue_count[IONIC_QTYPE_RXQ]);
@@ -4042,7 +4043,6 @@ int ionic_lif_size(struct ionic *ionic)
 	/* limit values to play nice with kdump */
 	if (is_kdump_kernel()) {
 		dev_nintrs = 2;
-		neqs_per_lif = 0;
 		nnqs_per_lif = 0;
 		ntxqs_per_lif = 1;
 		nrxqs_per_lif = 1;
@@ -4060,7 +4060,7 @@ int ionic_lif_size(struct ionic *ionic)
 
 	nxqs = min(ntxqs_per_lif, nrxqs_per_lif);
 	nxqs = min(nxqs, num_online_cpus());
-	neqs = min(neqs_per_lif, num_online_cpus());
+	nrdma_eqs = min(nrdma_eqs_per_lif, num_online_cpus());
 
 try_again:
 	/* interrupt usage:
@@ -4068,7 +4068,7 @@ int ionic_lif_size(struct ionic *ionic)
 	 *    1 for each CPU for master lif TxRx queue pairs
 	 *    whatever's left is for RDMA queues
 	 */
-	nintrs = 1 + nxqs + neqs;
+	nintrs = 1 + nxqs + nrdma_eqs;
 	min_intrs = 2;  /* adminq + 1 TxRx queue pair */
 
 	if (nintrs > dev_nintrs)
@@ -4088,7 +4088,7 @@ int ionic_lif_size(struct ionic *ionic)
 	}
 
 	ionic->nnqs_per_lif = nnqs_per_lif;
-	ionic->neqs_per_lif = neqs;
+	ionic->nrdma_eqs_per_lif = nrdma_eqs;
 	ionic->ntxqs_per_lif = nxqs;
 	ionic->nrxqs_per_lif = nxqs;
 	ionic->nintrs = nintrs;
@@ -4102,8 +4102,8 @@ int ionic_lif_size(struct ionic *ionic)
 		nnqs_per_lif >>= 1;
 		goto try_again;
 	}
-	if (neqs > 1) {
-		neqs >>= 1;
+	if (nrdma_eqs > 1) {
+		nrdma_eqs >>= 1;
 		goto try_again;
 	}
 	if (nxqs > 1) {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.h b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
index e01756fb7fdd..05e9a931ef0d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.h
@@ -202,7 +202,7 @@ struct ionic_lif {
 	u64 last_eid;
 	unsigned int kern_pid;
 	u64 __iomem *kern_dbpage;
-	unsigned int neqs;
+	unsigned int nrdma_eqs;
 	unsigned int nxqs;
 	unsigned int ntxq_descs;
 	unsigned int nrxq_descs;
-- 
2.34.1


