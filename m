Return-Path: <linux-rdma+bounces-17404-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP7LExgXpmlWKQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17404-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:02:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E380A1E6355
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0017C302525F
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 23:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522831D739;
	Mon,  2 Mar 2026 23:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSZPDkoL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D3F322B83
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 23:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492520; cv=none; b=WMAwD/VVXAZxyERDu3veUkol4+dPGMffSlrW98rjNzYkeFPBWbiwswoZZhep/W5DksEV8JIJfAdyn8dBAH4drF+PkhQt5ugej1B9aeDwp9YRNZ/+LAxYkx/AKwe214LIo4mklP+aCIjd+jyMFcRUSg002H2uax3LtTQztKiTkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492520; c=relaxed/simple;
	bh=D9A1mjx3Bo2dp6Mntk51MlHtoIWxAsQL+/MQZTZBMrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCRxXGj/SQ0KIz5JPOvf5YJjG4AaD0eNQ8NrpOb8+4o1/gTEv+QHg7qOP4S0IgxTkVhsZS2ferd34C/30Ku9EeHOkXqSNAYtc8MPW0cCYpJB70W+MWVxiRYk7sjXxsq2aE26AU9zPZ9XAx3vwJImU5QsX0ueROsdQb4ZKuq7BPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSZPDkoL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso43030885e9.1
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 15:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772492517; x=1773097317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CU2WMDwR3VgGVbtB5/gNO1+KxRbSdrRzqbkeoh8a3to=;
        b=KSZPDkoLm/mALs/aq2swRZoX3KY1HPLt3YBz3LuJIdZjk6lLCaKxInR4sM3HA3/m9Z
         dB32IaH2I2tFykaAPHOhW/NuJAL0sHbOqxKpP1Pd9AJz4tXHhvdyOJGudeJlN4F1hHmm
         IOpGKrISvXdL7irouAOkNaa4TebXP+OxI61fXA2El0uaJAQ4lrcoJhZMEx92oPRSWErW
         0BFwHGYsbkr4P0K6B5sUObguOhORN73UV7JJ0oaDjSQgCBxnVziLyAhF2n19iCFW6BIU
         8d8G34Aedbwhv2l0GxaLBwjT01OLt6GXM3sN66es7QNzhZ4E3AI76WH5W6EeYx+uDZGQ
         rEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772492517; x=1773097317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CU2WMDwR3VgGVbtB5/gNO1+KxRbSdrRzqbkeoh8a3to=;
        b=nQGM+8yVM44M1qbAbeYjM6bk0wn0cwZkhjwwpjKq0EV8yKUolp1wcL2FXa0urxEd1+
         WgAwhmztLD3EFb3HXPiRF2lCEvBZiNBamV30dg4cJ+DUtBubAbqPuY0t075N77VKlIZl
         9o94oeKKpsKr0L3KYeTLf9Bt0O2Zr/u0SMv9C7l+ui0C+6B44g+9Ye5W2F/3M4scmvwV
         lfouXLXcnBGXlzeDWQk89GCfdI39/OvHisxv8JzrcXP6NegzrGJ4ZV3pl6reR1j3wkyD
         Z5wE4/GSDxbmuisoAGU11Ut54yujN3kQPqLfHfqiNumg9wht6ZEJ+w2LIx67SY0xYsBP
         FA1A==
X-Forwarded-Encrypted: i=1; AJvYcCUsHimzSTUQaXgqGaJhIOZYab0V/2fhC+R+7mAJlmSyAP0h+Wpr62ntYhvJk87CD/bY+1NQz3dQJjvE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwlu36d3labx4gloYYHd6aNJhU1CNTeF6hOzYa/7fljwquKIds
	gMCUxq0iSxOmDvvdH5soO0d0uNX0QNSpXMsuvfagmPqVptpRsXqBNRBe
X-Gm-Gg: ATEYQzyt7aN3mSJtMINIPN+n/T0XwB3w3WDK+ldIz1O6NmtlyYvhXx1QdNlABqsuxMl
	yT2s268alAdWi2tz/etBlLDyyO3RKY7UptHNOqXBbQ1pb4giVlcXd/w+dh+lvyplsICEzbMyOoT
	+1XrTudg7S/9i2u3eBGUsLaX2pScfQAF2J0OFQ7Ha/Yt9wih+kh8+KGMp6M1l1OrZ9G9dfhd7Dy
	vLGONFhwR7bsrX1joPc1qmak054OmkvC4M+2VJJyTtpFzPsVmvH6vqWiW7zasto00yfVGp3uilX
	B9ZnWW37XlOKMR0Jp96jxdyCM42FOEKeOb1PQvp8DGqPsEiPG5iVqHr5kx21tU9AsIkDhsL1Ybt
	N1u5GkWoaduzcwCrdE+KG6r+z0AZbm+332C/k1FZS54t64Y6PX+dWHP+7vHpnBkN+gMF1HwjU5l
	wO4rbuS1X65RzDOppVmBow
X-Received: by 2002:a05:600c:4fc8:b0:47b:e2a9:2bd7 with SMTP id 5b1f17b1804b1-483c9beaca0mr292444625e9.19.1772492516969;
        Mon, 02 Mar 2026 15:01:56 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:57::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ae3f31dbsm17149216f8f.1.2026.03.02.15.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 15:01:55 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
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
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux@armlinux.org.uk,
	mbloch@nvidia.com,
	mike.marciniszyn@gmail.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [net-next V4 1/5] net: ethtool: Track pause storm events
Date: Mon,  2 Mar 2026 15:01:45 -0800
Message-ID: <20260302230149.1580195-2-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
References: <20260302230149.1580195-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E380A1E6355
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17404-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

With TX pause enabled, if a device is unable to pass packets up to the
stack (e.g., CPU is hanged), the device can cause pause storm. Given
that devices can have native support to protect the neighbor from such
flooding, such events need some tracking. This support is to track TX
pause storm events for better observability.

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
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


