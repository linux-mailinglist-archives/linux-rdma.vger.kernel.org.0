Return-Path: <linux-rdma+bounces-8449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C222A55A94
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982483B2C04
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B22727D76B;
	Thu,  6 Mar 2025 23:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="CBXZCyeB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2566C27F4C5
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302256; cv=none; b=iC3QBGfvp74whSyJBkc4/BxuF7p7NcFx6llNoh1BwY3IutseJ/7zDCPdb0F1+1BaCn3LPmYpLCOmqYo/fc8me/D0LZAbEB5jniadiOwtYm0oa1UhEjE7CaUarVOQbjQaT1Ql5CBMHwgm9sT+m/M9p2DUEPLQq1fwhbojAZlcLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302256; c=relaxed/simple;
	bh=Hv09k34nfs1xxqBXl7TDMFKgPOtA4OG/McOv3MJH1jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHOhSkA3zupgdE2YGEH6m9kozhgsQMUiGhbp9PROLlDwQtEa6BMx4GVukaOAzQZJUVyHUMPzZguZaSCXhGZ3E2WsfWtxQoPstZq9IDE0ebZ3bx1tSbumR2Yojbp14hg/TqM+LulEZGTUbhkV49PeaTItlS8678om7JaIxu0NxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=CBXZCyeB; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fb8ad525so8225546d6.3
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302253; x=1741907053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwf9aKYfLBkH2EO+Yv/vm47l0/6N6yxicdrmpxx6Kbk=;
        b=CBXZCyeBbiAOgIX/aBW8MLsy1ahwrp5DO9cz5sRTSgV3ISzhb2HBXjbUBzVIM4f1Iy
         0uO+keQ/Xbmjjq6nsZ9mNE1LQWb5NTIDLq+qjhhiWBhGkH5JCMAIrGlSQ3QRjWyJ8ddV
         BypuSNZNKbEnaZfa1Bi82bz3z92t31D0ALq+rV9kjuOeLw+/8iAQVtwOCr275ZEvLCoC
         yXBDH4eyS/TJPer5kgE3RjNilea3n/rF+/9DFY1yPr/YwXYOgh0cCPBud+45JzmxiMec
         DYbzL8Z4CS53bb0NDix5lqJsydPw1z5ojPk31Up4ArXk4hfxmkxMq2L101Fv5H8iMzxp
         QfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302253; x=1741907053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwf9aKYfLBkH2EO+Yv/vm47l0/6N6yxicdrmpxx6Kbk=;
        b=wvfwCMg9a7I1W9i0+jRlu3USnZpcdq13fV2WBK8FlidWAHzppifH5HAT4bwjDBxa+j
         ocHB72DrRncQWjcT4D0JkoPZFW1JIGmQcI7UC5O2dgbOCsc6jCbSRuHEG21kAes9j0Ji
         34UHn3KW5BjIrUnpNwaXdXA+TbkHZ3TXv+V+fviQwnBNrH+W1GEn6YsBjw1ckl2JR5pp
         lysza6SPSfnyjRnHAG+qCR3UpZaSlCqHXUL0nbiOba7IetZoJI8NpHuKl2iwGNSJuLKS
         KueIItf26+QxvKxIMxFIXklNW5I9SfBkVjJoO4SQxxSfofzjXAS43rtaKWSJDksqXrGP
         V9iA==
X-Forwarded-Encrypted: i=1; AJvYcCWEjbGrgh2xPoD2d9UMA97kdweO9iLEjNrKRT5CXScuGI5W/AWnKCgjM9e5iIxXxUe/Z1tqRQdqAKtY@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1azXThDoXJCiiWKvneBDwCINzUT+30Ao21ZuaImBTAuGx6yKn
	pvPWZPioGR5Vy9wPUyoSuBSy9l7EH+BjxgRt1V68qDFvmNeGyLH6FJbvmP/OVQ0=
