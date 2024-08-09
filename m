Return-Path: <linux-rdma+bounces-4282-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E77794D0F8
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419A51C2156A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0F194089;
	Fri,  9 Aug 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YIMiDe5r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570D195B18
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209364; cv=none; b=mn8pjC3RU+PtDq4BQWc4SnJKn5fuPEnvsXHGFeucXJ5uMOpB6X7gkrpo/qERkMHgid+MHgA+KTqWQ4pCeMad+u6/50qsunMAStS2WhI3lMpCB/VaTyc5tW/ULK+fv1gzWXRIHGMDwp2/WHhNZDnQ4wT498x/7Ua3a1eCTVzTT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209364; c=relaxed/simple;
	bh=bDW/dF13VUplmcG0FnCFuS1gT0xUyjb3t46RhgMKjUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kchnNhWI2uXAXH6tX+Erah58DBsd8FXlix9dTsC05SCTAomAALlxVRE3U01XltjUPbFreUczz165udu3u1VESVechBIukVf7b69zr/R+iCJvtthO7SbJXcJnnhLQPhAhCW7L7oYSE6d7g//arV01+9Av+4hy965nQkmY86h9M3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YIMiDe5r; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso27889451fa.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209360; x=1723814160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN/3NtEA8ChzCaWTJF8ZmgksgTpp42boQxGcCG9OcqE=;
        b=YIMiDe5rmxjHqGFBXiSQRESme7CoEO5T4zpkFwsF5Akt0isRt4ILLMhB+IFMGcONvo
         YV490nDCSEDSfP8IPgqdxuoWec159g1ki4zybH4hHNl/6zDH02csmyg+1AgOax65VUbc
         r1/5TkUTgEHIxCs2nX9ignWqnzFv6iNFQFXrr/I6jIIXCQ4IMvA4VaU6HXh19txiDH6w
         CxAlxOACVZlFz+VaJZ0JGTvz1UlPUzNrjj9o5wSnMpLk62Jwa9UuR+yxWdwqAz3EU3lZ
         DVioR5lmlbYD/YMKtHSGln8/u7MjtAQ1/oSfn62FYHTp8kQ4uVx0LYBi5ofX6gsoLiMF
         ixFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209360; x=1723814160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LN/3NtEA8ChzCaWTJF8ZmgksgTpp42boQxGcCG9OcqE=;
        b=I/kX+NkyholqQE1T22Az/11Xlhdjnt+8J16Utr1fg//USoAUlzslmZKBCv6bb8aHoH
         2ryByYA92BF/yrysnKVRmdiCe9f/1DjQGCCg6lYrqYAeVGzevjBDYxf1ifPK21rurphm
         QdNRzNGGArcxhWzl7GT6pqGJFIEz6+l2bIGrnC0UoaClTfLr6Vodyj/AeGEZ05oIWGZd
         F/D5s7ZhYg7eIpZ+AYKRljMrG/aG6U87FUcmPq+hUBhTAUIDaORkDxHg+vK0j5WP3blr
         cdemVLZrn8sTVGDj1udux1YeR2WilZBOVr5TQy7275nLMuPXDtwjVppd0vmEKb+OfGVa
         zpdw==
X-Gm-Message-State: AOJu0YydsUPGdQJ9UglJhJQLuGUxb/3+g/pL7HZ0KXDiPhpQbblWt9tY
	uAvSEB0EZLjGiOiRaeVhr39xJvcCqU6XltxP0DXG8JL25tjr2eFJDRaK9kmReEwguVrAZwX7X4F
	AUuc=
X-Google-Smtp-Source: AGHT+IEttW1/uGKUeVw42t5d5ekfysknQZ9MJbkkrqAFgAGNt9Fmek8l5eJy6OItypje7dXnaNpRYw==
X-Received: by 2002:a2e:b5ca:0:b0:2ee:df26:9d4d with SMTP id 38308e7fff4ca-2f1a6d6f776mr11485201fa.47.1723209360488;
        Fri, 09 Aug 2024 06:16:00 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.59
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
Subject: [PATCH for-next 10/13] RDMA/rtrs-srv: Avoid null pointer deref during path establishment
Date: Fri,  9 Aug 2024 15:15:35 +0200
Message-Id: <20240809131538.944907-11-haris.iqbal@ionos.com>
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
index c7aec40d4934..fe8abbe0d2e9 100644
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


