Return-Path: <linux-rdma+bounces-13844-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B90BD41EF
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5534718833A9
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A4E3101AD;
	Mon, 13 Oct 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cJm9F7+9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860830F948;
	Mon, 13 Oct 2025 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368004; cv=none; b=dXWxfwkbCSrX0zHw6XpziLwEC2HM7UkQqVWb2RLCp0yPECoKEPMvsoCvhQBb71Fnf0iKcDAuPFP/qhMNMQXMR/o7dFYzO3xnFoD4UYagVWq51CCxvQ/3Xl9TVrGa4Qwb337QBPegpNgAeHtL6lgTP+/Z/RxXLEwVuvkI7FcAl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368004; c=relaxed/simple;
	bh=fLiQFp8kMzuRKwFJFhBrFl72OV+6K1KagPxF/0HHwFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkDM5Ihc3FMPi9hb+MrPyP4lxMS9WKQwSzsyR/5g9YC+MyGT+flERhQhWqxKwmDuW+/e+CbWUkCP4/RS/oU/jFyniPmUYSEJZCrdxDICWcPp/3pAlTVEiU7gdkjj/NwTqEZOMQfYespKbyfV481b8rMlhmWxLpu3FcHFLPDaGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cJm9F7+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FEAC4CEE7;
	Mon, 13 Oct 2025 15:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368004;
	bh=fLiQFp8kMzuRKwFJFhBrFl72OV+6K1KagPxF/0HHwFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cJm9F7+9qCJ7cqP5IPpDlFTYY+qRij01nx7aa/pgWwrM8REPi8qTtHv/DtezSicYw
	 DaWgUcVFWKyS/qHFsYaYpGuZAjomm8Sf7eyMRpowLTCRGXyvhffzMdyy/K501gMBtg
	 fs7hLNyNUefjzUE8KqIUcob2QA47B/l2cjK5Wz4w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-rdma@vger.kernel.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 011/262] smb: server: fix IRD/ORD negotiation with the client
Date: Mon, 13 Oct 2025 16:42:33 +0200
Message-ID: <20251013144326.533723133@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit fad988a2158d743da7971884b93482a73735b25e ]

Already do real negotiation in smb_direct_handle_connect_request()
where we see the requested initiator_depth and responder_resources
from the client.

We should detect legacy iwarp clients using MPA v1
with the custom IRD/ORD negotiation.

We need to send the custom IRD/ORD in big endian,
but we need to try to let clients with broken requests
using little endian (older cifs.ko) to work.

Note the reason why this uses u8 for
initiator_depth and responder_resources is
that the rdma layer also uses it.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: linux-rdma@vger.kernel.org
Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/transport_rdma.c | 99 +++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 14 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index d059c890d1428..05dfef7ad67f5 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -152,6 +152,10 @@ struct smb_direct_transport {
 	struct work_struct	disconnect_work;
 
 	bool			negotiation_requested;
+
+	bool			legacy_iwarp;
+	u8			initiator_depth;
+	u8			responder_resources;
 };
 
 #define KSMBD_TRANS(t) ((struct ksmbd_transport *)&((t)->transport))
@@ -346,6 +350,9 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	t->cm_id = cm_id;
 	cm_id->context = t;
 
+	t->initiator_depth = SMB_DIRECT_CM_INITIATOR_DEPTH;
+	t->responder_resources = 1;
+
 	t->status = SMB_DIRECT_CS_NEW;
 	init_waitqueue_head(&t->wait_status);
 
