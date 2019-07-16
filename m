Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F66AE30
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfGPSM5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:12:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42244 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSM5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:12:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GI9Scp108140;
        Tue, 16 Jul 2019 18:12:35 GMT
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2tq6qtp8g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:12:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICYlX027647;
        Tue, 16 Jul 2019 18:12:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tq4du2ty6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:12:34 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GICW1t020646;
        Tue, 16 Jul 2019 18:12:32 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:12:32 +0000
From:   Shamir Rabinovitch <srabinov7@gmail.com>
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
Subject: [PATCH 01/25] RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
Date:   Tue, 16 Jul 2019 21:11:36 +0300
Message-Id: <20190716181200.4239-2-srabinov7@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190716181200.4239-1-srabinov7@gmail.com>
References: <20190716181200.4239-1-srabinov7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160223
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1034
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160222
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

The uobject pointer will be removed from ib_x (ib_pd, ib_mr,...) objects.
uobj_get_obj_read and uobj_put_obj_read macros were constructed with the
assumption that ib_x can figure the uobject in mind.

Fix this wrong assumption.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 125 ++++++++++++++++++++-------
 include/rdma/uverbs_std_types.h      |   8 +-
 2 files changed, 98 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 7ddd0e5bc6b3..b0dc301918bf 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -37,6 +37,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/list.h>
 
 #include <linux/uaccess.h>
 
@@ -711,6 +712,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_reg_mr      cmd;
 	struct ib_uverbs_reg_mr_resp resp;
 	struct ib_uobject           *uobj;
+	struct ib_uobject           *pduobj;
 	struct ib_pd                *pd;
 	struct ib_mr                *mr;
 	int                          ret;
@@ -731,7 +733,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
+			       &pduobj);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err_free;
@@ -799,6 +802,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	struct ib_pd		    *old_pd;
 	int                          ret;
 	struct ib_uobject	    *uobj;
+	struct ib_uobject	    *pduobj = NULL;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -831,7 +835,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 
 	if (cmd.flags & IB_MR_REREG_PD) {
 		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle,
-				       attrs);
+				       attrs, &pduobj);
 		if (!pd) {
 			ret = -EINVAL;
 			goto put_uobjs;
@@ -885,6 +889,7 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_alloc_mw      cmd;
 	struct ib_uverbs_alloc_mw_resp resp;
 	struct ib_uobject             *uobj;
+	struct ib_uobject             *pduobj;
 	struct ib_pd                  *pd;
 	struct ib_mw                  *mw;
 	int                            ret;
@@ -898,7 +903,8 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
+			       &pduobj);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err_free;
@@ -1117,6 +1123,7 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_resize_cq	cmd;
 	struct ib_uverbs_resize_cq_resp	resp = {};
+	struct ib_uobject		*cquobj;
 	struct ib_cq			*cq;
 	int				ret = -EINVAL;
 
@@ -1124,7 +1131,8 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       &cquobj);
 	if (!cq)
 		return -EINVAL;
 
@@ -1177,6 +1185,7 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_poll_cq_resp  resp;
 	u8 __user                     *header_ptr;
 	u8 __user                     *data_ptr;
+	struct ib_uobject	      *cquobj;
 	struct ib_cq                  *cq;
 	struct ib_wc                   wc;
 	int                            ret;
@@ -1185,7 +1194,8 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       &cquobj);
 	if (!cq)
 		return -EINVAL;
 
@@ -1226,6 +1236,7 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_req_notify_cq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_req_notify_cq cmd;
+	struct ib_uobject	      *cquobj;
 	struct ib_cq                  *cq;
 	int ret;
 
@@ -1233,7 +1244,8 @@ static int ib_uverbs_req_notify_cq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       &cquobj);
 	if (!cq)
 		return -EINVAL;
 
