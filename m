Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7DA378EC0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 May 2021 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbhEJNXQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 May 2021 09:23:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2432 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbhEJMu5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 May 2021 08:50:57 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ff1672Yw1zCr8h;
        Mon, 10 May 2021 20:47:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 20:49:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Xi Wang <wangxi11@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 3/7] RDMA/hns: Configure DCA mode for the userspace QP
Date:   Mon, 10 May 2021 20:48:05 +0800
Message-ID: <1620650889-61650-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620650889-61650-1-git-send-email-liweihang@huawei.com>
References: <1620650889-61650-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Xi Wang <wangxi11@huawei.com>

If the userspace driver assign a NULL to the field of 'buf_addr' in
'struct hns_roce_ib_create_qp' when creating QP, this means the kernel
driver need setup the QP as DCA mode. So add a QP capability bit in
response to indicate the userspace driver that the DCA mode has been
enabled.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c    |  17 +++++
 drivers/infiniband/hw/hns/hns_roce_dca.h    |   3 +
 drivers/infiniband/hw/hns/hns_roce_device.h |   5 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  23 +++++-
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |   2 +
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 110 ++++++++++++++++++++++------
 include/uapi/rdma/hns-abi.h                 |   1 +
 7 files changed, 137 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index 604d6cf..5eec1fb 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.c
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -386,6 +386,23 @@ static void free_dca_mem(struct dca_mem *mem)
 	spin_unlock(&mem->lock);
 }
 
+int hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+{
+	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
+
+	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
+
+	return 0;
+}
+
+void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_qp *hr_qp)
+{
+	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
+
+	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
+}
+
 static inline struct hns_roce_ucontext *
 uverbs_attr_to_hr_uctx(struct uverbs_attr_bundle *attrs)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
index 97caf03..419606ef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.h
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -26,4 +26,7 @@ void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
 void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_ucontext *uctx);
 
+int hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp);
+void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_qp *hr_qp);
 #endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 28fe33f..d1ca142 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -332,6 +332,10 @@ struct hns_roce_mtr {
 	struct hns_roce_hem_cfg  hem_cfg; /* config for hardware addressing */
 };
 
+struct hns_roce_dca_cfg {
+	u32 buf_id;
+};
+
 struct hns_roce_mw {
 	struct ib_mw		ibmw;
 	u32			pdn;
@@ -633,6 +637,7 @@ struct hns_roce_qp {
 	struct hns_roce_wq	sq;
 
 	struct hns_roce_mtr	mtr;
+	struct hns_roce_dca_cfg	dca_cfg;
 
 	u32			buff_size;
 	struct mutex		mutex;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index edcfd39..9adac50 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -350,6 +350,11 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	return 0;
 }
 
+static inline bool check_qp_dca_enable(struct hns_roce_qp *hr_qp)
+{
+	return !!(hr_qp->en_flags & HNS_ROCE_QP_CAP_DCA);
+}
+
 static int check_send_valid(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp)
 {
@@ -4531,6 +4536,21 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_140_raq, V2_QPC_BYTE_140_TRRL_BA_M,
 		       V2_QPC_BYTE_140_TRRL_BA_S, 0);
 
+	/* hip09 reused the IRRL_HEAD fileds in hip08 */
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		if (check_qp_dca_enable(hr_qp)) {
+			roce_set_bit(context->byte_196_sq_psn,
+				     V2_QPC_BYTE_196_DCA_MODE_S, 1);
+			roce_set_bit(qpc_mask->byte_196_sq_psn,
+				     V2_QPC_BYTE_196_DCA_MODE_S, 0);
+		}
+	} else {
+		/* reset IRRL_HEAD */
+		roce_set_field(qpc_mask->byte_196_sq_psn,
+			       V2_QPC_BYTE_196_IRRL_HEAD_M,
+			       V2_QPC_BYTE_196_IRRL_HEAD_S, 0);
+	}
+
 	context->irrl_ba = cpu_to_le32(irrl_ba >> 6);
 	qpc_mask->irrl_ba = 0;
 	roce_set_field(context->byte_208_irrl, V2_QPC_BYTE_208_IRRL_BA_M,
@@ -4688,9 +4708,6 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_212_lsn, V2_QPC_BYTE_212_LSN_M,
 		       V2_QPC_BYTE_212_LSN_S, 0);
 
