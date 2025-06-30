Return-Path: <linux-rdma+bounces-11758-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E6BAEDA48
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DDB17406B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4962580E1;
	Mon, 30 Jun 2025 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXTyGr70"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA86E239E7C
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751280770; cv=none; b=CqtQXTTci/ob7qqlXKVJ8WoVAhbmvK7WaVDdD9kWvgk/Vl1m6GgAeQLfqV4oRNip1f1GOwZpabaoZf6PrrzocU8g7easJLIUXi/UjoT7J5MgTwKwgRKqbWxT1lKu4Bk4xEUTCzZEY3gknEHVzPKMuXgeDSsAayCmeNeIdFDV928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751280770; c=relaxed/simple;
	bh=H8UB6LetajtjxyMXvFhBLOX8boksPMUrlBe8IBU5tBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqnTLz6XzHUJKE/g4Z9Hm7lj6eFf9WqXYUwP4LUaVKLD9u31eXhv6GHeo8U7HIRtOb0nlivHukmskcR3UkugqjTxJ1HKi5+20u5s97HSN4GeHPbw7BgSUAiI53gAhHX/ZnZrGk7aAMZzRBHYRUWCVRPS/b7Bc61oJH/2/rfCcLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXTyGr70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DA9C4CEE3;
	Mon, 30 Jun 2025 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751280769;
	bh=H8UB6LetajtjxyMXvFhBLOX8boksPMUrlBe8IBU5tBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PXTyGr70JRjknG/Tb2oqTgZIHF69649oy+00PAC70NxDpB9PBw5GHfL9TL7PMLE10
	 ywgFh//SIuylnfva2dqxOoKlgt+ZcelRbsIhbtF1DAv8NkvPTtQ94qL8AwxKlQcb+O
	 sUjT4mYDl0m01bqGyTI4JVzlEePVWa3mCwxOvtXrd07msCb4/p0QxvTIA1vKH96qOM
	 ez5xR3WZccaafZjUw1s10Aa6V0a1pPreHtMyIUVSB7ckM7nQsS/oAKbbDk9v+N0GnH
	 E5coALirwjAebZSl6aHKgD/LbCw/92gMdRBKtupaKADBDC8TA9PEXogYpgZnnDu8Iw
	 Amu3Ts5auZrqw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Or Har-Toov <ohartoov@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next 3/5] RDMA/cma: Support IB service record resolution
Date: Mon, 30 Jun 2025 13:52:33 +0300
Message-ID: <b6e82ad75522a13b5efe4ff86da0e465aab04cc2.1751279794.git.leonro@nvidia.com>
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

Add new UCMA command and the corresponding CMA implementation. Userspace
can send this command to request service resolution based on service
name or ID.

On a successful resolution, one or multiple service records are
returned, the first one will be used as destination address by default.

Two new CM events are added and returned to caller accordingly:
  - RDMA_CM_EVENT_ADDRINFO_RESOLVED: Resolve succeeded;
  - RDMA_CM_EVENT_ADDRINFO_ERROR:  Resolve failed.

Internally two new CM states are added:
  - RDMA_CM_ADDRINFO_QUERY: CM is in the process of IB service
    resolution;
  - RDMA_CM_ADDRINFO_RESOLVED: CM has finished the resolve process.

With these new states, beside existing state transfer processes, 2 new
processes are supported:
 1. The default address is used:
    RDMA_CM_ADDR_BOUND ->
      RDMA_CM_ADDRINFO_QUERY ->
        RDMA_CM_ADDRINFO_RESOLVED ->
          RDMA_CM_ROUTE_QUERY

 2. To use a different address:
    RDMA_CM_ADDR_BOUND ->
      RDMA_CM_ADDRINFO_QUERY->
        RDMA_CM_ADDRINFO_RESOLVED ->
          RDMA_CM_ADDR_QUERY ->
            RDMA_CM_ADDR_RESOLVED ->
              RDMA_CM_ROUTE_QUERY

In the 2nd case, resolve_addrinfo returns multiple records, a user
could call rdma_resolve_addr() with the one that is not the first.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c      | 136 ++++++++++++++++++++++++++++-
 drivers/infiniband/core/cma_priv.h |   4 +-
 drivers/infiniband/core/ucma.c     |  30 ++++++-
 include/rdma/rdma_cm.h             |  18 +++-
 include/uapi/rdma/rdma_user_cm.h   |  20 ++++-
 5 files changed, 202 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 9b471548e7ae..5b2d3ae3f9fc 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2076,6 +2076,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 	kfree(id_priv->id.route.path_rec);
 	kfree(id_priv->id.route.path_rec_inbound);
 	kfree(id_priv->id.route.path_rec_outbound);
