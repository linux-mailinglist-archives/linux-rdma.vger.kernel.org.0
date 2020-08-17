Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC4024669B
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Aug 2020 14:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgHQMq4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Aug 2020 08:46:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48014 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726727AbgHQMqz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 Aug 2020 08:46:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 39FE1A9CCE9BDC6FDF6D;
        Mon, 17 Aug 2020 20:46:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 17 Aug 2020 20:46:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next 3/4] RDMA/hns: Add support for CQE in size of 64 Bytes
Date:   Mon, 17 Aug 2020 20:45:43 +0800
Message-ID: <1597668344-48575-4-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1597668344-48575-1-git-send-email-liweihang@huawei.com>
References: <1597668344-48575-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Wenpeng Liang <liangwenpeng@huawei.com>

The new version of RoCEE supports using CQE in size of 32B or 64B. The
performance of bus can be improved by using larger size of CQE.

Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_cq.c     | 19 ++++++++++++++++++-
 drivers/infiniband/hw/hns/hns_roce_device.h |  4 ++++
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 20 +++++++++++++-------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  5 ++++-
 drivers/infiniband/hw/hns/hns_roce_main.c   |  2 ++
 include/uapi/rdma/hns-abi.h                 |  4 ++++
 6 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index e87d616..6d237af1 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -150,7 +150,7 @@ static int alloc_cq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 	int err;
 
 	buf_attr.page_shift = hr_dev->caps.cqe_buf_pg_sz + HNS_HW_PAGE_SHIFT;
-	buf_attr.region[0].size = hr_cq->cq_depth * hr_dev->caps.cq_entry_sz;
+	buf_attr.region[0].size = hr_cq->cq_depth * hr_cq->cqe_size;
 	buf_attr.region[0].hopnum = hr_dev->caps.cqe_hop_num;
 	buf_attr.region_count = 1;
 	buf_attr.fixed_page = true;
@@ -224,6 +224,21 @@ static void free_cq_db(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq,
 	}
 }
 
+static void set_cqe_size(struct hns_roce_cq *hr_cq, struct ib_udata *udata,
+			 struct hns_roce_ib_create_cq *ucmd)
+{
+	struct hns_roce_dev *hr_dev = to_hr_dev(hr_cq->ib_cq.device);
+
+	if (udata) {
+		if (udata->inlen >= offsetofend(typeof(*ucmd), cqe_size))
+			hr_cq->cqe_size = ucmd->cqe_size;
+		else
+			hr_cq->cqe_size = HNS_ROCE_V2_CQE_SIZE;
+	} else {
+		hr_cq->cqe_size = hr_dev->caps.cq_entry_sz;
+	}
+}
+
 int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 		       struct ib_udata *udata)
 {
@@ -266,6 +281,8 @@ int hns_roce_create_cq(struct ib_cq *ib_cq, const struct ib_cq_init_attr *attr,
 		}
 	}
 
+	set_cqe_size(hr_cq, udata, &ucmd);
+
 	ret = alloc_cq_buf(hr_dev, hr_cq, udata, ucmd.buf_addr);
 	if (ret) {
 		ibdev_err(ibdev, "Failed to alloc CQ buf, err %d\n", ret);
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index 8d658a1..e24d88a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -84,6 +84,9 @@
 
 #define HNS_ROCE_V3_EQE_SIZE			0x40
 
+#define HNS_ROCE_V2_CQE_SIZE		32
+#define HNS_ROCE_V3_CQE_SIZE		64
+
 #define HNS_ROCE_SL_SHIFT			28
 #define HNS_ROCE_TCLASS_SHIFT			20
 #define HNS_ROCE_FLOW_LABEL_MASK		0xfffff
@@ -472,6 +475,7 @@ struct hns_roce_cq {
 	void __iomem			*cq_db_l;
 	u16				*tptr_addr;
 	int				arm_sn;
+	int				cqe_size;
 	unsigned long			cqn;
 	u32				vector;
 	atomic_t			refcount;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 882d064..e0ff87e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1691,7 +1691,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	caps->mtpt_entry_sz	= HNS_ROCE_V2_MTPT_ENTRY_SZ;
 	caps->mtt_entry_sz	= HNS_ROCE_V2_MTT_ENTRY_SZ;
 	caps->idx_entry_sz	= HNS_ROCE_V2_IDX_ENTRY_SZ;
-	caps->cq_entry_sz	= HNS_ROCE_V2_CQE_ENTRY_SIZE;
+	caps->cq_entry_sz	= HNS_ROCE_V2_CQE_SIZE;
 	caps->page_size_cap	= HNS_ROCE_V2_PAGE_SIZE_SUPPORTED;
 	caps->reserved_lkey	= 0;
 	caps->reserved_pds	= 0;
@@ -1771,6 +1771,7 @@ static void set_default_caps(struct hns_roce_dev *hr_dev)
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
 		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
+		caps->cq_entry_sz = HNS_ROCE_V3_CQE_SIZE;
 	}
 }
 
@@ -1863,7 +1864,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	caps->max_sq_desc_sz	     = resp_a->max_sq_desc_sz;
 	caps->max_rq_desc_sz	     = resp_a->max_rq_desc_sz;
 	caps->max_srq_desc_sz	     = resp_a->max_srq_desc_sz;
-	caps->cq_entry_sz	     = resp_a->cq_entry_sz;
+	caps->cq_entry_sz	     = HNS_ROCE_V2_CQE_SIZE;
 
 	caps->mtpt_entry_sz	     = resp_b->mtpt_entry_sz;
 	caps->irrl_entry_sz	     = resp_b->irrl_entry_sz;
