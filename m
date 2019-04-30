Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEBBFB61
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 16:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfD3OZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 10:25:37 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47352 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfD3OZg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 10:25:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UEOTJh053582;
        Tue, 30 Apr 2019 14:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=Dcmpc7o9pASZzXT9o7VTUjtVbiOPJ4dsMUeTXdN31p0=;
 b=BU5xnwLbAJ1qBX9ggvAOMZRYjNkJTLovWzToWORfk+9QBYGSBehFhrDR7KkGOT5uUU8k
 3qRYH3cikuAI6S3ibiDr83hnOjnn++hNm2zRCUbnSGBuxJvGQn+XhBBdB+oPG9c1p+AK
 ST9o36CI+8lZATtd/V+xTubZzjqK8QkQRVuh6mejunL5tZDduHg8GAm4+UyZjniBAe97
 96qAkyNjESpLdUJZtnFIwuPynkwfefWh+4CV5+9+vNgGDntHlerUuMDI6LW3zFmVFJeU
 ZC+gkUG5zgSa7138l+LPt885eA1zzTLWXkhr6xHUy5wS2b1COFgUOxIzIgjuzBy+yEu+ /w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2s5j5u1jnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:25:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UEOq2Z142620;
        Tue, 30 Apr 2019 14:25:19 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2s4ew194vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:25:19 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3UEPFdu002611;
        Tue, 30 Apr 2019 14:25:15 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.1.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 07:25:14 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH for-next v1 2/4] RDMA/uverbs: uobj_get_obj_read should return the ib_uobject
Date:   Tue, 30 Apr 2019 17:23:22 +0300
Message-Id: <20190430142333.31063-3-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
References: <20190430142333.31063-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904300090
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9242 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904300091
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
 drivers/infiniband/core/uverbs_cmd.c | 165 +++++++++++++++++++++------
 include/rdma/uverbs_std_types.h      |   8 +-
 2 files changed, 137 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 76ac113d1da5..93363c41e77e 100644
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
+			       pduobj);
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
+				       attrs, pduobj);
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
+			       pduobj);
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
+			       cquobj);
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
+			       cquobj);
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
+			       cquobj);
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
+					    ind_tbl_uobj);
 		if (!ind_tbl) {
 			ret = -EINVAL;
 			goto err_put;
@@ -1324,7 +1342,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		} else {
 			if (cmd->is_srq) {
 				srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ,
-							cmd->srq_handle, attrs);
+							cmd->srq_handle, attrs,
+							srq_uobj);
 				if (!srq || srq->srq_type == IB_SRQT_XRC) {
 					ret = -EINVAL;
 					goto err_put;
@@ -1335,7 +1354,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 				if (cmd->recv_cq_handle != cmd->send_cq_handle) {
 					rcq = uobj_get_obj_read(
 						cq, UVERBS_OBJECT_CQ,
-						cmd->recv_cq_handle, attrs);
+						cmd->recv_cq_handle, attrs,
+						rcq_uobj);
 					if (!rcq) {
 						ret = -EINVAL;
 						goto err_put;
@@ -1346,11 +1366,12 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 
 		if (has_sq)
 			scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
-						cmd->send_cq_handle, attrs);
+						cmd->send_cq_handle, attrs,
+						scq_uobj);
 		if (!ind_tbl)
 			rcq = rcq ?: scq;
 		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle,
-				       attrs);
+				       attrs, pd_uobj);
 		if (!pd || (!scq && has_sq)) {
 			ret = -EINVAL;
 			goto err_put;
@@ -1646,6 +1667,7 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_query_qp      cmd;
 	struct ib_uverbs_query_qp_resp resp;
+	struct ib_uobject	       *qpuobj;
 	struct ib_qp                   *qp;
 	struct ib_qp_attr              *attr;
 	struct ib_qp_init_attr         *init_attr;
@@ -1662,7 +1684,8 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 		goto out;
 	}
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -1759,6 +1782,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		     struct ib_uverbs_ex_modify_qp *cmd)
 {
 	struct ib_qp_attr *attr;
+	struct ib_uobject *qpuobj;
 	struct ib_qp *qp;
 	int ret;
 
@@ -1767,7 +1791,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 		return -ENOMEM;
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd->base.qp_handle,
-			       attrs);
+			       attrs, qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -2001,6 +2025,7 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_send_wr       *user_wr;
 	struct ib_send_wr              *wr = NULL, *last, *next;
 	const struct ib_send_wr	       *bad_wr;
