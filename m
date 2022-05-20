Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4A752EEE9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 May 2022 17:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbiETPTu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 May 2022 11:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiETPTt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 May 2022 11:19:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0137F177893
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 08:19:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j28so11160249eda.13
        for <linux-rdma@vger.kernel.org>; Fri, 20 May 2022 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVKZjGz+IJsnsdnlvcHGCY1/aQD6LDE75UZKbaQS/y4=;
        b=NGA+3u1iyCZJk5YqqVe1CyySMtViclUxyfUCEObGPnyj14LPqb5c1ycvRsXj62SDHe
         epLChAPmHNvELksTbSDtThN49tScFqndSLJkWp7RGhu7XrvikG3NhFs9d1dqSqF5irM1
         ChJGPrDAxzPQGT9DrfI3p1vjpCJHe9tMBlocYn0FG97kPxMtHwN9lLo6vvgdNB0pubh5
         eU9zj/ItbXThQWra90PJXVLGRz80f6UvpWmwubhyI0NowmyB3yn19K4J2sU8YfT3PV0w
         t/xlgPnYeLQ7nIH7i7rW+kTIx2C1sKotDwVJ7Aji04f5cjGDmzHeMRMs+4ztf99rOCDm
         O9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVKZjGz+IJsnsdnlvcHGCY1/aQD6LDE75UZKbaQS/y4=;
        b=yxxZ60JpJXQ+QJWKCq8/lKyQtiOfGb7oeG1sIwDU/sydzHF717KRqfk+ZZ0HRqBdcv
         h5DDkHkiMaGX4EiUXMs5JactETIBKV+5z0Tp94JigeCUYOUNYmWRFzS6/vvJvCz1c3jV
         QEEf1yt/tHf6elw9rRzyqK3hTth47rlgh/ThN0hvbnS7Anex+xXN3jyLrJi16JFDX6pF
         yWk5zjlc6WeLqlp1ZvO1QtMuflRd8Iu4yuP3xnsdgQztEQCcSXUAEJZsyAa73/k5Rn3B
         jhbkG0XDSycXjgm5u8kxBnkaQpcTFGko31f4e8QmDcpvHKk7p2Gvjiyobkzjk1z4Gjdk
         LDgA==
X-Gm-Message-State: AOAM5321VEhLQBGIh0nFNwTAIi9Rz5LFlj2iPZmj1uFwnN1DdBNKXjGs
        IE4g74K92yFjED5ACVKDwm+aLS8bzmpJWQ==
X-Google-Smtp-Source: ABdhPJwGfoXQXXLNODny03FIhx92Mp2pJsSTd6HkFh1NCrcTIx7HTIUKaAf25iOTr/nybAeHdmdj1g==
X-Received: by 2002:a05:6402:1654:b0:42a:c4c7:e85e with SMTP id s20-20020a056402165400b0042ac4c7e85emr11303811edx.181.1653059986594;
        Fri, 20 May 2022 08:19:46 -0700 (PDT)
Received: from localhost.localdomain ([85.214.13.132])
        by smtp.gmail.com with ESMTPSA id j4-20020a170906104400b006f52dbc192bsm3342697ejj.37.2022.05.20.08.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:19:46 -0700 (PDT)
From:   Md Haris Iqbal <haris.iqbal@ionos.com>
To:     linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, aleksei.marov@ionos.com,
        danil.kipnis@ionos.com, rpearsonhpe@gmail.com
Subject: [PATCH] RDMA/rxe: For fast memory reg wr set both lkey and rkey
Date:   Fri, 20 May 2022 17:19:26 +0200
Message-Id: <20220520151926.2616318-1-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes: 001345339f4c ("RDMA/rxe: Separate HW and SW l/rkeys")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Aleksei Marov <aleksei.marov@ionos.com>
---
Cc: rpearsonhpe@gmail.com
---
 drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index fc3942e04a1f..04eb804efb23 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -648,7 +648,7 @@ int rxe_reg_fast_mr(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
 
 	mr->access = access;
 	mr->lkey = (mr->lkey & ~0xff) | key;
-	mr->rkey = (access & IB_ACCESS_REMOTE) ? mr->lkey : 0;
+	mr->rkey = mr->lkey;
 	mr->state = RXE_MR_STATE_VALID;
 
 	set = mr->cur_map_set;
-- 
2.25.1

