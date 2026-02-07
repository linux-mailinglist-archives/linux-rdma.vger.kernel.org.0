Return-Path: <linux-rdma+bounces-16658-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIdjFPePhmlwOwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16658-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 02:05:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD6E10467B
	for <lists+linux-rdma@lfdr.de>; Sat, 07 Feb 2026 02:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A69D4301BCFA
	for <lists+linux-rdma@lfdr.de>; Sat,  7 Feb 2026 01:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28ECD23A984;
	Sat,  7 Feb 2026 01:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEZJgR3I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8291B424F
	for <linux-rdma@vger.kernel.org>; Sat,  7 Feb 2026 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770426337; cv=none; b=AGHP2Sm2/6TtmcbS3JJ5qh452DioBNUniYER9I3T0l5d1KnTlCv2zxwCk9OvSakcV7AFgnBvXyxazQZP0ehgibzbxpNP1n8DnrtmQFuwTFBTD5QZD2UzkwQ28rmrLp9MiA17omhMK6hB2xh2u3+Qkm/0jJ7DisQbKT4uNvmFjao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770426337; c=relaxed/simple;
	bh=4c97E3l1fDx5rP31BJdStxGgz1jks7S0fHhu8URAe6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=szgpMPjL/vL919VPirv/QipazG1xnzkHn8uZ8ibCedoLfo6yJWpJ1InWOOOf6FcBvupXypj/AR4CVLJHhzZdW8bucoCDXU37aaMcctaZdzUFNlwEogRRn2q2bYDp2ONUphhfvhi9GOi2wIC8TyZmb8E+ROrz5dYTmcKH6uHmFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEZJgR3I; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4359108fd24so1747368f8f.2
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 17:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770426335; x=1771031135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h0Bl07+wUVkPYukWTkRgRpTRDTreTtiujhSkbJvfK8=;
        b=WEZJgR3IMgaZgVrA129f8Fv0CIkLDYJmZBTNGBNWTeRAbszKBLspOvb3OYujlkQG0k
         f76ZyG1DmGal4yTb6w3dLtZsBys8QlTObrqILVy25xK9cd8g8hBBy15CIvH0zp6qpYC2
         w+O7hKr/fuG2rGaJgpcSMLArXRKHkZzFIXjasA+wzMzP3cc1vmwocdJw12zLq90bEPZk
         VldvUJmyJdolXwECLeqw0b74G0J9fXjxlQv9m7PVl4i5KrYWzs0mYBGEaxenSoFGB09Y
         Xuovh8u0O1NbG3qotPZGWsRkX4zHb8mLLPptdXCodK9Y9PDItImSTQHOEMspW/U1CyIa
         rxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770426335; x=1771031135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5h0Bl07+wUVkPYukWTkRgRpTRDTreTtiujhSkbJvfK8=;
        b=BiHuyyu0J0ehBcbvaUtcrVDJVuZJ9qZI76M4HUaGPscrVgCZMthpUnJHDOVs+MP4ub
         LLqzrmWOb8NyeT8AKuiy7KhbmPMudky2vl3lL6IAwmJjuGRJ37kOdVYJo42lo/SIynD5
         t+1YgJG/ZvxmeV5ZhUgg1S2KG3A5HSOuV4KdrvEOihLmAdkw5snu/ce++DBrmoZcc+vI
         5N2zxj7o1PEQ5c+bfOcvywoINWaoBfQFLfiXxB/eh/BzYEMWRTmDyneulZhtJuDM+Pzd
         Yruy/O1TE+VW/xMgdO+vqkPTSdPyRf0PoGkT3n5aPANR0XQXlbDKuLqR7NRBlNcHTPEy
         kD3g==
X-Forwarded-Encrypted: i=1; AJvYcCWNITU60TlZXd9zV7RfbZF+ghIXK4+OOMBKffkjhdxYz6J3XwnF6HZRQbs9USGSlQum1xBePCmhzB2f@vger.kernel.org
X-Gm-Message-State: AOJu0YwcABWMMrFa7eOeSCkH7Pm77CU1FMIJ3dhcEoyh52XFDB737Nv4
	2U4+fAt3ppSriPEDlReRUGfhqtFle3DhPIL36qsTIKPl67fT5JGHQh3u
X-Gm-Gg: AZuq6aLvjK2iE7j2Ts6bSkMv0Azl/WCyidQsjWmDdbcXkTvehCXsOjPkBaNqjMv7+FB
	ilLugZXMO8eqvc45Txho4VbR9JUsQyR5W3B4Rn5rj2qO3dy/VpIxPhKPh4TOCteWt0UrWXzjB9Z
	pLItA03dTokmkitv3l+82sOhoLQmEFCtKFKP3RIPec+aDGABcvvK1fs3IqHLT8zCgQ2a4ZxfMzG
	SLPrNMZ/BZYyXFmOP+LwI6GeJ2LNzqk9dCAxOu9kAcHwzALPY/RHP2gv33axoUns0FRBgszZ4/A
	q+CW+NBDTvJBrx76IGknrUpWWiMYGAW0uUiGdA7qj9NsB0UBmQMbDbmZIrCQyvKKQDAkbwR51vX
	Orljg3xUCfuq5Ir3enOdavgEudKCnhE/IKT4IRXjle2RnRJBqEoBdnUeVwCon//LEdYIE8xJeSw
	8CpsqAyKClGQwfzBjM6w==
