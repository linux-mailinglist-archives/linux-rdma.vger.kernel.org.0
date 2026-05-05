Return-Path: <linux-rdma+bounces-19996-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG14CD+h+WnR+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19996-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:50:23 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0BB4C83EE
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8B57301E767
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5813EF0C6;
	Tue,  5 May 2026 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="beVmaoqF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0833E5ED2
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967253; cv=none; b=Cd9KlrDQ+p9foFBpJstp+XEs/aXngWdkDuyzvmjjqaS1NT/frQ3CMDWWdfKEIVsFHcx2h/02/mcIDZMwLqbhRsMgq1GA1s4UYOeHgcrSPYlmGPW5f4MYHt4aFEehQcsH8LEQxlpvItou1UWin4wjBTUU2E2rOh0mcmJQ9GPNrsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967253; c=relaxed/simple;
	bh=0yJT8QFEvfCqLmq2f2LuMOvO9+6CZ5GobjBrCm5dhG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vD9l6npeCaB2/+2lLanOh+F4Hzb+4DZRaGQW+TN4MiK8OUXWYKBWDfRD07EOYU/7c2/hI8ebwLQnDVcoqtHQvO/3sl3YoaUCg1RiZtV7YTCYJNufGEX2pUErb7h6Uc3ey9DZ5Fb2MDyQ4u09dzFs0zxXJ1fcs4j9wiRScK3u1C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=beVmaoqF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so32636155e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967242; x=1778572042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp/g/mQJCIE0U+NQtOyu/324OU34Lnzvt4+XyTSQOTw=;
        b=beVmaoqFy9WvL5zBWwm5mz6BIpZINLIjHwlDRUkNoha+sZoZ4CF0JiYLooFSK/+lyY
         n6NYB9ubAa5aRfrCePx5fxwNlTYK5cunaRBk82303P8g3ZqhFZ9Xltn9OZDSRJmjD1Ne
         lciCYo6iWl6VTdUfVZk6TaceppOnDK2TRdnhJiNnMT6uUG4XB5ZLdfFGj50GjbxaBrdR
         mWU4x7+ri4Go5YhOeyNeGUc5WYeJ3w/sO0tAl8567iDnF1tIh4rXGVDy+NUDjO0TopXT
         1ed/eifa9r2YoNTSHLESX+ijv/b2oPFS03gI7dP0priphtlogPu6CiOno4EnsGUI8R+i
         clLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967242; x=1778572042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lp/g/mQJCIE0U+NQtOyu/324OU34Lnzvt4+XyTSQOTw=;
        b=Y6T2iTjFY3TmnCkOXX6kuVxklj9aK7/iSLPO0cRtzp203Kn2H/29ygq+pJJFWgBrsB
         DCcWYeMnz7eVOpaweyhKkpNPAXmDvcKD20PG1Ak5zWZXieChUSpuvooyPJujJjtbh9QZ
         7tADSPGk12fgiHxjtgr7cqPJiCx28O3Le+TsLJ3I54L+s6Ve1F+YyHI0YkCKRbRLZaMw
         Tq57uBG5Ump6mQXoR2ie4iKVvajF1aToiXb2wWitepxtQBTTWh2YVCrncYQLIvC50+O5
         +mLD+cFRDOtt0lrR4ytXwWcJTqq9p8f48ep1Khb1QI6RYI5Upfv7czg9gUt/F0SBMxDP
         NSDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9/8NoLiaxUwDPtddpa1iGXODMIlyk0xKwTLTYYxd8u9VZdWufl/uoTMc/BioZrcWHO30f0I+hDWlu/@vger.kernel.org
X-Gm-Message-State: AOJu0YwrO23nu7O4jt0Jb2t3rSbVlh0ZI/DISSYy5YaoUX0CI+CAuUi2
	sw2/kaBY2LuCQ10ZWWrRrtFsxWMpi9vD38HfyMQ46B09kxlz+X04QqdESI4aIiNB4kE=
X-Gm-Gg: AeBDieusAXbCE/7GO+LJ0752Dgweaekrxb12oukUsDpFSoTFEb8SysR4khs8E2aNGzq
	0y39sBxhZoSGQ1CybeQLEvB9mh384cdtwf69ea2Pm+KQf0xRJu1DlWrVLKmzFtSAufXwB4GQPBx
	fJ2PlE9VcNQ7s54ew8BB+8mMeZQsu/uvDRU3l/ycU4jHaWMYcCV1ClGMOzH91+dA/UHHRka990e
	+qUDK8UyPTx3RPNgTUS/4pd/ill7sdSvp2pW1Bm3UeakH4gxOzZfooza3lGpFB9rTGX5TI7Pohq
	HiYfoIZoiiZhzRJYJSdkHm4uVXm42lmj3y2Qg3JAUriMuw/lEbBobVzdFAJxWB9jlH7kd3HcqSo
	BgMlRSdR0OYSwNRSoKtZ0VWzJABLxYXEUDYpq8YA4oHXlhj5NIlekL1enl/pDc/2WGfnoaOXD4O
	8LolkMhyfClUvyjwv4EAdPDBnLSXUdVoHmPuAGMinQ+I2sF8zR/ebpktbS33N1sSCGOAmlIThiI
	pLXknrf1ddyBgmOtQJpevLOsrgnHBPAMkdY5tDK0kFB2RXW90neNdnC
X-Received: by 2002:a05:600c:8b17:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-48d1426cdecmr38920505e9.14.1777967240579;
        Tue, 05 May 2026 00:47:20 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:20 -0700 (PDT)
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
Subject: [PATCH 05/13] RDMA/rmr: server: main functionality
Date: Tue,  5 May 2026 09:46:17 +0200
Message-ID: <20260505074644.195453-6-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505074644.195453-1-haris.iqbal@ionos.com>
References: <20260505074644.195453-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DC0BB4C83EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19996-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[]

Add the RMR server implementation:

  rmr-srv.c	server core: session handling, pool registration via
		rmr_srv_register(), incoming command and IO message
		processing, sync thread coordination and the
		rmr_srv_query()/rmr_srv_unregister() entry points used
		by upper-layer stores.
  rmr-srv-md.c	server-side metadata persistence: serialising the
		pool metadata (member ID, map version, mapped size,
		store state) and the dirty maps to the underlying
		store, plus the periodic md_sync delayed work.

The server interacts with an upper-layer store via the
struct rmr_srv_store_ops interface defined in rmr-srv.h, allowing
different store implementations (block device, file, ...) to plug
in without modifying RMR itself.

These files are not compiled until the modules are wired into the
build in a later patch in this series.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/infiniband/ulp/rmr/rmr-srv-md.c |  764 ++++++
 drivers/infiniband/ulp/rmr/rmr-srv.c    | 3306 +++++++++++++++++++++++
 2 files changed, 4070 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv-md.c
 create mode 100644 drivers/infiniband/ulp/rmr/rmr-srv.c

