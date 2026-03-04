Return-Path: <linux-rdma+bounces-17487-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAYHA6xZqGlxtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17487-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:11:24 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD414203E08
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9E0830C81E4
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCCF35CB6D;
	Wed,  4 Mar 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="u4p0zvjt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2135CB62
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640046; cv=none; b=muTfDfRWX3hhwXfI0NIBFE09lp8+JMBX6ML65M9GbQkMmAEru2knjxvyV0Qhq6bR4qOZRPOpGyuUqNG7hvTxb1F07i/elEE1uA6UWv84vFyoYR9w9BDNcz34liAPZZ4ondoaGJRMy1Eqhn5AgLc6k5AjWbVTt3Sn+NI8pAOgsLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640046; c=relaxed/simple;
	bh=xLsXwuVt8lGwGVFFyvY2JOLZOXAAfQeVNQWGZqC43oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQVlk8D6lqBsrCD41IzA9TXmjkC6jVSRaUMA2zLNKeTvdSiZmmlRhNm6L4AyjyfYHeNhgFgPmRlCB1WjMEGITAzcrDvGuuGE4oYuz5C3nc/xDv8GEHeokDRETjtiiOpLh3dDpvvlyjvZy4+eVfT8khVXFTCtEgmRd+Zbk8MZcn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=u4p0zvjt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso2651939f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640043; x=1773244843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCm7aN6GgQ9bQDL2tV38A52iqAWlIVq3d7H/Br7Cpdk=;
        b=u4p0zvjtV6a+Pt8dH+ZaS370YGWg9nTKM7pxNI53G/AEhMRIbPg2zVFqNgl9RxD1et
         phInIfD9SfsfCARb3SD/H4dr7rAfwLgYvwhIpmFe9q8iQ40KSfHhbct2xjLMYjTkql7b
         GRQ0kIckJmc6zIQJTdTWhKDP+uc33g4M+UMwzYDcv93b6EAiTB2ek122hvVll4Lx+LcK
         lVlZTExOJSse3Wo/aF8WsXh2/JeS3vnF3Z6lrUkqggDp4OKt+v+L/dT5STVm7uEx8NEj
         964z+CuNW/MQfS/FbDMEkR3kA73yg+48qx2U6QItWOV80nc+Dfz2GAOqq+jxztVU3IjP
         Bl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640043; x=1773244843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCm7aN6GgQ9bQDL2tV38A52iqAWlIVq3d7H/Br7Cpdk=;
        b=XpAduxn5Xa4e1ysXYDW/11oSXizfrNn7gAOJwN8owsmyKCU2jliZQVX08TZBePEysf
         rKH9iZdd6DJ1jxhSUib4CzqHfuIwWFu7GC5BqtoQKUZAWQ9oq4rjgOsh/TWX0mPTJPgv
         yOFrNiUle9cM2L9wSQXkQeAxwFA+pB4Q2cRTek1XQYhaGfz34R2oWf+4+iB0K6uNIPJT
         hhXvuYCZHXxKzfujr7xPwcWhbVxYFHLv9atJ/FgtC8aVIajoFS998CVuZWq0sw026Eha
         Xg7KKdFKe8V9Ofz3KvdUtnkSSvBaN/Zsx2ZdE7O+aJjo8nDWR+DF1KWaBPXsuJD6GFtB
         McCg==
X-Forwarded-Encrypted: i=1; AJvYcCVeGuJtvtT3DQ0sGlQ01xf/TOl48zl0lcv/Li/LTFHtMy9qmS2JfJie1OD0lYqUi/W+3+oiFySPWDMB@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCPY2zorMrX92lwSHFG0h1GfbghmPU23hrECw3SBNpxCXyuJ0
	VFWu6QG03hgcnYJ/QuTAawF4FjlUQifqqhjyz42zn8Y3bWQ1rEc3T9D4xI4IHwo0Hg0=
X-Gm-Gg: ATEYQzzOoagjibx5L4boBqjFt5rvbE4sHLU8bkyxhu5KqCBn8Jr+kGQdtU2McGM+8Rq
	2jBsJ77vy5dOvQYCc38m5zMcM7fKEr3afGECVWletavJteD1Y1PHveTgX72E0fqNTgbztrxOpIT
	OtNFBKUFBPji0+kQgP5oPU2PueVdFR/XdCiq23iYeW/Cc9GT6mE65Irp2IpQYYUmy70cdQOpWZb
	MpTek5JXWf/BIfptZBdUt8I3hwbGAeteY2LPb+U9kDV4QYLB7T5ntBk8IGOJTBwLS6cJLueMsRF
	CM23hNS76n5/5l/z3tzgbgNj9N4v+JA8RRggJa2c4Wg4KmXzjHagUO7rzOfy6eaXyRM6sy1GpUN
	nkloOW0V40nwkOW8JfE3WqPjTRK9PFU2UkF6a/WfbS71GWaVIQDs1qZHMsNnQA6OHP2/4p58zKA
	QKb4yl0rPOzEVvVN8shUfwMoQVad2/+mRhCeqUuXGJPJNcIQ==
X-Received: by 2002:a05:600c:138c:b0:47e:e952:86c9 with SMTP id 5b1f17b1804b1-485197e7678mr46704165e9.0.1772640043013;
        Wed, 04 Mar 2026 08:00:43 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ba2a5970sm20634679f8f.33.2026.03.04.08.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:42 -0800 (PST)
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
Subject: [PATCH net-next v3 08/13] devlink: add devlink_dev_driver_name() helper and use it in trace events
Date: Wed,  4 Mar 2026 17:00:17 +0100
Message-ID: <20260304160022.6114-9-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: DD414203E08
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
	TAGGED_FROM(0.00)[bounces-17487-lists,linux-rdma=lfdr.de];
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

In preparation to dev-less devlinks, add devlink_dev_driver_name()
that returns the driver name stored in devlink struct, and use it in
all trace events.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- using stored devlink->dev_driver
v1->v2:
- added missing symbol export
---
 include/net/devlink.h          |  1 +
 include/trace/events/devlink.h | 12 ++++++------
 net/devlink/core.c             |  6 ++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

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
index fcb73d3e56aa..34eb06d88544 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -260,6 +260,12 @@ const char *devlink_dev_name(const struct devlink *devlink)
 }
 EXPORT_SYMBOL_GPL(devlink_dev_name);
 
+const char *devlink_dev_driver_name(const struct devlink *devlink)
+{
+	return devlink->dev_driver->name;
+}
+EXPORT_SYMBOL_GPL(devlink_dev_driver_name);
+
 struct net *devlink_net(const struct devlink *devlink)
 {
 	return read_pnet(&devlink->_net);
-- 
2.51.1