+	kfree(id_priv->id.route.service_recs);
 
 	put_net(id_priv->id.route.addr.dev_addr.net);
 	kfree(id_priv);
@@ -3382,13 +3383,18 @@ static int cma_resolve_iboe_route(struct rdma_id_private *id_priv)
 int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 {
 	struct rdma_id_private *id_priv;
+	enum rdma_cm_state state;
 	int ret;
 
 	if (!timeout_ms)
 		return -EINVAL;
 
 	id_priv = container_of(id, struct rdma_id_private, id);
-	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED, RDMA_CM_ROUTE_QUERY))
+	state = id_priv->state;
+	if (!cma_comp_exch(id_priv, RDMA_CM_ADDR_RESOLVED,
+			   RDMA_CM_ROUTE_QUERY) &&
+	    !cma_comp_exch(id_priv, RDMA_CM_ADDRINFO_RESOLVED,
+			   RDMA_CM_ROUTE_QUERY))
 		return -EINVAL;
 
 	cma_id_get(id_priv);
@@ -3409,7 +3415,7 @@ int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms)
 
 	return 0;
 err:
-	cma_comp_exch(id_priv, RDMA_CM_ROUTE_QUERY, RDMA_CM_ADDR_RESOLVED);
+	cma_comp_exch(id_priv, RDMA_CM_ROUTE_QUERY, state);
 	cma_id_put(id_priv);
 	return ret;
 }
@@ -5506,3 +5512,129 @@ static void __exit cma_cleanup(void)
 
 module_init(cma_init);
 module_exit(cma_cleanup);
