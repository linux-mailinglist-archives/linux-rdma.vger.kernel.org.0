Return-Path: <linux-rdma+bounces-18091-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGNYC6yQsml5NgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18091-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:08:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 869B5270153
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 777EE31E3969
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15243C197C;
	Thu, 12 Mar 2026 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Fg9svybA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F303BFE4D
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309863; cv=none; b=snUPjDCNkIlk0cei4oYoo3l8kOHND1ku/LnNFxbX5IuYMAAY/zz+oGJwGmzvquE7xozPc7a3pD7M+mUqckqJ7I1f5z5c6nPLFBkjvWXHIOs4I8ymUzXoPjMSJo3x5FF8eDw96MQxb3AjwJyLGJM8G2nhjObp/lG6CMJEpJfEPvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309863; c=relaxed/simple;
	bh=1WRGLRV1Mf3gtLoQpSz/WpelFSk3nN1ML07ryNxiF/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3wWOqXrFgZ6TRhUcWdQoJ3dq26MgAiL/5ldgz4gt8BnrG7wiZc0rpsRmAzPKEQdscXNhEZ2cnWFkcRyXZ+tzobAvKEK6EfVjNpY6LIKsy3V6CGKNNDqJJQZscSQmMp/4zeZ+OquFUaI4F87a9rxjMN+Vu501KxyHzKD/L5kvmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Fg9svybA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b8a3f2bcso665370f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309860; x=1773914660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPMyjPKUIKGGoXPsQ6f7ReT1eeW8YNhjgt1YhvCXpE0=;
        b=Fg9svybAcoL/8W3TMV8UD1aita997P0m/lDmRNhHElXkBbE1/WCbgS7iQoLWF2/H5L
         9ALqht8tNXwyv6UehXx0G3Y0kM33W2jUX+egpH/Q/Jjr8nB0srr9XmehLdJF03P8hWso
         IEDck8AQ/u81W/ZsY2i1oRmrTPuOasmrsUHto7QCdwPPz50+4O9QxQ3jLBTan2qHidna
         oX7pa5OGcOzUu2Sla73tAJFcGnMseXEgnEKjf8yS2OIXQQuHqnRU8YmDuv6mG7f8v3/T
         zwSgH2wICBZpf5koM7412QWwXJFyqGNYKrSPgyNQHY+hMfEONAQjyrCALRF8OEj0/8dB
         Chiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309860; x=1773914660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MPMyjPKUIKGGoXPsQ6f7ReT1eeW8YNhjgt1YhvCXpE0=;
        b=nAzlicoV52frjEL7JfYm9Xr2pk6+x0YFb9hmeYhH/UP4YroVLvN1VivQNZHW9WQPzc
         7i9P1nZJhwqPe4hvg8TKC028cjaRjLNUqz0ljI697puwUONjv9BEcHd/tMgHjFsSo8Jk
         x53VTj3G1BGG56P+3ArS+13uQ0MRG9dQdm135qOsJhBoMIlxZtZ4+6ft9utX7cmk+3Gn
         +OdVMQY39EgywP5foMhalpY4ug225pXPRhtnNh+tIfjsLa6VdnHNe0JMNSDDCiDS5i8C
         6NZVDBl1jIkvQsDVaFq1ch/zsZWmx5HABd+NKSQ+CjkjPm0Xj5JJE4Ae3PA8i0QoyzOj
         +FaA==
X-Forwarded-Encrypted: i=1; AJvYcCWDGRpAXTzylo2lDuqdacyLAA09yHkeW46KqkVMY+MoUgkfR/3uMf+39Rb/GEKyvzDoVyhFMQ1Q+tHk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/XklOy6TPTY4iWjHIOyROHZEKvpeM8j277z0XBaa3dZTiOanr
	tkQi2qjn9YdKL1ojeYEZk0x3CYaoACzeH7h/BDaoPyNOTsvr/wy/kXFoLgBR7rLgjl4=
