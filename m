Return-Path: <linux-rdma+bounces-11753-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F85AED992
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B5F1775AB
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCF0257427;
	Mon, 30 Jun 2025 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apzfGpIG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C81F25A351
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278624; cv=none; b=dkZr2CnRYS8WNvTxFoj1v92KWFM3Ydqpl8xGkuvRgp8UYGRryqfebGzbUI+TxX6YU4IXNGiJ3W6Dm594GlM6xa8e1zzBpJTrq0z9Pv91Q3KiEtAXrCWGGEiYBj1o/3LjC600eX6zznYbjxlyiocmeZXX32EhXTq76KZy/C6yp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278624; c=relaxed/simple;
	bh=AnCLuERYeg2vETry5Eqjtpa0TO5qw1pSYuNDFfNeoqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfUC3VUzSJnno0beFdcGVoLbpqQ0ZUcZ8z0bRwbYZFh+Dqi641I99HDe6WmI/Am4lwbiYEWNfbLfwZjPhy1TlGzYJK/ulqZzKN0iBF50nT0zi+eUmzk7pnSrMOU2vFc3my7N3HKF0ls/qsAKjmenyZAqgL7pB2ZUjl3ZL0TQTEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apzfGpIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AA9C4CEEB;
	Mon, 30 Jun 2025 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751278624;
	bh=AnCLuERYeg2vETry5Eqjtpa0TO5qw1pSYuNDFfNeoqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=apzfGpIGuThMi1Gk0q4xJfBMY6Qg0ffDrHyF3NffW3LMeEyZPLKUeOWZLGKxTCHgS
	 LY2fMVSc6q+M6RjnSB6AKVVxzRKPm+EJJuqD15L+mvM2YInr/hNsZb+y5qWSWbyTYv
	 +m37/PNFH58nVk+TZZl5oX1VcKz/sYR7Jnjk6GbFIK78PYQuJvrnJeogferpaguFlT
	 ovCyxINtKoaa5HGPiFVhjuCXm+Q5RL75af27voQumKN4oitHTjYSYpKWcfHwUoQLQE
	 +6d/lDhzRCsew4/bH3HBhDxGJ5is6WfVT0fe5x1G+tzzAepljfWMzKxCy3BTKEsZt/
	 si6dR+gJpuIbA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next v2 3/3] IB/cm: Use separate agent w/o flow control for REP
Date: Mon, 30 Jun 2025 13:16:44 +0300
Message-ID: <9ac12d0842b849e2c8537d6e291ee0af9f79855c.1751278420.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751278420.git.leon@kernel.org>
References: <cover.1751278420.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

Most responses (e.g., RTU) are not subject to flow control, as there is
no further response expected.  However, REPs are both requests (waiting
for RTUs) and responses (being waited by REQs).

With agent-level flow control added to the MAD layer, REPs can get
delayed by outstanding REQs.  This can cause a problem in a scenario
such as 2 hosts connecting to each other at the same time.  Both hosts
fill the flow control outstanding slots with REQs.  The corresponding
REPs are now blocked behind those REQs, and neither side can make
progress until REQs time out.

Add a separate MAD agent which is only used to send REPs.  This agent
does not have a recv_handler as it doesn't process responses nor does it
register to receive requests.  Disable flow control for agents w/o a
recv_handler, as they aren't waiting for responses.  This allows the
newly added REP agent to send even when clients are slow to generate
RTU, which would be needed to unblock flow control outstanding slots.

Relax check in ib_post_send_mad to allow retries for this agent.  REPs
will be retried by the MAD layer until CM layer receives a response
(e.g., RTU) on the normal agent and cancels them.

Suggested-by: Sean Hefty <shefty@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c  | 47 ++++++++++++++++++++++++++++++-----
 drivers/infiniband/core/mad.c |  7 +++---
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 8670e58675c6..92678e438ff4 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -161,6 +161,7 @@ struct cm_counter_attribute {
 struct cm_port {
 	struct cm_device *cm_dev;
 	struct ib_mad_agent *mad_agent;
+	struct ib_mad_agent *rep_agent;
 	u32 port_num;
 	atomic_long_t counters[CM_COUNTER_GROUPS][CM_ATTR_COUNT];
 };
@@ -274,7 +275,8 @@ static inline void cm_deref_id(struct cm_id_private *cm_id_priv)
 		complete(&cm_id_priv->comp);
 }
 
