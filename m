Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D4758AFBF
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 20:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240901AbiHEScs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 14:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiHEScr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 14:32:47 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6D6611B
        for <linux-rdma@vger.kernel.org>; Fri,  5 Aug 2022 11:32:46 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10ea7d8fbf7so3800801fac.7
        for <linux-rdma@vger.kernel.org>; Fri, 05 Aug 2022 11:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=U0QIPtNNzCSSD37HN4EZBZo68v83U34VoVI89KfSeKY=;
        b=EoP7yDhTkb2DdgVUbFBZD06kqadiF9fcUy5LrUFz8NBEfKejTcYRBgjmrucSrvAPCg
         vfR2gGfVn7ywLCn3SExAk3iD/mYc+uacL1szbU6osv6s2Ha1stIAvUK8f68ABn73ulyN
         2+0yZlcE44+Qu+4tR4AaS78P1c60rwWkKfGGJLn+CwaBUY4dU/K7f/lqMRpV+zYgFCdW
         Nmg3UMUz/mlqz4tKV21IFsyh4wrwYfDpq0Yt4L9x2QrQuwJBcKHEHtK7p9CygvbfHQPe
         wpjb9DbhuTfUn6zsONUem33XgVb4EjZSVO9CBkCSrUzN9kIBEtnDOMZnS/fAhf6BrtAi
         DB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=U0QIPtNNzCSSD37HN4EZBZo68v83U34VoVI89KfSeKY=;
        b=TxHAu0p1yJVG4w84G8Suge+bBYe2+v37FU/9OCVstoXNAoEUSWUnLztZtiHimOryLW
         zG+iI383+WUuMoHOp8cij+pRvdz3UBc30fqMuiMtG6klB7CbtF1jil3MSHrhQ0582xJy
         BukuInH7aCxzHZnGyR7YdrOBRvzarL5mZ3ITFy6a+S5gTsckqMcjUF4Ep9xKByu4p7Dm
         Cj4zFvIyLg1wAyFv5f3lYAFJNQ8HkpC0urwChJrmdz3zC953vKvN35O04yOoslBD7PFq
         PTn+ovh9VyPDV0D0HLRK/FueWcnFsXhVkO57qWkg7amqY2fRVULZH95gWs4p7ZdikInp
         bnVg==
X-Gm-Message-State: ACgBeo0Wn7u22qM+eYeMKc4iVsq0H2rfyw3s3BS4ZI/xGCsW7pMbf6pC
        2RdAKKdlfNGJoecKNyMx54A=
X-Google-Smtp-Source: AA6agR4Ai/x+2NYOw82XmFKd/DAjUtvHyyvepBQXIVn09cZJllabJ1CBGMtAdkfYEE7kk3a9AsKnVg==
X-Received: by 2002:a05:6870:2392:b0:f3:2bcf:41ea with SMTP id e18-20020a056870239200b000f32bcf41eamr3826261oap.95.1659724366043;
        Fri, 05 Aug 2022 11:32:46 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id w9-20020a0568080d4900b003352223a14asm761145oik.15.2022.08.05.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:32:45 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, lizhijian@fujitsu.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH v5 for-next 0/2] RDMA/rxe: Fix error paths in MR alloc routines
Date:   Fri,  5 Aug 2022 13:31:52 -0500
Message-Id: <20220805183153.32007-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Currently the rxe driver has incorrect code in error paths for
allocating MR objects. The PD and umem are always freed in
rxe_mr_cleanup() but in some error paths they are already
freed or never set. This patch makes sure that the PD is always
set and checks to see if umem is set before freeing it in
rxe_mr_cleanup(). umem and maps are freed if an error occurs
in an allocate mr call.

Reported-by: Li Zhijian <lizhijian@fujitsu.com>
Link: https://lore.kernel.org/linux-rdma/11dafa5f-c52d-16c1-fe37-2cd45ab20474@fujitsu.com/
Fixes: 3902b429ca14 ("Implement invalidate MW operations")
Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v5:
  Dropped cleanup code from patch per Li Zhijian.
  Split up into two small patches.
v4:
  Added set mr->ibmr.pd back to avoid an -ENOMEM error causing
  rxe_put(mr_pd(mr)); to seg fault in rxe_mr_cleanup() since pd
  is not getting set in the error path.
v3:
  Rebased to apply to current for-next after
  	Revert "RDMA/rxe: Create duplicate mapping tables for FMRs"
v2:
  Moved setting mr->umem until after checks to avoid sending
  an ERR_PTR to ib_umem_release().
  Cleaned up umem and map sets if errors occur in alloc mr calls.
  Rebased to current for-next.

Bob Pearson (2):
  RDMA/rxe: Set pd early in mr alloc routines
  RDMA/rxe: Test mr->umem before releaseing umem

 drivers/infiniband/sw/rxe/rxe_loc.h   |  6 +++---
 drivers/infiniband/sw/rxe/rxe_mr.c    | 15 +++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.c | 10 +++++++---
 3 files changed, 17 insertions(+), 14 deletions(-)


base-commit: 6b822d408b58c3c4f26dae93245c6b7d8b39e0f9
-- 
2.34.1

