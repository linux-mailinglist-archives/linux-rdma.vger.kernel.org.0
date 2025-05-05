Return-Path: <linux-rdma+bounces-10052-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35000AAB411
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 06:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1FB13A625B
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 04:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DB037E698;
	Tue,  6 May 2025 00:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwkSMYep"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B82ECFF0;
	Mon,  5 May 2025 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486505; cv=none; b=ghRUfnEX1YnXRaN+OpVoZWfCeXjby/AQ1weTSi7mePDd9WK5xtZ5oZtd0PNN0mNsUQIbyDLcyBluzqiwQ+EIV72qv9jxHH/MK40PuoBWzlu3p82q4KQAmSymHrCWMLVOjCH5bqyrEa8zdAyWjjcxiKMCblbaHcaY8qohWzUk+bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486505; c=relaxed/simple;
	bh=APIQx3Gn421GVZMWdLsYkyL5g0rF2rs3PD1ddAP8elo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBhm57dwP3A0oLj9RJ4ojuwDhBNe1GZmOrRshKwrz11WPUPLvLYWzGGHbzlZMj7O9+MD9iiw62XFn9c1uytkezE6UD/3kbctFKezyjY+go2JTDwKCsMbclSzGD+Juw9+dM/+1js60aZRdeJISxpCPQhhJIjcSLcKW6MqMUdclbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwkSMYep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EEDC4CEE4;
	Mon,  5 May 2025 23:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486505;
	bh=APIQx3Gn421GVZMWdLsYkyL5g0rF2rs3PD1ddAP8elo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WwkSMYepH7FFgmdxxZ85k/BZUwU0jpbNUzu2/Z7fCXb3w1bjbonfWqFXiC70rdQtT
	 +0w9ivikjjwgnvqib7j2YXrw1Ud+4ZOcPXtUEZ2gnS2goST3Ep9bFCLKQ/8ALNIy98
	 2ZDp89is+kqpD+DFdFDBOxeQX5SstOEdKaZXmznxXnIUVPEW9leXNqtjiXkX/4qSo9
	 WcHllPbKKGIA7uTV/3xwwbtkfHdVkR83+/9gxVe7LIYqYFSeD7475k72oilTinA+i7
	 FtVLMxU94VgAYDSwN/m5mPedxtpu8HuZ4yL3m7I9jieB9KPz7LZ703/X1PbKSGP6+Z
	 bVaPkanZUMTVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maher Sanalla <msanalla@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	cmeiohas@nvidia.com,
	dan.carpenter@linaro.org,
	agoldberger@nvidia.com,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 064/212] RDMA/uverbs: Propagate errors from rdma_lookup_get_uobject()
Date: Mon,  5 May 2025 19:03:56 -0400
Message-Id: <20250505230624.2692522-64-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit 81f8f7454ad9e0bf95efdec6542afdc9a6ab1e24 ]

Currently, the IB uverbs API calls uobj_get_uobj_read(), which in turn
uses the rdma_lookup_get_uobject() helper to retrieve user objects.
In case of failure, uobj_get_uobj_read() returns NULL, overriding the
error code from rdma_lookup_get_uobject(). The IB uverbs API then
translates this NULL to -EINVAL, masking the actual error and
complicating debugging. For example, applications calling ibv_modify_qp
that fails with EBUSY when retrieving the QP uobject will see the
overridden error code EINVAL instead, masking the actual error.

Furthermore, based on rdma-core commit:
"2a22f1ced5f3 ("Merge pull request #1568 from jakemoroni/master")"
Kernel's IB uverbs return values are either ignored and passed on as is
to application or overridden with other errnos in a few cases.

Thus, to improve error reporting and debuggability, propagate the
original error from rdma_lookup_get_uobject() instead of replacing it
with EINVAL.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Link: https://patch.msgid.link/64f9d3711b183984e939962c2f83383904f97dfb.1740577869.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/uverbs_cmd.c | 144 ++++++++++++++-------------
 include/rdma/uverbs_std_types.h      |   2 +-
 2 files changed, 77 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index c6053e82ecf6f..33e2fe0facd52 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -718,8 +718,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 		goto err_free;
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
 		goto err_free;
 	}
 
@@ -809,8 +809,8 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
 	if (cmd.flags & IB_MR_REREG_PD) {
 		new_pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle,
 					   attrs);
