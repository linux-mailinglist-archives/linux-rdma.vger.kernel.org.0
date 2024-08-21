Return-Path: <linux-rdma+bounces-4452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D3A959A7A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B84281CC8
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA81C4ED1;
	Wed, 21 Aug 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hQJjiGC3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5D1B2EC4
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239401; cv=none; b=ewmtztCiiPbfuD6m0dXuL2yZIPEcyY4PDL+Bfv6vCHb1SlzmiAR83M46EWM70PgitFZt8jC4dBar3q9YPHBsYtZ02tP8srStK8sDddl2OqmKf2m5SHnZywtALjYXTdltaUh1nETByIGrksxrAi6eP28bpKDB6jZ3czFNWRgb+b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239401; c=relaxed/simple;
	bh=/cLqBgzuz+7z5BY2d9XvPUSzLLAqeRO8SPA9GHWbjCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AV8aHXj07tmRB0f2MPUndy6wPy1/u6NZtGbr4J3x2+IMpMRILdM71NGVUd5WLTMBOuYsbc5Ip3O7AFtRvavItwmxYiX1hBuZke4Q8jXJOGxwH7BPORYFGL/OvM8Z4Yk8+NcoArhM8uqHo9RnwcrfNaT5DdjtpL4XxVEjYAT6rxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hQJjiGC3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a8679f534c3so52577266b.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239397; x=1724844197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoj06T1lLnrz7lemwh9MfKf9lHfPP+xBU9RJw8REbTc=;
        b=hQJjiGC3S9GRNvWkrPyuiFncdian6RGEgW6oEcq9NJ/yugdenjSqUDrBrk9L77U8/I
         YYZ+ZNwg5lItMjXlZ1Ugkaw3yTjxW5ULoRoMt/A33walTy44LxBj8jS3+SyuMrcS0bhh
         OaCjt38QvrrAGMJHlsrxLF5bJeTmikIjEu147jZpiYKg7xxCyU2DbdGOXZ7wQi1jMonJ
         JA3wBva0RoB5DFnzMqUaoy0xc1daTQD705SGIsUUHMGQmCgsDQ29jXZP9p5vXGVYBs6j
         DTqts88HcZobc+B45oPPD0vIFpEI432roA8765yfHIKE7MTntawoeEW1hnApCauwOKkd
         h+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239397; x=1724844197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoj06T1lLnrz7lemwh9MfKf9lHfPP+xBU9RJw8REbTc=;
        b=PCmnVOBoW0cY9pkn93icqq4nD8aZHTV5t9UT9FSe91nL7Lp32WR2IHV4onTvcltjEm
         JznnNw0WKQZPjDISvGC+JBwcuYxJSUx33bMfbVHitKPAfLj76eoQmyouXDfLfuTkTw0a
         nICg8TeiET4uErbbndkV3DPrUOkfHQmmvJXy1/LnV15gRAweixVaAUkonVGPJylRrJMR
         +AuNl2cKFMWpm+ROQwnuHKllftGw3RxDBEazAPase/E1uyUKH2whxp1X7suzZlVlJfsD
         SFrkoqn/bd2+qsDRmisn2o/+vjgT1a71kEyONLjaTgLHGHa8eoe8ia1fM+5FG8qeE1HT
         pF5A==
X-Gm-Message-State: AOJu0Yw8vNXbCIKLlO7dvBmHvmBHWvAl/JkKNxP2EbMXJXlQ9kT/nABo
	OoccNNOXl2DfTe13Q0PkRsMHscWCi6E+JamjbWJu1J0M5D5IYkFi8iCEE3KYsoBwN3e1UEUneLR
	ACGM=
X-Google-Smtp-Source: AGHT+IFb9xoBpPiWxcZPQwvzY1vvNaFDW2JUcaxPfsLySIEhkbJ0plPU/Nub4R0zMJuJX1/+r1cKHw==
X-Received: by 2002:a17:906:c106:b0:a7a:be06:d8dc with SMTP id a640c23a62f3a-a866f893f11mr136936066b.48.1724239396898;
        Wed, 21 Aug 2024 04:23:16 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:16 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 01/11] RDMA/rtrs: For HB error add additional clt/srv specific logging
Date: Wed, 21 Aug 2024 13:22:07 +0200
Message-Id: <20240821112217.41827-2-haris.iqbal@ionos.com>
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
index 1d33efb8fb03..f76d483c3784 100644
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


