Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 934E94B290
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jun 2019 09:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfFSHDo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jun 2019 03:03:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfFSHDn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Jun 2019 03:03:43 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 40E9E7C7EC0378551879;
        Wed, 19 Jun 2019 15:03:38 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Wed, 19 Jun 2019 15:03:27 +0800
From:   Lijun Ou <oulijun@huawei.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 for-next] RDMA/hns: Cleanup unnecessary exported symbols
Date:   Wed, 19 Jun 2019 15:00:47 +0800
Message-ID: <1560927647-15788-1-git-send-email-oulijun@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch removes the hns-roce.ko for cleanup all the
exported symbols in common part.

Signed-off-by: Xi Wang <wangxi11@huawei.com>
Signed-off-by: Lijun Ou <oulijun@huawei.com>
---
V1->V2:
1.  Use the top level CONFIG_INFINIBAND_HNS tristate to control
    whether hns_roce_hw_v1.ko and hns_roce_hw_v2.ko are both as
    modules or both built in
2.  Add Signed-off-by
---
 drivers/infiniband/hw/hns/Kconfig          | 15 +++++++--------
 drivers/infiniband/hw/hns/Makefile         | 13 +++++++++----
 drivers/infiniband/hw/hns/hns_roce_alloc.c |  2 --
 drivers/infiniband/hw/hns/hns_roce_cmd.c   |  4 ----
 drivers/infiniband/hw/hns/hns_roce_cq.c    |  5 -----
 drivers/infiniband/hw/hns/hns_roce_db.c    |  4 ----
 drivers/infiniband/hw/hns/hns_roce_hem.c   |  5 -----
 drivers/infiniband/hw/hns/hns_roce_main.c  |  3 ---
 drivers/infiniband/hw/hns/hns_roce_mr.c    |  3 ---
 drivers/infiniband/hw/hns/hns_roce_pd.c    |  2 --
 drivers/infiniband/hw/hns/hns_roce_qp.c    | 13 -------------
 drivers/infiniband/hw/hns/hns_roce_srq.c   |  1 -
 12 files changed, 16 insertions(+), 54 deletions(-)

diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index fddb5fd..b548c00 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -7,25 +7,24 @@ config INFINIBAND_HNS
 	  is used in Hisilicon Hip06 and more further ICT SoC based on
 	  platform device.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called hns-roce.
+	  To compile HIP06 or HIP08 driver as module, choose M here.
 
 config INFINIBAND_HNS_HIP06
-	tristate "Hisilicon Hip06 Family RoCE support"
+	bool "Hisilicon Hip06 Family RoCE support"
 	depends on INFINIBAND_HNS && HNS && HNS_DSAF && HNS_ENET
 	---help---
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip06 and
 	  Hip07 SoC. These RoCE engines are platform devices.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called hns-roce-hw-v1.
+	  To compile this driver, choose Y here: if INFINIBAND_HNS is m, this
+	  module will be called hns-roce-hw-v1
 
 config INFINIBAND_HNS_HIP08
-	tristate "Hisilicon Hip08 Family RoCE support"
+	bool "Hisilicon Hip08 Family RoCE support"
 	depends on INFINIBAND_HNS && PCI && HNS3
 	---help---
 	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip08 SoC.
 	  The RoCE engine is a PCI device.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called hns-roce-hw-v2.
+	  To compile this driver, choose Y here: if INFINIBAND_HNS is m, this
+	  module will be called hns-roce-hw-v2.
diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
index eee5205..b956cf4 100644
--- a/drivers/infiniband/hw/hns/Makefile
+++ b/drivers/infiniband/hw/hns/Makefile
@@ -4,11 +4,16 @@
 
 ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
 
-obj-$(CONFIG_INFINIBAND_HNS) += hns-roce.o
 hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
 	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
 	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o
-obj-$(CONFIG_INFINIBAND_HNS_HIP06) += hns-roce-hw-v1.o
+
+ifdef CONFIG_INFINIBAND_HNS_HIP06
 hns-roce-hw-v1-objs := hns_roce_hw_v1.o
