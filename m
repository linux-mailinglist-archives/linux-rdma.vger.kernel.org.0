Return-Path: <linux-rdma+bounces-9978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C701AA9DB8
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 23:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D4817F480
	for <lists+linux-rdma@lfdr.de>; Mon,  5 May 2025 21:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E3B2741A2;
	Mon,  5 May 2025 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Wp7K74D5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554AA2701D7;
	Mon,  5 May 2025 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746478955; cv=none; b=mcbCVPpimbK69Rn//iLKpMTjs+SNueDcytTBobJ/6uoKYRALsyAEz/j3n+WysxtdsPz+sXFxtvm61b7+8ewqxkl+qG61Sy6B/8RFsaXXCpqECvkuMLFgmRJeufBuw68f3No7c/B3TprRO8SKGQyu8ZiT+ds/gtz8Dk5QDvSGHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746478955; c=relaxed/simple;
	bh=3CMcJyEmd1E4H6N8nUT9yDm/nXton5biDGdfHfBjja0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ei10qAmqYUTaGHAqy7Ba9ZbV/1ZVh1raL2S7VB6xdxbWISVhKmVI0uk4FEXRV8JpDVp+aDZGkg+1uWQKaNAtORTa8GFGANNlBkjZy7bcf5JhPFqEaove0Hd0kTm+J92Fgx13TpOlPg6aia85SlH+QrrVMrVTkzpc7dLP+Qw6j1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Wp7K74D5; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=0aNofVwsenyhD0ZZ4hEtlxuqS6aX+md3VKYHUKteKbM=; b=Wp7K74D53WrmNPZl
	i1bs1soOLv2U6puZTQfoL2lZWpqKjwGGop1t4/fPZ6g3/bRafZKPTxWfd+KZ6aKb0TJ99wR2VAEVZ
	LAyKQrLNqHsn6z7rFbZU7zvhQRXqumvNQMKzInAsg0Hnj5+V+O84Orq5e/ayyU+6hAMhN3/6m11k+
	C171rG+FM+5Seo3tBmLfXKIYV4UWdMC0Xw2gKsW1XT3TQdMfsNEC+StHLGu/1lD38UrrhGpo7Q70P
	xqt//vdoruhOdK8SJijUUD8OWVoUKUWoSk8fNpkvvnI4cilremaXz2+ZrfH9VZusuqqiVYfcRtWmp
	OKiZ8rRnyUS3M3G08w==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uC2xH-001WSi-1H;
	Mon, 05 May 2025 21:02:27 +0000
From: linux@treblig.org
To: bmt@zurich.ibm.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] RDMA/siw: Remove unused siw_mem_add
Date: Mon,  5 May 2025 22:02:26 +0100
Message-ID: <20250505210226.88994-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

siw_mem_add() was added in 2019 by
commit 2251334dcac9 ("rdma/siw: application buffer management")
but has remained unused.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/sw/siw/siw_mem.c | 24 ------------------------
 drivers/infiniband/sw/siw/siw_mem.h |  1 -
 2 files changed, 25 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index dcb963607c8b..ac943474d797 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -17,30 +17,6 @@
 /* Stag lookup is based on its index part only (24 bits). */
 #define SIW_STAG_MAX_INDEX	0x00ffffff
 
-/*
- * The code avoids special Stag of zero and tries to randomize
- * STag values between 1 and SIW_STAG_MAX_INDEX.
- */
-int siw_mem_add(struct siw_device *sdev, struct siw_mem *m)
-{
-	struct xa_limit limit = XA_LIMIT(1, SIW_STAG_MAX_INDEX);
-	u32 id, next;
-
-	get_random_bytes(&next, 4);
-	next &= SIW_STAG_MAX_INDEX;
-
-	if (xa_alloc_cyclic(&sdev->mem_xa, &id, m, limit, &next,
-	    GFP_KERNEL) < 0)
-		return -ENOMEM;
-
-	/* Set the STag index part */
-	m->stag = id << 8;
-
-	siw_dbg_mem(m, "new MEM object\n");
-
-	return 0;
-}
-
 /*
  * siw_mem_id2obj()
  *
diff --git a/drivers/infiniband/sw/siw/siw_mem.h b/drivers/infiniband/sw/siw/siw_mem.h
index e74cfcd6dbc1..8e769d30e2ac 100644
--- a/drivers/infiniband/sw/siw/siw_mem.h
+++ b/drivers/infiniband/sw/siw/siw_mem.h
@@ -12,7 +12,6 @@ void siw_umem_release(struct siw_umem *umem);
 struct siw_pbl *siw_pbl_alloc(u32 num_buf);
 dma_addr_t siw_pbl_get_buffer(struct siw_pbl *pbl, u64 off, int *len, int *idx);
 struct siw_mem *siw_mem_id2obj(struct siw_device *sdev, int stag_index);
-int siw_mem_add(struct siw_device *sdev, struct siw_mem *m);
 int siw_invalidate_stag(struct ib_pd *pd, u32 stag);
 int siw_check_mem(struct ib_pd *pd, struct siw_mem *mem, u64 addr,
 		  enum ib_access_flags perms, int len);
-- 
2.49.0


