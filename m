Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5A6477A3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Dec 2022 22:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLHVGS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Dec 2022 16:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHVGR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Dec 2022 16:06:17 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1C6511FC
        for <linux-rdma@vger.kernel.org>; Thu,  8 Dec 2022 13:06:17 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1441d7d40c6so3300690fac.8
        for <linux-rdma@vger.kernel.org>; Thu, 08 Dec 2022 13:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz5xyn+HHMsESLKATTNaUM3la32kwcEnj9qdTxWM0NI=;
        b=lWDOhWj1v2rZZNfOd3HDeSgrL9JigpzT1LnWEMJvvfSo+18DVykOW2k+UfYBhys0sR
         EC2BNWhNGQW3khdj7eoYNDLFdXCu//dC7vOb8I4M4YuUukG98l+aG+yum8uXlocMdX/7
         +jshj4u+8P/QSl1Pk8GhY4PcMZIT9whO/NCU9x9U4TguRPiPdG2diZutla7JdM/ipqZc
         xcRT0NZE8vGhGUQukeEyZaF068mRU1XUHiVcSFvDJZE6pmUWgUMCpcV1KbvFGUit93ei
         Erj/v6xFeHdgfvWWJRMk5m5kArT8SwS+U8Nepys44E2sk+hf+5/f1c1e7JraPb8JCcvw
         llbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qz5xyn+HHMsESLKATTNaUM3la32kwcEnj9qdTxWM0NI=;
        b=xl0IFnHwzu0REOMgZR9IjEs7kpLJfXt9cNkmQMsutIHPPIQIB/CN97As2MssDsdM+o
         40a22oq4ERp5jBbrCfPEIbBrAx+AO/fYtDezKy5vLh+UcBeWxPg0IBnKiVXLfipqL7+N
         +Dmj/tFA8m4xcn0wcrXyPOPnQVbWGhfIjve33TiPeQxEYmu2fhO5UwnbJA6W98NFb0/4
         wS2c7oDU+rSzUacFTziW9HxeNX+/36rbzF4bjieA50pq/9jDwPu4ToA26bHYToTThNqN
         WGkpvoptKKIqMyFQUOGv2ueHW6i8jU0q5MnuOlw1RLx8HGn9UnAV9U5C5LAqAhju880x
         zcuw==
X-Gm-Message-State: ANoB5plO2C8Q46K1damYhuEqhc3Y28fvNJLTI29kx/MfS/IBqnFAxhwS
        EgvNRIhBN0Lw2cXA6LvMERg=
X-Google-Smtp-Source: AA0mqf703yIHmNRAFBfp81hJ8S6uDRD2ipWAnAPoWJHxZt3u1xiQ5Vft0khIC3BdtN2uUkFkHw51VA==
X-Received: by 2002:a05:6870:89a1:b0:13b:a8af:40e2 with SMTP id f33-20020a05687089a100b0013ba8af40e2mr1610157oaq.20.1670533576684;
        Thu, 08 Dec 2022 13:06:16 -0800 (PST)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a13f-9234-e395-548a.res6.spectrum.com. [2603:8081:140c:1a00:a13f:9234:e395:548a])
        by smtp.googlemail.com with ESMTPSA id t11-20020a056870e74b00b0012763819bcasm5739250oak.50.2022.12.08.13.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:06:16 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, leonro@nvidia.com, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 1/6] RDMA/rxe: Cleanup mr_check_range
Date:   Thu,  8 Dec 2022 15:05:43 -0600
Message-Id: <20221208210547.28562-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208210547.28562-1-rpearsonhpe@gmail.com>
References: <20221208210547.28562-1-rpearsonhpe@gmail.com>
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
index b7c9ff1ddf0e..b007ff05baaf 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -24,8 +24,6 @@ u8 rxe_get_next_key(u32 last_key)
 
 int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 {
-
-
 	switch (mr->ibmr.type) {
 	case IB_MR_TYPE_DMA:
 		return 0;
@@ -39,7 +37,7 @@ int mr_check_range(struct rxe_mr *mr, u64 iova, size_t length)
 
 	default:
 		rxe_dbg_mr(mr, "type (%d) not supported\n", mr->ibmr.type);
-		return -EFAULT;
+		return -EINVAL;
 	}
 }
 
-- 
2.37.2

