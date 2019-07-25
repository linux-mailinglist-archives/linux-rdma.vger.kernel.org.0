Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445E974EC6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2019 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfGYNEM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Jul 2019 09:04:12 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:44605 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGYNEJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 25 Jul 2019 09:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564059847; x=1595595847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UNStvRlkTIA4ZnUe76/M5w+nHEHZbkWI8oIu60s9JlM=;
  b=CHB9yo/K1L6zYQ+LbGat4vm046XpWch5s0cKNZV2gWZBx1pDqueA4FB9
   D0k1//5Vy0yfHYahbgszTws1UkBgFCGjWZMYklkxvM2N036/Ax4ERnOb4
   A1t9K9rezOIug31TifB1W5lOmMpuShdqgcdBIX3/MHztgIB74qeLmJkBD
   8=;
X-IronPort-AV: E=Sophos;i="5.64,306,1559520000"; 
   d="scan'208";a="412367993"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-62350142.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 25 Jul 2019 13:04:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-62350142.us-east-1.amazon.com (Postfix) with ESMTPS id 60BC3A2A1D;
        Thu, 25 Jul 2019 13:04:05 +0000 (UTC)
Received: from EX13D19EUA001.ant.amazon.com (10.43.165.74) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 25 Jul 2019 13:04:04 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D19EUA001.ant.amazon.com (10.43.165.74) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 25 Jul 2019 13:04:03 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.134) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 25 Jul 2019 13:04:01 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-rdma@vger.kernel.org>, Gal Pressman <galpress@amazon.com>,
        "Firas JahJah" <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH for-next v2] RDMA/efa: Expose device statistics