+
+static void cma_query_ib_service_handler(int status,
+					 struct sa_service_rec *recs,
+					 unsigned int num_recs, void *context)
+{
+	struct cma_work *work = context;
+	struct rdma_id_private *id_priv = work->id;
+	struct sockaddr_ib *addr;
+
+	if (status)
+		goto fail;
+
+	if (!num_recs) {
+		status = -ENOENT;
+		goto fail;
+	}
+
+	if (id_priv->id.route.service_recs) {
+		status = -EALREADY;
+		goto fail;
+	}
+
+	id_priv->id.route.service_recs =
+		kmalloc_array(num_recs, sizeof(*recs), GFP_KERNEL);
+	if (!id_priv->id.route.service_recs) {
+		status = -ENOMEM;
+		goto fail;
+	}
+
+	id_priv->id.route.num_service_recs = num_recs;
+	memcpy(id_priv->id.route.service_recs, recs, sizeof(*recs) * num_recs);
+
+	addr = (struct sockaddr_ib *)&id_priv->id.route.addr.dst_addr;
+	addr->sib_family = AF_IB;
+	addr->sib_addr = *(struct ib_addr *)&recs->gid;
+	addr->sib_pkey = recs->pkey;
+	addr->sib_sid = recs->id;
+	rdma_addr_set_dgid(&id_priv->id.route.addr.dev_addr,
+			   (union ib_gid *)&addr->sib_addr);
+	ib_addr_set_pkey(&id_priv->id.route.addr.dev_addr,
+			 ntohs(addr->sib_pkey));
+
+	queue_work(cma_wq, &work->work);
+	return;
+
+fail:
+	work->old_state = RDMA_CM_ADDRINFO_QUERY;
+	work->new_state = RDMA_CM_ADDR_BOUND;
+	work->event.event = RDMA_CM_EVENT_ADDRINFO_ERROR;
+	work->event.status = status;
+	pr_debug_ratelimited(
+		"RDMA CM: SERVICE_ERROR: failed to query service record. status %d\n",
+		status);
+	queue_work(cma_wq, &work->work);
+}
+
+static int cma_resolve_ib_service(struct rdma_id_private *id_priv,
+				  struct rdma_ucm_ib_service *ibs)
+{
+	struct sa_service_rec sr = {};
+	ib_sa_comp_mask mask = 0;
+	struct cma_work *work;
+
+	work = kzalloc(sizeof(*work), GFP_KERNEL);
+	if (!work)
+		return -ENOMEM;
+
+	cma_id_get(id_priv);
+
+	work->id = id_priv;
+	INIT_WORK(&work->work, cma_work_handler);
+	work->old_state = RDMA_CM_ADDRINFO_QUERY;
+	work->new_state = RDMA_CM_ADDRINFO_RESOLVED;
+	work->event.event = RDMA_CM_EVENT_ADDRINFO_RESOLVED;
+
+	if (ibs->flags & RDMA_USER_CM_IB_SERVICE_FLAG_ID) {
+		sr.id = cpu_to_be64(ibs->service_id);
+		mask |= IB_SA_SERVICE_REC_SERVICE_ID;
+	}
+	if (ibs->flags & RDMA_USER_CM_IB_SERVICE_FLAG_NAME) {
+		strscpy(sr.name, ibs->service_name, sizeof(sr.name));
+		mask |= IB_SA_SERVICE_REC_SERVICE_NAME;
+	}
+
+	id_priv->query_id = ib_sa_service_rec_get(&sa_client,
+						  id_priv->id.device,
+						  id_priv->id.port_num,
+						  &sr, mask,
+						  2000, GFP_KERNEL,
+						  cma_query_ib_service_handler,
+						  work, &id_priv->query);
+
+	if (id_priv->query_id < 0) {
+		cma_id_put(id_priv);
+		kfree(work);
+		return id_priv->query_id;
+	}
+
+	return 0;
+}
+
+int rdma_resolve_ib_service(struct rdma_cm_id *id,
+			    struct rdma_ucm_ib_service *ibs)
+{
+	struct rdma_id_private *id_priv;
+	int ret;
+
+	id_priv = container_of(id, struct rdma_id_private, id);
+	if (!id_priv->cma_dev ||
+	    !cma_comp_exch(id_priv, RDMA_CM_ADDR_BOUND, RDMA_CM_ADDRINFO_QUERY))
+		return -EINVAL;
+
+	if (rdma_cap_ib_sa(id->device, id->port_num))
+		ret = cma_resolve_ib_service(id_priv, ibs);
+	else
+		ret = -EOPNOTSUPP;
+
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	cma_comp_exch(id_priv, RDMA_CM_ADDRINFO_QUERY, RDMA_CM_ADDR_BOUND);
+	return ret;
+}
+EXPORT_SYMBOL(rdma_resolve_ib_service);
diff --git a/drivers/infiniband/core/cma_priv.h b/drivers/infiniband/core/cma_priv.h
index b7354c94cf1b..c604b601f4d9 100644
--- a/drivers/infiniband/core/cma_priv.h
+++ b/drivers/infiniband/core/cma_priv.h
@@ -47,7 +47,9 @@ enum rdma_cm_state {
 	RDMA_CM_ADDR_BOUND,
 	RDMA_CM_LISTEN,
 	RDMA_CM_DEVICE_REMOVAL,
-	RDMA_CM_DESTROYING
+	RDMA_CM_DESTROYING,
+	RDMA_CM_ADDRINFO_QUERY,
+	RDMA_CM_ADDRINFO_RESOLVED
 };
 
 struct rdma_id_private {
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index 6e700b974033..1915f4e68308 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -282,6 +282,10 @@ static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
 	}
 	uevent->resp.event = event->event;
 	uevent->resp.status = event->status;
+
+	if (event->event == RDMA_CM_EVENT_ADDRINFO_RESOLVED)
+		goto out;
+
 	if (ctx->cm_id->qp_type == IB_QPT_UD)
 		ucma_copy_ud_event(ctx->cm_id->device, &uevent->resp.param.ud,
 				   &event->param.ud);
