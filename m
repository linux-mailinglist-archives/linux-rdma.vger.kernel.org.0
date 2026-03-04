Return-Path: <linux-rdma+bounces-17480-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA1pMO1cqGmQtwAAu9opvQ
	(envelope-from <linux-rdma+bounces-17480-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:25:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ED62042DB
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C470430440BA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0A34D39B;
	Wed,  4 Mar 2026 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xpNtugTn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604A34A78F
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640030; cv=none; b=CxSTxr0cqG60OyAXBSzUChNrgGRkEFYyWiIm6TcG06ZJ1weLirguVORwc4K9HiJ3SjA2v4DiafxwYexZJ9mWo60r123vcEtM7desjn7+SmrnxMLAhxL2/PBl6PNk29sq0NfBVt4kUGIz1Rb1JSEez+ix/UXxpkLoXDzJa/I1CQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640030; c=relaxed/simple;
	bh=Uit1Ti7AU3XxeFhawNvwoDfVMeh6nJo+iBe3Dbimg88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjLal5mBjJbP8WZgz/L+sYTmRnpJjR03kR7DcBI/8hBHIhZguPj9Frh0VdAklwqvJcuj64LCyoqHkVp2rAI/Vl6o3HqyB3BC+rbp1Z1ClGJxjV72o2zAdm7trzOu1dc3N9HpQamAS5iTrGVN4fehXr8jgr5Fxxsbixa6Rw7/A1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xpNtugTn; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b78b638eso3617722f8f.2
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640027; x=1773244827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=xpNtugTn5UkhZ0Lnj1qvpN3/EWbSA+Q7NtWSKHhiGKB85+u05ycJt2AN9tUrhAORh7
         hW+ribiQId7X1OKVlILOHPPh4w/TmVWNbsisyRB6ffJ34Vzazuplk05LwzGI7PNAcl5U
         a+zA90aBV1Dozsn2xQ19lB4SEP4M+3LvWhRAskqdlKCT2/49kNdf0633Cpkg/jpF7ntD
         SArn97nrknD8YfUqpQzAEJI/sgPJuRxXcFyCg3EPGuM0NLApF2sp1c/MBKdGMse3WcGY
         E/WNZK7o9QAXHrQMSZeTupaT9WPkuOs4CHpV8+2NziKLbUHnurL7UZwLXH1a6c2g1kH6
         9Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640027; x=1773244827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d9KLhKGx9RzUBsWoWUkwA/+vgETenzM1WQ8j317w0fU=;
        b=UzUUD6uPZ6b8kpxmfHS/j18F2Jmmu29HfBXUo8VwlRFeCrbB+sS57pyQRRRXuj23Je
         V2EML6Le3Duc9MVwJPir/l+hUval1J9hh88OvKKv+ffnVssWO2HLHH7Jaittdwx4Ys3S
         huzL97jdVBsYakuw3wOP9aLaRRyHRxK0JJm08LYZt3GBnmvUS9L59Y6PZ1lQqoQq6Lc5
         D5ORnTuHptE2xzXw9KiNg5dI8gXGWRD9VJXQst1K6ltb5U5CyQZY+bv0VApuZNaVT/Rk
         HH/LMkt2AVBWFEsXK37SeNqS2R4lPUMRnpmOo+f/79qbI0RXsRgVl2zlhGCiIWv/bi4w
         V+mA==
X-Forwarded-Encrypted: i=1; AJvYcCV7a4Rzoku8wz9qA/7f5HQAMlmz6pwOgQNJt9Z05elxUqoPYhgZFZMBfPv3/jNHlCH4+d/n5nzH3mQy@vger.kernel.org
X-Gm-Message-State: AOJu0YySBPjia0ISKhMdkS1eQEi8eaVukwC1hQvQYaTFnFSkidnkCjmQ
	52PtGGi8w16Htn9fFr364pt279W5PONnaR1OaDT/rGYbrCLfH01MXAclviRNo5DxXWg=
X-Gm-Gg: ATEYQzzvPcwemdmcM2Dk14+1FrbifP4ytnZ46ECuF1s4B6M03L7MFU+v10n5dlB0O1O
	dZPCsF8UoWSQIJwY1HytaTMkC1G6sTuvocDO8ne+lNSf0NYQ5N+wVk42zVcdMw2y2lm8ZQZdYuL
	2JI6dXGoh5FD87n4idzW4JkgnZrITOKlGc0dIsgaMCzoU4o0+lptCLmHVcVMLf2W5Ov3QjYHFN1
	pJfYHzNyOxgqkNGS+Rh1p8LqeNyFnqt9jFN/vWLJ9IYw7rAvepjPjPessBduTuOXrxGOmW9vxuz
	Gj76Q/LXGgoj57u0M+C3Rz5q/nasmSDWePyi+ij5v7bH9kXTL9C7tF7Yhvj/YcNw//f3N7+1GoJ
	a9cF5qvX6NIFv16sqtHc0GIUlWdf0MHklgLekghU4uYvdLpHR5/egXBZuqkzF2DPd4Khd1/rAZJ
	hmrLjq+xAU7tP0ML3ysrshrwoLoi9H6HKhlkTNkc7Jcy79qSED6T9PffgL
X-Received: by 2002:a05:6000:4006:b0:439:c279:32e9 with SMTP id ffacd0b85a97d-439c7fe3d7cmr4503831f8f.39.1772640026687;
        Wed, 04 Mar 2026 08:00:26 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b485a0b6sm27629409f8f.39.2026.03.04.08.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:25 -0800 (PST)
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
Subject: [PATCH net-next v3 01/13] devlink: expose devlink instance index over netlink
Date: Wed,  4 Mar 2026 17:00:10 +0100
Message-ID: <20260304160022.6114-2-jiri@resnulli.us>
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
X-Rspamd-Queue-Id: 28ED62042DB
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-17480-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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