@@ -1994,6 +1995,7 @@ static int hns_roce_query_pf_caps(struct hns_roce_dev *hr_dev)
 	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09) {
 		caps->ceqe_size = HNS_ROCE_V3_EQE_SIZE;
 		caps->aeqe_size = HNS_ROCE_V3_EQE_SIZE;
+		caps->cq_entry_sz = HNS_ROCE_V3_CQE_SIZE;
 	}
 
 	calc_pg_sz(caps->num_qps, caps->qpc_entry_sz, caps->qpc_hop_num,
@@ -2771,8 +2773,7 @@ static int hns_roce_v2_mw_write_mtpt(void *mb_buf, struct hns_roce_mw *mw)
 
 static void *get_cqe_v2(struct hns_roce_cq *hr_cq, int n)
 {
-	return hns_roce_buf_offset(hr_cq->mtr.kmem,
-				   n * HNS_ROCE_V2_CQE_ENTRY_SIZE);
+	return hns_roce_buf_offset(hr_cq->mtr.kmem, n * hr_cq->cqe_size);
 }
 
 static void *get_sw_cqe_v2(struct hns_roce_cq *hr_cq, int n)
@@ -2872,6 +2873,10 @@ static void hns_roce_v2_write_cqc(struct hns_roce_dev *hr_dev,
 	roce_set_field(cq_context->byte_8_cqn, V2_CQC_BYTE_8_CQN_M,
 		       V2_CQC_BYTE_8_CQN_S, hr_cq->cqn);
 
+	roce_set_field(cq_context->byte_8_cqn, V2_CQC_BYTE_8_CQE_SIZE_M,
+		       V2_CQC_BYTE_8_CQE_SIZE_S, hr_cq->cqe_size ==
+		       HNS_ROCE_V3_CQE_SIZE ? 1 : 0);
+
 	cq_context->cqe_cur_blk_addr = cpu_to_le32(to_hr_hw_page_addr(mtts[0]));
 
 	roce_set_field(cq_context->byte_16_hop_addr,
@@ -3039,7 +3044,8 @@ static int hns_roce_v2_sw_poll_cq(struct hns_roce_cq *hr_cq, int num_entries,
 }
 
 static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
-			   struct hns_roce_v2_cqe *cqe, struct ib_wc *wc)
+			   struct hns_roce_cq *cq, struct hns_roce_v2_cqe *cqe,
+			   struct ib_wc *wc)
 {
 	static const struct {
 		u32 cqe_status;
@@ -3080,7 +3086,7 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 
 	ibdev_err(&hr_dev->ib_dev, "error cqe status 0x%x:\n", cqe_status);
 	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_NONE, 16, 4, cqe,
-		       sizeof(*cqe), false);
+		       cq->cqe_size, false);
 
 	/*
 	 * For hns ROCEE, GENERAL_ERR is an error type that is not defined in
@@ -3177,7 +3183,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *hr_cq,
 		++wq->tail;
 	}
 
-	get_cqe_status(hr_dev, *cur_qp, cqe, wc);
+	get_cqe_status(hr_dev, *cur_qp, hr_cq, cqe, wc);
 	if (unlikely(wc->status != IB_WC_SUCCESS))
 		return 0;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index 9ed3339..059e308 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -86,7 +86,6 @@
 #define HNS_ROCE_V2_MTPT_ENTRY_SZ		64
 #define HNS_ROCE_V2_MTT_ENTRY_SZ		64
 #define HNS_ROCE_V2_IDX_ENTRY_SZ		4
-#define HNS_ROCE_V2_CQE_ENTRY_SIZE		32
 #define HNS_ROCE_V2_SCCC_ENTRY_SZ		32
 #define HNS_ROCE_V2_QPC_TIMER_ENTRY_SZ		PAGE_SIZE
 #define HNS_ROCE_V2_CQC_TIMER_ENTRY_SZ		PAGE_SIZE
@@ -311,6 +310,9 @@ struct hns_roce_v2_cq_context {
 #define	V2_CQC_BYTE_8_CQN_S 0
 #define V2_CQC_BYTE_8_CQN_M GENMASK(23, 0)
 
+#define V2_CQC_BYTE_8_CQE_SIZE_S 27
+#define V2_CQC_BYTE_8_CQE_SIZE_M GENMASK(28, 27)
+
 #define	V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_S 0
 #define V2_CQC_BYTE_16_CQE_CUR_BLK_ADDR_M GENMASK(19, 0)
 
@@ -898,6 +900,7 @@ struct hns_roce_v2_cqe {
 	u8	smac[4];
 	__le32	byte_28;
 	__le32	byte_32;
+	__le32	rsv[8];
 };
 
 #define	V2_CQE_BYTE_4_OPCODE_S 0
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 98945df..2213c75 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -324,6 +324,8 @@ static int hns_roce_alloc_ucontext(struct ib_ucontext *uctx,
 		mutex_init(&context->page_mutex);
 	}
 
+	resp.cqe_size = hr_dev->caps.cq_entry_sz;
+
 	ret = ib_copy_to_udata(udata, &resp, sizeof(resp));
 	if (ret)
 		goto error_fail_copy_to_udata;
diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
index 5c38758..99a11b6 100644
--- a/include/uapi/rdma/hns-abi.h
+++ b/include/uapi/rdma/hns-abi.h
@@ -39,6 +39,8 @@
 struct hns_roce_ib_create_cq {
 	__aligned_u64 buf_addr;
 	__aligned_u64 db_addr;
+	__u32 cqe_size;
+	__u32 reserved;
 };
 
 struct hns_roce_ib_create_cq_resp {
@@ -74,6 +76,8 @@ struct hns_roce_ib_create_qp_resp {
 struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	qp_tab_size;
 	__u32	cap_flags;
+	__u32	cqe_size;
+	__u32	reserved;
 };
 
 struct hns_roce_ib_alloc_pd_resp {
-- 
2.8.1

