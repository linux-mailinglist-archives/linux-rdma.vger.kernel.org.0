Return-Path: <linux-rdma+bounces-17165-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF31G6z6nmm+YAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17165-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:35:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33C819826C
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8151130398F2
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345CF3C199F;
	Wed, 25 Feb 2026 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="eGCQTFAW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3283BFE44
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026475; cv=none; b=NTq6njNMABwbf9O+Q8k3Rak6KVWNKllPzBW9vwxHf+o/OtJfkSMa4fOb2YTL5oR4QwSIavC3J8mgFmea4Q8lqXOzYX5Y34jux7wJSONZKz98l+qZQaqj5qwRElgSoCFMEkixWYNpCnPurmCywTeSs3jHHTUq+baRQzr9d/7CHMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026475; c=relaxed/simple;
	bh=VXRUjw3z3UNIh15gQNFX2CioLYNATxgwvmja7emLh0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiB91JzqytUWKusNZ+m4fD6KDojUamrpHXmtKOn2474taX4V+BL3TcQe6E8jtdPGrM2aZvA5pY24/KLWQurzjGIWGQr5/TNLZ0Y13VT7MiOreu3lSZ/V8E+l+YNPf8sPzjW8Iu12p1y4uzBF61L31S9SWTQPaixm238q2fhNNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=eGCQTFAW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48372efa020so53797005e9.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 05:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026469; x=1772631269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBeI8u/imk2Cfczd0e4jTH2zkhq0nWrokQows6+4QoU=;
        b=eGCQTFAWFDuc1j0MEvaQFN8irBySNBjySrvHjEBA+ptnxu0yc/fZ9e195RGE8DZv1y
         dJ6FYVzj6qG3r6v9YchmhuD9J5+QOjFvzGQoXxLaEw/Fejo03QxntEdLh9rqVEjx3cfw
         gg97OnqJ/Yy7WhtSXSNC0+nOsC7HLbVK9w85IJVxv+NKhCMCW1U6Is380k/qIN28/Cgn
         /LknmR2Epo9DAPPsO1f73mVwdZBOZAs3cT4k1AK1D8axt4FqkHj6InmqdIiEhIwEYGgO
         pf2tNXtJp27AfBLFQCfET2o6kFCdi9q4LXKnEm0Nn8Dd+WHo/V16WHhu/a2mv4vuSHJf
         ra4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026469; x=1772631269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MBeI8u/imk2Cfczd0e4jTH2zkhq0nWrokQows6+4QoU=;
        b=qOM2y831GzLjDCHmzdUSy6nb4OFfzom2dk2v1VKExN7M+v1+F1fwwyr9AJ40FwR+Bu
         20Gt2II3s0zfomppARfkbrBk48mKJv8kMsyMpgpv3tMd0ulYVBKWfF3iEBwXrqJm+Uj4
         p6+xMuGHwrYguBrrxUj80asg1BNLLj+WTdc4UeTaTNetx/77NbvOgiSo1RmpTvP1Voin
         pp6CCSextVWytYis5PPYMRfb/RKs0R4EkL2dO8cl28FGu1PB4NDvijJM1pfObBuSU3Yw
         9Y4AnFBxeRbZ9/DU+rjD/DR+BarVLAZE+raMp7OjhRaOJ8LSFb8xuWENsrGk/3gwIAbU
         f6lw==
X-Forwarded-Encrypted: i=1; AJvYcCVf+I0FayeWuDJQ2Gdttm4UTFV9nFfA1BpXRKeY4QkS+SkZCOTaPdRTfpppBt/t0QK2DQ9qTrBxh8m1@vger.kernel.org
X-Gm-Message-State: AOJu0YznuNbyP1EpX2xkGUzLj5u8cflphxtL3J8UKSxoSK22ON+A3M8g
	bueCDWV1yuHCizKt6t8mmWWZBpU61jAvSa8ro8KUkc8Y54ZWUPgEK0VcNDgI9XyC2L8=
X-Gm-Gg: ATEYQzwGOjuMdt2EEtmlJgBxZhkHNxw8M3oqjRIvlVnDFu7nlVeZtz4Q96ic4xdmkfO
	aBg2DvTncx6CH9ZweASPc/i64pF7FOwKBuP+sMjWTjAxzum5j4jaB9Olqt4Xo07Uq2CLJZVfpYL
	LsFrhrxPgfdTtba2yu4onlbj7LCAFl3zEnfFaJ7nE48jvFAMsr+azVGfni1/MpHUzbiWFjrVziw
	gCGOgp+Oer5gpC353VUHMvMkW6Smjk+Nx/BKE6d8Rt1ZAPMaakC0bhPFCQFDH8BaXix1F+oifot
	Sx+yfNkHqcIWhsmXqlts4GOo0Au7zydkf7/vf11EsImL2qGBGjqIloS9T8c7XNJpgBREMx5SBXL
	WeXYRo+trDnjJDb5jtLXUsU3pvSaJg74h7+xRjLYSRLiIYg/OuEgET20pdTTNl+JnWGc0wSbCuC
	ArLO43hIwfFqYRFw==
