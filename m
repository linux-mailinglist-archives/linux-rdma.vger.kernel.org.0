Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F45C3BE1C0
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jul 2021 06:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhGGEEc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Jul 2021 00:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbhGGEEa (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Jul 2021 00:04:30 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591CFC061574
        for <linux-rdma@vger.kernel.org>; Tue,  6 Jul 2021 21:01:50 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q23so1860600oiw.11
        for <linux-rdma@vger.kernel.org>; Tue, 06 Jul 2021 21:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10Ev9SPave/k5CAY73W+iEMVlowQOzVZsPSBG2WZa6s=;
        b=H/dochdJ54pcQ7aUAAMVWrDD0NFRCXcwkUK7hDcrpaUK2ZCSDelfGeWZ+ju3Lpv/lr
         TgLlengXR+3cMeitbeQbaPJIshQFstFThC178bM3pT5gBxIfjtnq8wOHvp9CZ64nGqkF
         9oSKWARfExq2mVxvxn/WGdH6Zj4yLSakjV/xaN3wkigbg2kQnrUec3EBEhKYN0OahHmu
         Ss88poxlts2imMvHShtq+q8NXjwHWAYg1S8+x2VDpfwPLApQI855Si4hKeCLOOEaLh29
         gtcatIK61A7leZVgBwcyUZhDSA2AHwZqvNPsSMb7DAP/rChDglwyZPrk9N6q8ZPQJqoN
         oqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10Ev9SPave/k5CAY73W+iEMVlowQOzVZsPSBG2WZa6s=;
        b=AliWSPkzWTl3zroNYtpMXys2nC8iGwLVBdYLrmGYlTbq0ohlRPaZVtsuPqkqfrSeni
         5Om6U0PxCtfrgK6Uo/8fjl6rbgvBV2nrU304qZy2qslHQMy/eVcOnZMWcFF55mK3k5xX
         Jl+ULJnZBXG1Xq5vSeCKHrybdYGxwCR/pPLkEKpLx3msB97tKp9tSC+I1bycGC6KYAJe
         UrtawbMMi4VNuYLw3XQkldqFtDP2dQUH6Q+hmxaBxCGLDkr+qbiBVZ5/dqWZBObWFtFK
         LSaVdLkaAyfW/Swhy4mBPREpgw00vJjL+dlJQnsgKdU3sGbQF03kSmkDIVYbETf4q4N6
         s4oA==
X-Gm-Message-State: AOAM533NuGpPnVO72H/mt9Y8L5h+emI+r5oz9Ywli0phUEP31hTf9pKL
        3Mf+bUeg6oNutr3cHMaly7k=
X-Google-Smtp-Source: ABdhPJy3BLTsBMGgh/PQ+sfs3lPxVIWh2bZ/ydCQJjvtCFWylxDOkzV831SvYzajaezNFwQBWyeAyg==
X-Received: by 2002:aca:30d4:: with SMTP id w203mr2184220oiw.34.1625630509783;
        Tue, 06 Jul 2021 21:01:49 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-3e85-59b9-418d-5cfe.res6.spectrum.com. [2603:8081:140c:1a00:3e85:59b9:418d:5cfe])
        by smtp.gmail.com with ESMTPSA id r13sm2564732oiw.44.2021.07.06.21.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 21:01:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 9/9] RDMA/rxe: Fix types in rxe_icrc.c
Date:   Tue,  6 Jul 2021 23:00:41 -0500
Message-Id: <20210707040040.15434-10-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707040040.15434-1-rpearsonhpe@gmail.com>
References: <20210707040040.15434-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the ICRC is generated as a u32 type and then forced to a __be32
and stored into the ICRC field in the packet. The actual type of the ICRC
is __be32. This patch replaces u32 by __be32 and eliminates the casts.
The computation is exactly the same as the original but the types are
more consistent.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_icrc.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_icrc.c b/drivers/infiniband/sw/rxe/rxe_icrc.c
index 4473d38c171f..e03af3012590 100644
--- a/drivers/infiniband/sw/rxe/rxe_icrc.c
+++ b/drivers/infiniband/sw/rxe/rxe_icrc.c
@@ -40,22 +40,22 @@ int rxe_icrc_init(struct rxe_dev *rxe)
  *
  * Return: the cumulative crc32 checksum
  */