-	roce_set_field(qpc_mask->byte_196_sq_psn, V2_QPC_BYTE_196_IRRL_HEAD_M,
-		       V2_QPC_BYTE_196_IRRL_HEAD_S, 0);
-
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index a2100a6..eecf27c 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -853,6 +853,8 @@ struct hns_roce_v2_qp_context {
 #define	V2_QPC_BYTE_196_IRRL_HEAD_S 0
 #define V2_QPC_BYTE_196_IRRL_HEAD_M GENMASK(7, 0)
 
+#define V2_QPC_BYTE_196_DCA_MODE_S 6
+
 #define	V2_QPC_BYTE_196_SQ_MAX_PSN_S 8
 #define V2_QPC_BYTE_196_SQ_MAX_PSN_M GENMASK(31, 8)
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 230a909..a8740ef 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -39,6 +39,7 @@
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
+#include "hns_roce_dca.h"
 
 static void flush_work_handle(struct work_struct *work)
 {
@@ -589,8 +590,21 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
 	return 0;
 }
 
+static bool check_dca_is_enable(struct hns_roce_dev *hr_dev, bool is_user,
+				unsigned long addr)
+{
+	if (!(hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_DCA_MODE))
+		return false;
+
+	/* If the user QP's buffer addr is 0, the DCA mode should be enabled */
+	if (is_user)
+		return !addr;
+
+	return false;
+}
+
 static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
-			    struct hns_roce_qp *hr_qp,
+			    struct hns_roce_qp *hr_qp, bool dca_en,
 			    struct hns_roce_buf_attr *buf_attr)
 {
 	int buf_size;
@@ -637,6 +651,19 @@ static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
 	buf_attr->page_shift = HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
 	buf_attr->region_count = idx;
 
+	if (dca_en) {
+		/*
+		 * When enable DCA, there's no need to alloc buffer now, and
+		 * the page shift should be fixed to 4K.
+		 */
+		buf_attr->mtt_only = true;
+		buf_attr->page_shift = HNS_HW_PAGE_SHIFT;
+	} else {
+		buf_attr->mtt_only = false;
+		buf_attr->page_shift = HNS_HW_PAGE_SHIFT +
+				       hr_dev->caps.mtt_buf_pg_sz;
+	}
+
 	return 0;
 }
 
@@ -735,12 +762,53 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
 	kfree(hr_qp->rq_inl_buf.wqe_list);
 }
 
-static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+static int alloc_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			 bool dca_en, struct hns_roce_buf_attr *buf_attr,
+			 struct ib_udata *udata, unsigned long addr)
+{
+	struct ib_device *ibdev = &hr_dev->ib_dev;
+	int ret;
+
+	if (dca_en) {
+		/* DCA must be enabled after the buffer size is configured. */
+		ret = hns_roce_enable_dca(hr_dev, hr_qp);
+		if (ret) {
+			ibdev_err(ibdev, "failed to enable DCA, ret = %d.\n",
+				  ret);
+			return ret;
+		}
+
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_DCA;
+	}
+
+	ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, buf_attr,
+				  HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
+				  udata, addr);
+	if (ret) {
+		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
+		if (dca_en)
+			hns_roce_disable_dca(hr_dev, hr_qp);
+	}
+
+	return ret;
+}
+
+static void free_wqe_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			 struct ib_udata *udata)
+{
+	hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
+
+	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DCA)
+		hns_roce_disable_dca(hr_dev, hr_qp);
+}
+
+static int alloc_qp_wqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 			struct ib_qp_init_attr *init_attr,
 			struct ib_udata *udata, unsigned long addr)
 {
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_buf_attr buf_attr = {};
+	bool dca_en;
 	int ret;
 
 	if (!udata && hr_qp->rq_inl_buf.wqe_cnt) {
@@ -755,16 +823,16 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 		hr_qp->rq_inl_buf.wqe_list = NULL;
 	}
 
-	ret = set_wqe_buf_attr(hr_dev, hr_qp, &buf_attr);
+	dca_en = check_dca_is_enable(hr_dev, !!udata, addr);
+	ret = set_wqe_buf_attr(hr_dev, hr_qp, dca_en, &buf_attr);
 	if (ret) {
-		ibdev_err(ibdev, "failed to split WQE buf, ret = %d.\n", ret);
+		ibdev_err(ibdev, "failed to set WQE attr, ret = %d.\n", ret);
 		goto err_inline;
 	}
-	ret = hns_roce_mtr_create(hr_dev, &hr_qp->mtr, &buf_attr,
-				  HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
-				  udata, addr);
+
+	ret = alloc_wqe_buf(hr_dev, hr_qp, dca_en, &buf_attr, udata, addr);
 	if (ret) {
-		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
+		ibdev_err(ibdev, "failed to alloc WQE buf, ret = %d.\n", ret);
 		goto err_inline;
 	}
 
@@ -775,9 +843,10 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 	return ret;
 }
 
