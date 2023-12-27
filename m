Return-Path: <linux-rdma+bounces-502-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD23B81ED6B
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Dec 2023 09:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856F7283087
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Dec 2023 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB8E63AA;
	Wed, 27 Dec 2023 08:48:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114C5613C
	for <linux-rdma@vger.kernel.org>; Wed, 27 Dec 2023 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VzKgoOi_1703666883;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VzKgoOi_1703666883)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 16:48:03 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next v3 2/2] RDMA/erdma: Add hardware statistics support
Date: Wed, 27 Dec 2023 16:48:00 +0800
Message-Id: <20231227084800.99091-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231227084800.99091-1-chengyou@linux.alibaba.com>
References: <20231227084800.99091-1-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, we add a new command to query hardware statistics, and then
implement two functions: ib_device_ops.alloc_hw_port_stats and
ib_device_ops.get_hw_stats to allow rdma tool can get the statistics
of erdma device.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    | 37 ++++++++++
 drivers/infiniband/hw/erdma/erdma_main.c  |  2 +
 drivers/infiniband/hw/erdma/erdma_verbs.c | 90 +++++++++++++++++++++++
 drivers/infiniband/hw/erdma/erdma_verbs.h |  4 +
 4 files changed, 133 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 4baabf1f2b08..ed8e3940cf4c 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -146,6 +146,7 @@ enum CMDQ_COMMON_OPCODE {
 	CMDQ_OPCODE_DESTROY_EQ = 1,
 	CMDQ_OPCODE_QUERY_FW_INFO = 2,
 	CMDQ_OPCODE_CONF_MTU = 3,
+	CMDQ_OPCODE_GET_STATS = 4,
 	CMDQ_OPCODE_CONF_DEVICE = 5,
 	CMDQ_OPCODE_ALLOC_DB = 8,
 	CMDQ_OPCODE_FREE_DB = 9,
@@ -359,6 +360,42 @@ struct erdma_cmdq_reflush_req {
 
 #define ERDMA_HW_RESP_SIZE 256
 
+struct erdma_cmdq_query_req {
+	u64 hdr;
+	u32 rsvd;
+	u32 index;
+
+	u64 target_addr;
+	u32 target_length;
+};
+
+#define ERDMA_HW_RESP_MAGIC 0x5566
+
+struct erdma_cmdq_query_resp_hdr {
+	u16 magic;
+	u8 ver;
+	u8 length;
+
+	u32 index;
+	u32 rsvd[2];
+};
+
+struct erdma_cmdq_query_stats_resp {
+	struct erdma_cmdq_query_resp_hdr hdr;
+
+	u64 tx_req_cnt;
+	u64 tx_packets_cnt;
+	u64 tx_bytes_cnt;
+	u64 tx_drop_packets_cnt;
+	u64 tx_bps_meter_drop_packets_cnt;
+	u64 tx_pps_meter_drop_packets_cnt;
+	u64 rx_packets_cnt;
+	u64 rx_bytes_cnt;
+	u64 rx_drop_packets_cnt;
+	u64 rx_bps_meter_drop_packets_cnt;
+	u64 rx_pps_meter_drop_packets_cnt;
+};
+
 /* cap qword 0 definition */
 #define ERDMA_CMD_DEV_CAP_MAX_CQE_MASK GENMASK_ULL(47, 40)
 #define ERDMA_CMD_DEV_CAP_FLAGS_MASK GENMASK_ULL(31, 24)
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index e4df5bf89cd0..472939172f0c 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -468,6 +468,7 @@ static const struct ib_device_ops erdma_device_ops = {
 	.driver_id = RDMA_DRIVER_ERDMA,
 	.uverbs_abi_ver = ERDMA_ABI_VERSION,
 
+	.alloc_hw_port_stats = erdma_alloc_hw_port_stats,
 	.alloc_mr = erdma_ib_alloc_mr,
 	.alloc_pd = erdma_alloc_pd,
 	.alloc_ucontext = erdma_alloc_ucontext,
@@ -479,6 +480,7 @@ static const struct ib_device_ops erdma_device_ops = {
 	.destroy_cq = erdma_destroy_cq,
 	.destroy_qp = erdma_destroy_qp,
 	.get_dma_mr = erdma_get_dma_mr,
+	.get_hw_stats = erdma_get_hw_stats,
 	.get_port_immutable = erdma_get_port_immutable,
 	.iw_accept = erdma_accept,
 	.iw_add_ref = erdma_qp_get_ref,
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index c317947563fb..23dfc01603f8 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1708,3 +1708,93 @@ void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason)
 
 	ib_dispatch_event(&event);
 }
+
+enum counters {
+	ERDMA_STATS_TX_REQS_CNT,
+	ERDMA_STATS_TX_PACKETS_CNT,
+	ERDMA_STATS_TX_BYTES_CNT,
+	ERDMA_STATS_TX_DISABLE_DROP_CNT,
+	ERDMA_STATS_TX_BPS_METER_DROP_CNT,
+	ERDMA_STATS_TX_PPS_METER_DROP_CNT,
+
+	ERDMA_STATS_RX_PACKETS_CNT,
+	ERDMA_STATS_RX_BYTES_CNT,
+	ERDMA_STATS_RX_DISABLE_DROP_CNT,
+	ERDMA_STATS_RX_BPS_METER_DROP_CNT,
+	ERDMA_STATS_RX_PPS_METER_DROP_CNT,
+
+	ERDMA_STATS_MAX
+};
+
+static const struct rdma_stat_desc erdma_descs[] = {
+	[ERDMA_STATS_TX_REQS_CNT].name = "tx_reqs_cnt",
+	[ERDMA_STATS_TX_PACKETS_CNT].name = "tx_packets_cnt",
+	[ERDMA_STATS_TX_BYTES_CNT].name = "tx_bytes_cnt",
+	[ERDMA_STATS_TX_DISABLE_DROP_CNT].name = "tx_disable_drop_cnt",
+	[ERDMA_STATS_TX_BPS_METER_DROP_CNT].name = "tx_bps_limit_drop_cnt",
+	[ERDMA_STATS_TX_PPS_METER_DROP_CNT].name = "tx_pps_limit_drop_cnt",
+	[ERDMA_STATS_RX_PACKETS_CNT].name = "rx_packets_cnt",
+	[ERDMA_STATS_RX_BYTES_CNT].name = "rx_bytes_cnt",
+	[ERDMA_STATS_RX_DISABLE_DROP_CNT].name = "rx_disable_drop_cnt",
+	[ERDMA_STATS_RX_BPS_METER_DROP_CNT].name = "rx_bps_limit_drop_cnt",
+	[ERDMA_STATS_RX_PPS_METER_DROP_CNT].name = "rx_pps_limit_drop_cnt",
+};
+
+struct rdma_hw_stats *erdma_alloc_hw_port_stats(struct ib_device *device,
+						u32 port_num)
+{
+	return rdma_alloc_hw_stats_struct(erdma_descs, ERDMA_STATS_MAX,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static int erdma_query_hw_stats(struct erdma_dev *dev,
+				struct rdma_hw_stats *stats)
+{
+	struct erdma_cmdq_query_stats_resp *resp;
+	struct erdma_cmdq_query_req req;
+	dma_addr_t dma_addr;
+	int err;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
+				CMDQ_OPCODE_GET_STATS);
+
+	resp = dma_pool_zalloc(dev->resp_pool, GFP_KERNEL, &dma_addr);
+	if (!resp)
+		return -ENOMEM;
+
+	req.target_addr = dma_addr;
+	req.target_length = ERDMA_HW_RESP_SIZE;
+
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	if (err)
+		goto out;
+
+	if (resp->hdr.magic != ERDMA_HW_RESP_MAGIC) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	memcpy(&stats->value[0], &resp->tx_req_cnt,
+	       sizeof(u64) * stats->num_counters);
+
+out:
+	dma_pool_free(dev->resp_pool, resp, dma_addr);
+
+	return err;
+}
+
+int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+		       u32 port, int index)
+{
+	struct erdma_dev *dev = to_edev(ibdev);
+	int ret;
+
+	if (port == 0)
+		return 0;
+
+	ret = erdma_query_hw_stats(dev, stats);
+	if (ret)
+		return ret;
+
+	return stats->num_counters;
+}
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index eb9c0f92fb6f..db6018529ccc 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -361,5 +361,9 @@ int erdma_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 		    unsigned int *sg_offset);
 void erdma_port_event(struct erdma_dev *dev, enum ib_event_type reason);
 void erdma_set_mtu(struct erdma_dev *dev, u32 mtu);
+struct rdma_hw_stats *erdma_alloc_hw_port_stats(struct ib_device *device,
+						u32 port_num);
+int erdma_get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+		       u32 port, int index);
 
 #endif
-- 
2.31.1


