Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D23F26C4A5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Sep 2020 17:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgIPP4a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Sep 2020 11:56:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:14328 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgIPPzb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 16 Sep 2020 11:55:31 -0400
IronPort-SDR: eWvFcfA0FGbNjjpGwRLhfEGELza8gT30+ccrsMPX+UfV1J1ju5o5FLt7mjucdkbTrfVkO8C9zN
 EZ94BQfdLe5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="159510481"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="159510481"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:19:26 -0700
IronPort-SDR: QPyczFpuswpPplE+C3zOo7oj7no43TV0/YU1jOctde24nIIaoVwNmJGZrBvNQ41Z0mG5coApNj
 a110SvzlpGpw==
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="483308354"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.255.37.20])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:19:25 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        "Sindhu, Devale" <sindhu.devale@intel.com>,
        Kamal Heib <kheib@redhat.com>
Subject: [PATCH for-next] i40iw: Add support to make destroy QP synchronous
Date:   Wed, 16 Sep 2020 08:18:12 -0500
Message-Id: <20200916131811.2077-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: "Sindhu, Devale" <sindhu.devale@intel.com>

Occasionally ib_write_bw crash is seen due to
access of a pd object in i40iw_sc_qp_destroy after it
is freed. Destroy qp is not synchronous in i40iw and
thus the iwqp object could be referencing a pd object
that is freed by ib core as a result of successful
return from i40iw_destroy_qp.

Wait in i40iw_destroy_qp till all QP references are released
and destroy the QP and its associated resources before returning.
Switch to use the refcount API vs atomic API for lifetime
management of the qp.

 RIP: 0010:i40iw_sc_qp_destroy+0x4b/0x120 [i40iw]
 [...]
 RSP: 0018:ffffb4a7042e3ba8 EFLAGS: 00010002
 RAX: 0000000000000000 RBX: 0000000000000001 RCX: dead000000000122
 RDX: ffffb4a7042e3bac RSI: ffff8b7ef9b1e940 RDI: ffff8b7efbf09080
 RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
 R10: 8080808080808080 R11: 0000000000000010 R12: ffff8b7efbf08050
 R13: 0000000000000001 R14: ffff8b7f15042928 R15: ffff8b7ef9b1e940
 FS:  0000000000000000(0000) GS:ffff8b7f2fa00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000400 CR3: 000000020d60a006 CR4: 00000000001606e0
 Call Trace:
  i40iw_exec_cqp_cmd+0x4d3/0x5c0 [i40iw]
  ? try_to_wake_up+0x1ea/0x5d0
  ? __switch_to_asm+0x40/0x70
  i40iw_process_cqp_cmd+0x95/0xa0 [i40iw]
  i40iw_handle_cqp_op+0x42/0x1a0 [i40iw]
  ? cm_event_handler+0x13c/0x1f0 [iw_cm]
  i40iw_rem_ref+0xa0/0xf0 [i40iw]
  cm_work_handler+0x99c/0xd10 [iw_cm]
  process_one_work+0x1a1/0x360
  worker_thread+0x30/0x380
  ? process_one_work+0x360/0x360
  kthread+0x10c/0x130
  ? kthread_park+0x80/0x80
  ret_from_fork+0x35/0x40

Fixes: d37498417947 ("i40iw: add files for iwarp interface")
Reported-by: Kamal Heib <kheib@redhat.com>
Signed-off-by: Sindhu, Devale <sindhu.devale@intel.com>
Signed-off-by: Shiraz, Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw.h       |  9 +++--
 drivers/infiniband/hw/i40iw/i40iw_cm.c    | 10 +++---
 drivers/infiniband/hw/i40iw/i40iw_hw.c    |  4 +--
 drivers/infiniband/hw/i40iw/i40iw_utils.c | 59 ++++++-------------------------
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 31 +++++++++++-----
 drivers/infiniband/hw/i40iw/i40iw_verbs.h |  3 +-
 6 files changed, 45 insertions(+), 71 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index 25747b8..832b80d 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -409,8 +409,8 @@ static inline struct i40iw_qp *to_iwqp(struct ib_qp *ibqp)
 }
 
 /* i40iw.c */
