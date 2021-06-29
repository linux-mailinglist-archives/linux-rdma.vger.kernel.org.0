Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4102A3B7959
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhF2Uaw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbhF2Uav (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:30:51 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47640C061766
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:28:23 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 22so218306oix.10
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grubGUbBuvqyqkCPcMcJ1aRrc0D4euuSFNCNaoiFuoI=;
        b=CPYjfuLZt6DAlGkktCwHI0FYmLb/IssaPvxCCdMy1rUCjEpYo7xXG4ynm8PfCwhIMb
         yIh85c3n3O+OZE81O7VdxPRxR3rSSvNT7l+6AzlbV7GYQQJddOY4MhxGsSKMc/z8g2W1
         UxDwSZw8Im+3lswlnzykPdyohkZA1cp4UowtHbitrTkkvf2OhvzDvSTGta4/dxwFx7RJ
         uSjpSfHUxDvpFMSdUE8YxOJfnsVaA2FuUslrBARlxKP6GbaM41rS8W7hFl0EHmSR8BAB
         sAAzRx9hAYGKdhMZvvHBw2obygEsr6sgMgSmZY5i+rAxU+DfnVznFC0XzSD7pZ/nn+sY
         5Jjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grubGUbBuvqyqkCPcMcJ1aRrc0D4euuSFNCNaoiFuoI=;
        b=CTxuBhW6+1ILKKNu1RjqFvSil8EggZCI7WpZCPwHFgdWNbmNcvVlucTbERBQ3tmePW
         jnrp35dJFbe/qzQfZS1SQsMWeJ2pMzF1kVwuK6NMfzwnD4W5WR57OLDGvFJRYCNCagO5
         KHPwcqyf0Zzgo68NHSaBdeA0N6NiQ76PftEmDtS/zOwVlN/RHPV36xbrZnd5Wunf4DNZ
         OVrekQ3ilBvEjyu5WMkoa6ftVuPkzlwvNMp7ainZYH+Rh0GkB6TGI7XjkJr3QsgEZmNi
         SGsOkpN9I+GzqGjq2q2mmO7kMrq1x8EpUt5ch2B496l2JQqgabPX2AeC6IwPCDl6B2Pe
         dOPg==
X-Gm-Message-State: AOAM5300rWXx8Wio1co8IQDlWXyBYrS2WqI2EIhp2RB106GTqHgtW/VW
        coZOR7Zk9nc1bsmaQ3HpziiDWU7A7E8=
X-Google-Smtp-Source: ABdhPJw4tQ9Q3iaK9AhieIZmEjbvpg1RTfE9W6n56pUjLUhn/GVNBRHRE/mbO+D5m1IThjSmk8xYtw==
X-Received: by 2002:aca:4143:: with SMTP id o64mr22810594oia.105.1624998502686;
        Tue, 29 Jun 2021 13:28:22 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2b92-ca20-93cc-e890.res6.spectrum.com. [2603:8081:140c:1a00:2b92:ca20:93cc:e890])
        by smtp.gmail.com with ESMTPSA id c4sm1107368ots.15.2021.06.29.13.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:28:22 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next resending 5/5] RDMA/rxe: Move crc32 init code to rxe_icrc.c
Date:   Tue, 29 Jun 2021 15:28:05 -0500
Message-Id: <20210629202804.29403-6-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629202804.29403-1-rpearsonhpe@gmail.com>
References: <20210629202804.29403-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch collects the code from rxe_register_device() that sets
up the crc32 calculation into a subroutine rxe_icrc_init() in
rxe_icrc.c. This completes collecting all the code specific to computing
ICRC into one file with a simple set of APIs.
Minor cleanups in rxe_icrc.c to
  Comments
  byte order types

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.h       |  1 -
 drivers/infiniband/sw/rxe/rxe_icrc.c  | 75 +++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_loc.h   |  1 +
 drivers/infiniband/sw/rxe/rxe_verbs.c | 11 ++--
 4 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 65a73c1c8b35..1bb3fb618bf5 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -14,7 +14,6 @@
 
 #include <linux/module.h>
 #include <linux/skbuff.h>
