Return-Path: <linux-rdma+bounces-22259-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id egJrEcs6MGrFQAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22259-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:47:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B17688F36
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 19:47:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ankey-net.20251104.gappssmtp.com header.s=20251104 header.b=pa4XmYcx;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22259-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22259-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B68D305093D
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Jun 2026 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3572DD5F6;
	Mon, 15 Jun 2026 17:46:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279E264614
	for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 17:46:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781545584; cv=none; b=ZsB3uOwGk1Ba/aacB28q8mDlozaBut4NYYn5XxzvXN7Imz1AmfT86H8ZuWdPywYlKWpxpx1biq9aaCArkBkgJILVqo7362I2d158ZEsksfz94kRx9LJEnV4l05CoO3NvfTPsrTe4wt9zs/PtMToJ66y1hC2VbB68ncOShDjUFDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781545584; c=relaxed/simple;
	bh=6FChuiiY1Ab4DoQ0VIjmNXOowo/9a9Qo6Y6YIXFBBsw=;
	h=From:Subject:Date:To:Cc:Message-ID:In-Reply-To:References; b=ojO+k0wOeCU5y1lPs0/pRHvZL0z2sKdRkGdr3oVH4YBlDvAh9zDswUZOkX8E6uREjnOd0093HZmrrIfzI49XPTHEX7fCUdVaYsQcAcOw1cnSZ6QzSGSxmHjMO4nFHHIL+GP3gZE6e8UB6wYaUn329temeySz7sWn4O/AuQyJkgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net; spf=none smtp.mailfrom=ankey.net; dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b=pa4XmYcx; arc=none smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8422f395a4aso2433438b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 15 Jun 2026 10:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ankey-net.20251104.gappssmtp.com; s=20251104; t=1781545582; x=1782150382; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:cc:to:date:subject:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EM3udb0oDgJN3cKMNmux7YsMkV9lDzcITmGFkVGmGqE=;
        b=pa4XmYcxUADAHuHOG3K+8NWlvTj24h7N/JrEGIWqgFjPaNqTt8HiBJ+eoGjulX/tUt
         +GUNCsQTohhqIdY5rMnCUWZ2ekPSoktw03uR919hD+dEbcbTsaITMxciZoi9m5eecfvY
         dficIhVifwvF3fTY9VW7a4+h9lHFkys+yMnbSaBCs3FyENYYY55zELXDODf0bUhEBvbj
         syVrsfj/eZDyPVndaVB0NdpPF/d2ipaPG3vFycXzQsPYHQzE+HXtwD8/FZpywpdM8O5C
         4UEIHFQNqxOXUo3tP8E8smAzX1qCU/5nGX3B0iElMJ49cN//YnqkHYF6e5ptCX8Ytbvq
         0OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781545582; x=1782150382;
        h=references:in-reply-to:message-id:cc:to:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EM3udb0oDgJN3cKMNmux7YsMkV9lDzcITmGFkVGmGqE=;
        b=AnH0srKRkvxXUbzAu+QtulCCJVoIf7imzvYnmeMSaEwU3ba+BQCO4UCAf1AiKVo7s1
         kxefz+l2SjTYQfe2+y2TsbXFsEGMvXBeacbySjgAVixMCitTOLVsWRqxHmgGTARzqEeW
         rcVK/6v9solbuFzQYy8aD3CoyipQ4kSLVtJ6PoYkvfBaM9IzOMmY5P/Yz9JddMWEHIAZ
         7AHckm+44MmucHdDMw0HMgqEApBcLJJL2h0++/y14pY9GFCLDXQk8I+M74b6fqSAsZmW
         QwoNBw1gZc/Lq/qjJx8bv6yinCDFVyiafN3jD69f7UR8ef0jXED6F+khIaOkAW4Q5u8H
         OGAA==
X-Forwarded-Encrypted: i=1; AFNElJ//71zVed25mT3GEtsCwgzsSjZddqm8fLCYwP60EAq2AObuagfDSH34MnFnpSmPNtz4i8yh9lcVgMI7@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+6sHtUlEoUVBE9LBISGihOEA3A6HIt/558REhCRc6IKhRkZQ
	313iWYfMhuNg+xpCoTVRQM/NvXy8jz6WQApHFiV5o4d7xsB5YPPqpyJDF5sDSvMJew==
