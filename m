Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52943224FC7
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 07:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgGSFWg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Jul 2020 01:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgGSFWf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 19 Jul 2020 01:22:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C090F2073E;
        Sun, 19 Jul 2020 05:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595136154;
        bh=MNNZcXDWgMuQgiq+7A7JxBVahvfDQDu94b3JlyVmAKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7ZD8Qrw1MffBlrpsLxstaw8noPCG6D6eD9XeykoJO1pIdiwkeofH4o4Jq2iQpTjy
         Eycn+AF1ARBzXv14iSnn9A8Hh9+nmCX7qfoK52VDippkgsPbRHY2J7tcAb1vdQk5fD
         aBWhmaQGiGrI8MUlA0rQtv6ifPQOMymQf2+W/1uU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 2/2] RDMA/core: Update write interface to use automatic object lifetime
Date:   Sun, 19 Jul 2020 08:22:23 +0300
Message-Id: <20200719052223.75245-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719052223.75245-1-leon@kernel.org>
References: <20200719052223.75245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The automatic object lifetime model allows us to change write() interface
to have same logic as ioctl() path. Update the create/alloc functions to be
in the following format, so code flow will be the same:
 * Allocate objects
 * Initialize them
 * Call to the drivers, this is last step that is allowed to fail
 * Finalize object
 * Return response and allow to core code to handle abort/commit
   respectively.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 312 ++++++++-------------------
 1 file changed, 93 insertions(+), 219 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 68c9a0210220..a66fc3e37a74 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -273,7 +273,7 @@ int ib_init_ucontext(struct uverbs_attr_bundle *attrs)
 
 static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 {
-	struct ib_uverbs_get_context_resp resp;
+	struct ib_uverbs_get_context_resp resp = {};
 	struct ib_uverbs_get_context cmd;
 	struct ib_device *ib_dev;
 	struct ib_uobject *uobj;
@@ -293,25 +293,20 @@ static int ib_uverbs_get_context(struct uverbs_attr_bundle *attrs)
 		goto err_ucontext;
 	}
 
-	resp = (struct ib_uverbs_get_context_resp){
-		.num_comp_vectors = attrs->ufile->device->num_comp_vectors,
-		.async_fd = uobj->id,
-	};
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_uobj;
-
 	ret = ib_init_ucontext(attrs);
 	if (ret)
 		goto err_uobj;
 
 	ib_uverbs_init_async_event_file(
 		container_of(uobj, struct ib_uverbs_async_event_file, uobj));
-	rdma_alloc_commit_uobject(uobj, attrs);
-	return 0;
+	uobj_finalize_uobj_create(uobj, attrs);
+
+	resp.num_comp_vectors = attrs->ufile->device->num_comp_vectors;
+	resp.async_fd = uobj->id;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_uobj:
-	rdma_alloc_abort_uobject(uobj, attrs, false);
+	uobj_alloc_abort(uobj, attrs);
 err_ucontext:
 	kfree(attrs->context);
 	attrs->context = NULL;
