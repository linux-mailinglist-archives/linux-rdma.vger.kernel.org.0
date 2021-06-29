Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BEC3B7958
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhF2Uaw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhF2Uav (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:30:51 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A960C061760
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:28:22 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso6029966ooc.5
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ts0M4A+kaV/PqWUKIrOiU8P0d0m2308UEHxNlk5yfDU=;
        b=B1ZCAbezF8PUfroHIgi7+7DAKAc6t0+T4JfyG9sbITGZhxZBMsfMbP6LChq/Bwl50i
         ARudn1+dPWi1cmENOmNC6X7+7NEIYdlAGmxLKrri+hINiB8RGTnLXR4Vilcyf0RiDOVn
         A7jYg+hYpGy/wH6mYxNVcpJxsC1oRhOWOj67mU91I8jF8Gu7DKpz6HMsFuYzU2rWyjcv
         sftIo1Jq3gY0tzzJr5s/wgqBqtoVS+xdCC45nKZZnT+VQ9ZeL7ZoCJKOgOtNNYqCJHr6
         2DUq0qKi4JQO1U/Rpr7vvWUpjfSoQrlTkNhTt/xwaW6FOrTpwbR4dhxXtGrIXH3kkPhi
         6GVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ts0M4A+kaV/PqWUKIrOiU8P0d0m2308UEHxNlk5yfDU=;
        b=MMb551jEvB6h+d/D8IEEb72WRa8DWp0xEjNw/y5BPM0YhAmmU5gzNFAibZJQGZYKtO
         0PuBJSV3rFjA8S5sjqlF0OC07xs4GUP0LLXzHksHT/MTYJchhaxufh9mPfWfINLz7RYx
         PAf37orcurKzbvm7FyIUEWPttKyVtf5aaN1nBZpeHE/G6SLt2C28+xtBTrIvJiS5GYfT
         x0BfGdHUcltEcWPR1ZlsN9fUTPwylnyJzB9kikQBlA4ejwEjfIZnTqH/clIbLOCq1MIc
         87rDu4uSmqRI6Kku+UEpAz/JXdusQ9iRu58FSzHBGyG6jCKqjHWuB7oH1qfxaGqU1/AB
         5u9w==
X-Gm-Message-State: AOAM533A6Ukk/vHP0HSP0UAn0PkkVB40sY6CCNWzVD7Y7CBGNuK/nRUR
        QyZ4kQXUt8o7Spfdapp2yss=
X-Google-Smtp-Source: ABdhPJx1qPd5WiIkKJxJ9N8pWzUvFyO79WutJ6FRO9z2F8eOnafaYjmHMXsHBHK41lz2kYEN0p6G9A==
X-Received: by 2002:a4a:ea8d:: with SMTP id r13mr5465260ooh.7.1624998502064;
        Tue, 29 Jun 2021 13:28:22 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-2b92-ca20-93cc-e890.res6.spectrum.com. [2603:8081:140c:1a00:2b92:ca20:93cc:e890])
        by smtp.gmail.com with ESMTPSA id h2sm3814854oog.16.2021.06.29.13.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:28:21 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next resending 4/5] RDMA/rxe: Move rxe_crc32 to a subroutine
Date:   Tue, 29 Jun 2021 15:28:04 -0500
Message-Id: <20210629202804.29403-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629202804.29403-1-rpearsonhpe@gmail.com>
References: <20210629202804.29403-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Move rxe_crc32 from rxe.h to rxe_icrc.c as a static local function.
Add some comments to rxe_icrc.c

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.h      | 21 ------------
 drivers/infiniband/sw/rxe/rxe_icrc.c | 50 +++++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_loc.h  |  1 -
 3 files changed, 45 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index 623fd17df02d..65a73c1c8b35 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -42,27 +42,6 @@
 
 extern bool rxe_initialized;
 
