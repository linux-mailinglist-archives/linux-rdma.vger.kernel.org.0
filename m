Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78F2C22D6F
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfETHyn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 03:54:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54456 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfETHyn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 May 2019 03:54:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4K7nBgE147944;
        Mon, 20 May 2019 07:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=YcGj2FSkIYR715FBkpPX/T4DVUavtCslUDAYxXz5G7U=;
 b=iyW8ZCDAiAXy+3CwI07kOTRmfKkx/qCtDcILAz0bMAw91HSom5NQCy3Nm5NpXwTgQGVu
 0lUS1T85AsvMNXj8mgO9kTLFcWsxsWXOlDK6EfmA4zGhrZ2fTisIFJCa6S2c+3ZBVa/p
 pAuhhxDFZRZ35caIFfqyGTp7NldcXL9ezstyg2UZCEE8/3WN5fOvMv0lcSxTA3KLWdeK
 9pyjMuHwp38sC52qgqFafF22hrznjZ4WBBwLi5x50iDYzM/hTU/u30xoAXop4OB1y+32
 u5VgoxxBnol+YbAyN6+UesZnjzvQQCISgUNWFn4FEyusre4wat+5SrAn0v+E1LK0B+5N 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sj9ft5793-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 07:54:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4K7rY72119305;
        Mon, 20 May 2019 07:54:30 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2skbphnhbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 May 2019 07:54:30 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4K7sTWC028221;
        Mon, 20 May 2019 07:54:29 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.35.172)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 May 2019 07:54:28 +0000
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     dledford@redhat.com, jgg@mellanox.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     shamir.rabinovitch@oracle.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH for-next v2 1/4] RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
Date:   Mon, 20 May 2019 10:53:18 +0300
Message-Id: <20190520075333.6002-2-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
References: <20190520075333.6002-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905200057
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9262 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905200057
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

future patch will remove the ib_uobject pointer from the ib_x
objects. the uobj_get_obj_read and uobj_put_obj_read macros
were constructed with the ability to reach the ib_uobject from
ib_x in mind. this need to change now.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 125 ++++++++++++++++++++-------
 include/rdma/uverbs_std_types.h      |   8 +-
 2 files changed, 98 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5a3a1780ceea..f1320de2b388 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -37,6 +37,7 @@
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/list.h>
 
 #include <linux/uaccess.h>
 
@@ -700,6 +701,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_reg_mr      cmd;
 	struct ib_uverbs_reg_mr_resp resp;
 	struct ib_uobject           *uobj;
+	struct ib_uobject           *pduobj;
 	struct ib_pd                *pd;
 	struct ib_mr                *mr;
 	int                          ret;
@@ -720,7 +722,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
+			       &pduobj);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err_free;
@@ -786,6 +789,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	struct ib_pd		    *old_pd;
 	int                          ret;
 	struct ib_uobject	    *uobj;
+	struct ib_uobject	    *pduobj = NULL;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
 	if (ret)
@@ -818,7 +822,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 
 	if (cmd.flags & IB_MR_REREG_PD) {
 		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle,
-				       attrs);
+				       attrs, &pduobj);
 		if (!pd) {
 			ret = -EINVAL;
 			goto put_uobjs;
@@ -872,6 +876,7 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_alloc_mw      cmd;
 	struct ib_uverbs_alloc_mw_resp resp;
 	struct ib_uobject             *uobj;
+	struct ib_uobject             *pduobj;
 	struct ib_pd                  *pd;
 	struct ib_mw                  *mw;
 	int                            ret;
@@ -885,7 +890,8 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
+			       &pduobj);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err_free;
@@ -1099,6 +1105,7 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_resize_cq	cmd;
 	struct ib_uverbs_resize_cq_resp	resp = {};
+	struct ib_uobject		*cquobj;
 	struct ib_cq			*cq;
 	int				ret = -EINVAL;
 
@@ -1106,7 +1113,8 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       &cquobj);
 	if (!cq)
 		return -EINVAL;
 
@@ -1159,6 +1167,7 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_poll_cq_resp  resp;
 	u8 __user                     *header_ptr;
 	u8 __user                     *data_ptr;
+	struct ib_uobject	      *cquobj;
 	struct ib_cq                  *cq;
 	struct ib_wc                   wc;
 	int                            ret;
@@ -1167,7 +1176,8 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       &cquobj);
 	if (!cq)
 		return -EINVAL;
 
@@ -1208,6 +1218,7 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_req_notify_cq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_req_notify_cq cmd;
+	struct ib_uobject	      *cquobj;
 	struct ib_cq                  *cq;
 	int ret;
 
@@ -1215,7 +1226,8 @@ static int ib_uverbs_req_notify_cq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       &cquobj);
 	if (!cq)
 		return -EINVAL;
 
@@ -1258,16 +1270,21 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
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
 
