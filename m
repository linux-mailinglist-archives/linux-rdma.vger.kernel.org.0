Return-Path: <linux-rdma+bounces-15934-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOF5MEi6c2kmyQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15934-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 19:13:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EEE796D3
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 19:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFD9A300A8F7
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jan 2026 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305FA27B4FA;
	Fri, 23 Jan 2026 18:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU2thMlz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD481B4224
	for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769191879; cv=none; b=aW6+0+1lU/WKSFjP6nesOuWVnJf3D3amtxrNgcNqsX2pPp+vOPOyxykxsuPC4/Py6AzJOx+X/CwZUd0A/6gmd28bbGlSOyPEMnc/nBBVsyYyDl5hxowh4awed3/VpLr51Sz99czhrDLT+VuvFPRmvA/Rw2dFryaFcrKu4s/hLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769191879; c=relaxed/simple;
	bh=rbyuRl0CtZEs5ZW7M89mRSqeuBOzP9MSDPqte6rZ5RA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nnpzEguq2xxYLiF/lyfDqX3rGzABglN/PgC6oIqhSLc5iAe1VeFKJVdNYW/uxydHqSfjZHoRLQp0GZRdOveocvakxQQjsd7AxM60qImPXiCLvqzyG2jCrvy63QmgWOwbsgLOC3MDT1L4w/Ndbnw17+CwDYnU4UgyaTb012CIJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU2thMlz; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-79414ab1497so23621877b3.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jan 2026 10:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769191877; x=1769796677; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UfqpNln2Xw2ohSKjImjbWhBfKeJgPKNjFydxNKV3vE=;
        b=dU2thMlzwZp8u5AnhoycLvsx5zBCWMfDQgQ578h68Y2HiuYVe34Aviu4x577BBjVgr
         lItbY4XBRuyeBke79fagdJgKK7OqV0ZsljCmtSd6AKT5iUWprHEJsqjL8YDvIU+x999T
         TKIj8VQdB1pGC6yvxg9CEDtwjBKIbclidP4r/ejDuQ5kuyqtzsHGtJk1Cao1PrP7OWQb
         nYiOFvnvqqZuDaHwgMnWi4+qdW3Uz9Uv9LFt0p5zuoDZORShpfB6HwbNZlZ+tld6/7dx
         ZJrLmx+3QTsqlQifEN9GWrOO5wFL5jEEK6cSkEFsz6a2MbCwYnC827Vs/81ctprgkRyN
         IxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769191877; x=1769796677;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UfqpNln2Xw2ohSKjImjbWhBfKeJgPKNjFydxNKV3vE=;
        b=H5BBPISNawo+QXuYjcFqpsNXyRSf3d6EiDi6dlx7enic6iikrkMbaUOc7v4O2RddWb
         i+tvizBBMRccZSz4nWsprQHjSsVNKHs1bL7FPt6RGRKUzRTQLY1MHwRmlBcZxbgDf1Rz
         x3G1wcvC1Rpr93jBnMlVv4qmWQ1p3dz6HmNYf6AVZphDoTixKOPcL0ubTCmnc1KadFew
         HTJ3225S2IcSeSUqLQOB7ohYFAzuCRB2B7CpeXyUcv8h0Az93msMiIV4xGNQyWLTLWNP
         uUHA7+jrl9ZmMqRuyWmrblYbyvNMxCIpHT4RtnYn6XRqJIexyU8E8CdcUf7vDVdNBOBD
         rs7A==
X-Forwarded-Encrypted: i=1; AJvYcCXlnpouS5M5zr4QCSoIOIK+QIL6sSPhi1lxAlrmLOcMQ5Ul9A5gvqffEpPnixSClbPeJWDrK+AXIOWX@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfFl77htVTno2xBBxwajTjqp3xv/glzykRNgLo12Y0vTNpbt5
	YoMRwZRdV5IVxtf7uLZ8havf1n+ylCM97/lt0GOufAhOe9K5ta24tAY+
