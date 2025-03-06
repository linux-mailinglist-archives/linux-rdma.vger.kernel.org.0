Return-Path: <linux-rdma+bounces-8451-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE29A55A9B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 00:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A92787A8AED
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 23:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F7280A20;
	Thu,  6 Mar 2025 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b="S7PASkt1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB61C2803F6
	for <linux-rdma@vger.kernel.org>; Thu,  6 Mar 2025 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741302259; cv=none; b=kypLc2B2XImWauF5nlPrD9QCeSD9uAbhmFXUTU7NTnBHY+bAP3k2YwlUdPk2fI2gtCzinJocSm7MZqmliOqFnkC97MBmXEe/UFIvtuRKG27anYZm5sji7biKJkVk5yrRda1dOtVpll6QX56mWeW9HhpzwTO4e5BjTead/c5OcGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741302259; c=relaxed/simple;
	bh=8zoJVMPNc2FcN+4s7xjapXpTwku8ERNAOulLVuTwkis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7Lyk2WkSHY2v3aVJCG6ia0k5ngkXfeJFGEd6n7lTJuV6ND6NQASX4Jij7fsIOx3TjYHSmgCHhw2YNot2UkMf7lTRfu1iA232vvP8m9TYPKbSqTmYiH7p8RUdfflpZgLQRFvk9RfYPCEfzTYRvER/6oEGSMdx9eyJrl+hCPN+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net; spf=pass smtp.mailfrom=enfabrica.net; dkim=pass (2048-bit key) header.d=enfabrica.net header.i=@enfabrica.net header.b=S7PASkt1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enfabrica.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enfabrica.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e41e17645dso11440196d6.2
        for <linux-rdma@vger.kernel.org>; Thu, 06 Mar 2025 15:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=enfabrica.net; s=google; t=1741302257; x=1741907057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iK4c5koKFv1LWAiQEBPg2eanOfUAKl1IQ+bM1zpj/YY=;
        b=S7PASkt1v+wU1hrJp67RK/pmk+ULSaNnddrZa6vZENx9B1mCbDnEC+SNeay2fhmjUx
         PuHEInp63tNXRrZjMK6HZDGNQ3xmF3pm795M9IgB5nbtoZDtocP+W/4KndeDQ+5obMOW
         eYxJqErfQbgZ+ljOEbCJ42zEP0S7fkHgi9oj9zQiLAOuqoqZFUHdGypqR4j2wNGvsdjf
         Dibltc3wL77IXhsrW/XnAJf9AoN9J+j4095XiPHdHeOuHZ7DfF8cmiVxSvYWjsLDjnP0
         zcyVR0uBViyGX2NewdzoHiecTAYPQPD1qROi35LLJD2E3mXALJYVd1Fu7E49Zfbqnv3r
         /h+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741302257; x=1741907057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iK4c5koKFv1LWAiQEBPg2eanOfUAKl1IQ+bM1zpj/YY=;
        b=UODweZGG1j08uONCtdmFoQCWWOk+FMy+Lbr8AuP5s6eOWwwuFv5ydf/aVxzxVa5heX
         hFwe3/S+GNtvf4zZbHkLXb/DQCQqDpAynvAhIyL7T2IeX+qq5Yp3zWhoITqi3RCrtLuL
         Ju6TvaMbNWTnct2NTEI4RfbfBGz2Fthqgwm+hgMP7tXzvkmog23V9rf1qvzklurQ9B9B
         27D1gHBOXIzaepQyX2X3kSjMzvr7TCDbSjajZb+STWZ2jx7p1WvFedzKOUfBvuGpG5pQ
         3t9C/MvG3LsIw25tDpuMyfhlMkOLuczuNB9UCBzpe5pKMC6vrUdHLCfaWIXTHpC3N63V
         KImw==
X-Forwarded-Encrypted: i=1; AJvYcCWkq+9/wOyKvpHgLvSzfOa8pB6wjG2b2PuoyXHSUEUXTWMU4NyKNbCJNUOO6gxF0+jfkjLK/AB5LDxK@vger.kernel.org
X-Gm-Message-State: AOJu0YxZwuk5lYtQ8wLUe8AIIul4lF6xOERYMzFkZOJiLo2iCdRlTiVG
	Kr+yPCe4RRUYWeQzJjMHDSOkMqWBe0hpsRiffK6GY415CbQpwbShn8C7+BXOPA8=
