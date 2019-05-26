Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA442A906
	for <lists+linux-rdma@lfdr.de>; Sun, 26 May 2019 10:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfEZIDK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 May 2019 04:03:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52598 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfEZIDJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 May 2019 04:03:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4Q7scEN171033;
        Sun, 26 May 2019 08:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=je/g4HxJ/zOhBc5rodppU6qpeqwgUgHTnRYPe2EyvRc=;
 b=w8GzVQa2Se6vyyxc3g4nriISgaA5ElNd3F3E5CCpYqi/m+f3u63Iiy5m7uchVMHSTQsS
 IvETE4Tu8VR1+dEbJN+OMRmvG/OewJi4Jk2UF4AdHTiU7O0NWtzCbE8gkcGSBC5zf2ar
 fFi+0IhLXgDH7rPzO+HlybLr4gR/kBwr9hWtDG7x5ql/17Ivb5UjLbdUmzy1g97W1X/b
 RunNw/fDYQ4rWUgAvS1fWvppWNzZqiryAJHM61gfehBPwmFlKByWl0byOwsrbLeExlM/
 EDc11wb8yHlnmgOad4uLrohtExdZ+2V27Wwuni5yXwyeS4ItiE/RnL0FcKVtm5wI5RBv QA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2spxbpt7ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 May 2019 08:02:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4Q82S1O071329;
        Sun, 26 May 2019 08:02:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2sqh72aagh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 26 May 2019 08:02:39 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4Q82aMR030435;
        Sun, 26 May 2019 08:02:37 GMT
Received: from host4.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 May 2019 08:02:36 +0000
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     yishaih@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org, jgg@mellanox.com
Cc:     Yuval Shaia <yuval.shaia@oracle.com>
Subject: [RFC] verbs: Introduce a new reg_mr API for virtual address space
Date:   Sun, 26 May 2019 11:02:24 +0300
Message-Id: <20190526080224.2778-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9268 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905260057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9268 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905260056
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The virtual address that is registered is used as a base for any address
used later in post_recv and post_send operations.

On a virtualised environment this is not correct.

A guest cannot register its memory so hypervisor maps the guest physical
address to a host virtual address and register it with the HW. Later on,
at datapath phase, the guest fills the SGEs with addresses from its
address space.
Since HW cannot access guest virtual address space an extra translation
is needed map those addresses to be based on the host virtual address
that was registered with the HW.

To avoid this, a logical separation between the address that is
registered and the address that is used as a offset at datapath phase is
needed.
This separation is already implemented in the lower layer part
(ibv_cmd_reg_mr) but blocked at the API level.

Fix it by introducing a new API function that accepts a address from
guest virtual address space as well.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 libibverbs/driver.h    |  3 +++
 libibverbs/dummy_ops.c | 10 ++++++++++
 libibverbs/verbs.h     | 26 ++++++++++++++++++++++++++
 providers/rxe/rxe.c    | 16 ++++++++++++----
 4 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index e4d624b2..73bc10e6 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -339,6 +339,9 @@ struct verbs_context_ops {
 				    unsigned int access);
 	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
 				 int access);
+	struct ibv_mr *(*reg_mr_virt_as)(struct ibv_pd *pd, void *addr,
+					 size_t length, uint64_t hca_va,
+					 int access);
 	int (*req_notify_cq)(struct ibv_cq *cq, int solicited_only);
 	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
 			void *addr, size_t length, int access);
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index c861c3a0..aab61a17 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -416,6 +416,14 @@ static struct ibv_mr *reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	return NULL;
 }
 
