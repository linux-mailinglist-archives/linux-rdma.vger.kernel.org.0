Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6242FC4A
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 15:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfE3NZy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 09:25:54 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:34991 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726589AbfE3NZy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 09:25:54 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 30 May 2019 16:25:33 +0300
Received: from r-vnc08.mtr.labs.mlnx (r-vnc08.mtr.labs.mlnx [10.208.0.121])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x4UDPVZd007883;
        Thu, 30 May 2019 16:25:33 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, sagi@grimberg.me, hch@lst.de,
        bvanassche@acm.org
Cc:     maxg@mellanox.com, israelr@mellanox.com, idanb@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 11/20] IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
Date:   Thu, 30 May 2019 16:25:22 +0300
Message-Id: <1559222731-16715-12-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Israel Rukshin <israelr@mellanox.com>

Using this new API reduces iSER code complexity.
It also reduces the maximum number of work requests per task and the need
of dealing with multiple MRs (and their registrations and invalidations)
per task. It is done by using a single WR and a special MR type
(IB_MR_TYPE_INTEGRITY) for PI operation.

The setup of the tested benchmark:
 - 2 servers with 24 cores (1 initiator and 1 target)
 - 24 target sessions with 1 LUN each
 - ramdisk backstore
 - PI active

Performance results running fio (24 jobs, 128 iodepth) using
write_generate=0 and read_verify=0 (w/w.o patch):

bs      IOPS(read)        IOPS(write)
----    ----------        ----------
512     1236.6K/1164.3K   1357.2K/1332.8K
1k      1196.5K/1163.8K   1348.4K/1262.7K
2k      1016.7K/921950    1003.7K/931230
4k      662728/600545     595423/501513
8k      385954/384345     333775/277090
16k     222864/222820     170317/170671
32k     116869/114896     82331/82244
64k     55205/54931       40264/40021

Using write_generate=1 and read_verify=1 (w/w.o patch):

bs      IOPS(read)        IOPS(write)
----    ----------        ----------
512     1090.1K/1030.9K   1303.9K/1101.4K
1k      1057.7K/904583    1318.4K/988085
2k      965226/638799     1008.6K/692514
4k      555479/410151     542414/414517
8k      298675/224964     264729/237508
16k     133485/122481     164625/138647
32k     74329/67615       80143/78743
64k     35716/35519       39294/37334

We get performance improvement at all block sizes.
The most significant improvement is when writing 4k bs (almost 30% more
iops).

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h     |  38 ++------
 drivers/infiniband/ulp/iser/iser_initiator.c |  12 ++-
 drivers/infiniband/ulp/iser/iser_memory.c    | 100 +++++++------------
 drivers/infiniband/ulp/iser/iser_verbs.c     | 140 +++++++++------------------
 4 files changed, 96 insertions(+), 194 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 36d525110fd2..6bf9eaa8ec96 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -225,13 +225,11 @@ enum iser_desc_type {
 	ISCSI_TX_DATAOUT
 };
 
-/* Maximum number of work requests per task:
- * Data memory region local invalidate + fast registration
- * Protection memory region local invalidate + fast registration
- * Signature memory region local invalidate + fast registration
- * PDU send
+/*
+ * Maximum number of work requests per task
+ * (invalidate, registration, send)
  */