@@ -415,8 +410,8 @@ static int ib_uverbs_query_port(struct uverbs_attr_bundle *attrs)
 
 static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 {
+	struct ib_uverbs_alloc_pd_resp resp = {};
 	struct ib_uverbs_alloc_pd      cmd;
-	struct ib_uverbs_alloc_pd_resp resp;
 	struct ib_uobject             *uobj;
 	struct ib_pd                  *pd;
 	int                            ret;
@@ -438,29 +433,20 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
 
 	pd->device  = ib_dev;
 	pd->uobject = uobj;
-	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->res.type = RDMA_RESTRACK_PD;
 
 	ret = ib_dev->ops.alloc_pd(pd, &attrs->driver_udata);
 	if (ret)
 		goto err_alloc;
-
-	uobj->object = pd;
-	memset(&resp, 0, sizeof resp);
-	resp.pd_handle = uobj->id;
 	rdma_restrack_uadd(&pd->res);
 
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_copy;
+	uobj->object = pd;
+	uobj_finalize_uobj_create(uobj, attrs);
 
-	rdma_alloc_commit_uobject(uobj, attrs);
-	return 0;
+	resp.pd_handle = uobj->id;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
-err_copy:
-	ib_dealloc_pd_user(pd, uverbs_get_cleared_udata(attrs));
-	pd = NULL;
 err_alloc:
 	kfree(pd);
 err:
@@ -568,8 +554,8 @@ static void xrcd_table_delete(struct ib_uverbs_device *dev,
 static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_device *ibudev = attrs->ufile->device;
+	struct ib_uverbs_open_xrcd_resp	resp = {};
 	struct ib_uverbs_open_xrcd	cmd;
-	struct ib_uverbs_open_xrcd_resp	resp;
 	struct ib_uxrcd_object         *obj;
 	struct ib_xrcd                 *xrcd = NULL;
 	struct fd			f = {NULL, 0};
@@ -624,8 +610,6 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 
 	atomic_set(&obj->refcnt, 0);
 	obj->uobject.object = xrcd;
-	memset(&resp, 0, sizeof resp);
-	resp.xrcd_handle = obj->uobject.id;
 
 	if (inode) {
 		if (new_xrcd) {
@@ -637,24 +621,14 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 		atomic_inc(&xrcd->usecnt);
 	}
 
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_copy;
-
 	if (f.file)
 		fdput(f);
 
 	mutex_unlock(&ibudev->xrcd_tree_mutex);
+	uobj_finalize_uobj_create(&obj->uobject, attrs);
 
-	rdma_alloc_commit_uobject(&obj->uobject, attrs);
-	return 0;
-
-err_copy:
-	if (inode) {
-		if (new_xrcd)
-			xrcd_table_delete(ibudev, inode);
-		atomic_dec(&xrcd->usecnt);
-	}
+	resp.xrcd_handle = obj->uobject.id;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_dealloc_xrcd:
 	ib_dealloc_xrcd_user(xrcd, uverbs_get_cleared_udata(attrs));
@@ -710,8 +684,8 @@ int ib_uverbs_dealloc_xrcd(struct ib_uobject *uobject, struct ib_xrcd *xrcd,
 
 static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 {
+	struct ib_uverbs_reg_mr_resp resp = {};
 	struct ib_uverbs_reg_mr      cmd;
-	struct ib_uverbs_reg_mr_resp resp;
 	struct ib_uobject           *uobj;
 	struct ib_pd                *pd;
 	struct ib_mr                *mr;
@@ -768,27 +742,16 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	rdma_restrack_uadd(&mr->res);
 
 	uobj->object = mr;
-
-	memset(&resp, 0, sizeof resp);
-	resp.lkey      = mr->lkey;
-	resp.rkey      = mr->rkey;
-	resp.mr_handle = uobj->id;
-
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_copy;
-
 	uobj_put_obj_read(pd);
+	uobj_finalize_uobj_create(uobj, attrs);
 
-	rdma_alloc_commit_uobject(uobj, attrs);
-	return 0;
-
-err_copy:
-	ib_dereg_mr_user(mr, uverbs_get_cleared_udata(attrs));
+	resp.lkey = mr->lkey;
+	resp.rkey = mr->rkey;
+	resp.mr_handle = uobj->id;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_put:
 	uobj_put_obj_read(pd);
-
 err_free:
 	uobj_alloc_abort(uobj, attrs);
 	return ret;
@@ -928,21 +891,13 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 	atomic_inc(&pd->usecnt);
 
 	uobj->object = mw;
+	uobj_put_obj_read(pd);
+	uobj_finalize_uobj_create(uobj, attrs);
 
-	memset(&resp, 0, sizeof(resp));
-	resp.rkey      = mw->rkey;
+	resp.rkey = mw->rkey;
 	resp.mw_handle = uobj->id;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_copy;
-
-	uobj_put_obj_read(pd);
-	rdma_alloc_commit_uobject(uobj, attrs);
-	return 0;
-
-err_copy:
-	uverbs_dealloc_mw(mw);
 err_put:
 	uobj_put_obj_read(pd);
 err_free:
@@ -979,40 +934,33 @@ static int ib_uverbs_create_comp_channel(struct uverbs_attr_bundle *attrs)
 	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
 
-	resp.fd = uobj->id;
-
 	ev_file = container_of(uobj, struct ib_uverbs_completion_event_file,
 			       uobj);
 	ib_uverbs_init_event_queue(&ev_file->ev_queue);
+	uobj_finalize_uobj_create(uobj, attrs);
 
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret) {
-		uobj_alloc_abort(uobj, attrs);
-		return ret;
-	}
-
-	rdma_alloc_commit_uobject(uobj, attrs);
-	return 0;
+	resp.fd = uobj->id;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 }
 
-static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
-				       struct ib_uverbs_ex_create_cq *cmd)
+static int create_cq(struct uverbs_attr_bundle *attrs,
+		     struct ib_uverbs_ex_create_cq *cmd)
 {
 	struct ib_ucq_object           *obj;
 	struct ib_uverbs_completion_event_file    *ev_file = NULL;
 	struct ib_cq                   *cq;
 	int                             ret;
-	struct ib_uverbs_ex_create_cq_resp resp;
+	struct ib_uverbs_ex_create_cq_resp resp = {};
 	struct ib_cq_init_attr attr = {};
 	struct ib_device *ib_dev;
 
 	if (cmd->comp_vector >= attrs->ufile->device->num_comp_vectors)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	obj = (struct ib_ucq_object *)uobj_alloc(UVERBS_OBJECT_CQ, attrs,
 						 &ib_dev);
 	if (IS_ERR(obj))
-		return obj;
+		return PTR_ERR(obj);
 
 	if (cmd->comp_channel >= 0) {
 		ev_file = ib_uverbs_lookup_comp_file(cmd->comp_channel, attrs);
@@ -1041,53 +989,38 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
 	atomic_set(&cq->usecnt, 0);
+	cq->res.type = RDMA_RESTRACK_CQ;
 
 	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
 	if (ret)
 		goto err_free;
+	rdma_restrack_uadd(&cq->res);
 
 	obj->uevent.uobject.object = cq;
 	obj->uevent.event_file = READ_ONCE(attrs->ufile->default_async_file);
 	if (obj->uevent.event_file)
 		uverbs_uobject_get(&obj->uevent.event_file->uobj);
+	uobj_finalize_uobj_create(&obj->uevent.uobject, attrs);
 
-	memset(&resp, 0, sizeof resp);
 	resp.base.cq_handle = obj->uevent.uobject.id;
-	resp.base.cqe       = cq->cqe;
+	resp.base.cqe = cq->cqe;
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
-	cq->res.type = RDMA_RESTRACK_CQ;
-	rdma_restrack_uadd(&cq->res);
-
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_cb;
-
-	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
-	return obj;
-
-err_cb:
-	if (obj->uevent.event_file)
-		uverbs_uobject_put(&obj->uevent.event_file->uobj);
-	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
-	cq = NULL;
 err_free:
 	kfree(cq);
 err_file:
 	if (ev_file)
 		ib_uverbs_release_ucq(ev_file, obj);
-
 err:
 	uobj_alloc_abort(&obj->uevent.uobject, attrs);
-
-	return ERR_PTR(ret);
+	return ret;
 }
 
 static int ib_uverbs_create_cq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_create_cq      cmd;
 	struct ib_uverbs_ex_create_cq	cmd_ex;
-	struct ib_ucq_object           *obj;
 	int ret;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
@@ -1100,14 +1033,12 @@ static int ib_uverbs_create_cq(struct uverbs_attr_bundle *attrs)
 	cmd_ex.comp_vector = cmd.comp_vector;
 	cmd_ex.comp_channel = cmd.comp_channel;
 
-	obj = create_cq(attrs, &cmd_ex);
-	return PTR_ERR_OR_ZERO(obj);
+	return create_cq(attrs, &cmd_ex);
 }
 
 static int ib_uverbs_ex_create_cq(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_ex_create_cq  cmd;
-	struct ib_ucq_object           *obj;
 	int ret;
 
 	ret = uverbs_request(attrs, &cmd, sizeof(cmd));
@@ -1120,8 +1051,7 @@ static int ib_uverbs_ex_create_cq(struct uverbs_attr_bundle *attrs)
 	if (cmd.reserved)
 		return -EINVAL;
 
-	obj = create_cq(attrs, &cmd);
-	return PTR_ERR_OR_ZERO(obj);
+	return create_cq(attrs, &cmd);
 }
 
 static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
@@ -1296,7 +1226,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	struct ib_srq			*srq = NULL;
 	struct ib_qp			*qp;
 	struct ib_qp_init_attr		attr = {};
-	struct ib_uverbs_ex_create_qp_resp resp;
+	struct ib_uverbs_ex_create_qp_resp resp = {};
 	int				ret;
 	struct ib_rwq_ind_table *ind_tbl = NULL;
 	bool has_sq = true;
@@ -1466,20 +1396,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	if (obj->uevent.event_file)
 		uverbs_uobject_get(&obj->uevent.event_file->uobj);
 
-	memset(&resp, 0, sizeof resp);
-	resp.base.qpn             = qp->qp_num;
-	resp.base.qp_handle       = obj->uevent.uobject.id;
-	resp.base.max_recv_sge    = attr.cap.max_recv_sge;
-	resp.base.max_send_sge    = attr.cap.max_send_sge;
-	resp.base.max_recv_wr     = attr.cap.max_recv_wr;
-	resp.base.max_send_wr     = attr.cap.max_send_wr;
-	resp.base.max_inline_data = attr.cap.max_inline_data;
-	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
-
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_uevent;
-
 	if (xrcd) {
 		obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object,
 					  uobject);
@@ -1500,12 +1416,18 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 					UVERBS_LOOKUP_READ);
 	if (ind_tbl)
 		uobj_put_obj_read(ind_tbl);
+	uobj_finalize_uobj_create(&obj->uevent.uobject, attrs);
+
+	resp.base.qpn             = qp->qp_num;
+	resp.base.qp_handle       = obj->uevent.uobject.id;
+	resp.base.max_recv_sge    = attr.cap.max_recv_sge;
+	resp.base.max_send_sge    = attr.cap.max_send_sge;
+	resp.base.max_recv_wr     = attr.cap.max_recv_wr;
+	resp.base.max_send_wr     = attr.cap.max_send_wr;
+	resp.base.max_inline_data = attr.cap.max_inline_data;
+	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
-	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
-	return 0;
-err_uevent:
-	if (obj->uevent.event_file)
-		uverbs_uobject_put(&obj->uevent.event_file->uobj);
 err_cb:
 	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));
 
