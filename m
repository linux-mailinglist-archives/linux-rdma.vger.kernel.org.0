Return-Path: <linux-rdma+bounces-14926-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EADA8CADB70
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A94C3058F9F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5432E5437;
	Mon,  8 Dec 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="B4hjLNG5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF02144CF
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210524; cv=none; b=Cu2GzRYXPbwBDj+rhYaiW5c+gEWeM3tk3esikZhyIWK/esjViB+WjEqIniEz8vveq5rWSqzSBbB+eg/UIrcDJ4e3JPo2/eSPihNSPVt/JQw2ckIL74Zk6wp7S2ZPp+de/I7k2C9JxpUuMpFHpmKZVoYz8zfNCXxc2ZvPLiyb2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210524; c=relaxed/simple;
	bh=L5anbixYm5eu3PUnqa5jss/IxCAeVU+dQkK8CmTcMl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ib2JPNaoCM/iWaFZSyfFnZKr0Ec3hDHQKH4VxvjR7NnK7dYt7EcP9QSSwB2llW2dARtOmABeZ3J2wbOUJcWgcGU+YjPrtf1SwfQg3yXjN5nRvfDuU01fB6ywigqJoTym2PiUCKTfZPKMStZOCurclfRnkm2WGJa4MiXTImv8xN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=B4hjLNG5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso35078515e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210519; x=1765815319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFs5+7kf0L4wvkgUyrkXjYT1ZEISo/kGXsQI/dANNXM=;
        b=B4hjLNG5QG4QzQvfTLFwHwPdpT63jR36o8NwnFrrEqYORGtE5DIF4xhPUER7TRzitx
         e4UsD6tvo8jgCr2Gb6d+brnbyQ2Q5HStU5wkHRrwUqw0F4ThOHS2xfXxrjWzVo3RjGmD
         CqmRyJAh5H8DBcNFLlKem3w0ot2J53UUxgtIB9TO3utviImFEx5ibNa3gpeSD+p7/jY0
         hd9G1axk+TRWngP5d9lNi2Ss06HcP9IauVXBhjbXswZrHzL4pnPHR/J4o5Fi43W0L4BZ
         33z4lEuob+WDSKj32iQxuCnh6StxVpQ3boQh3cf1jE4cLCPpeW//9yPM+WAgOjOs2dYT
         KczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210519; x=1765815319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nFs5+7kf0L4wvkgUyrkXjYT1ZEISo/kGXsQI/dANNXM=;
        b=aXFJMkquiDnumZINH1iYTn4QB2iWsnV4n5F3NGbfagGePALGzVbqH5c5MJJlsor9qi
         e8t6wH7+/jWHQLhXGhQwlOoa2CGl/Y1/QndzgGjms3fNzWK35lvIpklixlJZftcRK3fw
         P3mrB9F0H883g5051DV36Ji+MlfQn5zHbPp8lOK9egUhH4ZVKaayJV/dSRDv7KBWBTXH
         JVuXG/R7i6ElmxclDJZ7nkfr5n8kSpK1gedSBRdz7b5+MSerorcTTMvKO+/vCBpHNedv
         sjeryR1gWQ3zXyuaHb4YnB5/259UY39WgHOMAqNKpEcmY9Z0OqiwxUOXgmlIuFXB1U99
         ZZmA==
X-Gm-Message-State: AOJu0Yx5CQJQiV5DiCCLqDPDuijMFUZwK1V6ViZvcDdhA+mjegtSy9Bt
	ZZh2ZFoarY0iOYoNUa5j27/lZk38j9oPLTIUGYb9JtNSp/OEjAOOXyU+JwiquU1juO09RKx5s85
	GufqG
X-Gm-Gg: ASbGncv2Je1nqrtvhRqBcPdfVbsSWBXRs6jwxiBfHSwgb1xRAq8IgyN3VPx6G8Ja1QZ
	ILXZbF0mm5Ntea4y4KOFyzEbTgHw5tShwsXHyqPpFE60Pa4mnmajbN1VesxX6KeyhBODI/mefnK
	lcGECkHWEz7xEgjKlL9wg0CRc37l7k69WVUXPN4LmwWQlmvl23Z1IaDuTUraEGcHa+x7Noxd84M
	9pJ8qUYMrfNbVc9CXIdukHrnEQ+zCJ+OKzmE7kFjqCheu8pZFuHdQYTOiuxCefiYs4lzZblZRB+
	1ilPClFxg7puaM1XdQZZZqNuFdblJo7KBVPosMNo5BQmDRFfz+SEBcKA1j5IeZbKx4PIxd3E7ev
	nljgCKbALsh3r1ppbdy0EsItN6nRiFBYD++bxdo4sD3Z1I+sCYx4e7lulkCHG3tqI5KWWZBPR0T
	uXn4+BsAdPjMyM8Ph+OyICCgK5+CxnQZEmTgHvmEzkfTpMt6jGoFycl5XZKI4Sa+vpUoTd4UQLr
	K8qh79IdBLsXvOJd+A51D4P
X-Google-Smtp-Source: AGHT+IF5DJp7mnhr2onqKNTkO1bsE/zwBqHLSPDc4z2+ORBB8k7GA9eI0I6QIG2osS/FLdjzCuiumA==
X-Received: by 2002:a05:600c:3487:b0:477:9671:3a42 with SMTP id 5b1f17b1804b1-47939e43a49mr89693655e9.35.1765210519391;
        Mon, 08 Dec 2025 08:15:19 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:19 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Kim Zhu <zhu.yanjun@ionos.com>
Subject: [PATCH 3/9] RDMA/rtrs: Add optional support for IB_MR_TYPE_SG_GAPS
Date: Mon,  8 Dec 2025 17:15:07 +0100
Message-ID: <20251208161513.127049-4-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251208161513.127049-1-haris.iqbal@ionos.com>
References: <20251208161513.127049-1-haris.iqbal@ionos.com>
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
index 808de144d2e4..ee0682021234 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1360,7 +1360,9 @@ static void free_path_reqs(struct rtrs_clt_path *clt_path)
 
 static int alloc_path_reqs(struct rtrs_clt_path *clt_path)
 {
+	struct ib_device *ib_dev = clt_path->s.dev->ib_dev;
 	struct rtrs_clt_io_req *req;
+	enum ib_mr_type mr_type;
 	int i, err = -ENOMEM;
 
 	clt_path->reqs = kcalloc(clt_path->queue_depth,
@@ -1369,6 +1371,11 @@ static int alloc_path_reqs(struct rtrs_clt_path *clt_path)
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
@@ -1382,8 +1389,7 @@ static int alloc_path_reqs(struct rtrs_clt_path *clt_path)
 		if (!req->sge)
 			goto out;
 
-		req->mr = ib_alloc_mr(clt_path->s.dev->ib_pd,
-				      IB_MR_TYPE_MEM_REG,
+		req->mr = ib_alloc_mr(clt_path->s.dev->ib_pd, mr_type,
 				      clt_path->max_pages_per_mr);
 		if (IS_ERR(req->mr)) {
 			err = PTR_ERR(req->mr);
diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 758d77206315..905d5baec89b 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -568,13 +568,15 @@ static void unmap_cont_bufs(struct rtrs_srv_path *srv_path)
 
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
@@ -623,8 +625,13 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
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


