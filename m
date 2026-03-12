Return-Path: <linux-rdma+bounces-18092-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJfyOuGPsmlINgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18092-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:05:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F3526FFD2
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9940F302CE99
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C713C3440;
	Thu, 12 Mar 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nPFpBszh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA18E3C13E2
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309866; cv=none; b=jlukorfS8jHiCwWlJX4771S7ZISTAIK8gWqPonhJNCFlUEMvV3vgBpCBE52HWDfekNjVLV92MRxlnZT7wN/3U2xxTThM5yehQcZ6z4cA/jJyX0eYEYdVGH505SDbib+aiaRPLwfLlpYZY+/ZpnlToMZVjSBkJZDgrQVz3DcM/MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309866; c=relaxed/simple;
	bh=sBqoFY/Rv5DTMYj++KN0Sw7vm98e4uLLhQx69umkhKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax0xBr7mFIgc2WZyZyMwjOGh5Voqmjy4y9S6iirq5sCvO/BRj3Lof5eCeCBAMs3uGOkoYSACcn+p/BB/floYmdJH3cbtJJnJYz87uSPaANZQBMosqBJh1LbB5vsVVR1T6GQkuaU/B5QVF3qZO52j5CfapfAheyGktJ+JJfsxCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nPFpBszh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso665406f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309861; x=1773914661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thO3CTOoToOBK7xy8RWX7tgy+PjuAbGp4xc08ttDkvM=;
        b=nPFpBszhbGckY2T39kNhjRZLqn2FeoSdvwQca2KxEHPTVNTKUM2BBJJAVFxPTlPGti
         19TybGTrmLNtkDi6FkRZJg1g6T87yaCC2TClJLpGecTOH+EAHQDzV/GmdfkbR4AW7HR7
         vhH1AuzTKGOIIJSnjV8aecTWwl9VWDE1UfLJw6PHOZT2il61nvM472D1a8Lmae6DAUtp
         ASmeuxKJnWyM8o4m9TqCAYO70IRD40mBk+pDyoX2iSvHuSoJoL6LI+CZC+AWK47of6S0
         ak8GpnxpvSb923AqGK76YJzu9NUVZfErmIua1aJ7ZvWzz9QDGPProQaX5kuW5myRKR0u
         d7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309861; x=1773914661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thO3CTOoToOBK7xy8RWX7tgy+PjuAbGp4xc08ttDkvM=;
        b=PWwBnD7at0LiwbnA1kxFqgTu+lxhpnpcycH+r+lPxKrU3KiT9nvi6Ai0vmIRDshgnh
         F3jnxohKXXrzi4VXZyHjIV6znVXf1QexOQAkd+Hpz2tBZ4jCiAvIcXDKIjSgzIJi/XJL
         VjkzOiT5L9BCmEqOKFyogN9riugDXHXJQPA/8kVqphK3DKw6+jfDet37qQDOj/7CHBTo
         P4t3q35hq4Dh3oBAAeQWEZvuQ3aXZJBunueW98//KnGMV045Ng8/Rvw8yEVEQV6HDIiW
         QcBxGkaM4R0347CQG2wjJIwrl3ASbiePJIr3Cdesjrp9+M7ENE5cS50jJYGmd9Rc6/F9
         AxTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS/BarUst0/REDpLivyE4nFGFRHjZzBrbdsWq5xfWQ0S6M9B+CEainjvoJswPYhP13D2yLWPdQJeVs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53hN3o2mFfEUnCt0AypL5fS6N8+ag8S6E61XDi7Rug4Z+Ze1d
	7RY8KSZlPPo79k4VWew5tnzoIGGFOicHp2EF4l18LyinHWW886X3GkQ3u562bz1aixY=
X-Gm-Gg: ATEYQzxyw6a/AKa3sCdMhYa8rMybbSH+ZylaNaHlGY/uw6RRxhb8+JmM1/bvLQ+fQqm
	0D3XHx2YPabJaWP4BR8BbCD9y9slkgmZcy80Oo3YdGVGv2IT7YLTxgxkgxGShQEnnuD6PcFERIR
	pqaUg7ZJtwo93PYMHurvEUKy4hEQyVJy8hRllYCmE4I+fWQKgZjbuojRNbc7L2dbP41t6nnXIuA
	Rv5xLyvsmKC5WLq+aVq3QuhYdKE70gB0eAVmOce+Bp+RLLZcSq3dYr/MIKS7Lt0+h9EX0XoczkS
	I4db6rx8g3JHDejUEwvkbvvkuxraYY4BlNNxcpbXt2FuZXBpurFRhdXOoMtKdSKaG99n1NhjdfE
	NJQlktWlH6nD6t1FIowLMUota37Sy5otJ7WB125pySoA1iW3VyArVbd3GuKL+fCKcG6vGFSLJux
	b1bWPj1U8nwdjJ1g==
X-Received: by 2002:a05:6000:3113:b0:436:1b1:6cbd with SMTP id ffacd0b85a97d-439f81bd9dfmr10491594f8f.6.1773309860923;
        Thu, 12 Mar 2026 03:04:20 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe19abbasm6336477f8f.6.2026.03.12.03.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:20 -0700 (PDT)
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
Subject: [PATCH net-next v4 10/13] devlink: allow devlink instance allocation without a backing device
Date: Thu, 12 Mar 2026 11:04:04 +0100
Message-ID: <20260312100407.551173-11-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-18092-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B2F3526FFD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