@@ -1578,8 +1500,8 @@ static int ib_uverbs_ex_create_qp(struct uverbs_attr_bundle *attrs)
 
 static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 {
+	struct ib_uverbs_create_qp_resp resp = {};
 	struct ib_uverbs_open_qp        cmd;
-	struct ib_uverbs_create_qp_resp resp;
 	struct ib_uqp_object           *obj;
 	struct ib_xrcd		       *xrcd;
 	struct ib_uobject	       *uninitialized_var(xrcd_uobj);
@@ -1625,24 +1547,16 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 	obj->uevent.uobject.object = qp;
 	obj->uevent.uobject.user_handle = cmd.user_handle;
 
-	memset(&resp, 0, sizeof resp);
-	resp.qpn       = qp->qp_num;
-	resp.qp_handle = obj->uevent.uobject.id;
-
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_destroy;
-
 	obj->uxrcd = container_of(xrcd_uobj, struct ib_uxrcd_object, uobject);
 	atomic_inc(&obj->uxrcd->refcnt);
 	qp->uobject = obj;
 	uobj_put_read(xrcd_uobj);
+	uobj_finalize_uobj_create(&obj->uevent.uobject, attrs);
 
-	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
-	return 0;
+	resp.qpn = qp->qp_num;
+	resp.qp_handle = obj->uevent.uobject.id;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
-err_destroy:
-	ib_destroy_qp_user(qp, uverbs_get_cleared_udata(attrs));
 err_xrcd:
 	uobj_put_read(xrcd_uobj);
 err_put:
@@ -2478,24 +2392,14 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	ah->uobject  = uobj;
 	uobj->user_handle = cmd.user_handle;
 	uobj->object = ah;
-
-	resp.ah_handle = uobj->id;
-
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_copy;
-
 	uobj_put_obj_read(pd);
-	rdma_alloc_commit_uobject(uobj, attrs);
-	return 0;
+	uobj_finalize_uobj_create(uobj, attrs);
 
-err_copy:
-	rdma_destroy_ah_user(ah, RDMA_DESTROY_AH_SLEEPABLE,
-			     uverbs_get_cleared_udata(attrs));
+	resp.ah_handle = uobj->id;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
 err_put:
 	uobj_put_obj_read(pd);
-
 err:
 	uobj_alloc_abort(uobj, attrs);
 	return ret;
@@ -2987,26 +2891,18 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 	if (obj->uevent.event_file)
 		uverbs_uobject_get(&obj->uevent.event_file->uobj);
 
-	memset(&resp, 0, sizeof(resp));
+	uobj_put_obj_read(pd);
+	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
+				UVERBS_LOOKUP_READ);
+	uobj_finalize_uobj_create(&obj->uevent.uobject, attrs);
+
 	resp.wq_handle = obj->uevent.uobject.id;
 	resp.max_sge = wq_init_attr.max_sge;
 	resp.max_wr = wq_init_attr.max_wr;
 	resp.wqn = wq->wq_num;
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
-	err = uverbs_response(attrs, &resp, sizeof(resp));
-	if (err)
-		goto err_copy;
-
-	uobj_put_obj_read(pd);
-	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
-				UVERBS_LOOKUP_READ);
-	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
-	return 0;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
-err_copy:
-	if (obj->uevent.event_file)
-		uverbs_uobject_put(&obj->uevent.event_file->uobj);
-	ib_destroy_wq(wq, uverbs_get_cleared_udata(attrs));
 err_put_cq:
 	rdma_lookup_put_uobject(&cq->uobject->uevent.uobject,
 				UVERBS_LOOKUP_READ);
