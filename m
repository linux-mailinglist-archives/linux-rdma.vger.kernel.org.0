Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675EC607D9A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJURfJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 13:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJURfI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 13:35:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210A9A290;
        Fri, 21 Oct 2022 10:35:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so6036521wrt.11;
        Fri, 21 Oct 2022 10:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L//Wieblo+p2SGcpxf4C8N8iwGJJZA437EZKxzdxE5c=;
        b=c7QSuv7iBp5wBrkef3xhwdcZzBUk7O3yFsXRHdNkIwZRAgDvjtzVu3lTez4Or0vyqZ
         5srXJJ+CRE3E1YNzid2s4Md7XF+aRPkxl6K6NALoeHYddEpW4VHZ04RTPBnnp2PX0EZU
         +qSojd6H9nT4wHskzFEaa9LLw+Xqc2GyohDTnJYaSg0okXfDNoEea1f/jiX48iSzMHyO
         SiX5Sa2HbS2v7CjuJkBHKOzHxYpvBOvOeKYvCEE1sOjjA3Pvio7YrU86gea29CMgYS8Z
         T74fs5CQ8RzDLttl668kRmYZg/P+hiJZfHttqjmrQ0NEe/1nwgIm3TUSqhDljjSlhlEN
         4RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L//Wieblo+p2SGcpxf4C8N8iwGJJZA437EZKxzdxE5c=;
        b=2DyxTja42MTzDFn5tLwsjk8ncNlkmRce/G1LjiIQaSjTCHOawlAsNxHQMq5inkTVd+
         2QbLKzt0vNJMf3nY+piRf4tM1BHyzp1ub17OdF70uwPimPhXK5S9hcpcu+nmDuXlcsNP
         R3kT+kl4l9QFk1M1jXFjr4LkPG6QJXSf8TsNEEA5VjTKvz5ylMVWDE8I/NJV9acVWc2h
         XfNa4cl0HnXgZpI6jXaEairibtZAIVlQNOGIbsV/pqzZqhadBiD0u70EY9evyYvqFbgh
         60jyVjhYIYF9tKuvh0JcPd4ccSQV2rCXx8z+GLe/2xHO32L5l0GnD1HpY43OsF29Ts8R
         DaGQ==
X-Gm-Message-State: ACrzQf0pgefLmCRxyo9cLPzYuDtcLWlf5r/+GFmMUzaFbD6RDILXaLOJ
        +MqsXFr/WTdqvIM4+5uMe1Y=
X-Google-Smtp-Source: AMsMyM54AR9BJUW9TsivXYlyV1jmFLZIEQsnfKPiFn3aRYGaLVXlfmLDEFGSkuGG5WBbqHLN6o+D6A==
X-Received: by 2002:a05:6000:18ac:b0:232:c7c1:314f with SMTP id b12-20020a05600018ac00b00232c7c1314fmr12382847wri.109.1666373705721;
        Fri, 21 Oct 2022 10:35:05 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e38-20020a5d5966000000b002252884cc91sm19436118wri.43.2022.10.21.10.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 10:35:05 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/hw/qib/qib_iba6120: Remove variable freeze_cnt
Date:   Fri, 21 Oct 2022 18:35:04 +0100
Message-Id: <20221021173504.27546-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable freeze_cnt being incremented but it is never referenced,
it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/infiniband/hw/qib/qib_iba6120.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/qib/qib_iba6120.c b/drivers/infiniband/hw/qib/qib_iba6120.c
index aea571943768..23a81edf3f7a 100644
--- a/drivers/infiniband/hw/qib/qib_iba6120.c
+++ b/drivers/infiniband/hw/qib/qib_iba6120.c
@@ -799,12 +799,9 @@ static void qib_handle_6120_hwerrors(struct qib_devdata *dd, char *msg,
 			hwerrs &= ~TXE_PIO_PARITY;
 		}
 
-		if (!hwerrs) {
-			static u32 freeze_cnt;
-
-			freeze_cnt++;
+		if (!hwerrs)
 			qib_6120_clear_freeze(dd);
-		} else
+		else
 			isfatal = 1;
 	}
 
-- 
2.37.3

