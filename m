Return-Path: <linux-rdma+bounces-12302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47248B0A508
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F1E17DC01
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jul 2025 13:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B08E2DC35F;
	Fri, 18 Jul 2025 13:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5ZlKfcb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mrs9BQfY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FF472633;
	Fri, 18 Jul 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845032; cv=none; b=GLdf7KTGvvVdH/mPES9Rc3KRQFX33bnZ7/TSm+PZFbTbQoO2dhwmKuy0sfRtg3nUYVXbpMjDHs614OGro7Rq9mK4IFD6gAd/HxUuL9ZuhLeqPTN1JOswANrER+WjF8DohB0MVXzuLIURyNMnsVEVFf/qluQphZUcM4FXOcxA9Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845032; c=relaxed/simple;
	bh=J4r5ps9WvNju5FTso8sqRG8ARuQDhy2vAqkZIvQH0II=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVgrJxFZiTA3WpDB5+pMtE72BJEof/RalXyMgIcT8YcTcwNRfia2rTiTSkCSVIY/I8Vjhe0/4ipppagvx5gAlBSIeewshnffQV6KSWcR8LsT9gBkv4wGSGwIM5F//idf+STjif+LpvE8qwsus6jclwN8QssJEwSWPGDfjinQCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5ZlKfcb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mrs9BQfY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752845028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAwhNldOM1bvK5hnh10NqLPXigCuykAfwJ7ocfh53GA=;
	b=y5ZlKfcbysZ0JkZuKyGUA35K6MDj0Sa/qm6gwWPCkGVBOdAj0jPhD6igbw4uX+Qg5fp6+Z
	E1JidEuTPzw/xfMU78CLNfmZVobTgtGgbcjnbEyBZ1kKuW3S4x1Wcl8l1+TQZUjZCo3fc8
	EOBhCE3xPoUOhbSnGvSBBU3qXPf0eIiNe1ChRxHoKw15V4GQTw4maSEvQRBAQRCLfVQHDd
	EIimQZnMSi4mswwBYEGg7DlPTJTD9H0s3F/0kSEFzPqO07UNWrR7j6tnqWEWiIx1hAhvXH
	WYs1dDC2ibaVh/QIm9wsMnqHRkimJhqCmQH0vaDhNcnIt/K2Zs5PVy+MdsEZKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752845028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IAwhNldOM1bvK5hnh10NqLPXigCuykAfwJ7ocfh53GA=;
	b=mrs9BQfY10hLqFVIa/TLU0WP76TY6UxJlI02b3raDUfcT1JecaUtSLJxvFhgl+AprN3vx7
	rjmx8BkwJCM59VCQ==
Date: Fri, 18 Jul 2025 15:23:42 +0200
Subject: [PATCH net-next v4 1/2] ice: Don't use %pK through printk or
 tracepoints
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250718-restricted-pointers-net-v4-1-4baa64e40658@linutronix.de>
References: <20250718-restricted-pointers-net-v4-0-4baa64e40658@linutronix.de>
In-Reply-To: <20250718-restricted-pointers-net-v4-0-4baa64e40658@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752845027; l=3634;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=J4r5ps9WvNju5FTso8sqRG8ARuQDhy2vAqkZIvQH0II=;
 b=/djpugt6ObYd3ahyk9FKj2dg6XMy3D+TtNZRiJjFFVepc7D8kJ3G8YCpOyVK2IVLQ1qoPZyGP
 rzVgheMQdohCMc6wA+QVf/w+HlpQHlUBFTjNNkY8rLjKUtx9vHM/9wF
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping locks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_trace.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index af68869693edf6004e70caa4e952794439d800ab..76d67b39a0c1af02293ef2df06a6735b46c6679f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9153,7 +9153,7 @@ static int ice_create_q_channels(struct ice_vsi *vsi)
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
2.50.1


