Return-Path: <linux-rdma+bounces-22260-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /GFBBIA6MGq4QAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22260-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:46:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76356688F0D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:46:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ankey-net.20251104.gappssmtp.com header.s=20251104 header.b=TJ5X9c9+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22260-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22260-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9C04305A212
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C5130C179;
	Mon, 15 Jun 2026 17:46:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E6305680
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:46:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545584; cv=none; b=AcaaUPFPqVCO3NDXg3fFXIznS5LbaYKbUHd2bA9MD9Yic6GNWjwjLMQ/zwAZ9ABhCaVgAgGlOFeZpjX960lqB3C0RlmJbBh+cI9G7z3CYETkNHLLKbnlNEArq/7FMe/1waho31sqT5GrQUktJA1jv4ahpr/TQC50DqerRdHKgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545584; c=relaxed/simple;
	bh=pyOrnNpJGd2dapO35pY6K6uj+/dk+op3maz1n/yK9Mw=;
	h=From:Subject:Date:To:Cc:Message-ID:In-Reply-To:References; b=YoVouext6ZlpR4ZkI50pOw0w0vBOEosuek2Gj/ydX6Q/O5ygOiuq3kAr/FRFG7p4SNcMqORQSfNiWT5G63pbE7FdeYrT0vbonwJHUYNStCLZM9RyqLV3P7RYfyq/tqOG8Ucwr2ht5wmpxp/Lp0Av8Snj4Pl6DlNrIMnxfCDQw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net; spf=none smtp.mailfrom=ankey.net; dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b=TJ5X9c9+; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84237c55ef9so2327075b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ankey-net.20251104.gappssmtp.com; s=20251104; t=1781545583; x=1782150383; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:cc:to:date:subject:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J6Dz8o9Ws8v17p3yxoQcldpA2jKECp2Yes6whuzgrz0=;
        b=TJ5X9c9+290G1aY1H+x96js5ox8q/MxFg3tB61ySvPkkmDOVFyIsnNbz5u+MYNy3s9
         TorTuaRcrvMzXDuZ3A3APmTVYfdF5a9viLLytDjHBfnm6wFIcOhxFDNxYoQzADhOnXEQ
         ZJ/AYAw5xxFJWnQT0VVCu1bNZj9jAbSHw3nb1/kk1cGYYvaqK6LZ6FhgwI8I9WeotmfO
         JXMtFeoYf3iA/s/e52i601WELUPHg842Eidps6S/H1jCaUfovHqBJSDv1sU+lVYvCodM
         xL8ofipx7zwgVzYEndd812Uzb9flVHJu8RoOoA9Vh7Emrih8GfX/CPrZXyvCOfIeasUI
         fNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545583; x=1782150383;
        h=references:in-reply-to:message-id:cc:to:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6Dz8o9Ws8v17p3yxoQcldpA2jKECp2Yes6whuzgrz0=;
        b=dExtF4O99TgcxeEyNvoAminBR/Nnw9pZr77+vlzQmohfzf6GyAPGdiU+CcKNNK77xP
         AbiN1OzAmlqpHlxvZhDha3rHKJJc9s3Hkl7+FzBbiwG3ZZ6rIXDsrUTs4lpu0Ov1sF/z
         KJIz/xAT4NsicV0gkNeEhoo7tBMn5aIZWeRxijbUm78fAU4IOd+BaWJ8fpV+mwIu1EwI
         WdDtkG9vu/DQM6SaPOChgrk1OiXTJFLctl6w+6SpLd+p08+R/DMlBEBVbChZgh1ULyYY
         2c1xcgUuFY28jtngY9PkJJ7sm7LoJ4qXkmcb6ZvNwLmx0WIbHH7qEjuWyHRiufUOKOmo
         7bQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/qzTizL6N5d+VXFxzgxy0fmZTD0U7AoRMf7m2gDQirso9oq8tZcL/Tq9TsKI3qt9hSyE56zCw3J1vy@vger.kernel.org
X-Gm-Message-State: AOJu0YxonR2CdPUzwGh6iE20X4FWyOf2Q03Vo5pnasng8E3xA5O+igUr
	jVanNiAGPtx8+Ab8HGwrNHHaHRHryZ/oIhIyg70zwx9/ybrMLf6rFFqcnO7aZ21RZg==
