Return-Path: <linux-rdma+bounces-14923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D22F3CADB6A
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Dec 2025 17:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8601301E92D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Dec 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47E8238C0B;
	Mon,  8 Dec 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LXvcmUJM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930402144CF
	for <linux-rdma@vger.kernel.org>; Mon,  8 Dec 2025 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765210521; cv=none; b=GwXH0bM6OKqRoqEn+v0aQ54dmV6O66XPk9NHcJ57buguKAb7UeL6oBX1PFad1XFSLtl9hQeGagpO7B50f6t8VU7qqLHQRkmzEhipKPK2arggnnrPBAZl8+16zUWe3Fd/NUf9SgJ8FnSf5eudh4cTZ8fEIDHP5Yhf0w+vXPJb/T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765210521; c=relaxed/simple;
	bh=6GC/JXxWM1ZW8JPD7HSSt9ayvWBOHuhDoY2LuLcSbhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+Jx0Q0v6tR7Ew4anHmVMAVmoxZujNHKuGFU1Ci83yDyDQ0chdNA7FXp4XjdE5RsSyCWpvjovHVYXE0gukDdftFw9WaK0VgeoHdkXNZnamStmfUhg6FCXSgEyTS7fgVwdsZRbyeqlzPBs9PCznHeYKL4DC5h7qIoeQ+2M43muio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LXvcmUJM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477b91680f8so52092315e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 08 Dec 2025 08:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1765210518; x=1765815318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXXXBQkVy8R+mkIbinzUNypFXFC52DKmgPDxNhqtBpo=;
        b=LXvcmUJMDbNAXQ1UBfQa4RVTI3KnVHUrdRua0sjuIKVPYMZmBYEl9ONFt31kjA+Mw8
         FGBH72lV9K6Em0QyyAcyx6MjX8CC9lrPFTNOn0a1Gt/cJjm8CywTe4cir15Mq/XPzTDW
         QdgVbRlkDB51N68PZOyA6NGLDJ7JuuT4QTSToFC738JWITwwRGPTd9KASOugWdwpezay
         /rODgjKw2y2jm3AzSjAkh1ZkLA693C3BMqbX9/pAq7jaQgC3eFwz23evj4I8RvmVUhA1
         5pxQNNyQ3fYvlmsNhn1QgkRR8J5OfOUK5TtHf22+iMczVVwqRxuYelSATMSt1iIiGBCJ
         TfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765210518; x=1765815318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uXXXBQkVy8R+mkIbinzUNypFXFC52DKmgPDxNhqtBpo=;
        b=Yz8lv7D+ZWGK4r6cWbsd4DT3fuPaRampk/0LTfDdN1xQ9uM0fnmPFX8fW0dptMwY7w
         eKnVg+YYEERqnIXlZaZVBlW/aqcFo1ctyhzjVC+kGVX3bn/85Ja0ZCe04cI03Q0AkKSu
         pLWpPOdGAjSInGrvwUtqAG/lDKvo1nM2WoEJ07a+cNsxoCljgnd5QD6H6jFpRPv1Xls1
         rdoXk38ddbcK6UbTaTVVbY92joVfUHrGAmZhvbNFxc+F1ayNBdWTV6rFOiLiTpc7iMkP
         FlUrpJF6QoHcma7YqyAEBc48bg0HrpayBpAXRcuu7AwnjoYP8PCNoOAQY/iC1tlVVJ9R
         Ny3g==
X-Gm-Message-State: AOJu0YwYIWOWiJUGAQ9IG6cjrAGP+z7hmc/Y2m0RY5uAn2/KeIp0qg+x
	gfiphVftzd/jqMm7GADj+7YRvNmXVKm2hksFjAPqXZa3pEWYTfBUpbRLDC0yrRSwNWojNBLgDfR
	PpGmc
X-Gm-Gg: ASbGncs2Y0Fr+ITtatRxnxLOSnaoW9/uEMXirjRX+hC1karbqPvUGRa27F50cO29KMZ
	9M6aukArcrRU06ZSd9zT84AkLEyyo0m88+km7rxqAEJ63V6+ei0nGFZdc70R3dozTQYy9pCZbkR
	lP/lNJXXsWaaM+M+tiTo64NTOSwhIheuGUubX/fx+ftr6N4fhHbpw8XGpfw8sGUnk+YSecduf1L
	xp0JGVYtONNbC6oMivOVWSHxehgH3LwOh0/iHF3CtQZaUvwjBu3egyXxNspQCiSqeFfTWa6uK+9
	LJMwIk+b/ZHOGrcbwPPnIgdjDmWgj2b07DGNcSA7G0ljynrRc/JEsOG7P7teZUpHWag8NhjoBMo
	ssY/Eux5qADdzea28qQMcKh0UufXyOkKiZjoMDPNgwoj0PWtUXJwLm+FKLHlUowJtAql5Fl8M1G
	BAPD5m2H4U7YQWnocfj4+ZkcQ384LW3J8j76F8bcmMcJOrg+LmCy22IQi7+Nt7k21tYr4npiCFP
	Jjp0jqy5Ru8CXZKhKLl0DUC
X-Google-Smtp-Source: AGHT+IH33X/BCT7jSMJ7BqopcHDb1s1rih/frJ5EwLBmwaULGcA8WOkVTDvOgoVynveMyPBNCL8pSg==
X-Received: by 2002:a05:600c:4f4f:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47939e24000mr85612655e9.20.1765210517766;
        Mon, 08 Dec 2025 08:15:17 -0800 (PST)
Received: from lb03189.fkb.profitbricks.net (p200300f00f28af1ae57f1d6cbb50b9bc.dip0.t-ipconnect.de. [2003:f0:f28:af1a:e57f:1d6c:bb50:b9bc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479311ed466sm245275655e9.13.2025.12.08.08.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 08:15:17 -0800 (PST)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: bvanassche@acm.org,
	leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	grzegorz.prajsner@ionos.com,
	Roman Penyaev <r.peniaev@gmail.com>
Subject: [PATCH 1/9] RDMA/rtrs-srv: fix SG mapping
Date: Mon,  8 Dec 2025 17:15:05 +0100
Message-ID: <20251208161513.127049-2-haris.iqbal@ionos.com>
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
index ef4abdea3c2d..2589871c0fa9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -601,7 +601,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 	     srv_path->mrs_num++) {
 		struct rtrs_srv_mr *srv_mr = &srv_path->mrs[srv_path->mrs_num];
 		struct scatterlist *s;
-		int nr, nr_sgt, chunks;
+		int nr, nr_sgt, chunks, ind;
 
 		sgt = &srv_mr->sgt;
 		chunks = chunks_per_mr * srv_path->mrs_num;
@@ -631,7 +631,7 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
 		}
 		nr = ib_map_mr_sg(mr, sgt->sgl, nr_sgt,
 				  NULL, max_chunk_size);
-		if (nr != nr_sgt) {
+		if (nr < nr_sgt) {
 			err = nr < 0 ? nr : -EINVAL;
 			goto dereg_mr;
 		}
@@ -647,9 +647,24 @@ static int map_cont_bufs(struct rtrs_srv_path *srv_path)
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


