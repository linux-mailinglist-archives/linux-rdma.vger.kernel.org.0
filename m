Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4141CE56
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Sep 2021 23:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbhI2Vof (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Sep 2021 17:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345966AbhI2Vof (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Sep 2021 17:44:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F914C06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 14:42:53 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so4718676otb.1
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKL2rx4Se7LRynbifpHicrI0FvCrVSYu9niLii4bCRQ=;
        b=axQYjN4VYIV4KTCI8sepZhr1MMHFbIhq56kkCQIBNxKUJ/wGRGlHEaVEZWcDvNt1AR
         Ftuhv5C8LMw5pujhNc6XaUOX9SI93zgGfbFBPMiGp6fLfCy3LoHm//dArhPjc1JTD2WE
         5d93gX7/xJalhbc05TXFmpiReHoSdhHWtX0n9M9onIVmB4VYMD1UVkqZE7avPtVzGAZ0
         b/y8ONfdrjUvBEf35tj+F4Wwx1ghSCfOPMyZk9GCPBpx2amd2xs0ICOsuE8DR7pkWYlk
         tTSxTbDOiBTi7JXmAv/YFOJnigJT49ZMU5D8OFHsJ5DFZWFN4CGNPP3XysX1C30hYDKq
         +uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKL2rx4Se7LRynbifpHicrI0FvCrVSYu9niLii4bCRQ=;
        b=iu1CZR/ih7Xa9Kjz0PVZozsN/AMAwh9oR0tkscWa1752v78mUnoEGC6ClwN2F1Am7T
         aunopIDAS5+FqYvFaYQYneCu38mbYHf9nlGOiE3hD7o+UKFw6vTOKppiTHnfzX8rjNT3
         kcmgkGKotf04z6FQqgbt8N5EI5fyyNsugXRetKyB6wRHa4/RfzsESDLgWttH3bzTbpBZ
         /CyFq2j+dHTKGJvL13wW100O5XAQJ++NGwjeFsA0BIqedu30Q2151EURNeDL4u0pcCRq
         O6ILiW7Cm1lR2F2ddXMxWNC7z4J7nUolfuVtmwBGXdz2Ys09hOEMqgPXXuj2x/W0IEQZ
         X1Vw==
X-Gm-Message-State: AOAM532Pm1ktGVAkZBbmgDtRaZZeINXxA9wuzcbuZq1M/pTCgVYhDswW
        GhtwXK78lQvY7xiXczQuFOqDtvvayUJ4Xg==
X-Google-Smtp-Source: ABdhPJyXmMoA8KcIX1QH5FaQSppjbzs6lMC3QVXIRWhu+rewTOBmm/L0l1HxFlUPW410ZEwYoGlFeg==
X-Received: by 2002:a9d:4c11:: with SMTP id l17mr2028731otf.106.1632951772212;
        Wed, 29 Sep 2021 14:42:52 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-81c5-5403-9877-a213.res6.spectrum.com. [2603:8081:140c:1a00:81c5:5403:9877:a213])
        by smtp.gmail.com with ESMTPSA id v16sm187534otq.6.2021.09.29.14.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 14:42:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com, jgg@nvidia.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH] Provider/rxe: Remove printf()
Date:   Wed, 29 Sep 2021 16:42:15 -0500
Message-Id: <20210929214214.18767-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rxe provider issues a print statement if it detects
an invalid work request and also returns an error. A recently
added python test case triggers such a message which is expected
since the test is deliberately constructing invalid work requests.

This patch removes the print statement which has no practical use.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 providers/rxe/rxe.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/providers/rxe/rxe.c b/providers/rxe/rxe.c
index 3533a325..42fc447c 100644
--- a/providers/rxe/rxe.c
+++ b/providers/rxe/rxe.c
@@ -1513,10 +1513,8 @@ static int post_one_send(struct rxe_qp *qp, struct rxe_wq *sq,
 		length += ibwr->sg_list[i].length;
 
 	err = validate_send_wr(qp, ibwr, length);
-	if (err) {
-		printf("validate send failed\n");
+	if (err)
 		return err;
-	}
 
 	wqe = (struct rxe_send_wqe *)producer_addr(sq->queue);
 
-- 
2.30.2

