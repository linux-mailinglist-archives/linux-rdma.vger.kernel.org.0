Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B8760F42B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 11:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiJ0J6n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 05:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiJ0J6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 05:58:11 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1899A283
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 02:57:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VTB5LcB_1666864664;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VTB5LcB_1666864664)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 17:57:45 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 2/3] RDMA/erdma: Report atomic capacity when hardware supports atomic feature
Date:   Thu, 27 Oct 2022 17:57:40 +0800
Message-Id: <20221027095741.48044-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20221027095741.48044-1-chengyou@linux.alibaba.com>
References: <20221027095741.48044-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Introduce "capacity flags" field at where hardware put all zeros originally
in "query device" response. Using this field, hardware can report atomic
feature if supports.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h       | 1 +
 drivers/infiniband/hw/erdma/erdma_hw.h    | 5 +++++
 drivers/infiniband/hw/erdma/erdma_main.c  | 1 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 4 ++++
 4 files changed, 11 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index 730783fbc894..bb23d897c710 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -124,6 +124,7 @@ struct erdma_devattr {
 	u32 fw_version;
 
 	unsigned char peer_addr[ETH_ALEN];
+	unsigned long cap_flags;
 
 	int numa_node;
 	enum erdma_cc_alg cc;
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 2a9a4c73d52c..808e7ee56d93 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -303,6 +303,7 @@ struct erdma_cmdq_destroy_qp_req {
 
 /* cap qword 0 definition */
 #define ERDMA_CMD_DEV_CAP_MAX_CQE_MASK GENMASK_ULL(47, 40)
+#define ERDMA_CMD_DEV_CAP_FLAGS_MASK GENMASK_ULL(31, 24)
 #define ERDMA_CMD_DEV_CAP_MAX_RECV_WR_MASK GENMASK_ULL(23, 16)
 #define ERDMA_CMD_DEV_CAP_MAX_MR_SIZE_MASK GENMASK_ULL(7, 0)
 
@@ -314,6 +315,10 @@ struct erdma_cmdq_destroy_qp_req {
 
 #define ERDMA_NQP_PER_QBLOCK 1024
 
+enum {
+	ERDMA_DEV_CAP_FLAGS_ATOMIC = 1 << 7,
+};
+
 #define ERDMA_CMD_INFO0_FW_VER_MASK GENMASK_ULL(31, 0)
 
 /* CQE hdr */
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 49778bb294ae..e44b06fea595 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -374,6 +374,7 @@ static int erdma_dev_attrs_init(struct erdma_dev *dev)
 	dev->attrs.max_qp = ERDMA_NQP_PER_QBLOCK * ERDMA_GET_CAP(QBLOCK, cap1);
 	dev->attrs.max_mr = dev->attrs.max_qp << 1;
 	dev->attrs.max_cq = dev->attrs.max_qp << 1;
+	dev->attrs.cap_flags = ERDMA_GET_CAP(FLAGS, cap0);
 
 	dev->attrs.max_send_wr = ERDMA_MAX_SEND_WR;
 	dev->attrs.max_ord = ERDMA_MAX_ORD;
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index f3bf87f17527..d843ce1f35f3 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -288,6 +288,10 @@ int erdma_query_device(struct ib_device *ibdev, struct ib_device_attr *attr,
 	attr->max_mw = dev->attrs.max_mw;
 	attr->max_fast_reg_page_list_len = ERDMA_MAX_FRMR_PA;
 	attr->page_size_cap = ERDMA_PAGE_SIZE_SUPPORT;
+
+	if (dev->attrs.cap_flags & ERDMA_DEV_CAP_FLAGS_ATOMIC)
+		attr->atomic_cap = IB_ATOMIC_GLOB;
+
 	attr->fw_ver = dev->attrs.fw_version;
 
 	if (dev->netdev)
-- 
2.27.0

