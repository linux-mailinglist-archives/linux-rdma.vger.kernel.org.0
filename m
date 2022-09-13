Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC735B7D17
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Sep 2022 00:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIMWb0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Sep 2022 18:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIMWbT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Sep 2022 18:31:19 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8FC72B50
        for <linux-rdma@vger.kernel.org>; Tue, 13 Sep 2022 15:31:17 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1279948d93dso36064482fac.10
        for <linux-rdma@vger.kernel.org>; Tue, 13 Sep 2022 15:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tkaqMMw9p3X0dL/zjpn2XBuFPYQIcYLXNkKokBG+6u4=;
        b=Ic7wUp1lvJrgo+v4QvL6wdrBgjpWeXzvjTrEI1axt6EE7OjtEDp1oXG+skSTiINLDY
         ENskBCuVlXKAx9gc7ztwsXjoYHhmUHL6T3D19cqKJuw3hJTBU/SB3FqeMmxYz4BNxqiH
         VTSuNWzSDVswJ3wgy64c2ZIkCFimMUUg3dIzV3+yJi1Cr2JNpis5jasPk3VQEpZxNq+C
         n34gEwqKtdYgWjewDe+q/yuJXIj/4WrjccmeKg5JH8mPEJmuVmogRKQH1jDHDTW8tkjl
         8R0nD9gBNAzz7fg5LtVNudPY/JU4TIOLaK1A4ggX0ve9a/iRXAFxqyuK2Ug9CsqiB+Pk
         e0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tkaqMMw9p3X0dL/zjpn2XBuFPYQIcYLXNkKokBG+6u4=;
        b=UxW+ZnfkduvrB9S9heWBWD971Egavraf9dEvDFlh5I7SfVzLywAAKwUMhxT5oJq/TT
         qPaXTKrOsCsH6ZKZ3STE7WHrzvuY1M06AoLV7gHAQk3BZo6hicjHmm/I17HEZ0doUEnQ
         DEggOq2t9uXtILXr9J7mWaa5di/a8qVBpchMgHn4jnOQgximJrhrjxhfF2D59gxO7FQL
         99hiP7+hTs2kqTbUNBYoPcGJSscdckYf9UfzAvTTlcCNKNkLnuXwCrXXY6mH0WDWqFQM
         vmhWx3N11/DRXOjMaT1ltCVm0li6l13Lf6vyx78hGCXpTGCPHugjIdS3GnhmGuB+kQxy
         HMyQ==
X-Gm-Message-State: ACgBeo1DJlxAwWHNobts5+hffWK8aCCKssoO8QO76CMl303XQDw/HKVL
        ZRjBa5ho5RUQbyCSPpBe/CJ0eiwXOag=
X-Google-Smtp-Source: AA6agR4YwH6pqP8yn19+wmhiwvALEHKaf0NFu+ixDB4zh1eAkAoGzCwyFdqWtoD2ZsBrqNaLlMNwqQ==
X-Received: by 2002:aca:220d:0:b0:34f:7312:f1f with SMTP id b13-20020aca220d000000b0034f73120f1fmr674548oic.4.1663108276484;
        Tue, 13 Sep 2022 15:31:16 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-d098-9475-e37c-b40b.res6.spectrum.com. [2603:8081:140c:1a00:d098:9475:e37c:b40b])
        by smtp.googlemail.com with ESMTPSA id v17-20020a05683018d100b0063696cbb6bdsm6537131ote.62.2022.09.13.15.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:31:15 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 1/2] Update kernel headers
Date:   Tue, 13 Sep 2022 17:30:50 -0500
Message-Id: <20220913223050.18416-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913223050.18416-1-rpearsonhpe@gmail.com>
References: <20220913223050.18416-1-rpearsonhpe@gmail.com>
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

To commit ?? ("RDMA/rxe: Remove redundant num_sge fields").

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 kernel-headers/rdma/rdma_user_rxe.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
index f09c5c9e..73f679df 100644
--- a/kernel-headers/rdma/rdma_user_rxe.h
+++ b/kernel-headers/rdma/rdma_user_rxe.h
@@ -74,7 +74,7 @@ struct rxe_av {
 
 struct rxe_send_wr {
 	__aligned_u64		wr_id;
-	__u32			num_sge;
+	__u32			reserved;
 	__u32			opcode;
 	__u32			send_flags;
 	union {
@@ -166,7 +166,7 @@ struct rxe_send_wqe {
 
 struct rxe_recv_wqe {
 	__aligned_u64		wr_id;
-	__u32			num_sge;
+	__u32			reserved;
 	__u32			padding;
 	struct rxe_dma_info	dma;
 };
-- 
2.34.1

