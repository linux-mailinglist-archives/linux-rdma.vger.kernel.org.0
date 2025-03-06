Return-Path: <linux-rdma+bounces-8448-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D46D5A55A91
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00DB37A8978
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7627F4E0;
	Thu,  6 Mar 2025 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="OLuAGBKn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADBA27E1D4
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302254; cv=none; b=kuPG4FCp9RQQLuGXFK/PQ/slqVIP3M2nr+ZYPHrmwlU3bV1vrP4ZS+mvcqoUhOexK8s29moaBYq4Gvd2VaJpFwpDnuLWOzn9tchoOob1tvoobeMuoUVhC7lWiAf4KB4SlVMOkwnB/Nred6BA258IecsNsB7aDZde4DOBffybIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302254; c=relaxed/simple;
	bh=Gd7gnODU0DKD5ytC3V5mdWFfgw32qZrGg0fJLfcPqKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bit62KxNAxM0cvZIzX00qlTitPRsC2WrfCCmb+WdMdqtqUOhRXLg3zk5lxDWpcbLDdC97XNiyi2G+DpvEIRQuHp9fpfQexrW9G1rYFnIYC2RTCBcEJF3SAhYgUc2v5+5YntmLlVBxpMDTff70UwlGgKOxOMG82iqmOdDKPoliwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=OLuAGBKn; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c3b4c4b409so198116685a.3
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302251; x=1741907051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgZ4DFZe+wGVy1zx5dFgA68nl8KtUw/hz4M7r+ARKDs=;
        b=OLuAGBKnLvF5HZndx8lEW2hZJ+JinMNoiC8O8CXR9DtroLCij4q2UNdqhXaWFE2z9F
         9wp5ua5Y8d/UzUWGhWnKttD0lBRtLiymm5vFf6c/phDyGMl3WmkwrAvn+580WFEb7Kvj
         coMdHoAe96JImzffzYuc9RCxa4ROBfCXJXuPnUubbgg6PajwKgtJZSOzSAl4OCa18Jla
         eZdyJ9YO1vKbyvr5LBqZhetLGfEItekccLIYYuFtunhgrnOy5ORr2Dh8JB80fCVSdnws
         Fvk3gU33P9el2BpJKA2EJNBhVjTi871gAmtz1l5zNDG2KREoHj/SEgTo4f4tsDYvVNBf
         JQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302251; x=1741907051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgZ4DFZe+wGVy1zx5dFgA68nl8KtUw/hz4M7r+ARKDs=;
        b=qOZneV+LhXy0avmRb4az+cU9Yyi4uY9NOsCK2HzSWeurxIoNekEsqL5kqAnLrCL5Pa
         Ckis92P+9ihHRdVA0kq7uhVv28iFt5oHw1lvqn2QenlVi24d/f9NN1vTJHy6Xerky8Fa
         LcQ04/4nRVgIZogwtSeT+cE9xh00N1l8ZmvqAQce1AFGnsu0UPFmyR5npb8LGkLp/b47
         peqct/zDVt+hNjWmUkuBanNWbxf4LC26KYm3NX7OslQ1YZ0e4+weZlwNJQk3VaWgd3/J
         MWxrkKEF7CBE+zWesAsO75SEcJFzp1t7Kp83UEfQRbU2H2hdQHIwRhEc57PfSTS0As2u
         8jiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXaV8GpQpSNeReMF0UlB+qwD6x5n34LvONHvd8a+AyEwAvhlv2U3YZRSUteLRDat5TM61VP8zIfb4B@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMLGGux/Q/mENtr5HvHN1TnYa1fH45o4rd2b7Hrpe84XLxkda
	oA72LPL9lwrsZ5fNdikTGMTmYyNuzZ3rzdk9wMG83BZVssCD6rOMNejTadSv7Z8=
X-Gm-Gg: ASbGncuojCMpBMmBeylEHGsLGsPOATr31nIeAofDWpzL4PvXuxbwfBqjwTYWe7YccGl
	NbnvzvIRoCZo1Tv7BNpBXDb5wlOi0Zb7K8Yhp0L7e2z+xWMqJlvSVuH+Um7uaPpfCZZCCpiKnJL
	XZP2fTOuL9CwW2eufY6bs9Sc29MGQENqt+/sdddNVRPNLlNDshZCLM+7BOHMNhUPWdXBB/S2yrB
	1ISE03o4DfshjbVCryUkKCSlAGCogSDPeTkwLmar2uSnNc7OOEAQcAz4OrXUkG6634nlYucvsip
	gBl+HvLQsuhbG04OqTwwNhkkv3cujKC16EqwbdSqtRqPZ+KdzwvyzTgTXDHory9xpaph
