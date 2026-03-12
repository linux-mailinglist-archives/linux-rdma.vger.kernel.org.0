Return-Path: <linux-rdma+bounces-18094-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFcxHe+Qsml5NgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18094-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:09:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1272701AB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40686321932A
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A313C2770;
	Thu, 12 Mar 2026 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Qj8Mfr9U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF7B3C279D
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309870; cv=none; b=eXQTaRg9ayPhNV30NVAu7DZOHZPMO5DoYlYS3Pn2QQv9vm2JHa7upiS8lc9r9zyjMHJl+M/+twNvm9kodrQuupI3cJkDHtIM7QxGBnwIelKh5UrwwX1ccR9+nJc3akCIIxeV5MkuRhoggc2zG4dc5s49TpFT9d8oKHABB9VJXpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309870; c=relaxed/simple;
	bh=suAlp0+6vIiTYE/DszDuVSfJ/B/GhkXRhq5R0j4plyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnIMZI1iu1EMNdt7/L7iI5YB2O6hpi9pN7bJjTw3UKP/1lH7JHeZ8fv+XHx1HhpgGNRt9QtoHfv9cQ3+mL4AtirnAJZa0jxQOKTDD8df0hRF0/THoZJAapAsDw/bE3fuL+MvC3+9wU6Cuy7PHdl+y+MKebP/1plIP6EOG/YLX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Qj8Mfr9U; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so1029992f8f.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309864; x=1773914664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3g0UTN2sEfKe2VfEgfWZcWamkZLOLTyGyEUUMk8B8w=;
        b=Qj8Mfr9UwfhRSIgZUQHCZrKZIc0JzTFDaGraVvYFVfiMJeR8SifuCWCbXYITEiPNQS
         0DVGihRcwAKCf9yQciNxuEBl0hi9rx9W5AfHTg5G2AgxZbtwux/rXKdserotbDESUpcc
         hL4gfiQ7Ua6vVNv+5VdsZ+vPgedQhBmJ+BWMC2mFYOnMh3Pwsc1OLa5gAAMK6DMZPi1d
         u5AVVnOMBRnT7hBZip+cSKjEYlAVLUECpjQgReDTnKyx//W2UcST2Ye4czr7hXc+/C+7
         zgDfE9/lR2BDsNGQWPDc/eeb2HSARLJjToo8NDIdosm4igl4SY0zP61MCRbG0o7RTFmT
         8ljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309864; x=1773914664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3g0UTN2sEfKe2VfEgfWZcWamkZLOLTyGyEUUMk8B8w=;
        b=W65EqlmDJAxajEP+zYb+WWk8QM1QzkmULu9ZbZUA1mGamcfRYvaDbI/FW84qCzNlGY
         ADmpPn4Sskm8Vv/HBCLzaac3kMET+9Q/5kEyeQxYQr24IF2FK1UF7eAFmVPVd3pkooof
         hicHo3ldMHsLzopWNo/jm21U6IJhtTuN0DfKSgUZyyGfM0fAJEkdeFyHr5svcmlkVqG9
         mxPfvPy6mbqx+5N8B5nuEBiZaCft2qkYBEUCMjooqgyGpMN25q3aI3Tzna685X1A6TNX
         eJeFaUB2hXyk+Eyp4Fa/NsDty95mg+KULvqqGH9sHv6/iVvKKElgR3czttYMWCp7WnFL
         BQXA==
X-Forwarded-Encrypted: i=1; AJvYcCU9D5dNtWjXbH2MFa+ROVQDsk2VQQz9jUwCq0QFGXJDyZ04lPHh8Xu/ueZt+wS2XkgzbRwjSN9GsZdN@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXJo8n60zdm7IjkZ0C01FEsJjMxywpdkjfTH5sbWIy70AoME7
	Lh0HUKlxTgHE2YSq03JUGoOk8kr81d99YfaTBpyu1djgD5jBPzxpMUl59W+sZl0DHRU=
X-Gm-Gg: ATEYQzwTPzbcOFGpQLnI8K+aumCgZdjZRHLbBCSes+RTFnivYysV9wzWrmhx+WFVQ+M
	O8fxqj+ahO7LrWV/1hGKyeJUquUbFoA2+mQdb2BKZCIpHAspx+GssQLR1h/r43qBwbNMX2B56L6
	zH4aSHYAHTJ1AHo2ipinPIQScpOQz9v5OHnhWhXIC1Fjrirvbcw5vcSKIv0LpwXXCxBzCSBXajA
	bYSUxlFefeD3g/1KSCeCfLlBDO2VRZk/wDGkefWTbEHROK7CBilb1/wvvorG4YwKSj4V3oiX27c
	3qg2OjhX2tPhU9KplMtGdauQay4YcFBBurbj+dgbGyow2U5SyM2ZGYYiej36g4ZOxkC79JHtBCZ
	abKtS1qwN9ilvcp2NsmC8IfWxXlX8/F0qhkIYvAid0uY7v/ZoL8ZZwNQz0rZBlNb3iGPWOilNlx
	vMgS5nKlSMr+x6Iw==
