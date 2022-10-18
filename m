Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFE602353
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJREgZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJREgU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:20 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3384AA0249
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:19 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1322d768ba7so15598768fac.5
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+pQLfFTLvpppau6pAQopOyapj3Gnfc23EXBLPi5pxo=;
        b=VT84l+wYFbT4YBdyOxK2ciUyNVKwdGBsNQ2liETRe3LVtztMxM041SJ2smY4Xfh8NF
         CoVY+z97moIjFVNZh4z6iM1Sj2S/yKYB7HOavGM8QGOKlH/3G3CmbMgA4gGzNnKNYyY9
         ZyaoZKaEEcAC/ddCk5Ztb1RDIBhRN8PBa/7tOMs+O2ZGg5SYxjGgKoldmZETJQ/gvmfs
         I7XE2MIIKeFz2JPUqy+OYWx9ObGSsaHcY6bJgVcBijEkEqKEIvYDhx6dJz6cG3kJw0LB
         SsdVoPw/4f1kRr/lnFiSpzS0747Vy8cO6QoKH+My4+bp7m+UK8epy/54ZiPHaApCcFlV
         K/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+pQLfFTLvpppau6pAQopOyapj3Gnfc23EXBLPi5pxo=;
        b=xRxko4FpDZus2vVL/cc2aKapcMreLjvxI0m3/JBwu3W40g5dTIMzgofN84dhkWRkkB
         FipYmro0MW7vF4cMO0RZttgsrBNivXIOoqUdSudlnYBhZJiWHlEzr0wVKuAhpsk4Wg0O
         f+Mz6roCe9TrjKzYklNAPa37tp/IrrS3JE6QrPiQfEGpsgYIyfbImXm5xjyVgZ3HQ/qW
         Hk1s8Tip+t5tXItlXk8tIntR0a9VONzaDQ19fplp4ks/sxsSqewQBpcu5ekB3hRb/Nr5
         37l7fICGitQvmpKiDbn8rmRAgJ+jo1N9fDa1xpaORCSJ39c0L5Hg0Ao7fzhF3qBBAYy+
         JEPw==
X-Gm-Message-State: ACrzQf2SxiQ7EL4XF/c44d2I+uaCNy2GXjum4F0KAMrdbbAyVGdg2WwQ
        Zr8Tpl+gMkEdYB0weypZS0Y=
X-Google-Smtp-Source: AMsMyM7/oyTYASi+zIBlVgluB0ir0kbEWaqWwkeZ1V0fTlUCk6J1NlXAllyxOvd1CHTPcQ+83riYMg==
X-Received: by 2002:a05:6871:28e:b0:131:91b0:6a1 with SMTP id i14-20020a056871028e00b0013191b006a1mr604118oae.200.1666067778557;
        Mon, 17 Oct 2022 21:36:18 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:18 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 04/16] for-next RDMA/rxe: Make rxe_do_task static
Date:   Mon, 17 Oct 2022 23:33:35 -0500
Message-Id: <20221018043345.4033-5-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018043345.4033-1-rpearsonhpe@gmail.com>
References: <20221018043345.4033-1-rpearsonhpe@gmail.com>
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

