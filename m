Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D446C66885A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Jan 2023 01:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbjAMAWb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Jan 2023 19:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbjAMAWA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Jan 2023 19:22:00 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858E25E096
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:21:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r132so6049295oif.10
        for <linux-rdma@vger.kernel.org>; Thu, 12 Jan 2023 16:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=kBmf7ahExAxqdJPRr2AX4wg73QSbAzyCasvkSymaDhmk9C2lxzVD4VsulPixhiavBZ
         yEV902aTlu+ZsrpYTNoqNv8QhYxTg+juvf8dzj+rS4yKOa7SDmvcw64txafIsFLEaKCT
         fSV+zbBkLw2vVnulyCZj1Gdz/zWAUTWniZFRc40SNqu1A7WSnGtR8nDED1KzY2q0rBM3
         g93Srw6fVihQeYrR/rlQL//HKFO857hGZ4PbFyLgIhvmQ3OcKBxLRVwPEFjxvgngmLvu
         R3Fgo07aSJd21DQRYRzqs3jDO1BVTv9dj4C/4EfuwLYnZlA3n9x2Iq7klYlty31zy5yZ
         1GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=6Gu0SCdKXrpq4UDJ+IBumiz6F27qU2s1fO5HYYcDacDmv5BNAfrIxPlQDKuyRhtKo3
         Xb9BIGYJuXTr7ZdT2BzHfvP/iYaQ7gCnBLNmy3RHBtOfwNw7YcPvNu61s6hWf2G/vilY
         yO1i0sYayFtbmR6jy9+JskkfbviGqenBbEE6VrT9MxpRlp0fPJUvOTJLk/HoB/FElEgf
         ekukYupMe14zOD03VqGt7CrOdSlWoIVwpsGiDc9PLCVvXwuR83rPEWCWxZhhCF2Z5LaW
         jzH5o1jv1fEduP/n56DFG1YGCAry0U5SM4cYhKXxm9AM7JqVnE9i+eCCc64ubq3w4Qbm
         1gLQ==
X-Gm-Message-State: AFqh2kqsAQYcCG5ptOU1pJqU4LXZmmbNAx9wGGjP+dgvTuxPUwnAXX+i
        H2Rx8fq/jluW+v8PipGuESM=
X-Google-Smtp-Source: AMrXdXt3Vqiq01BHv4ftm2FvLDCQ2o+5XnypeOojctcjeOMJiN1aYOUUmZ1ymn/X+5J7TCPqChaw2Q==
X-Received: by 2002:a05:6808:158f:b0:364:6259:be35 with SMTP id t15-20020a056808158f00b003646259be35mr5218392oiw.46.1673569317908;
        Thu, 12 Jan 2023 16:21:57 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-550f-93bd-b210-47c2.res6.spectrum.com. [2603:8081:140c:1a00:550f:93bd:b210:47c2])
        by smtp.googlemail.com with ESMTPSA id z25-20020a056808049900b0035a9003b8edsm8480471oid.40.2023.01.12.16.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 16:21:57 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 1/6] RDMA/rxe: Cleanup mr_check_range
Date:   Thu, 12 Jan 2023 18:21:11 -0600
Message-Id: <20230113002116.457324-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113002116.457324-1-rpearsonhpe@gmail.com>
References: <20230113002116.457324-1-rpearsonhpe@gmail.com>
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

