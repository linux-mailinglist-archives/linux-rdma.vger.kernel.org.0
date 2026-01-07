Return-Path: <linux-rdma+bounces-15350-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E610CFF288
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 18:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E623F3266D0B
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F057035F8B4;
	Wed,  7 Jan 2026 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SgOivgkc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC68339B30
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802535; cv=none; b=lRrldJXAFEFw+qZEJt/PXDrb15LLXpisrdSiblh3ap7c5t8yxW0LGXFN9FJucKO1u9/8GlPDgjexbf/32f1tZgP9zC/XSmxoHT4LE+UigwoRfdn9nHMAv/fzEh5mYWhJqZq5oz+/t/N1jTSNJJ6tot9qAHCZGaIRnX6vbxJkMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802535; c=relaxed/simple;
	bh=Wi66HOKntRyzxQ+9bfFodbYiOWZ/6ZnSaLI+6csAfJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjaxU1G9EYXERNXyoULrGojGbK3TC3be6EBl4htOz0L/Iptqk58r10Cp7FwBToGzwYE5h5RxfwZP92lipHYLIByyf4HbMzUec94XHDyIjo7WGE35d5YKIwAEVvERR/o/4L4ykoc7AyPjVV+X8hDkvZPEG6Ia1uKeIUoBpgtVxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SgOivgkc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b8b5410a1so3124277a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802522; x=1768407322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG/sajJOSaoRMCcscBOtJXrIdX1i2/mmBUvONpkmEFM=;
        b=SgOivgkcAO+g/QBrwq6i9S2Zjrc2HcE612Ub5eL0cmPrDRViY0RVn1w1w3/LW9eL57
         8mfUEVyQIAkwqwH99y6jbEZeQgnuLQHcBhM8naRndM7LQYDvKkMEMCbwoGlpHdO9/S9h
         p+K4Hqp7u8x3wmg1ichce7RiJ0838456QppObWBJnx79UgubjU3L0YjAf8uQ9w8Fhfwm
         4i7ssoYvqiEPHtqHeBEYWSJ+giLZr1y/8eCx7iSYHmIBTElanrJ5fGkO/cwRwndvRvE5
         cf045IL0Cc3n+ZR7QON4lbLMiwGQi/M3udWvBkbRuj7nW5KXzRK9epEBmmMqo283gqI0
         dHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802522; x=1768407322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sG/sajJOSaoRMCcscBOtJXrIdX1i2/mmBUvONpkmEFM=;
        b=hbm1dXxb0X7l6w805Ui1pfQIjsQPX/B6V0Upw0+Bm1LxLGqk1GVUSCgkNtDkiPazmH
         i5rTxIwaJ/ghvgVrIFIWrtX72clKcaxhOE3AjGMIxeFTZq8dk/TLdsmUnso2h0PrJtTn
         cgFG9lvm2R12uWWWP/o5es2T/FbqigJmUnjIxELDIlJM8Qp4MR2wwyh/5Pk2Qb1jBwWH
         L8tFm/CgSV4psqKSs0wnkyQ7xqi/vXAChiZTP19Bi3eFNLw3DlwAtoyBy9gAhRea7aiE
         8/m6jHPvPzSYL0lGSv7Rb5yQn0RAywtPscL373WFiCMOpPgoDdl6I6ox766pQ9wGev99
         2GmQ==
X-Gm-Message-State: AOJu0Yzf5oOzmPtRRrppX2q7xyQFrkxQPhQpIBBCd76ljNs3jgjrfiQl
	2aOyHPljNyz35vHmcIgApJh60hywWqb3NB1QPEuvd+18zUe4jwOPURFZuweNXHAtSPpUgAlH+6Z
	yC04a
X-Gm-Gg: AY/fxX7fNKC70mOpo5sVea8NxAl14uRTc3R2qdQSOlmLdKwXyQk3gp9nRguARrQlJCr
	rIUCifb73//qIKGMt/7WRDmtmaJ7sdHdzwg32pwYzl6ZmNVse/h1M3xV+SOs1yozd94TiJ/2qOl
	3TaJcvXoD+D8sz11IdvjL3G39ndPII+xgP2XTWqkdqAZ54wRmI1lL3ckT5Ais5CZ4kan2rfEtXE
	8LThAw3/JDuEdIMrDX9my2MJvnVMiczPzyBWW9/0a77TsG5JwumWrlqmkuxYsP26oje/k5PMLQS
	Kg04JoRZTC2+zZccB6t1XyGWA8h79WVhTH387IeQPR5WbL/F6/WvzaMqKHO330mFZVyyaV2PYTZ
	Oupf4ATnhlDegheiTEA9bC3RfCc9e3lA7s4TZRgsJ4JMgsKTmememYkJwqbgBv+ZBdIW1qiUJQU
	gs9kAy0bPRnM/1+tUmTK8nxf4U5o/r+V8fxxvlHG2h9gPvXNi3PrsmTmt89nKg+KEvdxdb+cwdH
	mMPmhFO/zLMVpUH5Nv/j/upNV213KoaPQ==
