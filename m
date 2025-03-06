Return-Path: <linux-rdma+bounces-8453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C86AA55A9E
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7ECC7A8D71
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE44B280A5C;
	Thu,  6 Mar 2025 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="HoG9zcVx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC862803FD
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302263; cv=none; b=nTNXUPjA8s19OAejXeEAKsvx7bA0NfkkDWRe0TTskoHJPVyfCM958oQgv8SUkq1ZgX7jQWNdlybrVx6ns6h+k+u8eEBJa9XLZnn0qVf8TTlQI7BzW0MTzL8bUfSkf2IMlV01s6tS/MXA0yck6OHTrKRS0q07l/j9ikcLfhv0ii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302263; c=relaxed/simple;
	bh=U+FPMklqxEGNp2Jz2YOQHOK3M9eUniBywFkk8/Zi9sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ev5v5VzyfzAdzZXONNh8V0vpDZYZhpNfZ+ClRjdAjCnIOUg7LXSQFVFhVZT9+zQ2xMX81aPssRAIg8+9/793Va1NCqQ7Scg6DPO+Brw7ydvf0GtBsRcIKRrXc/z9e+ogxvYkbAo+wgaFE/OK4KQPBSdLf5LmLeoZ4YOSoNc3Uj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=HoG9zcVx; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c08fc20194so216440385a.2
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302260; x=1741907060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+rCZYlWGR67Iaw52JnPGDdtrZf11iJpZMP2VpzGX40=;
        b=HoG9zcVx/xUWKFqEWJiw6UttF6ymwtx/u9A73dUhyXqSL0SZUfxqil5m+WpfXs7st5
         lawykT2IcO2m7GR2nDttugihQdxR/EMjkXXrWJxYSRcZX9Rf9LOOUMWSBkWan6bQmamE
         rcIvOH06GngayNZuImiYgYnWDzHikZBDHoYiX8j8qdcR4FbBsUcyNFftErA9evocDR1K
         WxogIwkEch/Yj+Az3jlPp05CoO9JSB5kxaUsA78ECkyB++DByyBSUJymJJ8NklhWc+W8
         qfL3svFEVWEX4eoWGYZelh5zzscTyY1h66/JypBiuMfkcmQj8NEOmcp9E9cnJWxu4i8Y
         S2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302260; x=1741907060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+rCZYlWGR67Iaw52JnPGDdtrZf11iJpZMP2VpzGX40=;
        b=wXO9uvP/uU4eODjM+m3bXrt62SJ2Wam+qr9VIyWuh3Dib03rAeAfkQNIX1/WXw3dSO
         E3BZMGxTB122jmpPMc3HZM+Sk1aPkQX3ma8d3wY6FlFZ1w1alb2hiVfTujKVqWinC9b+
         oKF3eqfvaPPjJapyfLZpFOu62ulq2p4ZcSN2/l0yPMmJMiCEnrgO6nIRzOyMSR9naGx1
         bqGcDyTRtJc1vdsL71GsN/uqXn5K6Rdg0QOteFylWiXI+dsoiP+108dbTfAFGeaA0rdo
         gPHJvwDiFbEIc2PQRDlPle1C0GVxsH3LPCD0lkqGAoyhMsPNN/SnaulLOtjObvv6SVic
         U9KA==
X-Forwarded-Encrypted: i=1; AJvYcCVIChBhI7uVen68X2SIZB/PXRTcUQ4Xc4aO+BUucjs1zmAFBwDvW7VisCUUB85M9UypDCYTwOMW3mCs@vger.kernel.org
X-Gm-Message-State: AOJu0YwsRaITE3gTsRM8HVvBxznYOO3rcBecZXWdgHn6Jf3J6CaPvWHT
	MxaUfKao8J78pGFI/LgqDINplJxyyz7qy3tniuM8poyQ6orckR90nzFErTBzJ74=