@@ -3091,7 +2987,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	struct ib_wq	**wqs = NULL;
 	u32 *wqs_handles = NULL;
 	struct ib_wq	*wq = NULL;
-	int i, j, num_read_wqs;
+	int i, num_read_wqs;
 	u32 num_wq_handles;
 	struct uverbs_req_iter iter;
 	struct ib_device *ib_dev;
@@ -3137,6 +3033,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 		}
 
 		wqs[num_read_wqs] = wq;
+		atomic_inc(&wqs[num_read_wqs]->usecnt);
 	}
 
 	uobj = uobj_alloc(UVERBS_OBJECT_RWQ_IND_TBL, attrs, &ib_dev);
@@ -3164,33 +3061,24 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	atomic_set(&rwq_ind_tbl->usecnt, 0);
 
 	for (i = 0; i < num_wq_handles; i++)
-		atomic_inc(&wqs[i]->usecnt);
+		rdma_lookup_put_uobject(&wqs[i]->uobject->uevent.uobject,
+					UVERBS_LOOKUP_READ);
+	kfree(wqs_handles);
+	uobj_finalize_uobj_create(uobj, attrs);
 
 	resp.ind_tbl_handle = uobj->id;
 	resp.ind_tbl_num = rwq_ind_tbl->ind_tbl_num;
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
-	err = uverbs_response(attrs, &resp, sizeof(resp));
-	if (err)
-		goto err_copy;
-
-	kfree(wqs_handles);
-
-	for (j = 0; j < num_read_wqs; j++)
-		rdma_lookup_put_uobject(&wqs[j]->uobject->uevent.uobject,
-					UVERBS_LOOKUP_READ);
-
-	rdma_alloc_commit_uobject(uobj, attrs);
-	return 0;
-
-err_copy:
-	ib_destroy_rwq_ind_table(rwq_ind_tbl);
 err_uobj:
 	uobj_alloc_abort(uobj, attrs);
 put_wqs:
