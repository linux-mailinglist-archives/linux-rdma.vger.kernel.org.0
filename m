Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E57EAFF9
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Nov 2023 13:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjKNMiY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Nov 2023 07:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjKNMiX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Nov 2023 07:38:23 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFF413D;
        Tue, 14 Nov 2023 04:38:18 -0800 (PST)
Received: from kwepemi500006.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SV5Ls6KnzzMmlK;
        Tue, 14 Nov 2023 20:33:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 20:38:16 +0800
From:   Junxian Huang <huangjunxian6@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <huangjunxian6@hisilicon.com>
Subject: [PATCH for-next 3/3] RDMA/hns: Support SW stats with debugfs
Date:   Tue, 14 Nov 2023 20:34:49 +0800
Message-ID: <20231114123449.1106162-4-huangjunxian6@hisilicon.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
References: <20231114123449.1106162-1-huangjunxian6@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500006.china.huawei.com (7.221.188.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Support SW stats with debugfs.

Query output:
$ cat /sys/kernel/debug/hns_roce/hns_0/sw_stat/sw_stat
aeqe                 --- 3341
ceqe                 --- 0
cmds                 --- 6764
cmds_err             --- 0
posted_mbx           --- 3344
polled_mbx           --- 3
mbx_event            --- 3341
qp_create_err        --- 0
qp_modify_err        --- 0
cq_create_err        --- 0
cq_modify_err        --- 0
srq_create_err       --- 0
srq_modify_err       --- 0
xrcd_alloc_err       --- 0
mr_reg_err           --- 0
mr_rereg_err         --- 0
ah_create_err        --- 0
mmap_err             --- 0
uctx_alloc_err       --- 0

Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_ah.c      |  6 ++-
 drivers/infiniband/hw/hns/hns_roce_cmd.c     | 19 +++++++-
 drivers/infiniband/hw/hns/hns_roce_cq.c      | 17 ++++---
 drivers/infiniband/hw/hns/hns_roce_debugfs.c | 47 ++++++++++++++++++++
 drivers/infiniband/hw/hns/hns_roce_debugfs.h |  6 +++
 drivers/infiniband/hw/hns/hns_roce_device.h  | 24 ++++++++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c   | 47 ++++++++++++++------
 drivers/infiniband/hw/hns/hns_roce_main.c    | 45 ++++++++++++++++---
 drivers/infiniband/hw/hns/hns_roce_mr.c      | 26 ++++++++---
 drivers/infiniband/hw/hns/hns_roce_pd.c      | 12 +++--
 drivers/infiniband/hw/hns/hns_roce_qp.c      |  8 +++-
 drivers/infiniband/hw/hns/hns_roce_srq.c     |  6 ++-
 12 files changed, 220 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_ah.c b/drivers/infiniband/hw/hns/hns_roce_ah.c
index 3df032ddda18..fbf046982374 100644
--- a/drivers/infiniband/hw/hns/hns_roce_ah.c
+++ b/drivers/infiniband/hw/hns/hns_roce_ah.c
@@ -92,11 +92,15 @@ int hns_roce_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
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
index 736dc2f993b4..1b6d16af8c12 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -363,29 +363,31 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	struct hns_roce_ib_create_cq ucmd = {};
 	int ret;
 
-	if (attr->flags)
-		return -EOPNOTSUPP;
+	if (attr->flags) {
+		ret = -EOPNOTSUPP;
+		goto err_out;
+	}
 
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
@@ -430,6 +432,9 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 	free_cq_db(hr_dev, hr_cq, udata);
 err_cq_buf:
 	free_cq_buf(hr_dev, hr_cq);
+err_out:
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CQ_CREATE_ERR_CNT]);
+
 	return ret;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.c b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
index 79825570cc35..e8febb40f645 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.c
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.c
@@ -36,6 +36,51 @@ static void init_debugfs_seqfile(struct hns_debugfs_seqfile *seq,
 	seq->data = data;
 }
 
