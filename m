Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A83969BF1B
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Feb 2023 09:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBSI0q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Feb 2023 03:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBSI0p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Feb 2023 03:26:45 -0500
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE23C14A
        for <linux-rdma@vger.kernel.org>; Sun, 19 Feb 2023 00:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1676795205; x=1708331205;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7eKLWWqmDpRqnFJvqcgevRXZah45GDItwQkyYxXAnhI=;
  b=s7EFmukxsZNVp0xX5H8gJTsNC5QUg8StP0B2AravSaKSZzmLJzcv9B9x
   SFUYZ8z2paHWFXFMmaLzmNSry3zOFSylxdEfTNXOzlV6b+Xoymo2df9Rx
   oen1sC/GMmmEv+PC7kEw2RNuwV+WOrYbLBvgcCeT9IC/Ge/sI/k00yxrJ
   w=;
X-IronPort-AV: E=Sophos;i="5.97,309,1669075200"; 
   d="scan'208";a="312650970"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 08:13:33 +0000
Received: from EX19D002EUC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-3554bfcf.us-east-1.amazon.com (Postfix) with ESMTPS id C918D81C9C;
        Sun, 19 Feb 2023 08:13:31 +0000 (UTC)
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX19D002EUC001.ant.amazon.com (10.252.51.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.24; Sun, 19 Feb 2023 08:13:30 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.45 via Frontend Transport; Sun, 19 Feb 2023 08:13:28
 +0000
From:   Michael Margolin <mrgolin@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <sleybo@amazon.com>, <matua@amazon.com>, <ynachum@amazon.com>,
        Yehuda Yitschak <yehuday@amazon.com>
Subject: [PATCH] RDMA/efa: Add data polling capability feature bit
Date:   Sun, 19 Feb 2023 08:13:28 +0000
Message-ID: <20230219081328.10419-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yonatan Nachum <ynachum@amazon.com>

Add feature bit to existing device caps field. EFA supports data polling
of 128 bytes blocks.

Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Yonatan Nachum <ynachum@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 7 +++++--
 drivers/infiniband/hw/efa/efa_verbs.c           | 5 ++++-
 include/uapi/rdma/efa-abi.h                     | 3 ++-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index d4b9226088bd..3db791e6c030 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_ADMIN_CMDS_H_
@@ -618,7 +618,9 @@ struct efa_admin_feature_device_attr_desc {
 	 *    TX queues
 	 * 1 : rnr_retry - If set, RNR retry is supported on
 	 *    modify QP command
-	 * 31:2 : reserved - MBZ
+	 * 2 : data_polling_128 - If set, 128 bytes data
+	 *    polling is supported
+	 * 31:3 : reserved - MBZ
 	 */
 	u32 device_caps;
 
@@ -991,6 +993,7 @@ struct efa_admin_host_info {
 /* feature_device_attr_desc */
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RNR_RETRY_MASK   BIT(1)
+#define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_DATA_POLLING_128_MASK BIT(2)
 
 /* create_eq_cmd */
 #define EFA_ADMIN_CREATE_EQ_CMD_ENTRY_SIZE_WORDS_MASK       GENMASK(4, 0)
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index 31454643f8c5..c20136e9d3d1 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright 2018-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/dma-buf.h>
@@ -250,6 +250,9 @@ int efa_query_device(struct ib_device *ibdev,
 		if (EFA_DEV_CAP(dev, RNR_RETRY))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RNR_RETRY;
 
+		if (EFA_DEV_CAP(dev, DATA_POLLING_128))
+			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128;
+
 		if (dev->neqs)
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS;
 
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 163ac79556d6..74406b4817ce 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
- * Copyright 2018-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2023 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef EFA_ABI_USER_H
@@ -120,6 +120,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_RNR_RETRY = 1 << 1,
 	EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
 	EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
+	EFA_QUERY_DEVICE_CAPS_DATA_POLLING_128 = 1 << 4,
 };
 
 struct efa_ibv_ex_query_device_resp {
-- 
2.39.1

