Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE26D7360
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Apr 2023 06:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjDEE10 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Apr 2023 00:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236840AbjDEE1Y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Apr 2023 00:27:24 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB810CF
        for <linux-rdma@vger.kernel.org>; Tue,  4 Apr 2023 21:27:22 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17aa62d0a4aso37087509fac.4
        for <linux-rdma@vger.kernel.org>; Tue, 04 Apr 2023 21:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680668842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UrGFcsWq3dVrqh1lrExS/7KIzMlxfVpQ1ept8dQ9ic=;
        b=YA9lLvHvmglJ8NT8VtXZ7G8xx4QHmGl5/PdI7ZWpse8L3tNqAikloQPR7mKR+5stQJ
         xZQPpTGcWDGA02OKb34RZ7r+FmhwheWTPsAtalcnHkngcWJfGvY/oVuquOiXKLlWR1kK
         rzLNY+Qb8Gjy26Eb3pY+1g7s+pbkmeFs+18LsiMIuXAQINpbr01cgnnYfnOlrNk1OhZJ
         8K2vNhsuguH8n3qIPx3FYw6TwRQo/y7FEfcYG8+8Nmcuo/R7Zw0hRFD+I0ZPgge7JSkW
         vhThs7aMCclsy+7Ad1ePTZZgC7jioURq8Gw+jz1AuHCIIkIyT9ydToD6bFtAnLrlB+Bt
         h76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680668842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UrGFcsWq3dVrqh1lrExS/7KIzMlxfVpQ1ept8dQ9ic=;
        b=DEFBPsEGWtlJ4VB3ZkP4VKIAZV9k/K1B7YvkNMPcY6MAecjdHXVmNlO+icQEF9AQ0J
         8xihhvxGNoBAFb4wDM7k6bQd5jhFn2im+M3AZPTPSPLET1iiX5dwLgPzjz6Di1NwWSW1
         ZcpAxlOJFbeLe31d4cS45bfIIzYTvV5EDcEbgV78L9+OgW7wp9WSp+mQljPPpN50mPrl
         gfncPRYCTtDGTpj1yGKHLr7IkFDNVI0lxd9Zh3TdsogKi8hJa74QdiGy5Y82ovz3s4JP
         lgtMJGJ8XPBuc+bHrr11FWdtww8wCLiPe7Txhe+zpezytEB75cZF/hLQyxawe+yz7Rz8
         mZhw==
X-Gm-Message-State: AAQBX9eJidoUJl7Rs70bagRXw8L8eV59inHcEMAfb0e2osQErBRrew2Z
        3VecU04kmefHT/QltuVJhek=
X-Google-Smtp-Source: AKy350ZvOARNye67wMpUVxLNMm9y7dgnxn2gYHW6rkD83DDa+tMWZJl9QmqLoX5BKicvq9Cx3sexHw==
X-Received: by 2002:a05:6870:d192:b0:17f:7dca:8926 with SMTP id a18-20020a056870d19200b0017f7dca8926mr2662030oac.20.1680668841688;
        Tue, 04 Apr 2023 21:27:21 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id x80-20020a4a4153000000b0053d9be4be68sm6321326ooa.19.2023.04.04.21.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 21:27:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 5/5] RDMA/rxe: Protect QP state with qp->state_lock
Date:   Tue,  4 Apr 2023 23:26:11 -0500
Message-Id: <20230405042611.6467-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405042611.6467-1-rpearsonhpe@gmail.com>
References: <20230405042611.6467-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe driver makes little effort to make the changes
to qp state (which includes qp->attr.qp_state, qp->attr.sq_draining
and qp->valid) atomic between different client threads and
IO threads. In particular a common template is for an RDMA
application to call ib_modify_qp() to move a qp to ERR state and
then wait until all the packet and work queues have drained before
calling ib_destroy_qp(). None of these state changes are protected
by locks to assure that the changes are executed atomically and
that memory barriers are included. This has been observed to lead
to incorrect behavior around qp cleanup.

This patch continues the work of the previous patches in this series
and adds locking code around qp state changes and lookups.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_comp.c  |  48 ++++--
 drivers/infiniband/sw/rxe/rxe_net.c   |   3 +
 drivers/infiniband/sw/rxe/rxe_qp.c    | 153 +++++++++--------
 drivers/infiniband/sw/rxe/rxe_recv.c  |  10 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  71 +++++---
 drivers/infiniband/sw/rxe/rxe_resp.c  |  12 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 238 +++++++++++++++-----------
 7 files changed, 317 insertions(+), 218 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index 1ccae8cff359..db18ace74d2b 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -118,10 +118,12 @@ void retransmit_timer(struct timer_list *t)
 
 	rxe_dbg_qp(qp, "retransmit timer fired\n");
 
+	spin_lock_bh(&qp->state_lock);
 	if (qp->valid) {
 		qp->comp.timeout = 1;
 		rxe_sched_task(&qp->comp.task);
 	}