+static const char * const sw_stat_info[] = {
+	[HNS_ROCE_DFX_AEQE_CNT] = "aeqe",
+	[HNS_ROCE_DFX_CEQE_CNT] = "ceqe",
+	[HNS_ROCE_DFX_CMDS_CNT] = "cmds",
+	[HNS_ROCE_DFX_CMDS_ERR_CNT] = "cmds_err",
+	[HNS_ROCE_DFX_MBX_POSTED_CNT] = "posted_mbx",
+	[HNS_ROCE_DFX_MBX_POLLED_CNT] = "polled_mbx",
+	[HNS_ROCE_DFX_MBX_EVENT_CNT] = "mbx_event",
+	[HNS_ROCE_DFX_QP_CREATE_ERR_CNT] = "qp_create_err",
+	[HNS_ROCE_DFX_QP_MODIFY_ERR_CNT] = "qp_modify_err",
+	[HNS_ROCE_DFX_CQ_CREATE_ERR_CNT] = "cq_create_err",
+	[HNS_ROCE_DFX_CQ_MODIFY_ERR_CNT] = "cq_modify_err",
+	[HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT] = "srq_create_err",
+	[HNS_ROCE_DFX_SRQ_MODIFY_ERR_CNT] = "srq_modify_err",
+	[HNS_ROCE_DFX_XRCD_ALLOC_ERR_CNT] = "xrcd_alloc_err",
+	[HNS_ROCE_DFX_MR_REG_ERR_CNT] = "mr_reg_err",
+	[HNS_ROCE_DFX_MR_REREG_ERR_CNT] = "mr_rereg_err",
+	[HNS_ROCE_DFX_AH_CREATE_ERR_CNT] = "ah_create_err",
+	[HNS_ROCE_DFX_MMAP_ERR_CNT] = "mmap_err",
+	[HNS_ROCE_DFX_UCTX_ALLOC_ERR_CNT] = "uctx_alloc_err",
+};
+
+static int sw_stat_debugfs_show(struct seq_file *file, void *offset)
+{
+	struct hns_roce_dev *hr_dev = file->private;
+	int i;
+
+	for (i = 0; i < HNS_ROCE_DFX_CNT_TOTAL; i++)
+		seq_printf(file, "%-20s --- %lld\n", sw_stat_info[i],
+			   atomic64_read(&hr_dev->dfx_cnt[i]));
+
+	return 0;
+}
+
+static void create_sw_stat_debugfs(struct hns_roce_dev *hr_dev,
+				   struct dentry *parent)
+{
+	struct hns_sw_stat_debugfs *dbgfs = &hr_dev->dbgfs.sw_stat_root;
+
+	dbgfs->root = debugfs_create_dir("sw_stat", parent);
+
+	init_debugfs_seqfile(&dbgfs->sw_stat, "sw_stat", dbgfs->root,
+			     sw_stat_debugfs_show, hr_dev);
+}
+
 /* debugfs for device */
 void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
 {
@@ -43,6 +88,8 @@ void hns_roce_register_debugfs(struct hns_roce_dev *hr_dev)
 
 	dbgfs->root = debugfs_create_dir(dev_name(&hr_dev->ib_dev.dev),
 					 hns_roce_dbgfs_root);
+
+	create_sw_stat_debugfs(hr_dev, dbgfs->root);
 }
 
 void hns_roce_unregister_debugfs(struct hns_roce_dev *hr_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_debugfs.h b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
index ece71fe6730c..98e87bd3161e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_debugfs.h
+++ b/drivers/infiniband/hw/hns/hns_roce_debugfs.h
@@ -12,9 +12,15 @@ struct hns_debugfs_seqfile {
 	void *data;
 };
 
+struct hns_sw_stat_debugfs {
+	struct dentry *root;
+	struct hns_debugfs_seqfile sw_stat;
+};
+
 /* Debugfs for device */
 struct hns_roce_dev_debugfs {
 	struct dentry *root;
+	struct hns_sw_stat_debugfs sw_stat_root;
 };
 
 struct hns_roce_dev;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index a847cdfb4ad6..b1fce5ddf631 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -870,6 +870,29 @@ enum hns_roce_hw_pkt_stat_index {
 	HNS_ROCE_HW_CNT_TOTAL
 };
 
+enum hns_roce_sw_dfx_stat_index {
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
+	HNS_ROCE_DFX_CQ_MODIFY_ERR_CNT,
+	HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT,
+	HNS_ROCE_DFX_SRQ_MODIFY_ERR_CNT,
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
@@ -981,6 +1004,7 @@ struct hns_roce_dev {
 	u32 cong_algo_tmpl_id;
 	u64 dwqe_page;
 	struct hns_roce_dev_debugfs dbgfs;
+	atomic64_t *dfx_cnt;
 };
 
 static inline struct hns_roce_dev *to_hr_dev(struct ib_device *ib_dev)
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 8a5432bb0e85..5d0a7a1394fc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1297,6 +1297,8 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 	/* Write to hardware */
 	roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, csq->head);
 
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CMDS_CNT]);
+
 	do {
 		if (hns_roce_cmq_csq_done(hr_dev))
 			break;
@@ -1334,6 +1336,9 @@ static int __hns_roce_cmq_send(struct hns_roce_dev *hr_dev,
 
 	spin_unlock_bh(&csq->lock);
 
+	if (ret)
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CMDS_ERR_CNT]);
+
 	return ret;
 }
 