X-Google-Smtp-Source: AGHT+IGDKzMhLR7rEwsrTBkYDLjqgXRmC31T7+OmoHH6gaVPQotofQSXrIgpAMXNLZ3UQ8KdA7oiYw==
X-Received: by 2002:a05:620a:2722:b0:7c3:c3bb:2538 with SMTP id af79cd13be357-7c4e168c612mr159148085a.14.1741302251145;
        Thu, 06 Mar 2025 15:04:11 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:10 -0800 (PST)
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
Subject: [RFC PATCH 07/13] drivers: ultraeth: add request and ack receive support
Date: Fri,  7 Mar 2025 01:01:57 +0200
Message-ID: <20250306230203.1550314-8-nikolay@enfabrica.net>
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

Add support for receiving request and ack packets. A PDC is automatically
created if a request with SYN flag is received. If all is well with the
request and it passes all validations, we automatically return an ack.
Currently RUD (unordered) type of request is expected. The receive
and ack packet sequence numbers are tracked via bitmaps.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/ultraeth/uet_pdc.c     | 285 +++++++++++++++++++++++++++++++++
 drivers/ultraeth/uet_pds.c     | 137 +++++++++++++++-
 include/net/ultraeth/uet_pdc.h |  38 +++++
 3 files changed, 458 insertions(+), 2 deletions(-)

diff --git a/drivers/ultraeth/uet_pdc.c b/drivers/ultraeth/uet_pdc.c
index 47cf4c3dee04..a0352a925329 100644
--- a/drivers/ultraeth/uet_pdc.c
+++ b/drivers/ultraeth/uet_pdc.c
@@ -6,6 +6,19 @@
 #include <net/ultraeth/uet_context.h>
 #include <net/ultraeth/uet_pdc.h>
 
+static void uet_pdc_xmit(struct uet_pdc *pdc, struct sk_buff *skb)
+{
+	skb->dev = pds_netdev(pdc->pds);
+
+	if (!dst_hold_safe(&pdc->metadata->dst)) {
+		kfree_skb(skb);
+		return;
+	}
+
+	skb_dst_set(skb, &pdc->metadata->dst);
+	dev_queue_xmit(skb);
+}
+
 /* use the approach as nf nat, try a few rounds starting at random offset */
 static bool uet_pdc_id_get(struct uet_pdc *pdc)
 {
@@ -67,6 +80,12 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 	pdc->state = state;
 	pdc->dpdcid = dpdcid;
 	pdc->pid_on_fep = pid_on_fep;
+	pdc->rx_bitmap = bitmap_zalloc(UET_PDC_MPR, GFP_ATOMIC);
+	if (!pdc->rx_bitmap)
+		goto err_rx_bitmap;
+	pdc->ack_bitmap = bitmap_zalloc(UET_PDC_MPR, GFP_ATOMIC);
+	if (!pdc->ack_bitmap)
+		goto err_ack_bitmap;
 	pdc->metadata = __ip_tun_set_dst(key->src_ip, key->dst_ip, tos, 0, dport,
 					 md_flags, 0, 0);
 	if (!pdc->metadata)
@@ -103,6 +122,10 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 err_ep_insert:
 	dst_release(&pdc->metadata->dst);
 err_tun_dst:
+	bitmap_free(pdc->ack_bitmap);
+err_ack_bitmap:
+	bitmap_free(pdc->rx_bitmap);
+err_rx_bitmap:
 	uet_pds_pdcid_remove(pdc);
 err_id_get:
 	kfree(pdc);
@@ -113,6 +136,8 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 void uet_pdc_free(struct uet_pdc *pdc)
 {
 	dst_release(&pdc->metadata->dst);
+	bitmap_free(pdc->ack_bitmap);
+	bitmap_free(pdc->rx_bitmap);
 	kfree(pdc);
 }
 
@@ -122,3 +147,263 @@ void uet_pdc_destroy(struct uet_pdc *pdc)
 	uet_pds_pdcid_remove(pdc);
 	uet_pds_pdc_gc_queue(pdc);
 }