+	spin_unlock_bh(&qp->state_lock);
 }
 
 void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
@@ -479,9 +481,8 @@ static void do_complete(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 static void comp_check_sq_drain_done(struct rxe_qp *qp)
 {
+	spin_lock_bh(&qp->state_lock);
 	if (unlikely(qp_state(qp) == IB_QPS_SQD)) {
-		/* state_lock used by requester & completer */
-		spin_lock_bh(&qp->state_lock);
 		if (qp->attr.sq_draining && qp->comp.psn == qp->req.psn) {
 			qp->attr.sq_draining = 0;
 			spin_unlock_bh(&qp->state_lock);
@@ -497,8 +498,8 @@ static void comp_check_sq_drain_done(struct rxe_qp *qp)
 			}
 			return;
 		}
-		spin_unlock_bh(&qp->state_lock);
 	}
+	spin_unlock_bh(&qp->state_lock);
 }
 
 static inline enum comp_state complete_ack(struct rxe_qp *qp,
@@ -614,6 +615,26 @@ static void free_pkt(struct rxe_pkt_info *pkt)
 	ib_device_put(dev);
 }
 
+/* reset the retry timer if
+ * - QP is type RC
+ * - there is a packet sent by the requester that
+ *   might be acked (we still might get spurious
+ *   timeouts but try to keep them as few as possible)
+ * - the timeout parameter is set
+ * - the QP is alive
+ */
+static void reset_retry_timer(struct rxe_qp *qp)
+{
+	if (qp_type(qp) == IB_QPT_RC && qp->qp_timeout_jiffies) {
+		spin_lock_bh(&qp->state_lock);
+		if (qp_state(qp) >= IB_QPS_RTS &&
+		    psn_compare(qp->req.psn, qp->comp.psn) > 0)
+			mod_timer(&qp->retrans_timer,
+				  jiffies + qp->qp_timeout_jiffies);
+		spin_unlock_bh(&qp->state_lock);
+	}
+}
+
 int rxe_completer(struct rxe_qp *qp)
 {
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
@@ -623,14 +644,17 @@ int rxe_completer(struct rxe_qp *qp)
 	enum comp_state state;
 	int ret;
 
+	spin_lock_bh(&qp->state_lock);
 	if (!qp->valid || qp_state(qp) == IB_QPS_ERR ||
-	    qp_state(qp) == IB_QPS_RESET) {
+			  qp_state(qp) == IB_QPS_RESET) {
 		bool notify = qp->valid && (qp_state(qp) == IB_QPS_ERR);
 
 		drain_resp_pkts(qp);
 		flush_send_queue(qp, notify);
+		spin_unlock_bh(&qp->state_lock);
 		goto exit;
 	}
+	spin_unlock_bh(&qp->state_lock);
 
 	if (qp->comp.timeout) {
 		qp->comp.timeout_retry = 1;
@@ -718,20 +742,7 @@ int rxe_completer(struct rxe_qp *qp)
 				break;
 			}
 
-			/* re reset the timeout counter if
-			 * (1) QP is type RC
-			 * (2) the QP is alive
-			 * (3) there is a packet sent by the requester that
-			 *     might be acked (we still might get spurious
-			 *     timeouts but try to keep them as few as possible)
-			 * (4) the timeout parameter is set
-			 */
-			if ((qp_type(qp) == IB_QPT_RC) &&
-			    (qp_state(qp) >= IB_QPS_RTS) &&
-			    (psn_compare(qp->req.psn, qp->comp.psn) > 0) &&
-			    qp->qp_timeout_jiffies)
-				mod_timer(&qp->retrans_timer,
-					  jiffies + qp->qp_timeout_jiffies);
+			reset_retry_timer(qp);
 			goto exit;
 
 		case COMPST_ERROR_RETRY:
@@ -793,6 +804,7 @@ int rxe_completer(struct rxe_qp *qp)
 				 */
 				qp->req.wait_for_rnr_timer = 1;
 				rxe_dbg_qp(qp, "set rnr nak timer\n");
+				// TODO who protects from destroy_qp??
 				mod_timer(&qp->rnr_nak_timer,
 					  jiffies + rnrnak_jiffies(aeth_syn(pkt)
 						& ~AETH_TYPE_MASK));
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 9ed81d0bd25c..2bc7361152ea 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -413,11 +413,14 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 	int is_request = pkt->mask & RXE_REQ_MASK;
 	struct rxe_dev *rxe = to_rdev(qp->ibqp.device);
 
+	spin_lock_bh(&qp->state_lock);
 	if ((is_request && (qp_state(qp) < IB_QPS_RTS)) ||
 	    (!is_request && (qp_state(qp) < IB_QPS_RTR))) {
+		spin_unlock_bh(&qp->state_lock);
 		rxe_dbg_qp(qp, "Packet dropped. QP is not in ready state\n");
 		goto drop;
 	}
+	spin_unlock_bh(&qp->state_lock);
 
 	rxe_icrc_generate(skb, pkt);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index b9e40ad02ac6..762597f01b5f 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -325,8 +325,10 @@ int rxe_qp_from_init(struct rxe_dev *rxe, struct rxe_qp *qp, struct rxe_pd *pd,
 	if (err)
 		goto err2;
 
+	spin_lock_bh(&qp->state_lock);
 	qp->attr.qp_state = IB_QPS_RESET;
 	qp->valid = 1;
+	spin_unlock_bh(&qp->state_lock);
 
 	return 0;
 
@@ -377,27 +379,9 @@ int rxe_qp_to_init(struct rxe_qp *qp, struct ib_qp_init_attr *init)
 	return 0;
 }
 
-/* called by the modify qp verb, this routine checks all the parameters before
- * making any changes
- */
 int rxe_qp_chk_attr(struct rxe_dev *rxe, struct rxe_qp *qp,
 		    struct ib_qp_attr *attr, int mask)
 {
-	enum ib_qp_state cur_state = (mask & IB_QP_CUR_STATE) ?
-					attr->cur_qp_state : qp->attr.qp_state;
-	enum ib_qp_state new_state = (mask & IB_QP_STATE) ?
-					attr->qp_state : cur_state;
-
-	if (!ib_modify_qp_is_ok(cur_state, new_state, qp_type(qp), mask)) {
-		rxe_dbg_qp(qp, "invalid mask or state\n");
-		goto err1;
-	}
-
-	if (mask & IB_QP_STATE && cur_state == IB_QPS_SQD) {
-		if (qp->attr.sq_draining && new_state != IB_QPS_ERR)
-			goto err1;
-	}
-
 	if (mask & IB_QP_PORT) {
 		if (!rdma_is_port_valid(&rxe->ib_dev, attr->port_num)) {
 			rxe_dbg_qp(qp, "invalid port %d\n", attr->port_num);
@@ -508,22 +492,96 @@ static void rxe_qp_reset(struct rxe_qp *qp)
 /* move the qp to the error state */
 void rxe_qp_error(struct rxe_qp *qp)
 {
+	spin_lock_bh(&qp->state_lock);
 	qp->attr.qp_state = IB_QPS_ERR;
 
 	/* drain work and packet queues */
 	rxe_sched_task(&qp->resp.task);
 	rxe_sched_task(&qp->comp.task);
 	rxe_sched_task(&qp->req.task);
+	spin_unlock_bh(&qp->state_lock);
+}
+
+static void rxe_qp_sqd(struct rxe_qp *qp, struct ib_qp_attr *attr,
+		       int mask)
+{
+	spin_lock_bh(&qp->state_lock);
+	qp->attr.sq_draining = 1;
+	rxe_sched_task(&qp->comp.task);
+	rxe_sched_task(&qp->req.task);
+	spin_unlock_bh(&qp->state_lock);
+}
+
+/* caller should hold qp->state_lock */
+static int __qp_chk_state(struct rxe_qp *qp, struct ib_qp_attr *attr,
+			    int mask)
+{
+	enum ib_qp_state cur_state;
+	enum ib_qp_state new_state;
+
+	cur_state = (mask & IB_QP_CUR_STATE) ?
+				attr->cur_qp_state : qp->attr.qp_state;
+	new_state = (mask & IB_QP_STATE) ?
+				attr->qp_state : cur_state;
+
+	if (!ib_modify_qp_is_ok(cur_state, new_state, qp_type(qp), mask))
+		return -EINVAL;
+
+	if (mask & IB_QP_STATE && cur_state == IB_QPS_SQD) {
+		if (qp->attr.sq_draining && new_state != IB_QPS_ERR)
+			return -EINVAL;
+	}
+
+	return 0;
 }
 
+static const char *qps2str[] = {
+	[IB_QPS_RESET]	= "RESET",
+	[IB_QPS_INIT]	= "INIT",
+	[IB_QPS_RTR]	= "RTR",
+	[IB_QPS_RTS]	= "RTS",
+	[IB_QPS_SQD]	= "SQD",
+	[IB_QPS_SQE]	= "SQE",
+	[IB_QPS_ERR]	= "ERR",
+};
+
 /* called by the modify qp verb */
 int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		     struct ib_udata *udata)
 {
-	enum ib_qp_state cur_state = (mask & IB_QP_CUR_STATE) ?
-				attr->cur_qp_state : qp->attr.qp_state;
 	int err;
 
+	if (mask & IB_QP_CUR_STATE)
+		qp->attr.cur_qp_state = attr->qp_state;
+
+	if (mask & IB_QP_STATE) {
+		spin_lock_bh(&qp->state_lock);
+		err = __qp_chk_state(qp, attr, mask);
+		if (!err) {
+			qp->attr.qp_state = attr->qp_state;
+			rxe_dbg_qp(qp, "state -> %s\n",
+					qps2str[attr->qp_state]);
+		}
+		spin_unlock_bh(&qp->state_lock);
+
+		if (err)
+			return err;
+
+		switch (attr->qp_state) {
+		case IB_QPS_RESET:
+			rxe_qp_reset(qp);
+			break;
+		case IB_QPS_SQD:
+			rxe_qp_sqd(qp, attr, mask);
+			break;
+		case IB_QPS_ERR:
+			rxe_qp_error(qp);
+			break;
+		default:
+			break;
+		}
+	}
+
 	if (mask & IB_QP_MAX_QP_RD_ATOMIC) {
 		int max_rd_atomic = attr->max_rd_atomic ?
 			roundup_pow_of_two(attr->max_rd_atomic) : 0;
@@ -545,9 +603,6 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 			return err;
 	}
 
-	if (mask & IB_QP_CUR_STATE)
-		qp->attr.cur_qp_state = attr->qp_state;
-
 	if (mask & IB_QP_EN_SQD_ASYNC_NOTIFY)
 		qp->attr.en_sqd_async_notify = attr->en_sqd_async_notify;
 
@@ -627,48 +682,6 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 	if (mask & IB_QP_DEST_QPN)
 		qp->attr.dest_qp_num = attr->dest_qp_num;
 
-	if (mask & IB_QP_STATE) {
-		qp->attr.qp_state = attr->qp_state;
-
-		switch (attr->qp_state) {
-		case IB_QPS_RESET:
-			rxe_dbg_qp(qp, "state -> RESET\n");
-			rxe_qp_reset(qp);
-			break;
-
-		case IB_QPS_INIT:
-			rxe_dbg_qp(qp, "state -> INIT\n");
-			break;
-
-		case IB_QPS_RTR:
-			rxe_dbg_qp(qp, "state -> RTR\n");
-			break;
-
-		case IB_QPS_RTS:
-			rxe_dbg_qp(qp, "state -> RTS\n");
-			break;
-
-		case IB_QPS_SQD:
-			rxe_dbg_qp(qp, "state -> SQD\n");
-			if (cur_state != IB_QPS_SQD) {
-				qp->attr.sq_draining = 1;
-				rxe_sched_task(&qp->comp.task);
-				rxe_sched_task(&qp->req.task);
-			}
-			break;
-
-		case IB_QPS_SQE:
-			rxe_dbg_qp(qp, "state -> SQE !!?\n");
-			/* Not possible from modify_qp. */
-			break;
-
-		case IB_QPS_ERR:
-			rxe_dbg_qp(qp, "state -> ERR\n");
-			rxe_qp_error(qp);
-			break;
-		}
-	}
-
 	return 0;
 }
 
@@ -695,10 +708,12 @@ int rxe_qp_to_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask)
 	/* Applications that get this state typically spin on it.
 	 * Yield the processor
 	 */
-	if (qp->attr.sq_draining)
+	spin_lock_bh(&qp->state_lock);
+	if (qp->attr.sq_draining) {
+		spin_unlock_bh(&qp->state_lock);
 		cond_resched();
-
-	rxe_dbg_qp(qp, "attr->sq_draining = %d\n", attr->sq_draining);
+	}
+	spin_unlock_bh(&qp->state_lock);
 
 	return 0;
 }
@@ -722,7 +737,9 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
 {
 	struct rxe_qp *qp = container_of(work, typeof(*qp), cleanup_work.work);
 
+	spin_lock_bh(&qp->state_lock);
 	qp->valid = 0;
+	spin_unlock_bh(&qp->state_lock);
 	qp->qp_timeout_jiffies = 0;
 
 	if (qp_type(qp) == IB_QPT_RC) {
diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index ca17ac6c5878..2f953cc74256 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -38,13 +38,19 @@ static int check_type_state(struct rxe_dev *rxe, struct rxe_pkt_info *pkt,
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&qp->state_lock);
 	if (pkt->mask & RXE_REQ_MASK) {
-		if (unlikely(qp_state(qp) < IB_QPS_RTR))
+		if (unlikely(qp_state(qp) < IB_QPS_RTR)) {
+			spin_unlock_bh(&qp->state_lock);
 			return -EINVAL;
+		}
 	} else {
-		if (unlikely(qp_state(qp) < IB_QPS_RTS))
+		if (unlikely(qp_state(qp) < IB_QPS_RTS)) {
+			spin_unlock_bh(&qp->state_lock);
 			return -EINVAL;
+		}
 	}
+	spin_unlock_bh(&qp->state_lock);
 
 	return 0;
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index f329038efbc8..8e50d116d273 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -102,24 +102,33 @@ void rnr_nak_timer(struct timer_list *t)
 
 	rxe_dbg_qp(qp, "nak timer fired\n");
 
-	/* request a send queue retry */
-	qp->req.need_retry = 1;
-	qp->req.wait_for_rnr_timer = 0;
-	rxe_sched_task(&qp->req.task);
+	spin_lock_bh(&qp->state_lock);
+	if (qp->valid) {
+		/* request a send queue retry */
+		qp->req.need_retry = 1;
+		qp->req.wait_for_rnr_timer = 0;
+		rxe_sched_task(&qp->req.task);
+	}
+	spin_unlock_bh(&qp->state_lock);
 }
 
 static void req_check_sq_drain_done(struct rxe_qp *qp)
 {
-	struct rxe_queue *q = qp->sq.queue;
-	unsigned int index = qp->req.wqe_index;
-	unsigned int cons = queue_get_consumer(q, QUEUE_TYPE_FROM_CLIENT);
-	struct rxe_send_wqe *wqe = queue_addr_from_index(q, cons);
+	struct rxe_queue *q;
+	unsigned int index;
+	unsigned int cons;
+	struct rxe_send_wqe *wqe;
+
+	spin_lock_bh(&qp->state_lock);
+	if (qp_state(qp) == IB_QPS_SQD) {
+		q = qp->sq.queue;
+		index = qp->req.wqe_index;
+		cons = queue_get_consumer(q, QUEUE_TYPE_FROM_CLIENT);
+		wqe = queue_addr_from_index(q, cons);
 
-	if (unlikely(qp_state(qp) == IB_QPS_SQD)) {
 		/* check to see if we are drained;
 		 * state_lock used by requester and completer
 		 */
-		spin_lock_bh(&qp->state_lock);
 		do {
 			if (!qp->attr.sq_draining)
 				/* comp just finished */
@@ -144,28 +153,40 @@ static void req_check_sq_drain_done(struct rxe_qp *qp)
 			}
 			return;
 		} while (0);
-		spin_unlock_bh(&qp->state_lock);
 	}
+	spin_unlock_bh(&qp->state_lock);
 }
 
-static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
+static struct rxe_send_wqe *__req_next_wqe(struct rxe_qp *qp)
 {
-	struct rxe_send_wqe *wqe;
 	struct rxe_queue *q = qp->sq.queue;
 	unsigned int index = qp->req.wqe_index;
 	unsigned int prod;
 
-	req_check_sq_drain_done(qp);
-
 	prod = queue_get_producer(q, QUEUE_TYPE_FROM_CLIENT);
 	if (index == prod)
 		return NULL;
+	else
+		return queue_addr_from_index(q, index);
+}
 
-	wqe = queue_addr_from_index(q, index);
+static struct rxe_send_wqe *req_next_wqe(struct rxe_qp *qp)
+{
+	struct rxe_send_wqe *wqe;
+
+	req_check_sq_drain_done(qp);
+
+	wqe = __req_next_wqe(qp);
+	if (wqe == NULL)
+		return NULL;
 
+	spin_lock(&qp->state_lock);
 	if (unlikely((qp_state(qp) == IB_QPS_SQD) &&
-		     (wqe->state != wqe_state_processing)))
+		     (wqe->state != wqe_state_processing))) {
+		spin_unlock(&qp->state_lock);
 		return NULL;
+	}
+	spin_unlock(&qp->state_lock);
 
 	wqe->mask = wr_opcode_mask(wqe->wr.opcode, qp);
 	return wqe;
@@ -656,15 +677,16 @@ int rxe_requester(struct rxe_qp *qp)
 	struct rxe_ah *ah;
 	struct rxe_av *av;
 
-	if (unlikely(!qp->valid))
+	spin_lock_bh(&qp->state_lock);
+	if (unlikely(!qp->valid)) {
+		spin_unlock_bh(&qp->state_lock);
 		goto exit;
+	}
 
 	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
-		wqe = req_next_wqe(qp);
+		wqe = __req_next_wqe(qp);
+		spin_unlock_bh(&qp->state_lock);
 		if (wqe)
-			/*
-			 * Generate an error completion for error qp state
-			 */
 			goto err;
 		else
 			goto exit;
@@ -678,8 +700,10 @@ int rxe_requester(struct rxe_qp *qp)
 		qp->req.wait_psn = 0;
 		qp->req.need_retry = 0;
 		qp->req.wait_for_rnr_timer = 0;
+		spin_unlock_bh(&qp->state_lock);
 		goto exit;
 	}
