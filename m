Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A3977DD2F
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 11:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbjHPJV3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 05:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243291AbjHPJVE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 05:21:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901742684;
        Wed, 16 Aug 2023 02:21:01 -0700 (PDT)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQjJT70LQzrSMs;
        Wed, 16 Aug 2023 17:19:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:20:58 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Support hns SW stats
Date:   Wed, 16 Aug 2023 17:18:12 +0800
Message-ID: <20230816091812.2899366-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230816091812.2899366-1-huangjunxian6@hisilicon.com>
References: <20230816091812.2899366-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Chengchang Tang <tangchengchang@huawei.com>

Support query hns SW stats for rdma-tool to help debugging.

Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c     |  6 +-
 drivers/infiniband/hw/hns/hns_roce_cmd.c    | 19 ++++-
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 15 ++--
 drivers/infiniband/hw/hns/hns_roce_device.h | 22 +++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  8 ++
 drivers/infiniband/hw/hns/hns_roce_main.c   | 93 +++++++++++++++++----
 drivers/infiniband/hw/hns/hns_roce_mr.c     | 26 ++++--
 drivers/infiniband/hw/hns/hns_roce_pd.c     | 10 ++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     |  8 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c    |  6 +-
 10 files changed, 173 insertions(+), 40 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index e77fcc74f15c..12a6d92cd90e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -81,11 +81,15 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 		ret = rdma_read_gid_l2_fields(ah_attr->grh.sgid_attr,
 					      &ah->av.vlan_id, NULL);
 		if (ret)
-			return ret;
+			goto err_out;
 
 		ah->av.vlan_en = ah->av.vlan_id < VLAN_N_VID;
 	}
 
+err_out:
+	if (ret)
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_AH_CREATE_ERR_CNT]);
+
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 864413607571..873e8a69a1b9 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -41,7 +41,15 @@
 static int hns_roce_cmd_mbox_post_hw(struct hns_roce_dev *hr_dev,
 				     struct hns_roce_mbox_msg *mbox_msg)
 {
-	return hr_dev->hw->post_mbox(hr_dev, mbox_msg);
+	int ret;
+
+	ret = hr_dev->hw->post_mbox(hr_dev, mbox_msg);
+	if (ret)
+		return ret;
+
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MBX_POSTED_CNT]);
+
+	return 0;
 }
 
 /* this should be called with "poll_sem" */
@@ -58,7 +66,13 @@ static int __hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev,
 		return ret;
 	}
 
-	return hr_dev->hw->poll_mbox_done(hr_dev);
+	ret = hr_dev->hw->poll_mbox_done(hr_dev);
+	if (ret)
+		return ret;
+
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MBX_POLLED_CNT]);
+
+	return 0;
 }
 
 static int hns_roce_cmd_mbox_poll(struct hns_roce_dev *hr_dev,
@@ -89,6 +103,7 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 	context->result = (status == HNS_ROCE_CMD_SUCCESS) ? 0 : (-EIO);
 	context->out_param = out_param;
 	complete(&context->done);
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MBX_EVENT_CNT]);
 }
 
 static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 736dc2f993b4..4117e047fe97 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -361,31 +361,31 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	struct hns_roce_cq *hr_cq = to_hr_cq(ib_cq);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_ib_create_cq ucmd = {};
-	int ret;
+	int ret = -EOPNOTSUPP;
 
 	if (attr->flags)
-		return -EOPNOTSUPP;
+		goto err_out;
 
 	ret = verify_cq_create_attr(hr_dev, attr);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	if (udata) {
 		ret = get_cq_ucmd(hr_cq, udata, &ucmd);
 		if (ret)
-			return ret;
+			goto err_out;
 	}
 
 	set_cq_param(hr_cq, attr->cqe, attr->comp_vector, &ucmd);
 
 	ret = set_cqe_size(hr_cq, udata, &ucmd);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	ret = alloc_cq_buf(hr_dev, hr_cq, udata, ucmd.buf_addr);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc CQ buf, ret = %d.\n", ret);
-		return ret;
+		goto err_out;
 	}
 
 	ret = alloc_cq_db(hr_dev, hr_cq, udata, ucmd.db_addr, &resp);
