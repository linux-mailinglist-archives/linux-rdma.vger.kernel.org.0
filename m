Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA74736DF6
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 15:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjFTNzl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 09:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFTNzk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 09:55:40 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59FDD7
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 06:55:39 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a03ff70c1aso254182b6e.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 06:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687269339; x=1689861339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vvcJBVYrDs6rJgu+/fIqhhYxIXqZ9nD0G/s+ksNmFM=;
        b=Vo8Lj9Gj9J3GsUg8mUW6AM4TpCoRiJqB8QORzrUynq5bOx3PcRueaNV1KBdaVnWfLp
         3S1XugdMvAz+FDdpAiNr0z0+8+Vul/XenphiI6tYbvIUu8lEdTguW/Rk0rbJzigSG42H
         KxN50+6NtBOaaf9oRG5r6JsKsiTBBpthgKr6XUdgih7fdtKQsF5GAJr1CajripH3YPTW
         nmpI7pohX9iNyc6w+e9tc169svVmzS0TaXEMcMmiYQVXXe+v28s63tM61bxy8XUBmzHS
         BBazWJvxDaEVixNpXy1CIxMyzL0aHu/LLUOyg9ucVnInTAxOI+2y89XJrJdrntveSJb4
         5fEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687269339; x=1689861339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vvcJBVYrDs6rJgu+/fIqhhYxIXqZ9nD0G/s+ksNmFM=;
        b=ATG4qQvmN0A/6bydPi/kZ8zHm+jS0oUjdxcPL1omde9VdemyXnYCuJxttbD79Kf0MR
         HR28V7WoKoT94MBZ48aTiceFGUvM6SWq+Wxd+ptEQDzsOj9NRs2WWEk3aT+I+wHOjuqa
         zT1TUo+wrHEufTHjL3p5SVSPDINp8IvktnJOlpr5nXQcxr6UgvYQUVVjpgDdfkRxJyZh
         atCrN0kKU3GhO/SpFypjrrbivATrQ+XSfjPm70lqjRNBKGL8PAKxFPcvBxchqEHvoooP
         mIEVkJG2fPc5tOs58/qSDBM+0Xcb0XfZMtpeJk//32YNWhst139y2h3nFI3Lt+3MQ7PX
         /czw==
X-Gm-Message-State: AC+VfDwAETkDf9vy6Zucd1j/Q13vR2yYwqfgCfXuJsVMHCSCmUyT5cU7
        gnQyH+eKyQWp+/W6Xit/rCk=
X-Google-Smtp-Source: ACHHUZ4W2dOusv8YGcI6n9b875rB5TExOvaq+NxP/yNcNm/b+M4u22ZoTx/hYQ9sf3iTuyGB/ef1bw==
X-Received: by 2002:a05:6808:148a:b0:3a0:427d:4426 with SMTP id e10-20020a056808148a00b003a0427d4426mr424057oiw.32.1687269339030;
        Tue, 20 Jun 2023 06:55:39 -0700 (PDT)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-ba53-355d-2a89-4598.res6.spectrum.com. [2603:8081:140c:1a00:ba53:355d:2a89:4598])
        by smtp.gmail.com with ESMTPSA id bm9-20020a0568081a8900b003a03481094csm1091010oib.19.2023.06.20.06.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:55:38 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>,
        syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
Subject: [PATCH for-next v2 0/3] RDMA/rxe: Fix error path code in rxe_create_qp
Date:   Tue, 20 Jun 2023 08:55:17 -0500
Message-Id: <20230620135519.9365-1-rpearsonhpe@gmail.com>
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

If a call to rxe_create_qp() fails in rxe_qp_from_init()
rxe_cleanup(qp) will be called. This code currently does not correctly
handle cases where not all qp resources are allocated and can seg
fault as reported below. The first two patches cleanup cases where
this happens. The third patch corrects an error in rxe_srq.c where
if caller requests a change in the srq size the correct new value
is not returned to caller.

This patch series applies cleanly to the current for-next branch.

Reported-by: syzbot+2da1965168e7dbcba136@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-rdma/00000000000012d89205fe7cfe00@google.com/raw
Fixes: 49dc9c1f0c7e ("RDMA/rxe: Cleanup reset state handling in rxe_resp.c")
Fixes: fbdeb828a21f ("RDMA/rxe: Cleanup error state handling in rxe_comp.c")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2: Reverted a partially implemented change in patch 3/3 which was
    incorrect.

Bob Pearson (3):
  RDMA/rxe: Move work queue code to subroutines
  RDMA/rxe: Fix unsafe drain work queue code
  RDMA/rxe: Fix rxe_m-dify_srq

 drivers/infiniband/sw/rxe/rxe_comp.c |   4 +
 drivers/infiniband/sw/rxe/rxe_loc.h  |   6 -
 drivers/infiniband/sw/rxe/rxe_qp.c   | 163 ++++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_resp.c |   4 +
 drivers/infiniband/sw/rxe/rxe_srq.c  |  60 ++++++----
 5 files changed, 152 insertions(+), 85 deletions(-)


base-commit: 830f93f47068b1632cc127871fbf27e918efdf46
-- 
2.39.2

