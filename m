Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6B038C428
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhEUJ5m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 05:57:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3466 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhEUJzj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 05:55:39 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmhhH1j0gzCvSZ;
        Fri, 21 May 2021 17:51:27 +0800 (CST)
Received: from dggema753-chm.china.huawei.com (10.1.198.195) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:56 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema753-chm.china.huawei.com (10.1.198.195) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 21 May 2021 17:53:55 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 for-next 15/17] RDMA/i40iw: Use refcount_t instead of atomic_t on refcount of i40iw_cm_node
Date:   Fri, 21 May 2021 17:53:43 +0800
Message-ID: <1621590825-60693-16-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
References: <1621590825-60693-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema753-chm.china.huawei.com (10.1.198.195)
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
 drivers/infiniband/hw/i40iw/i40iw_cm.c | 36 +++++++++++++++++-----------------
 drivers/infiniband/hw/i40iw/i40iw_cm.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_cm.c b/drivers/infiniband/hw/i40iw/i40iw_cm.c
index 9bb86a4..caab0c1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.c
@@ -344,7 +344,7 @@ static void i40iw_free_retrans_entry(struct i40iw_cm_node *cm_node)
 		cm_node->send_entry = NULL;
 		i40iw_free_sqbuf(&iwdev->vsi, (void *)send_entry->sqbuf);
 		kfree(send_entry);
-		atomic_dec(&cm_node->ref_count);
+		refcount_dec(&cm_node->ref_count);
 	}
 }
 
@@ -570,7 +570,7 @@ static void i40iw_active_open_err(struct i40iw_cm_node *cm_node, bool reset)
 			    __func__,
 			    cm_node,
 			    cm_node->state);
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 		i40iw_send_reset(cm_node);
 	}
 
@@ -1092,7 +1092,7 @@ int i40iw_schedule_cm_timer(struct i40iw_cm_node *cm_node,
 	if (type == I40IW_TIMER_TYPE_SEND) {
 		spin_lock_irqsave(&cm_node->retrans_list_lock, flags);
 		cm_node->send_entry = new_send;
-		atomic_inc(&cm_node->ref_count);
+		refcount_inc(&cm_node->ref_count);
 		spin_unlock_irqrestore(&cm_node->retrans_list_lock, flags);
 		new_send->timetosend = jiffies + I40IW_RETRY_TIMEOUT;
 
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
@@ -1448,7 +1448,7 @@ struct i40iw_cm_node *i40iw_find_node(struct i40iw_cm_core *cm_core,
 		    !memcmp(cm_node->rem_addr, rem_addr, sizeof(cm_node->rem_addr)) &&
 		    (cm_node->rem_port == rem_port)) {
 			if (add_refcnt)
-				atomic_inc(&cm_node->ref_count);
+				refcount_inc(&cm_node->ref_count);
 			spin_unlock_irqrestore(&cm_core->ht_lock, flags);
 			return cm_node;
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
index 839966a..3cfe3d2 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_cm.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_cm.h
@@ -319,7 +319,7 @@ struct i40iw_cm_node {
 	enum i40iw_cm_node_state state;
 	u8 loc_mac[ETH_ALEN];
 	u8 rem_mac[ETH_ALEN];
-	atomic_t ref_count;
+	refcount_t ref_count;
 	struct i40iw_qp *iwqp;
 	struct i40iw_device *iwdev;
 	struct i40iw_sc_dev *dev;
-- 
2.7.4

