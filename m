Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629F866D20D
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Jan 2023 23:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjAPWxs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 17:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjAPWx0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 17:53:26 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D45328868
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 14:53:09 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id i5so6321249oih.11
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 14:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=CQiAquaWD/qixzw7ZE/zGrIC/taAPph0Iudxa6A7B3wGYRIv2lQAckPvl9DFUPPO4T
         Dhjt+2QI045ee2HpcItH9kaw9gQeabMbbi7u2d2tBuY+3vab7eqLrdUtgCCEHC0wXcQS
         dsJP6DNMfS1coRmUJvMePk/S3vfRyYT9Qd/xYcC9KFrM9BX2lfz8IkfIzJDqQsWtBPyJ
         1aqwYBwyNcGx8lMG5FlaBBdiWspvwtVjIXdyfS6b5Oe1sBFD222sn1gc9XVEwzZxKBQl
         /+q7iZD2LC0Y2XLzaIeqGqdBJIuuLOCc+cy2DWXp3djBULiYt6pf5vhNKnf09umRqQ13
         SmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=ry83jDiZ4oAJp5B5a9O7F+E/xd9uMviAjKp7iK70AN2B2JiCdH94drf8cnRxVi62Av
         WrgHb+hPiPxeZeTC+WK/fkvSQ/WNPjnzKEUi1B9WLArsKyLqiKZYgL19hj/wjw80x7lY
         oGLOtoYYrjmxcboM4efCfbQfzagHpjRepf0VhnsF6XQQp+fGlWYbZVP5T78ClPbi5ioM
         itCMlQyDSpby/8g9h5hkzStIn6zkW7GbW6+w45P5WMZpj4tkDQyZnSZN3ylioyYVG98+
         XDTKdDmsmTSUzWTXYlxIAceRq04Vl7K40v1BkI+8KeeE1RwgLNyY8C8LWmA25aZv8DSy
         FQ+w==
X-Gm-Message-State: AFqh2koVKrkoo615rKWaSVNs32R50isNjzmbputdpPtN377TLQIPmfFl
        f/QxrP1kOjZ7DJjoi9G6Q/s=
X-Google-Smtp-Source: AMrXdXvH2IloXJ3HWrabd6e2loj5wB1wmkfZVO3sZ0JYvDf78OuIMSXABTZMMawfia5ot9ayX8oNvQ==
X-Received: by 2002:a54:4816:0:b0:361:25e8:c6d8 with SMTP id j22-20020a544816000000b0036125e8c6d8mr482424oij.34.1673909586923;
        Mon, 16 Jan 2023 14:53:06 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id s4-20020a056808008400b0035028730c90sm13651937oic.1.2023.01.16.14.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 14:53:06 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 1/6] RDMA/rxe: Cleanup mr_check_range
Date:   Mon, 16 Jan 2023 16:52:24 -0600
Message-Id: <20230116225227.21163-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116225227.21163-1-rpearsonhpe@gmail.com>
References: <20230116225227.21163-1-rpearsonhpe@gmail.com>
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

