Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164825BB5BF
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiIQDKv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiIQDKr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:10:47 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8B74F39E
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:46 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-12c8312131fso4529147fac.4
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1O4gVNR3dcE8FWJuOdKt0Ng7mhdOLr6Amkjy6/uxb+o=;
        b=SfuzLFSufopvky1rRwHJCqM3vAwuDejF64udYVJv0Cij+3IxhKCiMVEttXEaAJPwN1
         p3dhRZZK38TPeaDeR9XLYCOGDzg3w5fKJwagkglRC2mjqHAbnnBSQ+wSpEZaDaTEoL7O
         bW1hAsiQ4TbX7MHYksv9yUKe1WT6bacUK7ZmvO+EqovwsaJE1RCkwuOxvmsqJP+Bpq1/
         YV1Xe41Q12iv/K8Dw7thNnGqQhFkdd0FDVjRsU//6ITtuYxw9En7y9U2KGJJ6NC3r7c6
         gWfu5AIek9IGnk8vEsgeEq1Vye+Oh+ba2fE1QKsIOIBiXr7sDVvZdt0rEMnQNXr8MxCt
         OQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1O4gVNR3dcE8FWJuOdKt0Ng7mhdOLr6Amkjy6/uxb+o=;
        b=bXO3QVLfcghwsO6+UVXcSlyxOd359najsUsGXGfgQgyJEkeSgcfTJUc+i0rYM6MAhJ
         ZhiemfT3KgZZreXfivWTueL3u55nuN8tMVJ+I9UxtJJEmnUjv7tjLZ2HPOJ36xyiE6VA
         3vPFDWukofY4144F+FK8dxbmcWzzTqEqrSqNmcKVA4lEXoXTErVuNQrD2gYmsAG9CefZ
         /fsciU/Qk50HENitch016EKxXa/BkVkPd6sFkGe5zVZgwpQCZGjozVUW763JwmAu86fU
         hl2tHseZ8eqU4ay1mb+88D77jOFWBEzTNbgkdUciwb2PfaQsyJo8inEhzwGnjrAXQqqr
         vmeA==
X-Gm-Message-State: ACgBeo3wrO9CAg8g5pl/gTlLqioTEipNfGjPyOBKlNTDILBoOhEkTtxj
        1y3gn+PHRXqlgzatZJgSTb8=
X-Google-Smtp-Source: AA6agR4j1rYxIFSn5XhMpilnOf6qAcoMCcG7ujP0c/L4dhw4o5IcQChd3keeouYM2lSi3XNi/iE+Eg==
X-Received: by 2002:a05:6870:1494:b0:12a:fadc:c6ce with SMTP id k20-20020a056870149400b0012afadcc6cemr10397771oab.283.1663384245679;
        Fri, 16 Sep 2022 20:10:45 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id be36-20020a05687058a400b000f5e89a9c60sm4464800oab.3.2022.09.16.20.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:10:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 03/13] RDMA: Add xrc opcodes to ib_pack.h
Date:   Fri, 16 Sep 2022 22:10:22 -0500
Message-Id: <20220917031028.21187-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031028.21187-1-rpearsonhpe@gmail.com>
References: <20220917031028.21187-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend ib_pack.h to include xrc opcodes.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 include/rdma/ib_pack.h | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/rdma/ib_pack.h b/include/rdma/ib_pack.h
index a9162f25beaf..cc9aac05d38e 100644
--- a/include/rdma/ib_pack.h
+++ b/include/rdma/ib_pack.h
@@ -56,8 +56,11 @@ enum {
 	IB_OPCODE_UD                                = 0x60,
 	/* per IBTA 1.3 vol 1 Table 38, A10.3.2 */
 	IB_OPCODE_CNP                               = 0x80,
+	IB_OPCODE_XRC				    = 0xa0,
 	/* Manufacturer specific */
 	IB_OPCODE_MSP                               = 0xe0,
+	/* opcode type bits */
+	IB_OPCODE_TYPE				    = 0xe0,
 
 	/* operations -- just used to define real constants */
 	IB_OPCODE_SEND_FIRST                        = 0x00,
@@ -84,6 +87,8 @@ enum {
 	/* opcode 0x15 is reserved */
 	IB_OPCODE_SEND_LAST_WITH_INVALIDATE         = 0x16,
 	IB_OPCODE_SEND_ONLY_WITH_INVALIDATE         = 0x17,
+	/* opcode command bits */
+	IB_OPCODE_CMD				    = 0x1f,
 
 	/* real constants follow -- see comment about above IB_OPCODE()
 	   macro for more details */
@@ -152,7 +157,32 @@ enum {
 
 	/* UD */
 	IB_OPCODE(UD, SEND_ONLY),
-	IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE)
+	IB_OPCODE(UD, SEND_ONLY_WITH_IMMEDIATE),
+
+	/* XRC */
+	IB_OPCODE(XRC, SEND_FIRST),
+	IB_OPCODE(XRC, SEND_MIDDLE),
+	IB_OPCODE(XRC, SEND_LAST),
+	IB_OPCODE(XRC, SEND_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(XRC, SEND_ONLY),
+	IB_OPCODE(XRC, SEND_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(XRC, RDMA_WRITE_FIRST),
+	IB_OPCODE(XRC, RDMA_WRITE_MIDDLE),
+	IB_OPCODE(XRC, RDMA_WRITE_LAST),
+	IB_OPCODE(XRC, RDMA_WRITE_LAST_WITH_IMMEDIATE),
+	IB_OPCODE(XRC, RDMA_WRITE_ONLY),
+	IB_OPCODE(XRC, RDMA_WRITE_ONLY_WITH_IMMEDIATE),
+	IB_OPCODE(XRC, RDMA_READ_REQUEST),
+	IB_OPCODE(XRC, RDMA_READ_RESPONSE_FIRST),
+	IB_OPCODE(XRC, RDMA_READ_RESPONSE_MIDDLE),
+	IB_OPCODE(XRC, RDMA_READ_RESPONSE_LAST),
+	IB_OPCODE(XRC, RDMA_READ_RESPONSE_ONLY),
+	IB_OPCODE(XRC, ACKNOWLEDGE),
+	IB_OPCODE(XRC, ATOMIC_ACKNOWLEDGE),
+	IB_OPCODE(XRC, COMPARE_SWAP),
+	IB_OPCODE(XRC, FETCH_ADD),
+	IB_OPCODE(XRC, SEND_LAST_WITH_INVALIDATE),
+	IB_OPCODE(XRC, SEND_ONLY_WITH_INVALIDATE),
 };
 
 enum {
-- 
2.34.1