@@ -1276,16 +1288,21 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 {
 	struct ib_uqp_object		*obj;
 	struct ib_device		*device;
+	struct ib_uobject		*pd_uobj = ERR_PTR(-ENOENT);
 	struct ib_pd			*pd = NULL;
 	struct ib_xrcd			*xrcd = NULL;
 	struct ib_uobject		*xrcd_uobj = ERR_PTR(-ENOENT);
+	struct ib_uobject		*scq_uobj = ERR_PTR(-ENOENT);
+	struct ib_uobject		*rcq_uobj = ERR_PTR(-ENOENT);
 	struct ib_cq			*scq = NULL, *rcq = NULL;
+	struct ib_uobject		*srq_uobj = ERR_PTR(-ENOENT);
 	struct ib_srq			*srq = NULL;
 	struct ib_qp			*qp;
 	struct ib_qp_init_attr		attr = {};
 	struct ib_uverbs_ex_create_qp_resp resp;
 	int				ret;
 	struct ib_rwq_ind_table *ind_tbl = NULL;
+	struct ib_uobject	*ind_tbl_uobj = ERR_PTR(-ENOENT);
 	bool has_sq = true;
 	struct ib_device *ib_dev;
 
@@ -1303,7 +1320,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	if (cmd->comp_mask & IB_UVERBS_CREATE_QP_MASK_IND_TABLE) {
 		ind_tbl = uobj_get_obj_read(rwq_ind_table,
 					    UVERBS_OBJECT_RWQ_IND_TBL,
-					    cmd->rwq_ind_tbl_handle, attrs);
+					    cmd->rwq_ind_tbl_handle, attrs,
+					    &ind_tbl_uobj);
 		if (!ind_tbl) {
 			ret = -EINVAL;
 			goto err_put;
@@ -1342,7 +1360,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		} else {
 			if (cmd->is_srq) {
 				srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ,
-							cmd->srq_handle, attrs);
+							cmd->srq_handle, attrs,
+							&srq_uobj);
 				if (!srq || srq->srq_type == IB_SRQT_XRC) {
 					ret = -EINVAL;
 					goto err_put;
@@ -1353,7 +1372,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 				if (cmd->recv_cq_handle != cmd->send_cq_handle) {
 					rcq = uobj_get_obj_read(
 						cq, UVERBS_OBJECT_CQ,
-						cmd->recv_cq_handle, attrs);
+						cmd->recv_cq_handle, attrs,
+						&rcq_uobj);
 					if (!rcq) {
 						ret = -EINVAL;
 						goto err_put;
@@ -1364,11 +1384,12 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 
 		if (has_sq)
 			scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
-						cmd->send_cq_handle, attrs);
+						cmd->send_cq_handle, attrs,
+						&scq_uobj);
 		if (!ind_tbl)
 			rcq = rcq ?: scq;
 		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle,
-				       attrs);
+				       attrs, &pd_uobj);
 		if (!pd || (!scq && has_sq)) {
 			ret = -EINVAL;
 			goto err_put;
@@ -1663,6 +1684,7 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_query_qp      cmd;
 	struct ib_uverbs_query_qp_resp resp;
+	struct ib_uobject	       *qpuobj;
 	struct ib_qp                   *qp;
 	struct ib_qp_attr              *attr;
 	struct ib_qp_init_attr         *init_attr;
@@ -1679,7 +1701,8 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 		goto out;
 	}
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -1776,6 +1799,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		     struct ib_uverbs_ex_modify_qp *cmd)
 {
 	struct ib_qp_attr *attr;
+	struct ib_uobject *qpuobj;
 	struct ib_qp *qp;
 	int ret;
 
@@ -1784,7 +1808,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		return -ENOMEM;
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd->base.qp_handle,
-			       attrs);
+			       attrs, &qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -2018,6 +2042,7 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_send_wr       *user_wr;
 	struct ib_send_wr              *wr = NULL, *last, *next;
 	const struct ib_send_wr	       *bad_wr;
+	struct ib_uobject	       *qpuobj;
 	struct ib_qp                   *qp;
 	int                             i, sg_ind;
 	int				is_ud;
@@ -2045,7 +2070,8 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	if (!user_wr)
 		return -ENOMEM;
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -2068,6 +2094,7 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 
 		if (is_ud) {
 			struct ib_ud_wr *ud;
+			struct ib_uobject *uobj;
 
 			if (user_wr->opcode != IB_WR_SEND &&
 			    user_wr->opcode != IB_WR_SEND_WITH_IMM) {
@@ -2083,7 +2110,8 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 			}
 
 			ud->ah = uobj_get_obj_read(ah, UVERBS_OBJECT_AH,
-						   user_wr->wr.ud.ah, attrs);
+						   user_wr->wr.ud.ah, attrs,
+						   &uobj);
 			if (!ud->ah) {
 				kfree(ud);
 				ret = -EINVAL;
@@ -2308,6 +2336,7 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_post_recv_resp resp;
 	struct ib_recv_wr              *wr, *next;
 	const struct ib_recv_wr	       *bad_wr;
+	struct ib_uobject	       *qpuobj;
 	struct ib_qp                   *qp;
 	int ret, ret2;
 	struct uverbs_req_iter iter;
@@ -2321,7 +2350,8 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(wr))
 		return PTR_ERR(wr);
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -2358,6 +2388,7 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_post_srq_recv_resp resp;
 	struct ib_recv_wr                  *wr, *next;
 	const struct ib_recv_wr		   *bad_wr;
