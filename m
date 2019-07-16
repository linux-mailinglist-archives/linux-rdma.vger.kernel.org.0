Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE006AE4A
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jul 2019 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbfGPSO4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Jul 2019 14:14:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44298 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388184AbfGPSO4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Jul 2019 14:14:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GIEPwW112515;
        Tue, 16 Jul 2019 18:14:40 GMT
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2tq6qtp8u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:14:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GICXqH114599;
        Tue, 16 Jul 2019 18:12:40 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tq6mn1mj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 18:12:40 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6GICcZa023922;
        Tue, 16 Jul 2019 18:12:38 GMT
Received: from host5.lan (/77.138.183.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 18:12:38 +0000
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
Subject: [PATCH 02/25] RDMA/uverbs: Delete the macro uobj_put_obj_read
Date:   Tue, 16 Jul 2019 21:11:37 +0300
Message-Id: <20190716181200.4239-3-srabinov7@gmail.com>
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
 definitions=main-1907160223
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>

The macro uobj_put_obj_read assumes an existence of a member with the name
uobject on each HW object. Since this member is about to be delete we
shouldn't use this macro, instead use uobj_put_read and delete
uobj_put_obj_read.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 92 ++++++++++++++--------------
 include/rdma/uverbs_std_types.h      |  3 -
 2 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index b0dc301918bf..204a93305f1c 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -778,7 +778,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err_copy;
 
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 
 	return uobj_alloc_commit(uobj, attrs);
 
@@ -786,7 +786,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	ib_dereg_mr_user(mr, uverbs_get_cleared_udata(attrs));
 
 err_put:
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 
 err_free:
 	uobj_alloc_abort(uobj, attrs);
@@ -864,7 +864,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 
 put_uobj_pd:
 	if (cmd.flags & IB_MR_REREG_PD)
-		uobj_put_obj_read(pd);
+		uobj_put_read(pduobj);
 
 put_uobjs:
 	uobj_put_write(uobj);
@@ -936,13 +936,13 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err_copy;
 
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 	return uobj_alloc_commit(uobj, attrs);
 
 err_copy:
 	uverbs_dealloc_mw(mw);
 err_put:
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 err_free:
 	uobj_alloc_abort(uobj, attrs);
 	return ret;
@@ -1144,7 +1144,7 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 out:
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 
 	return ret;
 }
@@ -1229,7 +1229,7 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 		ret = uverbs_output_written(attrs, UVERBS_ATTR_CORE_OUT);
 
 out_put:
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 	return ret;
 }
 
@@ -1252,7 +1252,7 @@ static int ib_uverbs_req_notify_cq(struct uverbs_attr_bundle *attrs)
 	ib_req_notify_cq(cq, cmd.solicited_only ?
 			 IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
 
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 
 	return 0;
 }
@@ -1505,15 +1505,15 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	}
 
 	if (pd)
-		uobj_put_obj_read(pd);
+		uobj_put_read(pd_uobj);
 	if (scq)
-		uobj_put_obj_read(scq);
+		uobj_put_read(scq_uobj);
 	if (rcq && rcq != scq)
-		uobj_put_obj_read(rcq);
+		uobj_put_read(rcq_uobj);
 	if (srq)
-		uobj_put_obj_read(srq);
+		uobj_put_read(srq_uobj);
 	if (ind_tbl)
-		uobj_put_obj_read(ind_tbl);
+		uobj_put_read(ind_tbl_uobj);
 
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
 err_cb:
@@ -1523,15 +1523,15 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	if (!IS_ERR(xrcd_uobj))
 		uobj_put_read(xrcd_uobj);
 	if (pd)
-		uobj_put_obj_read(pd);
+		uobj_put_read(pd_uobj);
 	if (scq)
-		uobj_put_obj_read(scq);
+		uobj_put_read(scq_uobj);
 	if (rcq && rcq != scq)
-		uobj_put_obj_read(rcq);
+		uobj_put_read(rcq_uobj);
 	if (srq)
-		uobj_put_obj_read(srq);
+		uobj_put_read(srq_uobj);
 	if (ind_tbl)
-		uobj_put_obj_read(ind_tbl);
+		uobj_put_read(ind_tbl_uobj);
 
 	uobj_alloc_abort(&obj->uevent.uobject, attrs);
 	return ret;
@@ -1710,7 +1710,7 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 
 	ret = ib_query_qp(qp, attr, cmd.attr_mask, init_attr);
 
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 
 	if (ret)
 		goto out;
@@ -1948,7 +1948,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 				      &attrs->driver_udata);
 
 release_qp:
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 out:
 	kfree(attr);
 
