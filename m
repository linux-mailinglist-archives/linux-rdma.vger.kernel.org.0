Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03601A66E8
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 15:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgDMNYP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 09:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729811AbgDMNYO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 09:24:14 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9058720692;
        Mon, 13 Apr 2020 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586784253;
        bh=g/VgAtWRW6SufyaTepln+mJZKoRKXlppQdV7qdcnLMw=;
        h=From:To:Cc:Subject:Date:From;
        b=HZG+JPbmEf+VwfcGQoYF4fo7PT8D+d2a7XOpoFpBMw8j9GlPB/MbBHj7maRI7wuk2
         mulvRGyKK2okePlerhRSOUNsX6N3Tug+CJUP88chOqM/Wc525ZTtiooEnaEPi9pnQh
         D3buaS3sj71wDzv9tHPX35V4+1bc+QNH8n1nfvZs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] RDMA/mad: Remove snoop interface
Date:   Mon, 13 Apr 2020 16:24:08 +0300
Message-Id: <20200413132408.931084-1-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Snoop interface is not used. Remove it.

Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/mad.c | 238 +---------------------------------
 include/rdma/ib_mad.h         |  49 +------
 2 files changed, 6 insertions(+), 281 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index c54db13fa9b0..e02b5c4fdf09 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -85,7 +85,6 @@ MODULE_PARM_DESC(send_queue_size, "Size of send queue in number of work requests
 module_param_named(recv_queue_size, mad_recvq_size, int, 0444);
 MODULE_PARM_DESC(recv_queue_size, "Size of receive queue in number of work requests");
 
-/* Client ID 0 is used for snoop-only clients */
 static DEFINE_XARRAY_ALLOC1(ib_mad_clients);
 static u32 ib_mad_client_next;
 static struct list_head ib_mad_port_list;
@@ -483,141 +482,12 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 }
 EXPORT_SYMBOL(ib_register_mad_agent);
 
