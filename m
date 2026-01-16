Return-Path: <linux-rdma+bounces-15610-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A12D2ABFE
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 04:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C9BCA3005019
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 03:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3B2342534;
	Fri, 16 Jan 2026 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="J8mCWPvA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872A341AB0;
	Fri, 16 Jan 2026 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768534196; cv=none; b=Fo38X3j6jZb2V9yUPcwRvK/8ktPj6bEDJl9DW5hdxroYpNa3ABxVaCN+7hey5uk6hjh8220BT7N9Cq3RPdDJCYOrNrj8+MkasFpTUQwfUdKA6kdjvqmzcUemxOGNbJJIsC5Uc5Q9tIMClL7g/ObHl/fhZznJIViJKi/bQGqA03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768534196; c=relaxed/simple;
	bh=LCj8CpjFd/PFJ7iHyfh28z01S14GZ1aFFjRGkqOQxsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dexFudq08KXpTPVzVU2fuHK6PuLBNXCNWzqF5wXjtfnbRY6S9e+EImfygqeSnqi0T6U/7+RDY37f3t4fYUU5WA603txxtEgniIh09miC2XcrJmSwgZ87fM0BhJ2h4KYSyJvyKldzqbcbyto/KpQW2UCTrwj/RlweTbjyigMbh0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=J8mCWPvA; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1768534194; x=1800070194;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LCj8CpjFd/PFJ7iHyfh28z01S14GZ1aFFjRGkqOQxsc=;
  b=J8mCWPvAsBkxLi9bxP653O5/bMMony7cOu7ja54klXyjCNqHXv4qF55y
   BeOsCfNr28hVyxyN+XnC0bETPPqCCnT90/iAgEWZlcxLi9rOnIX7fF+91
   cJsj51OtJAsQb86GkvSQe0PJfwzDfBCVABOkt1Vbi3GSaAGG0oo0tS8ID
   qYOZnjjlttvDCM9PS5niRYNFkfEobf4zTejXpd1AIWktYo5L63OR8dZsI
   LN3vp5Mu9CpoDqsboFK1WXavfFH4dyOyUvPuooiI6aO3f7R6tEz3B6LGs
   k7KOSFz6nIshb89RHtAXSHnyUPGHomux2TKfp4l2vhPX6gN1F9JuIZkL2
   g==;
X-CSE-ConnectionGUID: Z7RsxFvbQ+m3vRjizpv8uw==
X-CSE-MsgGUID: YXGbHEQ2T2qF8wR3X4riNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="230002921"
X-IronPort-AV: E=Sophos;i="6.21,230,1763391600"; 
   d="scan'208";a="230002921"
Received: from unknown (HELO az2nlsmgr2.o.css.fujitsu.com) ([51.138.80.169])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 12:28:43 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id 87BBE3C8;
	Fri, 16 Jan 2026 03:28:44 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (az2nlsmom4.o.css.fujitsu.com [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id 3FBF11801E9D;
	Fri, 16 Jan 2026 03:28:44 +0000 (UTC)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by az2nlsmom4.fujitsu.com (Postfix) with ESMTP id AE47B2004F87;
	Fri, 16 Jan 2026 03:28:40 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] RDMA/rxe: Remove unused page_offset member
Date: Fri, 16 Jan 2026 11:28:33 +0800
Message-ID: <20260116032833.2574627-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rxe_map_mr_sg(), the `page_offset` member of the `rxe_mr` struct
was initialized based on `ibmr.iova`, which will be updated inside
ib_sg_to_pages() later.

Consequently, the value assigned to `page_offset` was incorrect. However,
since `page_offset` was never utilized throughout the code, it can be safely
removed to clean up the codebase and avoid future confusion.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: make commit log more clear # Zhu
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
 drivers/infiniband/sw/rxe/rxe_odp.c   | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index b1df05238848..05710d785a7e 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -237,7 +237,6 @@ int rxe_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sgl,
 	mr->nbuf = 0;
 	mr->page_shift = ilog2(page_size);
 	mr->page_mask = ~((u64)page_size - 1);
-	mr->page_offset = mr->ibmr.iova & (page_size - 1);
 
 	return ib_sg_to_pages(ibmr, sgl, sg_nents, sg_offset, rxe_set_page);
 }
diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
index c928cbf2e35f..d3a54bfaf92f 100644
--- a/drivers/infiniband/sw/rxe/rxe_odp.c
+++ b/drivers/infiniband/sw/rxe/rxe_odp.c
@@ -110,7 +110,6 @@ int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 	mr->access = access_flags;
 	mr->ibmr.length = length;
 	mr->ibmr.iova = iova;
-	mr->page_offset = ib_umem_offset(&umem_odp->umem);
 
 	err = rxe_odp_init_pages(mr);
 	if (err) {
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index fd48075810dd..f94ce85eb807 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -347,7 +347,6 @@ struct rxe_mr {
 	int			access;
 	atomic_t		num_mw;
 
-	unsigned int		page_offset;
 	unsigned int		page_shift;
 	u64			page_mask;
 
-- 
2.41.0