X-Gm-Gg: ASbGnctQJF0hRZYqDyLwXp6Qrlad3fe1I6GjBVUy0SnjNHhJtXjJFK4yCnl1JT+/UAC
	75hd//xA6jiZI8lGmQ5LyFIHFn7H4CFUTXz7XNpl0jbeoC4SXqyTH8r4ubuzepEZM9CzNc/otXU
	iv/qas8ZLD5Qgq1rgDyymYr/ypRQBQgtbVicdF8f4u8rPv7ZWq6V6nricdEEYsxqWNTyL/iigX2
	hCjTnMZ5kZXadv0e3eqhCtRfIAojzpvE40S7MMeoLWU9w7QPJJtdvCU2k8TMGrD46sAVcEI2HjZ
	ZvMz7mbm1sqp59zuuHdJ5FVx/9c/xkFVry+OstE0Jx8zbJd8pQCKEKGq/ubMNY9cAMhN
X-Google-Smtp-Source: AGHT+IHYUL0eFaJJG6TuOC6v3Ofnweklcysj2NJ5wYSFYobjV1Zs2nYbzXnhIeDgP/IOJzICKGJlFA==
X-Received: by 2002:a05:6214:ca6:b0:6e8:fa33:2965 with SMTP id 6a1803df08f44-6e90061fa6emr13558416d6.14.1741302260275;
        Thu, 06 Mar 2025 15:04:20 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:19 -0800 (PST)
From: Nikolay Aleksandrov <nikolay@enfabrica.net>
To: netdev@vger.kernel.org
Cc: shrijeet@enfabrica.net,
	alex.badea@keysight.com,
	eric.davis@broadcom.com,
	rip.sohan@amd.com,
	dsahern@kernel.org,
	bmt@zurich.ibm.com,
	roland@enfabrica.net,
	nikolay@enfabrica.net,
	winston.liu@keysight.com,
	dan.mihailescu@keysight.com,
	kheib@redhat.com,
	parth.v.parikh@keysight.com,
	davem@redhat.com,
	ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com,
	welch@hpe.com,
	rakhahari.bhunia@keysight.com,
	kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [RFC PATCH 12/13] drivers: ultraeth: add initiator and target idle timeout support
Date: Fri,  7 Mar 2025 01:02:02 +0200
Message-ID: <20250306230203.1550314-13-nikolay@enfabrica.net>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306230203.1550314-1-nikolay@enfabrica.net>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add control packet header structure and a helper that builds a control
packet and transmits it. Currently it supports only CLOSE types,
use it to implement initiator and target timeout support by using the close
state machine. Upon initiator timeout we move to either ACK_WAIT (if
pending acks) or CLOSE_ACK_WAIT state, in the latter case we also send a
control message with CLOSE type. Upon target timeout we issue a REQ_CLOSE
control message and if it isn't answered in the timeout period we send a
NACK CLOSING_IN_ERR and close the PDC.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/ultraeth/uet_pdc.c     | 241 ++++++++++++++++++++++++++++++---
 drivers/ultraeth/uet_pds.c     |  40 +++++-
 include/net/ultraeth/uet_pdc.h |  12 +-
 include/net/ultraeth/uet_pds.h |   5 +
 include/uapi/linux/ultraeth.h  |  19 +++
 5 files changed, 293 insertions(+), 24 deletions(-)

diff --git a/drivers/ultraeth/uet_pdc.c b/drivers/ultraeth/uet_pdc.c
index 4f19bc68b570..5967095867dc 100644
--- a/drivers/ultraeth/uet_pdc.c
+++ b/drivers/ultraeth/uet_pdc.c
@@ -21,6 +21,14 @@ struct metadata_dst *uet_pdc_dst(const struct uet_pdc_key *key, __be16 dport,
 	return mdst;
 }
 
