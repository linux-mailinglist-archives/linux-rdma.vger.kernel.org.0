Return-Path: <linux-rdma+bounces-18088-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA6GENOPsmlINgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18088-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:05:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD7626FFBB
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 164F63025260
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39803C063A;
	Thu, 12 Mar 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="F4YA5N29"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B83BF687
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309862; cv=none; b=ZWcRiadCtmr6IZurNAndJZq3bynxh1U9wavbx/FKIQwx3D0IUAGLYQC1uyQeUwjPHcCBuMHsDMKrFl5yhc2tWgvg+iGKF4u7w9ywtY+m9+wkSeWNGQo/viIRlfABSJZ9PpJcO0lui3NzJm8xe/Lu6pRqQlSQblnIdnysJApQgkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309862; c=relaxed/simple;
	bh=i5rKA2YTnTgUVDiLBzobPs30Obw/a9s2IcnxQojxEfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/TZQzrFmJKMvxBtKqIJ1z3L3Dx2TrHzyDFHWMGWiZJB3E6aZxCUG2tzNeR9kdR7+/Fl1A+rDZHIZMT9LUppKKP5fhrgFi6E1OGt7DrhF6obFPMGi6yLT5YRispWaiZYZPPb2IO2V0FvEIJxLqNm/16bYpR74AWP8hT0y6TXsrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=F4YA5N29; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4853aec185aso7040255e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309856; x=1773914656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBxLs1D1zqMnnVRWFJXWayRzzgXR+CS+oaHoE8oyYjQ=;
        b=F4YA5N29K++WxHy794pWtk/N3MZBHTqkQCSOYfI2jSKvOp+Oq6y1hVqSDHhvKfMkl/
         bVOGOaivEoDJaTcN+45eU2MNpOO/J3hi5qxUi+bKZSxemUxtNYxRTv7E3cKAcOwCDWJo
         4KgY0wmOhI8FhJmst3cTOVIwUbk+m8Ddh4NbYFn8MxgwwfI+FTCRh38HsOS0y6v91TjN
         p+wT8uGQFjHmC9l2rRlRKqds52Mu1Kus8YiZYzcjoMjeWUcToGL9L+x2CpfPsgizmHFI
         UU0MZOUrEQTRjij/ek3JwL1UziCAnC0kIpGmytNMPmcb+T3hkIe37lEsiOJ69ypKmueg
         BYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309856; x=1773914656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBxLs1D1zqMnnVRWFJXWayRzzgXR+CS+oaHoE8oyYjQ=;
        b=D9GPtfniMFoxXDa43HWNJfaVEFi2ICKC9Eeb0IxFYtTd34ehaH//vM5btFtirreOmo
         hfVQI0PtB2FCxMiSJYHj2zgRpVmdf2rXk81CqZEjxDfXltUBBAj/lCf8RmJxuFtKWcMV
         rN3EX9DwhDc6RMgWJOHWy8lSNV3SQEKMnzVVYHLGSLL2kPOPbojre6AnRkQpqktK9pPG
         hkbMLfiXAbxuMxRyrHlBGX5JfVx/xebyfGp0ZWb7RHFauscQZUDup0gbY8GNumw2hC67
         etbn46/V1+3roy0Ej/YUpLXd5uNZPqiCeSQ1xlLTPIV7yuf3//Qf0tivXhcHfTHqCYF6
         GHtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFkZADONs6UpY8aATKwMtIiRQt8taFgGMhKrNPKD7CJE7dsknMlduLiDxA9fXF4hRuV6bfJsSoxpfj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz5SQW34gss4ByrvHzioIfjbFA40HEzGw75ws1/mynUpam4GJ+
	GvDDAi91ztVB0WUcy9q6jVGaPwPhGbyLCy0wa2FykrQlLG2295aQCcMmhXboOdGHdAo=
