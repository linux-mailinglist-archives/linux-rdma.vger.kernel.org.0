Return-Path: <linux-rdma+bounces-19995-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEbPMwii+WnR+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-19995-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:53:44 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 660494C850C
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 677E2304B90F
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5D03EE1E5;
	Tue,  5 May 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CDureJiZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD43EAC82
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967251; cv=none; b=AA9cp+NSzecj9NmGMkHf62dw4TFVZzJdJX87JDbDdhVOMfHgZxeKP5ij9sBcqpXJTtXfscJ5cyCrLDDw653G9AphHH7qFw6sMtItg7aBZZ5UffLs/WCjitKKXCOtv7GVbCGOW3bBFk89Di0Rz7anDFlCV1tu6N3HDtPkevRit1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967251; c=relaxed/simple;
	bh=mnDu9233zy3NXIpowZ9sBm6kVKWZ2CvIXnLOy50e5GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apMawFIIAiU+A+99auFFUn56PMPWiiaHFeTu6SLj504tMoLkYfgByN3pHDlwshfOAvwu32gvKujBj+BlLEkU+aK3cX75feTZvfxntU5QshFYrQIWCJVf+4o10gojZ3O2Hc56V1nMUk1RMMptM7EqV9XHQ8QpE+s1zcjrUYTeEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CDureJiZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso54087945e9.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777967246; x=1778572046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ai8t2M95CG1qyiwdjdt8gB4lloKch9LSXoTKwvwY5cs=;
        b=CDureJiZiPWvYhH45B5ghk4cC3zpqJL69QhR6a92BPT4ukLmJp4RORnInUUsRH852p
         0mMMR2WB+2MUCO/9eUVrLFwC0rXRweLnKuYpEu2GrJj7xAV1s9m17TFaqv5EpUyK31Gc
         CYX3XNaHUswtp9mVOhuzEGa8tTDQw2Q91WFP25vODAieAwsQS7QNZ8qJEnptj5vPGcsa
         ZScUIG+UZ6Sp5yhX9zRVXhoA2+WkuSpBuUTszUX2NBAoBqyonP0PjPDJMGPjjVGQRciB
         fFsfWuECYQYjfBCeJ/WwZoF4Di1GUVBGJgg56tMigWEdbpFWvRQXgCNSR/GIw7xYV220
         gabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967246; x=1778572046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ai8t2M95CG1qyiwdjdt8gB4lloKch9LSXoTKwvwY5cs=;
        b=A4zXlEId9jFlfDxuqBW5pbfUjZl993ZnxTW/ppb+Vtm/Lu87d2XbA+7AojsMknxCUa
         BzIOaTdVofJZPIKk07enOkHNEhPPE3a5NAsIUcfoMIDUk/rZP7qxMCL1I7zuVfPU6L8U
         ozmVj1anm6kSqco0OmsHs57rT0dk8SQN+MTE85wCAAyXNlcl+GcPtGZfFucnRRKPhSx/
         IWJkSVwKf6flYPc8eyihrF8w5cwP5xm1/c/RyEwxrVofJtG4tjHQLzZFIgki4MuOhNhA
         VUclz1z/5th6CZ0rGJck+fXqeJurP5FaEksANzGFK7VxEFaQZ/HD5GzQhMxJHr585zxe
         f7Mw==
X-Forwarded-Encrypted: i=1; AFNElJ86hYrgFftHYrpmRggAW/VahPqFJcJGiPHcL8HSkoOPZPmRKpbw7ztVcpz5EJVKewVZVJ/86gui3cRO@vger.kernel.org
X-Gm-Message-State: AOJu0YxNUf7ZeCpcLMoZ0JCojV/gR/ui3UxnJUPnqj8ecB4w2Oa4qOEb
	Su/ZWBykWmXrsNA0u86gF7zqcmsqzjArQWEUNebENGh1386DOqbbm7ebSwrkSifzdBA=
X-Gm-Gg: AeBDieusV9b5uKiIjUbEfGS2fNyD7SF2xuBhC5aUauyDRQ0F/CMYIqAYw5rYphCZqJD
	dd4xg7V4DRFBwYh0dFdQUEGj0Pcyg3ZVKd2rNMksdtQ1uHpyzXlWhlcIsQsQAT+l6IhFV1FwVNq
	CSekkKbJV8P1mQXS/aAUJ5XRkpAU832LHJA0hdb/C8Slv9c4EW2+Os3bHhqygOnRiV2MbL9zSK6
	STer3Wll5A/zCAzMilkhhbI8W4DaxLTRSpkTxWUAcEIllLpGIgTzCetxdffilaBu8BRCEnevpK5
	c9AUwcO60JI5fxMNiypXv5rEiewkC9V6TqdrL39vnQIUBkzzjmUA3H04hZdwbQrRxczC0JNOXkH
	xjKaf7VlbQDw+67KLfdOsSuyMszFCr+4D+2E7Vs3+8hZ6qS3ePfIHCvYDpERNn42p7NDtfJqy9+
	bzty9Km9/NQjHBvGO5QIiZpmZiHW/2liZcPP3K90GlcNoMsgvyI3n8zPXpTfUoLCE+/kHGEbub2
	LJs7lkTvK5q8op63OccmkfZGi3tv2kndWemLupGMOFTbg==
X-Received: by 2002:a05:600c:8116:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48d141ceb81mr38242215e9.0.1777967245773;
        Tue, 05 May 2026 00:47:25 -0700 (PDT)