@@ -2216,11 +2216,11 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 		ret = ret2;
 
 out_put:
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 
 	while (wr) {
 		if (is_ud && ud_wr(wr)->ah)
-			uobj_put_obj_read(ud_wr(wr)->ah);
+			uobj_put_read(ud_wr(wr)->ah->uobject);
 		next = wr->next;
 		kfree(wr);
 		wr = next;
@@ -2360,7 +2360,7 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	resp.bad_wr = 0;
 	ret = qp->device->ops.post_recv(qp->real_qp, wr, &bad_wr);
 
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 	if (ret) {
 		for (next = wr; next; next = next->next) {
 			++resp.bad_wr;
@@ -2412,7 +2412,7 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	resp.bad_wr = 0;
 	ret = srq->device->ops.post_srq_recv(srq, wr, &bad_wr);
 
-	uobj_put_obj_read(srq);
+	uobj_put_read(srquobj);
 
 	if (ret)
 		for (next = wr; next; next = next->next) {
@@ -2501,7 +2501,7 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err_copy;
 
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 	return uobj_alloc_commit(uobj, attrs);
 
 err_copy:
@@ -2509,7 +2509,7 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 			     uverbs_get_cleared_udata(attrs));
 
 err_put:
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 
 err:
 	uobj_alloc_abort(uobj, attrs);
@@ -2573,7 +2573,7 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 
 out_put:
 	mutex_unlock(&obj->mcast_lock);
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 
 	return ret;
 }
@@ -2618,7 +2618,7 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 
 out_put:
 	mutex_unlock(&obj->mcast_lock);
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 	return ret;
 }
 
@@ -2737,7 +2737,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 		flow_resources_add(uflow_res,
 				   IB_FLOW_SPEC_ACTION_HANDLE,
 				   ib_spec->action.act);
-		uobj_put_obj_read(ib_spec->action.act);
+		uobj_put_read(uobj);
 		break;
 	case IB_FLOW_SPEC_ACTION_COUNT:
 		if (kern_spec->flow_count.size !=
@@ -2755,7 +2755,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 		flow_resources_add(uflow_res,
 				   IB_FLOW_SPEC_ACTION_COUNT,
 				   ib_spec->flow_count.counters);
-		uobj_put_obj_read(ib_spec->flow_count.counters);
+		uobj_put_read(uobj);
 		break;
 	default:
 		return -EINVAL;
@@ -3022,16 +3022,16 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	if (err)
 		goto err_copy;
 
-	uobj_put_obj_read(pd);
-	uobj_put_obj_read(cq);
+	uobj_put_read(pduobj);
+	uobj_put_read(cquobj);
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
 
 err_copy:
 	ib_destroy_wq(wq, uverbs_get_cleared_udata(attrs));
 err_put_cq:
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 err_put_pd:
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 err_uobj:
 	uobj_alloc_abort(&obj->uevent.uobject, attrs);
 
@@ -3097,7 +3097,7 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 	}
 	ret = wq->device->ops.modify_wq(wq, &wq_attr, cmd.attr_mask,
 					&attrs->driver_udata);
-	uobj_put_obj_read(wq);
+	uobj_put_read(wquobj);
 	return ret;
 }
 
@@ -3201,7 +3201,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	kfree(wqs_handles);
 
 	for (j = 0; j < num_read_wqs; j++)
-		uobj_put_obj_read(wqs[j]);
+		uobj_put_read(wqs[j]->uobject);
 
 	return uobj_alloc_commit(uobj, attrs);
 
@@ -3211,7 +3211,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	uobj_alloc_abort(uobj, attrs);
 put_wqs:
 	for (j = 0; j < num_read_wqs; j++)
-		uobj_put_obj_read(wqs[j]);
+		uobj_put_read(wqs[j]->uobject);
 err_free:
 	kfree(wqs_handles);
 	kfree(wqs);
@@ -3380,7 +3380,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	if (err)
 		goto err_copy;
 
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 	kfree(flow_attr);
 	if (cmd.flow_attr.num_of_specs)
 		kfree(kern_flow_attr);
@@ -3393,7 +3393,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 err_free_flow_attr:
 	kfree(flow_attr);
 err_put:
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 err_uobj:
 	uobj_alloc_abort(uobj, attrs);
 err_free_attr:
@@ -3532,9 +3532,9 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 		uobj_put_read(xrcd_uobj);
 
 	if (ib_srq_has_cq(cmd->srq_type))
-		uobj_put_obj_read(attr.ext.cq);
+		uobj_put_read(cquobj);
 
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
 
 err_copy:
@@ -3543,11 +3543,11 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 err_free:
 	kfree(srq);
 err_put:
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 
 err_put_cq:
 	if (ib_srq_has_cq(cmd->srq_type))
-		uobj_put_obj_read(attr.ext.cq);
+		uobj_put_read(cquobj);
 
 err_put_xrcd:
 	if (cmd->srq_type == IB_SRQT_XRC) {
@@ -3617,7 +3617,7 @@ static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 	ret = srq->device->ops.modify_srq(srq, &attr, cmd.attr_mask,
 					  &attrs->driver_udata);
 
-	uobj_put_obj_read(srq);
+	uobj_put_read(srquobj);
 
 	return ret;
 }
@@ -3642,7 +3642,7 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 
 	ret = ib_query_srq(srq, &attr);
 
-	uobj_put_obj_read(srq);
+	uobj_put_read(srquobj);
 
 	if (ret)
 		return ret;
@@ -3769,7 +3769,7 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 
 	ret = rdma_set_cq_moderation(cq, cmd.attr.cq_count, cmd.attr.cq_period);
 
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 
 	return ret;
 }
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index 578e5c28bc1c..02641a3241e3 100644
--- a/include/rdma/uverbs_std_types.h
+++ b/include/rdma/uverbs_std_types.h
@@ -98,9 +98,6 @@ static inline void uobj_put_read(struct ib_uobject *uobj)
 	rdma_lookup_put_uobject(uobj, UVERBS_LOOKUP_READ);
 }
 
-#define uobj_put_obj_read(_obj)					\
-	uobj_put_read((_obj)->uobject)
-
 static inline void uobj_put_write(struct ib_uobject *uobj)
 {
 	rdma_lookup_put_uobject(uobj, UVERBS_LOOKUP_WRITE);
-- 
2.20.1

