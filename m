Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456F958DAF0
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Aug 2022 17:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbiHIPS5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 Aug 2022 11:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbiHIPS4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 Aug 2022 11:18:56 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BD210549
        for <linux-rdma@vger.kernel.org>; Tue,  9 Aug 2022 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1660058336; x=1691594336;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Q4XFajfhr3WAmS725ESwEq8Gv52Hhz781mynH1Sus6s=;
  b=kaQDJkFjjtmlF0Q25uWAfCcLae4axWbVjHKsHeOWXrmSYv/kYlDKGsSK
   v37smNSx1JYXKJiPhq+5Jx+VplCcJ4qQbtVQ2n65TzFf0y3dBQJBOfD1w
   m1YCEXFo97Zya43u9H92xJz0oXJHhnSI1+YWCZwILMtdzLIgopNVDdwpv
   w=;
X-IronPort-AV: E=Sophos;i="5.93,224,1654560000"; 
   d="scan'208";a="247022591"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 15:17:09 +0000
Received: from EX13D09EUC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-92ba9394.us-west-2.amazon.com (Postfix) with ESMTPS id 7862944A92;
        Tue,  9 Aug 2022 15:17:08 +0000 (UTC)
Received: from HFA15-G2116K32.ant.amazon.com (10.43.160.120) by
 EX13D09EUC002.ant.amazon.com (10.43.164.73) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Tue, 9 Aug 2022 15:17:04 +0000
From:   Michael Margolin <mrgolin@amazon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Firas Jahjah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>
Subject: [PATCH for-next] RDMA/efa: Support CQ receive entries with source GID
Date:   Tue, 9 Aug 2022 18:16:36 +0300
Message-ID: <20220809151636.788-1-mrgolin@amazon.com>
X-Mailer: git-send-email 2.30.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.43.160.120]
X-ClientProxiedBy: EX13P01UWA003.ant.amazon.com (10.43.160.197) To
 EX13D09EUC002.ant.amazon.com (10.43.164.73)
X-Spam-Status: No, score=-15.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a parameter for create CQ admin command to set source address on
receive completion descriptors. Report capability for this feature
through query device verb.

Reviewed-by: Firas Jahjah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Signed-off-by: Michael Margolin <mrgolin@amazon.com>
---
 drivers/infiniband/hw/efa/efa_admin_cmds_defs.h | 6 +++++-
 drivers/infiniband/hw/efa/efa_com_cmd.c         | 5 ++++-
 drivers/infiniband/hw/efa/efa_com_cmd.h         | 1 +
 drivers/infiniband/hw/efa/efa_verbs.c           | 4 +++-
 include/uapi/rdma/efa-abi.h                     | 4 +++-
 5 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 0b0b93b529f3..d4b9226088bd 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -444,7 +444,10 @@ struct efa_admin_create_cq_cmd {
 	/*
 	 * 4:0 : cq_entry_size_words - size of CQ entry in
 	 *    32-bit words, valid values: 4, 8.
-	 * 7:5 : reserved7 - MBZ
+	 * 5 : set_src_addr - If set, source address will be
+	 *    filled on RX completions from unknown senders.
+	 *    Requires 8 words CQ entry size.
+	 * 7:6 : reserved7 - MBZ
 	 */
 	u8 cq_caps_2;
 
@@ -980,6 +983,7 @@ struct efa_admin_host_info {
 #define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_MASK BIT(5)
 #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
 #define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
+#define EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR_MASK           BIT(5)
 
 /* create_cq_resp */
 #define EFA_ADMIN_CREATE_CQ_RESP_DB_VALID_MASK              BIT(0)
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index fb405da4e1db..8f8885e002ba 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -168,7 +168,10 @@ int efa_com_create_cq(struct efa_com_dev *edev,
 			EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED, 1);
 		create_cmd.eqn = params->eqn;
 	}
-
+	if (params->set_src_addr) {
+		EFA_SET(&create_cmd.cq_caps_2,
+			EFA_ADMIN_CREATE_CQ_CMD_SET_SRC_ADDR, 1);
+	}
 	efa_com_set_dma_addr(params->dma_addr,
 			     &create_cmd.cq_ba.mem_addr_high,
 			     &create_cmd.cq_ba.mem_addr_low);
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index c33010bbf9e8..c6234336543d 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -76,6 +76,7 @@ struct efa_com_create_cq_params {
 	u16 eqn;
 	u8 entry_size_in_bytes;
 	bool interrupt_mode_enabled;
+	bool set_src_addr;
 };
 
 struct efa_com_create_cq_result {
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index ecfe70eb5efb..c06669ca9e1f 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include <linux/dma-buf.h>
@@ -242,6 +242,7 @@ int efa_query_device(struct ib_device *ibdev,
 		resp.max_rq_wr = dev_attr->max_rq_depth;
 		resp.max_rdma_size = dev_attr->max_rdma_size;
 
+		resp.device_caps |= EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID;
 		if (EFA_DEV_CAP(dev, RDMA_READ))
 			resp.device_caps |= EFA_QUERY_DEVICE_CAPS_RDMA_READ;
 
@@ -1138,6 +1139,7 @@ int efa_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 	params.dma_addr = cq->dma_addr;
 	params.entry_size_in_bytes = cmd.cq_entry_size;
 	params.num_sub_cqs = cmd.num_sub_cqs;
+	params.set_src_addr = !!(cmd.flags & EFA_CREATE_CQ_WITH_SGID);
 	if (cmd.flags & EFA_CREATE_CQ_WITH_COMPLETION_CHANNEL) {
 		cq->eq = efa_vec2eq(dev, attr->comp_vector);
 		params.eqn = cq->eq->eeq.eqn;
diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
index 08035ccf1fff..163ac79556d6 100644
--- a/include/uapi/rdma/efa-abi.h
+++ b/include/uapi/rdma/efa-abi.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-2-Clause) */
 /*
- * Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2022 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef EFA_ABI_USER_H
@@ -54,6 +54,7 @@ struct efa_ibv_alloc_pd_resp {
 
 enum {
 	EFA_CREATE_CQ_WITH_COMPLETION_CHANNEL = 1 << 0,
+	EFA_CREATE_CQ_WITH_SGID               = 1 << 1,
 };
 
 struct efa_ibv_create_cq {
@@ -118,6 +119,7 @@ enum {
 	EFA_QUERY_DEVICE_CAPS_RDMA_READ = 1 << 0,
 	EFA_QUERY_DEVICE_CAPS_RNR_RETRY = 1 << 1,
 	EFA_QUERY_DEVICE_CAPS_CQ_NOTIFICATIONS = 1 << 2,
+	EFA_QUERY_DEVICE_CAPS_CQ_WITH_SGID     = 1 << 3,
 };
 
 struct efa_ibv_ex_query_device_resp {
-- 
2.34.1

