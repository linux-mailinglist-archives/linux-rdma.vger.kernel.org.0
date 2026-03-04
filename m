Return-Path: <linux-rdma+bounces-17492-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJxHAO1bqGmZtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17492-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:21:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A852041BF
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E6A831C5DBF
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B535F171;
	Wed,  4 Mar 2026 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3dJzgiFT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1517935E944
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640052; cv=none; b=n6FKNY/LoXox0VXk7Qeo1xzUdzYfembsz0LoqBuzEyENR67I94izUmAfy+DW88tug3+iPirPTKXaejosh7zECelOBYAx/iFau/NTVDFG0Jzihe+pNk53YQgVmrJl//9Q/pY3kZVzjGMnGBE+DiJsbQQk4bCHsuX4l/oEyjLwHGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640052; c=relaxed/simple;
	bh=suAlp0+6vIiTYE/DszDuVSfJ/B/GhkXRhq5R0j4plyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8MTPdZRKhcRSViDyAz9/CLeUVl13w9+/WKg4HnNHhqJ94QlDYOD1+gqKPfAlLSdxuDoCfcJOKjYSWWT5wzi/OCLj/zBerCXhn7u3Qag/qG5YtYcBO3MSr7AeOX8Gmf4gzR+w4VROvWJahIWYSYu2hK/5b2UM7BHRQGE9I26gnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=3dJzgiFT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso58844815e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640049; x=1773244849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3g0UTN2sEfKe2VfEgfWZcWamkZLOLTyGyEUUMk8B8w=;
        b=3dJzgiFToOxO+iz1yiW9nfsncciLnIlxgjjvboNOdkglu8CyhtZ9MO7v4Bh4FIgsfU
         MrzNoTeAvvm3WypyqQDUxai1rBbx5zEgAyYSAUWqdfM+vqy/Ek5qrOnT5ZXumpikCGuc
         hiR+rjO8FsnIliBbBDujSAidq9HJlaSIxUWZQPYkImNoxHusJaSMOp/cwAPWkq7+J5oO
         hQPyphCOlAwKP3qLXwp5rdAiTr+iKzXSR1JeHBCZggOf4XejQt1rITdMSiKgw7OQggM0
         duVGj/3Nvtae+W/DyqmouReOq8M+baixXfq6Fd0yxMVabI2h4iXe0f3BVx/6KIyB0aAa
         pxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640049; x=1773244849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T3g0UTN2sEfKe2VfEgfWZcWamkZLOLTyGyEUUMk8B8w=;
        b=vkQnO2+Q2v3/hw0ZdYCFJo09yFhz1HtrXOnbMWAlJckUXBjnkYKZcFNnvdULfroVfO
         JGkpEZ0nceyzFHuI0K1ZgvZgxiFgTe3PMleKu42Oxd+0V8r9hBIw2RTR2CJEMaBzCfiH
         nK7y9iTfddUbO2XpCVaixC4z+YPiSICKRyIfKAywMWLvfiXc6Y167o5U0w5x0Br+lrd4
         W/DASKxmDZDyqYoVrsyJlhhg0jdFaOhFo7rDDm9XbVc138iuI2DqjKY8dXwBzuxB+qOD
         L+V0LAacu6/0mT+joV4arzgSsCC3XazpWEuKotugqMOHqwHc/yPDIW6ENkq4auRFbSk5
         qaKg==
X-Forwarded-Encrypted: i=1; AJvYcCUPMAiRzNxnMy+N8bovr/3WrJEaTZxgqZzBLrpPyIq4QE+Bo5W0bRDNlByd0TuqfaMyjGX0u6Yw+Ug5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90QYQIF7ARi7OHuTjx6fIEebT+QNeBqxXm0iVh1RW9BxzBFYT
	SsrFVJTRoKzCvLMkW6ncxPZ0uYlpSaPFoqj5NOxjkxTJ9WAhVxoYUsKsGCGV1AhV43I=
X-Gm-Gg: ATEYQzzrjTF1LJcu2R8HzN2NB7VNU1s0dDGClABHXy+tXhnfKH/mHYNcWuhAujoT/KV
	axQ3/0j9RdDCNYUddJfyU8iRwdJUu+biwpT1vnWGyEOILYZYm/n2DdacqmplPzC8gaCVBLpy1n9
	yjOAq79UMRPjTkqarLyNNX+CaCeWgdZMATJwIS/iB5LZv1kFdcWS8R7OFSG14LK6bwfrntbOMvI
	ZTWS86hVq7QDhIUiVX6bwF1JpRaINpICn/xuz7yb15GxBTidoYe6ey9HXovysSMC3XwWkyVHFUB
	2ON+fck30Hid1dlEJLXjJbd4QpSL+ySK556Xuh6uoRvJngqgQWdzEsvHp4lUP4nk8AomlLYBSpl
	OZG89CHyKB4GA2sCmRYpZt0oi+NNyHTwnJHkjA9HfArYPfQ2z3VmuEC5nDnyFv8ROk7ITWElO1J
	R27R2Ls1iBqLHQQEFGlv8pg7arxglDu/X+QU4kWJkXJPrV4PhPHY05VMdr
X-Received: by 2002:a05:600c:529b:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-485198668eemr42237935e9.12.1772640049317;
        Wed, 04 Mar 2026 08:00:49 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485188914ddsm74604335e9.12.2026.03.04.08.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:48 -0800 (PST)
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
Subject: [PATCH net-next v3 12/13] documentation: networking: add shared devlink documentation
Date: Wed,  4 Mar 2026 17:00:21 +0100
Message-ID: <20260304160022.6114-13-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260304160022.6114-1-jiri@resnulli.us>
References: <20260304160022.6114-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 52A852041BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17492-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

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


