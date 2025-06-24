Return-Path: <linux-rdma+bounces-11572-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D21AE645C
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786444A66FF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD0298242;
	Tue, 24 Jun 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gwWlg6Wk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7CF291C0D;
	Tue, 24 Jun 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767231; cv=fail; b=CatJKPMBctWbt3EAWDAhnklpSssrBQdcd/SKE+YSXYE53y+WE66fH1s5JVg4JR/H2Ws/YAj6QkBF9HKuVCzeMeTWib7cjrHbgh63nvuwpu2TyNZeeVfzjDEAngO6Tnb7YschKJZ7D6+pY6lnX1VSBatuMdwz8hhC1n/kReyrJUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767231; c=relaxed/simple;
	bh=ovIz5ZJWELMPuRotgiHEq2cTsMFaEZPfb1dNsC7ONN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WS4rc6ZF6v/3IeAbPmyb2moxlplcxVA+ysgrvwMWpomKgaQ2ISrgCQSp9dYeCjPMIfsTayKcgjkXWThC1cwzHoL+nGxwGIME5FTws2x0u4dKbsYHFNX4JHl0lejxvHYv3kNle0sgz1ov8RlLR+es3ezQFi5MHWWgD8iME7Da3cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gwWlg6Wk; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaDrzj09hz56NL9ASOuRCuuZopL85ycxdeb9lleimHeo7IwGHoXzFFfu5utuSs6cKjmaJm8WzrfxhtbzzAdyRMm9g96hGs/O+1r/uCrWjzvXRAtu705L3F0TLpGYKVUmehWGiqYV7Ui/GSVUJ/5nltxJEqcIx1vs5VfplGDGxJKuqdOdE4Q1nHB4SP2/0K2YcoJXcWOeZaTM/RL1vwrLry8ULzsp7bgQ/LQSV/Ak3yegvEJLJnCkdfMDt9N45qlLf/22K0yRVOZgqla806OcgbgEkzAH5d01pbf34WjSHZXLBwHYyqxMrPEC2oUf8n0dum9YHgCN6IePtqV3o7TrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7HZyEFckxjOPPXEcvEo1wm2yiVAqhy7ar9AmpBjAbc=;
 b=kYN54jWFT9v1zpZ2v3ife8ihsu1gUhRKA86UkQpwDBqGi7VR65awiPypu9qWRmFTa5KsbIGcNlYRzYkx6p8/SjFBZX8fXlTcfBikLYxoaSZg9DW45bBBjxWS7U+Rm2a4ffv23lqRjMA7fH7MP5uZRgadaTAbLZBrXSfyOIhofv/RYuPi5Fr1DuY6b4nrnWmi8aCLG4d+lHRGIMwZFC+XAkYXGMIG8zrM8dBxwKdVBd7h/r+FjCvFwp6F6//o6od4lqlJYrCF0+20aiKV+yKM2/bFsiV/h2Nq+2K+M9aMZsbSjybTKqyYkS3zmeO9uLD+G4DKqoiYMl7mMLcFlx8oNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7HZyEFckxjOPPXEcvEo1wm2yiVAqhy7ar9AmpBjAbc=;
 b=gwWlg6WkV8pLy/xSwAEC2tFPm1YDJISwomYFz+B+Imn6+T2UAaLXXsjf9AD+yCb7VKziF3nh4/jWcjK+Bhqtj9C5oh4GoTJjmjGiR/3mb7GQoQdH7Www2jz88ITWi+tMMBft2LXYICwiDOsCwdu1S3taWi0Ki/Pxc5bzqGkgvSI=
Received: from CH0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:610:11a::35)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 12:13:46 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::9c) by CH0PR03CA0344.outlook.office365.com
 (2603:10b6:610:11a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 12:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:13:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:44 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:13:40 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v3 04/14] net: ionic: Provide RDMA reset support for the RDMA driver
