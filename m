Return-Path: <linux-rdma+bounces-18087-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHPiMHiQsmmMNgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18087-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:07:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BA92700FE
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 11:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86B47309F6B2
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27F03BE62F;
	Thu, 12 Mar 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZkEcSsV4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0EB3BED08
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309862; cv=none; b=WADb3RGW3Ou09GwWnfsWkbatTFhT4TvQImIo2qBwhh2MDiuoztPexMf2+V8ESIHA0I6pSTT1naqWMZvgtyQU2CADniegMdmFuZoTKoAgyboGa1rvBlgNEXhssL7YQNroyw18V6KZ0T1ftmEp3WGDqFlGLNHin6/g3kGWD6HUHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309862; c=relaxed/simple;
	bh=hoJyW70pRwQF+Dol9BG6YCoAOZsGIYBjkVmFjlkwfhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArEKVli/rCAYuAYY0ycOBcruwiiyBBygXIVUDBZoU2iGYHFDKEBsnAVHWCT2skTHSTOpSewqflmgcXGk6MvalhEyjq74Gfi3KyAnULQGq8T+V77BBv6jIcoDEK7cxD9otuNWLeZWrkQ8hWJ9oAY0RtGCwyNpcw0mnmQNLma7c/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZkEcSsV4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so10373205e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773309854; x=1773914654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDaCMI/W9G+gAIWeA9XqO9d7gvuiZhkev6lZNXATFmk=;
        b=ZkEcSsV41BdV5nDcS6ScWxV3kvg3+eqkzzmpWbsNkbBnhmBdgWPrbWdvPpNp727Jyc
         avCwtPJES54Oe1DANMjT7A+UKcfO1aywQw4XjaiaRE6+uURsaSTNd6vO7m2T1zaFaXoC
         CiWYm8Go5XARIntj/497aXoyCKMI8YpHwqLuDP/U3vlm7ukfBOFz9P+V6CU9+cJ/j4WL
         z7iVfkGpaRSnQyVe6dpfANTLFZs1aatDxSKxaKvZvDxr5RVAYZftyGcB8y0hTOeiRkSg
         6JWhUJg3oVP7CSfV27a8WLLYaZzPKX6hSdUKptV3C9cqkLiEh+2YLYtF3aEnicw+BTLB
         4p4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773309854; x=1773914654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mDaCMI/W9G+gAIWeA9XqO9d7gvuiZhkev6lZNXATFmk=;
        b=VmI7q/uwnb0zmY364fZYNBlR8rSRj47QjIe7WQkXbi7Pk14g4Gm8gErDKpYNpeSGaK
         csF7Guaeljfo6ETnKw3vx4vdLwH/BI0XjUZiCy3Vbj1p5yQmUhIDqGHjiWEY3EH2mtxr
         +vcICKARY+9gyO2+l5/TU+uqp0yzkcQYStGr5IFstdRk61q20kAsha0rCuU30GlYed/1
         n+qo1u8Oyb0ovcDb1NUpauSqbWdDQgBp7mxfBdpl/upenx9ccfa+rkFt0jtL44Z9kBC6
         vC2Dc4yX9UcrJrxT1s4vYrzPHKfrlNZ/Yzq3ylj3eX1yB9zACiVE8lshkbRPDp2SL17K
         2oYA==
X-Forwarded-Encrypted: i=1; AJvYcCUuk9CG2SGa9lOR04Fq5PgLub0jlG0x8txWSEMKPl0nE3aZ02eN/A+mgnopwhWE49pimALZsfCa5bJL@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6lMLkgBiDAFJhu7NTiD7yJ+2+5PWS0POEqsjON8bgnA3gE+n
	Mst/DdETwcj1kv6BKvZSD8DONPm6Reb0ldwp889ICOtBox8splDMfPqROGUyB5JuPKk=
X-Gm-Gg: ATEYQzwx/xqURpHSYf6OYfDc8Cdm5BLJEKipJEiOHMMQajR5kRGJLb+PcnkH9F3W3Fi
	ZbcYCGhcofvoqP+va3qhk+5rM98TXkepaHH1w7/UoTaR5ty3Kl28cwPnLm2qOaD17BM2DcHVKT3
	7HcE3hB/PtMi7sBcDN+BMFWibopR2cgzaDDQLzgkKwxO9tgLDxKX/JjCXn/LNH3ol2pm+YX5sm3
	V/ykvy3xpcQoBEVxG23sB7CPyhwj2AWZ7oEdttgE61RJ7gsIYUAQ88I6/QdYqxaWxMp5p254nPw
	eGrbeVORf26Bv1hLdecSjnvbZ9GVDuE/K8KJur0y6PfO7CXdxR0UAPwMNrZW9AvuzdhOAmrQE47
	cDUpLypezHrFiAB9r29mFg1hEGxi8RmAZY5a7JB2f5nBAuJJkVflgIbG+rUIEx/CU8ht1BHBhUm
	wTWwG6IPLpdwdAxw==
