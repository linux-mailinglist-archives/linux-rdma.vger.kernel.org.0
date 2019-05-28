Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 075D12CD77
	for <lists+linux-rdma@lfdr.de>; Tue, 28 May 2019 19:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfE1RSp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 May 2019 13:18:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60656 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfE1RSp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 May 2019 13:18:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SH8lQt006271;
        Tue, 28 May 2019 17:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=GfOHQ647DaiOcCYBBj4quo/svJsRMSbsfIxQgW4/w0U=;
 b=AHMyMIKmCOqPM9dPnBLu/FG+7jwQCkAL5pw3D3XKJZpFkW2uR+9c63dRo6IlkFSI/z1a
 IFpcAac7nDTu20UoS2Id+Yj1bCecSTmka8kSpkVZd7+9xqx7fVKgLAuWN259qgV5eSWX
 GEE5FDai8aNqv7gTvz9HvO+VjybSscrQDo4irfvd+vrrBHZzA2q3V9cyxbKdngsinJiy
 UoRc1la7A/8/IUy96Iba3e0zAM3zR8OIaAJ7n6R9lWFRT54D3h3VkghuVtMzJE8sIWF5
 p7MpPTDkLNkbo+hQuHwWfh3OP02ysxF3l6xzexdo+9O9GKsG4pKx0j2VMkDUTo2ZQXnu BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2spw4tcqhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 17:18:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4SHEL6g083309;
        Tue, 28 May 2019 17:16:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sqh737xqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 17:16:13 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4SHGDcl010189;
        Tue, 28 May 2019 17:16:13 GMT
Received: from host4.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 May 2019 10:16:12 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     yishaih@mellanox.com, dledford@redhat.com, jgg@ziepe.ca,
        leon@kernel.org, linux-rdma@vger.kernel.org, jgg@mellanox.com
Cc:     Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH v1 rdma-core] verbs: Introduce a new reg_mr API for virtual address space
Date:   Tue, 28 May 2019 20:14:39 +0300
Message-Id: <20190528171439.31499-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905280109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9271 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=29 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905280109
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
is needed to map those addresses to be based on the host virtual address
that was registered with the HW.

To avoid this, a logical separation between the address that is
registered and the address that is used as a offset at datapath phase is
needed.

This separation is already implemented in the lower layer part
(ibv_cmd_reg_mr) but blocked at the API level.

Fix it by introducing a new API function that accepts a address from
guest virtual address space as well

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
v0 -> v1:
	* Accept comment from Jason and change reg_mr callback signature
	* Add the new API to libibverbs/libibverbs.map.in (please review
	  carefully as i really not sure if this is how it should be done)
---
 libibverbs/compat-1_0.c           |  2 +-
 libibverbs/driver.h               |  2 +-
 libibverbs/dummy_ops.c            |  2 +-
 libibverbs/libibverbs.map.in      |  1 +
 libibverbs/verbs.c                | 23 ++++++++++++++++++++++-
 libibverbs/verbs.h                |  7 +++++++
 providers/bnxt_re/verbs.c         |  6 +++---
 providers/bnxt_re/verbs.h         |  2 +-
 providers/cxgb3/iwch.h            |  4 ++--
 providers/cxgb3/verbs.c           |  9 +++++----
 providers/cxgb4/libcxgb4.h        |  4 ++--
 providers/cxgb4/verbs.c           |  9 +++++----
 providers/hfi1verbs/hfiverbs.h    |  4 ++--
 providers/hfi1verbs/verbs.c       |  8 ++++----
 providers/hns/hns_roce_u.h        |  2 +-
 providers/hns/hns_roce_u_verbs.c  |  6 +++---
 providers/i40iw/i40iw_umain.h     |  2 +-
 providers/i40iw/i40iw_uverbs.c    |  8 ++++----
 providers/ipathverbs/ipathverbs.h |  4 ++--
 providers/ipathverbs/verbs.c      |  8 ++++----
 providers/mlx4/mlx4.h             |  4 ++--
 providers/mlx4/verbs.c            |  7 +++----
 providers/mlx5/mlx5.h             |  4 ++--
 providers/mlx5/verbs.c            |  7 +++----
 providers/mthca/ah.c              |  3 ++-
 providers/mthca/mthca.h           |  4 ++--
 providers/mthca/verbs.c           |  6 +++---
 providers/nes/nes_umain.h         |  2 +-
 providers/nes/nes_uverbs.c        |  9 ++++-----
 providers/ocrdma/ocrdma_main.h    |  2 +-
 providers/ocrdma/ocrdma_verbs.c   | 10 ++++------
 providers/qedr/qelr_main.h        |  2 +-
 providers/qedr/qelr_verbs.c       | 11 ++++-------
 providers/qedr/qelr_verbs.h       |  4 ++--
 providers/rxe/rxe.c               |  6 +++---
 providers/vmw_pvrdma/pvrdma.h     |  4 ++--
 providers/vmw_pvrdma/verbs.c      |  7 +++----
 37 files changed, 114 insertions(+), 91 deletions(-)