@@ -5662,19 +5667,25 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 	struct hns_roce_srq_context *srq_context;
 	struct hns_roce_srq_context *srqc_mask;
 	struct hns_roce_cmd_mailbox *mailbox;
-	int ret;
+	int ret = 0;
 
 	/* Resizing SRQs is not supported yet */
-	if (srq_attr_mask & IB_SRQ_MAX_WR)
-		return -EOPNOTSUPP;
+	if (srq_attr_mask & IB_SRQ_MAX_WR) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
 
 	if (srq_attr_mask & IB_SRQ_LIMIT) {
-		if (srq_attr->srq_limit > srq->wqe_cnt)
-			return -EINVAL;
+		if (srq_attr->srq_limit > srq->wqe_cnt) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-		if (IS_ERR(mailbox))
-			return PTR_ERR(mailbox);
+		if (IS_ERR(mailbox)) {
+			ret = PTR_ERR(mailbox);
+			goto out;
+		}
 
 		srq_context = mailbox->buf;
 		srqc_mask = (struct hns_roce_srq_context *)mailbox->buf + 1;
@@ -5687,15 +5698,17 @@ static int hns_roce_v2_modify_srq(struct ib_srq *ibsrq,
 		ret = hns_roce_cmd_mbox(hr_dev, mailbox->dma, 0,
 					HNS_ROCE_CMD_MODIFY_SRQC, srq->srqn);
 		hns_roce_free_cmd_mailbox(hr_dev, mailbox);
-		if (ret) {
+		if (ret)
 			ibdev_err(&hr_dev->ib_dev,
 				  "failed to handle cmd of modifying SRQ, ret = %d.\n",
 				  ret);
-			return ret;
-		}
 	}
 
-	return 0;
+out:
+	if (ret)
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_SRQ_MODIFY_ERR_CNT]);
+
+	return ret;
 }
 
 static int hns_roce_v2_query_srq(struct ib_srq *ibsrq, struct ib_srq_attr *attr)
@@ -5739,8 +5752,9 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 	int ret;
 
 	mailbox = hns_roce_alloc_cmd_mailbox(hr_dev);
-	if (IS_ERR(mailbox))
-		return PTR_ERR(mailbox);
+	ret = PTR_ERR_OR_ZERO(mailbox);
+	if (ret)
+		goto err_out;
 
 	cq_context = mailbox->buf;
 	cqc_mask = (struct hns_roce_v2_cq_context *)mailbox->buf + 1;