@@ -1623,21 +1630,21 @@ static int smb_direct_send_negotiate_response(struct smb_direct_transport *t,
 static int smb_direct_accept_client(struct smb_direct_transport *t)
 {
 	struct rdma_conn_param conn_param;
-	struct ib_port_immutable port_immutable;
-	u32 ird_ord_hdr[2];
+	__be32 ird_ord_hdr[2];
 	int ret;
 
+	/*
+	 * smb_direct_handle_connect_request()
+	 * already negotiated t->initiator_depth
+	 * and t->responder_resources
+	 */
 	memset(&conn_param, 0, sizeof(conn_param));
-	conn_param.initiator_depth = min_t(u8, t->cm_id->device->attrs.max_qp_rd_atom,
-					   SMB_DIRECT_CM_INITIATOR_DEPTH);
-	conn_param.responder_resources = 0;
-
-	t->cm_id->device->ops.get_port_immutable(t->cm_id->device,
-						 t->cm_id->port_num,
-						 &port_immutable);
-	if (port_immutable.core_cap_flags & RDMA_CORE_PORT_IWARP) {
-		ird_ord_hdr[0] = conn_param.responder_resources;
-		ird_ord_hdr[1] = 1;
+	conn_param.initiator_depth = t->initiator_depth;
+	conn_param.responder_resources = t->responder_resources;
+
+	if (t->legacy_iwarp) {
+		ird_ord_hdr[0] = cpu_to_be32(conn_param.responder_resources);
+		ird_ord_hdr[1] = cpu_to_be32(conn_param.initiator_depth);
 		conn_param.private_data = ird_ord_hdr;
 		conn_param.private_data_len = sizeof(ird_ord_hdr);
 	} else {
@@ -2023,10 +2030,13 @@ static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
 	return true;
 }
 
-static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
+static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id,
+					     struct rdma_cm_event *event)
 {
 	struct smb_direct_transport *t;
 	struct task_struct *handler;
+	u8 peer_initiator_depth;
+	u8 peer_responder_resources;
 	int ret;
 
 	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
@@ -2040,6 +2050,67 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 	if (!t)
 		return -ENOMEM;
 
+	peer_initiator_depth = event->param.conn.initiator_depth;
+	peer_responder_resources = event->param.conn.responder_resources;
+	if (rdma_protocol_iwarp(new_cm_id->device, new_cm_id->port_num) &&
+	    event->param.conn.private_data_len == 8) {
+		/*
+		 * Legacy clients with only iWarp MPA v1 support
+		 * need a private blob in order to negotiate
+		 * the IRD/ORD values.
+		 */
+		const __be32 *ird_ord_hdr = event->param.conn.private_data;
+		u32 ird32 = be32_to_cpu(ird_ord_hdr[0]);
+		u32 ord32 = be32_to_cpu(ird_ord_hdr[1]);
+
+		/*
+		 * cifs.ko sends the legacy IRD/ORD negotiation
+		 * event if iWarp MPA v2 was used.
+		 *
+		 * Here we check that the values match and only
+		 * mark the client as legacy if they don't match.
+		 */
+		if ((u32)event->param.conn.initiator_depth != ird32 ||
+		    (u32)event->param.conn.responder_resources != ord32) {
+			/*
+			 * There are broken clients (old cifs.ko)
+			 * using little endian and also
+			 * struct rdma_conn_param only uses u8
+			 * for initiator_depth and responder_resources,
+			 * so we truncate the value to U8_MAX.
+			 *
+			 * smb_direct_accept_client() will then
+			 * do the real negotiation in order to
+			 * select the minimum between client and
+			 * server.
+			 */
+			ird32 = min_t(u32, ird32, U8_MAX);
+			ord32 = min_t(u32, ord32, U8_MAX);
+
+			t->legacy_iwarp = true;
+			peer_initiator_depth = (u8)ird32;
+			peer_responder_resources = (u8)ord32;
+		}
+	}
+
+	/*
+	 * First set what the we as server are able to support
+	 */
+	t->initiator_depth = min_t(u8, t->initiator_depth,
+				   new_cm_id->device->attrs.max_qp_rd_atom);
+
+	/*
+	 * negotiate the value by using the minimum
+	 * between client and server if the client provided
+	 * non 0 values.
+	 */
+	if (peer_initiator_depth != 0)
+		t->initiator_depth = min_t(u8, t->initiator_depth,
+					   peer_initiator_depth);
+	if (peer_responder_resources != 0)
+		t->responder_resources = min_t(u8, t->responder_resources,
+					       peer_responder_resources);
+
 	ret = smb_direct_connect(t);
 	if (ret)
 		goto out_err;
@@ -2064,7 +2135,7 @@ static int smb_direct_listen_handler(struct rdma_cm_id *cm_id,
 {
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST: {
-		int ret = smb_direct_handle_connect_request(cm_id);
+		int ret = smb_direct_handle_connect_request(cm_id, event);
 
 		if (ret) {
 			pr_err("Can't create transport: %d\n", ret);
-- 
2.51.0




