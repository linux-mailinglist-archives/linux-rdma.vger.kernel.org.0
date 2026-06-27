Return-Path: <linux-rdma+bounces-22538-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uqpTDDVPQGq7egkAu9opvQ
	(envelope-from <linux-rdma+bounces-22538-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 00:31:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B536D2C15
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 00:31:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=hmXnvMhF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22538-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22538-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BCED3008639
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132D137DE9B;
	Sat, 27 Jun 2026 22:31:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEB2264D6
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 22:31:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782599465; cv=none; b=RE98VEQoL09k91c9qMuW8dvg7yjQ6qYRMr/0BmAYRz3Ap0nd85pyH+uUT7wMnxFb2vuJr+AUbj16cjs1UZ+tGYVu1KS4LjnBlLrpP0E1hyUvDRa6UYneQGc2cCyFRbf+pmYQI02YsVp+F3gD8/L5LV6bnh8a3KlgztAchDFpf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782599465; c=relaxed/simple;
	bh=GgrIpowPt0gYM+hInsqIaEhdI36x5tUL6UzdU2OHJBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fte9EOWmlJfMhWc2sZwW8HuPLzlI+fvkcT5XH+YVctwfgRTIdMao+wim8QmdkJN1bzadGl+4w+Zf+B8g8QkKpU0TOEtXVF+hQS8jVkswLJemJWjCpC1vDTlkTEARDPspR3vkLFLVdNUU47oVNsmiqTbxEdDoo48X3aECl//wC9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=hmXnvMhF; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49258ac7294so16091045e9.0
        for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 15:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1782599462; x=1783204262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wfQpUHY0GFJWX8Gxj2L7x91zN6hrfhBDwHrlwXgs7Dc=;
        b=hmXnvMhFLaA1yev6v9KNx1iZStfaRRHgv4yRPB4/2qXYwAMA2k+VIlExkTo2Vw5ncg
         G1M774JKc096b22dZMuGM68Ht0E3cc6NklCCX5PPEDGDx1PnW9fIjSdenO35iApdKGb0
         2aedqKrhrmu1PWsvFRjg7bwQKkEUBZV8dvA0gL3VNo93qIy0jJ+SWxvEGNJFExEM7g+1
         0kFEY1qG3bnTMM9g85ag4YTKdruFSFEtlNgOQ+2Bawah2jVT2AesZOiqBYcrAVqSLanX
         a/Vj4Q7nD1rOkgVH0Ft+xcMIG2m7WWz20uSI3OKx2n1gsiMxjsc3Qdgv3u9B/Nz60KYl
         7KXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782599462; x=1783204262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfQpUHY0GFJWX8Gxj2L7x91zN6hrfhBDwHrlwXgs7Dc=;
        b=fo7d1UZ7dnz509BULDqQ9jYJw4QiUuVsSN6tjX1T0A/4VD9k9FCU3Li7vtWCsFegf7
         uXjL+dhi7BpLzI3KICvVfef9O7CLuVeAoRsDFozSbMm07Ol22bfSTYjGwCcimQhlNd0l
         o6U4FQZp4b3VQLTBIXgWQYXedqp6Iq6uFduKFW5yJYZ09KwdiIwAaJCFiLCfKG7kf+Wm
         5HLK4V7jxCfxZFhlL9OlLqZS1BvwIk3/PIYOpvGvoEglJ9E4VPJ0QFSaNixnIWuIqKcN
         pQ3sXxV9UYa2amHzwAPY3Ccb9WIlhbtxV/J6bFzbnuEJ7Za3Qeaze1PM2avLzQQH1i6O
         NE+w==
X-Forwarded-Encrypted: i=1; AHgh+RoDlWM3BOYfPzM1apc07OFTyq+3xXsBq4zzaX2y+Cj56aG9KeXhhJUFBRELzJMlcTPc7N8i3e6Rp204@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl+KO2d+5K96Hx9V1lzWiGa4H/WjRgoKHdGmYfcsdFmCuvj9BY
	nPECe+uvOXPYPw2Jxsybjh6PrMYKdCaZ7U0d+A0BvxKcDGmsioj+BuTXKfX5nNpDBi14
X-Gm-Gg: AfdE7cn9+YeMpJg+dulwj6g+B5EB3Xjjoyu2W0ORVK+tffjAU522DOt/20PdrLBp7Xn
	y6kTZi6WwKeWnN6/ex6Ypa6MFTyVhTizcIc/X0/hc9VFNHCG2XrnNo8sgRWrNFnf8P3s2A29nM/
	NRVX5PS3S/G/DF04xAZLDhgFbyyAvLrJLrkYPFRktMMxpCDFd5LLDEII3INFeV1fMNVcMN4FA0l
	8ZD2hYPhtLaijGQI0juMHMzhXaARyIZMPWp3AhTreAFaZGBwP5zf61is6S30UNCkxDcIKsBg3YI
	2ru8qHMGlXL4OyC/UeSrwEqgdP07R/QXn2we2iAX68Dug1i8xoyxwmgUYDLNr/cL+x5zDumOTxk
	AHNMgdWgrfSwqP0ej8f7QssEezWzzKN1xXX8NnyyEccphFo/6utcSOAshteVrm2SrvrbK3VFyyv
	t4WHT+Z/5u4Ben+ORd6AxPjIykGYeujtTOfGV7y7KJ7kIYLyQ6ZEfS+oN4rjKw7BPBwTnhp0gBC
	jX0Mv/1E9QFGhcWTjXHL+VEmz7ExoedGxWj9Z9vvbdHww==
X-Received: by 2002:a05:600d:6454:10b0:490:e243:4806 with SMTP id 5b1f17b1804b1-49266866378mr141283065e9.9.1782599462338;
        Sat, 27 Jun 2026 15:31:02 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c291489sm134368885e9.2.2026.06.27.15.31.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Jun 2026 15:31:01 -0700 (PDT)
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
Cc: horms@kernel.org,
	borisp@nvidia.com,
	raeds@nvidia.com,
	ehakim@nvidia.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH net v4] net/mlx5e: macsec: fix use-after-free of metadata_dst on RX SC delete
