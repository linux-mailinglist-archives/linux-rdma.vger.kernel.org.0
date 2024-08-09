Return-Path: <linux-rdma+bounces-4275-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C88194D0F1
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9F81C21905
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC3E194C75;
	Fri,  9 Aug 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RciXoIx1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B7194AF4
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209359; cv=none; b=LBYDzOHl5BptrvDH4jcURPz3ZiTTJPWtVOyGbJDiQ0zhDAeKzyVhDGFTXCA9hOc0n+K+Ve9rWCPVWSN6KB8ZvyGE4RWpBm/JQxUM3SW1TXGvlvDwW3SZfw8IuFlR4rx4IUC70K2HFmYstV/0t0Q/nxCyKnvU3KD8XA3pdKScYuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209359; c=relaxed/simple;
	bh=UX6CYtwSpi23VKoZoiBb1839/I25OP7qWo97jVNyyvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ty02PJvDZd7sXmpJ0u5cOM5bnM+5pbajEBfcn0Jv9yjKn8OdMmMNW5+v42KefNzSg9/usYigWf/i7HSuXnG3fnvCRpZdM2fdj1HyPLni1woQe3M1y8Z5o/437DkcseHGOY22GPj6I4pTuhsripvfxC/gZt7wc49i2L2Dw7IatS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RciXoIx1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280bca3960so15296385e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209356; x=1723814156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VftxWQ8DmE0g8jGp2R6vgB3PyXWNM5bcwEfKFwmO7k=;
        b=RciXoIx12qr6sz3ANzjqHs3Y5CmAsBSg5I1kkX2CyORd/LyfOJw8l72E7p3FnjrQH9
         5V7X6X3bVAp3fzjktIHLoflD2qssEMoBlgVvUQXZxvp4yzb4Z0MGwrgmsRlyhSNfRI/6
         utS3LXopnv99mwpa93EqAjpeVzHj9UnP18wBbHrpyS6+mN0exBrRkM/WLOqkfRN8lois
         n4uDa5hILGHV+YDREgcPWxkmg5ZS1mfLhkvmnK9t/NBEdi/MmpHkNbAA4ETjJYgVtWXd
         xTHh+g0WqEkoZ3fhIjkQEx5V4wbwwBEvwggoooGm4udcBim1RcG/sxqQnW4bzVfdksTX
         gzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209356; x=1723814156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VftxWQ8DmE0g8jGp2R6vgB3PyXWNM5bcwEfKFwmO7k=;
        b=dARFpVef+iK4K7m2Xv5KpskrM/ZybxrN0KgOiyhm/mKSxBLzq2ZRDkTPg8wtjPk/GL
         U+x2LSnow2kwqRT+jQRSOTlfVBaxUu+h3vLVBLjW5+HRPqmLisEzozpEtWrFwj0dHgR9
         r2Fvn41f7vJtAZUCrmwCO3eDbGivEdWHFG42fnB+ploGir+P3znhp0Bf3FH1MtrKiBVU
         /kAYv6VzcCGK5IFcZbmmTc3KVf30080ucjbNzDfCb6OmECHH6PlyzonE5m/TFhXfRHPx
         JHu/o/CHRckJaPbsk9zbL64oyNvkUfXHTCZ1Kp9utJx+cJggCydorbiiMpX9dIxcEsWJ
         FrmA==
X-Gm-Message-State: AOJu0YxojgI/Es732aXz/YHTTFYxIGjpB0ml0iByMwTlKwKzA8DK7biZ
	nZXxhB/67hABwfDkWkYpCGJ+ySQ99HAlNBwgMrd6VzEB8B2eed3gEXl5ptQ05q5sS5WYP2W+I8R
	LNhE=
X-Google-Smtp-Source: AGHT+IExrlVjE+lm25xBam+bIIzEuM10jao7kd5SS9wyUlDp9JDkX6MQAnSSrZYLay7IkU7hbKUa8w==
X-Received: by 2002:a05:600c:4e8a:b0:426:6667:5c42 with SMTP id 5b1f17b1804b1-429c3a17ff5mr11456125e9.4.1723209355950;
        Fri, 09 Aug 2024 06:15:55 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:55 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 03/13] RDMA/rtrs: For HB error add additional clt/srv specific logging
Date: Fri,  9 Aug 2024 15:15:28 +0200
Message-Id: <20240809131538.944907-4-haris.iqbal@ionos.com>
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

In case of HB error, we need to know the specific path on which it
happened, for better debugging. Since the clt/srv path structures are not
available in rtrs.c, it needs to be done in the individual HB error
handler.

This commit add those loging. A sample kernel log output after this commit:

rtrs_core L357: <blya>: HB missed max reached.
rtrs_server L717: <blya>: HB err handler for path=ip:x.x.x.x@ip:x.x.x.x
.
.
rtrs_core L357: <blya>: HB missed max reached.
rtrs_client L1519: <blya>: HB err handler for path=ip:x.x.x.x@ip:x.x.x.x

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 2 ++
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 88106cf5ce55..66ac4dba990f 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1494,7 +1494,9 @@ static bool rtrs_clt_change_state_get_old(struct rtrs_clt_path *clt_path,
 static void rtrs_clt_hb_err_handler(struct rtrs_con *c)
 {
 	struct rtrs_clt_con *con = container_of(c, typeof(*con), c);
+	struct rtrs_clt_path *clt_path = to_clt_path(con->c.path);
 
+	rtrs_err(con->c.path, "HB err handler for path=%s\n", kobject_name(&clt_path->kobj));
 	rtrs_rdma_error_recovery(con);
 }
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 90ea25ad6720..e6885c88fa41 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -672,6 +672,10 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 
 static void rtrs_srv_hb_err_handler(struct rtrs_con *c)
 {
+	struct rtrs_srv_con *con = container_of(c, typeof(*con), c);
+	struct rtrs_srv_path *srv_path = to_srv_path(con->c.path);
+
+	rtrs_err(con->c.path, "HB err handler for path=%s\n", kobject_name(&srv_path->kobj));
 	close_path(to_srv_path(c->path));
 }
 
-- 
2.25.1