X-Gm-Gg: ASbGncsTc8QDDd5DQLN9zdCH/1F+pffLhsaBWvbCTFsJNvP3a70eSRlPJf5CCKx8ttZ
	bSkGPsj1vKPQ+ijJwjR/Q4fgo7QXd7K3C5rjLnbpO5jc57/SpmYHEFcVsHTbJ5Yf2I53NktHYtq
	KBFbRzRc2nbNr9tiA2DOm8O0Cnc1JZdSZItxicGEeoMAmsceFdsLu1yaVG5OMhAPH7phqlzWpLl
	bncV6dlh9q60pDpIMyXMW9RivkbFf0lJ9iChfeVGvEyLZbytBxKlHrx/gPptGVdbZrnT6EKzXSG
	h79cvd8i5mT0kc/7SuIb70+LtdVWoBrHUCiERJOOWhuCpPVodcuSYC5qb/pHNyA2JjIz
X-Google-Smtp-Source: AGHT+IHxTfaUjmuCoF7ih1GrTDipQZTYiCzwagxprA1b0yB9ai/NIjpk6yNwjcfOnnxMdiGhDrPEYQ==
X-Received: by 2002:ad4:5beb:0:b0:6e8:ed7f:1a79 with SMTP id 6a1803df08f44-6e9006773e7mr18910576d6.32.1741302256701;
        Thu, 06 Mar 2025 15:04:16 -0800 (PST)
