Return-Path: <linux-rdma+bounces-17166-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJvAHbT6nmm+YAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17166-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:35:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1568E198273
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C11CD303AA8D
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BCD3B961B;
	Wed, 25 Feb 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="r54+NJnx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1E83C1981
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026476; cv=none; b=gxdum9VUhTikxT+RfE9C2vonWHGZylow/ddYoCllqdgzjmwKO3T9mYRQtqdZha0bs3RGoICndUOP/z6+3cTjBJgna4jav/CQnRt3RxXnt/v6vZd3/vrPXbj0lO665O50/XZo2pcC/62/jkhSjI2q9S72ldqTXoHEkgad/OHVK/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026476; c=relaxed/simple;
	bh=W0h+Gw3i0X5fB0cIrXBdZOWGoeYvzVloh7Qvtqw2/xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSgbDGGC8l7NOIziGvO4SelYTtCtkfDuRNpi1WEMvH4OIxojfamOg/beRYqWlBuhF/ycZq6hE9otynYQ8YURZnoEbt9VPFqqDAs05v5VFr4FqI663ZT5Z8upyDbzPIzajVUICzU5PZGBr/A42y2hWqwNMOfzkG8SKEQ5l77mYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=r54+NJnx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso52317045e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026473; x=1772631273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/vYct8/33M9QQ+Vp9qSu2wuLu++aTJrTmpx2guIHLU=;
        b=r54+NJnxmmEwP41oNgXGB5ceLWS5/8VWvfCMhEvyXK07gR+lftuAgdG2R2mb06xQer
         sYJ9d1eQMJkG0WgS1+upLrLUnOjZBHYAdTY7OSjA3gGkcdsf9rr2tbLxO4+uUMbmRLTT
         zpfFQCMO+PBWSfy5gCG5BimmYVtWRqgnTb7JVpMyzLaG3O9R9kTFi+Q0/XWGLdSgx754
         lT5rY7np2PCZPToikgIk9BA07MwBlFpw94Q5JJL/V1squS5dc0icryXCvdd22FwA/5rq
         oSGdXCyOH5h4SF/3o/vAKKI32hxnY0gZ0OmW28Yqb//xe3LaISBOadZ9rLIk1CoY19da
         Xwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026473; x=1772631273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/vYct8/33M9QQ+Vp9qSu2wuLu++aTJrTmpx2guIHLU=;
        b=LNMAwfSv58cWgsMy4ZjFwk5ULrY06ObhAD6XaHjBbJ6ANTuFQ1aPqdwRk1dqCssOs4
         zqQqss0v7rFwL3edk0bvHZeWz9UWoL2rSTQ1d8+QvWi8ot6XFzUdWnKTrD+ZSfEesVcP
         mjZz5pWdo1OhJReE2l2YQmiIg7u514iJZ1gK5RgI3/i8hLTJIn82s2oV0lU4GRwIyfD6
         sje/sHPEGVv77eyd2JQef3QqY94GXTu/d6/cv9437++l7VioPIPkdiorY2pdRCvNhPct
         nV8s3xFPxdae4GrFk3WljehQ21lsdc2pjWOfLIFR9EC3jG+Hhy5aDSC3Tl6bkU5tD3Yc
         I32Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqO3fcLIpAPrHm3OUTfUAaq4vY7pCLG0d+yA6Z5gzkVFXevwVgwAidAX2DsTwxwQh3dyGtpoZybBA3@vger.kernel.org
X-Gm-Message-State: AOJu0YxvqDOz3ejwCVE12NUeN3tIhiPTYBlgaK6hAJBbXj6IIshB6bE+
	EbJdDyqFn3HfNOkUZsoAwFy2TdG5y0SQCJZE/e3K7OTQXtWH8M2x6aLGHJrLpehuGO8=
X-Gm-Gg: ATEYQzwNBmP5XKZnGgSeZFnoEYkhDINNlQAkWugcvE0GlB0VKrJHBHS83hctIIDpoeh
	xHzxh9WbJlcZWtlFKhe4C48Le7mcN7AopAx/VPNtHWjFk8whgL3seCnQtpzytd23cBmGJD4aXkc
	qlZ7YNvhMQdw7q6hF1wvkYjLIx7bEbzhmoTlw0mmfjpE+D14qVAzPPulNaRfvwsHeMPpjSqx9YX
	ZMG0L6WYv5bPR1kQCKIbo2imD7ldmZYuugECcGdxAGlngiG/2psh1q4OMcGe7E7wJB8kEWQ6MQW
	aVVCrHrI4QAMoYT9Yd6dxfK3Aq/MKkMcCS9YyjGWdCwadSuH3RON7F5rU/pdylDX8ccQ0TJdHXZ
	Vn40eCfIhDxjrCbnIoNzlEMVbJdFa0mr/27ZPaaJt0FBv/Fr3NrY/Shj0Da7LK+kpkSbIxIdqVJ
	ugQpFRujRU8VxAKA==