@@ -289,6 +293,7 @@ static struct ucma_event *ucma_create_uevent(struct ucma_context *ctx,
 		ucma_copy_conn_event(&uevent->resp.param.conn,
 				     &event->param.conn);
 
+out:
 	uevent->resp.ece.vendor_id = event->ece.vendor_id;
 	uevent->resp.ece.attr_mod = event->ece.attr_mod;
 	return uevent;
@@ -728,6 +733,28 @@ static ssize_t ucma_resolve_addr(struct ucma_file *file,
 	return ret;
 }
 
+static ssize_t ucma_resolve_ib_service(struct ucma_file *file,
+				       const char __user *inbuf, int in_len,
+				       int out_len)
+{
+	struct rdma_ucm_resolve_ib_service cmd;
+	struct ucma_context *ctx;
+	int ret;
+
+	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
+		return -EFAULT;
+
+	ctx = ucma_get_ctx(file, cmd.id);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	mutex_lock(&ctx->mutex);
+	ret = rdma_resolve_ib_service(ctx->cm_id, &cmd.ibs);
+	mutex_unlock(&ctx->mutex);
+	ucma_put_ctx(ctx);
+	return ret;
+}
+
 static ssize_t ucma_resolve_route(struct ucma_file *file,
 				  const char __user *inbuf,
 				  int in_len, int out_len)
@@ -1703,7 +1730,8 @@ static ssize_t (*ucma_cmd_table[])(struct ucma_file *file,
 	[RDMA_USER_CM_CMD_QUERY]	 = ucma_query,
 	[RDMA_USER_CM_CMD_BIND]		 = ucma_bind,
 	[RDMA_USER_CM_CMD_RESOLVE_ADDR]	 = ucma_resolve_addr,
-	[RDMA_USER_CM_CMD_JOIN_MCAST]	 = ucma_join_multicast
+	[RDMA_USER_CM_CMD_JOIN_MCAST]	 = ucma_join_multicast,
+	[RDMA_USER_CM_CMD_RESOLVE_IB_SERVICE] = ucma_resolve_ib_service
 };
 
 static ssize_t ucma_write(struct file *filp, const char __user *buf,
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index d1593ad47e28..72d1568e4cfb 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -33,7 +33,9 @@ enum rdma_cm_event_type {
 	RDMA_CM_EVENT_MULTICAST_JOIN,
 	RDMA_CM_EVENT_MULTICAST_ERROR,
 	RDMA_CM_EVENT_ADDR_CHANGE,
-	RDMA_CM_EVENT_TIMEWAIT_EXIT
+	RDMA_CM_EVENT_TIMEWAIT_EXIT,
+	RDMA_CM_EVENT_ADDRINFO_RESOLVED,
+	RDMA_CM_EVENT_ADDRINFO_ERROR
 };
 
 const char *__attribute_const__ rdma_event_msg(enum rdma_cm_event_type event);
@@ -63,6 +65,9 @@ struct rdma_route {
 	 * 2 - Both primary and alternate path are available
 	 */
 	int num_pri_alt_paths;
+
+	unsigned int num_service_recs;
+	struct sa_service_rec *service_recs;
 };
 
 struct rdma_conn_param {
@@ -197,6 +202,17 @@ int rdma_resolve_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
  */
 int rdma_resolve_route(struct rdma_cm_id *id, unsigned long timeout_ms);
 
+/**
+ * rdma_resolve_ib_service - Resolve the IB service record of the
+ *   service with the given service ID or name.
+ *
+ * This function is optional in the rdma cm flow. It is called on the client
+ * side of a connection, before calling rdma_resolve_route. The resolution
+ * can be done once per rdma_cm_id.
+ */
+int rdma_resolve_ib_service(struct rdma_cm_id *id,
+			    struct rdma_ucm_ib_service *ibs);
+
 /**
  * rdma_create_qp - Allocate a QP and associate it with the specified RDMA
  * identifier.
diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index 7cea03581f79..8799623bcba0 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -67,7 +67,8 @@ enum {
 	RDMA_USER_CM_CMD_QUERY,
 	RDMA_USER_CM_CMD_BIND,
 	RDMA_USER_CM_CMD_RESOLVE_ADDR,
-	RDMA_USER_CM_CMD_JOIN_MCAST
+	RDMA_USER_CM_CMD_JOIN_MCAST,
+	RDMA_USER_CM_CMD_RESOLVE_IB_SERVICE
 };
 
 /* See IBTA Annex A11, servies ID bytes 4 & 5 */
@@ -338,4 +339,21 @@ struct rdma_ucm_migrate_resp {
 	__u32 events_reported;
 };
 
+enum {
+	RDMA_USER_CM_IB_SERVICE_FLAG_ID = 1 << 0,
+	RDMA_USER_CM_IB_SERVICE_FLAG_NAME = 1 << 1,
+};
+
+#define RDMA_USER_CM_IB_SERVICE_NAME_SIZE 64
+struct rdma_ucm_ib_service {
+	__u64 service_id;
+	__u8  service_name[RDMA_USER_CM_IB_SERVICE_NAME_SIZE];
+	__u32 flags;
+	__u32 reserved;
+};
+
+struct rdma_ucm_resolve_ib_service {
+	__u32 id;
+	struct rdma_ucm_ib_service ibs;
+};
 #endif /* RDMA_USER_CM_H */
-- 
2.50.0