+
+static void pdc_build_ack(struct uet_pdc *pdc, struct sk_buff *skb, u32 psn,
+			  u8 ack_flags, bool exact_psn)
+{
+	struct uet_pds_ack_hdr *ack = skb_put(skb, sizeof(*ack));
+
+	uet_pdc_build_prologue(&ack->prologue, UET_PDS_TYPE_ACK,
+			       UET_PDS_NEXT_HDR_RSP, ack_flags);
+	if (exact_psn) {
+		ack->ack_psn_offset = 0;
+		ack->cack_psn = cpu_to_be32(psn);
+	} else {
+		ack->ack_psn_offset = cpu_to_be16(psn - pdc->rx_base_psn);
+		ack->cack_psn = cpu_to_be32(pdc->rx_base_psn);
+	}
+	ack->spdcid = cpu_to_be16(pdc->spdcid);
+	ack->dpdcid = cpu_to_be16(pdc->dpdcid);
+}
+
+static void uet_pdc_build_ses_ack(struct uet_pdc *pdc, struct sk_buff *skb,
+				  __u8 ses_rc, __be16 msg_id, u32 psn,
+				  u8 ack_flags, bool exact_psn)
+{
+	struct uet_ses_rsp_hdr *ses_rsp;
+	__be16 packed;
+
+	pdc_build_ack(pdc, skb, psn, ack_flags, exact_psn);
+	ses_rsp = skb_put(skb, sizeof(*ses_rsp));
+	memset(ses_rsp, 0, sizeof(*ses_rsp));
+	packed = pds_ses_rsp_hdr_pack(UET_SES_RSP_OP_RESPONSE, 0,
+				      UET_SES_RSP_LIST_EXPECTED, ses_rc);
+	ses_rsp->lst_opcode_ver_rc = packed;
+	ses_rsp->idx_gen_job_id = cpu_to_be32(pdc->key.job_id);
+	ses_rsp->msg_id = msg_id;
+}
+
+static int uet_pdc_send_ses_ack(struct uet_pdc *pdc, __u8 ses_rc, __be16 msg_id,
+				u32 psn, u8 ack_flags, bool exact_psn)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(sizeof(struct uet_ses_rsp_hdr) +
+			sizeof(struct uet_pds_ack_hdr), GFP_ATOMIC);
+	if (!skb)
+		return -ENOBUFS;
+
+	uet_pdc_build_ses_ack(pdc, skb, ses_rc, msg_id, psn, ack_flags,
+			      exact_psn);
+	uet_pdc_xmit(pdc, skb);
+
+	return 0;
+}
+
+static void uet_pdc_mpr_advance_tx(struct uet_pdc *pdc, u32 bits)
+{
+	if (!test_bit(0, pdc->ack_bitmap))
+		return;
+
+	bitmap_shift_right(pdc->ack_bitmap, pdc->ack_bitmap, bits, UET_PDC_MPR);
+	pdc->tx_base_psn += bits;
+	netdev_dbg(pds_netdev(pdc->pds), "%s: advancing tx to %u\n", __func__,
+		   pdc->tx_base_psn);
+}
+
+int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
+		   __be32 remote_fep_addr)
+{
+	struct uet_ses_rsp_hdr *ses_rsp = pds_ack_ses_rsp_hdr(skb);
+	struct uet_pds_ack_hdr *ack = pds_ack_hdr(skb);
+	s16 ack_psn_offset = be16_to_cpu(ack->ack_psn_offset);
+	const char *drop_reason = "ack_psn not in MPR window";
+	u32 cack_psn = be32_to_cpu(ack->cack_psn);
+	u32 ack_psn = cack_psn + ack_psn_offset;
+	int ret = -EINVAL;
+	u32 psn_bit;
+
+	spin_lock(&pdc->lock);
+	netdev_dbg(pds_netdev(pdc->pds), "%s: tx_busy: %u pdc: [ tx_base_psn: %u"
+				  " state: %u dpdcid: %u spdcid: %u ]\n"
+				  "ses: [ msg id: %u cack_psn: %u spdcid: %u"
+				  " dpdcid: %u ack_psn: %u ]\n",
+		   __func__, pdc->tx_busy, pdc->tx_base_psn,
+		   pdc->state, pdc->dpdcid, pdc->spdcid,
+		   be16_to_cpu(ses_rsp->msg_id), be32_to_cpu(ack->cack_psn),
+		   be16_to_cpu(ack->spdcid), be16_to_cpu(ack->dpdcid), ack_psn);
+
+	if (psn_mpr_pos(pdc->tx_base_psn, ack_psn) != UET_PDC_MPR_CUR)
+		goto err_dbg;
+
+	psn_bit = ack_psn - pdc->tx_base_psn;
+	if (!psn_bit_valid(psn_bit)) {
+		drop_reason = "ack_psn bit is invalid";
+		goto err_dbg;
+	}
+	if (test_and_set_bit(psn_bit, pdc->ack_bitmap)) {
+		drop_reason = "ack_psn bit already set in ack_bitmap";
+		goto err_dbg;
+	}
+
+	/* either using ROD mode or in SYN_SENT state */
+	if (pdc->tx_busy)
+		pdc->tx_busy = false;
+	/* we can advance only if the oldest pkt got acked */
+	if (!psn_bit)
+		uet_pdc_mpr_advance_tx(pdc, 1);
+
+	ret = 0;
+	switch (pdc->state) {
+	case UET_PDC_EP_STATE_SYN_SENT:
+	case UET_PDC_EP_STATE_NEW_ESTABLISHED:
+		pdc->dpdcid = be16_to_cpu(ack->spdcid);
+		pdc->state = UET_PDC_EP_STATE_ESTABLISHED;
+		fallthrough;
+	case UET_PDC_EP_STATE_ESTABLISHED:
+		ret = uet_job_fep_queue_skb(pds_context(pdc->pds),
+					    uet_ses_rsp_job_id(ses_rsp), skb,
+					    remote_fep_addr);
+		break;
+	case UET_PDC_EP_STATE_ACK_WAIT:
+		break;
+	case UET_PDC_EP_STATE_CLOSE_ACK_WAIT:
+		break;
+	}
+
+out:
+	spin_unlock(&pdc->lock);
+
+	return ret;
+err_dbg:
+	netdev_dbg(pds_netdev(pdc->pds), "%s: drop reason: [ %s ]\n"
+				  "pdc: [ tx_base_psn: %u state: %u"
+				  " dpdcid: %u spdcid: %u ]\n"
+				  "ses: [ msg id: %u cack_psn: %u spdcid: %u"
+				  " dpdcid: %u ack_psn: %u ]\n",
+		  __func__, drop_reason, pdc->tx_base_psn,
+		  pdc->state, pdc->dpdcid, pdc->spdcid,
+		  be16_to_cpu(ses_rsp->msg_id), be32_to_cpu(ack->cack_psn),
+		  be16_to_cpu(ack->spdcid), be16_to_cpu(ack->dpdcid), ack_psn);
+	goto out;
+}
+
+static void uet_pdc_mpr_advance_rx(struct uet_pdc *pdc)
+{
+	if (!test_bit(0, pdc->rx_bitmap))
+		return;
+
+	bitmap_shift_right(pdc->rx_bitmap, pdc->rx_bitmap, 1, UET_PDC_MPR);
+	pdc->rx_base_psn++;
+	netdev_dbg(pds_netdev(pdc->pds), "%s: advancing rx to %u\n",
+		   __func__, pdc->rx_base_psn);
+}
+
+int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
+		   __be32 remote_fep_addr, __u8 tos)
+{
+	struct uet_ses_req_hdr *ses_req = pds_req_ses_req_hdr(skb);
+	struct uet_pds_req_hdr *req = pds_req_hdr(skb);
+	u8 req_flags = uet_prologue_flags(&req->prologue), ack_flags = 0;
+	u32 req_psn = be32_to_cpu(req->psn);
+	const char *drop_reason = "tx_busy";
+	unsigned long psn_bit;
+	enum mpr_pos psn_pos;
+	int ret = -EINVAL;
+
+	spin_lock(&pdc->lock);
+	netdev_dbg(pds_netdev(pdc->pds), "%s: tx_busy: %u pdc: [ tx_base_psn: %u"
+				  " state: %u dpdcid: %u spdcid: %u ]\n"
+				  "req: [ psn: %u spdcid: %u dpdcid: %u prologue flags: 0x%x ]\n"
+				  "ses_req: [ opcode: %u msg id: %u job id: %u "
+				  "pid_on_fep: %u flags: 0x%x ]\n",
+		   __func__, pdc->tx_busy, pdc->tx_base_psn,
+		   pdc->state, pdc->dpdcid, pdc->spdcid,
+		   req_psn, be16_to_cpu(req->spdcid), be16_to_cpu(req->dpdcid),
+		   uet_prologue_flags(&req->prologue),
+		   uet_ses_req_opcode(ses_req), be16_to_cpu(ses_req->msg_id),
+		   uet_ses_req_job_id(ses_req), uet_ses_req_pid_on_fep(ses_req),
+		   uet_ses_req_flags(ses_req));
+
+	if (unlikely(pdc->tx_busy))
+		goto err_dbg;
+
+	if (req_flags & UET_PDS_REQ_FLAG_RETX)
+		ack_flags |= UET_PDS_ACK_FLAG_RETX;
+	if (INET_ECN_is_ce(tos))
+		ack_flags |= UET_PDS_ACK_FLAG_M;
+	psn_pos = psn_mpr_pos(pdc->rx_base_psn, req_psn);
+	switch (psn_pos) {
+	case UET_PDC_MPR_FUTURE:
+		drop_reason = "req psn is in a future MPR window";
+		goto err_dbg;
+	case UET_PDC_MPR_PREV:
+		if ((int)(req_psn - pdc->rx_base_psn) < S16_MIN) {
+			drop_reason = "req psn is too far in the past";
+			goto err_dbg;
+		}
+		uet_pdc_send_ses_ack(pdc, UET_SES_RSP_RC_NULL, ses_req->msg_id,
+				     req_psn, ack_flags, true);
+		netdev_dbg(pds_netdev(pdc->pds), "%s: received a request in previous MPR window (psn %u)\n"
+					  "pdc: [ rx_base_psn: %u state: %u"
+					  " dpdcid: %u spdcid: %u ]\n",
+			   __func__, req_psn, pdc->rx_base_psn,
+			   pdc->state, pdc->dpdcid, pdc->spdcid);
+		goto out;
+	case UET_PDC_MPR_CUR:
+		break;
+	}
+
+	psn_bit = req_psn - pdc->rx_base_psn;
+	if (!psn_bit_valid(psn_bit)) {
+		drop_reason = "req psn bit is invalid";
+		goto err_dbg;
+	}
+	if (test_and_set_bit(psn_bit, pdc->rx_bitmap)) {
+		drop_reason = "req psn bit is already set in rx_bitmap";
+		goto err_dbg;
+	}
+
+	ret = 0;
+	switch (pdc->state) {
+	case UET_PDC_EP_STATE_SYN_SENT:
+		/* error */
+		break;
+	case UET_PDC_EP_STATE_ESTABLISHED:
+		/* Rx request and do an upcall, potentially return an ack */
+		ret = uet_job_fep_queue_skb(pds_context(pdc->pds),
+					    uet_ses_req_job_id(ses_req), skb,
+					    remote_fep_addr);
+		/* TODO: handle errors in sending the error */
+		/* TODO: more specific RC codes */
+		break;
+	case UET_PDC_EP_STATE_ACK_WAIT:
+		break;
+	case UET_PDC_EP_STATE_CLOSE_ACK_WAIT:
+		break;
+	}
+
+	if (ret >= 0)
+		uet_pdc_send_ses_ack(pdc, UET_SES_RSP_RC_NULL, ses_req->msg_id,
+				     req_psn, ack_flags, false);
+	/* TODO: NAK */
+
+	if (!psn_bit)
+		uet_pdc_mpr_advance_rx(pdc);
+
+out:
+	spin_unlock(&pdc->lock);
+
+	return ret;
+err_dbg:
+	netdev_dbg(pds_netdev(pdc->pds), "%s: drop reason: [ %s ]\n"
+				  "pdc: [ rx_base_psn: %u state: %u"
+				  " dpdcid: %u spdcid: %u ]\n"
+				  "ses_req: [ msg id: %u ack_psn: %u spdcid: %u"
+				  " dpdcid: %u ]\n",
+		  __func__, drop_reason, pdc->rx_base_psn,
+		  pdc->state, pdc->dpdcid, pdc->spdcid,
+		  be16_to_cpu(ses_req->msg_id), be32_to_cpu(req->psn),
+		  be16_to_cpu(req->spdcid), be16_to_cpu(req->dpdcid));
+	goto out;
+}
diff --git a/drivers/ultraeth/uet_pds.c b/drivers/ultraeth/uet_pds.c
index 4aec61eeb230..abc576e5b6e7 100644
--- a/drivers/ultraeth/uet_pds.c
+++ b/drivers/ultraeth/uet_pds.c
@@ -149,11 +149,144 @@ void uet_pds_clean_job(struct uet_pds *pds, u32 job_id)
 	rhashtable_walk_exit(&iter);
 }
 
