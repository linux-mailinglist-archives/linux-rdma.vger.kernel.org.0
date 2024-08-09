Return-Path: <linux-rdma+bounces-4273-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D3594D0EF
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D4F1F21F19
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330002F37;
	Fri,  9 Aug 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DtrQ2rb/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005A194C93
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209359; cv=none; b=YvL9NAVBpXJ6hSlSMAVwvFB/YfOz3Fir2Z3VL+Ia9PihykMIfOZe36vkINWbMt0OpGB64b7kT+o58VbWSyN2viBOylxHKkDybvzb+jLRU8TcnoiQvlNMA9fjHYOpFVPemggQAWW+9ngDgdJ1UBEzCO245t55F2EX08sLnv9hTD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209359; c=relaxed/simple;
	bh=YWucwtpfgTcqBS05BBr3Qv4JpdW+smVL766x3V5mssE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gww7Dmnnz2gaM1XmQftkbEBkZyN56toIK8I5dQthNv5x0SslyvaPLfM/ZcBkyLEIy7q5Ar26ivLUCtmeKTbmfR1VxPCVdOp0YLL4eK26/latbKlF7ujn6aQUi6jV/v/A3YOMudN03SHmfO3vjgqEUEWG+pTcufn/mENAjFFHts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DtrQ2rb/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so13720325e9.2
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209355; x=1723814155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PivggR7AYjcEmDoWWdQztk4HyavK50yywVBFX8fK/ns=;
        b=DtrQ2rb/4KIrU8rilDRbnq2PmQKHhdnMoI11kz6r41vh4NQnD44So05jp8inJZD1l6
         onqHbQxoVhDDQPAj24d/rgVzWTlxYCC0n/NgpsmnapbIWPiPZ8pzxDs5CuvuR6EtSiM/
         J7lAFYOQWcyMpA/av9KXY6o1m0DXpa8Pfdj4CZSlo7WFs5AXIpTnqd1kxRwv3vwEFoLD
         1EavM7RwmnaPKt4tf2Zbpc3sDcGDya0p0YUo2c1GicttgakDnzfMYfs1TcD5vAKHiJmk
         Ml6sWP/1hTS3u1M1Q1SDy/S1zg2SBzBDnaE9bIhrrRQMUkij1zBgkkD4rDktuQM5a+fW
         HdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209355; x=1723814155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PivggR7AYjcEmDoWWdQztk4HyavK50yywVBFX8fK/ns=;
        b=wnilzLjiev/McgcqQGPD89gFRAatE84z7A0PZxk7m6QTQZ4H6iwDM7PTmz3FC/BidR
         mbclhAfYC/1sK7zkKep/WVsgMb96rVhFl5xT+12JQE4O6/zmssu2Brvivr0Zy8CTMpg+
         sA/qCJlPlu8cPvQEbVjqxx6h5IbNbW26VyPYe7opuGfN1xCZ/5QwmTDy/h5ia7sJLUcT
         FPPit4HQiyG4e5RjmdyLb7BV3hb7nphX77wZaNSQMs6d+Mnzx1j7IzAUos/s3l/jR4ra
         rdOU6K3rgCnYvQhlPJPDl1s7G9ADGDMsYpSL5/7GsTURFQTa9fCAvzaHuUvdFYlS6npI
         KyzA==
X-Gm-Message-State: AOJu0YyGiFR6OrlcOhvQXWZzPWVgi5Tn8GJv14HvhgRFrt7fYX3G15DS
	HYs4e9HZlYY48bqY8y3Nmtz82XVE5DlnLiJLHzBXSUDKp3AKQfmqTWTf3/GNQWf89dZAuQvaoCW
	tL64=
X-Google-Smtp-Source: AGHT+IEAsM7ho9eHZ+5FfgHNos7ZimcVajSJAQPuMFdYKoCK3Nn9HwwKB23vOwmDvV83TCciUYJlhw==
X-Received: by 2002:a05:600c:3146:b0:426:5dd0:a1ea with SMTP id 5b1f17b1804b1-429c3a52138mr12274335e9.28.1723209354581;
        Fri, 09 Aug 2024 06:15:54 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:54 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 01/13] RDMA/rtrs-srv: Make rtrs_srv_open fail if its a second call
Date: Fri,  9 Aug 2024 15:15:26 +0200
Message-Id: <20240809131538.944907-2-haris.iqbal@ionos.com>
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

Do not allow opening RTRS server if it is already in use and print
proper error message.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 27 +++++++++++++++++++++++---
 drivers/infiniband/ulp/rtrs/rtrs-srv.h |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 1d33efb8fb03..fb67b58a7f62 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2174,9 +2174,18 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
 	struct rtrs_srv_ctx *ctx;
 	int err;
 
+	mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
+	if (ib_ctx.srv_ctx) {
+		pr_err("%s: Already in use.\n", __func__);
+		ctx = ERR_PTR(-EEXIST);
+		goto out;
+	}
+
 	ctx = alloc_srv_ctx(ops);
-	if (!ctx)
-		return ERR_PTR(-ENOMEM);
+	if (!ctx) {
+		ctx = ERR_PTR(-ENOMEM);
+		goto out;
+	}
 
 	mutex_init(&ib_ctx.ib_dev_mutex);
 	ib_ctx.srv_ctx = ctx;
@@ -2185,9 +2194,11 @@ struct rtrs_srv_ctx *rtrs_srv_open(struct rtrs_srv_ops *ops, u16 port)
 	err = ib_register_client(&rtrs_srv_client);
 	if (err) {
 		free_srv_ctx(ctx);
-		return ERR_PTR(err);
+		ctx = ERR_PTR(err);
 	}
 
+out:
+	mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
 	return ctx;
 }
 EXPORT_SYMBOL(rtrs_srv_open);
@@ -2221,10 +2232,16 @@ static void close_ctx(struct rtrs_srv_ctx *ctx)
  */
 void rtrs_srv_close(struct rtrs_srv_ctx *ctx)
 {
+	mutex_lock(&ib_ctx.rtrs_srv_ib_mutex);
+	WARN_ON(ib_ctx.srv_ctx != ctx);
+
 	ib_unregister_client(&rtrs_srv_client);
 	mutex_destroy(&ib_ctx.ib_dev_mutex);
 	close_ctx(ctx);
 	free_srv_ctx(ctx);
+
+	ib_ctx.srv_ctx = NULL;
+	mutex_unlock(&ib_ctx.rtrs_srv_ib_mutex);
 }
 EXPORT_SYMBOL(rtrs_srv_close);
 
@@ -2282,6 +2299,9 @@ static int __init rtrs_server_init(void)
 		goto out_dev_class;
 	}
 
+	mutex_init(&ib_ctx.rtrs_srv_ib_mutex);
+	ib_ctx.srv_ctx = NULL;
+
 	return 0;
 
 out_dev_class:
@@ -2292,6 +2312,7 @@ static int __init rtrs_server_init(void)
 
 static void __exit rtrs_server_exit(void)
 {
+	mutex_destroy(&ib_ctx.rtrs_srv_ib_mutex);
 	destroy_workqueue(rtrs_wq);
 	class_unregister(&rtrs_dev_class);
 	rtrs_rdma_dev_pd_deinit(&dev_pd);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
index 5e325b82ff33..4924dde0a708 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
@@ -127,6 +127,7 @@ struct rtrs_srv_ib_ctx {
 	u16			port;
 	struct mutex            ib_dev_mutex;
 	int			ib_dev_count;
+	struct mutex		rtrs_srv_ib_mutex;
 };
 
 extern const struct class rtrs_dev_class;
-- 
2.25.1


