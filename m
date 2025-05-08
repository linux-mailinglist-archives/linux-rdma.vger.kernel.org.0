Return-Path: <linux-rdma+bounces-10135-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A5AAF254
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2BE3B52FD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519BA217F31;
	Thu,  8 May 2025 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="idoM4gz0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E5215F7C;
	Thu,  8 May 2025 05:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680460; cv=fail; b=KbeXF9pwZWHvisoC2KfgSE5lW6p76JFndiRsQPdPTl0Mlhy9jbnlRIM38OPgf58wVUun2K/anDTAE8QfO/doeVJFKtREA5AIuKfCT2vERHOsARHaYxywmgyGHZz6cfksxP/W+G7/gl+B/ESAa5XO2Pw9cEZIlhV43qQPP0muxR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680460; c=relaxed/simple;
	bh=e0QEhaGgqO3+sZHE83XtQSI6fMYhd7JXNksmoapxZrM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcvcyazUT7+rU0ZdjLCcP12oYAJpO16PE21/nAdyASJRyKLZsss6nZD2iDMGk62oI7EIldAVpcMmB6jHt29RodMyiFR1tRZy3E9cYQZ5t/MQb0n3GLyHBXq7IGl2Xsv4fyLcyKxDerzEoXArMyW1Mtz4Uk46GgUI/UGZqllXkXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=idoM4gz0; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asaj8ZI8HqvqAhPgXA+ekRPFc12VCyrsFzzFhl2n89aJs1Tncbb4Tt5yQDDc8NEE9qlF+hiBLOtY+7PQuVH1x2enOOJTPSqOymUOF+aL7+zxZgp8KlWwC4x3YRDpWA9kAERzLwjNaPwumAmpH0zV9qzHWXfgGCOKwPDs5dlGTHjzl9/rwshdkVg5f0V3mMHR69JMX/Byd6REF0H8jeR7IiImz6reKpAQK8poai59Q0NHLfg4/DgBpMpomp0fb/FHvN3cZYw270f2BuiUtpR+jbyXscpg9ltAYIYVXGJOl7XHc0IjH9uZVChRTkab3O4I8V/n5rXWmrCyi6okUsfGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4R2uzn3Dr9UmDqVRyzs3y6uTgF8aGRhQmM38NgbEJc=;
 b=VO8TxHmKgq0ziyw2kSaRVeZxakTtJnIsjnfTRuyADIHghmSsrZ8O2bLsh1aRij4nfpquhOzSeojwiPzWYxJVa13yot0ZCUP4iJTbccDjTsZ/3TU5lk1t2/oDgsZA7Kf8DgD1u7xWRIrRDlYqmLSArK97pVuSZfNao71Fybr25Uh82zSu2sACH4yfWRCXHU0aliAaUXc19MZbw6CB3PY+jeGLOMXIqxajiEQ5EwmUKxLtf8987tT112RYAvWYe9aQZwFn++JRyjupBtFYndx/5y9CEh00Y1ub0G7x0l0yLHlOgjogSGnaueAKSw+fLxQV0atjkzOKCbcYIklb0qba5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4R2uzn3Dr9UmDqVRyzs3y6uTgF8aGRhQmM38NgbEJc=;
 b=idoM4gz0LIvstQB5KOIcRvOrZuRv1JAxP8zUXlyHg99DqHHcofvuBNla5ENRM/DSp1CVfLvr/ti/9ustS+drGPFgmMWSKS9pcvfou1kw1747bEFcye957679hUj7/LyWsYcCQuVBeJIALKZ+MtiUsgFz/IrvpdQAhpoZMUn6edY=
Received: from PH7P220CA0179.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::27)
 by DS0PR12MB8786.namprd12.prod.outlook.com (2603:10b6:8:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 05:00:49 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::8a) by PH7P220CA0179.outlook.office365.com
 (2603:10b6:510:33b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Thu,
 8 May 2025 05:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:00:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:00:46 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:00:42 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 03/14] net: ionic: Export the APIs from net driver to support device commands