-#include <linux/crc32.h>
 
 #include <rdma/ib_verbs.h>
 #include <rdma/ib_user_verbs.h>
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index e116c63d7b84..4f311798d682 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -4,34 +4,59 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
+#include <linux/crc32.h>
 #include "rxe.h"
 #include "rxe_loc.h"
 
 /**
- * rxe_crc32 - Compute incremental crc32 for a contiguous segment
+ * rxe_icrc_init - Initialize crypto function for computing crc32
+ * @rxe: rdma_rxe device object
+ *
+ * Returns 0 on success else an error
+ */
+int rxe_icrc_init(struct rxe_dev *rxe)
+{
+	struct crypto_shash *tfm;
+
+	tfm = crypto_alloc_shash("crc32", 0, 0);
+	if (IS_ERR(tfm)) {
+		pr_err("failed to init crc32 algorithm err:%ld\n",
+			       PTR_ERR(tfm));
+		return PTR_ERR(tfm);
+	}
+
+	rxe->tfm = tfm;
+
+	return 0;
+}
+
+/**
+ * rxe_crc32 - Compute cumulative crc32 for a contiguous segment
  * @rxe: rdma_rxe device object
  * @crc: starting crc32 value from previous segments
  * @addr: starting address of segment
  * @len: length of the segment in bytes
  *
- * Returns the crc32 checksum of the segment starting from crc.
+ * Returns the crc32 cumulative checksum including the segment starting
+ * from crc.
  */
-static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *addr, size_t len)
+static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *addr,
+			size_t len)
 {
-	u32 icrc;
+	__be32 icrc;
 	int err;
 
 	SHASH_DESC_ON_STACK(shash, rxe->tfm);
 
 	shash->tfm = rxe->tfm;
-	*(u32 *)shash_desc_ctx(shash) = crc;
+	*(__be32 *)shash_desc_ctx(shash) = crc;
 	err = crypto_shash_update(shash, addr, len);
 	if (unlikely(err)) {
 		pr_warn_ratelimited("failed crc calculation, err: %d\n", err);
 		return crc32_le(crc, addr, len);
 	}
 
-	icrc = *(u32 *)shash_desc_ctx(shash);
+	icrc = *(__be32 *)shash_desc_ctx(shash);
 	barrier_data(shash_desc_ctx(shash));
 
 	return icrc;
@@ -39,19 +64,16 @@ static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *addr, size_t len)
 
 /**
  * rxe_icrc_hdr - Compute a partial ICRC for the IB transport headers.
- * @pkt: Information about the current packet
- * @skb: The packet buffer
+ * @pkt: packet information
+ * @skb: packet buffer
  *
  * Returns the partial ICRC
  */
 static u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
-	unsigned int bth_offset = 0;
-	struct iphdr *ip4h = NULL;
-	struct ipv6hdr *ip6h = NULL;
 	struct udphdr *udph;
 	struct rxe_bth *bth;
