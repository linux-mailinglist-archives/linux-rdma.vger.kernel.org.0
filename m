Return-Path: <linux-rdma+bounces-8452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79AA55A9C
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AC41897E61
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4FC27D789;
	Thu,  6 Mar 2025 23:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="dTEI3D0Z"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A273280A35
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302262; cv=none; b=AHIJ+cy3uqsgMwo0rUzADBC3D3wmGZF1poSc5t29V0EJ/mtQfG+JLVAx3Kf6gZVxeWPGYb2aStqgFxgtCPoxFhlzLQxFmzNfT8igTOkC+x089KzsJc1M6mcsrNlxvAg/2KqToIjLOUxOxb+2BNemOJ6TH9NvlXciAbuNpE0RLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302262; c=relaxed/simple;
	bh=yndAeAn2xqhE/kdxFO1U65LUqw0DkYwAykXl65heU9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHAmLcVZ0HEJ0NhiAhttz+rp7F0D59v9Lij13pOHj4rSmN+u7L8GIFPhiQog5U4DBFo6axuTo9smL1lyxzTcvROnnPS+8lkizTSNGjqr0nCNxVXd4tq7OrUPAaCfvge7AoHGX9Yvhv7KfaN9p/nE1dH/HK4rJutVXk171SCk4W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=dTEI3D0Z; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c3d591e50aso133957585a.0
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302258; x=1741907058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3PHcgpSmIYXkI7a7aJYg2x9bZpSnT5ilYLACdMs2bU=;
        b=dTEI3D0ZV7+PXNzoEaAJhfFWH81t3Q2/I0lPtjxyzxq0k87Dp4z+7Zcj2cyJyojpho
         mH98t2gYQ9o+BIZAwYZGQRX74AMmXhP6+HYHx6otc6u4UQ+NDsFgSa61gds/9/EjH0po
         vUzD+LzLCFKaUGdda53OoyvC/ssVIV7nW9WpAzMZLSE+K581Zb09Tazag7+xhKqqWkjk
         pE0yo/iDw0iynfSnwlU37q7kPC+GT3cQxtJTWodb/FAhgWBNY3C4uVINyMLOq3Y/9KTw
         5T1jihl058Sem/dPBdAlLSa9UnxMuZTgRhP4AMn2JkoYMt9B163uLrTBdxQaX9pNiEE7
         zxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302258; x=1741907058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3PHcgpSmIYXkI7a7aJYg2x9bZpSnT5ilYLACdMs2bU=;
        b=HJ9xnnWFwqyalEIQGgS8KKpoj1qz+8BNtEiJpHDo25QFPF5xjU3/MKOdzauwtARW8B
         m8qJG7O68ioMPVPVwK1KdVBL6heps1hHIqLqISvwMkuDfGf9W6BKzagIRfShegVRrzgY
         T+KoEeJezoxJHRYiXhJAh5VXlR0CLz9WVHF4dtgnHPcZZjKZFAU/XSJXiYu5dwRFtbfd
         cf/ZHxhrivMp7uRW+GR68yDpjMBJW6EO6RBBZjyReemgaXDD+WWw8xJrXJ5L8pMbqZf+
         8KKA/TTNzKvU75jt5KJQnAvu01xKiiUGt4kUmKudUD6GZjQKNqNkKicjcQWKZeWaBHza
         SkGw==
X-Forwarded-Encrypted: i=1; AJvYcCUAOqN3n3KIrmeYXaBrl7SxUpGQuKkwlcUGPv4PBTKqzx3lznwqwcIvZqMVjqRPUNTGKodDPDkfR1Dp@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3mX/n/OgZ0Di2O4XKEkr6t1nqDq3VC4YSqUkMiJQl/YghsI1
	kycmJlnEFlw65SAACEsGDT94WO/dnbojVeCKk7FSwEB+28R1v5Ufa6bz3y5rSbg=
