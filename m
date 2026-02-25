Return-Path: <linux-rdma+bounces-17164-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLNUJQj7nmm+YAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17164-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:37:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 264711982C3
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 202D130CC8A4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6F3B9600;
	Wed, 25 Feb 2026 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="AOZtH26y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED33B9611
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026475; cv=none; b=WTrbEWzyUVgwrgOLN6FQFpRn+pI+K8UBrNLf0B4CU5rCjB0PQE/RvfZkv448pqNUYDKi8hq5ygDZRU3EwBSZxaFXTBH78OB3NMQsxTrnJ1OhJWHVH8ViF/9C5XB0vVfUcMVFIns5IEr1WQnhkbdiJTJKDyO1BQMi0fV7c9phau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026475; c=relaxed/simple;
	bh=r67EuCuSEgnlNDiIhyauM9QDSlOGLxMQaLPlJqQlJh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qI+Fp61hOkZIyDHpE4xO9ScyWr6mKXV3ICTVVZodVQhHd/jWRHTxysw4nKoCNDyeXI0SiqsOllO7o6Ij5qZ0e+aZ9oFcqqBbrYrG+8P8fg512gWgc0y/Gg4Zle2TvkzheB3zrc0SqV6tzBsDb5p98arQtWL7VH/CNTzpHv0EbbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=AOZtH26y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439857ec679so1811885f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 05:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026472; x=1772631272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/FG3Lqra/1XuudAPK85QKV8ahCltY4VeAIS2Wk1ZgA=;
        b=AOZtH26yAWQzenMcaat2LyaeVktBl+Jnj+7qC0HivzbZlq83omf8hSwpOq6FT20g3I
         Wsx6R0ZcIlIDWIUO2smLNtr8eEpHBeYiL0svrDCZkcGogkpnr89jND7jqCxZQV7yHIEu
         7i1c3k5Sga1q3MXVDIJG2JykJ+pjz9OgDbpWmS5q6Zk3qOPKKhNiPANE7XTNSWfxbIwx
         LsUgV5BFPftdNHnnq/8jjMhQaSEtnras5bLxBagybHLb5SNih1BlQZl9fipS0xr6fw9L
         O6DTRPm5tbLxdGTiBIUvjyJkiFR4A0FjaV3iK8WBUMwSWU9P9lye+ufJu23vRjx7XEH+
         rcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026472; x=1772631272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/FG3Lqra/1XuudAPK85QKV8ahCltY4VeAIS2Wk1ZgA=;
        b=Ha9e1/5VUkR29v7sykZWSKORBgxrEUIv7VTvBN+VD04Ly4ZftVIFeimMcFnn/1jyXD
         cgzmgRwl7h6zwXG+Kc81SESQLqhGPdFnbmcQAZEEUW13de5xPS+kdbkIe+Dl129vnIuM
         lJx6OvRn1QeFsymaYJbe+ibNWpMgG6papfbhoarUJ1nGNFbxQ1wGdu8OR5oJH4m6iBcG
         u1bl5sj9iHz/1hq2lOeodJddzBwRMMofwMJOeUd2wAUeGfKDt1fWcg3DJX2FIdo+e7nu
         Fppnmy6Ailt0Mle0/mKpXwpTSNq83Ag0UvaCyNDh8y4OTuxBRXZxCPJs8ysBwGyNY4vL
         xPpw==
X-Forwarded-Encrypted: i=1; AJvYcCVJA2MOvFZ9i6ZLG0AgrDM4kIk3f2O3NgxQvHNZURDXVTp4VnYg+5E4g38N4bBP3B/W4FnetUBL7iM3@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhbwfypjaeH/+jUOLOy2/I6hOMKlktTFLBEW/FrcpQ06msJfn
	TeQEJfeYqQ2xuK5SPC3RNBxPfacvGnrcA9zLosnFfYEtkOuO4d2ufmNGUuxcfgkDj9o=
