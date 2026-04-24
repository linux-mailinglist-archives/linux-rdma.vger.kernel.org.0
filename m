Return-Path: <linux-rdma+bounces-19524-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O7VNh/z6mk1GQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19524-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 06:35:43 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D1A459CDB
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 06:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4080E3011F0E
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Apr 2026 04:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7D71A680E;
	Fri, 24 Apr 2026 04:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hdpwCntp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39CBA3D
	for <linux-rdma@vger.kernel.org>; Fri, 24 Apr 2026 04:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777005338; cv=none; b=HjefXGCwlwy+Dl92yxKqm1wcHOCzlDQJTPU3FBDI49EplUbfhyBBhjZk2ZIZDBrXs6Ru1+hvhnfRKbY20qVUnnLPnJBkhVdskcBe7HpdiCoV0WRGep3E5xZHz5rz2NV8DuA9Dsa4fSPDfj+R3o3oQuPtDvmfBXEC1eLg/zB7fP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777005338; c=relaxed/simple;
	bh=HgO9S3BkYHRQ0B11zHzgG0IkSdQcIX7pUgx+hxTXzw4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=izq5B+55bw3caH6hJwgtI4NtSpR11oUDNcSc3jrep8lTDfMicCBRmzIi+hSelwyhCZlBoE+MpQCkexKSXPbzAA2HYBI/Cf2qXbqvJViBRF061AE496lITXrY8nhz3xCajI+frBGUODhurJCaIy8MvzzQ4YP6A5Va/vKvufYFh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hdpwCntp; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777005333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=guuZ0j/x92mkd/RiCiHkM7Z0uXWdf3eeAmssHM3KRAE=;
	b=hdpwCntp9JT9wkwMIHwnUVNbzJh0Xghj2pWIsiErlFqPDq3enKie9Vp4NxfMZjDhg8AWNF
	k0FwlG72zLX30TDai7skgAnX9KJsXqmS6snsKNI27VSk1ybvLQApOl0vR7ZiccUJz7gt+3
	M80S+cEe41selqfjde9N97F0tl34OPw=
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH 1/1] RDMA/rxe: Fix unsafe socket release during namespace cleanup
Date: Fri, 24 Apr 2026 06:35:22 +0200
Message-ID: <20260424043522.22901-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D8D1A459CDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19524-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,vger.kernel.org,linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

Since all the sockets are created in rdma link create command
and destroyed in rdma link delete command, keeping
udp_tunnel_sock_release in rxe_ns_exit risks a "double-free" if
the namespace and the device are being cleaned up simultaneously.

Fixes: 13f2a53c2a71 ("RDMA/rxe: Add net namespace support for IPv4/IPv6 sockets")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/infiniband/sw/rxe/rxe_ns.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_ns.c b/drivers/infiniband/sw/rxe/rxe_ns.c
index 8b9d734229b2..53add78b8e3a 100644
--- a/drivers/infiniband/sw/rxe/rxe_ns.c
+++ b/drivers/infiniband/sw/rxe/rxe_ns.c
@@ -39,26 +39,6 @@ static void rxe_ns_exit(struct net *net)
 {
 	/* called when the network namespace is removed
 	 */
-	struct rxe_ns_sock *ns_sk = net_generic(net, rxe_pernet_id);
-	struct sock *sk;
-
-	rcu_read_lock();
-	sk = rcu_dereference(ns_sk->rxe_sk4);
-	rcu_read_unlock();
-	if (sk) {
-		rcu_assign_pointer(ns_sk->rxe_sk4, NULL);
-		udp_tunnel_sock_release(sk->sk_socket);
-	}
-
-#if IS_ENABLED(CONFIG_IPV6)
-	rcu_read_lock();
-	sk = rcu_dereference(ns_sk->rxe_sk6);
-	rcu_read_unlock();
-	if (sk) {
-		rcu_assign_pointer(ns_sk->rxe_sk6, NULL);
-		udp_tunnel_sock_release(sk->sk_socket);
-	}
-#endif
 }
 
 /*
-- 
2.43.0


