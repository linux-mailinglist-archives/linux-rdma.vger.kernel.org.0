Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28286AE79
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfGPSVm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:21:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbfGPSVm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:21:42 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIIhad116349;
        Tue, 16 Jul 2019 18:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=0XHAWgmjgx7ZuVRjazrv0OQYOVJXOqU/UTo1EYRFA4s=;
 b=hWfQmT6fvj+QC4lD0PkbRVd/o1EYYe1zIRIz/3cVbZif7CQvfjsIRU2tXdeeqLvTG5oI
 X3LDh5AFhYFO3+IWAowoiJaz63n9ubpw7R6XDl3IdPWNravowQvmeVCGAd1xdRkotnsW
 TcJYWSTSWLjGZkOAVHuglXADf2e4dPjtOgRSoiuN2SJelMNcMl79nCo91MALiwymtBUB
 pHir0Uf/Q2UgABUxOJgLBxWSKeUb6Mapc/ulfnhfT/JQQ0uQwxjYbGO57nKylkOWppLT
 8uS/t5kfz0dBKfkrM2J0T3gQ84VlNXLOVY4e1ZRhP4kChIEX25/crNywuB/oVdIpyCyA Pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtp9v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:21:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIHpiS038329;
        Tue, 16 Jul 2019 18:19:17 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tq4du2wku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:19:16 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GIJF9F003077;
        Tue, 16 Jul 2019 18:19:15 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:19:15 +0000
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
Subject: [PATCH rdma-core 03/12] verbs: Introduce new verb to import PD object
Date:   Tue, 16 Jul 2019 21:18:31 +0300
Message-Id: <20190716181840.4579-4-yuval.shaia@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716181840.4579-1-yuval.shaia@oracle.com>
References: <20190716181840.4579-1-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160224
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=29 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160224
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Second step in sharing an IB object is to import the exported object.

