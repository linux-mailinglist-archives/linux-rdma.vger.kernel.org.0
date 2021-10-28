Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1763443E137
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 14:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhJ1Mso (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 08:48:44 -0400
Received: from mail-dm6nam12on2108.outbound.protection.outlook.com ([40.107.243.108]:10631
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230375AbhJ1Msm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 28 Oct 2021 08:48:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bj8RI9RzSpEGPRUnqJxjPtDU9WAzkjjyrlVZYG20mUfCM61AhWxosqt+UH9Y4WvVnjrrjF8YAgz9mKdDV/G2Je3a+VLU3SDCkJ1OP4WwsPokaVCqzwYLTvLfOROg/lqQCzuqdgjTTe37VPlqs753pXXoiwcMuxeEZmPCiiKyPJlV2g7e2o4bvdVLWA+uA5rd13GY4wuEYEGy38SgoExvvx1uxyfMmo3zSiA0utriQkmqhPxYDNI20tTQ54IcTYlAz+XatEvHcoKjBlyOlxtDFdl35VljJgfgIQdszAifKI8/OoIYkqSGfykgWCF+xNa/JuMWGKYpd868Fj5IG2nq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siGzmbt+Rid2jSLPFKzFSc5bEOChe5t4dSFuSgMmWWM=;
 b=XKo9dTu/jOuKKLGlC8EWmL5JJfp6M41eoWwHkxv5n5MRRB30PtnFlsXc78jFOsL7KVp6gwKymx2eIcPSOIpMaL6ucGtq4nrSbG1gEQwjjcNZ6G2kGsv/cciUIaZ8MJb1H2+nb83XCiUi0Wqp4X/YF515TPVPMvbStaDEg6mjj7c9tUX4tgIuMUGQ1/sWDO3x7KEyuT3FIMH9kFg0A1Gg7yRfh3RWZhSwMv7TvQeOtL8sw94JGr7aG3/NcYG6FY0kXXSwEhRTmkTN+WcIRv7xkMGELt1slTmPEF3EZGrivyIKXPHrKo7di+dkoRm6KyD/PVeoqXxwlS1C8y7bIWMRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=bestguesspass action=none
 header.from=cornelisnetworks.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siGzmbt+Rid2jSLPFKzFSc5bEOChe5t4dSFuSgMmWWM=;
 b=QzUhVshHbWPMFvfXF+f2oesUBFTyhazb6PMu3h+jg48Lt6fmkxtVvenRfCX2XItijUmKWC1STnBCfa2fYsby5TgnUdc6Kl5MHoT6mDA4ibIIj4MIqm1L+1kUMt88JYH1EiQSn8Ud0or7VKU1lQNS5Z+7BGLn+rJug+4NVTuwCMdtOaX5S9za9wYzjoO9eD4AffUsOfMJNh/ED6Wd+GLLAADirT0Xwy5koSTOpBxpZmluTV2cEegIFfmqoM65ypwL+HzOpV9r+cpzSRCvdZsRE14tWvtQxrn25GqZ5z/pgpnz5kE/Onr/ZxOJhXq6VujMFPwdYqG/5gKMzrWCRs4JNQ==
Received: from DM5PR15CA0025.namprd15.prod.outlook.com (2603:10b6:4:4b::11) by
 DM5PR01MB3226.prod.exchangelabs.com (2603:10b6:3:100::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 28 Oct 2021 12:46:13 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::94) by DM5PR15CA0025.outlook.office365.com
 (2603:10b6:4:4b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 12:46:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; cornelisnetworks.com; dkim=none (message
 not signed) header.d=none;cornelisnetworks.com; dmarc=bestguesspass
 action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=awfm-01.cornelisnetworks.com;
Received: from awfm-01.cornelisnetworks.com (208.255.156.42) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 12:46:13 +0000
Received: from awfm-01.cornelisnetworks.com (localhost [127.0.0.1])
        by awfm-01.cornelisnetworks.com (8.14.7/8.14.7) with ESMTP id 19SCkBXH029177;
        Thu, 28 Oct 2021 08:46:11 -0400
Subject: [PATCH for-next 3/3] IB/opa_vnic: Rebranding of OPA VNIC driver to
 Cornelis Networks
From:   Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Scott Breyer <scott.breyer@cornelisnetworks.com>
Date:   Thu, 28 Oct 2021 08:46:11 -0400
Message-ID: <20211028124611.26694.71239.stgit@awfm-01.cornelisnetworks.com>
In-Reply-To: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
References: <20211028124426.26694.48584.stgit@awfm-01.cornelisnetworks.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b569a00d-1596-46ca-dee9-08d99a10ecbb
X-MS-TrafficTypeDiagnostic: DM5PR01MB3226:
X-Microsoft-Antispam-PRVS: <DM5PR01MB32263BA0619C972BAD12340CF4869@DM5PR01MB3226.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0UAJJo+/kyU04NhXMEdeB8i/fJa9zVTPGyW/tORcyU6LMu9Pi6/qoVSduRLm1miiMgk46VdgEyXFZMqSTp3yqIlTvTHFFLip8Kkzm8nnHoZ56pgdnCgikfn6A+oPUsthnr6H9/Wt7oOvr9BZCwYhL14eGiUnqaZme9+Ogge9JokOBMW7sbAJiIRj17YL2xi6A0tpcNb87DmDRSrnA/s6MKO+gAcB/HDg+8l9lcwGwpFzMFDDUgh4xTFsvIHK2n20mqg2p2/bHCs+LBah6TwZgxu0tQILA/mwF1HfitcHdUQa7wfGMiOPFRmwoKCMmJ29DmZ4ZqS74oDuqh/oEiShEdKOdrk9l3lGZxqBZCVu+2Mot1mFuWjFVG/wTVCzg5E2FardgC2uIhkVH3V3Qads6cdCeozJsW6rAqdz/4XZfIa0jmGzVxcOhJaBkpaoKo2D86oTIQvry+4bOjM23sdaJl7O3xw10y1HDjXybqCrW/nurZaVVUKsIIRSNd9tJePVCXZHUcZa1h8E+UIpnwbpk3nqU4dqJcO2dga37Em3GvDInEyxXQAPw3rT4xrGI5c3JY9CvMTihpxPsMaFaLadWOLg1gL8X11wH/sWrezQ1qaSV+KqMAMz6P0IZ00prgGbC8kIgWEnj9gPhZiv+bqqFNOnzu6JZ1ZBVgiB75tmMIg9sFo9dhfuVq+XaDCNt9uYLD9k7xtyng9pQG1GUG1sZYAqLoET5uJIaFgsrlQXo4=
X-Forefront-Antispam-Report: CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:awfm-01.cornelisnetworks.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(7126003)(8936002)(55016002)(83380400001)(103116003)(47076005)(336012)(356005)(44832011)(36906005)(426003)(5660300002)(36860700001)(8676002)(86362001)(4326008)(107886003)(316002)(70206006)(1076003)(508600001)(7696005)(2906002)(70586007)(81166007)(82310400003)(26005)(186003)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 12:46:13.0715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b569a00d-1596-46ca-dee9-08d99a10ecbb
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[awfm-01.cornelisnetworks.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR01MB3226
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Scott Breyer <scott.breyer@cornelisnetworks.com>

Changes instances of Intel to Cornelis in identifying strings

Signed-off-by: Scott Breyer <scott.breyer@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/ulp/opa_vnic/Kconfig         |    4 ++--
 drivers/infiniband/ulp/opa_vnic/Makefile        |    3 ++-
 drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c |    7 ++++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/opa_vnic/Kconfig b/drivers/infiniband/ulp/opa_vnic/Kconfig
index e842485..4d43d05 100644
--- a/drivers/infiniband/ulp/opa_vnic/Kconfig
+++ b/drivers/infiniband/ulp/opa_vnic/Kconfig
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config INFINIBAND_OPA_VNIC
-	tristate "Intel OPA VNIC support"
+	tristate "Cornelis OPX VNIC support"
 	depends on X86_64 && INFINIBAND
 	help
-	This is Omni-Path (OPA) Virtual Network Interface Controller (VNIC)
+	This is Omni-Path Express (OPX) Virtual Network Interface Controller (VNIC)
 	driver for Ethernet over Omni-Path feature. It implements the HW
 	independent VNIC functionality. It interfaces with Linux stack for
 	data path and IB MAD for the control path.
diff --git a/drivers/infiniband/ulp/opa_vnic/Makefile b/drivers/infiniband/ulp/opa_vnic/Makefile
index a8c21d1..1961838 100644
--- a/drivers/infiniband/ulp/opa_vnic/Makefile
+++ b/drivers/infiniband/ulp/opa_vnic/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# Makefile - Intel Omni-Path Virtual Network Controller driver
+# Makefile - Cornelis Omni-Path Express Virtual Network Controller driver
 # Copyright(c) 2017, Intel Corporation.
+# Copyright(c) 2021, Cornelis Networks.
 #
 obj-$(CONFIG_INFINIBAND_OPA_VNIC) += opa_vnic.o
 
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
index cecf0f7..21c6cea 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
@@ -1,5 +1,6 @@
 /*
  * Copyright(c) 2017 Intel Corporation.
+ * Copyright(c) 2021 Cornelis Networks.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -46,7 +47,7 @@
  */
 
 /*
- * This file contains OPA Virtual Network Interface Controller (VNIC)
+ * This file contains OPX Virtual Network Interface Controller (VNIC)
  * Ethernet Management Agent (EMA) driver
  */
 
@@ -1051,5 +1052,5 @@ static void opa_vnic_deinit(void)
 module_exit(opa_vnic_deinit);
 
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_AUTHOR("Intel Corporation");
-MODULE_DESCRIPTION("Intel OPA Virtual Network driver");
+MODULE_AUTHOR("Cornelis Networks");
+MODULE_DESCRIPTION("Cornelis OPX Virtual Network driver");