Date: Sun, 28 Jun 2026 00:30:59 +0200
Message-ID: <20260627223059.29917-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-22538-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:sd@queasysnail.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:borisp@nvidia.com,m:raeds@nvidia.com,m:ehakim@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:doruk@0sec.ai,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[doruk@0sec.ai,linux-rdma@vger.kernel.org];
	DMARC_NA(0.00)[0sec.ai];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[0sec.ai:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06B536D2C15

When an offloaded MACsec RX SC is deleted, macsec_del_rxsc_ctx() freed
the per-SC metadata_dst with metadata_dst_free(), which kfree()s the
object unconditionally and ignores the dst reference count. The RX
datapath in mlx5e_macsec_offload_handle_rx_skb() looks up the SC under
rcu_read_lock() via xa_load(), takes a reference with dst_hold() and
attaches the dst to the skb with skb_dst_set(). A reader that already
obtained the rx_sc pointer can race with the delete path and operate on
freed memory.

Fix the owner side by dropping the reference with dst_release() instead
of freeing unconditionally, and convert the RX datapath to
dst_hold_safe() so a reader racing the SC delete cannot attach a dst
whose last reference was just dropped; only attach it when a reference
was actually taken.

mlx5e_macsec_add_rxsc() also published sc_xarray_element via xa_alloc()
before rx_sc->md_dst was allocated and initialised, so a datapath reader
that looked the SC up by fs_id could observe rx_sc with md_dst still
NULL or, on weakly-ordered architectures, a non-NULL md_dst pointer
whose contents were not yet visible. NULL-check the xa_load() result and
md_dst on the datapath, and reorder add_rxsc() so the xa_alloc() publish
happens only after md_dst is fully initialised; the xarray RCU publish
then pairs with the rcu_read_lock()/xa_load() in the datapath.

Note: macsec_del_rxsc_ctx() also kfree()s rx_sc->sc_xarray_element
without an RCU grace period while the same datapath reads it under
rcu_read_lock(); that is a separate pre-existing issue left to a
follow-up patch.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: b7c9400cbc48 ("net/mlx5e: Implement MACsec Rx data path using MACsec skb_metadata_dst")
Cc: stable@vger.kernel.org
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
v4:
 - Reorder mlx5e_macsec_add_rxsc() so xa_alloc() publishes the SC only
   after rx_sc->md_dst is allocated and initialised; a datapath reader
   could otherwise observe a non-NULL md_dst with uninitialised contents
   (raised by the automated review forwarded by Simon Horman). Error
   paths adjusted (no xa_erase before the publish).
v3: NULL-check the xa_load() result and rx_sc->md_dst on the datapath.
v2: convert the datapath dst_hold() to dst_hold_safe().
v1: https://lore.kernel.org/netdev/20260615140534.52691-1-doruk@0sec.ai/
 .../mellanox/mlx5/core/en_accel/macsec.c      | 47 +++++++++++--------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 71b3a059c..daff53ba7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -714,34 +714,43 @@ static int mlx5e_macsec_add_rxsc(struct macsec_context *ctx)
 	}
 
 	sc_xarray_element->rx_sc = rx_sc;
