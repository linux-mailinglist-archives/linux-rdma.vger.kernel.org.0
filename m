Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0956229C
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Jun 2022 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbiF3TFM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Jun 2022 15:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiF3TFL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Jun 2022 15:05:11 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA4337A32
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:10 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-101d2e81bceso585824fac.0
        for <linux-rdma@vger.kernel.org>; Thu, 30 Jun 2022 12:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/SBzaqpErJoT/wcV9MTdujz+diRyCzAJur4KDGnY3A=;
        b=oob0klT/ryd4u3YiApFMmOM+r/5WBrGXchJROWcyGnN8F7V5cuVLEqiL7nT4BttzLl
         O9s202sP3xtCK/alpewWKFHJLTGbcR/uml02Tw6tfan/LFi3ShSyaERWyiuDIFc3+bOc
         bcsGSvYjTkWjhtI+Pj93TMGTJKfQ0M+7Rzl7l5mY1h0o8mXluMR+WrFuQ0MT53sjsKAZ
         4c8pPOkyWgNhXQvGpk96HfQGVHsnx/vNYEaX5G03aI1il0fO0G9jQcVla4DesHHY6k6B
         yMnK7PTmJHIHuHHA8RFMg4w/q0qq7Nf3Ug/P3tqU/tJUHzCNcZPaPLzFASwJLNvbIFWm
         n+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/SBzaqpErJoT/wcV9MTdujz+diRyCzAJur4KDGnY3A=;
        b=dKNRUp51PtPt1GuypCzYdwKcYoW1oE3uuyILcALPtgs0ClASPI1wBa3vp+A+JV+acg
         PeAGX/jFqjKrkgkjibFvNzzGOrQCq7diIOf71FlUvGJJrrlVKohXybsVLPDZTWbYDU0c
         hZESomeWcHFeqF82VIjdkNCdaH2XqVOX3RmoWdDzzL/qvAl0aShTAPJa31rAJtxeWVKm
         N8Z+0DjW9iD06ts4rGeCOzVt7ae/plGi754uPP6Qlv02s0s7ghKcVzhxAnbIX5Uc3rcX
         OXTA57WLVMKDriPAHQAT5nDPk4ya4ZR+gzuA+51Zmmir8Dh5mDxLHh/GWtqLvfhMGbYZ
         rNdg==
X-Gm-Message-State: AJIora92Vku/E9t1vvbMPV62pkBF7xulzTUTbRv/wXFVT6U9Wh81M4OF
        yP/o39Wp5Ys+S4silH9l5tk=
X-Google-Smtp-Source: AGRyM1urucKaa1wWBFTOHaSmmu41hkfNE6OcuVMjFchdfgR59b2B9fcN9atxxzfGDGlGwFi8LHOoTA==
X-Received: by 2002:a05:6870:65ab:b0:101:acac:7ba7 with SMTP id fp43-20020a05687065ab00b00101acac7ba7mr6429482oab.29.1656615910298;
        Thu, 30 Jun 2022 12:05:10 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id o4-20020a9d4104000000b0060bfb4e4033sm11756442ote.9.2022.06.30.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:05:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        Frank Zago <frank.zago@hpe.com>
Subject: [PATCH for-next v2 3/9] RDMA/rxe: Remove unnecessary include statement
Date:   Thu, 30 Jun 2022 14:04:20 -0500
Message-Id: <20220630190425.2251-4-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220630190425.2251-1-rpearsonhpe@gmail.com>
References: <20220630190425.2251-1-rpearsonhpe@gmail.com>
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

rxe_verbs.h includes the file <rdma/rdma_user_rxe.h>.
It should have been <uapi/rdma/rdma_user_rxe.h>,
however, it is not used and not required in this file.

This patch removes the include statement.

Reported-by: Frank Zago <frank.zago@hpe.com>
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
index ac464e68c923..ec9a70aecc1e 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.h
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
@@ -9,7 +9,6 @@
 
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
-#include <rdma/rdma_user_rxe.h>
 #include "rxe_pool.h"
 #include "rxe_task.h"
 #include "rxe_hw_counters.h"
-- 
2.34.1

