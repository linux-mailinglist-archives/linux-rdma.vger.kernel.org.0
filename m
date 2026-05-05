Return-Path: <linux-rdma+bounces-20002-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOlYJY6i+WnR+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-20002-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:55:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C804C8592
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01BAA306B102
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2633F0A9E;
	Tue,  5 May 2026 07:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LswpkPtP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E90A3ED11C
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967271; cv=none; b=g1+FlLHyrq9xAgFcl+eaIthCmEnsbIJAA6F3Ps3mDM+AZhtZK9IAu3UIr24hwUJyXf4U63iRrV6z+XKV4kuk0UJ95ZzqkLqi2mVbx5RBOUhJPkIahHDgPa92G42GMw9gjGJJCqKSLocpYIowmaCsN1yzBJjViWx4C0JzvNQJqjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967271; c=relaxed/simple;
	bh=m3VnSMM2QtOWFjvotg7TV3q/DN1mgtB9oq+ih2Z0h1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUB0HYEyP1MxpC3rYychgJXVXsmS4TduiR2ZkdPhGRKsuRLX1/r852sfyn+i7iEfspLsEf00yAfhUo72WO61nOlgwGZwCMvj7Vh1DYMQk6lZacSAsNU6y9v3yprbVpCrPSbR81aqFyxXB06PbdEeC4tmxWNNKEOyHWMOQaerCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LswpkPtP; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so32885075e9.0
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967268; x=1778572068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63kUHHgmHe5aHRdq16aqP1LCZFlEN5uhqVLiLtPxsH8=;
        b=LswpkPtPymN7j1kirDXXa5h/c7LOiytYYE3VujZvRrkmcbOr7QB+70QvH1avjDf3Gu
         RrGm5VQ1Taq0eAiScG2Z/argb2LfewL7rXLPeY8/okN4YSRqQNXnufwANarjVM98swNu
         wvmAhhyG2ujeDE1FT6nCeixdNYdofiEq5VmrRn6rSJCcksvQ123nISDXwyThjIbpCo0I
         NQLQXpVk5eKAenHUpBXQ/FMNS+lvCuBakGBFij4EYLRE7ugp1CQJbSYlccdoFEkDN9yE
         G1zFvM9H10rsMtQyTCkkhnm3vpYX03RX4o1SD088/pFkfYgJqbS8PleyS6eC+wLqdiGX
         bhmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967268; x=1778572068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63kUHHgmHe5aHRdq16aqP1LCZFlEN5uhqVLiLtPxsH8=;
        b=sYXVw8fZ1u3smBSkzzgM6FKXxPI49tceo+SOAt1W9x5BO7RpdFONhCpQFvdlCUasAK
         Es/9PSEzDTkefxPe1DcG4GAtTW6EsYTbo4YAGwdUmvsNkFH8MfMdRRQ+pyjZ4MBrlQpZ
         5b0JpAaXCUkFNuX/jxHM1cVpD+qUA1woOwvtrXFNfSqBVhtQy8KavOgVcDToIic7f7/M
         vx3ORy6xpHxVS+xwNo3ZjNv4LSgOISaFkEdULJpMFoqs4eh1UAKWPARQmGgVbZGqcrPF
         n0TyXoKdbjoVpzrvAFGnjY7v6efNODGFCn7oKO+GNB78ci8xc+IeF2ik0dSRp1jB5Y9K
         mRwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MwV5dJlsEaevRhJymEJBH6oKGvghFt3x7dp2sP31fDBvyo7Qz5Ok7gBazULf+rBh/Zw3Xrh9QvDxe@vger.kernel.org
X-Gm-Message-State: AOJu0YyEG+Z0caEP3JKCedR+zu6lAbnIySdNXb7a+Jfp99hz2klGtayE
	DFp6CYrNa+2SAN43YBXkjYzX4RX/trx5kyNaWXtu7joSNyaofUnjd5MP+aE6SQjVm3M=
X-Gm-Gg: AeBDiethMzOEe3FI7lagfUUOUW6WE4Mf0vN5IzlWhxw+Nbq67/i64HsHVhEb2aFCPmj
	OgepsMsZUN/m7TrtjGlpvMoPAysEfSTJOGehZFBl3PlmwuzWolde7hFE6PY6aChN1FwleBH4vVL
	Jp8Re2RAdkbKj61U5hGVIXkMLvloXlPe5LCw+jGxJj0uHWoIwkKJy72doFup0nevYMZUEhNGLv8
	bypgXcbRPHpspZ0mMdpkgvoLvibzlwYy2TxxhgwxLm93BfRH4G7GJlfoHTSuCIixB7EI6uUz9we
	ki1VeBreLPq7f7rnRP/TBJM8ATDFZvla0UjlLbH6r6WfqtreVZ3mr6zl34hNoZxQ1ZsCfIv9nqX
	8nx53vG+9oqOhiedC8GkltRijbvSCmOdxly/auG91/Tw46+ioUNIt9ACqOW9wy73xqLIAK4mgcM
	uwcCgvwvhHXvOkVz/wldRAbySp9ctRbgAGzbqHvZQ8j+Wj7LFcdcgCHl5bB/zBkgCf4tdzQfPcw
	ijvpgfBt3602Qcq1/mJtEx6N7nfvnb4HkiePxPencA31A==
