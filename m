Return-Path: <linux-rdma+bounces-18085-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4G6/DxOQsml5NgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18085-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:06:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94940270042
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CB883132ED4
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E18D3BED6A;
	Thu, 12 Mar 2026 10:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UuGFrvqL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4153BD259
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309855; cv=none; b=a6hNJu66JRf+WNXTbH12LGnF++M0AkK6di/G7U+4uygD7P3n0r9g00KUMS6TcoCFb81pCsc1RioVz7ulIbQgLSHmQXNwCohf7CXMEGIz72eViaaShmdTELGDm2n6TtJ00nfUK06v2X+MdodDedUg06Cp828KVp7m+BeuOWIygRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309855; c=relaxed/simple;
	bh=Vtm80qE6FuR56bwzyqwTxutZyqLSGPZTe2b3PkwM178=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3StECO5Wj/5QayUUi2W6CiiKZ5ZdChoNcnP7SP8DWVvEcCK07LGd063zLNc4aT41TDfAt1ZU4RROYeuusSv98CCfbTo6Na4Ckz8u9qab1Ezf6aTh/GhJ52f0DpwdFF5jOWQbnyi+ramS4J9YuKdtLx+JimwkAt1+Ih132mYTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UuGFrvqL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso6440625e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309853; x=1773914653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=UuGFrvqLIk2QH17vam2M68KVzf4VxO9Okf4knKwat2Ghw6FJ7A4oAd1vwOtks37Uz/
         olYnXO3NIUYECNqFEbMrULA/rKd+DMX+1LM0KJlB/vWO2xlL5UwOsT4CmmVhYfFc90Wd
         JPtb6eP9wLzHKPOiazn+gr4DCJtiDm2WAyLffki1EwahEsfo20F//LbPU7wWbn5KDSOQ
         5smyc+m62FrVpBUl7FbDlCFbDb9tq7/r8oQHID5EPeXhCs0CkEuP+fT/UC3ES07v9unw
         Edv2a2TzrEOA7CYxIguTkXJAZCjLGXJ6gu8Ez5sQyyQAs5yY0TXKtJoim+m+Juls1B6C
         ki9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309853; x=1773914653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=RRUVj3iejKN2/WFbnpH4n09tqSQVBfEjBkyaNie7f7DiZpH0Vo3wO4XjHffTH+n4U/
         zOf333E1E4HxW0Sg9nUyB0gfNze+6nq0HmREjKKAk2HAbjBgSZKVDjPe53VkpGR9Qd+K
         fObLgC8xAoEu3HqqFW875M/Uix/GlqptE6TDow8Bvr2jf2BTqOHWGz5Ayt9thIVaxUDn
         e6I+Whic9vff9xIsLX+1v3NQgug4DxtBhFURiXguwyt4kukN/DPMdhmvDFmJYuxaqHsL
         ennGw2A+XeF/TcfDULT5Qrs4kvpJ6xvOhP5Ofvs2SCN5J1qe2kPDgyhyBZKBHDiD7VZv
         0ZwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwdRW8DbZCDdsFPyAetJyT/xans5lgf2NsjZN974b+kvjtBUrV5FYSt9Slxwh5IDB1dLWZeiTg5gen@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEcG5NjAwufh2P6mvsTbZpL5sKIa0BYQQp+nSTOo8m/mWNR01
	OllVnJL1Z4H+PU1fVxOtklCOSBknUE+U9v+d+zY0d11iOxuOJX5lhvMNloHJ8rRiwOU=
X-Gm-Gg: ATEYQzyraz301M87ONwh77wE1sLQM4AgUScp+lArnuEjJRjUZjOUY6CNzpz0oCQLn9W
	zFB92jgvpuB5afWPM89UgCZbeiK1xqsyJKs+qbJR82FAiYJkCuB7wWxgHCTccl0sJYhc8YCwaC9
	ZjBDzVv7LWDxMe9WKZH32CZsp7lRDXCG/z9t/dzHoPO8fSarkUCDs7jYFD5zhs4Dn3ngZP6qpRg
	4bpQJB1m02LcogcwB6IsCfzj483060lDvSEV92NsVTrsE59Y31eTpOa8MqMAGR0TDEuZ3DrakwC
	P0Kacz/+8Yr1qk17/phlRNQLEKKgfF/7E2cP2AEAwfP5onSaX4qMUHU/EnOv0EGqkWISZ7prgJQ
	Czy4rFsfCKxYnesHyG6XtOc5FsCIUlGDySI/J3DJWvPaLdRgqfsW8LWey3aIcygYEE9rnEFZEUb
	9dViUkLH2ZmN8QZw==
X-Received: by 2002:a05:600c:458e:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-4854b0ac93fmr85263525e9.1.1773309852339;
        Thu, 12 Mar 2026 03:04:12 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm304199535e9.2.2026.03.12.03.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:11 -0700 (PDT)
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
Subject: [PATCH net-next v4 03/13] devlink: avoid extra iterations when found devlink is not registered
Date: Thu, 12 Mar 2026 11:03:57 +0100
Message-ID: <20260312100407.551173-4-jiri@resnulli.us>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18085-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 94940270042
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Since the one found is not registered, very unlikely another one with
the same bus_name/dev_name is going to be found. Stop right away and
prepare common "found" path for the follow-up patch.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/netlink.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 56817b85a3f9..7b205f677b7a 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -194,16 +194,20 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink_bus_name(devlink), busname) == 0 &&
-		    strcmp(devlink_dev_name(devlink), devname) == 0) {
-			devl_dev_lock(devlink, dev_lock);
-			if (devl_is_registered(devlink))
-				return devlink;
-			devl_dev_unlock(devlink, dev_lock);
-		}
+		    strcmp(devlink_dev_name(devlink), devname) == 0)
+			goto found;
 		devlink_put(devlink);
 	}
 
 	return ERR_PTR(-ENODEV);
+
+found:
+	devl_dev_lock(devlink, dev_lock);
+	if (devl_is_registered(devlink))
+		return devlink;
+	devl_dev_unlock(devlink, dev_lock);
+	devlink_put(devlink);
+	return ERR_PTR(-ENODEV);
 }
 
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
-- 
2.51.1