-#define ISER_MAX_WRS 7
+#define ISER_MAX_WRS 3
 
 /**
  * struct iser_tx_desc - iSER TX descriptor
@@ -247,9 +245,6 @@ enum iser_desc_type {
  * @mapped:        Is the task header mapped
  * @wr_idx:        Current WR index
  * @wrs:           Array of WRs per task
- * @data_reg:      Data buffer registration details
- * @prot_reg:      Protection buffer registration details
- * @sig_attrs:     Signature attributes
  */
 struct iser_tx_desc {
 	struct iser_ctrl             iser_header;
@@ -264,11 +259,7 @@ struct iser_tx_desc {
 	union iser_wr {
 		struct ib_send_wr		send;
 		struct ib_reg_wr		fast_reg;
-		struct ib_sig_handover_wr	sig;
 	} wrs[ISER_MAX_WRS];
-	struct iser_mem_reg          data_reg;
-	struct iser_mem_reg          prot_reg;
-	struct ib_sig_attrs          sig_attrs;
 };
 
 #define ISER_RX_PAD_SIZE	(256 - (ISER_RX_PAYLOAD_SIZE + \
@@ -388,6 +379,7 @@ struct iser_device {
  *
  * @mr:         memory region
  * @fmr_pool:   pool of fmrs
+ * @sig_mr:     signature memory region
  * @page_vec:   fast reg page list used by fmr pool
  * @mr_valid:   is mr valid indicator
  */
@@ -396,36 +388,22 @@ struct iser_reg_resources {
 		struct ib_mr             *mr;
 		struct ib_fmr_pool       *fmr_pool;
 	};
+	struct ib_mr                     *sig_mr;
 	struct iser_page_vec             *page_vec;
 	u8				  mr_valid:1;
 };
 
-/**
- * struct iser_pi_context - Protection information context
- *
- * @rsc:             protection buffer registration resources
- * @sig_mr:          signature enable memory region
- * @sig_mr_valid:    is sig_mr valid indicator
- * @sig_protected:   is region protected indicator
- */
-struct iser_pi_context {
-	struct iser_reg_resources	rsc;
-	struct ib_mr                   *sig_mr;
-	u8                              sig_mr_valid:1;
-	u8                              sig_protected:1;
-};
-
 /**
  * struct iser_fr_desc - Fast registration descriptor
  *
  * @list:           entry in connection fastreg pool
  * @rsc:            data buffer registration resources
- * @pi_ctx:         protection information context
+ * @sig_protected:  is region protected indicator
  */
 struct iser_fr_desc {
 	struct list_head		  list;
 	struct iser_reg_resources	  rsc;
-	struct iser_pi_context		 *pi_ctx;
+	bool				  sig_protected;
 	struct list_head                  all_list;
 };
 
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 96af06cfe0af..5cbb4b3a0566 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -592,15 +592,14 @@ void iser_login_rsp(struct ib_cq *cq, struct ib_wc *wc)
 static inline int
 iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
 {
-	if (likely(rkey == desc->rsc.mr->rkey)) {
-		desc->rsc.mr_valid = 0;
-	} else if (likely(desc->pi_ctx && rkey == desc->pi_ctx->sig_mr->rkey)) {
-		desc->pi_ctx->sig_mr_valid = 0;
-	} else {
+	if (unlikely((!desc->sig_protected && rkey != desc->rsc.mr->rkey) ||
+		     (desc->sig_protected && rkey != desc->rsc.sig_mr->rkey))) {
 		iser_err("Bogus remote invalidation for rkey %#x\n", rkey);
 		return -EINVAL;
 	}
 
+	desc->rsc.mr_valid = 0;
+
 	return 0;
 }
 
@@ -750,6 +749,9 @@ void iser_task_rdma_init(struct iscsi_iser_task *iser_task)
 	iser_task->prot[ISER_DIR_IN].data_len  = 0;
 	iser_task->prot[ISER_DIR_OUT].data_len = 0;
 
+	iser_task->prot[ISER_DIR_IN].dma_nents = 0;
+	iser_task->prot[ISER_DIR_OUT].dma_nents = 0;
+
 	memset(&iser_task->rdma_reg[ISER_DIR_IN], 0,
 	       sizeof(struct iser_mem_reg));
 	memset(&iser_task->rdma_reg[ISER_DIR_OUT], 0,
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index f431c9b4065c..42bf0c6d3bef 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -376,17 +376,17 @@ iser_inv_rkey(struct ib_send_wr *inv_wr,
 
 static int
 iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
-		struct iser_pi_context *pi_ctx,
-		struct iser_mem_reg *data_reg,
-		struct iser_mem_reg *prot_reg,
+		struct iser_data_buf *mem,
+		struct iser_data_buf *sig_mem,
+		struct iser_reg_resources *rsc,
 		struct iser_mem_reg *sig_reg)
 {
 	struct iser_tx_desc *tx_desc = &iser_task->desc;
-	struct ib_sig_attrs *sig_attrs = &tx_desc->sig_attrs;
 	struct ib_cqe *cqe = &iser_task->iser_conn->ib_conn.reg_cqe;
-	struct ib_sig_handover_wr *wr;
-	struct ib_mr *mr = pi_ctx->sig_mr;
-	int ret;
+	struct ib_mr *mr = rsc->sig_mr;
+	struct ib_sig_attrs *sig_attrs = mr->sig_attrs;
+	struct ib_reg_wr *wr;
+	int ret, n;
 
 	memset(sig_attrs, 0, sizeof(*sig_attrs));
 	ret = iser_set_sig_attrs(iser_task->sc, sig_attrs);
@@ -395,33 +395,36 @@ iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
 
 	iser_set_prot_checks(iser_task->sc, &sig_attrs->check_mask);
 
-	if (pi_ctx->sig_mr_valid)
+	if (rsc->mr_valid)
 		iser_inv_rkey(iser_tx_next_wr(tx_desc), mr, cqe);
 
 	ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
 
-	wr = container_of(iser_tx_next_wr(tx_desc), struct ib_sig_handover_wr,
-			  wr);
-	wr->wr.opcode = IB_WR_REG_SIG_MR;
+	n = ib_map_mr_sg_pi(mr, mem->sg, mem->dma_nents, NULL,
+			    sig_mem->sg, sig_mem->dma_nents, NULL, SZ_4K);
+	if (unlikely(n != mem->dma_nents + sig_mem->dma_nents)) {
+		iser_err("failed to map sg (%d/%d)\n",
+			 n, mem->dma_nents + sig_mem->dma_nents);
+		return n < 0 ? n : -EINVAL;
+	}
+
+	wr = container_of(iser_tx_next_wr(tx_desc), struct ib_reg_wr, wr);
+	memset(wr, 0, sizeof(*wr));
+	wr->wr.opcode = IB_WR_REG_MR_INTEGRITY;
 	wr->wr.wr_cqe = cqe;
-	wr->wr.sg_list = &data_reg->sge;
-	wr->wr.num_sge = 1;
+	wr->wr.num_sge = 0;
 	wr->wr.send_flags = 0;
-	wr->sig_attrs = sig_attrs;
-	wr->sig_mr = mr;
-	if (scsi_prot_sg_count(iser_task->sc))
-		wr->prot = &prot_reg->sge;
-	else
-		wr->prot = NULL;
-	wr->access_flags = IB_ACCESS_LOCAL_WRITE |
-			   IB_ACCESS_REMOTE_READ |
-			   IB_ACCESS_REMOTE_WRITE;
-	pi_ctx->sig_mr_valid = 1;
+	wr->mr = mr;
+	wr->key = mr->rkey;
+	wr->access = IB_ACCESS_LOCAL_WRITE |
+		     IB_ACCESS_REMOTE_READ |
+		     IB_ACCESS_REMOTE_WRITE;
+	rsc->mr_valid = 1;
 
 	sig_reg->sge.lkey = mr->lkey;
 	sig_reg->rkey = mr->rkey;
-	sig_reg->sge.addr = 0;
-	sig_reg->sge.length = scsi_transfer_length(iser_task->sc);
+	sig_reg->sge.addr = mr->iova;
+	sig_reg->sge.length = mr->length;
 
 	iser_dbg("lkey=0x%x rkey=0x%x addr=0x%llx length=%u\n",
 		 sig_reg->sge.lkey, sig_reg->rkey, sig_reg->sge.addr,
@@ -477,21 +480,6 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 	return 0;
 }
 
-static int
-iser_reg_prot_sg(struct iscsi_iser_task *task,
-		 struct iser_data_buf *mem,
-		 struct iser_fr_desc *desc,
-		 bool use_dma_key,
-		 struct iser_mem_reg *reg)
-{
-	struct iser_device *device = task->iser_conn->ib_conn.device;
-
-	if (use_dma_key)
-		return iser_reg_dma(device, mem, reg);
-
-	return device->reg_ops->reg_mem(task, mem, &desc->pi_ctx->rsc, reg);
-}
-
 static int
 iser_reg_data_sg(struct iscsi_iser_task *task,
 		 struct iser_data_buf *mem,
@@ -515,7 +503,6 @@ int iser_reg_rdma_mem(struct iscsi_iser_task *task,
 	struct iser_device *device = ib_conn->device;
 	struct iser_data_buf *mem = &task->data[dir];
 	struct iser_mem_reg *reg = &task->rdma_reg[dir];
-	struct iser_mem_reg *data_reg;
 	struct iser_fr_desc *desc = NULL;
 	bool use_dma_key;
 	int err;
@@ -528,32 +515,17 @@ int iser_reg_rdma_mem(struct iscsi_iser_task *task,
 		reg->mem_h = desc;
 	}
 
-	if (scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL)
-		data_reg = reg;
-	else
-		data_reg = &task->desc.data_reg;
-
-	err = iser_reg_data_sg(task, mem, desc, use_dma_key, data_reg);
-	if (unlikely(err))
-		goto err_reg;
-
-	if (scsi_get_prot_op(task->sc) != SCSI_PROT_NORMAL) {
-		struct iser_mem_reg *prot_reg = &task->desc.prot_reg;
-
-		if (scsi_prot_sg_count(task->sc)) {
-			mem = &task->prot[dir];
-			err = iser_reg_prot_sg(task, mem, desc,
-					       use_dma_key, prot_reg);
-			if (unlikely(err))
-				goto err_reg;
-		}
-
-		err = iser_reg_sig_mr(task, desc->pi_ctx, data_reg,
-				      prot_reg, reg);
+	if (scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL) {
+		err = iser_reg_data_sg(task, mem, desc, use_dma_key, reg);
+		if (unlikely(err))
+			goto err_reg;
+	} else {
+		err = iser_reg_sig_mr(task, mem, &task->prot[dir],
+				      &desc->rsc, reg);
 		if (unlikely(err))
 			goto err_reg;
 
-		desc->pi_ctx->sig_protected = 1;
+		desc->sig_protected = 1;
 	}
 
 	return 0;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index 4ff3d98fa6a4..ffd6bbc819f7 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -233,116 +233,63 @@ void iser_free_fmr_pool(struct ib_conn *ib_conn)
 	kfree(desc);
 }
 
-static int
-iser_alloc_reg_res(struct iser_device *device,
-		   struct ib_pd *pd,
-		   struct iser_reg_resources *res,
-		   unsigned int size)
+static struct iser_fr_desc *
+iser_create_fastreg_desc(struct iser_device *device,
+			 struct ib_pd *pd,
+			 bool pi_enable,
+			 unsigned int size)
 {
+	struct iser_fr_desc *desc;
 	struct ib_device *ib_dev = device->ib_device;
 	enum ib_mr_type mr_type;
 	int ret;
 
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return ERR_PTR(-ENOMEM);
+
 	if (ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
 		mr_type = IB_MR_TYPE_SG_GAPS;
 	else
 		mr_type = IB_MR_TYPE_MEM_REG;
 
-	res->mr = ib_alloc_mr(pd, mr_type, size);
-	if (IS_ERR(res->mr)) {
-		ret = PTR_ERR(res->mr);
+	desc->rsc.mr = ib_alloc_mr(pd, mr_type, size);
+	if (IS_ERR(desc->rsc.mr)) {
+		ret = PTR_ERR(desc->rsc.mr);
 		iser_err("Failed to allocate ib_fast_reg_mr err=%d\n", ret);
-		return ret;
-	}
-	res->mr_valid = 0;
-
-	return 0;
-}
-
-static void
-iser_free_reg_res(struct iser_reg_resources *rsc)
-{
-	ib_dereg_mr(rsc->mr);
-}
-
-static int
-iser_alloc_pi_ctx(struct iser_device *device,
-		  struct ib_pd *pd,
-		  struct iser_fr_desc *desc,
-		  unsigned int size)
-{
-	struct iser_pi_context *pi_ctx = NULL;
-	int ret;
-
-	desc->pi_ctx = kzalloc(sizeof(*desc->pi_ctx), GFP_KERNEL);
-	if (!desc->pi_ctx)
-		return -ENOMEM;
-
-	pi_ctx = desc->pi_ctx;
-
-	ret = iser_alloc_reg_res(device, pd, &pi_ctx->rsc, size);
-	if (ret) {
-		iser_err("failed to allocate reg_resources\n");
-		goto alloc_reg_res_err;
+		goto err_alloc_mr;
 	}
 
-	pi_ctx->sig_mr = ib_alloc_mr(pd, IB_MR_TYPE_SIGNATURE, 2);
-	if (IS_ERR(pi_ctx->sig_mr)) {
-		ret = PTR_ERR(pi_ctx->sig_mr);
-		goto sig_mr_failure;
+	if (pi_enable) {
+		desc->rsc.sig_mr = ib_alloc_mr_integrity(pd, size, size);
+		if (IS_ERR(desc->rsc.sig_mr)) {
+			ret = PTR_ERR(desc->rsc.sig_mr);
+			iser_err("Failed to allocate sig_mr err=%d\n", ret);
+			goto err_alloc_mr_integrity;
+		}
 	}
-	pi_ctx->sig_mr_valid = 0;
-	desc->pi_ctx->sig_protected = 0;
+	desc->rsc.mr_valid = 0;
 
-	return 0;
+	return desc;
 
-sig_mr_failure:
-	iser_free_reg_res(&pi_ctx->rsc);
-alloc_reg_res_err:
-	kfree(desc->pi_ctx);
+err_alloc_mr_integrity:
+	ib_dereg_mr(desc->rsc.mr);
+err_alloc_mr:
+	kfree(desc);
 
-	return ret;
+	return ERR_PTR(ret);
 }
 
-static void
-iser_free_pi_ctx(struct iser_pi_context *pi_ctx)
+static void iser_destroy_fastreg_desc(struct iser_fr_desc *desc)
 {
-	iser_free_reg_res(&pi_ctx->rsc);
-	ib_dereg_mr(pi_ctx->sig_mr);
-	kfree(pi_ctx);
-}
-
-static struct iser_fr_desc *
-iser_create_fastreg_desc(struct iser_device *device,
-			 struct ib_pd *pd,
-			 bool pi_enable,
-			 unsigned int size)
-{
-	struct iser_fr_desc *desc;
-	int ret;
+	struct iser_reg_resources *res = &desc->rsc;
 
-	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-	if (!desc)
-		return ERR_PTR(-ENOMEM);
-
-	ret = iser_alloc_reg_res(device, pd, &desc->rsc, size);
-	if (ret)
-		goto reg_res_alloc_failure;
-
-	if (pi_enable) {
-		ret = iser_alloc_pi_ctx(device, pd, desc, size);
-		if (ret)
-			goto pi_ctx_alloc_failure;
+	ib_dereg_mr(res->mr);
+	if (res->sig_mr) {
+		ib_dereg_mr(res->sig_mr);
+		res->sig_mr = NULL;
 	}
-
-	return desc;
-
-pi_ctx_alloc_failure:
-	iser_free_reg_res(&desc->rsc);
-reg_res_alloc_failure:
 	kfree(desc);
-
-	return ERR_PTR(ret);
 }
 
 /**
@@ -399,10 +346,7 @@ void iser_free_fastreg_pool(struct ib_conn *ib_conn)
 
 	list_for_each_entry_safe(desc, tmp, &fr_pool->all_list, all_list) {
 		list_del(&desc->all_list);
-		iser_free_reg_res(&desc->rsc);
-		if (desc->pi_ctx)
-			iser_free_pi_ctx(desc->pi_ctx);
-		kfree(desc);
+		iser_destroy_fastreg_desc(desc);
 		++i;
 	}
 
@@ -707,6 +651,7 @@ iser_calc_scsi_params(struct iser_conn *iser_conn,
 	struct ib_device_attr *attr = &device->ib_device->attrs;
 	unsigned short sg_tablesize, sup_sg_tablesize;
 	unsigned short reserved_mr_pages;
+	u32 max_num_sg;
 
 	/*
 	 * FRs without SG_GAPS or FMRs can only map up to a (device) page per
@@ -720,12 +665,17 @@ iser_calc_scsi_params(struct iser_conn *iser_conn,
 	else
 		reserved_mr_pages = 1;
 
+	if (iser_conn->ib_conn.pi_support)
+		max_num_sg = attr->max_pi_fast_reg_page_list_len;
+	else
+		max_num_sg = attr->max_fast_reg_page_list_len;
+
 	sg_tablesize = DIV_ROUND_UP(max_sectors * 512, SIZE_4K);
 	if (attr->device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS)
 		sup_sg_tablesize =
 			min_t(
 			 uint, ISCSI_ISER_MAX_SG_TABLESIZE,
-			 attr->max_fast_reg_page_list_len - reserved_mr_pages);
+			 max_num_sg - reserved_mr_pages);
 	else
 		sup_sg_tablesize = ISCSI_ISER_MAX_SG_TABLESIZE;
 
@@ -1118,9 +1068,9 @@ u8 iser_check_task_pi_status(struct iscsi_iser_task *iser_task,
 	struct ib_mr_status mr_status;
 	int ret;
 
-	if (desc && desc->pi_ctx->sig_protected) {
-		desc->pi_ctx->sig_protected = 0;
-		ret = ib_check_mr_status(desc->pi_ctx->sig_mr,
+	if (desc && desc->sig_protected) {
+		desc->sig_protected = 0;
+		ret = ib_check_mr_status(desc->rsc.sig_mr,
 					 IB_MR_CHECK_SIG_STATUS, &mr_status);
 		if (ret) {
 			pr_err("ib_check_mr_status failed, ret %d\n", ret);
-- 
2.16.3