X-Gm-Gg: ASbGncsSmt+XgZ8gKXeDSlfi4Z+sjBD6c5umgZjAG2huYU68ykhLizAIAHWXFKtUb3O
	r99ytl1zTB51M+iIif7dsJ2eUKOo7dkarxaaQl0sdkzA6JHenbDQn8NWofUQXmEc2Dt4drvAyn3
	tpzyq7i1qmeiyF+whuTpFCeqTGjO+nv4a8xSCir5kddUuR1w8bpKRF3x8G2U2HWNnVg73FYg+Jd
	Wut5UzGKS6ULDQ4xHIbGfvp8K8t62USqNjwhKd6IBxa+WfsH2tso0F3XGurVYdJleIlTJ2xv3Ou
	ZBAiV/j1/kgBvLnFvbAkwl1pLhfwtds5GPI+Mi0nNgqW/qkzQ/SIy0b+fmMt5HkspFVw
X-Google-Smtp-Source: AGHT+IEP6gNfr2d6Yjp8CS+OJ5EZK0Vk3IFPkEP7ZiqxgMfDyCp/7Wk5kV7i1EgxyX2bXgdbhi2zEQ==
X-Received: by 2002:a05:6214:2428:b0:6e8:f166:b19c with SMTP id 6a1803df08f44-6e900695416mr14903086d6.41.1741302258461;
        Thu, 06 Mar 2025 15:04:18 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:17 -0800 (PST)
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
Subject: [RFC PATCH 11/13] drivers: ultraeth: add nack support
Date: Fri,  7 Mar 2025 01:02:01 +0200
Message-ID: <20250306230203.1550314-12-nikolay@enfabrica.net>
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

Add nack header format with codes and helpers which allow sending of NACKs,
they construct the NACK packet dynamically and don't rely on a pre-existing
PDC.  Send back NACK packets if an error occurred when receiving a request.
The following events trigger NACKs:
 - DPDCID not found and SYN not set (UET_PDS_NACK_INV_DPDCID)
 - DPDCID not found and job/fep are invalid (UET_PDS_NACK_NO_RESOURCE)
 - DPDCID not found and local FEP address mismatches
   (UET_PDS_NACK_PDC_HDR_MISMATCH)
 - DPDCID is found but mode doesn't match
   (UET_PDS_NACK_PDC_MODE_MISMATCH)
 - DPDCID is found but PSN is wrong (UET_PDS_NACK_PSN_OOR_WINDOW or
   UET_PDS_NACK_INVALID_SYN if packet is with SYN)

Process received PDC_FATAL NACKs, the rest are silently ignored.

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/ultraeth/uet_pdc.c     | 79 ++++++++++++++++++++++++++--
 drivers/ultraeth/uet_pds.c     | 95 ++++++++++++++++++++++++++++++++--
 include/net/ultraeth/uet_pdc.h |  3 ++
 include/net/ultraeth/uet_pds.h | 10 ++++
 include/uapi/linux/ultraeth.h  | 55 ++++++++++++++++++++
 5 files changed, 235 insertions(+), 7 deletions(-)

diff --git a/drivers/ultraeth/uet_pdc.c b/drivers/ultraeth/uet_pdc.c
index e9469edd9014..4f19bc68b570 100644
--- a/drivers/ultraeth/uet_pdc.c
+++ b/drivers/ultraeth/uet_pdc.c
@@ -6,6 +6,21 @@
 #include <net/ultraeth/uet_context.h>
 #include <net/ultraeth/uet_pdc.h>
 
