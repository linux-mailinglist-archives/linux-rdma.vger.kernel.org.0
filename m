Return-Path: <linux-rdma+bounces-22353-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BvMsKrEHNGo+LgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22353-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 16:58:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FEC6A112C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 16:58:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=ESNZzhlj;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22353-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22353-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A030F3056607
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFDC3F413D;
	Thu, 18 Jun 2026 14:55:56 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737423F54BD
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 14:55:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794555; cv=none; b=PfL5Emwqd9e+VtRAS09xiWIo9j8PLtktUzK6yVhe3nHiepYnhY0kY1dv2i3o759bFcXTzXqmT4o6XqY0rBX3PYdv/ygZYftah1k95bZZK/QQBwNeb9LmH0O3dTQDml2U9B5Ro0cD3U7TYxP2H3sw5/+GwwvZfkT2B+ooghQxVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794555; c=relaxed/simple;
	bh=u9jzJTCuSR4v5CZ3TCwHDA26j82Y/8H6b8z/ylkoAzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fi13yi8cU7QDeWUUq8DXkE/twCmAbxfxsQJQlQnvJOp73CH8WAaOSPGpXaZJzCHVPjsdDOTefQifihKrZkXuTi837iutvOxY7nN/LXNh/G9th/QwYBsYYPZ+23Dol4jtxvtTFS9Kg4p8yocbP+WRv9wg90AzqSnTmD3R+m6b5OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=ESNZzhlj; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-463f1165e16so900712f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 07:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1781794548; x=1782399348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l4SVpdsBcLaIGz1nZfhK4QzCtZCeVsaw2otrcfNi0wE=;
        b=ESNZzhlj1X+3hi2Sj2hUHQBcWaaCIbyzREOpg/zsU9thxqKT62MtmEOcAdm2TTX5zC
         Unw8SjULsAUMCb8mx7ZgAte1oltPiSphMWi+mAX6r101t8EGmtbgZG+RydHL1yENydtw
         pc1+VFw0NFy1EfaTo1Jb4foHW6VWWFnKyFxJnexVtDrQklDDTBuUDdZpEVPOOBkKZbkz
         o0Bwuo9uMhADW3tr47+Q7f4rfuU2d4b8WwqqVK+4l9X7oLiKKa7Obiq7iH4nYRToxSoe
         sqk1m9CzOTkpt777rU0yAFV42Mt7D7hdZcESE09raodXqtJeNWkDSq8yU0VuXPD2mJMt
         ungA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781794548; x=1782399348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4SVpdsBcLaIGz1nZfhK4QzCtZCeVsaw2otrcfNi0wE=;
        b=DqCYqj3XiSSJjIcMSlyzqpPCFZa02Tos+f4adkOSKNqyTQJf+nVvfqfuU3/zJd+kFb
         KCcBTuTzSzj3JaOMz6YRSs0q1O+fqjPTxPmAHxJbMP8GJZGM6JNNwnnziBRlzV4CiU8e
         EQnZoFSUaYlonAHlLxEFVBszlGgHBXcs8OH2Ehk3T7Faq90jycK18kWjNm9N+cSic6rf
         cInVlVg/LcTZp1SjooSQ5QYOou3ibrz5HeRVnuHtJ1bwg5zlX68WdvK7XaugOTyaL2yj
         TLjYYccaK3DMGyzMpxoicy99PdHadQZsB9H9uVlDmWwKY1M4Rfw3CdFOm40Q2o6XrNPO
         FYcA==
X-Forwarded-Encrypted: i=1; AFNElJ+l/s2Xju73qaUWbviz0uL86HxdUcAdEquK/AWtGVIeDAmeII/z2OdftzTlStFPCbPgtJ6goiBQiNm8@vger.kernel.org
X-Gm-Message-State: AOJu0Yy74c+3a77O/3QAZHOv2sa+7oaVn93gHJc9pwO44zboqezBi5ax
	PqBgLd1fhlyBSa4v9v7iDNe1p2O6ngSSXuLDgbcjopY5U4pvTl++c9XkXsWnmoAGdLdg
X-Gm-Gg: AfdE7ckIldefU1C959QuKNgxkjxAeBtX3ikkLTcsmcnppcuRk1jB74wXheqpBATaAVF
	xRyvAti2EDkCW6ATd0fNoCGkCPVPT778GVtS6dvREdhedEDpfP2qCcSHlvg/Ygh5qnWVjiJ2pND
	jvdEFCV0iI+k0NoC5QBtQc7YWb/RthBmb6QSlsubhsrKQGHDKtWL4MLXvaiYUHd5nIgKvrEly29
	1ZbNAeT7mq+wcq+Tmn4KVkwHgugnrAwjS8iPsUBN8LVGeXQRHZHHqWH6pujXVEpNoAK1JFltYRn
	r9Qi4vdkRo/Iu8guk33bIOxKkVlpBONo36M2Kx17UCVPGXf40Teq6P7boKAihP1743gSR4vQ2VM
	CNZmX9iPwQCEu2AtqHvZUmuIEpD5ttMwPY9lROxdxIDCpayhtS71LZ0UpzneTM0wk5+OA0EHO3s
	84nkJ1cIt6mrL8FqI8rynOFoIhlrtzb/p4U0weUbOfEx/88e+ALdZf27EGCZBT0ZeqnihOGMGX4
	QkKXyxUOcOLfYqJXcNPA3cAiEO+rv/l+t8=
