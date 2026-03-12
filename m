Return-Path: <linux-rdma+bounces-18083-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMGuJriPsmlINgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18083-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:04:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2B126FF76
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 522223069D69
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654BB3BE148;
	Thu, 12 Mar 2026 10:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lUFF4zJZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E23BD25C
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309854; cv=none; b=nlSKbdi2XpAo1RkytRpMX6K2MmYDYScFxjgE8+MxKf1NTDLwQ+zAAwJRhb3KgxEW4xz6Oa6RXGpWyy4GQGQTOEyEJnm9jYAhnRkDpqRnnOC8xlq7lZEcRj/TPaweiG+gS6U+a5NxSAFyhmdD/kNmFEbXr8PcNNqP5QD3lKnqFIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309854; c=relaxed/simple;
	bh=Uit1Ti7AU3XxeFhawNvwoDfVMeh6nJo+iBe3Dbimg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnRrn5HqFLVrm8j4Psh8fkw6nNLgzWwgi7C1S86u2JV8jG6dNJPIsamwFPzgH3D3WQn7LhtuAi04EI/1ahXnPwtITxyI3JTcy9nWcueyelTVNXkGviXhLm6ld88mYtFMuuhymBQyb2aOgbZmNmFguSha4U2K/yD690pJKV3U7+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lUFF4zJZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso20381315e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309850; x=1773914650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=lUFF4zJZa0hgvIg96v34U0oJWVRFcoFa9sPidhNW/r6tgorFPdAVBUOnJNwV84tpz6
         gMs/NQWS0EqV6OK+nl1tgxtzz8AkxmsJnJ1RtRnpObyAr4PuEOwefSlyG3WECMcYVywD
         imyEd50XMM2nyeLI/O22MjeIcSHIYSvHeP6KX9BEsJU90COAM7UK6UzXwMzGazwkqayQ
         DSTlTolio/zV36wH1/oWeYKJPSdzQaHbT99CSx89fpcnXDqmWHHbAH/RzZIczhVIiNkx
         HaaZlf3v1pSG8xQ9C0jrPB9HyZISmTrKlF+2WMaAT9MArIxRoDnoqYGR+fJ+JAIx0D3j
         iDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309850; x=1773914650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=NpevvnH3vrVmz2T0poTm79emFWanngMkUu0TE9TLIApan6WQhGwyk8C/vA6w+MRx0V
         vmZRxlSBmv0DnbOG3vwvemAOOU1n50DILLWKx2vgcAJyLrzfOC440HMHKUhMTnvuMCO5
         e9SqvOXM56/r1tt9ARH2Gp5mwm2uXqJRhA4smNGZdyk/3slg5q/4nkNOlDyxWP3kjdy7
         4e6QQGHdnlq8TjHHJXRMcrlG61DjTaTBXz9qLuJbwL5ekaEc2ppCLwkXiMZQO7G364OL
         QtVdj87/PRybIvVmh9k+TYxdQSJoZ3DyICaGpPIQqsjDlXfsLQmbxu9wUoMXWF0upI3r
         vCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJreCrL2jU8s7gr/mTCAgVJN/dE244FKhovpXMEH4ql2YwgKNYqrIB3Ve7qFIZ2HqfOL4OIKtqg6cE@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxeRy7wPUiBY+fSar73gXWQmqCzvmxrxuyCF3fZD/OmYr8DBW
	dhervwl1lUxPcDTBPtgHVv44aMZR1uJ4znwoSBy4ITBWw10odZX6VzlIJcuYJcuiU8U=
X-Gm-Gg: ATEYQzx4mwBjP79XzwlF8i/ayrdSp4sxaYhZP7a2KuxKNSqJXNbDHv1mSRPBHwHxgSH
	1e0tQh376w3xswdEOJfPaVbid/oSMX2loI3v7EJSxHqlhfuQfRIky2fOshERb3+wZUqW1kzKuod
	p1k77zSnsfFDHnJZ0fVqkBBFhuwvscBHDVY/9v/JL9X4caf3QX1EMVjXYoVGYuBzPhZUMz5Z1FC
	zRo3o7CyZoeboZLjprea0WxLksUGnZ8W8UsM71W8ekMbDPM9z2kgdroFbTy+srJOIeAmg0jtgub
	RGyfbPDOT+ujjzwT6WurZywob4AYPM5oRbKG2i5INYwiLcVxp/u/UHHNg67rKNBd2AJmQs3LFI4
	mWyWjkcrFlWb2iLBRn467/ZUZwD0R2lpvBEoME8WfK8V+//cmPwguYdHHjrKOoxaTeE7hhfoSxQ
	UiRq0FBBVHtTau1A==
X-Received: by 2002:a05:600c:4fd5:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-4854f578e86mr42674835e9.6.1773309849689;
        Thu, 12 Mar 2026 03:04:09 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f6e6sm393371665e9.10.2026.03.12.03.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:09 -0700 (PDT)
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
Subject: [PATCH net-next v4 01/13] devlink: expose devlink instance index over netlink
Date: Thu, 12 Mar 2026 11:03:55 +0100
Message-ID: <20260312100407.551173-2-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-18083-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 3F2B126FF76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Each devlink instance has an internally assigned index used for xarray
storage. Expose it as a new DEVLINK_ATTR_INDEX uint attribute alongside
the existing bus_name and dev_name handle.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 5 +++++
 include/uapi/linux/devlink.h             | 2 ++
 net/devlink/devl_internal.h              | 2 ++
 net/devlink/port.c                       | 1 +
 4 files changed, 10 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..1bed67a0eefb 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -867,6 +867,10 @@ attribute-sets:
         type: flag
         doc: Request restoring parameter to its default value.
         value: 183
+      -
+        name: index
+        type: uint
+        doc: Unique devlink instance index.
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1311,6 +1315,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - reload-failed
             - dev-stats
       dump:
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..1ba3436db4ae 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -642,6 +642,8 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
+	DEVLINK_ATTR_INDEX,			/* uint */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 1377864383bc..31fa98af418e 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -178,6 +178,8 @@ devlink_nl_put_handle(struct sk_buff *msg, struct devlink *devlink)
 		return -EMSGSIZE;
 	if (nla_put_string(msg, DEVLINK_ATTR_DEV_NAME, dev_name(devlink->dev)))
 		return -EMSGSIZE;
+	if (nla_put_uint(msg, DEVLINK_ATTR_INDEX, devlink->index))
+		return -EMSGSIZE;
 	return 0;
 }
 
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 93d8a25bb920..1ff609571ea4 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -222,6 +222,7 @@ size_t devlink_nl_port_handle_size(struct devlink_port *devlink_port)
 
 	return nla_total_size(strlen(devlink->dev->bus->name) + 1) /* DEVLINK_ATTR_BUS_NAME */
 	     + nla_total_size(strlen(dev_name(devlink->dev)) + 1) /* DEVLINK_ATTR_DEV_NAME */
+	     + nla_total_size(8) /* DEVLINK_ATTR_INDEX */
 	     + nla_total_size(4); /* DEVLINK_ATTR_PORT_INDEX */
 }
 
-- 
2.51.1