Date: Thu, 8 May 2025 10:29:46 +0530
Message-ID: <20250508045957.2823318-4-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|DS0PR12MB8786:EE_
X-MS-Office365-Filtering-Correlation-Id: 729c6e61-8287-4759-bacc-08dd8ded4c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BzAWjpajD8RlKp+TYqhNAaz/J9NXwl/oDj1/Gy9gVRojMacNYxkYFPSSPjAQ?=
 =?us-ascii?Q?fAA0LANq+WxLh8fB683JD2BFszcJwhpeoXGKgm3C4l5VY3DxUc61v9ldyCbY?=
 =?us-ascii?Q?bMFab5hG1NIpaVuP7GQ722xhUFp1EOrdDKjR8rL/CrLJ6+LWguLsqOvOV8w6?=
 =?us-ascii?Q?DTBbARud66NmNaQ8FXs5i9DGHv8hTWXsLFotWdIRMecVY0YqvPCotasu56yn?=
 =?us-ascii?Q?2ReiwWK0SGZoML1FXxzrAKxBor7oyxYo5P50ZQwRBcc8Ce/bj9wdYX43re/u?=
 =?us-ascii?Q?Hv/Lq8NS6x+UR+rtowdN9KGuEcNNwocRVVOjt5Oi6yG+TqF0rugM/z8MqBPj?=
 =?us-ascii?Q?FoEDEeJ4QQ9suSZreWvuIwajsw6Fjr86UvtIIwvYAkpPyxS3RNbx7BBDQYra?=
 =?us-ascii?Q?8nDhGuhKEboZNPp72I6qLjrURhyowgzcUTdpeF0XSdLKx5F6DVfQtFEAGgVq?=
 =?us-ascii?Q?j69ccZ1Y+uQzHYKxI/KfiZoNMgkfwBjpzZMtz4Sl6eIMak5UIOiiNHvHS81D?=
 =?us-ascii?Q?viMg5OmvMtf3ES4hm1u4t60DX5AQQRRo9TiQLD6jpLVtwVpVanxIBwwu9KKI?=
 =?us-ascii?Q?Z0Z/+fgYnYAHV0Em/LFBghzQcOXnPyKtPkMWoIm6B86/feW3+b7DfkzDmKWG?=
 =?us-ascii?Q?Iyld0gAvuNIabs3zSEPJBD4X0Lan7eo+IRJPl/IZD3x03hH+sdzx36hqahtO?=
 =?us-ascii?Q?f24NsEPwzKdHbex2sD2Zq7Pc5e/wzF4atf3PmXiUOwvQ6edofp6nNnK6uwFp?=
 =?us-ascii?Q?jS7Y14MKTCOBZnUNb6gxJFPkwIo8XeSHZkENJDZnJOKOrZaKaF/j09lc3F7a?=
 =?us-ascii?Q?HOqtwTwW/djdE4KZ/g4iJverlS3rxaGQV7gMXR6qShJfZu7xcIIj8qtZ8nca?=
 =?us-ascii?Q?o44XNV+1I36+BNcrD77krZaTo860wvzd36zKnaLO4UzRiYCw2r3nqcFkZVvr?=
 =?us-ascii?Q?UIT6xni9m0B+RHo9L21/7YjTMcyyRzyfKptzzFNCgpFHaYgAmzyvDFCAWNCf?=
 =?us-ascii?Q?8IagSJavp8Vid89RYwmJ2/VcW7C5djEamsEkSb56mf3nBLVMhseSHHPrQOtA?=
 =?us-ascii?Q?bqjRD5mj86uesT+DnCnoh/BeyUiRNcOvBGKdRFBfQC45zYqLGCxPtWkidNxt?=
 =?us-ascii?Q?MT7MoQ5cklmXksu91myjXCW5CXekXNbHQ6di0KxFOb6qa2JvbRBEiPiLREcC?=
 =?us-ascii?Q?LfFJOjP0FJv0GSJ9bNWAloAD7LR6vKLmfcdW+mY7PPAiConnkmEb+9LCQV99?=
 =?us-ascii?Q?/ZQGFrDRTcgVFuE3hGY/MsswrElOFhqhI7vUtH2dU2JvWdpxhKq6cxL73RO6?=
 =?us-ascii?Q?rIO5Bsh1/b8tZo+hP/GkJDcq1i/lJOpnw3s9h4P3PcbFP5ZTKijZve6n9SVt?=
 =?us-ascii?Q?+mn9hauNzPwT8GCpmTJ3cyKhxWOScODfzBQBfVUr4yn8WlE58rm79hBOzk0x?=
 =?us-ascii?Q?yArOeAbEbH+ZuH6qii24PjXRIZgJEIouOqHHttpaW6S1Eaxy8cBalLzyVaVD?=
 =?us-ascii?Q?mfrViVk4vWiCOcVCxCP+jJW595r9E4xjsl6USime9WX0oY5uiTEUqrRxYg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:00:48.1296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 729c6e61-8287-4759-bacc-08dd8ded4c44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8786

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
2.34.1