@@ -430,6 +430,9 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	free_cq_db(hr_dev, hr_cq, udata);
 err_cq_buf:
 	free_cq_buf(hr_dev, hr_cq);
+err_out:
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CQ_CREATE_ERR_CNT]);
+
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 7f0d0288beb1..b5a12fc73e1a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -866,6 +866,27 @@ enum hns_roce_hw_pkt_stat_index {
 	HNS_ROCE_HW_CNT_TOTAL
 };
 
+enum hns_roce_hw_dfx_stat_index {
+	HNS_ROCE_DFX_AEQE_CNT,
+	HNS_ROCE_DFX_CEQE_CNT,
+	HNS_ROCE_DFX_CMDS_CNT,
+	HNS_ROCE_DFX_CMDS_ERR_CNT,
+	HNS_ROCE_DFX_MBX_POSTED_CNT,
+	HNS_ROCE_DFX_MBX_POLLED_CNT,
+	HNS_ROCE_DFX_MBX_EVENT_CNT,
+	HNS_ROCE_DFX_QP_CREATE_ERR_CNT,
+	HNS_ROCE_DFX_QP_MODIFY_ERR_CNT,
+	HNS_ROCE_DFX_CQ_CREATE_ERR_CNT,
+	HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT,
+	HNS_ROCE_DFX_XRCD_ALLOC_ERR_CNT,
+	HNS_ROCE_DFX_MR_REG_ERR_CNT,
+	HNS_ROCE_DFX_MR_REREG_ERR_CNT,
+	HNS_ROCE_DFX_AH_CREATE_ERR_CNT,
+	HNS_ROCE_DFX_MMAP_ERR_CNT,
+	HNS_ROCE_DFX_UCTX_ALLOC_ERR_CNT,
+	HNS_ROCE_DFX_CNT_TOTAL
+};
+
 struct hns_roce_hw {
 	int (*cmq_init)(struct hns_roce_dev *hr_dev);
 	void (*cmq_exit)(struct hns_roce_dev *hr_dev);
@@ -975,6 +996,7 @@ struct hns_roce_dev {
 	u32 is_vf;
 	u32 cong_algo_tmpl_id;
 	u64 dwqe_page;
+	atomic64_t *dfx_cnt;
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index d82daff2d9bd..d1249371dbda 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1292,6 +1292,8 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	/* Write to hardware */
 	roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, csq->head);
 
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CMDS_CNT]);
+
 	do {
 		if (hns_roce_cmq_csq_done(hr_dev))
 			break;
@@ -1329,6 +1331,9 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 
 	spin_unlock_bh(&csq->lock);
 
+	if (ret)
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CMDS_ERR_CNT]);
+
 	return ret;
 }
 
@@ -5966,6 +5971,8 @@ static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		++eq->cons_index;
 		aeqe_found = IRQ_HANDLED;
 
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_AEQE_CNT]);
+
 		hns_roce_v2_init_irq_work(hr_dev, eq, queue_num);
 
 		aeqe = next_aeqe_sw_v2(eq);
@@ -6007,6 +6014,7 @@ static irqreturn_t hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 
 		++eq->cons_index;
 		ceqe_found = IRQ_HANDLED;
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CEQE_CNT]);
 
 		ceqe = next_ceqe_sw_v2(eq);
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index d9d546cdef52..ca5d8bbd4fd1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -361,10 +361,10 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
 	struct hns_roce_ib_alloc_ucontext_resp resp = {};
 	struct hns_roce_ib_alloc_ucontext ucmd = {};
-	int ret;
+	int ret = -EAGAIN;
 
 	if (!hr_dev->active)
-		return -EAGAIN;
+		goto error_out;
 
 	resp.qp_tab_size = hr_dev->caps.num_qps;
 	resp.srq_tab_size = hr_dev->caps.num_srqs;
@@ -372,7 +372,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 	ret = ib_copy_from_udata(&ucmd, udata,
 				 min(udata->inlen, sizeof(ucmd)));
 	if (ret)
-		return ret;
+		goto error_out;
 
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
 		context->config = ucmd.config & HNS_ROCE_EXSGE_FLAGS;
