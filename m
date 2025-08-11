Return-Path: <linux-rdma+bounces-12665-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BADB2040B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 11:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07ABD18A051B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Aug 2025 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D02DE71D;
	Mon, 11 Aug 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O8ialkK2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t7OVbk4M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DC31F4E59;
	Mon, 11 Aug 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905411; cv=none; b=posaJ5pUpa6kWgstlDHB0voSO5iMM+az0znQcYmVEOz+9RwKl90PhiV9HfUQYHn5XfgEIpSMJJLUF3jia+NVQjGdttHb4RpRBjVEoXXscL+btMPda16X+kFBuhOLxR+wUvVwDzrlPqBvx5GD1XTQu2lNa56jgFjW5HFaJ80o2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905411; c=relaxed/simple;
	bh=T7FC9rutQZGsiSkiu1zAZb/dBlfuJq8IFe85Y1+xvHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/609SCV5z10ofOHy7vgPPuwBdcavjZfg4qBdqrqESlSRTNV/wL3KZx1DRiOVycxjNVby/mB58qdaXsGzd2VTGNzIfRGicJUkagt9ZHPheeBC+WZRqpb9SpsiGNRC1RPeAJoPjOqIBaBnkrOfumGz3K9zdXMNXqfv0leff+Qpx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O8ialkK2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t7OVbk4M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754905408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JZnt0Ku0ytDK5JOMZavp4kcCh/ydTN+qKpiPT34+tE=;
	b=O8ialkK2fXxYKKOcWAyLqkhIYevDp9nZY4X8MQEezdIe/h66gFInzW5YfyLFkGGy6dGpZB
	NiFZVwmaMd072+8qT9yZCsr+KmgRiSRO2Rizwrr/9dOSplbsz94o95F9i+8qp8trgqDJkP
	eGXMjoZkR3ng2KxKXtdKKPpRMaO0LQn0h43q5dnBGDMIT8QDR/AjBcCJILDrHfXhkSFRr7
	7ljhqEUToGmninxbaD/vHAgrO+iiu9eQgUoF/9zUlPMJYENZwT4Y99mTZyHpbZFdHV/XiU
	azNQkFxOJ5KFb4yefIP33xjgT3koyRUcVhTA2ADeJPgJGt/1bfx5TaBkWizZxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754905408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JZnt0Ku0ytDK5JOMZavp4kcCh/ydTN+qKpiPT34+tE=;
	b=t7OVbk4MDYbptjzl/Sbp2zrCi+Deu88cU47eRGI5pn92vtxzzMR/sgNSnqXgboDXNcGVgJ
	F7EOEz1MrLMwD3CA==
Date: Mon, 11 Aug 2025 11:43:18 +0200
Subject: [PATCH net-next v5 1/2] ice: Don't use %pK through printk or
 tracepoints
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250811-restricted-pointers-net-v5-1-2e2fdc7d3f2c@linutronix.de>
References: <20250811-restricted-pointers-net-v5-0-2e2fdc7d3f2c@linutronix.de>
In-Reply-To: <20250811-restricted-pointers-net-v5-0-2e2fdc7d3f2c@linutronix.de>
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
 Simon Horman <horms@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754905404; l=3684;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=T7FC9rutQZGsiSkiu1zAZb/dBlfuJq8IFe85Y1+xvHk=;
 b=mKlILFF7kSO3ybDXAeYwn5R/RnSczRsC9Z68XhaG4rZrL53qaeKK0nOYQOBX+XKuTSQQQOaSK
 y3cZTZbMkMtA+eN58wx+B7QzVKbfc4Uw8SsvZSUk58EvhmgRBqxwTdc
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
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 drivers/net/ethernet/intel/ice/ice_main.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_trace.h | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8e0b06c1e02b2a0ca25bd6f30395cc237e8c541e..93c6e64ed9404e48be5fedd5f7887a1bca8dda0e 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -9117,7 +9117,7 @@ static int ice_create_q_channels(struct ice_vsi *vsi)
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