Date: Tue, 24 Jun 2025 17:43:05 +0530
Message-ID: <20250624121315.739049-5-abhijit.gangurde@amd.com>
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
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 214100d8-9917-4b3a-2248-08ddb3189182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bQp+Dwm4JZCZIE8ON58geJpOZ0QuICkOiXsswBmh9JANenCmGKwIqhHPwHS+?=
 =?us-ascii?Q?qBOzPXI2RPC8GBECwXEyE5NOARF+0AJ/rO49Y8kM6RrkuKl9OhxJVxAXH6Sh?=
 =?us-ascii?Q?9wjGSJVFSjzYI40ozj1gFoZ7up41djceUsZCLU0uzcZzhJ24FzD3Rs0+WKkR?=
 =?us-ascii?Q?pWflvsHyC2/Ma9Txav+2L1vFAL6tpnO+uwAj8vHv2Ko+xxzuOg+qAKp2QOl9?=
 =?us-ascii?Q?BUI5U1v/Ih+nJAnkFwhZq4CySQfx8JuNrbfIaxTAIfY6pZnTzaPqqz6uqGRH?=
 =?us-ascii?Q?u6PBptkHDJ3dHEJR6BYSws9wLEDXlKf+7OKquc4XIIZ/nBZ9JpHzvJ2dPjmA?=
 =?us-ascii?Q?f0/i4pW/U4D+YQmMR3gulRuQoePMn9TTohZ5tjm0BxGOwfRn5qrQjaUxmLH0?=
 =?us-ascii?Q?EXguFRoDwRwDY35cQBrKg58tZDnhlgIvU+vTwFl3Y6y09Imu6cnqi69Mg2uA?=
 =?us-ascii?Q?NFDkIgr1Iwhh93ZOp6g8q9X5HnZw3ZC2J0kUuw0B0kKsoJGxLPjVuBgGBVWj?=
 =?us-ascii?Q?1zVAW9B2AGHA3pTevHLsvBI7scGA8G20r6/YrZv4/m5TwNW16NbE3aLoZHlL?=
 =?us-ascii?Q?dVoipCbUfL/CTktfpgiNIpXy3eLT75fY//BuLut4YpDi4ylk3NL0dGsGuvms?=
 =?us-ascii?Q?RQ3dqBDAwI2ekAHAIkYUwTHs+5pkIf0pZznWb1itGOWnv88mFaSt8Us7D7FA?=
 =?us-ascii?Q?kB1USqWPhC0lPHeIRNNCekAJCmhUbwThVNESgW2Hbs2vg/dA3XIQnvmoq2GM?=
 =?us-ascii?Q?Nl+ay9rJ8OW8Pc1X9yFJmzfO0kW9xGVv6RXTx//jxRgLt/vGdR37DZqQySjx?=
 =?us-ascii?Q?oWYPMIBP1fJSOQoqbEMO1iHyLHe+E1MDNXjMTITrNNAOPhgV8T0UkYTNQZtk?=
 =?us-ascii?Q?PYoUDcsKdrIqubgXrgZ/n9YF5QX6i6Ysj0gAvXZ2i4UHBnI74kxjSu7e86nY?=
 =?us-ascii?Q?pyBYPpMc3dcu++B1hCPxyd8nPL95oMN2N3lStV8vcaye02lPmO2jnsFJPHRD?=
 =?us-ascii?Q?bx/AAvREu0k+45VM8nzccuN0Oak5XEzoeQdEb12VrakPOgGO3nhbkBHOJP59?=
 =?us-ascii?Q?fZat/nI+CB10GN6AF9DkUTyE3dANI5u5PQX89qXC8/J54/O6xU3drBco8fs7?=
 =?us-ascii?Q?xCC8px2U9BB0FyavFCH68RS4QcaRavotoSKeCw8LjSNpGwEbDnOX7buMHBbO?=
 =?us-ascii?Q?YYloeyFdIXQzKOSzxBYxiGdepsR0zSWLrjrzjv9AN4C5slSmiKS8RZP7FACm?=
 =?us-ascii?Q?GlRH4AwU1NzGH9LvNsTAaTq1R0XJrfBU+1yG5Pj6JjFdjbranx2RdsvzfCVE?=
 =?us-ascii?Q?ctstQXiAK8pFkJQP2q4H0k5C6Xey3X/FDv8CrTyXEgsKNMvPJqATMr4aL9Ur?=
 =?us-ascii?Q?nAiaDQPNF7jKmTaKtyrmgxc/ssKF76rf2tmEW3m95N2K1NMwqwdUlB2J94DS?=
 =?us-ascii?Q?0NtdRg2t6m23TLHvPdLkh4XR+m/Q6/sQLxH3PWj9RFDA9GuHUdWKzI/Nzdmp?=
 =?us-ascii?Q?6Vd84AYESl9aJcqGQqrqBITrfawOvKDC8hDdavQXbQXmeMRGxv7g1sPGCA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:13:45.7762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 214100d8-9917-4b3a-2248-08ddb3189182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689

The Ethernet driver holds the privilege to execute the device commands.
Export the function to execute RDMA reset command for use by RDMA driver.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_api.h   |  9 ++++++++
 .../net/ethernet/pensando/ionic/ionic_aux.c   | 22 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index d75902ca34af..e0b766d1769f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -54,4 +54,13 @@ int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
  */
 int ionic_error_to_errno(enum ionic_status_code code);
 
+/**
+ * ionic_request_rdma_reset - request reset or disable the device or lif
+ * @lif:        Logical interface
+ *
+ * The reset is triggered asynchronously. It will wait until reset request
+ * completes or times out.
+ */
+void ionic_request_rdma_reset(struct ionic_lif *lif);
+
 #endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
index 781218c3feba..6cd4c718836c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_aux.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -93,3 +93,25 @@ void ionic_auxbus_unregister(struct ionic_lif *lif)
 out:
 	mutex_unlock(&lif->adev_lock);
 }
+
+void ionic_request_rdma_reset(struct ionic_lif *lif)
+{
+	struct ionic *ionic = lif->ionic;
+	int err;
+
+	union ionic_dev_cmd cmd = {
+		.cmd.opcode = IONIC_CMD_RDMA_RESET_LIF,
+		.cmd.lif_index = cpu_to_le16(lif->index),
+	};
+
+	mutex_lock(&ionic->dev_cmd_lock);
+
+	ionic_dev_cmd_go(&ionic->idev, &cmd);
+	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
+
+	mutex_unlock(&ionic->dev_cmd_lock);
+
+	if (err)
+		pr_warn("%s request_reset: error %d\n", __func__, err);
+}
+EXPORT_SYMBOL_NS(ionic_request_rdma_reset, "NET_IONIC");
-- 
2.43.0


