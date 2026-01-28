Return-Path: <linux-rdma+bounces-16111-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MldNRRqeWmPwwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16111-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 02:44:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF8C9C04C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 02:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAF5B3012C7F
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 01:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3666257844;
	Wed, 28 Jan 2026 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2U3ffgp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FB3255E43;
	Wed, 28 Jan 2026 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564688; cv=none; b=ZY+//AWdj/uR+/CS5Zq5EIVaR5WHptl21q/MgBu4z/NhEKBEo9J/g2lgto85ElzY5AQacXzGFa8XuCFRokWge/uVJT02TFIfPtBhG5zxeRP6yrkMiE60iMxMxdhMH+NXCxy34BURJ1PdfAO4FaBEoTBspq5N+ME5kNcaEgNBRJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564688; c=relaxed/simple;
	bh=L34J9dl+eRBhWI/L/HY9I5vyGWXT45NqS4E1zC5487c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MU5g9s8CJhwTNo/595+ho/c8oldQJKjS8pxQXHpjaav+Typ831WvsJp+rETA1KurKmzIQ3wE20mhBUXTDlF7LyZJb479tDasBHOCf0wNzgWcXs4eVWtHuyD1KUnFtU72HpNCk89o+DVlx5KhRYuztjXPd7Sk7wgGKzKjDkk1lcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2U3ffgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A53C116C6;
	Wed, 28 Jan 2026 01:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769564688;
	bh=L34J9dl+eRBhWI/L/HY9I5vyGWXT45NqS4E1zC5487c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2U3ffgpczD+WU0/LUto0sFyhNyJ4PYsD76CDHv17nzdnR7wp1J24hsIml3Zo3PA5
	 eXF7GN6Ej3MWCkA9IO1WjRbTiuWmbar15oN1Uj8Gzq3falEURavbpAXnuX2dKkBTWp
	 weNwAd1aKw2o06ZzOUQDzyZoeWTVMj8dXx0qcx6WSCw5/z3rpLM87GOKN/CS5Y3Va4
	 pK0JPfXzpHxUgkmD7pZqbBXpWcns66pfJgV/JVqn1jwWqOirPMIfVD7Ntt9v/VCAp+
	 +RBdAYDggFo17TX4lGbWdPAJNLqhQkeWflP1MZm55TyxTrKo31glKk4MBEy+we50dM
	 psRkjr+zKDcsQ==
From: carlos.bilbao@kernel.org
To: Leon Romanovsky <leon@kernel.org>
Cc: Carlos Bilbao <carlos.bilbao@lambdal.com>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlos Bilbao <carlos.bilbao@kernel.org>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Subject: [PATCH v2] RDMA/irdma: Use kvzalloc for paged memory DMA address array
Date: Tue, 27 Jan 2026 17:44:46 -0800
Message-ID: <20260128014446.405247-1-carlos.bilbao@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126194655.GN13967@unreal>
References: <20260126194655.GN13967@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16111-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.bilbao@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 2AF8C9C04C
X-Rspamd-Action: no action

From: Carlos Bilbao <carlos.bilbao@kernel.org>

Allocate array chunk->dmainfo.dmaaddrs using kvzalloc() to allow the
allocation to fall back to vmalloc when contiguous memory is unavailable
(instead of failing and logging page allocation warnings).

Acked-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
---
 drivers/infiniband/hw/irdma/utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 13d7499131d4..6aac6d314564 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2239,7 +2239,7 @@ void irdma_pble_free_paged_mem(struct irdma_chunk *chunk)
 				 chunk->pg_cnt);
 
 done:
-	kfree(chunk->dmainfo.dmaaddrs);
+	kvfree(chunk->dmainfo.dmaaddrs);
 	chunk->dmainfo.dmaaddrs = NULL;
 	vfree(chunk->vaddr);
 	chunk->vaddr = NULL;
@@ -2256,7 +2256,7 @@ int irdma_pble_get_paged_mem(struct irdma_chunk *chunk, u32 pg_cnt)
 	u32 size;
 	void *va;
 
-	chunk->dmainfo.dmaaddrs = kzalloc(pg_cnt << 3, GFP_KERNEL);
+	chunk->dmainfo.dmaaddrs = kvzalloc(pg_cnt << 3, GFP_KERNEL);
 	if (!chunk->dmainfo.dmaaddrs)
 		return -ENOMEM;
 
@@ -2277,7 +2277,7 @@ int irdma_pble_get_paged_mem(struct irdma_chunk *chunk, u32 pg_cnt)
 
 	return 0;
 err:
-	kfree(chunk->dmainfo.dmaaddrs);
+	kvfree(chunk->dmainfo.dmaaddrs);
 	chunk->dmainfo.dmaaddrs = NULL;
 
 	return -ENOMEM;
-- 
2.43.0


