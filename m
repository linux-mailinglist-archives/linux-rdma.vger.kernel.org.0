Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB81617A87D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCEPEh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:04:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:47946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgCEPEh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:04:37 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED2320848;
        Thu,  5 Mar 2020 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420676;
        bh=DH6fnPfUChk+Jy4Xtj5KHnoCVNYHkz2+CZk8PJRL84g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J8HawPT6HnTuwAx7XofUMjfvSoBJpE9e+BJ6eHdtgzgoNhy6GqFfJHr96OvCQF9HE
         lg3qknVa4jaP7tZIY7VzIroWBFiSYFtWok7Wj5kQQ/zAZhnIGv+N0Wy6EK72duogEk
         6xQN8RQwu8EBxpsLTYZoaMxKD4wxjWruoEfgnZjk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH rdma-core 10/11] librdmacm: Implement ECE handshake logic
Date:   Thu,  5 Mar 2020 17:03:55 +0200
Message-Id: <20200305150356.208843-11-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305150356.208843-1-leon@kernel.org>
References: <20200305150356.208843-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Perform ECE handshake through REQ/REP messages. The REQ message
initiated by active side towards passive side and carries the
ECE data. The passive side returns its decision in REP message.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 librdmacm/cma.c          | 46 ++++++++++++++++++++++++++++++++++------
 librdmacm/rdma_cma_abi.h |  1 +
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/librdmacm/cma.c b/librdmacm/cma.c
index ba8a9a57..af3c7041 100644
--- a/librdmacm/cma.c
+++ b/librdmacm/cma.c
@@ -1398,10 +1398,20 @@ static int init_ece(struct rdma_cm_id *id, struct ibv_qp *qp)
 	id_priv->local_ece.vendor_id = ece.vendor_id;
 	id_priv->local_ece.options = ece.options;

+	if (!id_priv->remote_ece.vendor_id)
+		return 0;
+
+	/* This QP was created due to REQ event */
+	ece.vendor_id = id_priv->remote_ece.vendor_id;
+	ece.options = id_priv->remote_ece.options;
+	ret = ibv_set_ece(qp, &ece);
+	if (ret)
+		return (errno == ECONNREFUSED) ? errno : 0;
+
+	id_priv->local_ece.options = ece.options;
 	return 0;
 }

-
 int rdma_create_qp_ex(struct rdma_cm_id *id,
 		      struct ibv_qp_init_attr_ex *attr)
 {
@@ -2074,8 +2084,8 @@ static int ucma_query_req_info(struct rdma_cm_id *id)
 	return 0;
 }

-static int ucma_process_conn_req(struct cma_event *evt,
-				 uint32_t handle)
+static int ucma_process_conn_req(struct cma_event *evt, uint32_t handle,
+				 struct ucma_abi_ece *ece)
 {
 	struct cma_id_private *id_priv;
 	int ret;
@@ -2095,6 +2105,8 @@ static int ucma_process_conn_req(struct cma_event *evt,
 	ucma_insert_id(id_priv);
 	id_priv->initiator_depth = evt->event.param.conn.initiator_depth;
 	id_priv->responder_resources = evt->event.param.conn.responder_resources;
+	id_priv->remote_ece.vendor_id = ece->vendor_id;
+	id_priv->remote_ece.options = ece->attr_mod;

 	if (evt->id_priv->sync) {
 		ret = rdma_migrate_id(&id_priv->id, NULL);
@@ -2143,6 +2155,26 @@ err:
 	return ret;
 }

+static int ucma_process_conn_resp_ece(struct cma_id_private *id_priv,
+				      struct ucma_abi_ece *ece)
+{
+	struct ibv_ece ibv_ece = { .vendor_id = ece->vendor_id,
+				   .options = ece->attr_mod };
+	int ret;
+
+	ret = ibv_set_ece(id_priv->id.qp, &ibv_ece);
+	if (ret && errno == EOPNOTSUPP)
+		goto out;
+
+	if (ret && errno == ECONNREFUSED)
+		/* libibverbs provider asked to reject connection */
+		return -1;
+
+	id_priv->local_ece.options = ibv_ece.options;
+out:
+	return ucma_process_conn_resp(id_priv);
+}
+
 static int ucma_process_join(struct cma_event *evt)
 {
 	evt->mc->mgid = evt->event.param.ud.ah_attr.grh.dgid;
@@ -2279,7 +2311,7 @@ retry:
 		else
 			ucma_copy_conn_event(evt, &resp.param.conn);

-		ret = ucma_process_conn_req(evt, resp.id);
+		ret = ucma_process_conn_req(evt, resp.id, &resp.ece);
 		if (ret)
 			goto retry;
 		break;
@@ -2288,8 +2320,8 @@ retry:
 		if (!evt->id_priv->id.qp) {
 			evt->event.event = RDMA_CM_EVENT_CONNECT_RESPONSE;
 		} else {
-			evt->event.status =
-				ucma_process_conn_resp(evt->id_priv);
+			evt->event.status = ucma_process_conn_resp_ece(
+				evt->id_priv, &resp.ece);
 			if (!evt->event.status)
 				evt->event.event = RDMA_CM_EVENT_ESTABLISHED;
 			else {
@@ -2639,7 +2671,7 @@ int rdma_get_remote_ece(struct rdma_cm_id *id, struct ibv_ece *ece)
 {
 	struct cma_id_private *id_priv;

-	if (id->qp || !ece)
+	if (!id || id->qp || !ece)
 		return ERR(EINVAL);

 	id_priv = container_of(id, struct cma_id_private, id);
diff --git a/librdmacm/rdma_cma_abi.h b/librdmacm/rdma_cma_abi.h
index 911863cc..f24417dd 100644
--- a/librdmacm/rdma_cma_abi.h
+++ b/librdmacm/rdma_cma_abi.h
@@ -334,6 +334,7 @@ struct ucma_abi_event_resp {
 		struct ucma_abi_conn_param conn;
 		struct ucma_abi_ud_param   ud;
 	} param;
+	struct ucma_abi_ece ece;
 };

 struct ucma_abi_set_option {
--
2.24.1