+void uet_pdc_rx_refresh(struct uet_pdc *pdc)
+{
+	unsigned long rx_jiffies = jiffies;
+
+	if (rx_jiffies != READ_ONCE(pdc->rx_last_jiffies))
+		WRITE_ONCE(pdc->rx_last_jiffies, rx_jiffies);
+}
+
 static void uet_pdc_xmit(struct uet_pdc *pdc, struct sk_buff *skb)
 {
 	skb->dev = pds_netdev(pdc->pds);
@@ -97,10 +105,19 @@ static void uet_pdc_rtx_timer_expired(struct timer_list *t)
 			continue;
 		}
 		if (UET_SKB_CB(skb)->rtx_attempts == UET_PDC_RTX_DEFAULT_MAX) {
+			struct uet_prologue_hdr *prologue;
+
 			/* XXX: close connection, count drops etc */
-			netdev_dbg(pds_netdev(pdc->pds), "%s: psn: %u too many rtx attempts: %u\n",
+			prologue = (struct uet_prologue_hdr *)skb->data;
+			netdev_dbg(pds_netdev(pdc->pds), "%s: psn: %u type: %u too many rtx attempts: %u\n",
 				   __func__, UET_SKB_CB(skb)->psn,
+				   uet_prologue_type(prologue),
 				   UET_SKB_CB(skb)->rtx_attempts);
+			if (uet_prologue_type(prologue) == UET_PDS_TYPE_CTRL_MSG &&
+			    uet_prologue_ctl_type(prologue) == UET_CTL_TYPE_CLOSE) {
+				uet_pdc_destroy(pdc);
+				goto out_unlock;
+			}
 			/* if dropping the oldest packet move window */
 			if (UET_SKB_CB(skb)->psn == pdc->tx_base_psn)
 				uet_pdc_mpr_advance_tx(pdc, 1);
@@ -114,6 +131,7 @@ static void uet_pdc_rtx_timer_expired(struct timer_list *t)
 
 	mod_timer(&pdc->rtx_timer, jiffies +
 				   nsecs_to_jiffies(smallest_diff));
+out_unlock:
 	spin_unlock(&pdc->lock);
 }
 
@@ -228,6 +246,154 @@ static int uet_pdc_rtx_queue(struct uet_pdc *pdc, struct sk_buff *skb, u32 psn)
 	return 0;
 }
 