-obj-$(CONFIG_INFINIBAND_HNS_HIP08) += hns-roce-hw-v2.o
-hns-roce-hw-v2-objs := hns_roce_hw_v2.o hns_roce_hw_v2_dfx.o
+obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v1.o $(hns-roce-objs)
+endif
+
+ifdef CONFIG_INFINIBAND_HNS_HIP08
+hns-roce-hw-v2-objs := hns_roce_hw_v2.o hns_roce_hw_v2_dfx.o $(hns-roce-objs)
+obj-$(CONFIG_INFINIBAND_HNS) += hns-roce-hw-v2.o
+endif
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index dac058d..aa2b570 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -67,7 +67,6 @@ void hns_roce_bitmap_free(struct hns_roce_bitmap *bitmap, unsigned long obj,
 {
 	hns_roce_bitmap_free_range(bitmap, obj, 1, rr);
 }
-EXPORT_SYMBOL_GPL(hns_roce_bitmap_free);
 
 int hns_roce_bitmap_alloc_range(struct hns_roce_bitmap *bitmap, int cnt,
 				int align, unsigned long *obj)
@@ -174,7 +173,6 @@ void hns_roce_buf_free(struct hns_roce_dev *hr_dev, u32 size,
 		kfree(buf->page_list);
 	}
 }
-EXPORT_SYMBOL_GPL(hns_roce_buf_free);
 
 int hns_roce_buf_alloc(struct hns_roce_dev *hr_dev, u32 size, u32 max_direct,
 		       struct hns_roce_buf *buf, u32 page_shift)
diff --git a/drivers/infiniband/hw/hns/hns_roce_cmd.c b/drivers/infiniband/hw/hns/hns_roce_cmd.c
index 2acf946..b83d5bd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cmd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cmd.c
@@ -103,7 +103,6 @@ void hns_roce_cmd_event(struct hns_roce_dev *hr_dev, u16 token, u8 status,
 	context->out_param = out_param;
 	complete(&context->done);
 }
-EXPORT_SYMBOL_GPL(hns_roce_cmd_event);
 
 /* this should be called with "use_events" */
 static int __hns_roce_cmd_mbox_wait(struct hns_roce_dev *hr_dev, u64 in_param,
@@ -204,7 +203,6 @@ int hns_roce_cmd_mbox(struct hns_roce_dev *hr_dev, u64 in_param, u64 out_param,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hns_roce_cmd_mbox);
 
 int hns_roce_cmd_init(struct hns_roce_dev *hr_dev)
 {
@@ -291,7 +289,6 @@ struct hns_roce_cmd_mailbox
 
 	return mailbox;
 }
-EXPORT_SYMBOL_GPL(hns_roce_alloc_cmd_mailbox);
 
 void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_cmd_mailbox *mailbox)
@@ -302,4 +299,3 @@ void hns_roce_free_cmd_mailbox(struct hns_roce_dev *hr_dev,
 	dma_pool_free(hr_dev->cmd.pool, mailbox->buf, mailbox->dma);
 	kfree(mailbox);
 }
-EXPORT_SYMBOL_GPL(hns_roce_free_cmd_mailbox);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 6e81ff3..6ea3206 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -205,7 +205,6 @@ void hns_roce_free_cq(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
 	hns_roce_bitmap_free(&cq_table->bitmap, hr_cq->cqn, BITMAP_NO_RR);
 }