-		if (!new_pd) {
-			ret = -EINVAL;
+		if (IS_ERR(new_pd)) {
+			ret = PTR_ERR(new_pd);
 			goto put_uobjs;
 		}
 	} else {
@@ -919,8 +919,8 @@ static int ib_uverbs_alloc_mw(struct uverbs_attr_bundle *attrs)
 		return PTR_ERR(uobj);
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
 		goto err_free;
 	}
 
@@ -1127,8 +1127,8 @@ static int ib_uverbs_resize_cq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq)
-		return -EINVAL;
+	if (IS_ERR(cq))
+		return PTR_ERR(cq);
 
 	ret = cq->device->ops.resize_cq(cq, cmd.cqe, &attrs->driver_udata);
 	if (ret)
@@ -1189,8 +1189,8 @@ static int ib_uverbs_poll_cq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq)
-		return -EINVAL;
+	if (IS_ERR(cq))
+		return PTR_ERR(cq);
 
 	/* we copy a struct ib_uverbs_poll_cq_resp to user space */
 	header_ptr = attrs->ucore.outbuf;
@@ -1238,8 +1238,8 @@ static int ib_uverbs_req_notify_cq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq)
-		return -EINVAL;
+	if (IS_ERR(cq))
+		return PTR_ERR(cq);
 
 	ib_req_notify_cq(cq, cmd.solicited_only ?
 			 IB_CQ_SOLICITED : IB_CQ_NEXT_COMP);
@@ -1321,8 +1321,8 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 		ind_tbl = uobj_get_obj_read(rwq_ind_table,
 					    UVERBS_OBJECT_RWQ_IND_TBL,
 					    cmd->rwq_ind_tbl_handle, attrs);
-		if (!ind_tbl) {
-			ret = -EINVAL;
+		if (IS_ERR(ind_tbl)) {
+			ret = PTR_ERR(ind_tbl);
 			goto err_put;
 		}
 
@@ -1360,8 +1360,10 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 			if (cmd->is_srq) {
 				srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ,
 							cmd->srq_handle, attrs);
-				if (!srq || srq->srq_type == IB_SRQT_XRC) {
-					ret = -EINVAL;
+				if (IS_ERR(srq) ||
+				    srq->srq_type == IB_SRQT_XRC) {
+					ret = IS_ERR(srq) ? PTR_ERR(srq) :
+								  -EINVAL;
 					goto err_put;
 				}
 			}
@@ -1371,23 +1373,29 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 					rcq = uobj_get_obj_read(
 						cq, UVERBS_OBJECT_CQ,
 						cmd->recv_cq_handle, attrs);
-					if (!rcq) {
-						ret = -EINVAL;
+					if (IS_ERR(rcq)) {
+						ret = PTR_ERR(rcq);
 						goto err_put;
 					}
 				}
 			}
 		}
 
-		if (has_sq)
+		if (has_sq) {
 			scq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
 						cmd->send_cq_handle, attrs);
+			if (IS_ERR(scq)) {
+				ret = PTR_ERR(scq);
+				goto err_put;
+			}
+		}
+
 		if (!ind_tbl && cmd->qp_type != IB_QPT_XRC_INI)
 			rcq = rcq ?: scq;
 		pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle,
 				       attrs);
