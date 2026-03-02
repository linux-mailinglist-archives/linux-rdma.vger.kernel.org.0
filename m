Return-Path: <linux-rdma+bounces-17407-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJPBN1EXpmkCKQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17407-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:03:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF01E63B6
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 00:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 467913039DDB
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610D33B6D9;
	Mon,  2 Mar 2026 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLNIpElk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3283A320A14
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 23:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772492528; cv=none; b=ldhcz3BVCMG2hyYcbJsfEueM8L5gaoSVm+cMvJoG2RJXXIa1CF++ypalMu8YCX76JYoqdOzfZ8p16NkR7KPBFoGML0RSIXEbMSSYCk4jtjxI1YxJzaYLmdmt6bHbfQfRECLIpKYhYbxnkIhhNtKvcMtkfme/qTG7Y7YeZdhTgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772492528; c=relaxed/simple;
	bh=1zAr0Zf85PBf7/Rh8qavxPEJLsNQewWny61GtNvPRxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ac0jCmYrF0JzAgQqFMKHITIBnXlg2mPQC+/FeKAVUB7KOhG0xbaCnoilvJJaZdQJRIqcNFIrZlAwyx80xGbSycUgdK9y3HFrIepQoJ5+qjMo0lumrjb7WJoqhF6Z4sW3AkI9kHbBMSfMePyQCW2IKa0Ctup1RXUsZbIN8vb42/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLNIpElk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so30423395e9.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Mar 2026 15:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772492525; x=1773097325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38elZ9Mqi1kIyTUdjlGj0GQti9oP3Rth6xiqlYhvdME=;
        b=hLNIpElk1AV5fAq9G2Q7vc9Rk1jB7Y/mH/ndfCov/FjPFj6h0HOCkXS8VtvijqVAXo
         AS55X4Tvmfc9hxpNmADnCbFZh3bMXa3ZAHEkJBfn0zwh1XboBF+YYrqquVcmd9JKzT1C
         fFWmVxjcqZmRoZDP5wEQMWDJFumO+IsfYJOh8FVlwUeq2ZOGlq52F/IIy1cp/gQRqgRZ
         dv15DmBM7cFzipunSg8iIgLXx2XfUqGtZXQuU753Hh4Slg6RqBHqEcpIRmG+zsqTgZmN
         ET9OFChmzmyD6LWZN7un9UXxzP9ydXLSofiTpfxdb7mxH730a8dOlxlh/95HNmwbOEuR
         6Rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772492525; x=1773097325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=38elZ9Mqi1kIyTUdjlGj0GQti9oP3Rth6xiqlYhvdME=;
        b=XVwWn5H/i7TemXQO8ZqKVa1UoaSomo7SUMC4KpJp849py2+8OdNZ4xrsUQJJRGcNAb
         CtAl6cFyTEqtqm4fW/CVQ5hQXB+PWDMT5anw3woS7U7A0O7MGbzEC0OukU6guPUc332+
         LTn15ja0HyeP2ftAdMOcTDM1GYyOLuCPY2g0e9VEaA8o8PRUILCsxZgffnxOc7+NzPKp
         rtWbfDAyKBvACGpMdgaScThU5tGSNmqY3BUh7OmyIq9ivBtwJpVM/AmS0MkrzhTbMP5X
         yiSEzjtgJf1EhqrvUMHyanUpTyZRKJhdvjrvZmGuB6+dNlPV6ky4N16TTc+1snPqRYV/
         t/aA==
X-Forwarded-Encrypted: i=1; AJvYcCUjmwFNBXmZnHWMyUxNct0oHmFHZwiky26nbIV1wD0XXGIC0BGBawbena1keqiue7bVD/mWRh750QHV@vger.kernel.org
X-Gm-Message-State: AOJu0YyZle/keK8BY0aSjGAkW8jdPiIeyIMAAw9RVfSgLe9PrVzPfSvm
	+c8Rd0Ndnx7XsjuUF8bBMFmKfBUTdi3R6M9C7GuIlEqEtC9tu4oRKtvQ
X-Gm-Gg: ATEYQzw4JiIGJwTxQ12cUhAQ35fmEjpX5ugz3TGXD92G2U/+/n7ITSOhVqJdGF//IX6
	qBx13vVciKyIlue3Lx67cDkOKCS0WGalAu247n2ILMn5wk9GBDzPq6GrltCVlrnZpndcCLDeXBD
	UmgFdLNv4iCu1i19sKlrck9IboCIgvT8M+6uHJ4lOLveprBn6Ncloqi/Ah7Wxv3hE3RFTxc3uHc
	TL9t6/ETF3x67gKfL1Td5AKL/wz44LGjWjW3JW1IExhOP1siho00fWq9quigWp7o1evhEt8GBVo
	iCK3R3y31OSLJVDU5pDKC6Unms6Th3R4Le58HmVvq9E2rNslEGTHELJ4pVVndrZzEwOYs+tbnyi
	a4JV/UIMik9P0/keZNVl3Cu+mib/vTV3TY2zWlPydD/2ELOrlGfnnqT417hVc5BztnDRMk0ZEjk
	PlM55o5QhmO7XysfuuEi2N