+	struct ib_uobject	       *qpuobj;
 	struct ib_qp                   *qp;
 	int                             i, sg_ind;
 	int				is_ud;
@@ -2009,6 +2034,12 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	const struct ib_sge __user *sgls;
 	const void __user *wqes;
 	struct uverbs_req_iter iter;
+	struct uobj_list_item {
+		struct list_head list;
+		struct ib_uobject *uobj;
+	};
+	struct uobj_list_item *item, *tmp;
+	LIST_HEAD(ud_uobj_list);
 
 	ret = uverbs_request_start(attrs, &iter, &cmd, sizeof(cmd));
 	if (ret)
@@ -2028,7 +2059,8 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 	if (!user_wr)
 		return -ENOMEM;
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -2050,10 +2082,18 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 		}
 
 		if (is_ud) {
+			struct uobj_list_item *ud_uobj;
 			struct ib_ud_wr *ud;
 
+			ud_uobj = kmalloc(sizeof(*ud_uobj), GFP_KERNEL);
+			if (!ud_uobj) {
+				ret = -ENOMEM;
+				goto out_put;
+			}
+
 			if (user_wr->opcode != IB_WR_SEND &&
 			    user_wr->opcode != IB_WR_SEND_WITH_IMM) {
+				kfree(ud_uobj);
 				ret = -EINVAL;
 				goto out_put;
 			}
@@ -2061,14 +2101,17 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 			next_size = sizeof(*ud);
 			ud = alloc_wr(next_size, user_wr->num_sge);
 			if (!ud) {
+				kfree(ud_uobj);
 				ret = -ENOMEM;
 				goto out_put;
 			}
 
-			ud->ah = uobj_get_obj_read(ah, UVERBS_OBJECT_AH,
-						   user_wr->wr.ud.ah, attrs);
+			ud->ah = uobj_get_obj_read(ah,
+				UVERBS_OBJECT_AH, user_wr->wr.ud.ah, attrs,
+				ud_uobj->uobj);
 			if (!ud->ah) {
 				kfree(ud);
+				kfree(ud_uobj);
 				ret = -EINVAL;
 				goto out_put;
 			}
@@ -2076,6 +2119,8 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 			ud->remote_qkey = user_wr->wr.ud.remote_qkey;
 
 			next = &ud->wr;
+			list_add(&ud_uobj->list, &ud_uobj_list);
+
 		} else if (user_wr->opcode == IB_WR_RDMA_WRITE_WITH_IMM ||
 			   user_wr->opcode == IB_WR_RDMA_WRITE ||
 			   user_wr->opcode == IB_WR_RDMA_READ) {
@@ -2184,6 +2229,9 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 out:
 	kfree(user_wr);
 
+	list_for_each_entry_safe(item, tmp, &ud_uobj_list, list)
+		kfree(item);
+
 	return ret;
 }
 
@@ -2291,6 +2339,7 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_post_recv_resp resp;
 	struct ib_recv_wr              *wr, *next;
 	const struct ib_recv_wr	       *bad_wr;
+	struct ib_uobject	       *qpuobj;
 	struct ib_qp                   *qp;
 	int ret, ret2;
 	struct uverbs_req_iter iter;
@@ -2304,7 +2353,8 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(wr))
 		return PTR_ERR(wr);
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       qpuobj);
 	if (!qp) {
 		ret = -EINVAL;
 		goto out;
@@ -2341,6 +2391,7 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_post_srq_recv_resp resp;
 	struct ib_recv_wr                  *wr, *next;
 	const struct ib_recv_wr		   *bad_wr;
+	struct ib_uobject		   *srquobj;
 	struct ib_srq                      *srq;
 	int ret, ret2;
 	struct uverbs_req_iter iter;
@@ -2354,7 +2405,8 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(wr))
 		return PTR_ERR(wr);
 