X-Received: by 2002:a05:600c:6815:b0:483:7783:537b with SMTP id 5b1f17b1804b1-483c21a54d7mr7735905e9.24.1772026469189;
        Wed, 25 Feb 2026 05:34:29 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7031f3sm66106985e9.6.2026.02.25.05.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:28 -0800 (PST)
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
Subject: [PATCH net-next v2 04/10] devlink: allow to use devlink index as a command handle
Date: Wed, 25 Feb 2026 14:34:16 +0100
Message-ID: <20260225133422.290965-5-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-17165-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli.us:mid,nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F33C819826C
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Currently devlink instances are addressed bus_name/dev_name tuple.
Allow the newly introduced DEVLINK_ATTR_INDEX to be used as
an alternative handle for all devlink commands.

When DEVLINK_ATTR_INDEX is present in the request, use it for a direct
xarray lookup instead of iterating over all instances comparing
bus_name/dev_name strings.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml |  51 ++++
 net/devlink/core.c                       |  16 +-
 net/devlink/devl_internal.h              |   1 +
 net/devlink/netlink.c                    |  11 +-
 net/devlink/netlink_gen.c                | 350 ++++++++++++++---------
 5 files changed, 286 insertions(+), 143 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 1bed67a0eefb..a73a86ec595d 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -1310,6 +1310,7 @@ operations:
           attributes: &dev-id-attrs
             - bus-name
             - dev-name
+            - index
         reply: &get-reply
           value: 3
           attributes:
@@ -1334,6 +1335,7 @@ operations:
           attributes: &port-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
         reply:
           value: 7
@@ -1358,6 +1360,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - port-type
             - port-function
@@ -1375,6 +1378,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - port-flavour
             - port-pci-pf-number
@@ -1409,6 +1413,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - port-split-count
 
@@ -1437,6 +1442,7 @@ operations:
           attributes: &sb-id-attrs
             - bus-name
             - dev-name
+            - index
             - sb-index
         reply: &sb-get-reply
           value: 13
@@ -1459,6 +1465,7 @@ operations:
           attributes: &sb-pool-id-attrs
             - bus-name
             - dev-name
+            - index
             - sb-index
             - sb-pool-index
         reply: &sb-pool-get-reply
@@ -1482,6 +1489,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - sb-index
             - sb-pool-index
             - sb-pool-threshold-type
@@ -1500,6 +1508,7 @@ operations:
           attributes: &sb-port-pool-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - sb-index
             - sb-pool-index
@@ -1524,6 +1533,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - sb-index
             - sb-pool-index
@@ -1542,6 +1552,7 @@ operations:
           attributes: &sb-tc-pool-bind-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - sb-index
             - sb-pool-type
@@ -1567,6 +1578,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - sb-index
             - sb-pool-index
@@ -1588,6 +1600,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - sb-index
 
     -
@@ -1603,6 +1616,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - sb-index
 
     -
@@ -1621,6 +1635,7 @@ operations:
           attributes: &eswitch-attrs
             - bus-name
             - dev-name
+            - index
             - eswitch-mode
             - eswitch-inline-mode
             - eswitch-encap-mode
@@ -1649,12 +1664,14 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - dpipe-table-name
         reply:
           value: 31
           attributes:
             - bus-name
             - dev-name
+            - index
             - dpipe-tables
 
     -
@@ -1669,11 +1686,13 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - dpipe-table-name
         reply:
           attributes:
             - bus-name
             - dev-name
+            - index
             - dpipe-entries
 
     -
@@ -1688,10 +1707,12 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
         reply:
           attributes:
             - bus-name
             - dev-name
+            - index
             - dpipe-headers
 
     -
@@ -1707,6 +1728,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - dpipe-table-name
             - dpipe-table-counters-enabled
 
@@ -1723,6 +1745,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - resource-id
             - resource-size
 
@@ -1738,11 +1761,13 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
         reply:
           value: 36
           attributes:
             - bus-name
             - dev-name
+            - index
             - resource-list
 
     -