X-Gm-Gg: Acq92OF+2VVNERvP1QI6ZHgRm5tqkruNrezz0B9PZhkqCgg47Rv28DJugxE5t2YG/qV
	3BsUSwryHBfSiprUVc9PSDBjXF6TC2RK6DGWKH31Ikx+opo8K5UrQsPfEtDAFyh2GyHNtB4EiaE
	55xmwXvyjs7c9QJA7ByK1Nmg61Mrpji77ktgYAXh2lYdkt4T0ZfO6DUJAqisNPzlO945JyI5fwL
	NYTpGAVSvbqiaaX0z0EalP6SEuxJcXS2QZgcVEBNOAV4huwDfdqxN+LwePlpDF1WAJ0UY00ZEFz
	f9xYcHDvfinlYAq/9IBk5ZMpQyUj8FqWaERVgxDCr7l4guJZ3oeZu30DtNl/ozWyCsO+Owv+L7R
	pOf0X/HYcHl5zZRJ7ldMVBHEyMUydrOGyII8V/ZZGwnQKavIKdgSFnXaZZUbfZHUcs7x/e6Ocvu
	ICYyEPvjBrvU3pcjkmic/JW1ozsd3UVVzOwUDPBWXB36hCQNV1Nn1k1kznOVeJ93apTXv3gHPG9
	YlO2mg0WyUaCyw9+w5TTd4L1HDYvvoTuLFb
X-Received: by 2002:a05:6a00:3908:b0:842:33f3:da7f with SMTP id d2e1a72fcca58-8434cd0c971mr15482546b3a.2.1781545582913;
        Mon, 15 Jun 2026 10:46:22 -0700 (PDT)
Received: from atimofey-ld1.linkedin.biz ([52.149.25.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accae18sm11214086b3a.17.2026.06.15.10.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:46:22 -0700 (PDT)
From: Alex Timofeyev <sashka@ankey.net>
Subject: [PATCH rdma-next v1 2/2] RDMA/cma: accept cross-NIC same-host local
 dst in validate_ipv6_net_dev
Date: Mon, 15 Jun 2026 17:46:19 +0000
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1781545579.3-sashka@ankey.net>
In-Reply-To: <1781545579.1-sashka@ankey.net>
References: <1781545579.1-sashka@ankey.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ankey-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22260-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:parav@nvidia.com,m:edwards@nvidia.com,m:vdumitrescu@nvidia.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashka@ankey.net,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[ankey.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ankey-net.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashka@ankey.net,linux-rdma@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ankey.net:email,ankey.net:mid,ankey.net:from_mime,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,ankey-net.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 76356688F0D

validate_ipv6_net_dev() confirms an incoming CM REQ was delivered on the
correct net_dev with an rt6_lookup() that requires
rt->rt6i_idev->dev == net_dev. For an IPv6 destination that is local to a
different netdev of the same host, the FIB resolves the lookup onto the
loopback netdev, so rt6i_idev->dev is lo regardless of which physical
netdev owns the listener address. The strict comparison then rejects the
REQ with -EHOSTUNREACH even though it was correctly delivered on net_dev.

Accept the request when the resolved route is RTF_LOCAL and net_dev itself
owns the address the listener was bound to (src_addr). This is the
receive-side counterpart to the cross-NIC same-host send-side fix in
addr_resolve_neigh().

Fixes: f887f2ac87c2 ("IB/cma: Validate routing of incoming requests")
Cc: stable@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>
Signed-off-by: Alex Timofeyev <sashka@ankey.net>
---
 drivers/infiniband/core/cma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 9480d1a51c11..872c57943362 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1635,7 +1635,20 @@ static bool validate_ipv6_net_dev(struct net_device *net_dev,
 	if (!rt)
 		return false;
 
-	ret = rt->rt6i_idev->dev == net_dev;
+	if (rt->rt6i_idev->dev == net_dev) {
+		ret = true;
+	} else if (rt->rt6i_flags & RTF_LOCAL) {
+		/* For a destination that is local to another netdev of the same
+		 * host, the FIB collapses the lookup onto the loopback netdev,
+		 * so rt6i_idev->dev is not net_dev even though the request was
+		 * correctly delivered on net_dev. Accept it when net_dev itself
+		 * owns the address we were listening on.
+		 */
+		ret = ipv6_chk_addr(dev_net(net_dev), &src_addr->sin6_addr,
+				    net_dev, 1);
+	} else {
+		ret = false;
+	}
 	ip6_rt_put(rt);
 
 	return ret;
-- 
2.40.4