X-Google-Smtp-Source: AGHT+IE6nh6uGipT4etpPkn1aygXf9/W2o8atKIw8B+Of2vJihQhW881jucVeFpSm7D4jSE/bXXdpw==
X-Received: by 2002:a05:6402:c19:b0:634:ab36:3c74 with SMTP id 4fb4d7f45d1cf-65097de796bmr1865237a12.9.1767802522491;
        Wed, 07 Jan 2026 08:15:22 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:22 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH v2 03/10] RDMA/rtrs: Add optional support for IB_MR_TYPE_SG_GAPS
Date: Wed,  7 Jan 2026 17:15:10 +0100
Message-ID: <20260107161517.56357-4-haris.iqbal@ionos.com>
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

Support IB_MR_TYPE_SG_GAPS, which has less limitations
than standard IB_MR_TYPE_MEM_REG, a few ULP support this.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Kim Zhu <zhu.yanjun@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 10 ++++++++--
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 13 ++++++++++---
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 56b98a7fde45..f0d43eb24c9e 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1359,7 +1359,9 @@ static void free_path_reqs(struct rtrs_clt_path *clt_path)
 
 static int alloc_path_reqs(struct rtrs_clt_path *clt_path)
 {
+	struct ib_device *ib_dev = clt_path->s.dev->ib_dev;
 	struct rtrs_clt_io_req *req;
+	enum ib_mr_type mr_type;
 	int i, err = -ENOMEM;
 
 	clt_path->reqs = kcalloc(clt_path->queue_depth,
@@ -1368,6 +1370,11 @@ static int alloc_path_reqs(struct rtrs_clt_path *clt_path)
 	if (!clt_path->reqs)
 		return -ENOMEM;
 
+	if (ib_dev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
+		mr_type = IB_MR_TYPE_SG_GAPS;
+	else
+		mr_type = IB_MR_TYPE_MEM_REG;
+
 	for (i = 0; i < clt_path->queue_depth; ++i) {
 		req = &clt_path->reqs[i];
 		req->iu = rtrs_iu_alloc(1, clt_path->max_hdr_size, GFP_KERNEL,
@@ -1381,8 +1388,7 @@ static int alloc_path_reqs(struct rtrs_clt_path *clt_path)
 		if (!req->sge)
 			goto out;
 
-		req->mr = ib_alloc_mr(clt_path->s.dev->ib_pd,
-				      IB_MR_TYPE_MEM_REG,
+		req->mr = ib_alloc_mr(clt_path->s.dev->ib_pd, mr_type,
 				      clt_path->max_pages_per_mr);
 		if (IS_ERR(req->mr)) {
 			err = PTR_ERR(req->mr);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index be44fd1b9944..7ed8910ef7f5 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -562,13 +562,15 @@ static void unmap_cont_bufs(struct rtrs_srv_path *srv_path)
 
 static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 {
+	struct ib_device *ib_dev = srv_path->s.dev->ib_dev;
 	struct rtrs_srv_sess *srv = srv_path->srv;
 	struct rtrs_path *ss = &srv_path->s;
 	int i, err, mrs_num;
 	unsigned int chunk_bits;
+	enum ib_mr_type mr_type;
 	int chunks_per_mr = 1;
-	struct ib_mr *mr;
 	struct sg_table *sgt;
+	struct ib_mr *mr;
 
 	/*
 	 * Here we map queue_depth chunks to MR.  Firstly we have to
@@ -617,8 +619,13 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 			err = -EINVAL;
 			goto free_sg;
 		}
-		mr = ib_alloc_mr(srv_path->s.dev->ib_pd, IB_MR_TYPE_MEM_REG,
-				 nr_sgt);
+
+		if (ib_dev->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
+			mr_type = IB_MR_TYPE_SG_GAPS;
+		else
+			mr_type = IB_MR_TYPE_MEM_REG;
+
+		mr = ib_alloc_mr(srv_path->s.dev->ib_pd, mr_type, nr_sgt);
 		if (IS_ERR(mr)) {
 			err = PTR_ERR(mr);
 			goto unmap_sg;
-- 
2.43.0