-	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
+	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs,
+				srquobj);
 	if (!srq) {
 		ret = -EINVAL;
 		goto out;
@@ -2391,6 +2443,7 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_create_ah	 cmd;
 	struct ib_uverbs_create_ah_resp	 resp;
 	struct ib_uobject		*uobj;
+	struct ib_uobject		*pduobj;
 	struct ib_pd			*pd;
 	struct ib_ah			*ah;
 	struct rdma_ah_attr		attr = {};
@@ -2410,7 +2463,8 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 		goto err;
 	}
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
+			       pduobj);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err;
@@ -2479,6 +2533,7 @@ static int ib_uverbs_destroy_ah(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_attach_mcast cmd;
+	struct ib_uobject	     *qpuobj;
 	struct ib_qp                 *qp;
 	struct ib_uqp_object         *obj;
 	struct ib_uverbs_mcast_entry *mcast;
@@ -2488,7 +2543,8 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       qpuobj);
 	if (!qp)
 		return -EINVAL;
 
@@ -2528,6 +2584,7 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_detach_mcast cmd;
 	struct ib_uqp_object         *obj;
+	struct ib_uobject	     *qpuobj;
 	struct ib_qp                 *qp;
 	struct ib_uverbs_mcast_entry *mcast;
 	int                           ret = -EINVAL;
@@ -2537,7 +2594,8 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       qpuobj);
 	if (!qp)
 		return -EINVAL;
 
@@ -2647,6 +2705,8 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 				       union ib_flow_spec *ib_spec,
 				       struct ib_uflow_resources *uflow_res)
 {
+	struct ib_uobject *uobj;
+
 	ib_spec->type = kern_spec->type;
 	switch (ib_spec->type) {
 	case IB_FLOW_SPEC_ACTION_TAG:
@@ -2671,7 +2731,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 		ib_spec->action.act = uobj_get_obj_read(flow_action,
 							UVERBS_OBJECT_FLOW_ACTION,
 							kern_spec->action.handle,
-							attrs);
+							attrs, uobj);
 		if (!ib_spec->action.act)
 			return -EINVAL;
 		ib_spec->action.size =
@@ -2689,7 +2749,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 			uobj_get_obj_read(counters,
 					  UVERBS_OBJECT_COUNTERS,
 					  kern_spec->flow_count.handle,
-					  attrs);
+					  attrs, uobj);
 		if (!ib_spec->flow_count.counters)
 			return -EINVAL;
 		ib_spec->flow_count.size =
@@ -2891,6 +2951,8 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_ex_create_wq_resp resp = {};
 	struct ib_uwq_object           *obj;
 	int err = 0;
+	struct ib_uobject *cquobj;
+	struct ib_uobject *pduobj;
 	struct ib_cq *cq;
 	struct ib_pd *pd;
 	struct ib_wq *wq;
@@ -2909,13 +2971,15 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs,
+			       pduobj);
 	if (!pd) {
 		err = -EINVAL;
 		goto err_uobj;
 	}
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       cquobj);
 	if (!cq) {
 		err = -EINVAL;
 		goto err_put_pd;
@@ -3007,6 +3071,7 @@ static int ib_uverbs_ex_destroy_wq(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_ex_modify_wq cmd;
+	struct ib_uobject *wquobj;
 	struct ib_wq *wq;
 	struct ib_wq_attr wq_attr = {};
 	int ret;
@@ -3021,7 +3086,8 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 	if (cmd.attr_mask > (IB_WQ_STATE | IB_WQ_CUR_STATE | IB_WQ_FLAGS))
 		return -EINVAL;
 
-	wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ, cmd.wq_handle, attrs);
+	wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ, cmd.wq_handle, attrs,
+			       wquobj);
 	if (!wq)
 		return -EINVAL;
 
@@ -3052,6 +3118,12 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	u32 num_wq_handles;
 	struct uverbs_req_iter iter;
 	struct ib_device *ib_dev;
+	struct uobj_list_item {
+		struct list_head list;
+		struct ib_uobject *uobj;
+	};
+	struct uobj_list_item *item, *tmp;
+	LIST_HEAD(uobj_list);
 
 	err = uverbs_request_start(attrs, &iter, &cmd, sizeof(cmd));
 	if (err)
@@ -3086,14 +3158,23 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 
 	for (num_read_wqs = 0; num_read_wqs < num_wq_handles;
 			num_read_wqs++) {
+		struct uobj_list_item *wq_uobj =
+			kmalloc(sizeof(*wq_uobj), GFP_KERNEL);
+		if (!wq_uobj) {
+			err = -ENOMEM;
+			goto put_wqs;
+		}
+
 		wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ,
-				       wqs_handles[num_read_wqs], attrs);
+				       wqs_handles[num_read_wqs], attrs,
+				       wq_uobj->uobj);
 		if (!wq) {
 			err = -EINVAL;
 			goto put_wqs;
 		}
 
 		wqs[num_read_wqs] = wq;