+	struct ib_uobject		   *srquobj;
 	struct ib_srq                      *srq;
 	int ret, ret2;
 	struct uverbs_req_iter iter;
@@ -2371,7 +2402,8 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(wr))
 		return PTR_ERR(wr);
 
-	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
+	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs,
+				&srquobj);
 	if (!srq) {
 		ret = -EINVAL;
 		goto out;
@@ -2408,6 +2440,7 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_create_ah	 cmd;
 	struct ib_uverbs_create_ah_resp	 resp;
 	struct ib_uobject		*uobj;
+	struct ib_uobject		*pduobj;
 	struct ib_pd			*pd;
 	struct ib_ah			*ah;
 	struct rdma_ah_attr		attr = {};
@@ -2427,7 +2460,8 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 		goto err;
 	}
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
+			       &pduobj);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err;
@@ -2497,6 +2531,7 @@ static int ib_uverbs_destroy_ah(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_attach_mcast cmd;
+	struct ib_uobject	     *qpuobj;
 	struct ib_qp                 *qp;
 	struct ib_uqp_object         *obj;
 	struct ib_uverbs_mcast_entry *mcast;
@@ -2506,7 +2541,8 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp)
 		return -EINVAL;
 
@@ -2546,6 +2582,7 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_detach_mcast cmd;
 	struct ib_uqp_object         *obj;
+	struct ib_uobject	     *qpuobj;
 	struct ib_qp                 *qp;
 	struct ib_uverbs_mcast_entry *mcast;
 	int                           ret;
@@ -2555,7 +2592,8 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp)
 		return -EINVAL;
 
@@ -2665,6 +2703,8 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 				       union ib_flow_spec *ib_spec,
 				       struct ib_uflow_resources *uflow_res)
 {
+	struct ib_uobject *uobj;
+
 	ib_spec->type = kern_spec->type;
 	switch (ib_spec->type) {
 	case IB_FLOW_SPEC_ACTION_TAG:
@@ -2689,7 +2729,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 		ib_spec->action.act = uobj_get_obj_read(flow_action,
 							UVERBS_OBJECT_FLOW_ACTION,
 							kern_spec->action.handle,
-							attrs);
+							attrs, &uobj);
 		if (!ib_spec->action.act)
 			return -EINVAL;
 		ib_spec->action.size =
@@ -2707,7 +2747,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 			uobj_get_obj_read(counters,
 					  UVERBS_OBJECT_COUNTERS,
 					  kern_spec->flow_count.handle,
-					  attrs);
+					  attrs, &uobj);
 		if (!ib_spec->flow_count.counters)
 			return -EINVAL;
 		ib_spec->flow_count.size =
@@ -2909,6 +2949,8 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_ex_create_wq_resp resp = {};
 	struct ib_uwq_object           *obj;
 	int err = 0;
+	struct ib_uobject *cquobj;
+	struct ib_uobject *pduobj;
 	struct ib_cq *cq;
 	struct ib_pd *pd;
 	struct ib_wq *wq;
@@ -2927,13 +2969,15 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
+			       &pduobj);
 	if (!pd) {
 		err = -EINVAL;
 		goto err_uobj;
 	}
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       &cquobj);
 	if (!cq) {
 		err = -EINVAL;
 		goto err_put_pd;
@@ -3025,6 +3069,7 @@ static int ib_uverbs_ex_destroy_wq(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_ex_modify_wq cmd;
+	struct ib_uobject *wquobj;
 	struct ib_wq *wq;
 	struct ib_wq_attr wq_attr = {};
 	int ret;
@@ -3039,7 +3084,8 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 	if (cmd.attr_mask > (IB_WQ_STATE | IB_WQ_CUR_STATE | IB_WQ_FLAGS))
 		return -EINVAL;
 
-	wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ, cmd.wq_handle, attrs);
+	wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ, cmd.wq_handle, attrs,
+			       &wquobj);
 	if (!wq)
 		return -EINVAL;
 
