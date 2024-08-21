Return-Path: <linux-rdma+bounces-4455-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB0959A7D
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81F81F21FE5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB7F1C4EED;
	Wed, 21 Aug 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CUqTXRrL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C947158544
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239402; cv=none; b=L0AGTMrymIa3nvSneLlpuaJ5YSvqAgf//X68xBpOUXRFqM9lgrMzRIvOPALAFriy2ei8UD8jSIHKiNgzjxlv28fZ2zf9eWonrlYXFOtvZkUXnsMZpoQAb1pxKxlmwajuaapupW0r0OVl/DYD1WWuIFRM6g02lreChXVLC46hRtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239402; c=relaxed/simple;
	bh=/6OItEvvxYPlrrVGtyxJUaH8vTuT08SMFkHPMeVL9XA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E1rrsDpcJ6PxzKNM6QhPkmGdaahSjLb0qHdyoYhTRcM3XXWIS7mG4xBLHRp0LSBDen6Ug1XNojRj4EBcwBAydKeeGB7sm+sDwrmXg8ZwZn9nuGR2Gwk586DbrjA9yKP/PQE01nK1NcaB8cMHX7aexqrWqb8zP0mPzMQ9wUXiZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CUqTXRrL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aada2358fso106518766b.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239399; x=1724844199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE5YcoXaJNOQSKQWGfiOqDhkdWpVQdl73GYH6YX7gvI=;
        b=CUqTXRrL7kukfzg05dWjnkul+uhnH1tO9KVzJAWwnzJadoE0eS8uKfvap+gdxbxCww
         hj4zeJhV3o+dmcMrI+y3FdSgTy9tXdECWFoI9fwCvJHUr1fOAoUt+QFWIin/yGWmY3SH
         0PVs2B893C4eNIqCJdKaArHYcd8O1bM95bn/OQ961mvngBYCnhTZZPqjo980pxTCUJrS
         H8E7qBEHIqrRJBXh27A5b1M5XXQAFmG6Wuezww2ciGuRxhNleOxcXaVMTeNLOwPNlX8M
         viNpr7guLF8wlNflakWdJn+R0OVKEIQ4dt+EjdLkdhW3eBVkPYXn5CYIFk/xFDCB75zx
         l8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239399; x=1724844199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pE5YcoXaJNOQSKQWGfiOqDhkdWpVQdl73GYH6YX7gvI=;
        b=LbcsfZcxHlKefJfTGk50e7JdDCe/pFJYfNAmeYdiDoaud9wOBvojCexkzQocvKB6fK
         V+RQ2DVSpQ2xuq0h0/roIn5ivuLCBwmFuSZWeD//I6iOWukegaJOSJnkSV11m85HAOwv
         iovuaRELc/IZg3a/Nga2nWKVxguWhyGo1lkM2TZaRqq94ozUmHZ++SO6TEQdg2iJjWHb
         OQBmVxQrrqmebhaH0N8ezFMYxXmaC/eJkGmjSvvn3LlWG9oLRMh57fVU30LqH4z/ROwI
         TFp4wCvl6/fezU0cerxrLhJwk/tW4OkAEVnHuvaZc1xPbQP/tRBFlFZOUX7yLQilVCOJ
         NIRg==
X-Gm-Message-State: AOJu0Yxwvz6Utn1bMotwGvKN+3yLPwnuv5+mh61AF2FEqLuAk053Yptq
	py2PpUxprInXMnkf4jaIGgTKs/s1BUIiQQ4/45TOJraSwFT8xnsUcGHfKxtesGJqLd70zsA6Zaz
	sDMM=
X-Google-Smtp-Source: AGHT+IEx/uZ5Zjlhi7tgtAwgfiJWMI54Vgp0Qk4v+J08s4AHJI6sKYUAB2OjVJHvC88qyP2JgzV0mw==
X-Received: by 2002:a17:907:940d:b0:a7d:c382:bcdf with SMTP id a640c23a62f3a-a866ff4be1bmr179248666b.10.1724239398926;
        Wed, 21 Aug 2024 04:23:18 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:18 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 04/11] RDMA/rtrs: Reset hb_missed_cnt after receiving other traffic from peer
Date: Wed, 21 Aug 2024 13:22:10 +0200
Message-Id: <20240821112217.41827-5-haris.iqbal@ionos.com>
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

Reset hb_missed_cnt after receiving traffic from other peer, so
hb is more robust again high load on host or network.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 3 ++-
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index b34eb4908185..c1bca8972015 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -619,6 +619,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		 */
 		if (WARN_ON(wc->wr_cqe->done != rtrs_clt_rdma_done))
 			return;
+		clt_path->s.hb_missed_cnt = 0;
 		rtrs_from_imm(be32_to_cpu(wc->ex.imm_data),
 			       &imm_type, &imm_payload);
 		if (imm_type == RTRS_IO_RSP_IMM ||
@@ -636,7 +637,6 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 				return  rtrs_clt_recv_done(con, wc);
 		} else if (imm_type == RTRS_HB_ACK_IMM) {
 			WARN_ON(con->c.cid);
-			clt_path->s.hb_missed_cnt = 0;
 			clt_path->s.hb_cur_latency =
 				ktime_sub(ktime_get(), clt_path->s.hb_last_sent);
 			if (clt_path->flags & RTRS_MSG_NEW_RKEY_F)
@@ -663,6 +663,7 @@ static void rtrs_clt_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		/*
 		 * Key invalidations from server side
 		 */
+		clt_path->s.hb_missed_cnt = 0;
 		WARN_ON(!(wc->wc_flags & IB_WC_WITH_INVALIDATE ||
 			  wc->wc_flags & IB_WC_WITH_IMM));
 		WARN_ON(wc->wr_cqe->done != rtrs_clt_rdma_done);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index f76d483c3784..ffd3e80596d0 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1233,6 +1233,7 @@ static void rtrs_srv_rdma_done(struct ib_cq *cq, struct ib_wc *wc)
 		 */
 		if (WARN_ON(wc->wr_cqe != &io_comp_cqe))
 			return;
+		srv_path->s.hb_missed_cnt = 0;
 		err = rtrs_post_recv_empty(&con->c, &io_comp_cqe);
 		if (err) {
 			rtrs_err(s, "rtrs_post_recv(), err: %d\n", err);
-- 
2.25.1