-	err = xa_alloc(&macsec->sc_xarray, &sc_xarray_element->fs_id, sc_xarray_element,
-		       XA_LIMIT(1, MLX5_MACEC_RX_FS_ID_MAX), GFP_KERNEL);
-	if (err) {
-		if (err == -EBUSY)
-			netdev_err(ctx->netdev,
-				   "MACsec offload: unable to create entry for RX SC (%d Rx SCs already allocated)\n",
-				   MLX5_MACEC_RX_FS_ID_MAX);
-		goto destroy_sc_xarray_elemenet;
-	}
 
 	rx_sc->md_dst = metadata_dst_alloc(0, METADATA_MACSEC, GFP_KERNEL);
 	if (!rx_sc->md_dst) {
 		err = -ENOMEM;
-		goto erase_xa_alloc;
+		goto destroy_sc_xarray_elemenet;
 	}
 
 	rx_sc->sci = ctx_rx_sc->sci;
 	rx_sc->active = ctx_rx_sc->active;
-	list_add_rcu(&rx_sc->rx_sc_list_element, rx_sc_list);
-
 	rx_sc->sc_xarray_element = sc_xarray_element;
 	rx_sc->md_dst->u.macsec_info.sci = rx_sc->sci;
+
+	/*
+	 * Publish the fully-initialised SC last: xa_alloc() makes
+	 * sc_xarray_element->rx_sc (and rx_sc->md_dst) reachable from the RX
+	 * datapath via xa_load().  Doing it only after md_dst is allocated and
+	 * initialised pairs with the rcu_read_lock()/xa_load() in
+	 * mlx5e_macsec_offload_handle_rx_skb(), so a reader can never observe
+	 * a non-NULL md_dst with uninitialised contents.
+	 */
+	err = xa_alloc(&macsec->sc_xarray, &sc_xarray_element->fs_id, sc_xarray_element,
+		       XA_LIMIT(1, MLX5_MACEC_RX_FS_ID_MAX), GFP_KERNEL);
+	if (err) {
+		if (err == -EBUSY)
+			netdev_err(ctx->netdev,
+				   "MACsec offload: unable to create entry for RX SC (%d Rx SCs already allocated)\n",
+				   MLX5_MACEC_RX_FS_ID_MAX);
+		goto destroy_md_dst;
+	}
+
+	list_add_rcu(&rx_sc->rx_sc_list_element, rx_sc_list);
 	mutex_unlock(&macsec->lock);
 
 	return 0;
 
-erase_xa_alloc:
-	xa_erase(&macsec->sc_xarray, sc_xarray_element->fs_id);
+destroy_md_dst:
+	dst_release(&rx_sc->md_dst->dst);
 destroy_sc_xarray_elemenet:
 	kfree(sc_xarray_element);
 destroy_rx_sc:
@@ -829,7 +838,7 @@ static void macsec_del_rxsc_ctx(struct mlx5e_macsec *macsec, struct mlx5e_macsec
 	 */
 	list_del_rcu(&rx_sc->rx_sc_list_element);
 	xa_erase(&macsec->sc_xarray, rx_sc->sc_xarray_element->fs_id);
-	metadata_dst_free(rx_sc->md_dst);
+	dst_release(&rx_sc->md_dst->dst);
 	kfree(rx_sc->sc_xarray_element);
 	kfree_rcu_mightsleep(rx_sc);
 }
@@ -1695,10 +1704,10 @@ void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
 
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
2.43.0


