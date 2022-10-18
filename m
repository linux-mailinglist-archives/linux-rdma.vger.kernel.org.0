Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20193602350
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Oct 2022 06:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJREgR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Oct 2022 00:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJREgQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Oct 2022 00:36:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCBFA0243
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:15 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id g10so14395522oif.10
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 21:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qm5mGTa3bhYcwi5JlLG1oAfRXa/BUdi8iIjw7y2ov7A=;
        b=pgd8TvXcV6XaoJ6v+EjLZHNh0zb1gtKebySZJ5GU5w4qXHR4c4+CpEHe/7fmmacwEJ
         E9OBdCPE6taJHjMRdDfRGrSt1i1vcGd7wBVaEHvV5qG8FpV5SGdzlNL6+64rFl3+HaQL
         RzrnYRHbrqlATJOLzpTwDmU6/PGL1sVWq6gmem2j1onAqIQOBjobRrrp4DjEZcX02stp
         fAZhjcbtm6ASpo0Z4hCo3EqzCL+6LOTUxo3sTyFVP4vxcyxbcVhjnpL9DEK6IDT9UeUE
         ugFwY9fuX1EGvTJdxk0GRdT0e68gfdGhj29UGKobcNlh+Dl40CRbRyPNv0GcBWO/ORry
         HUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm5mGTa3bhYcwi5JlLG1oAfRXa/BUdi8iIjw7y2ov7A=;
        b=He7fYjUwmJc0WaVbSzBTrpv4RZg23OfHiKjqeIkB3k/fUhEFZdarvFP5StuuPJh+Vd
         VbpyOj495XHXm4qoMnqpx0q2xo4zWEasF1sGLtL2nT9lKITGdSOOSg35l/r5CBF45SIH
         1mY8aEWgG3qMJhOCy1cTa4RWeD0jWhTcFR3ywjqnVFSH5D1okrmyeT4aZGX/tNuLjh4b
         ajfGNJcUbb0kkKg+vNWeer4xolO+6+IfCCLsMn4YKWAhyhtP/Cz9vBzSm725SV6f16Uh
         z5dUX0Rgj90q/URAXheau3FPt6Nfrpj0zKappgF22EinlT5niUf9EDV5gophXuTcW7Aq
         i1Yg==
X-Gm-Message-State: ACrzQf1bbUzyKyajlRkh+r6UjGCwFTsseKN3PLBZNeFuxYL4DToJcEgF
        UPX5bqWmksAGa4HSTksRq74=
X-Google-Smtp-Source: AMsMyM7qOsf+Y/ZkO41OO7iE052m73EKGDFe8Z2jvWBMfcissJwFaSt4dk1rx6KgyYYGvsOCJ+91HQ==
X-Received: by 2002:a05:6808:46:b0:354:943f:bcc5 with SMTP id v6-20020a056808004600b00354943fbcc5mr572024oic.104.1666067774820;
        Mon, 17 Oct 2022 21:36:14 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-290b-8972-ce76-602c.res6.spectrum.com. [2603:8081:140c:1a00:290b:8972:ce76:602c])
        by smtp.googlemail.com with ESMTPSA id e96-20020a9d01e9000000b006618ca5caa0sm5480333ote.78.2022.10.17.21.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 21:36:14 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        jenny.hack@hpe.com, ian.ziemba@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 01/16] RDMA/rxe: Remove init of task locks from rxe_qp.c
Date:   Mon, 17 Oct 2022 23:33:32 -0500
Message-Id: <20221018043345.4033-2-rpearsonhpe@gmail.com>
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

The calls to spin_lock_init() for the tasklet spinlocks in
rxe_qp_init_misc() are redundant since they are intiialized in
rxe_init_task().  This patch removes them.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_qp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index a62bab88415c..57c3f05ad15b 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -172,10 +172,6 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
 
 	spin_lock_init(&qp->state_lock);
 
-	spin_lock_init(&qp->req.task.state_lock);
-	spin_lock_init(&qp->resp.task.state_lock);
-	spin_lock_init(&qp->comp.task.state_lock);
-
 	spin_lock_init(&qp->sq.sq_lock);
 	spin_lock_init(&qp->rq.producer_lock);
 	spin_lock_init(&qp->rq.consumer_lock);
-- 
2.34.1

