Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78D0CEBBEF
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2019 03:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKACR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 31 Oct 2019 22:17:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfKACR0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 31 Oct 2019 22:17:26 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6B8BF2D7281720D95CF8;
        Fri,  1 Nov 2019 10:17:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Fri, 1 Nov 2019 10:17:17 +0800
From:   Weihang Li <liweihang@hisilicon.com>
To:     <jgg@ziepe.ca>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH rdma-core] libhns: Use syslog for debugging while no print by default
Date:   Fri, 1 Nov 2019 10:13:45 +0800
Message-ID: <1572574425-41927-1-git-send-email-liweihang@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

There should be no fprintf/printf in libraries by default unless
debugging. So replace all fprintf/printf in libhns with a macro that is
controlled by HNS_ROCE_DEBUG.
This patch also standardizes all printtings to maintain a uniform style.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
---
 providers/hns/hns_roce_u.c       | 12 +++++++-----
 providers/hns/hns_roce_u.h       | 13 +++++++++++--
 providers/hns/hns_roce_u_hw_v1.c | 28 ++++++++++++++--------------
 providers/hns/hns_roce_u_hw_v2.c | 18 +++++++++---------
 providers/hns/hns_roce_u_verbs.c | 36 ++++++++++++++++++------------------
 5 files changed, 59 insertions(+), 48 deletions(-)

diff --git a/providers/hns/hns_roce_u.c b/providers/hns/hns_roce_u.c
index 5872599..8433a90 100644
--- a/providers/hns/hns_roce_u.c
+++ b/providers/hns/hns_roce_u.c
@@ -115,7 +115,7 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 	context->uar = mmap(NULL, to_hr_dev(ibdev)->page_size,
 			    PROT_READ | PROT_WRITE, MAP_SHARED, cmd_fd, 0);
 	if (context->uar == MAP_FAILED) {
-		fprintf(stderr, PFX "Warning: failed to mmap() uar page.\n");
+		HR_LOG("Failed to mmap() uar page!\n");
 		goto err_free;
 	}
 
@@ -128,8 +128,7 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 					     PROT_READ | PROT_WRITE, MAP_SHARED,
 					     cmd_fd, HNS_ROCE_TPTR_OFFSET);
 		if (context->cq_tptr_base == MAP_FAILED) {
-			fprintf(stderr,
-				PFX "Warning: Failed to mmap cq_tptr page.\n");
+			HR_LOG("Failed to mmap() cq_tptr page!\n");
 			goto db_free;
 		}
 	}
