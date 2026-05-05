Return-Path: <linux-rdma+bounces-19997-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EDBCUuh+WnR+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19997-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:50:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED24C840B
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1C7730314DC
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2CD3EF644;
	Tue,  5 May 2026 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ghi+ViM/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503D93EDABB
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967254; cv=none; b=ahIUfnXNicxC/rLB+yhogmnGv6UYeqcHBNQ/xQB0WAVo6HEQaLL2AaCSMOPXvNfp92o5neCIRXH9mGZdmcVm+fKCnr4S/QzIRqWo4ZImILI51m5WLsLh6mLgTVFKWd34gJjxCu7v79qKYADci0FbWS+JfzwXf/AVnIyE+0WLkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967254; c=relaxed/simple;
	bh=8n0l/bUnaMA0EYN+UIYz45PGBhBd2D3KWmKjrBLvKLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cclXcBRBnD/jTzk/scabjExpweDPVoGBZzJTdChaN3AfxDpO6VJDN7NZ8bR0JahfbvGPLMm9ZrjQYz4BlxSuj0iwUBZrDQ/H1xlvpbuMHWcjHrHvVmE0SIb7Nyd7HmXivAhhXp/BEfoZM6jKLnxVuPwan33zW8Z5pdY0Lim6s20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ghi+ViM/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48d146705b4so7318295e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967249; x=1778572049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqmsk1g8ujkKXKALjteSQ/EE9ffYcF82KWss1m7sDrc=;
        b=Ghi+ViM/+8gdcDG1ePXxqXS56h5IJ4brZrbYybUEAXKM4ioa+5R+vqropeYI0QswJp
         /DCezY0mjAM9ZPl/bFahUjJNeuAue4uoy59cE7OOWxEpZcUhxucMi1Ksf5XyUYspx7kJ
         GWcwIWx8jUjOT63h2m3d268uXJjTnb0Aq/fZ01PuKKmNhrMbKj5m68CxwbA/YBWDyCpk
         pv5LABLiKo/xVVVhsPvvSrh/PNHn4MHiSZGYbAaH0R7WrUO+9rCU5XiHx/FTQI/+LmWI
         qo8Q2plQdVfSagE4o+f7XVpRxyqoNSIwkjDP6SLTap7XpZQPAVEIJp5SZ8+bmG8VfDCM
         zN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967249; x=1778572049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bqmsk1g8ujkKXKALjteSQ/EE9ffYcF82KWss1m7sDrc=;
        b=GYy7bhvQY50RdoaYhCXMMA4EjhN82dhSSWmu+dkeq18zva/eOPt30sl/meZMYilAXd
         n7DwVbseEyyd+RfHKGRcA28ByvnSfssGqagFS4hlcp5YwQ9WUObilWQVUPds8xotMyHl
         quzyaH45JGWOZY1j/UG8yiSWgjFB1usRLOn/TcYT3ZsrJkBjmcbUCwzR6cAy+4hAUfP6
         OGfRtu9U7kwoaz1OCvJhs+M9p/jznXL+dnm2iqMlgUqXC+d2Umezklz+jc5A0Qh7tYjm
         FIOMN820TO3D5F5eRF3h8/x3cjVNTfoXfcZe0IdUWYU2LXd2r8jjcsXFbnE7tGre2+Q6
         15LQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DLF2oc0gYUthpwL+MR1rlWIQIENXaJYAE5cu1HISaGB6Ke+Z39eb9pCC10ptOeIm3KMEESK1zdtk1@vger.kernel.org
X-Gm-Message-State: AOJu0YywiLovpHtvDya0GS+9bnPmvKDbnqofI8IGmoGJRCrA7Z4+D/s4
	HTYZz1wIW6G5vbQ+0uu3EMNYYDQp1JOxkEv9MUuymze2ec/2SyMOw7qubjR0Xjf4wLs=