+	spin_unlock_bh(&qp->state_lock);
 
 	/* we come here if the retransmit timer has fired
 	 * or if the rnr timer has fired. If the retransmit
@@ -839,8 +863,7 @@ int rxe_requester(struct rxe_qp *qp)
 	/* update wqe_index for each wqe completion */
 	qp->req.wqe_index = queue_next_index(qp->sq.queue, qp->req.wqe_index);
 	wqe->state = wqe_state_error;
-	qp->attr.qp_state = IB_QPS_ERR;
-	rxe_sched_task(&qp->comp.task);
+	rxe_qp_error(qp);
 exit:
 	ret = -EAGAIN;
 out:
diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index 67eac616235c..68f6cd188d8e 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -1137,8 +1137,13 @@ static enum resp_states do_complete(struct rxe_qp *qp,
 		return RESPST_ERR_CQ_OVERFLOW;
 
 finish:
-	if (unlikely(qp_state(qp) == IB_QPS_ERR))
+	spin_lock_bh(&qp->state_lock);
+	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
+		spin_unlock_bh(&qp->state_lock);
 		return RESPST_CHK_RESOURCE;
+	}
+	spin_unlock_bh(&qp->state_lock);
+
 	if (unlikely(!pkt))
 		return RESPST_DONE;
 	if (qp_type(qp) == IB_QPT_RC)
