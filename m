Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C825BB5D2
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Sep 2022 05:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIQDL6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Sep 2022 23:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiIQDLS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Sep 2022 23:11:18 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B330380523
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:10 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1274ec87ad5so54802429fac.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Sep 2022 20:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1O4gVNR3dcE8FWJuOdKt0Ng7mhdOLr6Amkjy6/uxb+o=;
        b=GfM6hLQTFxfWCA/daXE+BKluySstWmo2hgO3FTfPTnOMpLJuRcawYnZVSAyFgPuCKQ
         g5TNW/kI2YZriemNclMyQL4nRxGVwxPM10CmpTtvXDdArd+ATqrYv2QwWJ8GDr47BVjN
         ah1TlhmbvxjP3x4sQitIpwGdz5QHPnqsVCtcRJvXAO9ucseH3vTU/1ykag5XcrubYMXw
         mn8j9kdra/q60rtE2c9eqdLyvhns854OI/ETRtiLitK1NCWbaYhRJ4pu0NjGq+OJZj/Q
         qx3XADj2IhZY0FPIqv7Y265HGbP+NE+wRM1ipE2gf2o+X5B9UOIOrqK2BS1Om7/J+mTR
         DjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1O4gVNR3dcE8FWJuOdKt0Ng7mhdOLr6Amkjy6/uxb+o=;
        b=v9+2lMEInLRTHONFrQfKTKKbyIa5M7SpNVTTlFUuFUgrJyZS2Bstz5y5cExG+u/aqJ
         R/A5n5xouVpgCcrkUs14y+9l+7kA6BTPCT/rlMBpvP80tnuT9so9rCTTwaqsy2g1lNfh
         Y+IcMl5u/LxEkQ6YP/t9TiWpaRPMpMc02t/Hf1SovAcNsoXQAkJ/zTsOkgk3xt2BkHtt
         RZmdW5eI9+F+MZFPgUBOBdRszgg9T0LuWKLx66bp1Zx72187sViZoHbm27SB7IuAz9k5
         GBAhO/S7F4T0EHTlzHGq6nnKvAsxHa4civ0aVxF8F9pihXYEGJqGOmuOpB+Mu6ql7llp
         jhAA==
X-Gm-Message-State: ACgBeo0X6PDuBMu7Zz2TTjTHyYTYMGIQYXsdLEGo8ONzMA/dg1oqu18X
        nKe7vomimSEcYGjy7zQJn4MCCzQ7jr0=
X-Google-Smtp-Source: AA6agR5p8SqFqEVzYCc+qLr6Ss9RmIPrDeK2Iv3QQGsGeX5gzqDUQeRczj3bOJ9ZsTIe92V5WyWGkg==
X-Received: by 2002:a05:6870:d594:b0:12b:f19b:6e6d with SMTP id u20-20020a056870d59400b0012bf19b6e6dmr10409842oao.115.1663384270491;
        Fri, 16 Sep 2022 20:11:10 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-f9ea-fe1d-a45c-bca2.res6.spectrum.com. [2603:8081:140c:1a00:f9ea:fe1d:a45c:bca2])
        by smtp.googlemail.com with ESMTPSA id q17-20020a4a6c11000000b00475f26931c8sm921422ooc.13.2022.09.16.20.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 20:11:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 03/13] RDMA: Add xrc opcodes to ib_pack.h
Date:   Fri, 16 Sep 2022 22:10:54 -0500
Message-Id: <20220917031104.21222-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917031104.21222-1-rpearsonhpe@gmail.com>
References: <20220917031104.21222-1-rpearsonhpe@gmail.com>
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