-static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
+static struct ib_mad_send_buf *
+cm_alloc_msg_agent(struct cm_id_private *cm_id_priv, bool rep_agent)
 {
 	struct ib_mad_agent *mad_agent;
 	struct ib_mad_send_buf *m;
@@ -286,7 +288,8 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 		return ERR_PTR(-EINVAL);
 
 	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
-	mad_agent = cm_id_priv->av.port->mad_agent;
+	mad_agent = rep_agent ? cm_id_priv->av.port->rep_agent :
+				cm_id_priv->av.port->mad_agent;
 	if (!mad_agent) {
 		m = ERR_PTR(-EINVAL);
 		goto out;
@@ -315,6 +318,11 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	return m;
 }
 
+static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
+{
+	return cm_alloc_msg_agent(cm_id_priv, false);
+}
+
 static void cm_free_msg(struct ib_mad_send_buf *msg)
 {
 	if (msg->ah)
@@ -323,13 +331,14 @@ static void cm_free_msg(struct ib_mad_send_buf *msg)
 }
 
 static struct ib_mad_send_buf *
-cm_alloc_priv_msg(struct cm_id_private *cm_id_priv, enum ib_cm_state state)
+cm_alloc_priv_msg_rep(struct cm_id_private *cm_id_priv, enum ib_cm_state state,
+		      bool rep_agent)
 {
 	struct ib_mad_send_buf *msg;
 
 	lockdep_assert_held(&cm_id_priv->lock);
 
-	msg = cm_alloc_msg(cm_id_priv);
+	msg = cm_alloc_msg_agent(cm_id_priv, rep_agent);
 	if (IS_ERR(msg))
 		return msg;
 
@@ -344,6 +353,12 @@ cm_alloc_priv_msg(struct cm_id_private *cm_id_priv, enum ib_cm_state state)
 	return msg;
 }
 
+static struct ib_mad_send_buf *
+cm_alloc_priv_msg(struct cm_id_private *cm_id_priv, enum ib_cm_state state)
+{
+	return cm_alloc_priv_msg_rep(cm_id_priv, state, false);
+}
+
 static void cm_free_priv_msg(struct ib_mad_send_buf *msg)
 {
 	struct cm_id_private *cm_id_priv = msg->context[0];
@@ -2295,7 +2310,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 		goto out;
 	}
 
-	msg = cm_alloc_priv_msg(cm_id_priv, IB_CM_REP_SENT);
+	msg = cm_alloc_priv_msg_rep(cm_id_priv, IB_CM_REP_SENT, true);
 	if (IS_ERR(msg)) {
 		ret = PTR_ERR(msg);
 		goto out;
@@ -4380,9 +4395,22 @@ static int cm_add_one(struct ib_device *ib_device)
 			goto error2;
 		}
 
+		port->rep_agent = ib_register_mad_agent(ib_device, i,
+							IB_QPT_GSI,
+							NULL,
+							0,
+							cm_send_handler,
+							NULL,
+							port,
+							0);
+		if (IS_ERR(port->rep_agent)) {
+			ret = PTR_ERR(port->rep_agent);
+			goto error3;
+		}
+
 		ret = ib_modify_port(ib_device, i, 0, &port_modify);
 		if (ret)
-			goto error3;
+			goto error4;
 
 		count++;
 	}
@@ -4397,6 +4425,8 @@ static int cm_add_one(struct ib_device *ib_device)
 	write_unlock_irqrestore(&cm.device_lock, flags);
 	return 0;
 
+error4:
+	ib_unregister_mad_agent(port->rep_agent);
 error3:
 	ib_unregister_mad_agent(port->mad_agent);
 error2:
@@ -4410,6 +4440,7 @@ static int cm_add_one(struct ib_device *ib_device)
 
 		port = cm_dev->port[i-1];
 		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
+		ib_unregister_mad_agent(port->rep_agent);
 		ib_unregister_mad_agent(port->mad_agent);
 		ib_port_unregister_client_groups(ib_device, i,
 						 cm_counter_groups);
@@ -4439,12 +4470,14 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 
 	rdma_for_each_port (ib_device, i) {
 		struct ib_mad_agent *mad_agent;
+		struct ib_mad_agent *rep_agent;
 
 		if (!rdma_cap_ib_cm(ib_device, i))
 			continue;
 
 		port = cm_dev->port[i-1];
 		mad_agent = port->mad_agent;
+		rep_agent = port->rep_agent;
 		ib_modify_port(ib_device, port->port_num, 0, &port_modify);
 		/*
 		 * We flush the queue here after the going_down set, this
@@ -4458,8 +4491,10 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 		 */
 		write_lock(&cm_dev->mad_agent_lock);
 		port->mad_agent = NULL;
+		port->rep_agent = NULL;
 		write_unlock(&cm_dev->mad_agent_lock);
 		ib_unregister_mad_agent(mad_agent);
+		ib_unregister_mad_agent(rep_agent);
 		ib_port_unregister_client_groups(ib_device, i,
 						 cm_counter_groups);
 	}
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 183667038cf2..8f26bfb69586 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -424,7 +424,8 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 	mad_agent_priv->sol_fc_send_count = 0;
 	mad_agent_priv->sol_fc_wait_count = 0;
 	mad_agent_priv->sol_fc_max =
-		get_sol_fc_max_outstanding(mad_reg_req);
+		recv_handler ? get_sol_fc_max_outstanding(mad_reg_req) : 0;
+
 	ret2 = ib_mad_agent_security_setup(&mad_agent_priv->agent, qp_type);
 	if (ret2) {
 		ret = ERR_PTR(ret2);
@@ -1280,9 +1281,7 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		if (ret)
 			goto error;
 
-		if (!send_buf->mad_agent->send_handler ||
-		    (send_buf->timeout_ms &&
-		     !send_buf->mad_agent->recv_handler)) {
+		if (!send_buf->mad_agent->send_handler) {
 			ret = -EINVAL;
 			goto error;
 		}
-- 
2.50.0


