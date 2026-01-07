Return-Path: <linux-rdma+bounces-15355-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6CCCFEDF8
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3DDF3044B8F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189DF363C46;
	Wed,  7 Jan 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UH7IalVB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D1E34B683
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767802539; cv=none; b=E75jY6YVZRQJBVLVXT0sJAzqIV+qOHFE7CV1v76iCTzvU5MSIWnxnNFjUXd/9p2mqOiX3TXlpKOB8HMR8eaF75viy+lp87z6amdIWYjJtWbkEo7IbhCc0WfGRWjWgWXW8Qrq9DKdvwk+iJYHW1tMIB9H8IlwfLrV+UWKtakJTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767802539; c=relaxed/simple;
	bh=5f449gbIWAB59rRep2H/4tlPz6JB0oO7VSX+c/w480o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRrv4v60jgEpZznIjA8RGvBeXUmzr5hRFGmgDwUsA4YHFkmX89ORsjdEgDzorDe7aq2RHKk2hPlkUUzlwBFNN1dvJyqY/OwQ98AU5KuaTd5eNP8Z9Wk3qXQGwfuOYO4zTZrPeoFmC/cdxsrmnnEXU9e/NvSa+OHz29cu3QuWl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UH7IalVB; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6505cac9879so3752688a12.1
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 08:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767802521; x=1768407321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJwxjFTTjopk/w1Pf5y9NcI7+DkxvsPdg/MIPJrgFr4=;
        b=UH7IalVBYKNb6xYiknWDaa/JMAnIXIRiSbR4nvtfAfUYsGnk0x0cVuyUJKkq+xv/cd
         0FnGIa3yYZi8sLS7bhhzI8MmMZxXbc2PV+YGE92wXxuMTXup+0RZAOJx955xcxkR+1j7
         ZmAqtO9YXzYB6gG18aw0xJHkxjTT9JlJfXWN+UGsYhloOl/NprlPg/AmuP6cgrFWPQUD
         FivXXpQcIBKxpYP8xTP1v0oJTUZAo6A/GbuKvEsqxoVuQct++CEtde8M1jJ3OXHHfUWs
         PejQiWXkkS/D0FSQAEKLRGN2q3AurnCCGfKJlP5Cb+BrxAKB2kpQ+hzrsUtpwa3r945N
         /5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767802521; x=1768407321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yJwxjFTTjopk/w1Pf5y9NcI7+DkxvsPdg/MIPJrgFr4=;
        b=N5ClUjOHN+UFvvLijUIzWTaMOV8GQxv5rtelIsMuPGCaOTttQpRukfUYGTDTttvNQH
         v4wQZBZaXx/qpKoiWw7G9nadWJUv/diBiFnuUg61+3uGHkzEDHCjiZ/nxsmphwmWVo0p
         O2xWjp7EhHoxpe9YVMcfLhuEcxm9ctJzxky9R2ZH1bdkyc+6DhCu6zhsE7FBtdK1Uw0T
         B+tVmd1UWC05fawlxwbO8eeU6vvXJArcSXZsev8n1PIxiQKymg9ijJH/r0jZ7H9mC7GM
         bGVgkKl3YpDsm230c7WR9T4jUtVna6bdSrVlOuhpJh6DKe4clEDJx4qlun3GK1T3Bkfn
         rKXw==
X-Gm-Message-State: AOJu0Yx3pa/kknYmBxpIB62NSozcVDFmg5jErUHjEGFohshXGCVSyQwL
	/1ON8rkp+F7GPMqt67M6c2TKzj7GXi2GUQ/ihI5F1+Wvt51aSqlcWtKViGHo/7+K019YwWPSyd+
	/Y5LW
