Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA8B218582
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2020 13:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgGHLGF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Jul 2020 07:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgGHLGE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Jul 2020 07:06:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7203206F6;
        Wed,  8 Jul 2020 11:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594206362;
        bh=sL8Q1tCceObGYEFLJH2z5zHsfZXCDFGgUkM/fizrLqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RvhgJfTnawTvZM5yt7zfPCqIinW6Y/Wz0wqztdvczZ68v7yDqR+rBkx4yFGEfWVit
         V6tgj02apEEQZPqLTriXGoPgg9eGJTDTlOdie9nq/0TnfBwhNEJiNRoL7RNZL7aenm
         nHcQODGmYTTvIpSqP+ykSxxbuGtBglZAkLHnT7w4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/2] RDMA/core: Update write interface to use automatic object lifetime
Date:   Wed,  8 Jul 2020 14:05:54 +0300
Message-Id: <20200708110554.1270613-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708110554.1270613-1-leon@kernel.org>
References: <20200708110554.1270613-1-leon@kernel.org>
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
 drivers/infiniband/core/uverbs_cmd.c | 299 ++++++++-------------------
 1 file changed, 90 insertions(+), 209 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index c160306c48f0..ca188f0ea18a 100644
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
@@ -438,29 +433,19 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)

 	pd->device  = ib_dev;
 	pd->uobject = uobj;
-	pd->__internal_mr = NULL;
 	atomic_set(&pd->usecnt, 0);
 	pd->res.type = RDMA_RESTRACK_PD;
+	uobj->object = pd;

 	ret = ib_dev->ops.alloc_pd(pd, &attrs->driver_udata);
 	if (ret)
 		goto err_alloc;
-
-	uobj->object = pd;
-	memset(&resp, 0, sizeof resp);
-	resp.pd_handle = uobj->id;
 	rdma_restrack_uadd(&pd->res);
+	uobj_finalize_uobj_create(uobj, attrs);

-	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_copy;
-
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
@@ -568,8 +553,8 @@ static void xrcd_table_delete(struct ib_uverbs_device *dev,
 static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_device *ibudev = attrs->ufile->device;
+	struct ib_uverbs_open_xrcd_resp	resp = {};
 	struct ib_uverbs_open_xrcd	cmd;
-	struct ib_uverbs_open_xrcd_resp	resp;
 	struct ib_uxrcd_object         *obj;
 	struct ib_xrcd                 *xrcd = NULL;
 	struct fd			f = {NULL, 0};
@@ -624,8 +609,6 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)

 	atomic_set(&obj->refcnt, 0);
 	obj->uobject.object = xrcd;
