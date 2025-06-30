Return-Path: <linux-rdma+bounces-11760-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB6AEDA4B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA9E3B22DC
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83A246766;
	Mon, 30 Jun 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhl5Vfsi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B12884A2B
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280778; cv=none; b=oHQnS9c79S2EZyGxQYOsBNKbnHxVKhQpKfZQH8KaVQgX9DWemU7U/viQGjZbRPZz+2PmasznONItqGSbQjj4Q+N7wX5EiE9sovJJfUo+EMum4V9WYt0tMddTYokCf+h1uwVKBbgLmhFST4yjCc0IJUxYLburuBlnE632HQX2BA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280778; c=relaxed/simple;
	bh=8lONfLY7XhWyXjxZJfQ6w+rmtSlSoWHnj6Iyz+rQ5Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw4y3lt92MOgYR3J4zIOMdHP0u6xJnoR+f3fxwCWPs/qOjhKX4agNIkOPZcP23tmJcSNh/w6MWp33Ds2JondtBAPKU3uEDCQqiz9+bSqw2t7zCF2xyoFAP0lJF2sTKLwFDYtBNK0QRnBGuGUQUArSIDtf6QwF5dAS7H2HRkrcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhl5Vfsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E38AC4CEE3;
	Mon, 30 Jun 2025 10:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751280778;
	bh=8lONfLY7XhWyXjxZJfQ6w+rmtSlSoWHnj6Iyz+rQ5Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yhl5VfsiMOEOPPyqRV0179yfMbXQEYpdf0BqB96jamBxQWRl9QbxeKlbdYUtEstU+
	 vUkzVHqRe041jJB6McyYts8gV33WBG8yllgulC/xXlYh2sW/EUz7NLYFjPHCNT51iw
	 DhJ67sJkw4K1ChcyIFSiXSQZoFwTnWZkb9EpfGCP5A3U+/pE+0HHkNPkx1EIvPdOcP
	 YtqBgpS1w+6oNHnZZogsop0s0YcPTZ7R9MUgkDEobWbjfCcz+KLO9GIoXchabWOTQq
	 SoKxQv3UFcXRVUlXgDavn37NZl+hPAIGFaL3rkCi7vd5KLZmmJvC7Qj04EhmYdIGik
	 u9b+6/GGNVLfA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next 5/5] RDMA/ucma: Support write an event into a CM
Date: Mon, 30 Jun 2025 13:52:35 +0300
Message-ID: <fdf49d0b17a45933c5d8c1d90605c9447d9a3c73.1751279794.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751279793.git.leonro@nvidia.com>
References: <cover.1751279793.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Enable user-space to inject an event into a CM through it's event
channel. Two new events are added and supported: RDMA_CM_EVENT_USER and
RDMA_CM_EVENT_INTERNAL. With these 2 events a new event parameter "arg"
is supported, which is passed from sender to receiver transparently.

With this feature an application is able to write an event into a CM
channel with a new user-space rdmacm API. For example thread T1 could
write an event with the API:
    rdma_write_cm_event(cm_id, RDMA_CM_EVENT_USER, status, arg);
and thread T2 could receive the event with rdma_get_cm_event().

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/ucma.c   | 52 +++++++++++++++++++++++++++++++-
 include/rdma/rdma_cm.h           |  5 ++-
 include/uapi/rdma/rdma_user_cm.h | 16 +++++++++-
 3 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 3b9ca6d7a21b..f86ece701db6 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1745,6 +1745,55 @@ static ssize_t ucma_migrate_id(struct ucma_file *new_file,
 	return ret;
 }
 
