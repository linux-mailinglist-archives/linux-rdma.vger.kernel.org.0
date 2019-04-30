Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86E32FB66
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2019 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfD3OZx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 30 Apr 2019 10:25:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57092 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfD3OZx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 30 Apr 2019 10:25:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UEOYD1075162;
        Tue, 30 Apr 2019 14:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=hRR2fMO/MF9xQU9/RvZ7cb/vZPYZBCNUI8yriQGaVEk=;
 b=mOlBpKNUmyiXZG5aSjI8B+TY6uylB58rff0LPtADiB2SDePRD/JtPNz43g1j8gkj8dEa
 LEIa9rnZZR0ITR8Mn/vxPH3pMEtZKKAwJkaQsiVktXpMMr3zpMJ7vYq1xolfOW9zJbj/
 Axdr4BN1d9QTWURej+bD+k1CbOqp0FIGuHTHmWxCSH++z4E0fUxi9wfaxcrNkVAC0iM3
 X/idAq/RZ9rqUs/IuBEJni7OVGlMLD67aP8SncFSMdi7zODsvb1e9PimHaIUvFCM5i4D
 qEyx9uRIuGIL5ESFT5/LGuJ9AiB2MPSi8/R1zFq4/XbsSdqRffqD6tmOn5vSjTiT2XSZ Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2s4fqq4svb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:25:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3UEOf7U106974;
        Tue, 30 Apr 2019 14:25:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2s4d4ahyq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 14:25:31 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3UEPURa000684;
        Tue, 30 Apr 2019 14:25:30 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.1.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Apr 2019 07:25:30 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH for-next v1 3/4] RDMA/uverbs: uobj_put_obj_read macro should be removed
Date:   Tue, 30 Apr 2019 17:23:23 +0300
Message-Id: <20190430142333.31063-4-shamir.rabinovitch@oracle.com>
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

uobj_put_obj_read macro assume that ib_x has pointer to the
ib_uobject. this is wrong assumption as future patches will
remove the ib_uobject pointers from the ib_x objects. now
that we fixed the uobj_get_obj_read macro and we have the
ib_uobject we no longer need to use the ib_x to find the
ib_uobject and we can remove the uobj_put_obj_read macro.

Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 114 +++++++++++++--------------
 include/rdma/uverbs_std_types.h      |   3 -
 2 files changed, 56 insertions(+), 61 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 93363c41e77e..fe646e02ce38 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -765,7 +765,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err_copy;
 
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 
 	return uobj_alloc_commit(uobj, attrs);
 
@@ -773,7 +773,7 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	ib_dereg_mr_user(mr, &attrs->driver_udata);
 
 err_put:
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 
 err_free:
 	uobj_alloc_abort(uobj, attrs);
@@ -851,7 +851,7 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 
 put_uobj_pd:
 	if (cmd.flags & IB_MR_REREG_PD)
-		uobj_put_obj_read(pd);
+		uobj_put_read(pduobj);
 
 put_uobjs:
 	uobj_put_write(uobj);
@@ -923,13 +923,13 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
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
@@ -1126,7 +1126,7 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
 out:
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 
 	return ret;
 }
@@ -1211,7 +1211,7 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 		ret = uverbs_output_written(attrs, UVERBS_ATTR_CORE_OUT);
 
 out_put:
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 	return ret;
 }
 
@@ -1234,7 +1234,7 @@ static int ib_uverbs_req_notify_cq(struct uverbs_attr_bundle *attrs)
 	ib_req_notify_cq(cq, cmd.solicited_only ?
 			 IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
 
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 
 	return 0;
 }
@@ -1488,15 +1488,15 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
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
@@ -1506,15 +1506,15 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
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
@@ -1693,7 +1693,7 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 
 	ret = ib_query_qp(qp, attr, cmd.attr_mask, init_attr);
 
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 
 	if (ret)
 		goto out;
@@ -1931,7 +1931,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 				      &attrs->driver_udata);
 
 release_qp:
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 out:
 	kfree(attr);
 
@@ -2216,11 +2216,9 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 		ret = ret2;
 
 out_put:
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 
 	while (wr) {
-		if (is_ud && ud_wr(wr)->ah)
-			uobj_put_obj_read(ud_wr(wr)->ah);
 		next = wr->next;
 		kfree(wr);
 		wr = next;
@@ -2229,8 +2227,10 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 out:
 	kfree(user_wr);
 
-	list_for_each_entry_safe(item, tmp, &ud_uobj_list, list)
+	list_for_each_entry_safe(item, tmp, &ud_uobj_list, list) {
+		uobj_put_read(item->uobj);
 		kfree(item);
+	}
 
 	return ret;
 }
