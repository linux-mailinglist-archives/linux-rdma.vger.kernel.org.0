Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789D543E135
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 14:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhJ1Msf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 08:48:35 -0400
Received: from mail-mw2nam10on2126.outbound.protection.outlook.com ([40.107.94.126]:46176
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230281AbhJ1Msc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 08:48:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gs4NV09g3ObbkwmGolZV9KtOWqnwkPbP4WxKAw4UczLLXXHxorXG0xTd0EfD9mvdD1P2FRZrUmuvc1zaXmIDteh5RjXcywiTX2z447DGNZapnDgkP5nh53M/AnhW2bRhRKLxMg5c+VwkN5uX0FdvvaIwpr+AABJZ/Am2JiXD+dTcnHdsFicHGFin9yzHBm+SDPx7D7E3EbG3fv0PgG8L1FRBTBD6FsVdip4D0jK/7UzZ/SIEmR9yTOBK5oSz7Wb8PwAjux2QlzQaDpfgNJxCAmDUOWKb4wCECwrDZ2J8W2TtXBu42ItxEKEuF3P++y9yLy39fi4iOrvF4HQ4IBEIng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNJ3s38ZRrt+Ys9jwY0LibcBpTUybnmkqIw7eXBvlVI=;
 b=ZjvlRtpwk7skXPV3CgSeodvuFSTwKdcFWNvDa0tEYGXRxvlusYw5pHm5dLSSkqshbM7jme6qxEzW0hWyGHpdGG1H4Cwy1fOl2GR+TwVnYPm9BLMPy+KJhhogd4r2vaWP0JK6Lk13JyWKUEoqZH4H5KQkfPSaoYBRm1xbUnBp37q1U71N7LH8m3yYqWMa4wQbMzhFHFSY+s2QxyLsDC12HU+OmaNhz3cTIhST+mZR0Qwga1aG/8sF+54sGH9u5w1pCrdrHD4Ia6eCMijVNgljDsiGgk3T6D0eLdlmV0sh4m+bpMHLOrDJXDe09qg7glQ6XQuvEQG3YMtzY2qi6ppxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNJ3s38ZRrt+Ys9jwY0LibcBpTUybnmkqIw7eXBvlVI=;
 b=gCjfZZ+a4ysidhMRaz+I+hMolIOU7YRuAWjH9tvEWIdR+TMgRyiSkIUgP5oFCsfpuf201mhrofkoTIYsqpd9+hqT83rlClF+S0Fqm+d/WYLrrp1/0C2OnLOXKCrL43bD+hQWnbOqixSGW+KWXnqqnc2KJWyZJBZD+Qbm8/NssVhIZEhx+mzBVrwhbY+dUytAZaso3/jUeC9xBLxtc6o4MexwLbmihXu3WCglbJvuQTEMPw+nbs9bpN/svPQY9QoDI/DvNWMsiwb5pBGLmyprs0910qNhBk0/bD/v/CtUOGSxMxO0bVeWd/FVpppXMNxycgbHXBShZCNHWy+x9snaog==
Received: from BN6PR1701CA0005.namprd17.prod.outlook.com
 (2603:10b6:405:15::15) by DM6PR01MB3946.prod.exchangelabs.com
 (2603:10b6:5:87::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.20; Thu, 28 Oct
 2021 12:46:02 +0000
Received: from BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::ac) by BN6PR1701CA0005.outlook.office365.com
 (2603:10b6:405:15::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 12:46:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 BN8NAM11FT017.mail.protection.outlook.com (10.13.177.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 12:46:01 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 19SCk1EP028922;
        Thu, 28 Oct 2021 08:46:01 -0400
Subject: [PATCH for-next 1/3] IB/hfi1: Rebranding of hfi1 driver to Cornelis
 Networks
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Scott Breyer <scott.breyer@cornelisnetworks.com>
Date:   Thu, 28 Oct 2021 08:46:01 -0400
Message-ID: <20211028124601.26694.35662.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
References: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 029e27f1-adb9-4405-c3cc-08d99a10e60e
X-MS-TrafficTypeDiagnostic: DM6PR01MB3946:
X-Microsoft-Antispam-PRVS: <DM6PR01MB3946F206C11A78ECBA6FFED5F4869@DM6PR01MB3946.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VMV+G71qHKOIFcwsvo/SFdAQIG+S18Z0qN3QrKfJhdWKSSCz5QQnG+V8sj8B//kuqUM4PcyTXYAIHL7gNq6mMcOdQq05HOFQIv3RBeEKXSQcNWl32Nls8K1wEfj5ZsBCXGWdFncfUhqSOWj3rkm02iH8dHSdGFNw1i+gJ47L/78QWf6P0PPJZhHTlSqFsJUew/YuX1zlTb12maE6VtHlkGfslyA4WPiSejSb2TpaZ0sJ5GSsaFptaIOyJaPJr3HDJxfIMKLlygO6J7vjHdFCC4RwWXIt5rSetymyMqAYRus6vJOzxLtEGRZUXbz8PRS9FPjt3CLt8hh7cVIQKPfIlLFm2DZHc+9BRLJZQFmPu/gwmZAMgGb+fAd2VfSBL9xjbr9SueQ2yV6n1OmMjj/ImJZ2g/McYtgrp2dAuR9BqgjocL6PnNANdFHLIcZUoyQ+4Jpc1vkRNakqY7Feo53vqCDT8C/usCRMKqDbWuQ15KP5jdjwGo1iEdD34bCeAiIJmf/NO+IMANtdUAXigMnt66jRr67wNuj+2ZQoh9/9UZfS1oFx0umBz3ZRXQRtSuK1BXsPbY6EZsNEsKqSF7gSFc8wPIF2ly38vw4z62ewUd+GvxaidMNVPgFhs41Yxm1w1M6IODiwooCoxQlqSUDtLdzal2QXhVgswptiBfBHFGhtDvhQelg+IWsXVpF63qmOF5FOlG/E7Vo83Uh0UzzeewwKaJvQmuUcEmba+fsZz9M=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(426003)(8936002)(81166007)(336012)(26005)(83380400001)(2906002)(1076003)(103116003)(356005)(7126003)(36860700001)(44832011)(82310400003)(508600001)(70206006)(70586007)(107886003)(4326008)(5660300002)(47076005)(186003)(8676002)(316002)(7696005)(36906005)(86362001)(55016002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 12:46:01.9147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 029e27f1-adb9-4405-c3cc-08d99a10e60e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3946
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Scott Breyer <scott.breyer@cornelisnetworks.com>

Changes instances of Intel to Cornelis in identifying strings

Signed-off-by: Scott Breyer <scott.breyer@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi1/Kconfig  |    4 ++--
 drivers/infiniband/hw/hfi1/chip.c   |    5 +++--
 drivers/infiniband/hw/hfi1/driver.c |    3 ++-
 drivers/infiniband/hw/hfi1/init.c   |    3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/Kconfig b/drivers/infiniband/hw/hfi1/Kconfig
index 519866b..6eb7390 100644
--- a/drivers/infiniband/hw/hfi1/Kconfig
+++ b/drivers/infiniband/hw/hfi1/Kconfig
@@ -1,12 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_HFI1
-	tristate "Intel OPA Gen1 support"
+	tristate "Cornelis OPX Gen1 support"
 	depends on X86_64 && INFINIBAND_RDMAVT && I2C
 	select MMU_NOTIFIER
 	select CRC32
 	select I2C_ALGOBIT
 	help
-	This is a low-level driver for Intel OPA Gen1 adapter.
+	This is a low-level driver for Cornelis OPX Gen1 adapter.
 config HFI1_DEBUG_SDMA_ORDER
 	bool "HFI1 SDMA Order debug"
 	depends on INFINIBAND_HFI1
diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 37273dc..960329f 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
- */
+ * Copyright(c) 2021 Cornelis Networks.
+  */
 
 /*
  * This file contains all of the code that is specific to the HFI chip
@@ -14918,7 +14919,7 @@ static int obtain_boardname(struct hfi1_devdata *dd)
 {
 	/* generic board description */
 	const char generic[] =
-		"Intel Omni-Path Host Fabric Interface Adapter 100 Series";
+		"Cornelis Omni-Path Host Fabric Interface Adapter 100 Series";
 	unsigned long size;
 	int ret;
 
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index de41188..61f341c 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
 /*
  * Copyright(c) 2015-2020 Intel Corporation.
+ * Copyright(c) 2021 Cornelis Networks.
  */
 
 #include <linux/spinlock.h>
@@ -56,7 +57,7 @@
 MODULE_PARM_DESC(cap_mask, "Bit mask of enabled/disabled HW features");
 
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION("Intel Omni-Path Architecture driver");
+MODULE_DESCRIPTION("Cornelis Omni-Path Express driver");
 
 /*
  * MAX_PKT_RCV is the max # if packets processed per receive interrupt.
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index e3679d0..dbd1c31 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
 /*
  * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2021 Cornelis Networks.
  */
 
 #include <linux/pci.h>
@@ -1342,7 +1343,7 @@ void hfi1_disable_after_error(struct hfi1_devdata *dd)
 static int init_one(struct pci_dev *, const struct pci_device_id *);
 static void shutdown_one(struct pci_dev *);
 
-#define DRIVER_LOAD_MSG "Intel " DRIVER_NAME " loaded: "
+#define DRIVER_LOAD_MSG "Cornelis " DRIVER_NAME " loaded: "
 #define PFX DRIVER_NAME ": "
 
 const struct pci_device_id hfi1_pci_tbl[] = {

