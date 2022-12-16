Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF8864E8E3
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Dec 2022 10:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiLPJwh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Dec 2022 04:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiLPJwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 16 Dec 2022 04:52:36 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D408547325;
        Fri, 16 Dec 2022 01:52:33 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g1so1437581pfk.2;
        Fri, 16 Dec 2022 01:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rWshI90xMzDUIS1AOWubI86cljSuh0fWw5xZsMVvuLs=;
        b=P1+R1ohOAFjqmlJ+2eyMKtgnCN3KnsH9SpGn1HGKxYhA1qcAA0jGu8CJF/lCWqeNkb
         JcV9Lo8MXNRRfO2S9g1DHqKow9iyILSVsBASW31mAGkdfOH/SH85XIZfnV8kXyps0XMm
         Ibh6PQWDQQ1/s716PCMX54atsVIySZSO3Y0uVYflL+CFN5M5VduYB935oZ+d9uxwJpwq
         h+m/aw/rR9I5YT7xzBonK/GpIpBJElGPP7XAQ04b6lPFxervOwHYi3ElArY+ETCBnmMn
         txfmCS8G8V0fzWqqh6o2oTU52hGECkeokRP1XhnUBwXb09Ow2iHRpiUMPiElqxtvdMas
         B5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rWshI90xMzDUIS1AOWubI86cljSuh0fWw5xZsMVvuLs=;
        b=LO0niTj1zjUZEELE3bo6MV4qaCZFQP1uZrFLpoldZKL8NDQSTD87ebc9bul6EtDYKj
         uNvDoRfDabNiik4BgwAV4h/YIHNhJ8MFK80/MVZcEEKVzU2xlUOeQbnbgPb3Gl4OEGNw
         0fxEswg5wqfV840XpUnhztBoDgVGFjyLGneGIM+n+H37cxnWL7qWMv4fLnPz9TsHBUjJ
         aUWaMQQBptBLf5wkF8Dq96ZxktG5+4G9tsNSxFBsSApAy7BQqwJlQt/t+DNpiI9RF/SL
         /e250vswAZzYlEWlNGJkTsf48ndNdsY9G+XX5io3w0xaHmRzVoqFUaWq0mKlANn6L5jm
         7Mog==
X-Gm-Message-State: ANoB5pkpWF/igjKhfBcxwPMUZ33GrWFubRMvEw7ZuqhtvJ1hnoIrE1pA
        6mjjgRag7ctGI+JyDgSbGF0=
X-Google-Smtp-Source: AA0mqf4Yh4B6irBG84Rf39lk8yY5OoPxbx2hlcvQ1+Dj2m5oixUjuI96RkfCqSAVG9M9+L/z9pTP9A==
X-Received: by 2002:a05:6a00:1d04:b0:578:8533:9573 with SMTP id a4-20020a056a001d0400b0057885339573mr18148378pfx.22.1671184353285;
        Fri, 16 Dec 2022 01:52:33 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id v10-20020a62c30a000000b0057ef1262347sm1074040pfg.19.2022.12.16.01.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 01:52:32 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] RDMA/hfi1: Fix doc for hfi1_free_ctxt
Date:   Fri, 16 Dec 2022 13:52:25 +0400
Message-Id: <20221216095225.685353-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fix the typo of hfi1_create_ctxtdata.

Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/infiniband/hw/hfi1/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 24c0f0d257fc..62b6c5020039 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -464,7 +464,7 @@ int hfi1_create_ctxtdata(struct hfi1_pportdata *ppd, int numa,
  *
  * This wrapper is the free function that matches hfi1_create_ctxtdata().
  * When a context is done being used (kernel or user), this function is called
- * for the "final" put to match the kref init from hf1i_create_ctxtdata().
+ * for the "final" put to match the kref init from hfi1_create_ctxtdata().
  * Other users of the context do a get/put sequence to make sure that the
  * structure isn't removed while in use.
  */
-- 
2.25.1

