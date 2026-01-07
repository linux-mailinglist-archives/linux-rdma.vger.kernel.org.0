Return-Path: <linux-rdma+bounces-15354-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A777DCFF28B
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 18:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E1630A1581
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189553624C7;
	Wed,  7 Jan 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XS+FSEqL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BC73346A1
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802537; cv=none; b=Hrj+t7HHErUL+K5osEB6A+x2ZBWGR4mgIpfeW+dw6hi311gNWN7UVPqMU1BTh77XLQp+iMqouq+s/nuSdRhv92X4NPim7f0u6iX2fjVzxNtSqSb7uduApCvaQv3Sxw+vXoUu3uTRBzpP8Z1nEWuweEZXPkLGPxXLumuBN8llnzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802537; c=relaxed/simple;
	bh=c3V01rMEPTUTh/7QDNV1xmGISx6Ixxx+YdPJZPLgvHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BB00r/96Hg/JEPaWmFIIR6YDb2OV6Dv3TK23kyFV6/uz5H4zXmaUf061D8rMK+wZdnqfRdgxH/LFbhAMnU1kHfzoHZg1NMJ+9/1LxN3HrieUXflw/xRBr4POvjdXpoi+OVgEE+oYQbHHlYGNsRtH0ymIFW9y+ENjwc0CRQ2yZOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XS+FSEqL; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-650854c473fso1987028a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802524; x=1768407324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5YUhnWBIhKXv5nx2lFV74K2dqgHMdEi838j+SiTplI=;
        b=XS+FSEqL6QBFZH4CkCYRuWUODMq71gPGFps5fRohW4ftXTOoUlU8AOZ6mGQigfVtxV
         VRtCwq/xQ2frfABi9DxvRi8q/FG2o9GSn17Vv4Usu5ThphT2SdhRIKtFRi4MUNXFTODM
         Izs1Cw7w81/M+zvGSxJlquqYl80Bnq5olBbHTCVwYqjZxMANvALHJ6HgTF/iDzkQwnMF
         NoQUoZeBulXiEyU42V7aBE9pO9kT++leOr6MoPv/M6+1C4vqRF+9njyQcB1lwgMrc9Af
         AJx3TM+k9RYgDqDEIPmZxwj1Vk+JrxuZ3JFFMgzxFKzQPgCkwWL8NgzQSVncBer74GLD
         CluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802524; x=1768407324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5YUhnWBIhKXv5nx2lFV74K2dqgHMdEi838j+SiTplI=;
        b=EQrBaeXYdTLYJfwM1k4QYYODEjYWacJ/dKb1htyhPADMQhDrKAgNfoWfnBdbBluTtu
         LT7yCEzP5HnMFN6u7LHKyyBJyVGiPJtyhZMA1JEfGdeJJgpAmyekTKOUvwYcW34vX9Zq
         xZdiIS2zvh3+QZ68Y9VbE4z/OI7VD87EVf7eC9ZPAsXt8kOaMCrHlik1I/QFXeFy/TCc
         Q8SlCtbxeZzRVLdqJoYq5Y7OM09D9PralcOVNNqqlXpGyvHXTmOu8eVo7mlmn6sajFv/
         dbEZy1cd3+OiQpzLBe5L9L6TMbq3L/ikj5JVHMD+CsWn80AvaUEOZaCj3naLgO/39sAG
         Z5WA==
X-Gm-Message-State: AOJu0YzzyQ//mXsl6SeSY+t5BiG+qoiZup5cP3BaMzACuIpchiL3wHKj
	Pcvr6GEuSVpfXTZLW57KVObCYhxgu06Pjc+ccs8kj4gwSUFgKBHG+KkSUWAueveNHMX/cOGUlZL
	2CQ94
