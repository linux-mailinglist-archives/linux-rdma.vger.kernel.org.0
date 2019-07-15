Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E729F6984D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jul 2019 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfGOPVR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 15 Jul 2019 11:21:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46568 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbfGOPVQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 15 Jul 2019 11:21:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FFKvpO193744;
        Mon, 15 Jul 2019 15:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=919QiFVrd7WxEh97kj1fpF557EemWdz3q5TqukEIiuo=;
 b=R3OubKHtzxuPXs2tM7Z23tkLiIy/YaiVRr6J+pPjZrGZaJuLc/MB+SeHMpBSIWReP8T7
 rno3Z1CPuFTj7xl9XNZoov3EbO2A/EOEZgEzI480CWcHuJ/j+rSEw2gksKUuYq4am0mf
 4jJ4RXEzAeHj+pAqyvWUv4UeXGR/sB74XaECYDCWc2ygGSWYz+kspkfqjlxbwz7KVBJv
 VkjYrWMgaKpdBSnq76ZYd8297PmBCLoStzP9YSnq4hmjVPOh5c9PsaiWDnQuDfRz7LTP
 2TIPiERdZ3wcdD8SHHmDspB1ELkPWjlUWz8atsEyN9/lNLgsMwu1JzXYTxsMeIjnQNM0 Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tq6qtf7be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 15:20:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FF7aOE032776;
        Mon, 15 Jul 2019 15:20:54 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tq742k13a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 15:20:54 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6FFKrKK028235;
        Mon, 15 Jul 2019 15:20:53 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 08:20:52 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     yishaih@mellanox.com, dledford@redhat.com, leon@kernel.org,
        jgg@mellanox.com, mark.haywood@oracle.com, leonro@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Yuval Shaia <yuval.shaia@oracle.com>
Subject: [PATCH v9] verbs: Introduce a new reg_mr API for virtual address space
Date:   Mon, 15 Jul 2019 18:20:44 +0300
Message-Id: <20190715152044.31106-1-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=29 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150181
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The virtual address that is registered is used as a base for any address
passed later in post_recv and post_send operations.

On some virtualized environment this is not correct.

A guest cannot register its memory so hypervisor maps the guest physical
address to a host virtual address and register it with the HW. Later on,
at datapath phase, the guest fills the SGEs with addresses from its
address space.
Since HW cannot access guest virtual address space an extra translation
is needed to map those addresses to be based on the host virtual address
that was registered with the HW.
This datapath interference affects performances.

To avoid this, a logical separation between the address that is
registered and the address that is used as a offset at datapath phase is
needed.
This separation is already implemented in the lower layer part
(ibv_cmd_reg_mr) but blocked at the API level.

Fix it by introducing a new API function which accepts an address from
guest virtual address space as well, to be used as offset for later
datapath operations.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
v0 -> v1:
        * Change reg_mr callback signature instead of adding new callback
        * Add the new API to libibverbs/libibverbs.map.in
v1 -> v2:
        * Do not modify reg_mr signature for version 1.0
        * Add note to man page
v2 -> v3:
        * Rename function to reg_mr_iova (and arg-name to iova)
        * Some checkpatch issues not related to this fix but detected now
                * s/__FUNCTION__/__func
                * WARNING: function definition argument 'void *' should
                  also have an identifier name
v3 -> v4:
        * Fix commit message as suggested by Adit Ranadiv
        * Add support for efa
v4 -> v5:
        * Update PABI
        * Update debian files
v5 -> v6:
        * Move the new API to section in libibverbs/libibverbs.map.in
          (IBVERBS_1.7) as pointed out by Mark Haywood
v6 -> v7:
        *
v7 -> v8:
        * Update also redhat and suse specfiles so now all CI checks in
          github passed.
        * Leon, i have your r-b from v5, appriciate if you can take a look
          again now, with all the latest changes
v8 -> v9:
	* Back to 25 per Jason comment