@@ -5770,6 +5784,10 @@ static int hns_roce_v2_modify_cq(struct ib_cq *cq, u16 cq_count, u16 cq_period)
 			  "failed to process cmd when modifying CQ, ret = %d.\n",
 			  ret);
 
+err_out:
+	if (ret)
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CQ_MODIFY_ERR_CNT]);
+
 	return ret;
 }
 
@@ -6009,6 +6027,8 @@ static irqreturn_t hns_roce_v2_aeq_int(struct hns_roce_dev *hr_dev,
 		++eq->cons_index;
 		aeqe_found = IRQ_HANDLED;
 
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_AEQE_CNT]);
+
 		hns_roce_v2_init_irq_work(hr_dev, eq, queue_num);
 
 		aeqe = next_aeqe_sw_v2(eq);
@@ -6050,6 +6070,7 @@ static irqreturn_t hns_roce_v2_ceq_int(struct hns_roce_dev *hr_dev,
 
 		++eq->cons_index;
 		ceqe_found = IRQ_HANDLED;
+		atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_CEQE_CNT]);
 
 		ceqe = next_ceqe_sw_v2(eq);
 	}
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index c9f93ba522c9..b55fe6911f9f 100644
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
 
@@ -1009,6 +1017,21 @@ void hns_roce_handle_device_err(struct hns_roce_dev *hr_dev)
 	spin_unlock_irqrestore(&hr_dev->qp_list_lock, flags);
 }
 
+static int hns_roce_alloc_dfx_cnt(struct hns_roce_dev *hr_dev)
+{
+	hr_dev->dfx_cnt = kvcalloc(HNS_ROCE_DFX_CNT_TOTAL, sizeof(atomic64_t),
+				   GFP_KERNEL);
+	if (!hr_dev->dfx_cnt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void hns_roce_dealloc_dfx_cnt(struct hns_roce_dev *hr_dev)
+{
+	kvfree(hr_dev->dfx_cnt);
+}
+
 int hns_roce_init(struct hns_roce_dev *hr_dev)
 {
 	struct device *dev = hr_dev->dev;
@@ -1016,11 +1039,15 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 
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
 
@@ -1105,6 +1132,9 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 	if (hr_dev->hw->cmq_exit)
 		hr_dev->hw->cmq_exit(hr_dev);
 
+error_failed_alloc_dfx_cnt:
+	hns_roce_dealloc_dfx_cnt(hr_dev);
+
 	return ret;
 }
 
@@ -1125,6 +1155,7 @@ void hns_roce_exit(struct hns_roce_dev *hr_dev)
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
index bd1fe89ca205..d35cf59d0f43 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -149,14 +149,18 @@ int hns_roce_alloc_xrcd(struct ib_xrcd *ib_xrcd, struct ib_udata *udata)
 	struct hns_roce_xrcd *xrcd = to_hr_xrcd(ib_xrcd);
 	int ret;
 
-	if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC))
-		return -EOPNOTSUPP;
+	if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)) {
+		ret = -EOPNOTSUPP;
+		goto err_out;
+	}
 
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
index 828b58534aa9..31b147210688 100644
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
index 4e2d1c8e164a..4abae9477854 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -475,11 +475,11 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 
 	ret = set_srq_param(srq, init_attr, udata);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	ret = alloc_srq_buf(hr_dev, srq, udata);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	ret = alloc_srq_db(hr_dev, srq, udata, &resp);
 	if (ret)
@@ -517,6 +517,8 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 	free_srq_db(hr_dev, srq, udata);
 err_srq_buf:
 	free_srq_buf(hr_dev, srq);
+err_out:
+	atomic64_inc(&hr_dev->dfx_cnt[HNS_ROCE_DFX_SRQ_CREATE_ERR_CNT]);
 
 	return ret;
 }
-- 
2.30.0

