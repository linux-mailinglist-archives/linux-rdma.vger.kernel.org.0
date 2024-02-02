Return-Path: <linux-rdma+bounces-867-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE0847080
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 13:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCA91F2BC04
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Feb 2024 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC32215CE;
	Fri,  2 Feb 2024 12:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZDfLkDPK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0466F15B3
	for <linux-rdma@vger.kernel.org>; Fri,  2 Feb 2024 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877717; cv=none; b=OdfcZeq8wuMp3NmWFz3iRLDtNm6/wzTN6ScOLt84MWYFc6zY8q70I8Or4pJz1S/CNimTMnf7m9ttq6ymc59cU7ygHaO2zwti8iWlX0U69iz3Wyqh9ErCcKEIrHal4YFsG6OZ5rrmp3edoXsmZX4QQjA3M4fa4TPDxLk+bbmBeOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877717; c=relaxed/simple;
	bh=LVkVxqDPNymXHYLmyhlKXrsxPApp35YgN/QwSEMnRoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MV11cN2a0Jb3zMRGVyUwLSsWAn1YqxJeUk315x81hReOxRv4lycmCqrpiluIQXgyF9Bi2mk91SNR29L0G/cMPGe6Lr2PYVJhJ5SU8iZ3DRQ6OmuIwRPQUWrlEGS6EYMjLn3ssO55ua4mf4jGhfXDC54vEmQURn6MF6bEcxgQ1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZDfLkDPK; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706877713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tpUCAs2u7cOok6vftCAjHxAx60+odtBw2QunquXkc/k=;
	b=ZDfLkDPKN3HZnLUdfeRkJvPjXbawXzIl64ldkNOPdwbmDhJhfdXESNhdtgc064/YPS87yH
	wDAjdcbT/Ets8dlgk7JQdgt2Q48qUBMtCxj+WdEpBfo5WqR3yQ9rVHff+6p2k8gg8wDpa/
	vgw3t7jNUAb093+9Zn2P5hlppA2jbr0=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Subject: [PATCH v2] RDMA/rxe: Remove unused 'iova' parameter from rxe_mr_init_user
Date: Fri,  2 Feb 2024 20:41:44 +0800
Message-Id: <20240202124144.16033-1-guoqing.jiang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This one is not needed since commit 954afc5a8fd8 ("RDMA/rxe:
Use members of generic struct in rxe_mr").

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
v2 changes:
1. add relevant change in rxe_reg_user_mr, thanks for Yanjun's reminder

 drivers/infiniband/sw/rxe/rxe_loc.h   | 2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 4d2a8ef52c85..746110898a0e 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -59,7 +59,7 @@ int rxe_mmap(struct ib_ucontext *context, struct vm_area_struct *vma);
 /* rxe_mr.c */
 u8 rxe_get_next_key(u32 last_key);
 void rxe_mr_init_dma(int access, struct rxe_mr *mr);
-int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
+int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 		     int access, struct rxe_mr *mr);
 int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr);
 int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length);
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index bc81fde696ee..da3dee520876 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -126,7 +126,7 @@ static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
 	return xas_error(&xas);
 }
 
-int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
+int rxe_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
 		     int access, struct rxe_mr *mr)
 {
 	struct ib_umem *umem;
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index f0a03b910702..614581989b38 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1278,7 +1278,7 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
 	mr->ibmr.pd = ibpd;
 	mr->ibmr.device = ibpd->device;
 
-	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
+	err = rxe_mr_init_user(rxe, start, length, access, mr);
 	if (err) {
 		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d\n", err);
 		goto err_cleanup;
-- 
2.35.3


