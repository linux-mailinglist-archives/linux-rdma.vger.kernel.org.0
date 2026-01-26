Return-Path: <linux-rdma+bounces-16032-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID92DMXCd2nckgEAu9opvQ
	(envelope-from <linux-rdma+bounces-16032-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 20:38:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5978CAB8
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 20:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BBB830268A5
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 19:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0615F286890;
	Mon, 26 Jan 2026 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAMYRbsd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6209A26ED48
	for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769456308; cv=none; b=M6XCh1iZxAYKB8a0b46LjE840ZF2F1fnjFPqBPWsPqvI6WaiwZWP4vcQFYcTXnQkOIj/Gh42AJLsrwTzwey7RA3WN3jeDq0qIPN/H+YBvJ3HCT2UvojDk3lko64utPNXJQrjMp5OpANJDgijZad7GORCVfL/PINawAywR20Ij9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769456308; c=relaxed/simple;
	bh=KE5ceNF2zDqw8LnnABdcfLeNarTK90DNj06IOU74ZGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=puVGZoYEmfqrVIPlK+rC8HoFdE64tssO7id4j/FgT2epKYIiwMfQwIjS6TpKLFv45+bC8iT4Yd43aVRrRJcKREQDkVtlU2pbWKoyccRLete1vOcWxmQwSBA9vdk4bS+S8aOrgSBHJob0fcEyiuNBWNoh4XIKnXwBiM/VL4F8qkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAMYRbsd; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-6496804204cso1955047d50.3
        for <linux-rdma@vger.kernel.org>; Mon, 26 Jan 2026 11:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769456306; x=1770061106; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2+aNIXln8blsmbOccfH89nynTXB7Mbf5xzL4onU0SVg=;
        b=cAMYRbsd+L5bRr+zw3z+k9CFSWmTQE1wKX0/5tehT9Lfo3hRmFeC8TopY9W1gcd7Uf
         9GjmymYgiQit1MBfFTSKIw+0ZDZJNPMc7mLxsc03/XVPOlJcXYBROfROWRCVr5idrcJa
         c+mbYbOaWjJHitxS/pRW4mVEcX2ccInIesczksVu9I8Jhikvc+zWSicqr1I4PCximlgT
         7un5I8/TalngCmta3ptUZCikUSFSmEmxi6EndcrucS8grk6Cd6xN9MjntddEOxjG5qeJ
         CbR49wxl15xkKPs2O9Nrod9ofYNQQOM15fgsHg3cra4A7UxAGl6VVTAuZCbAhmkLLmlF
         UmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769456306; x=1770061106;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+aNIXln8blsmbOccfH89nynTXB7Mbf5xzL4onU0SVg=;
        b=ZYyi5bD6/E7oe9RxQONitnJWTwCoeP0ea3Xl99UWv12NwECj6e565kEdoRBUFVXDQb
         qkqkhmhXBvd88jL9YJjL//Y6GGJn/pZUB1jnHXYbBhGvEpkaja4AKhlRGcKZVLHzyuxK
         tiosEidczhKaVbF/a2lkrDW8MHUzGJV2R7Wh1OpwdzJC4iN1zEm1+FiqDt1nZeO/bZQ5
         m0KSCU5XYc/cr8vd4ERekB3JvE7fs3akYqxuuP++CjOt/fRFw01qu9bRQ9VPp8r5fkyY
         txX5D1tZ47o3AWVON7UTFoC1EYbO2+KyRMRxYEydj5nwKzlpX1Fe5aqUFfoPtcaUzm0G
         mpvA==
X-Forwarded-Encrypted: i=1; AJvYcCXL650wg8DS7HQ+8NufAUtL+5UTJ9BUDGjSUOGtJPaa1Hbj5Dq752PDFEBIWbqxZgjJchaBGjHPmFa3@vger.kernel.org
X-Gm-Message-State: AOJu0YzDEylIrtFSDoKTjZjtImVh3xeU4L6NAhIgKlZ5pdcIyUFNaC8j
	SHMCkSjP76Bg9QM4ixAAFUFTPtl7c4FG5zhBVSyOW4A9fr4N4iCRXLpu
X-Gm-Gg: AZuq6aIr6fBlrACxJ/K5rmOShz3uDiZzcA/g9OFmGBx1OqXPi3h/YhUXDVOtiAHdxO8
	4Q51KB8+47OsIW+3Caicsq+Tch03zikkFANqp5MpZU/adhTFhngluS5cNBJfabReryUk/43VEDT
	TvbzeuuUQm7c1cJmgu78pLVB7t+OD8Zcsgu0GhDqSZ/TK+Jg+AL5PqvUfZ69k0rL/AcAYNyDuVS
	1xZL6KIvs9CN+Hdt1N7/6Yn8GeJqiKh81JU5GR9swwxsRUtqWvRaz06ncIaLYDxS7zufQb0f1u9
	latzI7pwayFhmDWCcLnSnMA8+1bJESGqiuWgfuYAuiissMV6aB59OpEn/Cz/RrXhkND9Ssvkrd0
	ka2Dv/PaB1SCYMa7XwZd9zoSRkg6vp02S9mYZfT9GOx524BijkWQYVQeRLWRHyiHqxBLi1McQRT
	SbrzsqHUg=
X-Received: by 2002:a05:690e:120e:b0:649:39e1:6498 with SMTP id 956f58d0204a3-64970c9dedcmr4255047d50.60.1769456306319;
        Mon, 26 Jan 2026 11:38:26 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:1::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7943b2a2ed1sm51516537b3.30.2026.01.26.11.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:38:25 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Mon, 26 Jan 2026 11:38:17 -0800
Subject: [PATCH v2] net/mlx5e: don't assume psp tx skbs are ipv6 csum
 handling
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-dzahka-fix-tx-csum-partial-v2-1-0a905590ea5f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKjCd2kC/33NTQ6CMBCG4auQWTumnQYorriHYVFLhYn8pUWCE
 u5uJXHr8v0yeWaD4Dy7AJdkA+8WDjwOMeiUgG3N0DjkOjaQoExIIqzfpn0YvPOK84o2PHucjJ/
 ZdFik5HRtSas8hQhM3sWzA79WsVsO8+hfx69Fftcfq/6xi0SJ+U1IkWeF0lqVTW+4O9uxh2rf9
 w+HsDvtxAAAAA==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16032-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C5978CAB8
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
Changes in v2:
- move declarations down into branches where they are used.
- Link to v1: https://lore.kernel.org/r/20260123-dzahka-fix-tx-csum-partial-v1-1-7b0107693883@gmail.com
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
index c17ea0fcd8ef..ef7f5338540f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp_rxtx.c
@@ -177,8 +177,6 @@ bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct net *net = sock_net(skb->sk);
-	const struct ipv6hdr *ip6;
-	struct tcphdr *th;
 
 	if (!mlx5e_psp_set_state(priv, skb, psp_st))
 		return true;
@@ -190,11 +188,18 @@ bool mlx5e_psp_handle_tx_skb(struct net_device *netdev,
 		return false;
 	}
 	if (skb_is_gso(skb)) {
-		ip6 = ipv6_hdr(skb);
-		th = inner_tcp_hdr(skb);
+		int len = skb_shinfo(skb)->gso_size + inner_tcp_hdrlen(skb);
+		struct tcphdr *th = inner_tcp_hdr(skb);
 
-		th->check = ~tcp_v6_check(skb_shinfo(skb)->gso_size + inner_tcp_hdrlen(skb), &ip6->saddr,
-					  &ip6->daddr, 0);
+		if (skb->protocol == htons(ETH_P_IP)) {
+			const struct iphdr *ip = ip_hdr(skb);
+
+			th->check = ~tcp_v4_check(len, ip->saddr, ip->daddr, 0);
+		} else {
+			const struct ipv6hdr *ip6 = ipv6_hdr(skb);
+
+			th->check = ~tcp_v6_check(len, &ip6->saddr, &ip6->daddr, 0);
+		}
 	}
 
 	return true;

---
base-commit: 709bbb015538dfd5c97308b77c950d41a4d95cd3
change-id: 20260122-dzahka-fix-tx-csum-partial-952e8dc28375

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