-	int crc;
+	__be32 crc;
 	int length;
 	int hdr_size = sizeof(struct udphdr) +
 		(skb->protocol == htons(ETH_P_IP) ?
@@ -69,6 +91,8 @@ static u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 	crc = 0xdebb20e3;
 
 	if (skb->protocol == htons(ETH_P_IP)) { /* IPv4 */
+		struct iphdr *ip4h = NULL;
+
 		memcpy(pshdr, ip_hdr(skb), hdr_size);
 		ip4h = (struct iphdr *)pshdr;
 		udph = (struct udphdr *)(ip4h + 1);
@@ -77,6 +101,8 @@ static u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 		ip4h->check = CSUM_MANGLED_0;
 		ip4h->tos = 0xff;
 	} else {				/* IPv6 */
+		struct ipv6hdr *ip6h = NULL;
+
 		memcpy(pshdr, ipv6_hdr(skb), hdr_size);
 		ip6h = (struct ipv6hdr *)pshdr;
 		udph = (struct udphdr *)(ip6h + 1);
@@ -85,12 +111,9 @@ static u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 		ip6h->priority = 0xf;
 		ip6h->hop_limit = 0xff;
 	}
-	udph->check = CSUM_MANGLED_0;
-
-	bth_offset += hdr_size;
 
-	memcpy(&pshdr[bth_offset], pkt->hdr, RXE_BTH_BYTES);
-	bth = (struct rxe_bth *)&pshdr[bth_offset];
+	bth = (struct rxe_bth *)(udph + 1);
+	memcpy(bth, pkt->hdr, RXE_BTH_BYTES);
 
 	/* exclude bth.resv8a */
 	bth->qpn |= cpu_to_be32(~BTH_QPN_MASK);
@@ -115,18 +138,18 @@ int rxe_icrc_check(struct sk_buff *skb)
 {
 	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
 	__be32 *icrcp;
-	u32 pkt_icrc;
-	u32 icrc;
+	__be32 packet_icrc;
+	__be32 computed_icrc;
 
 	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
-	pkt_icrc = be32_to_cpu(*icrcp);
+	packet_icrc = *icrcp;
 
-	icrc = rxe_icrc_hdr(pkt, skb);
-	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
-				payload_size(pkt) + bth_pad(pkt));
-	icrc = (__force u32)cpu_to_be32(~icrc);
+	computed_icrc = rxe_icrc_hdr(pkt, skb);
+	computed_icrc = rxe_crc32(pkt->rxe, computed_icrc,
+		(u8 *)payload_addr(pkt), payload_size(pkt) + bth_pad(pkt));
+	computed_icrc = ~computed_icrc;
 
-	if (unlikely(icrc != pkt_icrc)) {
+	if (unlikely(computed_icrc != packet_icrc)) {
 		if (skb->protocol == htons(ETH_P_IPV6))
 			pr_warn_ratelimited("bad ICRC from %pI6c\n",
 					    &ipv6_hdr(skb)->saddr);
@@ -150,7 +173,7 @@ int rxe_icrc_check(struct sk_buff *skb)
 void rxe_icrc_generate(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
 	__be32 *icrcp;
-	u32 icrc;
+	__be32 icrc;
 
 	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
 	icrc = rxe_icrc_hdr(pkt, skb);
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index b08689b664ec..f98378f8ff31 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -193,6 +193,7 @@ int rxe_requester(void *arg);
 int rxe_responder(void *arg);
 
 /* rxe_icrc.c */
+int rxe_icrc_init(struct rxe_dev *rxe);
 int rxe_icrc_check(struct sk_buff *skb);
 void rxe_icrc_generate(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 
diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index c223959ac174..f7b1a1f64c13 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -1154,7 +1154,6 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 {
 	int err;
 	struct ib_device *dev = &rxe->ib_dev;
-	struct crypto_shash *tfm;
 
 	strscpy(dev->node_desc, "rxe", sizeof(dev->node_desc));
 
@@ -1173,13 +1172,9 @@ int rxe_register_device(struct rxe_dev *rxe, const char *ibdev_name)
 	if (err)
 		return err;
 
-	tfm = crypto_alloc_shash("crc32", 0, 0);
-	if (IS_ERR(tfm)) {
-		pr_err("failed to allocate crc algorithm err:%ld\n",
-		       PTR_ERR(tfm));
-		return PTR_ERR(tfm);
-	}
-	rxe->tfm = tfm;
+	err = rxe_icrc_init(rxe);
+	if (err)
+		return err;
 
 	err = ib_register_device(dev, ibdev_name, NULL);
 	if (err)
-- 
2.30.2