X-Gm-Gg: Acq92OEinFx6cC1lYRqLM082ib27Z+DVNBZYo+QmltKtaBEIjVCX1iHamXF3Et3FBgq
	gNHPOuQfKeUAnEaOn9b5SrFW9ZNs3eBpeC2E/3fgwlIsQGYAtnEE2qYVgwxZzRxnTvQGiWTodjv
	lgceMAs/l49ymKQRFh4WyxJGvgke/oZsY2nLQxuQRyg7K8s4fDOVggIiXnwSKNXu0v7TUBXGnQ9
	jC6bJtBxW6YOCoLanfV/+ZrUjIhSnl6k9Gl+/MNXtOn9nJijPNCaTuhcG/4REG/jzPg5PnAo7dF
	XbNiNS6/0XnQz2pA5lgaTbkJAAoFYFdkcYfuGSZxMFOylAtHnHiLKk1x0bsR5QQhgNN6gzUaozO
	cOASM4SkRWue/SD/lGuvZaOQLYR9xJKM1Oc0PAGW91B3fZAVUO6R2SMCl3Mswov1DS+bDskKBhu
	uvoLNJY7GSNM1QHZR6s14M40t6LAhN6JQrqJDVE+zF6LQZqqopHJngk4Kw844UEjSbanQUHbmln
	4DSYp/gRKsFKQVGY6Gc6SapFNk2xgeFCFn3
X-Received: by 2002:a05:6a00:813:b0:842:614b:50e1 with SMTP id d2e1a72fcca58-84513e3c998mr348207b3a.12.1781545581724;
        Mon, 15 Jun 2026 10:46:21 -0700 (PDT)
Received: from atimofey-ld1.linkedin.biz ([52.149.25.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434accae18sm11214086b3a.17.2026.06.15.10.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:46:21 -0700 (PDT)
From: Alex Timofeyev <sashka@ankey.net>
Subject: [PATCH rdma-next v1 1/2] RDMA/core: use destination netdev MAC for
 cross-NIC same-host local dst
Date: Mon, 15 Jun 2026 17:46:19 +0000
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <1781545579.2-sashka@ankey.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ankey-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22259-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ankey-net.20251104.gappssmtp.com:dkim,ankey.net:email,ankey.net:mid,ankey.net:from_mime,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5B17688F36

addr_resolve_neigh() treats every is_dst_local() destination as loopback
and copies the source device's MAC into the path record's destination MAC
(dst_dev_addr <- src_dev_addr). That is correct for true loopback (source
and destination on the same netdev), but wrong when the local destination
address lives on a different netdev of the same host.

In that cross-NIC same-host case the destination NIC will not accept a
frame whose destination MAC is the source NIC's MAC, and drops it in
hardware before it reaches the peer. rdma_resolve_addr() and
ib_send_cm_req() both return success, but the CM REQ never arrives and the
connection times out.

Look up the netdev that owns the destination address and copy its MAC into
dst_dev_addr instead. Fall back to the source MAC when no netdev claims the
address (true loopback), preserving the existing behaviour.

This was observed with two RoCEv2 ConnectX-7 ports on the same host, each
holding a global IPv6 GID, when one process pinned per NUMA NIC connected
to the other over RDMA-CM: the resolved destination MAC was the source
port's MAC instead of the destination port's, and the REQ was silently
dropped. With the fix the resolved MAC is the destination port's and the
connection completes.

Fixes: c31e4038c97f ("RDMA/core: Use route entry flag to decide on loopback traffic")
Cc: stable@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>
Signed-off-by: Alex Timofeyev <sashka@ankey.net>
---
 drivers/infiniband/core/addr.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 7e62b5b1ffaa..84aa43436bfe 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -451,10 +451,26 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
 			      u32 seq)
 {
 	if (is_dst_local(dst)) {
-		/* When the destination is local entry, source and destination
-		 * are same. Skip the neighbour lookup.
+		struct net_device *dst_ndev;
+
+		/* When the destination is local, source and destination are on
+		 * the same host. For true loopback (same netdev) the source and
+		 * destination MACs are equal, but when the destination address
+		 * lives on a different netdev of the same host the destination
+		 * MAC must be that netdev's MAC -- otherwise the destination NIC
+		 * silently drops the frame. Look up the netdev that owns the
+		 * destination address and copy its MAC; fall back to the source
+		 * MAC if no netdev claims the address.
 		 */
-		memcpy(addr->dst_dev_addr, addr->src_dev_addr, MAX_ADDR_LEN);
+		rcu_read_lock();
+		dst_ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(dst->dev), dst_in);
+		if (!IS_ERR(dst_ndev))
+			memcpy(addr->dst_dev_addr, dst_ndev->dev_addr,
+			       MAX_ADDR_LEN);
+		else
+			memcpy(addr->dst_dev_addr, addr->src_dev_addr,
+			       MAX_ADDR_LEN);
+		rcu_read_unlock();
 		return 0;
 	}
 
-- 
2.40.4