-static void free_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+static void free_qp_wqe(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
+			struct ib_udata *udata)
 {
-	hns_roce_mtr_destroy(hr_dev, &hr_qp->mtr);
+	free_wqe_buf(hr_dev, hr_qp, udata);
 	free_rq_inline_buf(hr_qp);
 }
 
@@ -835,7 +904,6 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 				goto err_out;
 			}
 			hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
-			resp->cap_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
 		}
 
 		if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
@@ -848,7 +916,6 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 				goto err_sdb;
 			}
 			hr_qp->en_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
-			resp->cap_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
 		}
 	} else {
 		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
@@ -1027,18 +1094,18 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 		}
 	}
 
-	ret = alloc_qp_buf(hr_dev, hr_qp, init_attr, udata, ucmd.buf_addr);
-	if (ret) {
-		ibdev_err(ibdev, "failed to alloc QP buffer, ret = %d.\n", ret);
-		goto err_buf;
-	}
-
 	ret = alloc_qpn(hr_dev, hr_qp);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc QPN, ret = %d.\n", ret);
 		goto err_qpn;
 	}
 
+	ret = alloc_qp_wqe(hr_dev, hr_qp, init_attr, udata, ucmd.buf_addr);
+	if (ret) {
+		ibdev_err(ibdev, "failed to alloc QP buffer, ret = %d.\n", ret);
+		goto err_buf;
+	}
+
 	ret = alloc_qp_db(hr_dev, hr_qp, init_attr, udata, &ucmd, &resp);
 	if (ret) {
 		ibdev_err(ibdev, "failed to alloc QP doorbell, ret = %d.\n",
@@ -1060,6 +1127,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	}
 
 	if (udata) {
+		resp.cap_flags = hr_qp->en_flags;
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
 		if (ret) {
@@ -1088,10 +1156,10 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 err_qpc:
 	free_qp_db(hr_dev, hr_qp, udata);
 err_db:
+	free_qp_wqe(hr_dev, hr_qp, udata);
+err_buf:
 	free_qpn(hr_dev, hr_qp);
 err_qpn:
-	free_qp_buf(hr_dev, hr_qp);
-err_buf:
 	free_kernel_wrid(hr_qp);
 	return ret;
 }
@@ -1105,7 +1173,7 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 
 	free_qpc(hr_dev, hr_qp);
 	free_qpn(hr_dev, hr_qp);
-	free_qp_buf(hr_dev, hr_qp);
+	free_qp_wqe(hr_dev, hr_qp, udata);
 	free_kernel_wrid(hr_qp);
 	free_qp_db(hr_dev, hr_qp, udata);
 
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index bcca5be..99da481 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
+	HNS_ROCE_QP_CAP_DCA = 1 << 4,
 };
 
 struct hns_roce_ib_create_qp_resp {
-- 
2.7.4

