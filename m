Return-Path: <linux-rdma+bounces-4283-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70194D0F9
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E9F1C21D3C
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569F1953BA;
	Fri,  9 Aug 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bajxgn0Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1E195980
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209364; cv=none; b=V8DuEVJoBir9URr6tc0odbUltL1eBVcGKA/yRf/d3LQXb3CzhsFViethB8cuLXPaauHwMUIpFc2WA0YK3NsHOV6Lmb/wmm37b137/4SNqUHmenztJIZE794NVy5GTMULHR5EOvQokdKLEkuKmdnveokEPAsv13K5euFHVYNDr/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209364; c=relaxed/simple;
	bh=ad06e7JutVcxmMQ0BOmwpDAQmKkjLSLR/RzU0bbWwGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQEnNkYuOjwNSr3Wa0iQiqjTafKXf0ryD4fi8YOPEOwuBnBNX9x476Qby/eIu4VKB6s9rh7zUoo1Yy4sGg5VUDUS0a9Wid9xaIkMZXPJFlniW2p7aRPevivgDO/LrsZb/KOhZbVxD6EbQWOgafnjYR5UK543G1VSl/AtL8Zywog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bajxgn0Y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428fb103724so17777515e9.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209361; x=1723814161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84Ddqq+9UVuqSicaxcUJ99dvqDlCAHZBvWXLqs6sph8=;
        b=bajxgn0Yr9pdrhLRanDSayDOMBfK5NTN8JwN0SSRikNVNpiw0ycCDVLzIVH8k8Fu5x
         +gWRM4GcAitUkcmhTbNikFOsPkhol+dm+zfLeCmQeghxrTw7hHv33oY/zNFT4HbEu2Co
         nXn1kvsIs0vEGl6cN/f8nHIxH0uG7VKNS6HpUHwvdBVjg0uproVLAgM71YXeNqz20eBQ
         kRS2OFYSASuPWYa++fOKwnJSvLgAk/P+TyDgtRRgq7t2Tg8nVdvjLkDHjPed6tJ2lR0g
         5fisFWlalbPzZZ/F1R8PaGuOP43NhuJiZhbZbnEoQE3rTauGNmFrSRTM7dPPiTGVF2yT
         JJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209361; x=1723814161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=84Ddqq+9UVuqSicaxcUJ99dvqDlCAHZBvWXLqs6sph8=;
        b=wXy7rwRcwbfayKQuMl2uW63vXR0GcX1wRtGHoL78jZ3Md6fhTSvhleBDpXXyEIHYl8
         5Gi6jsF6OxMsEVgqb3Z+5t89jtZIMtbXJA+eCfnFp3eNytxVWTu1FixCKwa0lRJE3UdV
         OOO3WG/LRrODngz1jEbEDJhxQlbdfHyfJWrDEcvgdBhKIsvXyPBt8uBHDdPPGsYLl70U
         vTq1AZKIAjhtrLVkHteIkLX0LvuiOLHhlR65PpKfKrfQfvxbCCguuExv9ij1NTUszs3j
         6hokZNjQPrngyl1RPqHGYRO+YYId2l8qMcRmokhUrEyXbxO8l8S/4TM2SGtg6YFsxFoF
         g24A==
X-Gm-Message-State: AOJu0YxLs+tzNUvFgKV4VpUIJf1FmKeus0ZMFZOhosXbV8KtrGd9fwnF
	kQmC92QxwDdqVhsGR2QWmO2TLDmir29hKgXgQAKTgnEmnErAeOHccWHMLF0uN9kaLKS5itflvmf
	fPo4=
X-Google-Smtp-Source: AGHT+IFEZzPEJw80hqASm7nrWVNaM8N/Qf9MOdXGDp3baMw8HWD/hRRj3wzJTfvx06isFl5ZTRjSxg==
X-Received: by 2002:a05:600c:4583:b0:424:71f7:77f2 with SMTP id 5b1f17b1804b1-4290b8df20fmr40606135e9.16.1723209361171;
        Fri, 09 Aug 2024 06:16:01 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:16:00 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 11/13] RDMA/rtrs: register ib event handler
Date: Fri,  9 Aug 2024 15:15:36 +0200
Message-Id: <20240809131538.944907-12-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240809131538.944907-1-haris.iqbal@ionos.com>
References: <20240809131538.944907-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>

Use ib_register_event_handler() to register event handlers for both
client and server side. For now, all those handlers do, is to print
type of incoming event.

Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 21 +++++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  2 ++
 drivers/infiniband/ulp/rtrs/rtrs-pri.h |  2 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 33 +++++++++++++++++++++++++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  2 ++
 5 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7c6d40380638..230e5f6c8c90 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -3149,8 +3149,20 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt_sess *clt,
 	return err;
 }
 
