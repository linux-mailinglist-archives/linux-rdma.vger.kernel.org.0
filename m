Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9DD607F68
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Oct 2022 22:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJUUCl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Oct 2022 16:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJUUCN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Oct 2022 16:02:13 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CA125ED0C
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:02 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1324e7a1284so4872741fac.10
        for <linux-rdma@vger.kernel.org>; Fri, 21 Oct 2022 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJoK0HylogCNImnm+D5kGSnKHCyCbyRc9oJ5qG2Py+Q=;
        b=H/BjvspHQG0mhW5wyawtPUc+ycoN/6/YIUig5QgtkN5SHBKyidBOoKgB322+UBk9/L
         IKpxMMDt+xHp//HwsuDOpkt0YqEWagj214OYsFQlN2NgfWfqXWBZjwLgDI76c2mZNPsX
         LmuDtJIzA28noShfaJiRVTlPVl0HRvQy+8Ybp+qKNfse40X1Up8w16m9YOCGRAYlo6PI
         /gAQv8Xqo+OthqVxQ062VWJ4L+3OE85UPQe8/xMzkoXuuoqApt/Nm/YWEw1uJ/QCEtqJ
         zM/GOr95hq7xBYE6DpSyAoL8kV6iHiuauv0rkrQnbQ3STeT6LFnFrz/uYM+c4wTYntkM
         xrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJoK0HylogCNImnm+D5kGSnKHCyCbyRc9oJ5qG2Py+Q=;
        b=olAlBPPY8fFuT+1gi7VHv/FpuUGUnHQEPGze4N1j+RsUblIMiixD5Khny5/INErVnd
         I6RVPx37OkFN5sHPC/ejTYiMOr9gl5FUbDcB1nYY96T2o+T6GdabdUvc6dENP8gIAeew
         3r3kR1KQ6TE6DbbolUzR40e2ddSMHN8jsSive5+F2Qy1QPiGREeeCpycb3bt72nCpRKX
         Q9Czo7QbacJbGVsa1vN6poHQA5/2S6Uin0bQJwk13HPn4b7yGLecWGgGH38elRnxcQ+i
         DkijLcoXv/REVSM+3FFyRewKUhY6pfcZwZXmIo8D+wca1LZ/bfVS55gWISnRfXbDO0zk
         SzlQ==
X-Gm-Message-State: ACrzQf2KCgvsQm6oX8QslrWFIv/QnJuTvn04V3ipJUkXFieRO5efAAy3
        VQichjuqCbCCYiOhNkVd8lk=
X-Google-Smtp-Source: AMsMyM5E3yPZLztP3je+iRgWDEZ6PnnD0rjXR7y7evHvBFvQJCgDUS92K4I+k+NpDiS8br9kqa4R3A==
X-Received: by 2002:a05:6870:2191:b0:132:a213:3657 with SMTP id l17-20020a056870219100b00132a2133657mr13758141oae.13.1666382521813;
        Fri, 21 Oct 2022 13:02:01 -0700 (PDT)
Received: from ubuntu-22.tx.rr.com (2603-8081-140c-1a00-a860-f1d2-9e17-7593.res6.spectrum.com. [2603:8081:140c:1a00:a860:f1d2:9e17:7593])
        by smtp.googlemail.com with ESMTPSA id s23-20020a056870631700b00132f141ef2dsm10674684oao.56.2022.10.21.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 13:02:01 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        jhack@hpe.com, ian.ziemba@hpe.com, matsuda-daisuke@fujitsu.com,
        lizhijian@fujitsu.com, haris.phnx@gmail.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 01/18] RDMA/rxe: Remove redundant header files
Date:   Fri, 21 Oct 2022 15:01:02 -0500
Message-Id: <20221021200118.2163-2-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021200118.2163-1-rpearsonhpe@gmail.com>
References: <20221021200118.2163-1-rpearsonhpe@gmail.com>
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

Remove unneeded include files.

Signed-off-by: Ian Ziemba <ian.ziemba@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index ec2b7de1c497..3fbaba9eec39 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -4,10 +4,6 @@
  * Copyright (c) 2015 System Fabric Works, Inc. All rights reserved.
  */
 
-#include <linux/kernel.h>
-#include <linux/interrupt.h>
-#include <linux/hardirq.h>
-
 #include "rxe.h"
 
 int __rxe_do_task(struct rxe_task *task)
-- 
2.34.1