---
 debian/libibverbs1.symbols        |  4 +++-
 libibverbs/CMakeLists.txt         |  2 +-
 libibverbs/driver.h               |  2 +-
 libibverbs/dummy_ops.c            |  2 +-
 libibverbs/libibverbs.map.in      |  5 +++++
 libibverbs/man/ibv_reg_mr.3       | 15 +++++++++++++--
 libibverbs/verbs.c                | 23 ++++++++++++++++++++++-
 libibverbs/verbs.h                |  7 +++++++
 providers/bnxt_re/verbs.c         |  6 +++---
 providers/bnxt_re/verbs.h         |  2 +-
 providers/cxgb3/iwch.h            |  4 ++--
 providers/cxgb3/verbs.c           | 15 +++++----------
 providers/cxgb4/libcxgb4.h        |  4 ++--
 providers/cxgb4/verbs.c           | 15 +++++----------
 providers/efa/verbs.c             |  4 ++--
 providers/efa/verbs.h             |  2 +-
 providers/hfi1verbs/hfiverbs.h    |  4 ++--
 providers/hfi1verbs/verbs.c       |  8 ++++----
 providers/hns/hns_roce_u.h        |  2 +-
 providers/hns/hns_roce_u_verbs.c  |  6 +++---
 providers/i40iw/i40iw_umain.h     |  3 ++-
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
 providers/nes/nes_umain.h         |  3 ++-
 providers/nes/nes_uverbs.c        |  9 ++++-----
 providers/ocrdma/ocrdma_main.h    |  4 ++--
 providers/ocrdma/ocrdma_verbs.c   | 10 ++++------
 providers/qedr/qelr_main.h        |  4 ++--
 providers/qedr/qelr_verbs.c       | 11 ++++-------
 providers/qedr/qelr_verbs.h       |  4 ++--
 providers/rxe/rxe.c               |  6 +++---
 providers/siw/siw.c               |  4 ++--
 providers/vmw_pvrdma/pvrdma.h     |  4 ++--
 providers/vmw_pvrdma/verbs.c      |  7 +++----
 42 files changed, 143 insertions(+), 113 deletions(-)

diff --git a/debian/libibverbs1.symbols b/debian/libibverbs1.symbols
index 39b3d4a9..aaac3830 100644
--- a/debian/libibverbs1.symbols
+++ b/debian/libibverbs1.symbols
@@ -4,7 +4,8 @@ libibverbs.so.1 libibverbs1 #MINVER#
  IBVERBS_1.1@IBVERBS_1.1 1.1.6
  IBVERBS_1.5@IBVERBS_1.5 20
  IBVERBS_1.6@IBVERBS_1.6 24
- (symver)IBVERBS_PRIVATE_25 25
+ IBVERBS_1.7@IBVERBS_1.7 25.0-1
+ (symver)IBVERBS_PRIVATE_25 25.0-1
  ibv_ack_async_event@IBVERBS_1.0 1.1.6
  ibv_ack_async_event@IBVERBS_1.1 1.1.6
  ibv_ack_cq_events@IBVERBS_1.0 1.1.6
@@ -89,6 +90,7 @@ libibverbs.so.1 libibverbs1 #MINVER#
  ibv_read_sysfs_file@IBVERBS_1.0 1.1.6
  ibv_reg_mr@IBVERBS_1.0 1.1.6
  ibv_reg_mr@IBVERBS_1.1 1.1.6
+ ibv_reg_mr_iova@IBVERBS_1.7 25.0-1
  ibv_register_driver@IBVERBS_1.1 1.1.6
  ibv_rereg_mr@IBVERBS_1.1 1.2.1
  ibv_resize_cq@IBVERBS_1.0 1.1.6
diff --git a/libibverbs/CMakeLists.txt b/libibverbs/CMakeLists.txt
index 1f5c59ed..a5926bbd 100644
--- a/libibverbs/CMakeLists.txt
+++ b/libibverbs/CMakeLists.txt
@@ -21,7 +21,7 @@ configure_file("libibverbs.map.in"
 
 rdma_library(ibverbs "${CMAKE_CURRENT_BINARY_DIR}/libibverbs.map"
   # See Documentation/versioning.md
-  1 1.6.${PACKAGE_VERSION}
+  1 1.7.${PACKAGE_VERSION}
   all_providers.c
   cmd.c
   cmd_ah.c
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 2e2131f2..88ed2b5e 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -362,7 +362,7 @@ struct verbs_context_ops {
 				    uint64_t dm_offset, size_t length,
 				    unsigned int access);
 	struct ibv_mr *(*reg_mr)(struct ibv_pd *pd, void *addr, size_t length,
-				 int access);
+				 uint64_t hca_va, int access);
 	int (*req_notify_cq)(struct ibv_cq *cq, int solicited_only);
 	int (*rereg_mr)(struct verbs_mr *vmr, int flags, struct ibv_pd *pd,
 			void *addr, size_t length, int access);
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index ebc6eddd..6560371a 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -411,7 +411,7 @@ static struct ibv_mr *reg_dm_mr(struct ibv_pd *pd, struct ibv_dm *dm,
 }
 
 static struct ibv_mr *reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-			     int access)
