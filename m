Return-Path: <linux-rdma+bounces-12432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A712CB0F91D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70EAAC23B6
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841142264D7;
	Wed, 23 Jul 2025 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zacWs5Iv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D220E717;
	Wed, 23 Jul 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291946; cv=fail; b=jgp3LuoMdQSuf/hL6K7kwx5JSN0vTVLVHJgJParphV5PrecgghG8efIesewRvqu8AZosIwEpNDzRHWiESKEedctlEh6TCX2MPnPJ5uLbXPXeGHRn/wY8d1h7yNlr7tb6tDTY+mg+svatQhwjjZDO3uKMUfiOm5tUL8nJZzx9NMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291946; c=relaxed/simple;
	bh=h/uVcETKC+3cGUzYGi4JWJzRSwkZpokJFdBJLWvU1P0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6fUfaEXIYyWLvHZGqMPVU0KPkV0GK+LodLeuc/E2i/fXvL4O2XcRRdO7wU9jqbIi6D28qAP+SuPAeCjmrICRhuTCMjnKdLYlqur9NK5jgmZ2pIP1rXWd3JBFRLthUVHkhxVcuLcL88oIUwZB8SbXbE5Obh5iSNigvqmAWyfa3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zacWs5Iv; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfklQ1iM1AHJ2zh63yz4TxAS8ZkjOCnA+0ZWSwvs+wGY1yC79RPoy/C2mQx+tDJT4hih49hhICiO5LEzDsqlupr+0LZvRh5+zW4BSjry8fCQLQm/BQxGBdUjxnyHOxfPQp9O2vgRnQBsQZEO9RgqBi4gbvTO6r2ET5q7BPKc9ufYt7lR8qR5M6eVIyq4M+58phfsOsxtFxSkXtXBl81rC2e+J14OtdYcGPNI+TXaBahAsVuIm6hMEd1GhZ0oOTjkWtjoJh1Ss4XME4QLeC4oXvv6OTJcuYrXYwvG/aAfJR37FLKdklm5UPvOxaokPwnUoj8YXprDzy+6Le0PO3YDsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEM1AFwIxmqwEmxJg+E8KJNyIe2JtRP6v/yV8Zdz8VU=;
 b=yQ5wulAxZU5G1fEWjw06TvUuY/grIa+LhvyxkxnYLVaGvzp7WW/QS3j7T1Z+f2b3FJZ2jugazL36zqOzH0nfjsN/1usgnZ+pTT2UA+VDGhvr4J+ZkB3Acc9xdk1pJg2fIG2j9jBcev/52m3jKzs7jK/Z0awlu27eZHTOS8p7iRnoUYicxTej+PLdm0ce9x1BRo8n9GqGmAiUD0+cZH1cgEncO1apSj3kIm1SciQUYRcXNxrxefh9N/iGdCp4SzasA5DNWA8S4PwGIdtzcEw/GTAT/ex+5iM+C3MgwsswnHXOOjmVgplKKp2130X7wjAuGETPpcs/m0AX2GgPbpIoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEM1AFwIxmqwEmxJg+E8KJNyIe2JtRP6v/yV8Zdz8VU=;
 b=zacWs5Ivc14GvfuifdXrDEARD/KZQeA+A+LnOzbzxSf89NkCGN0hqGwgxHcHudDUwzWvb6kVa3SRY7XO04zurP3JdYA11A9RaBZD+3x3Lv6SVNu5iCDHCYIDwR8iGvtZrIlvzwuRuUrkUsEeqliRJ+OsZurpkfK9kMX0tn9ERa8=
Received: from PH8P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::28)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 17:32:21 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::98) by PH8P222CA0027.outlook.office365.com
 (2603:10b6:510:2d7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Wed,
 23 Jul 2025 17:32:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:32:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:12 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:12 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:32:08 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v4 03/14] net: ionic: Export the APIs from net driver to support device commands
