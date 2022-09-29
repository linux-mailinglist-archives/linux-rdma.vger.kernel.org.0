Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494D15EFBA1
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Sep 2022 19:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiI2RJP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Sep 2022 13:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiI2RJN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Sep 2022 13:09:13 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C401CE915
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:09 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s125so2259837oie.4
        for <linux-rdma@vger.kernel.org>; Thu, 29 Sep 2022 10:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1O4gVNR3dcE8FWJuOdKt0Ng7mhdOLr6Amkjy6/uxb+o=;
        b=kzbA8ADTtAGvWyTjM+f4fINEg6ExVtX1Gm1BpXeGxWqA48H6cfuhv9k6U7H1wctqJQ
         ZFG5KI07m7lK/Hf8Cfh3num+xZrupqM//0OnxoWOXwGVLORTs7DaT3t1BH9WaRMrJ8rs
         LTF+YxUwv0nCEiv9jWkpepe0khTEAj+Mt1f4kv5yHSJOX3fufNci3T2ezFYRkZs96SPf
         E2LeauAr7fNdN6iVMHJdu6FUk9BJaIQCII1RFCPNmgyBuLvXyB9TUQck06Zj9LrPvQT+
         3R4L970IwyHYCiPl1KcND3fZefLn4aYq7OITrmXJmwKtylEr+RKMKyi71VRIMRx5zHNS
         Hmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1O4gVNR3dcE8FWJuOdKt0Ng7mhdOLr6Amkjy6/uxb+o=;
        b=tWXR1bXBeOMLt6EdiTUg6LnjBPuvYRApJmeNYAJDIuK+fX/gXoIPuNvpo4dT0mbC5p
         +W924nLR+g23UnYVmyqhBJ+MqRXocpqNTIdnZaoH4eHiebqLBipbmf4PRotauFKpXyON
         iMNa+2agW15xjCyNwScIABCKhCTNdVIu87b8TnKiiqSp3MzkreDw39Xs2QXofvEyHwOd
         ZL4GLv99DZdz5triNoptsLBSgYsQJMK/XXjFQFnn3MkEBogtm39o++jghD/hYs9KpeuJ
         za4rgcLI0jAUiRY0yu8aJIYgy/gOwLNI4pdWmu96fa0bSkpXjC2hwUi8tBukqNWfs2OP
         TO3A==
X-Gm-Message-State: ACrzQf3Ixcw7A7p3/9FLVjex7dtCk7Qimb3ZUF79kxfcjNKcSZiF4Hpi
        VICCihZfILDxiYH1KpRL2ZY=
X-Google-Smtp-Source: AMsMyM7OJuJ8i/J/iDTTi2w8YjOsCP2WqLlELzMdYqTFhfr10GAMd6CxP/QOeTa1U3pcOVgf149++A==
X-Received: by 2002:a54:4182:0:b0:34f:f1b4:5421 with SMTP id 2-20020a544182000000b0034ff1b45421mr7152831oiy.146.1664471349204;
        Thu, 29 Sep 2022 10:09:09 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-c4e7-bfae-90ed-ac81.res6.spectrum.com. [2603:8081:140c:1a00:c4e7:bfae:90ed:ac81])
        by smtp.googlemail.com with ESMTPSA id v17-20020a056808005100b00349a06c581fsm2798557oic.3.2022.09.29.10.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 10:09:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 03/13] RDMA: Add xrc opcodes to ib_pack.h
Date:   Thu, 29 Sep 2022 12:08:27 -0500
Message-Id: <20220929170836.17838-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929170836.17838-1-rpearsonhpe@gmail.com>
References: <20220929170836.17838-1-rpearsonhpe@gmail.com>
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