X-Gm-Gg: ATEYQzwqFY5sCrSJlvXbzl4aOPIoVPlhlHChwPKuxe8atTwucSFWiqoEtNZC/J68516
	gkS+uB02FlS8iAMEKoHr6a3JU6RiQ6C0vqb1Oj0+qj8y57MtKHnfWchL0uMOYKHB+gw3xRhJlkQ
	y3cu7dyOoWcodQZ01/kg4/T+qW4Oeyibcal86V35oHU+4IQ2VGf+Lnp7UXSZy7bf7F1hrB1/uQV
	X74g8GGuwGgPFbEOqIQ0qBZ22GYvAXmaHbXpn2aTkh/B6oTsqMAeCwsmfyyqzRFDBDXnN/NKAWK
	OVxGJZ0wHYj268LTztC9X6jy53eZhQVoF5AenzgQKZmJBEFb3N07THSyQGG/w7ineABS46jFbC1
	iRv45IaFIU5jpG8ss4XEG1g19KCxcqxX7qoehQLybgyaGp8lvk7+SQl7yERmVzD5Ob0sD4tYOPq
	NKj7nKpwBmIksjbQ==
X-Received: by 2002:a05:600c:8b8b:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-4854b0a5370mr87455915e9.6.1773309856147;
        Thu, 12 Mar 2026 03:04:16 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6e6sm393381525e9.10.2026.03.12.03.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:15 -0700 (PDT)
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
Subject: [PATCH net-next v4 06/13] devlink: support index-based notification filtering
Date: Thu, 12 Mar 2026 11:04:00 +0100
Message-ID: <20260312100407.551173-7-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-18088-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli.us:mid]
X-Rspamd-Queue-Id: DFD7626FFBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Extend the notification filter descriptor with devlink_index so
that userspace can filter notifications by devlink instance index
in addition to bus_name/dev_name.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v2->v3:
- new patch
---
 net/devlink/devl_internal.h |  4 ++++
 net/devlink/netlink.c       | 11 ++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 395832ed4477..f0ebfb936770 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -205,6 +205,8 @@ struct devlink_obj_desc {
 	const char *dev_name;
 	unsigned int port_index;
 	bool port_index_valid;
+	unsigned int devlink_index;
+	bool devlink_index_valid;
 	long data[];
 };
 
@@ -214,6 +216,8 @@ static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,
 	memset(desc, 0, sizeof(*desc));
 	desc->bus_name = devlink_bus_name(devlink);
 	desc->dev_name = devlink_dev_name(devlink);
+	desc->devlink_index = devlink->index;
+	desc->devlink_index_valid = true;
 }
 
 static inline void devlink_nl_obj_desc_port_set(struct devlink_obj_desc *desc,
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index fa38fca22fe4..32ddbe244cb7 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -73,13 +73,19 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 		flt->dev_name = pos;
 	}
 
+	if (attrs[DEVLINK_ATTR_INDEX]) {
+		flt->devlink_index = nla_get_uint(attrs[DEVLINK_ATTR_INDEX]);
+		flt->devlink_index_valid = true;
+	}
+
 	if (attrs[DEVLINK_ATTR_PORT_INDEX]) {
 		flt->port_index = nla_get_u32(attrs[DEVLINK_ATTR_PORT_INDEX]);
 		flt->port_index_valid = true;
 	}
 
 	/* Don't attach empty filter. */
-	if (!flt->bus_name && !flt->dev_name && !flt->port_index_valid) {
+	if (!flt->bus_name && !flt->dev_name &&
+	    !flt->devlink_index_valid && !flt->port_index_valid) {
 		kfree(flt);
 		flt = NULL;
 	}
@@ -100,6 +106,9 @@ int devlink_nl_notify_filter_set_doit(struct sk_buff *skb,
 static bool devlink_obj_desc_match(const struct devlink_obj_desc *desc,
 				   const struct devlink_obj_desc *flt)
 {
+	if (desc->devlink_index_valid && flt->devlink_index_valid &&
+	    desc->devlink_index != flt->devlink_index)
+		return false;
 	if (desc->bus_name && flt->bus_name &&
 	    strcmp(desc->bus_name, flt->bus_name))
 		return false;
-- 
2.51.1


