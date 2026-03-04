Return-Path: <linux-rdma+bounces-17483-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CNdF/5cqGmZtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17483-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:25:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA31204301
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB8831D546F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC434EEEA;
	Wed,  4 Mar 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BJ5vkHCH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B04334EF06
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640033; cv=none; b=GTNccth6r71ojtuCYkEURuqylAfSFjqFa+KKx4ggRTRPOsm3KeK4kfz3/ZRsH30hZf1L644D9NBboDsqkPRVTuVxYDge+/gFCNIjv3jZUg3ULDc+PdxbMopNMAKsGeBCEGIRBxM852qfzHUzeCZqpuFxsdtCdvBSIFHVwHOxQgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640033; c=relaxed/simple;
	bh=BrwM4XM4KMM/lo8saPOgEzUdEI2YOnTiFYCS9aa1d5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTOL8cU+VLPOemEtlN9MBaw9H868ynCok2+y+ZFzr2/5034cE9jPHYfpGYUtGr/Me922CP9q7dQhx866bWONMJMdsN7WS6LZP0BxARiyeROWXf60JYG2VndEzGgREGn2bJWWJB66dztcoN9OZiTgBFSmcZevWRetMK37SJ4mR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BJ5vkHCH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso4074706f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640030; x=1773244830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWrXUQ1J7/v/C4aUUHZrL7KMegfL3shCNXRwtxlNqOQ=;
        b=BJ5vkHCH3/tNU+yeej5X0l0Si4c+8PTqOvkhydLzIZJ7ZqZH4XXg4DYeBh9wsJ8qTl
         fnSVze8ba4zXFLBsa4NqvZue2sUjeNsdLGOd2n6bwvpnR595aFeUw5ivHoQl5V30UM4J
         QY6Im1bT4tFOAygAfCwMSVAKryIV7X4dfgyiICVcXoumYoon5BZ592CzyXXPK/6dcTVu
         GVJs6zJhf1WwnBzNyioG/V+DL/P9GR4dKbdVDirv0GKzs0LCbPrkRllxEJwsTEJW9LVa
         aY6kOj73nlGr1XyOwJE0IpXOUAPobaLbdrKg/cbpAooAQAuljnS2HCCc2t/smBTY22Be
         Tp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640030; x=1773244830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWrXUQ1J7/v/C4aUUHZrL7KMegfL3shCNXRwtxlNqOQ=;
        b=pglZSAgjmJBezRIlDVv8Y3eI19I8zHy/CdoqsBCtls2zQm+tnjZ1D+T7l65HCmxT3c
         Uz5pH39V+TfthWadIIXLRPGHfCGyAooNlW+SMEOw/S+486EjFwqOoeDc0SDFZn9pWcp4
         Gpyg+Fl3hgMlaVhLg4lxhbZObPyiGoLSb4CAToyoQJ0vD4+BRxLRfWNRRCP5wUBd6pSD
         SQuTtTabXXqLOoz4nBmz97SJJxxCoIJKTETo24jhz6llpE60EmkR/gKY6AmUZQciJWhj
         n49KbjRJKqUPJmN/JExaptHG7C2yYE5ro9q358qpD0vKTJKuQgz6l/qbDJvD6b/G9xfH
         ugtA==
X-Forwarded-Encrypted: i=1; AJvYcCUdGhgI1QIW06o/3bPOO7EK0rx2Y2xh43BhgbmkWGnLCA4mNKJAOsrX/+R0jyIChqKzfk1nLtSUaASn@vger.kernel.org
X-Gm-Message-State: AOJu0YyZAjPKUjCTr8rOKsIxtWZs+Iglzvh7pm6ZNpBgRcxQfolGVvID
	8Z83kRgOaIE3c2ybfGTC1laJ870w9/Zo8HLRdIHilExerUQsUALMGKoc5u2mMrqF4g8=
X-Gm-Gg: ATEYQzznxiS0ei7axRWp2pVEyhStmiQWkxAvWjfDsRtW8pd8uF0zShbeNeOodJvixI4
	/MRJB+jixnwNU/2z80zEqzhvYkb7BxQJ7St5hqu+eI5t/rg2Y8C+CBAhPc/HcSzxurDeqYVqyur
	FjF26mxsNwzoMrlYCj0g48dM88v5P0dKC914ynM4MCBVZvuXIJU29kQSjsZTL6+8UBHFA5Djj5M
	frhoSVK78kSWszMlkecYjBPbs/glDgF5Qv0bgNXsHuCPSMMQApzShO3uMhiK3rfNZtrlIM+P488
	b1V0sEYgQCgXWGXtN2pNJ8ilYoQGXbkfn0KmGjLRY7JSbwq4o/BB/grr8db33ksJ4/gFQRUvwbc
	qNU2HIH1RbDd3rt2iP5Qups0Zu3o6Cdk0JTgervxaTOyc/5IpX+8Ki+8teyuJT0HwcDd7MoI9U8
	TZuMVOq/SGX91anZV+sKNxYhVTkPLE+PeQbDID6W192Jsouw==
