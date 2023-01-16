Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE966D378
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jan 2023 00:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjAPX7H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Jan 2023 18:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjAPX6q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 16 Jan 2023 18:58:46 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE882B63B
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:50 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id x25-20020a056830115900b00670932eff32so16978472otq.3
        for <linux-rdma@vger.kernel.org>; Mon, 16 Jan 2023 15:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=GlltBRF5uz2P4HEVmxtrze5HA5GpfOAORg3gC8x3bwt4YIEKz6ryE0hNYD5FF2Q4Dj
         9+bmEEtPpz9T5TQWLHK8X38SKB2t+XwBWqUb1Ax0cM2DuRy2cJIX4emzs4EKXpBKYTNc
         VYRWaLM23hdHLuaiTm7w0UqOefzCQOE7SZeISGKdc/Cs0d2MmRJp9wrFnmvwK3BVJsbt
         YeYb/kwQMlWxrtl9VjT7IbltfKoOf7SUPqTqqOLG7ra3kslXr+weC+Nk4sU4CYtVfOi+
         EF/dGk5MMu+VKsYFCrXXfvrRIiFu7xZjBpbO6vDAUaFdJbzz8QMHnUC8g2MdAtJQnYO+
         5HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=3NfdkJxJe94S/InmBbWYeJRvGayWdM3GWep9dJP8ZmJYYkdKvShds3E6gT92RGqOWC
         pYFiNI31vQ1J3FmcUO9JV0hmqcy0danKnqg5cHiPLr5cL09ZW6FbPB/rs5jfVPl+yX2S
         6+9WTVDRxIA4V3S3yuFc0nCHZ8JrD1yx1cNGKQI/e+LTw9IupPcav18nvym8OocQ1bor
         6CmWGwDscIowwvfv+cN19n7oEHjwWqrRScyiTBr2sHcEmJkmJsapHUpDIlqcE+dH8lji
         SR0JAljzFNb4XOb/YWokW4bbRSA3cYHlxBfZ9jBx07s9pmqkGwElo58YBRQ16Mva7GWW
         uoPA==
X-Gm-Message-State: AFqh2koUSmtJInQOPklzf/qteoJW+gU/6QFri7KcWjvWtQ9r3mOeEZH6
        PECmL+YTEr2u0rVaKzuKHyw=
X-Google-Smtp-Source: AMrXdXu0pp6loWxJOzQIkTDbbH52TAmslxaBpzI7EecLJiDPZ2/C6Fhw98VkVt5h8bd7767CPzygBA==
X-Received: by 2002:a9d:639a:0:b0:684:dc1c:fe85 with SMTP id w26-20020a9d639a000000b00684dc1cfe85mr373806otk.36.1673913409485;
        Mon, 16 Jan 2023 15:56:49 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ea18-3ee9-26d1-7526.res6.spectrum.com. [2603:8081:140c:1a00:ea18:3ee9:26d1:7526])
        by smtp.gmail.com with ESMTPSA id w17-20020a9d77d1000000b00684e55f4541sm3540546otl.70.2023.01.16.15.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 15:56:49 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 1/6] RDMA/rxe: Cleanup mr_check_range
Date:   Mon, 16 Jan 2023 17:55:58 -0600
Message-Id: <20230116235602.22899-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230116235602.22899-1-rpearsonhpe@gmail.com>
References: <20230116235602.22899-1-rpearsonhpe@gmail.com>
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