@@ -1464,14 +1469,17 @@ int rxe_responder(struct rxe_qp *qp)
 	struct rxe_pkt_info *pkt = NULL;
 	int ret;
 
+	spin_lock_bh(&qp->state_lock);
 	if (!qp->valid || qp_state(qp) == IB_QPS_ERR ||
-	    qp_state(qp) == IB_QPS_RESET) {
+			  qp_state(qp) == IB_QPS_RESET) {
 		bool notify = qp->valid && (qp_state(qp) == IB_QPS_ERR);
 
 		drain_req_pkts(qp);
 		flush_recv_queue(qp, notify);
+		spin_unlock_bh(&qp->state_lock);
 		goto exit;
 	}
+	spin_unlock_bh(&qp->state_lock);
 
 	qp->resp.aeth_syndrome = AETH_ACK_UNLIMITED;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 28799f1cacb8..2bf4c7431382 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -660,42 +660,70 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 }
 
 /* send wr */
+
+/* sanity check incoming send work request */
 static int validate_send_wr(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
-			    unsigned int mask, unsigned int length)
+			    unsigned int *maskp, unsigned int *lengthp)
 {
 	int num_sge = ibwr->num_sge;
 	struct rxe_sq *sq = &qp->sq;
+	unsigned int mask = 0;
+	unsigned long length = 0;
+	int err = -EINVAL;
+	int i;
 
-	if (unlikely(num_sge > sq->max_sge)) {
-		rxe_dbg_qp(qp, "num_sge > max_sge");
-		goto err_out;
-	}
+	do {
+		mask = wr_opcode_mask(ibwr->opcode, qp);
+		if (!mask) {
+			rxe_err_qp(qp, "bad wr opcode for qp type");
+			break;
+		}
 
-	if (unlikely(mask & WR_ATOMIC_MASK)) {
-		if (length != 8) {
-			rxe_dbg_qp(qp, "atomic length != 8");
-			goto err_out;
+		if (num_sge > sq->max_sge) {
+			rxe_err_qp(qp, "num_sge > max_sge");
+			break;
 		}
 
-		if (atomic_wr(ibwr)->remote_addr & 0x7) {
-			rxe_dbg_qp(qp, "misaligned atomic address");
-			goto err_out;
+		length = 0;
+		for (i = 0; i < ibwr->num_sge; i++)
+			length += ibwr->sg_list[i].length;
+
+		if (length > (1UL << 31)) {
+			rxe_err_qp(qp, "message length too long");
+			break;
 		}
-	}
 
-	if (unlikely((ibwr->send_flags & IB_SEND_INLINE) &&
-		     (length > sq->max_inline))) {
-		rxe_dbg_qp(qp, "inline length too big");
-		goto err_out;
-	}
+		if (mask & WR_ATOMIC_MASK) {
+			if (length != 8) {
+				rxe_err_qp(qp, "atomic length != 8");
+				break;
+			}
+			if (atomic_wr(ibwr)->remote_addr & 0x7) {
+				rxe_err_qp(qp, "misaligned atomic address");
+				break;
+			}
+		}
+		if (ibwr->send_flags & IB_SEND_INLINE) {
+			if (!(mask & WR_INLINE_MASK)) {
+				rxe_err_qp(qp, "opcode doesn't support inline data");
+				break;
+			}
+			if (length > sq->max_inline) {
+				rxe_err_qp(qp, "inline length too big");
+				break;
+			}
+		}
 
-	return 0;
+		err = 0;
+	} while (0);
 
-err_out:
-	return -EINVAL;
+	*maskp = mask;
+	*lengthp = (int)length;
+
+	return err;
 }
 
-static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
+static int init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 			 const struct ib_send_wr *ibwr)
 {
 	wr->wr_id = ibwr->wr_id;
@@ -711,8 +739,18 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 		wr->wr.ud.ah_num = to_rah(ibah)->ah_num;
 		if (qp_type(qp) == IB_QPT_GSI)
 			wr->wr.ud.pkey_index = ud_wr(ibwr)->pkey_index;
-		if (wr->opcode == IB_WR_SEND_WITH_IMM)
+
+		switch (wr->opcode) {
+		case IB_WR_SEND_WITH_IMM:
 			wr->ex.imm_data = ibwr->ex.imm_data;
+			break;
+		case IB_WR_SEND:
+			break;
+		default:
+			rxe_err_qp(qp, "bad wr opcode %d for UD/GSI QP",
+					wr->opcode);
+			return -EINVAL;
+		}
 	} else {
 		switch (wr->opcode) {
 		case IB_WR_RDMA_WRITE_WITH_IMM:
@@ -729,6 +767,11 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 		case IB_WR_SEND_WITH_INV:
 			wr->ex.invalidate_rkey = ibwr->ex.invalidate_rkey;
 			break;
+		case IB_WR_RDMA_READ_WITH_INV:
+			wr->ex.invalidate_rkey = ibwr->ex.invalidate_rkey;
+			wr->wr.rdma.remote_addr = rdma_wr(ibwr)->remote_addr;
+			wr->wr.rdma.rkey	= rdma_wr(ibwr)->rkey;
+			break;
 		case IB_WR_ATOMIC_CMP_AND_SWP:
 		case IB_WR_ATOMIC_FETCH_AND_ADD:
 			wr->wr.atomic.remote_addr =
@@ -746,10 +789,20 @@ static void init_send_wr(struct rxe_qp *qp, struct rxe_send_wr *wr,
 			wr->wr.reg.key = reg_wr(ibwr)->key;
 			wr->wr.reg.access = reg_wr(ibwr)->access;
 			break;
+		case IB_WR_SEND:
+		case IB_WR_BIND_MW:
+		case IB_WR_FLUSH:
+		case IB_WR_ATOMIC_WRITE:
+			break;
 		default:
+			rxe_err_qp(qp, "unsupported wr opcode %d",
+					wr->opcode);
+			return -EINVAL;
 			break;
 		}
 	}
+
+	return 0;
 }
 
 static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
@@ -765,19 +818,22 @@ static void copy_inline_data_to_wqe(struct rxe_send_wqe *wqe,
 	}
 }
 
