Return-Path: <linux-rdma+bounces-17490-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEATNNVbqGmZtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17490-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:20:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EF920419A
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB5563354275
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEDA2EFDA4;
	Wed,  4 Mar 2026 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="B9G5BxKQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFFE35AC23
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640049; cv=none; b=TY1HOtofs8oPEzytCY6MMYASetoW4DyTtfJZbIRn7couxTfQOeBFU0kZlEbNWnUKugSSEz6NRhiD50cbSpeow10TsuSkuCe178Jr2ci/oBrDIubDobQvJ5J1nMTyPoL6HXmoTly4z4kP04tpgeFHC6C3FGojp12HRD0uvK4FyyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640049; c=relaxed/simple;
	bh=sBqoFY/Rv5DTMYj++KN0Sw7vm98e4uLLhQx69umkhKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgv2qQfyZEyYUvUKogHO90Da3tUIIKJ0ko5/t4VS6wj+pL8p9CAX773wNHQKwDIrSO8WdzShH7mE87GRJ3Bo7RReghLjRh+K5jmdisr12OUTgEeKM0R02l85RF9KnUpvUIeMzYDi2OO7ExDQSfM5SRljtPULQ9WMil80aH2J3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=B9G5BxKQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so58221585e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640046; x=1773244846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thO3CTOoToOBK7xy8RWX7tgy+PjuAbGp4xc08ttDkvM=;
        b=B9G5BxKQ+ybP1h85XM63PYj5dG38GuNXoFB5jXOjTd/IqP7YF0mj4PLK8KGOe7c0zW
         BBNQaOo9662BHLcqysCzsSb/E51avZPf6mRqTTMb44yN1Bv6WT0NVrxeK/tu/tZ5D2UZ
         hEZ0jQyLdHWM5NiLHv40ldybcr628gAlbOUk9gEzcBjwZQSbLXeMSrEwr94i/ii+aoyA
         aLm8PowMre5aNxzGjuWnDkizezayoSTkDNeP/d4LrXBqKG1HmW++7jRQv7t9eP65+7et
         E+6G21ZZgvFh/pvAIc/E3HYGSnoJUkBTD+Tb9jp5CSdia1PDs11QQ2AbVq0eOxYX9Ilb
         LPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640046; x=1773244846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thO3CTOoToOBK7xy8RWX7tgy+PjuAbGp4xc08ttDkvM=;
        b=VTH1QD7riWkLPMA3z++BP2bByAk+bMqV2p0FGaP7SzhOGYV5vGtR/yZXopWVfs0Pjo
         QHeYUKS6RXJUp2dPmtEQ/mDGcMwZl/dHx/CLGvQlOQ+1yseXgLzQpagnK1/Xo7uhGej0
         Ez13C+Hh1pTCP5rvIwzc9Yp2DST6rnbtDS7fImfeZ5If3RigVNcqLwAP+luPrWkc+y4c
         Lf4R1xodRC8uUQKdfIR6/sV1JGxXzg1uTj6ukmelifIIJEHTNDyl3/onkmjJrlVk17dO
         MoUAYghSsdO3CrWJQ0mdMuwFr1CzTYqNZZCUdUb9oY+65+09Mr90FPldYy2Qb6nqZeRc
         DZlg==
X-Forwarded-Encrypted: i=1; AJvYcCXPQQpuwjzViXg1KWR2TQq9mOFydlC1XUA2G2lv/E7xrrjU71zVn5L3sPWHtPqYJ8/x6jYdPi5IQMca@vger.kernel.org
X-Gm-Message-State: AOJu0YyglM/bjR6pR/DE3UQUA3cm7nOUm6D97ov1OlwufKA3kKKEu5OX
	eWc1L8LwVhEWO+oejnjE8tkMm+fAMNYxB679Ly3f+AIcI6aeIEJWcwmzmxeAZ2RAMDU=
X-Gm-Gg: ATEYQzwNbgQNJHL779UMc0KKrqnItmy7oRpbzAWmtI7LgfBAzTbm9cM/TX8FLJ2Q0OO
	V9xsxIL0UalvAbJC48NTTPtq03nzDgsBNSseL0lE/ryoiLhxDv8rtYXwMvJYfAyt/AvvPHd4WaU
	wxaBLBqFTYoH/a9YifGcAxaYAg8LoUGFqXSYXQTqquIgsR4IGYpt7pfYEjfw6H6ev+T+idKtf01
	SDs4LLPvAdz2IbzcAWfEejsDzeUlGFjU4a+Iihh8LMBFj7xu10+D/awRho7rN6SW4WaVm+5Leew
	898s6W8/bmreHiNS0V/vD6MjzU5la62BzBIh+CDNSSzB+wkGUgkQiw/1jkMeuUlZwx8F7PKOmL8
	tTnR+3+sn3LSxTnD4Y8qmyIwOyzqnKwEPzAqdyv7bCwX3f4EEnTvSq7zRaDp3EsPDm8AqIpo3sY
	sE1fzJDYn686lV81/wxl/SEK4aOGve035Cf07ojQjLd6XlfQ==