+static s64 uet_pdc_get_psn(struct uet_pdc *pdc)
+{
+	unsigned long fzb = find_first_zero_bit(pdc->tx_bitmap, UET_PDC_MPR);
+
+	if (unlikely(fzb == UET_PDC_MPR))
+		return -1;
+
+	set_bit(fzb, pdc->tx_bitmap);
+
+	return pdc->tx_base_psn + fzb;
+}
+
+static void uet_pdc_put_psn(struct uet_pdc *pdc, u32 psn)
+{
+	unsigned long psn_bit = psn - pdc->tx_base_psn;
+
+	clear_bit(psn_bit, pdc->tx_bitmap);
+}
+
+static int uet_pdc_tx_ctl(struct uet_pdc *pdc, u8 ctl_type, u8 flags,
+			  __be32 psn, __be32 payload)
+{
+	struct uet_pds_ctl_hdr *ctl;
+	struct sk_buff *skb;
+	int ret;
+
+	/* both CLOSE types need to be retransmitted and need a new PSN */
+	switch (ctl_type) {
+	case UET_CTL_TYPE_CLOSE:
+	case UET_CTL_TYPE_REQ_CLOSE:
+		/* payload & psn must be 0 */
+		if (payload || psn)
+			return -EINVAL;
+		/* AR must be set */
+		flags |= UET_PDS_CTL_FLAG_AR;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	skb = alloc_skb(sizeof(struct uet_pds_ctl_hdr), GFP_ATOMIC);
+	if (!skb)
+		return -ENOBUFS;
+	ctl = skb_put(skb, sizeof(*ctl));
+	uet_pdc_build_prologue(&ctl->prologue, UET_PDS_TYPE_CTRL_MSG,
+			       ctl_type, flags);
+	if (!psn) {
+		s64 psn_new = uet_pdc_get_psn(pdc);
+
+		if (psn_new == -1) {
+			kfree_skb(skb);
+			return -ENOSPC;
+		}
+		psn = cpu_to_be32(psn_new);
+	}
+	ctl->psn = psn;
+	ctl->spdcid = cpu_to_be16(pdc->spdcid);
+	ctl->dpdcid_pdc_info_offset = cpu_to_be16(pdc->dpdcid);
+	ctl->payload = payload;
+
+	ret = uet_pdc_rtx_queue(pdc, skb, be32_to_cpu(psn));
+	if (ret) {
+		uet_pdc_put_psn(pdc, be32_to_cpu(psn));
+		kfree_skb(skb);
+		return ret;
+	}
+	uet_pdc_xmit(pdc, skb);
+
+	return 0;
+}
+
+static void uet_pdc_close(struct uet_pdc *pdc)
+{
+	u8 state;
+	int ret;
+
+	/* we have already transmitted the close control packet */
+	if (pdc->state > UET_PDC_EP_STATE_ACK_WAIT)
+		return;
+
+	if (!RB_EMPTY_ROOT(&pdc->rtx_queue)) {
+		if (pdc->state == UET_PDC_EP_STATE_ACK_WAIT)
+			return;
+		state = UET_PDC_EP_STATE_ACK_WAIT;
+	} else {
+		u8 ctl_type, ctl_flags = 0;
+
+		if (pdc->is_initiator) {
+			ctl_type = UET_CTL_TYPE_CLOSE;
+			state = UET_PDC_EP_STATE_CLOSE_ACK_WAIT;
+			ctl_flags = UET_PDS_CTL_FLAG_AR;
+		} else {
+			ctl_type = UET_CTL_TYPE_REQ_CLOSE;
+			state = UET_PDC_EP_STATE_CLOSE_WAIT;
+		}
+		ret = uet_pdc_tx_ctl(pdc, ctl_type, ctl_flags, 0, 0);
+		if (ret)
+			return;
+	}
+
+	pdc->state = state;
+}
+
+static void uet_pdc_timeout_timer_expired(struct timer_list *t)
+{
+	struct uet_pdc *pdc = from_timer(pdc, t, timeout_timer);
+	unsigned long now = jiffies, last_rx;
+	bool rearm_timer = true;
+
+	last_rx = READ_ONCE(pdc->rx_last_jiffies);
+	if (time_after_eq(last_rx, now) ||
+	    time_after_eq(last_rx + UET_PDC_IDLE_TIMEOUT_JIFFIES, now))
+		goto rearm_timeout;
+	spin_lock(&pdc->lock);
+	switch (pdc->state) {
+	case UET_PDC_EP_STATE_ACK_WAIT:
+		uet_pdc_close(pdc);
+		fallthrough;
+	case UET_PDC_EP_STATE_CLOSE_WAIT:
+	case UET_PDC_EP_STATE_CLOSE_ACK_WAIT:
+		/* we waited too long for the last acks */
+		if (time_before_eq(last_rx + (UET_PDC_IDLE_TIMEOUT_JIFFIES * 2),
+				   now)) {
+			if (!pdc->is_initiator)
+				uet_pds_send_nack(pdc->pds, &pdc->key,
+						  pdc->metadata->u.tun_info.key.tp_dst,
+						  0,
+						  cpu_to_be16(pdc->spdcid),
+						  cpu_to_be16(pdc->dpdcid),
+						  UET_PDS_NACK_CLOSING_IN_ERR,
+						  cpu_to_be32(pdc->rx_base_psn + 1),
+						  0);
+			uet_pdc_destroy(pdc);
+			rearm_timer = false;
+		}
+		break;
+	default:
+		uet_pdc_close(pdc);
+		break;
+	}
+	spin_unlock(&pdc->lock);
+rearm_timeout:
+	if (rearm_timer)
+		mod_timer(&pdc->timeout_timer,
+			  now + UET_PDC_IDLE_TIMEOUT_JIFFIES);
+}
+
 /* use the approach as nf nat, try a few rounds starting at random offset */
 static bool uet_pdc_id_get(struct uet_pdc *pdc)
 {
@@ -301,6 +467,7 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 	if (!pdc->ack_bitmap)
 		goto err_ack_bitmap;
 	timer_setup(&pdc->rtx_timer, uet_pdc_rtx_timer_expired, 0);
+	timer_setup(&pdc->timeout_timer, uet_pdc_timeout_timer_expired, 0);
 	pdc->metadata = uet_pdc_dst(key, dport, tos);
 	if (!pdc->metadata)
 		goto err_tun_dst;
@@ -331,6 +498,9 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 	}
 
 out:
+	mod_timer(&pdc->timeout_timer,
+		  jiffies + UET_PDC_IDLE_TIMEOUT_JIFFIES);
+
 	return pdc_ins;
 
 err_ep_insert:
@@ -351,6 +521,7 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 
 void uet_pdc_free(struct uet_pdc *pdc)
 {
+	timer_delete_sync(&pdc->timeout_timer);
 	timer_delete_sync(&pdc->rtx_timer);
 	uet_pdc_rtx_purge(pdc);
 	dst_release(&pdc->metadata->dst);
@@ -367,25 +538,6 @@ void uet_pdc_destroy(struct uet_pdc *pdc)
 	uet_pds_pdc_gc_queue(pdc);
 }
 
-static s64 uet_pdc_get_psn(struct uet_pdc *pdc)
-{
-	unsigned long fzb = find_first_zero_bit(pdc->tx_bitmap, UET_PDC_MPR);
-
-	if (unlikely(fzb == UET_PDC_MPR))
-		return -1;
-
-	set_bit(fzb, pdc->tx_bitmap);
-
-	return pdc->tx_base_psn + fzb;
-}
-
-static void uet_pdc_put_psn(struct uet_pdc *pdc, u32 psn)
-{
-	unsigned long psn_bit = psn - pdc->tx_base_psn;
-
-	clear_bit(psn_bit, pdc->tx_bitmap);
-}
-
 static int uet_pdc_build_req(struct uet_pdc *pdc,
 			     struct sk_buff *skb, u8 type, u8 flags)
 {
@@ -685,8 +837,17 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 					    remote_fep_addr);
 		break;
 	case UET_PDC_EP_STATE_ACK_WAIT:
+		ret = uet_job_fep_queue_skb(pds_context(pdc->pds),
+					    uet_ses_rsp_job_id(ses_rsp), skb,
+					    remote_fep_addr);
+		if (!RB_EMPTY_ROOT(&pdc->rtx_queue) || ret < 0)
+			break;
+		uet_pdc_close(pdc);
+		ret = 1;
 		break;
 	case UET_PDC_EP_STATE_CLOSE_ACK_WAIT:
+		uet_pdc_destroy(pdc);
+		ret = 0;
 		break;
 	}
 