@@ -2363,7 +2363,7 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	resp.bad_wr = 0;
 	ret = qp->device->ops.post_recv(qp->real_qp, wr, &bad_wr);
 
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 	if (ret) {
 		for (next = wr; next; next = next->next) {
 			++resp.bad_wr;
@@ -2415,7 +2415,7 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	resp.bad_wr = 0;
 	ret = srq->device->ops.post_srq_recv(srq, wr, &bad_wr);
 
-	uobj_put_obj_read(srq);
+	uobj_put_read(srquobj);
 
 	if (ret)
 		for (next = wr; next; next = next->next) {
@@ -2504,14 +2504,14 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	if (ret)
 		goto err_copy;
 
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 	return uobj_alloc_commit(uobj, attrs);
 
 err_copy:
 	rdma_destroy_ah(ah, RDMA_DESTROY_AH_SLEEPABLE);
 
 err_put:
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 
 err:
 	uobj_alloc_abort(uobj, attrs);
@@ -2575,7 +2575,7 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 
 out_put:
 	mutex_unlock(&obj->mcast_lock);
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 
 	return ret;
 }
@@ -2620,7 +2620,7 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 
 out_put:
 	mutex_unlock(&obj->mcast_lock);
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 	return ret;
 }
 
@@ -2739,7 +2739,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 		flow_resources_add(uflow_res,
 				   IB_FLOW_SPEC_ACTION_HANDLE,
 				   ib_spec->action.act);
-		uobj_put_obj_read(ib_spec->action.act);
+		uobj_put_read(uobj);
 		break;
 	case IB_FLOW_SPEC_ACTION_COUNT:
 		if (kern_spec->flow_count.size !=
@@ -2757,7 +2757,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 		flow_resources_add(uflow_res,
 				   IB_FLOW_SPEC_ACTION_COUNT,
 				   ib_spec->flow_count.counters);
-		uobj_put_obj_read(ib_spec->flow_count.counters);
+		uobj_put_read(uobj);
 		break;
 	default:
 		return -EINVAL;
@@ -3024,16 +3024,16 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	if (err)
 		goto err_copy;
 
-	uobj_put_obj_read(pd);
-	uobj_put_obj_read(cq);
+	uobj_put_read(pduobj);
+	uobj_put_read(cquobj);
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
 
 err_copy:
 	ib_destroy_wq(wq, &attrs->driver_udata);
 err_put_cq:
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 err_put_pd:
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 err_uobj:
 	uobj_alloc_abort(&obj->uevent.uobject, attrs);
 
@@ -3099,7 +3099,7 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 	}
 	ret = wq->device->ops.modify_wq(wq, &wq_attr, cmd.attr_mask,
 					&attrs->driver_udata);
-	uobj_put_obj_read(wq);
+	uobj_put_read(wquobj);
 	return ret;
 }
 
@@ -3114,7 +3114,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	struct ib_wq	**wqs = NULL;
 	u32 *wqs_handles = NULL;
 	struct ib_wq	*wq = NULL;
-	int i, j, num_read_wqs;
+	int i, num_read_wqs;
 	u32 num_wq_handles;
 	struct uverbs_req_iter iter;
 	struct ib_device *ib_dev;
@@ -3162,7 +3162,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 			kmalloc(sizeof(*wq_uobj), GFP_KERNEL);
 		if (!wq_uobj) {
 			err = -ENOMEM;
-			goto put_wqs;
+			goto err_free;
 		}
 
 		wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ,
@@ -3170,7 +3170,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 				       wq_uobj->uobj);
 		if (!wq) {
 			err = -EINVAL;
-			goto put_wqs;
+			goto err_free;
 		}
 
 		wqs[num_read_wqs] = wq;
@@ -3180,7 +3180,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	uobj = uobj_alloc(UVERBS_OBJECT_RWQ_IND_TBL, attrs, &ib_dev);
 	if (IS_ERR(uobj)) {
 		err = PTR_ERR(uobj);
-		goto put_wqs;
+		goto err_free;
 	}
 
 	init_attr.log_ind_tbl_size = cmd.log_ind_tbl_size;
@@ -3214,11 +3214,10 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 
 	kfree(wqs_handles);
 
-	for (j = 0; j < num_read_wqs; j++)
-		uobj_put_obj_read(wqs[j]);
-
-	list_for_each_entry_safe(item, tmp, &uobj_list, list)
+	list_for_each_entry_safe(item, tmp, &uobj_list, list) {
+		uobj_put_read(item->uobj);
 		kfree(item);
+	}
 
 	return uobj_alloc_commit(uobj, attrs);
 
@@ -3226,15 +3225,14 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	ib_destroy_rwq_ind_table(rwq_ind_tbl);
 err_uobj:
 	uobj_alloc_abort(uobj, attrs);
-put_wqs:
-	for (j = 0; j < num_read_wqs; j++)
-		uobj_put_obj_read(wqs[j]);
 err_free:
 	kfree(wqs_handles);
 	kfree(wqs);
 
-	list_for_each_entry_safe(item, tmp, &uobj_list, list)
+	list_for_each_entry_safe(item, tmp, &uobj_list, list) {
+		uobj_put_read(item->uobj);
 		kfree(item);
+	}
 
 	return err;
 }
@@ -3400,7 +3398,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	if (err)
 		goto err_copy;
 
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 	kfree(flow_attr);
 	if (cmd.flow_attr.num_of_specs)
 		kfree(kern_flow_attr);
@@ -3413,7 +3411,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 err_free_flow_attr:
 	kfree(flow_attr);
 err_put:
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 err_uobj:
 	uobj_alloc_abort(uobj, attrs);
 err_free_attr:
@@ -3552,9 +3550,9 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 		uobj_put_read(xrcd_uobj);
 
 	if (ib_srq_has_cq(cmd->srq_type))
-		uobj_put_obj_read(attr.ext.cq);
+		uobj_put_read(cquobj);
 
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
 
 err_copy:
@@ -3563,11 +3561,11 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
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
@@ -3637,7 +3635,7 @@ static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 	ret = srq->device->ops.modify_srq(srq, &attr, cmd.attr_mask,
 					  &attrs->driver_udata);
 
-	uobj_put_obj_read(srq);
+	uobj_put_read(srquobj);
 
 	return ret;
 }
@@ -3662,7 +3660,7 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 
 	ret = ib_query_srq(srq, &attr);
 
-	uobj_put_obj_read(srq);
+	uobj_put_read(srquobj);
 
 	if (ret)
 		return ret;
@@ -3789,7 +3787,7 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 
 	ret = rdma_set_cq_moderation(cq, cmd.attr.cq_count, cmd.attr.cq_period);
 
-	uobj_put_obj_read(cq);
+	uobj_put_read(cquobj);
 
 	return ret;
 }
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index 2ec360f9bce3..cb3ac2965ffb 100644
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