X-Gm-Gg: ATEYQzwGb3cEw+fQ49jCS/Hx1P0ThcViH+sruvY3oaC9GwE9h8benp1BnuMM+ihHYar
	E2SwlfmwhcMZFjhWo/xWzG+3tKcLhYdlzU3VbGUPnyV1vUII2jmW7Y6jj8fp0AYXAKmInyZRyT7
	WctTS/jtdLl6GJ05JJResb1Qlow2BhVAw2okM6EgzpTdK08MaCD8iq60Egz5bfNTE5tIcl3EVRr
	vlyHDSHuxjUywM6LyEeiWEkLyjV5KKJz0pmvPNiH7iO0vDJo3mxi+qRyy/SVGYxRQHK7fr3Iygb
	Ep6GPR5YWYyWJyee6pCUlcbBYFSmUejcaAX16RaXEi0aidA5gKsBH91dB1jKdI/7PifNeJUHmjv
	py6R7gLUtlrZFhfzyGOZbgwDBFPg4XGVCgPTLbKceEp1kW5na1tORoIS3SETvmW1xLQWVVB5PGR
	IclTTvwfjJz5W2SQ==
X-Received: by 2002:a05:6000:2681:b0:439:cb9f:d635 with SMTP id ffacd0b85a97d-439f8223054mr10822988f8f.46.1773309859695;
        Thu, 12 Mar 2026 03:04:19 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a737csm6305802f8f.10.2026.03.12.03.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:19 -0700 (PDT)
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
Subject: [PATCH net-next v4 09/13] devlink: add devl_warn() helper and use it in port warnings
Date: Thu, 12 Mar 2026 11:04:03 +0100
Message-ID: <20260312100407.551173-10-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-18091-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 869B5270153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Introduce devl_warn() macro that uses dev_warn() when a backing
device is available and falls back to pr_warn() otherwise. Convert
all dev_warn() calls in port.c to use it, preparing for devlink
instances without a backing device.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/devl_internal.h |  9 +++++++++
 net/devlink/port.c          | 14 +++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 3cc7e696e0fd..cb2ffef1ac2d 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -71,6 +71,15 @@ struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				struct net *net, struct device *dev,
 				const struct device_driver *dev_driver);
 
+#define devl_warn(devlink, format, args...)				\
+	do {								\
+		if ((devlink)->dev)					\
+			dev_warn((devlink)->dev, format, ##args);	\
+		else							\
+			pr_warn("devlink (%s): " format,		\
+				devlink_dev_name(devlink), ##args);	\
+	} while (0)
+
 /* devlink instances are open to the access from the user space after
  * devlink_register() call. Such logical barrier allows us to have certain
  * expectations related to locking.
diff --git a/net/devlink/port.c b/net/devlink/port.c
index fa3e1597711b..7fcd1d3ed44c 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -976,7 +976,7 @@ static void devlink_port_type_warn(struct work_struct *work)
 	struct devlink_port *port = container_of(to_delayed_work(work),
 						 struct devlink_port,
 						 type_warn_dw);
-	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
+	devl_warn(port->devlink, "Type was not set for devlink port.");
 }
 
 static bool devlink_port_type_should_warn(struct devlink_port *devlink_port)
@@ -1242,9 +1242,9 @@ static void __devlink_port_type_set(struct devlink_port *devlink_port,
  */
 void devlink_port_type_eth_set(struct devlink_port *devlink_port)
 {
-	dev_warn(devlink_port->devlink->dev,
-		 "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
-		 devlink_port->index);
+	devl_warn(devlink_port->devlink,
+		  "devlink port type for port %d set to Ethernet without a software interface reference, device type not supported by the kernel?\n",
+		  devlink_port->index);
 	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_ETH, NULL);
 }
 EXPORT_SYMBOL_GPL(devlink_port_type_eth_set);
@@ -1273,9 +1273,9 @@ EXPORT_SYMBOL_GPL(devlink_port_type_ib_set);
 void devlink_port_type_clear(struct devlink_port *devlink_port)
 {
 	if (devlink_port->type == DEVLINK_PORT_TYPE_ETH)
-		dev_warn(devlink_port->devlink->dev,
-			 "devlink port type for port %d cleared without a software interface reference, device type not supported by the kernel?\n",
-			 devlink_port->index);
+		devl_warn(devlink_port->devlink,
+			  "devlink port type for port %d cleared without a software interface reference, device type not supported by the kernel?\n",
+			  devlink_port->index);
 	__devlink_port_type_set(devlink_port, DEVLINK_PORT_TYPE_NOTSET, NULL);
 }
 EXPORT_SYMBOL_GPL(devlink_port_type_clear);
-- 
2.51.1


