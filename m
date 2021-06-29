Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92FC3B792C
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Jun 2021 22:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhF2UQy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Jun 2021 16:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbhF2UQy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 29 Jun 2021 16:16:54 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E430C061760
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:25 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id d21-20020a9d72d50000b02904604cda7e66so53704otk.7
        for <linux-rdma@vger.kernel.org>; Tue, 29 Jun 2021 13:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ts0M4A+kaV/PqWUKIrOiU8P0d0m2308UEHxNlk5yfDU=;
        b=dRkCKCGpC+89LX5cCvYby+k5SG85L46x3zLifGfJBJXl5YB42433Z9LBdQB/L12qUV
         N/NCVt+ha/bfzpCngdkNPd+AIpGC4jOg4ODka6DnfoyL4DiRrkfJtxjMp2h74uWWO4HH
         v0JYYmTObqhRYqIXDdCqFrmmG1KUIdkonuvl/wua4D41MbM6URelD9DSCMlw0Sk2UkxL
         Xdq28mWOifpKLsgglj1Wj/6ILMfCGUkjy9aIdWruldYkwvIbwgGr3NCBilMpKr+0qUnv
         N4caO9dEdzvgmfk16yPyYV3zjbeGPyU02viv72bhIiCIMxLiUWMP4FT4WlC4wrPN0Jmc
         gqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ts0M4A+kaV/PqWUKIrOiU8P0d0m2308UEHxNlk5yfDU=;
        b=dDhkjnuCj9LrC4xLheuelIAxVphl4CAxG7laG/6lOLWOTs+BJ6mkNlSN23pgufnHTg
         j0b2kSnUR6KAiou6Dtnou7AHV9PG4AR5ZhOclyWmNIDYQre9RIFiXI1k3nh6D8icRa2S
         kkQ5h5hJWQbQ6iKOlptxmCVQILq/s43LoPRpM0K0eLzxql7BV1+MDzF09flOJG3kQTGg
         TzP2eOp9ow7BWfLBTwTZLEqWcnLCW+X6q/Dqkk50G290Y4o6wSWSkchV/tPN7qKcUkxR
         /krJky0KbzoiuYZlrnvUK+PgICIQ8+JmbdU8hzrJsYzmF+Js3iFhzdZ5OBkeia7ck1aK
         u85A==
X-Gm-Message-State: AOAM5309tOcCfn1Vg1kvPEiH6gUcipLspTx9JpupvgVYLB+biQ1B8r6n
        X6U8S9xXjgAdhMH1uendAqc=
X-Google-Smtp-Source: ABdhPJxAkFRDJww2s7N4mfBCC4srrvmKXdaCGIFjOmFx/3Wjov1HWUZ0a/LWB5D2QJgfy0qXlFXusA==
X-Received: by 2002:a05:6830:48:: with SMTP id d8mr6286257otp.122.1624997664997;
        Tue, 29 Jun 2021 13:14:24 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-aaa9-75eb-6e0f-9f85.res6.spectrum.com. [2603:8081:140c:1a00:aaa9:75eb:6e0f:9f85])
        by smtp.gmail.com with ESMTPSA id x29sm2697512ooj.10.2021.06.29.13.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 13:14:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 4/5] RDMA/rxe: Move rxe_crc32 to a subroutine
Date:   Tue, 29 Jun 2021 15:14:09 -0500
Message-Id: <20210629201412.28306-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210629201412.28306-1-rpearsonhpe@gmail.com>
References: <20210629201412.28306-1-rpearsonhpe@gmail.com>
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

