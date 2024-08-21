Return-Path: <linux-rdma+bounces-4459-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253AF959A81
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE176280DDA
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFD1C4EF0;
	Wed, 21 Aug 2024 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Y2njDS6l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88C01C57B5
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239406; cv=none; b=UjP7nuhl41UM9Cn+IHW93Y7tqtSNwWjhZoL35Vh8JWKkH1fNf7wYqts/vDPATCXWF5BWzoYUWJj80lMA6GPp0UNu0BE0yH46i0jueUXoxE8cX1cTpr8Ux5+w3QbmAdFYNCaWqPIRxtsg7oju7zCkwM/+iRrKNyShTBuIGXyoIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239406; c=relaxed/simple;
	bh=1LhXg5xWDvGPRaEsg0/S2HfUyvu2JUtIJZgNQ284l3k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dhqfb86s4R1Cl1yHTSN7birsvKXxD+iJJLoQnGNhSjXMp4jLFqUlkm3aLwPe1YcTZVx+4QRaMTlXATDDnCZqbi/Rb7gxvQl/Etn8DfxE52roclQf6VaHCAKCGJD61HX5IAqu/IAarYEB63u40sX8fFPWlc8+rGMAnX5fykwpKLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Y2njDS6l; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso4150829e87.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239403; x=1724844203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlZP5HgK2ScBazOgpen0WVZnjmuyRXH0hLPE2FocaPA=;
        b=Y2njDS6l4iUQNeslCIXb3MGD0dYrG1eq4uxeRgHDmi5TWDXoih3kKWVZDq0IBegWCD
         edlbg5Fqz5CqoM1etmBzufyWPnHRJFc2q+8nS8TRySDHVbB+gS2jf69s2P02Ijf+Ug52
         hujUEoTV1eu/hqT5FATZmuTwJvvwxUQEg/Js74wM7Ef6DMw0DWgFutaUsyFhO3r+9jvB
         ncmCpC24X8JFur0utyGfCU9RwN6S8YorSAVFIzqZlt8/+7MvawByHthq4f9p0VFNm8z5
         iTPu0xQCJRKXGzTBc+rrJJsOVljLNqzZCk8damyxflpLCNtq1g1AZDjNALlJbUvGNtxk
         6Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239403; x=1724844203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlZP5HgK2ScBazOgpen0WVZnjmuyRXH0hLPE2FocaPA=;
        b=pqH0BZGEkpeygWxdK4ONJPer7o/8HXe3Lg28uwTnKN5D1rUxKdZMd8iaBmSqQotPbw
         VQ1PjrtChWTW9krwIx/H/fWSQ4+Wgzy0CCQO6IcnGpL5GXXZCdTcfttU6Ywu0unduaU4
         kD3v+OH9QGElJUFXVM1jGLMFcaOcoegZst5omhVY6mFpzf7LjbI9KMmHPGwpiGfZN/tU
         JI0/yX9H5/YyBPJoO1Bz5CxlqQ1wxt8ixB91cheS1KOqRwecx3rp93zeXQqpVaqVMFiu
         42dvuhegt3NVSWprR0NT7mNGa7KDYoYn9q3TJ2RZ3Ov7aymI0Y2pJRgjrN2sIB82ASjP
         YhLQ==
X-Gm-Message-State: AOJu0YxH2+Mrd+HDXx5Pftfmer6UJHLVV8Sa0GxK2BF99TMSzP9bqSNU
	FY4IGCnFM0HBCN7Li0/GbJbgaS8MXBszpGcb7zLJKF+eoe7+i8wPYxRfo0I6RFp2K7v5e4lOOas
	GiDk=
X-Google-Smtp-Source: AGHT+IEYtXLEE3wuknGU0Iq7743MyCEhVpKlPm073YUOdKVLgFs+BKlBLI3YieWSItAQUYRDjA9qlQ==
X-Received: by 2002:a05:6512:2308:b0:52e:be1f:bf7f with SMTP id 2adb3069b0e04-533485c05d7mr1078649e87.27.1724239402180;
        Wed, 21 Aug 2024 04:23:22 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:21 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 08/11] RDMA/rtrs-srv: Avoid null pointer deref during path establishment
Date: Wed, 21 Aug 2024 13:22:14 +0200
Message-Id: <20240821112217.41827-9-haris.iqbal@ionos.com>
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

For RTRS path establishment, RTRS client initiates and completes con_num
of connections. After establishing all its connections, the information
is exchanged between the client and server through the info_req message.
During this exchange, it is essential that all connections have been
established, and the state of the RTRS srv path is CONNECTED.

So add these sanity checks, to make sure we detect and abort process in
error scenarios to avoid null pointer deref.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index ffd3e80596d0..05d15ff074bb 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -935,12 +935,11 @@ static void rtrs_srv_info_req_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (err)
 		goto close;
 
-out:
 	rtrs_iu_free(iu, srv_path->s.dev->ib_dev, 1);
 	return;
 close:
+	rtrs_iu_free(iu, srv_path->s.dev->ib_dev, 1);
 	close_path(srv_path);
-	goto out;
 }
 
 static int post_recv_info_req(struct rtrs_srv_con *con)
@@ -991,6 +990,16 @@ static int post_recv_path(struct rtrs_srv_path *srv_path)
 			q_size = SERVICE_CON_QUEUE_DEPTH;
 		else
 			q_size = srv->queue_depth;
+		if (srv_path->state != RTRS_SRV_CONNECTING) {
+			rtrs_err(s, "Path state invalid. state %s\n",
+				 rtrs_srv_state_str(srv_path->state));
+			return -EIO;
+		}
+
+		if (!srv_path->s.con[cid]) {
+			rtrs_err(s, "Conn not set for %d\n", cid);
+			return -EIO;
+		}
 
 		err = post_recv_io(to_srv_con(srv_path->s.con[cid]), q_size);
 		if (err) {
-- 
2.25.1