@@ -919,3 +1080,43 @@ void uet_pdc_rx_nack(struct uet_pdc *pdc, struct sk_buff *skb)
 out:
 	spin_unlock(&pdc->lock);
 }
+
+int uet_pdc_rx_ctl(struct uet_pdc *pdc, struct sk_buff *skb,
+		   __be32 remote_fep_addr)
+{
+	struct uet_pds_ctl_hdr *ctl = pds_ctl_hdr(skb);
+	u32 ctl_psn = be32_to_cpu(ctl->psn);
+	int ret = -EINVAL;
+
+	spin_lock(&pdc->lock);
+	netdev_dbg(pds_netdev(pdc->pds), "%s: CTRL pdc: [ spdcid: %u dpdcid: %u rx_base_psn %u ] "
+					 "ctrl header: [ ctl_type: %u psn: %u ]\n",
+		   __func__, pdc->spdcid, pdc->dpdcid, pdc->rx_base_psn,
+		   uet_prologue_ctl_type(&ctl->prologue), ctl_psn);
+	if (psn_mpr_pos(pdc->rx_base_psn, ctl_psn) != UET_PDC_MPR_CUR)
+		goto out;
+	switch (uet_prologue_ctl_type(&ctl->prologue)) {
+	case UET_CTL_TYPE_CLOSE:
+		/* only the initiator can send CLOSE */
+		if (pdc->is_initiator)
+			break;
+		ret = 0;
+		uet_pdc_send_ses_ack(pdc, UET_SES_RSP_RC_NULL, 0,
+				     be32_to_cpu(ctl->psn),
+				     0, true);
+		uet_pdc_destroy(pdc);
+		break;
+	case UET_CTL_TYPE_REQ_CLOSE:
+		/* only the target can send REQ_CLOSE */
+		if (!pdc->is_initiator)
+			break;
+		uet_pdc_close(pdc);
+		break;
+	default:
+		break;
+	}
+out:
+	spin_unlock(&pdc->lock);
+
+	return ret;
+}
diff --git a/drivers/ultraeth/uet_pds.c b/drivers/ultraeth/uet_pds.c
index c144b6df8327..9ab0a088b308 100644
--- a/drivers/ultraeth/uet_pds.c
+++ b/drivers/ultraeth/uet_pds.c
@@ -195,13 +195,18 @@ static int uet_pds_rx_ack(struct uet_pds *pds, struct sk_buff *skb,
 	struct uet_pds_req_hdr *pds_req = pds_req_hdr(skb);
 	u16 pdcid = be16_to_cpu(pds_req->dpdcid);
 	struct uet_pdc *pdc;
+	int ret;
 
 	pdc = rhashtable_lookup_fast(&pds->pdcid_hash, &pdcid,
 				     uet_pds_pdcid_rht_params);
 	if (!pdc)
 		return -ENOENT;
 
-	return uet_pdc_rx_ack(pdc, skb, remote_fep_addr);
+	ret = uet_pdc_rx_ack(pdc, skb, remote_fep_addr);
+	if (ret >= 0)
+		uet_pdc_rx_refresh(pdc);
+
+	return ret;
 }
 
 static void uet_pds_rx_nack(struct uet_pds *pds, struct sk_buff *skb)