X-Received: by 2002:a05:600c:19d4:b0:485:3c2e:60d5 with SMTP id 5b1f17b1804b1-48d1422baefmr39849435e9.2.1777967267641;
        Tue, 05 May 2026 00:47:47 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:47 -0700 (PDT)
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
Subject: [PATCH 13/13] block/brmr: include client and server modules into kernel compilation
Date: Tue,  5 May 2026 09:46:25 +0200
Message-ID: <20260505074644.195453-14-haris.iqbal@ionos.com>
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
X-Rspamd-Queue-Id: 89C804C8592
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ionos.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20002-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haris.iqbal@ionos.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ionos.com:email,ionos.com:dkim,ionos.com:mid]

Add the per-directory Kconfig and Makefile, and wire them into the
parent drivers/block Kconfig and Makefile so BRMR can be enabled in
a kernel build.

Three Kconfig symbols are introduced:

  CONFIG_BLK_DEV_BRMR		(silent, selected by either side)
  CONFIG_BLK_DEV_BRMR_CLIENT	(depends on INFINIBAND_RMR_CLIENT)
  CONFIG_BLK_DEV_BRMR_SERVER	(depends on INFINIBAND_RMR_SERVER)

The Makefile builds two modules: brmr-client.ko and brmr-server.ko.
The server side acts as a consumer of the RMR server-side IO store
interface (struct rmr_srv_store_ops) to back an RMR pool with a
local block device.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/block/Kconfig       |  2 ++
 drivers/block/Makefile      |  1 +
 drivers/block/brmr/Kconfig  | 28 ++++++++++++++++++++++++++++
 drivers/block/brmr/Makefile | 16 ++++++++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 drivers/block/brmr/Kconfig
 create mode 100644 drivers/block/brmr/Makefile

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 858320b6ebb7..65167fcb1357 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -353,6 +353,8 @@ config BLKDEV_UBLK_LEGACY_OPCODES
 
 source "drivers/block/rnbd/Kconfig"
 
+source "drivers/block/brmr/Kconfig"
+
 config BLK_DEV_ZONED_LOOP
 	tristate "Zoned loopback device support"
 	depends on BLK_DEV_ZONED
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 2d8096eb8cdf..4793c9b0b383 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_BLK_DEV_PCIESSD_MTIP32XX)	+= mtip32xx/
 
 obj-$(CONFIG_ZRAM) += zram/
 obj-$(CONFIG_BLK_DEV_RNBD)	+= rnbd/
+obj-$(CONFIG_BLK_DEV_BRMR)	+= brmr/
 
 obj-$(CONFIG_BLK_DEV_NULL_BLK)	+= null_blk/
 obj-$(CONFIG_BLK_DEV_RUST_NULL) += rnull/
diff --git a/drivers/block/brmr/Kconfig b/drivers/block/brmr/Kconfig
new file mode 100644
index 000000000000..a38d59d2c1d4
--- /dev/null
+++ b/drivers/block/brmr/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config BLK_DEV_BRMR
+	bool
+
+config BLK_DEV_BRMR_CLIENT
+	tristate "Block device over RMR (BRMR) client"
+	depends on INFINIBAND_RMR_CLIENT
+	select BLK_DEV_BRMR
+	help
+	  BRMR client is a block device driver that sits on top of the
+	  RMR ULP and exposes a standard Linux block device (/dev/brmrX)
+	  backed by an RMR pool.  Together with RMR it provides a
+	  single-hop replication and resynchronization solution for
+	  RDMA-connected storage clusters.
+
+	  If unsure, say N.
+
+config BLK_DEV_BRMR_SERVER
+	tristate "Block device over RMR (BRMR) server"
+	depends on INFINIBAND_RMR_SERVER
+	select BLK_DEV_BRMR
+	help
+	  BRMR server exports a local block device as the backing store
+	  for an RMR pool, so that BRMR clients can map it remotely
+	  over RDMA.
+
+	  If unsure, say N.
diff --git a/drivers/block/brmr/Makefile b/drivers/block/brmr/Makefile
new file mode 100644
index 000000000000..894ba2720557
--- /dev/null
+++ b/drivers/block/brmr/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ccflags-y := -I$(srctree)/drivers/infiniband/ulp/rtrs \
+	     -I$(srctree)/drivers/infiniband/ulp/rmr \
+	     -I$(srctree)/drivers/block/brmr
+
+brmr-client-y := brmr-clt.o \
+		 brmr-clt-sysfs.o \
+		 brmr-clt-reque.o \
+		 brmr-clt-stats.o
+
+brmr-server-y := brmr-srv-sysfs.o \
+		 brmr-srv.o
+
+obj-$(CONFIG_BLK_DEV_BRMR_CLIENT) += brmr-client.o
+obj-$(CONFIG_BLK_DEV_BRMR_SERVER) += brmr-server.o
-- 
2.43.0