+void rtrs_clt_ib_event_handler(struct ib_event_handler *handler,
+			       struct ib_event *ibevent)
+{
+	pr_info("Handling event: %s (%d).\n", ib_event_msg(ibevent->event),
+		ibevent->event);
+}
+
+
 static int rtrs_clt_ib_dev_init(struct rtrs_ib_dev *dev)
 {
+	INIT_IB_EVENT_HANDLER(&dev->event_handler, dev->ib_dev,
+			      rtrs_clt_ib_event_handler);
+	ib_register_event_handler(&dev->event_handler);
+
 	if (!(dev->ib_dev->attrs.device_cap_flags &
 	      IB_DEVICE_MEM_MGT_EXTENSIONS)) {
 		pr_err("Memory registrations not supported.\n");
@@ -3160,8 +3172,15 @@ static int rtrs_clt_ib_dev_init(struct rtrs_ib_dev *dev)
 	return 0;
 }
 
+static void rtrs_clt_ib_dev_deinit(struct rtrs_ib_dev *dev)
+{
+	ib_unregister_event_handler(&dev->event_handler);
+}
+
+
 static const struct rtrs_rdma_dev_pd_ops dev_pd_ops = {
-	.init = rtrs_clt_ib_dev_init
+	.init = rtrs_clt_ib_dev_init,
+	.deinit = rtrs_clt_ib_dev_deinit
 };
 
 static int __init rtrs_client_init(void)
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.h b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
index 45dac15825f4..0f57759b3080 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
@@ -212,6 +212,8 @@ int rtrs_clt_remove_path_from_sysfs(struct rtrs_clt_path *path,
 void rtrs_clt_set_max_reconnect_attempts(struct rtrs_clt_sess *clt, int value);
 int rtrs_clt_get_max_reconnect_attempts(const struct rtrs_clt_sess *clt);
 void free_path(struct rtrs_clt_path *clt_path);
+void rtrs_clt_ib_event_handler(struct ib_event_handler *handler,
+			       struct ib_event *ibevent);
 
 /* rtrs-clt-stats.c */
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-pri.h b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
index ab25619261d2..ef29bd483b5a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-pri.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-pri.h
@@ -69,6 +69,7 @@ struct rtrs_ib_dev;
 
 struct rtrs_rdma_dev_pd_ops {
 	int (*init)(struct rtrs_ib_dev *dev);
+	void (*deinit)(struct rtrs_ib_dev *dev);
 };
 
 struct rtrs_rdma_dev_pd {
@@ -84,6 +85,7 @@ struct rtrs_ib_dev {
 	struct kref		 ref;
 	struct list_head	 entry;
 	struct rtrs_rdma_dev_pd *pool;
+	struct ib_event_handler	 event_handler;
 };
 
 struct rtrs_con {
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index fe8abbe0d2e9..141f05a1c395 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -26,7 +26,10 @@ MODULE_LICENSE("GPL");
 #define DEFAULT_SESS_QUEUE_DEPTH 512
 #define MAX_HDR_SIZE PAGE_SIZE
 
-static struct rtrs_rdma_dev_pd dev_pd;
+static const struct rtrs_rdma_dev_pd_ops dev_pd_ops;
+static struct rtrs_rdma_dev_pd dev_pd = {
+	.ops = &dev_pd_ops
+};
 const struct class rtrs_dev_class = {
 	.name = "rtrs-server",
 };
@@ -2286,6 +2289,34 @@ static int check_module_params(void)
 	return 0;
 }
 
+void rtrs_srv_ib_event_handler(struct ib_event_handler *handler,
+			       struct ib_event *ibevent)
+{
+	pr_info("Handling event: %s (%d).\n", ib_event_msg(ibevent->event),
+		ibevent->event);
+}
+
+static int rtrs_srv_ib_dev_init(struct rtrs_ib_dev *dev)
+{
+	INIT_IB_EVENT_HANDLER(&dev->event_handler, dev->ib_dev,
+			      rtrs_srv_ib_event_handler);
+	ib_register_event_handler(&dev->event_handler);
+
+	return 0;
+}
+
+static void rtrs_srv_ib_dev_deinit(struct rtrs_ib_dev *dev)
+{
+	ib_unregister_event_handler(&dev->event_handler);
+}
+
+
+static const struct rtrs_rdma_dev_pd_ops dev_pd_ops = {
+	.init = rtrs_srv_ib_dev_init,
+	.deinit = rtrs_srv_ib_dev_deinit
+};
+
+
 static int __init rtrs_server_init(void)
 {
 	int err;
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 4924dde0a708..99cfd2e58ca1 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -133,6 +133,8 @@ struct rtrs_srv_ib_ctx {
 extern const struct class rtrs_dev_class;
 
 void close_path(struct rtrs_srv_path *srv_path);
+void rtrs_srv_ib_event_handler(struct ib_event_handler *handler,
+			       struct ib_event *ibevent);
 
 static inline void rtrs_srv_update_rdma_stats(struct rtrs_srv_stats *s,
 					      size_t size, int d)
-- 
2.25.1


