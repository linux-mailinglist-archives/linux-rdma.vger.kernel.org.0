Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEF66A70B
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Jan 2023 00:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjAMX1e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Jan 2023 18:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjAMX1c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 13 Jan 2023 18:27:32 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB38CBE3
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:27:31 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id d2-20020a056830044200b00684cc404c8aso2515234otc.0
        for <linux-rdma@vger.kernel.org>; Fri, 13 Jan 2023 15:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=NyDGqZHEiXNsR528nGJqXh3t4914oG0RdRug3tiug4SCBdNwiI+d39jk60VwmMKlTG
         rYd/RF8R14lyCuui5gblcC7dIGV5b5Xo3OnX9IH9AxYwmiNQFy5h28cJxUc/KZF0e7wE
         wHjHWRcOWZfyiWVqgCj5dFpi7okTxnelvH7zxA5vwCvQUI/F6ced50dgq8fbbWTA6eJs
         0xfncSKpyEFSVBGEbSZa9G2UTZLD2Z1jiDc9luBxfinqRDCkwc4chtFPURj1U9M0Lxv9
         LT8U37Zi9LJOtiBW/4el65yrhxr2ScSJjOLQ06afZAT6BpQFx+0S98HCpIcppM+BLGc8
         MmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFVv+FTu2viKrddF8zqbqpZJ1cote5/OKzz+8VqeQLQ=;
        b=ENEqWmm+nBfDEiNrI3OQLq0j9hxUroI/dzSFHJPGOmyPDlvxfP85K1OREyZKF4VKd/
         PKYzug8Wg0bw4XAFT4UgHzQNt4laiwJlwzDx1QbLjl45jVD6e4aM5bRbvswLureiHhFw
         NzLUJFWgicbIj2hpBurSZDAUXCbteFoZ8Z2k8axzko6UCIIUrS+INJfDxOkpZWT1zqzG
         MAHVYU23AX2kDLtORG88sXO0yYIHrIAP0ed0MrqxeTzbQy7fcXYG83eUmy9uTUM/XS2/
         Dz5A0jK+3zLJVLZYcNwc3E5pmovd9Nc7bljqW504sNNl4QVWOi1Dt8AKUjkaNz0xkOPC
         YnLg==
X-Gm-Message-State: AFqh2kpKyKPFt2QCCMCiXFmFSiP1yuDMX9DL2CBziA2xu7YeSo6avNXw
        y3CjGh3QIycZij1a/nD0vHE=
X-Google-Smtp-Source: AMrXdXseiMVoeqJkocKLEAtCL5b7VZkM5pdXOZEKEaqlnXLek0psf9GsUGoVGSZ7D0bcrZ/ZGFfu9Q==
X-Received: by 2002:a9d:61d2:0:b0:66e:a0ea:674c with SMTP id h18-20020a9d61d2000000b0066ea0ea674cmr40575268otk.1.1673652451144;
        Fri, 13 Jan 2023 15:27:31 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-3f47-8433-ec70-f475.res6.spectrum.com. [2603:8081:140c:1a00:3f47:8433:ec70:f475])
        by smtp.gmail.com with ESMTPSA id q13-20020a9d57cd000000b0066871c3adb3sm11297433oti.28.2023.01.13.15.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:27:30 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 1/6] RDMA/rxe: Cleanup mr_check_range
Date:   Fri, 13 Jan 2023 17:27:00 -0600
Message-Id: <20230113232704.20072-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230113232704.20072-1-rpearsonhpe@gmail.com>
References: <20230113232704.20072-1-rpearsonhpe@gmail.com>
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

