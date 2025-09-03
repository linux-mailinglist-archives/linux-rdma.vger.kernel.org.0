Return-Path: <linux-rdma+bounces-13050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C795DB414E2
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCA1175363
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC85D2D9492;
	Wed,  3 Sep 2025 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J0sDnoHi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D363D2D8DB1;
	Wed,  3 Sep 2025 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880257; cv=fail; b=dUUa77VhO2cDo4b+ORhwzc8z/hHebtzg4RQ5YL5L8nNCAkx+BHRlwg20zoy3xw375UGyG0qt2ODoCd4z97lTbWltJgN62uTYkZ5actqGeMWJ2xeIqCS18CWLHRqK2MnXlEeBrPcu1ns2NItPjQbnbvIqMOYl/gX4EQTQli5kH4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880257; c=relaxed/simple;
	bh=DuGRXm3G6STnw5PojIvaj7h3+QCDBTUd0I13tqGOb/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGP76muPXaMfWYGFDy2dYrZv9U+A4nmCfBrI6DuBkk8wmwc87io15RXU1QEnw6Mf5wq+HHNOOAyv7SJ8/N+OhXBjdOFbB2e4ba4dmXorfunweJixi264lSAecwzCMDF7DKyCumjcUjaaIGquctaODP70u5Ifr4EqVGW46dAratE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J0sDnoHi; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noQP4hcNhExVyedFQVrqr7z869AWxJTrJvj1EysDpqgYINJ8U9shMNQdkyUIPAEsKgLS2uivj7CAAWomK5HOy9MxRZg77lOg6kxH6C1p9CI+tMNaRu9qmezTo1XPh2QsrPQRWxoC+uqcuRlhmw8kIGeyN53fQne+uqndETraPCoKmUppp9mUzl8gpKuVlNcgIngFy71msvGmKbDTF8UBxeZMiwAg5KAeBY/YCIuGTRuCh+j2b1h6cxtzot06X34QpTeM9e3SG+JjFWk55m0Ok2XB65CTyiML0ZLviEacJFuXc+430jXPHAjRjwIwt0zCKzGGuwDAkgBTCrg4phho+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROUcFiiAmA0UvChZqyGDfkFIjIIbqTCtaOqGidUrdns=;
 b=uRenrJa5Jp6DkXETByo2jkcP9BmLsW6qMz6SvSWEk+qkXi1AoKPOtka1qnPnF6Bd81Y+KPY6XuLEUXit6ePeYqQbd+JDPQ7dbw1Zdysm0zNHUOswr7UP+uGO7InnRptmCpus2VzODUwKBkx8+FHER8qvmH+aCRx/DPoKxB12Xv6neH/WMgYoA4o+QUhUPuF88ZjiLKjxO7TI6QYF+NBVikNRB7hIcn77P0n72GMYk2CTSlk0rJM46oXxmLb+Qx6BUjPb3fCaDyNWe/W0SlTHJdf2v+mb9POC5BejB5rK9YOSC46pSLaFbfWI1Z8YHL6jqxcKJy/lLSyhdKgXv7nwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROUcFiiAmA0UvChZqyGDfkFIjIIbqTCtaOqGidUrdns=;
 b=J0sDnoHiXnnYjU4IurtWDDCmcux0ZfmZZ5DRfVIwfeCsOLpgui6QKxGZpeHZGVYeSyMGuAp6deoLl8/mGwzGcEOuy6KT7BSJX+2RQDx+Ws9qNXCg8zfh1EN4X0dj++K/mxxWTZ9aXuKBKbtRNhUgndnDIQr7h6qyVcFP0F0vkHI=
Received: from CH5PR02CA0006.namprd02.prod.outlook.com (2603:10b6:610:1ed::16)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 06:17:32 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::7f) by CH5PR02CA0006.outlook.office365.com
 (2603:10b6:610:1ed::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 06:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:17:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:17:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 23:17:30 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:17:26 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v6 03/14] net: ionic: Export the APIs from net driver to support device commands