@@ -1285,7 +1302,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	if (cmd->comp_mask & IB_UVERBS_CREATE_QP_MASK_IND_TABLE) {
 		ind_tbl = uobj_get_obj_read(rwq_ind_table,
 					    UVERBS_OBJECT_RWQ_IND_TBL,
-					    cmd->rwq_ind_tbl_handle, attrs);
+					    cmd->rwq_ind_tbl_handle, attrs,
+					    &ind_tbl_uobj);
 		if (!ind_tbl) {
 			ret = -EINVAL;
 			goto err_put;
@@ -1324,7 +1342,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		} else {
 			if (cmd->is_srq) {
 				srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ,
-							cmd->srq_handle, attrs);
+							cmd->srq_handle, attrs,
+							&srq_uobj);
 				if (!srq || srq->srq_type == IB_SRQT_XRC) {
 					ret = -EINVAL;
 					goto err_put;
@@ -1335,7 +1354,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 				if (cmd->recv_cq_handle != cmd->send_cq_handle) {
 					rcq = uobj_get_obj_read(
 						cq, UVERBS_OBJECT_CQ,
-						cmd->recv_cq_handle, attrs);
+						cmd->recv_cq_handle, attrs,
+						&rcq_uobj);
 					if (!rcq) {
 						ret = -EINVAL;
 						goto err_put;
@@ -1346,11 +1366,12 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 
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
@@ -1645,6 +1666,7 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_query_qp      cmd;
 	struct ib_uverbs_query_qp_resp resp;
+	struct ib_uobject	       *qpuobj;
 	struct ib_qp                   *qp;
 	struct ib_qp_attr              *attr;
 	struct ib_qp_init_attr         *init_attr;
@@ -1661,7 +1683,8 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 		goto out;
 	}
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -1758,6 +1781,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		     struct ib_uverbs_ex_modify_qp *cmd)
 {
 	struct ib_qp_attr *attr;
+	struct ib_uobject *qpuobj;
 	struct ib_qp *qp;
 	int ret;
 
@@ -1766,7 +1790,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		return -ENOMEM;
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd->base.qp_handle,
-			       attrs);
+			       attrs, &qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -2000,6 +2024,7 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_send_wr       *user_wr;
 	struct ib_send_wr              *wr = NULL, *last, *next;
 	const struct ib_send_wr	       *bad_wr;
+	struct ib_uobject	       *qpuobj;
 	struct ib_qp                   *qp;
 	int                             i, sg_ind;
 	int				is_ud;
@@ -2027,7 +2052,8 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	if (!user_wr)
 		return -ENOMEM;
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -2050,6 +2076,7 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 
 		if (is_ud) {
 			struct ib_ud_wr *ud;
+			struct ib_uobject *uobj;
 
 			if (user_wr->opcode != IB_WR_SEND &&
 			    user_wr->opcode != IB_WR_SEND_WITH_IMM) {
@@ -2065,7 +2092,8 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 			}
 
 			ud->ah = uobj_get_obj_read(ah, UVERBS_OBJECT_AH,
-						   user_wr->wr.ud.ah, attrs);
+						   user_wr->wr.ud.ah, attrs,
+						   &uobj);
 			if (!ud->ah) {
 				kfree(ud);
 				ret = -EINVAL;
@@ -2290,6 +2318,7 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_post_recv_resp resp;
 	struct ib_recv_wr              *wr, *next;
 	const struct ib_recv_wr	       *bad_wr;
+	struct ib_uobject	       *qpuobj;
 	struct ib_qp                   *qp;
 	int ret, ret2;
 	struct uverbs_req_iter iter;
@@ -2303,7 +2332,8 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(wr))
 		return PTR_ERR(wr);
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -2340,6 +2370,7 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_post_srq_recv_resp resp;
 	struct ib_recv_wr                  *wr, *next;
 	const struct ib_recv_wr		   *bad_wr;
+	struct ib_uobject		   *srquobj;
 	struct ib_srq                      *srq;
 	int ret, ret2;
 	struct uverbs_req_iter iter;
@@ -2353,7 +2384,8 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(wr))
 		return PTR_ERR(wr);
 
-	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
+	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs,
+				&srquobj);
 	if (!srq) {
 		ret = -EINVAL;
 		goto out;
@@ -2390,6 +2422,7 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_create_ah	 cmd;
 	struct ib_uverbs_create_ah_resp	 resp;
 	struct ib_uobject		*uobj;
+	struct ib_uobject		*pduobj;
 	struct ib_pd			*pd;
 	struct ib_ah			*ah;
 	struct rdma_ah_attr		attr = {};
@@ -2409,7 +2442,8 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 		goto err;
 	}
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
+			       &pduobj);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err;
@@ -2478,6 +2512,7 @@ static int ib_uverbs_destroy_ah(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_attach_mcast cmd;
+	struct ib_uobject	     *qpuobj;
 	struct ib_qp                 *qp;
 	struct ib_uqp_object         *obj;
 	struct ib_uverbs_mcast_entry *mcast;
@@ -2487,7 +2522,8 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp)
 		return -EINVAL;
 
