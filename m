Return-Path: <linux-rdma+bounces-9397-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C08AA87A58
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1C83B0A32
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127672676CF;
	Mon, 14 Apr 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JqYUFeJA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+U5jL9J6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567525DCFB;
	Mon, 14 Apr 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619181; cv=none; b=dsldTaPqG5agNd0gJxtpRkFrXaGsxmJr4aY3YiJZ/6mMHb2mraThgRS9o65s7VfgyecSLhH8WKNwSmtTUWqNgQkd7GURbi1dm4TCshZimPACeokTzDCOMzkq1Jebg3KSjhOty9bzpYwm4hIiomHMbLmU/tg2no/KzW02IO4ARwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619181; c=relaxed/simple;
	bh=/TFJeNWHlIev8JdIPEMQCqz5lniv40TS/OEo5OuIoAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CVmNzi3Lmfciuuufut6+jzXhzl4uBDR6FFb3ZUIoV/Y0UKWZwrBKjSMk+xbFWEsGQTrQrhlFZ40Kpp35S302d7dC/DbEGGtEOF9FvuONowH7HHk6FvJd4v49zcvWwLmer82S4YZzALg+73S5wEdtO7NIzkJ1tEDNA9XAqNdyeSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JqYUFeJA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+U5jL9J6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxGJCgnthnolGvygq4Smo2+2DVKb7rbKZI1gRHd2xwg=;
	b=JqYUFeJAl3PyH5dSVnQ/H8z3D1uJwePe0ize1trotlTospmX2eXiCx4Ilosj+UxoLLf0Zh
	cRVHe3TgfM9pePuU1Zlnj0WoPoLaidifRxOA1rQ3ckC2DO416rEAGQnCuljG4THWBhqZZf
	OfBqig6cCOWF22j3c2YFFQ6oRoWoEwdt3G7lOcREUxEh4h7aVyo33O7qGd7fbpz+75tV/k
	apr8rml6F4ItKUkca6CQ75yx+fibmD1G509S/EpLLnLlV01ct7vh9cIFJ9tF31/I5O45Yh
	LlO/DfwmrlUvYEfsQtUp49duhy/oZYZvfR2eCMvbpS1Xoq8J7moszmoI0ze1hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxGJCgnthnolGvygq4Smo2+2DVKb7rbKZI1gRHd2xwg=;
	b=+U5jL9J6WYWJWilPHgU6o/y11xklVr/l/srP1szNwt/tNwT2zcaulMks1dBzSNRdU3yRym
	4lwHVpUcudep7gAQ==
Date: Mon, 14 Apr 2025 10:26:07 +0200
Subject: [PATCH net-next 6/7] ice: Don't use %pK through printk or
 tracepoints
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-restricted-pointers-net-v1-6-12af0ce46cdd@linutronix.de>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
To: Jeff Johnson <jjohnson@kernel.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619172; l=3464;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/TFJeNWHlIev8JdIPEMQCqz5lniv40TS/OEo5OuIoAw=;
 b=bM9iAT+Re45X9Z0x/2a50zVokaO2aeQLV82PsVDGvysJhNvlOX+8yBfMzpvMHELEP51+5nNk1
 c2GR++ydH0CAroKWjqJejeA91merGkf3w3hxl67SAQbeirmq0en0f8M
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 drivers/net/ethernet/intel/ice/ice_main.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_trace.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d390157b59fe1873ddab78323cdc0bbaea6ad0c5..d27e8816a48fef5014148cae27e52c1801eaaada 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9118,7 +9118,7 @@ static int ice_create_q_channels(struct ice_vsi *vsi)
 		list_add_tail(&ch->list, &vsi->ch_list);
 		vsi->tc_map_vsi[i] = ch->ch_vsi;
 		dev_dbg(ice_pf_to_dev(pf),
-			"successfully created channel: VSI %pK\n", ch->ch_vsi);
+			"successfully created channel: VSI %p\n", ch->ch_vsi);
 	}
 	return 0;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 07aab6e130cd553fa1fcaa2feac9d14f0433239a..4f35ef8d6b299b4acd6c85992c2c93b164a88372 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -130,7 +130,7 @@ DECLARE_EVENT_CLASS(ice_tx_template,
 				   __entry->buf = buf;
 				   __assign_str(devname);),
 
-		    TP_printk("netdev: %s ring: %pK desc: %pK buf %pK", __get_str(devname),
+		    TP_printk("netdev: %s ring: %p desc: %p buf %p", __get_str(devname),
 			      __entry->ring, __entry->desc, __entry->buf)
 );
 
@@ -158,7 +158,7 @@ DECLARE_EVENT_CLASS(ice_rx_template,
 				   __entry->desc = desc;
 				   __assign_str(devname);),
 
-		    TP_printk("netdev: %s ring: %pK desc: %pK", __get_str(devname),
+		    TP_printk("netdev: %s ring: %p desc: %p", __get_str(devname),
 			      __entry->ring, __entry->desc)
 );
 DEFINE_EVENT(ice_rx_template, ice_clean_rx_irq,
@@ -182,7 +182,7 @@ DECLARE_EVENT_CLASS(ice_rx_indicate_template,
 				   __entry->skb = skb;
 				   __assign_str(devname);),
 
-		    TP_printk("netdev: %s ring: %pK desc: %pK skb %pK", __get_str(devname),
+		    TP_printk("netdev: %s ring: %p desc: %p skb %p", __get_str(devname),
 			      __entry->ring, __entry->desc, __entry->skb)
 );
 
@@ -205,7 +205,7 @@ DECLARE_EVENT_CLASS(ice_xmit_template,
 				   __entry->skb = skb;
 				   __assign_str(devname);),
 
-		    TP_printk("netdev: %s skb: %pK ring: %pK", __get_str(devname),
+		    TP_printk("netdev: %s skb: %p ring: %p", __get_str(devname),
 			      __entry->skb, __entry->ring)
 );
 
@@ -228,7 +228,7 @@ DECLARE_EVENT_CLASS(ice_tx_tstamp_template,
 		    TP_fast_assign(__entry->skb = skb;
 				   __entry->idx = idx;),
 
-		    TP_printk("skb %pK idx %d",
+		    TP_printk("skb %p idx %d",
 			      __entry->skb, __entry->idx)
 );
 #define DEFINE_TX_TSTAMP_OP_EVENT(name) \

-- 
2.49.0