-	for (j = 0; j < num_read_wqs; j++)
-		rdma_lookup_put_uobject(&wqs[j]->uobject->uevent.uobject,
+	for (i = 0; i < num_read_wqs; i++) {
+		rdma_lookup_put_uobject(&wqs[i]->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
+		atomic_dec(&wqs[i]->usecnt);
+	}
 err_free:
 	kfree(wqs_handles);
 	kfree(wqs);
@@ -3216,7 +3104,7 @@ static int ib_uverbs_ex_destroy_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_create_flow	  cmd;
-	struct ib_uverbs_create_flow_resp resp;
+	struct ib_uverbs_create_flow_resp resp = {};
 	struct ib_uobject		  *uobj;
 	struct ib_flow			  *flow_id;
 	struct ib_uverbs_flow_attr	  *kern_flow_attr;
@@ -3349,23 +3237,17 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 
 	ib_set_flow(uobj, flow_id, qp, qp->device, uflow_res);
 
-	memset(&resp, 0, sizeof(resp));
-	resp.flow_handle = uobj->id;
-
-	err = uverbs_response(attrs, &resp, sizeof(resp));
-	if (err)
-		goto err_copy;
-
 	rdma_lookup_put_uobject(&qp->uobject->uevent.uobject,
 				UVERBS_LOOKUP_READ);
 	kfree(flow_attr);
+
 	if (cmd.flow_attr.num_of_specs)
 		kfree(kern_flow_attr);
-	rdma_alloc_commit_uobject(uobj, attrs);
-	return 0;
-err_copy:
-	if (!qp->device->ops.destroy_flow(flow_id))
-		atomic_dec(&qp->usecnt);
+	uobj_finalize_uobj_create(uobj, attrs);
+
+	resp.flow_handle = uobj->id;
+	return uverbs_response(attrs, &resp, sizeof(resp));
+
 err_free:
 	ib_uverbs_flow_resources_free(uflow_res);
 err_free_flow_attr:
@@ -3400,7 +3282,7 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 				struct ib_uverbs_create_xsrq *cmd,
 				struct ib_udata *udata)
 {
-	struct ib_uverbs_create_srq_resp resp;
+	struct ib_uverbs_create_srq_resp resp = {};
 	struct ib_usrq_object           *obj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
@@ -3471,17 +3353,9 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	if (obj->uevent.event_file)
 		uverbs_uobject_get(&obj->uevent.event_file->uobj);
 
-	memset(&resp, 0, sizeof resp);
-	resp.srq_handle = obj->uevent.uobject.id;
-	resp.max_wr     = attr.attr.max_wr;
-	resp.max_sge    = attr.attr.max_sge;
 	if (cmd->srq_type == IB_SRQT_XRC)
 		resp.srqn = srq->ext.xrc.srq_num;
 
-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_copy;
-
 	if (cmd->srq_type == IB_SRQT_XRC)
 		uobj_put_read(xrcd_uobj);
 
@@ -3490,13 +3364,13 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 					UVERBS_LOOKUP_READ);
 
 	uobj_put_obj_read(pd);
-	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
-	return 0;
+	uobj_finalize_uobj_create(&obj->uevent.uobject, attrs);
+
+	resp.srq_handle = obj->uevent.uobject.id;
+	resp.max_wr = attr.attr.max_wr;
+	resp.max_sge = attr.attr.max_sge;
+	return uverbs_response(attrs, &resp, sizeof(resp));
 
-err_copy:
-	if (obj->uevent.event_file)
-		uverbs_uobject_put(&obj->uevent.event_file->uobj);
-	ib_destroy_srq_user(srq, uverbs_get_cleared_udata(attrs));
 err_put_pd:
 	uobj_put_obj_read(pd);
 err_put_cq:
-- 
2.26.2