-void i40iw_add_ref(struct ib_qp *);
-void i40iw_rem_ref(struct ib_qp *);
+void i40iw_qp_add_ref(struct ib_qp *ibqp);
+void i40iw_qp_rem_ref(struct ib_qp *ibqp);
 struct ib_qp *i40iw_get_qp(struct ib_device *, int);
 
 void i40iw_flush_wqes(struct i40iw_device *iwdev,
@@ -554,9 +554,8 @@ enum i40iw_status_code i40iw_manage_qhash(struct i40iw_device *iwdev,
 					  bool wait);
 void i40iw_receive_ilq(struct i40iw_sc_vsi *vsi, struct i40iw_puda_buf *rbuf);
 void i40iw_free_sqbuf(struct i40iw_sc_vsi *vsi, void *bufp);
-void i40iw_free_qp_resources(struct i40iw_device *iwdev,
-			     struct i40iw_qp *iwqp,
-			     u32 qp_num);
+void i40iw_free_qp_resources(struct i40iw_qp *iwqp);
+
 enum i40iw_status_code i40iw_obj_aligned_mem(struct i40iw_device *iwdev,
 					     struct i40iw_dma_mem *memptr,
 					     u32 size, u32 mask);
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index a3b9580..3053c34 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -2322,7 +2322,7 @@ static void i40iw_rem_ref_cm_node(struct i40iw_cm_node *cm_node)
 	iwqp = cm_node->iwqp;
 	if (iwqp) {
 		iwqp->cm_node = NULL;
-		i40iw_rem_ref(&iwqp->ibqp);
+		i40iw_qp_rem_ref(&iwqp->ibqp);
 		cm_node->iwqp = NULL;
 	} else if (cm_node->qhash_set) {
 		i40iw_get_addr_info(cm_node, &nfo);
@@ -3452,7 +3452,7 @@ void i40iw_cm_disconn(struct i40iw_qp *iwqp)
 		kfree(work);
 		return;
 	}
-	i40iw_add_ref(&iwqp->ibqp);
+	i40iw_qp_add_ref(&iwqp->ibqp);
 	spin_unlock_irqrestore(&iwdev->qptable_lock, flags);
 
 	work->iwqp = iwqp;
@@ -3623,7 +3623,7 @@ static void i40iw_disconnect_worker(struct work_struct *work)
 
 	kfree(dwork);
 	i40iw_cm_disconn_true(iwqp);
-	i40iw_rem_ref(&iwqp->ibqp);
+	i40iw_qp_rem_ref(&iwqp->ibqp);
 }
 
 /**
@@ -3745,7 +3745,7 @@ int i40iw_accept(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	cm_node->lsmm_size = accept.size + conn_param->private_data_len;
 	i40iw_cm_init_tsa_conn(iwqp, cm_node);
 	cm_id->add_ref(cm_id);
-	i40iw_add_ref(&iwqp->ibqp);
+	i40iw_qp_add_ref(&iwqp->ibqp);
 
 	attr.qp_state = IB_QPS_RTS;
 	cm_node->qhash_set = false;
@@ -3908,7 +3908,7 @@ int i40iw_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *conn_param)
 	iwqp->cm_node = cm_node;
 	cm_node->iwqp = iwqp;
 	iwqp->cm_id = cm_id;
-	i40iw_add_ref(&iwqp->ibqp);
+	i40iw_qp_add_ref(&iwqp->ibqp);
 
 	if (cm_node->state != I40IW_CM_STATE_OFFLOADED) {
 		cm_node->state = I40IW_CM_STATE_SYN_SENT;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_hw.c b/drivers/infiniband/hw/i40iw/i40iw_hw.c
index e108563..56fdc16 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_hw.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_hw.c
@@ -313,7 +313,7 @@ void i40iw_process_aeq(struct i40iw_device *iwdev)
 					    __func__, info->qp_cq_id);
 				continue;
 			}
-			i40iw_add_ref(&iwqp->ibqp);
+			i40iw_qp_add_ref(&iwqp->ibqp);
 			spin_unlock_irqrestore(&iwdev->qptable_lock, flags);
 			qp = &iwqp->sc_qp;
 			spin_lock_irqsave(&iwqp->lock, flags);
@@ -426,7 +426,7 @@ void i40iw_process_aeq(struct i40iw_device *iwdev)
 			break;
 		}
 		if (info->qp)
-			i40iw_rem_ref(&iwqp->ibqp);
+			i40iw_qp_rem_ref(&iwqp->ibqp);
 	} while (1);
 
 	if (aeqcnt)
diff --git a/drivers/infiniband/hw/i40iw/i40iw_utils.c b/drivers/infiniband/hw/i40iw/i40iw_utils.c
index e07fb37a..5e196bd 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_utils.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_utils.c
@@ -478,25 +478,6 @@ void i40iw_cleanup_pending_cqp_op(struct i40iw_device *iwdev)
 }
 
 /**
- * i40iw_free_qp - callback after destroy cqp completes
- * @cqp_request: cqp request for destroy qp
- * @num: not used
- */
-static void i40iw_free_qp(struct i40iw_cqp_request *cqp_request, u32 num)
-{
-	struct i40iw_sc_qp *qp = (struct i40iw_sc_qp *)cqp_request->param;
-	struct i40iw_qp *iwqp = (struct i40iw_qp *)qp->back_qp;
-	struct i40iw_device *iwdev;
-	u32 qp_num = iwqp->ibqp.qp_num;
-
-	iwdev = iwqp->iwdev;
-
-	i40iw_rem_pdusecount(iwqp->iwpd, iwdev);
-	i40iw_free_qp_resources(iwdev, iwqp, qp_num);
-	i40iw_rem_devusecount(iwdev);
-}
-
-/**
  * i40iw_wait_event - wait for completion
  * @iwdev: iwarp device
  * @cqp_request: cqp request to wait
@@ -616,26 +597,23 @@ void i40iw_rem_pdusecount(struct i40iw_pd *iwpd, struct i40iw_device *iwdev)
 }
 
 /**
- * i40iw_add_ref - add refcount for qp
+ * i40iw_qp_add_ref - add refcount for qp
  * @ibqp: iqarp qp
  */