@@ -218,6 +223,26 @@ static void uet_pds_rx_nack(struct uet_pds *pds, struct sk_buff *skb)
 	uet_pdc_rx_nack(pdc, skb);
 }
 
+static int uet_pds_rx_ctl(struct uet_pds *pds, struct sk_buff *skb,
+			  __be32 remote_fep_addr)
+{
+	struct uet_pds_ctl_hdr *ctl = pds_ctl_hdr(skb);
+	u16 pdcid = be16_to_cpu(ctl->dpdcid_pdc_info_offset);
+	struct uet_pdc *pdc;
+	int ret;
+
+	pdc = rhashtable_lookup_fast(&pds->pdcid_hash, &pdcid,
+				     uet_pds_pdcid_rht_params);
+	if (!pdc)
+		return -ENOENT;
+
+	ret = uet_pdc_rx_ctl(pdc, skb, remote_fep_addr);
+	if (ret >= 0)
+		uet_pdc_rx_refresh(pdc);
+
+	return ret;
+}
+
 static struct uet_pdc *uet_pds_new_pdc_rx(struct uet_pds *pds,
 					  struct sk_buff *skb,
 					  __be16 dport, u32 ack_gen_trigger,
@@ -245,6 +270,7 @@ static int uet_pds_rx_req(struct uet_pds *pds, struct sk_buff *skb,
 	struct uet_pdc_key key = {};
 	struct uet_fep *fep;
 	struct uet_pdc *pdc;
+	int ret;
 
 	key.src_ip = local_fep_addr;
 	key.dst_ip = remote_fep_addr;
@@ -303,7 +329,11 @@ static int uet_pds_rx_req(struct uet_pds *pds, struct sk_buff *skb,
 			return PTR_ERR(pdc);
 	}
 
-	return uet_pdc_rx_req(pdc, skb, remote_fep_addr, tos);
+	ret = uet_pdc_rx_req(pdc, skb, remote_fep_addr, tos);
+	if (ret >= 0)
+		uet_pdc_rx_refresh(pdc);
+
+	return ret;
 }
 
 static bool uet_pds_rx_valid_req_next_hdr(const struct uet_prologue_hdr *prologue)
@@ -368,6 +398,12 @@ int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 		ret = uet_pds_rx_req(pds, skb, local_fep_addr, remote_fep_addr,
 				     dport, tos);
 		break;
+	case UET_PDS_TYPE_CTRL_MSG:
+		offset += sizeof(struct uet_pds_ctl_hdr);
+		if (!pskb_may_pull(skb, offset))
+			break;
+		ret = uet_pds_rx_ctl(pds, skb, remote_fep_addr);
+		break;
 	case UET_PDS_TYPE_NACK:
 		if (uet_prologue_next_hdr(prologue) != UET_PDS_NEXT_HDR_NONE)
 			break;
diff --git a/include/net/ultraeth/uet_pdc.h b/include/net/ultraeth/uet_pdc.h
index 60aecc15d0f1..02d2d5716c48 100644
--- a/include/net/ultraeth/uet_pdc.h
+++ b/include/net/ultraeth/uet_pdc.h
@@ -22,6 +22,8 @@
 #define UET_PDC_MPR 128
 #define UET_PDC_SACK_BITS 64
 #define UET_PDC_SACK_MASK (U64_MAX << 3)
+#define UET_PDC_IDLE_TIMEOUT_SEC 60
+#define UET_PDC_IDLE_TIMEOUT_JIFFIES (UET_PDC_IDLE_TIMEOUT_SEC * HZ)
 
 #define UET_SKB_CB(skb)       ((struct uet_skb_cb *)&((skb)->cb[0]))
 
@@ -38,7 +40,8 @@ enum {
 	UET_PDC_EP_STATE_ESTABLISHED,
 	UET_PDC_EP_STATE_QUIESCE,
 	UET_PDC_EP_STATE_ACK_WAIT,
-	UET_PDC_EP_STATE_CLOSE_ACK_WAIT
+	UET_PDC_EP_STATE_CLOSE_ACK_WAIT,
+	UET_PDC_EP_STATE_CLOSE_WAIT
 };
 
 struct uet_pdc_key {
@@ -88,7 +91,7 @@ struct uet_pdc {
 	int rtx_max;
 	struct timer_list rtx_timer;
 	unsigned long rtx_timeout;
-
+	unsigned long rx_last_jiffies;
 	unsigned long *rx_bitmap;
 	unsigned long *tx_bitmap;
 	unsigned long *ack_bitmap;
@@ -102,6 +105,8 @@ struct uet_pdc {
 	u32 ack_gen_min_pkt_add;
 	u32 ack_gen_count;
 
+	struct timer_list timeout_timer;
+
 	struct rb_root rtx_queue;
 
 	struct hlist_node gc_node;
@@ -121,8 +126,11 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 		   __be32 remote_fep_addr);
 int uet_pdc_tx_req(struct uet_pdc *pdc, struct sk_buff *skb, u8 type);
 void uet_pdc_rx_nack(struct uet_pdc *pdc, struct sk_buff *skb);
+int uet_pdc_rx_ctl(struct uet_pdc *pdc, struct sk_buff *skb,
+		   __be32 remote_fep_addr);
 struct metadata_dst *uet_pdc_dst(const struct uet_pdc_key *key, __be16 dport,
 				 u8 tos);
+void uet_pdc_rx_refresh(struct uet_pdc *pdc);
 
 static inline void uet_pdc_build_prologue(struct uet_prologue_hdr *prologue,
 					  u8 type, u8 next, u8 flags)
diff --git a/include/net/ultraeth/uet_pds.h b/include/net/ultraeth/uet_pds.h
index 4e9794a4d3de..fc2414cc2de8 100644
--- a/include/net/ultraeth/uet_pds.h
+++ b/include/net/ultraeth/uet_pds.h
@@ -73,6 +73,11 @@ static inline struct uet_pds_ack_ext_hdr *pds_ack_ext_hdr(const struct sk_buff *
 	return (struct uet_pds_ack_ext_hdr *)(pds_ack_hdr(skb) + 1);
 }
 
+static inline struct uet_pds_ctl_hdr *pds_ctl_hdr(const struct sk_buff *skb)
+{
+	return (struct uet_pds_ctl_hdr *)skb_network_header(skb);
+}
+
 static inline struct uet_ses_rsp_hdr *pds_ack_ses_rsp_hdr(const struct sk_buff *skb)
 {
 	/* TODO: ack_ext_hdr, CC_STATE, etc. */
diff --git a/include/uapi/linux/ultraeth.h b/include/uapi/linux/ultraeth.h
index 53d2124bc285..c1d5457073e1 100644
--- a/include/uapi/linux/ultraeth.h
+++ b/include/uapi/linux/ultraeth.h
@@ -247,6 +247,25 @@ struct uet_pds_nack_hdr {
 	__be32 payload;
 } __attribute__ ((__packed__));
 
+/* control packet flags */
+enum {
+	UET_PDS_CTL_FLAG_RSV21	= (1 << 0),
+	UET_PDS_CTL_FLAG_RSV22	= (1 << 1),
+	UET_PDS_CTL_FLAG_SYN	= (1 << 2),
+	UET_PDS_CTL_FLAG_AR	= (1 << 3),
+	UET_PDS_CTL_FLAG_RETX	= (1 << 4),
+	UET_PDS_CTL_FLAG_RSV11	= (1 << 5),
+	UET_PDS_CTL_FLAG_RSV12	= (1 << 6),
+};
+
+struct uet_pds_ctl_hdr {
+	struct uet_prologue_hdr prologue;
+	__be32 psn;
+	__be16 spdcid;
+	__be16 dpdcid_pdc_info_offset;
+	__be32 payload;
+} __attribute__ ((__packed__));
+
 /* ses request op codes */
 enum {
 	UET_SES_REQ_OP_NOOP			= 0x00,
-- 
2.48.1