-EXPORT_SYMBOL_GPL(hns_roce_free_cq);
 
 static int hns_roce_ib_get_cq_umem(struct hns_roce_dev *hr_dev,
 				   struct ib_udata *udata,
@@ -441,7 +440,6 @@ struct ib_cq *hns_roce_ib_create_cq(struct ib_device *ib_dev,
 	kfree(hr_cq);
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(hns_roce_ib_create_cq);
 
 int hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 {
@@ -478,7 +476,6 @@ int hns_roce_ib_destroy_cq(struct ib_cq *ib_cq, struct ib_udata *udata)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hns_roce_ib_destroy_cq);
 
 void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn)
 {
@@ -494,7 +491,6 @@ void hns_roce_cq_completion(struct hns_roce_dev *hr_dev, u32 cqn)
 	++cq->arm_sn;
 	cq->comp(cq);
 }
-EXPORT_SYMBOL_GPL(hns_roce_cq_completion);
 
 void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 {
@@ -516,7 +512,6 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 	if (atomic_dec_and_test(&cq->refcount))
 		complete(&cq->free);
 }
-EXPORT_SYMBOL_GPL(hns_roce_cq_event);
 
 int hns_roce_init_cq_table(struct hns_roce_dev *hr_dev)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_db.c b/drivers/infiniband/hw/hns/hns_roce_db.c
index 3a040a9..627aa46 100644
--- a/drivers/infiniband/hw/hns/hns_roce_db.c
+++ b/drivers/infiniband/hw/hns/hns_roce_db.c
@@ -51,7 +51,6 @@ int hns_roce_db_map_user(struct hns_roce_ucontext *context,
 
 	return ret;
 }
-EXPORT_SYMBOL(hns_roce_db_map_user);
 
 void hns_roce_db_unmap_user(struct hns_roce_ucontext *context,
 			    struct hns_roce_db *db)
@@ -67,7 +66,6 @@ void hns_roce_db_unmap_user(struct hns_roce_ucontext *context,
 
 	mutex_unlock(&context->page_mutex);
 }
-EXPORT_SYMBOL(hns_roce_db_unmap_user);
 
 static struct hns_roce_db_pgdir *hns_roce_alloc_db_pgdir(
 					struct device *dma_device)
@@ -151,7 +149,6 @@ int hns_roce_alloc_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hns_roce_alloc_db);
 
 void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db)
 {
@@ -181,4 +178,3 @@ void hns_roce_free_db(struct hns_roce_dev *hr_dev, struct hns_roce_db *db)
 
 	mutex_unlock(&hr_dev->pgdir_mutex);
 }
-EXPORT_SYMBOL_GPL(hns_roce_free_db);
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 8490a86..d6ad8fe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -56,7 +56,6 @@ bool hns_roce_check_whether_mhop(struct hns_roce_dev *hr_dev, u32 type)
 
 	return false;
 }
-EXPORT_SYMBOL_GPL(hns_roce_check_whether_mhop);
 
 static bool hns_roce_check_hem_null(struct hns_roce_hem **hem, u64 start_idx,
 			    u32 bt_chunk_num)
