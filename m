Return-Path: <linux-rdma+bounces-19991-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGknHEeh+WnR+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19991-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:50:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D73124C83FE
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C33403082E84
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5B3E92B3;
	Tue,  5 May 2026 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e7+8jQPw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A5E3E9582
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967238; cv=none; b=t8lLlIRV4HqVQI+JLW26PzfpRM5WrI/8acRE9nUAkSsdtvNXrj5GGXqspK2E1tUzLLIE7kw8Kbt9fBbhlEcrH+vUZgLyMTJy2/qfB+fJjmygY6JVUPAy01H5y/iT553JEvh0DugOdo30aDvHmIRBtvNsMJqDO668H4Fx7/1yDCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967238; c=relaxed/simple;
	bh=8bVESHlQtb4wAiBXCXJWKcAcCrTP+cYVHRS4W8j7Asc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wxy/AEnY6V/Dmjj0jz9uIuDyzw1o58UjvdKd5v+P6nTxIMmvYNV6Q5OJWgwjxycJtnRzSQhvTjER54DdOc3YA1lPxIJ9suYUUBIzEqNBe1alQqgVOhgG6+ltx2WdexpIt6TPIvTWEu4u+KtlZeYIi1V9paQpS0b6q+Ym46nG1AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e7+8jQPw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48909558b3aso53375195e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967233; x=1778572033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Io7jaCur3kUqauPNdKS7HiygGLi+rI5gUmYd2CRwzg=;
        b=e7+8jQPw5g2htH8RSHQvIRw8HAlBEnZbvoB8wkk7RCOV/r8b/T+9PNX6LrR83JLffa
         VXk9jYSazT99F0cfGKJks8m3YsFVezaNZUlcPmzf004vpa5+sIew87OVXBj1rP7Vax+r
         Ovbh1UOEfo3r/aowPgFNUlQS04l5y+WkrXoJAgpKzxspq4FMTnMeiQAoH3kpQyXpmkrz
         quqQupRWSeqXaC4bIR4qhPPdPBoFu34fOaN9bo5qbIFNDnb1zHnL5AXXaJ5sWtjFOZKZ
         aX6EFvugroceKySZpUQfdsBsljJ5S1E4qwfrnFeWmdog0Qtl47v+x+7pp2RF+VEpJIFq
         7qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967233; x=1778572033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Io7jaCur3kUqauPNdKS7HiygGLi+rI5gUmYd2CRwzg=;
        b=UzCpjAPZWNNYU9Cz0HJm2QkqBZnzeQ1vsj/yZGjZh0qsghHBvWLSZTW6wj4LyD1w06
         Ng9WNun7MjwVZM+zMGwEFVpo+uRq+Yywr2Mr91eWZ8C3a8ukcJVc/QY+RTv6Tk5GCBAY
         w2yI27fJbN7IPBmCVo6KxWX3iBakh1wk/78MbUM1D9aQLJ1yvxYzz5J2eojvIhNsxnKu
         F6faz7bssYW54X5t0Jg3+gsx3XmybCigBmEhvEVRMkIPPuYLtxiFIxV+SmxSVpEn1dAX
         LwJc5EfIBeUSwNz0EgLrcwkfyFQIzDql2emgCrUqp3+FFdxf9TzfoSWnZ6g7YAIN4PIw
         KGCg==
X-Forwarded-Encrypted: i=1; AFNElJ/35dH5kOv/Twhb3UpLeeOL+/zT7ErmI0TfYm+ORjYbfqfuh+8Ko0aQRXpcaoHvHs4kBe1HSwCXDez5@vger.kernel.org
X-Gm-Message-State: AOJu0YwFnR6FiOaIK4JReQNSxshZ3a3yOFcoddnqixXvKrAijdv8UiJw
	3XyRrWS6zF1+oatU9HxZtJQGcAQdBSV6DYIh58c8NG43+Kb/IUIm/jHHyTdL3SZrGpY=
X-Gm-Gg: AeBDiesJrffqHzluZaiQmSul0A8+MtJjacvEBchUoBZeHXgh559A6jZshKPvjBmR2r7
	tkYlsURsIOhAWLFaA0qCKIppKIRI+auiZIZyw702zxmXUKwDwGIQCRx5QUDH4d2dfuYMOP9q7+C
	4SpPYFfiBp+X5a63ieLmKvqr2Pz6fSK1AYbQBJaOyPWDbV+Bh2v8IADAzRXE7ma5iiTsDCwhl9q
	y6gzoq1kTwxWs75bpyk1OVzFxDIQGZnBz/Za7XcmaFUjVBGp11aXp2h28M3t9h2xCWmAUzlZbp9
	gRIE94cdjLAhPx1BqR1MhQ6KIWAAE67yrg6MBccOi6S7hVq0rGCGa/cVqbYJznEAJJrU4ZW/YrW
	dC1v7s8U7NYx4FTa2O4Jv7QAwJ8wppRm27+Pt5r03usf4G6ZQqhq2QA4HDsoTnpuUAwkfIViwl5
	XDKDdiym/HawRaKiWieJRiEOzsnqe/YFlPJ1phGGkUiDL/zYX6tX96JNh+qqMUr26mtp/IdPUjR
	Nt6/4fiUomnuhyC2H5Ivmb3UWEmTZSLZ23oOdw3ZmcnXj99qokle88f
X-Received: by 2002:a05:600c:8590:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-48a986381b8mr160222445e9.9.1777967232429;
        Tue, 05 May 2026 00:47:12 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:12 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	jgg@ziepe.ca,
	leon@kernel.org,
	jinpu.wang@ionos.com,
	Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jia Li <jia.li@ionos.com>
Subject: [PATCH 02/13] RDMA/rmr: add shared library code (pool, map, request)
Date: Tue,  5 May 2026 09:46:14 +0200
Message-ID: <20260505074644.195453-3-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505074644.195453-1-haris.iqbal@ionos.com>
References: <20260505074644.195453-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D73124C83FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19991-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

Add the three source files that provide functionality shared by both
the RMR client and the RMR server:

  rmr-pool.c	pool refcounting, lookup and lifecycle helpers used
		by both client and server pool implementations.
  rmr-map.c	dirty-map data structure used to track which blocks
		have not yet been replicated to a given pool member.
  rmr-req.c	server-side request infrastructure that submits an
		I/O to an upper-layer store via struct
		rmr_srv_store_ops and propagates the completion back
		into RMR.

These files are not compiled until the modules are wired into the
build in a later patch in this series.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/infiniband/ulp/rmr/rmr-map.c  | 904 ++++++++++++++++++++++++++
 drivers/infiniband/ulp/rmr/rmr-pool.c | 401 ++++++++++++
 drivers/infiniband/ulp/rmr/rmr-req.c  | 796 +++++++++++++++++++++++
 3 files changed, 2101 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-map.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-pool.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-req.c