Received: from debil.. (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac256654fa6sm14971966b.93.2025.03.06.15.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:04:16 -0800 (PST)
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
Subject: [RFC PATCH 10/13] drivers: ultraeth: add sack support
Date: Fri,  7 Mar 2025 01:02:00 +0200
Message-ID: <20250306230203.1550314-11-nikolay@enfabrica.net>
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

Add SACK support, we choose to send SACK (and extended header) when we
have to send an ACK but cannot advance CACK. The logic is a bit
complicated because the spec says we have to align CACK and SACK_BASE to
8 which could effectively move CACK back so we have to fill in for those
bits as 1s in the SACK bitmap

Signed-off-by: Nikolay Aleksandrov <nikolay@enfabrica.net>
Signed-off-by: Alex Badea <alex.badea@keysight.com>
---
 drivers/ultraeth/uet_pdc.c     | 100 ++++++++++++++++++++++++++++++---
 drivers/ultraeth/uet_pds.c     |   3 +
 include/net/ultraeth/uet_pdc.h |  10 ++++
 include/uapi/linux/ultraeth.h  |  40 +++++++++++++
 4 files changed, 146 insertions(+), 7 deletions(-)

diff --git a/drivers/ultraeth/uet_pdc.c b/drivers/ultraeth/uet_pdc.c
index 55b893ac5479..e9469edd9014 100644
--- a/drivers/ultraeth/uet_pdc.c
+++ b/drivers/ultraeth/uet_pdc.c
@@ -401,13 +401,55 @@ static int uet_pdc_build_req(struct uet_pdc *pdc,
 	return 0;
 }
 
+static void pdc_build_sack(struct uet_pdc *pdc,
+			   struct uet_pds_ack_ext_hdr *ack_ext)
+{
+	u32 sack_base = pdc->lowest_unack_psn, shift;
+	unsigned long bit, start_bit;
+	s16 sack_psn_offset;
+	u64 sack_bitmap;
+
+	if (sack_base + UET_PDC_SACK_BITS > pdc->max_rcv_psn)
+		sack_base = max(pdc->max_rcv_psn - UET_PDC_SACK_BITS,
+				pdc->rx_base_psn);
+	sack_base &= UET_PDC_SACK_MASK;
+	sack_psn_offset = (s16)(sack_base -
+				(pdc->rx_base_psn & UET_PDC_SACK_MASK));
+	if (sack_base == pdc->rx_base_psn) {
+		shift = 1;
+		sack_bitmap = 1;
+		bit = 0;
+	} else if (sack_base < pdc->rx_base_psn) {
+		shift = pdc->rx_base_psn - sack_base;
+		sack_bitmap = U64_MAX >> (64 - shift);
+		bit = 0;
+	} else {
+		shift = 0;
+		sack_bitmap = 0;
+		bit = sack_base - pdc->rx_base_psn;
+	}
+
+	start_bit = bit;
+	for_each_set_bit_from(bit, pdc->rx_bitmap, UET_PDC_MPR) {
+		shift += (bit - start_bit);
+		if (shift >= UET_PDC_SACK_BITS)
+			break;
+		sack_bitmap |= BIT(shift);
+	}
+
+	pdc->lowest_unack_psn += UET_PDC_SACK_BITS;
+	ack_ext->sack_psn_offset = cpu_to_be16(sack_psn_offset);
+	ack_ext->sack_bitmap = cpu_to_be64(sack_bitmap);
+}
+
 static void pdc_build_ack(struct uet_pdc *pdc, struct sk_buff *skb, u32 psn,
 			  u8 ack_flags, bool exact_psn)
 {
+	u8 type = pdc_should_sack(pdc) ? UET_PDS_TYPE_ACK_CC : UET_PDS_TYPE_ACK;
 	struct uet_pds_ack_hdr *ack = skb_put(skb, sizeof(*ack));
 
-	uet_pdc_build_prologue(&ack->prologue, UET_PDS_TYPE_ACK,
-			       UET_PDS_NEXT_HDR_RSP, ack_flags);
+	uet_pdc_build_prologue(&ack->prologue, type, UET_PDS_NEXT_HDR_RSP,
+			       ack_flags);
 	if (exact_psn) {
 		ack->ack_psn_offset = 0;
 		ack->cack_psn = cpu_to_be32(psn);
@@ -417,6 +459,13 @@ static void pdc_build_ack(struct uet_pdc *pdc, struct sk_buff *skb, u32 psn,
 	}
 	ack->spdcid = cpu_to_be16(pdc->spdcid);
 	ack->dpdcid = cpu_to_be16(pdc->dpdcid);
+
+	if (pdc_should_sack(pdc)) {
+		struct uet_pds_ack_ext_hdr *ack_ext = skb_put(skb,
+							      sizeof(*ack_ext));
+
+		pdc_build_sack(pdc, ack_ext);
+	}
 }
 
 static void uet_pdc_build_ses_ack(struct uet_pdc *pdc, struct sk_buff *skb,
@@ -439,10 +488,12 @@ static void uet_pdc_build_ses_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 static int uet_pdc_send_ses_ack(struct uet_pdc *pdc, __u8 ses_rc, __be16 msg_id,
 				u32 psn, u8 ack_flags, bool exact_psn)
 {
+	unsigned int skb_size = sizeof(struct uet_ses_rsp_hdr) +
+				sizeof(struct uet_pds_ack_hdr);
 	struct sk_buff *skb;
 
-	skb = alloc_skb(sizeof(struct uet_ses_rsp_hdr) +
-			sizeof(struct uet_pds_ack_hdr), GFP_ATOMIC);
+	skb_size += pdc_should_sack(pdc) ? sizeof(struct uet_pds_ack_ext_hdr) : 0;
+	skb = alloc_skb(skb_size, GFP_ATOMIC);
 	if (!skb)
 		return -ENOBUFS;
 
@@ -514,6 +565,30 @@ int uet_pdc_tx_req(struct uet_pdc *pdc, struct sk_buff *skb, u8 type)
 	return ret;
 }
 
+static void uet_pdc_rx_sack(struct uet_pdc *pdc, struct sk_buff *skb,
+			    u32 cack_psn, struct uet_pds_ack_ext_hdr *ext_ack,
+			    bool ecn_marked)
+{
+	unsigned long bit, *sack_bitmap = (unsigned long *)&ext_ack->sack_bitmap;
+	u32 sack_base_psn = cack_psn +
+			    (s16)be16_to_cpu(ext_ack->sack_psn_offset);
+
+	while ((bit = find_next_bit(sack_bitmap, 64, 0)) != 64) {
+		/* skip bits that were already acked */
+		if (sack_base_psn + bit <= pdc->tx_base_psn) {
+			if (sack_base_psn + bit == pdc->tx_base_psn)
+				__uet_pdc_mpr_advance_tx(pdc, 1);
+			continue;
+		}
+		if (!psn_bit_valid((sack_base_psn + bit) - pdc->tx_base_psn))
+			break;
+		if (test_and_set_bit((sack_base_psn + bit) - pdc->tx_base_psn,
+				     pdc->ack_bitmap))
+			continue;
+		uet_pdc_ack_psn(pdc, skb, sack_base_psn + bit, ecn_marked);
+	}
+}
+
 int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 		   __be32 remote_fep_addr)
 {
@@ -521,10 +596,11 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 	struct uet_pds_ack_hdr *ack = pds_ack_hdr(skb);
 	s16 ack_psn_offset = be16_to_cpu(ack->ack_psn_offset);
 	const char *drop_reason = "ack_psn not in MPR window";
+	struct uet_pds_ack_ext_hdr *ext_ack = NULL;
 	u32 cack_psn = be32_to_cpu(ack->cack_psn);
 	u32 ack_psn = cack_psn + ack_psn_offset;
+	bool is_sack = false, ecn_marked;
 	int ret = -EINVAL;
-	bool ecn_marked;
 	u32 psn_bit;
 
 	spin_lock(&pdc->lock);
@@ -545,9 +621,16 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 		drop_reason = "ack_psn bit is invalid";
 		goto err_dbg;
 	}
+	if (uet_prologue_type(&ack->prologue) == UET_PDS_TYPE_ACK_CC) {
+		ext_ack = pds_ack_ext_hdr(skb);
+		is_sack = !!ext_ack->sack_bitmap;
+	}
 	if (test_and_set_bit(psn_bit, pdc->ack_bitmap)) {
-		drop_reason = "ack_psn bit already set in ack_bitmap";
-		goto err_dbg;
+		/* SACK packets can include already acked packets */
+		if (!is_sack) {
+			drop_reason = "ack_psn bit already set in ack_bitmap";
+			goto err_dbg;
+		}
 	}
 
 	/* either using ROD mode or in SYN_SENT state */
@@ -573,6 +656,9 @@ int uet_pdc_rx_ack(struct uet_pdc *pdc, struct sk_buff *skb,
 	if (cack_psn != ack_psn)
 		uet_pdc_ack_psn(pdc, skb, ack_psn, ecn_marked);
 
+	if (is_sack)
+		uet_pdc_rx_sack(pdc, skb, cack_psn, ext_ack, ecn_marked);
+
 	ret = 0;
 	switch (pdc->state) {
 	case UET_PDC_EP_STATE_SYN_SENT:
diff --git a/drivers/ultraeth/uet_pds.c b/drivers/ultraeth/uet_pds.c
index 52122998079d..436b63189800 100644
--- a/drivers/ultraeth/uet_pds.c
+++ b/drivers/ultraeth/uet_pds.c
@@ -266,6 +266,9 @@ int uet_pds_rx(struct uet_pds *pds, struct sk_buff *skb, __be32 local_fep_addr,
 
 	prologue = pds_prologue_hdr(skb);
 	switch (uet_prologue_type(prologue)) {
+	case UET_PDS_TYPE_ACK_CC:
+		offset += sizeof(struct uet_pds_ack_ext_hdr);
+		fallthrough;
 	case UET_PDS_TYPE_ACK:
 		if (!uet_pds_rx_valid_ack_next_hdr(prologue))
 			break;
diff --git a/include/net/ultraeth/uet_pdc.h b/include/net/ultraeth/uet_pdc.h
index 8a87fc0bc869..d6710f92fb16 100644
--- a/include/net/ultraeth/uet_pdc.h
+++ b/include/net/ultraeth/uet_pdc.h
@@ -20,6 +20,8 @@
 					  NSEC_PER_SEC)
 #define UET_PDC_RTX_DEFAULT_MAX 3
 #define UET_PDC_MPR 128
+#define UET_PDC_SACK_BITS 64
+#define UET_PDC_SACK_MASK (U64_MAX << 3)
 
 #define UET_SKB_CB(skb)       ((struct uet_skb_cb *)&((skb)->cb[0]))
 
@@ -93,6 +95,8 @@ struct uet_pdc {
 
 	u32 rx_base_psn;
 	u32 tx_base_psn;
+	u32 lowest_unack_psn;
+	u32 max_rcv_psn;
 
 	u32 ack_gen_trigger;
 	u32 ack_gen_min_pkt_add;
@@ -146,4 +150,10 @@ static inline bool before(u32 seq1, u32 seq2)
 {
 	return (s32)(seq1-seq2) < 0;
 }
+
+static inline bool pdc_should_sack(const struct uet_pdc *pdc)
+{
+	return pdc->lowest_unack_psn > pdc->rx_base_psn &&
+	       pdc->lowest_unack_psn < pdc->max_rcv_psn;
+}
 #endif /* _UECON_PDC_H */
diff --git a/include/uapi/linux/ultraeth.h b/include/uapi/linux/ultraeth.h
index cc39bf970e08..3b8e95d7ed7b 100644
--- a/include/uapi/linux/ultraeth.h
+++ b/include/uapi/linux/ultraeth.h
@@ -152,6 +152,46 @@ struct uet_pds_ack_hdr {
 	__be16 dpdcid;
 } __attribute__ ((__packed__));
 
+/* ext ack CC flags */
+enum {
+	UET_PDS_ACK_EXT_CC_F_RSVD	= (1 << 0)
+};
+
+/* field: cc_type_mpr_sack_off */
+#define UET_PDS_ACK_EXT_MPR_BITS 8
+#define UET_PDS_ACK_EXT_MPR_MASK 0xff
+#define UET_PDS_ACK_EXT_CC_FLAGS_BITS 4
+#define UET_PDS_ACK_EXT_CC_FLAGS_MASK 0xf
+#define UET_PDS_ACK_EXT_CC_FLAGS_SHIFT UET_PDS_ACK_EXT_MPR_BITS
+#define UET_PDS_ACK_EXT_CC_TYPE_BITS 4
+#define UET_PDS_ACK_EXT_CC_TYPE_MASK 0xf
+#define UET_PDS_ACK_EXT_CC_TYPE_SHIFT (UET_PDS_ACK_EXT_CC_FLAGS_SHIFT + \
+				       UET_PDS_ACK_EXT_CC_FLAGS_BITS)
+/* header used for ACK_CC */
+struct uet_pds_ack_ext_hdr {
+	__be16 cc_type_flags_mpr;
+	__be16 sack_psn_offset;
+	__be64 sack_bitmap;
+	__be64 ack_cc_state;
+} __attribute__ ((__packed__));
+
+static inline __u8 uet_pds_ack_ext_mpr(const struct uet_pds_ack_ext_hdr *ack)
+{
+	return __be16_to_cpu(ack->cc_type_flags_mpr) & UET_PDS_ACK_EXT_MPR_MASK;
+}
+
+static inline __u8 uet_pds_ack_ext_cc_flags(const struct uet_pds_ack_ext_hdr *ack)
+{
+	return (__be16_to_cpu(ack->cc_type_flags_mpr) >> UET_PDS_ACK_EXT_CC_FLAGS_SHIFT) &
+	       UET_PDS_ACK_EXT_CC_FLAGS_MASK;
+}
+
+static inline __u8 uet_pds_ack_ext_cc_type(const struct uet_pds_ack_ext_hdr *ack)
+{
+	return (__be16_to_cpu(ack->cc_type_flags_mpr) >> UET_PDS_ACK_EXT_CC_TYPE_SHIFT) &
+	       UET_PDS_ACK_EXT_CC_TYPE_MASK;
+}
+
 /* ses request op codes */
 enum {
 	UET_SES_REQ_OP_NOOP			= 0x00,
-- 
2.48.1