-static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
+static int init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 			 unsigned int mask, unsigned int length,
 			 struct rxe_send_wqe *wqe)
 {
 	int num_sge = ibwr->num_sge;
+	int err;
 
-	init_send_wr(qp, &wqe->wr, ibwr);
+	err = init_send_wr(qp, &wqe->wr, ibwr);
+	if (err)
+		return err;
 
 	/* local operation */
 	if (unlikely(mask & WR_LOCAL_OP_MASK)) {
 		wqe->mask = mask;
 		wqe->state = wqe_state_posted;
-		return;
+		return 0;
 	}
 
 	if (unlikely(ibwr->send_flags & IB_SEND_INLINE))
@@ -796,93 +852,62 @@ static void init_send_wqe(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
 	wqe->dma.sge_offset	= 0;
 	wqe->state		= wqe_state_posted;
 	wqe->ssn		= atomic_add_return(1, &qp->ssn);
+
+	return 0;
 }
 
-static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr,
-			 unsigned int mask, u32 length)
+static int post_one_send(struct rxe_qp *qp, const struct ib_send_wr *ibwr)
 {
 	int err;
 	struct rxe_sq *sq = &qp->sq;
 	struct rxe_send_wqe *send_wqe;
-	unsigned long flags;
+	unsigned int mask;
+	unsigned int length;
 	int full;
 
-	err = validate_send_wr(qp, ibwr, mask, length);
+	err = validate_send_wr(qp, ibwr, &mask, &length);
 	if (err)
 		return err;
 
-	spin_lock_irqsave(&qp->sq.sq_lock, flags);
-
 	full = queue_full(sq->queue, QUEUE_TYPE_FROM_ULP);
 	if (unlikely(full)) {
-		spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
-		rxe_dbg_qp(qp, "queue full");
+		rxe_err_qp(qp, "send queue full");
 		return -ENOMEM;
 	}
 
 	send_wqe = queue_producer_addr(sq->queue, QUEUE_TYPE_FROM_ULP);
-	init_send_wqe(qp, ibwr, mask, length, send_wqe);
-
-	queue_advance_producer(sq->queue, QUEUE_TYPE_FROM_ULP);
-
-	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
+	err = init_send_wqe(qp, ibwr, mask, length, send_wqe);
+	if (!err)
+		queue_advance_producer(sq->queue, QUEUE_TYPE_FROM_ULP);
 
-	return 0;
+	return err;
 }
 
