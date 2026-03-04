Return-Path: <linux-rdma+bounces-17484-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEF9FJhZqGlxtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17484-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:11:04 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FE203DD4
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 162F130C5801
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F0F35C18D;
	Wed,  4 Mar 2026 16:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="a+mo6D77"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946DC35B648
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640041; cv=none; b=rkjSyp/8vFwrsryk3UsIXAuhr0TtnP9abB+AGz8f4oliJQm5WC3sZ817w5PwwsbbUGrNc0zMsmN4Bdq8bD+1EReCQ+d4/xmMAq9Zej6K1tSquZDBhAVfx5P89OA0+keqMI9NwMFUGG4bA4+/Gi30urk0KxKmKe8Qf3zz970tZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640041; c=relaxed/simple;
	bh=7REG7e7eRo2LxU+1EFfdE+Tg/P+KtVUgE1UdHUpYeqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W7ETOpgPDYOKQ2/C6CdSp0sipg0uXfFb7ZoYeLycY6GvOAU4t+776izDCAhd96tD/DaOoK6MKR/gFhDt+9/W/ZiyFDfoBrfrx0pyFuLu1feW0KOe+usrqgHA3RhdIjZcvZ3KIrhRT61WDg+MMgWaZ2MluyU9sVz50Hah6qD6x1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=a+mo6D77; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso3363268f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640038; x=1773244838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p91XYxkA2zwDeIW6zeLvmoR6wJYLphT9dGZNIHh7FC0=;
        b=a+mo6D77gQakkEaolTxn15deziNA3EDNqfo5B2nIYDDcABV5Z2Nr0N30J/A8ht9L7l
         DYR9BzVcDr8OooS+HU5+vXfewsT8+92hnDqcYFvbRQeByGk76a/yd0R+3FRBPW356ZFX
         gUkgSvQ5m44kd9j+1LCFPS+S1WCg3jnGUeEB8kNtT40M+pCXzyNEr3Dz4jfwQeiL0uh9
         8JOvqLdGIMAA44vz4fB1qRO3SQcsWZk4QqsfziHlRhGOj2cTulsVvWFgq26K166QXK8A
         ZLRupfodJOZHzgt5WJQHemEvjGublGRwhIIL37455QhBmqnetUQT4hlq0JkIFwb3Ki1Z
         MwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640038; x=1773244838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p91XYxkA2zwDeIW6zeLvmoR6wJYLphT9dGZNIHh7FC0=;
        b=aeIB9bbjA8mIL7AwtwUWDLnF8kjaEWIMB94JmA/dqKNg0HNXBjxcuVwaIxw4dV1pgQ
         yQ+9ySORh+5YdvBX6cuNiBQBXR+LOin0o8CGw9ewNw4aVojxhapSNMCM0GfriRNW2fXa
         0gzYaoggoXUorHzAjc+Wl1jvtT19cjB9OGhco6vOAfEYfHQExTY4/Nb0xZMMRcPCIy8G
         y5RRK2kdhjohydoBPQM3Xez0Ez3Gu19tavWCq6mw780COIjdcl5mAp7B5+99ZfPvhdBn
         mVWuN3oE7ebxWYf6Gc7jX95XKVssueDJpsH96N+zYDBO43mzec6SZtW7vCIcKSLsbN+k
         WUSw==
X-Forwarded-Encrypted: i=1; AJvYcCUC6G1HFwPHisSWIyF6jtReK2wSJe9pb7Xc1BFdz6myfY9999DvQGMprP5DpHZb3Iz4QplEb/xONSq7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6lT9TJGKj00rNF0sXPFcQSPpL1ugvrR99L27uTNkBP2gke5+
	RlMEGJ62H2erQvFNLtb0Pc/WD/64SSMPoRQJPjJSTKwcAV/EXagSOz09YwleDCd8RjE=
X-Gm-Gg: ATEYQzzUwLAGLmJvzxxCwU+B2WVOEYRIJwo7VidmjZJWRUYsgpRBcETzKGmND6hkNZd
	YPakKL5rWNG8vbbeopHmERJEOwolG7w3HOnde/wA+IE2jfpskCcG0ozrbOO/uh6QjWbMQQz2Jz+
	Z6w/F9fHQgJ9Qq+NFTTLwyUY5QA8+Ri5OM7W/iQctxZkDufWAvYeaJZzlygF2Ep4zaWjGA+uHkj
	n1Tlhq3Wa0IEqndM1MmeaID2mk0n2hMnMXGPoD7uMQSYICp8ugaThyWkkSomUJUJE9CFyfkdEBs
	Z/i7kgt6bUqDQ6Pfn4DryFB0Ca2rAf2k7WdB2Yn1IfFLapHzYYxyXlPbBtY4MSAiki/hIPqned8
	VjSPm07Wo4iRiqHnAGNBWbk1IqPlmGEJUfkL0fyl1Y+tID82kdvoujap4rpQiEvCb9qtWs8qywV
	X1328Dh38rdcpPFalmpWfMD3skH/Xs5KmyK9D5/EoFFlqoqg==
X-Received: by 2002:a5d:5f91:0:b0:439:c43a:acb6 with SMTP id ffacd0b85a97d-439c7f64efdmr4412616f8f.10.1772640037350;
        Wed, 04 Mar 2026 08:00:37 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b272sm42727213f8f.24.2026.03.04.08.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:36 -0800 (PST)
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
Subject: [PATCH net-next v3 05/13] devlink: support index-based lookup via bus_name/dev_name handle
Date: Wed,  4 Mar 2026 17:00:14 +0100
Message-ID: <20260304160022.6114-6-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: F35FE203DD4
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
	TAGGED_FROM(0.00)[bounces-17484-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
index e73e39116365..5db931a0091c 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -208,6 +208,15 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
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