Received: from lb03189.fkb.profitbricks.net ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d186d97c4sm10617125e9.35.2026.05.05.00.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:47:25 -0700 (PDT)
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
Subject: [PATCH 07/13] RDMA/rmr: include client and server modules into kernel compilation
Date: Tue,  5 May 2026 09:46:19 +0200
Message-ID: <20260505074644.195453-8-haris.iqbal@ionos.com>
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
X-Rspamd-Queue-Id: 660494C850C
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
	TAGGED_FROM(0.00)[bounces-19995-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ionos.com:email,ionos.com:dkim,ionos.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add the per-directory Kconfig and Makefile, and wire them into the
parent drivers/infiniband Kconfig and drivers/infiniband/ulp Makefile
so RMR can be enabled in a kernel build.

Three Kconfig symbols are introduced:

  CONFIG_INFINIBAND_RMR		(silent, selected by either side)
  CONFIG_INFINIBAND_RMR_CLIENT	(depends on INFINIBAND_RTRS_CLIENT)
  CONFIG_INFINIBAND_RMR_SERVER	(depends on INFINIBAND_RTRS_SERVER)

The Makefile builds two modules: rmr-client.ko and rmr-server.ko,
sharing the pool, map, request and library code added earlier in
this series.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jia Li <jia.li@ionos.com>
---
 drivers/infiniband/Kconfig          |  1 +
 drivers/infiniband/ulp/Makefile     |  1 +
 drivers/infiniband/ulp/rmr/Kconfig  | 35 +++++++++++++++++++++++++++++
 drivers/infiniband/ulp/rmr/Makefile | 23 +++++++++++++++++++
 4 files changed, 60 insertions(+)
 create mode 100644 drivers/infiniband/ulp/rmr/Kconfig
 create mode 100644 drivers/infiniband/ulp/rmr/Makefile

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index a7e3f29dc037..4b2470b5a592 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -110,5 +110,6 @@ source "drivers/infiniband/ulp/srpt/Kconfig"
 source "drivers/infiniband/ulp/iser/Kconfig"
 source "drivers/infiniband/ulp/isert/Kconfig"
 source "drivers/infiniband/ulp/rtrs/Kconfig"
+source "drivers/infiniband/ulp/rmr/Kconfig"
 
 endif # INFINIBAND
diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
index 51b0d41699b8..24c8e4b00065 100644
--- a/drivers/infiniband/ulp/Makefile
+++ b/drivers/infiniband/ulp/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_INFINIBAND_SRPT)		+= srpt/
 obj-$(CONFIG_INFINIBAND_ISER)		+= iser/
 obj-$(CONFIG_INFINIBAND_ISERT)		+= isert/
 obj-$(CONFIG_INFINIBAND_RTRS)		+= rtrs/
+obj-$(CONFIG_INFINIBAND_RMR)		+= rmr/
diff --git a/drivers/infiniband/ulp/rmr/Kconfig b/drivers/infiniband/ulp/rmr/Kconfig
new file mode 100644
index 000000000000..1d62322a02be
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/Kconfig
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config INFINIBAND_RMR
+	tristate
+	depends on INFINIBAND_ADDR_TRANS
+
+config INFINIBAND_RMR_CLIENT
+	tristate "RMR client module"
+	depends on INFINIBAND_ADDR_TRANS
+	depends on INFINIBAND_RTRS_CLIENT
+	select INFINIBAND_RMR
+	help
+	  Reliable Multicast over RTRS (RMR) client module.
+
+	  RMR is an RDMA ULP that provides active-active block-level
+	  replication on top of the RTRS transport.  It guarantees
+	  delivery of an I/O to a group of storage nodes and handles
+	  resynchronization of data between storage nodes without
+	  involving the compute client.  This option builds the client
+	  side, intended to be used by an upper-layer initiator such
+	  as BRMR.
+
+	  If unsure, say N.
+
+config INFINIBAND_RMR_SERVER
+	tristate "RMR server module"
+	depends on INFINIBAND_ADDR_TRANS
+	depends on INFINIBAND_RTRS_SERVER
+	select INFINIBAND_RMR
+	help
+	  RMR server module processing connection, IO and replication
+	  requests from RMR clients on top of RTRS.  It will pass IO
+	  requests to its consumer, e.g. BRMR_server.
+
+	  If unsure, say N.
diff --git a/drivers/infiniband/ulp/rmr/Makefile b/drivers/infiniband/ulp/rmr/Makefile
new file mode 100644
index 000000000000..c173092f4cf2
--- /dev/null
+++ b/drivers/infiniband/ulp/rmr/Makefile
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+ccflags-y := -I$(srctree)/drivers/infiniband/ulp/rtrs
+
+CFLAGS_rmr-clt-trace.o = -I$(src)
+
+rmr-client-y := rmr-pool.o \
+		rmr-clt.o \
+		rmr-map-mgmt.o \
+		rmr-clt-stats.o \
+		rmr-clt-sysfs.o \
+		rmr-map.o \
+		rmr-clt-trace.o
+
+rmr-server-y := rmr-pool.o \
+		rmr-srv.o \
+		rmr-srv-md.o \
+		rmr-srv-sysfs.o \
+		rmr-req.o \
+		rmr-map.o
+
+obj-$(CONFIG_INFINIBAND_RMR_CLIENT) += rmr-client.o
+obj-$(CONFIG_INFINIBAND_RMR_SERVER) += rmr-server.o
-- 
2.43.0