diff --git a/libibverbs/compat-1_0.c b/libibverbs/compat-1_0.c
index 695f89de..fbcc7514 100644
--- a/libibverbs/compat-1_0.c
+++ b/libibverbs/compat-1_0.c
@@ -171,7 +171,7 @@ struct ibv_context_ops_1_0 {
 	struct ibv_pd *		(*alloc_pd)(struct ibv_context *context);
 	int			(*dealloc_pd)(struct ibv_pd *pd);
 	struct ibv_mr *		(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
-					  int access);
+					  uint64_t hca_va, int access);
 	int			(*dereg_mr)(struct ibv_mr *mr);
 	struct ibv_cq *		(*create_cq)(struct ibv_context *context, int cqe,
 					     struct ibv_comp_channel *channel,
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index e4d624b2..ef27259a 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -338,7 +338,7 @@ struct verbs_context_ops {
 				    uint64_t dm_offset, size_t length,
 				    unsigned int access);
 	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
-				 int access);
+				 uint64_t hca_va, int access);
 	int (*req_notify_cq)(struct ibv_cq *cq, int solicited_only);
 	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
 			void *addr, size_t length, int access);
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index c861c3a0..61a8fbdf 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -410,7 +410,7 @@ static struct ibv_mr *reg_dm_mr(struct ibv_pd *pd, struct ibv_dm *dm,
 }
 
 static struct ibv_mr *reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-			     int access)