X-Received: by 2002:adf:ef8d:0:b0:460:1f32:628d with SMTP id ffacd0b85a97d-4623683a4bdmr10901952f8f.11.1781794548276;
        Thu, 18 Jun 2026 07:55:48 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm63857002f8f.3.2026.06.18.07.55.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Jun 2026 07:55:47 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: borisp@nvidia.com,
	raeds@nvidia.com,
	ehakim@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	horms@kernel.org
Subject: [PATCH net v3] net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete
Date: Thu, 18 Jun 2026 16:55:45 +0200
Message-ID: <20260618145545.53035-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:borisp@nvidia.com,m:raeds@nvidia.com,m:ehakim@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22353-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[0sec.ai];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[0sec.ai:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:dkim,0sec.ai:email,0sec.ai:mid,0sec.ai:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25FEC6A112C

When an offloaded MACsec RX SC is deleted, macsec_del_rxsc_ctx() released
the per-SC metadata_dst with metadata_dst_free(), which calls kfree()
unconditionally and ignores the dst reference count. The RX datapath in
mlx5e_macsec_offload_handle_rx_skb() looks up the SC under rcu_read_lock()
via xa_load() and, while still holding only the RCU read lock, takes a
reference with dst_hold() and attaches the dst to the skb with
skb_dst_set().

A reader that has already obtained the rx_sc pointer can therefore race
with the delete path:

  CPU0 (del_rxsc)			CPU1 (rx datapath)
  --------------			------------------
					rcu_read_lock();
					rx_sc = xa_load(...)->rx_sc;
  xa_erase(...);
  metadata_dst_free(rx_sc->md_dst);	/* kfree(), ignores refcount */
					dst_hold(&rx_sc->md_dst->dst); /* UAF */
					skb_dst_set(skb, &rx_sc->md_dst->dst);

metadata_dst_free() frees the object even though the datapath still holds
(or is about to take) a reference, so the subsequent dst_hold() /
skb_dst_set() and the later skb free operate on freed memory.

Fix the owner side by dropping the reference with dst_release() instead of
freeing unconditionally. dst_release() only schedules the RCU-deferred
dst_destroy() once the reference count reaches zero, so a concurrent reader
that still holds a reference keeps the object alive.

Dropping the owner reference is not sufficient on its own: once the owner
reference is the last one, dst_release() drops the count to zero and the
destroy is merely RCU-deferred. A racing reader that runs plain dst_hold()
on that already-dead dst gets rcuref_get() == false but dst_hold() only
WARNs and attaches the dying dst to the skb anyway; the later skb free then
calls dst_release() on an object whose destroy is already scheduled, again
a use-after-free.

Convert the RX datapath to dst_hold_safe(), which returns false (without
warning) when the dst is already dead, and only attach it to the skb when a
reference was successfully taken. When the SC is being deleted the in-flight
packet simply proceeds without the offload metadata_dst: skb_metadata_dst()
returns NULL, the MACsec core sees !is_macsec_md_dst and skips this secy
(rx_uses_md_dst path), which is the correct behaviour for a packet whose SC
is going away.

While reworking the datapath lookup, also guard the two NULL dereferences
on the same path that an automated review (forwarded by Simon Horman)
flagged: xa_load() can return NULL when the fs_id has just been erased, and
mlx5e_macsec_add_rxsc() publishes sc_xarray_element via xa_alloc() before
rx_sc->md_dst is allocated, so a packet carrying a freshly recycled fs_id
can observe a non-NULL rx_sc whose md_dst is still NULL. Check both before
dereferencing.

Note: macsec_del_rxsc_ctx() also kfree()s rx_sc->sc_xarray_element without
an RCU grace period while the same datapath reads it under rcu_read_lock();
that is a separate pre-existing issue and is left to a follow-up patch.

Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v3:
 - Also guard the RX-datapath NULL dereferences flagged by the automated
   review: NULL-check the xa_load() result and rx_sc->md_dst before use.
 - Note the unrelated non-RCU kfree(sc_xarray_element) in the delete path
   as a separate follow-up rather than folding it in here.
v2:
 - Convert the RX datapath dst_hold() to dst_hold_safe() so a reader racing
   the SC delete cannot attach a dst whose last reference was just dropped
   (per the automated review forwarded by Simon Horman).
v1: https://lore.kernel.org/netdev/20260615140534.52691-1-doruk@0sec.ai/

 .../net/ethernet/mellanox/mlx5/core/en_accel/macsec.c  | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 71b3a05..fb2c64d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -829,7 +829,7 @@ static void macsec_del_rxsc_ctx(struct mlx5e_macsec *macsec, struct mlx5e_macsec
 	 */
 	list_del_rcu(&rx_sc->rx_sc_list_element);
 	xa_erase(&macsec->sc_xarray, rx_sc->sc_xarray_element->fs_id);
-	metadata_dst_free(rx_sc->md_dst);
+	dst_release(&rx_sc->md_dst->dst);
 	kfree(rx_sc->sc_xarray_element);
 	kfree_rcu_mightsleep(rx_sc);
 }
@@ -1695,10 +1695,10 @@ void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
 
 	rcu_read_lock();
 	sc_xarray_element = xa_load(&macsec->sc_xarray, fs_id);
-	rx_sc = sc_xarray_element->rx_sc;
-	if (rx_sc) {
-		dst_hold(&rx_sc->md_dst->dst);
-		skb_dst_set(skb, &rx_sc->md_dst->dst);
+	rx_sc = sc_xarray_element ? sc_xarray_element->rx_sc : NULL;
+	if (rx_sc && rx_sc->md_dst) {
+		if (dst_hold_safe(&rx_sc->md_dst->dst))
+			skb_dst_set(skb, &rx_sc->md_dst->dst);
 	}
 
 	rcu_read_unlock();
-- 
2.53.0


