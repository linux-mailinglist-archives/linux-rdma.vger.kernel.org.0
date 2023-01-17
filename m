Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E5C66E4F1
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjAQRb4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Jan 2023 12:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjAQR2R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Jan 2023 12:28:17 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EF749039
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:01 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-15f64f2791dso2393336fac.7
        for <linux-rdma@vger.kernel.org>; Tue, 17 Jan 2023 09:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=CaACOsLCh/oRFowdYNTUO0wmPkubn8jNVqHU3Pxwc0PeR1ZxlH+8iYJQIuFvr/saOI
         u9h+CT1JigXz+rTk1QQvc9Zv7QA1aU/UaQ3AgJnwZFPGD79gSijiol/EGBXtUEj15fYA
         M5GS52FVwnB3hStwBI1E99x3Np44aWh191U4nHvBWgmsyg1jsAjRO0bMfnDgod1RdXDH
         +cwGby+Q/GiktLO4Q5Z3QgHjjZwFLoegtRIfFBlYxBPxSRYtlHGyXIXuZbCw+bUoRJoW
         xMa7L5Yh/+AG3Zu7gX/7qFTmdOtwtubh7HWncAxboaen1q1Bdd4J5xbkKxmwB2JY0kFz
         R7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=V/wpLE+rZOm8Q/P5WK/Tn/uQnaUN2PSSPHU/hTOtiNLcPBfckVi0fbBe8XRbxKQftF
         kccPlP+A2Ck7Qeo33qGgifnTFTPXujAUZgp3uxo3TXFJmgToIl5/BzuCcgPT7OiZ/rDV
         KETATUevBUOiWNi+3MQVtFGjmWUSYcTkVMZ6vunyV1HwG3+do3aAxa2WJrmkhIvg9EAg
         ptQTyWwZo+KAGjGHwXzmevJAHJrvbMlZFmfkSw0W5oRsv2kx0wg6Ftvx99/8I+QvFcuQ
         bBvQy3B5pzkrhdaIF0aRNiYTqZ1knr2K9JU3RIFmdqVkM1/rwzuTvHTv9tdbm3OyIodS
         0vFQ==
X-Gm-Message-State: AFqh2ko/clv1yl0+GnbKZlAow5y/ItzQOMIBZyBM7DHnl9ZFjaSMtvfD
        n882QUMO54MrqzG8SeaH8d0GmciXReaJCw==
X-Google-Smtp-Source: AMrXdXuXqOtNZvRBLb/SDKGxOzOQd+FZn1PcEJWftvV5Kfx9FvtTxyxM0MNngZivGLM7XrZBjaLs0g==
X-Received: by 2002:a05:6870:a1a:b0:158:7b1d:e9a3 with SMTP id bf26-20020a0568700a1a00b001587b1de9a3mr1478896oac.6.1673976421134;
        Tue, 17 Jan 2023 09:27:01 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id l3-20020a056870218300b00152c52608dbsm16936489oae.34.2023.01.17.09.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:27:00 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 1/6] RDMA/rxe: Cleanup mr_check_range
Date:   Tue, 17 Jan 2023 11:25:36 -0600
Message-Id: <20230117172540.33205-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230117172540.33205-1-rpearsonhpe@gmail.com>
References: <20230117172540.33205-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove blank lines and replace EFAULT by EINVAL when an invalid
mr type is used.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 072eac4b65d2..632ee1e516a1 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -26,8 +26,6 @@ u8 rxe_get_next_key(u32 last_key)
 
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
-
-
 	switch (mr->ibmr.type) {
 	case IB_MR_TYPE_DMA:
 		return 0;
@@ -41,7 +39,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 	default:
 		rxe_dbg_mr(mr, "type (%d) not supported\n", mr->ibmr.type);
-		return -EFAULT;
+		return -EINVAL;
 	}
 }
 
-- 
2.37.2

