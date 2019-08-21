Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B4897CEA
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 16:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfHUO2L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 10:28:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53098 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbfHUO2L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Aug 2019 10:28:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENf4M096880;
        Wed, 21 Aug 2019 14:27:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2019-08-05;
 bh=24HQes+eRkJtF1wGIrwlTmDpI435FkTDsTQanglI18Y=;
 b=nxflpiU7nCaCmVXYijofqiXNE5jrFKNIAA73Ww2UGJJPEzP+BbbROPBts3clix2/uFr9
 DWZjNKO07xc7AX/jgou3SfC5XnAQtt6rEj6w2AB4a/1MSoKhcFvN8mqUH/V3QWLmkUXT
 Clchdc58YfHkNu38aJ3uU9mesNvL7uETDvoF8f5p0ZZ4GbpJvDm7p664vi5U2S72pqpI
 DJQuO97M1Hg9Wo9meI5BZKdz4YHRtWK9sD35zNkoKS/rNq6aTfMaeJ8b4ClTaSAgTxxl
 J7fFwmbw4SfvEwQtnx1Et/esxAMV77ozgQn1d32FV8G1JvSPU3a4mLUK252F/hLkl9/H zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2ue9hpnw5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7LENVgo106811;
        Wed, 21 Aug 2019 14:27:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2ugj7pydu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:27:45 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7LERjhI003578;
        Wed, 21 Aug 2019 14:27:45 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Aug 2019 07:27:45 -0700
From:   Yuval Shaia <yuval.shaia@oracle.com>
To:     dledford@redhat.com, jgg@ziepe.ca, leon@kernel.org,
        monis@mellanox.com, parav@mellanox.com, danielj@mellanox.com,
        kamalheib1@gmail.com, markz@mellanox.com,
        swise@opengridcomputing.com, shamir.rabinovitch@oracle.com,
        johannes.berg@intel.com, willy@infradead.org,
        michaelgur@mellanox.com, markb@mellanox.com,
        yuval.shaia@oracle.com, dan.carpenter@oracle.com,
        bvanassche@acm.org, maxg@mellanox.com, israelr@mellanox.com,
        galpress@amazon.com, denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, will@kernel.org, ereza@mellanox.com,
        jgg@mellanox.com, linux-rdma@vger.kernel.org
Cc:     Shamir Rabinovitch <srabinov7@gmail.com>
Subject: [PATCH v1 rdma-core 08/12] verbs: Introduce new verb to import MR object
Date:   Wed, 21 Aug 2019 17:26:35 +0300
Message-Id: <20190821142639.5807-9-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190821142639.5807-1-yuval.shaia@oracle.com>
References: <20190821142639.5807-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908210158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9355 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=29 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908210158
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Second step in sharing an IB object is to import the exported object.

