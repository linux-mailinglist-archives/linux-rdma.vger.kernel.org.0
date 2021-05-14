Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5BE3801D0
	for <lists+linux-rdma@lfdr.de>; Fri, 14 May 2021 04:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhENCNH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 22:13:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3661 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhENCNH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 May 2021 22:13:07 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FhBm80f9wz1BMNR;
        Fri, 14 May 2021 10:09:12 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 10:11:43 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH for-next 5/6] RDMA/i40iw: Use refcount_t instead of atomic_t for reference counting
Date:   Fri, 14 May 2021 10:11:38 +0800
Message-ID: <1620958299-4869-6-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
References: <1620958299-4869-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API will WARN on underflow and overflow of a reference
counter, and avoid use-after-free risks.

Cc: Faisal Latif <faisal.latif@intel.com>
Cc: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/i40iw/i40iw.h       |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c    | 54 +++++++++++++++----------------
 drivers/infiniband/hw/i40iw/i40iw_cm.h    |  4 +--
 drivers/infiniband/hw/i40iw/i40iw_main.c  |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_puda.h  |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_utils.c | 10 +++---
 6 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw.h b/drivers/infiniband/hw/i40iw/i40iw.h
index be4094a..15c5dd6 100644
--- a/drivers/infiniband/hw/i40iw/i40iw.h
+++ b/drivers/infiniband/hw/i40iw/i40iw.h
@@ -137,7 +137,7 @@ struct i40iw_cqp_request {
 	struct cqp_commands_info info;
 	wait_queue_head_t waitq;
 	struct list_head list;
-	atomic_t refcount;
+	refcount_t refcount;
 	void (*callback_fcn)(struct i40iw_cqp_request*, u32);
 	void *param;
 	struct i40iw_cqp_compl_info compl_info;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 2450b7d..caab0c1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -77,7 +77,7 @@ void i40iw_free_sqbuf(struct i40iw_sc_vsi *vsi, void *bufp)
 	struct i40iw_puda_buf *buf = (struct i40iw_puda_buf *)bufp;
 	struct i40iw_puda_rsrc *ilq = vsi->ilq;
 
-	if (!atomic_dec_return(&buf->refcount))
+	if (refcount_dec_and_test(&buf->refcount))
 		i40iw_puda_ret_bufpool(ilq, buf);
 }
 
@@ -344,7 +344,7 @@ static void i40iw_free_retrans_entry(struct i40iw_cm_node *cm_node)
 		cm_node->send_entry = NULL;
 		i40iw_free_sqbuf(&iwdev->vsi, (void *)send_entry->sqbuf);
 		kfree(send_entry);
-		atomic_dec(&cm_node->ref_count);
+		refcount_dec(&cm_node->ref_count);
 	}
 }
 
@@ -531,7 +531,7 @@ static struct i40iw_puda_buf *i40iw_form_cm_frame(struct i40iw_cm_node *cm_node,
 	if (pdata && pdata->addr)
 		memcpy(buf, pdata->addr, pdata->size);
 
-	atomic_set(&sqbuf->refcount, 1);
+	refcount_set(&sqbuf->refcount, 1);
 
 	return sqbuf;
 }
@@ -570,7 +570,7 @@ static void i40iw_active_open_err(struct i40iw_cm_node *cm_node, bool reset)
 			    __func__,
 			    cm_node,
 			    cm_node->state);
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 		i40iw_send_reset(cm_node);
 	}
 
