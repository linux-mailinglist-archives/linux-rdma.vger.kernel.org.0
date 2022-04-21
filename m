Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35085098BD
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 09:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385395AbiDUHUr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Apr 2022 03:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385482AbiDUHUp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Apr 2022 03:20:45 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F2167F5
        for <linux-rdma@vger.kernel.org>; Thu, 21 Apr 2022 00:17:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VAdZrqA_1650525473;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VAdZrqA_1650525473)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 15:17:54 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, dledford@redhat.com, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com,
        chengyou@linux.alibaba.com, tonylu@linux.alibaba.com,
        BMT@zurich.ibm.com
Subject: [PATCH for-next v7 04/12] RDMA/erdma: Add main include file
Date:   Thu, 21 Apr 2022 15:17:39 +0800
Message-Id: <20220421071747.1892-5-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220421071747.1892-1-chengyou@linux.alibaba.com>
References: <20220421071747.1892-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Add ERDMA driver main header file, defining internal used data structures
and operations. The defined data structures includes *cmdq*, which is used
as the communication channel between ERDMA driver and hardware.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h | 287 ++++++++++++++++++++++++++++
 1 file changed, 287 insertions(+)
 create mode 100644 drivers/infiniband/hw/erdma/erdma.h

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
new file mode 100644
index 000000000000..a75138f9e523
--- /dev/null
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+
+/* Authors: Cheng Xu <chengyou@linux.alibaba.com> */
+/*          Kai Shen <kaishen@linux.alibaba.com> */
+/* Copyright (c) 2020-2022, Alibaba Group. */
+
+#ifndef __ERDMA_H__
+#define __ERDMA_H__
+
+#include <linux/bitfield.h>
+#include <linux/netdevice.h>
+#include <linux/xarray.h>
+#include <rdma/ib_verbs.h>
+
+#include "erdma_hw.h"
+
+#define DRV_MODULE_NAME "erdma"
+#define ERDMA_NODE_DESC "Elastic RDMA(iWARP) stack"
+
+struct erdma_eq {
+	void *qbuf;
+	dma_addr_t qbuf_dma_addr;
+
+	spinlock_t lock;
+
+	u32 depth;
+
+	u16 ci;
+	u16 rsvd;
+
+	atomic64_t event_num;
+	atomic64_t notify_num;
+
+	u64 __iomem *db_addr;
+	u64 *db_record;
+};
+
+struct erdma_cmdq_sq {
+	void *qbuf;
+	dma_addr_t qbuf_dma_addr;
+
+	spinlock_t lock;
+
+	u32 depth;
+	u16 ci;
+	u16 pi;
+
+	u16 wqebb_cnt;
+
+	u64 *db_record;
+};
+
+struct erdma_cmdq_cq {
+	void *qbuf;
+	dma_addr_t qbuf_dma_addr;
+
+	spinlock_t lock;
+
+	u32 depth;
+	u32 ci;
+	u32 cmdsn;
+
+	u64 *db_record;
+
+	atomic64_t armed_num;
+};
+
+enum {
+	ERDMA_CMD_STATUS_INIT,
+	ERDMA_CMD_STATUS_ISSUED,
+	ERDMA_CMD_STATUS_FINISHED,
+	ERDMA_CMD_STATUS_TIMEOUT
+};
+
+struct erdma_comp_wait {
+	struct completion wait_event;
+	u32 cmd_status;
+	u32 ctx_id;
+	u16 sq_pi;
+	u8 comp_status;
+	u8 rsvd;
+	u32 comp_data[4];
+};
+
+enum {
+	ERDMA_CMDQ_STATE_OK_BIT = 0,
+	ERDMA_CMDQ_STATE_TIMEOUT_BIT = 1,
+	ERDMA_CMDQ_STATE_CTX_ERR_BIT = 2,
+};
+
+#define ERDMA_CMDQ_TIMEOUT_MS 15000
+#define ERDMA_REG_ACCESS_WAIT_MS 20
+#define ERDMA_WAIT_DEV_DONE_CNT 500
+
+struct erdma_cmdq {
+	unsigned long *comp_wait_bitmap;
+	struct erdma_comp_wait *wait_pool;
+	spinlock_t lock;
+
+	bool use_event;
+
+	struct erdma_cmdq_sq sq;
+	struct erdma_cmdq_cq cq;
+	struct erdma_eq eq;
+
+	unsigned long state;
+
+	struct semaphore credits;
+	u16 max_outstandings;
+};
+
+#define COMPROMISE_CC ERDMA_CC_CUBIC
+enum erdma_cc_alg {
+	ERDMA_CC_NEWRENO = 0,
+	ERDMA_CC_CUBIC,
+	ERDMA_CC_HPCC_RTT,
+	ERDMA_CC_HPCC_ECN,
+	ERDMA_CC_HPCC_INT,
+	ERDMA_CC_METHODS_NUM
+};
+
+struct erdma_devattr {
+	u32 fw_version;
+
+	unsigned char peer_addr[ETH_ALEN];
+
+	int numa_node;
+	enum erdma_cc_alg cc;
+	u32 grp_num;
+	u32 irq_num;
+
+	bool disable_dwqe;
+	u16 dwqe_pages;
+	u16 dwqe_entries;
+
+	u32 max_qp;
+	u32 max_send_wr;
+	u32 max_recv_wr;
+	u32 max_ord;
+	u32 max_ird;
+
+	u32 max_send_sge;
+	u32 max_recv_sge;
+	u32 max_sge_rd;
+	u32 max_cq;
+	u32 max_cqe;
+	u64 max_mr_size;
+	u32 max_mr;
+	u32 max_pd;
+	u32 max_mw;
+	u32 local_dma_key;
+};
+
+#define ERDMA_IRQNAME_SIZE 50
+
+struct erdma_irq {
+	char name[ERDMA_IRQNAME_SIZE];
+	u32 msix_vector;
+	cpumask_t affinity_hint_mask;
+};
+
+struct erdma_eq_cb {
+	bool ready;
+	void *dev; /* All EQs use this fields to get erdma_dev struct */
+	struct erdma_irq irq;
+	struct erdma_eq eq;
+	struct tasklet_struct tasklet;
+};
+
+struct erdma_resource_cb {
+	unsigned long *bitmap;
+	spinlock_t lock;
+	u32 next_alloc_idx;
+	u32 max_cap;
+};
+
+enum {
+	ERDMA_RES_TYPE_PD = 0,
+	ERDMA_RES_TYPE_STAG_IDX = 1,
+	ERDMA_RES_CNT = 2,
+};
+
+#define ERDMA_EXTRA_BUFFER_SIZE ERDMA_DB_SIZE
+#define WARPPED_BUFSIZE(size) ((size) + ERDMA_EXTRA_BUFFER_SIZE)
+
+struct erdma_dev {
+	struct ib_device ibdev;
+	struct net_device *netdev;
+	struct pci_dev *pdev;
+	struct notifier_block netdev_nb;
+
+	resource_size_t func_bar_addr;
+	resource_size_t func_bar_len;
+	u8 __iomem *func_bar;
+
+	struct erdma_devattr attrs;
+	/* physical port state (only one port per device) */
+	enum ib_port_state state;
+
+	/* cmdq and aeq use the same msix vector */
+	struct erdma_irq comm_irq;
+	struct erdma_cmdq cmdq;
+	struct erdma_eq aeq;
+	struct erdma_eq_cb ceqs[ERDMA_NUM_MSIX_VEC - 1];
+
+	spinlock_t lock;
+	struct erdma_resource_cb res_cb[ERDMA_RES_CNT];
+	struct xarray qp_xa;
+	struct xarray cq_xa;
+
+	u32 next_alloc_qpn;
+	u32 next_alloc_cqn;
+
+	spinlock_t db_bitmap_lock;
+	/* We provide max 64 uContexts that each has one SQ doorbell Page. */
+	DECLARE_BITMAP(sdb_page, ERDMA_DWQE_TYPE0_CNT);
+	/*
+	 * We provide max 496 uContexts that each has one SQ normal Db,
+	 * and one directWQE db。
+	 */
+	DECLARE_BITMAP(sdb_entry, ERDMA_DWQE_TYPE1_CNT);
+
+	atomic_t num_ctx;
+	struct list_head cep_list;
+};
+
+static inline void *get_queue_entry(void *qbuf, u32 idx, u32 depth, u32 shift)
+{
+	idx &= (depth - 1);
+
+	return qbuf + (idx << shift);
+}
+
+static inline struct erdma_dev *to_edev(struct ib_device *ibdev)
+{
+	return container_of(ibdev, struct erdma_dev, ibdev);
+}
+
+static inline u32 erdma_reg_read32(struct erdma_dev *dev, u32 reg)
+{
+	return readl(dev->func_bar + reg);
+}
+
+static inline u64 erdma_reg_read64(struct erdma_dev *dev, u32 reg)
+{
+	return readq(dev->func_bar + reg);
+}
+
+static inline void erdma_reg_write32(struct erdma_dev *dev, u32 reg, u32 value)
+{
+	writel(value, dev->func_bar + reg);
+}
+
+static inline void erdma_reg_write64(struct erdma_dev *dev, u32 reg, u64 value)
+{
+	writeq(value, dev->func_bar + reg);
+}
+
+static inline u32 erdma_reg_read32_filed(struct erdma_dev *dev, u32 reg,
+					 u32 filed_mask)
+{
+	u32 val = erdma_reg_read32(dev, reg);
+
+	return FIELD_GET(filed_mask, val);
+}
+
+int erdma_cmdq_init(struct erdma_dev *dev);
+void erdma_finish_cmdq_init(struct erdma_dev *dev);
+void erdma_cmdq_destroy(struct erdma_dev *dev);
+
+void erdma_cmdq_build_reqhdr(u64 *hdr, u32 mod, u32 op);
+int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, u64 *req, u32 req_size,
+			u64 *resp0, u64 *resp1);
+void erdma_cmdq_completion_handler(struct erdma_cmdq *cmdq);
+
+int erdma_ceqs_init(struct erdma_dev *dev);
+void erdma_ceqs_uninit(struct erdma_dev *dev);
+void notify_eq(struct erdma_eq *eq);
+void *get_next_valid_eqe(struct erdma_eq *eq);
+
+int erdma_aeq_init(struct erdma_dev *dev);
+void erdma_aeq_destroy(struct erdma_dev *dev);
+
+void erdma_aeq_event_handler(struct erdma_dev *dev);
+void erdma_ceq_completion_handler(struct erdma_eq_cb *ceq_cb);
+
+#endif
-- 
2.27.0

