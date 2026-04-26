Return-Path: <linux-rdma+bounces-19563-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yyd4IvkR7mkSqgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19563-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:24:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD429469F28
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 15:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF72C300C01E
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Apr 2026 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA2D361DD0;
	Sun, 26 Apr 2026 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5Lk5kxR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F1236166F
	for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209844; cv=none; b=s0/X6BIktM0iYxfa4qzOYUQr+KOLj4IMbeKv8dm3uSExisXLr216BQFj+8Fzwm7OGwGaaE7KyaH64cMgraWQTJfOTUX/YahfYNSx/i3IJmX81n4JFb3LDsTpGk+e0tI5rP9jDz2RuhrRl8+A4ZkBnwm10ZfppOjawqqysg/Nkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209844; c=relaxed/simple;
	bh=LWM6HVvLB3siDa8uee4eKBpkMgIxMcJcTfUZ2PDqrpk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCfVoMTnAyuE6FF7zViwSg+1pZJqIiKAR9w0uErTy5TqJ/Rae7Yt/KOxCWTiA4tCh5amyhwnwAoMUgREWDSFRh8V/p6WirtJDmhG2aDBTmsU8NFq1zp7/9eDRUpF2iz0eYO/tczfpqgQbYgnQab6hz340iYLKplK9MF2E2rvI2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5Lk5kxR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so121612055e9.0
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 06:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777209841; x=1777814641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=glWTzLuCweIyCCW4tksfnjVH1VqFaefOjJWpjhDpMUo=;
        b=Q5Lk5kxRvNLPiFU8aRm8JODwoRyNXqGSolBkPS7UhOaDueHFg/VaFoWL3RnRQ35ixP
         grLAFlZz44EgKKG24++NReNimSkMh1HXjrcGNHTbpjxKAg0mZ2iJN93cszoC8TOoeDvA
         VyJih2aBYrAjlWGpe4PKrO25lGnqsgm2rGVuZmKtoKHfbOOyi22NFoNMtmeueqcUIhEO
         kKAEfad8PdWI7Rl1WUhXgL4n9A8GWCBJzH+x13PDTBZHgs5lyBLlHGIw515eisb2FgNc
         ehsdixMG/a1xB6UgS6zwwxYj8R/yTFv2I2fznMBh1xCf8ddVTs5iJh1nmpMo4VrzDljI
         SjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777209841; x=1777814641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glWTzLuCweIyCCW4tksfnjVH1VqFaefOjJWpjhDpMUo=;
        b=ojomq5TCoYeHpNxYcrXROd+xGr1IAinrUrKKF2KNocToYdvUJGl/dS3MoLGj7F5VcX
         TV/gmeUCOonaH+TOpm2bdvTgKPpjtoIjZ7K696Ues7HryKWhsWnL5Wcmx+jGiAaFQqei
         07jobykHA96e/op/vkC/QyHimIBysRZWRp0PXEUw/smW9P8jfX7sVWHYbhi5ZjuHgh/6
         zAk29/ZOe7Z5F54bNIwBYP8OquEDAe79a5GwrrGOw2yXjG2hw3YNkLVWnh4BeGbW6CpY
         nzSAHXN+aJr0NYMykARAcvGtRNy3aBmKgRXvcDE4rLGhJEVB5I+wcTTlD0cJCVVT7leE
         V3rw==
X-Forwarded-Encrypted: i=1; AFNElJ9M6g4J25jlpMoTPTLLrtp3WQWBf0QFSqdvUvX3hGrF4OzPiDzbXr3QfnqtOlfkW/0HX96n70G+pJwS@vger.kernel.org
X-Gm-Message-State: AOJu0YzHa3MKKR6rA0AF/ClWLdquS+1NWGAiLCbIB5FCDqG3LuP7/kZi
	VKRJG6CbfTdqZDn7d0+oIHXY1m6H6XJ4MKLX1OGx54MTwMOzKs/LuI2f
X-Gm-Gg: AeBDiesdyoClz/9WAJbJtmPbXUu6qf3brejRhY/DuB4zBxw+cq3mUjFFrf8F8f09u3D
	60ZYcqQszcDav+FtYEAhOLIwpC9UYcMIM29+fOi2k89ClOinEUu9PJLQ48dfVuwqA8gd1Ray9RJ
	/1yKE2QuEDT423xx8b3GPskBAkjQEOWjwxZ/SzRaxf2/rBNj3CsTGYp0ad2XYOP+RvXWdv8g7eT
	09A5jrHZ2BwjCnCvVlHzgO1fMOhUeTr6p/F9EMvN7j/ScPzEteHXonzF9BT2XkSg5GZwLLpfspJ
	txCj+KTAAIhbTYPDeAP8Y31STa2aOsdSdE1RlaqhKM00uHsGRkIWXzTY15oUEQrnOXoOzkTsZUt
	t1MV5nGcbwmJBZcx7URFWvOHc06ORLh7bmxddZJZPoRO1+dVJhaB+eWw7reLn2wHM/gD18AppOH
	SNqm3ZvDrWiWogGMZh3vF2pCXpanGofX2y8dk9D5YP4XmBlVshXUS05ppgqo7S6Ak2QGxYUQD4X
	xDSbhzblAHx4lB8JpqAkavpriLVNWcWCaBMUAPD+A==
X-Received: by 2002:a05:600c:4fd2:b0:488:e192:6fbd with SMTP id 5b1f17b1804b1-488fb790869mr549903445e9.30.1777209840929;
        Sun, 26 Apr 2026 06:24:00 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a52583fe7sm401895935e9.13.2026.04.26.06.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 06:24:00 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: michaelgur@nvidia.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v2] RDMA/mlx5: Fix UMR XLT cleanup on ODP populate failure
Date: Sun, 26 Apr 2026 14:23:41 +0100
Message-ID: <20260426132356.22264-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD429469F28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19563-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

mlx5r_umr_update_xlt() allocates and DMA maps an XLT buffer with
mlx5r_umr_create_xlt(). The buffer is released by the common cleanup path
through mlx5r_umr_unmap_free_xlt().

After mlx5_odp_populate_xlt() became fallible, its error path returned
directly and skipped that cleanup. This leaks the XLT DMA mapping and
buffer. If the emergency XLT page was used, it also leaves
xlt_emergency_page_mutex locked.

Break out of the loop so execution falls through the existing cleanup path.

Fixes: 1efe8c0670d6 ("RDMA/core: Convert UMEM ODP DMA mapping to caching IOVA and page linkage")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v2:
 - Use 'break' instead of 'goto' as the loop already checks 'err'. (Michael Gur)

 drivers/infiniband/hw/mlx5/umr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 29488fba21a0..71f331ce6d89 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -915,7 +915,7 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		 */
 		err = mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
 		if (err)
-			return err;
+			break;
 		dma_sync_single_for_device(ddev, sg.addr, sg.length,
 					   DMA_TO_DEVICE);
 		sg.length = ALIGN(size_to_map, MLX5_UMR_FLEX_ALIGNMENT);
-- 
2.43.0