@@ -150,8 +149,9 @@ static struct verbs_context *hns_roce_alloc_context(struct ibv_device *ibdev,
 
 tptr_free:
 	if (hr_dev->hw_version == HNS_ROCE_HW_VER1) {
-		if (munmap(context->cq_tptr_base, HNS_ROCE_CQ_DB_BUF_SIZE))
-			fprintf(stderr, PFX "Warning: Munmap tptr failed.\n");
+		if (munmap(context->cq_tptr_base, HNS_ROCE_CQ_DB_BUF_SIZE)) {
+			HR_LOG("Failed to munmap() cq_tptr page!\n");
+		}
 		context->cq_tptr_base = NULL;
 	}
 
@@ -192,6 +192,8 @@ static struct verbs_device *hns_device_alloc(struct verbs_sysfs_dev *sysfs_dev)
 	if (!dev)
 		return NULL;
 
+	OPEN_LOG("hns");
+
 	dev->u_hw = sysfs_dev->match->driver_data;
 	dev->hw_version = dev->u_hw->hw_version;
 	dev->page_size   = sysconf(_SC_PAGESIZE);
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 23e0f13..da397a9 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -47,8 +47,6 @@
 
 #define HNS_ROCE_HW_VER2		('h' << 24 | 'i' << 16 | '0' << 8 | '8')
 
-#define PFX				"hns: "
-
 #define HNS_ROCE_MAX_INLINE_DATA_LEN	32
 #define HNS_ROCE_MAX_CQ_NUM		0x10000
 #define HNS_ROCE_MAX_SRQWQE_NUM		0x8000
@@ -56,6 +54,17 @@
 #define HNS_ROCE_MIN_CQE_NUM		0x40
 #define HNS_ROCE_MIN_WQE_NUM		0x20
 
+#ifdef HNS_ROCE_DEBUG
+#include <syslog.h>
+#define OPEN_LOG(s)			openlog(s, LOG_NDELAY|LOG_PID, LOG_USER)
+#define HR_LOG_DBG(level, fmt, args...)	syslog(level, fmt, ##args)
+#define HR_LOG(fmt, args...)		syslog(LOG_ERR, fmt, ##args)
+#else
+#define OPEN_LOG(s)
+#define HR_LOG_DBG(level, fmt, args...)
+#define HR_LOG(fmt, args...)
+#endif
+
 #define HNS_ROCE_CQE_ENTRY_SIZE		0x20
 #define HNS_ROCE_SQWQE_SHIFT		6
 #define HNS_ROCE_SGE_IN_WQE		2
diff --git a/providers/hns/hns_roce_u_hw_v1.c b/providers/hns/hns_roce_u_hw_v1.c
index fceb57a..9324bce 100644
--- a/providers/hns/hns_roce_u_hw_v1.c
+++ b/providers/hns/hns_roce_u_hw_v1.c
@@ -117,7 +117,7 @@ static void hns_roce_update_cq_cons_index(struct hns_roce_context *ctx,
 static void hns_roce_handle_error_cqe(struct hns_roce_cqe *cqe,
 				      struct ibv_wc *wc)
 {
-	fprintf(stderr, PFX "error cqe!\n");
+	HR_LOG("Error cqe!\n");
 	switch (roce_get_field(cqe->cqe_byte_4,
 			       CQE_BYTE_4_STATUS_OF_THE_OPERATION_M,
 			       CQE_BYTE_4_STATUS_OF_THE_OPERATION_S) &
@@ -185,7 +185,8 @@ static struct hns_roce_cqe *next_cqe_sw(struct hns_roce_cq *cq)
 static void *get_recv_wqe(struct hns_roce_qp *qp, int n)
 {
 	if ((n < 0) || (n > qp->rq.wqe_cnt)) {
-		printf("rq wqe index:%d,rq wqe cnt:%d\r\n", n, qp->rq.wqe_cnt);
+		HR_LOG("rq wqe index = %d, rq wqe cnt = %d\n", n,
+		       qp->rq.wqe_cnt);
 		return NULL;
 	}
 
@@ -195,7 +196,8 @@ static void *get_recv_wqe(struct hns_roce_qp *qp, int n)
 static void *get_send_wqe(struct hns_roce_qp *qp, int n)
 {
 	if ((n < 0) || (n > qp->sq.wqe_cnt)) {
-		printf("sq wqe index:%d,sq wqe cnt:%d\r\n", n, qp->sq.wqe_cnt);
+		HR_LOG("sq wqe index = %d, sq wqe cnt = %d\n", n,
+		       qp->sq.wqe_cnt);
 		return NULL;
 	}
 
@@ -216,8 +218,8 @@ static int hns_roce_wq_overflow(struct hns_roce_wq *wq, int nreq,
 	cur = wq->head - wq->tail;
 	pthread_spin_unlock(&cq->lock);
 
-	printf("wq:(head = %d, tail = %d, max_post = %d), nreq = 0x%x\n",
-		wq->head, wq->tail, wq->max_post, nreq);
+	HR_LOG("wq: (head = %d, tail = %d, max_post = %d), nreq = 0x%x\n",
+	       wq->head, wq->tail, wq->max_post, nreq);
 
 	return cur + nreq >= wq->max_post;
 }
@@ -227,12 +229,10 @@ static struct hns_roce_qp *hns_roce_find_qp(struct hns_roce_context *ctx,
 {
 	int tind = (qpn & (ctx->num_qps - 1)) >> ctx->qp_table_shift;
 
-	if (ctx->qp_table[tind].refcnt) {
+	if (ctx->qp_table[tind].refcnt)
 		return ctx->qp_table[tind].table[qpn & ctx->qp_table_mask];
-	} else {
-		printf("hns_roce_find_qp fail!\n");
+	else
 		return NULL;
-	}
 }
 
 static void hns_roce_clear_qp(struct hns_roce_context *ctx, uint32_t qpn)
@@ -282,7 +282,7 @@ static int hns_roce_v1_poll_one(struct hns_roce_cq *cq,
 		*cur_qp = hns_roce_find_qp(to_hr_ctx(cq->ibv_cq.context),
 					   qpn & 0xffffff);
 		if (!*cur_qp) {
-			fprintf(stderr, PFX "can't find qp!\n");
+			HR_LOG("Failed to find qp!\n");
 			return CQ_POLL_ERR;
 		}
 	}
@@ -487,8 +487,8 @@ static int hns_roce_u_v1_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 		if (wr->num_sge > qp->sq.max_gs) {
 			ret = -1;
 			*bad_wr = wr;
-			printf("wr->num_sge(<=%d) = %d, check failed!\r\n",
-				qp->sq.max_gs, wr->num_sge);
+			HR_LOG("sge_num(<=%d) = %d, check failed!\n",
+			       qp->sq.max_gs, wr->num_sge);
 			goto out;
 		}
 
@@ -557,7 +557,7 @@ static int hns_roce_u_v1_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			if (le32toh(ctrl->msg_length) > qp->max_inline_data) {
 				ret = -1;
 				*bad_wr = wr;
-				printf("inline data len(1-32)=%d, send_flags = 0x%x, check failed!\r\n",
+				HR_LOG("inline data len(1-32) = %d, send_flags = 0x%x, check failed!\n",
 					wr->send_flags, ctrl->msg_length);
 				return ret;
 			}
@@ -664,7 +664,7 @@ static int hns_roce_u_v1_modify_qp(struct ibv_qp *qp, struct ibv_qp_attr *attr,
 
 	if (!ret && (attr_mask & IBV_QP_PORT)) {
 		hr_qp->port_num = attr->port_num;
-		printf("hr_qp->port_num= 0x%x\n", hr_qp->port_num);
+		HR_LOG("port num = 0x%x\n", hr_qp->port_num);
 	}
 
 	hr_qp->sl = attr->ah_attr.sl;
diff --git a/providers/hns/hns_roce_u_hw_v2.c b/providers/hns/hns_roce_u_hw_v2.c
index 931f59d..57c6389 100644
--- a/providers/hns/hns_roce_u_hw_v2.c
+++ b/providers/hns/hns_roce_u_hw_v2.c
@@ -131,7 +131,8 @@ static struct hns_roce_v2_cqe *next_cqe_sw_v2(struct hns_roce_cq *cq)
 static void *get_recv_wqe_v2(struct hns_roce_qp *qp, int n)
 {
 	if ((n < 0) || (n > qp->rq.wqe_cnt)) {
-		printf("rq wqe index:%d,rq wqe cnt:%d\r\n", n, qp->rq.wqe_cnt);
+		HR_LOG("rq wqe index = %d, rq wqe cnt = %d\n", n,
+		       qp->rq.wqe_cnt);
 		return NULL;
 	}
 
@@ -288,7 +289,7 @@ static int hns_roce_flush_cqe(struct hns_roce_qp **cur_qp, struct ibv_wc *wc)
 		ret = hns_roce_u_v2_modify_qp(&(*cur_qp)->ibv_qp,
 						      &attr, attr_mask);
 		if (ret) {
-			fprintf(stderr, PFX "failed to modify qp!\n");
+			HR_LOG("Failed to modify qp!\n");
 			return ret;
 		}
 		(*cur_qp)->ibv_qp.state = IBV_QPS_ERR;
@@ -470,7 +471,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *cq,
 		*cur_qp = hns_roce_v2_find_qp(to_hr_ctx(cq->ibv_cq.context),
 					      qpn & 0xffffff);
 		if (!*cur_qp) {
-			fprintf(stderr, PFX "can't find qp!\n");
+			HR_LOG("Failed to find qp!\n");
 			return V2_CQ_POLL_ERR;
 		}
 	}
@@ -536,8 +537,7 @@ static int hns_roce_v2_poll_one(struct hns_roce_cq *cq,
 
 		ret = hns_roce_handle_recv_inl_wqe(cqe, cur_qp, wc, opcode);
 		if (ret) {
-			fprintf(stderr,
-				PFX "failed to handle recv inline wqe!\n");
+			HR_LOG("Failed to handle recv inline wqe!\n");
 			return ret;
 		}
 	}
@@ -824,7 +824,7 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 					       RC_SQ_WQE_BYTE_4_OPCODE_M,
 					       RC_SQ_WQE_BYTE_4_OPCODE_S,
 					       HNS_ROCE_WQE_OP_MASK);
-				printf("Not supported transport opcode %d\n",
+				HR_LOG("Not supported transport opcode %d\n",
 				       wr->opcode);
 				break;
 			}
@@ -846,15 +846,15 @@ int hns_roce_u_v2_post_send(struct ibv_qp *ibvqp, struct ibv_send_wr *wr,
 			if (le32toh(rc_sq_wqe->msg_len) > qp->max_inline_data) {
 				ret = EINVAL;
 				*bad_wr = wr;
-				printf("data len=%d, send_flags = 0x%x!\r\n",
-					rc_sq_wqe->msg_len, wr->send_flags);
+				HR_LOG("data len = %d, send_flags = 0x%x!\n",
+				       rc_sq_wqe->msg_len, wr->send_flags);
 				goto out;
 			}
 
 			if (wr->opcode == IBV_WR_RDMA_READ) {
 				ret = EINVAL;
 				*bad_wr = wr;
-				printf("Not supported inline data!\n");
+				HR_LOG("Not supported inline data!\n");
 				goto out;
 			}
 
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 9d222c0..bda019c 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -128,12 +128,12 @@ struct ibv_mr *hns_roce_u_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	struct ib_uverbs_reg_mr_resp resp;
 
 	if (!addr) {
-		fprintf(stderr, "2nd parm addr is NULL!\n");
+		HR_LOG("Invalid addr to register mr!\n");
 		return NULL;
 	}
 
 	if (!length) {
-		fprintf(stderr, "3st parm length is 0!\n");
+		HR_LOG("Invalid length to register mr!\n");
 		return NULL;
 	}
 
@@ -491,12 +491,12 @@ struct ibv_srq *hns_roce_u_create_srq(struct ibv_pd *pd,
 
 	ret = hns_roce_create_idx_que(pd, srq);
 	if (ret) {
-		fprintf(stderr, "hns_roce_create_idx_que failed!\n");
+		HR_LOG("Failed to create index queue!\n");
 		goto out;
 	}
 
 	if (hns_roce_alloc_srq_buf(pd, &srq_init_attr->attr, srq)) {
-		fprintf(stderr, "hns_roce_alloc_srq_buf failed!\n");
+		HR_LOG("Failed to allocate srq buffer!\n");
 		goto err_idx_que;
 	}
 
@@ -577,17 +577,17 @@ static int hns_roce_verify_qp(struct ibv_qp_init_attr *attr,
 
 	if (hr_dev->hw_version == HNS_ROCE_HW_VER1) {
 		if (attr->cap.max_send_wr < HNS_ROCE_MIN_WQE_NUM) {
-			fprintf(stderr,
-				"max_send_wr = %d, less than minimum WQE number.\n",
-				attr->cap.max_send_wr);
-				attr->cap.max_send_wr = HNS_ROCE_MIN_WQE_NUM;
+			HR_LOG_DBG(LOG_WARNING,
+				   "max_send_wr = %d, less than minimum WQE.\n",
+				   attr->cap.max_send_wr);
+			attr->cap.max_send_wr = HNS_ROCE_MIN_WQE_NUM;
 		}
 
 		if (attr->cap.max_recv_wr < HNS_ROCE_MIN_WQE_NUM) {
-			fprintf(stderr,
-				"max_recv_wr = %d, less than minimum WQE number.\n",
-				attr->cap.max_recv_wr);
-				attr->cap.max_recv_wr = HNS_ROCE_MIN_WQE_NUM;
+			HR_LOG_DBG(LOG_WARNING,
+				   "max_recv_wr = %d, less than minimum WQE.\n",
+				   attr->cap.max_recv_wr);
+			attr->cap.max_recv_wr = HNS_ROCE_MIN_WQE_NUM;
 		}
 	}
 
@@ -849,20 +849,20 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 	struct hns_roce_context *context = to_hr_ctx(pd->context);
 
 	if (hns_roce_verify_qp(attr, context)) {
-		fprintf(stderr, "hns_roce_verify_sizes failed!\n");
+		HR_LOG("Failed to verify qp!\n");
 		return NULL;
 	}
 
 	qp = malloc(sizeof(*qp));
 	if (!qp) {
-		fprintf(stderr, "malloc failed!\n");
+		HR_LOG("Failed to allocate qp!\n");
 		return NULL;
 	}
 
 	hns_roce_set_qp_params(pd, attr, qp, context);
 
 	if (hns_roce_alloc_qp_buf(pd, &attr->cap, attr->qp_type, qp)) {
-		fprintf(stderr, "hns_roce_alloc_qp_buf failed!\n");
+		HR_LOG("Failed to allocate qp buffer!\n");
 		goto err_buf;
 	}
 
@@ -870,7 +870,7 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 
 	if (pthread_spin_init(&qp->sq.lock, PTHREAD_PROCESS_PRIVATE) ||
 	    pthread_spin_init(&qp->rq.lock, PTHREAD_PROCESS_PRIVATE)) {
-		fprintf(stderr, "pthread_spin_init failed!\n");
+		HR_LOG("Failed to pthread_spin_init()!\n");
 		goto err_free;
 	}
 
@@ -891,13 +891,13 @@ struct ibv_qp *hns_roce_u_create_qp(struct ibv_pd *pd,
 	ret = ibv_cmd_create_qp(pd, &qp->ibv_qp, attr, &cmd.ibv_cmd,
 				sizeof(cmd), &resp.ibv_resp, sizeof(resp));
 	if (ret) {
-		fprintf(stderr, "ibv_cmd_create_qp failed!\n");
+		HR_LOG("Failed to create qp!\n");
 		goto err_rq_db;
 	}
 
 	ret = hns_roce_store_qp(context, qp->ibv_qp.qp_num, qp);
 	if (ret) {
-		fprintf(stderr, "hns_roce_store_qp failed!\n");
+		HR_LOG("Failed to store qp!\n");
 		goto err_destroy;
 	}
 	pthread_mutex_unlock(&context->qp_table_mutex);
-- 
2.8.1