X-Received: by 2002:a05:600c:6217:b0:476:d494:41d2 with SMTP id 5b1f17b1804b1-483c9bc5c06mr239092445e9.29.1772492525302;
        Mon, 02 Mar 2026 15:02:05 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:58::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7031f3sm390474325e9.6.2026.03.02.15.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 15:02:04 -0800 (PST)
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
Subject: [net-next V4 4/5] eth: fbnic: Fetch TX pause storm stats
Date: Mon,  2 Mar 2026 15:01:48 -0800
Message-ID: <20260302230149.1580195-5-mohsin.bashr@gmail.com>
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
X-Rspamd-Queue-Id: BDBF01E63B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17407-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

With pause storm protection in place, track the occurrence of pause
storm events. Since there is a one-to-one mapping between pause storm
interrupts and events, use the interrupt count to track this metric.

./ethtool -I -a eth0
Pause parameters for eth0:
Autonegotiate:	off
RX:		off
TX:		on
Statistics:
  tx_pause_frames: 759657
  rx_pause_frames: 0
  tx_pause_storm_events: 219

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h      |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c  |  3 +++
 drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c      | 15 +++++++++++++++
 4 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index e68c56237b61..72eb22a52572 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -627,6 +627,7 @@ enum {
 	FBNIC_RXB_ENQUEUE_INDICES	= 4
 };
 
+#define FBNIC_RXB_INTR_PS_COUNT(n)	(0x080e9 + (n))	/* 0x203a4 + 4*n */
 #define FBNIC_RXB_DRBO_FRM_CNT_SRC(n)	(0x080f9 + (n))	/* 0x203e4 + 4*n */
 #define FBNIC_RXB_DRBO_BYTE_CNT_SRC_L(n) \
 					(0x080fd + (n))	/* 0x203f4 + 4*n */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index ade9e667640f..70c995b8d1bd 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1754,6 +1754,7 @@ fbnic_get_pause_stats(struct net_device *netdev,
 	struct fbnic_net *fbn = netdev_priv(netdev);
 	struct fbnic_mac_stats *mac_stats;
 	struct fbnic_dev *fbd = fbn->fbd;
+	u64 tx_ps_events;
 
 	mac_stats = &fbd->hw_stats.mac;
 
@@ -1761,6 +1762,8 @@ fbnic_get_pause_stats(struct net_device *netdev,
 
 	pause_stats->tx_pause_frames = mac_stats->pause.tx_pause_frames.value;
 	pause_stats->rx_pause_frames = mac_stats->pause.rx_pause_frames.value;
+	tx_ps_events = mac_stats->pause.tx_pause_storm_events.value;
+	pause_stats->tx_pause_storm_events = tx_ps_events;
 }
 
 static void
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
index aa3f429a9aed..caea4be46762 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hw_stats.h
@@ -54,6 +54,7 @@ struct fbnic_rmon_stats {
 struct fbnic_pause_stats {
 	struct fbnic_stat_counter tx_pause_frames;
 	struct fbnic_stat_counter rx_pause_frames;
+	struct fbnic_stat_counter tx_pause_storm_events;
 };
 
 struct fbnic_eth_mac_stats {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 805107ba3b10..53b7a938b4c2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -418,6 +418,18 @@ static void __fbnic_mac_stat_rd64(struct fbnic_dev *fbd, bool reset, u32 reg,
 	stat->reported = true;
 }
 
+static void fbnic_mac_stat_rd32(struct fbnic_dev *fbd, bool reset, u32 reg,
+				struct fbnic_stat_counter *stat)
+{
+	u32 new_reg_value;
+
+	new_reg_value = rd32(fbd, reg);
+	if (!reset)
+		stat->value += new_reg_value - stat->u.old_reg_value_32;
+	stat->u.old_reg_value_32 = new_reg_value;
+	stat->reported = true;
+}
+
 #define fbnic_mac_stat_rd64(fbd, reset, __stat, __CSR) \
 	__fbnic_mac_stat_rd64(fbd, reset, FBNIC_##__CSR##_L, &(__stat))
 
@@ -812,6 +824,9 @@ fbnic_mac_get_pause_stats(struct fbnic_dev *fbd, bool reset,
 			    MAC_STAT_TX_XOFF_STB);
 	fbnic_mac_stat_rd64(fbd, reset, pause_stats->rx_pause_frames,
 			    MAC_STAT_RX_XOFF_STB);
+	fbnic_mac_stat_rd32(fbd, reset,
+			    FBNIC_RXB_INTR_PS_COUNT(FBNIC_RXB_INTF_NET),
+			    &pause_stats->tx_pause_storm_events);
 }
 
 static void
-- 
2.47.3


