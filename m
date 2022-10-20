Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E97660642E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Oct 2022 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiJTPU5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Oct 2022 11:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiJTPUo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Oct 2022 11:20:44 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48986419A7
        for <linux-rdma@vger.kernel.org>; Thu, 20 Oct 2022 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1666279241; x=1697815241;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oESy1/8NF/PFCPEm4QIVU4UzxGM5KMl92gtgHs2Li1Q=;
  b=M4oAJ5+OLWCw9B6mmV6yflG9Jgk0PjwfYqUTY2ZoRu8s0O7AelqTSFwG
   d3X9WWC8EjIbZp7GXleDFo6tu998jTSwIFReHkh8GezgKim0czTO7513M
   4kNGxQ5zLiC/TmakCG7sTRrnIouuJwXQvz+cyKJS9NhIrgri8mcnZ6VEC
   k=;
X-IronPort-AV: E=Sophos;i="5.95,199,1661817600"; 
   d="scan'208";a="142375971"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 15:20:10 +0000
Received: from EX13D09EUC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-f7c754c9.us-west-2.amazon.com (Postfix) with ESMTPS id AD2B44163C;
        Thu, 20 Oct 2022 15:20:09 +0000 (UTC)
Received: from HFA15-G2116K32.ant.amazon.com (10.43.162.213) by
 EX13D09EUC002.ant.amazon.com (10.43.164.73) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Thu, 20 Oct 2022 15:20:05 +0000
From:   Michael Margolin <mrgolin@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Firas Jahjah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-rc] RDMA/efa: Add EFA 0xefa2 PCI ID
Date:   Thu, 20 Oct 2022 18:19:49 +0300
Message-ID: <20221020151949.1768-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.30.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.162.213]
X-ClientProxiedBy: EX13D35UWC001.ant.amazon.com (10.43.162.197) To
 EX13D09EUC002.ant.amazon.com (10.43.164.73)
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add support for 0xefa2 devices.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index 94b94cca4870..15ee92081118 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/module.h>
@@ -14,10 +14,12 @@
 
 #define PCI_DEV_ID_EFA0_VF 0xefa0
 #define PCI_DEV_ID_EFA1_VF 0xefa1
+#define PCI_DEV_ID_EFA2_VF 0xefa2
 
 static const struct pci_device_id efa_pci_tbl[] = {
 	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA0_VF) },
 	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA1_VF) },
+	{ PCI_VDEVICE(AMAZON, PCI_DEV_ID_EFA2_VF) },
 	{ }
 };
 
-- 
2.37.1

