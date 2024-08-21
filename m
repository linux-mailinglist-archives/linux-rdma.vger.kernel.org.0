Return-Path: <linux-rdma+bounces-4454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C345959A7C
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23F961F22B0E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D1F1A284D;
	Wed, 21 Aug 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="S5UN039s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB11A4B8D
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239402; cv=none; b=qBBRnfjHWghYJjbs7HN4sLUXoscwLDSxyJb5RoitxAyiRJ6jmFMOaJ6OkKVJUnPLK/NyjEgNq1Pj1u9F9oUKHzq32PUlPJxYjy+mKg8uEpA8fr1LyWkZtu5CDsZneCmSCm96AX2/z3AaJX233LRFYfydepN3nyw9el9wPdFnvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239402; c=relaxed/simple;
	bh=wSG8mJWVwK1/KFG56H2h9FYqiJNGfBvw1cfDruXjyG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VGRvXl+YX3KpsPLEyM/rVoXIqXmmzgLi/zPkxDCPkSImH0XMcVA7N9I6cv9qpWWaXD4SUMGrIvVSqWwh39O8slB1rNiJOkFVS7HOjINFugJEVP0BQdUShM0IEVyFm5+YFkqFA0o4iP2lzxImVx5O3KMFD8ztqPnrvNjE0hUBoZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=S5UN039s; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a94478a4eso122995066b.1
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239399; x=1724844199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fjw2Ta8LUJKcy0S2Y9A72sgh/iD12aMXAxb+1vnFQ4=;
        b=S5UN039sr2v0SnLoolvFf/EG5KJ1d1vd6qoZjEPECaAwDoaLMBCIutuG8U3JVIWVvO
         Z1imB/txczL4hqTQVtUieYttTFIpp9sBsbpw4IffbONG+9xEqG+wwR0BHdqM6tjVTMBg
         Y58K91aGmcRW0lQwFALzCteRGtsu+YSNjKryj8z7+4Wai6osG3HyKL7up0d+a95gR9m3
         ty5TKialSyHV9Kx5qnBeawpasYKIIRgVKN1M9vKRJbTrM2Ux8ckVwbOu7Yoq7Jrr7L0x
         WU/o9arkOhw7DQcXGrxhmn3B2npe3Hv2l/EhXyr/w8xG4hgoJM0RPmRSFmaMqE2k/qRt
         vpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239399; x=1724844199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fjw2Ta8LUJKcy0S2Y9A72sgh/iD12aMXAxb+1vnFQ4=;
        b=HW6HWJs9YELnvccsLkIAJps6mjZw6jATy5KNG9HcquHe5hLkxf7/+RMQAnczwSpARz
         2ZooOdB6CPqaKJ0rhJgeRpND1Mf0xPPC/hJ90olTC0iebH5GH4iW6HMbtaAEwunZH8bT
         GEnYKUdQuORhnOXOgcxBzvXNcnNos2gMAsViDwMwbr2ABXy1DzODps5Uw5oUX1kZkj2z
         f4Jyp5MSxbgENOzbE2bO8OLd9S8iU7EQDBBO9EP+gIC0xgGiS91xTSXgC/nDNuTExBTO
         S89mxjMzUZJEmV8EPxTDQw3Ski8nLn8MpErt51DBmTJiK0K5HBY5mwNaQbECvqvNp7W3
         QDKg==
X-Gm-Message-State: AOJu0YyFHHuIl06jBDGLoBb2i5a0NezY0N4ITGdTlG9iRV2vf7kITMUg
	hT+mYH8ASHVagggrlUsgHqxctjlqPs2ZGNZgDDFloLCBR2yJT+YUgV+15jGbZYP+gZOjVYBvGVJ
	V08o=
X-Google-Smtp-Source: AGHT+IEsUfqne2r3nsaYjTyU8ED4E0/ZaBTF222Wk0s44ci9jA13M+pFm08VBzXvMhXp4Kv8lLfHtg==
X-Received: by 2002:a17:907:6d24:b0:a7a:b561:358e with SMTP id a640c23a62f3a-a8670183ea0mr178400466b.33.1724239398245;
        Wed, 21 Aug 2024 04:23:18 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:17 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 03/11] RDMA/rtrs-clt: Rate limit errors in IO path
Date: Wed, 21 Aug 2024 13:22:09 +0200
Message-Id: <20240821112217.41827-4-haris.iqbal@ionos.com>
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

On network errors, a large number of these logs are printed due to all the
inflight IOs, rate limit them so they do not clutter kernel log.

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index d09018c11ece..b34eb4908185 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -331,7 +331,7 @@ static void rtrs_clt_fast_reg_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
 	if (wc->status != IB_WC_SUCCESS) {
-		rtrs_err(con->c.path, "Failed IB_WR_REG_MR: %s\n",
+		rtrs_err_rl(con->c.path, "Failed IB_WR_REG_MR: %s\n",
 			  ib_wc_status_msg(wc->status));
 		rtrs_rdma_error_recovery(con);
 	}
@@ -351,7 +351,7 @@ static void rtrs_clt_inv_rkey_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct rtrs_clt_con *con = to_clt_con(wc->qp->qp_context);
 
 	if (wc->status != IB_WC_SUCCESS) {
-		rtrs_err(con->c.path, "Failed IB_WR_LOCAL_INV: %s\n",
+		rtrs_err_rl(con->c.path, "Failed IB_WR_LOCAL_INV: %s\n",
 			  ib_wc_status_msg(wc->status));
 		rtrs_rdma_error_recovery(con);
 	}
@@ -419,7 +419,7 @@ static void complete_rdma_req(struct rtrs_clt_io_req *req, int errno,
 			refcount_inc(&req->ref);
 			err = rtrs_inv_rkey(req);
 			if (err) {
-				rtrs_err(con->c.path, "Send INV WR key=%#x: %d\n",
+				rtrs_err_rl(con->c.path, "Send INV WR key=%#x: %d\n",
 					  req->mr->rkey, err);
 			} else if (can_wait) {
 				wait_for_completion(&req->inv_comp);
-- 
2.25.1