-static inline int is_snooping_sends(int mad_snoop_flags)
-{
-	return (mad_snoop_flags &
-		(/*IB_MAD_SNOOP_POSTED_SENDS |
-		 IB_MAD_SNOOP_RMPP_SENDS |*/
-		 IB_MAD_SNOOP_SEND_COMPLETIONS /*|
-		 IB_MAD_SNOOP_RMPP_SEND_COMPLETIONS*/));
-}
-
-static inline int is_snooping_recvs(int mad_snoop_flags)
-{
-	return (mad_snoop_flags &
-		(IB_MAD_SNOOP_RECVS /*|
-		 IB_MAD_SNOOP_RMPP_RECVS*/));
-}
-
-static int register_snoop_agent(struct ib_mad_qp_info *qp_info,
-				struct ib_mad_snoop_private *mad_snoop_priv)
-{
-	struct ib_mad_snoop_private **new_snoop_table;
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&qp_info->snoop_lock, flags);
-	/* Check for empty slot in array. */
-	for (i = 0; i < qp_info->snoop_table_size; i++)
-		if (!qp_info->snoop_table[i])
-			break;
-
-	if (i == qp_info->snoop_table_size) {
-		/* Grow table. */
-		new_snoop_table = krealloc(qp_info->snoop_table,
-					   sizeof mad_snoop_priv *
-					   (qp_info->snoop_table_size + 1),
-					   GFP_ATOMIC);
-		if (!new_snoop_table) {
-			i = -ENOMEM;
-			goto out;
-		}
-
-		qp_info->snoop_table = new_snoop_table;
-		qp_info->snoop_table_size++;
-	}
-	qp_info->snoop_table[i] = mad_snoop_priv;
-	atomic_inc(&qp_info->snoop_count);
-out:
-	spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
-	return i;
-}
-
-struct ib_mad_agent *ib_register_mad_snoop(struct ib_device *device,
-					   u8 port_num,
-					   enum ib_qp_type qp_type,
-					   int mad_snoop_flags,
-					   ib_mad_snoop_handler snoop_handler,
-					   ib_mad_recv_handler recv_handler,
-					   void *context)
-{
-	struct ib_mad_port_private *port_priv;
-	struct ib_mad_agent *ret;
-	struct ib_mad_snoop_private *mad_snoop_priv;
-	int qpn;
-	int err;
-
-	/* Validate parameters */
-	if ((is_snooping_sends(mad_snoop_flags) && !snoop_handler) ||
-	    (is_snooping_recvs(mad_snoop_flags) && !recv_handler)) {
-		ret = ERR_PTR(-EINVAL);
-		goto error1;
-	}
-	qpn = get_spl_qp_index(qp_type);
-	if (qpn == -1) {
-		ret = ERR_PTR(-EINVAL);
-		goto error1;
-	}
-	port_priv = ib_get_mad_port(device, port_num);
-	if (!port_priv) {
-		ret = ERR_PTR(-ENODEV);
-		goto error1;
-	}
-	/* Allocate structures */
-	mad_snoop_priv = kzalloc(sizeof *mad_snoop_priv, GFP_KERNEL);
-	if (!mad_snoop_priv) {
-		ret = ERR_PTR(-ENOMEM);
-		goto error1;
-	}
-
-	/* Now, fill in the various structures */
-	mad_snoop_priv->qp_info = &port_priv->qp_info[qpn];
-	mad_snoop_priv->agent.device = device;
-	mad_snoop_priv->agent.recv_handler = recv_handler;
-	mad_snoop_priv->agent.snoop_handler = snoop_handler;
-	mad_snoop_priv->agent.context = context;
-	mad_snoop_priv->agent.qp = port_priv->qp_info[qpn].qp;
-	mad_snoop_priv->agent.port_num = port_num;
-	mad_snoop_priv->mad_snoop_flags = mad_snoop_flags;
-	init_completion(&mad_snoop_priv->comp);
-
-	err = ib_mad_agent_security_setup(&mad_snoop_priv->agent, qp_type);
-	if (err) {
-		ret = ERR_PTR(err);
-		goto error2;
-	}
-
-	mad_snoop_priv->snoop_index = register_snoop_agent(
-						&port_priv->qp_info[qpn],
-						mad_snoop_priv);
-	if (mad_snoop_priv->snoop_index < 0) {
-		ret = ERR_PTR(mad_snoop_priv->snoop_index);
-		goto error3;
-	}
-
-	atomic_set(&mad_snoop_priv->refcount, 1);
-	return &mad_snoop_priv->agent;
-error3:
-	ib_mad_agent_security_cleanup(&mad_snoop_priv->agent);
-error2:
-	kfree(mad_snoop_priv);
-error1:
-	return ret;
-}
-EXPORT_SYMBOL(ib_register_mad_snoop);
-
 static inline void deref_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 {
 	if (atomic_dec_and_test(&mad_agent_priv->refcount))
 		complete(&mad_agent_priv->comp);
 }
 
-static inline void deref_snoop_agent(struct ib_mad_snoop_private *mad_snoop_priv)
-{
-	if (atomic_dec_and_test(&mad_snoop_priv->refcount))
-		complete(&mad_snoop_priv->comp);
-}
-
 static void unregister_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 {
 	struct ib_mad_port_private *port_priv;
@@ -650,25 +520,6 @@ static void unregister_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 	kfree_rcu(mad_agent_priv, rcu);
 }
 
