Return-Path: <linux-rdma+bounces-11571-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1BDAE645D
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 14:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467A94045F3
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jun 2025 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8C296155;
	Tue, 24 Jun 2025 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="go59ibZ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E7292910;
	Tue, 24 Jun 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767231; cv=fail; b=oQS+JtapOUMRSbnOBeYVTzsLD0IibhH/r3+SwkLNMa2CTXsDbKNo3TyxGkFeGsek51aUjhjqwbDS/hYWQxBezetKk5o4RRlXDaIP92MOeKW9+NUZQkcrtCV0qFZ5gwIHf6w4NN6H8M1TmImTxajjvKQxOL5JuemnTCYP5OJP4j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767231; c=relaxed/simple;
	bh=h/uVcETKC+3cGUzYGi4JWJzRSwkZpokJFdBJLWvU1P0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pt6yFeNSby7tXTSz1NPtqpPk4ASVcmACGQav85CftYVTnT2xPHLPrdGH+7k+8svluwsJNeAHhHrPQSCKvyWKZYLKmlktcyv5Gsj5MhNEh94/a7L05zIgni42XcWBVdWPhct+cbFZXj9VeU8h+KG+1cfUfXhR/P0wuaalwiMxg6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=go59ibZ7; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN4PodQ+6BpI1zt1sg0rSRBOTaSPv0RWQ/N0UK7UdKd07i4qAtnK5/Ujo6JLb3V+Guwe71nJyeRWr8QiwGvNyz/SIMNp9mACm+5O0Whfhg7iMXHtwt6vgTX4G6geG4hRLwad/X+OVE/PFEVWyxC+IucKchl6tr+Mp1t0Tc3WkatDJ/pXQwenoPE+tPiFyWZLCBsHDOziuq2m1nlYjsR3V0aiTPBDrVg8hztHm/D/c06/k0NjcsC9Q6JXfSdepyYv114/ZX+76IvCIm2rrimJUOfMPhD+KRn+vtncfSbpCO8gtlcZExBNJMnt4y//xyHEvXcMn/x+Fh0u6phXXshdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEM1AFwIxmqwEmxJg+E8KJNyIe2JtRP6v/yV8Zdz8VU=;
 b=y6KxEvL+k8p044A97xF+cQgigDpSDIbJ1OeHBzjeqZpQ3I+7ZaZ2hMZA9vn6Qyp1t5Gcdoep36/XQNQ4cdfCIQpeKteRlSfyTk/qLVMXPPu5FnBycPYY5mQITfFyTb4ATHlDwgauKos6tpzA+IQ8r1zIhpYTtW380PuTVCl5Yr3lWegsLZQQDoAe1sRHDutr3/YxGhXtKwutun3J2vlby9qKc7N673HwB+CG/3ZDtG7xLjdFeS00B1wUdMkNRs8sUX7NOoQz6vCcGwVQuO48pJueOdLYTQGR3mOE+vdGrO4dxcz8HSyZ93kopXmEixQwkePf85Qkp614dYrvfLJeWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEM1AFwIxmqwEmxJg+E8KJNyIe2JtRP6v/yV8Zdz8VU=;
 b=go59ibZ7Z+MVAgOwW0CUDnhj56pTDNgrQDVmybqp0J0uWNpIpsOA7kHkKhXj0nM6DJUzMFc/NS4m56ivtN18GWWJgEj68RtYXIA2E8CF0MTP84u9IE47koN3+eB7yNO9bvpfmuYgUqhvkVcxxvMTCcsve4mn8q2VxLwnqEsG29k=
Received: from CH0PR03CA0368.namprd03.prod.outlook.com (2603:10b6:610:119::17)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 24 Jun
 2025 12:13:42 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::ab) by CH0PR03CA0368.outlook.office365.com
 (2603:10b6:610:119::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 12:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 12:13:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 07:13:40 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 24 Jun 2025 07:13:36 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v3 03/14] net: ionic: Export the APIs from net driver to support device commands