-		if (!pd || (!scq && has_sq)) {
-			ret = -EINVAL;
+		if (IS_ERR(pd)) {
+			ret = PTR_ERR(pd);
 			goto err_put;
 		}
 
@@ -1482,18 +1490,18 @@ static int create_qp(struct uverbs_attr_bundle *attrs,
 err_put:
 	if (!IS_ERR(xrcd_uobj))
 		uobj_put_read(xrcd_uobj);
-	if (pd)
+	if (!IS_ERR_OR_NULL(pd))
 		uobj_put_obj_read(pd);
-	if (scq)
+	if (!IS_ERR_OR_NULL(scq))
 		rdma_lookup_put_uobject(&scq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
-	if (rcq && rcq != scq)
+	if (!IS_ERR_OR_NULL(rcq) && rcq != scq)
 		rdma_lookup_put_uobject(&rcq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
-	if (srq)
+	if (!IS_ERR_OR_NULL(srq))
 		rdma_lookup_put_uobject(&srq->uobject->uevent.uobject,
 					UVERBS_LOOKUP_READ);
-	if (ind_tbl)
+	if (!IS_ERR_OR_NULL(ind_tbl))
 		uobj_put_obj_read(ind_tbl);
 
 	uobj_alloc_abort(&obj->uevent.uobject, attrs);
@@ -1655,8 +1663,8 @@ static int ib_uverbs_query_qp(struct uverbs_attr_bundle *attrs)
 	}
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp) {
-		ret = -EINVAL;
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
 		goto out;
 	}
 
@@ -1761,8 +1769,8 @@ static int modify_qp(struct uverbs_attr_bundle *attrs,
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd->base.qp_handle,
 			       attrs);
-	if (!qp) {
-		ret = -EINVAL;
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
 		goto out;
 	}
 
@@ -2027,8 +2035,8 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 		return -ENOMEM;
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp) {
-		ret = -EINVAL;
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
 		goto out;
 	}
 
@@ -2065,9 +2073,9 @@ static int ib_uverbs_post_send(struct uverbs_attr_bundle *attrs)
 
 			ud->ah = uobj_get_obj_read(ah, UVERBS_OBJECT_AH,
 						   user_wr->wr.ud.ah, attrs);
-			if (!ud->ah) {
+			if (IS_ERR(ud->ah)) {
+				ret = PTR_ERR(ud->ah);
 				kfree(ud);
-				ret = -EINVAL;
 				goto out_put;
 			}
 			ud->remote_qpn = user_wr->wr.ud.remote_qpn;
@@ -2304,8 +2312,8 @@ static int ib_uverbs_post_recv(struct uverbs_attr_bundle *attrs)
 		return PTR_ERR(wr);
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp) {
-		ret = -EINVAL;
+	if (IS_ERR(qp)) {
+		ret = PTR_ERR(qp);
 		goto out;
 	}
 
@@ -2355,8 +2363,8 @@ static int ib_uverbs_post_srq_recv(struct uverbs_attr_bundle *attrs)
 		return PTR_ERR(wr);
 
 	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
-	if (!srq) {
-		ret = -EINVAL;
+	if (IS_ERR(srq)) {
+		ret = PTR_ERR(srq);
 		goto out;
 	}
 
@@ -2412,8 +2420,8 @@ static int ib_uverbs_create_ah(struct uverbs_attr_bundle *attrs)
 	}
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
 		goto err;
 	}
 
@@ -2482,8 +2490,8 @@ static int ib_uverbs_attach_mcast(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp)
-		return -EINVAL;
+	if (IS_ERR(qp))
+		return PTR_ERR(qp);
 
 	obj = qp->uobject;
 
@@ -2532,8 +2540,8 @@ static int ib_uverbs_detach_mcast(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp)
-		return -EINVAL;
+	if (IS_ERR(qp))
+		return PTR_ERR(qp);
 
 	obj = qp->uobject;
 	mutex_lock(&obj->mcast_lock);
@@ -2667,8 +2675,8 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 							UVERBS_OBJECT_FLOW_ACTION,
 							kern_spec->action.handle,
 							attrs);