+			     uint64_t hca_va,  int access)
 {
 	errno = ENOSYS;
 	return NULL;
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index 87a1b9fc..523fd424 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -94,6 +94,7 @@ IBVERBS_1.1 {
 		ibv_query_srq;
 		ibv_rate_to_mbps;
 		ibv_reg_mr;
+		ibv_reg_mr_virt_as;
 		ibv_register_driver;
 		ibv_rereg_mr;
 		ibv_resize_cq;
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index 1766b9f5..3390aef8 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -312,7 +312,28 @@ LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
 	if (ibv_dontfork_range(addr, length))
 		return NULL;
 
-	mr = get_ops(pd->context)->reg_mr(pd, addr, length, access);
+	mr = get_ops(pd->context)->reg_mr(pd, addr, length, (uint64_t) addr,
+					  access);
+	if (mr) {
+		mr->context = pd->context;
+		mr->pd      = pd;
+		mr->addr    = addr;
+		mr->length  = length;
+	} else
+		ibv_dofork_range(addr, length);
+
+	return mr;
+}
+
+struct ibv_mr *ibv_reg_mr_virt_as(struct ibv_pd *pd, void *addr, size_t length,
+				  uint64_t hca_va, int access)
+{
+	struct ibv_mr *mr;
+
+	if (ibv_dontfork_range(addr, length))
+		return NULL;
+
+	mr = get_ops(pd->context)->reg_mr(pd, addr, length, hca_va, access);
 	if (mr) {
 		mr->context = pd->context;
 		mr->pd      = pd;
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index cb2d8439..adbf991b 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2372,6 +2372,13 @@ static inline int ibv_close_xrcd(struct ibv_xrcd *xrcd)
 struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
 			  size_t length, int access);
 
+/**
+ * ibv_reg_mr_virt_as - Register a memory region with a virtual offset
+ * address
+ */
+struct ibv_mr *ibv_reg_mr_virt_as(struct ibv_pd *pd, void *addr, size_t length,
+				  uint64_t hca_va, int access);
+
 
 enum ibv_rereg_mr_err_code {
 	/* Old MR is valid, invalid input */
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index bec382b3..f85c277b 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -132,7 +132,7 @@ int bnxt_re_free_pd(struct ibv_pd *ibvpd)
 }
 
 struct ibv_mr *bnxt_re_reg_mr(struct ibv_pd *ibvpd, void *sva, size_t len,
-			      int access)
+			      uint64_t hca_va, int access)
 {
 	struct bnxt_re_mr *mr;
 	struct ibv_reg_mr cmd;
@@ -142,8 +142,8 @@ struct ibv_mr *bnxt_re_reg_mr(struct ibv_pd *ibvpd, void *sva, size_t len,
 	if (!mr)
 		return NULL;
 
-	if (ibv_cmd_reg_mr(ibvpd, sva, len, (uintptr_t)sva, access, &mr->vmr,
-			   &cmd, sizeof(cmd), &resp.ibv_resp, sizeof(resp))) {
+	if (ibv_cmd_reg_mr(ibvpd, sva, len, hca_va, access, &mr->vmr, &cmd,
+			   sizeof(cmd), &resp.ibv_resp, sizeof(resp))) {
 		free(mr);
 		return NULL;
 	}
diff --git a/providers/bnxt_re/verbs.h b/providers/bnxt_re/verbs.h
index 6e5f092b..af5f35f9 100644
--- a/providers/bnxt_re/verbs.h
+++ b/providers/bnxt_re/verbs.h
@@ -62,7 +62,7 @@ int bnxt_re_query_port(struct ibv_context *uctx, uint8_t port,
 struct ibv_pd *bnxt_re_alloc_pd(struct ibv_context *uctx);
 int bnxt_re_free_pd(struct ibv_pd *ibvpd);
 struct ibv_mr *bnxt_re_reg_mr(struct ibv_pd *ibvpd, void *buf, size_t len,
-			      int ibv_access_flags);
+			      uint64_t hca_va, int ibv_access_flags);
 int bnxt_re_dereg_mr(struct verbs_mr *vmr);
 
 struct ibv_cq *bnxt_re_create_cq(struct ibv_context *uctx, int ncqe,
diff --git a/providers/cxgb3/iwch.h b/providers/cxgb3/iwch.h
index a6fea23d..ccb11729 100644
--- a/providers/cxgb3/iwch.h
+++ b/providers/cxgb3/iwch.h
@@ -150,8 +150,8 @@ extern int iwch_query_port(struct ibv_context *context, uint8_t port,
 extern struct ibv_pd *iwch_alloc_pd(struct ibv_context *context);
 extern int iwch_free_pd(struct ibv_pd *pd);
 
-extern struct ibv_mr *iwch_reg_mr(struct ibv_pd *pd, void *addr,
-				  size_t length, int access);
+extern struct ibv_mr *iwch_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+				  uint64_t hca_va, int access);
 extern int iwch_dereg_mr(struct verbs_mr *mr);
 
 struct ibv_cq *iwch_create_cq(struct ibv_context *context, int cqe,
diff --git a/providers/cxgb3/verbs.c b/providers/cxgb3/verbs.c
index 67eb588b..490a3c62 100644
--- a/providers/cxgb3/verbs.c
+++ b/providers/cxgb3/verbs.c
@@ -140,11 +140,12 @@ static struct ibv_mr *__iwch_reg_mr(struct ibv_pd *pd, void *addr,
 	return &mhp->vmr.ibv_mr;
 }
 
-struct ibv_mr *iwch_reg_mr(struct ibv_pd *pd, void *addr,
-			   size_t length, int access)
+struct ibv_mr *iwch_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access)
 {
-	PDBG("%s addr %p length %ld\n", __FUNCTION__, addr, length);
-	return __iwch_reg_mr(pd, addr, length, (uintptr_t) addr, access);
+	PDBG("%s addr %p length %ld hca_va %p\n", __FUNCTION__, addr, length,
+	     hca_va);
+	return __iwch_reg_mr(pd, addr, length, hca_va, access);
 }
 
 int iwch_dereg_mr(struct verbs_mr *vmr)
diff --git a/providers/cxgb4/libcxgb4.h b/providers/cxgb4/libcxgb4.h
index 7626a5f1..1ee94e4c 100644
--- a/providers/cxgb4/libcxgb4.h
+++ b/providers/cxgb4/libcxgb4.h
@@ -198,8 +198,8 @@ int c4iw_query_port(struct ibv_context *context, uint8_t port,
 struct ibv_pd *c4iw_alloc_pd(struct ibv_context *context);
 int c4iw_free_pd(struct ibv_pd *pd);
 
-struct ibv_mr *c4iw_reg_mr(struct ibv_pd *pd, void *addr,
-				  size_t length, int access);
+struct ibv_mr *c4iw_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access);
 int c4iw_dereg_mr(struct verbs_mr *vmr);
 
 struct ibv_cq *c4iw_create_cq(struct ibv_context *context, int cqe,
diff --git a/providers/cxgb4/verbs.c b/providers/cxgb4/verbs.c
index f5c154e6..c8aeb8b4 100644
--- a/providers/cxgb4/verbs.c
+++ b/providers/cxgb4/verbs.c
@@ -142,11 +142,12 @@ static struct ibv_mr *__c4iw_reg_mr(struct ibv_pd *pd, void *addr,
 	return &mhp->vmr.ibv_mr;
 }
 
-struct ibv_mr *c4iw_reg_mr(struct ibv_pd *pd, void *addr,
-			   size_t length, int access)
+struct ibv_mr *c4iw_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access)
 {
-	PDBG("%s addr %p length %ld\n", __func__, addr, length);
-	return __c4iw_reg_mr(pd, addr, length, (uintptr_t) addr, access);
+	PDBG("%s addr %p length %ld hca_va %p\n", __func__, addr, length,
+	     hca_va);
+	return __c4iw_reg_mr(pd, addr, length, hca_va, access);
 }
 
 int c4iw_dereg_mr(struct verbs_mr *vmr)
diff --git a/providers/hfi1verbs/hfiverbs.h b/providers/hfi1verbs/hfiverbs.h
index 070a01c9..b9e91d80 100644
--- a/providers/hfi1verbs/hfiverbs.h
+++ b/providers/hfi1verbs/hfiverbs.h
@@ -204,8 +204,8 @@ struct ibv_pd *hfi1_alloc_pd(struct ibv_context *pd);
 
 int hfi1_free_pd(struct ibv_pd *pd);
 
-struct ibv_mr *hfi1_reg_mr(struct ibv_pd *pd, void *addr,
-			    size_t length, int access);
+struct ibv_mr *hfi1_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access);
 
 int hfi1_dereg_mr(struct verbs_mr *vmr);
 
diff --git a/providers/hfi1verbs/verbs.c b/providers/hfi1verbs/verbs.c
index ff001f6d..275f8d51 100644
--- a/providers/hfi1verbs/verbs.c
+++ b/providers/hfi1verbs/verbs.c
@@ -129,8 +129,8 @@ int hfi1_free_pd(struct ibv_pd *pd)
 	return 0;
 }
 
-struct ibv_mr *hfi1_reg_mr(struct ibv_pd *pd, void *addr,
-			    size_t length, int access)
+struct ibv_mr *hfi1_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access)
 {
 	struct verbs_mr *vmr;
 	struct ibv_reg_mr cmd;
@@ -141,8 +141,8 @@ struct ibv_mr *hfi1_reg_mr(struct ibv_pd *pd, void *addr,
 	if (!vmr)
 		return NULL;
 
-	ret = ibv_cmd_reg_mr(pd, addr, length, (uintptr_t)addr, access, vmr,
-			     &cmd, sizeof cmd, &resp, sizeof resp);
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
 
 	if (ret) {
 		free(vmr);
diff --git a/providers/hns/hns_roce_u.h b/providers/hns/hns_roce_u.h
index 65125e5a..2d35e00f 100644
--- a/providers/hns/hns_roce_u.h
+++ b/providers/hns/hns_roce_u.h
@@ -293,7 +293,7 @@ struct ibv_pd *hns_roce_u_alloc_pd(struct ibv_context *context);
 int hns_roce_u_free_pd(struct ibv_pd *pd);
 
 struct ibv_mr *hns_roce_u_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-				 int access);
+				 uint64_t hca_va, int access);
 int hns_roce_u_rereg_mr(struct verbs_mr *mr, int flags, struct ibv_pd *pd,
 			void *addr, size_t length, int access);
 int hns_roce_u_dereg_mr(struct verbs_mr *mr);
diff --git a/providers/hns/hns_roce_u_verbs.c b/providers/hns/hns_roce_u_verbs.c
index 9ca62c72..8cf21870 100644
--- a/providers/hns/hns_roce_u_verbs.c
+++ b/providers/hns/hns_roce_u_verbs.c
@@ -120,7 +120,7 @@ int hns_roce_u_free_pd(struct ibv_pd *pd)
 }
 
 struct ibv_mr *hns_roce_u_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-				 int access)
+				 uint64_t hca_va, int access)
 {
 	int ret;
 	struct verbs_mr *vmr;
@@ -141,8 +141,8 @@ struct ibv_mr *hns_roce_u_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	if (!vmr)
 		return NULL;
 
-	ret = ibv_cmd_reg_mr(pd, addr, length, (uintptr_t)addr, access, vmr,
-			     &cmd, sizeof(cmd), &resp, sizeof(resp));
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
 	if (ret) {
 		free(vmr);
 		return NULL;
diff --git a/providers/i40iw/i40iw_umain.h b/providers/i40iw/i40iw_umain.h
index 80c1727c..98c62c80 100644
--- a/providers/i40iw/i40iw_umain.h
+++ b/providers/i40iw/i40iw_umain.h
@@ -160,7 +160,7 @@ int i40iw_uquery_device(struct ibv_context *, struct ibv_device_attr *);
 int i40iw_uquery_port(struct ibv_context *, uint8_t, struct ibv_port_attr *);
 struct ibv_pd *i40iw_ualloc_pd(struct ibv_context *);
 int i40iw_ufree_pd(struct ibv_pd *);
-struct ibv_mr *i40iw_ureg_mr(struct ibv_pd *, void *, size_t, int);
+struct ibv_mr *i40iw_ureg_mr(struct ibv_pd *, void *, size_t, uint64_t, int);
 int i40iw_udereg_mr(struct verbs_mr *vmr);
 struct ibv_cq *i40iw_ucreate_cq(struct ibv_context *, int, struct ibv_comp_channel *, int);
 int i40iw_uresize_cq(struct ibv_cq *, int);
diff --git a/providers/i40iw/i40iw_uverbs.c b/providers/i40iw/i40iw_uverbs.c
index 63b7206a..c054eb56 100644
--- a/providers/i40iw/i40iw_uverbs.c
+++ b/providers/i40iw/i40iw_uverbs.c
@@ -149,7 +149,8 @@ int i40iw_ufree_pd(struct ibv_pd *pd)
  * @length: length of the memory
  * @access: access allowed on this mr
  */
-struct ibv_mr *i40iw_ureg_mr(struct ibv_pd *pd, void *addr, size_t length, int access)
+struct ibv_mr *i40iw_ureg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			     uint64_t hca_va, int access)
 {
 	struct verbs_mr *vmr;
 	struct i40iw_ureg_mr cmd;
@@ -161,9 +162,8 @@ struct ibv_mr *i40iw_ureg_mr(struct ibv_pd *pd, void *addr, size_t length, int a
 
 	cmd.reg_type = IW_MEMREG_TYPE_MEM;
 
-	if (ibv_cmd_reg_mr(pd, addr, length, (uintptr_t)addr,
-			   access, vmr, &cmd.ibv_cmd, sizeof(cmd),
-			   &resp, sizeof(resp))) {
+	if (ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd.ibv_cmd,
+			   sizeof(cmd), &resp, sizeof(resp))) {
 		fprintf(stderr, PFX "%s: Failed to register memory\n", __func__);
 		free(vmr);
 		return NULL;
diff --git a/providers/ipathverbs/ipathverbs.h b/providers/ipathverbs/ipathverbs.h
index cfb5cc38..694f1f44 100644
--- a/providers/ipathverbs/ipathverbs.h
+++ b/providers/ipathverbs/ipathverbs.h
@@ -183,8 +183,8 @@ struct ibv_pd *ipath_alloc_pd(struct ibv_context *pd);
 
 int ipath_free_pd(struct ibv_pd *pd);
 
-struct ibv_mr *ipath_reg_mr(struct ibv_pd *pd, void *addr,
-			    size_t length, int access);
+struct ibv_mr *ipath_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			    uint64_t hca_va, int access);
 
 int ipath_dereg_mr(struct verbs_mr *vmr);
 
diff --git a/providers/ipathverbs/verbs.c b/providers/ipathverbs/verbs.c
index de4722b2..505ea584 100644
--- a/providers/ipathverbs/verbs.c
+++ b/providers/ipathverbs/verbs.c
@@ -109,8 +109,8 @@ int ipath_free_pd(struct ibv_pd *pd)
 	return 0;
 }
 
-struct ibv_mr *ipath_reg_mr(struct ibv_pd *pd, void *addr,
-			    size_t length, int access)
+struct ibv_mr *ipath_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			    uint64_t hca_va, int access)
 {
 	struct verbs_mr *vmr;
 	struct ibv_reg_mr cmd;
@@ -121,8 +121,8 @@ struct ibv_mr *ipath_reg_mr(struct ibv_pd *pd, void *addr,
 	if (!vmr)
 		return NULL;
 
-	ret = ibv_cmd_reg_mr(pd, addr, length, (uintptr_t)addr, access, vmr,
-			     &cmd, sizeof cmd, &resp, sizeof resp);
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
 	if (ret) {
 		free(vmr);
 		return NULL;
diff --git a/providers/mlx4/mlx4.h b/providers/mlx4/mlx4.h
index e9412c51..ae02221a 100644
--- a/providers/mlx4/mlx4.h
+++ b/providers/mlx4/mlx4.h
@@ -325,8 +325,8 @@ struct ibv_xrcd *mlx4_open_xrcd(struct ibv_context *context,
 				struct ibv_xrcd_init_attr *attr);
 int mlx4_close_xrcd(struct ibv_xrcd *xrcd);
 
-struct ibv_mr *mlx4_reg_mr(struct ibv_pd *pd, void *addr,
-			    size_t length, int access);
+struct ibv_mr *mlx4_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access);
 int mlx4_rereg_mr(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
 		  void *addr, size_t length, int access);
 int mlx4_dereg_mr(struct verbs_mr *vmr);
diff --git a/providers/mlx4/verbs.c b/providers/mlx4/verbs.c
index eae75f1d..697ef769 100644
--- a/providers/mlx4/verbs.c
+++ b/providers/mlx4/verbs.c
@@ -275,7 +275,7 @@ int mlx4_close_xrcd(struct ibv_xrcd *ib_xrcd)
 }
 
 struct ibv_mr *mlx4_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-			   int access)
+			   uint64_t hca_va, int access)
 {
 	struct verbs_mr *vmr;
 	struct ibv_reg_mr cmd;
@@ -286,9 +286,8 @@ struct ibv_mr *mlx4_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	if (!vmr)
 		return NULL;
 
-	ret = ibv_cmd_reg_mr(pd, addr, length, (uintptr_t) addr,
-			     access, vmr, &cmd, sizeof(cmd),
-			     &resp, sizeof(resp));
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
 	if (ret) {
 		free(vmr);
 		return NULL;
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 3838e901..77b0b151 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -798,8 +798,8 @@ struct ibv_pd *mlx5_alloc_pd(struct ibv_context *context);
 int mlx5_free_pd(struct ibv_pd *pd);
 
 struct ibv_mr *mlx5_alloc_null_mr(struct ibv_pd *pd);
-struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr,
-			   size_t length, int access);
+struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access);
 int mlx5_rereg_mr(struct verbs_mr *mr, int flags, struct ibv_pd *pd, void *addr,
 		  size_t length, int access);
 int mlx5_dereg_mr(struct verbs_mr *mr);
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index 44926610..129dc772 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -373,7 +373,7 @@ int mlx5_free_pd(struct ibv_pd *pd)
 }
 
 struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-			   int acc)
