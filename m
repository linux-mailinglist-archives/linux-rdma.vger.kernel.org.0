Return-Path: <linux-rdma+bounces-17486-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF+yOKJZqGlxtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17486-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:11:14 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9701F203DEA
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEB2230C71CE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4272335CB98;
	Wed,  4 Mar 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KJPdwU7g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172D35C1BE
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640045; cv=none; b=asJ98170aV3kV1dYlVqOyRvJyP1AQJtRCd7ivubn9IqD8UibQLSJK87SFp2AL5icIx3Ga3LiaCCwvDkxLMOCZyd8JxSJgtrCxvPNGR/SpOaHJi2Iz+xrtBMXppxyt3OlUo8oUeWHi0863qfK+gzAs/6ZRL+SOXKQTHKLFgjaBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640045; c=relaxed/simple;
	bh=7DRFVjIY+Ygj/L7QkL1uTDqAGAZViCzf/BNmCHn88Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mm4HS/3FogPU2bT9QZ0emAg4E8ra26uHnJLA5omz4Po/W8aEgwYlztmU+9niO0S9t94hdtf45lkLhUHKcYMaW73krsEPkHPMzWnJqBtaz8nNqwa3bbvt9aWb1Ltvi6mqVvDQ2NytHAccA6Vjewari3o2sfpgVDC0F76KnuorQSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KJPdwU7g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806bf39419so58736735e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640042; x=1773244842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=KJPdwU7gVjpcfDhV1aQxSuc5yozVPQMU/1qFi/q7+Hx2sdeqbUkK4o6QOJ1b+5ElDs
         d10NH31xZl/ZiSZtwK2fusIflEr+9LwuqSCqP1orIseKmdqnGLZf7EnCZY43golne9Ly
         O+xRX1OV2lKVhKZZqMrFKzCVDbCT6s0AdY8u6/aXm0YralJ+VMipL9H9RzYfpKP5RANd
         XaOuxJEOeHTtCTBJ9h5B57DyyxYqv9Z+huyfG0dlKDwo6SNjQTZ+BTBZiALexFSgzKu0
         q5LywESpYymuHSxV3hR/vGVUa7dwIilXvFIOLEgmWKwv5lgptnsvacVtUOnS+pIPvpKt
         vG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640042; x=1773244842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n2wY6Op/4DSI4vvkFWBlagxqRGhWF9+RBtWwPNkHP68=;
        b=EiCa6kk5rViuGDTCPdwdmOqso0p+mnwodmQ7rfvY6bfp0YcOcminQNqftl9K6F9fDS
         RZCV79bTjYXt0PNDipkPXA/LrJPSbeSL1OGtQFyKyiS+uVb5965iRskYNQ+rOUGTUbwi
         ljuSgZic+yaMJfGZOvkefUbExho86OG98mauAFSUDCIAyhmEACUYCY7NWW08W8G4aCCm
         w6T4KQoSdlTvAkxSmIf6GWsFhZuOaQFRn6IxPKtQrK/+TIy7nkyxZCJBMXBaTM7J5aFN
         fF8xpDy8GrGf2GPfdoRx15UYBR6v+R3GV9fr0+5dYh6cg7xK1LazQa54pIdHJmPOWEBo
         eZYw==
X-Forwarded-Encrypted: i=1; AJvYcCUPtx+n8TGdnBC10lYoSIw5jcSY287voa0g2wWSaxkiRqbQpi+VnWGVGtVVdz+OAhUIefKsWpCkMm4C@vger.kernel.org
X-Gm-Message-State: AOJu0YwhA6mwo6lRbeTKUrBvaXjOEAZ61k8Tq6r+M3GGnNMu51HsvcrK
	b8CZJcWRdtpIYrQRJQ0+g8PlqXgW7vWThhEVjQLP+TgxJseSkXkXXSzdIQ2vSIbhA1E=
X-Gm-Gg: ATEYQzyINjddH/2kaOB/4yEQozaWpF6hyD0NSQO9yEKTa2lqMtWZPEgcrZnGHhG5vyt
	sS+IcDykkpYWyj81+Mn3n0Pf13YWdn+AOGmXNkm6R04xNTEIfihS/LyNyOb3e4iJOqGWELT4iwE
	Zt0jwoPoxRaiZ8OloQhz/Yjl8vxavMm5BjD13TsabMVIPeUmW2CMkHIKYMvIEoNDZSxJ7FD++SB
	oFqxXBP/qKopX86yi/Oxq1XCTY9jo92MjL80y8whqxUa1duAiceEu+nP4ocnHWtfbOqfgB0vuGA
	ePi52EpUTRCu8v+YrIqpedCmRhQPfs/cGrwlc6MtkcPl5rTd8DU4gvdX38xnQ2FPfSUVp/rcSWY
	z4sjs02J4kcr7ti34nyf6Q2qCq1aksmKcu0sDFEnhRDlI49x1PbA9nGeZEQXS7Rij1+ijg//H1W
	pZC4d10egGM89L+M1XI/erN4zay1LddVJCP8KVsYEFagCF7w==
X-Received: by 2002:a05:6000:2089:b0:436:3761:583b with SMTP id ffacd0b85a97d-439c113528emr11715074f8f.27.1772640041008;
        Wed, 04 Mar 2026 08:00:41 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439abded86esm33624183f8f.6.2026.03.04.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:40 -0800 (PST)
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
Subject: [PATCH net-next v3 07/13] devlink: introduce __devlink_alloc() with dev driver pointer
Date: Wed,  4 Mar 2026 17:00:16 +0100
Message-ID: <20260304160022.6114-8-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 9701F203DEA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17486-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

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