+static int uet_pds_rx_ack(struct uet_pds *pds, struct sk_buff *skb,
+			  __be32 local_fep_addr, __be32 remote_fep_addr)
+{
+	struct uet_pds_req_hdr *pds_req = pds_req_hdr(skb);
+	u16 pdcid = be16_to_cpu(pds_req->dpdcid);
+	struct uet_pdc *pdc;
+
+	pdc = rhashtable_lookup_fast(&pds->pdcid_hash, &pdcid,
+				     uet_pds_pdcid_rht_params);
+	if (!pdc)
+		return -ENOENT;
+
+	return uet_pdc_rx_ack(pdc, skb, remote_fep_addr);
+}
+
+static struct uet_pdc *uet_pds_new_pdc_rx(struct uet_pds *pds,
+					  struct sk_buff *skb,
+					  __be16 dport,
+					  struct uet_pdc_key *key,
+					  u8 mode, u8 state)
+{
+	struct uet_ses_req_hdr *ses_req = pds_req_ses_req_hdr(skb);
+	struct uet_pds_req_hdr *req = pds_req_hdr(skb);
+
+	return uet_pdc_create(pds, be32_to_cpu(req->psn), state,
+			      be16_to_cpu(req->spdcid),
+			      uet_ses_req_pid_on_fep(ses_req),
+			      mode, 0, dport, key, true);
+}
+
+static int uet_pds_rx_req(struct uet_pds *pds, struct sk_buff *skb,
+			  __be32 local_fep_addr, __be32 remote_fep_addr,
+			  __be16 dport, __u8 tos)
+{
+	struct uet_ses_req_hdr *ses_req = pds_req_ses_req_hdr(skb);
+	struct uet_pds_req_hdr *pds_req = pds_req_hdr(skb);
+	u16 pdcid = be16_to_cpu(pds_req->dpdcid);
+	struct uet_pdc_key key = {};
+	struct uet_fep *fep;
+	struct uet_pdc *pdc;
+
+	key.src_ip = local_fep_addr;
+	key.dst_ip = remote_fep_addr;
+	key.job_id = uet_ses_req_job_id(ses_req);
+
+	pdc = rhashtable_lookup_fast(&pds->pdcid_hash, &pdcid,
+				     uet_pds_pdcid_rht_params);
+	/* new flow */
+	if (unlikely(!pdc)) {
+		struct uet_prologue_hdr *prologue = pds_prologue_hdr(skb);
+		struct uet_context *ctx;
+		struct uet_job *job;
+
+		if (!(uet_prologue_flags(prologue) & UET_PDS_REQ_FLAG_SYN))
+			return -EINVAL;
+
+		ctx = container_of(pds, struct uet_context, pds);
+		job = uet_job_find(&ctx->job_reg, key.job_id);
+		if (!job)
+			return -ENOENT;
+		fep = rcu_dereference(job->fep);
+		if (!fep)
+			return -ECONNREFUSED;
+		if (fep->addr.in_address.ip != local_fep_addr)
+			return -ENOENT;
+
+		pdc = uet_pds_new_pdc_rx(pds, skb, dport, &key,
+					 UET_PDC_MODE_RUD,
+					 UET_PDC_EP_STATE_NEW_ESTABLISHED);
+		if (IS_ERR(pdc))
+			return PTR_ERR(pdc);
+	}
+
+	return uet_pdc_rx_req(pdc, skb, remote_fep_addr, tos);
+}
+
+static bool uet_pds_rx_valid_req_next_hdr(const struct uet_prologue_hdr *prologue)
+{
+	switch (uet_prologue_next_hdr(prologue)) {
+	case UET_PDS_NEXT_HDR_REQ_STD:
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static bool uet_pds_rx_valid_ack_next_hdr(const struct uet_prologue_hdr *prologue)
+{
+	switch (uet_prologue_next_hdr(prologue)) {
+	case UET_PDS_NEXT_HDR_RSP:
+	case UET_PDS_NEXT_HDR_RSP_DATA:
+	case UET_PDS_NEXT_HDR_RSP_DATA_SMALL:
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 	       __be32 remote_fep_addr, __be16 dport, __u8 tos)
 {
+	struct uet_prologue_hdr *prologue;
+	unsigned int offset = 0;
+	int ret = -EINVAL;
+
 	if (!pskb_may_pull(skb, sizeof(struct uet_prologue_hdr)))
-		return -EINVAL;
+		return ret;
+
+	prologue = pds_prologue_hdr(skb);
+	switch (uet_prologue_type(prologue)) {
+	case UET_PDS_TYPE_ACK:
+		if (!uet_pds_rx_valid_ack_next_hdr(prologue))
+			break;
+		offset += sizeof(struct uet_pds_ack_hdr) +
+			  sizeof(struct uet_ses_rsp_hdr);
+		if (!pskb_may_pull(skb, offset))
+			break;
+
+		__net_timestamp(skb);
+		ret = uet_pds_rx_ack(pds, skb, local_fep_addr, remote_fep_addr);
+		break;
+	case UET_PDS_TYPE_RUD_REQ:
+		if (!uet_pds_rx_valid_req_next_hdr(prologue))
+			break;
+		offset = sizeof(struct uet_pds_ack_hdr) +
+			 sizeof(struct uet_ses_req_hdr);
+		if (!pskb_may_pull(skb, offset))
+			break;
+		ret = uet_pds_rx_req(pds, skb, local_fep_addr, remote_fep_addr,
+				     dport, tos);
+		break;
+	default:
+		break;
+	}
 
-	return 0;
+	return ret;
 }
diff --git a/include/net/ultraeth/uet_pdc.h b/include/net/ultraeth/uet_pdc.h
index 70f3c6aa03df..1a42647489fe 100644
--- a/include/net/ultraeth/uet_pdc.h
+++ b/include/net/ultraeth/uet_pdc.h
@@ -45,6 +45,12 @@ enum {
 	UET_PDC_MODE_UUD
 };
 
+enum mpr_pos {
+	UET_PDC_MPR_PREV,
+	UET_PDC_MPR_CUR,
+	UET_PDC_MPR_FUTURE
+};
+
 struct uet_pdc {
 	struct rhash_head pdcid_node;
 	struct rhash_head pdcep_node;
@@ -63,6 +69,9 @@ struct uet_pdc {
 	u8 mode;
 	bool is_initiator;
 
+	unsigned long *rx_bitmap;
+	unsigned long *ack_bitmap;
+
 	u32 rx_base_psn;
 	u32 tx_base_psn;
 
@@ -76,4 +85,33 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 			       const struct uet_pdc_key *key, bool is_inbound);
 void uet_pdc_destroy(struct uet_pdc *pdc);
 void uet_pdc_free(struct uet_pdc *pdc);
+int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
+		   __be32 remote_fep_addr, __u8 tos);
+int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
+		   __be32 remote_fep_addr);
+
+static inline void uet_pdc_build_prologue(struct uet_prologue_hdr *prologue,
+					  u8 type, u8 next, u8 flags)
+{
+	prologue->type_next_flags = cpu_to_be16((type & UET_PROLOGUE_TYPE_MASK) <<
+						UET_PROLOGUE_TYPE_SHIFT |
+						(next & UET_PROLOGUE_NEXT_MASK) <<
+						UET_PROLOGUE_NEXT_SHIFT |
+						(flags & UET_PROLOGUE_FLAGS_MASK));
+}
+
+static inline enum mpr_pos psn_mpr_pos(u32 base_psn, u32 psn)
+{
+	if (base_psn > psn)
+		return UET_PDC_MPR_PREV;
+	else if (psn - base_psn < UET_PDC_MPR)
+		return UET_PDC_MPR_CUR;
+	else
+		return UET_PDC_MPR_FUTURE;
+}
+
+static inline bool psn_bit_valid(u32 bit)
+{
+	return bit < UET_PDC_MPR;
+}
 #endif /* _UECON_PDC_H */
-- 
2.48.1


