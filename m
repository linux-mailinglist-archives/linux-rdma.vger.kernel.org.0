Return-Path: <linux-rdma+bounces-12735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C2B25AE6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 07:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C605676B6
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 05:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F522223DC0;
	Thu, 14 Aug 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W8sM9wye"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902B22AE76;
	Thu, 14 Aug 2025 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755149978; cv=fail; b=tQXdVUEso1S9uluWSYUtdpWCk260dwGut/rw4xmu+2MMbFJ0JK8jBx4IuP113Vpx0GDh/6eeuD6QUjU3dQYyobVfuE1L2QVxJtdIczms6ewkSZNcPO82DAV2mIqzKxiTAt/yNzGmPXhkLocHUaAnY+M9YX3yPPKNMaKMWQGyYAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755149978; c=relaxed/simple;
	bh=DuGRXm3G6STnw5PojIvaj7h3+QCDBTUd0I13tqGOb/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rYzwq28a2/Btdbw1J+A4a41ott/M95Fm68fSfiAZxz/TI4csp4PCV2Vroq6TW5n428exlvPW1+8fUV7+eqF0BucKa6l0lt2T31rVhYv5wXGHFl2mt33YektIWyw1wEgP5VtAj2Mk5Ren/fpxpi0KI453MqzZrTAaSoVvoLRJgWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W8sM9wye; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckHDxZrjsXngdaA7w0zwbVOfxT246PIt7bB37SK2oBrUq3SINtQAn1Q1n3P52t5IkO0Hua2ErnB1q/J1185adx4j6+KpxRbYYPnYwXsaqBXwzcJ+CsJvTDwiRWZ7MouWa+QOTdjkBYNGVfqls3zR32kv6jW9kS7M15ILjLDV8kKd4Q6DbYIWfAwYyz3uzHVWUG8SVFv9SedlRFCkfKWak3D+LCuMCtaIOkBZFSi7G3VdapcxDeqo2+zPeM/9k1jeAARKtJr6304/c71tLC6KKr1QTKnnW4/pWbFdlhTs3rEaHAkwLGCrTeIqFE/JxvPAJ/+CpcVQ2RP1lQl32PtYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROUcFiiAmA0UvChZqyGDfkFIjIIbqTCtaOqGidUrdns=;
 b=F4TWYD9FLU/zhi8D6n0sEzWl1hZiNhsgedxjyfObPvreZOwaZB2coysbfhHrGt4zQvgb7fIAFYG3YAPlynRNdyIJRFWewN3PVrKzGzHd7JY3hA7Ts3xS6rScuWQkcwjHf3cc1RLxOHo5BQi6CeZIJtactWtNdW/1V8B2n1I4p90mP+1cm2sdSvs/nFRUdggJEkSyOLTmdlQGg5hGBuwI8IkzFva+gNViWMH+ot06jDmF1Ik/p61wGMaHcyX7IZII37q5yb4yx3MSc5odofU/ZB+GydhD3gf+dHdY0aTrqm0DAHoZQAmF/TZZ1MjvBwvoa7cq6SfrA+OlPVWTVAcN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROUcFiiAmA0UvChZqyGDfkFIjIIbqTCtaOqGidUrdns=;
 b=W8sM9wyeYI13DogaWY0oW9FkIRpNDrPTNfhtQ4q81DIJjsrwbTBmoy0uyTG9q0mfYl7jbwMHohn97sVhw/wSW84W/95disiZgdQsMNActlOKdboNied7KNrBQWlD8Pv4aWK3zk1Oz+/uU7z96up45fiRkW2XtDOwhRtEUWhqO5U=