@@ -1758,6 +1783,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - reload-action
             - reload-limits
             - netns-pid
@@ -1767,6 +1793,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - reload-actions-performed
 
     -
@@ -1781,6 +1808,7 @@ operations:
           attributes: &param-id-attrs
             - bus-name
             - dev-name
+            - index
             - param-name
         reply: &param-get-reply
           attributes: *param-id-attrs
@@ -1802,6 +1830,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - param-name
             - param-type
             # param-value-data is missing here as the type is variable
@@ -1821,6 +1850,7 @@ operations:
           attributes: &region-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - region-name
         reply: &region-get-reply
@@ -1845,6 +1875,7 @@ operations:
           attributes: &region-snapshot-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - region-name
             - region-snapshot-id
@@ -1875,6 +1906,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - region-name
             - region-snapshot-id
@@ -1886,6 +1918,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - region-name
 
@@ -1935,6 +1968,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - info-driver-name
             - info-serial-number
             - info-version-fixed
@@ -1956,6 +1990,7 @@ operations:
           attributes: &health-reporter-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - health-reporter-name
         reply: &health-reporter-get-reply
@@ -1978,6 +2013,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - health-reporter-name
             - health-reporter-graceful-period
@@ -2048,6 +2084,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - flash-update-file-name
             - flash-update-component
             - flash-update-overwrite-mask
@@ -2065,6 +2102,7 @@ operations:
           attributes: &trap-id-attrs
             - bus-name
             - dev-name
+            - index
             - trap-name
         reply: &trap-get-reply
           value: 63
@@ -2087,6 +2125,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - trap-name
             - trap-action
 
@@ -2103,6 +2142,7 @@ operations:
           attributes: &trap-group-id-attrs
             - bus-name
             - dev-name
+            - index
             - trap-group-name
         reply: &trap-group-get-reply
           value: 67
@@ -2125,6 +2165,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - trap-group-name
             - trap-action
             - trap-policer-id
@@ -2142,6 +2183,7 @@ operations:
           attributes: &trap-policer-id-attrs
             - bus-name
             - dev-name
+            - index
             - trap-policer-id
         reply: &trap-policer-get-reply
           value: 71
@@ -2164,6 +2206,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - trap-policer-id
             - trap-policer-rate
             - trap-policer-burst
@@ -2194,6 +2237,7 @@ operations:
           attributes: &rate-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - rate-node-name
         reply: &rate-get-reply
@@ -2217,6 +2261,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - rate-node-name
             - rate-tx-share
             - rate-tx-max
@@ -2238,6 +2283,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - rate-node-name
             - rate-tx-share
             - rate-tx-max
@@ -2259,6 +2305,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - rate-node-name
 
     -
@@ -2274,6 +2321,7 @@ operations:
           attributes: &linecard-id-attrs
             - bus-name
             - dev-name
+            - index
             - linecard-index
         reply: &linecard-get-reply
           value: 80
@@ -2296,6 +2344,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - linecard-index
             - linecard-type
 
@@ -2329,6 +2378,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - selftests
 
     -
@@ -2340,4 +2390,5 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 49f856beb8b2..2dd6d45bec18 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -333,13 +333,15 @@ void devlink_put(struct devlink *devlink)
 		queue_rcu_work(system_percpu_wq, &devlink->rwork);
 }
 
-struct devlink *devlinks_xa_find_get(struct net *net, unsigned long *indexp)
+static struct devlink *__devlinks_xa_find_get(struct net *net,
+					      unsigned long *indexp,
+					      unsigned long end)
 {
 	struct devlink *devlink = NULL;
 
 	rcu_read_lock();
 retry:
-	devlink = xa_find(&devlinks, indexp, ULONG_MAX, DEVLINK_REGISTERED);
+	devlink = xa_find(&devlinks, indexp, end, DEVLINK_REGISTERED);
 	if (!devlink)
 		goto unlock;
 
@@ -358,6 +360,16 @@ struct devlink *devlinks_xa_find_get(struct net *net, unsigned long *indexp)
 	goto retry;
 }
 
