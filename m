Return-Path: <linux-rdma+bounces-17482-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDIoCIdbqGmZtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17482-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:19:19 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799D204139
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E989330F489
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC1634BA50;
	Wed,  4 Mar 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HKgeK19B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9C34A3B1
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640033; cv=none; b=S4kK9OH31m3/WDQgtezG0csDd8HZexaJak63rWKuBpaqQCwDlMXNOy+Q9ueMQtOBrN+PYAnoREVQo5nZwcWiEZbJzkggVS3G1erQf54hSsopn2MQ5t3o6B5gwexuwloCDRSiFnT6fmjdj/eW9f07WEFuWhRHgZZgTCpfx0rsuBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640033; c=relaxed/simple;
	bh=Vtm80qE6FuR56bwzyqwTxutZyqLSGPZTe2b3PkwM178=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cj9PZTb5sQQQPU/FCAnKu19Bw/+QrKdLZiXVZ3MJ1TYpGHh5L674Kl5jRVUgg03sd/u5jry1L4DBUi3egGtud4EmPsXJbqJIrC/PHfODJfUun+RK0xNvEoQHzKlOXWba0FQnpxu/O6wlUi6NeA31bEZuVMRF6Bc7EiJv03pzuYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=HKgeK19B; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so80057465e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640030; x=1773244830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=HKgeK19BNnN/xfBdG3TeGtmGL4/I6csuNySXiK2cvgGVrlXff2jFACmEtRqt1l/BkT
         QS8uWnklsDMoiQGl9zO7SZwouW09GKKmMpK346Hlh5FEVTSNPBKXJ6jfQX15eXo1TdRF
         qlVD3h9UmKOPLDS//iY+ytByE8MGw49FZJ0V0I0NzZ1BCn2jCs591b0RE/Xpp3PoKF8s
         azTOhDeI7RpNIvy6vt/0kOKU8R7hgiFVSrd+0v6JuY2LYxG0CGCXMVcyGIdRmjW52VlM
         4zNYfYKPVl2jeoGMmQvDQRvR4toe5Z0JohC8zilCe0XoTEYzmcCm5+YF44VzPCPnLl7f
         dLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640030; x=1773244830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HEWuug6YBMXUGRBONZQ2DbkIBf5q1GxD8BXyAd3vMMw=;
        b=au5LuHW7abo5U1ftdrw2l419CXBS7ib0sGwaP2PrtUzIJ2M/4krSf4oMVAtHNJw/YS
         PhSe6nU2FgRbW8exWlCIXICHQFbBEvp8OlAxN4sEiAsYcLA9otTzuFNF8UuvnhyU5kFM
         0wHCwLJT2RZ24S3lYSr4HDzhtNV3rOpaHKfm2LovLnorAp0GKDZVtQCtuygL3mi3lHpE
         HU2a9xlGHXWx1B6eur35c/q1WNDnVEX2oVYGZVjMlI/t5J3HIEvMFbqXluLQV3r40gkC
         nrvHBzPugYyvH29tP3OaXeP92wJ4M7cFirFu1e5QHtx5VKx84KwLBhKKjm83pnFxnqaA
         RTgw==
X-Forwarded-Encrypted: i=1; AJvYcCUtPyLvU5Mjcb2TDidCPUJG9imBrhm6GSYaH4d8Tlt4HueCJS3ZOc5foNNkWk64gHm8YGkLjIwm7zQL@vger.kernel.org
X-Gm-Message-State: AOJu0YyLo0TCWTlioFAnxdW4swG5EB/+B3rNmto3+Q/FbyYLG1tiTpv4
	9CZn0t1IwEAKRAh2+Xb2SdZuQUC/LkAQ+anNPLBIg6EYqXxGqb3V0c2GjrYYhiF+R4I=
X-Gm-Gg: ATEYQzxynn+bbuQFSARVvx+GJdrAnZK7l8Pit31i9yz/9zUhijqyManRvr2wjW5PPKA
	eSr5DEu5rFzOhmIu3h6WGeH84PEHwew0W7Z4gDNj2E31LWH8hF7spRGxmZrbWWHfFHzrlbLTfjn
	5nzKO11FV/KOpagunXOmoW8MzZ3yiPwW6i8dHcOv2pFo7cWPLZMn2li7xYoVpSvHqAD6Q4VkKXl
	y49u+IuovhQdazggk6rUTboe2mxC7VN0Fyzj7cK9xg6mP2+K7HTyrXMAX2vXDks+15ijmu+863D
	OYpo9kMFZoIbDdohZ9HWlsm4wcUhtF8KbvmB6wHjUoxV/tv2inPG+d7WUIJhc+fsxhhTjudSofs
	IV/+dbCl444DodSAK8UVgviX1JA2zfRg66oV9IR+hDNdBoOddYVTuMDscITWlWKx7jO+vsDYMZ8
	Hj48MMKJEJXuLgqXBPA8DP7mozKu9i3dTJ3sAu2C0Ul+R3zA==
X-Received: by 2002:a05:600c:1c21:b0:483:71f7:2794 with SMTP id 5b1f17b1804b1-48519866866mr45713755e9.15.1772640030032;
        Wed, 04 Mar 2026 08:00:30 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485187ced3bsm56749265e9.8.2026.03.04.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:29 -0800 (PST)
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
Subject: [PATCH net-next v3 03/13] devlink: avoid extra iterations when found devlink is not registered
Date: Wed,  4 Mar 2026 17:00:12 +0100
Message-ID: <20260304160022.6114-4-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 7799D204139
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17482-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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