-static void unregister_mad_snoop(struct ib_mad_snoop_private *mad_snoop_priv)
-{
-	struct ib_mad_qp_info *qp_info;
-	unsigned long flags;
-
-	qp_info = mad_snoop_priv->qp_info;
-	spin_lock_irqsave(&qp_info->snoop_lock, flags);
-	qp_info->snoop_table[mad_snoop_priv->snoop_index] = NULL;
-	atomic_dec(&qp_info->snoop_count);
-	spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
-
-	deref_snoop_agent(mad_snoop_priv);
-	wait_for_completion(&mad_snoop_priv->comp);
-
-	ib_mad_agent_security_cleanup(&mad_snoop_priv->agent);
-
-	kfree(mad_snoop_priv);
-}
-
 /*
  * ib_unregister_mad_agent - Unregisters a client from using MAD services
  *
@@ -677,20 +528,11 @@ static void unregister_mad_snoop(struct ib_mad_snoop_private *mad_snoop_priv)
 void ib_unregister_mad_agent(struct ib_mad_agent *mad_agent)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
-	struct ib_mad_snoop_private *mad_snoop_priv;
-
-	/* If the TID is zero, the agent can only snoop. */
-	if (mad_agent->hi_tid) {
-		mad_agent_priv = container_of(mad_agent,
-					      struct ib_mad_agent_private,
-					      agent);
-		unregister_mad_agent(mad_agent_priv);
-	} else {
-		mad_snoop_priv = container_of(mad_agent,
-					      struct ib_mad_snoop_private,
-					      agent);
-		unregister_mad_snoop(mad_snoop_priv);
-	}
+
+	mad_agent_priv = container_of(mad_agent,
+				      struct ib_mad_agent_private,
+				      agent);
+	unregister_mad_agent(mad_agent_priv);
 }
 EXPORT_SYMBOL(ib_unregister_mad_agent);
 
@@ -706,57 +548,6 @@ static void dequeue_mad(struct ib_mad_list_head *mad_list)
 	spin_unlock_irqrestore(&mad_queue->lock, flags);
 }
 
