Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D284D4049
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Mar 2022 05:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiCJE3z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Mar 2022 23:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239468AbiCJE3y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Mar 2022 23:29:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AF010857D
        for <linux-rdma@vger.kernel.org>; Wed,  9 Mar 2022 20:28:52 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KDbYD67qCzcZxK;
        Thu, 10 Mar 2022 12:24:00 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 12:28:50 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 12:28:50 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>
Subject: [Resend][PATCH v2 for-next] RDMA/hns: Use the reserved loopback QPs to free MR before destroying MPT
Date:   Thu, 10 Mar 2022 12:28:35 +0800
Message-ID: <20220310042835.38634-1-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yixing Liu <liuyixing1@huawei.com>

Before destroying MPT, the reserved loopback QPs send loopback IOs (one
write operation per SL). Completing these loopback IOs represents that
there isn't any outstanding request in MPT, then it's safe to destroy MPT.

Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---

Changes since v1:
* Allocate all reserved resources in one function.
* Clean up encoding issues.
* v1 Link: https://patchwork.kernel.org/project/linux-rdma/patch/20220225095654.24684-1-liangwenpeng@huawei.com/

 drivers/infiniband/hw/hns/hns_roce_device.h |   2 +
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 311 +++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  20 ++
 drivers/infiniband/hw/hns/hns_roce_mr.c     |   6 +-
 4 files changed, 335 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 21182ec56f18..3083d6db1d68 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -633,6 +633,7 @@ struct hns_roce_qp {
 	u32			next_sge;
 	enum ib_mtu		path_mtu;
 	u32			max_inline_data;
+	u8			free_mr_en;

 	/* 0: flush needed, 1: unneeded */
 	unsigned long		flush_flag;
@@ -889,6 +890,7 @@ struct hns_roce_hw {
 			 enum ib_qp_state new_state);
 	int (*qp_flow_control_init)(struct hns_roce_dev *hr_dev,
 			 struct hns_roce_qp *hr_qp);
+	void (*dereg_mr)(struct hns_roce_dev *hr_dev);
 	int (*init_eq)(struct hns_roce_dev *hr_dev);
 	void (*cleanup_eq)(struct hns_roce_dev *hr_dev);
 	int (*write_srqc)(struct hns_roce_srq *srq, void *mb_buf);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 06eb4f00428c..2b0cef17ad45 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2664,6 +2664,194 @@ static void free_dip_list(struct hns_roce_dev *hr_dev)
 	spin_unlock_irqrestore(&hr_dev->dip_list_lock, flags);
 }