diff --git a/drivers/infiniband/ulp/rmr/rmr-map.c b/drivers/infiniband/ulp/rmr/rmr-map.c
new file mode 100644
index 000000000000..f4b7dd7c3b50
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-map.c
@@ -0,0 +1,904 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#include <linux/slab.h>
+
+#include "rmr-map.h"
+#include "rmr-pool.h"
+
+void rmr_map_update_page_params(struct rmr_dirty_id_map *map)
+{
+	unsigned long remaining_chunks;
+
+	map->no_of_flp = (map->no_of_chunks >> CHUNKS_PER_FLP_LOG2);
+
+	/*
+	 * If the number of chunks are not completely filling an FLP (CHUNKS_PER_FLP),
+	 * then the remaining would be tracked by the next FLP. Thus the next FLP would
+	 * have unused SLP pointers. We will calculate the number of SLP slots which will
+	 * be used in the last FLP.
+	 */
+	remaining_chunks = map->no_of_chunks & (CHUNKS_PER_FLP - 1);
+	if (!remaining_chunks) {
+		/*
+		 * If there are no remaining chunks, then the last FLP is completely full.
+		 */
+		map->no_of_slp_in_last_flp = NO_OF_SLP_PER_FLP;
+		map->no_of_chunk_in_last_slp = NO_OF_CHUNKS_PER_PAGE;
+	} else {
+		/*
+		 * If there are remaining chunks, then we add another FLP for it.
+		 * This FLP will not be full, hence we calculate the number of SLP slots
+		 * that will be used.
+		 */
+		map->no_of_flp += 1;
+		map->no_of_slp_in_last_flp = (remaining_chunks >> CHUNKS_PER_SLP_LOG2);
+
+		/*
+		 * Same as above. It could be that the number of chunks do not fit neatly
+		 * in the last SLP (CHUNKS_PER_SLP), and the remaining ones end up in the
+		 * SLP with remaining chunk slots.
+		 */
+		remaining_chunks &= (CHUNKS_PER_SLP - 1);
+		if (!remaining_chunks) {
+			/*
+			 * If there are no remaining chunks, then the last SLP is completely full.
+			 */
+			map->no_of_chunk_in_last_slp = CHUNKS_PER_SLP;
+		} else {
+			/*
+			 * If there are remaining chunks, then we add another SLP.
+			 */
+			map->no_of_slp_in_last_flp += 1;
+			map->no_of_chunk_in_last_slp = remaining_chunks;
+		}
+	}
+
+	map->total_slp = ((map->no_of_flp - 1) * NO_OF_SLP_PER_FLP) + map->no_of_slp_in_last_flp;
+}
+
+static void rmr_map_update_map_params(struct rmr_pool *pool, struct rmr_dirty_id_map *map)
+{
+	map->no_of_chunks = pool->no_of_chunks;
+
+	rmr_map_update_page_params(map);
+
+	pr_info("%s: Chunks info %u, %u, %u, %llu\n",
+		__func__, pool->chunk_size, ilog2(pool->chunk_size),
+		pool->chunk_size_shift, map->no_of_chunks);
+	pr_info("%s: FLPs %llu, SLPs in last FLP %llu, Total SLPs %llu, chunks in last SLP %llu\n",
+		__func__, map->no_of_flp, map->no_of_slp_in_last_flp, map->total_slp,
+		map->no_of_chunk_in_last_slp);
+	pr_info("%s: Dirty map size %lldB\n", __func__, (map->total_slp * PAGE_SIZE));
+}
+
+static int rmr_map_allocate_pages(struct rmr_pool *pool, struct rmr_dirty_id_map *map)
+{
+	el_flp *flp_ptr;
+	u64 no_of_slps;
+	int i, j;
+
+	for (i = 0; i < map->no_of_flp;) {
+		map->dirty_bitmap[i] = (void *)get_zeroed_page(GFP_KERNEL);
+		if (!map->dirty_bitmap[i])
+			goto err_alloc;
+		flp_ptr = (el_flp *)map->dirty_bitmap[i];
+
+		if (i == (map->no_of_flp - 1))
+			no_of_slps = map->no_of_slp_in_last_flp;
+		else
+			no_of_slps = NO_OF_SLP_PER_FLP;
+
+		/*
+		 * Move the increment to here, so that later in err_alloc: if we have to free,
+		 * the index i, is pointing in the correct position.
+		 */
+		i++;
+
+		for (j = 0; j < no_of_slps; j++, flp_ptr++) {
+			*flp_ptr = get_zeroed_page(GFP_KERNEL);
+			if (!*flp_ptr)
+				goto err_alloc;
+		}
+	}
+
+	// TODO remove this
+	map->bitmap_filter = kcalloc(pool->no_of_chunks, sizeof(*map->bitmap_filter), GFP_KERNEL);
+	if (!map->bitmap_filter)
+		goto err_alloc;
+
+	return 0;
+
+err_alloc:
+	for (--i; i >= 0; i--) {
+		flp_ptr = (el_flp *)map->dirty_bitmap[i];
+
+		for (--j; j >= 0; j--)
+			free_page((unsigned long)*(flp_ptr + j));
+
+		j = NO_OF_SLP_PER_FLP;
+		free_page((unsigned long)map->dirty_bitmap[i]);
+	}
+
+	return -ENOMEM;
+}
+
+struct rmr_dirty_id_map *rmr_map_create(struct rmr_pool *pool, u8 member_id)
+{
+	struct rmr_dirty_id_map *map = NULL;
+	int ret;
+
+	pr_info("%s: Creating map for member_id %u, in pool %s. Existing map_cnt %u\n",
+		__func__, member_id, pool->poolname, pool->maps_cnt);
+
+	if (!pool->no_of_chunks) {
+		pr_err("%s: dirty map size cannot be zero\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	mutex_lock(&pool->maps_lock);
+
+	/*
+	 * Don't create if already exists
+	 */
+	map = rmr_pool_find_map(pool, member_id);
+	if (map != NULL) {
+		pr_err("Map with member_id %u already exists\n", member_id);
+		ret = -EEXIST;
+		goto err_unlock;
+	}
+
+	if (pool->maps_cnt >= RMR_POOL_MAX_SESS) {
+		pr_err("pool %s can not create new map, max number of sessions %d achieved\n",
+		       pool->poolname, RMR_POOL_MAX_SESS);
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
+	/*
+	 * Allocate memory and init the structure
+	 */
+	map = (struct rmr_dirty_id_map *)get_zeroed_page(GFP_KERNEL);
+	if (!map) {
+		pr_err("cannot allocate map for member_id %u\n", member_id);
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
+	rmr_map_update_map_params(pool, map);
+
+	ret = rmr_map_allocate_pages(pool, map);
+	if (ret) {
+		pr_err("cannot allocate memory for member_id %u\n", member_id);
+		goto err_map;
+	}
+
+	xa_init_flags(&map->rmr_id_map, XA_FLAGS_ALLOC);
+	map->member_id = member_id;
+	map->ts = jiffies;
+
+	rmr_pool_maps_append(pool, map);
+
+	mutex_unlock(&pool->maps_lock);
+
+	return map;
+
+err_map:
+	free_page((unsigned long)map);
+err_unlock:
+	mutex_unlock(&pool->maps_lock);
+	return ERR_PTR(ret);
+}
+
+void rmr_map_destroy(struct rmr_dirty_id_map *map)
+{
+	el_flp *flp_ptr;
+	int i, j;
+	u64 no_of_slps;
+
+	WARN_ON(!xa_empty(&map->rmr_id_map));
+	map->ts = jiffies;
+
+	pr_info("%s: member_id %u\n", __func__, map->member_id);
+	kfree(map->bitmap_filter);
+
+	for (i = 0; i < map->no_of_flp; i++) {
+		flp_ptr = (el_flp *)map->dirty_bitmap[i];
+
+		if (i == (map->no_of_flp - 1))
+			no_of_slps = map->no_of_slp_in_last_flp;
+		else
+			no_of_slps = NO_OF_SLP_PER_FLP;
+
+		for (j = 0; j < no_of_slps; j++)
+			free_page((unsigned long)*(flp_ptr + j));
+
+		free_page((unsigned long)map->dirty_bitmap[i]);
+	}
+
+	free_page((unsigned long)map);
+}
+
+/**
+ * rmr_map_calc_chunk -	Calculate chunk number from offset and length of IO
+ *
+ * @pool:		The pool
+ * @offset:		Offset of the IO
+ * @length:		Length of the IO
+ * @id:			rmr_id_t where to populate the chunk details
+ *			id.b: chunk number denoted by this entry
+ *			id.a: Number of chunks dirty starting (and including) id.b
+ *
+ *			For example:
+ *			if id.a is 1, only id.b is dirty.
+ *			if id.a is 2, id.b and (id.b+1) is dirty
+ *
+ * Context:
+ *	srcu pool->map_srcu should be held while calling this function.
+ */
+void rmr_map_calc_chunk(struct rmr_pool *pool, size_t offset, size_t length, rmr_id_t *id)
+{
+	u64 off_len = offset + length;
+
+	id->b = GET_CHUNK_NUMBER(offset, pool->chunk_size_shift);
+	id->a = GET_FOLLOWING_CHUNKS(off_len, pool->chunk_size_shift, id->b);
+}
+
+/**
+ * rmr_get_chunk_md_from_id - Get the chunk metadata byte from rmr_id_t
+ *
+ * @map:	The map to work on
+ * @id:		rmr_id_t to use to get the chunk metadata byte
+ *
+ * Context:
+ *	srcu pool->map_srcu should be held while calling this function.
+ */
+inline u8 *rmr_get_chunk_md_from_id(struct rmr_dirty_id_map *map, rmr_id_t id)
+{
+	unsigned long idb_slp, idb_slp_index, idb_chunk;
+	el_flp *flp_ptr;
+	u8 *slp, *chunk_md;
+
+	/*
+	 * First get the pointer to first level page (FLP).
+	 * To get that, we need to find which first level page the chunk belongs, and it can
+	 * be found by dividing the chunk number by the maximum number of chunks 1 FLP can track.
+	 *
+	 * After that we need to adjust the id.b to go one level down. This is because we just
+	 * moved to the desired FLP, and hence that portion of id.b can be dropped.
+	 * For this we do the modulo with CHUNKS_PER_FLP.
+	 */
+	flp_ptr = (el_flp *)(map->dirty_bitmap[id.b >> CHUNKS_PER_FLP_LOG2]);
+	idb_slp = id.b & (CHUNKS_PER_FLP - 1);
+
+	/*
+	 * Now we need to move to the second level page (SLP).
+	 * The addresses to SLPs are stored in the FLP as a list of addresses. Hence we calculate
+	 * the desired slp index which has the address to the SLP our chunk md resides in.
+	 *
+	 * We then adjust our flp_ptr according to the index.
+	 * Note that flp_ptr is of type el_flp (flp element), which is unsigned long, since
+	 * addresses are of that data type. This lets us move to the slp index easily.
+	 */
+	idb_slp_index = idb_slp >> CHUNKS_PER_SLP_LOG2;
+	flp_ptr += idb_slp_index;
+
+	/*
+	 * The location pointed by flp_ptr is storing the address to the SLP we want to move to.
+	 * So we dereference it first, and then cast it to relevant pointer (to the chunk metadata
+	 * data type, which is u8).
+	 *
+	 * The last step it to move to the correct chunk metadata in the SLP.
+	 *
+	 * Each SLP can store metadata for CHUNKS_PER_SLP chunks. So we adjust the idb_slp
+	 * accordingly. And then move our slp pointer to the correct chunk metadata byte.
+	 */
+	slp = (u8 *)(*flp_ptr);
+	idb_chunk = idb_slp & (CHUNKS_PER_SLP - 1);
+	chunk_md = slp + idb_chunk;
+
+	return chunk_md;
+}
+
+static bool rmr_chunk_md_check_dirty(u8 *chunk_md)
+{
+	return (*chunk_md) & (0x1 << CHUNK_DIRTY_BIT);
+}
+
+static void rmr_chunk_md_set_dirty(u8 *chunk_md)
+{
+	*chunk_md |= (0x1 << CHUNK_DIRTY_BIT);
+}
+
+static void rmr_chunk_md_unset_dirty(u8 *chunk_md)
+{
+	*chunk_md &= ~(0x1 << CHUNK_DIRTY_BIT);
+}
+
+/**
+ * rmr_map_set_dirty -	Set bits from rmr_id_t
+ *
+ * @map:		Map to work on
+ * @id:			rmr_id_t containing the chunk info
+ *			id.b: chunk number denoted by this entry
+ *			id.a: Number of chunks dirty starting (and including) id.b
+ * @filter:		Filter to add to entry
+ *
+ *
+ * Context:
+ *	srcu pool->map_srcu should be held while calling this function.
+ */
+inline void rmr_map_set_dirty(struct rmr_dirty_id_map *map, rmr_id_t id, u8 filter)
+{
+	u8 *chunk_md;
+	u64 i;
+
+	map->ts = jiffies;
+
+	chunk_md = rmr_get_chunk_md_from_id(map, id);
+	for (i = 0; i < id.a; i++) {
+		rmr_chunk_md_set_dirty(chunk_md);
+		chunk_md++;
+	}
+}
+
+inline void rmr_map_set_dirty_all(struct rmr_dirty_id_map *map, u8 filter)
+{
+	el_flp *flp_ptr;
+	u64 no_of_slps, no_of_chunks;
+	bool is_last_flp;
+	u8 *slp;
+	int i, j, k;
+
+	for (i = 0; i < map->no_of_flp; i++) {
+		flp_ptr = (el_flp *)map->dirty_bitmap[i];
+		is_last_flp = (i == (map->no_of_flp - 1));
+
+		if (is_last_flp)
+			no_of_slps = map->no_of_slp_in_last_flp;
+		else
+			no_of_slps = NO_OF_SLP_PER_FLP;
+
+		for (j = 0; j < no_of_slps; j++, flp_ptr++) {
+			slp = (u8 *)(*flp_ptr);
+
+			if (is_last_flp && j == (no_of_slps - 1))
+				no_of_chunks = map->no_of_chunk_in_last_slp;
+			else
+				no_of_chunks = NO_OF_CHUNKS_PER_PAGE;
+
+			for (k = 0; k < no_of_chunks; k++, slp++)
+				rmr_chunk_md_set_dirty(slp);
+		}
+	}
+}
+
+/**
+ * rmr_map_unset_dirty - Clear bits from rmr_id_t, and free entry if any
+ *
+ * @map:		Map to work on
+ * @id:			rmr_id_t containing the chunk info
+ *			id.b: chunk number denoted by this entry
+ *			id.a: Number of chunks dirty starting (and including) id.b
+ * @filter:		Filter to add to entry
+ *
+ * Description:
+ *	This version can be used by both client and server.
+ *	If entry is found, the function frees it.
+ *	Clears the bit using info from the given rmr_id_t
+ *
+ * Context:
+ *	srcu pool->map_srcu should be held while calling this function.
+ */
+inline struct rmr_map_entry *rmr_map_unset_dirty(struct rmr_dirty_id_map *map, rmr_id_t id,
+						 u8 filter)
+{
+	struct rmr_map_entry *entry;
+	u8 *chunk_md;
+	u64 i;
+
+	map->ts = jiffies;
+
+	chunk_md = rmr_get_chunk_md_from_id(map, id);
+	BUG_ON(!chunk_md);
+	for (i = 0; i < id.a; i++) {
+		rmr_chunk_md_unset_dirty(chunk_md);
+		chunk_md++;
+	}
+
+	entry = xa_erase(&map->rmr_id_map, rmr_id_to_key(id));
+	if (!entry) {
+		pr_debug("in the member_id %d there is no entry for id [%llu, %llu]\n",
+			 map->member_id, id.a, id.b);
+	}
+
+	return entry;
+}
+
+/*
+ * rmr_map_check_dirty - Check if the following bits are set or not
+ *
+ * @map:		Map to work on
+ * @id:			rmr_id_t containing the chunk info
+ *			id.b: chunk number denoted by this entry
+ *			id.a: Number of chunks dirty starting (and including) id.b
+ *
+ * Context:
+ *	srcu pool->map_srcu should be held while calling this function.
+ */
+inline bool rmr_map_check_dirty(struct rmr_dirty_id_map *map, rmr_id_t id)
+{
+	u8 *chunk_md;
+
+	chunk_md = rmr_get_chunk_md_from_id(map, id);
+	return rmr_chunk_md_check_dirty(chunk_md);
+}
+
+/**
+ * rmr_map_get_dirty_entry - Check and return entry if the following bits are set
+ *
+ * @map:		Map to work on
+ * @id:			rmr_id_t containing the chunk info
+ *			id.b: chunk number denoted by this entry
+ *			id.a: Number of chunks dirty starting (and including) id.b
+ *
+ * Description:
+ *	Check if a chunk is dirty or not.
+ *	If the particular chunk is dirty, then create an entry for it and return back.
+ *
+ * Context:
+ *	srcu pool->map_srcu should be held while calling this function.
+ */
+inline struct rmr_map_entry *rmr_map_get_dirty_entry(struct rmr_dirty_id_map *map, rmr_id_t id)
+{
+	struct rmr_map_entry *entry;
+	int err;
+
+	if (rmr_map_check_dirty(map, id)) {
+		entry = xa_load(&map->rmr_id_map, rmr_id_to_key(id));
+		if (entry) {
+			pr_debug("%s: For id [%llu, %llu], entry exists member_id %u\n",
+				 __func__, id.a, id.b, map->member_id);
+			return entry;
+		}
+
+		entry = kmem_cache_zalloc(rmr_map_entry_cachep, GFP_KERNEL);
+		if (!entry) {
+			pr_err("%s: Cannot allocate entry for member_id %d, id [[%llu, %llu]]\n",
+			       __func__, map->member_id, id.a, id.b);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		atomic_set(&entry->sync_cnt, -1);
+		init_llist_head(&entry->wait_list);
+
+		err = xa_insert(&map->rmr_id_map, rmr_id_to_key(id), entry, GFP_KERNEL);
+		if (err == 0)
+			return entry;
+
+		kmem_cache_free(rmr_map_entry_cachep, entry);
+
+		if (err == -EBUSY)
+			return xa_load(&map->rmr_id_map, rmr_id_to_key(id));
+		else
+			return ERR_PTR(-ENOMEM);
+	}
+
+	return NULL;
+}
+
+/**
+ * rmr_map_clear_filter_all - Clear filter for entire bitmap
+ *
+ * @map:       Map to work on
+ * @filter:    Filter to be cleared
+ *
+ * Context:
+ *	srcu pool->map_srcu should be held while calling this function.
+ */
+inline void rmr_map_clear_filter_all(struct rmr_dirty_id_map *map, u8 filter)
+{
+	u64 i;
+
+	for (i = 0; i < map->no_of_chunks; i++)
+		map->bitmap_filter[i] &= ~filter;
+}
+
+/**
+ * rmr_map_unset_dirty_all - Clear all chunk bits (the entire map)
+ *
+ * @map:       Map to work on
+ *
+ * Context:
+ *	srcu pool->map_srcu should be held while calling this function.
+ */
+inline void rmr_map_unset_dirty_all(struct rmr_dirty_id_map *map)
+{
+	rmr_id_t id;
+	u64 i;
+
+	/*
+	 * TODO: memcpy zeroes or something faster
+	 */
+
+	id.a = 1;
+	for (i = 0; i < map->no_of_chunks; i++) {
+		id.b = i;
+
+		if (!rmr_map_check_dirty(map, id))
+			continue;
+
+		rmr_map_unset_dirty(map, id, MAP_NO_FILTER);
+	}
+
+	rmr_map_clear_filter_all(map, MAP_ENTRY_UNSYNCED);
+}
+
+/**
+ * rmr_map_empty - Check if there are any chunks dirty
+ *
+ * @map:       Map to work on
+ *
+ * Return:
+ *	True:	If map is empty
+ *	False:	Otherwise
+ *
+ * Context:
+ *	srcu pool->map_srcu should be held while calling this function.
+ */
+inline bool rmr_map_empty(struct rmr_dirty_id_map *map)
+{
+	el_flp *flp_ptr;
+	u64 no_of_slps, no_of_chunks;
+	bool is_last_flp;
+	u8 *slp;
+	int i, j, k;
+
+	for (i = 0; i < map->no_of_flp; i++) {
+		flp_ptr = (el_flp *)map->dirty_bitmap[i];
+		is_last_flp = (i == (map->no_of_flp - 1));
+
+		if (is_last_flp)
+			no_of_slps = map->no_of_slp_in_last_flp;
+		else
+			no_of_slps = NO_OF_SLP_PER_FLP;
+
+		for (j = 0; j < no_of_slps; j++, flp_ptr++) {
+			slp = (u8 *)(*flp_ptr);
+
+			if (is_last_flp && j == (no_of_slps - 1))
+				no_of_chunks = map->no_of_chunk_in_last_slp;
+			else
+				no_of_chunks = NO_OF_CHUNKS_PER_PAGE;
+
+			for (k = 0; k < no_of_chunks; k++, slp++) {
+				if (rmr_chunk_md_check_dirty(slp))
+					return false;
+			}
+		}
+	}
+
+	return true;
+}
+
+inline void rmr_map_bitwise_or_buf(void *dst_buf, void *src_buf, u32 buf_size)
+{
+	u8 *src_byte, *dst_byte;
+
+	src_byte = src_buf;
+	dst_byte = dst_buf;
+
+	while (buf_size--)
+		*(dst_byte + buf_size) |= *(src_byte + buf_size);
+}
+
+inline int rmr_map_create_entries(struct rmr_dirty_id_map *map)
+{
+	struct rmr_map_entry *entry;
+	rmr_id_t id;
+	int err;
+	u64 i;
+
+	id.a = 1;
+	for (i = 0; i < map->no_of_chunks; i++) {
+		id.b = i;
+
+		if (!rmr_map_check_dirty(map, id))
+			continue;
+
+		if (xa_load(&map->rmr_id_map, rmr_id_to_key(id)))
+			continue;
+
+		entry = kmem_cache_zalloc(rmr_map_entry_cachep, GFP_KERNEL);
+		if (!entry) {
+			pr_err("%s: Cannot allocate entry for member_id %d, chunk %llu\n",
+			       __func__, map->member_id, i);
+			return -ENOMEM;
+		}
+
+		atomic_set(&entry->sync_cnt, -1);
+		init_llist_head(&entry->wait_list);
+
+		pr_debug("%s: Adding entry %p for chunk %llu\n",
+			 __func__, entry, i);
+
+		err = xa_insert(&map->rmr_id_map, rmr_id_to_key(id), entry, GFP_KERNEL);
+		if (err) {
+			pr_err("%s: Cannot insert entry for member_id %d, chunk %llu\n",
+			       __func__, map->member_id, i);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * rmr_map_slps_to_buf - Copy SLPs to given buf
+ *
+ * @map:	Map to work on
+ * @slp_idx:	SLP number to start copying from
+ * @no_of_slp:	Number of SLPs to copy
+ * @buf:	Buffer to copy SLPs to
+ *
+ * Context:
+ *     srcu pool->map_srcu should be held while calling this function.
+ */
+void rmr_map_slps_to_buf(struct rmr_dirty_id_map *map, u64 slp_idx, u64 no_of_slp, u8 *buf)
+{
+	el_flp *flp_ptr;
+	u64 slp_no, flp_no, i = 0;
+	void *slp;
+
+	flp_no = slp_idx >> NO_OF_SLP_PER_FLP_LOG2;
+	slp_no = slp_idx & (NO_OF_SLP_PER_FLP - 1);
+
+	flp_ptr = (el_flp *)map->dirty_bitmap[flp_no];
+	while (i < no_of_slp) {
+		slp = (void *)(*(flp_ptr + slp_no));
+
+		memcpy(buf, slp, PAGE_SIZE);
+		buf += PAGE_SIZE;
+
+		slp_no++;
+		if (slp_no >= NO_OF_SLP_PER_FLP) {
+			flp_no += 1;
+			slp_no = 0;
+
+			flp_ptr = (el_flp *)map->dirty_bitmap[flp_no];
+		}
+
+		i++;
+	}
+
+	return;
+}
+
+/**
+ * rmr_map_buf_to_slps - Copy data from buf to SLPs
+ *
+ * @map:	Map to work on
+ * @buf:	Buffer from which to copy data
+ * @buf_size:	Buffer size
+ * @slp_idx:	SLP number to start copying to
+ * @test:	Whether to compare data or copy
+ *
+ * Return:
+ *	Number of SLPs to which data was copied.
+ *	0 in case of failure.
+ *
+ * Context:
+ *     srcu pool->map_srcu should be held while calling this function.
+ */
+u64 rmr_map_buf_to_slps(struct rmr_dirty_id_map *map, u8 *buf, u32 buf_size, u64 slp_idx,
+			bool test)
+{
+	el_flp *flp_ptr;
+	u64 slp_no, flp_no, i = 0;
+	u64 no_of_slp;
+	void *slp;
+
+	/*
+	 * The buf_size should be a factor of PAGE_SIZE
+	 */
+	if (buf_size % PAGE_SIZE) {
+		pr_info("%s: Failed %u\n", __func__, buf_size);
+		return 0;
+	}
+
+	no_of_slp = buf_size >> PAGE_SHIFT;
+
+	flp_no = slp_idx >> NO_OF_SLP_PER_FLP_LOG2;
+	slp_no = slp_idx & (NO_OF_SLP_PER_FLP - 1);
+
+	pr_info("%s: no_of_slp=%llu, flp_no=%llu, slp_no=%llu, slp_idx=%llu\n",
+		__func__, no_of_slp, flp_no, slp_no, slp_idx);
+	flp_ptr = (el_flp *)map->dirty_bitmap[flp_no];
+	while (i < no_of_slp) {
+		slp = (void *)(*(flp_ptr + slp_no));
+
+		if (test && memcmp(slp, buf, PAGE_SIZE)) {
+			pr_info("%s: Compare failed\n", __func__);
+			return 0;
+		} else if (!test) {
+			memcpy(slp, buf, PAGE_SIZE);
+		}
+		buf += PAGE_SIZE;
+
+		slp_no++;
+		if (slp_no >= NO_OF_SLP_PER_FLP) {
+			flp_no += 1;
+			slp_no = 0;
+
+			flp_ptr = (el_flp *)map->dirty_bitmap[flp_no];
+		}
+
+		i++;
+	}
+
+	return no_of_slp;
+}
+
+void rmr_map_hexdump_bitmap_buf(u8 member_id, void *buf, u32 buf_size)
+{
+	u8 *buf_byte;
+	u32 size = 0;
+
+	buf_byte = buf;
+
+	pr_info("%s: Starting bitmap dump for member %u in hex, size %u\n",
+		__func__, member_id, buf_size);
+	pr_info("---------------------------------------------------------\n");
+	while (size < buf_size) {
+		pr_cont("%02X", *(buf_byte + size));
+		size++;
+	}
+
+	pr_info("\n");
+}
+
+void rmr_map_dump_bitmap(struct rmr_dirty_id_map *map)
+{
+	el_flp *flp_ptr;
+	u64 no_of_slps, no_of_chunks;
+	bool is_last_flp;
+	u8 *slp;
+	int i, j;
+
+	for (i = 0; i < map->no_of_flp; i++) {
+		flp_ptr = (el_flp *)map->dirty_bitmap[i];
+		is_last_flp = (i == (map->no_of_flp - 1));
+
+		if (is_last_flp)
+			no_of_slps = map->no_of_slp_in_last_flp;
+		else
+			no_of_slps = NO_OF_SLP_PER_FLP;
+
+		for (j = 0; j < no_of_slps; j++, flp_ptr++) {
+			slp = (u8 *)(*flp_ptr);
+
+			if (is_last_flp && j == (no_of_slps - 1))
+				no_of_chunks = map->no_of_chunk_in_last_slp;
+			else
+				no_of_chunks = NO_OF_CHUNKS_PER_PAGE;
+
+			/* Each chunk is represented by a byte */
+			rmr_map_hexdump_bitmap_buf(map->member_id, slp, no_of_chunks);
+		}
+	}
+}
+
+/**
+ * rmr_map_summary_format - Format a per-member dirty-chunk summary into buf
+ *
+ * @pool:	Pool whose maps to summarise
+ * @buf:	Output buffer (must be at least @buf_size bytes)
+ * @buf_size:	Size of @buf in bytes
+ *
+ * Description:
+ *	Output format (one line per member that has a map):
+ *	member <id>: [<idx0> <idx1> ...] <dirty_count>/<total> dirty
+ *	At most 50 dirty chunk indices are listed per member; if there
+ *	are more, a "..." marker appears before the closing bracket.
+ *
+ * Context: caller must hold srcu pool->map_srcu.
+ *
+ * Return: number of bytes written (excluding trailing NUL).
+ */
+int rmr_map_summary_format(struct rmr_pool *pool, char *buf, size_t buf_size)
+{
+	struct rmr_dirty_id_map *map;
+	el_flp *flp_ptr;
+	u64 no_of_slps, no_of_chunks_in_slp;
+	u64 chunk_idx, dirty_count;
+	bool is_last_flp;
+	u8 *slp;
+	int printed_ids;
+	int pos = 0;
+	int i, fi, si;
+
+	for (i = 0; i < RMR_POOL_MAX_SESS; i++) {
+		map = rcu_dereference(pool->maps[i]);
+		if (!map)
+			continue;
+
+		pos += scnprintf(buf + pos, buf_size - pos,
+				 "member %u: [", map->member_id);
+
+		dirty_count = 0;
+		chunk_idx = 0;
+		printed_ids = 0;
+		for (fi = 0; fi < map->no_of_flp; fi++) {
+			flp_ptr = (el_flp *)map->dirty_bitmap[fi];
+			is_last_flp = (fi == (map->no_of_flp - 1));
+			no_of_slps = is_last_flp ?
+				map->no_of_slp_in_last_flp : NO_OF_SLP_PER_FLP;
+
+			for (si = 0; si < no_of_slps; si++, flp_ptr++) {
+				u64 ci;
+
+				slp = (u8 *)(*flp_ptr);
+				no_of_chunks_in_slp =
+					(is_last_flp && si == (no_of_slps - 1)) ?
+					map->no_of_chunk_in_last_slp :
+					NO_OF_CHUNKS_PER_PAGE;
+
+				for (ci = 0; ci < no_of_chunks_in_slp;
+				     ci++, chunk_idx++) {
+					if (!(slp[ci] & (1 << CHUNK_DIRTY_BIT)))
+						continue;
+					dirty_count++;
+					/* Cap listed IDs to fit all members in PAGE_SIZE */
+					if (printed_ids < 50) {
+						pos += scnprintf(buf + pos,
+								 buf_size - pos,
+								 "%llu ", chunk_idx);
+						printed_ids++;
+					}
+				}
+			}
+		}
+
+		/* Overwrite trailing space before ']' */
+		if (pos > 0 && buf[pos - 1] == ' ')
+			pos--;
+		if (printed_ids < dirty_count)
+			pos += scnprintf(buf + pos, buf_size - pos,
+					 "...] %llu/%llu dirty\n",
+					 dirty_count, map->no_of_chunks);
+		else
+			pos += scnprintf(buf + pos, buf_size - pos,
+					 "] %llu/%llu dirty\n",
+					 dirty_count, map->no_of_chunks);
+	}
+
+	return pos;
+}
+
+void rmr_map_bidump_bitmap_buf(void *buf, u8 member_id, u32 buf_long)
+{
+	char box[65];
+	u64 *buf_byte;
+	u64 the_byte;
+	int i, j;
+	u32 count = 0;
+
+	buf_byte = buf;
+
+	pr_info("%s: bitmap for member %d dump in binary, the size in longs %u\n",
+		__func__, member_id, buf_long);
+	while (count < buf_long) {
+		the_byte = *(buf_byte + count);
+		for (i = 63, j = 0; i >= 0; i--, j++)
+			box[j] = (the_byte & (1ULL << i)) ? '1' : '0';
+		box[j] = '\0';
+		pr_cont("[%s]", box);
+		count++;
+	}
+
+	pr_info("\n");
+	pr_info("---------------------------------------------------------\n");
+}
diff --git a/drivers/infiniband/ulp/rmr/rmr-pool.c b/drivers/infiniband/ulp/rmr/rmr-pool.c
new file mode 100644
index 000000000000..5e5632d9d701
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-pool.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#include <linux/wait.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include "rmr-pool.h"
+
+LIST_HEAD(pool_list);
+DEFINE_MUTEX(pool_mutex);	/* mutex to protect pool_list */
+struct kmem_cache *rmr_map_entry_cachep;
+
+const char *rmr_get_cmd_name(enum rmr_msg_cmd_type cmd)
+{
+	switch (cmd) {
+	case RMR_CMD_MAP_READY: return "RMR_CMD_MAP_READY";
+	case RMR_CMD_MAP_SEND: return "RMR_CMD_MAP_SEND";
+	case RMR_CMD_SEND_MAP_BUF: return "RMR_CMD_SEND_MAP_BUF";
+	case RMR_CMD_MAP_BUF_DONE: return "RMR_CMD_MAP_BUF_DONE";
+	case RMR_CMD_MAP_DONE: return "RMR_CMD_MAP_DONE";
+	case RMR_CMD_MAP_DISABLE: return "RMR_CMD_MAP_DISABLE";
+	case RMR_CMD_READ_MAP_BUF: return "RMR_CMD_READ_MAP_BUF";
+	case RMR_CMD_MAP_CHECK: return "RMR_CMD_MAP_CHECK";
+	case RMR_CMD_LAST_IO_TO_MAP: return "RMR_CMD_LAST_IO_TO_MAP";
+	case RMR_CMD_STORE_CHECK: return "RMR_CMD_STORE_CHECK";
+	case RMR_CMD_MAP_TEST: return "RMR_CMD_MAP_TEST";
+	case RMR_CMD_SEND_MD_BUF: return "RMR_CMD_SEND_MD_BUF";
+	case RMR_CMD_MD_SEND: return "RMR_CMD_MD_SEND";
+
+	case RMR_CMD_MAP_GET_VER: return "RMR_CMD_MAP_GET_VER";
+	case RMR_CMD_MAP_SET_VER: return "RMR_CMD_MAP_SET_VER";
+	case RMR_CMD_DISCARD_CLEAR_FLAG: return "RMR_CMD_DISCARD_CLEAR_FLAG";
+	case RMR_CMD_SEND_DISCARD: return "RMR_CMD_SEND_DISCARD";
+
+	case RMR_MAP_CMD_MAX: return "RMR_MAP_CMD_MAX";
+
+	case RMR_CMD_POOL_INFO: return "RMR_CMD_POOL_INFO";
+	case RMR_CMD_JOIN_POOL: return "RMR_CMD_JOIN_POOL";
+
+	case RMR_CMD_REJOIN_POOL: return "RMR_CMD_REJOIN_POOL";
+
+	case RMR_CMD_LEAVE_POOL: return "RMR_CMD_LEAVE_POOL";
+	case RMR_CMD_ENABLE_POOL: return "RMR_CMD_ENABLE_POOL";
+
+	case RMR_CMD_USER: return "RMR_CMD_USER";
+
+	case RMR_POOL_CMD_MAX: return "RMR_POOL_CMD_MAX";
+
+	default: return "Unknown command";
+	}
+}
+
+void free_pool(struct rmr_pool *pool)
+{
+	WARN_ON(!list_empty(&pool->sess_list));
+
+	cleanup_srcu_struct(&pool->sess_list_srcu);
+	cleanup_srcu_struct(&pool->map_srcu);
+
+	if (!list_empty(&pool->entry)) {
+		mutex_lock(&pool_mutex);
+		list_del(&pool->entry);
+		mutex_unlock(&pool_mutex);
+	}
+
+	percpu_ref_exit(&pool->ids_inflight_ref);
+	kfree(pool);
+}
+
+/**
+ * rmr_find_pool_by_group_id - Find a pool with group_id in global pool list
+ *
+ * @group_id: Group_id of the pool being searched
+ *
+ * Locks:
+ *    Caller should hold global pool_mutex
+ */
+struct rmr_pool *rmr_find_pool_by_group_id(u32 group_id)
+{
+	struct rmr_pool *pool;
+
+	list_for_each_entry(pool, &pool_list, entry)
+		if (pool->group_id == group_id)
+			return pool;
+
+	return NULL;
+}
+
+/**
+ * rmr_find_pool - Find a pool named poolname in the global pool list
+ *
+ * @poolname: Name of the pool to be searched
+ *
+ * Locks:
+ *    Caller must hold global pool_mutex
+ */
+struct rmr_pool *rmr_find_pool(const char *poolname)
+{
+	struct rmr_pool *pool;
+
+	lockdep_assert_held(&pool_mutex);
+
+	list_for_each_entry(pool, &pool_list, entry) {
+		if (!strcmp(poolname, pool->poolname))
+			return pool;
+	}
+
+	return NULL;
+}
+
+static void rmr_pool_inflight_ref_release(struct percpu_ref *ref)
+{
+	struct rmr_pool *pool = container_of(ref, struct rmr_pool, ids_inflight_ref);
+
+	complete_all(&pool->complete_done);
+}
+
+void rmr_pool_confirm_inflight_ref(struct percpu_ref *ref)
+{
+	struct rmr_pool *pool = container_of(ref, struct rmr_pool, ids_inflight_ref);
+
+	complete_all(&pool->confirm_done);
+}
+
+static struct rmr_pool *alloc_pool(const char *poolname, u32 group_id)
+{
+	struct rmr_pool *pool;
+	int ret;
+
+	pr_debug("%s: allocate pool %s with group_id %u\n",
+		 __func__, poolname, group_id);
+
+	if (strlen(poolname) > NAME_MAX) {
+		pr_err("%s: Failed to create '%s': name too long\n", __func__, poolname);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pool = kzalloc(sizeof(struct rmr_pool), GFP_KERNEL);
+	if (unlikely(!pool))
+		return ERR_PTR(-ENOMEM);
+
+	ret = init_srcu_struct(&pool->sess_list_srcu);
+	if (ret) {
+		pr_err("%s: Sess list srcu init failed, err: %d\n", __func__, ret);
+		pool = ERR_PTR(ret);
+		goto free_pool;
+	}
+
+	ret = init_srcu_struct(&pool->map_srcu);
+	if (ret) {
+		pr_err("%s: Map srcu init failed, err: %d\n", __func__, ret);
+		pool = ERR_PTR(ret);
+		goto cleanup_sess_srcu;
+	}
+
+	ret = percpu_ref_init(&pool->ids_inflight_ref,
+			      rmr_pool_inflight_ref_release,
+			      PERCPU_REF_ALLOW_REINIT, GFP_KERNEL);
+	if (ret) {
+		pr_err("%s: Percpu reference init failed for pool %s\n", __func__, poolname);
+		pool = ERR_PTR(ret);
+		goto cleanup_map_srcu;
+	}
+
+	pool->group_id = group_id;
+	pool->map_ver = 1;
+	pool->mapped_size = 0;
+	xa_init_flags(&pool->stg_members, XA_FLAGS_ALLOC);
+	init_completion(&pool->complete_done);
+	init_completion(&pool->confirm_done);
+	mutex_init(&pool->sess_lock);
+	mutex_init(&pool->maps_lock);
+	INIT_LIST_HEAD(&pool->entry);
+	INIT_LIST_HEAD(&pool->sess_list);
+
+	init_completion(&pool->discard_done);
+	atomic_set(&pool->discard_waiting, 0);
+	atomic_set(&pool->normal_count, 0);
+
+	strscpy(pool->poolname, poolname, sizeof(pool->poolname));
+
+	return pool;
+
+cleanup_map_srcu:
+	cleanup_srcu_struct(&pool->map_srcu);
+cleanup_sess_srcu:
+	cleanup_srcu_struct(&pool->sess_list_srcu);
+free_pool:
+	kfree(pool);
+	return pool;
+}
+
+struct rmr_pool *rmr_create_pool(const char *poolname, void *priv)
+{
+	u32 group_id;
+	struct rmr_pool *pool;
+
+	mutex_lock(&pool_mutex);
+
+	pool = rmr_find_pool(poolname);
+	if (unlikely(pool)) {
+		pr_err("Pool '%s' already exists\n", poolname);
+		pool = ERR_PTR(-EEXIST);
+		goto out;
+	}
+
+	/* Calculate the poolname hash */
+	group_id = rmr_pool_hash(poolname);
+
+	/* Double ensure there is no hash-clash */
+	pool = rmr_find_pool_by_group_id(group_id);
+	if (unlikely(pool)) {
+		pr_err("Pool '%s' already exists\n", poolname);
+		pool = ERR_PTR(-EEXIST);
+		goto out;
+	}
+
+	pool = alloc_pool(poolname, group_id);
+	if (IS_ERR(pool)) {
+		pr_err("Pool allocation failed for pool %s\n", poolname);
+		goto out;
+	}
+
+	list_add(&pool->entry, &pool_list);
+	pool->priv = priv;
+	pool->pool_md.magic = RMR_POOL_MD_MAGIC;
+
+out:
+	mutex_unlock(&pool_mutex);
+	return pool;
+}
+
+/**
+ * rmr_pool_maps_to_buf - Copy dirty_bitmap buffer of pool to buf
+ *
+ * @pool:	The pool whose map is to be copied
+ * @map_idx:	The map index in the pool's map array
+ * @offset:	The offset to read from in the maps dirty_bitmap buffer
+ * @buf:	Pointer to buf where to copy the dirty_bitmap buffer
+ * @buflen:	Length of the buf available to copy to
+ * @filter:	TODO
+ *
+ * Description:
+ *	This function is one half of the (map <-> buf) pair. It is used to save map into a buf.
+ *	The other half is rmr_pool_save_map, which is used to save a buf into the map.
+ *	This function is used while both sending a map and reading a map.
+ *	The process for both of them is largely same.
+ *
+ *	The relevant params like member_id, offset for the dirty_bitmap buffer
+ *	are stored in the rmr_map_buf_hdr, which is kept at the starting of buf.
+ *
+ *	The caller has to take care of sending the correct map index and offset to copy from.
+ *	For this, the function provides some help in the form of updating the map_idx and
+ *	offset values (for map send), and storing it those in map_buf_hdr (for map read).
+ *
+ * Return value:
+ *	0 If there is no more data to send
+ *	Total size copied to buf
+ */
+int rmr_pool_maps_to_buf(struct rmr_pool *pool, u8 *map_idx, u64 *slp_idx,
+			 void *buf, size_t buflen, rmr_map_filter filter)
+{
+	struct rmr_map_buf_hdr *map_buf_hdr = (struct rmr_map_buf_hdr *)buf;
+	struct rmr_dirty_id_map *map = NULL;
+	int lock_idx;
+	u64 no_of_slp;
+
+	/* Adjust buf and buflen */
+	buf += sizeof(struct rmr_map_buf_hdr);
+	buflen -= sizeof(struct rmr_map_buf_hdr);
+
+	lock_idx = srcu_read_lock(&pool->map_srcu);
+	for ( ; ; *map_idx += 1) {
+
+		if (*map_idx >= pool->maps_cnt) {
+			srcu_read_unlock(&pool->map_srcu, lock_idx);
+			return 0;
+		}
+
+		map = rcu_dereference(pool->maps[*map_idx]);
+		if (map)
+			break;
+	}
+
+	map_buf_hdr->version = RMR_MAP_FORMAT_VER;
+
+	/* This is for the destination, to inform where to store */
+	map_buf_hdr->member_id = map->member_id;
+	map_buf_hdr->dst_slp_idx = (*slp_idx);
+
+	/*
+	 * SLPs are pages. Duh!
+	 */
+	no_of_slp = buflen >> PAGE_SHIFT;
+	no_of_slp = min(no_of_slp, (map->total_slp - *slp_idx));
+	rmr_map_slps_to_buf(map, *slp_idx, no_of_slp, buf);
+	map_buf_hdr->buf_size = no_of_slp * PAGE_SIZE;
+
+	if ((*slp_idx + no_of_slp) >= map->total_slp) {
+		/*
+		 * All done for this map.
+		 * Now move on to the next one, and reset the index.
+		 */
+		*map_idx += 1;
+		*slp_idx = 0;
+	} else {
+		/*
+		 * Copy the number of SLPs we can, and increment the index.
+		 */
+		*slp_idx += no_of_slp;
+	}
+
+	pr_info("%s: buf_size %u, buflen w/o hdr %lu\n",
+		__func__, map_buf_hdr->buf_size, buflen);
+
+	/* This is for MAP_READ, to inform where to ask from next */
+	map_buf_hdr->map_idx = *map_idx;
+	map_buf_hdr->slp_idx = *slp_idx;
+
+	srcu_read_unlock(&pool->map_srcu, lock_idx);
+
+	return (map_buf_hdr->buf_size + sizeof(struct rmr_map_buf_hdr));
+}
+
+/**
+ * rmr_pool_save_map - Copy given buf to dirty_bitmap buffer of pool
+ *
+ * @pool:	The pool whose map is the dest for the copy
+ * @buf:	Pointer to buf from where to copy
+ * @buflen:	Length of the buf available to copy
+ * @test_only:	Only test if the buf given matches with dirty_bitmap buf of pool
+ * @map_clean:	TODO
+ *
+ * Description:
+ *	This function is the other half of the (map <-> buf) pair.
+ *	It saves buf into the map of pool. The relevant params are read from the
+ *	rmr_map_buf_hdr which lies in the start of the given buf.
+ *
+ * Return value:
+ *	0 on success
+ *	-errno on error
+ */
+int rmr_pool_save_map(struct rmr_pool *pool, void *buf, size_t buflen,
+		      bool test_only)
+{
+	struct rmr_map_buf_hdr *map_buf_hdr = (struct rmr_map_buf_hdr *)buf;
+	struct rmr_dirty_id_map *map = NULL;
+	int err = 0, lock_idx;
+	u32 buf_size;
+	u64 slp_idx;
+
+	if (map_buf_hdr->version != RMR_MAP_FORMAT_VER) {
+		pr_err("Wrong map format. Expected %d but received %llu\n",
+		       RMR_MAP_FORMAT_VER, map_buf_hdr->version);
+		return -EINVAL;
+	}
+
+	/* Adjust buf and buflen */
+	buf += sizeof(struct rmr_map_buf_hdr);
+	buflen -= sizeof(struct rmr_map_buf_hdr);
+
+	lock_idx = srcu_read_lock(&pool->map_srcu);
+	map = rmr_pool_find_map(pool, map_buf_hdr->member_id);
+	if (!map) {
+		pr_err("%s: No map found for member_id %llu\n",
+		       __func__, map_buf_hdr->member_id);
+		err = -ENOENT;
+		goto out;
+	}
+
+	slp_idx = map_buf_hdr->dst_slp_idx;
+	buf_size = map_buf_hdr->buf_size;
+
+	pr_info("%s: For pool %s, received map for %llu, slp_idx %llu, buf_size %u, buflen %lu\n",
+		__func__, pool->poolname, map_buf_hdr->member_id, slp_idx, buf_size, buflen);
+
+	/* Sanity */
+	WARN_ON(buf_size > buflen);
+	WARN_ON(buf_size % PAGE_SIZE);
+
+	pr_info("%s: buf_size %u, buflen w/o hdr %lu\n", __func__, map_buf_hdr->buf_size, buflen);
+
+	/*
+	 * The buf_size would be a factor of PAGE_SIZE,
+	 * and thats how we know no_of_slp(s) to save.
+	 */
+	if (!rmr_map_buf_to_slps(map, buf, buf_size, slp_idx, test_only)) {
+		pr_err("%s: rmr_map_buf_to_slps failed\n", __func__);
+		goto out;
+	}
+
+out:
+	srcu_read_unlock(&pool->map_srcu, lock_idx);
+
+	return err;
+}
diff --git a/drivers/infiniband/ulp/rmr/rmr-req.c b/drivers/infiniband/ulp/rmr/rmr-req.c
new file mode 100644
index 000000000000..d748579c489c
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-req.c
@@ -0,0 +1,796 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#include <linux/slab.h>
+
+#include "rmr-req.h"
+#include "rmr-srv.h"
+#include "rmr-clt.h"
+
+extern struct kmem_cache *rmr_req_cachep;
+extern struct kmem_cache *rmr_map_entry_cachep;
+extern struct rmr_store_ops *pstore_ops;
+
+static void rmr_req_complete(struct rmr_srv_req *req);
+static void rmr_req_store_done(struct rmr_srv_req *req);
+static void rmr_req_sync_failed(struct rmr_srv_req *req);
+static void rmr_req_send_map_clear(struct rmr_srv_req *req);
+static void rmr_req_sync_complete(struct rmr_srv_req *req);
+static void rmr_req_store(struct rmr_srv_req *req);
+
+/**
+ * rmr_srv_req_resp - Response from the lower level module
+ *
+ * @req:	Request to be processed
+ * @err:	Error value
+ *
+ * Description:
+ *	This function is the return point from the below module
+ *	where IO is submitted.
+ *
+ * Context:
+ *	In this function the request should always be in state RMR_REQ_STATE_STORE
+ */
+void rmr_srv_req_resp(struct rmr_srv_req *req, int err)
+{
+	/*
+	 * Use the error sent from lower layer
+	 */
+	req->err = err;
+
+	/*
+	 * For Normal (non-sync) requests we handle both non-error and error cases from one
+	 * place. Since its simple.
+	 */
+	if (rmr_op(req->flags) != RMR_OP_SYNCREQ) {
+		rmr_req_complete(req);
+		return;
+	}
+
+	/*
+	 * Sync requests are complicated, since it needs extra post-processing
+	 * once IO is done for us.
+	 *
+	 * 1) In case of no failure, we need to send map clear to other nodes,
+	 *    since they think we are still dirty for this chunk.
+	 *
+	 * 2) We need to check for waiting IO in entry->wait_list, and kick them.
+	 */
+	if (!req->err)
+		rmr_req_store_done(req);
+	else
+		rmr_req_sync_failed(req);
+}
+EXPORT_SYMBOL(rmr_srv_req_resp);
+
+/**
+ * rmr_srv_req_create - Create an rmr server request
+ *
+ * @msg:	IO message containing information
+ * @srv_pool:	Server pool creating this request
+ * @rtrs_op:	rtrs IO context
+ * @data:	pointer to data buf
+ * @datalen:	len of data buf
+ * @endreq:	Function to be called at the end of rmr request processing
+ *
+ * Description:
+ *	RMR server request are base structures which holds the IO while they are being processed.
+ *	They go through a state machine, while a number of checks are done. IOs which are
+ *	destined for a chunk that is dirty, are paused while that chunk is synced.
+ *
+ * Return:
+ *	Pointer to the create rmr server request on success
+ *	Error pointer on failure
+ */
+struct rmr_srv_req *rmr_srv_req_create(const struct rmr_msg_io *msg, struct rmr_srv_pool *srv_pool,
+				       struct rtrs_srv_op *rtrs_op, void *data, u32 datalen,
+				       void (*endreq)(struct rmr_srv_req *, int))
+{
+	struct rmr_srv_req *req;
+	struct rmr_srv_io_store *store = srv_pool->io_store;
+	int i;
+
+	if (!store || !atomic_read(&srv_pool->store_state)) {
+		pr_err("%s: store not set, or srv_pool not in correct state %s\n",
+		       __func__, srv_pool->pool->poolname);
+		return ERR_PTR(-ENODEV);
+	}
+
+	req = kmem_cache_zalloc(rmr_req_cachep, GFP_KERNEL);
+	if (!req) {
+		pr_err("cannot allocate memory for rmr_req.\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	req->id.a = le64_to_cpu(msg->id_a);
+	req->id.b = le64_to_cpu(msg->id_b);
+
+	req->offset = le32_to_cpu(msg->offset);
+	req->length = le32_to_cpu(msg->length);
+	req->flags = le32_to_cpu(msg->flags);
+	req->prio = le16_to_cpu(msg->prio);
+
+	req->mem_id = le32_to_cpu(msg->mem_id);
+	for (i = 0; i < msg->failed_cnt; i++)
+		req->failed_srv_id[i] = msg->failed_id[i];
+
+	req->failed_cnt = msg->failed_cnt;
+	req->map_ver = le64_to_cpu(msg->map_ver);
+	req->sync = msg->sync;
+
+	req->data = data;
+	req->datalen = datalen;
+	req->rtrs_op = rtrs_op;
+	req->srv_pool = srv_pool;
+	req->store = store;
+	req->endreq = endreq;
+
+	pr_debug("req %p, chunk_size %u\n", req, req->srv_pool->pool->chunk_size);
+
+	return req;
+}
+
+struct rmr_srv_req *rmr_srv_md_req_create(struct rmr_srv_pool *srv_pool,
+					  struct rtrs_srv_op *rtrs_op, void *data,
+					  u32 offset, u32 len, unsigned long flags,
+					  void (*endreq)(struct rmr_srv_req *, int))
+{
+	struct rmr_srv_req *req;
+	struct rmr_srv_io_store *store = srv_pool->io_store;
+
+	if (!store) {
+		pr_err("No store_id registered for srv pool %s\n", srv_pool->pool->poolname);
+		return ERR_PTR(-ENODEV);
+	}
+
+	req = kmem_cache_zalloc(rmr_req_cachep, GFP_KERNEL);
+	if (!req) {
+		pr_err("cannot allocate memory for rmr_req.\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	req->offset = offset;
+	req->length = len;
+	req->flags = flags;
+	req->sync = false; /* A md req is always non-sync */
+
+	req->data = data;
+	req->rtrs_op = rtrs_op;
+	req->srv_pool = srv_pool;
+	req->store = store;
+	req->endreq = endreq;
+
+	pr_debug("md req %p, len %u\n", req, len);
+
+	return req;
+}
+
+void rmr_req_submit(struct rmr_srv_req *req);
+static void rmr_req_sched(struct work_struct *work)
+{
+	struct rmr_srv_req *req = container_of(work, struct rmr_srv_req, work);
+
+	pr_debug("scheduled work process for req %p\n", req);
+	if (req->err)
+		rmr_req_complete(req);
+	else
+		rmr_req_submit(req);
+}
+
+void rmr_process_wait_list(struct rmr_map_entry *entry, int err)
+{
+	struct llist_node *first, *next;
+	struct rmr_srv_req *req;
+
+	pr_debug("processing wait list for entry %p, sync_cnt=%d\n",
+		 entry, atomic_read(&entry->sync_cnt));
+
+	WARN_ON(atomic_read(&entry->sync_cnt) > 0);
+
+	while (!llist_empty(&entry->wait_list)) {
+		first = llist_del_all(&entry->wait_list);
+		while (first) {
+			next = first->next;
+			req = llist_entry(first, struct rmr_srv_req, node);
+
+			pr_debug("process waiting req %p id (%llu, %llu) flags %u\n",
+				 req, req->id.a, req->id.b, req->flags);
+			if (err) {
+				pr_err("fail waiting req %p id (%llu, %llu) flags %u err %d\n",
+				       req, req->id.a, req->id.b, req->flags, err);
+				req->err = -EIO;
+			}
+
+			pr_debug("schedule processing req %p with err %d\n", req, req->err);
+			INIT_WORK(&req->work, rmr_req_sched);
+			schedule_work(&req->work);
+
+			first = next;
+		}
+	}
+}
+
+void rmr_req_submit(struct rmr_srv_req *req)
+{
+	struct rmr_srv_pool *srv_pool = req->srv_pool;
+	struct rmr_map_entry *entry;
+	struct rmr_dirty_id_map *map;
+
+	if (rmr_op(req->flags) == RMR_OP_FLUSH && !req->length) {
+		rmr_req_store(req);
+		return;
+	}
+
+	pr_debug("check map for req %p flag %u request id [%llu, %llu] offset %u length %u\n",
+		 req, req->flags,
+		 req->id.a, req->id.b, req->offset, req->length);
+
+	map = rmr_pool_find_map(srv_pool->pool, srv_pool->member_id);
+	if (!map) {
+		pr_err("no map found for pool_id %u\n", srv_pool->member_id);
+		req->err = -EINVAL;
+		goto err;
+	}
+
+	rcu_read_lock();
+	entry = rmr_map_get_dirty_entry(map, req->id);
+	if (!entry) {
+		/*
+		 * The chunk containing data for this req is NOT dirty for us
+		 */
+		pr_debug("check map for req %p flags %u request id [%llu, %llu], no entry in the map\n",
+			 req, req->flags, req->id.a, req->id.b);
+		rcu_read_unlock();
+		rmr_req_store(req);
+		return;
+	} else {
+		/*
+		 * The chunk for this data is dirty for us.
+		 *
+		 * we have 2 cases.
+		 *
+		 * 1) Its coming from a sync rmr-clt (Its an internal read).
+		 * Then, fail the IO, since we do not want to end up in a deadlock,
+		 * or go through multiple hops for a single read. The sender can try some other
+		 * node itself.
+		 */
+		if (req->sync) {
+			WARN_ON(rmr_op(req->flags) != RMR_OP_READ);
+			rcu_read_unlock();
+			req->err = -EIO;
+			goto err;
+		}
+
+		/*
+		 * 2) If its coming from a non-sync rmr-clt,
+		 *    simply go ahead with syncing the data first.
+		 */
+		llist_add(&req->node, &entry->wait_list);
+		pr_debug("%s: req %p flags %u id (%llu %llu) added to wait list. sync_cnt %d\n",
+			 __func__, req, req->flags, req->id.a, req->id.b,
+			 atomic_read(&entry->sync_cnt));
+
+		rcu_read_unlock();
+		/*
+		 * If we are the first who grabs the entry then start sync.
+		 *
+		 * Otherwise, the one syncing the data would pick us up from the entry->wait_list
+		 * and kick us. So simply exit for now.
+		 */
+		if (atomic_cmpxchg(&entry->sync_cnt, -1, 0) == -1) {
+			int err;
+
+			req->priv = entry;
+			err = rmr_srv_sync_chunk_id(srv_pool, entry, req->id, false);
+			if (err) {
+				atomic_set(&entry->sync_cnt, -1);
+				rmr_process_wait_list(entry, err);
+			}
+		}
+	}
+
+	return;
+
+err:
+	rmr_req_complete(req);
+}
+
+static void rmr_req_store(struct rmr_srv_req *req)
+{
+	int err;
+
+	pr_debug("submit to store req %p flags %u request id [%llu, %llu] offset %u length %u\n",
+		 req, req->flags,
+		 req->id.a, req->id.b, req->offset, req->length);
+
+	err = req->store->ops->submit_req(req->store->priv, req->data, req->offset,
+					  req->length, req->flags, req->prio, req);
+	if (err) {
+		pr_err("%s: error submitting req %p, err %d\n", __func__, req, err);
+		req->err = err;
+		if (rmr_op(req->flags) == RMR_OP_SYNCREQ)
+			rmr_req_sync_failed(req);
+		else
+			rmr_req_complete(req);
+	}
+}
+
+static void rmr_md_req_store(struct rmr_srv_req *req)
+{
+	int err;
+
+	err = req->store->ops->submit_md_req(req->store->priv, req->data, req->offset, req->length,
+					     req->flags, req);
+	if (err) {
+		req->endreq(req, err);
+		pr_err("release md req %p, flags %u\n", req, req->flags);
+		kmem_cache_free(rmr_req_cachep, req);
+	}
+}
+
+/* md req submission path*/
+void rmr_md_req_submit(struct rmr_srv_req *req)
+{
+	rmr_md_req_store(req);
+}
+
+static void rmr_req_sched_store(struct work_struct *work)
+{
+	struct rmr_srv_req *req = container_of(work, struct rmr_srv_req, work);
+
+	pr_debug("scheduled store for req %p\n", req);
+	rmr_req_store(req);
+}
+
+static void rmr_req_remote_io_done(void *priv, int err)
+{
+	struct rmr_srv_req *req = priv;
+
+	pr_debug("called for req %p, err code %d\n", req, err);
+
+	rmr_clt_put_iu(req->srv_pool->clt, req->iu);
+
+	if (err) {
+		req->err = err;
+		rmr_req_sync_failed(req);
+		return;
+	}
+
+	pr_debug("schedule store for req %p with err %d\n", req, req->err);
+	INIT_WORK(&req->work, rmr_req_sched_store);
+	schedule_work(&req->work);
+}
+
+static void rmr_req_remote_read(struct rmr_srv_req *req)
+{
+	struct rmr_srv_pool *srv_pool = req->srv_pool;
+	struct rmr_pool *clt = srv_pool->clt;
+	unsigned long flags;
+	int err;
+
+	pr_debug("redirecting req id (%llu, %llu)\n",
+		 req->id.a, req->id.b);
+	if (!clt) {
+		pr_err("No srv pool assigned for redirect for %s\n", srv_pool->pool->poolname);
+		err = -EINVAL;
+		goto err;
+	}
+
+	if (rmr_op(req->flags) == RMR_OP_SYNCREQ)
+		flags = RMR_OP_READ;
+	else
+		flags = req->flags;
+
+	req->iu = rmr_clt_get_iu(clt, flags, WAIT);
+	if (IS_ERR_OR_NULL(req->iu)) {
+		pr_err("Failed to get rmr_iu for req id (%llu, %llu)\n",
+		       req->id.a, req->id.b);
+		err = -EINVAL;
+		goto err;
+	}
+
+	sg_init_one(&req->sg, req->data, req->datalen);
+
+	pr_debug("After sg_init_one nents=%d\n", sg_nents(&req->sg));
+
+	/* look at the flags here! */
+	err = rmr_clt_request(clt, req->iu, req->offset, req->length, flags,
+			      req->prio, req, rmr_req_remote_io_done,
+			      &req->sg, sg_nents(&req->sg));
+	if (err) {
+		pr_err("rmr_clt_request error %d\n", err);
+		rmr_clt_put_iu(clt, req->iu);
+		err = -EREMOTEIO;
+		goto err;
+	}
+
+	pr_debug("remote read submitted\n");
+	return;
+
+err:
+	req->err = err;
+	rmr_req_sync_failed(req);
+}
+
+static void rmr_sync_req_sched(struct work_struct *work)
+{
+	struct rmr_srv_req *req = container_of(work, struct rmr_srv_req, work);
+
+	pr_debug("scheduled work process for req %p\n", req);
+	if (req->err)
+		rmr_req_sync_complete(req);
+	else
+		rmr_req_send_map_clear(req);
+}
+
+static void rmr_req_complete(struct rmr_srv_req *req)
+{
+	pr_debug("send completeion for req %p flags %u request id (%llu, %llu) offset %u length %u err %d\n",
+		 req, req->flags,
+		 req->id.a, req->id.b, req->offset, req->length, req->err);
+
+	/* endreq() records the Last IO buffer accordingly. */
+	req->endreq(req, req->err);
+
+	pr_debug("release req %p, flags %u\n", req, req->flags);
+
+	kmem_cache_free(rmr_req_cachep, req);
+}
+
+static struct rmr_srv_req *rmr_req_create_sync_req(struct rmr_srv_pool *srv_pool, rmr_id_t id,
+						   u32 offset, u32 len, bool from_sync,
+						   struct rmr_srv_req *parent)
+{
+	struct rmr_srv_req *req;
+	struct rmr_srv_io_store *store = srv_pool->io_store;
+
+	if (!store) {
+		pr_err("No store_id registered for srv pool %s\n", srv_pool->pool->poolname);
+		return ERR_PTR(-ENODEV);
+	}
+
+	req = kmem_cache_zalloc(rmr_req_cachep, GFP_KERNEL);
+	if (!req) {
+		pr_err("cannot allocate memory for rmr_req.\n");
+		return ERR_PTR(-ENOMEM);
+	}
+	req->id.a = id.a;
+	req->id.b = id.b;
+	req->flags = RMR_OP_SYNCREQ;
+	req->length = len;
+	req->offset = offset;
+	req->srv_pool = srv_pool;
+	req->store = store;
+	req->from_sync = from_sync;
+
+	if (parent) {
+		req->data = parent->data + offset;
+	} else {
+		req->data = kmalloc(req->length, GFP_KERNEL);
+		if (!req->data) {
+			pr_err("cannot allocate memory for sync req id [%llu, %llu]\n",
+			       req->id.a, req->id.b);
+			kmem_cache_free(rmr_req_cachep, req);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+	req->datalen = len;
+	req->parent = parent;
+
+	pr_debug("sync req %p created, flags %u request id (%llu, %llu) offset %u length %u parent %p\n",
+		 req, req->flags, req->id.a, req->id.b, req->offset, req->length, parent);
+
+	return req;
+}
+
+//should be called only if corresponding map entry has 0 sync cnt
+int rmr_srv_sync_chunk_id(struct rmr_srv_pool *srv_pool, struct rmr_map_entry *entry,
+			  rmr_id_t id, bool from_sync)
+{
+	struct rmr_pool *pool = srv_pool->pool;
+	struct rmr_dirty_id_map *map;
+	struct rmr_srv_req *parent_req;
+	u32 max_io_size, total_len, offset;
+
+	if (!srv_pool->clt) {
+		pr_err("For pool %s no sync pool assigned.\n", pool->poolname);
+		return -EINVAL;
+	}
+	max_io_size = srv_pool->max_sync_io_size;
+
+	map = rmr_pool_find_map(pool, srv_pool->member_id);
+	if (!map) {
+		pr_err("no map found for pool_id %u\n", srv_pool->member_id);
+		//TODO: handle this , probably initialize map, or just throw err?
+		return -EINVAL;
+	}
+
+	offset = CHUNK_TO_OFFSET(id.b, pool->chunk_size_shift);
+	total_len = pool->chunk_size;
+
+	pr_debug("pool %s sync id (%llu, %llu), total_len %u, max_io_size %u\n",
+		 pool->poolname, id.a, id.b, total_len, max_io_size);
+
+	/*
+	 * The parent_req starts with total_len, then get decremented in loop below.
+	 * The child reqs are filled one by one from end to second.
+	 *
+	 * Maybe refactor this to a simple loop?
+	 */
+	parent_req = rmr_req_create_sync_req(srv_pool, id, offset, total_len, from_sync, NULL);
+	if (IS_ERR_OR_NULL(parent_req)) {
+		pr_err("pool %s failed to create main sync req to sync id (%llu, %llu)\n",
+		       pool->poolname, id.a, id.b);
+		return -ENOMEM;
+	}
+	parent_req->priv = entry;
+
+	if (from_sync) {
+		if (rmr_srv_get_sync_permit(srv_pool)) {
+			pr_err("rmr_srv_sync_chunk_id failed to acquire permit for parent\n");
+			kfree(parent_req->data);
+			kmem_cache_free(rmr_req_cachep, parent_req);
+
+			return -EINVAL;
+		}
+	}
+
+	// inc ref cnt for parent_req
+	map_entry_get_sync(entry);
+	while (parent_req->length > max_io_size) {
+		struct rmr_srv_req *req;
+		u32 child_offset = offset + (parent_req->length - max_io_size);
+
+		// submit req
+		req = rmr_req_create_sync_req(srv_pool, id, (parent_req->length - max_io_size),
+					      max_io_size, from_sync, parent_req);
+		if (IS_ERR_OR_NULL(req)) {
+			pr_err("%s: Pool %s, id (%llu, %llu), offset %u, len %u, err %ld\n",
+			       __func__, pool->poolname, id.a, id.b,
+			       (parent_req->length - max_io_size), max_io_size, PTR_ERR(req));
+			parent_req->err = PTR_ERR(req);
+
+			rmr_req_sync_failed(parent_req);
+			return -EINVAL;
+		}
+
+		/*
+		 * The offset sent to rmr_req_create_sync_req for this req is in context of the
+		 * chunk. But the real offset for this req in the disk is this.
+		 */
+		req->offset = child_offset;
+
+		if (from_sync) {
+			if (rmr_srv_get_sync_permit(srv_pool)) {
+				pr_err("rmr_srv_sync_chunk_id failed to acquire permit for child\n");
+				kmem_cache_free(rmr_req_cachep, req);
+
+				parent_req->err = -EBUSY;
+				rmr_req_sync_failed(parent_req);
+				return -EINVAL;
+			}
+		}
+
+		// inc ref cnt for the child req just created
+		map_entry_get_sync(entry);
+		req->priv = entry;
+		rmr_req_remote_read(req);
+
+		parent_req->length -= max_io_size;
+		parent_req->datalen -= max_io_size;
+	}
+
+	//submit parent req
+	rmr_req_remote_read(parent_req);
+
+	return 0;
+}
+
+static void __release_parent_req(struct rcu_head *head)
+{
+	struct rmr_srv_req *req = container_of(head, struct rmr_srv_req, rcu);
+	struct rmr_map_entry *entry = req->priv;
+
+	pr_debug("is called for req=%p id=(%llu,%llu) err=%d, entry=%p\n",
+		 req, req->id.a, req->id.b, req->err, entry);
+
+	kfree(req->data);
+
+	//may be now we can stop saving entry in req->priv, but always rmr_map_find it
+	if (!req->err) {
+		pr_debug("req %p, completed all sync req, lets clean map\n", req);
+		rmr_process_wait_list(entry, 0);
+	} else {
+		pr_debug("req %p completed with err %d, process wait list\n",
+			 req, req->err);
+
+		/* sync of this entry failed, we reset the sync_cnt so that the other req
+		 * or sync thread could try again in the future. Without resetting, no one
+		 * could get the ref and start sync again.
+		 */
+		atomic_set(&entry->sync_cnt, -1);
+		rmr_process_wait_list(entry, req->err);
+	}
+
+	pr_debug("free entry %p for req %p\n", entry, req);
+	kmem_cache_free(rmr_map_entry_cachep, entry);
+
+	if (req->from_sync)
+		rmr_srv_put_sync_permit(req->srv_pool);
+
+	kmem_cache_free(rmr_req_cachep, req);
+}
+
+static void rmr_req_sync_complete(struct rmr_srv_req *req)
+{
+	struct rmr_srv_pool *srv_pool = req->srv_pool;
+	struct rmr_dirty_id_map *map;
+	int lock_idx;
+
+	pr_debug("sync_req %p completed for id (%llu, %llu), offset %u, len %u, err %d, from sync %d\n",
+		 req, req->id.a, req->id.b, req->offset, req->length,
+		 req->err, req->from_sync);
+
+	if (req->err)
+		rmr_srv_sync_req_failed(req->srv_pool);
+
+	pr_debug("release sync req %p, flags %u\n", req, req->flags);
+
+	/*
+	 * Only parent sync req own the allocated data.
+	 */
+	if (!req->parent) {
+		if (!req->err) {
+			map = rmr_pool_find_map(srv_pool->pool,
+						srv_pool->member_id);
+			if (map) {
+				lock_idx = srcu_read_lock(&srv_pool->pool->map_srcu);
+				rmr_map_unset_dirty(map, req->id,
+						    MAP_NO_FILTER);
+				srcu_read_unlock(&srv_pool->pool->map_srcu, lock_idx);
+			} else {
+				pr_err("no map found for pool_id %u\n", srv_pool->member_id);
+				req->err = -EINVAL;
+			}
+		}
+
+		pr_debug("req %p, completed all sync req, lets clean map\n",
+			 req);
+		call_rcu(&req->rcu, __release_parent_req);
+	} else {
+		/*
+		 * Child req has nothing to do but put permit and free
+		 */
+		if (req->from_sync)
+			rmr_srv_put_sync_permit(req->srv_pool);
+
+		kmem_cache_free(rmr_req_cachep, req);
+	}
+}
+
+static void rmr_req_sync_failed(struct rmr_srv_req *req)
+{
+	rmr_srv_sync_req_failed(req->srv_pool);
+
+	pr_err("pool %s sync req %p failed for id (%llu, %llu), offset %u, len %u, err %d\n",
+	       req->srv_pool->pool->poolname, req, req->id.a, req->id.b,
+	       req->offset, req->length, req->err);
+
+	rmr_req_store_done(req);
+}
+
+// this is actually very like rmr_req_remote_io_done but without rmr_clt_put_iu
+// do we want to have one function for both cases?
+static void rmr_req_map_clear_done(void *priv, int err)
+{
+	struct rmr_srv_req *req = priv;
+
+	rmr_clt_put_iu(req->srv_pool->clt, req->iu);
+
+	pr_debug("called for req %p, err code %d\n", req, err);
+	if (err)
+		pr_err("pool %s, sync req  with id (%llu, %llu) failed to send map clear\n",
+		       req->srv_pool->pool->poolname, req->id.a, req->id.b);
+
+	rmr_req_sync_complete(req);
+}
+
+static void rmr_req_store_done(struct rmr_srv_req *req)
+{
+	struct rmr_map_entry *entry = req->priv;
+	struct rmr_srv_req *parent_req = NULL;
+
+	pr_debug("called for req %p id (%llu, %llu ) offset %u len %u with parent req %p\n",
+		 req, req->id.a, req->id.b, req->offset, req->length, req->parent);
+
+	if (req->parent)
+		parent_req = req->parent;
+	else
+		parent_req = req;
+
+	if (req->err)
+		parent_req->err = req->err;
+
+	if (map_entry_put_sync(entry)) {
+		pr_debug("%s: for entry %p id (%llu, %llu) all sync req done.\n", __func__,
+			 entry, req->id.a, req->id.b);
+
+		/* We have to schedule the work of parent req from here since we are in the
+		 * interrupt context of either parent req or child req
+		 */
+		pr_debug("%s: process parent_req %p\n", __func__, parent_req);
+		INIT_WORK(&parent_req->work, rmr_sync_req_sched);
+		schedule_work(&parent_req->work);
+	}
+
+	if (req != parent_req) {
+		pr_debug("completing req %p with err %d\n", req, req->err);
+		rmr_req_sync_complete(req);
+	}
+}
+
+static void rmr_req_send_map_clear(struct rmr_srv_req *req)
+{
+	struct rmr_srv_pool *srv_pool = req->srv_pool;
+	struct rmr_pool *pool = srv_pool->clt;
+	struct rmr_iu *iu;
+	int err;
+
+	if (!pool) {
+		pr_err("Cannot send map clear. No pool client assigend for srv pool %s\n",
+		       req->srv_pool->pool->poolname);
+		req->err = -EINVAL;
+		goto err;
+	}
+
+	/*
+	 * We try to clear map, but if we fail to, we simply ignore the error.
+	 * Such zombie entries will be clear by rmr_srv_check_map_clear.
+	 */
+	iu = rmr_clt_get_iu(pool, RMR_OP_WRITE, WAIT);
+	if (IS_ERR_OR_NULL(iu)) {
+		pr_err("Failed to get rmr_iu for req id (%llu, %llu)\n",
+		       req->id.a, req->id.b);
+		goto err;
+	}
+
+	pr_debug("send map clear req id (%llu, %llu), member_id %u\n",
+		 req->id.a, req->id.b, srv_pool->member_id);
+
+	/*
+	 * For MAP_CLEAR, we only need rmr_id_t for chunk number,
+	 * and our member_id to say to clear the above chunk number for ths storage node.
+	 *
+	 * We also update the minimum members needed for map update.
+	 */
+	iu->msg.hdr.group_id = cpu_to_le32(pool->group_id);
+	iu->msg.hdr.type = cpu_to_le16(RMR_MSG_MAP_CLEAR);
+	iu->msg.hdr.__padding = 0;
+
+	iu->msg.id_a = cpu_to_le64(req->id.a);
+	iu->msg.id_b = cpu_to_le64(req->id.b);
+	iu->msg.member_id = srv_pool->member_id;
+
+	iu->msg.flags = cpu_to_le32(RMR_OP_WRITE);
+
+	iu->conf = rmr_req_map_clear_done;
+	iu->priv = req;
+
+	req->iu = iu;
+
+	err = rmr_clt_send_map_update(pool, req->iu);
+	if (err) {
+		pr_err("%s error %d\n", __func__, err);
+		rmr_clt_put_iu(pool, req->iu);
+		goto err;
+	}
+
+	pr_debug("send map clear submitted\n");
+	return;
+
+err:
+	rmr_req_sync_complete(req);
+}
-- 
2.43.0


