Return-Path: <linux-rdma+bounces-18090-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPaaK5+Qsml5NgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18090-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:08:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4A527012D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DE9A30A185D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476D83BF690;
	Thu, 12 Mar 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KSIjSVQq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595403BF695
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309863; cv=none; b=BgyL24bv/+z48A/Bp9nS1P6L66CduY53c6b9Dv8MaubNRTVlb3Xp9n64k8NOlqm0yKvX8GdwMJn4vUHxiKbkpaXJFyCrR+C8DJk28lQT6gQDnzeublCXQdndIYv5O4fp6C6GU/vTboV98E9kkNai7Y87492Nq09uT8BsqZUJ0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309863; c=relaxed/simple;
	bh=7DRFVjIY+Ygj/L7QkL1uTDqAGAZViCzf/BNmCHn88Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sviB4Va3oVFwdAZdr9bvlKh8xJvxsSdVp6rI+D5ZHIhaxjv3I7kaLQE1DHpEDV1pdjYxinFS3s3wnkp+UwAwIOKisTlaIJb6JvHYBkMdQqOC7K59pKzfNodKW6r/vlxfemWF1ayzmROyPuIM2PdkFqPlmDS7PsOdzL5eF11C6b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KSIjSVQq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b78b638eso902416f8f.2
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309857; x=1773914657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=KSIjSVQqlLM6E+xIK5q2jBSjB/vBFosH4JkpAltGAax2/BQpY0uh1aIsegW2Nlh6SP
         1oAcecgqEZDMO4kmnlNDXbM57TokOVqNZOnU4mUZx+FdZth5alTWSEkDU29xwIXPcsrw
         ZLubgtFlefLPyEFdGd6n9dzhwTfs8ZsQFixqdmQRp9n3GbdZsGgzxx+z5W8qohb99SVa
         xxeRnv1ri7qvVZImf/lEao+JUZ2xFl0lPgdeu2jdTQl6b94N0SuNcWTQO+VF54T1H8Y5
         mIvPVKelhpj4H/G9kgPcz0aUDLe85NIvTNisS47IdEhrhqGrqlxZmkoKe1CfxakbinCS
         7C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309857; x=1773914657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=vS2VgEb2tCDC5sac/RhAXPYupjhj36s3aQrcYIGa3e2/VSlwMd9fqpUh7DT7/7duw4
         nl9mMI0fW9lg8Idb8Bs77A7fH9qLqzvWVtHzivgjkxVMCVVgPlxswahiNE68ZObz6QGB
         Uh0W1m8q5guLFrM76ryH7BICjZUPNVPC1ooK8Z5XlgSb2ppPsPSWDjSUG7jmRV8peZF7
         F3QSSEo2rpl/oUHzY3THF4KbCfgpAVlrmHFEgxHchxzscD39z+A9WTr4YO+2zP0nVUfw
         n3kQiwgVxOuQA19r50wKpKE1W0rTYRq6A+Us4xYH5cQ533g2EWjfYECgWhDUOq6hbXxH
         fu9w==
X-Forwarded-Encrypted: i=1; AJvYcCX8EMrp2SBU4a1WBkyopoHkwwFqtJuDX9eErxRPtgtnukU4h1/XwbEfLHks0XDIbLDKxoSy6r6amvW/@vger.kernel.org
X-Gm-Message-State: AOJu0YwAYD19uQgLwquW558eT3sO2Du2JpTrRqLMB6ZhD5KUqlahR/0n
	VMos7nY6ypc8dJUB65e5p9Z5WOuI8eVQ7gKoAP+u861QH8WWfNfGFT1Vwc1aY0zCEnA=