@@ -3104,8 +3150,11 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 
 	for (num_read_wqs = 0; num_read_wqs < num_wq_handles;
 			num_read_wqs++) {
+		struct ib_uobject *uobj;
+
 		wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ,
-				       wqs_handles[num_read_wqs], attrs);
+				       wqs_handles[num_read_wqs], attrs,
+				       &uobj);
 		if (!wq) {
 			err = -EINVAL;
 			goto put_wqs;
@@ -3166,6 +3215,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 err_free:
 	kfree(wqs_handles);
 	kfree(wqs);
+
 	return err;
 }
 
@@ -3193,6 +3243,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	struct ib_flow			  *flow_id;
 	struct ib_uverbs_flow_attr	  *kern_flow_attr;
 	struct ib_flow_attr		  *flow_attr;
+	struct ib_uobject		  *qpuobj;
 	struct ib_qp			  *qp;
 	struct ib_uflow_resources	  *uflow_res;
 	struct ib_uverbs_flow_spec_hdr	  *kern_spec;
@@ -3256,7 +3307,8 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 		goto err_free_attr;
 	}
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp) {
 		err = -EINVAL;
 		goto err_uobj;
@@ -3371,6 +3423,8 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 {
 	struct ib_uverbs_create_srq_resp resp;
 	struct ib_usrq_object           *obj;
+	struct ib_uobject		*cquobj = ERR_PTR(-ENOENT);
+	struct ib_uobject		*pduobj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
 	struct ib_uobject               *uninitialized_var(xrcd_uobj);
@@ -3406,14 +3460,15 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 
 	if (ib_srq_has_cq(cmd->srq_type)) {
 		attr.ext.cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
-						cmd->cq_handle, attrs);
+						cmd->cq_handle, attrs, &cquobj);
 		if (!attr.ext.cq) {
 			ret = -EINVAL;
 			goto err_put_xrcd;
 		}
 	}
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle, attrs,
+			       &pduobj);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err_put_cq;
@@ -3542,6 +3597,7 @@ static int ib_uverbs_create_xsrq(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_modify_srq cmd;
+	struct ib_uobject	   *srquobj;
 	struct ib_srq              *srq;
 	struct ib_srq_attr          attr;
 	int                         ret;
@@ -3550,7 +3606,8 @@ static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
+	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs,
+				&srquobj);
 	if (!srq)
 		return -EINVAL;
 
@@ -3570,6 +3627,7 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_query_srq      cmd;
 	struct ib_uverbs_query_srq_resp resp;
 	struct ib_srq_attr              attr;
+	struct ib_uobject		*srquobj;
 	struct ib_srq                   *srq;
 	int                             ret;
 
@@ -3577,7 +3635,8 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
+	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs,
+				&srquobj);
 	if (!srq)
 		return -EINVAL;
 
@@ -3689,6 +3748,7 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_ex_modify_cq cmd;
+	struct ib_uobject *cquobj;
 	struct ib_cq *cq;
 	int ret;
 
@@ -3702,7 +3762,8 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 	if (cmd.attr_mask > IB_CQ_MODERATE)
 		return -EOPNOTSUPP;
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       &cquobj);
 	if (!cq)
 		return -EINVAL;
 
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index 05eabfd5d0d3..578e5c28bc1c 100644
--- a/include/rdma/uverbs_std_types.h
+++ b/include/rdma/uverbs_std_types.h
@@ -64,9 +64,11 @@ static inline void *_uobj_get_obj_read(struct ib_uobject *uobj)
 		return NULL;
 	return uobj->object;
 }
-#define uobj_get_obj_read(_object, _type, _id, _attrs)                         \
-	((struct ib_##_object *)_uobj_get_obj_read(                            \
-		uobj_get_read(_type, _id, _attrs)))
+#define uobj_get_obj_read(_object, _type, _id, _attrs, _uobj)                  \
+({                                                                             \
+	*_uobj = uobj_get_read(_type, _id, _attrs);                            \
+	((struct ib_##_object *)_uobj_get_obj_read(*_uobj));                   \
+})
 
 #define uobj_get_write(_type, _id, _attrs)                                     \
 	rdma_lookup_get_uobject(uobj_get_type(_attrs, _type), (_attrs)->ufile, \
-- 
2.20.1