-static int rxe_post_send_kernel(struct rxe_qp *qp, const struct ib_send_wr *wr,
+static int rxe_post_send_kernel(struct rxe_qp *qp,
+				const struct ib_send_wr *ibwr,
 				const struct ib_send_wr **bad_wr)
 {
 	int err = 0;
-	unsigned int mask;
-	unsigned int length = 0;
-	int i;
-	struct ib_send_wr *next;
-
-	while (wr) {
-		mask = wr_opcode_mask(wr->opcode, qp);
-		if (unlikely(!mask)) {
-			rxe_dbg_qp(qp, "bad wr opcode for qp");
-			err = -EINVAL;
-			*bad_wr = wr;
-			break;
-		}
-
-		if (unlikely((wr->send_flags & IB_SEND_INLINE) &&
-			     !(mask & WR_INLINE_MASK))) {
-			rxe_dbg_qp(qp, "opcode doesn't support inline data");
-			err = -EINVAL;
-			*bad_wr = wr;
-			break;
-		}
-
-		next = wr->next;
-
-		length = 0;
-		for (i = 0; i < wr->num_sge; i++)
-			length += wr->sg_list[i].length;
-		if (length > 1<<31) {
-			err = -EINVAL;
-			rxe_dbg_qp(qp, "message length too long");
-			*bad_wr = wr;
-			break;
-		}
+	unsigned long flags;
 
-		err = post_one_send(qp, wr, mask, length);
+	spin_lock_irqsave(&qp->sq.sq_lock, flags);
+	while (ibwr) {
+		err = post_one_send(qp, ibwr);
 		if (err) {
-			*bad_wr = wr;
+			*bad_wr = ibwr;
 			break;
 		}
-
-		wr = next;
+		ibwr = ibwr->next;
 	}
+	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
 
-	/* if we didn't post anything there's nothing to do */
 	if (!err)
 		rxe_sched_task(&qp->req.task);
 
-	if (unlikely(qp_state(qp) == IB_QPS_ERR))
+	spin_lock_bh(&qp->state_lock);
+	if (qp_state(qp) == IB_QPS_ERR)
 		rxe_sched_task(&qp->comp.task);
+	spin_unlock_bh(&qp->state_lock);
 
 	return err;
 }
@@ -893,19 +918,21 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	struct rxe_qp *qp = to_rqp(ibqp);
 	int err;
 
-	if (unlikely(!qp->valid)) {
-		*bad_wr = wr;
-		err = -EINVAL;
-		rxe_dbg_qp(qp, "qp destroyed");
-		goto err_out;
+	spin_lock_bh(&qp->state_lock);
+	/* caller has already called destroy_qp */
+	if (WARN_ON_ONCE(!qp->valid)) {
+		spin_unlock_bh(&qp->state_lock);
+		rxe_err_qp(qp, "qp has been destroyed");
+		return -EINVAL;
 	}
 
 	if (unlikely(qp_state(qp) < IB_QPS_RTS)) {
+		spin_unlock_bh(&qp->state_lock);
 		*bad_wr = wr;
-		err = -EINVAL;
-		rxe_dbg_qp(qp, "qp not ready to send");
-		goto err_out;
+		rxe_err_qp(qp, "qp not ready to send");
+		return -EINVAL;
 	}
+	spin_unlock_bh(&qp->state_lock);
 
 	if (qp->is_user) {
 		/* Utilize process context to do protocol processing */
@@ -913,14 +940,10 @@ static int rxe_post_send(struct ib_qp *ibqp, const struct ib_send_wr *wr,
 	} else {
 		err = rxe_post_send_kernel(qp, wr, bad_wr);
 		if (err)
-			goto err_out;
+			return err;
 	}
 
 	return 0;
-
-err_out:
-	rxe_err_qp(qp, "returned err = %d", err);
-	return err;
 }
 
 /* recv wr */
@@ -985,18 +1008,27 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 	struct rxe_rq *rq = &qp->rq;
 	unsigned long flags;
 
-	if (unlikely((qp_state(qp) < IB_QPS_INIT) || !qp->valid)) {
+	spin_lock_bh(&qp->state_lock);
+	/* caller has already called destroy_qp */
+	if (WARN_ON_ONCE(!qp->valid)) {
+		spin_unlock_bh(&qp->state_lock);
+		rxe_err_qp(qp, "qp has been destroyed");
+		return -EINVAL;
+	}
+
+	/* see C10-97.2.1 */
+	if (unlikely((qp_state(qp) < IB_QPS_INIT))) {
+		spin_unlock_bh(&qp->state_lock);
 		*bad_wr = wr;
-		err = -EINVAL;
-		rxe_dbg_qp(qp, "qp destroyed or not ready to post recv");
-		goto err_out;
+		rxe_dbg_qp(qp, "qp not ready to post recv");
+		return -EINVAL;
 	}
+	spin_unlock_bh(&qp->state_lock);
 
 	if (unlikely(qp->srq)) {
 		*bad_wr = wr;
-		err = -EINVAL;
-		rxe_dbg_qp(qp, "use post_srq_recv instead");
-		goto err_out;
+		rxe_dbg_qp(qp, "qp has srq, use post_srq_recv instead");
+		return -EINVAL;
 	}
 
 	spin_lock_irqsave(&rq->producer_lock, flags);
@@ -1012,12 +1044,10 @@ static int rxe_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 
 	spin_unlock_irqrestore(&rq->producer_lock, flags);
 
+	spin_lock_bh(&qp->state_lock);
 	if (qp_state(qp) == IB_QPS_ERR)
 		rxe_sched_task(&qp->resp.task);
-
-err_out:
-	if (err)
-		rxe_err_qp(qp, "returned err = %d", err);
+	spin_unlock_bh(&qp->state_lock);
 
 	return err;
 }
-- 
2.37.2