X-Gm-Gg: AeBDiev2Q9bB8HFOWrg1ucp1u71zXN/YpqKMyrRp2/neGhp6xfOsTHauBLT5iJl08Ih
	LDw6QmCmggjFYeBEMTAO9hCkiO5riF9nKiveg/g0po7VUcyQ6+m2BClO5yMX9T9dOPDQMW2BIrd
	pylYxcZvhmnOxJkc2VMdHj4Y883jUPJLiKVL2hQyMe/vFI4VfwCXuDuKHgwv41/J6XOSMHLa7Mf
	PNUKaTDHtWxNqEJD9bMi8jQCq4j/ipdQ9YT3cK8iNx5uBJCYUAqmpO8VEpMZhErGF2hoXF50bzg
	GW1HTJswZoGi2vcSHZ4y2XlKrWsvfkkcNz8o/ybYbYS5tItTqxQKeEXx0cMT2F3PQppOF/2lPe5
	MFBwZT3lCV86wxiLDFdAgcHLFfNvjNTA3Fkz6HumkICuSv9qOW/y1AZWvpq6B5bhvmXjaqj07/b
	iByPkZYMNNcOUZ22D0iAopW5qKcXuOCEuaJsOL+1WRoac+oSHQqspRj/bTsm3fpZ+sr6yGFwxEo
	/B4LVp1DuPW0yeVUPQ8BIs4YhFVxr5ly0tKUjuucGcnXQ==
X-Received: by 2002:a05:600c:3e14:b0:48a:568f:ae6b with SMTP id 5b1f17b1804b1-48d187d9723mr30418965e9.7.1777967248572;
        Tue, 05 May 2026 00:47:28 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:28 -0700 (PDT)
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
Subject: [PATCH 08/13] block/brmr: add private headers with brmr protocol structs and helpers
Date: Tue,  5 May 2026 09:46:20 +0200
Message-ID: <20260505074644.195453-9-haris.iqbal@ionos.com>
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
X-Rspamd-Queue-Id: D7ED24C840B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19997-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ionos.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

Block device over RMR (BRMR) is an upper-layer block driver that
sits on top of the RMR ULP and exposes a standard Linux block device
(/dev/brmrX) backed by an RMR pool.

Add the BRMR private headers:

  brmr-proto.h	wire-protocol structs exchanged between client and
		server outside of the rmr-clt/rmr-srv command channel.
  brmr-clt.h	client-side data structures: per-pool tag set, per-CPU
		requeue queues, per-device statistics and gendisk state.
  brmr-srv.h	server-side data structures: brmr_srv_blk_dev backing
		store description, on-disk metadata header layout and
		state-bit helpers.

These files are not compiled until the modules are wired into the
build in a later patch in this series.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/block/brmr/brmr-clt.h   | 299 ++++++++++++++++++++++++++++++++
 drivers/block/brmr/brmr-proto.h | 121 +++++++++++++
 drivers/block/brmr/brmr-srv.h   | 133 ++++++++++++++
 3 files changed, 553 insertions(+)
 create mode 100644 drivers/block/brmr/brmr-clt.h
 create mode 100644 drivers/block/brmr/brmr-proto.h
 create mode 100644 drivers/block/brmr/brmr-srv.h