Date: Wed, 23 Jul 2025 23:01:38 +0530
Message-ID: <20250723173149.2568776-4-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: 153d4271-4198-4f93-24a4-08ddca0ee0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n2thhmM7Ts2lcWbPqVu7TXcN8WLXMsuMqd65b798v+MT4Cz6mmH6LKUqSXCp?=
 =?us-ascii?Q?Yvg4q/8z/iWAms2/GBqJUvBwcMd8cmC3BWgMj6YiE4IdpIGmqqK0/g4sVjko?=
 =?us-ascii?Q?K+Fif1txJetXKRVfZ0KUjnGN7jUFjtW9dDv3vwvXGi7XL6sKQdbv3LWBdD+U?=
 =?us-ascii?Q?XEZjFrAikkvtCT2PQYl+tsmhR60lSzefviQoM8LwUXK9eq3RiX3bpKoQG454?=
 =?us-ascii?Q?d6TsGZ85L0fuaiiKu25DJ9Q2t+LdCIY+O0gbKQhLzcAmKxnXqukJNE0AeAw3?=
 =?us-ascii?Q?VSKzELUBO8G5Xnz5NMTGYbaxeepq2jKxEWvKvHhBf0vksubm+GRBOi4lOtyF?=
 =?us-ascii?Q?Ryi/+Xz/unlHPzYOIP8ZbbrsIjpIxvy7Nb+cEZ5EeCjVltawZcwkT3t0mZib?=
 =?us-ascii?Q?s2wwqvLACOeSgEOwJaMOJHO3Q2tVn4fkr2ubN2FqTuRWfpoWS32apOW2Hk3k?=
 =?us-ascii?Q?1D0cjOElmHFgZqdn4pW17+kggh8PmPAijkEv1Z8FwyS/uUlXIiyklY7W+uMN?=
 =?us-ascii?Q?SxRmHi6oCZnGnTfru38aHCRZ/jWhNTuUeNG2Witl0975Gzx8SfiNz6g/QIy7?=
 =?us-ascii?Q?KonUN1VYPnj973MipRKmm2WXpVhTQ5qE5CZbU9nK52btZiZg7owQPLvpQ+mB?=
 =?us-ascii?Q?LfvHGKnlyKwAjkLH6tyvf1nilzU73+grB7f6mXd/51zzyig1HHPSZ7mU4FTR?=
 =?us-ascii?Q?8rNKgefn4qfOLF4+uwF1WMDbGilZcWbRyHZkH7vDNo6LcS7b5oXnp3q9GXZy?=
 =?us-ascii?Q?CVY7fHLLUzWdGtlhwwfKPD3Gyix+rPPzlKimX/uzQGt0t6PwMYEZ2JUKr+mv?=
 =?us-ascii?Q?JBbjLupVQNtHt/JrrkiOAbtmUX0PINjk/U9alPNMGYhoYl/RP1CNrEs1+pDp?=
 =?us-ascii?Q?noCQdT/WYjgy3DRsgVPqf8DWUqFtQ0mHJqzyjsSh2AoX5MS8zCsApkWgBot6?=
 =?us-ascii?Q?7RYkQR7t0nceyYo4MZ/RJ6n1dWcWpVY35ek5upELfU4pNixfge4+e32UMw8R?=
 =?us-ascii?Q?tVjIi2LTOtNz0p2CCe8v5KYIm7FpChN6irVXCtQupIE9uvHIRSjP84vW3gTD?=
 =?us-ascii?Q?2Uy0GcDECA/rRYelfYIDlwWMD40shOMG5LMc68ogqGwn5tbEunBjlymRoXqh?=
 =?us-ascii?Q?Wz9XvWZghZZt7ZT4sHj9ajlCEpB2xpT2CACkZ5DoK6F9ACU0XzHbbvR8vaeu?=
 =?us-ascii?Q?gqmAKrghblHA9GLOCaBp1gKruJRLYYGbuhVsF6lPC+AVSd9UGqPHtDMZY8nX?=
 =?us-ascii?Q?kQNVfSEBDAn2KFy6SgnahVEjxDYpTPHEAuZjf+mc17jgHVv2edwtmYVQDQWm?=
 =?us-ascii?Q?B0FjR7vfCX7+H5YlUIekJ92/5TK4RodmUb79nkm3zT1SgRG9IkuOkThp8ZmS?=
 =?us-ascii?Q?IPc1dgO9ticNHOxVf3ROT/S5o1+CCuwoHrlnWVUn51AhPn+qhNm0zbWD5Ike?=
 =?us-ascii?Q?S92nsL4bhlbhHAyNI1ufDrRcp9Yoz9DUNWhXkC9MxZmd7lRm6T5KhJ2ung7A?=
 =?us-ascii?Q?OdWatAbb53zjZWCRLdKrlxNyIiN6C9h3WPDYKky0QizwPQlGiIPEC8KCow?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:20.8036
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 153d4271-4198-4f93-24a4-08ddca0ee0f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305

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