Date: Tue, 24 Jun 2025 17:43:04 +0530
Message-ID: <20250624121315.739049-4-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 666c28fd-7597-4936-e3d9-08ddb3188ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6WwQXTrnX1ny9hLSCoyeZXiguT8HjEoKsQi6yv1ae6y9RbW2P4XRmzNwtX2V?=
 =?us-ascii?Q?nhU0Acoy6YDp5262cDEb+CRB9+6+kj9E8LsvfbDdzjUjb3+2Pjtur4lhSt7O?=
 =?us-ascii?Q?KuJ1i0cd1jDSVmGjXrHmUNGiKh4S1kubWogbcGhGYrrK6Xp/tbxZB2X3jvN/?=
 =?us-ascii?Q?UV+d12ohbBooe/nFMXwkLg3RuU8I5gjDd2kfVW0ahGmN3CDDLMa4LiQY6kox?=
 =?us-ascii?Q?C5rdOmlpk5lpDycBu/HiTOHIBMtucCO+D5rAFJWpgJk//LpBThoFfTtfIiM8?=
 =?us-ascii?Q?CgljpLH9FJe7FWOpm88cfHYx0OtU4IZ3wEbaVsZCep5KxzCYvwaK68Fc4OaC?=
 =?us-ascii?Q?jdlO8B4y400XqEtUIk8SPf56idi/BW/BuBDpa426NcGQNQNp+N++oxKH/znX?=
 =?us-ascii?Q?vwgj9wdP8fyQZLPFQ2lMq5LUi4vlMLPWTxyRzmjVwypUcry8fBakdgAUb62C?=
 =?us-ascii?Q?oYmjLqrINN19xme6EaClgX0apoM7fpVVT7G4LY9S4ouvOQrj7j0ZmHZk7S6t?=
 =?us-ascii?Q?z6rR4zJlcjfUKbDQIdcuSXx78S1GiWDyySX9Ppz+PAmiMSh3LJB0vFBarLhZ?=
 =?us-ascii?Q?LjtfTfnzLxzQ7OJQ1/hoGNY8eAuFL1E/LdvJxeCqsN/nXe4ZY7bbPUJ6U9hh?=
 =?us-ascii?Q?k4//gQdQjWARaAjLQHeU/6wZ1nPOd1oKJZZwsOetCfcOM1BMbKE7MQx3HtxQ?=
 =?us-ascii?Q?B5HhiJH2ZoN/emlZquk/FCbii5wwVef9ZEDxoXPwyurHg422O4llWArGCKb4?=
 =?us-ascii?Q?n2Hp4i1PYXdKF9orMv5KrTvDqSdUkwn4O7lqucJQaoCmYcP2qHOrikctTecG?=
 =?us-ascii?Q?rRJoyh6+mUA6qlQLD4zpFj5DYoRdi7Mp1XHyhZLuGMMJ2izOamLqaB6NIaUH?=
 =?us-ascii?Q?0Ca/E3HgVEZgGbpcmht/cMxunREtXYqlEQn67fJALwH3x6wnVnKaRiB5ZZDe?=
 =?us-ascii?Q?SFLkeK/XJ8hh6QiVOF5GtOv+x6OGOpew8jfIKnO8N9OdzyoggLXtg1QqfdnL?=
 =?us-ascii?Q?wPBi9A6wSwcehRPgF1fPFu6kb3QU5cSWRTFDusEYVZFA7u8j+qm3A9lOCJj7?=
 =?us-ascii?Q?RwtRUwEZ5pRjlb5eu9I8A74SZt9IZiE7T3Ck2ZNYBG4RnQCIcdkfLO59/xus?=
 =?us-ascii?Q?t8p7C+5ZSivpvpRLD6qNdNwJDDLwyOx372A3hq2vWcoJ30VZayAYaS7LR46j?=
 =?us-ascii?Q?zL69DpSeCrztdLxjHfjIi+sEhpgmMy3TW1d8otG4CqNx6SwTDRjgQnmxOFio?=
 =?us-ascii?Q?gFZLPqigga1fDXi+8wwG9tj2anp9QwHCiLWkdTpyVa/nhtIrxC/iBaHhuhyu?=
 =?us-ascii?Q?T+ilBWFX6Xs7fdG40H7R99P7/XeBXz+8JAs7uz7UYrNQ8LewvHgfVo6q5/Z3?=
 =?us-ascii?Q?GqmmfjcjKdJCfkXp4qcOwBE3VlPaHTJaC35kHgqZ6vI631ywFaoUmwQp+WqK?=
 =?us-ascii?Q?KtoKJmVTidPo3agpznHNi5MSYKBo6Jbdvv63bDMiA2Rdj1yfniRn6Lep6fRn?=
 =?us-ascii?Q?Qfj8WhOQtb3CY81sjN3fW8ZWqkv+92FbTTzO3AfaB5bnhf+2yhWdYCqmjQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 12:13:41.2599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 666c28fd-7597-4936-e3d9-08ddb3188ed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645