diff --git a/drivers/block/brmr/brmr-clt.h b/drivers/block/brmr/brmr-clt.h
new file mode 100644
index 000000000000..1482c7517ee8
--- /dev/null
+++ b/drivers/block/brmr/brmr-clt.h
@@ -0,0 +1,299 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Block device over RMR (BRMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#ifndef BRMR_PRI_H
+#define BRMR_PRI_H
+
+#include <linux/limits.h>
+#include <linux/blk-mq.h>
+#include "rmr-pool.h"
+
+#include "brmr-proto.h"
+
+#define BRMR_VER_MAJOR 0
+#define BRMR_VER_MINOR 1
+
+#ifndef BRMR_VER_STRING
+#define BRMR_VER_STRING __stringify(BRMR_VER_MAJOR) "." \
+			 __stringify(BRMR_VER_MINOR)
+#endif
+
+#define BRMR_LINK_NAME "block"
+
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
+#define BRMR_INLINE_SG_CNT 0
+#else
+#define BRMR_INLINE_SG_CNT 2
+#endif
+#define BRMR_RDMA_SGL_SIZE (sizeof(struct scatterlist) * BRMR_INLINE_SG_CNT)
+
+enum brmr_dev_state {
+	DEV_STATE_INIT,
+	DEV_STATE_READY,
+	DEV_STATE_DISCONNECTED,
+	DEV_STATE_CLOSING,
+};
+
+struct brmr_clt_iu {
+	struct request		*rq;
+	struct rmr_iu		*rmr_iu;
+	struct brmr_clt_dev	*dev;
+	blk_status_t		status;
+	struct sg_table		sgt;
+	struct scatterlist	sgl[];
+};
+
+struct brmr_queue {
+	struct list_head	requeue_list;
+	unsigned long		in_list;
+	struct blk_mq_hw_ctx	*hctx;
+};
+
+struct brmr_cpu_qlist {
+	struct list_head	requeue_list;
+	spinlock_t		requeue_lock;
+	unsigned int		cpu;
+};
+
+struct brmr_clt_pool {
+	struct list_head        list;
+	struct rmr_pool         *rmr;
+	wait_queue_head_t       rmr_waitq;
+	bool                    rmr_ready;
+	int			queue_depth;
+	u32			max_io_size;
+	u32			chunk_size;
+	u32			max_segments;
+	struct brmr_cpu_qlist __percpu
+				*cpu_queues;
+	DECLARE_BITMAP(cpu_queues_bm, NR_CPUS);
+	int	__percpu	*cpu_rr; /* per-cpu var for CPU round-robin */
+	atomic_t	     	busy;
+	struct blk_mq_tag_set	tag_set;
+	struct mutex		lock; /* protects state and devs_list */
+	struct list_head        devs_list; /* list of struct brmr_clt_dev */
+	refcount_t		refcount;
+	char			poolname[NAME_MAX];
+};
+
+/**
+ * Statistic of requests submitted to the rmr-clt layer.
+ * This means total number of requests received from blk
+ * is cnt_whole+(cnt_split/2)
+ * while total number submitted to rmr-clt is cnt_whole+cnt_split
+ */
+struct brmr_stats_rq {
+	struct {
+		u64 cnt_whole;
+		u64 cnt_split;
+		u64 total_sectors;
+	} dir[2];
+};
+
+#define STATS_SIZES_NUM 16
+
+struct brmr_stats_sizes {
+	struct {
+		u64 cnt_whole[STATS_SIZES_NUM];
+		u64 cnt_left[STATS_SIZES_NUM];
+		u64 cnt_right[STATS_SIZES_NUM];
+	} dir[2];
+};
+
+struct brmr_stats_sts_resource {
+	u64 get_iu;
+	u64 get_iu2;
+	u64 clt_request1;
+	u64 clt_request;
+};
+
+struct brmr_stats_pcpu {
+
+	struct brmr_stats_rq submitted_requests;
+	struct brmr_stats_sizes request_sizes;
+	struct brmr_stats_sts_resource sts_resource;
+};
+
+struct brmr_clt_stats {
+	struct brmr_stats_pcpu __percpu *pcpu_stats;
+};
+
+struct brmr_clt_dev {
+	struct brmr_clt_pool	*pool;
+	struct request_queue	*queue;
+	struct brmr_queue	*hw_queues;
+	u32			idx;
+	enum brmr_dev_state	dev_state;
+	bool			read_only;
+	bool			map_incomplete;
+	u64			size_sect;	/* device size in sectors */
+	struct list_head        list;
+	struct brmr_clt_stats	stats;
+	struct gendisk		*gd;
+	struct kobject		kobj;
+	struct kobject		kobj_stats;
+	char			blk_symlink_name[NAME_MAX];
+	refcount_t		refcount;
+	struct work_struct	unmap_on_rmmod_work;
+	bool			wc;
+	bool			fua;
+
+	/*
+	 * Params holding block device related info
+	 */
+	u32	max_hw_sectors;
+	u32	max_write_zeroes_sectors;
+	u32	max_discard_sectors;
+	u32	discard_granularity;
+	u32	discard_alignment;
+	u16	physical_block_size;
+	u16	logical_block_size;
+	u16	max_segments;
+	u16	secure_discard;
+	u8	cache_policy;
+};
+
+#define BRMR_HEADER_MAGIC_TOKEN 0x312631494f4e4f53
+
+#define BRMR_HEADER_VERSION_INITIAL 1
+#define BRMR_CURRENT_HEADER_VERSION BRMR_HEADER_VERSION_INITIAL
+
+static inline enum rmr_io_flags rq_to_rmr_flags(struct request *rq)
+{
+	enum rmr_io_flags rmr_flag;
+
+	switch (req_op(rq)) {
+	case REQ_OP_READ:
+		rmr_flag = RMR_OP_READ;
+		break;
+	case REQ_OP_WRITE:
+		rmr_flag = RMR_OP_WRITE;
+		break;
+	case REQ_OP_DISCARD:
+		rmr_flag = RMR_OP_DISCARD;
+		break;
+	case REQ_OP_WRITE_ZEROES:
+		rmr_flag = RMR_OP_WRITE_ZEROES;
+		break;
+	case REQ_OP_FLUSH:
+		rmr_flag = RMR_OP_FLUSH;
+		break;
+/* TODO
+	case REQ_OP_SECURE_ERASE:
+		rmr_flag = IBNBD_OP_SECURE_ERASE;
+		break;
+*/
+	default:
+		WARN(1, "Unknown request type %d (flags %u)\n",
+		     req_op(rq), rq->cmd_flags);
+		rmr_flag = 0;
+	}
+
+	/* Set sync flag for write request. */
+	if (op_is_sync(rq->cmd_flags))
+		rmr_flag |= RMR_F_SYNC;
+
+	if (op_is_flush(rq->cmd_flags))
+		rmr_flag |= RMR_F_FUA;
+
+	return rmr_flag;
+}
+
+static inline u32 brmr_pool_chunk_size(struct brmr_clt_pool *pool)
+{
+	return pool->chunk_size;
+}
+
+struct brmr_clt_dev *brmr_clt_map_device(const char *pool, u64 size);
+int brmr_clt_close_device(struct brmr_clt_dev *dev, const struct attribute *sysfs_self);
+
+void brmr_clt_put_dev(struct brmr_clt_dev *dev);
+
+struct brmr_clt_dev *find_and_get_device(const char *name);
+
+/* brmr-sysfs.c */
+
+int brmr_clt_create_sysfs_files(void);
+void brmr_clt_destroy_sysfs_files(void);
+
+void brmr_clt_destroy_dev_sysfs_files(struct brmr_clt_dev *dev,
+				      const struct attribute *sysfs_self);
+
+/* brmr-reque.c */
+
+bool brmr_add_to_requeue(struct brmr_clt_pool *pool, struct brmr_queue *q);
+void brmr_requeue_requests(struct brmr_clt_pool *pool);
+void brmr_init_cpu_qlists(struct brmr_cpu_qlist __percpu *cpu_queues);
+
+/* brmr-stats.c */
+
+int brmr_clt_init_stats(struct brmr_clt_stats *stats);
+void brmr_clt_free_stats(struct brmr_clt_stats *stats);
+
+int brmr_clt_reset_submitted_req(struct brmr_clt_stats *stats, bool enable);
+int brmr_clt_reset_req_sizes(struct brmr_clt_stats *stats, bool enable);
+int brmr_clt_reset_sts_resource(struct brmr_clt_stats *stats, bool enable);
+
+/**
+ * size: size of the request submitted in bytes
+ * split: 0 when request from blk is submitted to rmr-clt as 1
+ * 1 if it is one part of the split from a blk request
+ */
+void brmr_update_stats(struct brmr_clt_stats *stats, size_t size, int split, int d);
+
+/**
+ * which: at which place is BLK_STS_RESOURCE returned?
+ */
+void brmr_clt_update_sts_resource(struct brmr_clt_stats *stats, int which);
+
+ssize_t brmr_clt_stats_sizes_to_str(struct brmr_clt_stats *stats, char *page, size_t len);
+
+ssize_t brmr_clt_stats_rq_to_str(struct brmr_clt_stats *stats, char *page, size_t len);
+
+ssize_t brmr_stats_sts_resource_to_str(
+	struct brmr_clt_stats *stats, char *page, size_t len);
+
+ssize_t brmr_stats_sts_resource_per_cpu_to_str(
+	struct brmr_clt_stats *stats, char *page, size_t len);
+
+#define STAT_STORE_FUNC(type, store, reset)				\
+static ssize_t store##_store(struct kobject *kobj,			\
+			     struct kobj_attribute *attr,		\
+			     const char *buf, size_t count)		\
+{									\
+	int ret = -EINVAL;						\
+	type *dev = container_of(kobj, type, kobj_stats);		\
+									\
+	if (sysfs_streq(buf, "1"))					\
+		ret = reset(&dev->stats, true);				\
+	else if (sysfs_streq(buf, "0"))					\
+		ret = reset(&dev->stats, false);			\
+	if (ret)							\
+		return ret;						\
+									\
+	return count;							\
+}
+
+#define STAT_SHOW_FUNC(type, show, print)				\
+static ssize_t show##_show(struct kobject *kobj,			\
+			   struct kobj_attribute *attr,			\
+			   char *page)					\
+{									\
+	type *dev = container_of(kobj, type, kobj_stats);		\
+									\
+	return print(&dev->stats, page, PAGE_SIZE);			\
+}
+
+#define STAT_ATTR(type, stat, print, reset)				\
+STAT_STORE_FUNC(type, stat, reset)					\
+STAT_SHOW_FUNC(type, stat, print)					\
+static struct kobj_attribute stat##_attr =				\
+		__ATTR(stat, 0644,					\
+		       stat##_show,					\
+		       stat##_store)
+
+#endif /* BRMR_PRI_H */
diff --git a/drivers/block/brmr/brmr-proto.h b/drivers/block/brmr/brmr-proto.h
new file mode 100644
index 000000000000..c5f0f25a5eb7
--- /dev/null
+++ b/drivers/block/brmr/brmr-proto.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Block device over RMR (BRMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#define BRMR_PROTO_VER_MAJOR 0
+#define BRMR_PROTO_VER_MINOR 1
+
+#define BRMR_CMD_RSP_MAGIC 0xDEADF00D
+
+struct brmr_blk_dev_params {
+	/*
+	 * Params holding block device related info
+	 */
+	__le32 max_hw_sectors;
+	__le32 max_write_zeroes_sectors;
+	__le32 max_discard_sectors;
+	__le32 discard_granularity;
+	__le32 discard_alignment;
+	__le16 physical_block_size;
+	__le16 logical_block_size;
+	__le16 max_segments;
+	__le16 secure_discard;
+	u8 cache_policy;
+};
+
+enum brmr_msg_type {
+	BRMR_MSG_IO,
+	BRMR_MSG_CMD,
+};
+
+struct brmr_msg_hdr {
+	__le16	type;
+	__le16	__padding;
+};
+
+enum brmr_msg_cmd_type {
+	BRMR_CMD_MAP, // 0
+	BRMR_CMD_REMAP,
+
+	BRMR_CMD_UNMAP,
+	BRMR_CMD_GET_PARAMS,
+
+	/*
+	 * Add new command types above this.
+	 */
+	BRMR_CMD_RSP,
+};
+
+struct brmr_msg_map_new_cmd {
+	struct brmr_blk_dev_params dev_params;
+
+	u32 version; /* version of the header itself */
+	u64 mapped_size; /* size in 512 byte blocks of this device */
+};
+
+struct brmr_msg_cmd {
+	struct brmr_msg_hdr	hdr;
+	u8			ver;
+	u8			cmd_type;
+	u8			rsvd[2];
+	union {
+		struct brmr_msg_map_new_cmd map_new_cmd;
+		/* May be other command(s) later */
+	};
+};
+
+/**
+ * struct brmr_cmd_get_params_rsp - response message to BRMR_CMD_GET_PARAMS
+ * @hdr:			message header
+ * @nsectors:			number of sectors in the usual 512b unit
+ * @max_hw_sectors:		max hardware sectors in the usual 512b unit
+ * @max_write_zeroes_sectors:	max sectors for WRITE ZEROES in the 512b unit
+ * @max_discard_sectors:	max. sectors that can be discarded at once in 512b
+ * unit.
+ * @discard_granularity:	size of the internal discard allocation unit in bytes
+ * @discard_alignment:		offset from internal allocation assignment in bytes
+ * @physical_block_size:	physical block size device supports in bytes
+ * @logical_block_size:		logical block size device supports in bytes
+ * @max_segments:		max segments hardware support in one transfer
+ * @secure_discard:		supports secure discard
+ * @cache_policy:		support write-back caching or FUA?
+ */
+struct brmr_cmd_get_params_rsp {
+	struct brmr_blk_dev_params dev_params;
+
+	/*
+	 * Params holding brmr device related info
+	 */
+	u8	mapped;
+	__le64	mapped_size;
+};
+
+struct brmr_msg_cmd_rsp {
+	struct brmr_msg_hdr	hdr;
+	u64			magic;
+	u8			ver;
+	u8			cmd_type;
+	u8			status;
+	u8			rsvd[1];
+	union {
+		struct brmr_cmd_get_params_rsp get_params_rsp;
+		//any other command responces.
+	};
+};
+
+struct brmr_cmd_priv {
+	void			*dev;
+	u8			cmd_type;
+	void			*rsp_buf;
+	size_t			rsp_buf_len;
+	int			errno;
+	struct completion	complete_done;
+};
+
+enum brmr_cache_policy {
+	BRMR_FUA = 1 << 0,
+	BRMR_WRITEBACK = 1 << 1,
+};
diff --git a/drivers/block/brmr/brmr-srv.h b/drivers/block/brmr/brmr-srv.h
new file mode 100644
index 000000000000..4180ee600e65
--- /dev/null
+++ b/drivers/block/brmr/brmr-srv.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Block device over RMR (BRMR)
+ *
+ * Copyright (c) 2026 IONOS SE
+ */
+
+#ifndef BRMR_SRV_H
+#define BRMR_SRV_H
+
+#include <linux/fs.h>
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/radix-tree.h>
+
+#include "brmr-proto.h"
+#include "rmr-req.h"
+
+#define BRMR_SERVER_VER_MAJOR 0
+#define BRMR_SERVER_VER_MINOR 1
+
+#ifndef BRMR_SERVER_VER_STRING
+#define BRMR_SERVER_VER_STRING	__stringify(BRMR_SERVER_VER_MAJOR) "." \
+				__stringify(BRMR_SERVER_VER_MINOR)
+#endif
+
+#define DEFAULT_BLK_OPEN_FLAGS (BLK_OPEN_READ | BLK_OPEN_WRITE | BLK_OPEN_EXCL)
+
+#define BRMR_BLK_STORE_MAGIC	0xC0FFEE
+#define BLK_STR_MD_SIZE		PAGE_SIZE
+#define BLK_STR_MD_SIZE_SECTORS (PAGE_SIZE / SECTOR_SIZE)
+#define BLK_STR_MIN_MAPPED_SIZE (PAGE_SIZE + BLK_STR_MD_SIZE)
+
+extern struct list_head store_list;
+extern struct mutex store_mutex;
+
+extern struct rmr_srv_store_ops pstore_blk_ops;
+extern struct kobject *rmr_strs_kobj;
+
+/* brmr server */
+
+enum brmr_srv_store_state {
+	BRMR_SRV_STORE_OPEN,
+	BRMR_SRV_STORE_MAPPED,
+	BRMR_SRV_STORE_NEED_SYNC,
+};
+
+struct brmr_srv_io_priv {
+	struct brmr_srv_blk_dev	*dev;
+	void			*priv;
+};
+
+struct rmr_blk_dev_params {
+	u32 max_hw_sectors;
+	u32 max_write_zeroes_sectors;
+	u32 max_discard_sectors;
+	u32 discard_granularity;
+	u32 discard_alignment;
+	u16 physical_block_size;
+	u16 logical_block_size;
+	u16 max_segments;
+	u16 secure_discard;
+	u8 cache_policy;
+};
+
+struct brmr_srv_blk_dev {
+	char poolname[NAME_MAX];
+	struct block_device *bdev;
+	struct file *bdev_file;
+	struct list_head entry;
+	char name[BDEVNAME_SIZE];
+	struct rmr_pool *pool;
+	u64 mapped_size;	/* in sectors */
+	u64 dev_size;		/* in sectors */
+	struct rmr_blk_dev_params dev_params;
+	struct kmem_cache *io_priv_cache;
+	struct kobject kobj;
+	unsigned long state;
+	struct completion comp;
+	struct percpu_ref kref;
+};
+
+struct brmr_srv_blk_dev_meta {
+	char poolname[NAME_MAX];
+	struct rmr_blk_dev_params dev_params;
+	u64 magic; /* magic token to identify a header */
+	u32 version; /* version of the header itself */
+	u64 dev_size;
+	u64 mapped_size;
+	u64 state;
+	u64 offset;
+	u64 ts;
+} __packed;
+
+int brmr_srv_blk_validate_md(struct brmr_srv_blk_dev *dev, struct brmr_srv_blk_dev_meta *meta);
+struct brmr_srv_blk_dev *brmr_srv_blk_create(const char *path, char *name);
+void brmr_srv_blk_destroy(struct brmr_srv_blk_dev *dev);
+int brmr_srv_blk_open(struct brmr_srv_blk_dev *dev, const char *path, bool create, bool replace);
+void brmr_srv_blk_close(struct brmr_srv_blk_dev *dev, bool delete);
+
+int brmr_srv_read_and_check_md(struct brmr_srv_blk_dev *dev, void *md_page);
+
+static inline void brmr_srv_blk_set_state(struct brmr_srv_blk_dev *dev,
+					  enum brmr_srv_store_state state)
+{
+	set_bit(state, &dev->state);
+}
+
+static inline void brmr_srv_blk_clear_state(struct brmr_srv_blk_dev *dev,
+					    enum brmr_srv_store_state state)
+{
+	clear_bit(state, &dev->state);
+}
+
+static inline int brmr_srv_blk_get_ref(struct brmr_srv_blk_dev *dev)
+{
+	return percpu_ref_tryget(&dev->kref);
+}
+
+static inline void brmr_srv_blk_put_ref(struct brmr_srv_blk_dev *dev)
+{
+	percpu_ref_put(&dev->kref);
+}
+
+
+/* brmr-server-sysfs.c */
+
+int brmr_srv_create_sysfs_files(void);
+void brmr_srv_destroy_sysfs_files(void);
+void blk_str_destroy_sysfs_files(struct brmr_srv_blk_dev *dev,
+				 const struct attribute *sysfs_self);
+
+#endif /* BRMR_SRV_H */
-- 
2.43.0