X-Received: by 2002:a05:600c:19c6:b0:480:5951:fc1e with SMTP id 5b1f17b1804b1-48519839402mr46151445e9.11.1772640046104;
        Wed, 04 Mar 2026 08:00:46 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a895553sm42331885e9.1.2026.03.04.08.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:45 -0800 (PST)
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
Subject: [PATCH net-next v3 10/13] devlink: allow devlink instance allocation without a backing device
Date: Wed,  4 Mar 2026 17:00:19 +0100
Message-ID: <20260304160022.6114-11-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 36EF920419A
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
	TAGGED_FROM(0.00)[bounces-17490-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Allow devlink_alloc_ns() to be called with dev=NULL to support
device-less devlink instances. When dev is NULL, the instance is
identified over netlink using "devlink_index" as bus_name and
the decimal index value as dev_name.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- rebased on top of __devlink_alloc() introduction
- removed dev check before dev_warn (devl_warn is used now)
- rebased on top of devlink->bus_name and devlink->dev_name removal
- rebased on top of devlink->dev_driver addition
v1->v2:
- moved DEVLINK_INDEX_BUS_NAME definition to patch #5
- added comment to dev arg that it can be NULL
- fixed the index sprintf for dev-less
---
 net/devlink/core.c          | 23 ++++++++++++++++++-----
 net/devlink/dev.c           |  8 ++++----
 net/devlink/devl_internal.h |  5 +++--
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 34eb06d88544..eeb6a71f5f56 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -250,13 +250,13 @@ EXPORT_SYMBOL_GPL(devlink_to_dev);
 
 const char *devlink_bus_name(const struct devlink *devlink)
 {
-	return devlink->dev->bus->name;
+	return devlink->dev ? devlink->dev->bus->name : DEVLINK_INDEX_BUS_NAME;
 }
 EXPORT_SYMBOL_GPL(devlink_bus_name);
 
 const char *devlink_dev_name(const struct devlink *devlink)
 {
-	return dev_name(devlink->dev);
+	return devlink->dev ? dev_name(devlink->dev) : devlink->dev_name_index;
 }
 EXPORT_SYMBOL_GPL(devlink_dev_name);
 
@@ -329,7 +329,10 @@ static void devlink_release(struct work_struct *work)
 
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
-	put_device(devlink->dev);
+	if (devlink->dev)
+		put_device(devlink->dev);
+	else
+		kfree(devlink->dev_name_index);
 	kvfree(devlink);
 }
 
@@ -432,7 +435,7 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 	static u32 last_id;
 	int ret;
 
-	WARN_ON(!ops || !dev || !dev_driver);
+	WARN_ON(!ops || !dev_driver);
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
@@ -445,7 +448,14 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 	if (ret < 0)
 		goto err_xa_alloc;
 
-	devlink->dev = get_device(dev);
+	if (dev) {
+		devlink->dev = get_device(dev);
+	} else {
+		devlink->dev_name_index = kasprintf(GFP_KERNEL, "%u", devlink->index);
+		if (!devlink->dev_name_index)
+			goto err_kasprintf;
+	}
+
 	devlink->ops = ops;
 	devlink->dev_driver = dev_driver;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
@@ -471,6 +481,8 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 
 	return devlink;
 
+err_kasprintf:
+	xa_erase(&devlinks, devlink->index);
 err_xa_alloc:
 	kvfree(devlink);
 	return NULL;
@@ -492,6 +504,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 				 size_t priv_size, struct net *net,
 				 struct device *dev)
 {
+	WARN_ON(!dev);
 	return __devlink_alloc(ops, priv_size, net, dev, dev->driver);
 }
 EXPORT_SYMBOL_GPL(devlink_alloc_ns);
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index e3a36de4f4ae..57b2b8f03543 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -453,7 +453,8 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 	 * (e.g., PCI reset) and to close possible races between these
 	 * operations and probe/remove.
 	 */
-	device_lock_assert(devlink->dev);
+	if (devlink->dev)
+		device_lock_assert(devlink->dev);
 
 	memcpy(remote_reload_stats, devlink->stats.remote_reload_stats,
 	       sizeof(remote_reload_stats));
@@ -854,7 +855,7 @@ int devlink_info_version_running_put_ext(struct devlink_info_req *req,
 }
 EXPORT_SYMBOL_GPL(devlink_info_version_running_put_ext);
 
-static int devlink_nl_driver_info_get(struct device_driver *drv,
+static int devlink_nl_driver_info_get(const struct device_driver *drv,
 				      struct devlink_info_req *req)
 {
 	if (!drv)
@@ -872,7 +873,6 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 		     enum devlink_command cmd, u32 portid,
 		     u32 seq, int flags, struct netlink_ext_ack *extack)
 {
-	struct device *dev = devlink_to_dev(devlink);
 	struct devlink_info_req req = {};
 	void *hdr;
 	int err;
@@ -892,7 +892,7 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 			goto err_cancel_msg;
 	}
 
-	err = devlink_nl_driver_info_get(dev->driver, &req);
+	err = devlink_nl_driver_info_get(devlink->dev_driver, &req);
 	if (err)
 		goto err_cancel_msg;
 
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index cb2ffef1ac2d..7dfb7cdd2d23 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -49,6 +49,7 @@ struct devlink {
 	struct xarray snapshot_ids;
 	struct devlink_dev_stats stats;
 	struct device *dev;
+	const char *dev_name_index;
 	const struct device_driver *dev_driver;
 	possible_net_t _net;
 	/* Serializes access to devlink instance specific objects such as
@@ -119,7 +120,7 @@ static inline bool devl_is_registered(struct devlink *devlink)
 
 static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
 {
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_lock(devlink->dev);
 	devl_lock(devlink);
 }
@@ -127,7 +128,7 @@ static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
 static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
 {
 	devl_unlock(devlink);
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_unlock(devlink->dev);
 }
 
-- 
2.51.1