-void i40iw_add_ref(struct ib_qp *ibqp)
+void i40iw_qp_add_ref(struct ib_qp *ibqp)
 {
 	struct i40iw_qp *iwqp = (struct i40iw_qp *)ibqp;
 
-	atomic_inc(&iwqp->refcount);
+	refcount_inc(&iwqp->refcount);
 }
 
 /**
- * i40iw_rem_ref - rem refcount for qp and free if 0
+ * i40iw_qp_rem_ref - rem refcount for qp and free if 0
  * @ibqp: iqarp qp
  */
-void i40iw_rem_ref(struct ib_qp *ibqp)
+void i40iw_qp_rem_ref(struct ib_qp *ibqp)
 {
 	struct i40iw_qp *iwqp;
-	enum i40iw_status_code status;
-	struct i40iw_cqp_request *cqp_request;
-	struct cqp_commands_info *cqp_info;
 	struct i40iw_device *iwdev;
 	u32 qp_num;
 	unsigned long flags;
@@ -643,7 +621,7 @@ void i40iw_rem_ref(struct ib_qp *ibqp)
 	iwqp = to_iwqp(ibqp);
 	iwdev = iwqp->iwdev;
 	spin_lock_irqsave(&iwdev->qptable_lock, flags);
-	if (!atomic_dec_and_test(&iwqp->refcount)) {
+	if (!refcount_dec_and_test(&iwqp->refcount)) {
 		spin_unlock_irqrestore(&iwdev->qptable_lock, flags);
 		return;
 	}
@@ -651,25 +629,8 @@ void i40iw_rem_ref(struct ib_qp *ibqp)
 	qp_num = iwqp->ibqp.qp_num;
 	iwdev->qp_table[qp_num] = NULL;
 	spin_unlock_irqrestore(&iwdev->qptable_lock, flags);
-	cqp_request = i40iw_get_cqp_request(&iwdev->cqp, false);
-	if (!cqp_request)
-		return;
-
-	cqp_request->callback_fcn = i40iw_free_qp;
-	cqp_request->param = (void *)&iwqp->sc_qp;
-	cqp_info = &cqp_request->info;
-	cqp_info->cqp_cmd = OP_QP_DESTROY;
-	cqp_info->post_sq = 1;
-	cqp_info->in.u.qp_destroy.qp = &iwqp->sc_qp;
-	cqp_info->in.u.qp_destroy.scratch = (uintptr_t)cqp_request;
-	cqp_info->in.u.qp_destroy.remove_hash_idx = true;
-	status = i40iw_handle_cqp_op(iwdev, cqp_request);
-	if (!status)
-		return;
+	complete(&iwqp->free_qp);
 
-	i40iw_rem_pdusecount(iwqp->iwpd, iwdev);
-	i40iw_free_qp_resources(iwdev, iwqp, qp_num);
-	i40iw_rem_devusecount(iwdev);
 }
 
 /**
@@ -936,7 +897,7 @@ static void i40iw_terminate_timeout(struct timer_list *t)
 	struct i40iw_sc_qp *qp = (struct i40iw_sc_qp *)&iwqp->sc_qp;
 
 	i40iw_terminate_done(qp, 1);
-	i40iw_rem_ref(&iwqp->ibqp);
+	i40iw_qp_rem_ref(&iwqp->ibqp);
 }
 
 /**
@@ -948,7 +909,7 @@ void i40iw_terminate_start_timer(struct i40iw_sc_qp *qp)
 	struct i40iw_qp *iwqp;
 
 	iwqp = (struct i40iw_qp *)qp->back_qp;
-	i40iw_add_ref(&iwqp->ibqp);
+	i40iw_qp_add_ref(&iwqp->ibqp);
 	timer_setup(&iwqp->terminate_timer, i40iw_terminate_timeout, 0);
 	iwqp->terminate_timer.expires = jiffies + HZ;
 	add_timer(&iwqp->terminate_timer);
@@ -964,7 +925,7 @@ void i40iw_terminate_del_timer(struct i40iw_sc_qp *qp)
 
 	iwqp = (struct i40iw_qp *)qp->back_qp;
 	if (del_timer(&iwqp->terminate_timer))
-		i40iw_rem_ref(&iwqp->ibqp);
+		i40iw_qp_rem_ref(&iwqp->ibqp);
 }
 
 /**
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 4511e17..6ade1ea 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -364,11 +364,11 @@ static struct i40iw_pbl *i40iw_get_pbl(unsigned long va,
  * @iwqp: qp ptr (user or kernel)
  * @qp_num: qp number assigned
  */
-void i40iw_free_qp_resources(struct i40iw_device *iwdev,
-			     struct i40iw_qp *iwqp,
-			     u32 qp_num)
+void i40iw_free_qp_resources(struct i40iw_qp *iwqp)
 {
 	struct i40iw_pbl *iwpbl = &iwqp->iwpbl;
+	struct i40iw_device *iwdev = iwqp->iwdev;
+	u32 qp_num = iwqp->ibqp.qp_num;
 
 	i40iw_ieq_cleanup_qp(iwdev->vsi.ieq, &iwqp->sc_qp);
 	i40iw_dealloc_push_page(iwdev, &iwqp->sc_qp);
@@ -402,6 +402,10 @@ static void i40iw_clean_cqes(struct i40iw_qp *iwqp, struct i40iw_cq *iwcq)
 static int i40iw_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct i40iw_qp *iwqp = to_iwqp(ibqp);
+	struct ib_qp_attr attr;
+	struct i40iw_device *iwdev = iwqp->iwdev;
+
+	memset(&attr, 0, sizeof(attr));
 
 	iwqp->destroyed = 1;
 
@@ -416,7 +420,15 @@ static int i40iw_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 		}
 	}
 
