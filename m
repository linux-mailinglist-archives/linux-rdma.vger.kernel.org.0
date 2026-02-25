Return-Path: <linux-rdma+bounces-17167-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N8oHS/8nmm+YAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17167-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:42:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A79198448
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8002E31B0170
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E483BFE56;
	Wed, 25 Feb 2026 13:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GxCVFlE9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EFD3D1CB3
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026478; cv=none; b=HVLxvKEraLbP2Z8Wrs9pLcMGyAdp6Rp7sCF8aH9Ks4/pBxZsZgx55GfVpD1L4TQomC7q8pSxCihCRWwCdE0a8QHny1D5JMHbKSuXVJ/LBueLcOTshr4XiD4AgoxqDLF2Wqu5s1QKPlGWgxuLkx/STcdvIGVXG14XMm9yFnuVppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026478; c=relaxed/simple;
	bh=z40VzN7RJg93nuVTx3uJj/QFEihxo6bbSBkIUN0ad9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAC1cqjg6vX0TwNLWT8BdAlLt9ft2iv2LgKMnj3buOww3wlDb04nEe346g9U5da5RncPsHsUTkCcYV0ZZAFyedumHvUSgsYXUpAAQLfnfim43tdfsrHMpkQq4JxSqCppvccFquVURXMh513lgkmgpUgH6d5iJQidvjjGFkZrngU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GxCVFlE9; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-48329eb96a7so39928955e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026476; x=1772631276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ4paXHHNx1lbVehk+CL3CnGm7xq68IcRaSeIPyM4M4=;
        b=GxCVFlE9w7w5HUov3ZrFteu4Wm8d0T+Ec+z+g9I7ZLDLOHXLkgpuUSvrglJuAKF5Tn
         6ciXqENK4sSSw1OaEuFX0hOfXvrdVMEmIGho4THe/JrEEZPkjomdhy9++5q8jQb55uzi
         Jk/LmGl82eQZ92YbQQxKA5vRIxo86HT8cWFJPiokQQHhWMhxtMqAV/VtUJmOqdjkiCxg
         VDKVDqaRbvG2PvE7i2H5fq142F7iClzmn+B6OYqmM26AnzelbtQUE1gbfGpj+Py85FeX
         2k/+LpNV5uPoSQoGp/2hWfbiZ2zLX5csqGRZ3Uc15Ygf8IDSTUGFYC6OFj63BloAlHZR
         p2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026476; x=1772631276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wQ4paXHHNx1lbVehk+CL3CnGm7xq68IcRaSeIPyM4M4=;
        b=tQunXfniXZ19RC1hdMrsNYBuOdTx4VzKljHr2ahXkhOXgxNO8Vco5V6ZfZiOUbw3mt
         3dGyS/rfE6r7jsLzI3dBPlQ816BFNxTTvF4Ds8Eo62DgLJi8Kx8sD/NGrNpopHuoVo/F
         qvvTZ0U1sOGobW9RT+L2e5RTaBnAm5X8634Px3dcM2RPj/e4WKAIAbRmfGUuSUsO3W7v
         qBpUgifQ82g6Wt/9t1Q0CQ5LC5dxrTtSmHiEczjfq7u8N0hamt/tP2K7hqvEQ76uC87z
         6F3zwEbRSdqt2rfviu+wKQGtealp3P/wy7h0edhzOLonsgsd+8mlEldIbO30MEOCRM6r
         v6rA==
X-Forwarded-Encrypted: i=1; AJvYcCUDKIp31ZP8mKSE+IUIWJ2t+GmbSf36BgedZesduwS2OfP0+9bOIyfdFGNYbN9Hp1Qjs7OVylU5om8+@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPtg3Er7d7cBzJYoH7OnhAqODD4tLevpewtndk3S2PaBYT1RK
	EoLeNxFTMOaTLm+6FOQNlTy3FUBgKvclANkEkM8o2uKpSYTPcqGLhHmjcFQJO8nnvhw=
X-Gm-Gg: ATEYQzwJNaF60kAQRND10UqpYwsYBo+kA68o7yTBgkTj3DIB/e4xuFA1aYBJDF/Tca2
	qeIMrriGrpAZsZGDheLTlp8gamiGGNMdEkPRiKB9rq4rtuyNlRjcqtcjIahr3RcAyT5JicEAtqU
	JJRoXBavb24TgKJb3/9C2YmpeJM5FQ0FnIypgCoa8Gy40HJ9G0btuAOh1RMOAf9K+Z0x7gxawYs
	sD2hnPl77RIIRcvUfqDcX3gxQqtEAKkHfWIF0hWJJV9kGfhghUVMe3bl4qZ76dFmxPDIr32W/z4
	Z013A0a5uljLHt9xovi8WjCCYCYWDLTcnEmj5fz/abptcQ0eNuV48LrGs0+rmyxMi9IFtTMYBUq
	dfaOl8dBAWvsVBS2kzJSB92I42levaPxO7JmqQRRnb2KE6wmU7Dd6ytHLi4qPzUKhvbg99WSaij
	WIQBS+5Bk7ndQQMChC5ABkL/Mp
X-Received: by 2002:a05:6000:2403:b0:436:1590:f9e7 with SMTP id ffacd0b85a97d-4396f15cd3amr27471526f8f.12.1772026475499;
        Wed, 25 Feb 2026 05:34:35 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43986aa2f84sm11713836f8f.7.2026.02.25.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:35 -0800 (PST)
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
Subject: [PATCH net-next v2 09/10] documentation: networking: add shared devlink documentation
Date: Wed, 25 Feb 2026 14:34:21 +0100
Message-ID: <20260225133422.290965-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17167-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.961];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C9A79198448
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- fixed number of "="'s
---
 .../networking/devlink/devlink-shared.rst     | 89 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..4043f6647243
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,89 @@
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
+chip to share an additional devlink instance for chip-wide operations. This
+is implemented within individual drivers alongside the individual PF devlink
+instances, not replacing them.
+
+Multiple PFs may reside on the same physical chip, running a single firmware.
+Some of the resources and configurations may be shared among these PFs. The
+shared devlink instance provides an object to pin configuration knobs on.
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