+			   uint64_t hca_va, int acc)
 {
 	struct mlx5_mr *mr;
 	struct ibv_reg_mr cmd;
@@ -385,9 +385,8 @@ struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	if (!mr)
 		return NULL;
 
-	ret = ibv_cmd_reg_mr(pd, addr, length, (uintptr_t)addr, access,
-			     &mr->vmr, &cmd, sizeof(cmd), &resp,
-			     sizeof resp);
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, &mr->vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
 	if (ret) {
 		mlx5_free_buf(&(mr->buf));
 		free(mr);
diff --git a/providers/mthca/ah.c b/providers/mthca/ah.c
index df0cb281..70fee9a6 100644
--- a/providers/mthca/ah.c
+++ b/providers/mthca/ah.c
@@ -61,7 +61,8 @@ static struct mthca_ah_page *__add_page(struct mthca_pd *pd, int page_size, int
 		return NULL;
 	}
 
-	page->mr = mthca_reg_mr(&pd->ibv_pd, page->buf.buf, page_size, 0);
+	page->mr = mthca_reg_mr(&pd->ibv_pd, page->buf.buf, page_size,
+				(uint64_t) page->buf.buf, 0);
 	if (!page->mr) {
 		mthca_free_buf(&page->buf);
 		free(page);
diff --git a/providers/mthca/mthca.h b/providers/mthca/mthca.h
index 61042de3..b7df2f73 100644
--- a/providers/mthca/mthca.h
+++ b/providers/mthca/mthca.h
@@ -280,8 +280,8 @@ int mthca_query_port(struct ibv_context *context, uint8_t port,
 struct ibv_pd *mthca_alloc_pd(struct ibv_context *context);
 int mthca_free_pd(struct ibv_pd *pd);
 
-struct ibv_mr *mthca_reg_mr(struct ibv_pd *pd, void *addr,
-			    size_t length, int access);
+struct ibv_mr *mthca_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			    uint64_t hca_va, int access);
 int mthca_dereg_mr(struct verbs_mr *mr);
 
 struct ibv_cq *mthca_create_cq(struct ibv_context *context, int cqe,
diff --git a/providers/mthca/verbs.c b/providers/mthca/verbs.c
index e7a1c357..99e5ec66 100644
--- a/providers/mthca/verbs.c
+++ b/providers/mthca/verbs.c
@@ -145,10 +145,10 @@ static struct ibv_mr *__mthca_reg_mr(struct ibv_pd *pd, void *addr,
 	return &vmr->ibv_mr;
 }
 
-struct ibv_mr *mthca_reg_mr(struct ibv_pd *pd, void *addr,
-			    size_t length, int access)
+struct ibv_mr *mthca_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			    uint64_t hca_va, int access)
 {
-	return __mthca_reg_mr(pd, addr, length, (uintptr_t) addr, access, 0);
+	return __mthca_reg_mr(pd, addr, length, hca_va, access, 0);
 }
 
 int mthca_dereg_mr(struct verbs_mr *vmr)
diff --git a/providers/nes/nes_umain.h b/providers/nes/nes_umain.h
index b377508d..a0189c62 100644
--- a/providers/nes/nes_umain.h
+++ b/providers/nes/nes_umain.h
@@ -355,7 +355,7 @@ int nes_uquery_device(struct ibv_context *, struct ibv_device_attr *);
 int nes_uquery_port(struct ibv_context *, uint8_t, struct ibv_port_attr *);
 struct ibv_pd *nes_ualloc_pd(struct ibv_context *);
 int nes_ufree_pd(struct ibv_pd *);
-struct ibv_mr *nes_ureg_mr(struct ibv_pd *, void *, size_t, int);
+struct ibv_mr *nes_ureg_mr(struct ibv_pd *, void *, size_t, uint64_t, int);
 int nes_udereg_mr(struct verbs_mr *vmr);
 struct ibv_cq *nes_ucreate_cq(struct ibv_context *, int, struct ibv_comp_channel *, int);
 int nes_uresize_cq(struct ibv_cq *, int);
diff --git a/providers/nes/nes_uverbs.c b/providers/nes/nes_uverbs.c
index fd14849e..e5442b78 100644
--- a/providers/nes/nes_uverbs.c
+++ b/providers/nes/nes_uverbs.c
@@ -165,8 +165,8 @@ int nes_ufree_pd(struct ibv_pd *pd)
 /**
  * nes_ureg_mr
  */
-struct ibv_mr *nes_ureg_mr(struct ibv_pd *pd, void *addr,
-		size_t length, int access)
+struct ibv_mr *nes_ureg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access)
 {
 	struct verbs_mr *vmr;
 	struct nes_ureg_mr cmd;
@@ -177,9 +177,8 @@ struct ibv_mr *nes_ureg_mr(struct ibv_pd *pd, void *addr,
 		return NULL;
 
 	cmd.reg_type = IWNES_MEMREG_TYPE_MEM;
-	if (ibv_cmd_reg_mr(pd, addr, length, (uintptr_t) addr,
-			access, vmr, &cmd.ibv_cmd, sizeof(cmd),
-			&resp, sizeof(resp))) {
+	if (ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd.ibv_cmd,
+			   sizeof(cmd), &resp, sizeof(resp))) {
 		free(vmr);
 
 		return NULL;
diff --git a/providers/ocrdma/ocrdma_main.h b/providers/ocrdma/ocrdma_main.h
index 33def78c..882ce9ec 100644
--- a/providers/ocrdma/ocrdma_main.h
+++ b/providers/ocrdma/ocrdma_main.h
@@ -269,7 +269,7 @@ int ocrdma_query_device(struct ibv_context *, struct ibv_device_attr *);
 int ocrdma_query_port(struct ibv_context *, uint8_t, struct ibv_port_attr *);
 struct ibv_pd *ocrdma_alloc_pd(struct ibv_context *);
 int ocrdma_free_pd(struct ibv_pd *);
-struct ibv_mr *ocrdma_reg_mr(struct ibv_pd *, void *, size_t,
+struct ibv_mr *ocrdma_reg_mr(struct ibv_pd *, void *, size_t, uint64_t,
 			     int ibv_access_flags);
 int ocrdma_dereg_mr(struct verbs_mr *vmr);
 
diff --git a/providers/ocrdma/ocrdma_verbs.c b/providers/ocrdma/ocrdma_verbs.c
index 5bd9f5ae..2c608e26 100644
--- a/providers/ocrdma/ocrdma_verbs.c
+++ b/providers/ocrdma/ocrdma_verbs.c
@@ -186,22 +186,20 @@ int ocrdma_free_pd(struct ibv_pd *ibpd)
 /*
  * ocrdma_reg_mr
  */
-struct ibv_mr *ocrdma_reg_mr(struct ibv_pd *pd, void *addr,
-			     size_t len, int access)
+struct ibv_mr *ocrdma_reg_mr(struct ibv_pd *pd, void *addr, size_t len,
+			     uint64_t hca_va, int access)
 {
 	struct ocrdma_mr *mr;
 	struct ibv_reg_mr cmd;
 	struct uocrdma_reg_mr_resp resp;
-	uint64_t hca_va = (uintptr_t) addr;
 
 	mr = malloc(sizeof *mr);
 	if (!mr)
 		return NULL;
 	bzero(mr, sizeof *mr);
 
-	if (ibv_cmd_reg_mr(pd, addr, len, hca_va,
-			   access, &mr->vmr, &cmd, sizeof(cmd),
-			   &resp.ibv_resp, sizeof(resp))) {
+	if (ibv_cmd_reg_mr(pd, addr, len, hca_va, access, &mr->vmr, &cmd,
+			   sizeof(cmd), &resp.ibv_resp, sizeof(resp))) {
 		free(mr);
 		return NULL;
 	}
diff --git a/providers/qedr/qelr_main.h b/providers/qedr/qelr_main.h
index ef05acbc..1248c5c0 100644
--- a/providers/qedr/qelr_main.h
+++ b/providers/qedr/qelr_main.h
@@ -46,7 +46,7 @@ int qelr_query_port(struct ibv_context *, uint8_t, struct ibv_port_attr *);
 struct ibv_pd *qelr_alloc_pd(struct ibv_context *);
 int qelr_dealloc_pd(struct ibv_pd *);
 
-struct ibv_mr *qelr_reg_mr(struct ibv_pd *, void *, size_t,
+struct ibv_mr *qelr_reg_mr(struct ibv_pd *, void *, size_t, uint64_t,
 			   int ibv_access_flags);
 int qelr_dereg_mr(struct verbs_mr *vmr);
 
diff --git a/providers/qedr/qelr_verbs.c b/providers/qedr/qelr_verbs.c
index c5edc097..8e406bc6 100644
--- a/providers/qedr/qelr_verbs.c
+++ b/providers/qedr/qelr_verbs.c
@@ -157,8 +157,8 @@ int qelr_dealloc_pd(struct ibv_pd *ibpd)
 	return rc;
 }
 
-struct ibv_mr *qelr_reg_mr(struct ibv_pd *ibpd, void *addr,
-			   size_t len, int access)
+struct ibv_mr *qelr_reg_mr(struct ibv_pd *ibpd, void *addr, size_t len,
+			   uint64_t hca_va, int access)
 {
 	struct qelr_mr *mr;
 	struct ibv_reg_mr cmd;
@@ -166,17 +166,14 @@ struct ibv_mr *qelr_reg_mr(struct ibv_pd *ibpd, void *addr,
 	struct qelr_pd *pd = get_qelr_pd(ibpd);
 	struct qelr_devctx *cxt = get_qelr_ctx(ibpd->context);
 
-	uint64_t hca_va = (uintptr_t) addr;
-
 	mr = malloc(sizeof(*mr));
 	if (!mr)
 		return NULL;
 
 	bzero(mr, sizeof(*mr));
 
-	if (ibv_cmd_reg_mr(ibpd, addr, len, hca_va,
-			   access, &mr->vmr, &cmd, sizeof(cmd),
-			   &resp.ibv_resp, sizeof(resp))) {
+	if (ibv_cmd_reg_mr(ibpd, addr, len, hca_va, access, &mr->vmr, &cmd,
+			   sizeof(cmd), &resp.ibv_resp, sizeof(resp))) {
 		free(mr);
 		return NULL;
 	}
diff --git a/providers/qedr/qelr_verbs.h b/providers/qedr/qelr_verbs.h
index 26802c3a..e8c9bcb5 100644
--- a/providers/qedr/qelr_verbs.h
+++ b/providers/qedr/qelr_verbs.h
@@ -48,8 +48,8 @@ int qelr_query_port(struct ibv_context *context, uint8_t port,
 struct ibv_pd *qelr_alloc_pd(struct ibv_context *context);
 int qelr_dealloc_pd(struct ibv_pd *ibpd);
 
-struct ibv_mr *qelr_reg_mr(struct ibv_pd *ibpd, void *addr,
-			   size_t len, int access);
+struct ibv_mr *qelr_reg_mr(struct ibv_pd *ibpd, void *addr, size_t len,
+			   uint64_t hca_va, int access);
 int qelr_dereg_mr(struct verbs_mr *mr);
 
 struct ibv_cq *qelr_create_cq(struct ibv_context *context, int cqe,
diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 909c3f7b..c0fb32e3 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -123,7 +123,7 @@ static int rxe_dealloc_pd(struct ibv_pd *pd)
 }
 
 static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-				 int access)
+				 uint64_t hca_va, int access)
 {
 	struct verbs_mr *vmr;
 	struct ibv_reg_mr cmd;
@@ -134,8 +134,8 @@ static struct ibv_mr *rxe_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	if (!vmr)
 		return NULL;
 
-	ret = ibv_cmd_reg_mr(pd, addr, length, (uintptr_t)addr, access, vmr,
-			     &cmd, sizeof cmd, &resp, sizeof resp);
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
 	if (ret) {
 		free(vmr);
 		return NULL;
diff --git a/providers/vmw_pvrdma/pvrdma.h b/providers/vmw_pvrdma/pvrdma.h
index ebd50ce1..d90bd809 100644
--- a/providers/vmw_pvrdma/pvrdma.h
+++ b/providers/vmw_pvrdma/pvrdma.h
@@ -281,8 +281,8 @@ int pvrdma_query_port(struct ibv_context *context, uint8_t port,
 struct ibv_pd *pvrdma_alloc_pd(struct ibv_context *context);
 int pvrdma_free_pd(struct ibv_pd *pd);
 
-struct ibv_mr *pvrdma_reg_mr(struct ibv_pd *pd, void *addr,
-			     size_t length, int access);
+struct ibv_mr *pvrdma_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			     uint64_t hca_va, int access);
 int pvrdma_dereg_mr(struct verbs_mr *mr);
 
 struct ibv_cq *pvrdma_create_cq(struct ibv_context *context, int cqe,
diff --git a/providers/vmw_pvrdma/verbs.c b/providers/vmw_pvrdma/verbs.c
index e27952bf..e8423c01 100644
--- a/providers/vmw_pvrdma/verbs.c
+++ b/providers/vmw_pvrdma/verbs.c
@@ -112,7 +112,7 @@ int pvrdma_free_pd(struct ibv_pd *pd)
 }
 
 struct ibv_mr *pvrdma_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-			     int access)
+			     uint64_t hca_va, int access)
 {
 	struct verbs_mr *vmr;
 	struct ibv_reg_mr cmd;
@@ -123,9 +123,8 @@ struct ibv_mr *pvrdma_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	if (!vmr)
 		return NULL;
 
-	ret = ibv_cmd_reg_mr(pd, addr, length, (uintptr_t) addr,
-			     access, vmr, &cmd, sizeof(cmd),
-			     &resp, sizeof(resp));
+	ret = ibv_cmd_reg_mr(pd, addr, length, hca_va, access, vmr, &cmd,
+			     sizeof(cmd), &resp, sizeof(resp));
 	if (ret) {
 		free(vmr);
 		return NULL;
-- 
2.20.1

