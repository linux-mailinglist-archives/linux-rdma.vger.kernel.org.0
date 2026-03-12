Return-Path: <linux-rdma+bounces-18086-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ILOKkOQsml5NgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18086-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:06:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 063BF270075
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86CAC317640C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD923BF699;
	Thu, 12 Mar 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="E8+SKtWF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871023BD62F
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309859; cv=none; b=lpHH6a0Q2UBUq0Izry5BG8ZSltUhxwgXdQtiT0uS1KabCnFajSR1zp6+PZN2npZW1IWKrwGcR59PeKOmeQjv6Vhk8871WgCNF6aUbX/+pK80giCqSAczGwxC4gC2rvqG4SuUlf7iw/SispJI/qVSXT9M1DYhsPmAY1QpSz03wUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309859; c=relaxed/simple;
	bh=KKgpf/IuVUhdHxdP18sDxJ2z6/oTRbCGNRlLhLLutN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgEAVzNzfit7408OktqdyZIWi9aEe7KCXxo4/l12t7um0HenR/fGvbJ7XA+PKZMdDz6DazCEQJNxYgOWm4muERq2ecxvuhD8JJXRN0splV9OZJwU5wO43GUqUwe+Ccafwwx0aDPpQ5l+hLO2v7I0HYGgenSfBZ7fu6E9w9vZ6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=E8+SKtWF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so10373485e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309855; x=1773914655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt/ZWCyMacTTa4RZa6eugwP76rLiGQg/Yv19xWzkpec=;
        b=E8+SKtWFmwDJCxiHR7D6hjewlebDTzmIX5H6aMokblPjp1kdPTCOZAlV75KmK4vPU9
         S1MKdD7SKWApcat42ALG1GNeNl6v+gALfSCMVwOZYiL/eoCG2GhxED0d066M8d1RfM2+
         XyNKfLPNqWqP/1/yJ3TjdfdvEoOW5fGju04J6PktFh2fEHDeMAAr9eEMA8v5+mc35bLc
         2foekThgTl03ePc7gC9H/WIhkQlTFHu+kawL94nkOCquUm0q9jKW0wSBWTMNs5Xe0VG+
         z50iivAWMCL2Nc3iYziO8g79ktvF0fdzlgdZDC6Een7uUjsC2DIPlWDSjyJxeFrTP8B5
         ixeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309855; x=1773914655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zt/ZWCyMacTTa4RZa6eugwP76rLiGQg/Yv19xWzkpec=;
        b=X+U8iJWTDC4siqqSlmN83trL8tC6VtZQ6Mc6VFtaMXBgtLeTJJJBACRLZ8seTju6/9
         kbSfrQCj1r5cpPFtfgck8dqTUtEBmveaAbzHYTrBKmj1qP4Twpr/fA3S/mIzLDOA5tH4
         soTvNfSHvpa0HQo2jqxdtw3p5dpja9c72All2Lw/ZL847R6E6sPS4wuKyNwujwSw3lag
         wyPfAnRNGJQT+HgUPzJkem1n9pft/Vs8z7OybyjAtlvlQJeEwmgkuLwMahgWfu3/L4cR
         y/2vIRP+DZQ7rQkc+mczxX2Aa5JzRJpfwTsHruV9Hs9SOetUQgOAxqiU1T6r4CtLyFR6
         cltg==
X-Forwarded-Encrypted: i=1; AJvYcCW1k+st9H8/9Y3Oo34eQw7cebZqMMsRQrbipMNJ8z6eATZSCS26AptRz1aMe1R7rRMk8yKi8+ySwDEQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy889w27+bsrBuKyglniS+TjqJ8pYyYl5/kfIhV7nK1DMEh8fn0
	Z/SNnbZEUxklXjnR7zAMJo5N3mBBWmmoquCxaWPGzV96LObSOnL61D/v/xeinmBfUTk=
X-Gm-Gg: ATEYQzwdlT2UA8NltEnq+4MXUVLgrkAQC8usqsT4qMQkKT5A5ugA6wFTYduVlRE9Jw1
	fUF3uX2Im0czWjS6GuGBr9ymbo2p82kJc4g8zMHHyg/lzxOkxvgWzhGj6Us/pd00DZdVPkvwG3o
	8Fb0Jodt38TIaHhhsz4ctCT3d2ljMJtTrSZhxZlUUHo7K8nGwPrUOXhtY+WeyYTF2gi2IkVE3Up
	Sw7IOFQ+6ftStjyM0amVnXtvhshaxN+T+rr8g32BBALR93RF0Dno7RrcB5iObQlzVFIJ/aZ2EI9
	avLznt3eHZM5Zg4U4ZCqbMufV88U4guxYin5ecXqGjSZrdFw4NPn8YrJM5LHcQ+4YoFRTjCEBQ8
	aolrgm3XBTxj5KLTPebJHnkcGhimmdsu+6/m6v4ZfYBoJMZWUkpEadCb9+A4ojGFRZOy3/zIiri
	37/2ycvxgQ3FAKEYPSS8ztBhnG
X-Received: by 2002:a05:600c:3e0b:b0:485:46fd:7887 with SMTP id 5b1f17b1804b1-4854b0bb5c0mr98639645e9.13.1773309854890;
        Thu, 12 Mar 2026 03:04:14 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm97596925e9.1.2026.03.12.03.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:14 -0700 (PDT)
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
Subject: [PATCH net-next v4 05/13] devlink: support index-based lookup via bus_name/dev_name handle
Date: Thu, 12 Mar 2026 11:03:59 +0100
Message-ID: <20260312100407.551173-6-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-18086-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 063BF270075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Devlink instances without a backing device use bus_name
"devlink_index" and dev_name set to the decimal index string.
When user space sends this handle, detect the pattern and perform
a direct xarray lookup by index instead of iterating all instances.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- unify return value -ENODEV even in case non-numeric dev_name
v1->v2:
- moved DEVLINK_INDEX_BUS_NAME definition here from patch #7
---
 include/uapi/linux/devlink.h | 2 ++
 net/devlink/netlink.c        | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 1ba3436db4ae..7de2d8cc862f 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -19,6 +19,8 @@
 #define DEVLINK_GENL_VERSION 0x1
 #define DEVLINK_GENL_MCGRP_CONFIG_NAME "config"
 
+#define DEVLINK_INDEX_BUS_NAME "devlink_index"
+
 enum devlink_command {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_CMD_UNSPEC,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 9cba40285de4..fa38fca22fe4 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -203,6 +203,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	busname = nla_data(attrs[DEVLINK_ATTR_BUS_NAME]);
 	devname = nla_data(attrs[DEVLINK_ATTR_DEV_NAME]);
 
+	if (!strcmp(busname, DEVLINK_INDEX_BUS_NAME)) {
+		if (kstrtoul(devname, 10, &index))
+			return ERR_PTR(-ENODEV);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
 		    strcmp(devlink_dev_name(devlink), devname) == 0)
-- 
2.51.1


