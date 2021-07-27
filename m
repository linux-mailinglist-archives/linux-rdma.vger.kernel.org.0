Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6193D6CB9
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jul 2021 05:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbhG0Cup (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Jul 2021 22:50:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7437 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhG0Cup (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Jul 2021 22:50:45 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GYj0H19hPz80fp;
        Tue, 27 Jul 2021 11:27:27 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:07 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 11:31:07 +0800
From:   Wenpeng Liang <liangwenpeng@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
        <liangwenpeng@huawei.com>, Xi Wang <wangxi11@huawei.com>
Subject: [PATCH v3 for-next 03/12] RDMA/hns: Configure DCA mode for the userspace QP
Date:   Tue, 27 Jul 2021 11:27:23 +0800
Message-ID: <1627356452-30564-4-git-send-email-liangwenpeng@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
References: <1627356452-30564-1-git-send-email-liangwenpeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
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
Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_dca.c    |  15 ++++
 drivers/infiniband/hw/hns/hns_roce_dca.h    |   6 +-
 drivers/infiniband/hw/hns/hns_roce_device.h |   5 ++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  19 ++++-
 drivers/infiniband/hw/hns/hns_roce_qp.c     | 106 ++++++++++++++++++++++------
 include/uapi/rdma/hns-abi.h                 |   1 +
 6 files changed, 127 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
index 81b3c58..b14b23e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.c
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
@@ -342,6 +342,21 @@ static void free_dca_mem(struct dca_mem *mem)
 	spin_unlock(&mem->lock);
 }
 
+void hns_roce_enable_dca(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
+{
+	struct hns_roce_dca_cfg *cfg = &hr_qp->dca_cfg;
+
+	cfg->buf_id = HNS_DCA_INVALID_BUF_ID;
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
 static struct hns_roce_ucontext *
 uverbs_attr_to_hr_uctx(struct uverbs_attr_bundle *attrs)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.h b/drivers/infiniband/hw/hns/hns_roce_dca.h
index a82ed5e..a13a2d6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_dca.h
+++ b/drivers/infiniband/hw/hns/hns_roce_dca.h
@@ -14,16 +14,20 @@ struct hns_dca_page_state {
 	u32 head : 1; /* This page is the head in a continuous address range. */
 };
 
+#define HNS_DCA_INVALID_BUF_ID 0UL
 struct hns_dca_shrink_resp {
 	u64 free_key; /* free buffer's key which registered by the user */
 	u32 free_mems; /* free buffer count which no any QP be using */
 };
 
-#define HNS_DCA_INVALID_BUF_ID 0UL
 
 void hns_roce_register_udca(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_ucontext *uctx);
 void hns_roce_unregister_udca(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_ucontext *uctx);
 
+void hns_roce_enable_dca(struct hns_roce_dev *hr_dev,
+			 struct hns_roce_qp *hr_qp);
+void hns_roce_disable_dca(struct hns_roce_dev *hr_dev,
+			  struct hns_roce_qp *hr_qp);
 #endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index d18bc22..00f80b3 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -331,6 +331,10 @@ struct hns_roce_mtr {
 	struct hns_roce_hem_cfg  hem_cfg; /* config for hardware addressing */
 };
 
+struct hns_roce_dca_cfg {
+	u32 buf_id;
+};
+
 struct hns_roce_mw {
 	struct ib_mw		ibmw;
 	u32			pdn;
@@ -631,6 +635,7 @@ struct hns_roce_qp {
 	struct hns_roce_wq	sq;
 
 	struct hns_roce_mtr	mtr;
+	struct hns_roce_dca_cfg	dca_cfg;
 
 	u32			buff_size;
 	struct mutex		mutex;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 594d4ce..ced0c44 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -345,6 +345,12 @@ static int set_rwqe_data_seg(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	return 0;
 }
 
+static bool check_dca_attach_enable(struct hns_roce_qp *hr_qp)
+{
+	return hr_qp->en_flags & HNS_ROCE_QP_CAP_DYNAMIC_CTX_ATTACH;
+}
+
+
 static int check_send_valid(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_qp *hr_qp)
 {
@@ -4371,6 +4377,17 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	hr_reg_write(context, QPC_TRRL_BA_H, trrl_ba >> (32 + 16 + 4));
 	hr_reg_clear(qpc_mask, QPC_TRRL_BA_H);
 
+	/* hip09 reused the IRRL_HEAD fileds in hip08 */
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
+		if (check_dca_attach_enable(hr_qp)) {
+			hr_reg_enable(context, QPC_DCA_MODE);
+			hr_reg_clear(qpc_mask, QPC_DCA_MODE);
+		}
+	} else {
+		/* reset IRRL_HEAD */
+		hr_reg_clear(qpc_mask, QPC_V2_IRRL_HEAD);
+	}
+
 	context->irrl_ba = cpu_to_le32(irrl_ba >> 6);
 	qpc_mask->irrl_ba = 0;
 	hr_reg_write(context, QPC_IRRL_BA_H, irrl_ba >> (32 + 6));
@@ -4489,8 +4506,6 @@ static int modify_qp_rtr_to_rts(struct ib_qp *ibqp,
 	hr_reg_write(context, QPC_LSN, 0x100);
 	hr_reg_clear(qpc_mask, QPC_LSN);
 
-	hr_reg_clear(qpc_mask, QPC_V2_IRRL_HEAD);
-
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index b101b7e5..91311a0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -39,6 +39,7 @@
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
+#include "hns_roce_dca.h"
 
 static void flush_work_handle(struct work_struct *work)
 {
@@ -604,8 +605,21 @@ static int set_user_sq_size(struct hns_roce_dev *hr_dev,
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
@@ -649,9 +663,21 @@ static int set_wqe_buf_attr(struct hns_roce_dev *hr_dev,
 	if (hr_qp->buff_size < 1)
 		return -EINVAL;
 
-	buf_attr->page_shift = HNS_HW_PAGE_SHIFT + hr_dev->caps.mtt_buf_pg_sz;
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
 
@@ -748,12 +774,48 @@ static void free_rq_inline_buf(struct hns_roce_qp *hr_qp)
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
+		/* DCA must be enabled after the buffer attr is configured. */
+		hns_roce_enable_dca(hr_dev, hr_qp);
+
+		hr_qp->en_flags |= HNS_ROCE_QP_CAP_DYNAMIC_CTX_ATTACH;
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
+	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_DYNAMIC_CTX_ATTACH)
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
@@ -768,16 +830,16 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
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
-				  PAGE_SHIFT + hr_dev->caps.mtt_ba_pg_sz,
-				  udata, addr);
+
+	ret = alloc_wqe_buf(hr_dev, hr_qp, dca_en, &buf_attr, udata, addr);
 	if (ret) {
-		ibdev_err(ibdev, "failed to create WQE mtr, ret = %d.\n", ret);
+		ibdev_err(ibdev, "failed to alloc WQE buf, ret = %d.\n", ret);
 		goto err_inline;
 	}
 
@@ -788,9 +850,10 @@ static int alloc_qp_buf(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
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
 
@@ -848,7 +911,6 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 				goto err_out;
 			}
 			hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
-			resp->cap_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
 		}
 
 		if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
@@ -861,7 +923,6 @@ static int alloc_qp_db(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 				goto err_sdb;
 			}
 			hr_qp->en_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
-			resp->cap_flags |= HNS_ROCE_QP_CAP_RQ_RECORD_DB;
 		}
 	} else {
 		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
@@ -1040,18 +1101,18 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
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
@@ -1073,6 +1134,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 	}
 
 	if (udata) {
+		resp.cap_flags = hr_qp->en_flags;
 		ret = ib_copy_to_udata(udata, &resp,
 				       min(udata->outlen, sizeof(resp)));
 		if (ret) {
@@ -1101,10 +1163,10 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
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
@@ -1118,7 +1180,7 @@ void hns_roce_qp_destroy(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 
 	free_qpc(hr_dev, hr_qp);
 	free_qpn(hr_dev, hr_qp);
-	free_qp_buf(hr_dev, hr_qp);
+	free_qp_wqe(hr_dev, hr_qp, udata);
 	free_kernel_wrid(hr_qp);
 	free_qp_db(hr_dev, hr_qp, udata);
 
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index bcca5be..4452b17 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -77,6 +77,7 @@ enum hns_roce_qp_cap_flags {
 	HNS_ROCE_QP_CAP_RQ_RECORD_DB = 1 << 0,
 	HNS_ROCE_QP_CAP_SQ_RECORD_DB = 1 << 1,
 	HNS_ROCE_QP_CAP_OWNER_DB = 1 << 2,
+	HNS_ROCE_QP_CAP_DYNAMIC_CTX_ATTACH = 1 << 4,
 };
 
 struct hns_roce_ib_create_qp_resp {
-- 
2.8.1