+			     uint64_t hca_va,  int access)
 {
 	errno = ENOSYS;
 	return NULL;
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index ee253ec0..c1b4537a 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -116,6 +116,11 @@ IBVERBS_1.6 {
 		ibv_qp_to_qp_ex;
 } IBVERBS_1.5;
 
+IBVERBS_1.7 {
+	global:
+		ibv_reg_mr_iova;
+} IBVERBS_1.6;
+
 /* If any symbols in this stanza change ABI then the entire staza gets a new symbol
    version. See the top level CMakeLists.txt for this setting. */
 
diff --git a/libibverbs/man/ibv_reg_mr.3 b/libibverbs/man/ibv_reg_mr.3
index 631e5fe8..be90a57b 100644
--- a/libibverbs/man/ibv_reg_mr.3
+++ b/libibverbs/man/ibv_reg_mr.3
@@ -3,7 +3,7 @@
 .\"
 .TH IBV_REG_MR 3 2006-10-31 libibverbs "Libibverbs Programmer's Manual"
 .SH "NAME"
-ibv_reg_mr, ibv_dereg_mr \- register or deregister a memory region (MR)
+ibv_reg_mr, ibv_reg_mr_iova, ibv_dereg_mr \- register or deregister a memory region (MR)
 .SH "SYNOPSIS"
 .nf
 .B #include <infiniband/verbs.h>
@@ -11,6 +11,10 @@ ibv_reg_mr, ibv_dereg_mr \- register or deregister a memory region (MR)
 .BI "struct ibv_mr *ibv_reg_mr(struct ibv_pd " "*pd" ", void " "*addr" ,
 .BI "                          size_t " "length" ", int " "access" );
 .sp
+.BI "struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd " "*pd" ", void " "*addr" ,
+.BI "                               size_t " "length" ", uint64_t " "hca_va" ,
+.BI "                               int " "access" );
+.sp
 .BI "int ibv_dereg_mr(struct ibv_mr " "*mr" );
 .fi
 .SH "DESCRIPTION"
@@ -52,11 +56,18 @@ Local read access is always enabled for the MR.
 .PP
 To create an implicit ODP MR, IBV_ACCESS_ON_DEMAND should be set, addr should be 0 and length should be SIZE_MAX.
 .PP
+.B ibv_reg_mr_iova()
+ibv_reg_mr_iova is the same as the normal reg_mr, except that the user is
+allowed to specify the virtual base address of the MR when accessed through
+a lkey or rkey. The offset in the memory region is computed as 'addr +
+(iova - hca_va)'. Specifying 0 for hca_va has the same effect as
+IBV_ACCESS_ZERO_BASED.
+.PP
 .B ibv_dereg_mr()
 deregisters the MR
 .I mr\fR.
 .SH "RETURN VALUE"
-.B ibv_reg_mr()
+.B ibv_reg_mr() / ibv_reg_mr_iova()
 returns a pointer to the registered MR, or NULL if the request fails.
 The local key (\fBL_Key\fR) field
 .B lkey