X-Received: by 2002:a05:600c:a088:b0:485:550c:cda4 with SMTP id 5b1f17b1804b1-485550ccdbemr2387545e9.8.1773309853668;
        Thu, 12 Mar 2026 03:04:13 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b7f406sm212105465e9.13.2026.03.12.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 03:04:13 -0700 (PDT)
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
Subject: [PATCH net-next v4 04/13] devlink: allow to use devlink index as a command handle
Date: Thu, 12 Mar 2026 11:03:58 +0100
Message-ID: <20260312100407.551173-5-jiri@resnulli.us>
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
	TAGGED_FROM(0.00)[bounces-18087-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: F2BA92700FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Currently devlink instances are addressed bus_name/dev_name tuple.
Allow the newly introduced DEVLINK_ATTR_INDEX to be used as
an alternative handle for all devlink commands.

When DEVLINK_ATTR_INDEX is present in the request, use it for a direct
xarray lookup instead of iterating over all instances comparing
bus_name/dev_name strings.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v3->v4:
- added checks-max-u32-max to yaml
- removed no longer necessary index max check
  from devlink_get_from_attrs_lock()
v2->v3:
- check out of bounds index
- reject mixture of handle approaches
---
 Documentation/netlink/specs/devlink.yaml |  53 ++++
 net/devlink/core.c                       |  16 +-
 net/devlink/devl_internal.h              |   1 +
 net/devlink/netlink.c                    |  14 +-
 net/devlink/netlink_gen.c                | 355 ++++++++++++++---------
 5 files changed, 296 insertions(+), 143 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 1bed67a0eefb..b495d56b9137 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -871,6 +871,8 @@ attribute-sets:
         name: index
         type: uint
         doc: Unique devlink instance index.
+        checks:
+          max: u32-max
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1310,6 +1312,7 @@ operations:
           attributes: &dev-id-attrs
             - bus-name
             - dev-name
+            - index
         reply: &get-reply
           value: 3
           attributes:
@@ -1334,6 +1337,7 @@ operations:
           attributes: &port-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
         reply:
           value: 7
@@ -1358,6 +1362,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - port-type
             - port-function
@@ -1375,6 +1380,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - port-flavour
             - port-pci-pf-number
@@ -1409,6 +1415,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - port-split-count
 
@@ -1437,6 +1444,7 @@ operations:
           attributes: &sb-id-attrs
             - bus-name
             - dev-name
+            - index
             - sb-index
         reply: &sb-get-reply
           value: 13
@@ -1459,6 +1467,7 @@ operations:
           attributes: &sb-pool-id-attrs
             - bus-name
             - dev-name
+            - index
             - sb-index
             - sb-pool-index
         reply: &sb-pool-get-reply
@@ -1482,6 +1491,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - sb-index
             - sb-pool-index
             - sb-pool-threshold-type
@@ -1500,6 +1510,7 @@ operations:
           attributes: &sb-port-pool-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - sb-index
             - sb-pool-index
@@ -1524,6 +1535,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - sb-index
             - sb-pool-index
@@ -1542,6 +1554,7 @@ operations:
           attributes: &sb-tc-pool-bind-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - sb-index
             - sb-pool-type
@@ -1567,6 +1580,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - sb-index
             - sb-pool-index
@@ -1588,6 +1602,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - sb-index
 
     -
@@ -1603,6 +1618,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - sb-index
 
     -
@@ -1621,6 +1637,7 @@ operations:
           attributes: &eswitch-attrs
             - bus-name
             - dev-name
+            - index
             - eswitch-mode
             - eswitch-inline-mode
             - eswitch-encap-mode
@@ -1649,12 +1666,14 @@ operations:
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
@@ -1669,11 +1688,13 @@ operations:
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
@@ -1688,10 +1709,12 @@ operations:
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
@@ -1707,6 +1730,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - dpipe-table-name
             - dpipe-table-counters-enabled
 
@@ -1723,6 +1747,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - resource-id
             - resource-size
 
@@ -1738,11 +1763,13 @@ operations:
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
@@ -1758,6 +1785,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - reload-action
             - reload-limits
             - netns-pid
@@ -1767,6 +1795,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - reload-actions-performed
 
     -
@@ -1781,6 +1810,7 @@ operations:
           attributes: &param-id-attrs
             - bus-name
             - dev-name
+            - index
             - param-name
         reply: &param-get-reply
           attributes: *param-id-attrs
@@ -1802,6 +1832,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - param-name
             - param-type
             # param-value-data is missing here as the type is variable
@@ -1821,6 +1852,7 @@ operations:
           attributes: &region-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - region-name
         reply: &region-get-reply
@@ -1845,6 +1877,7 @@ operations:
           attributes: &region-snapshot-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - region-name
             - region-snapshot-id
@@ -1875,6 +1908,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - region-name
             - region-snapshot-id
@@ -1886,6 +1920,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - region-name
 
@@ -1935,6 +1970,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - info-driver-name
             - info-serial-number
             - info-version-fixed
@@ -1956,6 +1992,7 @@ operations:
           attributes: &health-reporter-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - health-reporter-name
         reply: &health-reporter-get-reply
@@ -1978,6 +2015,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
             - health-reporter-name
             - health-reporter-graceful-period
@@ -2048,6 +2086,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - flash-update-file-name
             - flash-update-component
             - flash-update-overwrite-mask
@@ -2065,6 +2104,7 @@ operations:
           attributes: &trap-id-attrs
             - bus-name
             - dev-name
+            - index
             - trap-name
         reply: &trap-get-reply
           value: 63
@@ -2087,6 +2127,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - trap-name
             - trap-action
 
@@ -2103,6 +2144,7 @@ operations:
           attributes: &trap-group-id-attrs
             - bus-name
             - dev-name
+            - index
             - trap-group-name
         reply: &trap-group-get-reply
           value: 67
@@ -2125,6 +2167,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - trap-group-name
             - trap-action
             - trap-policer-id
@@ -2142,6 +2185,7 @@ operations:
           attributes: &trap-policer-id-attrs
             - bus-name
             - dev-name
+            - index
             - trap-policer-id
         reply: &trap-policer-get-reply
           value: 71
@@ -2164,6 +2208,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - trap-policer-id
             - trap-policer-rate
             - trap-policer-burst
@@ -2194,6 +2239,7 @@ operations:
           attributes: &rate-id-attrs
             - bus-name
             - dev-name
+            - index
             - port-index
             - rate-node-name
         reply: &rate-get-reply
@@ -2217,6 +2263,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - rate-node-name
             - rate-tx-share
             - rate-tx-max
@@ -2238,6 +2285,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - rate-node-name
             - rate-tx-share
             - rate-tx-max
@@ -2259,6 +2307,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - rate-node-name
 
     -
@@ -2274,6 +2323,7 @@ operations:
           attributes: &linecard-id-attrs
             - bus-name
             - dev-name
+            - index
             - linecard-index
         reply: &linecard-get-reply
           value: 80
@@ -2296,6 +2346,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - linecard-index
             - linecard-type
 
@@ -2329,6 +2380,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - selftests
 
     -
@@ -2340,4 +2392,5 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - index
             - port-index
diff --git a/net/devlink/core.c b/net/devlink/core.c
index 63709c132a7c..237558abcd63 100644
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
index 1b770de0313e..395832ed4477 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -90,6 +90,7 @@ extern struct genl_family devlink_nl_family;
 	for (index = 0; (devlink = devlinks_xa_find_get(net, &index)); index++)
 
 struct devlink *devlinks_xa_find_get(struct net *net, unsigned long *indexp);
+struct devlink *devlinks_xa_lookup_get(struct net *net, unsigned long index);
 
 static inline bool __devl_is_registered(struct devlink *devlink)
 {
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 7b205f677b7a..9cba40285de4 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -186,6 +186,17 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	char *busname;
 	char *devname;
 
+	if (attrs[DEVLINK_ATTR_INDEX]) {
+		if (attrs[DEVLINK_ATTR_BUS_NAME] ||
+		    attrs[DEVLINK_ATTR_DEV_NAME])
+			return ERR_PTR(-EINVAL);
+		index = nla_get_u32(attrs[DEVLINK_ATTR_INDEX]);
+		devlink = devlinks_xa_lookup_get(net, index);
+		if (!devlink)
+			return ERR_PTR(-ENODEV);
+		goto found;
+	}
+
 	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
 		return ERR_PTR(-EINVAL);
 
@@ -356,7 +367,8 @@ int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 	int flags = NLM_F_MULTI;
 
 	if (attrs &&
-	    (attrs[DEVLINK_ATTR_BUS_NAME] || attrs[DEVLINK_ATTR_DEV_NAME]))
+	    (attrs[DEVLINK_ATTR_BUS_NAME] || attrs[DEVLINK_ATTR_DEV_NAME] ||
+	     attrs[DEVLINK_ATTR_INDEX]))
 		return devlink_nl_inst_single_dumpit(msg, cb, flags, dump_one,
 						     attrs);
 	else
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f4c61c2b4f22..eb35e80e01d1 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -11,6 +11,11 @@
 
 #include <uapi/linux/devlink.h>
 
+/* Integer value ranges */
+static const struct netlink_range_validation devlink_attr_index_range = {
+	.max	= U32_MAX,
+};
+
 /* Sparse enums validation callbacks */
 static int
 devlink_attr_param_type_validate(const struct nlattr *attr,
@@ -56,37 +61,42 @@ const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_I
 };
 
 /* DEVLINK_CMD_GET - do */
-static const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_PORT_GET - do */
-static const struct nla_policy devlink_port_get_do_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_PORT_GET - dump */
-static const struct nla_policy devlink_port_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_port_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_PORT_SET - do */
-static const struct nla_policy devlink_port_set_nl_policy[DEVLINK_ATTR_PORT_FUNCTION + 1] = {
+static const struct nla_policy devlink_port_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_PORT_TYPE] = NLA_POLICY_MAX(NLA_U16, 3),
 	[DEVLINK_ATTR_PORT_FUNCTION] = NLA_POLICY_NESTED(devlink_dl_port_function_nl_policy),
 };
 
 /* DEVLINK_CMD_PORT_NEW - do */