X-Received: by 2002:a05:6000:288b:b0:435:975d:33b0 with SMTP id ffacd0b85a97d-4362967e068mr6267345f8f.35.1770426335035;
        Fri, 06 Feb 2026 17:05:35 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:8::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974b230sm10555280f8f.36.2026.02.06.17.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 17:05:32 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [PATCH net-next V2 1/5] net: ethtool: Track pause storm events
Date: Fri,  6 Feb 2026 17:05:21 -0800
Message-ID: <20260207010525.3808842-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
References: <20260207010525.3808842-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16658-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCD6E10467B
X-Rspamd-Action: no action

With TX pause enabled, if a device is unable to pass packets up to the
stack (e.g., CPU is hanged), the device can cause pause storm. Given
that devices can have native support to protect the neighbor from such
flooding, such events need some tracking. This support is to track TX
pause storm events for better observability.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 Documentation/netlink/specs/ethtool.yaml       | 13 +++++++++++++
 include/linux/ethtool.h                        |  2 ++
 include/uapi/linux/ethtool_netlink_generated.h |  1 +
 net/ethtool/pause.c                            |  4 +++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0a2d2343f79a..4707063af3b4 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -879,6 +879,19 @@ attribute-sets:
       -
         name: rx-frames
         type: u64
+      -
+        name: tx-pause-storm-events
+        type: u64
+        doc: >-
+            TX pause storm event count. Increments each time device
+            detects that its pause assertion condition has been true
+            for too long for normal operation. As a result, the device
+            has temporarily disabled its own Pause TX function to
+            protect the network from itself.
+            This counter should never increment under normal overload
+            conditions; it indicates catastrophic failure like an OS
+            crash. The rate of incrementing is implementation specific.
+
   -
     name: pause
     attr-cnt-name: __ethtool-a-pause-cnt
diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 798abec67a1b..83c375840835 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -512,12 +512,14 @@ struct ethtool_eth_ctrl_stats {
  *
  *	Equivalent to `30.3.4.3 aPAUSEMACCtrlFramesReceived`
  *	from the standard.
+ * @tx_pause_storm_events: TX pause storm event count (see ethtool.yaml).
  */
 struct ethtool_pause_stats {
 	enum ethtool_mac_stats_src src;
 	struct_group(stats,
 		u64 tx_pause_frames;
 		u64 rx_pause_frames;
+		u64 tx_pause_storm_events;
 	);
 };
 
diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
index 556a0c834df5..114b83017297 100644
--- a/include/uapi/linux/ethtool_netlink_generated.h
+++ b/include/uapi/linux/ethtool_netlink_generated.h
@@ -381,6 +381,7 @@ enum {
 	ETHTOOL_A_PAUSE_STAT_PAD,
 	ETHTOOL_A_PAUSE_STAT_TX_FRAMES,
 	ETHTOOL_A_PAUSE_STAT_RX_FRAMES,
+	ETHTOOL_A_PAUSE_STAT_TX_PAUSE_STORM_EVENTS,
 
 	__ETHTOOL_A_PAUSE_STAT_CNT,
 	ETHTOOL_A_PAUSE_STAT_MAX = (__ETHTOOL_A_PAUSE_STAT_CNT - 1)
diff --git a/net/ethtool/pause.c b/net/ethtool/pause.c
index 0f9af1e66548..5d28f642764c 100644
--- a/net/ethtool/pause.c
+++ b/net/ethtool/pause.c
@@ -130,7 +130,9 @@ static int pause_put_stats(struct sk_buff *skb,
 	if (ethtool_put_stat(skb, pause_stats->tx_pause_frames,
 			     ETHTOOL_A_PAUSE_STAT_TX_FRAMES, pad) ||
 	    ethtool_put_stat(skb, pause_stats->rx_pause_frames,
-			     ETHTOOL_A_PAUSE_STAT_RX_FRAMES, pad))
+			     ETHTOOL_A_PAUSE_STAT_RX_FRAMES, pad) ||
+	    ethtool_put_stat(skb, pause_stats->tx_pause_storm_events,
+			     ETHTOOL_A_PAUSE_STAT_TX_PAUSE_STORM_EVENTS, pad))
 		goto err_cancel;
 
 	nla_nest_end(skb, nest);
-- 
2.47.3


