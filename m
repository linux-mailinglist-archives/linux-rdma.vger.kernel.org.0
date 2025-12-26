Return-Path: <linux-rdma+bounces-15225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47673CDE8C4
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Dec 2025 10:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99987300486C
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Dec 2025 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B6D296BB6;
	Fri, 26 Dec 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="q1NT7NxK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827B23BCF3;
	Fri, 26 Dec 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742200; cv=none; b=mZykJE9RCzERWgYKIlK9MHyzpntab61gdAgr3kSiLYUzqf2/8GRlJA1Btjudfc6G04P3KN007yoFsjVge4NE0gObJ7m+2FP3PuNFUbDN5i88hyJm6yDEgHlQuKdECKxnGuSImlTGbYd9XTZYaRIMZcudmHKiyA8UixL2m9bO+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742200; c=relaxed/simple;
	bh=6RocRk8ljme3kz9lExqokavTKbt1mvl8Tw2sv2cGjic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uE17/AHjna8uZRjtCbHAmel4dsixEuYuTZJ6GtrDaH3LLSuTstKkWIGf5F3FVYDZUdbevxAAqJhKs1Je08PhXGWsCYm7hVxJLJ85KPRjoTwFmFBqhqGP6T4BgfrGd0On6rYPSZAr3QLwUVuSm0t4UIXu0pzgL/w19uKZjw36SYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=q1NT7NxK; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1766742198; x=1798278198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6RocRk8ljme3kz9lExqokavTKbt1mvl8Tw2sv2cGjic=;
  b=q1NT7NxK0BGpEmrTaJIAkNHOI3rmeQRudVFtbliBid1rko3XBOdDpNoi
   2bOg24WnbSGaXV8Yw4JylxaKMwEKxxpQL0J8OKfTBhpj/CuKRx+91H7CK
   E2d8cwoDdE0RaBbP/iAxlgsMuK6nhzuEtsW7aGpZ7yiQECukGSDOTxNOL
   Kvy1R8PnZ54DeVEX2DoevocJUVmW5kcTe9nc1Nd62daXapC8bIKU9eFn2
   YMUzCC1PMq/00quhgWdltQ8SqecIgKWpO07aAIZ8njXM0X4qjwGUEpgwa
   ssYeTF57U8dkq/c2uJKR7yWPw8gb8JAsjXs72KFx4OJF0iGVP+4nxsUu0
   g==;
X-CSE-ConnectionGUID: jRDrRQ4yQIOwER416VL/pw==
X-CSE-MsgGUID: naFdtvhxRjW/RUUzff+Cqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="224096762"
X-IronPort-AV: E=Sophos;i="6.21,177,1763391600"; 
   d="scan'208";a="224096762"
Received: from unknown (HELO az2nlsmgr3.o.css.fujitsu.com) ([20.61.8.234])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2025 18:42:08 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id 341B6100034B;
	Fri, 26 Dec 2025 09:42:08 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (az2uksmom2.o.css.fujitsu.com [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTPS id DAF9018041BD;
	Fri, 26 Dec 2025 09:42:07 +0000 (UTC)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with ESMTP id 5D46114076BD;
	Fri, 26 Dec 2025 09:42:04 +0000 (UTC)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] RDMA/rxe: Remove unused page_offset member
Date: Fri, 26 Dec 2025 17:41:59 +0800
Message-ID: <20251226094159.3042935-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `page_offset` member of the `rxe_mr` struct was initialized based on
`ibmr.iova`, which at the initialization point hadn't been properly set.

Consequently, the value assigned to `page_offset` was incorrect. However,
since `page_offset` was never utilized throughout the code, it can be safely
removed to clean up the codebase and avoid future confusion.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 1 -
 drivers/infiniband/sw/rxe/rxe_odp.c   | 1 -
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index bcb97b3ea58a..b28b56db725a 100644
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
index f58e3ec6252f..8b6a8b064d3c 100644
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


