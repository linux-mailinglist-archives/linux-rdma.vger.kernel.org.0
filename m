Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E9E6A155C
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Feb 2023 04:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjBXD3c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Feb 2023 22:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBXD31 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Feb 2023 22:29:27 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF204FAB0
        for <linux-rdma@vger.kernel.org>; Thu, 23 Feb 2023 19:29:25 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id v17-20020a0568301bd100b0068dc615ee44so3170934ota.10
        for <linux-rdma@vger.kernel.org>; Thu, 23 Feb 2023 19:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zatgSMdPL19G8ruq1U2M7ZCeKdTLzAuLWPJWsbcduN4=;
        b=qCiSWmCdDiPyV6QujOpxJH2O6QM+jGwwwG7Z+X+VL+fLZH1PEHHcCujtgSq+ZEyFrs
         h0jE4lJyPoWWOeGpKOKQSsMZOGOefDII3QfXy2m9HxwWrU1K3GHGgnW2QXm8wVsWQkNB
         phmyOmIFl7KmngRH9t/iBiqFXOL2Wc9ZMhh0SEdRpr540dZMYf0u42ep3gOOQwB+9W7n
         F9MRHOAHXWZqZusYdnYQVQFwvdtmuQOz/JpK9uM4PpkEut7G8Kpz1h3ncd7ndp6CGSUB
         Yc/yaG/RkwHEfYo4m+hRLFu+Yp3BUJ3M45LUHcMf3Ghk/vTXRvGYnYrgq8uRFsU9UWOP
         RjTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zatgSMdPL19G8ruq1U2M7ZCeKdTLzAuLWPJWsbcduN4=;
        b=4VFyg3rD+iTyUJt0oBuaO0v4rc++JXc9PhDt/FQxwSseodYTubcGJWpxtOmi6zlvuI
         WTne2K48rkDdb3Cg1XDE2dYXLCEu4eKu9ZTTc0piE6HF9mG+xUkF3E5A5RZsk1GSQ+i/
         7CGUZemkpmHHeiJ6K2JN1tsbXQW12QIxxkbZrOj6Gltf95IJrOMoEDnYFLJdNV5pbJl9
         6KO5lFTmRsHfZBCJcgGHc9aSXUj04A1m+G6apUXD8a8hXbUVxRo5HxxtckdQvpVJt7qe
         zECUk72Ul0bXu1FcDPOopudsPeDmjhGPTaDy39JR3SDoaAX7DokOPVQkEpkjtmcoys04
         Vc+g==
X-Gm-Message-State: AO0yUKXq1byb/FqiwBLwFKFv4zMBeQiXvGY8DcuwlQH8qOAtMz1zshgV
        YO/FQM7RmSDPlR2sRYHAD80=
X-Google-Smtp-Source: AK7set+VBAucu4zsZFvyGfuN+RmY1xGtqq430I2iPq/V71IMcjPxxStCWP9E3sShtNMJ99Q981ZIrg==
X-Received: by 2002:a05:6830:440d:b0:686:dfe6:a532 with SMTP id q13-20020a056830440d00b00686dfe6a532mr6702287otv.7.1677209365215;
        Thu, 23 Feb 2023 19:29:25 -0800 (PST)
Received: from rpearson-X570-AORUS-PRO-WIFI.tx.rr.com (2603-8081-140c-1a00-07e1-19cc-c957-ef10.res6.spectrum.com. [2603:8081:140c:1a00:7e1:19cc:c957:ef10])
        by smtp.gmail.com with ESMTPSA id l15-20020a9d550f000000b0068d3f341dd9sm2587561oth.62.2023.02.23.19.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 19:29:24 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 0/4] Add error logging to rxe
Date:   Thu, 23 Feb 2023 21:29:13 -0600
Message-Id: <20230224032916.151490-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Primarily to make debugging more efficient log message types
are added and error logging messages are added to the verbs API
to rxe driver with the goal that each error reported up to
rdma-core will generate at least one message with additional
details and internal errors restricted to debug messages which can
be dynamically turned on.

v2:
  This set of four patches was split off an earlier series called
  Correct qp reference counting since it is not really related.

Bob Pearson (4):
  RDMA/rxe: Replace exists by rxe in rxe.c
  RDMA/rxe: Change rxe_dbg to rxe_dbg_dev
  RDMA/rxe: Extend dbg log messages to err and info
  RDMA/rxe: Add error messages

 drivers/infiniband/sw/rxe/rxe.c       |  16 +-
 drivers/infiniband/sw/rxe/rxe.h       |  45 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +
 drivers/infiniband/sw/rxe/rxe_cq.c    |   6 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 -
 drivers/infiniband/sw/rxe/rxe_mmap.c  |   6 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  13 -
 drivers/infiniband/sw/rxe/rxe_net.c   |   4 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  16 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |   4 +
 drivers/infiniband/sw/rxe/rxe_srq.c   |   6 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c | 831 +++++++++++++++++++-------
 13 files changed, 685 insertions(+), 271 deletions(-)


base-commit: 66fb1d5df6ace316a4a6e2c31e13fc123ea2b644
-- 
2.37.2