+static void free_mr_exit(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
+		if (free_mr->rsv_qp[i]) {
+			ret = ib_destroy_qp(free_mr->rsv_qp[i]);
+			if (ret)
+				ibdev_err(&hr_dev->ib_dev,
+					  "failed to destroy qp in free mr.\n");
+
+			free_mr->rsv_qp[i] = NULL;
+		}
+	}
+
+	if (free_mr->rsv_cq) {
+		ib_destroy_cq(free_mr->rsv_cq);
+		free_mr->rsv_cq = NULL;
+	}
+
+	if (free_mr->rsv_pd) {
+		ib_dealloc_pd(free_mr->rsv_pd);
+		free_mr->rsv_pd = NULL;
+	}
+}
+
+static int free_mr_alloc_res(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct ib_cq_init_attr cq_init_attr = {};
+	struct ib_qp_init_attr qp_init_attr = {};
+	struct ib_pd *pd;
+	struct ib_cq *cq;
+	struct ib_qp *qp;
+	int ret;
+	int i;
+
+	pd = ib_alloc_pd(ibdev, 0);
+	if (IS_ERR(pd)) {
+		ibdev_err(ibdev, "failed to create pd for free mr.\n");
+		return PTR_ERR(pd);
+	}
+	free_mr->rsv_pd = pd;
+
+	cq_init_attr.cqe = HNS_ROCE_FREE_MR_USED_CQE_NUM;
+	cq = ib_create_cq(ibdev, NULL, NULL, NULL, &cq_init_attr);
+	if (IS_ERR(cq)) {
+		ibdev_err(ibdev, "failed to create cq for free mr.\n");
+		ret = PTR_ERR(cq);
+		goto create_failed;
+	}
+	free_mr->rsv_cq = cq;
+
+	qp_init_attr.qp_type = IB_QPT_RC;
+	qp_init_attr.sq_sig_type = IB_SIGNAL_ALL_WR;
+	qp_init_attr.send_cq = free_mr->rsv_cq;
+	qp_init_attr.recv_cq = free_mr->rsv_cq;
+	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
+		qp_init_attr.cap.max_send_wr = HNS_ROCE_FREE_MR_USED_SQWQE_NUM;
+		qp_init_attr.cap.max_send_sge = HNS_ROCE_FREE_MR_USED_SQSGE_NUM;
+		qp_init_attr.cap.max_recv_wr = HNS_ROCE_FREE_MR_USED_RQWQE_NUM;
+		qp_init_attr.cap.max_recv_sge = HNS_ROCE_FREE_MR_USED_RQSGE_NUM;
+
+		qp = ib_create_qp(free_mr->rsv_pd, &qp_init_attr);
+		if (IS_ERR(qp)) {
+			ibdev_err(ibdev, "failed to create qp for free mr.\n");
+			ret = PTR_ERR(qp);
+			goto create_failed;
+		}
+
+		free_mr->rsv_qp[i] = qp;
+	}
+
+	return 0;
+
+create_failed:
+	free_mr_exit(hr_dev);
+
+	return ret;
+}
+
+static int free_mr_modify_rsv_qp(struct hns_roce_dev *hr_dev,
+				 struct ib_qp_attr *attr, int sl_num)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_qp *hr_qp;
+	int loopback;
+	int mask;
+	int ret;
+
+	hr_qp = to_hr_qp(free_mr->rsv_qp[sl_num]);
+	hr_qp->free_mr_en = 1;
+
+	mask = IB_QP_STATE | IB_QP_PKEY_INDEX | IB_QP_PORT | IB_QP_ACCESS_FLAGS;
+	attr->qp_state = IB_QPS_INIT;
+	attr->port_num = 1;
+	attr->qp_access_flags = IB_ACCESS_REMOTE_WRITE;
+	ret = ib_modify_qp(&hr_qp->ibqp, attr, mask);
+	if (ret) {
+		ibdev_err(ibdev, "failed to modify qp to init, ret = %d.\n",
+			  ret);
+		return ret;
+	}
+
+	loopback = hr_dev->loop_idc;
+	/* Set qpc lbi = 1 incidate loopback IO */
+	hr_dev->loop_idc = 1;
+
+	mask = IB_QP_STATE | IB_QP_AV | IB_QP_PATH_MTU | IB_QP_DEST_QPN |
+	       IB_QP_RQ_PSN | IB_QP_MAX_DEST_RD_ATOMIC | IB_QP_MIN_RNR_TIMER;
+	attr->qp_state = IB_QPS_RTR;
+	attr->ah_attr.type = RDMA_AH_ATTR_TYPE_ROCE;
+	attr->path_mtu = IB_MTU_256;
+	attr->dest_qp_num = hr_qp->qpn;
+	attr->rq_psn = HNS_ROCE_FREE_MR_USED_PSN;
+
+	rdma_ah_set_sl(&attr->ah_attr, (u8)sl_num);
+
+	ret = ib_modify_qp(&hr_qp->ibqp, attr, mask);
+	hr_dev->loop_idc = loopback;
+	if (ret) {
+		ibdev_err(ibdev, "failed to modify qp to rtr, ret = %d.\n",
+			  ret);
+		return ret;
+	}
+
+	mask = IB_QP_STATE | IB_QP_SQ_PSN | IB_QP_RETRY_CNT | IB_QP_TIMEOUT |
+	       IB_QP_RNR_RETRY | IB_QP_MAX_QP_RD_ATOMIC;
+	attr->qp_state = IB_QPS_RTS;
+	attr->sq_psn = HNS_ROCE_FREE_MR_USED_PSN;
+	attr->retry_cnt = HNS_ROCE_FREE_MR_USED_QP_RETRY_CNT;
+	attr->timeout = HNS_ROCE_FREE_MR_USED_QP_TIMEOUT;
+	ret = ib_modify_qp(&hr_qp->ibqp, attr, mask);
+	if (ret)
+		ibdev_err(ibdev, "failed to modify qp to rts, ret = %d.\n",
+			  ret);
+
+	return ret;
+}
+
+static int free_mr_modify_qp(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+	struct ib_qp_attr attr = {};
+	int ret;
+	int i;
+
+	rdma_ah_set_grh(&attr.ah_attr, NULL, 0, 0, 1, 0);
+	rdma_ah_set_static_rate(&attr.ah_attr, 3);
+	rdma_ah_set_port_num(&attr.ah_attr, 1);
+
+	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
+		ret = free_mr_modify_rsv_qp(hr_dev, &attr, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int free_mr_init(struct hns_roce_dev *hr_dev)
+{
+	int ret;
+
+	ret = free_mr_alloc_res(hr_dev);
+	if (ret)
+		return ret;
+
+	ret = free_mr_modify_qp(hr_dev);
+	if (ret)
+		goto err_modify_qp;
+
+	return 0;
+
+err_modify_qp:
+	free_mr_exit(hr_dev);
+
+	return ret;
+}
+
 static int get_hem_table(struct hns_roce_dev *hr_dev)
 {
 	unsigned int qpc_count;
@@ -3244,6 +3432,98 @@ static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
 	return 0;
 }

+static int free_mr_post_send_lp_wqe(struct hns_roce_qp *hr_qp)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_qp->ibqp.device);
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	const struct ib_send_wr *bad_wr;
+	struct ib_rdma_wr rdma_wr = {};
+	struct ib_send_wr *send_wr;
+	int ret;
+
+	send_wr = &rdma_wr.wr;
+	send_wr->opcode = IB_WR_RDMA_WRITE;
+
+	ret = hns_roce_v2_post_send(&hr_qp->ibqp, send_wr, &bad_wr);
+	if (ret) {
+		ibdev_err(ibdev, "failed to post wqe for free mr, ret = %d.\n",
+			  ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hns_roce_v2_poll_cq(struct ib_cq *ibcq, int num_entries,
+			       struct ib_wc *wc);
+
+static void free_mr_send_cmd_to_hw(struct hns_roce_dev *hr_dev)
+{
+	struct hns_roce_v2_priv *priv = hr_dev->priv;
+	struct hns_roce_v2_free_mr *free_mr = &priv->free_mr;
+	struct ib_wc wc[ARRAY_SIZE(free_mr->rsv_qp)];
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	struct hns_roce_qp *hr_qp;
+	unsigned long end;
+	int cqe_cnt = 0;
+	int npolled;
+	int ret;
+	int i;
+
+	/*
+	 * If the device initialization is not complete or in the uninstall
+	 * process, then there is no need to execute free mr.
+	 */
+	if (priv->handle->rinfo.reset_state == HNS_ROCE_STATE_RST_INIT ||
+	    priv->handle->rinfo.instance_state == HNS_ROCE_STATE_INIT ||
+	    hr_dev->state == HNS_ROCE_DEVICE_STATE_UNINIT)
+		return;
+
+	mutex_lock(&free_mr->mutex);
+
+	for (i = 0; i < ARRAY_SIZE(free_mr->rsv_qp); i++) {
+		hr_qp = to_hr_qp(free_mr->rsv_qp[i]);
+
+		ret = free_mr_post_send_lp_wqe(hr_qp);
+		if (ret) {
+			ibdev_err(ibdev,
+				  "failed to send wqe (qp:0x%lx) for free mr, ret = %d.\n",
+				  hr_qp->qpn, ret);
+			break;
+		}
+
+		cqe_cnt++;
+	}
+
+	end = msecs_to_jiffies(HNS_ROCE_V2_FREE_MR_TIMEOUT) + jiffies;
+	while (cqe_cnt) {
+		npolled = hns_roce_v2_poll_cq(free_mr->rsv_cq, cqe_cnt, wc);
+		if (npolled < 0) {
+			ibdev_err(ibdev,
+				  "failed to poll cqe for free mr, remain %d cqe.\n",
+				  cqe_cnt);
+			goto out;
+		}
+
+		if (time_after(jiffies, end)) {
+			ibdev_err(ibdev,
+				  "failed to poll cqe for free mr and timeout, remain %d cqe.\n",
+				  cqe_cnt);
+			goto out;
+		}
+		cqe_cnt -= npolled;
+	}
+
+out:
+	mutex_unlock(&free_mr->mutex);
+}
+
+static void hns_roce_v2_dereg_mr(struct hns_roce_dev *hr_dev)
+{
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		free_mr_send_cmd_to_hw(hr_dev);
+}
+
 static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 {
 	return hns_roce_buf_offset(hr_cq->mtr.kmem, n * hr_cq->cqe_size);
@@ -4663,6 +4943,18 @@ static int hns_roce_v2_set_path(struct ib_qp *ibqp,
 	u8 hr_port;
 	int ret;

+	/*
+	 * If free_mr_en of qp is set, it means that this qp comes from
+	 * free mr. This qp will perform the loopback operation.
+	 * In the loopback scenario, only sl needs to be set.
+	 */
+	if (hr_qp->free_mr_en) {
+		hr_reg_write(context, QPC_SL, rdma_ah_get_sl(&attr->ah_attr));
+		hr_reg_clear(qpc_mask, QPC_SL);
+		hr_qp->sl = rdma_ah_get_sl(&attr->ah_attr);
+		return 0;
+	}
+
 	ib_port = (attr_mask & IB_QP_PORT) ? attr->port_num : hr_qp->port + 1;
 	hr_port = ib_port - 1;
 	is_roce_protocol = rdma_cap_eth_ah(&hr_dev->ib_dev, ib_port) &&
@@ -6247,6 +6539,7 @@ static const struct hns_roce_hw hns_roce_hw_v2 = {
 	.set_hem = hns_roce_v2_set_hem,
 	.clear_hem = hns_roce_v2_clear_hem,
 	.modify_qp = hns_roce_v2_modify_qp,
+	.dereg_mr = hns_roce_v2_dereg_mr,
 	.qp_flow_control_init = hns_roce_v2_qp_flow_control_init,
 	.init_eq = hns_roce_v2_init_eq_table,
 	.cleanup_eq = hns_roce_v2_cleanup_eq_table,
@@ -6328,14 +6621,25 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
 	ret = hns_roce_init(hr_dev);
 	if (ret) {
 		dev_err(hr_dev->dev, "RoCE Engine init failed!\n");
-		goto error_failed_get_cfg;
+		goto error_failed_cfg;
+	}
+
+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08) {
+		ret = free_mr_init(hr_dev);
+		if (ret) {
+			dev_err(hr_dev->dev, "failed to init free mr!\n");
+			goto error_failed_roce_init;
+		}
 	}

 	handle->priv = hr_dev;

 	return 0;

-error_failed_get_cfg:
+error_failed_roce_init:
+	hns_roce_exit(hr_dev);
+
+error_failed_cfg:
 	kfree(hr_dev->priv);

 error_failed_kzalloc:
@@ -6357,6 +6661,9 @@ static void __hns_roce_hw_v2_uninit_instance(struct hnae3_handle *handle,
 	hr_dev->state = HNS_ROCE_DEVICE_STATE_UNINIT;
 	hns_roce_handle_device_err(hr_dev);

+	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP08)
+		free_mr_exit(hr_dev);
+
 	hns_roce_exit(hr_dev);
 	kfree(hr_dev->priv);
 	ib_dealloc_device(&hr_dev->ib_dev);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 12be85f0986e..0d87b627601e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -139,6 +139,18 @@ enum {
 #define CMD_CSQ_DESC_NUM		1024
 #define CMD_CRQ_DESC_NUM		1024

+/* Free mr used parameters */
+#define HNS_ROCE_FREE_MR_USED_CQE_NUM		128
+#define HNS_ROCE_FREE_MR_USED_QP_NUM		0x8
+#define HNS_ROCE_FREE_MR_USED_PSN		0x0808
+#define HNS_ROCE_FREE_MR_USED_QP_RETRY_CNT	0x7
+#define HNS_ROCE_FREE_MR_USED_QP_TIMEOUT	0x12
+#define HNS_ROCE_FREE_MR_USED_SQWQE_NUM		128
+#define HNS_ROCE_FREE_MR_USED_SQSGE_NUM		0x2
+#define HNS_ROCE_FREE_MR_USED_RQWQE_NUM		128
+#define HNS_ROCE_FREE_MR_USED_RQSGE_NUM		0x2
+#define HNS_ROCE_V2_FREE_MR_TIMEOUT		4500
+
 enum {
 	NO_ARMED = 0x0,
 	REG_NXT_CEQE = 0x2,
@@ -1418,10 +1430,18 @@ struct hns_roce_link_table {
 #define HNS_ROCE_EXT_LLM_ENTRY(addr, id) (((id) << (64 - 12)) | ((addr) >> 12))
 #define HNS_ROCE_EXT_LLM_MIN_PAGES(que_num) ((que_num) * 4 + 2)

+struct hns_roce_v2_free_mr {
+	struct ib_qp *rsv_qp[HNS_ROCE_FREE_MR_USED_QP_NUM];
+	struct ib_cq *rsv_cq;
+	struct ib_pd *rsv_pd;
+	struct mutex mutex;
+};
+
 struct hns_roce_v2_priv {
 	struct hnae3_handle *handle;
 	struct hns_roce_v2_cmq cmq;
 	struct hns_roce_link_table ext_llm;
+	struct hns_roce_v2_free_mr free_mr;
 };

 struct hns_roce_dip {
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index b58b869339cc..b389738d157f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -119,8 +119,7 @@ static void free_mr_pbl(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 	hns_roce_mtr_destroy(hr_dev, &mr->pbl_mtr);
 }

-static void hns_roce_mr_free(struct hns_roce_dev *hr_dev,
-			     struct hns_roce_mr *mr)
+static void hns_roce_mr_free(struct hns_roce_dev *hr_dev, struct hns_roce_mr *mr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
@@ -343,6 +342,9 @@ int hns_roce_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 	int ret = 0;

+	if (hr_dev->hw->dereg_mr)
+		hr_dev->hw->dereg_mr(hr_dev);
+
 	hns_roce_mr_free(hr_dev, mr);
 	kfree(mr);

--
2.33.0