@@ -234,7 +233,6 @@ int hns_roce_calc_hem_mhop(struct hns_roce_dev *hr_dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(hns_roce_calc_hem_mhop);
 
 static struct hns_roce_hem *hns_roce_alloc_hem(struct hns_roce_dev *hr_dev,
 					       int npages,
@@ -621,7 +619,6 @@ int hns_roce_table_get(struct hns_roce_dev *hr_dev,
 	mutex_unlock(&table->mutex);
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hns_roce_table_get);
 
 static void hns_roce_table_mhop_put(struct hns_roce_dev *hr_dev,
 				    struct hns_roce_hem_table *table,
@@ -764,7 +761,6 @@ void hns_roce_table_put(struct hns_roce_dev *hr_dev,
 
 	mutex_unlock(&table->mutex);
 }
-EXPORT_SYMBOL_GPL(hns_roce_table_put);
 
 void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 			  struct hns_roce_hem_table *table,
@@ -837,7 +833,6 @@ void *hns_roce_table_find(struct hns_roce_dev *hr_dev,
 	mutex_unlock(&table->mutex);
 	return addr;
 }
-EXPORT_SYMBOL_GPL(hns_roce_table_find);
 
 int hns_roce_table_get_range(struct hns_roce_dev *hr_dev,
 			     struct hns_roce_hem_table *table,
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index f07b2ec..28af1cd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -57,7 +57,6 @@ int hns_get_gid_index(struct hns_roce_dev *hr_dev, u8 port, int gid_index)
 {
 	return gid_index * hr_dev->caps.num_ports + port;
 }
-EXPORT_SYMBOL_GPL(hns_get_gid_index);
 
 static int hns_roce_set_mac(struct hns_roce_dev *hr_dev, u8 port, u8 *addr)
 {
@@ -972,7 +971,6 @@ int hns_roce_init(struct hns_roce_dev *hr_dev)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(hns_roce_init);
 
 void hns_roce_exit(struct hns_roce_dev *hr_dev)
 {
@@ -993,7 +991,6 @@ void hns_roce_exit(struct hns_roce_dev *hr_dev)
 	if (hr_dev->hw->reset)
 		hr_dev->hw->reset(hr_dev, false);
 }
-EXPORT_SYMBOL_GPL(hns_roce_exit);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Wei Hu <xavier.huwei@huawei.com>");
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 38ed4ac..f67f453 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -47,7 +47,6 @@ unsigned long key_to_hw_index(u32 key)
 {
 	return (key << 24) | (key >> 8);
 }
-EXPORT_SYMBOL_GPL(key_to_hw_index);
 
 static int hns_roce_sw2hw_mpt(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_cmd_mailbox *mailbox,
@@ -66,7 +65,6 @@ int hns_roce_hw2sw_mpt(struct hns_roce_dev *hr_dev,
 				 mpt_index, !mailbox, HNS_ROCE_CMD_HW2SW_MPT,
 				 HNS_ROCE_CMD_TIMEOUT_MSECS);
 }
-EXPORT_SYMBOL_GPL(hns_roce_hw2sw_mpt);
 
 static int hns_roce_buddy_alloc(struct hns_roce_buddy *buddy, int order,
 				unsigned long *seg)
@@ -293,7 +291,6 @@ void hns_roce_mtt_cleanup(struct hns_roce_dev *hr_dev, struct hns_roce_mtt *mtt)
 		break;
 	}
 }
-EXPORT_SYMBOL_GPL(hns_roce_mtt_cleanup);
 
 static void hns_roce_loop_free(struct hns_roce_dev *hr_dev,
 			       struct hns_roce_mr *mr, int err_loop_index,
diff --git a/drivers/infiniband/hw/hns/hns_roce_pd.c b/drivers/infiniband/hw/hns/hns_roce_pd.c
index 8134013..920ca76 100644
--- a/drivers/infiniband/hw/hns/hns_roce_pd.c
+++ b/drivers/infiniband/hw/hns/hns_roce_pd.c
@@ -83,13 +83,11 @@ int hns_roce_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(hns_roce_alloc_pd);
 
 void hns_roce_dealloc_pd(struct ib_pd *pd, struct ib_udata *udata)
 {
 	hns_roce_pd_free(to_hr_dev(pd->device), to_hr_pd(pd)->pdn);
 }
-EXPORT_SYMBOL_GPL(hns_roce_dealloc_pd);
 
 int hns_roce_uar_alloc(struct hns_roce_dev *hr_dev, struct hns_roce_uar *uar)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 8db2817..a6008c4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -64,7 +64,6 @@ void hns_roce_qp_event(struct hns_roce_dev *hr_dev, u32 qpn, int event_type)
 	if (atomic_dec_and_test(&qp->refcount))
 		complete(&qp->free);
 }
-EXPORT_SYMBOL_GPL(hns_roce_qp_event);
 
 static void hns_roce_ib_qp_event(struct hns_roce_qp *hr_qp,
 				 enum hns_roce_event type)
@@ -139,7 +138,6 @@ enum hns_roce_qp_state to_hns_roce_state(enum ib_qp_state state)
 		return HNS_ROCE_QP_NUM_STATE;
 	}
 }
-EXPORT_SYMBOL_GPL(to_hns_roce_state);
 
 static int hns_roce_gsi_qp_alloc(struct hns_roce_dev *hr_dev, unsigned long qpn,
 				 struct hns_roce_qp *hr_qp)
@@ -242,7 +240,6 @@ void hns_roce_qp_remove(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 	__xa_erase(xa, hr_qp->qpn & (hr_dev->caps.num_qps - 1));
 	xa_unlock_irqrestore(xa, flags);
 }
-EXPORT_SYMBOL_GPL(hns_roce_qp_remove);
 
 void hns_roce_qp_free(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 {
@@ -260,7 +257,6 @@ void hns_roce_qp_free(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
 		hns_roce_table_put(hr_dev, &qp_table->qp_table, hr_qp->qpn);
 	}
 }
-EXPORT_SYMBOL_GPL(hns_roce_qp_free);
 
 void hns_roce_release_range_qp(struct hns_roce_dev *hr_dev, int base_qpn,
 			       int cnt)
@@ -272,7 +268,6 @@ void hns_roce_release_range_qp(struct hns_roce_dev *hr_dev, int base_qpn,
 
 	hns_roce_bitmap_free_range(&qp_table->bitmap, base_qpn, cnt, BITMAP_RR);
 }
-EXPORT_SYMBOL_GPL(hns_roce_release_range_qp);
 
 static int hns_roce_set_rq_size(struct hns_roce_dev *hr_dev,
 				struct ib_qp_cap *cap, bool is_user, int has_rq,
@@ -923,7 +918,6 @@ struct ib_qp *hns_roce_create_qp(struct ib_pd *pd,
 
 	return &hr_qp->ibqp;
 }
-EXPORT_SYMBOL_GPL(hns_roce_create_qp);
 
 int to_hr_qp_type(int qp_type)
 {
@@ -942,7 +936,6 @@ int to_hr_qp_type(int qp_type)
 
 	return transport_type;
 }
-EXPORT_SYMBOL_GPL(to_hr_qp_type);
 
 int hns_roce_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		       int attr_mask, struct ib_udata *udata)
@@ -1062,7 +1055,6 @@ void hns_roce_lock_cqs(struct hns_roce_cq *send_cq, struct hns_roce_cq *recv_cq)
 		spin_lock_nested(&send_cq->lock, SINGLE_DEPTH_NESTING);
 	}
 }