@@ -1092,11 +1092,11 @@ int i40iw_schedule_cm_timer(struct i40iw_cm_node *cm_node,
 	if (type == I40IW_TIMER_TYPE_SEND) {
 		spin_lock_irqsave(&cm_node->retrans_list_lock, flags);
 		cm_node->send_entry = new_send;
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 		spin_unlock_irqrestore(&cm_node->retrans_list_lock, flags);
 		new_send->timetosend = jiffies + I40IW_RETRY_TIMEOUT;
 
-		atomic_inc(&sqbuf->refcount);
+		refcount_inc(&sqbuf->refcount);
 		i40iw_puda_send_buf(vsi->ilq, sqbuf);
 		if (!send_retrans) {
 			i40iw_cleanup_retrans_entry(cm_node);
@@ -1140,7 +1140,7 @@ static void i40iw_retrans_expired(struct i40iw_cm_node *cm_node)
 		i40iw_send_reset(cm_node);
 		break;
 	default:
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 		i40iw_send_reset(cm_node);
 		i40iw_create_event(cm_node, I40IW_CM_EVENT_ABORTED);
 		break;
@@ -1198,7 +1198,7 @@ static void i40iw_build_timer_list(struct list_head *timer_list,
 	list_for_each_safe(list_node, list_core_temp, hte) {
 		cm_node = container_of(list_node, struct i40iw_cm_node, list);
 		if (cm_node->close_entry || cm_node->send_entry) {
-			atomic_inc(&cm_node->ref_count);
+			refcount_inc(&cm_node->ref_count);
 			list_add(&cm_node->timer_entry, timer_list);
 		}
 	}
@@ -1286,7 +1286,7 @@ static void i40iw_cm_timer_tick(struct timer_list *t)
 		vsi = &cm_node->iwdev->vsi;
 
 		if (!cm_node->ack_rcvd) {
-			atomic_inc(&send_entry->sqbuf->refcount);
+			refcount_inc(&send_entry->sqbuf->refcount);
 			i40iw_puda_send_buf(vsi->ilq, send_entry->sqbuf);
 			cm_node->cm_core->stats_pkt_retrans++;
 		}
@@ -1448,7 +1448,7 @@ struct i40iw_cm_node *i40iw_find_node(struct i40iw_cm_core *cm_core,
 		    !memcmp(cm_node->rem_addr, rem_addr, sizeof(cm_node->rem_addr)) &&
 		    (cm_node->rem_port == rem_port)) {
 			if (add_refcnt)
-				atomic_inc(&cm_node->ref_count);
+				refcount_inc(&cm_node->ref_count);
 			spin_unlock_irqrestore(&cm_core->ht_lock, flags);
 			return cm_node;
 		}
@@ -1491,7 +1491,7 @@ static struct i40iw_cm_listener *i40iw_find_listener(
 		     !memcmp(listen_addr, ip_zero, sizeof(listen_addr))) &&
 		     (listen_port == dst_port) &&
 		     (listener_state & listen_node->listener_state)) {
-			atomic_inc(&listen_node->ref_count);
+			refcount_inc(&listen_node->ref_count);
 			spin_unlock_irqrestore(&cm_core->listen_list_lock, flags);
 			return listen_node;
 		}
@@ -1864,7 +1864,7 @@ static int i40iw_dec_refcnt_listen(struct i40iw_cm_core *cm_core,
 			cm_node = container_of(list_pos, struct i40iw_cm_node, list);
 			if ((cm_node->listener == listener) &&
 			    !cm_node->accelerated) {
-				atomic_inc(&cm_node->ref_count);
+				refcount_inc(&cm_node->ref_count);
 				list_add(&cm_node->reset_entry, &reset_list);
 			}
 		}
@@ -1901,7 +1901,7 @@ static int i40iw_dec_refcnt_listen(struct i40iw_cm_core *cm_core,
 				event.cm_info.loc_port = loopback->loc_port;
 				event.cm_info.cm_id = loopback->cm_id;
 				event.cm_info.ipv4 = loopback->ipv4;
-				atomic_inc(&loopback->ref_count);
+				refcount_inc(&loopback->ref_count);
 				loopback->state = I40IW_CM_STATE_CLOSED;
 				i40iw_event_connect_error(&event);
 				cm_node->state = I40IW_CM_STATE_LISTENER_DESTROYED;
@@ -1910,7 +1910,7 @@ static int i40iw_dec_refcnt_listen(struct i40iw_cm_core *cm_core,
 		}
 	}
 
-	if (!atomic_dec_return(&listener->ref_count)) {
+	if (refcount_dec_and_test(&listener->ref_count)) {
 		spin_lock_irqsave(&cm_core->listen_list_lock, flags);
 		list_del(&listener->list);
 		spin_unlock_irqrestore(&cm_core->listen_list_lock, flags);
@@ -2206,7 +2206,7 @@ static struct i40iw_cm_node *i40iw_make_cm_node(
 	spin_lock_init(&cm_node->retrans_list_lock);
 	cm_node->ack_rcvd = false;
 
-	atomic_set(&cm_node->ref_count, 1);
+	refcount_set(&cm_node->ref_count, 1);
 	/* associate our parent CM core */
 	cm_node->cm_core = cm_core;
 	cm_node->tcp_cntxt.loc_id = I40IW_CM_DEF_LOCAL_ID;
@@ -2288,7 +2288,7 @@ static void i40iw_rem_ref_cm_node(struct i40iw_cm_node *cm_node)
 	unsigned long flags;
 
 	spin_lock_irqsave(&cm_node->cm_core->ht_lock, flags);
-	if (atomic_dec_return(&cm_node->ref_count)) {
+	if (!refcount_dec_and_test(&cm_node->ref_count)) {
 		spin_unlock_irqrestore(&cm_node->cm_core->ht_lock, flags);
 		return;
 	}
@@ -2366,7 +2366,7 @@ static void i40iw_handle_fin_pkt(struct i40iw_cm_node *cm_node)
 		cm_node->tcp_cntxt.rcv_nxt++;
 		i40iw_cleanup_retrans_entry(cm_node);
 		cm_node->state = I40IW_CM_STATE_CLOSED;
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 		i40iw_send_reset(cm_node);
 		break;
 	case I40IW_CM_STATE_FIN_WAIT1:
@@ -2627,7 +2627,7 @@ static void i40iw_handle_syn_pkt(struct i40iw_cm_node *cm_node,
 		break;
 	case I40IW_CM_STATE_CLOSED:
 		i40iw_cleanup_retrans_entry(cm_node);
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 		i40iw_send_reset(cm_node);
 		break;
 	case I40IW_CM_STATE_OFFLOADED:
@@ -2701,7 +2701,7 @@ static void i40iw_handle_synack_pkt(struct i40iw_cm_node *cm_node,
 	case I40IW_CM_STATE_CLOSED:
 		cm_node->tcp_cntxt.loc_seq_num = ntohl(tcph->ack_seq);
 		i40iw_cleanup_retrans_entry(cm_node);
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 		i40iw_send_reset(cm_node);
 		break;
 	case I40IW_CM_STATE_ESTABLISHED:
@@ -2774,7 +2774,7 @@ static int i40iw_handle_ack_pkt(struct i40iw_cm_node *cm_node,
 		break;
 	case I40IW_CM_STATE_CLOSED:
 		i40iw_cleanup_retrans_entry(cm_node);
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 		i40iw_send_reset(cm_node);
 		break;
 	case I40IW_CM_STATE_LAST_ACK:
@@ -2870,7 +2870,7 @@ static struct i40iw_cm_listener *i40iw_make_listen_node(
 				       I40IW_CM_LISTENER_EITHER_STATE);
 	if (listener &&
 	    (listener->listener_state == I40IW_CM_LISTENER_ACTIVE_STATE)) {
-		atomic_dec(&listener->ref_count);
+		refcount_dec(&listener->ref_count);
 		i40iw_debug(cm_core->dev,
 			    I40IW_DEBUG_CM,
 			    "Not creating listener since it already exists\n");
@@ -2888,7 +2888,7 @@ static struct i40iw_cm_listener *i40iw_make_listen_node(
 
 		INIT_LIST_HEAD(&listener->child_listen_list);
 
-		atomic_set(&listener->ref_count, 1);
+		refcount_set(&listener->ref_count, 1);
 	} else {
 		listener->reused_node = 1;
 	}
@@ -3213,7 +3213,7 @@ void i40iw_receive_ilq(struct i40iw_sc_vsi *vsi, struct i40iw_puda_buf *rbuf)
 				    I40IW_DEBUG_CM,
 				    "%s allocate node failed\n",
 				    __func__);
-			atomic_dec(&listener->ref_count);
+			refcount_dec(&listener->ref_count);
 			return;
 		}
 		if (!tcph->rst && !tcph->fin) {
@@ -3222,7 +3222,7 @@ void i40iw_receive_ilq(struct i40iw_sc_vsi *vsi, struct i40iw_puda_buf *rbuf)
 			i40iw_rem_ref_cm_node(cm_node);
 			return;
 		}
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 	} else if (cm_node->state == I40IW_CM_STATE_OFFLOADED) {
 		i40iw_rem_ref_cm_node(cm_node);
 		return;
@@ -4228,7 +4228,7 @@ static void i40iw_cm_event_handler(struct work_struct *work)
  */
 static void i40iw_cm_post_event(struct i40iw_cm_event *event)
 {
-	atomic_inc(&event->cm_node->ref_count);
+	refcount_inc(&event->cm_node->ref_count);
 	event->cm_info.cm_id->add_ref(event->cm_info.cm_id);
 	INIT_WORK(&event->event_work, i40iw_cm_event_handler);
 
@@ -4331,7 +4331,7 @@ void i40iw_cm_teardown_connections(struct i40iw_device *iwdev, u32 *ipaddr,
 		    (nfo->vlan_id == cm_node->vlan_id &&
 		    (!memcmp(cm_node->loc_addr, ipaddr, nfo->ipv4 ? 4 : 16) ||
 		     !memcmp(cm_node->rem_addr, ipaddr, nfo->ipv4 ? 4 : 16)))) {
-			atomic_inc(&cm_node->ref_count);
+			refcount_inc(&cm_node->ref_count);
 			list_add(&cm_node->teardown_entry, &teardown_list);
 		}
 	}
@@ -4342,7 +4342,7 @@ void i40iw_cm_teardown_connections(struct i40iw_device *iwdev, u32 *ipaddr,
 		    (nfo->vlan_id == cm_node->vlan_id &&
 		    (!memcmp(cm_node->loc_addr, ipaddr, nfo->ipv4 ? 4 : 16) ||
 		     !memcmp(cm_node->rem_addr, ipaddr, nfo->ipv4 ? 4 : 16)))) {
-			atomic_inc(&cm_node->ref_count);
+			refcount_inc(&cm_node->ref_count);
 			list_add(&cm_node->teardown_entry, &teardown_list);
 		}
 	}
diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.h b/drivers/infiniband/hw/i40iw/i40iw_cm.h
index 6e43e4d..3cfe3d2 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.h
@@ -291,7 +291,7 @@ struct i40iw_cm_listener {
 	u32 loc_addr[4];
 	u16 loc_port;
 	struct iw_cm_id *cm_id;
-	atomic_t ref_count;
+	refcount_t ref_count;
 	struct i40iw_device *iwdev;
 	atomic_t pend_accepts_cnt;
 	int backlog;
@@ -319,7 +319,7 @@ struct i40iw_cm_node {
 	enum i40iw_cm_node_state state;
 	u8 loc_mac[ETH_ALEN];
 	u8 rem_mac[ETH_ALEN];
-	atomic_t ref_count;
+	refcount_t ref_count;
 	struct i40iw_qp *iwqp;
 	struct i40iw_device *iwdev;
 	struct i40iw_sc_dev *dev;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_main.c b/drivers/infiniband/hw/i40iw/i40iw_main.c
index b496f30..fc48555 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_main.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_main.c
@@ -1125,7 +1125,7 @@ static enum i40iw_status_code i40iw_alloc_local_mac_ipaddr_entry(struct i40iw_de
 	}
 
 	/* increment refcount, because we need the cqp request ret value */
-	atomic_inc(&cqp_request->refcount);
+	refcount_inc(&cqp_request->refcount);
 
 	cqp_info = &cqp_request->info;
 	cqp_info->cqp_cmd = OP_ALLOC_LOCAL_MAC_IPADDR_ENTRY;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_puda.h b/drivers/infiniband/hw/i40iw/i40iw_puda.h
index 53a7d58..5996626 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_puda.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_puda.h
@@ -90,7 +90,7 @@ struct i40iw_puda_buf {
 	u8 tcphlen;		/* tcp length in bytes */
 	u8 maclen;		/* mac length in bytes */
 	u32 totallen;		/* machlen+iphlen+tcphlen+datalen */
-	atomic_t refcount;
+	refcount_t refcount;
 	u8 hdrlen;
 	bool ipv4;
 	u32 seqnum;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_utils.c b/drivers/infiniband/hw/i40iw/i40iw_utils.c
index 9ff825f..32ff432b 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_utils.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_utils.c
@@ -384,10 +384,10 @@ struct i40iw_cqp_request *i40iw_get_cqp_request(struct i40iw_cqp *cqp, bool wait
 	}
 
 	if (wait) {
-		atomic_set(&cqp_request->refcount, 2);
+		refcount_set(&cqp_request->refcount, 2);
 		cqp_request->waiting = true;
 	} else {
-		atomic_set(&cqp_request->refcount, 1);
+		refcount_set(&cqp_request->refcount, 1);
 	}
 	return cqp_request;
 }
@@ -424,7 +424,7 @@ void i40iw_free_cqp_request(struct i40iw_cqp *cqp, struct i40iw_cqp_request *cqp
 void i40iw_put_cqp_request(struct i40iw_cqp *cqp,
 			   struct i40iw_cqp_request *cqp_request)
 {
-	if (atomic_dec_and_test(&cqp_request->refcount))
+	if (refcount_dec_and_test(&cqp_request->refcount))
 		i40iw_free_cqp_request(cqp, cqp_request);
 }
 
@@ -445,7 +445,7 @@ static void i40iw_free_pending_cqp_request(struct i40iw_cqp *cqp,
 	}
 	i40iw_put_cqp_request(cqp, cqp_request);
 	wait_event_timeout(iwdev->close_wq,
-			   !atomic_read(&cqp_request->refcount),
+			   !refcount_read(&cqp_request->refcount),
 			   1000);
 }
 
@@ -1005,7 +1005,7 @@ static void i40iw_cqp_manage_hmc_fcn_callback(struct i40iw_cqp_request *cqp_requ
 
 	if (hmcfcninfo && hmcfcninfo->callback_fcn) {
 		i40iw_debug(&iwdev->sc_dev, I40IW_DEBUG_HMC, "%s1\n", __func__);
-		atomic_inc(&cqp_request->refcount);
+		refcount_inc(&cqp_request->refcount);
 		work = &iwdev->virtchnl_w[hmcfcninfo->iw_vf_idx];
 		work->cqp_request = cqp_request;
 		INIT_WORK(&work->work, i40iw_cqp_manage_hmc_fcn_worker);
-- 
2.7.4