+static ssize_t ucma_write_cm_event(struct ucma_file *file,
+				   const char __user *inbuf, int in_len,
+				   int out_len)
+{
+	struct rdma_ucm_write_cm_event cmd;
+	struct rdma_cm_event event = {};
+	struct ucma_event *uevent;
+	struct ucma_context *ctx;
+	int ret = 0;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	if ((cmd.event != RDMA_CM_EVENT_USER) &&
+	    (cmd.event != RDMA_CM_EVENT_INTERNAL))
+		return -EINVAL;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	event.event = cmd.event;
+	event.status = cmd.status;
+	event.param.arg = cmd.param.arg;
+
+	uevent = kzalloc(sizeof(*uevent), GFP_KERNEL);
+	if (!uevent) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	uevent->ctx = ctx;
+	uevent->resp.uid = ctx->uid;
+	uevent->resp.id = ctx->id;
+	uevent->resp.event = event.event;
+	uevent->resp.status = event.status;
+	memcpy(uevent->resp.param.arg32, &event.param.arg,
+	       sizeof(event.param.arg));
+
+	mutex_lock(&ctx->file->mut);
+	list_add_tail(&uevent->list, &ctx->file->event_list);
+	mutex_unlock(&ctx->file->mut);
+	wake_up_interruptible(&ctx->file->poll_wait);
+
+out:
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
 static ssize_t (*ucma_cmd_table[])(struct ucma_file *file,
 				   const char __user *inbuf,
 				   int in_len, int out_len) = {
@@ -1771,7 +1820,8 @@ static ssize_t (*ucma_cmd_table[])(struct ucma_file *file,
 	[RDMA_USER_CM_CMD_BIND]		 = ucma_bind,
 	[RDMA_USER_CM_CMD_RESOLVE_ADDR]	 = ucma_resolve_addr,
 	[RDMA_USER_CM_CMD_JOIN_MCAST]	 = ucma_join_multicast,
-	[RDMA_USER_CM_CMD_RESOLVE_IB_SERVICE] = ucma_resolve_ib_service
+	[RDMA_USER_CM_CMD_RESOLVE_IB_SERVICE] = ucma_resolve_ib_service,
+	[RDMA_USER_CM_CMD_WRITE_CM_EVENT] = ucma_write_cm_event,
 };
 
 static ssize_t ucma_write(struct file *filp, const char __user *buf,
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index 72d1568e4cfb..9bd930a83e6e 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -35,7 +35,9 @@ enum rdma_cm_event_type {
 	RDMA_CM_EVENT_ADDR_CHANGE,
 	RDMA_CM_EVENT_TIMEWAIT_EXIT,
 	RDMA_CM_EVENT_ADDRINFO_RESOLVED,
-	RDMA_CM_EVENT_ADDRINFO_ERROR
+	RDMA_CM_EVENT_ADDRINFO_ERROR,
+	RDMA_CM_EVENT_USER,
+	RDMA_CM_EVENT_INTERNAL,
 };
 
 const char *__attribute_const__ rdma_event_msg(enum rdma_cm_event_type event);
@@ -98,6 +100,7 @@ struct rdma_cm_event {
 	union {
 		struct rdma_conn_param	conn;
 		struct rdma_ud_param	ud;
+		u64			arg;
 	} param;
 	struct rdma_ucm_ece ece;
 };
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 00501da0567e..5ded174687ee 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -68,7 +68,8 @@ enum {
 	RDMA_USER_CM_CMD_BIND,
 	RDMA_USER_CM_CMD_RESOLVE_ADDR,
 	RDMA_USER_CM_CMD_JOIN_MCAST,
-	RDMA_USER_CM_CMD_RESOLVE_IB_SERVICE
+	RDMA_USER_CM_CMD_RESOLVE_IB_SERVICE,
+	RDMA_USER_CM_CMD_WRITE_CM_EVENT,
 };
 
 /* See IBTA Annex A11, servies ID bytes 4 & 5 */
@@ -304,6 +305,7 @@ struct rdma_ucm_event_resp {
 	union {
 		struct rdma_ucm_conn_param conn;
 		struct rdma_ucm_ud_param   ud;
+		__u32 arg32[2];
 	} param;
 	__u32 reserved;
 	struct rdma_ucm_ece ece;
@@ -362,4 +364,16 @@ struct rdma_ucm_resolve_ib_service {
 	__u32 id;
 	struct rdma_ucm_ib_service ibs;
 };
+
+struct rdma_ucm_write_cm_event {
+	__u32 id;
+	__u32 reserved;
+	__u32 event;
+	__u32 status;
+	union {
+		struct rdma_ucm_conn_param conn;
+		struct rdma_ucm_ud_param ud;
+		__u64 arg;
+	} param;
+};
 #endif /* RDMA_USER_CM_H */
-- 
2.50.0