Date:   Thu, 25 Jul 2019 16:03:53 +0300
Message-ID: <20190725130353.11544-1-galpress@amazon.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Expose hardware statistics through the sysfs api:
/sys/class/infiniband/efa_0/hw_counters/*.
/sys/class/infiniband/efa_0/ports/1/hw_counters/*.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
This patch should be merged after:
https://patchwork.kernel.org/patch/11053949/

To prevent null dereference.

Changelog:
* Remove the 'if (port_num)' check from efa_alloc_hw_stats
---
 drivers/infiniband/hw/efa/efa.h         |  3 +
 drivers/infiniband/hw/efa/efa_com_cmd.c | 35 ++++++++++++
 drivers/infiniband/hw/efa/efa_com_cmd.h | 23 ++++++++
 drivers/infiniband/hw/efa/efa_main.c    |  2 +
 drivers/infiniband/hw/efa/efa_verbs.c   | 75 +++++++++++++++++++++++++
 5 files changed, 138 insertions(+)

diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
index 119f8efec564..2283e432693e 100644
--- a/drivers/infiniband/hw/efa/efa.h
+++ b/drivers/infiniband/hw/efa/efa.h
@@ -156,5 +156,8 @@ int efa_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *qp_attr,
 		  int qp_attr_mask, struct ib_udata *udata);
 enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
 					 u8 port_num);
+struct rdma_hw_stats *efa_alloc_hw_stats(struct ib_device *ibdev, u8 port_num);
+int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+		     u8 port_num, int index);
 
 #endif /* _EFA_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index 62345d8abf3c..16b115df63e8 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -702,3 +702,38 @@ int efa_com_dealloc_uar(struct efa_com_dev *edev,
 
 	return 0;
 }
+
+int efa_com_get_stats(struct efa_com_dev *edev,
+		      struct efa_com_get_stats_params *params,
+		      union efa_com_get_stats_result *result)
+{
+	struct efa_com_admin_queue *aq = &edev->aq;
+	struct efa_admin_aq_get_stats_cmd cmd = {};
+	struct efa_admin_acq_get_stats_resp resp;
+	int err;
+
+	cmd.aq_common_descriptor.opcode = EFA_ADMIN_GET_STATS;
+	cmd.type = params->type;
+	cmd.scope = params->scope;
+	cmd.scope_modifier = params->scope_modifier;
+
+	err = efa_com_cmd_exec(aq,
+			       (struct efa_admin_aq_entry *)&cmd,
+			       sizeof(cmd),
+			       (struct efa_admin_acq_entry *)&resp,
+			       sizeof(resp));
+	if (err) {
+		ibdev_err(edev->efa_dev,
+			  "Failed to get stats type-%u scope-%u.%u [%d]\n",
+			  cmd.type, cmd.scope, cmd.scope_modifier, err);
+		return err;
+	}
+
+	result->basic_stats.tx_bytes = resp.basic_stats.tx_bytes;
+	result->basic_stats.tx_pkts = resp.basic_stats.tx_pkts;
+	result->basic_stats.rx_bytes = resp.basic_stats.rx_bytes;
+	result->basic_stats.rx_pkts = resp.basic_stats.rx_pkts;
+	result->basic_stats.rx_drops = resp.basic_stats.rx_drops;
+
+	return 0;
+}
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.h b/drivers/infiniband/hw/efa/efa_com_cmd.h
index a1174380462c..7f6c13052f49 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.h
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.h
@@ -225,6 +225,26 @@ struct efa_com_dealloc_uar_params {
 	u16 uarn;
 };
 
+struct efa_com_get_stats_params {
+	/* see enum efa_admin_get_stats_type */
+	u8 type;
+	/* see enum efa_admin_get_stats_scope */
+	u8 scope;
+	u16 scope_modifier;
+};
+
+struct efa_com_basic_stats {
+	u64 tx_bytes;
+	u64 tx_pkts;
+	u64 rx_bytes;
+	u64 rx_pkts;
+	u64 rx_drops;
+};
+
+union efa_com_get_stats_result {
+	struct efa_com_basic_stats basic_stats;
+};
+
 void efa_com_set_dma_addr(dma_addr_t addr, u32 *addr_high, u32 *addr_low);
 int efa_com_create_qp(struct efa_com_dev *edev,
 		      struct efa_com_create_qp_params *params,
@@ -266,5 +286,8 @@ int efa_com_alloc_uar(struct efa_com_dev *edev,
 		      struct efa_com_alloc_uar_result *result);
 int efa_com_dealloc_uar(struct efa_com_dev *edev,
 			struct efa_com_dealloc_uar_params *params);
+int efa_com_get_stats(struct efa_com_dev *edev,
+		      struct efa_com_get_stats_params *params,
+		      union efa_com_get_stats_result *result);
 
 #endif /* _EFA_COM_CMD_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
index dd1c6d49466f..83858f7e83d0 100644
--- a/drivers/infiniband/hw/efa/efa_main.c
+++ b/drivers/infiniband/hw/efa/efa_main.c
@@ -201,6 +201,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.driver_id = RDMA_DRIVER_EFA,
 	.uverbs_abi_ver = EFA_UVERBS_ABI_VERSION,
 
+	.alloc_hw_stats = efa_alloc_hw_stats,
 	.alloc_pd = efa_alloc_pd,
 	.alloc_ucontext = efa_alloc_ucontext,
 	.create_ah = efa_create_ah,
@@ -212,6 +213,7 @@ static const struct ib_device_ops efa_dev_ops = {
 	.destroy_ah = efa_destroy_ah,
 	.destroy_cq = efa_destroy_cq,
 	.destroy_qp = efa_destroy_qp,
+	.get_hw_stats = efa_get_hw_stats,
 	.get_link_layer = efa_port_link_layer,
 	.get_port_immutable = efa_get_port_immutable,
 	.mmap = efa_mmap,
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
index df77bc312a25..32d3b3deabce 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -41,6 +41,33 @@ static inline u64 get_mmap_key(const struct efa_mmap_entry *efa)
 	       ((u64)efa->mmap_page << PAGE_SHIFT);
 }
 
+#define EFA_DEFINE_STATS(op) \
+	op(EFA_TX_BYTES, "tx_bytes") \
+	op(EFA_TX_PKTS, "tx_pkts") \
+	op(EFA_RX_BYTES, "rx_bytes") \
+	op(EFA_RX_PKTS, "rx_pkts") \
+	op(EFA_RX_DROPS, "rx_drops") \
+	op(EFA_SUBMITTED_CMDS, "submitted_cmds") \
+	op(EFA_COMPLETED_CMDS, "completed_cmds") \
+	op(EFA_NO_COMPLETION_CMDS, "no_completion_cmds") \
+	op(EFA_KEEP_ALIVE_RCVD, "keep_alive_rcvd") \
+	op(EFA_ALLOC_PD_ERR, "alloc_pd_err") \
+	op(EFA_CREATE_QP_ERR, "create_qp_err") \
+	op(EFA_REG_MR_ERR, "reg_mr_err") \
+	op(EFA_ALLOC_UCONTEXT_ERR, "alloc_ucontext_err") \
+	op(EFA_CREATE_AH_ERR, "create_ah_err")
+
+#define EFA_STATS_ENUM(ename, name) ename,
+#define EFA_STATS_STR(ename, name) [ename] = name,
+
+enum efa_hw_stats {
+	EFA_DEFINE_STATS(EFA_STATS_ENUM)
+};
+
+static const char *const efa_stats_names[] = {
+	EFA_DEFINE_STATS(EFA_STATS_STR)
+};
+
 #define EFA_CHUNK_PAYLOAD_SHIFT       12
 #define EFA_CHUNK_PAYLOAD_SIZE        BIT(EFA_CHUNK_PAYLOAD_SHIFT)
 #define EFA_CHUNK_PAYLOAD_PTR_SIZE    8
@@ -1727,6 +1754,54 @@ void efa_destroy_ah(struct ib_ah *ibah, u32 flags)
 	efa_ah_destroy(dev, ah);
 }
 