X-Received: by 2002:a05:600c:190f:b0:477:9a28:b0a4 with SMTP id 5b1f17b1804b1-483a95574c5mr269548815e9.0.1772026472996;
        Wed, 25 Feb 2026 05:34:32 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd733706sm68868485e9.13.2026.02.25.05.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:32 -0800 (PST)
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
Subject: [PATCH net-next v2 07/10] devlink: allow devlink instance allocation without a backing device
Date: Wed, 25 Feb 2026 14:34:19 +0100
Message-ID: <20260225133422.290965-8-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17166-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.966];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli.us:mid,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 1568E198273
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Allow devlink_alloc_ns() to be called with dev=NULL to support
device-less devlink instances. When dev is NULL, the instance is
identified over netlink using "devlink_index" as bus_name and
the decimal index value as dev_name.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- moved DEVLINK_INDEX_BUS_NAME definition to patch #5
- added comment to dev arg that it can be NULL
- fixed the index sprintf for dev-less
---
 net/devlink/core.c          | 25 +++++++++++++++++++------
 net/devlink/dev.c           | 11 +++++++----
 net/devlink/devl_internal.h |  4 ++--
 net/devlink/port.c          | 14 +++++++++-----
 4 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index 85ea5856d523..e931e66aa3a2 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -331,7 +331,10 @@ static void devlink_release(struct work_struct *work)
 
 	mutex_destroy(&devlink->lock);
 	lockdep_unregister_key(&devlink->lock_key);
-	put_device(devlink->dev);
+	if (devlink->dev)
+		put_device(devlink->dev);
+	else
+		kfree(devlink->dev_name);
 	kvfree(devlink);
 }
 
@@ -433,7 +436,7 @@ EXPORT_SYMBOL_GPL(devlink_unregister);
  *	@ops: ops
  *	@priv_size: size of user private data
  *	@net: net namespace
- *	@dev: parent device
+ *	@dev: parent device, or NULL for a device-less devlink instance
  *
  *	Allocate new devlink instance resources, including devlink index
  *	and name.
@@ -446,7 +449,7 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	static u32 last_id;
 	int ret;
 
-	WARN_ON(!ops || !dev);
+	WARN_ON(!ops);
 	if (!devlink_reload_actions_valid(ops))
 		return NULL;
 
@@ -459,9 +462,17 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 	if (ret < 0)
 		goto err_xa_alloc;
 
-	devlink->dev = get_device(dev);
-	devlink->bus_name = dev->bus->name;
-	devlink->dev_name = dev_name(dev);
+	if (dev) {
+		devlink->dev = get_device(dev);
+		devlink->bus_name = dev->bus->name;
+		devlink->dev_name = dev_name(dev);
+	} else {
+		devlink->bus_name = DEVLINK_INDEX_BUS_NAME;
+		devlink->dev_name = kasprintf(GFP_KERNEL, "%u", devlink->index);
+		if (!devlink->dev_name)
+			goto err_kasprintf;
+	}
+
 	devlink->ops = ops;
 	xa_init_flags(&devlink->ports, XA_FLAGS_ALLOC);
 	xa_init_flags(&devlink->params, XA_FLAGS_ALLOC);
@@ -486,6 +497,8 @@ struct devlink *devlink_alloc_ns(const struct devlink_ops *ops,
 
 	return devlink;
 
+err_kasprintf:
+	xa_erase(&devlinks, devlink->index);
 err_xa_alloc:
 	kvfree(devlink);
 	return NULL;
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index e3a36de4f4ae..b63597312bbd 100644
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
@@ -892,9 +893,11 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 			goto err_cancel_msg;
 	}
 
-	err = devlink_nl_driver_info_get(dev->driver, &req);
-	if (err)
-		goto err_cancel_msg;
+	if (dev) {
+		err = devlink_nl_driver_info_get(dev->driver, &req);
+		if (err)
+			goto err_cancel_msg;
+	}
 
 	genlmsg_end(msg, hdr);
 	return 0;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 67425c5d8cfc..89d08fd511cb 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -107,7 +107,7 @@ static inline bool devl_is_registered(struct devlink *devlink)
 
 static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
 {
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_lock(devlink->dev);
 	devl_lock(devlink);
 }
@@ -115,7 +115,7 @@ static inline void devl_dev_lock(struct devlink *devlink, bool dev_lock)
 static inline void devl_dev_unlock(struct devlink *devlink, bool dev_lock)
 {
 	devl_unlock(devlink);
-	if (dev_lock)
+	if (dev_lock && devlink->dev)
 		device_unlock(devlink->dev);
 }
 
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1d4a79c6d4d3..f19b690ebe7e 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -976,7 +976,9 @@ static void devlink_port_type_warn(struct work_struct *work)
 	struct devlink_port *port = container_of(to_delayed_work(work),
 						 struct devlink_port,
 						 type_warn_dw);
-	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
+	if (port->devlink->dev)
+		dev_warn(port->devlink->dev,
+			 "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
@@ -1242,9 +1244,10 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
  */
 void devlink_port_type_eth_set(struct devlink_port *devlink_port)
 {
-	dev_warn(devlink_port->devlink->dev,
-		 "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
-		 devlink_port->index);
+	if (devlink_port->devlink->dev)
+		dev_warn(devlink_port->devlink->dev,
+			 "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
+			 devlink_port->index);
 	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_ETH, NULL);
 }
 EXPORT_SYMBOL_GPL(devlink_port_type_eth_set);
@@ -1272,7 +1275,8 @@ EXPORT_SYMBOL_GPL(devlink_port_type_ib_set);
  */
 void devlink_port_type_clear(struct devlink_port *devlink_port)
 {
-	if (devlink_port->type == DEVLINK_PORT_TYPE_ETH)
+	if (devlink_port->type == DEVLINK_PORT_TYPE_ETH &&
+	    devlink_port->devlink->dev)
 		dev_warn(devlink_port->devlink->dev,
 			 "devlink port type for port %d cleared without a software interface reference, device type not supported by the kernel?\n",
 			 devlink_port->index);
-- 
2.51.1


