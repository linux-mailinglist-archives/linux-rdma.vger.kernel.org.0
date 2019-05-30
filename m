Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23B82FB89
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 14:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfE3M0B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 08:26:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59392 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbfE3M0B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 08:26:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UCImtU050554;
        Thu, 30 May 2019 12:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=noYL2MPKC0mn+hPiQaW/9kAkIdyqNMPT8IUAeNv5vfM=;
 b=ubEgSFTrFUi3lcV5ENJ3/rnYNOV/0mOpe7fDblKImblL507uC5ibGxv04LydnqAutgkz
 ArroyHlnVOjPsY4srwbI02ie48kl2pXf2BIH1kVbZdcBW0yOo05CsK4Nvhdp1n+jAvzU
 80q1RxgIFIN6ZaTgyZFKVCaZoojp+jzQ1wmZzseJevSpV20pPk9WZAVsLBz91AZZ8pWN
 lMbsiWjQc9q2e7GBf2u+hF2uSd52pzn9Rx3dr9EbGcAMQLe0cbWGM2lffFjK+uyMj7Uf
 ABhdDRKw/nuHlzm+AJ+mLKBFcqQTjKorbGNt8e4viOYhCaDegUyLi9pO+TuHC9ei0IxE jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tqq3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 12:25:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4UCPOca079724;
        Thu, 30 May 2019 12:25:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2ss1fp1fx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 12:25:37 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4UCPb94019415;
        Thu, 30 May 2019 12:25:37 GMT
Received: from srabinov-laptop.nl.oracle.com (/10.175.32.156)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 May 2019 05:25:36 -0700
From:   Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     dledford@redhat.com, jgg@mellanox.com,
        shamir.rabinovitch@oracle.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH for-next v3 2/4] RDMA/uverbs: uobj_put_obj_read macro should be removed
Date:   Thu, 30 May 2019 15:24:07 +0300
Message-Id: <20190530122422.32283-3-shamir.rabinovitch@oracle.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
References: <20190530122422.32283-1-shamir.rabinovitch@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300093
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300093
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
 drivers/infiniband/core/uverbs_cmd.c | 92 ++++++++++++++--------------
 include/rdma/uverbs_std_types.h      |  3 -
 2 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index f1320de2b388..a850424ae184 100644
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
@@ -1487,15 +1487,15 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
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
@@ -1505,15 +1505,15 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
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
@@ -1692,7 +1692,7 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 
 	ret = ib_query_qp(qp, attr, cmd.attr_mask, init_attr);
 
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 
 	if (ret)
 		goto out;
@@ -1930,7 +1930,7 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 				      &attrs->driver_udata);
 
 release_qp:
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 out:
 	kfree(attr);
 
@@ -2198,11 +2198,11 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
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
@@ -2342,7 +2342,7 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 	resp.bad_wr = 0;
 	ret = qp->device->ops.post_recv(qp->real_qp, wr, &bad_wr);
 
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 	if (ret) {
 		for (next = wr; next; next = next->next) {
 			++resp.bad_wr;
@@ -2394,7 +2394,7 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 	resp.bad_wr = 0;
 	ret = srq->device->ops.post_srq_recv(srq, wr, &bad_wr);
 
-	uobj_put_obj_read(srq);
+	uobj_put_read(srquobj);
 
 	if (ret)
 		for (next = wr; next; next = next->next) {
@@ -2483,14 +2483,14 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
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
@@ -2554,7 +2554,7 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 
 out_put:
 	mutex_unlock(&obj->mcast_lock);
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 
 	return ret;
 }
@@ -2599,7 +2599,7 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 
 out_put:
 	mutex_unlock(&obj->mcast_lock);
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 	return ret;
 }
 
@@ -2718,7 +2718,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 		flow_resources_add(uflow_res,
 				   IB_FLOW_SPEC_ACTION_HANDLE,
 				   ib_spec->action.act);
-		uobj_put_obj_read(ib_spec->action.act);
+		uobj_put_read(uobj);
 		break;
 	case IB_FLOW_SPEC_ACTION_COUNT:
 		if (kern_spec->flow_count.size !=
@@ -2736,7 +2736,7 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 		flow_resources_add(uflow_res,
 				   IB_FLOW_SPEC_ACTION_COUNT,
 				   ib_spec->flow_count.counters);
-		uobj_put_obj_read(ib_spec->flow_count.counters);
+		uobj_put_read(uobj);
 		break;
 	default:
 		return -EINVAL;
@@ -3003,16 +3003,16 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
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
 
@@ -3078,7 +3078,7 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 	}
 	ret = wq->device->ops.modify_wq(wq, &wq_attr, cmd.attr_mask,
 					&attrs->driver_udata);
-	uobj_put_obj_read(wq);
+	uobj_put_read(wquobj);
 	return ret;
 }
 
@@ -3182,7 +3182,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	kfree(wqs_handles);
 
 	for (j = 0; j < num_read_wqs; j++)
-		uobj_put_obj_read(wqs[j]);
+		uobj_put_read(wqs[j]->uobject);
 
 	return uobj_alloc_commit(uobj, attrs);
 
@@ -3192,7 +3192,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	uobj_alloc_abort(uobj, attrs);
 put_wqs:
 	for (j = 0; j < num_read_wqs; j++)
-		uobj_put_obj_read(wqs[j]);
+		uobj_put_read(wqs[j]->uobject);
 err_free:
 	kfree(wqs_handles);
 	kfree(wqs);
@@ -3361,7 +3361,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	if (err)
 		goto err_copy;
 
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 	kfree(flow_attr);
 	if (cmd.flow_attr.num_of_specs)
 		kfree(kern_flow_attr);
@@ -3374,7 +3374,7 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 err_free_flow_attr:
 	kfree(flow_attr);
 err_put:
-	uobj_put_obj_read(qp);
+	uobj_put_read(qpuobj);
 err_uobj:
 	uobj_alloc_abort(uobj, attrs);
 err_free_attr:
@@ -3513,9 +3513,9 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 		uobj_put_read(xrcd_uobj);
 
 	if (ib_srq_has_cq(cmd->srq_type))
-		uobj_put_obj_read(attr.ext.cq);
+		uobj_put_read(cquobj);
 
-	uobj_put_obj_read(pd);
+	uobj_put_read(pduobj);
 	return uobj_alloc_commit(&obj->uevent.uobject, attrs);
 
 err_copy:
@@ -3524,11 +3524,11 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
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
@@ -3598,7 +3598,7 @@ static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 	ret = srq->device->ops.modify_srq(srq, &attr, cmd.attr_mask,
 					  &attrs->driver_udata);
 
-	uobj_put_obj_read(srq);
+	uobj_put_read(srquobj);
 
 	return ret;
 }
@@ -3623,7 +3623,7 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 
 	ret = ib_query_srq(srq, &attr);
 
-	uobj_put_obj_read(srq);
+	uobj_put_read(srquobj);
 
 	if (ret)
 		return ret;
@@ -3750,7 +3750,7 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 
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