+struct rdma_hw_stats *efa_alloc_hw_stats(struct ib_device *ibdev, u8 port_num)
+{
+	return rdma_alloc_hw_stats_struct(efa_stats_names,
+					  ARRAY_SIZE(efa_stats_names),
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+int efa_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+		     u8 port_num, int index)
+{
+	struct efa_com_get_stats_params params = {};
+	union efa_com_get_stats_result result;
+	struct efa_dev *dev = to_edev(ibdev);
+	struct efa_com_basic_stats *bs;
+	struct efa_com_stats_admin *as;
+	struct efa_stats *s;
+	int err;
+
+	params.type = EFA_ADMIN_GET_STATS_TYPE_BASIC;
+	params.scope = EFA_ADMIN_GET_STATS_SCOPE_ALL;
+
+	err = efa_com_get_stats(&dev->edev, &params, &result);
+	if (err)
+		return err;
+
+	bs = &result.basic_stats;
+	stats->value[EFA_TX_BYTES] = bs->tx_bytes;
+	stats->value[EFA_TX_PKTS] = bs->tx_pkts;
+	stats->value[EFA_RX_BYTES] = bs->rx_bytes;
+	stats->value[EFA_RX_PKTS] = bs->rx_pkts;
+	stats->value[EFA_RX_DROPS] = bs->rx_drops;
+
+	as = &dev->edev.aq.stats;
+	stats->value[EFA_SUBMITTED_CMDS] = atomic64_read(&as->submitted_cmd);
+	stats->value[EFA_COMPLETED_CMDS] = atomic64_read(&as->completed_cmd);
+	stats->value[EFA_NO_COMPLETION_CMDS] = atomic64_read(&as->no_completion);
+
+	s = &dev->stats;
+	stats->value[EFA_KEEP_ALIVE_RCVD] = atomic64_read(&s->keep_alive_rcvd);
+	stats->value[EFA_ALLOC_PD_ERR] = atomic64_read(&s->sw_stats.alloc_pd_err);
+	stats->value[EFA_CREATE_QP_ERR] = atomic64_read(&s->sw_stats.create_qp_err);
+	stats->value[EFA_REG_MR_ERR] = atomic64_read(&s->sw_stats.reg_mr_err);
+	stats->value[EFA_ALLOC_UCONTEXT_ERR] = atomic64_read(&s->sw_stats.alloc_ucontext_err);
+	stats->value[EFA_CREATE_AH_ERR] = atomic64_read(&s->sw_stats.create_ah_err);
+
+	return ARRAY_SIZE(efa_stats_names);
+}
+
 enum rdma_link_layer efa_port_link_layer(struct ib_device *ibdev,
 					 u8 port_num)
 {
-- 
2.22.0

