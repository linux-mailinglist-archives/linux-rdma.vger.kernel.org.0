Return-Path: <linux-rdma+bounces-15356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E18FACFF210
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 18:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2FAA326B564
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D5435F8C7;
	Wed,  7 Jan 2026 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Y+zcpwjM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE50A1FCFEF
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802539; cv=none; b=foYXdArK0fwtwBrh6415B8M8hDqV41u0em3uj+8Q0MfWUyIuI6TZCDhqVo1MChLxSASY9bEWunjztnkBfedj1GltyovE3o6oNcezAKrFVCh1BOeCpycAvbtE2Sb+7SBlPRta9Nj2Gz7YS+7Y4gAgmM50C84+/wkggS5WiJFqSyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802539; c=relaxed/simple;
	bh=V3BBKkmfnBkdyaCY39U2ZJJl6WfMXXaDLxlj5GWZ7aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l3WzvAC31H8WSdI9PDPxwSAPoF1ZOh33DdmwMmN8+X19SIM9zIBnERFNUlMVVIYCWWn6o0MUu14/XWBVjBHS+5kHNTlvOBScZU9UbDArgJDEkG0wS9QzP3+La28v7hFkYS8ow7UXBmsVcrNBTCpyYUCNeBHmqPVNpvPfYIiXpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Y+zcpwjM; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b9dfc146fso1980521a12.0
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802526; x=1768407326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k1NTv2UoowQVsXGv69jvwWJ7AaBviNCdCwteUJOS4M=;
        b=Y+zcpwjMipxnTGtA2JjMSMDtq7Gb5Afg4E+aXhyN2R/4cxNmNSfmoLmStWM8y1ch/C
         wyYKqtIxqDtSA5S0csD+mqf++ws59OhnRP8dfbnXaOrdbXSQS1EW09mApn0ddmtCE36v
         a1TTUUYUPjDMctQnKgC/Leqhf4/5OMqinoxW7fvcHpbedTb1rTfi4Cj82JcoYFcLDviW
         g2ZRqoP/xBVBbyzAkEAqG6oHfoiGBfholKEzTgQ2tZUrqiKqcN/OuhzoPIVDwwsoY6dX
         Jnk/tX70LV2JkTjwyWALbGyE+kKBQZ4TvmSjkSyjqcuCRZEHTnBf5K8gII6WhuW75Z2W
         9HtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802526; x=1768407326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9k1NTv2UoowQVsXGv69jvwWJ7AaBviNCdCwteUJOS4M=;
        b=jAD+v6ZGkDFB0SW2h1YPEL1KFoLz97rW5B8jV5mxWZ+624pMzOcBgJUkHqGXor/M6J
         H9fYT6aznr88TQNvyOUObUA5baTuQrYjXYJ96V22FQUWJeFdxIqVjE8ldQtb7WUD1E35
         WiV/TqyifrvNjaXU7qbBe1VgrMFRuqLW9anSZHf4IMSGuKTDE/xFNVHsgSFrP//Lxfz4
         6YyYJxmTgfomTaUvtxf9g6l0VLvIc/swcebvo6XXEjT0skUAZfsEZDQM9o86JnPFDndT
         cJWDBwVbDiwCMZbluJA/PEv5Xm6dd9Izt//H8lN6SLHp23hPWBroS51k5GajA5qRJ7g7
         LOxg==
X-Gm-Message-State: AOJu0YxuA1jGVkot4pc7mUsAz0k6Yu6oHZpWYD6Od3ypgX4YfVrAO8m2
	xhF2m8d2XhzQjwGqd6oTYAa3oQc6DHJU3pBo2LCRqBnwbhJXNHJLThFzDIs64uy9n2dofGvmIua
	PHIo39p8=
X-Gm-Gg: AY/fxX57HQkZjjHgyxz2ns0A+bI4221c0kQzqZP+qPy3qfK4RZPDscR7QLuHQE0693y
	X52bLmG7YsU/FyiYgkPkfyjT/i5uBSm+CNj50HbTkkS5TezxHpN1VxZxPMhu2Mdez2mK/+olKcI
	iphzzZtFPtX3LVhD/pjR+AG/E548WSsM75ZFOqLDyhwVRp0ACGF3xwYTDQpwJkuvCN3YAUpHnFN
	fyLaENuTz2lOzpAxNhQchZRgNfWSEyqBUzM7/+fr/VV6RxTilOi7g8ZvU9bOelRCPLJA6gq1c3l
	NFAPzNTj4ZHFSZ1p1lfjtA4Fb/KOf1ANNW854tFPYWqOuuVRLlbsnM1YbUYuDOk8pUtcovx+0qK
	yiKEdqW4oMgZLVEq/E3iD2IgvXxUMt1jpUHoTWSUip1FKDst+V5m7BwiRqH3acQNSqQaf01TDJP
	eUrRmQlGfYqS+EOB/SKdb4qmt/1ZOY0ohykUGLwpQmRPDbpBviHNtEWcnRyKaSkFtSZbEzQNoH2
	PzzhrA8jhfhFmQ8Za0ZXjE=
X-Google-Smtp-Source: AGHT+IHhTuG7foO0/3uBColi0fL9RdVLc8pdf/0wAjzY7zovpYeAxQlLfIE1cZCLsCOJr7aPu4T7cw==
X-Received: by 2002:a05:6402:3551:b0:647:94e1:800f with SMTP id 4fb4d7f45d1cf-65097b99f05mr3377433a12.8.1767802525739;
        Wed, 07 Jan 2026 08:15:25 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:25 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH v2 08/10] RDMA/rtrs: Extend log message when a port fails
Date: Wed,  7 Jan 2026 17:15:15 +0100
Message-ID: <20260107161517.56357-9-haris.iqbal@ionos.com>
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

From: Kim Zhu <zhu.yanjun@ionos.com>

Add HCA name and port of this HCA.
This would help with analysing and debugging the logs.

The logs would looks something like this,

rtrs_server L2516: Handling event: port error (10).
		   HCA name: mlx4_0, port num: 2
rtrs_client L3326: Handling event: port error (10).
		   HCA name: mlx4_0, port num: 1

Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 7 +++++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 393b5f35ff38..5e9f2153936d 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -3179,8 +3179,11 @@ int rtrs_clt_create_path_from_sysfs(struct rtrs_clt_sess *clt,
 void rtrs_clt_ib_event_handler(struct ib_event_handler *handler,
 			       struct ib_event *ibevent)
 {
-	pr_info("Handling event: %s (%d).\n", ib_event_msg(ibevent->event),
-		ibevent->event);
+	struct ib_device *idev = ibevent->device;
+	u32 port_num = ibevent->element.port_num;
+
+	pr_info("Handling event: %s (%d). HCA name: %s, port num: %u\n",
+			ib_event_msg(ibevent->event), ibevent->event, idev->name, port_num);
 }
 
 
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index d5189f12d2f7..09f4a16b4403 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -2342,8 +2342,11 @@ static int check_module_params(void)
 void rtrs_srv_ib_event_handler(struct ib_event_handler *handler,
 			       struct ib_event *ibevent)
 {
-	pr_info("Handling event: %s (%d).\n", ib_event_msg(ibevent->event),
-		ibevent->event);
+	struct ib_device *idev = ibevent->device;
+	u32 port_num = ibevent->element.port_num;
+
+	pr_info("Handling event: %s (%d). HCA name: %s, port num: %u\n",
+			ib_event_msg(ibevent->event), ibevent->event, idev->name, port_num);
 }
 
 static int rtrs_srv_ib_dev_init(struct rtrs_ib_dev *dev)
-- 
2.43.0