X-Gm-Gg: AZuq6aI/iDo7Hkl5rV7gAz66VU7rvKqOm04xqby876/o+TFRY4xg8r+1ttkGykJoFdV
	x7RIpFAnOMf6rCyoJZIqGgqWkHt8O5msb06mFE8/cGKX0kOIikZo03BRF385//pHyZclvGByqIC
	HUQtXc0uGoznssQStQMPbbLJSZWBYvIXBjWqydImsdnuroVI21oygVkyp+ViH6At+fe1n/nJBeZ
	WG4YKps/byusgbr9mp9ighHNZU+UPZ7AsFzFqbjBCmSNT73p+uzUEThndASd22rTQdbzJMmvtcS
	nfnMAeOlinPo6L/zoiOBNsfPuIRWPd9L1jGssM9KjeLIczewPzYUVQPlE2F6R851FG4JbAfyisK
	1UByg83kySL2Xj7lU38L93z/TpO+PlNZRxOd1RAvL+MpPbzv74KTIIYDy3VXRHkUnXze/HHFijq
	64KQxhK5YH
X-Received: by 2002:a05:690c:22c8:b0:786:56f9:215c with SMTP id 00721157ae682-7943990fd2bmr35611157b3.29.1769191876635;
        Fri, 23 Jan 2026 10:11:16 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943af14186sm13862167b3.6.2026.01.23.10.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 10:11:15 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Fri, 23 Jan 2026 10:11:05 -0800
Subject: [PATCH] net/mlx5e: don't assume psp tx skbs are ipv6 csum handling
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-dzahka-fix-tx-csum-partial-v1-1-7b0107693883@gmail.com>
X-B4-Tracking: v=1; b=H4sIALi5c2kC/x3MQQqDMBBA0avIrDuQTFFjr1JcDMnUDLYqiYpUv
 HtDlw8+/4QsSSXDozohya5Z56nA3irwkadBUEMxkKHGWCIMX44j40sPXA/0efvgwmlVfmNXk7j
 gyd3bGspgSVKy//zZX9cPIl4BymwAAAA=
To: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
 Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15934-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8EEE796D3
X-Rspamd-Action: no action

mlx5e_psp_handle_tx_skb() assumes skbs are ipv6 when doing a partial
TCP checksum with tso. Make correctly mlx5e_psp_handle_tx_skb() handle
ipv4 packets.

Fixes: e5a1861a298e ("net/mlx5e: Implement PSP Tx data path")
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
This is a bug when an ipv4 tx skb passes through
mlx5e_psp_handle_tx_skb() and tso is requested. It was previously
undetected in my testing because my setup involves cx7's on both ends,
and mlx5e_handle_csum() marks PSP rx skb's with csum_unnecessary.

To reproduce the problem just turn off NETIF_F_RXCSUM and observe:
nstat -a | grep TcpInCsumErrors
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c   | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
index c17ea0fcd8ef..15a344ad471d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -178,7 +178,9 @@ bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct net *net = sock_net(skb->sk);
 	const struct ipv6hdr *ip6;
+	const struct iphdr *ip;
 	struct tcphdr *th;
+	int len;
 
 	if (!mlx5e_psp_set_state(priv, skb, psp_st))
 		return true;
@@ -190,11 +192,16 @@ bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
 		return false;
 	}
 	if (skb_is_gso(skb)) {
-		ip6 = ipv6_hdr(skb);
 		th = inner_tcp_hdr(skb);
-
-		th->check = ~tcp_v6_check(skb_shinfo(skb)->gso_size + inner_tcp_hdrlen(skb), &ip6->saddr,
-					  &ip6->daddr, 0);
+		len = skb_shinfo(skb)->gso_size + inner_tcp_hdrlen(skb);
+
+		if (skb->protocol == htons(ETH_P_IP)) {
+			ip = ip_hdr(skb);
+			th->check = ~tcp_v4_check(len, ip->saddr, ip->daddr, 0);
+		} else {
+			ip6 = ipv6_hdr(skb);
+			th->check = ~tcp_v6_check(len, &ip6->saddr, &ip6->daddr, 0);
+		}
 	}
 
 	return true;

---
base-commit: 4a3dba48188208e4f66822800e042686784d29d1
change-id: 20260122-dzahka-fix-tx-csum-partial-952e8dc28375

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