X-Gm-Gg: AY/fxX49AjttTWSA1Pn6TsjPMl5Ui5vmaLz8TGiTcnb3+UTcSb8NvAA7Kb/MBJlViN5
	AZqG09H+3vWfJwvq9XNfAhDvZcGX1hF7dTZ7rQuCMKVRNdoxdnp8KLKHXkzPqzpjr7nOEaGDTrG
	Jwcs2eHWHZhRojoEMEvuqDjKGDq+glnunuyu/0rH63+QxNmNnh85NN5a1dD/2ZjwfS1exKZOfzA
	CpIIWSzUMGvJPAVqg76F+EfPfL/HB2YslpE+LqG1MfZZRQgZt28yU3D5pEAaWAihe9DwDGBVDhY
	OE5ipFQbhdvhqbiWech5py0pp19S0i0OJcARamIC1s1VUd0Wjx96mtsk/jqJLH2VNutAKYNola9
	beiUNIG/Nf5pDmrTRThTrCVTnJbbh7lv1f3+1PKWbYCY0gT8Btm0SWTEvboaChez4ZsC062ndGj
	d7+tGq0y5BZUOTRRT9b7TymwpXCsdmyr5NGQ+RwizbuLOmacpZElSL/ZloB+M72gsYdp3TSu3l1
	ylQ4L3zJnDlMgf64zDVxH49yG/jfQW6Rg==
X-Google-Smtp-Source: AGHT+IFDmfpPMq8nvd+KFXbVgSv0A9hRjgmgQIMMrYkMIWy/YaKTV7xq0NXlEnlKR+e7r5WDyO1ZCQ==
X-Received: by 2002:a05:6402:26d3:b0:64d:4894:7749 with SMTP id 4fb4d7f45d1cf-65097b37c79mr3569014a12.1.1767802524401;
        Wed, 07 Jan 2026 08:15:24 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:24 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH v2 06/10] RDMA/rtrs-srv: Add check and closure for possible zombie paths
Date: Wed,  7 Jan 2026 17:15:13 +0100
Message-ID: <20260107161517.56357-7-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260107161517.56357-1-haris.iqbal@ionos.com>
References: <20260107161517.56357-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During several network incidents, a number of RTRS paths for a session
went through disconnect and reconnect phase. However, some of those did
not auto-reconnect successfully. Instead they failed with the following
logs,

On client,
kernel: rtrs_client L1991: <sess-name>: Connect rejected: status 28
  (consumer defined), rtrs errno -104
kernel: rtrs_client L2698: <sess-name>: init_conns() failed: err=-104
  path=gid:<gid1>@gid:<gid2> [mlx4_0:1]

On server, (log a)
kernel: ibtrs_server L1868: <>: Connection already exists: 0

When the misbehaving path was removed, and add_path was called to re-add
the path, the log on client side changed to, (log b)
kernel: rtrs_client L1991: <sess-name>: Connect rejected: status 28
  (consumer defined), rtrs errno -17

There was no log on the server side for this, which is expected since
there is no logging in that path,
if (unlikely(__is_path_w_addr_exists(srv, &cm_id->route.addr))) {
	err = -EEXIST;
	goto err;

Because of the following check on server side,
if (unlikely(sess->state != IBTRS_SRV_CONNECTING)) {
	ibtrs_err(s, "Session in wrong state: %s\n",

.. we know that the path in (log a) was in CONNECTING state.

The above state of the path persists for as long as we leave the session
be. This means that the path is in some zombie state, probably waiting
for the info_req packet to arrive, which never does.

The changes in this commits does 2 things.

1) Add logs at places where we see the errors happening. The logs would
shed more light at the state and lifetime of such zombie paths.

2) Close such zombie sessions, only if they are in CONNECTING state, and
after an inactivity period of 30 seconds.
  i) The state check prevents closure of paths which are CONNECTED.
Also, from the above logs and code, we already know that the path could
only be on CONNECTING state, so we play safe and narrow our impact surface
area by closing only CONNECTING paths.
  ii) The inactivity period is to allow requests for other cid to finish
processing, or for any stray packets to arrive/fail.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
v2:
- Addressed comment to remove internal ticket reference.

 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 45 +++++++++++++++++++++++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 +
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 9b8567e5ea38..4e49c15fa970 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -905,6 +905,12 @@ static int process_info_req(struct rtrs_srv_con *con,
 				      tx_iu->dma_addr,
 				      tx_iu->size, DMA_TO_DEVICE);
 