+struct metadata_dst *uet_pdc_dst(const struct uet_pdc_key *key, __be16 dport,
+				 u8 tos)
+{
+	IP_TUNNEL_DECLARE_FLAGS(md_flags) = { };
+	struct metadata_dst *mdst;
+
+	mdst = __ip_tun_set_dst(key->src_ip, key->dst_ip, tos, 0, dport,
+				md_flags, 0, 0);
+	if (!mdst)
+		return NULL;
+	mdst->u.tun_info.mode |= IP_TUNNEL_INFO_TX;
+
+	return mdst;
+}
+
 static void uet_pdc_xmit(struct uet_pdc *pdc, struct sk_buff *skb)
 {
 	skb->dev = pds_netdev(pdc->pds);
@@ -241,7 +256,6 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 			       const struct uet_pdc_key *key, bool is_inbound)
 {
 	struct uet_pdc *pdc, *pdc_ins = ERR_PTR(-ENOMEM);
-	IP_TUNNEL_DECLARE_FLAGS(md_flags) = { };
 	int ret __maybe_unused;
 
 	switch (mode) {
@@ -287,8 +301,7 @@ struct uet_pdc *uet_pdc_create(struct uet_pds *pds, u32 rx_base_psn, u8 state,
 	if (!pdc->ack_bitmap)
 		goto err_ack_bitmap;
 	timer_setup(&pdc->rtx_timer, uet_pdc_rtx_timer_expired, 0);
-	pdc->metadata = __ip_tun_set_dst(key->src_ip, key->dst_ip, tos, 0, dport,
-					 md_flags, 0, 0);
+	pdc->metadata = uet_pdc_dst(key, dport, tos);
 	if (!pdc->metadata)
 		goto err_tun_dst;
 
@@ -731,6 +744,19 @@ static void uet_pdc_rx_req_handle_ack(struct uet_pdc *pdc, unsigned int len,
 	}
 }
 
+static bool uet_pdc_req_validate_mode(const struct uet_pdc *pdc,
+				      const struct uet_pds_req_hdr *req)
+{
+	switch (uet_prologue_type(&req->prologue)) {
+	case UET_PDS_TYPE_RUD_REQ:
+		return pdc->mode == UET_PDC_MODE_RUD;
+	case UET_PDS_TYPE_ROD_REQ:
+		return pdc->mode == UET_PDC_MODE_ROD;
+	}
+
+	return false;
+}
+
 int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 		   __be32 remote_fep_addr, __u8 tos)
 {
@@ -743,6 +769,7 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 	unsigned int len = skb->len;
 	bool first_ack = false;
 	enum mpr_pos psn_pos;
+	__u8 nack_code = 0;
 	int ret = -EINVAL;
 
 	spin_lock(&pdc->lock);
@@ -761,6 +788,11 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 
 	if (unlikely(pdc->tx_busy))
 		goto err_dbg;
+	if (!uet_pdc_req_validate_mode(pdc, req)) {
+		drop_reason = "pdc mode doesn't match request";
+		nack_code = UET_PDS_NACK_PDC_MODE_MISMATCH;
+		goto err_dbg;
+	}
 
 	if (req_flags & UET_PDS_REQ_FLAG_RETX)
 		ack_flags |= UET_PDS_ACK_FLAG_RETX;
@@ -770,10 +802,15 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 	switch (psn_pos) {
 	case UET_PDC_MPR_FUTURE:
 		drop_reason = "req psn is in a future MPR window";
+		if (req_flags & UET_PDS_REQ_FLAG_SYN)
+			nack_code = UET_PDS_NACK_INVALID_SYN;
+		else
+			nack_code = UET_PDS_NACK_PSN_OOR_WINDOW;
 		goto err_dbg;
 	case UET_PDC_MPR_PREV:
 		if ((int)(req_psn - pdc->rx_base_psn) < S16_MIN) {
 			drop_reason = "req psn is too far in the past";
+			nack_code = UET_PDS_NACK_PSN_OOR_WINDOW;
 			goto err_dbg;
 		}
 		uet_pdc_send_ses_ack(pdc, UET_SES_RSP_RC_NULL, ses_req->msg_id,
@@ -805,6 +842,7 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 
 			if (!psn_bit_valid(psn_bit)) {
 				drop_reason = "req psn bit is invalid";
+				nack_code = UET_PDS_NACK_PSN_OOR_WINDOW;
 				goto err_dbg;
 			}
 			if (test_and_set_bit(psn_bit, pdc->rx_bitmap)) {
@@ -844,5 +882,40 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 		  pdc->state, pdc->dpdcid, pdc->spdcid,
 		  be16_to_cpu(ses_req->msg_id), be32_to_cpu(req->psn),
 		  be16_to_cpu(req->spdcid), be16_to_cpu(req->dpdcid));
+
+	if (nack_code)
+		uet_pds_send_nack(pdc->pds, &pdc->key,
+				  pdc->metadata->u.tun_info.key.tp_dst, 0,
+				  cpu_to_be16(pdc->spdcid),
+				  cpu_to_be16(pdc->dpdcid),
+				  nack_code, req->psn,
+				  pds_req_to_nack_flags(req_flags));
 	goto out;
 }
+
+void uet_pdc_rx_nack(struct uet_pdc *pdc, struct sk_buff *skb)
+{
+	struct uet_pds_nack_hdr *nack = pds_nack_hdr(skb);
+	u32 nack_psn = be32_to_cpu(nack->nack_psn_pkt_id);
+
+	spin_lock(&pdc->lock);
+	netdev_dbg(pds_netdev(pdc->pds), "%s: NACK pdc: [ spdcid: %u dpdcid: %u rx_base_psn %u ] "
+					 "nack header: [ nack_code: %u vendor_code: %u nack_psn: %u ]\n",
+		   __func__, pdc->spdcid, pdc->dpdcid, pdc->rx_base_psn,
+		   nack->nack_code, nack->vendor_code, nack_psn);
+	if (psn_mpr_pos(pdc->rx_base_psn, nack_psn) != UET_PDC_MPR_CUR)
+		goto out;
+	switch (nack->nack_code) {
+	/* PDC_FATAL codes */
+	case UET_PDS_NACK_CLOSING_IN_ERR:
+	case UET_PDS_NACK_INV_DPDCID:
+	case UET_PDS_NACK_NO_RESOURCE:
+	case UET_PDS_NACK_PDC_HDR_MISMATCH:
+	case UET_PDS_NACK_INVALID_SYN:
+	case UET_PDS_NACK_PDC_MODE_MISMATCH:
+		uet_pdc_destroy(pdc);
+		break;
+	}
+out:
+	spin_unlock(&pdc->lock);
+}
diff --git a/drivers/ultraeth/uet_pds.c b/drivers/ultraeth/uet_pds.c
index 436b63189800..c144b6df8327 100644
--- a/drivers/ultraeth/uet_pds.c
+++ b/drivers/ultraeth/uet_pds.c
@@ -149,6 +149,46 @@ void uet_pds_clean_job(struct uet_pds *pds, u32 job_id)
 	rhashtable_walk_exit(&iter);
 }
 
+static void uet_pds_build_nack(struct sk_buff *skb, __be16 spdcid, __be16 dpdcid,
+			       u8 nack_code, __be32 nack_psn, u8 flags)
+{
+	struct uet_pds_nack_hdr *nack = skb_put(skb, sizeof(*nack));
+
+	uet_pdc_build_prologue(&nack->prologue, UET_PDS_TYPE_NACK,
+			       UET_PDS_NEXT_HDR_NONE, flags);
+	nack->nack_code = nack_code;
+	nack->vendor_code = 0;
+	nack->nack_psn_pkt_id = nack_psn;
+	nack->spdcid = spdcid;
+	nack->dpdcid = dpdcid;
+	nack->payload = 0;
+}
+
+void uet_pds_send_nack(struct uet_pds *pds, const struct uet_pdc_key *key,
+		       __be16 dport, u8 tos, __be16 spdcid, __be16 dpdcid,
+		       __u8 nack_code, __be32 nack_psn, __u8 flags)
+{
+	struct metadata_dst *mdst;
+	struct sk_buff *skb;
+
+	if (WARN_ON_ONCE(!key))
+		return;
+
+	skb = alloc_skb(sizeof(struct uet_pds_nack_hdr), GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	skb->dev = pds_netdev(pds);
+	uet_pds_build_nack(skb, spdcid, dpdcid, nack_code, nack_psn, flags);
+	mdst = uet_pdc_dst(key, dport, tos);
+	if (!mdst) {
+		kfree_skb(skb);
+		return;
+	}
+	skb_dst_set(skb, &mdst->dst);
+	dev_queue_xmit(skb);
+}
+
 static int uet_pds_rx_ack(struct uet_pds *pds, struct sk_buff *skb,
 			  __be32 local_fep_addr, __be32 remote_fep_addr)
 {
@@ -164,6 +204,20 @@ static int uet_pds_rx_ack(struct uet_pds *pds, struct sk_buff *skb,
 	return uet_pdc_rx_ack(pdc, skb, remote_fep_addr);
 }
 
+static void uet_pds_rx_nack(struct uet_pds *pds, struct sk_buff *skb)
+{
+	struct uet_pds_nack_hdr *nack = pds_nack_hdr(skb);
+	u16 pdcid = be16_to_cpu(nack->dpdcid);
+	struct uet_pdc *pdc;
+
+	pdc = rhashtable_lookup_fast(&pds->pdcid_hash, &pdcid,
+				     uet_pds_pdcid_rht_params);
+	if (!pdc)
+		return;
+
+	uet_pdc_rx_nack(pdc, skb);
+}
+
 static struct uet_pdc *uet_pds_new_pdc_rx(struct uet_pds *pds,
 					  struct sk_buff *skb,
 					  __be16 dport, u32 ack_gen_trigger,
@@ -201,21 +255,45 @@ static int uet_pds_rx_req(struct uet_pds *pds, struct sk_buff *skb,
 	/* new flow */
 	if (unlikely(!pdc)) {
 		struct uet_prologue_hdr *prologue = pds_prologue_hdr(skb);
+		__u8 req_flags = uet_prologue_flags(prologue);
 		struct uet_context *ctx;
 		struct uet_job *job;
 
-		if (!(uet_prologue_flags(prologue) & UET_PDS_REQ_FLAG_SYN))
+		if (!(uet_prologue_flags(prologue) & UET_PDS_REQ_FLAG_SYN)) {
+			uet_pds_send_nack(pds, &key, dport, 0, 0,
+					  pds_req->spdcid,
+					  UET_PDS_NACK_INV_DPDCID, pds_req->psn,
+					  pds_req_to_nack_flags(req_flags));
 			return -EINVAL;
+		}
 
 		ctx = container_of(pds, struct uet_context, pds);
 		job = uet_job_find(&ctx->job_reg, key.job_id);
-		if (!job)
+		if (!job) {
+			uet_pds_send_nack(pds, &key, dport, 0, 0,
+					  pds_req->spdcid,
+					  UET_PDS_NACK_NO_RESOURCE,
+					  pds_req->psn,
+					  pds_req_to_nack_flags(req_flags));
 			return -ENOENT;
+		}
 		fep = rcu_dereference(job->fep);
-		if (!fep)
+		if (!fep) {
+			uet_pds_send_nack(pds, &key, dport, 0, 0,
+					  pds_req->spdcid,
+					  UET_PDS_NACK_NO_RESOURCE,
+					  pds_req->psn,
+					  pds_req_to_nack_flags(req_flags));
 			return -ECONNREFUSED;
-		if (fep->addr.in_address.ip != local_fep_addr)
+		}
+		if (fep->addr.in_address.ip != local_fep_addr) {
+			uet_pds_send_nack(pds, &key, dport, 0, 0,
+					  pds_req->spdcid,
+					  UET_PDS_NACK_PDC_HDR_MISMATCH,
+					  pds_req->psn,
+					  pds_req_to_nack_flags(req_flags));
 			return -ENOENT;
+		}
 
 		pdc = uet_pds_new_pdc_rx(pds, skb, dport, fep->ack_gen_trigger,
 					 fep->ack_gen_min_pkt_add, &key,
@@ -290,6 +368,15 @@ int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 		ret = uet_pds_rx_req(pds, skb, local_fep_addr, remote_fep_addr,
 				     dport, tos);
 		break;
+	case UET_PDS_TYPE_NACK:
+		if (uet_prologue_next_hdr(prologue) != UET_PDS_NEXT_HDR_NONE)
+			break;
+		offset += sizeof(struct uet_pds_nack_hdr);
+		if (!pskb_may_pull(skb, offset))
+			break;
+		ret = 0;
+		uet_pds_rx_nack(pds, skb);
+		break;
 	default:
 		break;
 	}
diff --git a/include/net/ultraeth/uet_pdc.h b/include/net/ultraeth/uet_pdc.h
index d6710f92fb16..60aecc15d0f1 100644
--- a/include/net/ultraeth/uet_pdc.h
+++ b/include/net/ultraeth/uet_pdc.h
@@ -120,6 +120,9 @@ int uet_pdc_rx_req(struct uet_pdc *pdc, struct sk_buff *skb,
 int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 		   __be32 remote_fep_addr);
 int uet_pdc_tx_req(struct uet_pdc *pdc, struct sk_buff *skb, u8 type);
+void uet_pdc_rx_nack(struct uet_pdc *pdc, struct sk_buff *skb);
+struct metadata_dst *uet_pdc_dst(const struct uet_pdc_key *key, __be16 dport,
+				 u8 tos);
 
 static inline void uet_pdc_build_prologue(struct uet_prologue_hdr *prologue,
 					  u8 type, u8 next, u8 flags)
diff --git a/include/net/ultraeth/uet_pds.h b/include/net/ultraeth/uet_pds.h
index 78624370f18c..4e9794a4d3de 100644
--- a/include/net/ultraeth/uet_pds.h
+++ b/include/net/ultraeth/uet_pds.h
@@ -7,6 +7,7 @@
 #include <linux/rhashtable.h>
 #include <uapi/linux/ultraeth.h>
 #include <linux/skbuff.h>
+#include <net/ultraeth/uet_pdc.h>
 
 /**
  * struct uet_pds - Packet Delivery Sublayer state structure
@@ -43,6 +44,10 @@ int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 int uet_pds_tx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 	       __be32 remote_fep_addr, __be16 dport, u32 job_id);
 
+void uet_pds_send_nack(struct uet_pds *pds, const struct uet_pdc_key *key,
+		       __be16 dport, u8 tos, __be16 spdcid, __be16 dpdcid,
+		       __u8 nack_code, __be32 nack_psn, __u8 flags);
+
 static inline struct uet_prologue_hdr *pds_prologue_hdr(const struct sk_buff *skb)
 {
 	return (struct uet_prologue_hdr *)skb_network_header(skb);
@@ -92,4 +97,9 @@ static inline __be16 pds_ses_rsp_hdr_pack(__u8 opcode, __u8 version, __u8 list,
 			   (ses_rc & UET_SES_RSP_RC_MASK) <<
 			   UET_SES_RSP_RC_SHIFT);
 }
+
+static inline __u8 pds_req_to_nack_flags(__u8 req_flags)
+{
+	return req_flags & UET_PDS_REQ_FLAG_RETX ? UET_PDS_NACK_FLAG_RETX : 0;
+}
 #endif /* _UECON_PDS_H */
diff --git a/include/uapi/linux/ultraeth.h b/include/uapi/linux/ultraeth.h
index 3b8e95d7ed7b..53d2124bc285 100644
--- a/include/uapi/linux/ultraeth.h
+++ b/include/uapi/linux/ultraeth.h
@@ -192,6 +192,61 @@ static inline __u8 uet_pds_ack_ext_cc_type(const struct uet_pds_ack_ext_hdr *ack
 	       UET_PDS_ACK_EXT_CC_TYPE_MASK;
 }
 
+/* NACK codes */
+enum {
+	UET_PDS_NACK_TRIMMED		= 0x01,
+	UET_PDS_NACK_TRIMMED_LASTHOP	= 0x02,
+	UET_PDS_NACK_TRIMMED_ACK	= 0x03,
+	UET_PDS_NACK_NO_PDC_AVAIL	= 0x04,
+	UET_PDS_NACK_NO_CCC_AVAIL	= 0x05,
+	UET_PDS_NACK_NO_BITMAP		= 0x06,
+	UET_PDS_NACK_NO_PKT_BUFFER	= 0x07,
+	UET_PDS_NACK_NO_GTD_DEL_AVAIL	= 0x08,
+	UET_PDS_NACK_NO_SES_MSG_AVAIL	= 0x09,
+	UET_PDS_NACK_NO_RESOURCE	= 0x0A,
+	UET_PDS_NACK_PSN_OOR_WINDOW	= 0x0B,
+	UET_PDS_NACK_FIRST_ROD_OOO	= 0x0C,
+	UET_PDS_NACK_ROD_OOO		= 0x0D,
+	UET_PDS_NACK_INV_DPDCID		= 0x0E,
+	UET_PDS_NACK_PDC_HDR_MISMATCH	= 0x0F,
+	UET_PDS_NACK_CLOSING		= 0x10,
+	UET_PDS_NACK_CLOSING_IN_ERR	= 0x11,
+	UET_PDS_NACK_PKT_NOT_RCVD	= 0x12,
+	UET_PDS_NACK_GTD_RESP_UNAVAIL	= 0x13,
+	UET_PDS_NACK_ACK_WITH_DATA	= 0x14,
+	UET_PDS_NACK_INVALID_SYN	= 0x15,
+	UET_PDS_NACK_PDC_MODE_MISMATCH	= 0x16,
+	UET_PDS_NACK_NEW_START_PSN	= 0x17,
+	UET_PDS_NACK_RCVD_SES_PROCG	= 0x18,
+	UET_PDS_NACK_UNEXP_EVENT	= 0x19,
+	UET_PDS_NACK_RCVR_INFER_LOSS	= 0x1A,
+	/* 0x1B - 0xFC reserved for UET */
+	UET_PDS_NACK_EXP_NACK_NORMAL	= 0xFD,
+	UET_PDS_NACK_T_EXP_NACK_ERR	= 0xFE,
+	UET_PDS_NACK_EXP_NACK_FATAL	= 0xFF
+};
+
+/* NACK flags */
+enum {
+	UET_PDS_NACK_FLAG_RSV21	= (1 << 0),
+	UET_PDS_NACK_FLAG_RSV22	= (1 << 1),
+	UET_PDS_NACK_FLAG_RSV23	= (1 << 2),
+	UET_PDS_NACK_FLAG_NT	= (1 << 3),
+	UET_PDS_NACK_FLAG_RETX	= (1 << 4),
+	UET_PDS_NACK_FLAG_M	= (1 << 5),
+	UET_PDS_NACK_FLAG_RSV	= (1 << 6)
+};
+
+struct uet_pds_nack_hdr {
+	struct uet_prologue_hdr prologue;
+	__u8 nack_code;
+	__u8 vendor_code;
+	__be32 nack_psn_pkt_id;
+	__be16 spdcid;
+	__be16 dpdcid;
+	__be32 payload;
+} __attribute__ ((__packed__));
+
 /* ses request op codes */
 enum {
 	UET_SES_REQ_OP_NOOP			= 0x00,
-- 
2.48.1


