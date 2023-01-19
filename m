Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C506747C2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Jan 2023 01:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjATADw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Jan 2023 19:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjATADc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Jan 2023 19:03:32 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0369FDCE
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 16:02:51 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s66so3115533oib.7
        for <linux-rdma@vger.kernel.org>; Thu, 19 Jan 2023 16:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=BcMrZysQxZWL+p7w1cw2QXid52MVQPSK66P3CgeIg5oF9A1XqPbEMtGnYx05OlAZyd
         2LPIWz4o8HpoabCQlqL+WmfJlSZDuVd9NSVfY1ecH3DnBlPeZkTic8Q7SHB7/QHGgt/3
         7WOz4fPC8+OLleELg8gXUFMDQ8nuzLX7HKCd5sHpIAyQCqbP/CgFqwXfSzOl+7bcTcm1
         aTcEsGn8WeyjK7eRGpjYkiJkMvyCvOjjEPlfSNSW+WSyRbT1EbA6ewx28YTxF3wfSs03
         9IdlZqmytBdWGTgTmWEzPT1GBswjOtQTAFZjbaLH1YSL6k+Zhd7N0wJUUWrMxcrNHnA9
         pxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=npgViKhEoINsh8hMZqGLBHKc1T/YFDYtBk6zJcOqtBeN24Z+6qbpZ9/fxwPcQzsofo
         gAuTos/pHfaHtgQ9OwXKUYPP12nE/Cxf+zQiAg0UsadiWyUXYV6x7ayjV2jdrYiBnpQf
         A54iDnRBErlTpeDokDnZgjuC4KLUvjAS3cISL6Or62SPC7y3h5XNMNcVE1aV5GCh01K+
         tYTl6UhwvGD2S2uRLmMELWBvSKBxBv6bfIy8ToWLlmo0mF/Yx7RqKVdQjyvGtFfdRrtS
         UwO26CP3tpXczAnvjiPzXepeoDRkHiF3F9TkvRNeudBsCtSZdB1HhNDa3LCaKAbgDo/5
         sVOw==
X-Gm-Message-State: AFqh2kryhYU3xutF/u1PmnG1oS6a91w0U/6iN8oKLW0FsCYfP7XPyIjB
        omuQA69zPNCTTxRWnXzYrsM=
X-Google-Smtp-Source: AMrXdXult1mRe2NxXOb8q+gwvbZ2eOKu5ffMfDGhKvs5T1bbz0lSr43ivc4YAxt08YrsORI3KLqPYg==
X-Received: by 2002:aca:1902:0:b0:35b:7145:2bd5 with SMTP id l2-20020aca1902000000b0035b71452bd5mr6328219oii.16.1674172970328;
        Thu, 19 Jan 2023 16:02:50 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-d086-74d8-5274-c0f1.res6.spectrum.com. [2603:8081:140c:1a00:d086:74d8:5274:c0f1])
        by smtp.gmail.com with ESMTPSA id bj23-20020a056808199700b0036718f58b7esm6139394oib.15.2023.01.19.16.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 16:02:49 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leonro@nvidia.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 1/6] RDMA/rxe: Cleanup mr_check_range
Date:   Thu, 19 Jan 2023 17:59:32 -0600
Message-Id: <20230119235936.19728-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230119235936.19728-1-rpearsonhpe@gmail.com>
References: <20230119235936.19728-1-rpearsonhpe@gmail.com>
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

