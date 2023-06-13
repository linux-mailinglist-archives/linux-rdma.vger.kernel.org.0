Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D14672E8C3
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 18:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjFMQqy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 12:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjFMQqy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 12:46:54 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64BF11D
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 09:46:51 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b251ef7b77so2936055a34.0
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 09:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686674811; x=1689266811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H11khCN7HiFI7dMBdDFp52/ZR8hsMexZR+/Lgoufluk=;
        b=bJgonWMbLvG/8JdM1anszhB2e8LuU/mvQPGfthwPxchmEftLNwKNXZqsYWwaMSQDyE
         egJffCvU/gwjmmuVuQRDadDyYrPiesteGR0F1hmBDLJUBjNNANYchkIF49XPdf907+m5
         wvJ4wZGAXu6gqKlk3cWIu1Rxx0WwEVPs6KLMLWN1sAy6Xa04VCUKJxXEWmd8ypmVavS6
         Zcj/LG/BFAeuh19BXYEm/IQyXtY9a5Uwgw3h1t88PThxWPjf2yG53/+Mz/DoXbEtHF91
         Er35wu2v0n3a8ul/EK15Fn2jNhu2MEggEaIbJu6X/oKoBlIi18bcJASY+G7yCcu1fb39
         ng+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686674811; x=1689266811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H11khCN7HiFI7dMBdDFp52/ZR8hsMexZR+/Lgoufluk=;
        b=PBPMuz3LHByb47JEqbfyS882+9uGPLUP9iI26yPc9RxzZDuUc6N5oF+5HQlWnnyYf4
         5+ZQN+PgnIQqsMe0BHdhzVQ2pO6Kx+WyvZTx2/J07eoZUoey4qaMyHm9tqMbtaP/Qkak
         2U3tI4lP7PEEG2wgBKH9o6lqSN7zy6MopK8A15AXLy6Xbj4SrukEpzzGwa5jv18vQtoz
         AijVjtjcCx6942Kz7nOMxHt5o5GFJDPDkGswFEd69B71d7a7jnOdS1s7rqasb44/NFUv
         TqQ8+JwyVkSo5p68ONt4wd1DlUel2+s091AGPeCv1filaq3DD5zLkRKBsQ20oAotIBdv
         u0ug==
X-Gm-Message-State: AC+VfDxTGFAiVmmpbvZAczzFivc/aNBKfJG/Jz84J+ebOt+1VzYYgRYd
        xBueX0G5D7NaQQa96YsMQLs=
X-Google-Smtp-Source: ACHHUZ4xos/+WRmzzJBC1T41C+9pgay+k1usTT0kxPVnoD6ueQBTDzi1gAbEgXIBvEYSjtvzn6i2dw==
X-Received: by 2002:a05:6830:4421:b0:6b2:aeb7:91bb with SMTP id q33-20020a056830442100b006b2aeb791bbmr10809347otv.7.1686674810810;
        Tue, 13 Jun 2023 09:46:50 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-b626-4062-16bc-09b1.res6.spectrum.com. [2603:8081:140c:1a00:b626:4062:16bc:9b1])
        by smtp.gmail.com with ESMTPSA id e15-20020a05683013cf00b006b2e6a604a7sm2292491otq.77.2023.06.13.09.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 09:46:50 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc] RDMA/rxe: Fixes mr access supported list
Date:   Tue, 13 Jun 2023 11:45:57 -0500
Message-Id: <20230613164556.16875-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.39.2
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

A recent patch incorrectly did not include IB_ACCESS_RELAXED_ORDERING
in the list of supported access flags for the rxe driver. The driver
actually does nothing related to relaxed ordering but it causes no
problems to include it as supported but with no effect. This patch
adds this access flag to the list of supported access flags.

Without this change ib_send_bw and friends do not run correctly.

Fixes: 02ed253770fb ("RDMA/rxe: Introduce rxe access supported flags")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index cb18b83b73c1..f9aa8cd097cf 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -262,7 +262,8 @@ enum {
 				| IB_ACCESS_MW_BIND
 				| IB_ACCESS_ON_DEMAND
 				| IB_ACCESS_FLUSH_GLOBAL
-				| IB_ACCESS_FLUSH_PERSISTENT,
+				| IB_ACCESS_FLUSH_PERSISTENT
+				| IB_ACCESS_RELAXED_ORDERING,
 	RXE_ACCESS_SUPPORTED_QP	= RXE_ACCESS_SUPPORTED_MR,
 	RXE_ACCESS_SUPPORTED_MW	= RXE_ACCESS_SUPPORTED_MR
 				| IB_ZERO_BASED,

base-commit: 830f93f47068b1632cc127871fbf27e918efdf46
-- 
2.39.2