X-Received: by 2002:a05:6000:40db:b0:439:af81:1b2f with SMTP id ffacd0b85a97d-439f821fa57mr10881376f8f.46.1773309863778;
        Thu, 12 Mar 2026 03:04:23 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1b22e7sm7506007f8f.16.2026.03.12.03.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:23 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v4 12/13] documentation: networking: add shared devlink documentation
Date: Thu, 12 Mar 2026 11:04:06 +0100
Message-ID: <20260312100407.551173-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260312100407.551173-1-jiri@resnulli.us>
References: <20260312100407.551173-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18094-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: CC1272701AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- describing 2 models of use os shared device, with and without per-PF
  instances
v1->v2:
- fixed number of "="'s
---
 .../networking/devlink/devlink-shared.rst     | 97 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..16bf6a7d25d9
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,97 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Devlink Shared Instances
+========================
+
+Overview
+========
+
+Shared devlink instances allow multiple physical functions (PFs) on the same
+chip to share a devlink instance for chip-wide operations.
+
+Multiple PFs may reside on the same physical chip, running a single firmware.
+Some of the resources and configurations may be shared among these PFs. The
+shared devlink instance provides an object to pin configuration knobs on.
+
+There are two possible usage models:
+
+1. The shared devlink instance is used alongside individual PF devlink
+   instances, providing chip-wide configuration in addition to per-PF
+   configuration.
+2. The shared devlink instance is the only devlink instance, without
+   per-PF instances.
+
+It is up to the driver to decide which usage model to use.
+
+The shared devlink instance is not backed by any struct *device*.
+
+Implementation
+==============
+
+Architecture
+------------
+
+The implementation uses:
+
+* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
+* **Shared instance management**: Global list of shared instances with reference counting
+
+API Functions
+-------------
+
+The following functions are provided for managing shared devlink instances:
+
+* ``devlink_shd_get()``: Get or create a shared devlink instance identified by a string ID
+* ``devlink_shd_put()``: Release a reference on a shared devlink instance
+* ``devlink_shd_get_priv()``: Get private data from shared devlink instance
+
+Initialization Flow
+-------------------
+
+1. **PF calls shared devlink init** during driver probe
+2. **Chip identification** using driver-specific method to determine device identity
+3. **Get or create shared instance** using ``devlink_shd_get()``:
+
+   * The function looks up existing instance by identifier
+   * If none exists, creates new instance:
+     - Allocates and registers devlink instance
+     - Adds to global shared instances list
+     - Increments reference count
+
+4. **Set nested devlink instance** for the PF devlink instance using
+   ``devl_nested_devlink_set()`` before registering the PF devlink instance
+
+Cleanup Flow
+------------
+
+1. **Cleanup** when PF is removed
+2. **Call** ``devlink_shd_put()`` to release reference (decrements reference count)
+3. **Shared instance is automatically destroyed** when the last PF removes (reference count reaches zero)
+
+Chip Identification
+-------------------
+
+PFs belonging to the same chip are identified using a driver-specific method.
+The driver is free to choose any identifier that is suitable for determining
+whether two PFs are part of the same device. Examples include:
+
+* **PCI VPD serial numbers**: Extract from PCI VPD
+* **Device tree properties**: Read chip identifier from device tree
+* **Other hardware-specific identifiers**: Any unique identifier that groups PFs by chip
+
+Locking
+-------
+
+A global mutex (``shd_mutex``) protects the shared instances list during registration/deregistration.
+
+Similarly to other nested devlink instance relationships, devlink lock of
+the shared instance should be always taken after the devlink lock of PF.
+
+Reference Counting
+------------------
+
+Each shared devlink instance maintains a reference count (``refcount_t refcount``).
+The reference count is incremented when ``devlink_shd_get()`` is called and decremented
+when ``devlink_shd_put()`` is called. When the reference count reaches zero, the shared
+instance is automatically destroyed.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 35b12a2bfeba..f7ba7dcf477d 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -68,6 +68,7 @@ general.
    devlink-resource
    devlink-selftests
    devlink-trap
+   devlink-shared
 
 Driver-specific documentation
 -----------------------------
-- 
2.51.1