+	/*
+	 * Now disable zombie connection closing. Since from the logs and code,
+	 * we know that it can never be in CONNECTED state.
+	 */
+	srv_path->connection_timeout = 0;
+
 	/* Send info response */
 	err = rtrs_iu_post_send(&con->c, tx_iu, tx_sz, reg_wr);
 	if (err) {
@@ -1531,17 +1537,38 @@ static int sockaddr_cmp(const struct sockaddr *a, const struct sockaddr *b)
 	}
 }
 
+/* Let's close connections which have been waiting for more than 30 seconds */
+#define RTRS_MAX_CONN_TIMEOUT 30000
+
+static void rtrs_srv_check_close_path(struct rtrs_srv_path *srv_path)
+{
+	struct rtrs_path *s = &srv_path->s;
+
+	if (srv_path->state == RTRS_SRV_CONNECTING && srv_path->connection_timeout &&
+	   (jiffies_to_msecs(jiffies - srv_path->connection_timeout) > RTRS_MAX_CONN_TIMEOUT)) {
+		rtrs_err(s, "Closing zombie path\n");
+		close_path(srv_path);
+	}
+}
+
 static bool __is_path_w_addr_exists(struct rtrs_srv_sess *srv,
 				    struct rdma_addr *addr)
 {
 	struct rtrs_srv_path *srv_path;
 
-	list_for_each_entry(srv_path, &srv->paths_list, s.entry)
+	list_for_each_entry(srv_path, &srv->paths_list, s.entry) {
 		if (!sockaddr_cmp((struct sockaddr *)&srv_path->s.dst_addr,
 				  (struct sockaddr *)&addr->dst_addr) &&
 		    !sockaddr_cmp((struct sockaddr *)&srv_path->s.src_addr,
-				  (struct sockaddr *)&addr->src_addr))
+				  (struct sockaddr *)&addr->src_addr)) {
+			rtrs_err((&srv_path->s),
+				 "Path (%s) with same addr exists (lifetime %u)\n",
+				 rtrs_srv_state_str(srv_path->state),
+				 (jiffies_to_msecs(jiffies - srv_path->connection_timeout)));
+			rtrs_srv_check_close_path(srv_path);
 			return true;
+		}
+	}
 
 	return false;
 }
@@ -1779,7 +1806,6 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 	}
 	if (__is_path_w_addr_exists(srv, &cm_id->route.addr)) {
 		err = -EEXIST;
-		pr_err("Path with same addr exists\n");
 		goto err;
 	}
 	srv_path = kzalloc(sizeof(*srv_path), GFP_KERNEL);
@@ -1826,6 +1852,7 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 	spin_lock_init(&srv_path->state_lock);
 	INIT_WORK(&srv_path->close_work, rtrs_srv_close_work);
 	rtrs_srv_init_hb(srv_path);
+	srv_path->connection_timeout = 0;
 
 	srv_path->s.dev = rtrs_ib_dev_find_or_add(cm_id->device, &dev_pd);
 	if (!srv_path->s.dev) {
@@ -1931,8 +1958,10 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 			goto reject_w_err;
 		}
 		if (s->con[cid]) {
-			rtrs_err(s, "Connection already exists: %d\n",
-				  cid);
+			rtrs_err(s, "Connection (%s) already exists: %d (lifetime %u)\n",
+				 rtrs_srv_state_str(srv_path->state), cid,
+				 (jiffies_to_msecs(jiffies - srv_path->connection_timeout)));
+			rtrs_srv_check_close_path(srv_path);
 			mutex_unlock(&srv->paths_mutex);
 			goto reject_w_err;
 		}
@@ -1947,6 +1976,12 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
 			goto reject_w_err;
 		}
 	}
+
+	/*
+	 * Start of any connection creation resets the timeout for the path.
+	 */
+	srv_path->connection_timeout = jiffies;
+
 	err = create_con(srv_path, cm_id, cid);
 	if (err) {
 		rtrs_err((&srv_path->s), "create_con(), error %pe\n", ERR_PTR(err));
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 014f85681f37..3d36876527f5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -89,6 +89,7 @@ struct rtrs_srv_path {
 	unsigned int		mem_bits;
 	struct kobject		kobj;
 	struct rtrs_srv_stats	*stats;
+	unsigned long		connection_timeout;
 };
 
 static inline struct rtrs_srv_path *to_srv_path(struct rtrs_path *s)
-- 
2.43.0