+		list_add(&wq_uobj->list, &uobj_list);
 	}
 
 	uobj = uobj_alloc(UVERBS_OBJECT_RWQ_IND_TBL, attrs, &ib_dev);
@@ -3136,6 +3217,9 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	for (j = 0; j < num_read_wqs; j++)
 		uobj_put_obj_read(wqs[j]);
 
+	list_for_each_entry_safe(item, tmp, &uobj_list, list)
+		kfree(item);
+
 	return uobj_alloc_commit(uobj, attrs);
 
 err_copy:
@@ -3148,6 +3232,10 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 err_free:
 	kfree(wqs_handles);
 	kfree(wqs);
+
+	list_for_each_entry_safe(item, tmp, &uobj_list, list)
+		kfree(item);
+
 	return err;
 }
 
@@ -3175,6 +3263,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	struct ib_flow			  *flow_id;
 	struct ib_uverbs_flow_attr	  *kern_flow_attr;
 	struct ib_flow_attr		  *flow_attr;
+	struct ib_uobject		  *qpuobj;
 	struct ib_qp			  *qp;
 	struct ib_uflow_resources	  *uflow_res;
 	struct ib_uverbs_flow_spec_hdr	  *kern_spec;
@@ -3238,7 +3327,8 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 		goto err_free_attr;
 	}
 
-	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
+	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs,
+			       qpuobj);
 	if (!qp) {
 		err = -EINVAL;
 		goto err_uobj;
@@ -3353,6 +3443,8 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 {
 	struct ib_uverbs_create_srq_resp resp;
 	struct ib_usrq_object           *obj;
+	struct ib_uobject		*cquobj = ERR_PTR(-ENOENT);
+	struct ib_uobject		*pduobj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
 	struct ib_uobject               *uninitialized_var(xrcd_uobj);
@@ -3388,14 +3480,15 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 
 	if (ib_srq_has_cq(cmd->srq_type)) {
 		attr.ext.cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
-						cmd->cq_handle, attrs);
+						cmd->cq_handle, attrs, cquobj);
 		if (!attr.ext.cq) {
 			ret = -EINVAL;
 			goto err_put_xrcd;
 		}
 	}
 
-	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle, attrs);
+	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle, attrs,
+			       pduobj);
 	if (!pd) {
 		ret = -EINVAL;
 		goto err_put_cq;
@@ -3524,6 +3617,7 @@ static int ib_uverbs_create_xsrq(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_modify_srq cmd;
+	struct ib_uobject	   *srquobj;
 	struct ib_srq              *srq;
 	struct ib_srq_attr          attr;
 	int                         ret;
@@ -3532,7 +3626,8 @@ static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
+	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs,
+				srquobj);
 	if (!srq)
 		return -EINVAL;
 
@@ -3552,6 +3647,7 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 	struct ib_uverbs_query_srq      cmd;
 	struct ib_uverbs_query_srq_resp resp;
 	struct ib_srq_attr              attr;
+	struct ib_uobject		*srquobj;
 	struct ib_srq                   *srq;
 	int                             ret;
 
@@ -3559,7 +3655,8 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		return ret;
 
-	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
+	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs,
+				srquobj);
 	if (!srq)
 		return -EINVAL;
 
@@ -3671,6 +3768,7 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_ex_modify_cq cmd;
+	struct ib_uobject *cquobj;
 	struct ib_cq *cq;
 	int ret;
 
@@ -3684,7 +3782,8 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 	if (cmd.attr_mask > IB_CQ_MODERATE)
 		return -EOPNOTSUPP;
 
-	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
+	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs,
+			       cquobj);
 	if (!cq)
 		return -EINVAL;
 
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index 05eabfd5d0d3..2ec360f9bce3 100644
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
+	_uobj = uobj_get_read(_type, _id, _attrs);                             \
+	((struct ib_##_object *)_uobj_get_obj_read(_uobj));                    \
+})
 
 #define uobj_get_write(_type, _id, _attrs)                                     \
 	rdma_lookup_get_uobject(uobj_get_type(_attrs, _type), (_attrs)->ufile, \
-- 
2.20.1