X-Gm-Gg: ATEYQzw4hMjp3nK6rdaKmDzQhMyYHdON5L1mQV1vnlfpdNxHhXbhly0DJnO99XZpsmR
	G5u+BAMRfDuHgv1aVLrZkmyJztYKZIBZPLRSXAjYOj2QLMGvuAjCvflBt5JARQS0vc01FlPCXbw
	A6Vq+DyUzGGQCshjj32HWeQ0/7JmTUoNF3g6X/eUuP6Xj7lrBiK5ZQhRHsAvlCD01t2Ifb0xnbl
	/ySQzh36YtxFZ+XTlA1ds7LtP4Av/iowR66haMtzLXsic/EP7Puj9BxeDa9gV9KMsCTodGc3rRN
	cBtq+yvxuF6UKVnY4j8w7gqYqzK1eQVTpBSsP6PjkMoRd9GsO9fvK0RnFVvNdiTQWFtNTgVEfKv
	nYQ4H8VMtyV5IJ+jYWrpb2FLrPe+ZKZ325Jdn4+3glmasPwwdK1i0os+myZqZras4OklrzkwOgb
	qHjFOdCxIBUtIiHxpcVDUDu/NZ
X-Received: by 2002:a5d:5d05:0:b0:439:869a:a15 with SMTP id ffacd0b85a97d-439942fbac8mr908648f8f.42.1772026471792;
        Wed, 25 Feb 2026 05:34:31 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d401aasm33063361f8f.23.2026.02.25.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:31 -0800 (PST)
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
Subject: [PATCH net-next v2 06/10] devlink: add devlink_dev_driver_name() helper and use it in trace events
Date: Wed, 25 Feb 2026 14:34:18 +0100
Message-ID: <20260225133422.290965-7-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17164-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.969];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 264711982C3
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

In preparation to dev-less devlinks, add devlink_dev_driver_name()
that safely returns the driver name or NULL, and use it in all trace
events. The trace __string() macro handles NULL via __string_src(),
recording "(null)".

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- added missing symbol export
---
 include/net/devlink.h          |  1 +
 include/trace/events/devlink.h | 12 ++++++------
 net/devlink/core.c             |  8 ++++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index 0afb0958b910..45dec7067a8e 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1613,6 +1613,7 @@ struct devlink *priv_to_devlink(void *priv);
 struct device *devlink_to_dev(const struct devlink *devlink);
 const char *devlink_bus_name(const struct devlink *devlink);
 const char *devlink_dev_name(const struct devlink *devlink);
+const char *devlink_dev_driver_name(const struct devlink *devlink);
 
 /* Devlink instance explicit locking */
 void devl_lock(struct devlink *devlink);
diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index 32304ce9ad15..4f8edf77dfbe 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -23,7 +23,7 @@ TRACE_EVENT(devlink_hwmsg,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__field(bool, incoming)
 		__field(unsigned long, type)
 		__dynamic_array(u8, buf, len)
@@ -57,7 +57,7 @@ TRACE_EVENT(devlink_hwerr,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__field(int, err)
 		__string(msg, msg)
 		),
@@ -87,7 +87,7 @@ TRACE_EVENT(devlink_health_report,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__string(msg, msg)
 	),
@@ -118,7 +118,7 @@ TRACE_EVENT(devlink_health_recover_aborted,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__field(bool, health_state)
 		__field(u64, time_since_last_recover)
@@ -152,7 +152,7 @@ TRACE_EVENT(devlink_health_reporter_state_update,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(reporter_name, reporter_name)
 		__field(u8, new_state)
 	),
@@ -183,7 +183,7 @@ TRACE_EVENT(devlink_trap_report,
 	TP_STRUCT__entry(
 		__string(bus_name, devlink_bus_name(devlink))
 		__string(dev_name, devlink_dev_name(devlink))
-		__string(driver_name, devlink_to_dev(devlink)->driver->name)
+		__string(driver_name, devlink_dev_driver_name(devlink))
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
 		__array(char, input_dev_name, IFNAMSIZ)
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 2dd6d45bec18..85ea5856d523 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -260,6 +260,14 @@ const char *devlink_dev_name(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_dev_name);
 
+const char *devlink_dev_driver_name(const struct devlink *devlink)
+{
+	struct device *dev = devlink->dev;
+
+	return dev ? dev->driver->name : NULL;
+}
+EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
-- 
2.51.1