+static struct ibv_mr *reg_mr_virt_as(struct ibv_pd *pd, void *addr,
+				     size_t length, uint64_t hca_va,
+				     int access)
+{
+	errno = ENOSYS;
+	return NULL;
+}
+
 static int req_notify_cq(struct ibv_cq *cq, int solicited_only)
 {
 	return ENOSYS;
@@ -508,6 +516,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	read_counters,
 	reg_dm_mr,
 	reg_mr,
+	reg_mr_virt_as,
 	req_notify_cq,
 	rereg_mr,
 	resize_cq,
@@ -623,6 +632,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_PRIV_OP(ctx, query_srq);
 	SET_OP(vctx, reg_dm_mr);
 	SET_PRIV_OP(ctx, reg_mr);
+	SET_OP(vctx, reg_mr_virt_as);
 	SET_OP(ctx, req_notify_cq);
 	SET_PRIV_OP(ctx, rereg_mr);
 	SET_PRIV_OP(ctx, resize_cq);
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index cb2d8439..8bcc8388 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2037,6 +2037,9 @@ struct verbs_context {
 	struct ibv_mr *(*reg_dm_mr)(struct ibv_pd *pd, struct ibv_dm *dm,
 				    uint64_t dm_offset, size_t length,
 				    unsigned int access);
+	struct ibv_mr *(*reg_mr_virt_as)(struct ibv_pd *pd, void *addr,
+					 size_t length, uint64_t hca_va,
+					 int access);
 	struct ibv_dm *(*alloc_dm)(struct ibv_context *context,
 				   struct ibv_alloc_dm_attr *attr);
 	int (*free_dm)(struct ibv_dm *dm);
@@ -2574,6 +2577,29 @@ struct ibv_mr *ibv_reg_dm_mr(struct ibv_pd *pd, struct ibv_dm *dm,
 	return vctx->reg_dm_mr(pd, dm, dm_offset, length, access);
 }
 
+/**
+ * ibv_reg_mr_virt_as - Register MR for virtual address
+ * @pd - The PD to associated this MR with
+ * @addr - Address to register
+ * @length - Number of bytes to register
+ * @hca_va - Virtual Address
+ * @access - memory region access flags
+ */
+static inline
+struct ibv_mr *ibv_reg_mr_virt_as(struct ibv_pd *pd, void *addr, size_t length,
+				  uint64_t hca_va, int access)
+{
+	struct verbs_context *vctx = verbs_get_ctx_op(pd->context,
+						      reg_mr_virt_as);
+
+	if (!vctx) {
+		errno = ENOSYS;
+		return NULL;
+	}
+
+	return vctx->reg_mr_virt_as(pd, addr, length, hca_va, access);
+}
+
 /**
  * ibv_create_cq - Create a completion queue
  * @context - Context CQ will be attached to
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 909c3f7b..e7246da9 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -122,8 +122,9 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
 	return ret;
 }
 
-static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-				 int access)
+static struct ibv_mr *rxe_reg_mr_virt_as(struct ibv_pd *pd, void *addr,
+					 size_t length, uint64_t hca_va,
+					 int access)
 {
 	struct verbs_mr *vmr;
 	struct ibv_reg_mr cmd;
@@ -134,8 +135,8 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	if (!vmr)
 		return NULL;
 
-	ret = ibv_cmd_reg_mr(pd, addr, length, (uintptr_t)addr, access, vmr,
-			     &cmd, sizeof cmd, &resp, sizeof resp);
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
 	if (ret) {
 		free(vmr);
 		return NULL;
@@ -144,6 +145,12 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	return &vmr->ibv_mr;
 }
 
+static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+				 int access)
+{
+	return rxe_reg_mr_virt_as(pd, addr, length, (uint64_t) addr, access);
+}
+
 static int rxe_dereg_mr(struct verbs_mr *vmr)
 {
 	int ret;
@@ -836,6 +843,7 @@ static const struct verbs_context_ops rxe_ctx_ops = {
 	.alloc_pd = rxe_alloc_pd,
 	.dealloc_pd = rxe_dealloc_pd,
 	.reg_mr = rxe_reg_mr,
+	.reg_mr_virt_as = rxe_reg_mr_virt_as,
 	.dereg_mr = rxe_dereg_mr,
 	.create_cq = rxe_create_cq,
 	.poll_cq = rxe_poll_cq,
-- 
2.20.1