Date: Wed, 3 Sep 2025 11:45:55 +0530
Message-ID: <20250903061606.4139957-4-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f583782-8568-41eb-fb5c-08ddeab190d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ooidIDKhp8QBWp1X4K7s6AbFFk34tBLvz9MQmpscpKTuG9RGpIQC9OqRqs4?=
 =?us-ascii?Q?UEWvP+7o6qMAJ/+YZaOYr94y/oZhGa3TRHpCrtyFYJE47mod/yCCjCWcJ+2h?=
 =?us-ascii?Q?XYvFytysoXhJxveoOuaWznnX4cxmpxGdoJLCKWXFbW7JGTiXHBOshBKgH7+S?=
 =?us-ascii?Q?8oCB0IE/iUOzyR3sHKE4LEUO1CgPVoPXs/RSoiRaFJEGKytNyQ4Q1r2BsaFh?=
 =?us-ascii?Q?fzydjlKz3A2hnThbwPWumQz/glZn/hSKtoJDnUEtHpx6JE8sgT3/IqyPlGPO?=
 =?us-ascii?Q?Pm6bFu82rRYHR9nY/KdecQIK+Wn1jfrvyQD+sMjI889TRTZAvWb+YcEe0oNb?=
 =?us-ascii?Q?HX9NQOgCsTKKzJf7Sj6H00u68mUCijaWlEwOhIT92/pprqNo6uGKB/LrubUV?=
 =?us-ascii?Q?PqgyzFJ2j1M6rwNXXsx74OpDhn+M+GPstUvsW8qEBBfxmjGMQw6YyT7ZZauv?=
 =?us-ascii?Q?57yvKxkSBHgrVHSgRcqy5N+yIsz/LM8Ti1pTrkPNU/UDuuIu0k8PiWXvnj6S?=
 =?us-ascii?Q?SXCbMtqAnvOzWoxwBvF3DeXED5WB5iuNo1jr/rq63Oo5nfj/da7drGv+jbkX?=
 =?us-ascii?Q?ZtJeD95G2k69ZLVlPjZClLdL9Mnalshs7ppmxoed7gip/oAIYKTKRk/my3Gd?=
 =?us-ascii?Q?sgH1dpSepctgGc0ypziOpqcSoOgLkqzFEufVCs5SQZUWWahA1Nnw+yWMBkap?=
 =?us-ascii?Q?oHxsIfkrxVP+AYcaY//0gLjjzpDmhjLo3YmYex3YdizPKhgWBSVfTUEYjkDD?=
 =?us-ascii?Q?GqpmmfxItig5RvRS65SMClhD+rwENA9NhLiJgY48E84efXb0EdF4ANJS6PqA?=
 =?us-ascii?Q?SuRwVsFKmiM0T3vcZRz0qB5q+hd23XTvNdohXpZNcbTKPd/ka7qLd3LXUR+q?=
 =?us-ascii?Q?fS6QuwJ0XFeWS5xKQVLctXGZcIjTi2O5DZM70Tewv25D3kVf7AhALplNxMLu?=
 =?us-ascii?Q?tQauNlBq19faKU4VZaHN+6ATxxFxEEQMHUGIqXXrXQuHL9elULu0LncKNfJy?=
 =?us-ascii?Q?o5pCwOS2ipG7VgzTG1jwHJYH3BtjTPPXl2vVoqPDKZNsCKIvumZGNhJT7PTX?=
 =?us-ascii?Q?rI5kCmHsphzkV8RxwuafPuPLTec9G/YDRLhJM+vNDmJFJnQTxbdX+arSinoi?=
 =?us-ascii?Q?LwXXQig/VCFqhcFRl/F7y1wZedKcTE7rXmse9+Q0rpPPgirdMTDvV72THbUB?=
 =?us-ascii?Q?2VPqds0ddXml/iJY2NF1pPjKD2XUuy0NLu/AOsXT+GOrCT/4qYFdlXpy3OU9?=
 =?us-ascii?Q?J1B5p2e2z97xjOjB8mpOIw6xG/W6Jq+cvJ6PpDnTSopAfxDa0DnGcxEZjxnW?=
 =?us-ascii?Q?bjSjtpTTpTqu4g8IsMt2MORDdVGmlCZHU9I/Z4ZxG6QyosNUI1Gj5VtZ1Pmn?=
 =?us-ascii?Q?MC1nYeLdiV1HzwPoc2oFR+rZ3le2mxlhL5tNDgAozd/lXU5SziOBQW1PcoxW?=
 =?us-ascii?Q?lESXCXOdlsRmi9qpcj41eQ0uwBa2/Zygan3mcd1yvHPBJq971DccPEpMtUT9?=
 =?us-ascii?Q?hD5lZQPfMkzFtn+smwHFD7QBPD2nUqtNDAZD?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:17:31.5397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f583782-8568-41eb-fb5c-08ddeab190d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130

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
index 0e60a6bef99a..14dc055be3e9 100644
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