+struct devlink *devlinks_xa_find_get(struct net *net, unsigned long *indexp)
+{
+	return __devlinks_xa_find_get(net, indexp, ULONG_MAX);
+}
+
+struct devlink *devlinks_xa_lookup_get(struct net *net, unsigned long index)
+{
+	return __devlinks_xa_find_get(net, &index, index);
+}
+
 /**
  * devl_register - Register devlink instance
  * @devlink: devlink
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index d43819c6b452..67425c5d8cfc 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -92,6 +92,7 @@ extern struct genl_family devlink_nl_family;
 	for (index = 0; (devlink = devlinks_xa_find_get(net, &index)); index++)
 
 struct devlink *devlinks_xa_find_get(struct net *net, unsigned long *indexp);
+struct devlink *devlinks_xa_lookup_get(struct net *net, unsigned long index);
 
 static inline bool __devl_is_registered(struct devlink *devlink)
 {
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index a517d42c7b96..b73cec31089f 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -186,6 +186,14 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	char *busname;
 	char *devname;
 
+	if (attrs[DEVLINK_ATTR_INDEX]) {
+		index = nla_get_uint(attrs[DEVLINK_ATTR_INDEX]);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
 		return ERR_PTR(-EINVAL);
 
@@ -356,7 +364,8 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 	int flags = NLM_F_MULTI;
 
 	if (attrs &&
-	    (attrs[DEVLINK_ATTR_BUS_NAME] || attrs[DEVLINK_ATTR_DEV_NAME]))
+	    (attrs[DEVLINK_ATTR_BUS_NAME] || attrs[DEVLINK_ATTR_DEV_NAME] ||
+	     attrs[DEVLINK_ATTR_INDEX]))
 		return devlink_nl_inst_single_dumpit(msg, cb, flags, dump_one,
 						     attrs);
 	else
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f4c61c2b4f22..9812897c5524 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -56,37 +56,42 @@ const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_I
 };
 
 /* DEVLINK_CMD_GET - do */
-static const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_PORT_GET - do */
-static const struct nla_policy devlink_port_get_do_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_PORT_GET - dump */
-static const struct nla_policy devlink_port_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_port_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_PORT_SET - do */
-static const struct nla_policy devlink_port_set_nl_policy[DEVLINK_ATTR_PORT_FUNCTION + 1] = {
+static const struct nla_policy devlink_port_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_PORT_TYPE] = NLA_POLICY_MAX(NLA_U16, 3),
 	[DEVLINK_ATTR_PORT_FUNCTION] = NLA_POLICY_NESTED(devlink_dl_port_function_nl_policy),
 };
 
 /* DEVLINK_CMD_PORT_NEW - do */
-static const struct nla_policy devlink_port_new_nl_policy[DEVLINK_ATTR_PORT_PCI_SF_NUMBER + 1] = {
+static const struct nla_policy devlink_port_new_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_PORT_FLAVOUR] = NLA_POLICY_MAX(NLA_U16, 7),
 	[DEVLINK_ATTR_PORT_PCI_PF_NUMBER] = { .type = NLA_U16, },
@@ -95,58 +100,66 @@ static const struct nla_policy devlink_port_new_nl_policy[DEVLINK_ATTR_PORT_PCI_
 };
 
 /* DEVLINK_CMD_PORT_DEL - do */
