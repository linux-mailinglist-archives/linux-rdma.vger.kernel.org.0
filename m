Return-Path: <linux-rdma+bounces-4460-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B783959ABB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E5BBB25A2E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201B31CDA2B;
	Wed, 21 Aug 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RtIe1ng0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BDE1C4EEB
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239406; cv=none; b=JQqAJVzI5Q+i0ZCCNsBfErO9Ml4fWnXbnnIAaK6a2ueQM+b4PNHP9+VvrFdKkePsPDQGT5cQSMNX5VBfK4gIXbosr7AT0mSOSosByO5h/+K1BBP3td5lls1R7QbZmaqp2JBOHVTZkEVYD5CIq9qkj4B+vOQZyqVX62rISmw7Feo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239406; c=relaxed/simple;
	bh=ToPpPF8PgRne+NZN4bTaf9yJyCjnXa/jwywqeKB/wYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhNXtRHomXum2EfckNQa5Q+uQvDvrPPEqMEP6mDc7CQKfKNPxyltIXBOePFv+nt5LLRbRGF6E1LfYDMBQtAOVuWmwowWmQJNv/IfGx5GOyPdG8k5wsbBXqv7Bd24EC3k5soVz73S95iryg56RuitKSu4pGVb8vB3b5/+kiP+zJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RtIe1ng0; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7d26c2297eso751824966b.2
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239403; x=1724844203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vj3WjtP4ex7lKBF1Z85c4VX/qcuEjWxgusEnVCWcG+Q=;
        b=RtIe1ng0Zv3HD4SjYvXUZwfrNzDCvrwNa46qHpuZN/KajHp+evGrF07NdBQXh/nEWV
         XfJ2qAdaDkywmkhSlYJj8jillExdMIjadQruHPOlsu8/rKqLQVyWtBHkW/UdM6HOce9x
         nMZfFdOa0jcpSNSZRadzUYesi6uV6Z50uERtPpuCv6w6BLA2COY6QTBzEyKhj4B2fO8f
         bU1Tp5FmDkcPhBKbCOi4ikUfIH9wnjmPJdHcO1aLzKImqpmOztIaJzSxRNw4YetoMTn6
         Q2iinN8TOXd3t3VBnbI6V2GvyMqAF5sqrXHHhK+87ZHIVqvjaqU2USKK14rnrN3xxo0j
         TAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239403; x=1724844203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vj3WjtP4ex7lKBF1Z85c4VX/qcuEjWxgusEnVCWcG+Q=;
        b=vfd2NGf/Jn1EzU6cbJtVUqTT8Bj9d/wVt/NiUefsoRNp98NmwHvHpjyCne8BVAdfcj
         yjN78muCRVGZHQm4n2cd5m8oOCa1H2kzCq2ntiFFrcnRxR1jzHH83y5hzHiJyM8F2FdO
         w01ytF9g1Xc7jw0QRVD1vCs14XB9fYqI2k9kTVOif52CatkUihhJMVVjJLRnuDZZu9aO
         QTGuvrhvKkMXl/TlACIhCmay71rZHNY95TIXoTmLfPvw22Rma5M6y7zfxzB+yJfpNgV+
         irv8aFODwKnYcu3dO61QtJOiSd4i+1eVdshrs/bt6qUsS92rcdmM6mC5xiocE3theDbF
         Y7sg==
X-Gm-Message-State: AOJu0YyJJVBoswmWJ2C/lCYifP/HG1lkan8XahuiQZr80/3hei+4gIh1
	awXduqFkbeU4pMtHKvBYtChVky7GFFnudiM/tJbsQYALIrP3NzO0YT0NBdMEKc4C+vizP85xs8X
	rMec=
X-Google-Smtp-Source: AGHT+IHqz/9asCXG6QtYx3roh9DDIgCUKc+6JEJHPqQq76ekzQM2x2jvp1NNsUDoYi9C7xL16hPy6g==
X-Received: by 2002:a17:907:3e8e:b0:a6f:1443:1e24 with SMTP id a640c23a62f3a-a866f342950mr170585766b.34.1724239402947;
        Wed, 21 Aug 2024 04:23:22 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:22 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 09/11] RDMA/rtrs: register ib event handler
Date: Wed, 21 Aug 2024 13:22:15 +0200
Message-Id: <20240821112217.41827-10-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821112217.41827-1-haris.iqbal@ionos.com>
References: <20240821112217.41827-1-haris.iqbal@ionos.com>
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
index 05d15ff074bb..e83d95647852 100644
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
@@ -2269,6 +2272,34 @@ static int check_module_params(void)
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
index 5e325b82ff33..014f85681f37 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -132,6 +132,8 @@ struct rtrs_srv_ib_ctx {
 extern const struct class rtrs_dev_class;
 
 void close_path(struct rtrs_srv_path *srv_path);
+void rtrs_srv_ib_event_handler(struct ib_event_handler *handler,
+			       struct ib_event *ibevent);
 
 static inline void rtrs_srv_update_rdma_stats(struct rtrs_srv_stats *s,
 					      size_t size, int d)
-- 
2.25.1