RDMA driver needs to establish admin queues to support admin operations.
Export the APIs to send device commands for the RDMA driver.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  7 ----
 .../net/ethernet/pensando/ionic/ionic_api.h   | 36 +++++++++++++++++++
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  1 +
 .../net/ethernet/pensando/ionic/ionic_main.c  |  4 ++-
 4 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 04f00ea94230..85198e6a806e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -65,16 +65,9 @@ struct ionic {
 	int watchdog_period;
 };
 
-struct ionic_admin_ctx {
-	struct completion work;
-	union ionic_adminq_cmd cmd;
-	union ionic_adminq_comp comp;
-};
-
 int ionic_adminq_post(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
 int ionic_adminq_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx,
 		      const int err, const bool do_msg);
-int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
 int ionic_adminq_post_wait_nomsg(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
 void ionic_adminq_netdev_err_print(struct ionic_lif *lif, u8 opcode,
 				   u8 status, int err);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index f9fcd1b67b35..d75902ca34af 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -5,6 +5,8 @@
 #define _IONIC_API_H_
 
 #include <linux/auxiliary_bus.h>
+#include "ionic_if.h"
+#include "ionic_regs.h"
 
 /**
  * struct ionic_aux_dev - Auxiliary device information
@@ -18,4 +20,38 @@ struct ionic_aux_dev {
 	struct auxiliary_device adev;
 };
 
+/**
+ * struct ionic_admin_ctx - Admin command context
+ * @work:       Work completion wait queue element
+ * @cmd:        Admin command (64B) to be copied to the queue
+ * @comp:       Admin completion (16B) copied from the queue
+ */
+struct ionic_admin_ctx {
+	struct completion work;
+	union ionic_adminq_cmd cmd;
+	union ionic_adminq_comp comp;
+};
+
+/**
+ * ionic_adminq_post_wait - Post an admin command and wait for response
+ * @lif:        Logical interface
+ * @ctx:        API admin command context
+ *
+ * Post the command to an admin queue in the ethernet driver.  If this command
+ * succeeds, then the command has been posted, but that does not indicate a
+ * completion.  If this command returns success, then the completion callback
+ * will eventually be called.
+ *
+ * Return: zero or negative error status
+ */
+int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
+
+/**
+ * ionic_error_to_errno - Transform ionic_if errors to os errno
+ * @code:       Ionic error number
+ *
+ * Return:      Negative OS error number or zero
+ */
+int ionic_error_to_errno(enum ionic_status_code code);
+
 #endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index c8c710cfe70c..bc26eb8f5779 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -12,6 +12,7 @@
 
 #include "ionic_if.h"
 #include "ionic_regs.h"
+#include "ionic_api.h"
 
 #define IONIC_MAX_TX_DESC		8192
 #define IONIC_MAX_RX_DESC		16384
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index daf1e82cb76b..60fc232338b9 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -72,7 +72,7 @@ static const char *ionic_error_to_str(enum ionic_status_code code)
 	}
 }
 
-static int ionic_error_to_errno(enum ionic_status_code code)
+int ionic_error_to_errno(enum ionic_status_code code)
 {
 	switch (code) {
 	case IONIC_RC_SUCCESS:
@@ -114,6 +114,7 @@ static int ionic_error_to_errno(enum ionic_status_code code)
 		return -EIO;
 	}
 }
+EXPORT_SYMBOL_NS(ionic_error_to_errno, "NET_IONIC");
 
 static const char *ionic_opcode_to_str(enum ionic_cmd_opcode opcode)
 {
@@ -480,6 +481,7 @@ int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 {
 	return __ionic_adminq_post_wait(lif, ctx, true);
 }
+EXPORT_SYMBOL_NS(ionic_adminq_post_wait, "NET_IONIC");
 
 int ionic_adminq_post_wait_nomsg(struct ionic_lif *lif, struct ionic_admin_ctx *ctx)
 {
-- 
2.43.0