X-Gm-Gg: ATEYQzxAmAWP9kmuvA51ycodwMeV9sAowKKG7GNZE4Z/UYJL0MbXCTyHKXjBu0RFDDI
	pdJ09EiZg4skfc4omFbl00ju7+HGHmsSVwgr4EGU874IDpfEyycsSTPPiaVRrD9JKLILauRguWV
	rBGToPln4Lp6ynN2qD3udObRLEyZDMMv2l+MHvJm0OMTXfWYZoonenxQP68OvMHtkOoqXRJjHLW
	Mz8AnqyFPM9fVdBZ808MwwFhNWOZ/S3xIg60+4MNalZviBnl8lV+vORUPS1w7hjAJz/wmVOKpyb
	aK0uAGei7Cz4jqrORmyVt97/J98RKmbHxpGHK+3Wus9Vz0yY4yBobS9mBONoDdE402rgGdT+m9Z
	6cCEwJb/Ujc+Cr7jz6qv36mNufTqcEsX73+gbKjV+Ldyr70YQMujQntRCjErTpas8tXSpjc8jna
	x4cZ0jiLFR+ViL0w==
X-Received: by 2002:a05:6000:186a:b0:439:b1c3:84bc with SMTP id ffacd0b85a97d-439f81e297fmr11955825f8f.7.1773309857325;
        Thu, 12 Mar 2026 03:04:17 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b4dasm6982812f8f.18.2026.03.12.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:16 -0700 (PDT)
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
Subject: [PATCH net-next v4 07/13] devlink: introduce __devlink_alloc() with dev driver pointer
Date: Thu, 12 Mar 2026 11:04:01 +0100
Message-ID: <20260312100407.551173-8-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-18090-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0C4A527012D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Introduce __devlink_alloc() as an internal devlink allocator that
accepts a struct device_driver pointer and stores it in the devlink
instance. This allows internal devlink code (e.g. shared instances)
to associate a driver with a devlink instance without need to pass dev
pointer.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/core.c          | 40 ++++++++++++++++++++++---------------
 net/devlink/devl_internal.h |  5 +++++
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 237558abcd63..fcb73d3e56aa 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -418,27 +418,15 @@ void devlink_unregister(struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_unregister);
 
-/**
- *	devlink_alloc_ns - Allocate new devlink instance resources
- *	in specific namespace
- *
- *	@ops: ops
- *	@priv_size: size of user private data
- *	@net: net namespace
- *	@dev: parent device
- *
- *	Allocate new devlink instance resources, including devlink index
- *	and name.
- */
-struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
-				 size_t priv_size, struct net *net,
-				 struct device *dev)
+struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
+				struct net *net, struct device *dev,
+				const struct device_driver *dev_driver)
 {
 	struct devlink *devlink;
 	static u32 last_id;
 	int ret;
 
-	WARN_ON(!ops || !dev);
+	WARN_ON(!ops || !dev || !dev_driver);
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
@@ -453,6 +441,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 
 	devlink->dev = get_device(dev);
 	devlink->ops = ops;
+	devlink->dev_driver = dev_driver;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->snapshot_ids, XA_FLAGS_ALLOC);
@@ -480,6 +469,25 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	kvfree(devlink);
 	return NULL;
 }
+
+/**
+ *	devlink_alloc_ns - Allocate new devlink instance resources
+ *	in specific namespace
+ *
+ *	@ops: ops
+ *	@priv_size: size of user private data
+ *	@net: net namespace
+ *	@dev: parent device
+ *
+ *	Allocate new devlink instance resources, including devlink index
+ *	and name.
+ */
+struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
+				 size_t priv_size, struct net *net,
+				 struct device *dev)
+{
+	return __devlink_alloc(ops, priv_size, net, dev, dev->driver);
+}
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
 
 /**
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index f0ebfb936770..3cc7e696e0fd 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -49,6 +49,7 @@ struct devlink {
 	struct xarray snapshot_ids;
 	struct devlink_dev_stats stats;
 	struct device *dev;
+	const struct device_driver *dev_driver;
 	possible_net_t _net;
 	/* Serializes access to devlink instance specific objects such as
 	 * port, sb, dpipe, resource, params, region, traps and more.
@@ -66,6 +67,10 @@ struct devlink {
 extern struct xarray devlinks;
 extern struct genl_family devlink_nl_family;
 
+struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
+				struct net *net, struct device *dev,
+				const struct device_driver *dev_driver);
+
 /* devlink instances are open to the access from the user space after
  * devlink_register() call. Such logical barrier allows us to have certain
  * expectations related to locking.
-- 
2.51.1