@@ -2527,6 +2563,7 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_detach_mcast cmd;
 	struct ib_uqp_object         *obj;
+	struct ib_uobject	     *qpuobj;
 	struct ib_qp                 *qp;
 	struct ib_uverbs_mcast_entry *mcast;
 	int                           ret = -EINVAL;
@@ -2536,7 +2573,8 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp)
 		return -EINVAL;
 
@@ -2646,6 +2684,8 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 				       union ib_flow_spec *ib_spec,
 				       struct ib_uflow_resources *uflow_res)
 {
+	struct ib_uobject *uobj;
+
 	ib_spec->type = kern_spec->type;
 	switch (ib_spec->type) {
 	case IB_FLOW_SPEC_ACTION_TAG:
@@ -2670,7 +2710,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 		ib_spec->action.act = uobj_get_obj_read(flow_action,
 							UVERBS_OBJECT_FLOW_ACTION,
 							kern_spec->action.handle,
-							attrs);
+							attrs, &uobj);
 		if (!ib_spec->action.act)
 			return -EINVAL;
 		ib_spec->action.size =
@@ -2688,7 +2728,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 			uobj_get_obj_read(counters,
 					  UVERBS_OBJECT_COUNTERS,
 					  kern_spec->flow_count.handle,
-					  attrs);
+					  attrs, &uobj);
 		if (!ib_spec->flow_count.counters)
 			return -EINVAL;
 		ib_spec->flow_count.size =
@@ -2890,6 +2930,8 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_ex_create_wq_resp resp = {};
 	struct ib_uwq_object           *obj;
 	int err = 0;
+	struct ib_uobject *cquobj;
+	struct ib_uobject *pduobj;
 	struct ib_cq *cq;
 	struct ib_pd *pd;
 	struct ib_wq *wq;
@@ -2908,13 +2950,15 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
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
@@ -3006,6 +3050,7 @@ static int ib_uverbs_ex_destroy_wq(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_ex_modify_wq cmd;
+	struct ib_uobject *wquobj;
 	struct ib_wq *wq;
 	struct ib_wq_attr wq_attr = {};
 	int ret;
@@ -3020,7 +3065,8 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 	if (cmd.attr_mask > (IB_WQ_STATE | IB_WQ_CUR_STATE | IB_WQ_FLAGS))
 		return -EINVAL;
 
-	wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ, cmd.wq_handle, attrs);
+	wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ, cmd.wq_handle, attrs,
+			       &wquobj);
 	if (!wq)
 		return -EINVAL;
 
@@ -3085,8 +3131,11 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 
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
@@ -3147,6 +3196,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 err_free:
 	kfree(wqs_handles);
 	kfree(wqs);
+
 	return err;
 }
 
@@ -3174,6 +3224,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	struct ib_flow			  *flow_id;
 	struct ib_uverbs_flow_attr	  *kern_flow_attr;
 	struct ib_flow_attr		  *flow_attr;
+	struct ib_uobject		  *qpuobj;
 	struct ib_qp			  *qp;
 	struct ib_uflow_resources	  *uflow_res;
 	struct ib_uverbs_flow_spec_hdr	  *kern_spec;
@@ -3237,7 +3288,8 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 		goto err_free_attr;
 	}
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       &qpuobj);
 	if (!qp) {
 		err = -EINVAL;
 		goto err_uobj;
@@ -3352,6 +3404,8 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 {
 	struct ib_uverbs_create_srq_resp resp;
 	struct ib_usrq_object           *obj;
+	struct ib_uobject		*cquobj = ERR_PTR(-ENOENT);
+	struct ib_uobject		*pduobj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
 	struct ib_uobject               *uninitialized_var(xrcd_uobj);
@@ -3387,14 +3441,15 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 
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
@@ -3523,6 +3578,7 @@ static int ib_uverbs_create_xsrq(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_modify_srq cmd;
+	struct ib_uobject	   *srquobj;
 	struct ib_srq              *srq;
 	struct ib_srq_attr          attr;
 	int                         ret;
@@ -3531,7 +3587,8 @@ static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
+	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs,
+				&srquobj);
 	if (!srq)
 		return -EINVAL;
 
@@ -3551,6 +3608,7 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_query_srq      cmd;
 	struct ib_uverbs_query_srq_resp resp;
 	struct ib_srq_attr              attr;
+	struct ib_uobject		*srquobj;
 	struct ib_srq                   *srq;
 	int                             ret;
 
@@ -3558,7 +3616,8 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
+	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs,
+				&srquobj);
 	if (!srq)
 		return -EINVAL;
 
@@ -3670,6 +3729,7 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_ex_modify_cq cmd;
+	struct ib_uobject *cquobj;
 	struct ib_cq *cq;
 	int ret;
 
@@ -3683,7 +3743,8 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
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