-static const struct nla_policy devlink_port_del_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_del_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_PORT_SPLIT - do */
-static const struct nla_policy devlink_port_split_nl_policy[DEVLINK_ATTR_PORT_SPLIT_COUNT + 1] = {
+static const struct nla_policy devlink_port_split_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_PORT_SPLIT_COUNT] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_PORT_UNSPLIT - do */
-static const struct nla_policy devlink_port_unsplit_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_unsplit_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_SB_GET - do */
-static const struct nla_policy devlink_sb_get_do_nl_policy[DEVLINK_ATTR_SB_INDEX + 1] = {
+static const struct nla_policy devlink_sb_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_SB_GET - dump */
-static const struct nla_policy devlink_sb_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_sb_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_SB_POOL_GET - do */
-static const struct nla_policy devlink_sb_pool_get_do_nl_policy[DEVLINK_ATTR_SB_POOL_INDEX + 1] = {
+static const struct nla_policy devlink_sb_pool_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
 };
 
 /* DEVLINK_CMD_SB_POOL_GET - dump */
-static const struct nla_policy devlink_sb_pool_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_sb_pool_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_SB_POOL_SET - do */
-static const struct nla_policy devlink_sb_pool_set_nl_policy[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE + 1] = {
+static const struct nla_policy devlink_sb_pool_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
 	[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE] = NLA_POLICY_MAX(NLA_U8, 1),
@@ -154,24 +167,27 @@ static const struct nla_policy devlink_sb_pool_set_nl_policy[DEVLINK_ATTR_SB_POO
 };
 
 /* DEVLINK_CMD_SB_PORT_POOL_GET - do */
-static const struct nla_policy devlink_sb_port_pool_get_do_nl_policy[DEVLINK_ATTR_SB_POOL_INDEX + 1] = {
+static const struct nla_policy devlink_sb_port_pool_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
 };
 
 /* DEVLINK_CMD_SB_PORT_POOL_GET - dump */
-static const struct nla_policy devlink_sb_port_pool_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_sb_port_pool_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_SB_PORT_POOL_SET - do */
-static const struct nla_policy devlink_sb_port_pool_set_nl_policy[DEVLINK_ATTR_SB_THRESHOLD + 1] = {
+static const struct nla_policy devlink_sb_port_pool_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
@@ -179,9 +195,10 @@ static const struct nla_policy devlink_sb_port_pool_set_nl_policy[DEVLINK_ATTR_S
 };
 
 /* DEVLINK_CMD_SB_TC_POOL_BIND_GET - do */
-static const struct nla_policy devlink_sb_tc_pool_bind_get_do_nl_policy[DEVLINK_ATTR_SB_TC_INDEX + 1] = {
+static const struct nla_policy devlink_sb_tc_pool_bind_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_TYPE] = NLA_POLICY_MAX(NLA_U8, 1),
@@ -189,15 +206,17 @@ static const struct nla_policy devlink_sb_tc_pool_bind_get_do_nl_policy[DEVLINK_
 };
 
 /* DEVLINK_CMD_SB_TC_POOL_BIND_GET - dump */
-static const struct nla_policy devlink_sb_tc_pool_bind_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_sb_tc_pool_bind_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_SB_TC_POOL_BIND_SET - do */
-static const struct nla_policy devlink_sb_tc_pool_bind_set_nl_policy[DEVLINK_ATTR_SB_TC_INDEX + 1] = {
+static const struct nla_policy devlink_sb_tc_pool_bind_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
@@ -207,80 +226,91 @@ static const struct nla_policy devlink_sb_tc_pool_bind_set_nl_policy[DEVLINK_ATT
 };
 
 /* DEVLINK_CMD_SB_OCC_SNAPSHOT - do */
-static const struct nla_policy devlink_sb_occ_snapshot_nl_policy[DEVLINK_ATTR_SB_INDEX + 1] = {
+static const struct nla_policy devlink_sb_occ_snapshot_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_SB_OCC_MAX_CLEAR - do */
-static const struct nla_policy devlink_sb_occ_max_clear_nl_policy[DEVLINK_ATTR_SB_INDEX + 1] = {
+static const struct nla_policy devlink_sb_occ_max_clear_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_ESWITCH_GET - do */
-static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_ESWITCH_SET - do */
-static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
+static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 2),
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U8, 3),
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 /* DEVLINK_CMD_DPIPE_TABLE_GET - do */
-static const struct nla_policy devlink_dpipe_table_get_nl_policy[DEVLINK_ATTR_DPIPE_TABLE_NAME + 1] = {
+static const struct nla_policy devlink_dpipe_table_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_DPIPE_ENTRIES_GET - do */
-static const struct nla_policy devlink_dpipe_entries_get_nl_policy[DEVLINK_ATTR_DPIPE_TABLE_NAME + 1] = {
+static const struct nla_policy devlink_dpipe_entries_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_DPIPE_HEADERS_GET - do */
-static const struct nla_policy devlink_dpipe_headers_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_dpipe_headers_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET - do */
-static const struct nla_policy devlink_dpipe_table_counters_set_nl_policy[DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED + 1] = {
+static const struct nla_policy devlink_dpipe_table_counters_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED] = { .type = NLA_U8, },
 };
 
 /* DEVLINK_CMD_RESOURCE_SET - do */
-static const struct nla_policy devlink_resource_set_nl_policy[DEVLINK_ATTR_RESOURCE_SIZE + 1] = {
+static const struct nla_policy devlink_resource_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_RESOURCE_ID] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RESOURCE_SIZE] = { .type = NLA_U64, },
 };
 
 /* DEVLINK_CMD_RESOURCE_DUMP - do */
-static const struct nla_policy devlink_resource_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_resource_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_RELOAD - do */
-static const struct nla_policy devlink_reload_nl_policy[DEVLINK_ATTR_RELOAD_LIMITS + 1] = {
+static const struct nla_policy devlink_reload_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_RELOAD_ACTION] = NLA_POLICY_RANGE(NLA_U8, 1, 2),
 	[DEVLINK_ATTR_RELOAD_LIMITS] = NLA_POLICY_BITFIELD32(6),
 	[DEVLINK_ATTR_NETNS_PID] = { .type = NLA_U32, },
@@ -289,22 +319,25 @@ static const struct nla_policy devlink_reload_nl_policy[DEVLINK_ATTR_RELOAD_LIMI
 };
 
 /* DEVLINK_CMD_PARAM_GET - do */
-static const struct nla_policy devlink_param_get_do_nl_policy[DEVLINK_ATTR_PARAM_NAME + 1] = {
+static const struct nla_policy devlink_param_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_PARAM_GET - dump */
-static const struct nla_policy devlink_param_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_param_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_PARAM_SET - do */
-static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_PARAM_RESET_DEFAULT + 1] = {
+static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PARAM_TYPE] = NLA_POLICY_VALIDATE_FN(NLA_U8, &devlink_attr_param_type_validate),
 	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = NLA_POLICY_MAX(NLA_U8, 2),
@@ -312,41 +345,46 @@ static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_PARAM_RE
 };
 
 /* DEVLINK_CMD_REGION_GET - do */
-static const struct nla_policy devlink_region_get_do_nl_policy[DEVLINK_ATTR_REGION_NAME + 1] = {
+static const struct nla_policy devlink_region_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_REGION_GET - dump */
-static const struct nla_policy devlink_region_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_region_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_REGION_NEW - do */
-static const struct nla_policy devlink_region_new_nl_policy[DEVLINK_ATTR_REGION_SNAPSHOT_ID + 1] = {
+static const struct nla_policy devlink_region_new_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_REGION_DEL - do */
-static const struct nla_policy devlink_region_del_nl_policy[DEVLINK_ATTR_REGION_SNAPSHOT_ID + 1] = {
+static const struct nla_policy devlink_region_del_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_REGION_READ - dump */
-static const struct nla_policy devlink_region_read_nl_policy[DEVLINK_ATTR_REGION_DIRECT + 1] = {
+static const struct nla_policy devlink_region_read_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .type = NLA_U32, },
@@ -356,44 +394,50 @@ static const struct nla_policy devlink_region_read_nl_policy[DEVLINK_ATTR_REGION
 };
 
 /* DEVLINK_CMD_PORT_PARAM_GET - do */
-static const struct nla_policy devlink_port_param_get_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_param_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_PORT_PARAM_SET - do */
-static const struct nla_policy devlink_port_param_set_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_param_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_INFO_GET - do */
-static const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_GET - do */
-static const struct nla_policy devlink_health_reporter_get_do_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_GET - dump */
-static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_SET - do */
-static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD + 1] = {
+static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .type = NLA_U64, },
@@ -403,137 +447,155 @@ static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATT
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_RECOVER - do */
-static const struct nla_policy devlink_health_reporter_recover_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_recover_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE - do */
-static const struct nla_policy devlink_health_reporter_diagnose_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_diagnose_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET - dump */
-static const struct nla_policy devlink_health_reporter_dump_get_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_dump_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR - do */
-static const struct nla_policy devlink_health_reporter_dump_clear_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_dump_clear_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_FLASH_UPDATE - do */
-static const struct nla_policy devlink_flash_update_nl_policy[DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK + 1] = {
+static const struct nla_policy devlink_flash_update_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_FLASH_UPDATE_FILE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_FLASH_UPDATE_COMPONENT] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK] = NLA_POLICY_BITFIELD32(3),
 };
 
 /* DEVLINK_CMD_TRAP_GET - do */
-static const struct nla_policy devlink_trap_get_do_nl_policy[DEVLINK_ATTR_TRAP_NAME + 1] = {
+static const struct nla_policy devlink_trap_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_TRAP_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_TRAP_GET - dump */
-static const struct nla_policy devlink_trap_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_trap_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_TRAP_SET - do */
-static const struct nla_policy devlink_trap_set_nl_policy[DEVLINK_ATTR_TRAP_ACTION + 1] = {
+static const struct nla_policy devlink_trap_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_TRAP_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_TRAP_ACTION] = NLA_POLICY_MAX(NLA_U8, 2),
 };
 
 /* DEVLINK_CMD_TRAP_GROUP_GET - do */
-static const struct nla_policy devlink_trap_group_get_do_nl_policy[DEVLINK_ATTR_TRAP_GROUP_NAME + 1] = {
+static const struct nla_policy devlink_trap_group_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_TRAP_GROUP_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_TRAP_GROUP_GET - dump */
-static const struct nla_policy devlink_trap_group_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_trap_group_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_TRAP_GROUP_SET - do */
-static const struct nla_policy devlink_trap_group_set_nl_policy[DEVLINK_ATTR_TRAP_POLICER_ID + 1] = {
+static const struct nla_policy devlink_trap_group_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_TRAP_GROUP_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_TRAP_ACTION] = NLA_POLICY_MAX(NLA_U8, 2),
 	[DEVLINK_ATTR_TRAP_POLICER_ID] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_TRAP_POLICER_GET - do */
-static const struct nla_policy devlink_trap_policer_get_do_nl_policy[DEVLINK_ATTR_TRAP_POLICER_ID + 1] = {
+static const struct nla_policy devlink_trap_policer_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_TRAP_POLICER_ID] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_TRAP_POLICER_GET - dump */
-static const struct nla_policy devlink_trap_policer_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_trap_policer_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_TRAP_POLICER_SET - do */
-static const struct nla_policy devlink_trap_policer_set_nl_policy[DEVLINK_ATTR_TRAP_POLICER_BURST + 1] = {
+static const struct nla_policy devlink_trap_policer_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_TRAP_POLICER_ID] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_TRAP_POLICER_RATE] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_TRAP_POLICER_BURST] = { .type = NLA_U64, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_TEST - do */
-static const struct nla_policy devlink_health_reporter_test_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_test_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_RATE_GET - do */
-static const struct nla_policy devlink_rate_get_do_nl_policy[DEVLINK_ATTR_RATE_NODE_NAME + 1] = {
+static const struct nla_policy devlink_rate_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_RATE_GET - dump */
-static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TX_SHARE] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
@@ -544,9 +606,10 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_B
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TX_SHARE] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
@@ -557,50 +620,57 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_B
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
-static const struct nla_policy devlink_rate_del_nl_policy[DEVLINK_ATTR_RATE_NODE_NAME + 1] = {
+static const struct nla_policy devlink_rate_del_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_LINECARD_GET - do */
-static const struct nla_policy devlink_linecard_get_do_nl_policy[DEVLINK_ATTR_LINECARD_INDEX + 1] = {
+static const struct nla_policy devlink_linecard_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_LINECARD_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_LINECARD_GET - dump */
-static const struct nla_policy devlink_linecard_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_linecard_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_LINECARD_SET - do */
-static const struct nla_policy devlink_linecard_set_nl_policy[DEVLINK_ATTR_LINECARD_TYPE + 1] = {
+static const struct nla_policy devlink_linecard_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_LINECARD_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_LINECARD_TYPE] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_SELFTESTS_GET - do */
-static const struct nla_policy devlink_selftests_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_selftests_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 };
 
 /* DEVLINK_CMD_SELFTESTS_RUN - do */
-static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_SELFTESTS + 1] = {
+static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_SELFTESTS] = NLA_POLICY_NESTED(devlink_dl_selftest_id_nl_policy),
 };
 
 /* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
-static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = { .type = NLA_UINT, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
@@ -613,7 +683,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -629,14 +699,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_PORT_GET,
 		.dumpit		= devlink_nl_port_get_dumpit,
 		.policy		= devlink_port_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -646,7 +716,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_FUNCTION,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -656,7 +726,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_PCI_SF_NUMBER,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -666,7 +736,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_del_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_del_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -676,7 +746,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_split_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_split_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_SPLIT_COUNT,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -686,7 +756,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_unsplit_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_unsplit_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -696,14 +766,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_SB_GET,
 		.dumpit		= devlink_nl_sb_get_dumpit,
 		.policy		= devlink_sb_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -713,14 +783,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_pool_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_pool_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_POOL_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_SB_POOL_GET,
 		.dumpit		= devlink_nl_sb_pool_get_dumpit,
 		.policy		= devlink_sb_pool_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -730,7 +800,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_pool_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_pool_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -740,14 +810,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_port_pool_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_port_pool_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_POOL_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_SB_PORT_POOL_GET,
 		.dumpit		= devlink_nl_sb_port_pool_get_dumpit,
 		.policy		= devlink_sb_port_pool_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -757,7 +827,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_port_pool_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_port_pool_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_THRESHOLD,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -767,14 +837,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_tc_pool_bind_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_tc_pool_bind_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_TC_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_SB_TC_POOL_BIND_GET,
 		.dumpit		= devlink_nl_sb_tc_pool_bind_get_dumpit,
 		.policy		= devlink_sb_tc_pool_bind_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -784,7 +854,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_tc_pool_bind_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_tc_pool_bind_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_TC_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -794,7 +864,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_occ_snapshot_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_occ_snapshot_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -804,7 +874,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_occ_max_clear_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_occ_max_clear_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -814,7 +884,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_eswitch_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_eswitch_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -824,7 +894,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_eswitch_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_eswitch_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_ESWITCH_ENCAP_MODE,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -834,7 +904,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_dpipe_table_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_dpipe_table_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DPIPE_TABLE_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -844,7 +914,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_dpipe_entries_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_dpipe_entries_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DPIPE_TABLE_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -854,7 +924,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_dpipe_headers_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_dpipe_headers_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -864,7 +934,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_dpipe_table_counters_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_dpipe_table_counters_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -874,7 +944,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_resource_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_resource_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RESOURCE_SIZE,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -884,7 +954,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_resource_dump_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_resource_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -894,7 +964,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_reload_doit,
 		.post_doit	= devlink_nl_post_doit_dev_lock,
 		.policy		= devlink_reload_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RELOAD_LIMITS,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -904,14 +974,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_param_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_param_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PARAM_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_PARAM_GET,
 		.dumpit		= devlink_nl_param_get_dumpit,
 		.policy		= devlink_param_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -921,7 +991,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_param_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_param_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PARAM_RESET_DEFAULT,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -931,14 +1001,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_region_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_region_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_REGION_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_REGION_GET,
 		.dumpit		= devlink_nl_region_get_dumpit,
 		.policy		= devlink_region_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -948,7 +1018,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_region_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_region_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_REGION_SNAPSHOT_ID,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -958,7 +1028,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_region_del_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_region_del_nl_policy,
-		.maxattr	= DEVLINK_ATTR_REGION_SNAPSHOT_ID,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -966,7 +1036,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.validate	= GENL_DONT_VALIDATE_DUMP_STRICT,
 		.dumpit		= devlink_nl_region_read_dumpit,
 		.policy		= devlink_region_read_nl_policy,
-		.maxattr	= DEVLINK_ATTR_REGION_DIRECT,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -976,7 +1046,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_param_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_param_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -992,7 +1062,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_param_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_param_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1002,7 +1072,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_info_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_info_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -1018,14 +1088,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_HEALTH_REPORTER_GET,
 		.dumpit		= devlink_nl_health_reporter_get_dumpit,
 		.policy		= devlink_health_reporter_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -1035,7 +1105,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1045,7 +1115,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_recover_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_recover_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1055,7 +1125,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_diagnose_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_diagnose_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1063,7 +1133,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.validate	= GENL_DONT_VALIDATE_DUMP_STRICT,
 		.dumpit		= devlink_nl_health_reporter_dump_get_dumpit,
 		.policy		= devlink_health_reporter_dump_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -1073,7 +1143,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_dump_clear_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_dump_clear_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1083,7 +1153,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_flash_update_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_flash_update_nl_policy,
-		.maxattr	= DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1093,14 +1163,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_trap_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_trap_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_TRAP_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_TRAP_GET,
 		.dumpit		= devlink_nl_trap_get_dumpit,
 		.policy		= devlink_trap_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -1110,7 +1180,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_trap_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_trap_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_TRAP_ACTION,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1120,14 +1190,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_trap_group_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_trap_group_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_TRAP_GROUP_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_TRAP_GROUP_GET,
 		.dumpit		= devlink_nl_trap_group_get_dumpit,
 		.policy		= devlink_trap_group_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -1137,7 +1207,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_trap_group_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_trap_group_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_TRAP_POLICER_ID,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1147,14 +1217,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_trap_policer_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_trap_policer_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_TRAP_POLICER_ID,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_TRAP_POLICER_GET,
 		.dumpit		= devlink_nl_trap_policer_get_dumpit,
 		.policy		= devlink_trap_policer_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -1164,7 +1234,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_trap_policer_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_trap_policer_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_TRAP_POLICER_BURST,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1174,7 +1244,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_test_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_test_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1184,14 +1254,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_NODE_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_RATE_GET,
 		.dumpit		= devlink_nl_rate_get_dumpit,
 		.policy		= devlink_rate_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -1201,7 +1271,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1211,7 +1281,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1221,7 +1291,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_del_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_del_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_NODE_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1231,14 +1301,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_linecard_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_linecard_get_do_nl_policy,
-		.maxattr	= DEVLINK_ATTR_LINECARD_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_LINECARD_GET,
 		.dumpit		= devlink_nl_linecard_get_dumpit,
 		.policy		= devlink_linecard_get_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -1248,7 +1318,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_linecard_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_linecard_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_LINECARD_TYPE,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1258,7 +1328,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_selftests_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_selftests_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -1274,14 +1344,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_selftests_run_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_selftests_run_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SELFTESTS,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_NOTIFY_FILTER_SET,
 		.doit		= devlink_nl_notify_filter_set_doit,
 		.policy		= devlink_notify_filter_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 };
-- 
2.51.1