-static const struct nla_policy devlink_port_new_nl_policy[DEVLINK_ATTR_PORT_PCI_SF_NUMBER + 1] = {
+static const struct nla_policy devlink_port_new_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_PORT_FLAVOUR] = NLA_POLICY_MAX(NLA_U16, 7),
 	[DEVLINK_ATTR_PORT_PCI_PF_NUMBER] = { .type = NLA_U16, },
@@ -95,58 +105,66 @@ static const struct nla_policy devlink_port_new_nl_policy[DEVLINK_ATTR_PORT_PCI_
 };
 
 /* DEVLINK_CMD_PORT_DEL - do */
-static const struct nla_policy devlink_port_del_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_del_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_PORT_SPLIT - do */
-static const struct nla_policy devlink_port_split_nl_policy[DEVLINK_ATTR_PORT_SPLIT_COUNT + 1] = {
+static const struct nla_policy devlink_port_split_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_PORT_SPLIT_COUNT] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_PORT_UNSPLIT - do */
-static const struct nla_policy devlink_port_unsplit_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_unsplit_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_SB_GET - do */
-static const struct nla_policy devlink_sb_get_do_nl_policy[DEVLINK_ATTR_SB_INDEX + 1] = {
+static const struct nla_policy devlink_sb_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_SB_GET - dump */
-static const struct nla_policy devlink_sb_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_sb_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_SB_POOL_GET - do */
-static const struct nla_policy devlink_sb_pool_get_do_nl_policy[DEVLINK_ATTR_SB_POOL_INDEX + 1] = {
+static const struct nla_policy devlink_sb_pool_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
 };
 
 /* DEVLINK_CMD_SB_POOL_GET - dump */
-static const struct nla_policy devlink_sb_pool_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_sb_pool_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_SB_POOL_SET - do */
-static const struct nla_policy devlink_sb_pool_set_nl_policy[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE + 1] = {
+static const struct nla_policy devlink_sb_pool_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
 	[DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE] = NLA_POLICY_MAX(NLA_U8, 1),
@@ -154,24 +172,27 @@ static const struct nla_policy devlink_sb_pool_set_nl_policy[DEVLINK_ATTR_SB_POO
 };
 
 /* DEVLINK_CMD_SB_PORT_POOL_GET - do */
-static const struct nla_policy devlink_sb_port_pool_get_do_nl_policy[DEVLINK_ATTR_SB_POOL_INDEX + 1] = {
+static const struct nla_policy devlink_sb_port_pool_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
 };
 
 /* DEVLINK_CMD_SB_PORT_POOL_GET - dump */
-static const struct nla_policy devlink_sb_port_pool_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_sb_port_pool_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_SB_PORT_POOL_SET - do */
-static const struct nla_policy devlink_sb_port_pool_set_nl_policy[DEVLINK_ATTR_SB_THRESHOLD + 1] = {
+static const struct nla_policy devlink_sb_port_pool_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
@@ -179,9 +200,10 @@ static const struct nla_policy devlink_sb_port_pool_set_nl_policy[DEVLINK_ATTR_S
 };
 
 /* DEVLINK_CMD_SB_TC_POOL_BIND_GET - do */
-static const struct nla_policy devlink_sb_tc_pool_bind_get_do_nl_policy[DEVLINK_ATTR_SB_TC_INDEX + 1] = {
+static const struct nla_policy devlink_sb_tc_pool_bind_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_TYPE] = NLA_POLICY_MAX(NLA_U8, 1),
@@ -189,15 +211,17 @@ static const struct nla_policy devlink_sb_tc_pool_bind_get_do_nl_policy[DEVLINK_
 };
 
 /* DEVLINK_CMD_SB_TC_POOL_BIND_GET - dump */
-static const struct nla_policy devlink_sb_tc_pool_bind_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_sb_tc_pool_bind_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_SB_TC_POOL_BIND_SET - do */
-static const struct nla_policy devlink_sb_tc_pool_bind_set_nl_policy[DEVLINK_ATTR_SB_TC_INDEX + 1] = {
+static const struct nla_policy devlink_sb_tc_pool_bind_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_SB_POOL_INDEX] = { .type = NLA_U16, },
@@ -207,80 +231,91 @@ static const struct nla_policy devlink_sb_tc_pool_bind_set_nl_policy[DEVLINK_ATT
 };
 
 /* DEVLINK_CMD_SB_OCC_SNAPSHOT - do */
-static const struct nla_policy devlink_sb_occ_snapshot_nl_policy[DEVLINK_ATTR_SB_INDEX + 1] = {
+static const struct nla_policy devlink_sb_occ_snapshot_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_SB_OCC_MAX_CLEAR - do */
-static const struct nla_policy devlink_sb_occ_max_clear_nl_policy[DEVLINK_ATTR_SB_INDEX + 1] = {
+static const struct nla_policy devlink_sb_occ_max_clear_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_SB_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_ESWITCH_GET - do */
-static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_eswitch_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_ESWITCH_SET - do */
-static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_ESWITCH_ENCAP_MODE + 1] = {
+static const struct nla_policy devlink_eswitch_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_ESWITCH_MODE] = NLA_POLICY_MAX(NLA_U16, 2),
 	[DEVLINK_ATTR_ESWITCH_INLINE_MODE] = NLA_POLICY_MAX(NLA_U8, 3),
 	[DEVLINK_ATTR_ESWITCH_ENCAP_MODE] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 /* DEVLINK_CMD_DPIPE_TABLE_GET - do */
-static const struct nla_policy devlink_dpipe_table_get_nl_policy[DEVLINK_ATTR_DPIPE_TABLE_NAME + 1] = {
+static const struct nla_policy devlink_dpipe_table_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_DPIPE_ENTRIES_GET - do */
-static const struct nla_policy devlink_dpipe_entries_get_nl_policy[DEVLINK_ATTR_DPIPE_TABLE_NAME + 1] = {
+static const struct nla_policy devlink_dpipe_entries_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_DPIPE_HEADERS_GET - do */
-static const struct nla_policy devlink_dpipe_headers_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_dpipe_headers_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_DPIPE_TABLE_COUNTERS_SET - do */
-static const struct nla_policy devlink_dpipe_table_counters_set_nl_policy[DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED + 1] = {
+static const struct nla_policy devlink_dpipe_table_counters_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_DPIPE_TABLE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED] = { .type = NLA_U8, },
 };
 
 /* DEVLINK_CMD_RESOURCE_SET - do */
-static const struct nla_policy devlink_resource_set_nl_policy[DEVLINK_ATTR_RESOURCE_SIZE + 1] = {
+static const struct nla_policy devlink_resource_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_RESOURCE_ID] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RESOURCE_SIZE] = { .type = NLA_U64, },
 };
 
 /* DEVLINK_CMD_RESOURCE_DUMP - do */
-static const struct nla_policy devlink_resource_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_resource_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_RELOAD - do */
-static const struct nla_policy devlink_reload_nl_policy[DEVLINK_ATTR_RELOAD_LIMITS + 1] = {
+static const struct nla_policy devlink_reload_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_RELOAD_ACTION] = NLA_POLICY_RANGE(NLA_U8, 1, 2),
 	[DEVLINK_ATTR_RELOAD_LIMITS] = NLA_POLICY_BITFIELD32(6),
 	[DEVLINK_ATTR_NETNS_PID] = { .type = NLA_U32, },
@@ -289,22 +324,25 @@ static const struct nla_policy devlink_reload_nl_policy[DEVLINK_ATTR_RELOAD_LIMI
 };
 
 /* DEVLINK_CMD_PARAM_GET - do */
-static const struct nla_policy devlink_param_get_do_nl_policy[DEVLINK_ATTR_PARAM_NAME + 1] = {
+static const struct nla_policy devlink_param_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_PARAM_GET - dump */
-static const struct nla_policy devlink_param_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_param_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_PARAM_SET - do */
-static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_PARAM_RESET_DEFAULT + 1] = {
+static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PARAM_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PARAM_TYPE] = NLA_POLICY_VALIDATE_FN(NLA_U8, &devlink_attr_param_type_validate),
 	[DEVLINK_ATTR_PARAM_VALUE_CMODE] = NLA_POLICY_MAX(NLA_U8, 2),
@@ -312,41 +350,46 @@ static const struct nla_policy devlink_param_set_nl_policy[DEVLINK_ATTR_PARAM_RE
 };
 
 /* DEVLINK_CMD_REGION_GET - do */
-static const struct nla_policy devlink_region_get_do_nl_policy[DEVLINK_ATTR_REGION_NAME + 1] = {
+static const struct nla_policy devlink_region_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_REGION_GET - dump */
-static const struct nla_policy devlink_region_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_region_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_REGION_NEW - do */
-static const struct nla_policy devlink_region_new_nl_policy[DEVLINK_ATTR_REGION_SNAPSHOT_ID + 1] = {
+static const struct nla_policy devlink_region_new_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_REGION_DEL - do */
-static const struct nla_policy devlink_region_del_nl_policy[DEVLINK_ATTR_REGION_SNAPSHOT_ID + 1] = {
+static const struct nla_policy devlink_region_del_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_REGION_READ - dump */
-static const struct nla_policy devlink_region_read_nl_policy[DEVLINK_ATTR_REGION_DIRECT + 1] = {
+static const struct nla_policy devlink_region_read_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_REGION_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_REGION_SNAPSHOT_ID] = { .type = NLA_U32, },
@@ -356,44 +399,50 @@ static const struct nla_policy devlink_region_read_nl_policy[DEVLINK_ATTR_REGION
 };
 
 /* DEVLINK_CMD_PORT_PARAM_GET - do */
-static const struct nla_policy devlink_port_param_get_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_param_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_PORT_PARAM_SET - do */
-static const struct nla_policy devlink_port_param_set_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_port_param_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_INFO_GET - do */
-static const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_info_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_GET - do */
-static const struct nla_policy devlink_health_reporter_get_do_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_GET - dump */
-static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_SET - do */
-static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD + 1] = {
+static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .type = NLA_U64, },
@@ -403,137 +452,155 @@ static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATT
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_RECOVER - do */
-static const struct nla_policy devlink_health_reporter_recover_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_recover_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_DIAGNOSE - do */
-static const struct nla_policy devlink_health_reporter_diagnose_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_diagnose_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_DUMP_GET - dump */
-static const struct nla_policy devlink_health_reporter_dump_get_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_dump_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_DUMP_CLEAR - do */
-static const struct nla_policy devlink_health_reporter_dump_clear_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_dump_clear_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_FLASH_UPDATE - do */
-static const struct nla_policy devlink_flash_update_nl_policy[DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK + 1] = {
+static const struct nla_policy devlink_flash_update_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_FLASH_UPDATE_FILE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_FLASH_UPDATE_COMPONENT] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK] = NLA_POLICY_BITFIELD32(3),
 };
 
 /* DEVLINK_CMD_TRAP_GET - do */
-static const struct nla_policy devlink_trap_get_do_nl_policy[DEVLINK_ATTR_TRAP_NAME + 1] = {
+static const struct nla_policy devlink_trap_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_TRAP_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_TRAP_GET - dump */
-static const struct nla_policy devlink_trap_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_trap_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_TRAP_SET - do */
-static const struct nla_policy devlink_trap_set_nl_policy[DEVLINK_ATTR_TRAP_ACTION + 1] = {
+static const struct nla_policy devlink_trap_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_TRAP_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_TRAP_ACTION] = NLA_POLICY_MAX(NLA_U8, 2),
 };
 
 /* DEVLINK_CMD_TRAP_GROUP_GET - do */
-static const struct nla_policy devlink_trap_group_get_do_nl_policy[DEVLINK_ATTR_TRAP_GROUP_NAME + 1] = {
+static const struct nla_policy devlink_trap_group_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_TRAP_GROUP_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_TRAP_GROUP_GET - dump */
-static const struct nla_policy devlink_trap_group_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_trap_group_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_TRAP_GROUP_SET - do */
-static const struct nla_policy devlink_trap_group_set_nl_policy[DEVLINK_ATTR_TRAP_POLICER_ID + 1] = {
+static const struct nla_policy devlink_trap_group_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_TRAP_GROUP_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_TRAP_ACTION] = NLA_POLICY_MAX(NLA_U8, 2),
 	[DEVLINK_ATTR_TRAP_POLICER_ID] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_TRAP_POLICER_GET - do */
-static const struct nla_policy devlink_trap_policer_get_do_nl_policy[DEVLINK_ATTR_TRAP_POLICER_ID + 1] = {
+static const struct nla_policy devlink_trap_policer_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_TRAP_POLICER_ID] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_TRAP_POLICER_GET - dump */
-static const struct nla_policy devlink_trap_policer_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_trap_policer_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_TRAP_POLICER_SET - do */
-static const struct nla_policy devlink_trap_policer_set_nl_policy[DEVLINK_ATTR_TRAP_POLICER_BURST + 1] = {
+static const struct nla_policy devlink_trap_policer_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_TRAP_POLICER_ID] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_TRAP_POLICER_RATE] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_TRAP_POLICER_BURST] = { .type = NLA_U64, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_TEST - do */
-static const struct nla_policy devlink_health_reporter_test_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_NAME + 1] = {
+static const struct nla_policy devlink_health_reporter_test_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_RATE_GET - do */
-static const struct nla_policy devlink_rate_get_do_nl_policy[DEVLINK_ATTR_RATE_NODE_NAME + 1] = {
+static const struct nla_policy devlink_rate_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_RATE_GET - dump */
-static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TX_SHARE] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
@@ -544,9 +611,10 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_B
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TX_SHARE] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
@@ -557,50 +625,57 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_B
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
-static const struct nla_policy devlink_rate_del_nl_policy[DEVLINK_ATTR_RATE_NODE_NAME + 1] = {
+static const struct nla_policy devlink_rate_del_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_LINECARD_GET - do */
-static const struct nla_policy devlink_linecard_get_do_nl_policy[DEVLINK_ATTR_LINECARD_INDEX + 1] = {
+static const struct nla_policy devlink_linecard_get_do_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_LINECARD_INDEX] = { .type = NLA_U32, },
 };
 
 /* DEVLINK_CMD_LINECARD_GET - dump */
-static const struct nla_policy devlink_linecard_get_dump_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_linecard_get_dump_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_LINECARD_SET - do */
-static const struct nla_policy devlink_linecard_set_nl_policy[DEVLINK_ATTR_LINECARD_TYPE + 1] = {
+static const struct nla_policy devlink_linecard_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_LINECARD_INDEX] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_LINECARD_TYPE] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_SELFTESTS_GET - do */
-static const struct nla_policy devlink_selftests_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+static const struct nla_policy devlink_selftests_get_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 };
 
 /* DEVLINK_CMD_SELFTESTS_RUN - do */
