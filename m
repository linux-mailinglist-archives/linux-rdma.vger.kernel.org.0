Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6187236F6
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 07:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjFFFua (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 01:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjFFFuT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 01:50:19 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6617E6A
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 22:50:12 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkV2uPa_1686030608;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VkV2uPa_1686030608)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 13:50:09 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 1/4] RDMA/erdma: Configure PAGE_SIZE to hardware
Date:   Tue,  6 Jun 2023 13:50:02 +0800
Message-Id: <20230606055005.80729-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230606055005.80729-1-chengyou@linux.alibaba.com>
References: <20230606055005.80729-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add a new CMDQ message to configure hardware. Initially the page size (in
the format of shift) will be passed to hardware, so that hardware can
organize the mmio space properly. It's called only if hardware supports it.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h   | 12 ++++++++++++
 drivers/infiniband/hw/erdma/erdma_main.c | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 76ce2856be28..670796c22bcc 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -159,6 +159,7 @@ enum CMDQ_COMMON_OPCODE {
 	CMDQ_OPCODE_DESTROY_EQ = 1,
 	CMDQ_OPCODE_QUERY_FW_INFO = 2,
 	CMDQ_OPCODE_CONF_MTU = 3,
+	CMDQ_OPCODE_CONF_DEVICE = 5,
 };
 
 /* cmdq-SQE HDR */
@@ -196,6 +197,16 @@ struct erdma_cmdq_destroy_eq_req {
 	u8 qtype;
 };
 
+/* config device cfg */
+#define ERDMA_CMD_CONFIG_DEVICE_PS_EN_MASK BIT(31)
+#define ERDMA_CMD_CONFIG_DEVICE_PGSHIFT_MASK GENMASK(4, 0)
+
+struct erdma_cmdq_config_device_req {
+	u64 hdr;
+	u32 cfg;
+	u32 rsvd[5];
+};
+
 struct erdma_cmdq_config_mtu_req {
 	u64 hdr;
 	u32 mtu;
@@ -329,6 +340,7 @@ struct erdma_cmdq_reflush_req {
 
 enum {
 	ERDMA_DEV_CAP_FLAGS_ATOMIC = 1 << 7,
+	ERDMA_DEV_CAP_FLAGS_EXTEND_DB = 1 << 3,
 };
 
 #define ERDMA_CMD_INFO0_FW_VER_MASK GENMASK_ULL(31, 0)
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 7c74abeee864..525edea987b2 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -426,6 +426,22 @@ static int erdma_dev_attrs_init(struct erdma_dev *dev)
 	return err;
 }
 
+static int erdma_device_config(struct erdma_dev *dev)
+{
+	struct erdma_cmdq_config_device_req req = {};
+
+	if (!(dev->attrs.cap_flags & ERDMA_DEV_CAP_FLAGS_EXTEND_DB))
+		return 0;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
+				CMDQ_OPCODE_CONF_DEVICE);
+
+	req.cfg = FIELD_PREP(ERDMA_CMD_CONFIG_DEVICE_PGSHIFT_MASK, PAGE_SHIFT) |
+		  FIELD_PREP(ERDMA_CMD_CONFIG_DEVICE_PS_EN_MASK, 1);
+
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+}
+
 static int erdma_res_cb_init(struct erdma_dev *dev)
 {
 	int i, j;
@@ -512,6 +528,10 @@ static int erdma_ib_device_add(struct pci_dev *pdev)
 	if (ret)
 		return ret;
 
+	ret = erdma_device_config(dev);
+	if (ret)
+		return ret;
+
 	ibdev->node_type = RDMA_NODE_RNIC;
 	memcpy(ibdev->node_desc, ERDMA_NODE_DESC, sizeof(ERDMA_NODE_DESC));
 
-- 
2.31.1