X-Received: by 2002:a05:600c:608c:b0:477:8985:4036 with SMTP id 5b1f17b1804b1-48519847c92mr38638575e9.1.1772640028394;
        Wed, 04 Mar 2026 08:00:28 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c4489279sm12476015f8f.20.2026.03.04.08.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:27 -0800 (PST)
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
Subject: [PATCH net-next v3 02/13] devlink: add helpers to get bus_name/dev_name
Date: Wed,  4 Mar 2026 17:00:11 +0100
Message-ID: <20260304160022.6114-3-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 9EA31204301
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
	TAGGED_FROM(0.00)[bounces-17483-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Introduce devlink_bus_name() and devlink_dev_name() helpers and
convert all direct accesses to devlink->dev->bus->name and
dev_name(devlink->dev) to use them.

This prepares for dev-less devlink instances where these helpers
will be extended to handle the missing device.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- don't store bus_name/dev_name in devlink struct
---
 include/net/devlink.h          |  2 ++
 include/trace/events/devlink.h | 24 ++++++++++++------------
 net/devlink/core.c             | 12 ++++++++++++
 net/devlink/devl_internal.h    |  8 ++++----
 net/devlink/netlink.c          |  4 ++--
 net/devlink/port.c             |  4 ++--
 6 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..0afb0958b910 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1611,6 +1611,8 @@ struct devlink_ops {
 void *devlink_priv(struct devlink *devlink);
 struct devlink *priv_to_devlink(void *priv);
 struct device *devlink_to_dev(const struct devlink *devlink);
+const char *devlink_bus_name(const struct devlink *devlink);
+const char *devlink_dev_name(const struct devlink *devlink);
 
 /* Devlink instance explicit locking */
 void devl_lock(struct devlink *devlink);
diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index f241e204fe6b..32304ce9ad15 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -21,8 +21,8 @@ TRACE_EVENT(devlink_hwmsg,
 	TP_ARGS(devlink, incoming, type, buf, len),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__field(bool, incoming)
 		__field(unsigned long, type)
@@ -55,8 +55,8 @@ TRACE_EVENT(devlink_hwerr,
 	TP_ARGS(devlink, err, msg),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__field(int, err)
 		__string(msg, msg)
@@ -85,8 +85,8 @@ TRACE_EVENT(devlink_health_report,
 	TP_ARGS(devlink, reporter_name, msg),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__string(msg, msg)
@@ -116,8 +116,8 @@ TRACE_EVENT(devlink_health_recover_aborted,
 	TP_ARGS(devlink, reporter_name, health_state, time_since_last_recover),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__field(bool, health_state)
@@ -150,8 +150,8 @@ TRACE_EVENT(devlink_health_reporter_state_update,
 	TP_ARGS(devlink, reporter_name, new_state),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(reporter_name, reporter_name)
 		__field(u8, new_state)
@@ -181,8 +181,8 @@ TRACE_EVENT(devlink_trap_report,
 	TP_ARGS(devlink, skb, metadata),
 
 	TP_STRUCT__entry(
-		__string(bus_name, devlink_to_dev(devlink)->bus->name)
-		__string(dev_name, dev_name(devlink_to_dev(devlink)))
+		__string(bus_name, devlink_bus_name(devlink))
+		__string(dev_name, devlink_dev_name(devlink))
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
diff --git a/net/devlink/core.c b/net/devlink/core.c
index d8e509a669bf..63709c132a7c 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -248,6 +248,18 @@ struct device *devlink_to_dev(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_to_dev);
 
+const char *devlink_bus_name(const struct devlink *devlink)
+{
+	return devlink->dev->bus->name;
+}
+EXPORT_SYMBOL_GPL(devlink_bus_name);
+
+const char *devlink_dev_name(const struct devlink *devlink)
+{
+	return dev_name(devlink->dev);
+}
+EXPORT_SYMBOL_GPL(devlink_dev_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 31fa98af418e..1b770de0313e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -174,9 +174,9 @@ devlink_dump_state(struct netlink_callback *cb)
 static inline int
 devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 {
-	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink->dev->bus->name))
+	if (nla_put_string(msg, DEVLINK_ATTR_BUS_NAME, devlink_bus_name(devlink)))
 		return -EMSGSIZE;
-	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
+	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, devlink_dev_name(devlink)))
 		return -EMSGSIZE;
 	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
 		return -EMSGSIZE;
@@ -211,8 +211,8 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 					    struct devlink *devlink)
 {
 	memset(desc, 0, sizeof(*desc));
-	desc->bus_name = devlink->dev->bus->name;
-	desc->dev_name = dev_name(devlink->dev);
+	desc->bus_name = devlink_bus_name(devlink);
+	desc->dev_name = devlink_dev_name(devlink);
 }
 
 static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..56817b85a3f9 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -193,8 +193,8 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
-		if (strcmp(devlink->dev->bus->name, busname) == 0 &&
-		    strcmp(dev_name(devlink->dev), devname) == 0) {
+		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
+		    strcmp(devlink_dev_name(devlink), devname) == 0) {
 			devl_dev_lock(devlink, dev_lock);
 			if (devl_is_registered(devlink))
 				return devlink;
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 1ff609571ea4..fa3e1597711b 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -220,8 +220,8 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 {
 	struct devlink *devlink = devlink_port->devlink;
 
-	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
-	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	return nla_total_size(strlen(devlink_bus_name(devlink)) + 1) /* DEVLINK_ATTR_BUS_NAME */
+	     + nla_total_size(strlen(devlink_dev_name(devlink)) + 1) /* DEVLINK_ATTR_DEV_NAME */
 	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
-- 
2.51.1