-static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_SELFTESTS + 1] = {
+static const struct nla_policy devlink_selftests_run_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_SELFTESTS] = NLA_POLICY_NESTED(devlink_dl_selftest_id_nl_policy),
 };
 
 /* DEVLINK_CMD_NOTIFY_FILTER_SET - do */
-static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_PORT_INDEX + 1] = {
+static const struct nla_policy devlink_notify_filter_set_nl_policy[DEVLINK_ATTR_INDEX + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_INDEX] = NLA_POLICY_FULL_RANGE(NLA_UINT, &devlink_attr_index_range),
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
 };
 
@@ -613,7 +688,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -629,14 +704,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -646,7 +721,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_FUNCTION,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -656,7 +731,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_PCI_SF_NUMBER,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -666,7 +741,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_del_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_del_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -676,7 +751,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_split_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_split_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_SPLIT_COUNT,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -686,7 +761,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_unsplit_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_unsplit_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -696,14 +771,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -713,14 +788,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -730,7 +805,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_pool_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_pool_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_POOL_THRESHOLD_TYPE,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -740,14 +815,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -757,7 +832,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_port_pool_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_port_pool_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_THRESHOLD,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -767,14 +842,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -784,7 +859,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_tc_pool_bind_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_tc_pool_bind_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_TC_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -794,7 +869,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_occ_snapshot_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_occ_snapshot_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -804,7 +879,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_sb_occ_max_clear_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_sb_occ_max_clear_nl_policy,
-		.maxattr	= DEVLINK_ATTR_SB_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -814,7 +889,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_eswitch_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_eswitch_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -824,7 +899,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_eswitch_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_eswitch_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_ESWITCH_ENCAP_MODE,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -834,7 +909,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_dpipe_table_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_dpipe_table_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DPIPE_TABLE_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -844,7 +919,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_dpipe_entries_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_dpipe_entries_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DPIPE_TABLE_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -854,7 +929,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_dpipe_headers_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_dpipe_headers_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -864,7 +939,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_dpipe_table_counters_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_dpipe_table_counters_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DPIPE_TABLE_COUNTERS_ENABLED,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -874,7 +949,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_resource_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_resource_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RESOURCE_SIZE,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -884,7 +959,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_resource_dump_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_resource_dump_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -894,7 +969,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_reload_doit,
 		.post_doit	= devlink_nl_post_doit_dev_lock,
 		.policy		= devlink_reload_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RELOAD_LIMITS,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -904,14 +979,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -921,7 +996,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_param_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_param_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PARAM_RESET_DEFAULT,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -931,14 +1006,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -948,7 +1023,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_region_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_region_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_REGION_SNAPSHOT_ID,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -958,7 +1033,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_region_del_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_region_del_nl_policy,
