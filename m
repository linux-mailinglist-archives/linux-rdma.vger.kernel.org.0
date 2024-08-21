Return-Path: <linux-rdma+bounces-4461-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97740959A83
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5121A1F23B47
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F071CDA3F;
	Wed, 21 Aug 2024 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XNsEvX1/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29F1CBEB7
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239407; cv=none; b=Fz1u60YehcJus4AmUgX7N+hCvKiRHZxvhgB/pg446mnOy5KOqP+vG0tAN08fsZM3f7w4vEqvKu8UaKHNdh77fFF89wbzRQuuhzo3rLGTERkKBhyYcqBGe44uRMXdW65sJNO9eDOXLWbSmvodEJsNQT5HOobnGSDNSteIIomE0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239407; c=relaxed/simple;
	bh=xLcPXGIQYb8rDHlaDSABgBgt2ojUJwEMbr395zl0B7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrQPZqh3IRoPPB817vCBg6qWFBC22uC3N/GYFjEpi4JvLHEQS9yvKAwm/oKbu7RE7aBeUh2mJJRvPSEJwKQeWIOJIuZjqB390nl3sFHIe1EeRueTZoqDHNqUs0tIEikGic0EAWYOjlvM0mb8eG10MxeacIPPKrYAX+meCqlPhwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XNsEvX1/; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bed83488b6so5660210a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239404; x=1724844204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQMKt+Z6oU8k718oVYzHw1t/snarDjAZbdeYqhgVzX8=;
        b=XNsEvX1/G0b6/Z1OHuIfGrO2K1NadShV2KmmrTFXZfDHEDHY0D9JOyqI5x3Ogam/ia
         tpG/aNLjlKHoUmo3biplRRF219dqjIUWuZax901tWMRPyImpbOkMeFQXQYheOriqtfAq
         Ry6Yb1TdL0OYk9ZpZ50pUFlIaZFAU0T0FPNnR205Uakf2Urox7seM3Sl2NIw5KY8lSK/
         a2054mq148U9fH8cDiJ3BTc90qJu8Ktppit8xtP4vsvafAAG6eV1AQUqMQiOqMN+ljI9
         PtN6B1BFDKt7vdKn9HegapbnledzQe26M7qoaT59QSZuEqNJTVG7rlPGOzI79L5tmpsr
         U9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239404; x=1724844204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQMKt+Z6oU8k718oVYzHw1t/snarDjAZbdeYqhgVzX8=;
        b=itPPw9VIF4thZHJaZbhmz9H1HsDikSwT+r6dkWNKgcbbxReLMjZjbrvEHKsZhk/BMq
         dU129IoultNGa80MXHp7d+xwn+IXSCDh2m5tBg3hFmkHmOaEewHXV14W2zJYQj7YmDUh
         gelNt5BUkQnlna1DCOR4T2Fh6B+h0D7rcc8Lemddg6gHUMD+L0aitpyXQNImIkfd2pTA
         D2Ot/9F5ELbEt1YBiVETZR3gn6d/PNX8iRUhgLAjqVTlELnwSS2ft3EVeT8MT1jxMLvb
         22VRwa4wEWKGeqmpcvpjyPQgIaQZQXMTlPco8+C7suYGSxidljE2iSg8exuZnqZVL5tj
         Dgcw==
X-Gm-Message-State: AOJu0YzyZ4PsOU6C7A23QZdWp3pMQS7ZVu7ew9nZdpUrURazneEc6nys
	5I5FPAX9ss+e+DRoanx8Ffca4UnVw9yMgD2+3R7bwUpUH8sUhg0WzFoZrYlo9D/kl8hxC6If62u
	r50E=
X-Google-Smtp-Source: AGHT+IGDXTTnoykTio+IMFeSLV7X87G4m3Oowqfq3oV3Ef+KLkLk+zJIaxobu3fb59/DVsmz53UY1Q==
X-Received: by 2002:a17:907:f1a2:b0:a7a:387c:23f8 with SMTP id a640c23a62f3a-a866f125490mr148115866b.3.1724239403641;
        Wed, 21 Aug 2024 04:23:23 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:23 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 10/11] RDMA/rtrs-clt: Do local invalidate after write io completion
Date: Wed, 21 Aug 2024 13:22:16 +0200
Message-Id: <20240821112217.41827-11-haris.iqbal@ionos.com>
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

From: Jack Wang <jinpu.wang@ionos.com>

Switch local invalidate after write io completion avoid the
chain usage of WR, this fixed the local protection error on
LOCAL INVALIDATE WR.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 230e5f6c8c90..fb548d6a0aae 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -395,9 +395,9 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			/*
 			 * We are here to invalidate read/write requests
 			 * ourselves.  In normal scenario server should
-			 * send INV for all read requests, we do chained local
-			 * invalidate for write requests, but
-			 * we are here, thus two things could happen:
+			 * send INV for all read requests, we do local
+			 * invalidate for write requests ourselves, but
+			 * we are here, thus three things could happen:
 			 *
 			 *    1.  this is failover, when errno != 0
 			 *        and can_wait == 1,
@@ -405,6 +405,9 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			 *    2.  something totally bad happened and
 			 *        server forgot to send INV, so we
 			 *        should do that ourselves.
+			 *
+			 *    3.  write request finishes, we need to do local
+			 *        invalidate
 			 */
 
 			if (can_wait) {
@@ -1085,7 +1088,6 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 	int ret, count = 0;
 	u32 imm, buf_id;
 	struct ib_reg_wr rwr;
-	struct ib_send_wr inv_wr;
 	struct ib_send_wr *wr = NULL;
 	bool fr_en = false;
 
@@ -1126,13 +1128,6 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 					req->sg_cnt, req->dir);
 			return ret;
 		}
-		inv_wr = (struct ib_send_wr) {
-			.opcode		    = IB_WR_LOCAL_INV,
-			.wr_cqe		    = &req->inv_cqe,
-			.send_flags	    = IB_SEND_SIGNALED,
-			.ex.invalidate_rkey = req->mr->rkey,
-		};
-		req->inv_cqe.done = rtrs_clt_inv_rkey_done;
 		rwr = (struct ib_reg_wr) {
 			.wr.opcode = IB_WR_REG_MR,
 			.wr.wr_cqe = &fast_reg_cqe,
@@ -1142,7 +1137,6 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 		};
 		wr = &rwr.wr;
 		fr_en = true;
-		refcount_inc(&req->ref);
 		req->mr->need_inval = true;
 	}
 	/*
@@ -1153,7 +1147,7 @@ static int rtrs_clt_write_req(struct rtrs_clt_io_req *req)
 
 	ret = rtrs_post_rdma_write_sg(req->con, req, rbuf, fr_en, count,
 				      req->usr_len + sizeof(*msg),
-				      imm, wr, &inv_wr);
+				      imm, wr, NULL);
 	if (ret) {
 		rtrs_err_rl(s,
 			    "Write request failed: error=%d path=%s [%s:%u]\n",
-- 
2.25.1