-	i40iw_rem_ref(&iwqp->ibqp);
+	attr.qp_state = IB_QPS_ERR;
+	i40iw_modify_qp(&iwqp->ibqp, &attr, IB_QP_STATE, NULL);
+	i40iw_qp_rem_ref(&iwqp->ibqp);
+	wait_for_completion(&iwqp->free_qp);
+	i40iw_cqp_qp_destroy_cmd(&iwdev->sc_dev, &iwqp->sc_qp);
+	i40iw_rem_pdusecount(iwqp->iwpd, iwdev);
+	i40iw_free_qp_resources(iwqp);
+	i40iw_rem_devusecount(iwdev);
+
 	return 0;
 }
 
@@ -577,6 +589,7 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
 	qp->back_qp = (void *)iwqp;
 	qp->push_idx = I40IW_INVALID_PUSH_PAGE_INDEX;
 
+	iwqp->iwdev = iwdev;
 	iwqp->ctx_info.iwarp_info = &iwqp->iwarp_info;
 
 	if (i40iw_allocate_dma_mem(dev->hw,
@@ -601,7 +614,6 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
 		goto error;
 	}
 
-	iwqp->iwdev = iwdev;
 	iwqp->iwpd = iwpd;
 	iwqp->ibqp.qp_num = qp_num;
 	qp = &iwqp->sc_qp;
@@ -715,7 +727,7 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
 		goto error;
 	}
 