-	memset(&resp, 0, sizeof resp);
-	resp.xrcd_handle = obj->uobject.id;

 	if (inode) {
 		if (new_xrcd) {
@@ -637,24 +620,14 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
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
@@ -710,8 +683,8 @@ int ib_uverbs_dealloc_xrcd(struct ib_uobject *uobject, struct ib_xrcd *xrcd,

 static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 {
+	struct ib_uverbs_reg_mr_resp resp = {};
 	struct ib_uverbs_reg_mr      cmd;
-	struct ib_uverbs_reg_mr_resp resp;
 	struct ib_uobject           *uobj;
 	struct ib_pd                *pd;
 	struct ib_mr                *mr;
@@ -766,29 +739,17 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 	mr->res.type = RDMA_RESTRACK_MR;
 	mr->iova = cmd.hca_va;
 	rdma_restrack_uadd(&mr->res);
-
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
@@ -927,27 +888,21 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 	mw->uobject = uobj;
 	uobj->object = mw;
 	mw->type = cmd.mw_type;
+	atomic_inc(&pd->usecnt);

 	ret = pd->device->ops.alloc_mw(mw, &attrs->driver_udata);
 	if (ret)
 		goto err_alloc;

-	atomic_inc(&pd->usecnt);
+	uobj_put_obj_read(pd);
+	uobj_finalize_uobj_create(uobj, attrs);
+
 	resp.rkey = mw->rkey;
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
-	mw = NULL;
 err_alloc:
+	atomic_dec(&pd->usecnt);
 	kfree(mw);
 err_put:
 	uobj_put_obj_read(pd);
@@ -985,20 +940,13 @@ static int ib_uverbs_create_comp_channel(struct uverbs_attr_bundle *attrs)
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

 static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
@@ -1008,7 +956,7 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	struct ib_uverbs_completion_event_file    *ev_file = NULL;
 	struct ib_cq                   *cq;
 	int                             ret;
-	struct ib_uverbs_ex_create_cq_resp resp;
+	struct ib_uverbs_ex_create_cq_resp resp = {};
 	struct ib_cq_init_attr attr = {};
 	struct ib_device *ib_dev;

@@ -1047,36 +995,25 @@ static struct ib_ucq_object *create_cq(struct uverbs_attr_bundle *attrs,
 	cq->event_handler = ib_uverbs_cq_event_handler;
 	cq->cq_context    = ev_file ? &ev_file->ev_queue : NULL;
 	atomic_set(&cq->usecnt, 0);
+	cq->res.type = RDMA_RESTRACK_CQ;
+	obj->uevent.uobject.object = cq;
+	obj->uevent.event_file = READ_ONCE(attrs->ufile->default_async_file);

 	ret = ib_dev->ops.create_cq(cq, &attr, &attrs->driver_udata);
 	if (ret)
 		goto err_free;
+	rdma_restrack_uadd(&cq->res);

-	obj->uevent.uobject.object = cq;
-	obj->uevent.event_file = READ_ONCE(attrs->ufile->default_async_file);
 	if (obj->uevent.event_file)
 		uverbs_uobject_get(&obj->uevent.event_file->uobj);
+	uobj_finalize_uobj_create(&obj->uevent.uobject, attrs);

-	memset(&resp, 0, sizeof resp);
 	resp.base.cq_handle = obj->uevent.uobject.id;
-	resp.base.cqe       = cq->cqe;
+	resp.base.cqe = cq->cqe;
 	resp.response_length = uverbs_response_length(attrs, sizeof(resp));
-
-	cq->res.type = RDMA_RESTRACK_CQ;
-	rdma_restrack_uadd(&cq->res);
-
 	ret = uverbs_response(attrs, &resp, sizeof(resp));
-	if (ret)
-		goto err_cb;
-
-	rdma_alloc_commit_uobject(&obj->uevent.uobject, attrs);
-	return obj;
+	return ret ? ERR_PTR(ret) : obj;

-err_cb:
-	if (obj->uevent.event_file)
-		uverbs_uobject_put(&obj->uevent.event_file->uobj);
-	ib_destroy_cq_user(cq, uverbs_get_cleared_udata(attrs));
-	cq = NULL;
 err_free:
 	kfree(cq);
 err_file:
@@ -1302,7 +1239,7 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 	struct ib_srq			*srq = NULL;
 	struct ib_qp			*qp;
 	struct ib_qp_init_attr		attr = {};
-	struct ib_uverbs_ex_create_qp_resp resp;
+	struct ib_uverbs_ex_create_qp_resp resp = {};
 	int				ret;
 	struct ib_rwq_ind_table *ind_tbl = NULL;
 	bool has_sq = true;
@@ -1472,20 +1409,6 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
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
@@ -1506,12 +1429,18 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
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

@@ -1584,8 +1513,8 @@ static int ib_uverbs_ex_create_qp(struct uverbs_attr_bundle *attrs)

 static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
 {
+	struct ib_uverbs_create_qp_resp resp = {};
 	struct ib_uverbs_open_qp        cmd;
-	struct ib_uverbs_create_qp_resp resp;
 	struct ib_uqp_object           *obj;
 	struct ib_xrcd		       *xrcd;
 	struct ib_uobject	       *uninitialized_var(xrcd_uobj);
@@ -1631,24 +1560,16 @@ static int ib_uverbs_open_qp(struct uverbs_attr_bundle *attrs)
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
@@ -2484,24 +2405,14 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
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
@@ -2993,26 +2904,18 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
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
@@ -3097,7 +3000,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 	struct ib_wq	**wqs = NULL;
 	u32 *wqs_handles = NULL;
 	struct ib_wq	*wq = NULL;
-	int i, j, num_read_wqs;
+	int i, num_read_wqs;
 	u32 num_wq_handles;
 	struct uverbs_req_iter iter;
 	struct ib_device *ib_dev;
@@ -3143,6 +3046,7 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 		}

 		wqs[num_read_wqs] = wq;
+		atomic_inc(&wqs[num_read_wqs]->usecnt);
 	}

 	uobj = uobj_alloc(UVERBS_OBJECT_RWQ_IND_TBL, attrs, &ib_dev);
@@ -3170,33 +3074,24 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
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
@@ -3222,7 +3117,7 @@ static int ib_uverbs_ex_destroy_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_create_flow	  cmd;
-	struct ib_uverbs_create_flow_resp resp;
+	struct ib_uverbs_create_flow_resp resp = {};
 	struct ib_uobject		  *uobj;
 	struct ib_flow			  *flow_id;
 	struct ib_uverbs_flow_attr	  *kern_flow_attr;
@@ -3355,23 +3250,17 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)

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
@@ -3406,7 +3295,7 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 				struct ib_uverbs_create_xsrq *cmd,
 				struct ib_udata *udata)
 {
-	struct ib_uverbs_create_srq_resp resp;
+	struct ib_uverbs_create_srq_resp resp = {};
 	struct ib_usrq_object           *obj;
 	struct ib_pd                    *pd;
 	struct ib_srq                   *srq;
@@ -3477,17 +3366,9 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
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

@@ -3496,13 +3377,13 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
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

