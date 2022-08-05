Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C723258AFC2
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbiHESde (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 14:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiHESdd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 14:33:33 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAE57AC2C
        for <linux-rdma@vger.kernel.org>; Fri,  5 Aug 2022 11:33:32 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-f2a4c51c45so3784310fac.9
        for <linux-rdma@vger.kernel.org>; Fri, 05 Aug 2022 11:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3lhqZ7f3OfTRU61o40fcFUP92WSD3WP4nWFJ/OZsNLY=;
        b=p6mvyfgbrfZQa0jAPCf3ODqa1X8fOB2vmy4xSGx5BVsx+xCeQmaa7YAdUrd+DXHc8x
         ibXjosr6keIrPIbd4XinsOaKOYR3Gxdyi6AlMItsbRLFHoYKqq6cEoiD8OMbSMC7lb+S
         /cpdXdLQ6nI+6tTMuBAimeqUO+wtc9NXNKukHEb6uwInmpDTgTDsbiVhNPucolkfOEtc
         j7Uy4dJg4uN55zV/kNqxjjRivIkDa+L4uP1JGPvF6ZwlWAvzV5qqdTLpVF3N/oJn8NMs
         GrQHgXcFv4AVMUejKrA1X/g/F0CCuv5IIfeN3uftTGlfkJmOw9uuvn/Zh/sRgaEcJ4MK
         OWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3lhqZ7f3OfTRU61o40fcFUP92WSD3WP4nWFJ/OZsNLY=;
        b=5Dh2tEc0CXl09iBw+Sl7brxucfCEmuf9bjvGePh10E+RyLvHD5SCBUaoPhv0TrobvD
         cpYYM7vxF0rAoFRo0VNYPjnWPYPNB6kfFSlkwkCMzRmSL65/ksycsxldznEMlaTOlmlT
         kcqt5VUdmtFN2//zDOjLpp0FNR52e6xQPhtrkxQH7MfddyFmts6+IDhKGyhWmhDIJVDH
         jIURWKhvpDYr+/87HTkXP7MmXYsv2YW4A6xRmp0qOizbKDnPylVU77fvFW8XqYlTsQJE
         cat1zQA7kk6+hlj93FY/uBm+qdUQonV4skoHBLochPZ3KmGi4AZSBqEPFw7I5/7/V5i2
         rbJA==
X-Gm-Message-State: ACgBeo28IRbrtVFaGLwEePQBXsDivSkH9dQ5dAT16ZWXnxBuuibrY6GI
        R/K4IwsnGn5zshQq8Mveva4=
X-Google-Smtp-Source: AA6agR6/XgikDgUpu8lHDSSOxRTOBJZjxTn80fCa6wRsclwCXEMkxp9DoxV5Ty5akt/KYrwfomHIUQ==
X-Received: by 2002:a05:6870:41c9:b0:102:820:ac9e with SMTP id z9-20020a05687041c900b001020820ac9emr7412251oac.167.1659724412365;
        Fri, 05 Aug 2022 11:33:32 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id w9-20020a0568080d4900b003352223a14asm761145oik.15.2022.08.05.11.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:33:32 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v5 for-next 2/2] RDMA/rxe: Test mr->umem before releasing umem
Date:   Fri,  5 Aug 2022 13:31:56 -0500
Message-Id: <20220805183153.32007-3-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220805183153.32007-1-rpearsonhpe@gmail.com>
References: <20220805183153.32007-1-rpearsonhpe@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In rxe_mr_cleanup() test mr->umem before calling ib_umem_release()
since in some error paths it may not be set.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index af34f198e645..f0726e8ee855 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -627,7 +627,9 @@ void rxe_mr_cleanup(struct rxe_pool_elem *elem)
 	int i;
 
 	rxe_put(mr_pd(mr));
-	ib_umem_release(mr->umem);
+
+	if (mr->umem)
+		ib_umem_release(mr->umem);
 
 	if (mr->map) {
 		for (i = 0; i < mr->num_map; i++)
-- 
2.34.1

