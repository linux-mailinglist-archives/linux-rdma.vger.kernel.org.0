Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6760272E93C
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jun 2023 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbjFMRTC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Jun 2023 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbjFMRTB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Jun 2023 13:19:01 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B521AC
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 10:19:00 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b2d8b5fde6so2080389a34.2
        for <linux-rdma@vger.kernel.org>; Tue, 13 Jun 2023 10:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686676739; x=1689268739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQXoCRHymE4uVf1TfGvqvejrHT9Pt6FBTTGcSlMOJGs=;
        b=F+7i4pg9/Z/4n/FKmMc5MQBHwK1ZFS8LuRT69g7SPiCw2vx7dlx3NWt0pbts0xltS5
         QINhuzgDjEgIgsC508iSIkGMeT+LCR3kFKd35a5SMCGP5hGymCvIlr/zIz45BYuZ8nGu
         InQULxCUhA/Htr/I9EFlH59571Eb9tWGl0oxIoLsQUi6Us0+fn8DtbWjhLdcwjwXbefu
         N1YbKcnLnjLVu/2hzK7IzWVBYxd9ZeJPpK8Q1I8wva5QeVpoT23FYi8zVR62eHCurqDx
         zOKHGmlitXyBaRb++uoMIGeRt/Hr8IMj2FEAmTDAigSsnqUlu6iTR8i92jiPltiPlF9A
         KqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686676739; x=1689268739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQXoCRHymE4uVf1TfGvqvejrHT9Pt6FBTTGcSlMOJGs=;
        b=JfvQLPSvp/YlYXoTqBO/r8Y1nPbkgHcIT2/GtU54+RQ3U5dGRpoh9Zku0KhqWmlglU
         YZz1XwmOEB/6qOXmqWgalDHHWai0wlNCQlOXkOQOuPM0ZA38z1pFntcA1kt6I3w4graA
         hRoLgT0/t6LzOTp4mueXG9cneAr8e7nJaaVnbQrLOFHLwo9FQs6eaoiUW3pkd43+J2SX
         F5V82wWrYdkLxmiGKyqWL4UUZsi3zB3TczwnHZJJDVsMUSdQfr7jiDRQ4l9sj2Wlwdz0
         7r60ehjo6MikFk2SfcVmUOOfjzaAjmyoQxALTr5PU8wCNaFWwe2C8iVWcgBlYdSlnrkB
         RC8w==
X-Gm-Message-State: AC+VfDwxRmAbyBIXB04QE3ZDOGvCVC6d8Xo+mGqZp8DrAGaeGBzgcKeS
        Q4ENz2eSeYgk7cBWO1cRfnc=
X-Google-Smtp-Source: ACHHUZ6PED2Qfiv8iqYhr63rnPvdEAmQXZ8Q3GbKFLDCFNJ/h15jX1pRPLPN3mbq0EKHi5VJNVm+Bg==
X-Received: by 2002:a05:6870:35c4:b0:1a6:4920:d331 with SMTP id c4-20020a05687035c400b001a64920d331mr8083153oak.42.1686676739504;
        Tue, 13 Jun 2023 10:18:59 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-b626-4062-16bc-09b1.res6.spectrum.com. [2603:8081:140c:1a00:b626:4062:16bc:9b1])
        by smtp.gmail.com with ESMTPSA id b17-20020a4aba11000000b005255e556399sm4251667oop.43.2023.06.13.10.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 10:18:59 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v2 for-next] RDMA/rxe: Fixes mr access supported list
Date:   Tue, 13 Jun 2023 12:16:55 -0500
Message-Id: <20230613171654.19334-1-rpearsonhpe@gmail.com>
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
problems to include it as supported but with no effect. This change
caused ib_send_bw and friends to not run correctly.

The correct approach is for the driver to allow any of the optional
access flags and otherwise ignore them. This patch adds
IB_ACCESS_OPTIONAL to the list of rxe supported flags.

Link: https://lore.kernel.org/linux-rdma/ZIifmHzwnvn3YVbI@nvidia.com/raw
Fixes: 02ed253770fb ("RDMA/rxe: Introduce rxe access supported flags")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2: Changed the target to for-next since the error is not currently in
    for-rc. Replaced IB_ACCESS_RELAXED_ORDERING by IB_ACCESS_OPTIONAL
    per a suggestion by Jason Gunthorpe.
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index cb18b83b73c1..ccb9d19ffe8a 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -262,7 +262,8 @@ enum {
 				| IB_ACCESS_MW_BIND
 				| IB_ACCESS_ON_DEMAND
 				| IB_ACCESS_FLUSH_GLOBAL
-				| IB_ACCESS_FLUSH_PERSISTENT,
+				| IB_ACCESS_FLUSH_PERSISTENT
+				| IB_ACCESS_OPTIONAL,
 	RXE_ACCESS_SUPPORTED_QP	= RXE_ACCESS_SUPPORTED_MR,
 	RXE_ACCESS_SUPPORTED_MW	= RXE_ACCESS_SUPPORTED_MR
 				| IB_ZERO_BASED,

base-commit: 830f93f47068b1632cc127871fbf27e918efdf46
-- 
2.39.2