A new IB verb is introduced to import an IB object from one context
(identified by it's fd) to a second one.

Importing an IB object increases the reference count of that object in
the kernel

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 kernel-headers/rdma/ib_user_verbs.h | 10 ++++++++++
 libibverbs/cmd.c                    | 21 +++++++++++++++++++++
 libibverbs/driver.h                 |  6 ++++++
 libibverbs/dummy_ops.c              |  9 +++++++++
 libibverbs/kern-abi.h               |  1 +
 libibverbs/libibverbs.map.in        |  1 +
 libibverbs/verbs.h                  | 20 ++++++++++++++++++++
 7 files changed, 68 insertions(+)

diff --git a/kernel-headers/rdma/ib_user_verbs.h b/kernel-headers/rdma/ib_user_verbs.h
index 872298bf..5e55979c 100644
--- a/kernel-headers/rdma/ib_user_verbs.h
+++ b/kernel-headers/rdma/ib_user_verbs.h
@@ -90,6 +90,7 @@ enum ib_uverbs_write_cmds {
 	IB_USER_VERBS_CMD_OPEN_QP,
 	IB_USER_VERBS_CMD_IMPORT_FROM_FD,
 	IB_USER_VERBS_CMD_IMPORT_PD = IB_USER_VERBS_CMD_IMPORT_FROM_FD,
+	IB_USER_VERBS_CMD_IMPORT_MR = IB_USER_VERBS_CMD_IMPORT_FROM_FD,
 };
 
 enum {
@@ -1309,9 +1310,18 @@ struct ib_uverbs_import_pd {
 	__u8  reserved[6];
 };
 
+struct ib_uverbs_import_mr {
+	__aligned_u64 response;
+	__u32 fd;
+	__u32 handle;
+	__u16 type;
+	__u8  reserved[6];
+};
+
 struct ib_uverbs_import_fr_fd_resp {
 	union {
 		struct ib_uverbs_alloc_pd_resp alloc_pd;
+		struct ib_uverbs_reg_mr_resp reg_mr;
 	} u;
 };
 
diff --git a/libibverbs/cmd.c b/libibverbs/cmd.c
index 75efcf75..f7dc5597 100644
--- a/libibverbs/cmd.c
+++ b/libibverbs/cmd.c
@@ -382,6 +382,27 @@ int ibv_cmd_reg_mr(struct ibv_pd *pd, void *addr, size_t length,
 	return 0;
 }
 
+int ibv_cmd_import_mr(struct ibv_context *context, struct verbs_mr *vmr,
+		      struct ibv_import_mr *cmd, size_t cmd_size,
+		      struct ib_uverbs_import_fr_fd_resp *resp,
+		      size_t resp_size)
+{
+	int ret;
+
+	ret = execute_cmd_write(context, IB_USER_VERBS_CMD_IMPORT_MR, cmd,
+				cmd_size, resp, resp_size);
+	if (ret)
+		return ret;
+
+	vmr->ibv_mr.handle  = resp->u.reg_mr.mr_handle;
+	vmr->ibv_mr.lkey    = resp->u.reg_mr.lkey;
+	vmr->ibv_mr.rkey    = resp->u.reg_mr.rkey;
+	vmr->ibv_mr.context = context;
+	vmr->mr_type        = IBV_MR_TYPE_MR;
+
+	return 0;
+}
+
 int ibv_cmd_rereg_mr(struct verbs_mr *vmr, uint32_t flags, void *addr,
 		     size_t length, uint64_t hca_va, int access,
 		     struct ibv_pd *pd, struct ibv_rereg_mr *cmd,
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index f2e2f11c..bb7ac1eb 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -317,6 +317,8 @@ struct verbs_context_ops {
 			    uint16_t lid);
 	int (*free_dm)(struct ibv_dm *dm);
 	int (*get_srq_num)(struct ibv_srq *srq, uint32_t *srq_num);
+	struct ibv_mr *(*import_mr)(struct ibv_context *context, uint32_t fd,
+				    uint32_t handle);
 	struct ibv_pd *(*import_pd)(struct ibv_context *context, uint32_t fd,
 				    uint32_t handle);
 	int (*modify_cq)(struct ibv_cq *cq, struct ibv_modify_cq_attr *attr);
@@ -479,6 +481,10 @@ int ibv_cmd_rereg_mr(struct verbs_mr *vmr, uint32_t flags, void *addr,
 		     size_t cmd_sz, struct ib_uverbs_rereg_mr_resp *resp,
 		     size_t resp_sz);
 int ibv_cmd_dereg_mr(struct verbs_mr *vmr);
+int ibv_cmd_import_mr(struct ibv_context *context, struct verbs_mr *vmr,
+		      struct ibv_import_mr *cmd, size_t cmd_size,
+		      struct ib_uverbs_import_fr_fd_resp *resp,
+		      size_t resp_size);
 int ibv_cmd_advise_mr(struct ibv_pd *pd,
 		      enum ibv_advise_mr_advice advice,
 		      uint32_t flags,
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index 295e0732..e577e12f 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -282,6 +282,13 @@ static int get_srq_num(struct ibv_srq *srq, uint32_t *srq_num)
 	return ENOSYS;
 }
 
+static struct ibv_mr *import_mr(struct ibv_context *context, uint32_t fd,
+				uint32_t handle)
+{
+	errno = ENOSYS;
+	return NULL;
+}
+
 static struct ibv_pd *import_pd(struct ibv_context *context, uint32_t fd,
 				uint32_t handle)
 {
@@ -494,6 +501,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	detach_mcast,
 	free_dm,
 	get_srq_num,
+	import_mr,
 	import_pd,
 	modify_cq,
 	modify_flow_action_esp,
@@ -636,6 +644,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_PRIV_OP(ctx, rereg_mr);
 	SET_PRIV_OP(ctx, resize_cq);
 	SET_OP(vctx, import_pd);
+	SET_OP(vctx, import_mr);
 
 #undef SET_OP
 #undef SET_OP2
diff --git a/libibverbs/kern-abi.h b/libibverbs/kern-abi.h
index 714be0c8..52eb2694 100644
--- a/libibverbs/kern-abi.h
+++ b/libibverbs/kern-abi.h
@@ -208,6 +208,7 @@ DECLARE_CMDX(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ, ibv_req_notify_cq, ib_uverbs_req_n
 DECLARE_CMD(IB_USER_VERBS_CMD_REREG_MR, ibv_rereg_mr, ib_uverbs_rereg_mr);
 DECLARE_CMD(IB_USER_VERBS_CMD_RESIZE_CQ, ibv_resize_cq, ib_uverbs_resize_cq);
 DECLARE_CMDX(IB_USER_VERBS_CMD_IMPORT_PD, ibv_import_pd, ib_uverbs_import_pd, ib_uverbs_import_fr_fd_resp);
+DECLARE_CMDX(IB_USER_VERBS_CMD_IMPORT_MR, ibv_import_mr, ib_uverbs_import_mr, ib_uverbs_import_fr_fd_resp);
 DECLARE_CMD_EX(IB_USER_VERBS_EX_CMD_CREATE_CQ, ibv_create_cq_ex, ib_uverbs_ex_create_cq);
 DECLARE_CMD_EX(IB_USER_VERBS_EX_CMD_CREATE_FLOW, ibv_create_flow, ib_uverbs_create_flow);
 DECLARE_CMD_EX(IB_USER_VERBS_EX_CMD_CREATE_QP, ibv_create_qp_ex, ib_uverbs_ex_create_qp);
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index 6fff7065..ee26d8a1 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -165,6 +165,7 @@ IBVERBS_PRIVATE_@IBVERBS_PABI_VERSION@ {
 		ibv_cmd_detach_mcast;
 		ibv_cmd_free_dm;
 		ibv_cmd_get_context;
+		ibv_cmd_import_mr;
 		ibv_cmd_import_pd;
 		ibv_cmd_modify_flow_action_esp;
 		ibv_cmd_modify_qp;
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index f3f7200a..259dd2c0 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2015,6 +2015,8 @@ struct ibv_values_ex {
 
 struct verbs_context {
 	/*  "grows up" - new fields go here */
+	struct ibv_mr *(*import_mr)(struct ibv_context *context, uint32_t fd,
+				    uint32_t handle);
 	struct ibv_pd *(*import_pd)(struct ibv_context *context, uint32_t fd,
 				    uint32_t handle);
 	int (*query_port)(struct ibv_context *context, uint8_t port_num,
@@ -3305,6 +3307,24 @@ static inline struct ibv_pd *ibv_import_pd(struct ibv_context *context,
 	return pd;
 }
 
+static inline struct ibv_mr *ibv_import_mr(struct ibv_context *context,
+					   uint32_t fd, uint32_t handle)
+{
+	struct verbs_context *vctx = verbs_get_ctx_op(context, import_mr);
+	struct ibv_mr *mr;
+
+	if (!vctx) {
+		errno = ENOSYS;
+		return NULL;
+	}
+
+	mr = vctx->import_mr(context, fd, handle);
+	if (mr)
+		mr->context = context;
+
+	return mr;
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.20.1