-	i40iw_add_ref(&iwqp->ibqp);
+	refcount_set(&iwqp->refcount, 1);
 	spin_lock_init(&iwqp->lock);
 	iwqp->sig_all = (init_attr->sq_sig_type == IB_SIGNAL_ALL_WR) ? 1 : 0;
 	iwdev->qp_table[qp_num] = iwqp;
@@ -737,10 +749,11 @@ static struct ib_qp *i40iw_create_qp(struct ib_pd *ibpd,
 	}
 	init_completion(&iwqp->sq_drained);
 	init_completion(&iwqp->rq_drained);
+	init_completion(&iwqp->free_qp);
 
 	return &iwqp->ibqp;
 error:
-	i40iw_free_qp_resources(iwdev, iwqp, qp_num);
+	i40iw_free_qp_resources(iwqp);
 	return ERR_PTR(err_code);
 }
 
@@ -2629,13 +2642,13 @@ static int i40iw_query_gid(struct ib_device *ibdev,
 	.get_hw_stats = i40iw_get_hw_stats,
 	.get_port_immutable = i40iw_port_immutable,
 	.iw_accept = i40iw_accept,
-	.iw_add_ref = i40iw_add_ref,
+	.iw_add_ref = i40iw_qp_add_ref,
 	.iw_connect = i40iw_connect,
 	.iw_create_listen = i40iw_create_listen,
 	.iw_destroy_listen = i40iw_destroy_listen,
 	.iw_get_qp = i40iw_get_qp,
 	.iw_reject = i40iw_reject,
-	.iw_rem_ref = i40iw_rem_ref,
+	.iw_rem_ref = i40iw_qp_rem_ref,
 	.map_mr_sg = i40iw_map_mr_sg,
 	.mmap = i40iw_mmap,
 	.modify_qp = i40iw_modify_qp,
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.h b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
index 331bc21..bab71f3 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
@@ -139,7 +139,7 @@ struct i40iw_qp {
 	struct i40iw_qp_host_ctx_info ctx_info;
 	struct i40iwarp_offload_info iwarp_info;
 	void *allocated_buffer;
-	atomic_t refcount;
+	refcount_t refcount;
 	struct iw_cm_id *cm_id;
 	void *cm_node;
 	struct ib_mr *lsmm_mr;
@@ -174,5 +174,6 @@ struct i40iw_qp {
 	struct i40iw_dma_mem ietf_mem;
 	struct completion sq_drained;
 	struct completion rq_drained;
+	struct completion free_qp;
 };
 #endif
-- 
1.8.3.1