@@ -396,7 +396,7 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 
 	ret = hns_roce_uar_alloc(hr_dev, &context->uar);
 	if (ret)
-		goto error_fail_uar_alloc;
+		goto error_out;
 
 	ret = hns_roce_alloc_uar_entry(uctx);
 	if (ret)
@@ -423,7 +423,9 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 error_fail_uar_entry:
 	ida_free(&hr_dev->uar_ida.ida, (int)context->uar.logic_idx);
 
-error_fail_uar_alloc:
+error_out:
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_UCTX_ALLOC_ERR_CNT]);
+
 	return ret;
 }
 
@@ -439,6 +441,7 @@ static void hns_roce_dealloc_ucontext(struct ib_ucontext *ibcontext)
 
 static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 {
+	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
 	struct rdma_user_mmap_entry *rdma_entry;
 	struct hns_user_mmap_entry *entry;
 	phys_addr_t pfn;
@@ -446,8 +449,10 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 	int ret;
 
 	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
-	if (!rdma_entry)
+	if (!rdma_entry) {
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MMAP_ERR_CNT]);
 		return -EINVAL;
+	}
 
 	entry = to_hns_mmap(rdma_entry);
 	pfn = entry->address >> PAGE_SHIFT;
@@ -467,6 +472,9 @@ static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
 
 out:
 	rdma_user_mmap_entry_put(rdma_entry);
+	if (ret)
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MMAP_ERR_CNT]);
+
 	return ret;
 }
 
@@ -515,10 +523,30 @@ static void hns_roce_get_fw_ver(struct ib_device *device, char *str)
 		 sub_minor);
 }
 