diff --git a/libibverbs/verbs.c b/libibverbs/verbs.c
index c7e8e8e9..e5063af2 100644
--- a/libibverbs/verbs.c
+++ b/libibverbs/verbs.c
@@ -306,7 +306,28 @@ LATEST_SYMVER_FUNC(ibv_reg_mr, 1_1, "IBVERBS_1.1",
 	if (ibv_dontfork_range(addr, length))
 		return NULL;
 
-	mr = get_ops(pd->context)->reg_mr(pd, addr, length, access);
+	mr = get_ops(pd->context)->reg_mr(pd, addr, length, (uintptr_t) addr,
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
+struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
+			       uint64_t iova, int access)
+{
+	struct ibv_mr *mr;
+
+	if (ibv_dontfork_range(addr, length))
+		return NULL;
+
+	mr = get_ops(pd->context)->reg_mr(pd, addr, length, iova, access);
 	if (mr) {
 		mr->context = pd->context;
 		mr->pd      = pd;
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index 1b0aef03..1e01b5db 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2376,6 +2376,13 @@ static inline int ibv_close_xrcd(struct ibv_xrcd *xrcd)
 struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
 			  size_t length, int access);
 
+/**
+ * ibv_reg_mr_iova - Register a memory region with a virtual offset
+ * address
+ */
+struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
+			       uint64_t iova, int access);
+
 
 enum ibv_rereg_mr_err_code {
 	/* Old MR is valid, invalid input */
diff --git a/providers/bnxt_re/verbs.c b/providers/bnxt_re/verbs.c
index ed7ddb6e..2218e3a0 100644
--- a/providers/bnxt_re/verbs.c
+++ b/providers/bnxt_re/verbs.c
@@ -131,7 +131,7 @@ int bnxt_re_free_pd(struct ibv_pd *ibvpd)
 }
 
 struct ibv_mr *bnxt_re_reg_mr(struct ibv_pd *ibvpd, void *sva, size_t len,
-			      int access)
+			      uint64_t hca_va, int access)
 {
 	struct bnxt_re_mr *mr;
 	struct ibv_reg_mr cmd;
@@ -141,8 +141,8 @@ struct ibv_mr *bnxt_re_reg_mr(struct ibv_pd *ibvpd, void *sva, size_t len,
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
index b565d7e6..2e994880 100644
--- a/providers/bnxt_re/verbs.h
+++ b/providers/bnxt_re/verbs.h
@@ -61,7 +61,7 @@ int bnxt_re_query_port(struct ibv_context *uctx, uint8_t port,
 struct ibv_pd *bnxt_re_alloc_pd(struct ibv_context *uctx);
 int bnxt_re_free_pd(struct ibv_pd *ibvpd);
 struct ibv_mr *bnxt_re_reg_mr(struct ibv_pd *ibvpd, void *buf, size_t len,
-			      int ibv_access_flags);
+			      uint64_t hca_va, int ibv_access_flags);
 int bnxt_re_dereg_mr(struct verbs_mr *vmr);
 
 struct ibv_cq *bnxt_re_create_cq(struct ibv_context *uctx, int ncqe,
diff --git a/providers/cxgb3/iwch.h b/providers/cxgb3/iwch.h
index c8de44e9..c7d85d3a 100644
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
index 8b90482a..39a44192 100644
--- a/providers/cxgb3/verbs.c
+++ b/providers/cxgb3/verbs.c
@@ -103,15 +103,17 @@ int iwch_free_pd(struct ibv_pd *pd)
 	return 0;
 }
 
-static struct ibv_mr *__iwch_reg_mr(struct ibv_pd *pd, void *addr,
-				    size_t length, uint64_t hca_va,
-				    int access)
+struct ibv_mr *iwch_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access)
 {
 	struct iwch_mr *mhp;
 	struct ibv_reg_mr cmd;
 	struct uiwch_reg_mr_resp resp;
 	struct iwch_device *dev = to_iwch_dev(pd->context->device);
 
+	PDBG("%s addr %p length %ld hca_va %p\n", __func__, addr, length,
+	     hca_va);
+
 	mhp = malloc(sizeof *mhp);
 	if (!mhp)
 		return NULL;
@@ -140,13 +142,6 @@ static struct ibv_mr *__iwch_reg_mr(struct ibv_pd *pd, void *addr,
 	return &mhp->vmr.ibv_mr;
 }
 
-struct ibv_mr *iwch_reg_mr(struct ibv_pd *pd, void *addr,
-			   size_t length, int access)
-{
-	PDBG("%s addr %p length %ld\n", __FUNCTION__, addr, length);
-	return __iwch_reg_mr(pd, addr, length, (uintptr_t) addr, access);
-}
-
 int iwch_dereg_mr(struct verbs_mr *vmr)
 {
 	int ret;
diff --git a/providers/cxgb4/libcxgb4.h b/providers/cxgb4/libcxgb4.h
index 0fbceab0..ce8f29dd 100644
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
index 452e4f1f..4240f6b3 100644
--- a/providers/cxgb4/verbs.c
+++ b/providers/cxgb4/verbs.c
@@ -109,15 +109,17 @@ int c4iw_free_pd(struct ibv_pd *pd)
 	return 0;
 }
 
-static struct ibv_mr *__c4iw_reg_mr(struct ibv_pd *pd, void *addr,
-				    size_t length, uint64_t hca_va,
-				    int access)
+struct ibv_mr *c4iw_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access)
 {
 	struct c4iw_mr *mhp;
 	struct ibv_reg_mr cmd;
 	struct ib_uverbs_reg_mr_resp resp;
 	struct c4iw_dev *dev = to_c4iw_dev(pd->context->device);
 
+	PDBG("%s addr %p length %ld hca_va %p\n", __func__, addr, length,
+	     hca_va);
+
 	mhp = malloc(sizeof *mhp);
 	if (!mhp)
 		return NULL;
@@ -142,13 +144,6 @@ static struct ibv_mr *__c4iw_reg_mr(struct ibv_pd *pd, void *addr,
 	return &mhp->vmr.ibv_mr;
 }
 
-struct ibv_mr *c4iw_reg_mr(struct ibv_pd *pd, void *addr,
-			   size_t length, int access)
-{
-	PDBG("%s addr %p length %ld\n", __func__, addr, length);
-	return __c4iw_reg_mr(pd, addr, length, (uintptr_t) addr, access);
-}
-
 int c4iw_dereg_mr(struct verbs_mr *vmr)
 {
 	int ret;
diff --git a/providers/efa/verbs.c b/providers/efa/verbs.c
index 4d36f9e1..d2500ecb 100644
--- a/providers/efa/verbs.c
+++ b/providers/efa/verbs.c
@@ -126,7 +126,7 @@ int efa_dealloc_pd(struct ibv_pd *ibvpd)
 }
 
 struct ibv_mr *efa_reg_mr(struct ibv_pd *ibvpd, void *sva, size_t len,
-			  int access)
+			  uint64_t hca_va, int access)
 {
 	struct ib_uverbs_reg_mr_resp resp;
 	struct ibv_reg_mr cmd;
@@ -136,7 +136,7 @@ struct ibv_mr *efa_reg_mr(struct ibv_pd *ibvpd, void *sva, size_t len,
 	if (!mr)
 		return NULL;
 
-	if (ibv_cmd_reg_mr(ibvpd, sva, len, (uintptr_t)sva, access, &mr->vmr,
+	if (ibv_cmd_reg_mr(ibvpd, sva, len, hca_va, access, &mr->vmr,
 			   &cmd, sizeof(cmd), &resp, sizeof(resp))) {
 		free(mr);
 		return NULL;
diff --git a/providers/efa/verbs.h b/providers/efa/verbs.h
index 1a49653f..7b532adc 100644
--- a/providers/efa/verbs.h
+++ b/providers/efa/verbs.h
@@ -18,7 +18,7 @@ int efa_query_device_ex(struct ibv_context *context,
 struct ibv_pd *efa_alloc_pd(struct ibv_context *uctx);
 int efa_dealloc_pd(struct ibv_pd *ibvpd);
 struct ibv_mr *efa_reg_mr(struct ibv_pd *ibvpd, void *buf, size_t len,
-			  int ibv_access_flags);
+			  uint64_t hca_va, int ibv_access_flags);
 int efa_dereg_mr(struct verbs_mr *vmr);
 
 struct ibv_cq *efa_create_cq(struct ibv_context *uctx, int ncqe,
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
index 93bc47c1..517d97b3 100644
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
index 9ba65a1d..44bc32a4 100644
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
index 4055933a..af84f284 100644
--- a/providers/i40iw/i40iw_umain.h
+++ b/providers/i40iw/i40iw_umain.h
@@ -155,7 +155,8 @@ int i40iw_uquery_device(struct ibv_context *, struct ibv_device_attr *);
 int i40iw_uquery_port(struct ibv_context *, uint8_t, struct ibv_port_attr *);
 struct ibv_pd *i40iw_ualloc_pd(struct ibv_context *);
 int i40iw_ufree_pd(struct ibv_pd *);
-struct ibv_mr *i40iw_ureg_mr(struct ibv_pd *, void *, size_t, int);
+struct ibv_mr *i40iw_ureg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			     uint64_t hca_va, int access);
 int i40iw_udereg_mr(struct verbs_mr *vmr);
 struct ibv_cq *i40iw_ucreate_cq(struct ibv_context *, int, struct ibv_comp_channel *, int);
 int i40iw_uresize_cq(struct ibv_cq *, int);
diff --git a/providers/i40iw/i40iw_uverbs.c b/providers/i40iw/i40iw_uverbs.c
index 83b504fa..240150b9 100644
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
index 9c21d775..3c161e8e 100644
--- a/providers/mlx4/mlx4.h
+++ b/providers/mlx4/mlx4.h
@@ -320,8 +320,8 @@ struct ibv_xrcd *mlx4_open_xrcd(struct ibv_context *context,
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
index 9a5affe7..d814a2bc 100644
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
index d9fccdcc..ab3c2c1a 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -821,8 +821,8 @@ void mlx5_async_event(struct ibv_context *context,
 		      struct ibv_async_event *event);
 
 struct ibv_mr *mlx5_alloc_null_mr(struct ibv_pd *pd);
-struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr,
-			   size_t length, int access);
+struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access);
 int mlx5_rereg_mr(struct verbs_mr *mr, int flags, struct ibv_pd *pd, void *addr,
 		  size_t length, int access);
 int mlx5_dereg_mr(struct verbs_mr *mr);
diff --git a/providers/mlx5/verbs.c b/providers/mlx5/verbs.c
index c13e81f4..714c5f7e 100644
--- a/providers/mlx5/verbs.c
+++ b/providers/mlx5/verbs.c
@@ -388,7 +388,7 @@ int mlx5_free_pd(struct ibv_pd *pd)
 }
 
 struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
-			   int acc)
+			   uint64_t hca_va, int acc)
 {
 	struct mlx5_mr *mr;
 	struct ibv_reg_mr cmd;
@@ -400,9 +400,8 @@ struct ibv_mr *mlx5_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
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
index df0cb281..adefb178 100644
--- a/providers/mthca/ah.c
+++ b/providers/mthca/ah.c
@@ -61,7 +61,8 @@ static struct mthca_ah_page *__add_page(struct mthca_pd *pd, int page_size, int
 		return NULL;
 	}
 
-	page->mr = mthca_reg_mr(&pd->ibv_pd, page->buf.buf, page_size, 0);
+	page->mr = mthca_reg_mr(&pd->ibv_pd, page->buf.buf, page_size,
+				(uintptr_t) page->buf.buf, 0);
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
index edb38622..1070ce42 100644
--- a/providers/nes/nes_umain.h
+++ b/providers/nes/nes_umain.h
@@ -350,7 +350,8 @@ int nes_uquery_device(struct ibv_context *, struct ibv_device_attr *);
 int nes_uquery_port(struct ibv_context *, uint8_t, struct ibv_port_attr *);
 struct ibv_pd *nes_ualloc_pd(struct ibv_context *);
 int nes_ufree_pd(struct ibv_pd *);
-struct ibv_mr *nes_ureg_mr(struct ibv_pd *, void *, size_t, int);
+struct ibv_mr *nes_ureg_mr(struct ibv_pd *pd, void *addr, size_t length,
+			   uint64_t hca_va, int access);
 int nes_udereg_mr(struct verbs_mr *vmr);
 struct ibv_cq *nes_ucreate_cq(struct ibv_context *, int, struct ibv_comp_channel *, int);
 int nes_uresize_cq(struct ibv_cq *, int);
diff --git a/providers/nes/nes_uverbs.c b/providers/nes/nes_uverbs.c
index 8523e923..2b78468b 100644
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
index 33def78c..aadefd96 100644
--- a/providers/ocrdma/ocrdma_main.h
+++ b/providers/ocrdma/ocrdma_main.h
@@ -269,8 +269,8 @@ int ocrdma_query_device(struct ibv_context *, struct ibv_device_attr *);
 int ocrdma_query_port(struct ibv_context *, uint8_t, struct ibv_port_attr *);
 struct ibv_pd *ocrdma_alloc_pd(struct ibv_context *);
 int ocrdma_free_pd(struct ibv_pd *);
-struct ibv_mr *ocrdma_reg_mr(struct ibv_pd *, void *, size_t,
-			     int ibv_access_flags);
+struct ibv_mr *ocrdma_reg_mr(struct ibv_pd *pd, void *addr, size_t len,
+			     uint64_t hca_va, int access);
 int ocrdma_dereg_mr(struct verbs_mr *vmr);
 
 struct ibv_cq *ocrdma_create_cq(struct ibv_context *, int,
diff --git a/providers/ocrdma/ocrdma_verbs.c b/providers/ocrdma/ocrdma_verbs.c
index 3b3e1a60..4ae35be9 100644
--- a/providers/ocrdma/ocrdma_verbs.c
+++ b/providers/ocrdma/ocrdma_verbs.c
@@ -185,22 +185,20 @@ int ocrdma_free_pd(struct ibv_pd *ibpd)
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
index 77aa9c2f..fae87130 100644
--- a/providers/qedr/qelr_main.h
+++ b/providers/qedr/qelr_main.h
@@ -46,8 +46,8 @@ int qelr_query_port(struct ibv_context *, uint8_t, struct ibv_port_attr *);
 struct ibv_pd *qelr_alloc_pd(struct ibv_context *);
 int qelr_dealloc_pd(struct ibv_pd *);
 
-struct ibv_mr *qelr_reg_mr(struct ibv_pd *, void *, size_t,
-			   int ibv_access_flags);
+struct ibv_mr *qelr_reg_mr(struct ibv_pd *ibpd, void *addr, size_t len,
+			   uint64_t hca_va, int access);
 int qelr_dereg_mr(struct verbs_mr *vmr);
 
 struct ibv_cq *qelr_create_cq(struct ibv_context *, int,
diff --git a/providers/qedr/qelr_verbs.c b/providers/qedr/qelr_verbs.c
index a347714d..4b19ccb0 100644
--- a/providers/qedr/qelr_verbs.c
+++ b/providers/qedr/qelr_verbs.c
@@ -156,8 +156,8 @@ int qelr_dealloc_pd(struct ibv_pd *ibpd)
 	return rc;
 }
 
-struct ibv_mr *qelr_reg_mr(struct ibv_pd *ibpd, void *addr,
-			   size_t len, int access)
+struct ibv_mr *qelr_reg_mr(struct ibv_pd *ibpd, void *addr, size_t len,
+			   uint64_t hca_va, int access)
 {
 	struct qelr_mr *mr;
 	struct ibv_reg_mr cmd;
@@ -165,17 +165,14 @@ struct ibv_mr *qelr_reg_mr(struct ibv_pd *ibpd, void *addr,
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
index cf2ce047..d0eacbfe 100644
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
index 2efb646c..4e05d5b9 100644
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
diff --git a/providers/siw/siw.c b/providers/siw/siw.c
index 41f33fa1..c1acf398 100644
--- a/providers/siw/siw.c
+++ b/providers/siw/siw.c
@@ -96,7 +96,7 @@ static int siw_free_pd(struct ibv_pd *pd)
 }
 
 static struct ibv_mr *siw_reg_mr(struct ibv_pd *pd, void *addr, size_t len,
-				 int access)
+				 uint64_t hca_va, int access)
 {
 	struct siw_cmd_reg_mr cmd = {};
 	struct siw_cmd_reg_mr_resp resp = {};
@@ -107,7 +107,7 @@ static struct ibv_mr *siw_reg_mr(struct ibv_pd *pd, void *addr, size_t len,
 	if (!mr)
 		return NULL;
 
-	rv = ibv_cmd_reg_mr(pd, addr, len, (uintptr_t)addr, access,
+	rv = ibv_cmd_reg_mr(pd, addr, len, hca_va, access,
 			    &mr->base_mr, &cmd.ibv_cmd, sizeof(cmd),
 			    &resp.ibv_resp, sizeof(resp));
 	if (rv) {
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