X-Gm-Gg: ASbGnctzit5HpMx1SVLxf8yd0SlNsY4B9FGywGSc3Azw9xgCtj61LL0v6SwqLnJUxKF
	q+PbIR5QEa83FftEZRv4vjqDNCnG+F6Na/jJmfktxs59ymsAyOZUDq/x7f3LxKgaYzjwU8u52Xa
	ecqFw6XwetANQbYKss6uRGYlEzJmR8UyuKk6w2gQSMf+JeJqhPhcvM2zHmyEqBqiaX4GpouSMrM
	JUIn0AwzBv9h5UY+NM/+lJpgkVoMzlFLF6KShz0l/nLoRIogxFvyEt0AYfjr9WK9F8B7/DO8yr/
	spBEv67XQMyW53/bKV8Ef92PbToFs2z0yyzkst+IH0W2jhZfZoi4zQOZGTjyelcrtLCe
X-Google-Smtp-Source: AGHT+IFHoxfqPVbJbyiyNsne45S/SjH8yFhnpBfXPuEHDhvCo7LC1oPeuv2HrkdT1Q70hwCSjB7xmg==
X-Received: by 2002:a05:6214:2428:b0:6e6:698f:cb00 with SMTP id 6a1803df08f44-6e9006942bamr13795096d6.42.1741302253065;
        Thu, 06 Mar 2025 15:04:13 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:12 -0800 (PST)
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
Subject: [RFC PATCH 08/13] drivers: ultraeth: add request transmit support
Date: Fri,  7 Mar 2025 01:01:58 +0200
Message-ID: <20250306230203.1550314-9-nikolay@enfabrica.net>
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

Add support for sending request packets, if a PDC doesn't exist yet one
gets created and the request carries the SYN flag until the first ack is
received. Currently it operates in RUD (unordered) mode. The transmit
packet sequence numbers are tracked via a bitmap. Track unacked packets
and retransmit them upon a timeout.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/ultraeth/uet_pdc.c     | 312 ++++++++++++++++++++++++++++++++-
 drivers/ultraeth/uet_pds.c     |  57 ++++++
 include/net/ultraeth/uet_pdc.h |  27 +++
 include/net/ultraeth/uet_pds.h |   2 +
 4 files changed, 389 insertions(+), 9 deletions(-)

diff --git a/drivers/ultraeth/uet_pdc.c b/drivers/ultraeth/uet_pdc.c
index a0352a925329..dc79305cc3b5 100644
--- a/drivers/ultraeth/uet_pdc.c
+++ b/drivers/ultraeth/uet_pdc.c
@@ -19,6 +19,191 @@ static void uet_pdc_xmit(struct uet_pdc *pdc, struct sk_buff *skb)
 	dev_queue_xmit(skb);
 }
 
