Return-Path: <linux-rdma+bounces-14928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DECCADB76
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 097D03062E33
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CEF2E6CAA;
	Mon,  8 Dec 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Vc9q+o5n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C532DC78F
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210525; cv=none; b=kCVZYS6eCKbBOHnukSGhvgIgTPf2UdmdeRWmnkj0lwHmnMRm7TPW+Ma2bqCEjSJ63OppmUVrzt14DJdcf0f2X9+oz2T3XPegqrPOqP5jmD57taJNrO3tf9HfGv4/RMyfGh3jHPGfKKSHfE2YPFcgbw7s2vfGKg+2zQ2f66P+Jpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210525; c=relaxed/simple;
	bh=cMNi8GY3Y1cRQK8lazmYYlFlSOUesworRQ4ro3epPJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNJjvtC9cYYSP7I3QYVyopM0A62LeNbeHedDTiWp5KC1Eet+MLPTub2ZOt1eSphyy4PAD/wlfsixNKJm9X15OdHY6ifqMUW9pI6LOSTtoZbIQZzIt8j05qNKY5BxkXfg0nD0esChmaP7MdNAIA4M5b97ZyXZIkQ9feyjJ8ArrjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Vc9q+o5n; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47789cd2083so28092565e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210521; x=1765815321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVWCs8qtdBfDRkjciM3QR2KLKrBZLnHD9GyVyZSe7l8=;
        b=Vc9q+o5nXv0AUTEqUL3E/A96ff30+kv5zbTHAxYaZf7WrVk/6DZnfhUBC+kCLM9Djt
         Jgkj4pzno2KmJRb9qs2dcmQqiMTd32ZrgqL0dyO4cvFCFvCk+9jdoxDzYrL2UjDRH9kO
         DIvo5+gqVLCOOREuIXw8OzAJkBfuCpjl1Hsl6Py71vb5be1Vi+/mKhqOwt6jDLiAOphX
         KVE86Vz2ysNlxuc1hJdPVQPRS2HssJX0tfLKzTkYWZBLJVYIPIN82ORSfmSKg+DBkDXf
         YpUZFWV+AoDt0Efnrj4RWY+8Z73lX4r2RC+JcBjF6GPZHK8YxWu0kTJoTHrdNYEaKdIT
         RtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210521; x=1765815321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fVWCs8qtdBfDRkjciM3QR2KLKrBZLnHD9GyVyZSe7l8=;
        b=aaM9Oe7merVDM0vR5ngGduGxb2ZVTNYTBn5yWEnADm+m8E7JT3zAyhMEpmLi95wsuf
         YRjc3o4R/xztaBOX69a2xgTxmezEkiUFZv/Db8oNllWs6x6MOPZuMpA4JQjfH7I7Iqnk
         rdxkaKj/HrJVKO0EhkKygkqxr81bXIxXtK6yUUGfKijPSvF8P2NOZLZQkywQDd7FuNgk
         Hf7CGk8HTfpGTugbaWmyUFmvDsNjUzHGkfuRzDz3EXdY2wiDpVuKXmK9NMlFDlZDiFWJ
         pbiEjrjaCESeDHWnZ4rW0+KFl03WcwUXXoSx+WuZSRDkjoU6zTh0Qd+nKDOQ0ZzFVD6m
         LdjQ==
X-Gm-Message-State: AOJu0YxGwI7MeolgWh0kcMDrba7CyHdK1HreHihyaDXct5citUzTCC3C
	GsOdvq7tsHz7D1rZX/mhbQichCBq5jw2qALFoxq6jwjsK7M9ysrQpy9hOxkXT+oZx74SsuZ3Xp0
	YaJgI
X-Gm-Gg: ASbGncst6azT6FMdoMjwCqZQNS0WzUHh4Jhwvb/NTJ8cd9GjS1DMlenTawQUP1lcB3T
	3UpjZz9aO4N3OdIPfvFK0MwSMtm5Ks2y0yz/Kz+WDZMywWfrBcWlPgys7zINot8X0II4nwDL9FA
	oLYHCSRGN2WPFuYBAbaYR1AL8uQvVyCv8/HOirvEOSY0YAxN7for42aJuB/sP9M1rcZyDN9vIWM
	gy30cAXhMdKU1SrUr39zaR7sr4xXuqD3zRQ+TUGBb+sbn36WRYbp9pfbrCgutKxEshcYdGTwwVM
	RzxFq6bGlYqhuVNGCQYgQmaHFbxfCLko/Ru0F/sajej8adsHk3mrLHTaqniWgg8edSoq/SFWNpE
	Va3fC86lZhQOxHVkxqrGedadStolwLW6O31UDgSTxO7hLQmDEJe0iYvqDX5kEU9u4yYzNXVLKdt
	FUAD66CDeyrmO6Wnl/88dOXKldWwBEQ7KWogY4jq9dd35MbK+l3+4DtYCh7ufiysQnYFEI/25Sx
	c837z5xllXXSWIrnu0J8uSB
X-Google-Smtp-Source: AGHT+IE1XgR6nL5YpKlxmXYFC6WorBp5iEQXtvUxzYHUmRn18dj8rYH9ciJKgY9Y5Y1ysvG6O4MnsQ==
X-Received: by 2002:a05:600c:3b8b:b0:477:582e:7a81 with SMTP id 5b1f17b1804b1-47939df3288mr91471275e9.4.1765210521428;
        Mon, 08 Dec 2025 08:15:21 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:21 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com
Subject: [PATCH 6/9] RDMA/rtrs-srv: Add check and closure for possible zombie paths
Date: Mon,  8 Dec 2025 17:15:10 +0100
Message-ID: <20251208161513.127049-7-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208161513.127049-1-haris.iqbal@ionos.com>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
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
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 46 +++++++++++++++++++++++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 +
 2 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 4e203140c990..20e7d2681668 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -911,6 +911,13 @@ static int process_info_req(struct rtrs_srv_con *con,
 				      tx_iu->dma_addr,
 				      tx_iu->size, DMA_TO_DEVICE);
 
+	/*
+	 * Now disable zombie connection closing. Since from the logs and code,
+	 * we know that it can never be in CONNECTED state.
+	 * See RNBD-3128 comments.
+	 */
+	srv_path->connection_timeout = 0;
+
 	/* Send info response */
 	err = rtrs_iu_post_send(&con->c, tx_iu, tx_sz, reg_wr);
 	if (err) {
@@ -1537,17 +1544,38 @@ static int sockaddr_cmp(const struct sockaddr *a, const struct sockaddr *b)
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
@@ -1785,7 +1813,6 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 	}
 	if (__is_path_w_addr_exists(srv, &cm_id->route.addr)) {
 		err = -EEXIST;
-		pr_err("Path with same addr exists\n");
 		goto err;
 	}
 	srv_path = kzalloc(sizeof(*srv_path), GFP_KERNEL);
@@ -1832,6 +1859,7 @@ static struct rtrs_srv_path *__alloc_path(struct rtrs_srv_sess *srv,
 	spin_lock_init(&srv_path->state_lock);
 	INIT_WORK(&srv_path->close_work, rtrs_srv_close_work);
 	rtrs_srv_init_hb(srv_path);
+	srv_path->connection_timeout = 0;
 
 	srv_path->s.dev = rtrs_ib_dev_find_or_add(cm_id->device, &dev_pd);
 	if (!srv_path->s.dev) {
@@ -1937,8 +1965,10 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
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
@@ -1953,6 +1983,12 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
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
 		rtrs_err((&srv_path->s), "create_con(), error %d(%pe)\n", err, ERR_PTR(err));
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


