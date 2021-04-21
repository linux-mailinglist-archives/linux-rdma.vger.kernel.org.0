Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0788B3664BB
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 07:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhDUFVX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 01:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhDUFVW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 21 Apr 2021 01:21:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C6CC06174A
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:50 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id e89-20020a9d01e20000b0290294134181aeso12160206ote.5
        for <linux-rdma@vger.kernel.org>; Tue, 20 Apr 2021 22:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5fvvTXwrORaywL4sUtUiwhAlXJjrd+P2Uxb/hkRYq4=;
        b=e38RsmhvWBtyo7ibje92T43SEclXVZtG/8Bvn486d2+K51fDY7UNl4vv/kXRJFTzgS
         6h4JDXFlP7FJyO/Jtl6A450XdJKGRyy/7Pe6Xvna0Ht0StuauSGHDlYpLBNJ9vMr6pY3
         rLo6teDabMa+EXYlIq/Fc2YUKVR44E6btqUHMVgQekT7eEv0I6mkfPFvt5b+uiIslmKc
         axTcLWBmqTNux9y2HOsfib0gqRJDUDT+24XDmOizVvbCQyE66BDpAK7p8KFeHwHnfOpi
         rIQfC9eRrn3lN9oxEgNh466E6kZVd4JJivJeXlcypWicP6ngDuUef7J9Se03wscPzwAv
         U2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5fvvTXwrORaywL4sUtUiwhAlXJjrd+P2Uxb/hkRYq4=;
        b=orRCFuQC1lqEtKYP/uW5Qxcy2CDVAjKLKz+E/WQwlo75dctX5D2B9Whu7nEcxQNu2C
         plUa8HNL7pQU0ps9Jxmw70QpL7vMdFjnFDRWBXPPqLtEq3ozV1y3iwAfJ/iB7Ar3Nzt8
         Fg38E3/QW70N1hQJK5wyNpBzRFHk5b+Hm1nKVx3+sF/4FHs+l9VDpy70NocyHG4Fx+ZR
         Fn3ldOk6BjAdWxrVDnyZTreRNIeB/ulQQTtPN+ONR9YyzOPF3m4bDORNgjUpmclkJb/O
         5XHb5L8d8WVvtpMFY+qZyAKEIAt60XTHcxrgmfcZkikDwfHf3ItRhv2Hqzs/a5cXiKAp
         /wPg==
X-Gm-Message-State: AOAM533TceI9UcEUcN2PZdLbsyn5tTNttJYvfxM02RKQ44bbfWcPEwnL
        /x6YfXDbGw3G1f7puYstO58=
X-Google-Smtp-Source: ABdhPJy0HBW2lyF2yqoEvkNKQnwDBmUEMWinn/FXkfXUAdg88uM1dddCF8hfUxF6XgV0lIGGLFjT4w==
X-Received: by 2002:a9d:459a:: with SMTP id x26mr11612387ote.337.1618982449678;
        Tue, 20 Apr 2021 22:20:49 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-eeb0-9b2d-35df-5cd9.res6.spectrum.com. [2603:8081:140c:1a00:eeb0:9b2d:35df:5cd9])
        by smtp.gmail.com with ESMTPSA id r18sm296069otp.74.2021.04.20.22.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 22:20:49 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v3 0/9] RDMA/rxe: Implement memory windows
Date:   Wed, 21 Apr 2021 00:20:07 -0500
Message-Id: <20210421052015.4546-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches implement memory windows for the rdma_rxe
driver. This is a shorter reimplementation of an earlier patch
set. They apply to and depend on the current for-next linux rdma
tree.

Signed-off-by: Bob Pearson <rpearson@hpe.com>
---
v3:
  cleaned up void return and lower case enums from
  Zhu's review.
v2:
  cleaned up an issue in rdma_user_rxe.h
  cleaned up a collision in rxe_resp.c

Bob Pearson (9):
  RDMA/rxe: Add bind MW fields to rxe_send_wr
  RDMA/rxe: Return errors for add index and key
  RDMA/rxe: Enable MW object pool
  RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
  RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
  RDMA/rxe: Move local ops to subroutine
  RDMA/rxe: Add support for bind MW work requests
  RDMA/rxe: Implement invalidate MW operations
  RDMA/rxe: Implement memory access through MWs

 drivers/infiniband/sw/rxe/Makefile     |   1 +
 drivers/infiniband/sw/rxe/rxe.c        |   1 +
 drivers/infiniband/sw/rxe/rxe_comp.c   |   1 +
 drivers/infiniband/sw/rxe/rxe_loc.h    |  29 +-
 drivers/infiniband/sw/rxe/rxe_mr.c     |  79 ++++--
 drivers/infiniband/sw/rxe/rxe_mw.c     | 356 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
 drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
 drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
 drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
 drivers/infiniband/sw/rxe/rxe_req.c    | 102 ++++---
 drivers/infiniband/sw/rxe/rxe_resp.c   | 110 +++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  38 ++-
 include/uapi/rdma/rdma_user_rxe.h      |  34 ++-
 16 files changed, 691 insertions(+), 151 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
-- 
2.27.0