-static void snoop_send(struct ib_mad_qp_info *qp_info,
-		       struct ib_mad_send_buf *send_buf,
-		       struct ib_mad_send_wc *mad_send_wc,
-		       int mad_snoop_flags)
-{
-	struct ib_mad_snoop_private *mad_snoop_priv;
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&qp_info->snoop_lock, flags);
-	for (i = 0; i < qp_info->snoop_table_size; i++) {
-		mad_snoop_priv = qp_info->snoop_table[i];
-		if (!mad_snoop_priv ||
-		    !(mad_snoop_priv->mad_snoop_flags & mad_snoop_flags))
-			continue;
-
-		atomic_inc(&mad_snoop_priv->refcount);
-		spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
-		mad_snoop_priv->agent.snoop_handler(&mad_snoop_priv->agent,
-						    send_buf, mad_send_wc);
-		deref_snoop_agent(mad_snoop_priv);
-		spin_lock_irqsave(&qp_info->snoop_lock, flags);
-	}
-	spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
-}
-
-static void snoop_recv(struct ib_mad_qp_info *qp_info,
-		       struct ib_mad_recv_wc *mad_recv_wc,
-		       int mad_snoop_flags)
-{
-	struct ib_mad_snoop_private *mad_snoop_priv;
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&qp_info->snoop_lock, flags);
-	for (i = 0; i < qp_info->snoop_table_size; i++) {
-		mad_snoop_priv = qp_info->snoop_table[i];
-		if (!mad_snoop_priv ||
-		    !(mad_snoop_priv->mad_snoop_flags & mad_snoop_flags))
-			continue;
-
-		atomic_inc(&mad_snoop_priv->refcount);
-		spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
-		mad_snoop_priv->agent.recv_handler(&mad_snoop_priv->agent, NULL,
-						   mad_recv_wc);
-		deref_snoop_agent(mad_snoop_priv);
-		spin_lock_irqsave(&qp_info->snoop_lock, flags);
-	}
-	spin_unlock_irqrestore(&qp_info->snoop_lock, flags);
-}
-
 static void build_smp_wc(struct ib_qp *qp, struct ib_cqe *cqe, u16 slid,
 		u16 pkey_index, u8 port_num, struct ib_wc *wc)
 {
@@ -2289,9 +2080,6 @@ static void ib_mad_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	recv->header.recv_wc.recv_buf.mad = (struct ib_mad *)recv->mad;
 	recv->header.recv_wc.recv_buf.grh = &recv->grh;
 
-	if (atomic_read(&qp_info->snoop_count))
-		snoop_recv(qp_info, &recv->header.recv_wc, IB_MAD_SNOOP_RECVS);
-
 	/* Validate MAD */
 	if (!validate_mad((const struct ib_mad_hdr *)recv->mad, qp_info, opa))
 		goto out;
@@ -2538,9 +2326,6 @@ static void ib_mad_send_done(struct ib_cq *cq, struct ib_wc *wc)
 	mad_send_wc.send_buf = &mad_send_wr->send_buf;
 	mad_send_wc.status = wc->status;
 	mad_send_wc.vendor_err = wc->vendor_err;
-	if (atomic_read(&qp_info->snoop_count))
-		snoop_send(qp_info, &mad_send_wr->send_buf, &mad_send_wc,
-			   IB_MAD_SNOOP_SEND_COMPLETIONS);
 	ib_mad_complete_send_wr(mad_send_wr, &mad_send_wc);
 
 	if (queued_send_wr) {
@@ -2782,10 +2567,6 @@ static void local_completions(struct work_struct *work)
 			local->mad_priv->header.recv_wc.recv_buf.grh = NULL;
 			local->mad_priv->header.recv_wc.recv_buf.mad =
 						(struct ib_mad *)local->mad_priv->mad;
-			if (atomic_read(&recv_mad_agent->qp_info->snoop_count))
-				snoop_recv(recv_mad_agent->qp_info,
-					  &local->mad_priv->header.recv_wc,
-					   IB_MAD_SNOOP_RECVS);
 			recv_mad_agent->agent.recv_handler(
 						&recv_mad_agent->agent,
 						&local->mad_send_wr->send_buf,
@@ -2800,10 +2581,6 @@ static void local_completions(struct work_struct *work)
 		mad_send_wc.status = IB_WC_SUCCESS;
 		mad_send_wc.vendor_err = 0;
 		mad_send_wc.send_buf = &local->mad_send_wr->send_buf;
-		if (atomic_read(&mad_agent_priv->qp_info->snoop_count))
-			snoop_send(mad_agent_priv->qp_info,
-				   &local->mad_send_wr->send_buf,
-				   &mad_send_wc, IB_MAD_SNOOP_SEND_COMPLETIONS);
 		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
 						   &mad_send_wc);
 
@@ -3119,10 +2896,6 @@ static void init_mad_qp(struct ib_mad_port_private *port_priv,
 	init_mad_queue(qp_info, &qp_info->send_queue);
 	init_mad_queue(qp_info, &qp_info->recv_queue);
 	INIT_LIST_HEAD(&qp_info->overflow_list);
-	spin_lock_init(&qp_info->snoop_lock);
-	qp_info->snoop_table = NULL;
-	qp_info->snoop_table_size = 0;
-	atomic_set(&qp_info->snoop_count, 0);
 }
 
 static int create_mad_qp(struct ib_mad_qp_info *qp_info,
@@ -3166,7 +2939,6 @@ static void destroy_mad_qp(struct ib_mad_qp_info *qp_info)
 		return;
 
 	ib_destroy_qp(qp_info->qp);
-	kfree(qp_info->snoop_table);
 }
 
 /*
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index 4e62650e2127..8c093fc1bb9f 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -558,20 +558,6 @@ struct ib_mad_recv_wc;
 typedef void (*ib_mad_send_handler)(struct ib_mad_agent *mad_agent,
 				    struct ib_mad_send_wc *mad_send_wc);
 
-/**
- * ib_mad_snoop_handler - Callback handler for snooping sent MADs.
- * @mad_agent: MAD agent that snooped the MAD.
- * @send_buf: send MAD data buffer.
- * @mad_send_wc: Work completion information on the sent MAD.  Valid
- *   only for snooping that occurs on a send completion.
- *
- * Clients snooping MADs should not modify data referenced by the @send_buf
- * or @mad_send_wc.
- */
-typedef void (*ib_mad_snoop_handler)(struct ib_mad_agent *mad_agent,
-				     struct ib_mad_send_buf *send_buf,
-				     struct ib_mad_send_wc *mad_send_wc);
-
 /**
  * ib_mad_recv_handler - callback handler for a received MAD.
  * @mad_agent: MAD agent requesting the received MAD.
@@ -581,8 +567,7 @@ typedef void (*ib_mad_snoop_handler)(struct ib_mad_agent *mad_agent,
  * MADs received in response to a send request operation will be handed to
  * the user before the send operation completes.  All data buffers given
  * to registered agents through this routine are owned by the receiving
- * client, except for snooping agents.  Clients snooping MADs should not
- * modify the data referenced by @mad_recv_wc.
+ * client.
  */
 typedef void (*ib_mad_recv_handler)(struct ib_mad_agent *mad_agent,
 				    struct ib_mad_send_buf *send_buf,
@@ -595,7 +580,6 @@ typedef void (*ib_mad_recv_handler)(struct ib_mad_agent *mad_agent,
  * @mr: Memory region for system memory usable for DMA.
  * @recv_handler: Callback handler for a received MAD.
  * @send_handler: Callback handler for a sent MAD.
- * @snoop_handler: Callback handler for snooped sent MADs.
  * @context: User-specified context associated with this registration.
  * @hi_tid: Access layer assigned transaction ID for this client.
  *   Unsolicited MADs sent by this client will have the upper 32-bits
@@ -612,7 +596,6 @@ struct ib_mad_agent {
 	struct ib_qp		*qp;
 	ib_mad_recv_handler	recv_handler;
 	ib_mad_send_handler	send_handler;
-	ib_mad_snoop_handler	snoop_handler;
 	void			*context;
 	u32			hi_tid;
 	u32			flags;
@@ -720,36 +703,6 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 					   ib_mad_recv_handler recv_handler,
 					   void *context,
 					   u32 registration_flags);
-
-enum ib_mad_snoop_flags {
-	/*IB_MAD_SNOOP_POSTED_SENDS	   = 1,*/
-	/*IB_MAD_SNOOP_RMPP_SENDS	   = (1<<1),*/
-	IB_MAD_SNOOP_SEND_COMPLETIONS	   = (1<<2),
-	/*IB_MAD_SNOOP_RMPP_SEND_COMPLETIONS = (1<<3),*/
-	IB_MAD_SNOOP_RECVS		   = (1<<4)
-	/*IB_MAD_SNOOP_RMPP_RECVS	   = (1<<5),*/
-	/*IB_MAD_SNOOP_REDIRECTED_QPS	   = (1<<6)*/
-};
-
-/**
- * ib_register_mad_snoop - Register to snoop sent and received MADs.
- * @device: The device to register with.
- * @port_num: The port on the specified device to use.
- * @qp_type: Specifies which QP traffic to snoop.  Must be either
- *   IB_QPT_SMI or IB_QPT_GSI.
- * @mad_snoop_flags: Specifies information where snooping occurs.
- * @send_handler: The callback routine invoked for a snooped send.
- * @recv_handler: The callback routine invoked for a snooped receive.
- * @context: User specified context associated with the registration.
- */
-struct ib_mad_agent *ib_register_mad_snoop(struct ib_device *device,
-					   u8 port_num,
-					   enum ib_qp_type qp_type,
-					   int mad_snoop_flags,
-					   ib_mad_snoop_handler snoop_handler,
-					   ib_mad_recv_handler recv_handler,
-					   void *context);
-
 /**
  * ib_unregister_mad_agent - Unregisters a client from using MAD services.
  * @mad_agent: Corresponding MAD registration request to deregister.
-- 
2.25.2

