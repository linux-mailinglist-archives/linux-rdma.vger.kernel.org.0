Return-Path: <linux-rdma+bounces-4276-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0F594D0F2
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 15:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07CB28414A
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 13:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789191957F8;
	Fri,  9 Aug 2024 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="g9QJBbkT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0B1194C7A
	for <linux-rdma@vger.kernel.org>; Fri,  9 Aug 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209360; cv=none; b=Wz8sup7dD6GE5CgbIX8bHZpVT9pJcy49Yaw7Ehc4ar8XAvz0/BNjkHZcbekICEvykTsfxwKrQSot75hpeHiZZRBOrP0ftN3/ayQB2865Gj9Ao46rKc1IUgMatcO/d1ie7k+TQ0bidTIxinwuV6ELLa2+gbtkXY/R8RKAL9axNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209360; c=relaxed/simple;
	bh=aPdeol5t6wwSSHxVfJDH5JF9MYqzC9pPQihHi5HNRHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YqX26JZrGOFJyIU8BSdKYY7zinitlL5MrJ+sJgKVXypLtGPH9cPRTXvbwwO9/w8EidejEg/RkqeGPEkSXJNO7ml0qu7sZ2kzu851O5+zdG4O6nlSFke8LH4Tjt7v81D2edjHeccZbo4eohS0cPKM5sJpdNj7hpydWaWiAjmb5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=g9QJBbkT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e0d18666so14762345e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Aug 2024 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723209357; x=1723814157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qJ3V7YJGTaGdVFsVivjHiBFvmyNekMesA0jctJoY0g=;
        b=g9QJBbkTQTyIrTSnjceuS5cDSADGHqhd6sk7WoQbcvi/qBtK3La2ybK8hbJDZHVAuI
         g6zlR8aN56OOT/SXB/vFf+rc7EF0BY74IhPHG+5zHSO9pSJolKrYr+ccxuadneLYekdt
         RxnlZpa1+rE3x+NlFzpLZyzhZwdDFBRjXCFdG6g66cQ3Dm5d1+vEPVzaxe0ZcjOiJfAo
         r8W0k0lyNCO3QZZq2562L2cdXRZvS6efT4dwKqUud+vp0Lha1L7MWZmrECwQ0S7dNzNg
         F8ToOL6GoZScUPiDUjyXIIeZ3kxkog9w7EOKwEpiIFzN3lyKUaWSXIaHHdS8q6FSr7PO
         r3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209357; x=1723814157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qJ3V7YJGTaGdVFsVivjHiBFvmyNekMesA0jctJoY0g=;
        b=LdJsvZyqpxLFZm3EVcvlL18UMZq4HkoXDtUpY3FmAyw9/Dg71V0M+MDG2uNsqUInP6
         Wl8vFom+6UHf0G8F/bo7x06cntRQXhT8AcK6O2dHP0NqfL83XjZJODUQ3CGrJ0Fr7tcI
         Xan+8ukWhsUkhn96XCGZilzSbD7ftTwdWeSJ8rJiK3JZaZwLcRxqdNSj4r96VzZKlCib
         1dHP/liYD5VUbu8q+Z4a/yXzUu8rNzeu/zpmZbx5i0fAayrnAqNsuelrEWSx+hof9G8d
         MQWMIjKaXYePGqwng237iJ5oSer4vG1t33Rjr8cG5Ch1GBbxEmIbxTB0USt4V8yWU4dO
         iJOQ==
X-Gm-Message-State: AOJu0Yw72uf1JZjK+JFpmEM2SmAsHEjZCJhpzRUjSRFW7gPpG5pTMSRT
	2xWB6A6Kg3NbQjjrviPmJTuGnkgjhG8CNvDdU6iECueQiBKJYkf/m2YWkuKCTa5KfFf8Sn/Zbz1
	A82s=
X-Google-Smtp-Source: AGHT+IHlt1+BIV9S4Y0Nh5RjJBXf5glbMu0f9sBcmKh1HWNwwD1nNhO3bJ+cIo25rAT/MRFWkGJAyw==
X-Received: by 2002:a05:600c:314a:b0:426:6eb9:db07 with SMTP id 5b1f17b1804b1-429c3a1bc51mr11322155e9.13.1723209356576;
        Fri, 09 Aug 2024 06:15:56 -0700 (PDT)
Received: from lb01533.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c77f078sm78280625e9.37.2024.08.09.06.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:15:56 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH for-next 04/13] RDMA/rtrs-clt: Fix need_inv setting in error case
Date: Fri,  9 Aug 2024 15:15:29 +0200
Message-Id: <20240809131538.944907-5-haris.iqbal@ionos.com>
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

From: Jack Wang <jinpu.wang@ionos.com>

In some cases need_inv can be missed for write requests, additionally
driver has to handle missing invalidates for write requests. While at
it, remove the else case from write invalidate path as it is possible
to reach there.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 66ac4dba990f..d09018c11ece 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -391,11 +391,12 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 	clt_path = to_clt_path(con->c.path);
 
 	if (req->sg_cnt) {
-		if (req->dir == DMA_FROM_DEVICE && req->need_inv) {
+		if (req->need_inv) {
 			/*
-			 * We are here to invalidate read requests
+			 * We are here to invalidate read/write requests
 			 * ourselves.  In normal scenario server should
-			 * send INV for all read requests, but
+			 * send INV for all read requests, we do chained local
+			 * invalidate for write requests, but
 			 * we are here, thus two things could happen:
 			 *
 			 *    1.  this is failover, when errno != 0
@@ -422,14 +423,6 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 					  req->mr->rkey, err);
 			} else if (can_wait) {
 				wait_for_completion(&req->inv_comp);
-			} else {
-				/*
-				 * Something went wrong, so request will be
-				 * completed from INV callback.
-				 */
-				WARN_ON_ONCE(1);
-
-				return;
 			}
 			if (!refcount_dec_and_test(&req->ref))
 				return;
@@ -1146,6 +1139,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 		};
 		wr = &rwr.wr;
 		fr_en = true;
+		req->need_inv = true;
 		refcount_inc(&req->ref);
 	}
 	/*
@@ -1164,6 +1158,10 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 			    clt_path->hca_port);
 		if (req->mp_policy == MP_POLICY_MIN_INFLIGHT)
 			atomic_dec(&clt_path->stats->inflight);
+		if (req->need_inv) {
+			req->need_inv = false;
+			refcount_dec(&req->ref);
+		}
 		if (req->sg_cnt)
 			ib_dma_unmap_sg(clt_path->s.dev->ib_dev, req->sglist,
 					req->sg_cnt, req->dir);
-- 
2.25.1