+#define HNS_ROCE_DFX_STATS(ename, cname) \
+	[HNS_ROCE_DFX_##ename##_CNT].name = cname
+
 #define HNS_ROCE_HW_CNT(ename, cname) \
-	[HNS_ROCE_HW_##ename##_CNT].name = cname
+	[HNS_ROCE_DFX_CNT_TOTAL + HNS_ROCE_HW_##ename##_CNT].name = cname
 
 static const struct rdma_stat_desc hns_roce_port_stats_descs[] = {
+	HNS_ROCE_DFX_STATS(AEQE, "aeqe"),
+	HNS_ROCE_DFX_STATS(CEQE, "ceqe"),
+	HNS_ROCE_DFX_STATS(CMDS, "cmds"),
+	HNS_ROCE_DFX_STATS(CMDS_ERR, "cmds_err"),
+	HNS_ROCE_DFX_STATS(MBX_POSTED, "posted_mbx"),
+	HNS_ROCE_DFX_STATS(MBX_POLLED, "polled_mbx"),
+	HNS_ROCE_DFX_STATS(MBX_EVENT, "mbx_event"),
+	HNS_ROCE_DFX_STATS(QP_CREATE_ERR, "qp_create_err"),
+	HNS_ROCE_DFX_STATS(QP_MODIFY_ERR, "qp_modify_err"),
+	HNS_ROCE_DFX_STATS(CQ_CREATE_ERR, "cq_create_err"),
+	HNS_ROCE_DFX_STATS(SRQ_CREATE_ERR, "srq_create_err"),
+	HNS_ROCE_DFX_STATS(XRCD_ALLOC_ERR, "xrcd_alloc_err"),
+	HNS_ROCE_DFX_STATS(MR_REG_ERR, "mr_reg_err"),
+	HNS_ROCE_DFX_STATS(MR_REREG_ERR, "mr_rereg_err"),
+	HNS_ROCE_DFX_STATS(AH_CREATE_ERR, "ah_create_err"),
+	HNS_ROCE_DFX_STATS(MMAP_ERR, "mmap_err"),
+	HNS_ROCE_DFX_STATS(UCTX_ALLOC_ERR, "uctx_alloc_err"),
 	HNS_ROCE_HW_CNT(RX_RC_PKT, "rx_rc_pkt"),
 	HNS_ROCE_HW_CNT(RX_UC_PKT, "rx_uc_pkt"),
 	HNS_ROCE_HW_CNT(RX_UD_PKT, "rx_ud_pkt"),
@@ -547,19 +575,21 @@ static struct rdma_hw_stats *hns_roce_alloc_hw_port_stats(
 				struct ib_device *device, u32 port_num)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(device);
-	u32 port = port_num - 1;
+	int num_counters;
 
-	if (port > hr_dev->caps.num_ports) {
+	if (port_num > hr_dev->caps.num_ports) {
 		ibdev_err(device, "invalid port num.\n");
 		return NULL;
 	}
 
 	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08 ||
 	    hr_dev->is_vf)
-		return NULL;
+		num_counters = HNS_ROCE_DFX_CNT_TOTAL;
+	else
+		num_counters = ARRAY_SIZE(hns_roce_port_stats_descs);
 
 	return rdma_alloc_hw_stats_struct(hns_roce_port_stats_descs,
-					  ARRAY_SIZE(hns_roce_port_stats_descs),
+					  num_counters,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 
@@ -568,8 +598,9 @@ static int hns_roce_get_hw_stats(struct ib_device *device,
 				 u32 port, int index)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(device);
-	int num_counters = HNS_ROCE_HW_CNT_TOTAL;
+	int hw_counters = HNS_ROCE_HW_CNT_TOTAL;
 	int ret;
+	int i;
 
 	if (port == 0)
 		return 0;
@@ -577,19 +608,24 @@ static int hns_roce_get_hw_stats(struct ib_device *device,
 	if (port > hr_dev->caps.num_ports)
 		return -EINVAL;
 
+	for (i = 0; i < HNS_ROCE_DFX_CNT_TOTAL; i++)
+		stats->value[i] = atomic64_read(&hr_dev->dfx_cnt[i]);
+
 	if (hr_dev->pci_dev->revision <= PCI_REVISION_ID_HIP08 ||
 	    hr_dev->is_vf)
-		return -EOPNOTSUPP;
+		return HNS_ROCE_DFX_CNT_TOTAL;
 
-	ret = hr_dev->hw->query_hw_counter(hr_dev, stats->value, port,
-					   &num_counters);
+	hw_counters = HNS_ROCE_HW_CNT_TOTAL;
+	ret = hr_dev->hw->query_hw_counter(hr_dev,
+					&stats->value[HNS_ROCE_DFX_CNT_TOTAL],
+					port, &hw_counters);
 	if (ret) {
 		ibdev_err(device, "failed to query hw counter, ret = %d\n",
 			  ret);
 		return ret;
 	}
 
-	return num_counters;
+	return hw_counters + HNS_ROCE_DFX_CNT_TOTAL;
 }
 
 static void hns_roce_unregister_device(struct hns_roce_dev *hr_dev)
@@ -1009,6 +1045,21 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev)
 	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
 }
 
+static int hns_roce_alloc_dfx_cnt(struct hns_roce_dev *hr_dev)
+{
+	hr_dev->dfx_cnt = kcalloc(HNS_ROCE_DFX_CNT_TOTAL, sizeof(atomic64_t),
+				  GFP_KERNEL);
+	if (!hr_dev->dfx_cnt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void hns_roce_dealloc_dfx_cnt(struct hns_roce_dev *hr_dev)
+{
+	kfree(hr_dev->dfx_cnt);
+}
+
 int hns_roce_init(struct hns_roce_dev *hr_dev)
 {
 	struct device *dev = hr_dev->dev;
@@ -1016,11 +1067,15 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 
 	hr_dev->is_reset = false;
 
+	ret = hns_roce_alloc_dfx_cnt(hr_dev);
+	if (ret)
+		return ret;
+
 	if (hr_dev->hw->cmq_init) {
 		ret = hr_dev->hw->cmq_init(hr_dev);
 		if (ret) {
 			dev_err(dev, "init RoCE Command Queue failed!\n");
-			return ret;
+			goto error_failed_alloc_dfx_cnt;
 		}
 	}
 
@@ -1103,6 +1158,9 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 	if (hr_dev->hw->cmq_exit)
 		hr_dev->hw->cmq_exit(hr_dev);
 
+error_failed_alloc_dfx_cnt:
+	hns_roce_dealloc_dfx_cnt(hr_dev);
+
 	return ret;
 }
 
@@ -1122,6 +1180,7 @@ void hns_roce_exit(struct hns_roce_dev *hr_dev)
 	hns_roce_cmd_cleanup(hr_dev);
 	if (hr_dev->hw->cmq_exit)
 		hr_dev->hw->cmq_exit(hr_dev);
+	hns_roce_dealloc_dfx_cnt(hr_dev);
 }
 
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 14376490ac22..d68074b6ca17 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -228,8 +228,10 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	int ret;
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	if (!mr) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
 
 	mr->iova = virt_addr;
 	mr->size = length;
@@ -259,6 +261,9 @@ struct ib_mr *hns_roce_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	free_mr_key(hr_dev, mr);
 err_alloc_mr:
 	kfree(mr);
+err_out:
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MR_REG_ERR_CNT]);
+
 	return ERR_PTR(ret);
 }
 
@@ -274,12 +279,15 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 	unsigned long mtpt_idx;
 	int ret;
 
-	if (!mr->enabled)
-		return ERR_PTR(-EINVAL);
+	if (!mr->enabled) {
+		ret = -EINVAL;
+		goto err_out;
+	}
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox))
-		return ERR_CAST(mailbox);
+	ret = PTR_ERR_OR_ZERO(mailbox);
+	if (ret)
+		goto err_out;
 
 	mtpt_idx = key_to_hw_index(mr->key) & (hr_dev->caps.num_mtpts - 1);
 