-		.maxattr	= DEVLINK_ATTR_REGION_SNAPSHOT_ID,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -966,7 +1041,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.validate	= GENL_DONT_VALIDATE_DUMP_STRICT,
 		.dumpit		= devlink_nl_region_read_dumpit,
 		.policy		= devlink_region_read_nl_policy,
-		.maxattr	= DEVLINK_ATTR_REGION_DIRECT,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -976,7 +1051,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_param_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_param_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -992,7 +1067,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_port_param_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_port_param_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_PORT_INDEX,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1002,7 +1077,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_info_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_info_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -1018,14 +1093,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -1035,7 +1110,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1045,7 +1120,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_recover_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_recover_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1055,7 +1130,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_diagnose_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_diagnose_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1063,7 +1138,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.validate	= GENL_DONT_VALIDATE_DUMP_STRICT,
 		.dumpit		= devlink_nl_health_reporter_dump_get_dumpit,
 		.policy		= devlink_health_reporter_dump_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
 	},
 	{
@@ -1073,7 +1148,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_dump_clear_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_dump_clear_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1083,7 +1158,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_flash_update_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_flash_update_nl_policy,
-		.maxattr	= DEVLINK_ATTR_FLASH_UPDATE_OVERWRITE_MASK,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1093,14 +1168,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -1110,7 +1185,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_trap_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_trap_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_TRAP_ACTION,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1120,14 +1195,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -1137,7 +1212,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_trap_group_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_trap_group_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_TRAP_POLICER_ID,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1147,14 +1222,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -1164,7 +1239,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_trap_policer_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_trap_policer_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_TRAP_POLICER_BURST,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1174,7 +1249,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_test_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_test_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1184,14 +1259,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -1201,7 +1276,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1211,7 +1286,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1221,7 +1296,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_del_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_del_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_NODE_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1231,14 +1306,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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
@@ -1248,7 +1323,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_linecard_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_linecard_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_LINECARD_TYPE,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1258,7 +1333,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_selftests_get_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_selftests_get_nl_policy,
-		.maxattr	= DEVLINK_ATTR_DEV_NAME,
+		.maxattr	= DEVLINK_ATTR_INDEX,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
@@ -1274,14 +1349,14 @@ const struct genl_split_ops devlink_nl_ops[74] = {
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