X-Gm-Gg: AY/fxX4aUX3diT65kKmOL5KLAL3Ak2oGlyuZxa0Qsfw7PJC2ssyhJ3SUJW3EG25SjHY
	Mny3x2+TlMkXs7IUyfP9HdNgaM1xysbjiYXc+YZNn7Il3H8gExr8+OUSk1vEbgZQHcNSzLtierQ
	KEyPfqg2cZEnZ2TjrPxlAkwd/ITL5I50J+Dk6w08YL5Hv3MqlrjQWkXsk0oUuB0eUW4oyP45NqZ
	pgmckFS5V9DL8W486wRBsKWbx59STriNG0i0UGzQpBIEZSsHPQH+4f58E9/pvGIydxUKTd2rc9A
	rjv2q/Z0FAHJy9skhwWD9vPTir3tOgnZJAW3meSr6/tMzueellofcE1kMQoXUqGzuLMVAcw+LmO
	30vYeGLPG+Vw7YDM+mNkX4uUuvoffS76OygTQHCkSCLaWtStBP2GMLgcZvkpS56hvNKDsjQdiug
	u64UxstUhYImfzBwvao0FcOigUi71ycZAgE10qoo9eZ2laKLLkA0m8Uk0HMphuHgSV78fRTS9gK
	6d3gOz3DEZb9mcwztBjSHY=
X-Google-Smtp-Source: AGHT+IEIFeHzHrFI1jdddL7eZ5iJb7pg4BNI3rpQCf3DQsR6yZUZENrEmwgiQgm91ToYFNqtgaTQQg==
X-Received: by 2002:a17:907:2689:b0:b83:972a:6af6 with SMTP id a640c23a62f3a-b8444fa0b03mr305349566b.44.1767802521120;
        Wed, 07 Jan 2026 08:15:21 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net ([212.227.34.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b9d4c89sm4864773a12.10.2026.01.07.08.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:15:20 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Roman Penyaev <r.peniaev@gmail.com>
Subject: [PATCH v2 01/10] RDMA/rtrs-srv: fix SG mapping
Date: Wed,  7 Jan 2026 17:15:08 +0100
Message-ID: <20260107161517.56357-2-haris.iqbal@ionos.com>
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

From: Roman Penyaev <r.peniaev@gmail.com>

This fixes the following error on the server side:

   RTRS server session allocation failed: -EINVAL

caused by the caller of the `ib_dma_map_sg()`, which does not expect
less mapped entries, than requested, which is in the order of things
and can be easily reproduced on the machine with enabled IOMMU.

The fix is to treat any positive number of mapped sg entries as a
successful mapping and cache DMA addresses by traversing modified
SG table.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 7a402eb8e0bf..adb798e2a54a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -595,7 +595,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 	     srv_path->mrs_num++) {
 		struct rtrs_srv_mr *srv_mr = &srv_path->mrs[srv_path->mrs_num];
 		struct scatterlist *s;
-		int nr, nr_sgt, chunks;
+		int nr, nr_sgt, chunks, ind;
 
 		sgt = &srv_mr->sgt;
 		chunks = chunks_per_mr * srv_path->mrs_num;
@@ -625,7 +625,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 		}
 		nr = ib_map_mr_sg(mr, sgt->sgl, nr_sgt,
 				  NULL, max_chunk_size);
-		if (nr != nr_sgt) {
+		if (nr < nr_sgt) {
 			err = nr < 0 ? nr : -EINVAL;
 			goto dereg_mr;
 		}
@@ -641,9 +641,24 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 				goto dereg_mr;
 			}
 		}
-		/* Eventually dma addr for each chunk can be cached */
-		for_each_sg(sgt->sgl, s, nr_sgt, i)
-			srv_path->dma_addr[chunks + i] = sg_dma_address(s);
+
+		/*
+		 * Cache DMA addresses by traversing sg entries.  If
+		 * regions were merged, an inner loop is required to
+		 * populate the DMA address array by traversing larger
+		 * regions.
+		 */
+		ind = chunks;
+		for_each_sg(sgt->sgl, s, nr_sgt, i) {
+			unsigned int dma_len = sg_dma_len(s);
+			u64 dma_addr = sg_dma_address(s);
+			u64 dma_addr_end = dma_addr + dma_len;
+
+			do {
+				srv_path->dma_addr[ind++] = dma_addr;
+				dma_addr += max_chunk_size;
+			} while (dma_addr < dma_addr_end);
+		}
 
 		ib_update_fast_reg_key(mr, ib_inc_rkey(mr->rkey));
 		srv_mr->mr = mr;
-- 
2.43.0