-static inline u32 rxe_crc32(struct rxe_dev *rxe,
-			    u32 crc, void *next, size_t len)
-{
-	u32 retval;
-	int err;
-
-	SHASH_DESC_ON_STACK(shash, rxe->tfm);
-
-	shash->tfm = rxe->tfm;
-	*(u32 *)shash_desc_ctx(shash) = crc;
-	err = crypto_shash_update(shash, next, len);
-	if (unlikely(err)) {
-		pr_warn_ratelimited("failed crc calculation, err: %d\n", err);
-		return crc32_le(crc, next, len);
-	}
-
-	retval = *(u32 *)shash_desc_ctx(shash);
-	barrier_data(shash_desc_ctx(shash));
-	return retval;
-}
-
 void rxe_set_mtu(struct rxe_dev *rxe, unsigned int dev_mtu);
 
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name);
diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 5424b8bea908..e116c63d7b84 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -7,8 +7,44 @@
 #include "rxe.h"
 #include "rxe_loc.h"
 
-/* Compute a partial ICRC for all the IB transport headers. */
-u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
+/**
+ * rxe_crc32 - Compute incremental crc32 for a contiguous segment
+ * @rxe: rdma_rxe device object
+ * @crc: starting crc32 value from previous segments
+ * @addr: starting address of segment
+ * @len: length of the segment in bytes
+ *
+ * Returns the crc32 checksum of the segment starting from crc.
+ */
+static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *addr, size_t len)
+{
+	u32 icrc;
+	int err;
+
+	SHASH_DESC_ON_STACK(shash, rxe->tfm);
+
+	shash->tfm = rxe->tfm;
+	*(u32 *)shash_desc_ctx(shash) = crc;
+	err = crypto_shash_update(shash, addr, len);
+	if (unlikely(err)) {
+		pr_warn_ratelimited("failed crc calculation, err: %d\n", err);
+		return crc32_le(crc, addr, len);
+	}
+
+	icrc = *(u32 *)shash_desc_ctx(shash);
+	barrier_data(shash_desc_ctx(shash));
+
+	return icrc;
+}
+
+/**
+ * rxe_icrc_hdr - Compute a partial ICRC for the IB transport headers.
+ * @pkt: Information about the current packet
+ * @skb: The packet buffer
+ *
+ * Returns the partial ICRC
+ */
+static u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
 	unsigned int bth_offset = 0;
 	struct iphdr *ip4h = NULL;
@@ -71,9 +107,9 @@ u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 /**
  * rxe_icrc_check - Compute ICRC for a packet and compare to the ICRC
  *		    delivered in the packet.
- * @skb: The packet buffer with packet info in skb->cb[] (receive path)
+ * @skb: packet buffer with packet info in skb->cb[] (receive path)
  *
- * Returns 0 on success or an error on failure
+ * Returns 0 if the ICRCs match or an error on failure
  */
 int rxe_icrc_check(struct sk_buff *skb)
 {
@@ -106,7 +142,11 @@ int rxe_icrc_check(struct sk_buff *skb)
 	return 0;
 }
 
-/* rxe_icrc_generate- compute ICRC for a packet. */
+/**
+ * rxe_icrc_generate - Compute ICRC for a packet.
+ * @pkt: packet information
+ * @skb: packet buffer
+ */
 void rxe_icrc_generate(struct rxe_pkt_info *pkt, struct sk_buff *skb)
 {
 	__be32 *icrcp;
diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
index 2c724b9970d6..b08689b664ec 100644
--- a/drivers/infiniband/sw/rxe/rxe_loc.h
+++ b/drivers/infiniband/sw/rxe/rxe_loc.h
@@ -193,7 +193,6 @@ int rxe_requester(void *arg);
 int rxe_responder(void *arg);
 
 /* rxe_icrc.c */
-u32 rxe_icrc_hdr(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 int rxe_icrc_check(struct sk_buff *skb);
 void rxe_icrc_generate(struct rxe_pkt_info *pkt, struct sk_buff *skb);
 
-- 
2.30.2

