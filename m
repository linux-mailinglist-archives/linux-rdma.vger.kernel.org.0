Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB48A3DAF7E
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jul 2021 00:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhG2Wum (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 18:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbhG2Wul (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jul 2021 18:50:41 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC48C061765
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:37 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id h7-20020a4ab4470000b0290263c143bcb2so1975555ooo.7
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jul 2021 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFaVSnJSikM0I7j89ygvHRvWQHX9DmYxRz16Xu4kLLA=;
        b=nQ8SFlfpimiQlAQbOE5aCKQKKzVwT/J/W4o0cZXjTwTbVN3zW6cWbHFp5Xo9QtUi9h
         e/Vu4zcOA+AgeiEdNsC9+fVf/XJJB68/kWrLXBXvq74Y6uCAEYDqOlCM+FjfZaAnObSN
         FczckSUgN+pFwHRmF6YHTvzYQ8Ae3CpgOaVB3M23oqP5wlprq5Io8uX+sseaCC/G44ae
         3bxEhuLwHQ7Hs5wSNmTE0WIAWN1zfX2JG/4iVYaDJl9bfMQ6mH+mwg3234aYTVnm9+2k
         apLp1LHDsfGE6fPSXHZ7CrMhcvKPT/Mz/jh9KQFJdeRbzKIEr2LUjw6OhEV3JYLPhfUs
         jsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFaVSnJSikM0I7j89ygvHRvWQHX9DmYxRz16Xu4kLLA=;
        b=lo09KA37+0enzn2MGK7Lv9JVv4FEHcP8TPglkNmoeTm/nDx/WRC5sRlrOPP+7z1TUr
         wLXHKuzbRmKGMXm50DMq4XE6UmmvorgYzh9YzLX6PcKY8UtyLJ78gHYhardDgR3YcX5x
         +W8p6YiL0vFjFpKS+3BxTymbT36qQD7inJweRimezv3oJPBM9Od+GXVpnmW1Vlx7ArPD
         8P35Bc/cUWaOLJiv2G+swNvhvsFoLI4cn3NmcCFuBjkllDLJKrpRTZF1uourf48Hsxj3
         NDBbD9Gi0Fmsq8JmFHx1s5Ks//WKJ+XL5CN0ujnFyCR7ppLMld6Tz7L3/8t+1NeePBKj
         Rmaw==
X-Gm-Message-State: AOAM530N+xqdfnu7O7mNWx4n8qEjZ08O/e684m4U8zdwzD08lO32P/+x
        iKpc15TK4odgCFsYIZAHXSo=
X-Google-Smtp-Source: ABdhPJwpN/MroRpQ499TwZADieZVKtvLI79nuCeRuzPNio7POaQF5BC4RY1FrPw3XsbM670zX7kDzA==
X-Received: by 2002:a4a:da0f:: with SMTP id e15mr4506588oou.53.1627599036754;
        Thu, 29 Jul 2021 15:50:36 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-80ca-c9ae-640f-0f9a.res6.spectrum.com. [2603:8081:140c:1a00:80ca:c9ae:640f:f9a])
        by smtp.gmail.com with ESMTPSA id t16sm776469otm.63.2021.07.29.15.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 15:50:36 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 04/13] RDMA/rxe: Extend rxe_opcode.h to support xrc
Date:   Thu, 29 Jul 2021 17:49:07 -0500
Message-Id: <20210729224915.38986-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210729224915.38986-1-rpearsonhpe@gmail.com>
References: <20210729224915.38986-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend rxe_wr_opcode_info to support more QP types.

Extend rxe_hdr_type and rxe_hdr_mask enums to support XRCETH headers.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_opcode.h | 38 +++++++++++++-------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_opcode.h b/drivers/infiniband/sw/rxe/rxe_opcode.h
index e02f039b8c44..a5349eecc9c0 100644
--- a/drivers/infiniband/sw/rxe/rxe_opcode.h
+++ b/drivers/infiniband/sw/rxe/rxe_opcode.h
@@ -27,28 +27,27 @@ enum rxe_wr_mask {
 	WR_ATOMIC_OR_READ_MASK		= WR_ATOMIC_MASK | WR_READ_MASK,
 };
 
-#define WR_MAX_QPT		(8)
-
 struct rxe_wr_opcode_info {
 	char			*name;
-	enum rxe_wr_mask	mask[WR_MAX_QPT];
+	enum rxe_wr_mask	mask[IB_QPT_MAX];
 };
 
 extern struct rxe_wr_opcode_info rxe_wr_opcode_info[];
 
 enum rxe_hdr_type {
-	RXE_LRH,
-	RXE_GRH,
-	RXE_BTH,
-	RXE_RETH,
-	RXE_AETH,
-	RXE_ATMETH,
-	RXE_ATMACK,
-	RXE_IETH,
-	RXE_RDETH,
-	RXE_DETH,
-	RXE_IMMDT,
-	RXE_PAYLOAD,
+	RXE_LRH,		/* IBA 5.2.1 not used by rxe */
+	RXE_GRH,		/* IBA 5.2.2 */
+	RXE_BTH,		/* IBA 5.2.3 */
+	RXE_RDETH,		/* IBA 5.2.4 not supported by rxe */
+	RXE_DETH,		/* IBA 5.2.5 */
+	RXE_RETH,		/* IBA 5.2.6 */
+	RXE_ATMETH,		/* IBA 5.2.7 */
+	RXE_XRCETH,		/* IBA 5.2.8 */
+	RXE_AETH,		/* IBA 5.2.9 */
+	RXE_ATMACK,		/* IBA 5.2.10 */
+	RXE_IMMDT,		/* IBA 5.2.11 */
+	RXE_IETH,		/* IBA 5.2.12 */
+	RXE_PAYLOAD,		/* IBA 5.2.13 */
 	NUM_HDR_TYPES
 };
 
@@ -56,14 +55,15 @@ enum rxe_hdr_mask {
 	RXE_LRH_MASK		= BIT(RXE_LRH),
 	RXE_GRH_MASK		= BIT(RXE_GRH),
 	RXE_BTH_MASK		= BIT(RXE_BTH),
-	RXE_IMMDT_MASK		= BIT(RXE_IMMDT),
+	RXE_RDETH_MASK		= BIT(RXE_RDETH),
+	RXE_DETH_MASK		= BIT(RXE_DETH),
 	RXE_RETH_MASK		= BIT(RXE_RETH),
-	RXE_AETH_MASK		= BIT(RXE_AETH),
 	RXE_ATMETH_MASK		= BIT(RXE_ATMETH),
+	RXE_XRCETH_MASK		= BIT(RXE_XRCETH),
+	RXE_AETH_MASK		= BIT(RXE_AETH),
 	RXE_ATMACK_MASK		= BIT(RXE_ATMACK),
+	RXE_IMMDT_MASK		= BIT(RXE_IMMDT),
 	RXE_IETH_MASK		= BIT(RXE_IETH),
-	RXE_RDETH_MASK		= BIT(RXE_RDETH),
-	RXE_DETH_MASK		= BIT(RXE_DETH),
 	RXE_PAYLOAD_MASK	= BIT(RXE_PAYLOAD),
 
 	RXE_REQ_MASK		= BIT(NUM_HDR_TYPES + 0),
-- 
2.30.2

