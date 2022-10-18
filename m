Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4B602367
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiJREiI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJREiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:38:06 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90161A025E
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:38:05 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id g130so14393487oia.13
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n+pQLfFTLvpppau6pAQopOyapj3Gnfc23EXBLPi5pxo=;
        b=eOTh05AiD/g+ebg5KW0i3OtqImxr112j4XD/b9KS/0l1WLP3NMmS2j27+HutQclQVJ
         sDSY0Dx8nxa/ZI0gLXKaik0Og7uELlqY7KMFw/ZYhVTD/uvEqDGhVHXVGatLhDzTJDA9
         NXJxR6bHm3NbDNj42srMwAIKnNT6exDKPT+jOHRvfbkJETz5TM+QXUq8COpyFlL+ffZr
         Kp0/aQHE8WGjB43M437U+rKWxJJywJL6VaeF5QVl0Ebyjj/MMi/30nXTVk3oGPps1ySi
         e4p9PBPPwatrKplB1g+RtpW1NOP5g8pVR9WvK3Jjl4C7x4xpqPBGcAgyBgiUctAcZOH1
         43Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+pQLfFTLvpppau6pAQopOyapj3Gnfc23EXBLPi5pxo=;
        b=K/zus6AiM/TwC0BAvlnHkAsflCpKTinr5bL13yTwjSo/UPc1fxYIqFTGbNeswRl3mu
         K93B5luz556aUK+8vWNStGw3lvN8qVaZWfJVVpzqWk9Ce3Sg90Y57TPhMqpPC1JjwnE9
         IQNsaRGaqYBG3ALYceDJZ9sy0VsGOXy3RjWaidwu+TNrPR+HJ8Kr/DJxprRXlQGoAcnL
         EMrR9zkxX1xXIKWfiVsPpAynjX+vlt5SaULhi02SFQOVO2idPSRBQyZ+XgrI7eRNuMGq
         yrkVH6xxuAWDayYv7BIX1DQkUD41S/nm2AbZOcpOyRzY5oBw+EcyXExO74dBlHJW3sn4
         sbyw==
X-Gm-Message-State: ACrzQf08hrb+jFmP1+DkD0Fj1u/rhy6V42se1PUoIBKB0Uot1bYhuIGV
        bO797o/K3wpViP9uuF82Rvw=
X-Google-Smtp-Source: AMsMyM4rbwcXMDHkbMDD4x1TXKHXP5SW5HbhNeJLPWCMGtiDGXR2YKX78ICOlwiDjYo2wCo/rnqefQ==
X-Received: by 2002:a05:6808:11ca:b0:34f:9c50:7c73 with SMTP id p10-20020a05680811ca00b0034f9c507c73mr552135oiv.86.1666067884937;
        Mon, 17 Oct 2022 21:38:04 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id z34-20020a056870c22200b0012784cb563dsm5669507oae.22.2022.10.17.21.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:38:04 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 04/16] RDMA/rxe: Make rxe_do_task static
Date:   Mon, 17 Oct 2022 23:37:56 -0500
Message-Id: <20221018043755.4104-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The subroutine rxe_do_task() is only called in rxe_task.c. This patch
makes it static and renames it do_task().

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 2 +-
 drivers/infiniband/sw/rxe/rxe_task.h | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 446ee2c3d381..097ddb16c230 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -28,7 +28,7 @@ int __rxe_do_task(struct rxe_task *task)
  * a second caller finds the task already running
  * but looks just after the last call to func
  */
-void rxe_do_task(struct tasklet_struct *t)
+static void rxe_do_task(struct tasklet_struct *t)
 {
 	int cont;
 	int ret;
diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
index 590b1c1d7e7c..99e0173e5c46 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.h
+++ b/drivers/infiniband/sw/rxe/rxe_task.h
@@ -44,14 +44,6 @@ void rxe_cleanup_task(struct rxe_task *task);
  */
 int __rxe_do_task(struct rxe_task *task);
 
-/*
- * common function called by any of the main tasklets
- * If there is any chance that there is additional
- * work to do someone must reschedule the task before
- * leaving
- */
-void rxe_do_task(struct tasklet_struct *t);
-
 void rxe_run_task(struct rxe_task *task);
 
 void rxe_sched_task(struct rxe_task *task);
-- 
2.34.1