A new IB verb is introduced to import an IB object from one context
(identified by it's fd) to a second one.

Importing an IB object increases the reference count of that object in
the kernel.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 kernel-headers/rdma/ib_user_verbs.h | 16 ++++++++++++++++
 libibverbs/cmd.c                    | 18 ++++++++++++++++++
 libibverbs/driver.h                 |  6 ++++++
 libibverbs/dummy_ops.c              |  9 +++++++++
 libibverbs/kern-abi.h               |  2 +-
 libibverbs/libibverbs.map.in        |  2 ++
 libibverbs/verbs.h                  | 20 ++++++++++++++++++++
 7 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/kernel-headers/rdma/ib_user_verbs.h b/kernel-headers/rdma/ib_user_verbs.h
index 0474c740..872298bf 100644
--- a/kernel-headers/rdma/ib_user_verbs.h
+++ b/kernel-headers/rdma/ib_user_verbs.h
@@ -88,6 +88,8 @@ enum ib_uverbs_write_cmds {
 	IB_USER_VERBS_CMD_CLOSE_XRCD,
 	IB_USER_VERBS_CMD_CREATE_XSRQ,
 	IB_USER_VERBS_CMD_OPEN_QP,
+	IB_USER_VERBS_CMD_IMPORT_FROM_FD,
+	IB_USER_VERBS_CMD_IMPORT_PD = IB_USER_VERBS_CMD_IMPORT_FROM_FD,
 };
 
 enum {
@@ -1299,6 +1301,20 @@ struct ib_uverbs_ex_modify_cq {
 	__u32 reserved;
 };
 
+struct ib_uverbs_import_pd {
+	__aligned_u64 response;
+	__u32 fd;
+	__u32 handle;
+	__u16 type;
+	__u8  reserved[6];
+};
+
+struct ib_uverbs_import_fr_fd_resp {
+	union {
+		struct ib_uverbs_alloc_pd_resp alloc_pd;
+	} u;
+};
+
 #define IB_DEVICE_NAME_MAX 64
 
 #endif /* IB_USER_VERBS_H */
diff --git a/libibverbs/cmd.c b/libibverbs/cmd.c
index 5291abfd..5500ae16 100644
--- a/libibverbs/cmd.c
+++ b/libibverbs/cmd.c
@@ -294,6 +294,24 @@ int ibv_cmd_alloc_pd(struct ibv_context *context, struct ibv_pd *pd,
 	return 0;
 }
 
+int ibv_cmd_import_pd(struct ibv_context *context, struct ibv_pd *pd,
+		      struct ibv_import_pd *cmd, size_t cmd_size,
+		      struct ib_uverbs_import_fr_fd_resp *resp,
+		      size_t resp_size)
+{
+	int ret;
+
+	ret = execute_cmd_write(context, IB_USER_VERBS_CMD_IMPORT_PD, cmd,
+				cmd_size, resp, resp_size);
+	if (ret)
+		return ret;
+
+	pd->handle  = resp->u.alloc_pd.pd_handle;
+	pd->context = context;
+
+	return 0;
+}
+
 int ibv_cmd_open_xrcd(struct ibv_context *context, struct verbs_xrcd *xrcd,
 		      int vxrcd_size,
 		      struct ibv_xrcd_init_attr *attr,
diff --git a/libibverbs/driver.h b/libibverbs/driver.h
index 2e2131f2..fda80bef 100644
--- a/libibverbs/driver.h
+++ b/libibverbs/driver.h
@@ -317,6 +317,8 @@ struct verbs_context_ops {
 			    uint16_t lid);
 	int (*free_dm)(struct ibv_dm *dm);
 	int (*get_srq_num)(struct ibv_srq *srq, uint32_t *srq_num);
+	struct ibv_pd *(*import_pd)(struct ibv_context *context, uint32_t fd,
+				    uint32_t handle);
 	int (*modify_cq)(struct ibv_cq *cq, struct ibv_modify_cq_attr *attr);
 	int (*modify_flow_action_esp)(struct ibv_flow_action *action,
 				      struct ibv_flow_action_esp_attr *attr);
@@ -456,6 +458,10 @@ int ibv_cmd_alloc_pd(struct ibv_context *context, struct ibv_pd *pd,
 		     struct ibv_alloc_pd *cmd, size_t cmd_size,
 		     struct ib_uverbs_alloc_pd_resp *resp, size_t resp_size);
 int ibv_cmd_dealloc_pd(struct ibv_pd *pd);
+int ibv_cmd_import_pd(struct ibv_context *context, struct ibv_pd *pd,
+		      struct ibv_import_pd *cmd, size_t cmd_size,
+		      struct ib_uverbs_import_fr_fd_resp *resp,
+		      size_t resp_size);
 int ibv_cmd_open_xrcd(struct ibv_context *context, struct verbs_xrcd *xrcd,
 		      int vxrcd_size,
 		      struct ibv_xrcd_init_attr *attr,
diff --git a/libibverbs/dummy_ops.c b/libibverbs/dummy_ops.c
index ebc6eddd..026bc71c 100644
--- a/libibverbs/dummy_ops.c
+++ b/libibverbs/dummy_ops.c
@@ -282,6 +282,13 @@ static int get_srq_num(struct ibv_srq *srq, uint32_t *srq_num)
 	return ENOSYS;
 }
 
+static struct ibv_pd *import_pd(struct ibv_context *context, uint32_t fd,
+				uint32_t handle)
+{
+	errno = ENOSYS;
+	return NULL;
+}
+
 static int modify_cq(struct ibv_cq *cq, struct ibv_modify_cq_attr *attr)
 {
 	return ENOSYS;
@@ -487,6 +494,7 @@ const struct verbs_context_ops verbs_dummy_ops = {
 	detach_mcast,
 	free_dm,
 	get_srq_num,
+	import_pd,
 	modify_cq,
 	modify_flow_action_esp,
 	modify_qp,
@@ -627,6 +635,7 @@ void verbs_set_ops(struct verbs_context *vctx,
 	SET_OP(ctx, req_notify_cq);
 	SET_PRIV_OP(ctx, rereg_mr);
 	SET_PRIV_OP(ctx, resize_cq);
+	SET_OP(vctx, import_pd);
 
 #undef SET_OP
 #undef SET_OP2
diff --git a/libibverbs/kern-abi.h b/libibverbs/kern-abi.h
index dc2f33d3..714be0c8 100644
--- a/libibverbs/kern-abi.h
+++ b/libibverbs/kern-abi.h
@@ -207,7 +207,7 @@ DECLARE_CMD(IB_USER_VERBS_CMD_REG_MR, ibv_reg_mr, ib_uverbs_reg_mr);
 DECLARE_CMDX(IB_USER_VERBS_CMD_REQ_NOTIFY_CQ, ibv_req_notify_cq, ib_uverbs_req_notify_cq, empty);
 DECLARE_CMD(IB_USER_VERBS_CMD_REREG_MR, ibv_rereg_mr, ib_uverbs_rereg_mr);
 DECLARE_CMD(IB_USER_VERBS_CMD_RESIZE_CQ, ibv_resize_cq, ib_uverbs_resize_cq);
-
+DECLARE_CMDX(IB_USER_VERBS_CMD_IMPORT_PD, ibv_import_pd, ib_uverbs_import_pd, ib_uverbs_import_fr_fd_resp);
 DECLARE_CMD_EX(IB_USER_VERBS_EX_CMD_CREATE_CQ, ibv_create_cq_ex, ib_uverbs_ex_create_cq);
 DECLARE_CMD_EX(IB_USER_VERBS_EX_CMD_CREATE_FLOW, ibv_create_flow, ib_uverbs_create_flow);
 DECLARE_CMD_EX(IB_USER_VERBS_EX_CMD_CREATE_QP, ibv_create_qp_ex, ib_uverbs_ex_create_qp);
diff --git a/libibverbs/libibverbs.map.in b/libibverbs/libibverbs.map.in
index ee253ec0..b034cd36 100644
--- a/libibverbs/libibverbs.map.in
+++ b/libibverbs/libibverbs.map.in
@@ -114,6 +114,7 @@ IBVERBS_1.5 {
 IBVERBS_1.6 {
 	global:
 		ibv_qp_to_qp_ex;
+		ibv_import_pd;
 } IBVERBS_1.5;
 
 /* If any symbols in this stanza change ABI then the entire staza gets a new symbol
@@ -159,6 +160,7 @@ IBVERBS_PRIVATE_@IBVERBS_PABI_VERSION@ {
 		ibv_cmd_detach_mcast;
 		ibv_cmd_free_dm;
 		ibv_cmd_get_context;
+		ibv_cmd_import_pd;
 		ibv_cmd_modify_flow_action_esp;
 		ibv_cmd_modify_qp;
 		ibv_cmd_modify_qp_ex;
diff --git a/libibverbs/verbs.h b/libibverbs/verbs.h
index ff593d93..cb1a021b 100644
--- a/libibverbs/verbs.h
+++ b/libibverbs/verbs.h
@@ -2015,6 +2015,8 @@ struct ibv_values_ex {
 
 struct verbs_context {
 	/*  "grows up" - new fields go here */
+	struct ibv_pd *(*import_pd)(struct ibv_context *context, uint32_t fd,
+				    uint32_t handle);
 	int (*query_port)(struct ibv_context *context, uint8_t port_num,
 			  struct ibv_port_attr *port_attr,
 			  size_t port_attr_len);
@@ -3278,6 +3280,24 @@ static inline uint32_t ibv_mr_to_handle(struct ibv_mr *mr)
 	return mr->handle;
 }
 
+static inline struct ibv_pd *ibv_import_pd(struct ibv_context *context,
+					   uint32_t fd, uint32_t handle)
+{
+	struct verbs_context *vctx = verbs_get_ctx_op(context, import_pd);
+	struct ibv_pd *pd;
+
+	if (!vctx) {
+		errno = ENOSYS;
+		return NULL;
+	}
+
+	pd = vctx->import_pd(context, fd, handle);
+	if (pd)
+		pd->context = context;
+
+	return pd;
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.20.1