Received: from BN8PR15CA0003.namprd15.prod.outlook.com (2603:10b6:408:c0::16)
 by SA5PPF50009C446.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 05:39:30 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::29) by BN8PR15CA0003.outlook.office365.com
 (2603:10b6:408:c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 05:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 05:39:30 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 00:39:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 13 Aug
 2025 22:39:29 -0700
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 14 Aug 2025 00:39:25 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v5 03/14] net: ionic: Export the APIs from net driver to support device commands
Date: Thu, 14 Aug 2025 11:08:49 +0530
Message-ID: <20250814053900.1452408-4-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SA5PPF50009C446:EE_
X-MS-Office365-Filtering-Correlation-Id: f47c3eda-0da7-48c1-317c-08dddaf4f0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sm0n45j1ZJ4uh6jRqxj+xBBKq10/3a95cJpnpiNWRzPMk6j+mDyAh3qj1Blz?=
 =?us-ascii?Q?6BN5eMLl4ShMPo0PXtocfpKUc+QMbsbrizupbpg2sso5wtqgiwCkayHexCZb?=
 =?us-ascii?Q?78Kzn0wQpyzY/nrjTiLXH2w4R9ZTVWC5i348Ouv+oXYIwMHuyMd8JSCbgCEj?=
 =?us-ascii?Q?V+GyPU0XS0Jm1kVeV11ZcTfESnaOdm5yeRQpetDem692NUrTywx3GjVOtiAA?=
 =?us-ascii?Q?9J1QFK4z6dmen41BC8TeVHdFRtB0sgWDl7TGPCOeFCc3Ravc3vcMZBo4TDL7?=
 =?us-ascii?Q?GkGgyUzfbGpm6QM9tSQWyLr6w9SAc2G0n9wcAiFJarWeEoaaGhQjzwEkx4XP?=
 =?us-ascii?Q?SrwcyK4s3Y71I0tLpfFYqNhJlvD9OOt/YUxTu2ZrXvL4SEJ/K2vkLink5xW7?=
 =?us-ascii?Q?EzljHZGJ5O+VGWaKaHZiyognXAUVp1lAbvxRAvuEpc57/10uHFLXs1oL5XjV?=
 =?us-ascii?Q?4mrE0r1bCwc1/vLHoZFcQfDCQweP+6JbPhbT04bzGkIckp5/yx338qKAjVxt?=
 =?us-ascii?Q?WiSVKG4VHi90kp/N1All+55beruWcbYB+YhF+SRUlKKksln7Q08bbwKIDPcO?=
 =?us-ascii?Q?x7JRLEfj4C4RubymV9Phw2h9MtUB7rgYrRXbzKRMHGOYGlhQKsy5ydwOcomk?=
 =?us-ascii?Q?DIImsIZ0Yf35tdRnnUPh/EedrxEixHqLSMsfGAzYzVeJXBwOHjQ7tbiZNqfo?=
 =?us-ascii?Q?W03gjAzh9i33WrY1sGBgGcZnWEbk2yLf45JjmmyKPuo/OE/f+IjzXi6Al+Gc?=
 =?us-ascii?Q?KsXHNnCO/JPo49FqlUEc42QGta6ep4+y20+EN0tibG4RkWmtyxiJVgFuXQlH?=
 =?us-ascii?Q?g1ZG96945V6SnYEN/siI7LvZvVIhRgA/OgpGI44McshgdZj0VEidSPGZVeKR?=
 =?us-ascii?Q?f3QyGKu56Yszc7X2Ms79sv5RVqMNJ7XQxBDm4T3zPUpuh+l1RxhK6zzzzZSH?=
 =?us-ascii?Q?5hNguv9CxBr2OTQMX9Ipn6Cuz6ZSsAQfJTGCDXxtYhGW/b3N0DJ3sG5MVpiV?=
 =?us-ascii?Q?untgHSShFvKmjDWxx6+mA2yN9D6q1+hRe3+RX/EBXQSmuVZhv4AK9gkT4s1x?=
 =?us-ascii?Q?LtQ9ZUN0CbuiyCTFpEIGdktkYjnIbzDBECPSb50bnvWnnO+jayTGYk/B5hCa?=
 =?us-ascii?Q?uhIMr/6PQ2tYwzccfuLc1vOpjB/s/OgYLRsPuT+FKxWOYiA1IWpNOpYVPUu8?=
 =?us-ascii?Q?KXMTnNxUn40oT3vw32MuYj9D/v1hFDSiy11AMkAvsLy7qa3wRQIUZO/gZhOY?=
 =?us-ascii?Q?Up+K0vXjqXVzce7GPkJ2/aClulRcQtFiWBsJpApW/REkT6pG+tU+cZsMYNEC?=
 =?us-ascii?Q?cCZXRX0hz5z6DpPMl5Ty1E3hjrTuxTmlk2r9Rd6gzsfYpAWzTpAh7LAGdc55?=
 =?us-ascii?Q?vuVDuWoID777iULkl+2YcQzPHTpGjE4zzlA7S5PFCcFnrhCJoMuw6tJ2mzBA?=
 =?us-ascii?Q?dipEge42NqlBKNEUR1oQPbI50a0aZINjcWfFoanpBWtL2KbydszNBsLC2aPY?=
 =?us-ascii?Q?OGEseaidUJ4i55NlD+wsXoI7m63mjFa5cfQ4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 05:39:30.1778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f47c3eda-0da7-48c1-317c-08dddaf4f0bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF50009C446

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