-static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
+static __be32 rxe_crc32(struct rxe_dev *rxe, __be32 crc, void *next, size_t len)
 {
-	u32 icrc;
+	__be32 icrc;
 	int err;
 
 	SHASH_DESC_ON_STACK(shash, rxe->tfm);
 
 	shash->tfm = rxe->tfm;
-	*(u32 *)shash_desc_ctx(shash) = crc;
+	*(__be32 *)shash_desc_ctx(shash) = crc;
 	err = crypto_shash_update(shash, next, len);
 	if (unlikely(err)) {
 		pr_warn_ratelimited("failed crc calculation, err: %d\n", err);
-		return crc32_le(crc, next, len);
+		return (__force __be32)crc32_le((__force u32)crc, next, len);
 	}
 
-	icrc = *(u32 *)shash_desc_ctx(shash);
+	icrc = *(__be32 *)shash_desc_ctx(shash);
 	barrier_data(shash_desc_ctx(shash));
 
 	return icrc;
@@ -69,14 +69,14 @@ static u32 rxe_crc32(struct rxe_dev *rxe, u32 crc, void *next, size_t len)
  *
  * Return: the partial ICRC
  */
-static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
+static __be32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	unsigned int bth_offset = 0;
 	struct iphdr *ip4h = NULL;
 	struct ipv6hdr *ip6h = NULL;
 	struct udphdr *udph;
 	struct rxe_bth *bth;
-	int crc;
+	__be32 crc;
 	int length;
 	int hdr_size = sizeof(struct udphdr) +
 		(skb->protocol == htons(ETH_P_IP) ?
@@ -91,7 +91,7 @@ static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	/* This seed is the result of computing a CRC with a seed of
 	 * 0xfffffff and 8 bytes of 0xff representing a masked LRH.
 	 */
-	crc = 0xdebb20e3;
+	crc = (__force __be32)0xdebb20e3;
 
 	if (skb->protocol == htons(ETH_P_IP)) { /* IPv4 */
 		memcpy(pshdr, ip_hdr(skb), hdr_size);
@@ -140,16 +140,16 @@ static u32 rxe_icrc_hdr(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	__be32 *icrcp;
-	u32 pkt_icrc;
-	u32 icrc;
+	__be32 pkt_icrc;
+	__be32 icrc;
 
 	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
-	pkt_icrc = be32_to_cpu(*icrcp);
+	pkt_icrc = *icrcp;
 
 	icrc = rxe_icrc_hdr(skb, pkt);
 	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
 				payload_size(pkt) + bth_pad(pkt));
-	icrc = (__force u32)cpu_to_be32(~icrc);
+	icrc = ~icrc;
 
 	if (unlikely(icrc != pkt_icrc)) {
 		if (skb->protocol == htons(ETH_P_IPV6))
@@ -175,11 +175,11 @@ int rxe_icrc_check(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 void rxe_icrc_generate(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 {
 	__be32 *icrcp;
-	u32 icrc;
+	__be32 icrc;
 
 	icrcp = (__be32 *)(pkt->hdr + pkt->paylen - RXE_ICRC_SIZE);
 	icrc = rxe_icrc_hdr(skb, pkt);
 	icrc = rxe_crc32(pkt->rxe, icrc, (u8 *)payload_addr(pkt),
 				payload_size(pkt) + bth_pad(pkt));
-	*icrcp = (__force __be32)~icrc;
+	*icrcp = ~icrc;
 }
-- 
2.30.2