diff --git a/drivers/infiniband/ulp/rmr/rmr-srv-md.c b/drivers/infiniband/ulp/rmr/rmr-srv-md.c
new file mode 100644
index 000000000000..9dab71a810b8
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-srv-md.c
@@ -0,0 +1,764 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reliable multicast over RTRS (RMR) — server metadata subsystem
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <linux/module.h>
+#include <linux/blkdev.h>
+
+#include "rmr-srv.h"
+#include "rmr-req.h"
+#include "rmr-clt.h"
+
+/**
+ * process_md_io() - Process medata IO message
+ *
+ * @pool:	the pool where requests go through
+ * @rtrs_op:	rtrs IO context
+ * @offset:	offset in bytes relative to rmr metadata.
+ * @len:	length of the buffer in bytes
+ * @flags:	indicates metadata IO options
+ * @buf:	pointer to metadata buffer
+ *
+ * Return:
+ *	0 on success
+ *
+ * Description:
+ *	All metadata IOs go through this function to submit requests to block device. The offset it
+ *	passes on is relative to bytes shifting on rmr medata which is composed of a header
+ *	structure for pool metadata, bitmap and last_io array.
+ */
+int process_md_io(struct rmr_pool *pool, struct rtrs_srv_op *rtrs_op, u32 offset, u32 len,
+			 unsigned long flags, void *buf)
+{
+	struct rmr_srv_pool *srv_pool;
+	struct rmr_srv_req *req;
+	int err = 0;
+
+	srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+	if (!percpu_ref_tryget_live(&pool->ids_inflight_ref)) {
+		err = -EIO;
+		goto no_put;
+	}
+
+	req = rmr_srv_md_req_create(srv_pool, rtrs_op, buf, offset, len, flags, rmr_srv_endreq);
+	if (IS_ERR(req)) {
+		pr_err("Failed to create rmr_req %pe\n", req);
+		err = PTR_ERR(req);
+		goto put_pool;
+	}
+
+	rmr_md_req_submit(req);
+	return 0;
+
+put_pool:
+	percpu_ref_put(&pool->ids_inflight_ref);
+no_put:
+	return err;
+}
+
+int rmr_srv_read_md(struct rmr_pool *pool, struct rtrs_srv_op *rtrs_op, u32 offset, u32 len,
+		    struct rmr_pool_md *pool_md_page)
+{
+	/* pool_md is pre-allocated */
+	return process_md_io(pool, rtrs_op, offset, len, RMR_OP_MD_READ, pool_md_page);
+}
+
+static int rmr_srv_load_last_io(struct rmr_srv_pool *srv_pool)
+{
+	void *buf;
+	u64 offset, len;
+	struct rmr_pool *pool = srv_pool->pool;
+	struct rmr_pool_md *pool_md = &pool->pool_md;
+	int err = 0;
+
+	if (!pool_md->queue_depth) {
+		pr_err("%s: pool %s has zero queue_depth\n",
+		       __func__, pool->poolname);
+		return -EINVAL;
+	}
+	offset = RMR_LAST_IO_OFFSET;
+	len = rmr_last_io_len(pool_md->queue_depth);
+
+	if (!srv_pool->last_io_idx) {
+		srv_pool->last_io_idx = kcalloc(pool_md->queue_depth,
+						sizeof(*srv_pool->last_io_idx), GFP_KERNEL);
+		if (!srv_pool->last_io_idx)
+			return -ENOMEM;
+	}
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		return err;
+	}
+
+	err = rmr_srv_read_md(pool, NULL, offset, len, buf);
+	if (err) {
+		pr_err("%s: failed to read last_io buffer of len %lld at offset %lld\n",
+		       __func__, len, offset);
+		goto free_buf;
+	}
+	memcpy(srv_pool->last_io_idx, (rmr_id_t *)buf, len);
+
+free_buf:
+	kfree(buf);
+	return err;
+}
+
+/**
+ * rmr_srv_md_maps_sync - Sync dirty maps to persistent storage
+ *
+ * Description:
+ *	Writes maps in two passes to the map-related regions of the on-disk layout:
+ *
+ *	Pass 1 — hdr_region (single PAGE_SIZE write at RMR_MD_SIZE + last_io_len):
+ *	  Fills one rmr_map_cbuf_hdr slot per map_idx in [0:maps_cnt].
+ *	  The buffer is kzalloc'd, so slots beyond maps_cnt are zero.
+ *	  The entire PAGE_SIZE region is issued as a single I/O.
+ *
+ *	Pass 2 — maps_region (slp pages at computed offsets after hdr_region):
+ *	  Each map's data offset = map_region_offset + map_idx * per_map_size.
+ *	  pool->maps[0:maps_cnt] is always dense (no NULL gaps).
+ */
+void rmr_srv_md_maps_sync(struct rmr_pool *pool)
+{
+	struct rmr_map_cbuf_hdr *map_cbuf_hdr;
+	struct rmr_dirty_id_map *map = NULL;
+	u32 hdr_region_offset = rmr_bitmap_offset(pool->pool_md.queue_depth);
+	u32 map_region_offset = hdr_region_offset + RMR_MAP_BUF_HDR_SIZE;
+	u64 per_map_size = 0;
+	int err, lock_idx;
+	void *buf;
+	u8 map_idx;
+
+	buf = kzalloc(RMR_MAP_BUF_HDR_SIZE, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	lock_idx = srcu_read_lock(&pool->map_srcu);
+
+	/* Fill the header region: one slot per active map */
+	for (map_idx = 0; map_idx < pool->maps_cnt; map_idx++) {
+		map = rcu_dereference(pool->maps[map_idx]);
+		if (WARN_ON(!map))
+			goto unlock;
+
+		map_cbuf_hdr = buf + map_idx * sizeof(struct rmr_map_cbuf_hdr);
+		map_cbuf_hdr->version = RMR_MAP_FORMAT_VER;
+		map_cbuf_hdr->member_id = map->member_id;
+		map_cbuf_hdr->no_of_chunks = map->no_of_chunks;
+		map_cbuf_hdr->no_of_flp = map->no_of_flp;
+		map_cbuf_hdr->no_of_slp_in_last_flp = map->no_of_slp_in_last_flp;
+		map_cbuf_hdr->no_of_chunk_in_last_slp = map->no_of_chunk_in_last_slp;
+		map_cbuf_hdr->total_slp = map->total_slp;
+		per_map_size = map->total_slp * PAGE_SIZE;
+	}
+
+	/* Write the entire header region as a single PAGE_SIZE I/O */
+	err = process_md_io(pool, NULL, hdr_region_offset,
+			PAGE_SIZE, RMR_OP_MD_WRITE, buf);
+	if (err) {
+		pr_warn("%s: failed to write header region at 0x%x: %d\n",
+			__func__, hdr_region_offset, err);
+		goto unlock;
+	}
+
+	if (WARN_ON(!per_map_size))
+		goto unlock;
+
+	/* Write each map's slp pages */
+	for (map_idx = 0; map_idx < pool->maps_cnt; map_idx++) {
+		u32 map_data_offset;
+		el_flp *flp_ptr;
+		u64 no_of_slps;
+		void *slp;
+		int i, j;
+
+		map = rcu_dereference(pool->maps[map_idx]);
+		if (WARN_ON(!map))
+			break;
+
+		map_data_offset = map_region_offset + map_idx * per_map_size;
+
+		for (i = 0; i < map->no_of_flp; i++) {
+			flp_ptr = (el_flp *)map->dirty_bitmap[i];
+
+			if (i == (map->no_of_flp - 1))
+				no_of_slps = map->no_of_slp_in_last_flp;
+			else
+				no_of_slps = NO_OF_SLP_PER_FLP;
+
+			for (j = 0; j < no_of_slps; j++, flp_ptr++) {
+				slp = (void *)(*flp_ptr);
+
+				err = process_md_io(pool, NULL, map_data_offset,
+						PAGE_SIZE, RMR_OP_MD_WRITE, slp);
+				if (err)
+					pr_warn("%s: failed to write map slp at 0x%x: %d\n",
+						__func__, map_data_offset, err);
+				map_data_offset += PAGE_SIZE;
+			}
+		}
+	}
+
+unlock:
+	srcu_read_unlock(&pool->map_srcu, lock_idx);
+	kfree(buf);
+}
+
+/**
+ * rmr_srv_refresh_md_maps - Restore maps from map buffers on disk
+ *
+ * Description:
+ *	Reads back the maps written by rmr_srv_md_maps_sync(). Reads the hdr_region
+ *	in a single I/O to obtain the per-map headers, then loads each present
+ *	map's slp pages from maps_region:
+ *	  data offset = map_region_offset + map_idx * per_map_size
+ *	Header slots 0..N-1 are active; remaining are zero (member_id == 0).
+ */
+static int rmr_srv_refresh_md_maps(struct rmr_srv_pool *srv_pool)
+{
+	struct rmr_pool *pool = srv_pool->pool;
+	struct rmr_map_cbuf_hdr *map_cbuf_hdr;
+	struct rmr_dirty_id_map *map = NULL;
+	u32 hdr_region_offset = rmr_bitmap_offset(pool->pool_md.queue_depth);
+	u32 map_region_offset = hdr_region_offset + RMR_MAP_BUF_HDR_SIZE;
+	int err = 0, lock_idx;
+	void *buf;
+	u8 map_idx, valid_nr = 0;
+	bool unpack;
+
+	buf = kzalloc(RMR_MAP_BUF_HDR_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* Read the entire header region in a single PAGE_SIZE I/O */
+	err = rmr_srv_read_md(pool, NULL, hdr_region_offset, RMR_MAP_BUF_HDR_SIZE, buf);
+	if (err) {
+		pr_err("%s: failed to read header region at offset %u\n",
+				__func__, hdr_region_offset);
+		kfree(buf);
+		return err;
+	}
+
+	lock_idx = srcu_read_lock(&pool->map_srcu);
+	for (map_idx = 0; map_idx < RMR_POOL_MAX_SESS; map_idx++) {
+		u64 per_map_size;
+		u32 map_data_offset;
+		el_flp *flp_ptr;
+		u64 no_of_slps;
+		void *slp;
+		int i, j;
+
+		map_cbuf_hdr = buf + map_idx * sizeof(struct rmr_map_cbuf_hdr);
+		pr_debug("%s: %llu %u %llu %llu %llu %llu %llu\n", __func__,
+			map_cbuf_hdr->version,
+			map_cbuf_hdr->member_id,
+			map_cbuf_hdr->no_of_chunks,
+			map_cbuf_hdr->no_of_flp,
+			map_cbuf_hdr->no_of_slp_in_last_flp,
+			map_cbuf_hdr->no_of_chunk_in_last_slp,
+			map_cbuf_hdr->total_slp);
+
+		/* Empty slot: no more active maps beyond this point */
+		if (!map_cbuf_hdr->member_id)
+			break;
+		valid_nr++;
+
+		per_map_size = map_cbuf_hdr->total_slp * PAGE_SIZE;
+		map_data_offset = map_region_offset + map_idx * per_map_size;
+
+		unpack = false;
+		/*
+		 * The dirty map should be updated only when the one on disk is more updated.
+		 * Such cases are as follows.
+		 * 1) The dirty map does not exist in the pool. The map will be simply restored to
+		 * the last version we have.
+		 * 2) The dirty map of the pool is just created. If it has been updated, the one on
+		 * disk is outdated.
+		 */
+		map = rmr_pool_find_map(pool, map_cbuf_hdr->member_id);
+		if (!map) {
+			map = rmr_map_create(pool, map_cbuf_hdr->member_id);
+			if (IS_ERR(map)) {
+				err = PTR_ERR(map);
+				pr_err("%s: pool %s, member_id %d failed to create map\n",
+				       __func__, pool->poolname, map_cbuf_hdr->member_id);
+				goto unlock;
+			}
+			unpack = true;
+		} else if (rmr_map_empty(map)) {
+			unpack = true;
+		}
+
+		if (map->no_of_chunks != map_cbuf_hdr->no_of_chunks ||
+				map->no_of_flp != map_cbuf_hdr->no_of_flp ||
+				map->no_of_slp_in_last_flp != map_cbuf_hdr->no_of_slp_in_last_flp ||
+				map->no_of_chunk_in_last_slp != map_cbuf_hdr->no_of_chunk_in_last_slp ||
+				map->total_slp != map_cbuf_hdr->total_slp) {
+			pr_err("%s: Sanity check failed\n", __func__);
+			goto unlock;
+		}
+
+		xa_store(&pool->stg_members, map_cbuf_hdr->member_id, XA_TRUE, GFP_KERNEL);
+
+		if (!unpack)
+			continue;
+
+		for (i = 0; i < map->no_of_flp; i++) {
+			flp_ptr = (el_flp *)map->dirty_bitmap[i];
+
+			if (i == (map->no_of_flp - 1))
+				no_of_slps = map->no_of_slp_in_last_flp;
+			else
+				no_of_slps = NO_OF_SLP_PER_FLP;
+
+			for (j = 0; j < no_of_slps; j++, flp_ptr++) {
+				slp = (void *)(*flp_ptr);
+
+				err = rmr_srv_read_md(pool, NULL, map_data_offset,
+						PAGE_SIZE, slp);
+				if (err) {
+					pr_err("%s: failed to read bitmap at offset %u\n",
+						__func__, map_data_offset);
+					goto unlock;
+				}
+				map_data_offset += PAGE_SIZE;
+			}
+		}
+	}
+
+unlock:
+	if (!valid_nr)
+		pr_err("%s: no valid map found in metadata\n", __func__);
+
+	/*
+	 * TODO: We need better error handling logic here.
+	 * Lets suppose after successfully reading few pages for a map, we fail to read next page.
+	 * We then error out and fail the register, but leave the partially updated map in the pool.
+	 * Later when another register is called, and we come here to read the maps, we will
+	 * see a non-empty map, and skip reading the map from disk.
+	 */
+	srcu_read_unlock(&pool->map_srcu, lock_idx);
+	kfree(buf);
+	return err;
+}
+
+/**
+ * rmr_srv_md_update() - update the metadata of the server pool
+ *
+ * Description:
+ *	Read current in-memory pool states that changes to the srv_md of this pool.
+ */
+static int rmr_srv_md_update(struct rmr_srv_pool *srv_pool)
+{
+	struct rmr_pool *pool;
+	struct rmr_srv_md *my_srv_md;
+	int md_i;
+
+	pool = srv_pool->pool;
+	md_i = rmr_pool_find_md(&pool->pool_md, srv_pool->member_id, true);
+	if (md_i < 0) {
+		pr_warn("No space for new member %d.\n", srv_pool->member_id);
+		return -EINVAL;
+	}
+	my_srv_md = &pool->pool_md.srv_md[md_i];
+	my_srv_md->member_id = srv_pool->member_id;
+	my_srv_md->store_state = atomic_read(&srv_pool->store_state);
+	my_srv_md->map_ver = srv_pool->pool->map_ver;
+	my_srv_md->srv_pool_state = atomic_read(&srv_pool->state);
+	pr_debug("Set srv_md[%d] it with the member_id %d.\n", md_i, srv_pool->member_id);
+	return 0;
+}
+
+/**
+ * rmr_srv_flush_pool_md() - Write pool_md region to disk immediately
+ *
+ * @srv_pool:	Server pool whose pool_md is to be flushed
+ *
+ * Description:
+ *	Persist pool_md without waiting for the delayed work.
+ */
+void rmr_srv_flush_pool_md(struct rmr_srv_pool *srv_pool)
+{
+	struct rmr_pool *pool = srv_pool->pool;
+	void *buf;
+	int err;
+
+	if (!atomic_read(&srv_pool->store_state) || !pool->mapped_size)
+		return;
+
+	err = rmr_srv_md_update(srv_pool);
+	if (err) {
+		pr_warn("%s: failed to update pool_md before flush: 0x%x\n", __func__, err);
+		return;
+	}
+
+	buf = kzalloc(RMR_MD_SIZE, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	memcpy(buf, &pool->pool_md, sizeof(struct rmr_pool_md));
+	err = process_md_io(pool, NULL, 0, RMR_MD_SIZE, RMR_OP_MD_WRITE, buf);
+	if (err)
+		pr_warn("%s: failed to flush pool_md: 0x%x at offset 0 len %lu\n",
+			__func__, err, RMR_MD_SIZE);
+	kfree(buf);
+}
+
+/**
+ * rmr_srv_flush_last_io() - Write last_io region to disk
+ *
+ * @srv_pool:	Server pool whose last_io is to be flushed
+ */
+static void rmr_srv_flush_last_io(struct rmr_srv_pool *srv_pool)
+{
+	struct rmr_pool *pool = srv_pool->pool;
+	u64 last_io_len = rmr_last_io_len(pool->pool_md.queue_depth);
+	void *buf;
+	int err;
+
+	if (!last_io_len || !srv_pool->last_io)
+		return;
+
+	buf = kzalloc(last_io_len, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	memcpy(srv_pool->last_io_idx, srv_pool->last_io, last_io_len);
+	memcpy(buf, srv_pool->last_io_idx, last_io_len);
+
+	err = process_md_io(pool, NULL, RMR_MD_SIZE, last_io_len,
+			    RMR_OP_MD_WRITE, buf);
+	if (err)
+		pr_warn("%s: failed to flush last_io: 0x%x at offset %lu len %llu\n",
+			__func__, err, RMR_MD_SIZE, last_io_len);
+	kfree(buf);
+}
+
+/**
+ * rmr_srv_md_load_buf() - Load the server metadata from buffer to the server pool.
+ *
+ * Description:
+ *	This function loads the server-side metadata from buffer to the pool. The buffer must be
+ *	in the format of rmr pool metadata structure, which may contain updated srv_md of
+ *	multiple servers.
+ */
+static int rmr_srv_md_load_buf(struct rmr_pool *pool, void *buf)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_srv_md *srv_md_buf;
+	u8 member_id = 0;
+	int err = 0, index, i;
+	bool ret = false;
+
+	buf += (RMR_CLT_MD_SIZE - sizeof(struct rmr_srv_md));
+	for (i = 0; i < RMR_POOL_MAX_SESS; i++) {
+		buf += sizeof(struct rmr_srv_md);
+		srv_md_buf = (struct rmr_srv_md *)buf;
+		member_id = srv_md_buf->member_id;
+		/* skip updating the srv_md of this server pool */
+		if (!member_id || member_id == srv_pool->member_id)
+			continue;
+
+		index = rmr_pool_find_md(&pool->pool_md, member_id, true);
+		if (index < 0) {
+			pr_debug("%s: No space in the pool_md for new member %d\n",
+				 __func__, member_id);
+			err = -EINVAL;
+			continue;
+		}
+
+		pr_debug("Load srv_md[%d] with member_id %d\n", index, member_id);
+		memcpy(&pool->pool_md.srv_md[index], srv_md_buf, sizeof(struct rmr_srv_md));
+		ret = true;
+	}
+
+	if (!ret) {
+		pr_debug("No server metadata found in the buffer\n");
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+/**
+ * rmr_srv_md_process_buf() - Load the metadata from buffer to the server pool.
+ *
+ * Description:
+ *	This node loads the metadata from buffer to the server pool.
+ */
+int rmr_srv_md_process_buf(struct rmr_pool *pool, void *buf, bool sync)
+{
+	struct rmr_srv_pool *srv_pool;
+	struct rmr_pool_md *buf_pool_md, *dest_md = &pool->pool_md;
+	int err = 0;
+
+	srv_pool = (struct rmr_srv_pool *)pool->priv;
+	buf_pool_md = (struct rmr_pool_md *)buf;
+	if (!sync) {
+		/* Copy only the client-side header. */
+		memcpy(dest_md, buf_pool_md, RMR_CLT_MD_SIZE);
+	} else {
+		err = rmr_srv_md_load_buf(pool, buf);
+		if (err)
+			pr_err("Failed to load md buf to pool %s\n", pool->poolname);
+	}
+
+	return err;
+}
+
+int rmr_srv_send_md_update(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_pool *sync_pool = srv_pool->clt;
+	struct rmr_msg_pool_cmd msg = {};
+	int err = 0, buflen;
+	void *buf;
+
+	/* Only normal-state server pools should send metadata updates. */
+	if (atomic_read(&srv_pool->state) != RMR_SRV_POOL_STATE_NORMAL)
+		return -EINVAL;
+
+	/* For a stg node A, is A->B alive? */
+	if (!sync_pool) {
+		pr_debug("pool %s has no sync pool assigned. Cannot send md update commands.\n",
+			 pool->poolname);
+		return -ENXIO;
+	}
+
+	buf = kzalloc(RMR_MD_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	buflen = RMR_MD_SIZE;
+
+	rmr_clt_init_cmd(sync_pool, &msg);
+	msg.cmd_type = RMR_CMD_MD_SEND;
+	/* This node sends messages to start md_update. */
+	msg.md_send_cmd.leader_id = srv_pool->member_id;
+	msg.md_send_cmd.src_mapped_size = pool->mapped_size;
+
+	err = rmr_clt_send_cmd_with_data_all(sync_pool, &msg, buf, buflen);
+	if (err < 0) {
+		pr_debug("pool %s sends all sess RMR_CMD_MD_SEND failed\n", pool->poolname);
+		goto free_buf;
+	}
+
+	/*
+	 * keep the original slice of buffer if the corresponding send req failed.
+	 *
+	 * TODO:
+	 * We need to use the err received from rmr_clt_send_cmd_with_data_all in this function,
+	 * and match the sessions we are skipping.
+	 *
+	 * In general, the sessions_skipped == (RMR_POOL_MAX_SESS - (number_of_legs - 1 - err).
+	 * If the above number does not match, then we abandon the buffers, and try again.
+	 */
+	err = rmr_srv_md_load_buf(pool, buf);
+	if (err) {
+		pr_debug("Failed to load md buf to pool %s\n", pool->poolname);
+		goto free_buf;
+	}
+
+free_buf:
+	kfree(buf);
+	return err;
+}
+
+/**
+ * rmr_srv_refresh_md() - Refresh the metadata of the rmr pool.
+ *
+ * @srv_pool: Server pool whose metadata to be find
+ *
+ * Description:
+ *	Read the metadata of the rmr pool from the backing store.
+ *
+ * Return:
+ *	True when reading the metadata succeeds in two cases. The first case is a successful read
+ *	but no metadata found. The second case is it found metadata which contains the srv_md.
+ *	False otherwise.
+ */
+int rmr_srv_refresh_md(struct rmr_srv_pool *srv_pool)
+{
+	struct rmr_pool_md *pool_md_page;
+	struct rmr_pool *pool = srv_pool->pool;
+	int index, ret;
+	u64 md_ver;
+
+	pool_md_page = kzalloc(RMR_MD_SIZE, GFP_KERNEL);
+	if (!pool_md_page)
+		return -ENOMEM;
+
+	if (rmr_srv_read_md(pool, NULL, 0, RMR_MD_SIZE, pool_md_page)) {
+		pr_err("%s: failed reading md of rmr\n", __func__);
+		goto free_md;
+	}
+
+	pr_info("%s: Read md of pool %s from store with magic 0x%llx\n",
+		__func__, pool_md_page->poolname, pool_md_page->magic);
+
+	if (pool_md_page->magic != RMR_POOL_MD_MAGIC) {
+		pr_info("%s: No valid md found on the store for pool %s\n",
+			__func__, pool->poolname);
+		ret = -EINVAL;
+		goto free_md;
+	}
+
+	/*
+	 * TODO: Should we sanity check other params also?
+	 */
+	if (pool_md_page->chunk_size != pool->chunk_size) {
+		pr_err("%s: chunk size mismatched. pool chunk size %u, md chunk size %u\n",
+		       __func__, pool->chunk_size, pool_md_page->chunk_size);
+		goto free_md;
+	}
+
+	/* Import the metadata to the states of the pool. */
+	index = rmr_pool_find_md(pool_md_page, srv_pool->member_id, false);
+	if (index < 0) {
+		pr_info("%s: No md found for member_id %d\n", __func__, srv_pool->member_id);
+		ret = index;
+		goto free_md;
+	}
+
+	if (pool_md_page->srv_md[index].mapped_size != pool->mapped_size) {
+		pr_err("%s: Mapped size mismatched. The srv pool %llu, md %llu\n",
+		       __func__, pool->mapped_size, pool_md_page->mapped_size);
+		ret = -EINVAL;
+		goto free_md;
+	}
+
+	md_ver = pool_md_page->srv_md[index].map_ver;
+	if (md_ver < pool->map_ver)
+		pr_err("The current map ver is %lld but the map ver on md is %lld.\n",
+		       pool->map_ver, md_ver);
+	else
+		pool->map_ver = md_ver;
+
+	pool->pool_md = *pool_md_page;
+
+	ret = rmr_srv_load_last_io(srv_pool);
+	if (ret) {
+		pr_err("%s: failed to load last_io array to memory with err 0x%x\n",
+		       __func__, ret);
+		goto zero_md;
+	}
+
+	pr_info("%s: no_of_chunks %lld\n", __func__, pool->no_of_chunks);
+	ret = rmr_srv_refresh_md_maps(srv_pool);
+	if (ret) {
+		pr_err("%s: failed to load dirty bitmap to memory with err %pe\n",
+		       __func__, ERR_PTR(ret));
+		goto free_last_io;
+	}
+	goto free_md;
+
+free_last_io:
+	kfree(srv_pool->last_io_idx);
+	srv_pool->last_io_idx = NULL;
+zero_md:
+	memset(&pool->pool_md, 0, sizeof(pool->pool_md));
+free_md:
+	kfree(pool_md_page);
+	return ret;
+}
+
+/**
+ * rmr_srv_mark_maps_dirty() - Set MD_DIRTY_MAPS and schedule delayed sync
+ *
+ * @srv_pool:	Server pool with changed maps
+ */
+void rmr_srv_mark_maps_dirty(struct rmr_srv_pool *srv_pool)
+{
+	set_bit(MD_DIRTY_MAPS, &srv_pool->md_dirty);
+	mod_delayed_work(srv_pool->md_sync_wq, &srv_pool->md_sync_dwork,
+			 msecs_to_jiffies(RMR_SRV_MD_SYNC_INTERVAL_MS));
+}
+
+/**
+ * rmr_srv_md_sync - sync dirty metadata regions of pool
+ *
+ * Description:
+ *	Dirty-driven consumer: only flushes regions whose dirty bit is set.
+ *	Producers set bits and schedule this work via mod_delayed_work().
+ *	Does NOT re-queue itself — the next dirty event will schedule it.
+ */
+void rmr_srv_md_sync(struct work_struct *work)
+{
+	struct rmr_srv_pool *srv_pool;
+	struct rmr_pool *pool;
+	bool ret, did_work = false;
+
+	srv_pool = container_of(to_delayed_work(work), struct rmr_srv_pool, md_sync_dwork);
+	if (!srv_pool->pool)
+		return;
+
+	/*
+	 * It could happen that access the pool while the pool is not there. Use reference counting
+	 * for server pool to avoid the issue.
+	 */
+	ret = rmr_get_srv_pool(srv_pool);
+	if (!ret) {
+		pr_err("%s: pool is not there\n", __func__);
+		return;
+	}
+
+	pool = srv_pool->pool;
+
+	/*
+	 * Update srv_md snapshot and notify peers whenever any region is dirty.
+	 */
+	if (!rmr_srv_md_update(srv_pool) && rmr_srv_send_md_update(pool))
+		pr_debug("failed to send md update\n");
+
+	/*
+	 * The io store is ready after the store is registered and the pool metadata is
+	 * updated, if any.
+	 */
+	if (!atomic_read(&srv_pool->store_state) || !pool->mapped_size)
+		goto put_pool;
+
+	/*
+	 * On-disk layout of rmr pool metadata:
+	 *
+	 *   0           RMR_MD_SIZE   +last_io_len    +PAGE_SIZE
+	 *   +-----------+-------------+---------------+--------------------+
+	 *   | pool_md   | last_io     | hdr_region    | maps_region ...    |
+	 *   +-----------+-------------+---------------+--------------------+
+	 *   <-RMR_MD_SIZE><-last_io_len><--PAGE_SIZE--><-per_map slp pages->
+	 *
+	 * pool->maps[0:maps_cnt] is always dense (no NULL gaps).
+	 *
+	 * This I/O covers pool_md + last_io. hdr_region and maps_region are
+	 * written separately by rmr_srv_md_maps_sync().
+	 */
+	if (test_and_clear_bit(MD_DIRTY_POOL, &srv_pool->md_dirty)) {
+		rmr_srv_flush_pool_md(srv_pool);
+		did_work = true;
+	}
+
+	if (test_and_clear_bit(MD_DIRTY_LAST_IO, &srv_pool->md_dirty)) {
+		rmr_srv_flush_last_io(srv_pool);
+		did_work = true;
+	}
+
+	if (test_and_clear_bit(MD_DIRTY_MAPS, &srv_pool->md_dirty)) {
+		rmr_srv_md_maps_sync(pool);
+		did_work = true;
+	}
+
+	if (did_work)
+		pr_debug("%s: flushed dirty regions for server pool %u of %s\n",
+			 __func__, srv_pool->member_id, pool->poolname);
+
+put_pool:
+	rmr_put_srv_pool(srv_pool);
+	/* Do NOT re-queue. Producers schedule us via mod_delayed_work. */
+}
diff --git a/drivers/infiniband/ulp/rmr/rmr-srv.c b/drivers/infiniband/ulp/rmr/rmr-srv.c
new file mode 100644
index 000000000000..66af29b90c53
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/rmr-srv.c
@@ -0,0 +1,3306 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reliable multicast over RTRS (RMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include <linux/module.h>
+#include <linux/blkdev.h>
+
+#include "rmr-srv.h"
+#include "rmr-req.h"
+#include "rmr-clt.h"
+
+MODULE_AUTHOR("The RMR and BRMR developers");
+MODULE_VERSION(RMR_VER_STRING);
+MODULE_DESCRIPTION("RMR Server");
+MODULE_LICENSE("GPL");
+
+static struct rtrs_srv_ctx *rtrs_ctx;
+struct kmem_cache *rmr_req_cachep;
+
+static LIST_HEAD(g_sess_list);
+static DEFINE_MUTEX(g_sess_lock);
+
+#define MIN_CHUNK_SIZE (128 << 10)
+#define MAX_CHUNK_SIZE (1024 << 10)
+#define DEFAULT_CHUNK_SIZE MIN_CHUNK_SIZE
+
+static int __read_mostly chunk_size = DEFAULT_CHUNK_SIZE;
+
+module_param_named(chunk_size, chunk_size, uint, 0444);
+MODULE_PARM_DESC(chunk_size,
+		 "Unit size which is tracked for being dirty. (default: "
+		 /* cppcheck-suppress unknownMacro */
+		 __stringify(DEFAULT_CHUNK_SIZE) "KB)");
+
+static int __read_mostly sync_queue_depth = DEFAULT_SYNC_QUEUE_DEPTH;
+
+module_param_named(sync_queue_depth, sync_queue_depth, uint, 0644);
+MODULE_PARM_DESC(sync_queue_depth,
+		 "Max in-flight sync requests per pool (default: "
+		 __stringify(DEFAULT_SYNC_QUEUE_DEPTH) ")");
+
+bool rmr_get_srv_pool(struct rmr_srv_pool *srv_pool)
+{
+	pr_debug("pool %s, before inc refcount %d\n",
+		 srv_pool->pool->poolname, refcount_read(&srv_pool->refcount));
+	return refcount_inc_not_zero(&srv_pool->refcount);
+}
+
+static struct rmr_srv_pool *rmr_find_and_get_srv_pool(u32 group_id)
+{
+	struct rmr_pool *pool;
+	struct rmr_srv_pool *srv_pool;
+
+	mutex_lock(&pool_mutex);
+	pool = rmr_find_pool_by_group_id(group_id);
+	if (!pool) {
+		mutex_unlock(&pool_mutex);
+		return ERR_PTR(-ENOENT);
+	}
+
+	srv_pool = (struct rmr_srv_pool *)pool->priv;
+	if (!rmr_get_srv_pool(srv_pool)) {
+		mutex_unlock(&pool_mutex);
+		return ERR_PTR(-EINVAL);
+	}
+	mutex_unlock(&pool_mutex);
+
+	return srv_pool;
+}
+
+void rmr_put_srv_pool(struct rmr_srv_pool *srv_pool)
+{
+	struct rmr_pool *pool = srv_pool->pool;
+
+	might_sleep();
+
+	pr_debug("pool %s, before dec refcnt %d\n",
+		 (pool ? pool->poolname : "(empty)"), refcount_read(&srv_pool->refcount));
+	if (refcount_dec_and_test(&srv_pool->refcount)) {
+		mutex_destroy(&srv_pool->srv_pool_lock);
+
+		if (srv_pool->clt)
+			rmr_clt_close(srv_pool->clt);
+
+		kfree(srv_pool->last_io);
+		srv_pool->last_io = NULL;
+		kfree(srv_pool->last_io_idx);
+		srv_pool->last_io_idx = NULL;
+
+		if (pool) {
+			pr_info("srv: destroy pool %s\n", pool->poolname);
+			free_pool(pool);
+		}
+
+		cancel_delayed_work_sync(&srv_pool->md_sync_dwork);
+		destroy_workqueue(srv_pool->md_sync_wq);
+
+		cancel_delayed_work_sync(&srv_pool->clean_dwork);
+		destroy_workqueue(srv_pool->clean_wq);
+
+		kfree(srv_pool);
+	}
+}
+
+static const char *rmr_get_srv_pool_state_name(enum rmr_srv_pool_state state)
+{
+	switch (state) {
+	case RMR_SRV_POOL_STATE_EMPTY: return "RMR_SRV_POOL_STATE_EMPTY";
+	case RMR_SRV_POOL_STATE_REGISTERED: return "RMR_SRV_POOL_STATE_REGISTERED";
+	case RMR_SRV_POOL_STATE_CREATED: return "RMR_SRV_POOL_STATE_CREATED";
+	case RMR_SRV_POOL_STATE_NORMAL: return "RMR_SRV_POOL_STATE_NORMAL";
+	case RMR_SRV_POOL_STATE_NO_IO: return "RMR_SRV_POOL_STATE_NO_IO";
+
+	default: return "Unknown state";
+	}
+}
+
+/**
+ * rmr_srv_change_pool_state() - Change srv pool state
+ *
+ * @srv_pool:	Server pool whose state is to be changed
+ * @new_state:	State to which the transition is to be made
+ *
+ * Return:
+ *	old state on succes
+ *	negative error code on failure
+ *
+ * Description:
+ *	This function controls the state transitions for rmr-srv pool state.
+ *	Every state transition is controlled by this except to NORMAL.
+ *	Function rmr_srv_set_pool_state_normal handles transition to state NORMAL.
+ *	"always-invalid" state transitions are checked and prevented here
+ *	Case dependent valid/invalid state transition, should be handled by caller
+ */
+static inline int rmr_srv_change_pool_state(struct rmr_srv_pool *srv_pool,
+					    enum rmr_srv_pool_state new_state)
+{
+	enum rmr_srv_pool_state old_state = atomic_read(&srv_pool->state);
+	int cmp_state;
+
+	WARN_ON(new_state == RMR_SRV_POOL_STATE_NORMAL);
+
+	if (old_state == new_state)
+		return old_state;
+
+	pr_info("%s: Old state %s, Requested state %s\n",
+		__func__, rmr_get_srv_pool_state_name(old_state),
+		rmr_get_srv_pool_state_name(new_state));
+
+	switch (new_state) {
+	case RMR_SRV_POOL_STATE_NO_IO:
+		/*
+		 * NO_IO can be reached from REGISTERED, CREATED, or NORMAL.
+		 * EMPTY -> NO_IO is illegal: a pool with no store cannot have
+		 * active sessions that fail.
+		 */
+		if (WARN_ON(old_state == RMR_SRV_POOL_STATE_EMPTY))
+			goto err;
+		atomic_set(&srv_pool->state, RMR_SRV_POOL_STATE_NO_IO);
+		break;
+	case RMR_SRV_POOL_STATE_EMPTY:
+		/*
+		 * EMPTY is reached from REGISTERED (store unregistered, no
+		 * sessions) or from NO_IO (last session left, no store). A
+		 * direct jump from CREATED or NORMAL is illegal — those states
+		 * must pass through NO_IO first.
+		 */
+		if (WARN_ON(old_state == RMR_SRV_POOL_STATE_CREATED ||
+			    old_state == RMR_SRV_POOL_STATE_NORMAL))
+			goto err;
+		atomic_set(&srv_pool->state, RMR_SRV_POOL_STATE_EMPTY);
+		break;
+	case RMR_SRV_POOL_STATE_REGISTERED:
+		/*
+		 * REGISTERED is entered from EMPTY (store just registered, no
+		 * sessions) or from NO_IO (last session left, store still
+		 * present). A direct jump from CREATED or NORMAL is illegal —
+		 * those states must pass through NO_IO first.
+		 */
+		if (WARN_ON(old_state == RMR_SRV_POOL_STATE_CREATED ||
+			    old_state == RMR_SRV_POOL_STATE_NORMAL))
+			goto err;
+		atomic_set(&srv_pool->state, RMR_SRV_POOL_STATE_REGISTERED);
+
+		break;
+	case RMR_SRV_POOL_STATE_CREATED:
+		/*
+		 * CREATED is entered only from REGISTERED, when the first
+		 * non-sync create-mode join arrives. Any other predecessor
+		 * is illegal.
+		 */
+		cmp_state = RMR_SRV_POOL_STATE_REGISTERED;
+		if (atomic_try_cmpxchg(&srv_pool->state, &cmp_state, RMR_SRV_POOL_STATE_CREATED))
+			goto out;
+		WARN_ON(1);
+		goto err;
+	default:
+		pr_err("%s: Unknown state %d\n", __func__, new_state);
+		goto err;
+	}
+
+out:
+	rmr_srv_mark_pool_md_dirty(srv_pool);
+	return old_state;
+
+err:
+	pr_err("%s: Failed. Old state %s, Requested state %s\n",
+	       __func__, rmr_get_srv_pool_state_name(old_state),
+	       rmr_get_srv_pool_state_name(new_state));
+	return -EINVAL;
+}
+
+/**
+ * rmr_srv_set_pool_state_normal() - Change srv pool state to NORMAL
+ *
+ * @srv_pool:	Server pool whose state is to be changed to NORMAL
+ *
+ * Return:
+ *	old state on succes
+ *	negative error code on failure
+ *
+ * Description:
+ *	This function controls the state transitions for rmr-srv pool state to NORMAL
+ *	"always-invalid" state transitions are checked and prevented here
+ *	Case dependent valid/invalid state transition, should be handled by caller
+ */
+static int rmr_srv_set_pool_state_normal(struct rmr_srv_pool *srv_pool)
+{
+	int old_state;
+
+	mutex_lock(&srv_pool->srv_pool_lock);
+	old_state = atomic_read(&srv_pool->state);
+
+	pr_info("%s: Old state %s\n", __func__,
+		rmr_get_srv_pool_state_name(old_state));
+
+	if (old_state == RMR_SRV_POOL_STATE_NORMAL)
+		goto out;
+
+	/*
+	 * CREATED -> NORMAL: normal enable on a newly created pool.
+	 * NO_IO -> NORMAL: map update completed, pool can serve IOs again.
+	 * Any other predecessor is illegal.
+	 */
+	if (WARN_ON(old_state != RMR_SRV_POOL_STATE_CREATED &&
+		    old_state != RMR_SRV_POOL_STATE_NO_IO)) {
+		old_state = -EINVAL;
+		goto out;
+	}
+
+	atomic_set(&srv_pool->state, RMR_SRV_POOL_STATE_NORMAL);
+	rmr_srv_mark_pool_md_dirty(srv_pool);
+	pr_info("%s: Server pool state changed to NORMAL\n", __func__);
+
+out:
+	mutex_unlock(&srv_pool->srv_pool_lock);
+
+	return old_state;
+}
+
+/**
+ * rmr_srv_clear_map() - clear the  dirty map if other pool member completely synced it
+ *
+ * @pool:	rmr pool that holds the maps to clean
+ * @member_id:	pool member id for which map is reported as clean
+ *
+ * Description:
+ *	If other pool member responded that he finished syncing his data, then we can
+ *	clear his map replicated to this nodes, in case of some clear commands were
+ *	lost or failed.
+ *
+ * Return:
+ *	no
+ *
+ * Context:
+ *	This function can wait on spin_lock if the deleted entry should be inserted back
+ *
+ * Locks:
+ *	no
+ */
+static void rmr_srv_clear_map(struct rmr_pool *pool, u8 member_id)
+{
+	// TODO: this looks like rmr_pool_map_remove_entries, can we do something about this?
+	// I was not able to merge them, but it would be nice.
+	struct rmr_dirty_id_map *map = NULL;
+	rmr_id_t id;
+	int i, lock_idx;
+
+	pr_debug("pool %s clear map entries for member_id=%u\n",
+		 pool->poolname, member_id);
+
+	lock_idx = srcu_read_lock(&pool->map_srcu);
+	map = rmr_pool_find_map(pool, member_id);
+	if (!map) {
+		pr_err("for pool %s cannot find map for member id %u\n", pool->poolname, member_id);
+		goto unlock;
+	}
+
+	/* if the map state changed since we send our CHECK_MAP command, it means that
+	 * some entries were added and the map is not clean and we should not wipe it.
+	 * rsp of CHECK_MAP cmd can be outdated a little so we do not trust it then.
+	 */
+	if (atomic_read(&map->check_state) != RMR_MAP_STATE_CHECKING)
+		pr_debug("map for member_id=%u cannot be cleared now, state changed\n",
+			 map->member_id);
+
+	for (i = 0; i < map->no_of_chunks; i++) {
+		id.a = 1;
+		id.b = i;
+
+		rmr_map_unset_dirty(map, id, MAP_NO_FILTER);
+
+		/* If the state changed since the last check then it is possible that after
+		 * clear_bit of RMR_MAP_STATE_CHECK_CLEAR in the rmr_req_check_map we called
+		 * rmr_map_insert. There we check that entry is already in the map and leave
+		 * the function. But the following erease here would delete it. So we return
+		 * erased entry back to the table if the state of checking changed.
+		 */
+		if (atomic_read(&map->check_state) != RMR_MAP_STATE_CHECKING) {
+			pr_debug("map for member_id=%u cannot be cleared now, state changed\n",
+				 map->member_id);
+
+			rmr_map_set_dirty(map, id, 0);
+			goto unlock;
+		}
+	}
+	pr_debug("clear map entries for member_id=%u is done\n", member_id);
+unlock:
+	srcu_read_unlock(&pool->map_srcu, lock_idx);
+	rmr_srv_mark_maps_dirty((struct rmr_srv_pool *)pool->priv);
+}
+
+/**
+ * rmr_srv_check_map_clear() - periodic work that checks if the other node finished sync
+ *
+ * @work:	delayed work structure to start and repeat the work
+ *
+ * Description:
+ *	Check the dirty maps of all of the other pool members. If any of the maps is dirty
+ *	then send check command and if the pool member responds that it has cleared his map,
+ *	then we should clear it locally. When checking is done reschedule itself again.
+ *
+ * Return:
+ *	no
+ *
+ * Context:
+ *	runs in the process context.
+ *
+ * Locks:
+ *	no
+ */
+static void rmr_srv_check_map_clear(struct work_struct *work)
+{
+	struct rmr_srv_pool *srv_pool;
+	struct rmr_pool *pool;
+	int i, lock_idx;
+
+	srv_pool = container_of(to_delayed_work(work), struct rmr_srv_pool, clean_dwork);
+
+	if (!srv_pool->pool) {
+		pr_debug("no rmr pool assigend to srv_pool yet.\n");
+		goto out;
+	}
+
+	pool = srv_pool->pool;
+	pr_debug("check map for srv pool %s started...\n", pool->poolname);
+
+	if (atomic_read(&srv_pool->state) != RMR_SRV_POOL_STATE_NORMAL) {
+		pr_debug("srv pool %s is not in normal state, skip map clear check",
+			 pool->poolname);
+		goto out;
+	}
+
+	if (!srv_pool->clt) {
+		pr_debug("srv pool %s does not have sync pool assigned, skip map clear check\n",
+			 pool->poolname);
+		goto out;
+	}
+
+	lock_idx = srcu_read_lock(&pool->map_srcu);
+	for (i = 0; i < pool->maps_cnt; i++) {
+		struct rmr_dirty_id_map *map;
+		u8 member_id;
+		int ret;
+
+		map = rcu_dereference(pool->maps[i]);
+		if (WARN_ON(!map))
+			break;
+
+		member_id = map->member_id;
+		if (member_id == srv_pool->member_id) {
+			pr_debug("srv pool %s skip checking map with id %u, since it is me.\n",
+				 pool->poolname, member_id);
+			continue;
+		}
+
+		if (rmr_map_empty(map)) {
+			pr_debug("srv pool %s map for member_id=%u is empty, no need to check\n",
+				 pool->poolname, map->member_id);
+			continue;
+		}
+
+		atomic_set(&map->check_state, RMR_MAP_STATE_CHECKING);
+
+		ret = rmr_clt_pool_member_synced(srv_pool->clt, member_id);
+		if (ret < 0) {
+			pr_debug("pool %s failed to check if member_id=%u synced, ret %d\n",
+				 pool->poolname, member_id, ret);
+			atomic_set(&map->check_state, RMR_MAP_STATE_NO_CHECK);
+			continue;
+		}
+
+		pr_debug("pool %s check if pool member %u synced, reported %u\n\n",
+			 pool->poolname, member_id, ret);
+		if (ret)
+			rmr_srv_clear_map(pool, member_id);
+
+		atomic_set(&map->check_state, RMR_MAP_STATE_NO_CHECK);
+	}
+	srcu_read_unlock(&pool->map_srcu, lock_idx);
+
+	pr_debug("check map for pool %s done. schedule next one.\n", pool->poolname);
+
+out:
+	queue_delayed_work(srv_pool->clean_wq, &srv_pool->clean_dwork,
+			   msecs_to_jiffies(RMR_SRV_CHECK_MAPS_INTERVAL_MS));
+}
+
+struct rmr_srv_pool *rmr_create_srv_pool(char *poolname, u32 member_id)
+{
+	struct rmr_srv_pool *srv_pool;
+	srv_pool = kzalloc(sizeof(struct rmr_srv_pool), GFP_KERNEL);
+	if (unlikely(!srv_pool))
+		return ERR_PTR(-ENOMEM);
+
+	atomic_set(&srv_pool->state, RMR_SRV_POOL_STATE_EMPTY);
+	srv_pool->maintenance_mode = false;
+	refcount_set(&srv_pool->refcount, 1);
+	mutex_init(&srv_pool->srv_pool_lock);
+
+	atomic_set(&srv_pool->store_state, false);
+
+	srv_pool->member_id = member_id;
+	srv_pool->max_sync_io_size = U32_MAX;
+
+	/* Sync thread */
+	srv_pool->th_tsk = NULL;
+	atomic_set(&srv_pool->thread_state, SYNC_THREAD_STOPPED);
+	atomic_set(&srv_pool->in_flight_sync_reqs, 0);
+
+	/* clean outdated entries from the map work */
+	srv_pool->clean_wq = alloc_workqueue("%s_clean_wq", 0, 0, poolname);
+	if (!srv_pool->clean_wq) {
+		kfree(srv_pool);
+		pr_err("failed to create wq pool %s\n", poolname);
+		return ERR_PTR(-ENOMEM);
+	}
+	INIT_DELAYED_WORK(&srv_pool->clean_dwork, rmr_srv_check_map_clear);
+	queue_delayed_work(srv_pool->clean_wq, &srv_pool->clean_dwork,
+			   msecs_to_jiffies(RMR_SRV_CHECK_MAPS_INTERVAL_MS));
+
+	/* sync metadata of the rmr pool */
+	srv_pool->md_sync_wq = alloc_workqueue("%s_md_sync_wq", 0, 0, poolname);
+	if (!srv_pool->md_sync_wq) {
+		kfree(srv_pool);
+		pr_err("failed to create md_sync_wq pool %s\n", poolname);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	INIT_DELAYED_WORK(&srv_pool->md_sync_dwork, rmr_srv_md_sync);
+	/* No initial queue — first dirty event will schedule the work. */
+	return srv_pool;
+}
+
+void rmr_srv_pool_update_params(struct rmr_pool *pool)
+{
+	pr_info("%s: Setting chunk_size for pool %s to %d",
+		__func__, pool->poolname, chunk_size);
+	pool->chunk_size = chunk_size;
+	pool->chunk_size_shift = ilog2(chunk_size);
+}
+
+static struct rmr_pool *rmr_srv_sess_get_pool(struct rmr_srv_sess *srv_sess, u32 group_id)
+{
+	struct rmr_pool *pool;
+	struct rmr_srv_pool *srv_pool;
+	bool ret;
+
+	rcu_read_lock();
+	pool = xa_load(&srv_sess->pools, group_id);
+	if (!pool) {
+		pool = ERR_PTR(-ENXIO);
+		goto out;
+	}
+
+	srv_pool = (struct rmr_srv_pool *)pool->priv;
+	ret = rmr_get_srv_pool(srv_pool);
+	if (!ret)
+		pool = ERR_PTR(-ENXIO);
+
+out:
+	rcu_read_unlock();
+	return pool;
+}
+
+static void rmr_srv_sess_put_pool(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+	rmr_put_srv_pool(srv_pool);
+}
+
+/**
+ * rmr_srv_endreq() - Function called when an rmr server request finishes processing
+ *
+ * @req:	Pointer to the request ending
+ * @err:	Error value. Would be 0 for a successful request
+ */
+void rmr_srv_endreq(struct rmr_srv_req *req, int err)
+{
+	struct rmr_srv_pool *srv_pool = req->srv_pool;
+	struct rmr_pool *pool = srv_pool->pool;
+	struct rtrs_srv_op *rtrs_op = req->rtrs_op;
+	struct rmr_dirty_id_map *map;
+	int i;
+
+	if (req->flags == RMR_OP_MD_WRITE || req->flags == RMR_OP_MD_READ) {
+		if (unlikely(err))
+			pr_err("Failed to complete the md req %x\n", req->flags);
+		goto put_ref;
+	} else if (unlikely(err) && !req->sync) {
+		struct rmr_srv_pool *srv_pool = req->srv_pool;
+
+		rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_NO_IO);
+	} else if (rmr_op(req->flags) == RMR_OP_WRITE) {
+		srv_pool->last_io[req->mem_id].a = req->id.a;
+		srv_pool->last_io[req->mem_id].b = req->id.b;
+
+		if (!test_and_set_bit(MD_DIRTY_LAST_IO, &srv_pool->md_dirty)) {
+			mod_delayed_work(srv_pool->md_sync_wq,
+					 &srv_pool->md_sync_dwork,
+					 msecs_to_jiffies(RMR_SRV_MD_SYNC_INTERVAL_MS));
+		}
+
+		for (i = 0; i < req->failed_cnt; i++) {
+			int err;
+
+			map = rmr_pool_find_map(srv_pool->pool, req->failed_srv_id[i]);
+			if (!map) {
+				pr_err("Cannot find map for srv_id %u\n", req->failed_srv_id[i]);
+				err = -EINVAL;
+				goto out;
+			}
+
+			atomic_set(&map->check_state, RMR_MAP_STATE_NO_CHECK);
+			rmr_map_set_dirty(map, req->id, 0);
+
+			if (req->map_ver > srv_pool->pool->map_ver)
+				srv_pool->pool->map_ver = req->map_ver;
+		}
+		if (req->failed_cnt) {
+			rmr_srv_mark_pool_md_dirty(srv_pool);
+			rmr_srv_mark_maps_dirty(srv_pool);
+		}
+	}
+
+out:
+	/* The requests created by rmr-srv don't use rtrs_op. */
+	rtrs_srv_resp_rdma(rtrs_op, err);
+	rmr_srv_sess_put_pool(req->srv_pool->pool);
+put_ref:
+	percpu_ref_put(&pool->ids_inflight_ref);
+}
+
+static void rmr_srv_stop_sync_and_unset_store(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+	atomic_set(&srv_pool->store_state, false);
+
+	if (atomic_read(&srv_pool->thread_state) != SYNC_THREAD_STOPPED) {
+		atomic_set(&srv_pool->thread_state, SYNC_THREAD_REQ_STOP);
+		wake_up_process(srv_pool->th_tsk);
+
+		while (atomic_read(&srv_pool->thread_state) != SYNC_THREAD_STOPPED) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(msecs_to_jiffies(1000));
+		}
+	}
+}
+
+static void rmr_srv_delete_store_member(struct rmr_pool *pool, unsigned long id)
+{
+	rmr_pool_remove_map(pool, id);
+	xa_erase(&pool->stg_members, id);
+	rmr_srv_mark_maps_dirty((struct rmr_srv_pool *)pool->priv);
+}
+
+/**
+ * rmr_srv_add_store_member() - Register a storage member and create its dirty map
+ *
+ * @pool:	The pool to which the member belongs.
+ * @id:		Member ID of the storage node to add.
+ *
+ * Records @id in pool->stg_members and allocates a dirty map for it.
+ * On failure the stg_members entry is removed before returning.
+ *
+ * Return:
+ *	0 on success, negative error code on failure.
+ */
+static int rmr_srv_add_store_member(struct rmr_pool *pool, unsigned long id)
+{
+	struct rmr_dirty_id_map *map;
+	int ret;
+
+	map = rmr_pool_find_map(pool, id);
+	if (map) {
+		pr_err("%s: pool %s, member_id %lu map already exists\n",
+		       __func__, pool->poolname, id);
+		return -EEXIST;
+	}
+
+	ret = xa_err(xa_store(&pool->stg_members, id, XA_TRUE, GFP_KERNEL));
+	if (ret) {
+		pr_err("%s: Failed to add storage member %lu: %d\n",
+		       __func__, id, ret);
+		return ret;
+	}
+
+	/*
+	 * Create the map of the newly added member.
+	 */
+	map = rmr_map_create(pool, id);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		pr_err("%s: pool %s, member_id %lu failed to create map on err %d: %pe\n",
+		       __func__, pool->poolname, id, ret, map);
+		goto rem_store;
+	}
+	return 0;
+
+rem_store:
+	xa_erase(&pool->stg_members, id);
+	return ret;
+}
+
+/**
+ * rmr_srv_handle_other_member_add() - Handle a POOL_INFO ADD message for a different member
+ *
+ * @srv_pool:		The server pool receiving the notification.
+ * @pool_info_cmd:	The received POOL_INFO command carrying member_id, mode, and dirty.
+ *
+ * For %RMR_POOL_INFO_MODE_ASSEMBLE, verifies that the member and its dirty map
+ * already exist (the node is rejoining a pool it was previously part of).
+ * For %RMR_POOL_INFO_MODE_CREATE, adds the member via rmr_srv_add_store_member()
+ * and optionally marks its map fully dirty if the client reported outstanding data.
+ *
+ * Return:
+ *	0 on success, negative error code on failure.
+ */
+static int rmr_srv_handle_other_member_add(struct rmr_srv_pool *srv_pool,
+					   const struct rmr_msg_pool_info_cmd *pool_info_cmd)
+{
+	struct rmr_pool *pool = srv_pool->pool;
+	struct rmr_dirty_id_map *map;
+	int ret;
+
+	if (pool_info_cmd->mode == RMR_POOL_INFO_MODE_ASSEMBLE) {
+		pr_info("%s: Member %u got add of member %u with mode assemble\n",
+			__func__, srv_pool->member_id, pool_info_cmd->member_id);
+
+		/*
+		 * For assemble, member info should already exist.
+		 */
+		if (xa_load(&pool->stg_members, pool_info_cmd->member_id) != XA_TRUE) {
+			pr_err("%s: pool %s, member_id %u not present\n",
+			       __func__, pool->poolname, pool_info_cmd->member_id);
+			return -ENOENT;
+		}
+
+		map = rmr_pool_find_map(pool, pool_info_cmd->member_id);
+		if (!map) {
+			pr_err("%s: pool %s, member_id %u, map not present\n",
+			       __func__, pool->poolname, pool_info_cmd->member_id);
+			return -ENOENT;
+		}
+	} else if (pool_info_cmd->mode == RMR_POOL_INFO_MODE_CREATE &&
+		    pool_info_cmd->member_id != srv_pool->member_id) {
+		pr_info("%s: Member %u got add of member %u with mode create\n",
+			__func__, srv_pool->member_id, pool_info_cmd->member_id);
+
+		ret = rmr_srv_add_store_member(pool, pool_info_cmd->member_id);
+		if (ret) {
+			pr_err("%s: rmr_srv_add_store_member failed %d\n", __func__, ret);
+			return ret;
+		}
+
+		if (pool_info_cmd->dirty) {
+			map = rmr_pool_find_map(pool, pool_info_cmd->member_id);
+			if (WARN_ON(!map)) {
+				xa_erase(&pool->stg_members, pool_info_cmd->member_id);
+				return -EINVAL;
+			}
+			rmr_map_set_dirty_all(map, MAP_NO_FILTER);
+		}
+		rmr_srv_mark_maps_dirty((struct rmr_srv_pool *)pool->priv);
+	} else {
+		pr_err("%s: pool %s, member_id %u, unexpected mode %u for ADD operation\n",
+		       __func__, pool->poolname, pool_info_cmd->member_id,
+		       pool_info_cmd->mode);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int rmr_srv_query(struct rmr_pool *pool, u64 mapped_size, struct rmr_attrs *attr)
+{
+	struct rmr_srv_pool *srv_pool;
+	struct rmr_dirty_id_map *map;
+	size_t queue_depth;
+
+	if (pool) {
+		srv_pool = (struct rmr_srv_pool *)pool->priv;
+		queue_depth = srv_pool->queue_depth;
+	} else {
+		/*
+		 * If pool is NULL, we are being called to estimate the md size
+		 * before the pool is created. Use max queue depth in that case.
+		 */
+		queue_depth = RMR_SRV_MAX_QDEPTH;
+	}
+
+	/*
+	 * Dummy map structure, so that we can reuse the update map param function.
+	 */
+	map = (struct rmr_dirty_id_map *)get_zeroed_page(GFP_KERNEL);
+	if (!map) {
+		pr_err("%s: Cannot allocate map\n", __func__);
+		return -ENOMEM;
+	}
+
+	map->no_of_chunks = (mapped_size >> (ilog2(chunk_size) - 9));
+	rmr_map_update_page_params(map);
+
+	attr->rmr_md_size = (map->total_slp * PAGE_SIZE * RMR_POOL_MAX_SESS) + RMR_MD_SIZE;
+	attr->rmr_md_size += (queue_depth * sizeof(*srv_pool->last_io_idx));
+
+	attr->rmr_md_size = attr->rmr_md_size / SECTOR_SIZE;
+
+	free_page((unsigned long)map);
+	return 0;
+}
+EXPORT_SYMBOL(rmr_srv_query);
+
+/**
+ * rmr_srv_set_map() - Create the dirty map for this server's member in the pool
+ *
+ * @pool:	The pool for which the map is to be created.
+ * @mode:	Registration mode; if %RMR_SRV_DISK_REPLACE, any existing map for
+ *		this member is removed before creating the new one.
+ *
+ * Description:
+ *	Invoked after the mapped size of the pool has been validated.  Updates
+ *	pool metadata with the mapped size, recalculates the chunk count, and
+ *	calls rmr_srv_add_store_member() to register this node's map.
+ *
+ * Return:
+ *	0 on success, negative error code on failure.
+ */
+static int rmr_srv_set_map(struct rmr_pool *pool, enum rmr_srv_register_disk_mode mode)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	int ret, md_i;
+
+	pr_info("%s: Mapped size of the pool %s is set to %lld\n",
+		__func__, pool->poolname, pool->mapped_size);
+
+	/* Update mapped_size in the pool metadata. */
+	md_i = rmr_pool_find_md(&pool->pool_md, srv_pool->member_id, true);
+	if (md_i < 0) {
+		pr_err("No space for new member %d.\n", srv_pool->member_id);
+		return -ENOMEM;
+	}
+	pool->pool_md.srv_md[md_i].mapped_size = pool->mapped_size;
+
+	/*
+	 * The existing map is irrelevant if user asked for store REPLACE.
+	 */
+	if (mode == RMR_SRV_DISK_REPLACE)
+		rmr_pool_remove_map(pool, srv_pool->member_id);
+
+	ret = rmr_srv_add_store_member(pool, srv_pool->member_id);
+	if (ret) {
+		pr_err("%s: rmr_srv_add_store_member failed %d\n", __func__, ret);
+		goto err_out;
+	}
+
+	return ret;
+
+err_out:
+	pool->pool_md.srv_md[md_i].mapped_size = 0;
+	return ret;
+}
+
+/**
+ * rmr_srv_register() - Register a backend store with an RMR server pool
+ *
+ * @poolname:	Name of the pool to which the store is to be registered.
+ * @ops:	Store operations pointer.
+ * @priv:	Private data for the store.
+ * @mapped_size:	Size of the storage device in sectors.
+ * @mode:	Registration mode: %RMR_SRV_DISK_CREATE for a new store,
+ *		%RMR_SRV_DISK_REPLACE to replace an existing one, or
+ *		%RMR_SRV_DISK_ADD to rejoin an existing pool.
+ *
+ * Description:
+ *	An RMR server pool requires a backend store to service I/Os.
+ *	This function registers that store, sets up the pool's dirty map for
+ *	this member, and records the marked_create flag for validation when
+ *	the first client joins.
+ *
+ * Return:
+ *	Pointer to the rmr_pool on success, NULL on error.
+ */
+static bool rmr_srv_pool_has_non_sync_sess(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool_sess *pool_sess;
+
+	list_for_each_entry(pool_sess, &pool->sess_list, pool_entry) {
+		if (!pool_sess->sync)
+			return true;
+	}
+	return false;
+}
+
+struct rmr_pool *rmr_srv_register(char *poolname, struct rmr_srv_store_ops *ops, void *priv,
+				  u64 mapped_size, enum rmr_srv_register_disk_mode mode)
+{
+	struct rmr_pool *pool;
+	struct rmr_srv_io_store *io_store;
+	struct rmr_srv_pool *srv_pool;
+	u32 group_id = rmr_pool_hash(poolname);
+	enum rmr_srv_pool_state state;
+	int ret;
+
+	srv_pool = rmr_find_and_get_srv_pool(group_id);
+	if (IS_ERR(srv_pool)) {
+		pr_err("pool %s does not exists: %pe\n", poolname, srv_pool);
+		return NULL;
+	}
+	pool = srv_pool->pool;
+
+	mutex_lock(&srv_pool->srv_pool_lock);
+	if (mode == RMR_SRV_DISK_CREATE &&
+	    (rmr_srv_pool_has_non_sync_sess(pool) ||
+	     rmr_pool_find_map(pool, srv_pool->member_id))) {
+		pr_err("%s: Cannot register (create) new backend for %s; Sessions/Map exists\n",
+		       __func__, poolname);
+		ret = -EEXIST;
+		goto put_err;
+	}
+
+	if (mode == RMR_SRV_DISK_REPLACE &&
+	    (!rmr_srv_pool_has_non_sync_sess(pool))) {
+		pr_err("%s: Cannot register (replace) new backend for %s; No non-sync session\n",
+		       __func__, poolname);
+		ret = -EINVAL;
+		goto put_err;
+	}
+
+	if (srv_pool->io_store) {
+		pr_err("Srv pool %s already has store registered\n", poolname);
+		goto put_err;
+	}
+
+	if (pool->mapped_size && pool->mapped_size != mapped_size) {
+		pr_err("Pool %s already has mapped size %lld, cannot register store with %lld\n",
+		       poolname, pool->mapped_size, mapped_size);
+		ret = -EINVAL;
+		goto put_err;
+	}
+
+	io_store = kzalloc(sizeof(*io_store), GFP_KERNEL);
+	if (!io_store) {
+		pr_err("Failed to allocate io_store for %s\n", poolname);
+		goto put_err;
+	}
+
+	pool->mapped_size = mapped_size;
+	io_store->ops = ops;
+	io_store->priv = priv;
+	srv_pool->io_store = io_store;
+
+	/* The pool updates its number of tracking chunks with the mapped size just provided. */
+	rmr_pool_update_no_of_chunk(pool);
+
+	if (mode == RMR_SRV_DISK_CREATE || mode == RMR_SRV_DISK_REPLACE) {
+		ret = rmr_srv_set_map(pool, mode);
+		if (ret) {
+			pr_err("%s: failed to set maps in rmr pool %s, err %d\n",
+			       __func__, poolname, ret);
+			goto free_io_store;
+		}
+	} else if (mode == RMR_SRV_DISK_ADD) {
+		/*
+		 * Read the pool metadata stored on this device before md_sync writes
+		 * new metadata to the store.
+		 */
+		ret = rmr_srv_refresh_md(srv_pool);
+		if (ret) {
+			pr_err("%s: cannot refresh md of the pool\n", __func__);
+			goto free_io_store;
+		}
+	} else {
+		pr_err("%s: Wrong register disk mode %d\n", __func__, mode);
+		ret = -EINVAL;
+		goto free_io_store;
+	}
+
+	srv_pool->marked_create = (mode == RMR_SRV_DISK_CREATE);
+	atomic_set(&srv_pool->store_state, true);
+	rmr_srv_mark_pool_md_dirty(srv_pool);
+	state = atomic_read(&srv_pool->state);
+	if (state != RMR_SRV_POOL_STATE_NORMAL &&
+	    state != RMR_SRV_POOL_STATE_NO_IO)
+		rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_REGISTERED);
+	mutex_unlock(&srv_pool->srv_pool_lock);
+
+	__module_get(THIS_MODULE);
+	pr_info("Registered store with pool %s\n", poolname);
+
+	return srv_pool->pool;
+
+free_io_store:
+	kfree(io_store);
+	srv_pool->io_store = NULL;
+put_err:
+	mutex_unlock(&srv_pool->srv_pool_lock);
+	rmr_put_srv_pool(srv_pool);
+	return NULL;
+}
+EXPORT_SYMBOL(rmr_srv_register);
+
+static void rmr_srv_delete_md(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_dirty_id_map *map = NULL;
+	int err, lock_idx;
+	u32 map_region_offset = rmr_bitmap_offset(pool->pool_md.queue_depth) + RMR_MAP_BUF_HDR_SIZE;
+	u64 per_map_size = 0;
+	u64 len;
+	u8 map_idx;
+	void *buf;
+
+	/*
+	 * It could happen to access the pool while the pool is not there. Use reference counting
+	 * for server pool to avoid the issue.
+	 */
+	err = rmr_get_srv_pool(srv_pool);
+	if (!err) {
+		pr_err("%s: pool is not there\n", __func__);
+		return;
+	}
+
+	len = rmr_bitmap_offset(pool->pool_md.queue_depth) + PAGE_SIZE;
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		goto put_pool;
+
+	/*
+	 * On-disk layout of rmr pool metadata:
+	 *
+	 *   0           RMR_MD_SIZE   +last_io_len    +PAGE_SIZE
+	 *   +-----------+-------------+---------------+--------------------+
+	 *   | pool_md   | last_io     | hdr_region    | maps_region ...    |
+	 *   +-----------+-------------+---------------+--------------------+
+	 *   <-RMR_MD_SIZE><-last_io_len><--PAGE_SIZE--> maps_cnt * per_map
+	 */
+	err = process_md_io(pool, NULL, 0, len, RMR_OP_MD_WRITE, buf);
+	if (err)
+		pr_warn("%s: failed to process md write io with err 0x%x.\n", __func__, err);
+
+	/*
+	 * Zero the bitmap on disk using O(1) offset formula.
+	 */
+	lock_idx = srcu_read_lock(&pool->map_srcu);
+	for (map_idx = 0; map_idx < pool->maps_cnt; map_idx++) {
+		u32 map_data_offset;
+		el_flp *flp_ptr;
+		u64 no_of_slps;
+		int i, j;
+
+		map = rcu_dereference(pool->maps[map_idx]);
+		if (WARN_ON(!map))
+			break;
+
+		per_map_size = map->total_slp * PAGE_SIZE;
+		map_data_offset = map_region_offset + map_idx * per_map_size;
+
+		for (i = 0; i < map->no_of_flp; i++) {
+			flp_ptr = (el_flp *)map->dirty_bitmap[i];
+
+			if (i == (map->no_of_flp - 1))
+				no_of_slps = map->no_of_slp_in_last_flp;
+			else
+				no_of_slps = NO_OF_SLP_PER_FLP;
+
+			for (j = 0; j < no_of_slps; j++, flp_ptr++) {
+				err = process_md_io(pool, NULL, map_data_offset,
+						    PAGE_SIZE, RMR_OP_MD_WRITE, buf);
+				if (err)
+					pr_warn("%s: bitmap write failed at 0x%x, err 0x%x.\n",
+						__func__, map_data_offset, err);
+				map_data_offset += PAGE_SIZE;
+			}
+		}
+	}
+	srcu_read_unlock(&pool->map_srcu, lock_idx);
+
+	rmr_srv_delete_store_member(pool, srv_pool->member_id);
+
+	free_page((unsigned long)buf);
+put_pool:
+	rmr_put_srv_pool(srv_pool);
+}
+
+/**
+ * rmr_srv_unregister() - Unregister the backend store from rmr server pool
+ *
+ * @poolname:	Name of the pool from which the store is to be unregistered
+ * @delete:	If true, delete all the metadata associated with this pool
+ *
+ * Description:
+ *	rmr server pool needs a backend store which serves the IOs
+ *	This function is used to unregister a backend store from rmr server pool.
+ *
+ * Return:
+ *	None
+ */
+void rmr_srv_unregister(char *poolname, bool delete)
+{
+	struct rmr_pool *pool;
+	struct rmr_srv_pool *srv_pool;
+	struct rmr_srv_io_store	*io_store;
+
+	mutex_lock(&pool_mutex);
+	pool = rmr_find_pool(poolname);
+	mutex_unlock(&pool_mutex);
+
+	if (!pool) {
+		pr_err("%s, Pool %s does not exists\n", __func__, poolname);
+		return;
+	}
+
+	srv_pool = (struct rmr_srv_pool *)pool->priv;
+	mutex_lock(&srv_pool->srv_pool_lock);
+
+	if (!srv_pool->io_store) {
+		pr_err("Srv pool %s not registered\n", poolname);
+		mutex_unlock(&srv_pool->srv_pool_lock);
+		return;
+	}
+
+	if (srv_pool->marked_delete) {
+		if (!delete) {
+			pr_err("%s: Storage server marked for delete, but delete mode not set\n",
+			       __func__);
+			pr_err("%s: Continuing with only removal", __func__);
+		}
+	} else if (!srv_pool->marked_create && delete) {
+		pr_err("%s: Storage server not marked for delete, abandoning delete.\n", __func__);
+		delete = false;
+	}
+
+	io_store = srv_pool->io_store;
+
+	rmr_srv_stop_sync_and_unset_store(pool);
+
+	percpu_ref_kill_and_confirm(&pool->ids_inflight_ref, rmr_pool_confirm_inflight_ref);
+	wait_for_completion(&pool->complete_done);
+	wait_for_completion(&pool->confirm_done);
+
+	/*
+	 * Re-init so metadata IO can go in if needed
+	 */
+	reinit_completion(&pool->complete_done);
+	reinit_completion(&pool->confirm_done);
+	percpu_ref_reinit(&pool->ids_inflight_ref);
+
+	if (delete)
+		rmr_srv_delete_md(pool);
+
+	kfree(srv_pool->io_store);
+	srv_pool->io_store = NULL;
+
+	mutex_lock(&pool->sess_lock);
+	if (!rmr_srv_pool_has_non_sync_sess(pool))
+		rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_EMPTY);
+	mutex_unlock(&pool->sess_lock);
+
+	srv_pool->marked_delete = false;
+	mutex_unlock(&srv_pool->srv_pool_lock);
+
+	pool->mapped_size = 0;
+
+	rmr_put_srv_pool(srv_pool);
+
+	pr_info("Unregistered store with pool %s\n", poolname);
+
+	module_put(THIS_MODULE);
+}
+EXPORT_SYMBOL(rmr_srv_unregister);
+
+/**
+ * rmr_srv_pool_cmd_with_rsp() - Sends a user command to all sessions of the internal (sync) clt
+ *
+ * @pool:	rmr pool to which the command is for
+ * @conf:	confirmation function to be called after completion
+ * @priv:	pointer to priv data, to be returned to user while calling conf function
+ * @usr_vec:	kvec containing user data (mostly command messages?)
+ * @nr:		number of kvecs
+ * @buf:	buf where the response from the user server is to be directed
+ * @buf_len:	length of the buffer
+ * @size:	size of the buf to be sent to a single session
+ *
+ * Description:
+ *	This function provides an interface for the user to send commands to storage nodes connected
+ *	through the internal network of this rmr pool.
+ *	It redirects the command through the rmr-client pool in this storage node, which then sends
+ *	the command to all the storage nodes it is connected to.
+ *	The command is sent as a read, so that the response from the user srv side can be received
+ *	The buffer sent by the user is meant to receive the response from the user server side.
+ *	The size of the buffer is set during rmr_clt_open.
+ *
+ * Return:
+ *	0 on success
+ *	negative errno in case of error
+ *
+ * Context:
+ *	Inflight commands will block map update, until the inflights are completed.
+ */
+int rmr_srv_pool_cmd_with_rsp(struct rmr_pool *pool, rmr_conf_fn *conf, void *priv,
+			     const struct kvec *usr_vec, size_t nr, void *buf, int buf_len,
+			     size_t size)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+	if (!srv_pool->clt) {
+		pr_warn("srv pool %s does not have sync pool assigned.\n",
+			pool->poolname);
+		return -EAGAIN;
+	}
+
+	return rmr_clt_cmd_with_rsp(srv_pool->clt, conf, priv, usr_vec, nr, buf, buf_len, size);
+}
+EXPORT_SYMBOL(rmr_srv_pool_cmd_with_rsp);
+
+static int rmr_srv_send_discard_all(struct rmr_pool *pool, u8 member_id)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_pool *sync_pool = srv_pool->clt;
+	struct rmr_msg_pool_cmd msg = {};
+	int err;
+
+	/*
+	 * If the member_id is not this server's member_id, it means this server is the receiving
+	 * node of the discard request.
+	 */
+	if (srv_pool->member_id != member_id)
+		return 0;
+
+	pr_info("%s: Send discards across storage nodes for pool %s\n",
+		__func__, pool->poolname);
+
+	rmr_clt_init_cmd(sync_pool, &msg);
+	msg.cmd_type = RMR_CMD_SEND_DISCARD;
+	msg.send_discard_cmd.member_id = member_id;
+
+	err = rmr_clt_pool_send_all(sync_pool, &msg);
+	if (err) {
+		pr_err("Failed to send discard cmd for pool %s: %d\n",
+		       pool->poolname, err);
+	}
+	return err;
+}
+
+/**
+ * rmr_srv_discard_id() - discard the data chunks of length from offset on disk
+ *
+ * @pool:	source pool.
+ * @offset	offset in bytes.
+ * @length:	length in bytes
+ * @member_id:	member id of the storage node to discard the data from. If 0, then the node is
+ *		this server pool.
+ * @sync:	indicates whether to send sync requests to other connected nodes.
+ *
+ * Return:
+ *	0 on success, err code otherwise
+ *
+ * Description:
+ *	This function discards the data chunks on the server with member_id. It will mark the
+ *	data chunks as dirty and set the discard_entries flag of the corresponding srv_md true.
+ *	Then it notifies all the connected nodes it has discarded data.
+ */
+int rmr_srv_discard_id(struct rmr_pool *pool, u64 offset, u64 length, u8 member_id, bool sync)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_dirty_id_map *map;
+	rmr_id_t id;
+	int md_i, err;
+
+	if (!member_id)
+		member_id = srv_pool->member_id;
+
+	map = rmr_pool_find_map(pool, member_id);
+	if (!map) {
+		pr_err("for srv pool %s cannot find map for member_id %u\n",
+		       pool->poolname, member_id);
+		return -EINVAL;
+	}
+
+	md_i = rmr_pool_find_md(&pool->pool_md, member_id, false);
+	if (md_i < 0) {
+		pr_err("%s: for srv pool %s cannot find md for member_id %u\n",
+		       __func__, pool->poolname, member_id);
+		return -EINVAL;
+	}
+
+	/*
+	 * If this node has received a response of the discard request from a normal server,
+	 * the node will continue to mark all the data chunks as dirty.
+	 */
+	if (member_id == srv_pool->member_id && sync) {
+		if (!srv_pool->clt) {
+			pr_err("pool %s has no sync pool assigned. Cannot send discards.\n",
+			       pool->poolname);
+			return -ENXIO;
+		}
+
+		/*
+		 * This node tries to send discards to all its connected nodes. The other node
+		 * that has received the discards will start a new round. In the end, all normal
+		 * nodes that are connected to this node should receive the discards.
+		 */
+		err = rmr_srv_send_discard_all(pool, member_id);
+		if (err) {
+			pr_err("%s: no server receives discards for pool %s: %d\n",
+			       __func__, pool->poolname, err);
+			return err;
+		}
+	}
+
+	/*
+	 * Set the discard_entries flag of the corresponding srv_md true. Be careful that setting
+	 * the wrong srv_md will lead to loops of discards.
+	 */
+	pool->pool_md.srv_md[md_i].discard_entries = true;
+	rmr_srv_mark_pool_md_dirty(srv_pool);
+
+	if (length) {
+		rmr_map_calc_chunk(pool, offset, length, &id);
+		rmr_map_set_dirty(map, id, MAP_ENTRY_UNSYNCED);
+	} else {
+		/* discard all data chunks */
+		rmr_map_set_dirty_all(map, MAP_ENTRY_UNSYNCED);
+		pr_info("%s: Discard all data chunks for member_id %u in srv_pool %s: %u\n",
+			__func__, member_id, pool->poolname, srv_pool->member_id);
+	}
+
+	rmr_map_clear_filter_all(map, MAP_ENTRY_UNSYNCED);
+	rmr_srv_mark_maps_dirty(srv_pool);
+
+	return 0;
+}
+EXPORT_SYMBOL(rmr_srv_discard_id);
+
+void rmr_srv_replace_store(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+	RMR_STORE_SET_REPLACE(pool->map_ver);
+	rmr_srv_flush_pool_md(srv_pool);
+}
+EXPORT_SYMBOL(rmr_srv_replace_store);
+
+/**
+ * rmr_srv_pool_check_store() - Check whether IO is allowed for a pool or not
+ *
+ * @pool:	pool to check
+ *
+ * Return:
+ *	1 if IO is allowed, 0 therwise
+ *
+ * Description:
+ *	For a rmr-srv pool, the store registered provides a way to check whether it can process
+ *	IOs or not.
+ */
+static int rmr_srv_pool_check_store(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_srv_io_store *store = srv_pool->io_store;
+	void *store_priv;
+
+	if (!store) {
+		pr_debug("for srv pool %s no store assigned\n", pool->poolname);
+		return false;
+	}
+
+	if (!store->ops) {
+		pr_err("for pool %s store has no ops assigned\n", pool->poolname);
+		return false;
+	}
+	store_priv = store->priv;
+
+	return store->ops->io_allowed(store_priv);
+}
+
+/**
+ * process_msg_io() - Process IO message
+ *
+ * @srv_sess:	rmr srv session over which the message was received
+ * @rtrs_op:	rtrs IO context
+ * @data:	pointer to data buf
+ * @datalen:	len of data buf
+ * @usr:	pointer to user buf
+ * @usrlen:	len of user buf
+ *
+ * Return:
+ *	0 on success
+ *	negative error code otherwise
+ *
+ * Description:
+ *	Perform some basic checks.
+ *	Create an IO request and start its state machine.
+ */
+static int process_msg_io(struct rmr_srv_sess *srv_sess,
+			  struct rtrs_srv_op *rtrs_op, void *data,
+			  u32 datalen, const void *usr, size_t usrlen)
+{
+	const struct rmr_msg_io *msg = usr;
+	struct rmr_pool *pool;
+	struct rmr_srv_pool *srv_pool;
+	struct rmr_srv_req *req;
+	int err = 0;
+	u32 group_id = le32_to_cpu(msg->hdr.group_id);
+
+	pool = rmr_srv_sess_get_pool(srv_sess, group_id);
+	if (IS_ERR(pool)) {
+		pr_err_ratelimited("Got I/O request on session %s for unknown pool group id %d: %pe\n",
+				   srv_sess->sessname, group_id, pool);
+		return PTR_ERR(pool);
+	}
+
+	srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+	/*
+	 * No new references will come in after we have killed the percpu_ref.
+	 * Percpu_ref_tryget_live() returns false when @confirm_kill in
+	 * percpu_ref_kill_and_confirm() is done.
+	 */
+	if (!percpu_ref_tryget_live(&pool->ids_inflight_ref)) {
+		err = -EIO;
+		goto no_put;
+	}
+
+	if (!atomic_read(&srv_pool->store_state) ||
+	    atomic_read(&srv_pool->state) != RMR_SRV_POOL_STATE_NORMAL) {
+		pr_err_ratelimited("server pool %s is not up for IO (state = %s)\n",
+				   pool->poolname,
+				   rmr_get_srv_pool_state_name(atomic_read(&srv_pool->state)));
+		err = -EIO;
+		goto put_pool;
+	}
+
+	/*
+	 * The IOs coming from internal sync sessions are always READ.
+	 */
+	if (msg->sync && rmr_op(le32_to_cpu(msg->flags)) != RMR_OP_READ) {
+		pr_err_ratelimited("process_msg_io: pool %s write IO from internal connection.\n",
+				   pool->poolname);
+		err = -EIO;
+		goto put_pool;
+	}
+
+	/*
+	 * For non internal IOs, make sure the underlying store is ready for IO
+	 */
+	if (!msg->sync && !rmr_srv_pool_check_store(pool)) {
+		pr_err("process_msg_io: pool %s IO not allowed\n", pool->poolname);
+		err = -EIO;
+		goto put_pool;
+	}
+
+	req = rmr_srv_req_create(msg, srv_pool, rtrs_op, data, datalen, rmr_srv_endreq);
+	if (IS_ERR(req)) {
+		pr_err("Failed to create rmr_req %pe\n", req);
+
+		//TODO: do we have to rtrs_srv_resp_rdma here ?
+		err = PTR_ERR(req);
+		goto put_pool;
+	}
+
+	rmr_req_submit(req);
+	return 0;
+
+put_pool:
+	percpu_ref_put(&pool->ids_inflight_ref);
+
+no_put:
+	rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_NO_IO);
+	rmr_srv_sess_put_pool(pool);
+	return err;
+}
+
+int rmr_srv_get_sync_permit(struct rmr_srv_pool *srv_pool)
+{
+	atomic_inc(&srv_pool->in_flight_sync_reqs);
+
+	while (atomic_read(&srv_pool->in_flight_sync_reqs) >= sync_queue_depth) {
+		/* Permit overslow; sleep */
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+
+		if (atomic_read(&srv_pool->thread_state) != SYNC_THREAD_RUNNING) {
+			atomic_dec(&srv_pool->in_flight_sync_reqs);
+
+			return -EINTR;
+		}
+	}
+
+	return 0;
+}
+
+void rmr_srv_put_sync_permit(struct rmr_srv_pool *srv_pool)
+{
+	atomic_dec(&srv_pool->in_flight_sync_reqs);
+
+	wake_up_process(srv_pool->th_tsk);
+}
+
+static int rmr_srv_sync_map(void *arg)
+{
+	struct rmr_srv_pool *srv_pool = arg;
+	struct rmr_pool *pool = srv_pool->pool;
+	struct rmr_dirty_id_map *map;
+	rmr_id_t rmr_id;
+	struct rmr_map_entry *entry;
+	int err = 0;
+	u64 i;
+
+	pr_info("Sync thread starting!\n");
+
+	map = rmr_pool_find_map(pool, srv_pool->member_id);
+	if (!map) {
+		/*
+		 * We do not need to error out here.
+		 * Since no session has ever been added to this pool,
+		 * it technically means this pool is in sync state.
+		 */
+		pr_info("No map found for pool %s\n", pool->poolname);
+		goto out;
+	}
+
+	rmr_id.a = 1;
+	for (i = 0; i < map->no_of_chunks; i++) {
+		if (atomic_read(&srv_pool->thread_state) == SYNC_THREAD_REQ_STOP) {
+			pr_info("Request to stop sync thread\n");
+			err = -EINTR;
+			goto err;
+		}
+
+		if (!atomic_read(&srv_pool->store_state) ||
+		    atomic_read(&srv_pool->state) != RMR_SRV_POOL_STATE_NORMAL) {
+			atomic_set(&srv_pool->thread_state, SYNC_THREAD_WAIT);
+			pr_err("Pool not in desired state\n");
+			/* Unsure what error to return here */
+			err = -EINVAL;
+			goto err;
+		}
+
+		rmr_id.b = i;
+		entry = rmr_map_get_dirty_entry(map, rmr_id);
+		if (entry) {
+			if (atomic_cmpxchg(&entry->sync_cnt, -1, 0) != -1) {
+				/* someone has already started sync for this id */
+				continue;
+			}
+
+			err = rmr_srv_sync_chunk_id(srv_pool, entry, rmr_id, true);
+			if (err) {
+				/* this is to undo the previous cmpxchg if the error in
+				 * rmr_srv_sync_chunk_id happened before any requests were created
+				 */
+				atomic_cmpxchg(&entry->sync_cnt, 0, -1);
+				pr_err("Failed to sync chunk (%llu, %llu)\n", rmr_id.a, rmr_id.b);
+				goto err;
+			}
+		}
+	}
+
+	/*
+	 * Finished syncing chunks,
+	 * Now change the thread state to wait,
+	 * to wait for the in flight syncs
+	 */
+	atomic_set(&srv_pool->thread_state, SYNC_THREAD_WAIT);
+
+err:
+	while (atomic_read(&srv_pool->in_flight_sync_reqs) != 0) {
+		/*
+		 * Wait for all permits to get freed.
+		 * Since the completion path needs this thread to
+		 * be up and running
+		 */
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule();
+		//TODO: should it be timeout?
+	}
+
+out:
+	atomic_set(&srv_pool->thread_state, SYNC_THREAD_STOPPED);
+
+	pr_info("Sync thread exiting with err %d\n", err);
+	return err;
+}
+
+int rmr_srv_sync_thread_start(struct rmr_srv_pool *srv_pool)
+{
+	atomic_set(&srv_pool->in_flight_sync_reqs, 0);
+	srv_pool->th_tsk = kthread_run(rmr_srv_sync_map, srv_pool,
+				       "rmr_srv_sync_thread");
+	if (IS_ERR(srv_pool->th_tsk)) {
+		atomic_set(&srv_pool->thread_state, SYNC_THREAD_STOPPED);
+		return -ENOMEM;
+	}
+
+	atomic_set(&srv_pool->thread_state, SYNC_THREAD_RUNNING);
+	return 0;
+}
+
+int rmr_srv_sync_thread_stop(struct rmr_srv_pool *srv_pool)
+{
+	if (atomic_read(&srv_pool->thread_state) == SYNC_THREAD_RUNNING) {
+		atomic_set(&srv_pool->thread_state, SYNC_THREAD_REQ_STOP);
+		wake_up_process(srv_pool->th_tsk);
+	}
+
+	return 0;
+}
+
+void rmr_srv_sync_req_failed(struct rmr_srv_pool *srv_pool)
+{
+	/*
+	 * TODO: Investigate the necessity to change server state
+	 * to RMR_SRV_POOL_STATE_NO_IO for sync_req failure.
+	 */
+	// rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_NO_IO);
+	rmr_srv_sync_thread_stop(srv_pool);
+}
+
+static void rmr_srv_read_map_buf(struct rmr_pool *pool, void *buf, size_t buflen,
+				 const struct rmr_msg_map_buf_cmd *map_buf_cmd)
+{
+	int size;
+	u8 map_idx = map_buf_cmd->map_idx;
+	u64 slp_idx = map_buf_cmd->slp_idx;
+
+	size = rmr_pool_maps_to_buf(pool, &map_idx, &slp_idx, buf, buflen, MAP_NO_FILTER);
+	if (size == 0) {
+		// No more dirty map to write
+		struct rmr_map_buf_hdr *map_buf_hdr = (struct rmr_map_buf_hdr *)buf;
+
+		map_buf_hdr->version = RMR_MAP_FORMAT_VER;
+		map_buf_hdr->member_id = 0;
+	}
+}
+
+static void rmr_srv_update_md_buf(struct rmr_srv_pool *srv_pool, void *buf, size_t buflen)
+{
+	struct rmr_pool *pool = srv_pool->pool;
+	struct rmr_pool_md *pool_md = &pool->pool_md;
+	struct rmr_pool_md *buf_md = (struct rmr_pool_md *)buf;
+	u8 member_id = srv_pool->member_id;
+	int idx, buf_idx;
+
+	/* Zero out the buffer in case data is corrupted somehow. */
+	memset(buf, 0, buflen);
+	idx = rmr_pool_find_md(pool_md, member_id, false);
+	if (idx < 0) {
+		pr_err("The server pool hasn't updated srv_md yet %d\n", member_id);
+		return;
+	}
+
+	buf_idx = rmr_pool_find_md(buf_md, member_id, true);
+	if (buf_idx < 0) {
+		pr_err("The buffer has no space for the member_id %d\n", member_id);
+		return;
+	}
+
+	memcpy(&buf_md->srv_md[buf_idx], &pool_md->srv_md[idx], sizeof(struct rmr_srv_md));
+}
+
+static int rmr_srv_save_last_io_to_map(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_dirty_id_map *map;
+	int i, j, lock_idx;
+
+	map = rmr_pool_find_map(pool, srv_pool->member_id);
+	if (!map) {
+		pr_err("no map found for member_id %u\n", srv_pool->member_id);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < srv_pool->queue_depth; i++) {
+		rmr_id_t *id;
+		struct rmr_dirty_id_map *mp;
+
+		id = &srv_pool->last_io[i];
+
+		if (id->a == U64_MAX && id->b == U64_MAX)
+			continue;
+
+		if (rmr_map_check_dirty(map, *id)) {
+			/*
+			 * We already have this id added to our map, and which says
+			 * that its dirty for us. This means that last_io info about
+			 * this id is outdated.
+			 * We honor the info in the map, and skip this entry
+			 */
+			continue;
+		}
+
+		lock_idx = srcu_read_lock(&pool->map_srcu);
+		for (j = 0; j < pool->maps_cnt; j++) {
+			mp = rcu_dereference(pool->maps[j]);
+			if (WARN_ON(!mp) || mp->member_id == srv_pool->member_id)
+				continue;
+
+			rmr_map_set_dirty(mp, *id, 0);
+
+			// Clean the entry since it has been used up
+			id->a = U64_MAX;
+			id->b = U64_MAX;
+		}
+		srcu_read_unlock(&pool->map_srcu, lock_idx);
+	}
+
+	rmr_srv_mark_maps_dirty(srv_pool);
+	return 0;
+}
+
+/**
+ * process_msg_user_cmd() - Process user command
+ *
+ * @pool:	rmr pool
+ * @cmd_msg:	pointer to command message. The user data is right after this struct.
+ * @data:	data buffer to be passed down the user
+ * @datalen:	length of the user buffer
+ *
+ * Description:
+ *	Pass down the user command to the user server side.
+ *	The user command data is kept right after the pool command (see arranging of kvec)
+ *
+ * Return:
+ *	0 in case of success
+ *	negative is case of failure
+ *
+ * Context:
+ *	The call goes to the user server side. Care must be taken not to block.
+ */
+static int process_msg_user_cmd(struct rmr_srv_pool *srv_pool,
+				const struct rmr_msg_pool_cmd *cmd_msg, void *data, int datalen)
+{
+	struct rmr_srv_io_store *store = srv_pool->io_store;
+	size_t usr_len = cmd_msg->user_cmd.usr_len;
+	int ret;
+
+	pr_debug("%s: cmd_len=%zu usr_len=%zu\n", __func__, sizeof(*cmd_msg), usr_len);
+
+	if (!store) {
+		pr_err("%s: No store registered\n", __func__);
+		return -EAGAIN;
+	}
+
+	ret = store->ops->submit_cmd(store->priv, cmd_msg + 1, usr_len, data, datalen);
+
+	return ret;
+}
+
+static void do_sess_leave_srv_sess(struct rmr_srv_pool_sess *pool_sess)
+{
+	struct rmr_srv_sess *srv_sess = pool_sess->srv_sess;
+
+	mutex_lock(&srv_sess->lock);
+	list_del(&pool_sess->srv_sess_entry);
+	mutex_unlock(&srv_sess->lock);
+}
+
+static void sess_leave_pool(struct rmr_pool *pool,
+			    struct rmr_srv_pool_sess *pool_sess)
+{
+	struct rmr_srv_sess *srv_sess = pool_sess->srv_sess;
+
+	pr_info("pool sesss %s leaves pool %s\n",
+		pool_sess->sessname, pool->poolname);
+
+	mutex_lock(&pool->sess_lock);
+	list_del(&pool_sess->pool_entry);
+	xa_erase(&srv_sess->pools, pool->group_id);
+	mutex_unlock(&pool->sess_lock);
+
+	rmr_srv_sysfs_del_sess(pool_sess);
+
+	pool_sess->srv_pool = NULL;
+}
+
+static void rmr_srv_free_pool_sess(struct rmr_srv_pool_sess *pool_sess)
+{
+	kfree(pool_sess);
+}
+
+static void destroy_sess(struct rmr_srv_sess *srv_sess)
+{
+	struct rmr_srv_pool *srv_pool;
+	struct rmr_srv_pool_sess *pool_sess, *tmp;
+
+	// why do they do this in rnbd srv ?
+	// if (list_empty(&srv_sess->pool_sess_list))
+	// 	goto out;
+
+	mutex_lock(&srv_sess->lock);
+	list_for_each_entry_safe (pool_sess, tmp, &srv_sess->pool_sess_list, srv_sess_entry) {
+		list_del(&pool_sess->srv_sess_entry);
+		srv_pool = pool_sess->srv_pool;
+
+		// A network disconnect event
+		if (!pool_sess->sync)
+			rmr_srv_change_pool_state(pool_sess->srv_pool, RMR_SRV_POOL_STATE_NO_IO);
+
+		sess_leave_pool(srv_pool->pool, pool_sess);
+		rmr_put_srv_pool(srv_pool);
+		rmr_srv_free_pool_sess(pool_sess);
+	}
+	mutex_unlock(&srv_sess->lock);
+
+	xa_destroy(&srv_sess->pools);
+	might_sleep();
+
+	mutex_lock(&g_sess_lock);
+	list_del(&srv_sess->g_list_entry);
+	mutex_unlock(&g_sess_lock);
+
+	mutex_destroy(&srv_sess->lock);
+	kfree(srv_sess);
+}
+
+void rmr_srv_destroy_pool(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool_sess *pool_sess, *tmp;
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+	if (!pool) {
+		pr_err("%s: pool is empty\n", __func__);
+		return;
+	}
+
+	list_for_each_entry_safe (pool_sess, tmp, &pool->sess_list, pool_entry) {
+		WARN_ON(!pool_sess->srv_pool);
+
+		do_sess_leave_srv_sess(pool_sess);
+		sess_leave_pool(srv_pool->pool, pool_sess);
+		rmr_put_srv_pool(srv_pool);
+		rmr_srv_free_pool_sess(pool_sess);
+	}
+}
+
+int rmr_srv_remove_clt_pool(struct rmr_srv_pool *srv_pool)
+{
+	struct rmr_pool *clt;
+
+	clt = srv_pool->clt;
+	if (!clt) {
+		pr_info("Srv pool %s has no internal clt pool assigned\n",
+			srv_pool->pool->poolname);
+		return -EINVAL;
+	}
+
+	pr_info("from pool %s remove sync (internal) pool %s\n",
+		srv_pool->pool->poolname, clt->poolname);
+	srv_pool->clt = NULL;
+
+	rmr_clt_close(clt);
+
+	pr_info("pool %s removed\n", clt->poolname);
+
+	return 0;
+}
+
+static int create_srv_sess(struct rtrs_srv_sess *rtrs)
+{
+	struct rmr_srv_sess *srv_sess;
+	char sessname[NAME_MAX];
+	int err;
+
+	err = rtrs_srv_get_path_name(rtrs, sessname, sizeof(sessname));
+	if (unlikely(err)) {
+		pr_err("rtrs_srv_get_sess_name(%s): %d\n", sessname, err);
+		return err;
+	}
+	srv_sess = kzalloc(sizeof(*srv_sess), GFP_KERNEL);
+	if (!srv_sess)
+		return -ENOMEM;
+
+	mutex_init(&srv_sess->lock);
+	srv_sess->rtrs = rtrs;
+	strscpy(srv_sess->sessname, sessname, NAME_MAX);
+	xa_init_flags(&srv_sess->pools, XA_FLAGS_ALLOC);
+	INIT_LIST_HEAD(&srv_sess->pool_sess_list);
+	mutex_init(&srv_sess->lock);
+
+	mutex_lock(&g_sess_lock);
+	list_add(&srv_sess->g_list_entry, &g_sess_list);
+	mutex_unlock(&g_sess_lock);
+
+	rtrs_srv_set_sess_priv(rtrs, srv_sess);
+
+	return 0;
+}
+
+static int rmr_srv_link_ev(struct rtrs_srv_sess *rtrs,
+			   enum rtrs_srv_link_ev ev, void *priv)
+{
+	struct rmr_srv_sess *srv_sess = priv;
+
+	switch (ev) {
+	case RTRS_SRV_LINK_EV_CONNECTED:
+		return create_srv_sess(rtrs);
+
+	case RTRS_SRV_LINK_EV_DISCONNECTED:
+		if (WARN_ON(!srv_sess))
+			return -EINVAL;
+
+		destroy_sess(srv_sess);
+		return 0;
+
+	default:
+		pr_warn("Received unknown rtrs session event %d from session %s\n",
+			ev, srv_sess->sessname);
+		return -EINVAL;
+	}
+}
+
+static struct rmr_srv_pool_sess *__find_sess_in_pool(struct rmr_pool *pool,
+						     const char *sessname)
+{
+	struct rmr_srv_pool_sess *pool_sess;
+
+	list_for_each_entry (pool_sess, &pool->sess_list, pool_entry) {
+		if (!strcmp(pool_sess->sessname, sessname)) {
+			return pool_sess;
+		}
+	}
+
+	return NULL;
+}
+
+static int sess_join_pool(struct rmr_pool *pool, struct rmr_srv_pool_sess *pool_sess)
+{
+	struct rmr_srv_pool_sess *find;
+	struct rmr_srv_sess *srv_sess = pool_sess->srv_sess;
+	int ret = 0;
+
+	mutex_lock(&pool->sess_lock);
+	find = __find_sess_in_pool(pool, pool_sess->sessname);
+	if (find) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+
+	ret = xa_err(xa_store(&srv_sess->pools, pool->group_id, pool, GFP_KERNEL));
+	if (ret) {
+		pr_err("can not add pool %s err %d\n", pool->poolname, ret);
+		goto unlock;
+	}
+	pr_info("%s: Added pool %s to rmr_srv_sess %s\n",
+		__func__, pool->poolname, srv_sess->sessname);
+
+	ret = rmr_srv_sysfs_add_sess(pool, pool_sess);
+	if (ret) {
+		pr_err("failed to create sysfs for pool sess %s in pool %s\n",
+		       pool_sess->sessname, pool->poolname);
+
+		xa_erase(&srv_sess->pools, pool->group_id);
+		goto unlock;
+	}
+	list_add(&pool_sess->pool_entry, &pool->sess_list);
+
+unlock:
+	mutex_unlock(&pool->sess_lock);
+
+	return ret;
+}
+
+static void do_sess_leave_pool(struct rmr_pool *pool, struct rmr_srv_pool_sess *pool_sess)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+	do_sess_leave_srv_sess(pool_sess);
+	sess_leave_pool(pool, pool_sess);
+	rmr_put_srv_pool(srv_pool);
+	rmr_srv_free_pool_sess(pool_sess);
+}
+
+/**
+ * process_msg_pool_info() - Process a POOL_INFO membership change notification
+ *
+ * @pool:		Pool which received the command.
+ * @pool_info_cmd:	The received POOL_INFO command carrying member_id,
+ *			operation, mode, and dirty flag.
+ *
+ * Dispatches on (operation, mode) pairs notified by the client:
+ *  - ADD + CREATE:    a new storage node is joining; add it via
+ *		       rmr_srv_handle_other_member_add().
+ *  - ADD + ASSEMBLE:  an existing node is reassembling; verify its map and
+ *		       stg_members entry already exist.
+ *  - REMOVE + DELETE: a storage node is permanently leaving; remove its map
+ *		       and stg_members entry via rmr_srv_delete_store_member().
+ *  - REMOVE + DISASSEMBLE: temporary leave; no map changes needed (TODO).
+ *
+ * Return:
+ *	0 on success, negative error code on failure.
+ */
+static int process_msg_pool_info(struct rmr_pool *pool,
+				 const struct rmr_msg_pool_info_cmd *pool_info_cmd)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	int ret = 0;
+
+	pr_info("%s: Server pool %s with member_id %u, received pool_info message\n",
+		__func__, pool->poolname, srv_pool->member_id);
+
+	if (pool_info_cmd->operation == RMR_POOL_INFO_OP_ADD) {
+		ret = rmr_srv_handle_other_member_add(srv_pool, pool_info_cmd);
+		if (ret) {
+			pr_err("%s: Failed to create maps for other pools: %d\n",
+			       __func__, ret);
+			return ret;
+		}
+	} else if (pool_info_cmd->operation == RMR_POOL_INFO_OP_REMOVE) {
+		if (pool_info_cmd->mode == RMR_POOL_INFO_MODE_DELETE) {
+			pr_info("%s: Member %u got remove of member %u with mode delete\n",
+				__func__, srv_pool->member_id, pool_info_cmd->member_id);
+			rmr_srv_delete_store_member(pool, pool_info_cmd->member_id);
+		} else if (pool_info_cmd->mode == RMR_POOL_INFO_MODE_DISASSEMBLE) {
+			pr_info("%s: Member %u got remove of member %u with mode disassemble, "
+				"preserving dirty map\n",
+				__func__, srv_pool->member_id, pool_info_cmd->member_id);
+			/*
+			 * Do NOT remove the dirty map or stg_members entry for the
+			 * disassembled member.  IOs arriving after this point will
+			 * continue to accumulate dirty entries for that member via
+			 * the piggyback mechanism, so it can resync on reassembly.
+			 */
+		}
+	}
+	rmr_srv_flush_pool_md(srv_pool);
+
+	return ret;
+}
+
+static struct rmr_srv_pool_sess *alloc_pool_sess(struct rmr_srv_pool *srv_pool,
+						 struct rmr_srv_sess *srv_sess)
+{
+	struct rmr_srv_pool_sess *pool_sess;
+
+	pool_sess = kzalloc_node(sizeof(*pool_sess), GFP_KERNEL, NUMA_NO_NODE);
+	if (unlikely(!pool_sess)) {
+		pr_err("Failed to allocate session for srv pool %s\n", srv_pool->pool->poolname);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	strscpy(pool_sess->sessname, srv_sess->sessname, NAME_MAX);
+	INIT_LIST_HEAD(&pool_sess->pool_entry);
+	INIT_LIST_HEAD(&pool_sess->srv_sess_entry);
+	pool_sess->srv_sess = srv_sess;
+	pool_sess->srv_pool = srv_pool;
+
+	return pool_sess;
+}
+
+/**
+ * rmr_srv_process_join_create() - Handle the CREATE case of a join_pool message
+ *
+ * @pool:		The pool being created.
+ * @join_pool_cmd:	The received join_pool command carrying dirty flag and
+ *			per-member info for any pre-existing pool members.
+ *
+ * If the client reports that this server's existing data is dirty, marks own
+ * map fully dirty.  Then iterates the per-member list in the message and adds
+ * each member via rmr_srv_add_store_member(), marking its map dirty if the
+ * client flagged it.  On failure, all members added so far are cleaned up.
+ *
+ * Return:
+ *	0 on success, negative error code on failure.
+ */
+static int rmr_srv_process_join_create(struct rmr_pool *pool,
+				       const struct rmr_msg_join_pool_cmd *join_pool_cmd)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_dirty_id_map *map;
+	int i, ret;
+	u8 member_id;
+
+	/*
+	 * Mark our maps dirty if client asked us to.
+	 */
+	if (join_pool_cmd->dirty) {
+		map = rmr_pool_find_map(pool, srv_pool->member_id);
+		if (!map) {
+			pr_err("%s: No map found for %u\n",
+			       __func__, srv_pool->member_id);
+			return -EINVAL;
+		}
+		rmr_map_set_dirty_all(map, MAP_NO_FILTER);
+	}
+
+	/*
+	 * Add other storage members in case its a create message.
+	 */
+	for (i = 0; i < join_pool_cmd->mem_info.no_of_stor; i++) {
+		member_id = join_pool_cmd->mem_info.p_mem_info[i].member_id;
+
+		ret = rmr_srv_add_store_member(pool, member_id);
+		if (ret) {
+			pr_err("%s: rmr_srv_add_store_member failed %d\n", __func__, ret);
+			goto cleanup;
+		}
+
+		if (join_pool_cmd->mem_info.p_mem_info[i].c_dirty) {
+			map = rmr_pool_find_map(pool, member_id);
+			if (WARN_ON(!map)) {
+				xa_erase(&pool->stg_members, member_id);
+				ret = -EINVAL;
+				goto cleanup;
+			}
+			rmr_map_set_dirty_all(map, MAP_NO_FILTER);
+		}
+	}
+
+	return 0;
+
+cleanup:
+	while (i--)
+		rmr_srv_delete_store_member(pool,
+					    join_pool_cmd->mem_info.p_mem_info[i].member_id);
+	return ret;
+}
+
+static void rmr_srv_process_leave_delete(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	void *entry;
+	unsigned long id;
+
+	/*
+	 * When we are leaving a pool (not disassembly), we have to,
+	 * 1) Delete dirty entries from all the maps of other storage nodes, since we do not
+	 * need them anymore
+	 * 2) Delete all the maps of other storage nodes.
+	 *
+	 * Map for this storage node is created/deleted during register/unregister.
+	 */
+	xa_for_each(&pool->stg_members, id, entry) {
+		if (id == srv_pool->member_id)
+			continue;
+
+		rmr_srv_delete_store_member(pool, id);
+	}
+}
+
+static int process_msg_join_pool(struct rmr_pool *pool, struct rmr_srv_sess *srv_sess,
+				 struct rtrs_srv_sess *rtrs, bool sync,
+				 const struct rmr_msg_join_pool_cmd *join_pool_cmd)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_srv_pool_sess *pool_sess;
+	int ret = 0, i;
+	bool alloced_last_io = false;
+
+	pr_info("Client %s requests to join pool %s (state=%d)\n",
+		srv_sess->sessname, pool->poolname, atomic_read(&srv_pool->state));
+
+	mutex_lock(&srv_sess->lock);
+
+	/*
+	 * Here we only do chunk size check,
+	 * to make sure different storage nodes do not use different chunk sizes.
+	 */
+	if (join_pool_cmd->chunk_size && pool->chunk_size != join_pool_cmd->chunk_size) {
+		pr_err("pool %s has chunksize %u != msg chunksize %u\n",
+		       pool->poolname, pool->chunk_size, join_pool_cmd->chunk_size);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	mutex_lock(&srv_pool->srv_pool_lock);
+	if (atomic_read(&srv_pool->state) == RMR_SRV_POOL_STATE_EMPTY) {
+		pr_err("%s: pool %s has no store registered; join rejected\n",
+		       __func__, pool->poolname);
+		ret = -EINVAL;
+		goto unlock_srv_pool_lock;
+	}
+
+	if (!sync) {
+		if (join_pool_cmd->create) {
+			if (srv_pool->last_io || srv_pool->last_io_idx) {
+				pr_err("%s: pool %s already has last_io buffer allocated\n",
+				       __func__, pool->poolname);
+				ret = -EEXIST;
+				goto unlock_srv_pool_lock;
+			}
+
+			if (!srv_pool->marked_create) {
+				pr_err("%s: pool %s not in create state\n",
+				       __func__, pool->poolname);
+				ret = -EINVAL;
+				goto unlock_srv_pool_lock;
+			}
+		} else if (srv_pool->marked_create) {
+			pr_err("%s: pool %s should not be in create state\n",
+			       __func__, pool->poolname);
+			ret = -EINVAL;
+			goto unlock_srv_pool_lock;
+		}
+	}
+
+	pool_sess = alloc_pool_sess(srv_pool, srv_sess);
+	if (IS_ERR(pool_sess)) {
+		pr_err("failed to allc pool_sees for pool %s sev_sess %s: %pe\n",
+		       pool->poolname, srv_sess->sessname, pool_sess);
+		ret = PTR_ERR(pool_sess);
+		goto unlock_srv_pool_lock;
+	}
+	srv_pool->queue_depth = join_pool_cmd->queue_depth;
+
+	ret = sess_join_pool(pool, pool_sess);
+	if (ret) {
+		pr_err("Failed to join pool\n");
+		goto free_sess;
+	}
+	pool_sess->sync = sync;
+
+	if (!pool_sess->sync && !srv_pool->last_io) {
+		/* Joining for the first time */
+		srv_pool->last_io = kcalloc(srv_pool->queue_depth, sizeof(*srv_pool->last_io),
+					    GFP_KERNEL);
+		if (!srv_pool->last_io) {
+			pr_err("Memory allocation failed for srv_pool->last_io\n");
+			ret = -ENOMEM;
+			goto sess_leave;
+		}
+		alloced_last_io = true;
+
+		/* The previous last_io buffer exists. */
+		if (srv_pool->last_io_idx) {
+			memcpy(srv_pool->last_io, srv_pool->last_io_idx,
+			       rmr_last_io_len(srv_pool->queue_depth));
+		} else {
+			for (i = 0; i < srv_pool->queue_depth; i++) {
+				srv_pool->last_io[i].a = U64_MAX;
+				srv_pool->last_io[i].b = U64_MAX;
+			}
+
+			srv_pool->last_io_idx = kcalloc(srv_pool->queue_depth,
+						    sizeof(*srv_pool->last_io_idx), GFP_KERNEL);
+			if (!srv_pool->last_io_idx) {
+				ret = -ENOMEM;
+				goto free_last_io;
+			}
+		}
+		pr_info("Allocated %ld B last_io buffer for pool %s\n",
+			srv_pool->queue_depth * sizeof(*srv_pool->last_io), pool->poolname);
+	}
+
+	/*
+	 * Join/Rejoin messages from sync sessions do not affect our state.
+	 *
+	 * For non-sync sessions, if our state is NO_IO, pserver can either send a,
+	 * - rejoin message in case our state NO_IO due to network/IO issue
+	 * - join message in case pserver crashed
+	 * hence, no state transition is needed.
+	 */
+	if (!pool_sess->sync) {
+		if (join_pool_cmd->create) {
+			/*
+			 * First-time pool creation: set up member info and maps,
+			 * then move to CREATED awaiting enable_pool(1).
+			 */
+			ret = rmr_srv_process_join_create(pool, join_pool_cmd);
+			if (ret) {
+				pr_err("%s: rmr_srv_process_join_create failed %d\n",
+				       __func__, ret);
+				goto free_last_io;
+			}
+
+			/*
+			 * In the CREATE path pool_md has only magic set; all other
+			 * header fields are normally populated later by
+			 * RMR_CMD_SEND_MD_BUF.  Initialise them now so that
+			 * queue_depth (and the bitmap/last_io offsets derived from
+			 * it) are correct before the first on-demand map flush fires.
+			 */
+			pool->pool_md.queue_depth = join_pool_cmd->queue_depth;
+			pool->pool_md.chunk_size  = pool->chunk_size;
+			pool->pool_md.mapped_size = pool->mapped_size;
+			pool->pool_md.group_id    = pool->group_id;
+			strscpy(pool->pool_md.poolname, pool->poolname,
+				sizeof(pool->pool_md.poolname));
+			rmr_srv_mark_pool_md_dirty(srv_pool);
+			rmr_srv_mark_maps_dirty((struct rmr_srv_pool *)pool->priv);
+
+			ret = rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_CREATED);
+			if (ret < 0)
+				goto leave_delete;
+
+			srv_pool->marked_create = false;
+		} else if (atomic_read(&srv_pool->state) != RMR_SRV_POOL_STATE_NO_IO) {
+			/*
+			 * Assemble or rejoin: a map update is needed before IOs
+			 * can resume, so move to NO_IO. If we are already in
+			 * NO_IO (e.g. pserver reconnecting after a network event
+			 * that already drove us there), no transition is needed.
+			 */
+			ret = rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_NO_IO);
+			if (ret < 0)
+				goto leave_delete;
+		}
+	}
+
+	mutex_unlock(&srv_pool->srv_pool_lock);
+
+	rmr_get_srv_pool(srv_pool);
+	list_add_tail(&pool_sess->srv_sess_entry, &srv_sess->pool_sess_list);
+
+	mutex_unlock(&srv_sess->lock);
+
+	return 0;
+
+leave_delete:
+	if (!pool_sess->sync && join_pool_cmd->create)
+		rmr_srv_process_leave_delete(pool);
+free_last_io:
+	if (alloced_last_io) {
+		kfree(srv_pool->last_io);
+		srv_pool->last_io = NULL;
+
+		kfree(srv_pool->last_io_idx);
+		srv_pool->last_io_idx = NULL;
+	}
+sess_leave:
+	sess_leave_pool(pool, pool_sess);
+free_sess:
+	rmr_srv_free_pool_sess(pool_sess);
+unlock_srv_pool_lock:
+	mutex_unlock(&srv_pool->srv_pool_lock);
+unlock:
+	mutex_unlock(&srv_sess->lock);
+	return ret;
+}
+
+void rmr_srv_stop_sync_and_go_offline(struct rmr_pool *pool)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+	rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_NO_IO);
+
+	if (atomic_read(&srv_pool->thread_state) != SYNC_THREAD_STOPPED) {
+		atomic_set(&srv_pool->thread_state, SYNC_THREAD_REQ_STOP);
+		wake_up_process(srv_pool->th_tsk);
+
+		while (atomic_read(&srv_pool->thread_state) != SYNC_THREAD_STOPPED) {
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(msecs_to_jiffies(1000));
+		}
+	}
+}
+
+static int process_msg_leave_pool(struct rmr_pool *pool, struct rmr_srv_sess *sess, bool sync,
+				  const struct rmr_msg_leave_pool_cmd *leave_pool_cmd)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_srv_pool_sess *pool_sess;
+	u64 last_io_len;
+	int ret = 0;
+	void *buf;
+
+	pr_info("Session %s requests to leave pool %d\n", sess->sessname,
+		leave_pool_cmd->member_id);
+
+	if (srv_pool->member_id != leave_pool_cmd->member_id) {
+		pr_err("%s: For sess %s, Srv pool member_id %d, Message member_id %d\n",
+		       __func__, sess->sessname, srv_pool->member_id, leave_pool_cmd->member_id);
+		return -ENOENT;
+	}
+
+	mutex_lock(&pool->sess_lock);
+	pool_sess = __find_sess_in_pool(pool, sess->sessname);
+	if (!pool_sess) {
+		mutex_unlock(&pool->sess_lock);
+		pr_err("Session %s is not in pool %s\n", sess->sessname,
+		       pool->poolname);
+		return -ENOENT;
+	}
+	mutex_unlock(&pool->sess_lock);
+
+	do_sess_leave_pool(pool, pool_sess);
+
+	mutex_lock(&srv_pool->srv_pool_lock);
+	srv_pool->marked_delete = leave_pool_cmd->delete;
+	mutex_unlock(&srv_pool->srv_pool_lock);
+
+	if (!sync) {
+		/*
+		 * Stop the sync thread if its running, and go offline.
+		 */
+		rmr_srv_stop_sync_and_go_offline(pool);
+
+		if (leave_pool_cmd->delete) {
+			rmr_srv_process_leave_delete(pool);
+		} else {
+			/*
+			 * Disassemble: flush the dirty map to disk first so that
+			 * the on-disk map reflects all dirty entries accumulated
+			 * up to this point.  On reassembly the map is read back
+			 * and used to drive resync of any members that missed IOs.
+			 */
+			rmr_srv_md_maps_sync(pool);
+
+			/*
+			 * Clear last_io and persist it to disk so that it is not
+			 * used after reassembly.  Note: maps are always flushed
+			 * above regardless of whether last_io is valid; the two
+			 * operations are independent.
+			 */
+			last_io_len = rmr_last_io_len(pool->pool_md.queue_depth);
+
+			if (!srv_pool->last_io || !last_io_len)
+				goto change_state;
+
+			memset(srv_pool->last_io, 0, last_io_len);
+			if (srv_pool->last_io_idx)
+				memset(srv_pool->last_io_idx, 0, last_io_len);
+
+			buf = kzalloc(last_io_len, GFP_KERNEL);
+			if (!buf)
+				goto change_state;
+
+			ret = process_md_io(pool, NULL,
+					    RMR_LAST_IO_OFFSET,
+					    last_io_len,
+					    RMR_OP_MD_WRITE, buf);
+			if (ret) {
+				pr_err("%s: For pool %s process_md_io failed\n",
+				       __func__, pool->poolname);
+			}
+			kfree(buf);
+		}
+
+change_state:
+		/*
+		 * All sessions have left. Transition back to REGISTERED if the
+		 * backend store is still present, or to EMPTY if it is not.
+		 */
+		mutex_lock(&srv_pool->srv_pool_lock);
+		if (srv_pool->io_store)
+			rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_REGISTERED);
+		else
+			rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_EMPTY);
+		mutex_unlock(&srv_pool->srv_pool_lock);
+	}
+
+	return 0;
+}
+
+static int process_msg_map_clear(struct rmr_srv_sess *srv_sess,
+				 const void *usr)
+{
+	const struct rmr_msg_io *msg = usr;
+	struct rmr_pool *pool;
+	rmr_id_t id;
+	unsigned long key;
+	struct rmr_map_entry *entry;
+	struct rmr_dirty_id_map *map;
+	u8 member_id;
+	int err = 0;
+	u32 group_id = le32_to_cpu(msg->hdr.group_id);
+
+	id.a = le64_to_cpu(msg->id_a);
+	id.b = le64_to_cpu(msg->id_b);
+	key = rmr_id_to_key(id);
+	member_id = msg->member_id;
+
+	pr_debug("received map clear msg, id (%llu, %llu), member_id %u\n",
+		 id.a, id.b, member_id);
+
+	pool = rmr_srv_sess_get_pool(srv_sess, group_id);
+	if (IS_ERR(pool)) {
+		pr_err_ratelimited("Got I/O request on session %s for unknown pool: %pe\n",
+				   srv_sess->sessname, pool);
+		return PTR_ERR(pool);
+	}
+
+	map = rmr_pool_find_map(pool, member_id);
+	if (!map) {
+		pr_err("no map found for member_id %u\n", member_id);
+		err = -EINVAL;
+		goto put_pool;
+		//TODO: handle this , probably initialize map, or just throw err?
+	}
+
+	entry = rmr_map_unset_dirty(map, id, MAP_NO_FILTER);
+	if (entry) {
+		/* We do not need any rcu protection here since it is deleted by the other
+		 * rmr server. And sync can only be done for entries that are
+		 * dirty for this particaular server.
+		 */
+		kmem_cache_free(rmr_map_entry_cachep, entry);
+	}
+	rmr_srv_mark_maps_dirty((struct rmr_srv_pool *)pool->priv);
+
+put_pool:
+	rmr_srv_sess_put_pool(pool);
+	return err;
+}
+
+static int process_msg_map_add(struct rmr_srv_sess *srv_sess,
+			       const void *usr)
+{
+	const struct rmr_msg_io *msg = usr;
+	struct rmr_pool *pool;
+	int i, ret = 0;
+	struct rmr_dirty_id_map *map;
+	u32 group_id = le32_to_cpu(msg->hdr.group_id);
+
+	pr_debug("received map add member_id %u, id (%llu %llu)\n",
+		 msg->member_id, msg->id_a, msg->id_b);
+
+	pool = rmr_srv_sess_get_pool(srv_sess, group_id);
+	if (IS_ERR(pool)) {
+		pr_err_ratelimited("Got I/O request on session %s for unknown pool: %pe\n",
+				   srv_sess->sessname, pool);
+		return PTR_ERR(pool);
+	}
+
+	for (i = 0; i < msg->failed_cnt; i++) {
+		u64 msg_map_ver = le64_to_cpu(msg->map_ver);
+		rmr_id_t id;
+
+		map = rmr_pool_find_map(pool, msg->failed_id[i]);
+		if (!map) {
+			pr_err("no map found for member_id %u\n", msg->failed_id[i]);
+			ret = -EINVAL;
+			goto put_pool;
+		}
+
+		atomic_set(&map->check_state, RMR_MAP_STATE_NO_CHECK);
+		id.a = le64_to_cpu(msg->id_a);
+		id.b = le64_to_cpu(msg->id_b);
+		rmr_map_set_dirty(map, id, 0);
+
+		if (msg_map_ver > pool->map_ver)
+			pool->map_ver = msg_map_ver;
+	}
+	if (msg->failed_cnt) {
+		rmr_srv_mark_pool_md_dirty((struct rmr_srv_pool *)pool->priv);
+		rmr_srv_mark_maps_dirty((struct rmr_srv_pool *)pool->priv);
+	}
+
+put_pool:
+	rmr_srv_sess_put_pool(pool);
+
+	return ret;
+}
+
+/**
+ * rmr_srv_set_pool_mm() - Set the rmr srv pool to maintenance mode
+ *
+ * @srv_pool:	The rmr srv pool to set in maintenance mode
+ *
+ * Description:
+ *	While in maintenance mode, we do not serve IOs either, so we set state to NO_IO
+ *
+ * Return:
+ *	0 on success
+ *	Error value on failure
+ */
+static int rmr_srv_set_pool_mm(struct rmr_srv_pool *srv_pool)
+{
+	srv_pool->maintenance_mode = true;
+
+	return rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_NO_IO);
+}
+
+/**
+ * rmr_srv_unset_pool_mm() - Clear the rmr srv pool maintenance mode
+ *
+ * @srv_pool:	The rmr srv pool to clear maintenance mode of
+ *
+ * Description:
+ *	While in maintenance mode, we do not serve IOs either, so we set state to NO_IO
+ *
+ * Return:
+ *	0 on success
+ *	Error value on failure
+ */
+static int rmr_srv_unset_pool_mm(struct rmr_srv_pool *srv_pool)
+{
+	srv_pool->maintenance_mode = false;
+	rmr_srv_flush_pool_md(srv_pool);
+
+	return 0;
+}
+
+static int process_msg_enable_pool(struct rmr_pool *pool, struct rmr_srv_sess *sess, bool sync,
+				   const struct rmr_msg_enable_pool_cmd *enable_pool_cmd)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	enum rmr_srv_pool_state old_state = atomic_read(&srv_pool->state);
+	int ret = 0;
+
+	/*
+	 * Enable/Disable messages from sync sessions do not affect us.
+	 */
+	if (sync) {
+		pr_info("%s: From sync sess %s, for pool %s\n", __func__, sess->sessname,
+			pool->poolname);
+		return 0;
+	}
+
+	pr_info("Client %s requests to set enable=%d pool %s current state %s\n",
+		sess->sessname, enable_pool_cmd->enable, pool->poolname,
+		rmr_get_srv_pool_state_name(old_state));
+
+	/*
+	 * Enable when not in maintenance mode, can be handled simply
+	 */
+	if (enable_pool_cmd->enable && !srv_pool->maintenance_mode) {
+		/*
+		 * CREATED -> NORMAL: initial enable after create-mode join.
+		 * NO_IO -> NORMAL: was_last_authoritative recovery (pserver
+		 * enables this node directly without a map update because its
+		 * dirty map is already authoritative).
+		 */
+		if (old_state != RMR_SRV_POOL_STATE_CREATED &&
+		    old_state != RMR_SRV_POOL_STATE_NO_IO) {
+			pr_err("%s: pool %s cannot be enabled in state %s\n",
+			       __func__, pool->poolname,
+			       rmr_get_srv_pool_state_name(old_state));
+			return -EINVAL;
+		}
+
+		ret = rmr_srv_set_pool_state_normal(srv_pool);
+		if (ret < 0)
+			goto out_err;
+
+		return 0;
+	}
+
+	/*
+	 * Any other case involves considering maintenance mode settings
+	 */
+	if (!enable_pool_cmd->enable) {
+		if (old_state != RMR_SRV_POOL_STATE_NORMAL &&
+		    old_state != RMR_SRV_POOL_STATE_NO_IO) {
+			pr_err("%s: pool %s can only disable from NORMAL or NO_IO state (current: %s)\n",
+			       __func__, pool->poolname,
+			       rmr_get_srv_pool_state_name(old_state));
+			return -EINVAL;
+		}
+		ret = rmr_srv_set_pool_mm(srv_pool);
+	} else {
+		ret = rmr_srv_unset_pool_mm(srv_pool);
+	}
+
+	if (ret < 0)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	/*
+	 * Put srv pool state to old one
+	 */
+	atomic_set(&srv_pool->state, old_state);
+	return ret;
+}
+
+/**
+ * process_msg_map_ready() - Process RMR_CMD_MAP_READY command
+ *
+ * @pool:		Pool which received the command
+ * @sync:		Whether the command was sent from an internal (sync) rmr-client or not
+ *
+ * Return:
+ *	0 on success
+ *	Negative errno on failure
+ *
+ * Description:
+ *	A RMR_CMD_MAP_READY command is the first command that is sent to a storage node which will
+ *	receive a map from another storage node as part of a map update.
+ *
+ *	It checks whether this storage node is ready and in an expected state to receive a map.
+ */
+static int process_msg_map_ready(struct rmr_pool *pool, bool sync)
+{
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_dirty_id_map *map;
+	int i, err = 0, pool_state;
+
+	mutex_lock(&srv_pool->srv_pool_lock);
+	pool_state = atomic_read(&srv_pool->state);
+
+	/* A map update from another storage node is not allowed. */
+	if (sync) {
+		pr_err("%s: (sync) Cannot receive map from other storage nodes\n", __func__);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * A map update from pserver should start only when in,
+	 * NO_IO - after a network/IO error
+	 * CREATED - For extend (This is not nice.
+	 *			 Extend should inform the storage node that it is being
+	 *			 used for an extend leg for an already existing node, and
+	 *			 the state should be set accordingly. So that we can allow
+	 *			 this only when in NO_IO state.)
+	 */
+	if (pool_state != RMR_SRV_POOL_STATE_NO_IO && pool_state != RMR_SRV_POOL_STATE_CREATED) {
+		pr_err("(non-sync) pool state not correct %d", pool_state);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * We seem to be in process of another map update.
+	 */
+	if (srv_pool->map_update_state != MAP_UPDATE_STATE_DISABLED) {
+		pr_err("rmr_srv_send_map Map update already in progress\n");
+		err = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * If pserver is instructing us to receive a map, then the map we
+	 * hold is meaningless.
+	 */
+	mutex_lock(&pool->maps_lock);
+	for (i = 0; i < RMR_POOL_MAX_SESS; i++) {
+		map = rcu_dereference_protected(pool->maps[i],
+						lockdep_is_held(&pool->maps_lock));
+		if (!map)
+			continue;
+
+		rmr_map_unset_dirty_all(map);
+	}
+	mutex_unlock(&pool->maps_lock);
+	rmr_srv_mark_maps_dirty(srv_pool);
+
+	srv_pool->map_update_state = MAP_UPDATE_STATE_READY;
+
+	pr_info("%s: process_msg_cmd: moved to MAP_UPDATE_STATE_READY\n", __func__);
+
+out:
+	mutex_unlock(&srv_pool->srv_pool_lock);
+	return err;
+}
+
+/**
+ * process_msg_cmd_handler() - Processes rmr command message
+ *
+ * @work:	scheduled work structure
+ *
+ * Description:
+ *	The command messages being processed here, can be broadly divided into 2 categories.
+ *	Ones which are able to use the rsp buffer to send back status.
+ *	Ones which cannot use the rsp buffer to send back status. These ones use the rsp buffer
+ *	for other purposes; like sending map data, or read user rsp buffer.
+ *
+ * Context:
+ *	Execution time depends on the command. It may take a long time for commands which sends
+ *	data (map).
+ */
+static void process_msg_cmd_handler(struct work_struct *work)
+{
+	struct rmr_cmd_work_info *work_info = container_of(work, struct rmr_cmd_work_info, cmd_work);
+	struct rmr_pool *pool = work_info->pool;
+	struct rmr_srv_pool *srv_pool = (struct rmr_srv_pool *)pool->priv;
+	struct rmr_srv_sess *sess = work_info->sess;
+	struct rtrs_srv_sess *rtrs = work_info->rtrs;
+	const struct rmr_msg_pool_cmd *cmd_msg = work_info->cmd_msg;
+	struct rmr_dirty_id_map *map;
+	u8 sync, flags;
+	u64 src_mapped_size;
+	int md_i, err = 0;
+
+	/*
+	 * The switch cases below are used by either map sending node,
+	 * or the node which is to receive the map, but not both.
+	 */
+	switch (cmd_msg->cmd_type) {
+	case RMR_CMD_REJOIN_POOL:
+		/*
+		 * For now, we do not have any difference between joinand
+		 * rejoin on the storage server side
+		 */
+	case RMR_CMD_JOIN_POOL:
+		/*
+		 * Server node, received a request for a new session
+		 */
+		err = process_msg_join_pool(pool, sess, rtrs, cmd_msg->sync,
+					    &cmd_msg->join_pool_cmd);
+		if (err) {
+			pr_err("process_msg_join_pool failed with err %d\n", err);
+			goto out;
+		}
+		work_info->rsp->join_pool_cmd_rsp.chunk_size = pool->chunk_size;
+
+		if (pool->mapped_size) {
+			work_info->rsp->join_pool_cmd_rsp.mapped_size = pool->mapped_size;
+			pr_info("srv pool %s sets mapped size %llu\n",
+			       pool->poolname, pool->mapped_size);
+		} else
+			work_info->rsp->join_pool_cmd_rsp.mapped_size = 0;
+
+		break;
+	case RMR_CMD_POOL_INFO:
+		/*
+		 * Server node, received pool info command
+		 */
+		err = process_msg_pool_info(pool, &cmd_msg->pool_info_cmd);
+		if (err) {
+			pr_err("process_msg_pool_info failed with err %d\n", err);
+			goto out;
+		}
+
+		break;
+	case RMR_CMD_LEAVE_POOL:
+		err = process_msg_leave_pool(pool, sess, cmd_msg->sync, &cmd_msg->leave_pool_cmd);
+		if (err) {
+			pr_err("process_msg_leave_pool failed with err %d\n", err);
+			goto out;
+		}
+
+		break;
+	case RMR_CMD_ENABLE_POOL:
+		err = process_msg_enable_pool(pool, sess, cmd_msg->sync, &cmd_msg->enable_pool_cmd);
+		if (err) {
+			pr_err("process_msg_enable_pool failed with err %d\n", err);
+			goto out;
+		}
+
+		break;
+	case RMR_CMD_MAP_READY:
+		/*
+		 * Map receiving node.
+		 * Getting ready to receive dirty map
+		 */
+		pr_info("%s: RMR_CMD_MAP_READY\n", __func__);
+
+		err = process_msg_map_ready(pool, cmd_msg->sync);
+		if (err) {
+			pr_err("process_msg_map_ready failed with err %d\n", err);
+			goto out;
+		}
+
+		break;
+	case RMR_CMD_MAP_SEND:
+		/*
+		 * Map sending node.
+		 * Send map to the node with member_id == map_send_cmd->receiver_member_id
+		 */
+		pr_info("%s: RMR_CMD_MAP_SEND\n", __func__);
+
+		err = rmr_clt_send_map(pool, srv_pool->clt, &cmd_msg->map_send_cmd, MAP_NO_FILTER);
+		if (err) {
+			pr_err("rmr_clt_send_map failed with err %d\n", err);
+			goto out;
+		}
+
+		break;
+	case RMR_CMD_SEND_MAP_BUF:
+		/*
+		 * Map receiving node.
+		 * Received the map from another node. Save it.
+		 */
+		pr_info("%s: RMR_CMD_SEND_MAP_BUF\n", __func__);
+
+		if (srv_pool->map_update_state != MAP_UPDATE_STATE_READY) {
+			pr_err("rmr_srv_send_map Node not ready to receive map\n");
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = rmr_pool_save_map(pool, work_info->data, work_info->datalen,
+					false);
+		if (err) {
+			if (!cmd_msg->sync)
+				rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_NO_IO);
+
+			pr_err("rmr_pool_save_map failed\n");
+			goto out;
+		}
+		break;
+	case RMR_CMD_MAP_BUF_DONE:
+		/*
+		 * Map receiving node.
+		 * A confirmation that all map updates have been sent.
+		 */
+		pr_info("%s: RMR_CMD_MAP_BUF_DONE\n", __func__);
+
+		if (srv_pool->map_update_state != MAP_UPDATE_STATE_READY) {
+			pr_err("rmr_srv_send_map Node state not correct\n");
+			err = -EINVAL;
+			goto out;
+		}
+
+		if (cmd_msg->map_buf_done_cmd.map_version < pool->map_ver) {
+			pr_err("Map version received (%llu) is older than ours (%llu)\n",
+			       cmd_msg->map_buf_done_cmd.map_version, pool->map_ver);
+			err = -EINVAL;
+			goto out;
+		}
+
+		pool->map_ver = cmd_msg->map_buf_done_cmd.map_version;
+		rmr_srv_mark_pool_md_dirty(srv_pool);
+
+		srv_pool->map_update_state = MAP_UPDATE_STATE_DONE;
+
+		break;
+	case RMR_CMD_MAP_DONE:
+		/*
+		 * Map receiving node.
+		 * A confirmation from the client, that map update was done successfully or not.
+		 */
+		pr_info("%s: RMR_CMD_MAP_DONE\n", __func__);
+
+		if (srv_pool->map_update_state != MAP_UPDATE_STATE_DONE) {
+			pr_err("rmr_srv_send_map Map not updated succesfully\n");
+			err = -EINVAL;
+		}
+
+		/*
+		 * On a successful map update, we go to NORMAL state.
+		 *
+		 * map_done_cmd.enable says whether this map update should make us go to
+		 * NORMAL state or not. This is controlled by the pserver.
+		 */
+		if (cmd_msg->map_done_cmd.enable) {
+			if (rmr_srv_set_pool_state_normal(srv_pool) < 0)
+				err = -EINVAL;
+		}
+
+		srv_pool->map_update_state = MAP_UPDATE_STATE_DISABLED;
+		break;
+	case RMR_CMD_MAP_DISABLE:
+		/*
+		 * Something went wrong on the client side; we need to reset everything.
+		 */
+		pr_info("%s: RMR_CMD_MAP_DISABLE\n", __func__);
+
+		if (!cmd_msg->sync)
+			rmr_srv_change_pool_state(srv_pool, RMR_SRV_POOL_STATE_NO_IO);
+
+		srv_pool->map_update_state = MAP_UPDATE_STATE_DISABLED;
+		break;
+	case RMR_CMD_READ_MAP_BUF:
+		/*
+		 * Pserver wants to read our dirty map. So send it.
+		 */
+		pr_info("%s: RMR_CMD_READ_MAP_BUF\n", __func__);
+
+		rmr_srv_read_map_buf(pool, work_info->data, work_info->datalen,
+				     &cmd_msg->map_buf_cmd);
+
+		goto out_no_rsp;
+	case RMR_CMD_MAP_CHECK:
+		pr_debug("%s: RMR_CMD_MAP_CHECK\n", __func__);
+
+		if (atomic_read(&srv_pool->state) != RMR_SRV_POOL_STATE_NORMAL) {
+			pr_debug("srv pool %s is not in normal state, cannot do map check\n",
+				pool->poolname);
+			work_info->rsp->value = false;
+			break;
+		}
+		map = rmr_pool_find_map(pool, srv_pool->member_id);
+		if (!map) {
+			pr_err("pool %s no map found for member_id %u\n",
+			       pool->poolname, srv_pool->member_id);
+			err = -EINVAL;
+			goto out;
+		}
+		work_info->rsp->value = rmr_map_empty(map);
+		pr_debug("pool %s member_id %d rsp with map_empty=%llu\n",
+			 pool->poolname, srv_pool->member_id,
+			 work_info->rsp->value);
+
+		break;
+
+	case RMR_CMD_LAST_IO_TO_MAP:
+		/*
+		 * Use the last_io list, and add those IOs as dirty IDs to the map
+		 * for every other storage server other than this one.
+		 */
+		pr_info("%s: RMR_CMD_LAST_IO_TO_MAP\n", __func__);
+		err = rmr_srv_save_last_io_to_map(pool);
+		if (err) {
+			pr_err("rmr_srv_save_last_io_to_map failed\n");
+			goto out;
+		}
+
+		break;
+
+	case RMR_CMD_MAP_TEST:
+		/*
+		 * Received the map test from another node.
+		 * Check that we have everything that other node has.
+		 */
+		pr_info("%s: RMR_CMD_MAP_TEST\n", __func__);
+
+		err = rmr_pool_save_map(pool, work_info->data, work_info->datalen, true);
+		if (err) {
+			pr_err("rmr_srv_save_map failed, test_only, err %d\n", err);
+		}
+		goto out_no_rsp;
+	case RMR_CMD_MD_SEND:
+		/*
+		 * Received the message to copy metadata of server pool to the sender.
+		 */
+		src_mapped_size = cmd_msg->md_send_cmd.src_mapped_size;
+		pr_debug("stg %u: receives md_update message from pool %u\n",
+			 srv_pool->member_id, cmd_msg->md_send_cmd.leader_id);
+
+		/* Check the pool mapped_sizes are consistent or not */
+		if (pool->mapped_size && src_mapped_size && pool->mapped_size != src_mapped_size) {
+			pr_err_ratelimited("This %s mapped_size %llu != src %d mapped_size %llu\n",
+			       pool->poolname, pool->mapped_size, cmd_msg->md_send_cmd.leader_id,
+			       src_mapped_size);
+			goto out;
+		}
+
+		if (cmd_msg->md_send_cmd.read_full_md) {
+			if (work_info->datalen < sizeof(struct rmr_pool_md)) {
+				pr_err("%s: buffer too small for full pool_md (%zu < %zu)\n",
+				       __func__, work_info->datalen,
+				       sizeof(struct rmr_pool_md));
+				err = -EINVAL;
+				goto out;
+			}
+			memcpy(work_info->data, &pool->pool_md, sizeof(struct rmr_pool_md));
+		} else {
+			/* If updating buf incurs error, it simply waits for next md_update. */
+			rmr_srv_update_md_buf(srv_pool, work_info->data, work_info->datalen);
+		}
+
+		break;
+	case RMR_CMD_SEND_MD_BUF:
+		/*
+		 * Received the client pool metadata. Save it.
+		 */
+		sync = cmd_msg->send_md_buf_cmd.sync;
+		flags = cmd_msg->send_md_buf_cmd.flags;
+		if (flags == RMR_OP_MD_WRITE) {
+			err = rmr_srv_md_process_buf(pool, work_info->data, sync);
+			if (err) {
+				pr_err("rmr_srv_write_md failed\n");
+				goto out;
+			}
+
+			if (atomic_read(&srv_pool->store_state)) {
+				/* write back to disk */
+				err = process_md_io(pool, NULL, 0, work_info->datalen, flags,
+						    &pool->pool_md);
+				if (err) {
+					pr_err("Failed to process md io\n");
+					goto out;
+				}
+			}
+		}
+
+		if (!sync && flags == RMR_OP_MD_READ)
+			memcpy(work_info->data, &pool->pool_md, sizeof(struct rmr_pool_md));
+
+		break;
+	case RMR_CMD_SEND_DISCARD:
+		/* Received the message to handle discards. */
+		pr_info("%s: RMR_CMD_SEND_DISCARD for srv %u\n",
+			__func__, cmd_msg->send_discard_cmd.member_id);
+		if (!cmd_msg->sync) {
+			err = rmr_pool_md_check_discard(pool, cmd_msg->send_discard_cmd.member_id);
+			if (err > 0) {
+				/* This node has received discards. */
+				err = 0;
+				pr_info("pool %s member_id %d has received discards\n",
+					pool->poolname, srv_pool->member_id);
+				goto out;
+			}
+		}
+
+		/*
+		 * For sync requests, even if the server that is not in normal state has received
+		 * the discard request, its dirty map is still outdated. However, non-sync
+		 * requests can overlook this check and proceed discarding directly.
+		 */
+		if (cmd_msg->sync && atomic_read(&srv_pool->state) != RMR_SRV_POOL_STATE_NORMAL){
+			pr_err("srv pool %s not in normal state for sync discard request\n",
+				pool->poolname);
+			err = -EINVAL;
+			goto out;
+		}
+
+		err = rmr_srv_discard_id(pool, 0, 0, cmd_msg->send_discard_cmd.member_id,
+				cmd_msg->sync);
+		if (err)
+			pr_err("Failed to discard id\n");
+
+		break;
+	case RMR_CMD_STORE_CHECK:
+		pr_debug("%s: RMR_CMD_STORE_CHECK\n", __func__);
+
+		work_info->rsp->value = rmr_srv_pool_check_store(pool);
+		pr_debug("pool %s member_id %d rsp with value=%llu\n",
+			 pool->poolname, srv_pool->member_id,
+			 work_info->rsp->value);
+
+		break;
+	case RMR_CMD_MAP_GET_VER:
+		pr_debug("%s: RMR_CMD_MAP_GET_VER\n", __func__);
+
+		work_info->rsp->value = pool->map_ver;
+		pr_debug("pool %s member_id %d rsp with value=%llu\n",
+			 pool->poolname, srv_pool->member_id,
+			 work_info->rsp->value);
+
+		break;
+	case RMR_CMD_MAP_SET_VER:
+		pr_debug("%s: RMR_CMD_MAP_SET_VER\n", __func__);
+
+		pool->map_ver = work_info->cmd_msg->set_map_ver_cmd.map_ver;
+		rmr_srv_mark_pool_md_dirty(srv_pool);
+		break;
+	case RMR_CMD_DISCARD_CLEAR_FLAG:
+		pr_info("%s: RMR_CMD_DISCARD_CLEAR_FLAG\n", __func__);
+
+		md_i = rmr_pool_find_md(&pool->pool_md, cmd_msg->send_discard_cmd.member_id, false);
+		if (md_i < 0) {
+			pr_info("Didn't find md for member_id %u\n",
+				cmd_msg->send_discard_cmd.member_id);
+			goto out;
+		}
+
+		pool->pool_md.srv_md[md_i].discard_entries = false;
+		rmr_srv_flush_pool_md(srv_pool);
+		break;
+	case RMR_CMD_USER:
+		pr_debug("%s: RMR_CMD_USER\n", __func__);
+
+		err = process_msg_user_cmd(srv_pool, cmd_msg, work_info->data, work_info->datalen);
+		if (err) {
+			pr_err("process_msg_user_cmd failed with err %d\n", err);
+			goto out_no_rsp;
+		}
+
+		goto out_no_rsp;
+	default:
+		pr_warn("%s: switch default type: %d\n", __func__, cmd_msg->cmd_type);
+
+		err = -EINVAL;
+	}
+
+out:
+	work_info->rsp->err = err;
+	work_info->rsp->member_id = srv_pool->member_id;
+	work_info->rsp->cmd_type = cmd_msg->cmd_type;
+
+out_no_rsp:
+	// Should we return err in rdma_resp ?
+	pr_debug("send rtrs completion from msg_cmd_handler, err:%d\n", err);
+	rtrs_srv_resp_rdma(work_info->rtrs_op, err);
+
+	rmr_put_srv_pool(srv_pool);
+	kfree(work_info);
+}
+
+static int schedule_process_msg_cmd(struct rmr_srv_sess *srv_sess,
+				    struct rtrs_srv_op *rtrs_op,
+				    void *data, size_t datalen,
+				    const void *msg, size_t len)
+{
+	struct rmr_srv_pool *srv_pool;
+	const struct rmr_msg_pool_cmd *cmd_msg = msg;
+	const char *poolname = cmd_msg->pool_name;
+	struct rmr_cmd_work_info *work_info;
+	u32 group_id = le32_to_cpu(cmd_msg->hdr.group_id);
+
+	pr_debug("pool %s received cmd %d\n",
+		 poolname, cmd_msg->cmd_type);
+
+	srv_pool = rmr_find_and_get_srv_pool(group_id);
+	if (IS_ERR(srv_pool)) {
+		pr_err("Cmd %s: pool %s does not exists: %pe\n",
+                        rmr_get_cmd_name(cmd_msg->cmd_type), poolname, srv_pool);
+		return PTR_ERR(srv_pool);
+	}
+
+	pr_debug("process_msg_cmd: pool %s found\n", poolname);
+
+	work_info = kzalloc(sizeof(struct rmr_cmd_work_info), GFP_KERNEL);
+	if (!work_info) {
+		pr_err("failed to allocate work info to send map\n");
+		rmr_put_srv_pool(srv_pool);
+		return -ENOMEM;
+	}
+	work_info->pool = srv_pool->pool;
+	work_info->sess = srv_sess;
+	work_info->rtrs = srv_sess->rtrs;
+	work_info->rtrs_op = rtrs_op;
+	work_info->cmd_msg = cmd_msg;
+	work_info->rsp = data;
+	work_info->data = data;
+	work_info->datalen = datalen;
+
+	INIT_WORK(&work_info->cmd_work, process_msg_cmd_handler);
+	schedule_work(&work_info->cmd_work);
+
+	return 0;
+}
+
+static int rmr_srv_rdma_ev(void *priv, struct rtrs_srv_op *id,
+			   void *data, size_t datalen,
+			   const void *usr, size_t usrlen)
+{
+	struct rmr_srv_sess *srv_sess = priv;
+	const struct rmr_msg_hdr *hdr = usr;
+	int ret = 0;
+	u16 type;
+
+	if (unlikely(WARN_ON(!srv_sess)))
+		return -ENODEV;
+
+	type = le16_to_cpu(hdr->type);
+
+	switch (type) {
+	case RMR_MSG_IO:
+		return process_msg_io(srv_sess, id, data, datalen,
+				      usr, usrlen);
+	case RMR_MSG_MAP_CLEAR:
+		ret = process_msg_map_clear(srv_sess, usr);
+		break;
+	case RMR_MSG_MAP_ADD:
+		ret = process_msg_map_add(srv_sess, usr);
+		break;
+	case RMR_MSG_CMD:
+		return schedule_process_msg_cmd(srv_sess, id, data, datalen,
+						usr, usrlen);
+	default:
+		pr_warn("Received unexpected message type %d from session %s\n",
+			type, srv_sess->sessname);
+		return -EINVAL;
+	}
+
+	rtrs_srv_resp_rdma(id, ret);
+
+	return 0;
+}
+
+/**
+ * rmr_srv_check_params() - Check the parameters of the storage node
+ *
+ * @srv_pool:	The rmr srv pool to check parameters for
+ *
+ * Description:
+ *	Checks the device params with other connected server nodes.
+ *
+ * Return:
+ *	0 on success.
+ *	-Negative error code on failure.
+ */
+int rmr_srv_check_params(struct rmr_srv_pool *srv_pool)
+{
+	void *dev;
+	int err;
+
+	/* If the store has not been added to this server pool, ignore device param checks. */
+	if (!srv_pool->io_store)
+		return 0;
+
+	dev = srv_pool->io_store->priv;
+	err = srv_pool->io_store->ops->get_params(dev);
+	if (err) {
+		pr_err("%s: store get_params failed for pool %s, err %d\n",
+		       __func__, srv_pool->pool->poolname, err);
+		return err;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(rmr_srv_check_params);
+
+static struct rtrs_srv_ops rtrs_ops;
+static int __init rmr_srv_init_module(void)
+{
+	int err;
+
+	if (!is_power_of_2(chunk_size) ||
+	    chunk_size < MIN_CHUNK_SIZE || chunk_size > MAX_CHUNK_SIZE) {
+		pr_err("Loading module %s failed. Invalid chunk_size %u\n",
+			KBUILD_MODNAME, chunk_size);
+		pr_err("Chunk size should be a power of 2, and between (min %u - max %u)\n",
+			MIN_CHUNK_SIZE, MAX_CHUNK_SIZE);
+		return -EINVAL;
+	}
+
+	pr_info("Loading module %s, version %s, proto %s, chunk_size %u\n",
+		KBUILD_MODNAME, RMR_VER_STRING, RMR_PROTO_VER_STRING, chunk_size);
+
+	rtrs_ops = (struct rtrs_srv_ops){
+		.rdma_ev = rmr_srv_rdma_ev,
+		.link_ev = rmr_srv_link_ev,
+	};
+
+	rmr_req_cachep = kmem_cache_create("rmr_req_cachep", sizeof(struct rmr_srv_req),
+					   0, 0, NULL);
+	if (!rmr_req_cachep) {
+		pr_err("can not allocagte cachep for rmr_req\n");
+		err = -ENOMEM;
+		goto out;
+	}
+	rmr_map_entry_cachep = kmem_cache_create("rmr_map_entry_cachep",
+						 sizeof(struct rmr_map_entry),
+						 0, 0, NULL);
+	if (!rmr_map_entry_cachep) {
+		pr_err("can not allocagte cachep for rmr_map_entry\n");
+		err = -ENOMEM;
+		goto req_destroy;
+	}
+
+	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct rmr_map_cbuf_hdr) < RMR_POOL_MAX_SESS);
+
+	rtrs_ctx = rtrs_srv_open(&rtrs_ops, RTRS_PORT);
+	if (IS_ERR(rtrs_ctx)) {
+		err = PTR_ERR(rtrs_ctx);
+		pr_err("rtrs_srv_open(), err: %pe\n", rtrs_ctx);
+		goto map_destroy;
+	}
+
+	err = rmr_srv_create_sysfs_files();
+	if (err) {
+		pr_err("rmr_srv_create_sysfs_files(), err: %d\n", err);
+		goto srv_close;
+	}
+
+	return 0;
+
+srv_close:
+	rtrs_srv_close(rtrs_ctx);
+map_destroy:
+	kmem_cache_destroy(rmr_map_entry_cachep);
+req_destroy:
+	kmem_cache_destroy(rmr_req_cachep);
+out:
+	return err;
+}
+
+static void __exit rmr_srv_cleanup_module(void)
+{
+	struct rmr_pool *pool, *tmp;
+	struct rmr_srv_pool *srv_pool;
+
+	pr_info("Unloading module\n");
+	kmem_cache_destroy(rmr_req_cachep);
+
+	rtrs_srv_close(rtrs_ctx);
+
+	list_for_each_entry_safe (pool, tmp, &pool_list, entry) {
+		srv_pool = (struct rmr_srv_pool *)pool->priv;
+
+		WARN_ON(!list_empty(&pool->sess_list));
+		rmr_srv_destroy_pool(pool);
+		rmr_srv_destroy_pool_sysfs_files(pool, NULL);
+		rmr_put_srv_pool(srv_pool);
+	}
+
+	rmr_srv_destroy_sysfs_files();
+	pr_info("Module unloaded\n");
+}
+
+module_init(rmr_srv_init_module);
+module_exit(rmr_srv_cleanup_module);
-- 
2.43.0