@@ -331,8 +339,12 @@ struct ib_mr *hns_roce_rereg_user_mr(struct ib_mr *ibmr, int flags, u64 start,
 free_cmd_mbox:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 
-	if (ret)
+err_out:
+	if (ret) {
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_MR_REREG_ERR_CNT]);
 		return ERR_PTR(ret);
+	}
+
 	return NULL;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 783e71852c50..7399963dc294 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -147,16 +147,18 @@ int hns_roce_alloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)
 {
 	struct hns_roce_dev *hr_dev = to_hr_dev(ib_xrcd->device);
 	struct hns_roce_xrcd *xrcd = to_hr_xrcd(ib_xrcd);
-	int ret;
+	int ret = -EINVAL;
 
 	if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC))
-		return -EINVAL;
+		goto err_out;
 
 	ret = hns_roce_xrcd_alloc(hr_dev, &xrcd->xrcdn);
+
+err_out:
 	if (ret)
-		return ret;
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_XRCD_ALLOC_ERR_CNT]);
 
-	return 0;
+	return ret;
 }
 
 int hns_roce_dealloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index cdc1c6de43a1..2b4316b3a022 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1216,7 +1216,7 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 
 	ret = check_qp_type(hr_dev, init_attr->qp_type, !!udata);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	if (init_attr->qp_type == IB_QPT_XRC_TGT)
 		hr_qp->xrcdn = to_hr_xrcd(init_attr->xrcd)->xrcdn;
@@ -1231,6 +1231,10 @@ int hns_roce_create_qp(struct ib_qp *qp, struct ib_qp_init_attr *init_attr,
 		ibdev_err(ibdev, "create QP type 0x%x failed(%d)\n",
 			  init_attr->qp_type, ret);
 
+err_out:
+	if (ret)
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_QP_CREATE_ERR_CNT]);
+
 	return ret;
 }
 
@@ -1366,6 +1370,8 @@ int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 
 out:
 	mutex_unlock(&hr_qp->mutex);
+	if (ret)
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_QP_MODIFY_ERR_CNT]);
 
 	return ret;
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 8dae98f827eb..394c10c55c4a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -401,11 +401,11 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 
 	ret = set_srq_param(srq, init_attr, udata);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	ret = alloc_srq_buf(hr_dev, srq, udata);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	ret = alloc_srqn(hr_dev, srq);
 	if (ret)
@@ -437,6 +437,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	free_srqn(hr_dev, srq);
 err_srq_buf:
 	free_srq_buf(hr_dev, srq);
+err_out:
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT]);
 
 	return ret;
 }
-- 
2.30.0

