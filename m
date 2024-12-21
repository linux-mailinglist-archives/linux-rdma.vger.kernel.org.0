Return-Path: <linux-rdma+bounces-6690-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9959F9DC4
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 02:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D7216800A
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Dec 2024 01:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC1558BB;
	Sat, 21 Dec 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="Ifvc09ke"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B006282EE;
	Sat, 21 Dec 2024 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734745232; cv=none; b=aluqddDPxSgJawHpB6AUfR97uEPbRJslVTGte5DrcYlGtywIdQGEB9XLERjAET4jYtGEIgQ302udbTYWctKDnqk/xIyDcmN+dIj9OGE3nmGdrvzkmo9ZNrVaL+X0yCqjTAJZp2D+Hio2/jMTmssR9N6T9PosPt1Gu3vVUiBMFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734745232; c=relaxed/simple;
	bh=59cATSC8tYG6qTczkafkxfKMcZ83dqEKLqp5g3yDhlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T2OXx772je7K9nmTaGGCsIrZWg9TyEHmn2EbYz03AsiD/DXPX33j7I/2sEdv50Fi5xkkKt18nxJhEJAA6WlPlxsVZMdzlBjY8wFMlTfa1IpH3eF/IEq3VWaEHNexAbNhhSW4Yqaevtgms9RSYPTY8kRfnwckGTuNYVQx8UDk7mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=Ifvc09ke; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=/EYrkAQg5wWMF/k4iroqJWgKXPZPZyDZ6ZVafcGJAvo=; b=Ifvc09ke/KxQGu2V
	4mHJ+iho7soxuawpW9GcO3yDBAtiljoAf+pMNDI3Y/g/8mYBedZmFk0DvhxnThTT8Xhiaty7bRWyA
	g1smLO8gNr/ifbl80PBZFZnW1SnHJZBYzoppqt7hwl4N2PkGaSyF1wZk4AJyunpIulC5LHqVOvglG
	FR006bo/nU7FSWXBB39OWE3SS9Ig3WnaysKwJp7NWkmnpBOIrWwRyYhfbKb6oxFXNwa3k4eQTc0VP
	p93USdueU1KyBz/icXSKyB83eNF51rE/TWQ4Co7QH4BNDrRzyt4AfTzAssXFUK9Pya/fMUz274zEV
	xv/5WFxx0PJH0YvuGA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tOoTj-006dmT-3A;
	Sat, 21 Dec 2024 01:40:28 +0000
From: linux@treblig.org
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/4] RDMA/core: Remove unused ib_find_exact_cached_pkey
Date: Sat, 21 Dec 2024 01:40:19 +0000
Message-ID: <20241221014021.343979-3-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221014021.343979-1-linux@treblig.org>
References: <20241221014021.343979-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The last use of ib_find_exact_cached_pkey() was removed in 2012
by commit 2c75d2ccb6e5 ("IB/mlx4: Fix QP1 P_Key processing in the Primary
Physical Function (PPF)")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/infiniband/core/cache.c | 35 ---------------------------------
 include/rdma/ib_cache.h         | 16 ---------------
 2 files changed, 51 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index b7c078b7f7cf..f8413f8a9f26 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1127,41 +1127,6 @@ int ib_find_cached_pkey(struct ib_device *device, u32 port_num,
 }
 EXPORT_SYMBOL(ib_find_cached_pkey);
 
-int ib_find_exact_cached_pkey(struct ib_device *device, u32 port_num,
-			      u16 pkey, u16 *index)
-{
-	struct ib_pkey_cache *cache;
-	unsigned long flags;
-	int i;
-	int ret = -ENOENT;
-
-	if (!rdma_is_port_valid(device, port_num))
-		return -EINVAL;
-
-	read_lock_irqsave(&device->cache_lock, flags);
-
-	cache = device->port_data[port_num].cache.pkey;
-	if (!cache) {
-		ret = -EINVAL;
-		goto err;
-	}
-
-	*index = -1;
-
-	for (i = 0; i < cache->table_len; ++i)
-		if (cache->table[i] == pkey) {
-			*index = i;
-			ret = 0;
-			break;
-		}
-
-err:
-	read_unlock_irqrestore(&device->cache_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(ib_find_exact_cached_pkey);
-
 int ib_get_cached_lmc(struct ib_device *device, u32 port_num, u8 *lmc)
 {
 	unsigned long flags;
diff --git a/include/rdma/ib_cache.h b/include/rdma/ib_cache.h
index 226ae3702d8a..2bf09b594d10 100644
--- a/include/rdma/ib_cache.h
+++ b/include/rdma/ib_cache.h
@@ -63,22 +63,6 @@ int ib_find_cached_pkey(struct ib_device    *device,
 			u16                  pkey,
 			u16                 *index);
 
-/**
- * ib_find_exact_cached_pkey - Returns the PKey table index where a specified
- *   PKey value occurs. Comparison uses the FULL 16 bits (incl membership bit)
- * @device: The device to query.
- * @port_num: The port number of the device to search for the PKey.
- * @pkey: The PKey value to search for.
- * @index: The index into the cached PKey table where the PKey was found.
- *
- * ib_find_exact_cached_pkey() searches the specified PKey table in
- * the local software cache.
- */
-int ib_find_exact_cached_pkey(struct ib_device    *device,
-			      u32                  port_num,
-			      u16                  pkey,
-			      u16                 *index);
-
 /**
  * ib_get_cached_lmc - Returns a cached lmc table entry
  * @device: The device to query.
-- 
2.47.1