+static void uet_pdc_mpr_advance_tx(struct uet_pdc *pdc, u32 bits)
+{
+	if (!test_bit(0, pdc->tx_bitmap) || !test_bit(0, pdc->ack_bitmap))
+		return;
+
+	bitmap_shift_right(pdc->tx_bitmap, pdc->tx_bitmap, bits, UET_PDC_MPR);
+	bitmap_shift_right(pdc->ack_bitmap, pdc->ack_bitmap, bits, UET_PDC_MPR);
+	pdc->tx_base_psn += bits;
+	netdev_dbg(pds_netdev(pdc->pds), "%s: advancing tx to %u\n", __func__,
+		   pdc->tx_base_psn);
+}
+
+static void uet_pdc_rtx_skb(struct uet_pdc *pdc, struct sk_buff *skb, ktime_t ts)
+{
+	struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+	struct uet_prologue_hdr *prologue;
+
+	if (!nskb)
+		return;
+
+	prologue = (struct uet_prologue_hdr *)nskb->data;
+	if (!(uet_prologue_flags(prologue) & UET_PDS_REQ_FLAG_RETX))
+		uet_pdc_build_prologue(prologue,
+				       uet_prologue_ctl_type(prologue),
+				       uet_prologue_next_hdr(prologue),
+				       uet_prologue_flags(prologue) |
+				       UET_PDS_REQ_FLAG_RETX);
+
+	uet_pdc_xmit(pdc, nskb);
+	skb->tstamp = ts;
+	UET_SKB_CB(skb)->rtx_attempts++;
+}
+
+static void uet_pdc_rtx_timer_expired(struct timer_list *t)
+{
+	u64 smallest_diff = UET_PDC_RTX_DEFAULT_TIMEOUT_NSEC;
+	struct uet_pdc *pdc = from_timer(pdc, t, rtx_timer);
+	ktime_t now = ktime_get_real_ns();
+	struct sk_buff *skb, *skb_tmp;
+
+	spin_lock(&pdc->lock);
+	skb = skb_rb_first(&pdc->rtx_queue);
+	skb_rbtree_walk_from_safe(skb, skb_tmp) {
+		ktime_t expire = ktime_add(skb->tstamp,
+					   UET_PDC_RTX_DEFAULT_TIMEOUT_NSEC);
+
+		if (ktime_before(now, expire)) {
+			u64 diff = ktime_to_ns(ktime_sub(expire, now));
+
+			if (diff < smallest_diff)
+				smallest_diff = diff;
+			continue;
+		}
+		if (UET_SKB_CB(skb)->rtx_attempts == UET_PDC_RTX_DEFAULT_MAX) {
+			/* XXX: close connection, count drops etc */
+			netdev_dbg(pds_netdev(pdc->pds), "%s: psn: %u too many rtx attempts: %u\n",
+				   __func__, UET_SKB_CB(skb)->psn,
+				   UET_SKB_CB(skb)->rtx_attempts);
+			/* if dropping the oldest packet move window */
+			if (UET_SKB_CB(skb)->psn == pdc->tx_base_psn)
+				uet_pdc_mpr_advance_tx(pdc, 1);
+			rb_erase(&skb->rbnode, &pdc->rtx_queue);
+			consume_skb(skb);
+			continue;
+		}
+
+		uet_pdc_rtx_skb(pdc, skb, now);
+	}
+
+	mod_timer(&pdc->rtx_timer, jiffies +
+				   nsecs_to_jiffies(smallest_diff));
+	spin_unlock(&pdc->lock);
+}
+
+static void uet_pdc_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	struct sk_buff *skb1;
+
+	while (*p) {
+		parent = *p;
+		skb1 = rb_to_skb(parent);
+		if (before(UET_SKB_CB(skb)->psn, UET_SKB_CB(skb1)->psn))
+			p = &parent->rb_left;
+		else
+			p = &parent->rb_right;
+	}
+
+	rb_link_node(&skb->rbnode, parent, p);
+	rb_insert_color(&skb->rbnode, root);
+}
+
+static struct sk_buff *uet_pdc_rtx_find(struct uet_pdc *pdc, u32 psn)
+{
+	struct rb_node *parent, **p = &pdc->rtx_queue.rb_node;
+
+	while (*p) {
+		struct sk_buff *skb;
+
+		parent = *p;
+		skb = rb_to_skb(parent);
+		if (psn == UET_SKB_CB(skb)->psn)
+			return skb;
+
+		if (before(psn, UET_SKB_CB(skb)->psn))
+			p = &parent->rb_left;
+		else
+			p = &parent->rb_right;
+	}
+
+	return NULL;
+}
+
+static void uet_pdc_rtx_remove_skb(struct uet_pdc *pdc, struct sk_buff *skb)
+{
+	rb_erase(&skb->rbnode, &pdc->rtx_queue);
+	consume_skb(skb);
+}
+
+static void uet_pdc_ack_psn(struct uet_pdc *pdc, struct sk_buff *ack_skb,
+			    u32 psn, bool ecn_marked)
+{
+	struct sk_buff *skb = skb_rb_first(&pdc->rtx_queue);
+	u32 first_psn = skb ? UET_SKB_CB(skb)->psn : 0;
+
+	/* if the oldest PSN got ACKed and it hasn't been retransmitted
+	 * we can move the timer to the next one
+	 */
+	if (skb && psn == first_psn) {
+		struct sk_buff *next = skb_rb_next(skb);
+
+		/* move timer only if first PSN wasn't retransmitted */
+		if (next && !UET_SKB_CB(skb)->rtx_attempts) {
+			ktime_t expire = ktime_add(next->tstamp,
+						   UET_PDC_RTX_DEFAULT_TIMEOUT_NSEC);
+			ktime_t now = ktime_get_ns();
+
+			if (ktime_before(expire, now)) {
+				u64 diff = ktime_to_ns(ktime_sub(expire, now));
+				unsigned long diffj = nsecs_to_jiffies(diff);
+
+				mod_timer(&pdc->rtx_timer, jiffies + diffj);
+			}
+		}
+	} else {
+		skb = uet_pdc_rtx_find(pdc, psn);
+	}
+
+	if (!skb)
+		return;
+
+	uet_pdc_rtx_remove_skb(pdc, skb);
+}
+
+static void uet_pdc_rtx_purge(struct uet_pdc *pdc)
+{
+	struct rb_node *p = rb_first(&pdc->rtx_queue);
+
+	while (p) {
+		struct sk_buff *skb = rb_to_skb(p);
+
+		p = rb_next(p);
+		uet_pdc_rtx_remove_skb(pdc, skb);
+	}
+}
+
+static int uet_pdc_rtx_queue(struct uet_pdc *pdc, struct sk_buff *skb, u32 psn)
+{
+	struct sk_buff *rtx_skb = skb_clone(skb, GFP_ATOMIC);
+
+	if (unlikely(!rtx_skb))
+		return -ENOMEM;
+
+	UET_SKB_CB(rtx_skb)->psn = psn;
+	UET_SKB_CB(rtx_skb)->rtx_attempts = 0;
+	uet_pdc_rbtree_insert(&pdc->rtx_queue, rtx_skb);
+
+	if (!timer_pending(&pdc->rtx_timer))
+		mod_timer(&pdc->rtx_timer, jiffies +
+					   UET_PDC_RTX_DEFAULT_TIMEOUT_JIFFIES);
+
+	return 0;
+}
+
 /* use the approach as nf nat, try a few rounds starting at random offset */
 static bool uet_pdc_id_get(struct uet_pdc *pdc)
 {
@@ -69,7 +254,7 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 	pdc->pds = pds;
 	pdc->mode = mode;
 	pdc->is_initiator = !is_inbound;
-
+	pdc->rtx_queue = RB_ROOT;
 	if (!uet_pdc_id_get(pdc))
 		goto err_id_get;
 
@@ -83,9 +268,13 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 	pdc->rx_bitmap = bitmap_zalloc(UET_PDC_MPR, GFP_ATOMIC);
 	if (!pdc->rx_bitmap)
 		goto err_rx_bitmap;
+	pdc->tx_bitmap = bitmap_zalloc(UET_PDC_MPR, GFP_ATOMIC);
+	if (!pdc->tx_bitmap)
+		goto err_tx_bitmap;
 	pdc->ack_bitmap = bitmap_zalloc(UET_PDC_MPR, GFP_ATOMIC);
 	if (!pdc->ack_bitmap)
 		goto err_ack_bitmap;
+	timer_setup(&pdc->rtx_timer, uet_pdc_rtx_timer_expired, 0);
 	pdc->metadata = __ip_tun_set_dst(key->src_ip, key->dst_ip, tos, 0, dport,
 					 md_flags, 0, 0);
 	if (!pdc->metadata)
@@ -124,6 +313,8 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 err_tun_dst:
 	bitmap_free(pdc->ack_bitmap);
 err_ack_bitmap:
+	bitmap_free(pdc->tx_bitmap);
+err_tx_bitmap:
 	bitmap_free(pdc->rx_bitmap);
 err_rx_bitmap:
 	uet_pds_pdcid_remove(pdc);
@@ -135,8 +326,11 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 
 void uet_pdc_free(struct uet_pdc *pdc)
 {
+	timer_delete_sync(&pdc->rtx_timer);
+	uet_pdc_rtx_purge(pdc);
 	dst_release(&pdc->metadata->dst);
 	bitmap_free(pdc->ack_bitmap);
+	bitmap_free(pdc->tx_bitmap);
 	bitmap_free(pdc->rx_bitmap);
 	kfree(pdc);
 }
@@ -148,6 +342,53 @@ void uet_pdc_destroy(struct uet_pdc *pdc)
 	uet_pds_pdc_gc_queue(pdc);
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
+static int uet_pdc_build_req(struct uet_pdc *pdc,
+			     struct sk_buff *skb, u8 type, u8 flags)
+{
+	struct uet_pds_req_hdr *req;
+	s64 psn;
+
+	req = skb_push(skb, sizeof(*req));
+	uet_pdc_build_prologue(&req->prologue, type,
+			       UET_PDS_NEXT_HDR_REQ_STD, flags);
+	switch (pdc->state) {
+	case UET_PDC_EP_STATE_CLOSED:
+		pdc->psn_start = get_random_u32();
+		pdc->tx_base_psn = pdc->psn_start;
+		pdc->rx_base_psn = pdc->psn_start;
+		break;
+	}
+
+	psn = uet_pdc_get_psn(pdc);
+	if (unlikely(psn == -1))
+		return -ENOSPC;
+	UET_SKB_CB(skb)->psn = psn;
+	req->psn = cpu_to_be32(psn);
+	req->spdcid = cpu_to_be16(pdc->spdcid);
+	req->dpdcid = cpu_to_be16(pdc->dpdcid);
+
+	return 0;
+}
+
 static void pdc_build_ack(struct uet_pdc *pdc, struct sk_buff *skb, u32 psn,
 			  u8 ack_flags, bool exact_psn)
 {
@@ -200,15 +441,65 @@ static int uet_pdc_send_ses_ack(struct uet_pdc *pdc, __u8 ses_rc, __be16 msg_id,
 	return 0;
 }
 
-static void uet_pdc_mpr_advance_tx(struct uet_pdc *pdc, u32 bits)
+int uet_pdc_tx_req(struct uet_pdc *pdc, struct sk_buff *skb, u8 type)
 {
-	if (!test_bit(0, pdc->ack_bitmap))
-		return;
+	struct uet_pds_req_hdr *req;
+	int ret = 0;
 
-	bitmap_shift_right(pdc->ack_bitmap, pdc->ack_bitmap, bits, UET_PDC_MPR);
-	pdc->tx_base_psn += bits;
-	netdev_dbg(pds_netdev(pdc->pds), "%s: advancing tx to %u\n", __func__,
-		   pdc->tx_base_psn);
+	spin_lock_bh(&pdc->lock);
+	if (pdc->tx_busy) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	switch (pdc->state) {
+	case UET_PDC_EP_STATE_CLOSED:
+		ret = uet_pdc_build_req(pdc, skb, type, UET_PDS_REQ_FLAG_SYN);
+		if (ret)
+			goto out_unlock;
+		req = (struct uet_pds_req_hdr *)skb->data;
+		ret = uet_pdc_rtx_queue(pdc, skb, be32_to_cpu(req->psn));
+		if (ret) {
+			uet_pdc_put_psn(pdc, be32_to_cpu(req->psn));
+			goto out_unlock;
+		}
+		pdc->state = UET_PDC_EP_STATE_SYN_SENT;
+		pdc->tx_busy = true;
+		break;
+	case UET_PDC_EP_STATE_SYN_SENT:
+		break;
+	case UET_PDC_EP_STATE_ESTABLISHED:
+		ret = uet_pdc_build_req(pdc, skb, type, 0);
+		if (ret)
+			goto out_unlock;
+		req = (struct uet_pds_req_hdr *)skb->data;
+		ret = uet_pdc_rtx_queue(pdc, skb, be32_to_cpu(req->psn));
+		if (ret) {
+			uet_pdc_put_psn(pdc, be32_to_cpu(req->psn));
+			goto out_unlock;
+		}
+		break;
+	case UET_PDC_EP_STATE_QUIESCE:
+		break;
+	case UET_PDC_EP_STATE_ACK_WAIT:
+		break;
+	case UET_PDC_EP_STATE_CLOSE_ACK_WAIT:
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+out_unlock:
+	netdev_dbg(pds_netdev(pdc->pds), "%s: tx_busy: %u pdc: [ tx_base_psn: %u"
+				  " state: %u dpdcid: %u spdcid: %u ] proto 0x%x\n",
+		   __func__, pdc->tx_busy, pdc->tx_base_psn, pdc->state,
+		   pdc->dpdcid, pdc->spdcid, ntohs(skb->protocol));
+	spin_unlock_bh(&pdc->lock);
+
+	if (!ret)
+		uet_pdc_xmit(pdc, skb);
+
+	return ret;
 }
 
 int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
@@ -221,6 +512,7 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 	u32 cack_psn = be32_to_cpu(ack->cack_psn);
 	u32 ack_psn = cack_psn + ack_psn_offset;
 	int ret = -EINVAL;
+	bool ecn_marked;
 	u32 psn_bit;
 
 	spin_lock(&pdc->lock);
@@ -237,7 +529,7 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 		goto err_dbg;
 
 	psn_bit = ack_psn - pdc->tx_base_psn;
-	if (!psn_bit_valid(psn_bit)) {
+	if (!psn_bit_valid(psn_bit) || !test_bit(psn_bit, pdc->tx_bitmap)) {
 		drop_reason = "ack_psn bit is invalid";
 		goto err_dbg;
 	}
@@ -252,6 +544,8 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 	/* we can advance only if the oldest pkt got acked */
 	if (!psn_bit)
 		uet_pdc_mpr_advance_tx(pdc, 1);
+	ecn_marked = !!(uet_prologue_flags(&ack->prologue) & UET_PDS_ACK_FLAG_M);
+	uet_pdc_ack_psn(pdc, skb, ack_psn, ecn_marked);
 
 	ret = 0;
 	switch (pdc->state) {
diff --git a/drivers/ultraeth/uet_pds.c b/drivers/ultraeth/uet_pds.c
index abc576e5b6e7..7efb634de85f 100644
--- a/drivers/ultraeth/uet_pds.c
+++ b/drivers/ultraeth/uet_pds.c
@@ -290,3 +290,60 @@ int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 
 	return ret;
 }
+
+static struct uet_pdc *uet_pds_new_pdc_tx(struct uet_pds *pds,
+					  struct sk_buff *skb,
+					  __be16 dport,
+					  struct uet_pdc_key *key,
+					  u8 mode, u8 state)
+{
+	struct uet_ses_req_hdr *ses_req = (struct uet_ses_req_hdr *)skb->data;
+
+	return uet_pdc_create(pds, 0, state, 0,
+			      uet_ses_req_pid_on_fep(ses_req),
+			      mode, 0, dport, key, false);
+}
+
+int uet_pds_tx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
+	       __be32 remote_fep_addr, __be16 dport, u32 job_id)
+{
+	struct uet_ses_req_hdr *ses_req = (struct uet_ses_req_hdr *)skb->data;
+	u32 req_job_id = uet_ses_req_job_id(ses_req);
+	struct uet_pdc_key key = {};
+	struct uet_pdc *pdc;
+
+	/* sending with wrong SES header job id? */
+	if (unlikely(job_id != req_job_id))
+		return -EINVAL;
+
+	key.src_ip = local_fep_addr;
+	key.dst_ip = remote_fep_addr;
+	key.job_id = job_id;
+
+	pdc = rhashtable_lookup_fast(&pds->pdcep_hash, &key,
+				     uet_pds_pdcep_rht_params);
+	/* new flow */
+	if (unlikely(!pdc)) {
+		struct uet_context *ctx;
+		struct uet_job *job;
+		struct uet_fep *fep;
+
+		ctx = container_of(pds, struct uet_context, pds);
+		job = uet_job_find(&ctx->job_reg, key.job_id);
+		if (!job)
+			return -ENOENT;
+		fep = rcu_dereference(job->fep);
+		if (!fep)
+			return -ECONNREFUSED;
+
+		pdc = uet_pds_new_pdc_tx(pds, skb, dport, &key,
+					 UET_PDC_MODE_RUD,
+					 UET_PDC_EP_STATE_CLOSED);
+		if (IS_ERR(pdc))
+			return PTR_ERR(pdc);
+	}
+
+	__net_timestamp(skb);
+
+	return uet_pdc_tx_req(pdc, skb, UET_PDS_TYPE_RUD_REQ);
+}
diff --git a/include/net/ultraeth/uet_pdc.h b/include/net/ultraeth/uet_pdc.h
index 1a42647489fe..261afc57ffe1 100644
--- a/include/net/ultraeth/uet_pdc.h
+++ b/include/net/ultraeth/uet_pdc.h
@@ -13,6 +13,12 @@
 
 #define UET_PDC_ID_MAX_ATTEMPTS 128
 #define UET_PDC_MAX_ID U16_MAX
+#define UET_PDC_RTX_DEFAULT_TIMEOUT_SEC 30
+#define UET_PDC_RTX_DEFAULT_TIMEOUT_JIFFIES (UET_PDC_RTX_DEFAULT_TIMEOUT_SEC * \
+					     HZ)
+#define UET_PDC_RTX_DEFAULT_TIMEOUT_NSEC (UET_PDC_RTX_DEFAULT_TIMEOUT_SEC * \
+					  NSEC_PER_SEC)
+#define UET_PDC_RTX_DEFAULT_MAX 3
 #define UET_PDC_MPR 128
 
 #define UET_SKB_CB(skb)       ((struct uet_skb_cb *)&((skb)->cb[0]))
@@ -20,6 +26,7 @@
 struct uet_skb_cb {
 	u32 psn;
 	__be32 remote_fep_addr;
+	u8 rtx_attempts;
 };
 
 enum {
@@ -51,6 +58,13 @@ enum mpr_pos {
 	UET_PDC_MPR_FUTURE
 };
 
+struct uet_pdc_pkt {
+	struct sk_buff *skb;
+	struct timer_list rtx_timer;
+	u32 psn;
+	int rtx;
+};
+
 struct uet_pdc {
 	struct rhash_head pdcid_node;
 	struct rhash_head pdcep_node;
@@ -69,12 +83,19 @@ struct uet_pdc {
 	u8 mode;
 	bool is_initiator;
 
+	int rtx_max;
+	struct timer_list rtx_timer;
+	unsigned long rtx_timeout;
+
 	unsigned long *rx_bitmap;
+	unsigned long *tx_bitmap;
 	unsigned long *ack_bitmap;
 
 	u32 rx_base_psn;
 	u32 tx_base_psn;
 
+	struct rb_root rtx_queue;
+
 	struct hlist_node gc_node;
 	struct rcu_head rcu;
 };
@@ -89,6 +110,7 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 		   __be32 remote_fep_addr, __u8 tos);
 int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 		   __be32 remote_fep_addr);
+int uet_pdc_tx_req(struct uet_pdc *pdc, struct sk_buff *skb, u8 type);
 
 static inline void uet_pdc_build_prologue(struct uet_prologue_hdr *prologue,
 					  u8 type, u8 next, u8 flags)
@@ -114,4 +136,9 @@ static inline bool psn_bit_valid(u32 bit)
 {
 	return bit < UET_PDC_MPR;
 }
+
+static inline bool before(u32 seq1, u32 seq2)
+{
+	return (s32)(seq1-seq2) < 0;
+}
 #endif /* _UECON_PDC_H */
diff --git a/include/net/ultraeth/uet_pds.h b/include/net/ultraeth/uet_pds.h
index 43f5748a318a..78624370f18c 100644
--- a/include/net/ultraeth/uet_pds.h
+++ b/include/net/ultraeth/uet_pds.h
@@ -40,6 +40,8 @@ void uet_pds_clean_job(struct uet_pds *pds, u32 job_id);
 
 int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 	       __be32 remote_fep_addr, __be16 dport, __u8 tos);
+int uet_pds_tx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
+	       __be32 remote_fep_addr, __be16 dport, u32 job_id);
 
 static inline struct uet_prologue_hdr *pds_prologue_hdr(const struct sk_buff *skb)
 {
-- 
2.48.1


