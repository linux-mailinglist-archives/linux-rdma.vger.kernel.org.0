Return-Path: <linux-rdma+bounces-13051-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5ACB414E6
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB407560C5C
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3152D97AC;
	Wed,  3 Sep 2025 06:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pERWIOvS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904DD2D7DC7;
	Wed,  3 Sep 2025 06:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880263; cv=fail; b=JdN3zpO/1STWdTUpRDvtuWifIqa9SDcNkaZQpJh56caDJ5cFDq8M9NMDwDjmeV1pYB0uC+zdvO3d1vCNCeRWYaPiYaUio5vJcE5UfyXj94eZ1Qa3M0j8p+3a0jpKvSh52Y/o3pXtUMqZNLHWChtD/CxmZ1ins3LFfhx3hV0Q6l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880263; c=relaxed/simple;
	bh=+VzOr43iTWgDtxaSZ3J6fp7o8fJIVlHBtyaiHDdKPAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCboQQrZeWahY0EA/i+5m0rHwJ/wuMXBPmDDo9iIfPQUOVESoI1T44igthN8u4BKpSKHA4xLmR2DbpQonHV4Cz2jOmwTe7lc0JxvvjVPUKBt+H2gC0NPmb+yXZuKUcH7e6dNqf4faLbd2wSLnA43hrl2wcW+ZL3/CHJp5jx7kdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pERWIOvS; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olIli5UBkP3ICDp81XoZrgoGaGnr3JQF7rKSRoRZfAcTguMJ3ef9bxU2YuOrTMXZor6JMR6XTRnhWusUO8nN8zB+Z0x6UrbMXOZPvoIUH0v3qnNFbFgshVAZ4+TKh+AZKOSby40WdK/Nh3LUQAMq2/0v/OjBaZYWr/F4pQQBEXHENjlkJYsh5qedgHlJa9irwBDOE4D1Dn+/Fcx5BGDo14OFr+oXiNVYhN1leOAZ5ulGMtJJ7eMbs8bRPOUER2wGzRhxudhI5V4m5kUMfIAuAOryWQrYGEbGFAl9+K4RMi4yHS/u7oesk7jIijABRcOgAlmAM3bOPmhkMlX3jaRMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFLk0eoNiAIeG45aUblgkvyIUpJd3GlBO06frfi2H4w=;
 b=k2GlCfmhYlVYCDGRjGA4yeVLMf8cofHAxjECB41Pd7sCl464cSCRvVMXRvyncfz/lBS9EVDKlmVNTlWYatFFq2X+bEqf9gtWxbPnyVkuNZueAZJ+Ef0JbwLhJq2BakFqXrgHgBh1AdWfymvxEBKJhQrKKXa1jSut/w5ozj54J42noB11wZBxiQoyaDrp8lESBB62M8f1eZvRoFeKGOefbEzQ/RGgCq+OSWQpzG/Ijcac/SidGaY/nOp1F2rgteM5Bk0HITwqn1uM689cmSSZ56/H1jy9RL1q1jnSjN9OyjtE3BNKVFmFN26MmjbbTTTy43Qt4U367WYTa2h93DCxqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFLk0eoNiAIeG45aUblgkvyIUpJd3GlBO06frfi2H4w=;
 b=pERWIOvSQakjQ6WP4hB71prUUq/oF8e7pQmPPbGxwbRdhTfh9tGrLziUq0MmG5gmrdHnv9sjX7qLiZYLkA3OtRoI+4mwMQ6a8eZbFWWJGIG4UUYj0EblH/15wD+Gn46vB+Jad3wjIHj9PoTpR8kq1xHyNqty5ZHYZaR5pz3FSFI=
Received: from CH0P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::6)
 by SJ5PPFD5E8DE351.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 06:17:36 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::38) by CH0P223CA0030.outlook.office365.com
 (2603:10b6:610:116::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 06:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:17:36 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:35 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 23:17:35 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:17:31 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v6 04/14] net: ionic: Provide RDMA reset support for the RDMA driver