-EXPORT_SYMBOL_GPL(hns_roce_lock_cqs);
 
 void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
 			 struct hns_roce_cq *recv_cq) __releases(&send_cq->lock)
@@ -1079,7 +1071,6 @@ void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
 		spin_unlock_irq(&recv_cq->lock);
 	}
 }
-EXPORT_SYMBOL_GPL(hns_roce_unlock_cqs);
 
 static void *get_wqe(struct hns_roce_qp *hr_qp, int offset)
 {
@@ -1091,20 +1082,17 @@ void *get_recv_wqe(struct hns_roce_qp *hr_qp, int n)
 {
 	return get_wqe(hr_qp, hr_qp->rq.offset + (n << hr_qp->rq.wqe_shift));
 }
-EXPORT_SYMBOL_GPL(get_recv_wqe);
 
 void *get_send_wqe(struct hns_roce_qp *hr_qp, int n)
 {
 	return get_wqe(hr_qp, hr_qp->sq.offset + (n << hr_qp->sq.wqe_shift));
 }
-EXPORT_SYMBOL_GPL(get_send_wqe);
 
 void *get_send_extend_sge(struct hns_roce_qp *hr_qp, int n)
 {
 	return hns_roce_buf_offset(&hr_qp->hr_buf, hr_qp->sge.offset +
 					(n << hr_qp->sge.sge_shift));
 }
-EXPORT_SYMBOL_GPL(get_send_extend_sge);
 
 bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
 			  struct ib_cq *ib_cq)
@@ -1123,7 +1111,6 @@ bool hns_roce_wq_overflow(struct hns_roce_wq *hr_wq, int nreq,
 
 	return cur + nreq >= hr_wq->max_post;
 }
-EXPORT_SYMBOL_GPL(hns_roce_wq_overflow);
 
 int hns_roce_init_qp_table(struct hns_roce_dev *hr_dev)
 {
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index c222f24..787fbda 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -30,7 +30,6 @@ void hns_roce_srq_event(struct hns_roce_dev *hr_dev, u32 srqn, int event_type)
 	if (atomic_dec_and_test(&srq->refcount))
 		complete(&srq->free);
 }
-EXPORT_SYMBOL_GPL(hns_roce_srq_event);
 
 static void hns_roce_ib_srq_event(struct hns_roce_srq *srq,
 				  enum hns_roce_event event_type)
-- 
1.9.1