-		if (!ib_spec->action.act)
-			return -EINVAL;
+		if (IS_ERR(ib_spec->action.act))
+			return PTR_ERR(ib_spec->action.act);
 		ib_spec->action.size =
 			sizeof(struct ib_flow_spec_action_handle);
 		flow_resources_add(uflow_res,
@@ -2685,8 +2693,8 @@ static int kern_spec_to_ib_spec_action(struct uverbs_attr_bundle *attrs,
 					  UVERBS_OBJECT_COUNTERS,
 					  kern_spec->flow_count.handle,
 					  attrs);
-		if (!ib_spec->flow_count.counters)
-			return -EINVAL;
+		if (IS_ERR(ib_spec->flow_count.counters))
+			return PTR_ERR(ib_spec->flow_count.counters);
 		ib_spec->flow_count.size =
 				sizeof(struct ib_flow_spec_action_count);
 		flow_resources_add(uflow_res,
@@ -2904,14 +2912,14 @@ static int ib_uverbs_ex_create_wq(struct uverbs_attr_bundle *attrs)
 		return PTR_ERR(obj);
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd.pd_handle, attrs);
-	if (!pd) {
-		err = -EINVAL;
+	if (IS_ERR(pd)) {
+		err = PTR_ERR(pd);
 		goto err_uobj;
 	}
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq) {
-		err = -EINVAL;
+	if (IS_ERR(cq)) {
+		err = PTR_ERR(cq);
 		goto err_put_pd;
 	}
 
@@ -3012,8 +3020,8 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 		return -EINVAL;
 
 	wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ, cmd.wq_handle, attrs);
-	if (!wq)
-		return -EINVAL;
+	if (IS_ERR(wq))
+		return PTR_ERR(wq);
 
 	if (cmd.attr_mask & IB_WQ_FLAGS) {
 		wq_attr.flags = cmd.flags;
@@ -3096,8 +3104,8 @@ static int ib_uverbs_ex_create_rwq_ind_table(struct uverbs_attr_bundle *attrs)
 			num_read_wqs++) {
 		wq = uobj_get_obj_read(wq, UVERBS_OBJECT_WQ,
 				       wqs_handles[num_read_wqs], attrs);
-		if (!wq) {
-			err = -EINVAL;
+		if (IS_ERR(wq)) {
+			err = PTR_ERR(wq);
 			goto put_wqs;
 		}
 
@@ -3252,8 +3260,8 @@ static int ib_uverbs_ex_create_flow(struct uverbs_attr_bundle *attrs)
 	}
 
 	qp = uobj_get_obj_read(qp, UVERBS_OBJECT_QP, cmd.qp_handle, attrs);
-	if (!qp) {
-		err = -EINVAL;
+	if (IS_ERR(qp)) {
+		err = PTR_ERR(qp);
 		goto err_uobj;
 	}
 
@@ -3399,15 +3407,15 @@ static int __uverbs_create_xsrq(struct uverbs_attr_bundle *attrs,
 	if (ib_srq_has_cq(cmd->srq_type)) {
 		attr.ext.cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ,
 						cmd->cq_handle, attrs);
-		if (!attr.ext.cq) {
-			ret = -EINVAL;
+		if (IS_ERR(attr.ext.cq)) {
+			ret = PTR_ERR(attr.ext.cq);
 			goto err_put_xrcd;
 		}
 	}
 
 	pd = uobj_get_obj_read(pd, UVERBS_OBJECT_PD, cmd->pd_handle, attrs);
-	if (!pd) {
-		ret = -EINVAL;
+	if (IS_ERR(pd)) {
+		ret = PTR_ERR(pd);
 		goto err_put_cq;
 	}
 
@@ -3514,8 +3522,8 @@ static int ib_uverbs_modify_srq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
-	if (!srq)
-		return -EINVAL;
+	if (IS_ERR(srq))
+		return PTR_ERR(srq);
 
 	attr.max_wr    = cmd.max_wr;
 	attr.srq_limit = cmd.srq_limit;
@@ -3542,8 +3550,8 @@ static int ib_uverbs_query_srq(struct uverbs_attr_bundle *attrs)
 		return ret;
 
 	srq = uobj_get_obj_read(srq, UVERBS_OBJECT_SRQ, cmd.srq_handle, attrs);
-	if (!srq)
-		return -EINVAL;
+	if (IS_ERR(srq))
+		return PTR_ERR(srq);
 
 	ret = ib_query_srq(srq, &attr);
 
@@ -3668,8 +3676,8 @@ static int ib_uverbs_ex_modify_cq(struct uverbs_attr_bundle *attrs)
 		return -EOPNOTSUPP;
 
 	cq = uobj_get_obj_read(cq, UVERBS_OBJECT_CQ, cmd.cq_handle, attrs);
-	if (!cq)
-		return -EINVAL;
+	if (IS_ERR(cq))
+		return PTR_ERR(cq);
 
 	ret = rdma_set_cq_moderation(cq, cmd.attr.cq_count, cmd.attr.cq_period);
 
diff --git a/include/rdma/uverbs_std_types.h b/include/rdma/uverbs_std_types.h
index fe05121169589..555ea3d142a46 100644
--- a/include/rdma/uverbs_std_types.h
+++ b/include/rdma/uverbs_std_types.h
@@ -34,7 +34,7 @@
 static inline void *_uobj_get_obj_read(struct ib_uobject *uobj)
 {
 	if (IS_ERR(uobj))
-		return NULL;
+		return ERR_CAST(uobj);
 	return uobj->object;
 }
 #define uobj_get_obj_read(_object, _type, _id, _attrs)                         \
-- 
2.39.5