Date: Wed, 3 Sep 2025 11:45:56 +0530
Message-ID: <20250903061606.4139957-5-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SJ5PPFD5E8DE351:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e75b65-25f2-44a5-54c9-08ddeab193aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IK045qZZCyemNlBvFaghGLRe65/RYIoVcM+GJ9W7arm4F/mu1MLT0d+Y5NZC?=
 =?us-ascii?Q?Q7xAxjQdvr2MkyqkJH+WZLBqk4dOxHlcYvdY/oP+lDeJ0JFgVOxv8zX9+nqn?=
 =?us-ascii?Q?nPssa1PmsGAvxXDIOpnwYxbFGGjIAh5zl/JUDbwCxqB5SIeHiVvJ1JlG8QS6?=
 =?us-ascii?Q?8D3Ce4DGFyIJVAaVTS8wVtAfNg4VMzTFIEPDtTJ4wzwNSIa5VOlniUeyVXaO?=
 =?us-ascii?Q?v9KbkWPCSa04IUyHcxB5U0Zim/tFlIQeNnr9GQeoWrRdBJnYdWYr/Ihs6e7u?=
 =?us-ascii?Q?bpGiMTtP4Mgr+VdRnJ3XzOIF5pFg6grim58umoQBfBKLygOlk4tHwgEQTelF?=
 =?us-ascii?Q?HMnA8I2POsdLUpvIfyrJpA7gUFTtTXhNWd8SrSkJm9/WyFKa1DdHaXLgLmsW?=
 =?us-ascii?Q?WktmfZwiMmK5i3bbWqYjXFbz698tO4cjCXKmW0vJ/yQYO+pgcxou8xyVCpJS?=
 =?us-ascii?Q?dtVbwlOPBAnyaxNJ8p8rxJQC8ooIlxtjhd21e8YtyZt4STQE1JxrpApCNPLt?=
 =?us-ascii?Q?WpAE3z2cTHfqCE2KUMUF8vEQJB2+pBI3bWF+3YviwVgVy/Cqf+oO2MwkXM/E?=
 =?us-ascii?Q?Zh/ZFAGTqBiSQDQnp1G7CjyN6J+XRxfau1vA29YrPfLPQ5WKBproSOUZkbgh?=
 =?us-ascii?Q?k+VAhHpanbfbuVIIe7joMYDctohX1wmaK82n3EsC7ZvCRlXJpd4uEEuQaeYN?=
 =?us-ascii?Q?PXEjawWTnveIWKpQQs052TPObkVb0YqtU4IrKWJzFuN4IdD2ovCfHLG6g/PF?=
 =?us-ascii?Q?w1Th5lPlzl0bS7/2z2gx6+YAOaeLSMT2OTTjS8j2t/UTunsFMEa6bEpCzmed?=
 =?us-ascii?Q?GGxsNAuacISBCMObUSYY5fFeRR70+T2KMQkxJatWcptkDBRvuodCnwt00XId?=
 =?us-ascii?Q?s67FYU3CfxQAq2dLjYsdGYZ/nftNBpQKzyRmDbzaWbXAGTFIs3YX8F4qKN1A?=
 =?us-ascii?Q?6uyBygoAS8FoHYx3qts/srUxnEOmh2JDM7iAMSRFYMOIMTQuF5441unSTsPb?=
 =?us-ascii?Q?F0xWFPFYZngFvA7s7OxtK9OMy7RjXDZm0pdOF/s5KYkPuD2i1U2PR2APjI9g?=
 =?us-ascii?Q?DTSSRVmSeuC82RkBNFs7iA+6h+99zvxRJdhew9exRkV9MdDgqWMNK+qXUuBe?=
 =?us-ascii?Q?/TMlHVUrLmq3e1a6Y5LwqsAuZdcHr3gd3GbYYZ+q2Z6owMD7B+78IMs4FJWL?=
 =?us-ascii?Q?y1XhnaKcJKeKmX8PsTRyfh7ypZUSpNEEG+ul2pxOT+XLiN1FtCgtWme7V7Pn?=
 =?us-ascii?Q?+TqHIRKe+frJyP6Bpr1NNcmgTfm59yHrSr6Pdcgj8Rj64KoT4JuTnqbzt/xR?=
 =?us-ascii?Q?FPj91OR+jsjUB3qy1ub1TjJ2CC0Zazg2kRgsmxnZLjVGfo3DTTowXucXcVEy?=
 =?us-ascii?Q?xtbpW4F6DCZgRMM2HeZhgvdITT48m7eyApqYx9ch8mw3EnsNswE48qf5sVCG?=
 =?us-ascii?Q?mvpPlm0lPTvef94E0FbNQ7yI1iwDMo8eaA422yYBSVFUN4Bnvwak5KamW5Gj?=
 =?us-ascii?Q?6/c+PBWb1niqZNHKTLUNRjC6xZ1fEkFUTlnA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:17:36.3189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e75b65-25f2-44a5-54c9-08ddeab193aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD5E8DE351

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
index f3c2a5227b36..a2be338eb3e5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_aux.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -78,3 +78,25 @@ void ionic_auxbus_unregister(struct ionic_lif *lif)
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


