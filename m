Return-Path: <linux-rdma+bounces-17161-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JuXL7j6nmm+YAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17161-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:35:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37880198282
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7CE0308E30C
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218E73BFE4D;
	Wed, 25 Feb 2026 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YejnM16x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699963AEF5B
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026470; cv=none; b=inwnDYer/RV0MGOKS0MZmhoAe2mUVvYP2mj07wNcJTlkRQ+kf5D/iaxGLMb4IpSKddawC4jbsiN8sWumqGQQ2IS8tD8MhcgVYAcskjrrodo3nDS1HwkOuXKClp0kY8F/sZm7HZuim/jpWx5IMfjyEgt/jqfeF8Ic9qOP+BDAzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026470; c=relaxed/simple;
	bh=PABzC/qYg8Go3kt1GXod1fs3aKuZpPfkbvp4LZZhDPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FwuN1ujq24dVZYv1vozXcviPlE675kr++mJM2P16Hl/XGC7JBcT5Om+B8ii4MbAf60IIDKnXmuvAKEmxD6XjnLoG1ps0NnepLeafaa9D9ZLjYZwPbgr63f/RmcmIEuGwXyba2VTju4vfKdTXVJXXJ21ZArA4VizN+GYnGpft0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=YejnM16x; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-480706554beso79342355e9.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 05:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026468; x=1772631268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWhrdo13vFR8MpiWqGIUlMw11zaKiApxbVw47NJoYB0=;
        b=YejnM16xnGU2GKt/KJgJ2dVqhRyS7HDZAizyT2sZHwOUi400ShfwOlv70+hLTHTb0D
         HODTMfMp7yb4lK3hbV0cxnIyW2Z+uBOYiZZn7o3kOGp8HJBt2BLEeKrxuNIJzHqDJX8J
         4nMjzkXVjmAOVJcRGJyVN9chfknHG/sksb1Z9kf6u61FXousetYPthuYXUtAawYGWSfL
         ykcDh5RbPGNnCZCPWprHlq2UlJAhW7SIxBpbngZ4MbAL/05ch1PY3NmP2/ua4aPoxMOf
         qeTWXqDNL61U5db9qiWg6649HeJqmJmuLi74w86ZeZj2lvXokMBvLJdk2NyD91wTW+N3
         aVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026468; x=1772631268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWhrdo13vFR8MpiWqGIUlMw11zaKiApxbVw47NJoYB0=;
        b=E0UkLGHjt5Xo7adNpqYuwfwpPxNiVdQ6Bhf9+gei5irYSQ4v8dxwJ50NgDIR7DbASu
         dy494Roy0tm6JPjQ48HP0437sOXuUpsq5waYV8L4Y2qBoImvxObZttRrBOEplGmCpqQ9
         ZDrhcht75WVXrELoV/B/y4BPnM8fvhqVKcLtOaAMYDNKB0CYEmbF1hO1IK3k68cuH6d1
         YlW6SwYlHi6f66gelh1HxMMDCOJG9D9lr7IKte1EIHJgJV/YyMQHXpKhKSU/OLdMd964
         nL2y7Kc7iTIXstjQb995rovLXEyt228bPI5TVXFbI1ztgEBwYZwkyMok52VHlkrQhQiz
         Nw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyuafvqBPcJ/9dN0MEFG2JsQqcSvC1l9CubceuNyAN+Pr3nAEoio5eoJI4sZW1BBYKexELLdnCIuJ6@vger.kernel.org
X-Gm-Message-State: AOJu0YzZR/f97VpM90lzABGiYl/b3IIZVOiP5VuJ5/AE0O113eBzn1WO
	aPYV7iM2rwRyptNX3/a1NQANiJJyCu0P6CH6HyvrSKUR2r0yxGiJ+4twTqxcIjBpakA=
X-Gm-Gg: ATEYQzwt0mstdzKQ1AjhJ1/RIGl32Olf/c0+oaGGqEBDL4+LGgPpXWg3QZm4YG2SKiV
	9n/npFFKd1KdnEamcA5Y7ERTLzSppHzwLhteZT5lv/INEpB3AxqQK+vwRtbSTe6ehWLdB6OjMfR
	93HwMysHg5oDm7y3bvKrMcjFqlp5ai1MSMEuC3FNFfDbhJOyLonk3vI00EZlZ9u7uyOKK0qLoz+
	GcdZH8llT2P2P0EdVuK1V9PGv13kRvTloPLYqZih6D7Px9TgD5CF30Gt+yO9xXWZgQcg7DBNUcq
	3u7nhuWtOkMPQB8B+DAOGCb54E6/GvTGKP63Y15m9sRsqL35MF3upMsOIt03DDPrKUuEP2vp1aB
	EXnsfDsR/e85+WKigPx1k2sh3tU9tM0pLo3FUJs58Db6GIXYE9EF8ZrOq6XT5up4VdTV+neApFd
	HmJMIks85UvBk7kg==
X-Received: by 2002:a05:600c:45c5:b0:483:afbb:a077 with SMTP id 5b1f17b1804b1-483c216a9f6mr9402805e9.1.1772026467742;
        Wed, 25 Feb 2026 05:34:27 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd732eb1sm71670605e9.12.2026.02.25.05.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:27 -0800 (PST)
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
Subject: [PATCH net-next v2 03/10] devlink: avoid extra iterations when found devlink is not registered
Date: Wed, 25 Feb 2026 14:34:15 +0100
Message-ID: <20260225133422.290965-4-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-17161-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.973];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 37880198282
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
index 3f73ced2d879..a517d42c7b96 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -194,16 +194,20 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 
 	devlinks_xa_for_each_registered_get(net, index, devlink) {
 		if (strcmp(devlink->bus_name, busname) == 0 &&
-		    strcmp(devlink->dev_name, devname) == 0) {
-			devl_dev_lock(devlink, dev_lock);
-			if (devl_is_registered(devlink))
-				return devlink;
-			devl_dev_unlock(devlink, dev_lock);
-		}
+		    strcmp(devlink->dev_name, devname) == 0)
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


