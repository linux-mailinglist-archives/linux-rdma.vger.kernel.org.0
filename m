Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B213E36EFA7
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Apr 2021 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhD2St6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Apr 2021 14:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbhD2St5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Apr 2021 14:49:57 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC563C06138B
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:10 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso39788915otl.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Apr 2021 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c06zpA8aeXEVo7bsgbGlPOO+xujWnv514iha8A3pDdA=;
        b=hnJzvw76N+D/vmfmMh1CJvjBvuMiIoytKh/Phq5PtzACTU5DfbwL15oAw3Ipacgco/
         Yozf+SeE9poCl4rGsDfeZ+Z3Wk5fVw62LJkNoWlaqdTwkJNK4l8d+Frd4UxXoYJ8/hUG
         1L0EGq52QfpQRQXQjkmkEjb7sStjDqGkoJq0X85KKMkoVkIN28yuYEW8W1RBZbHa0Ptt
         Xk5Isz2GVyT+UFq6g7hCUoJDn1+obL5oW+qLsRQjc8/BWK8J01QtGg511lPs6yrY1FUe
         x3A4LOJkAAOrwy+Qwvm/Ok+cqp56c6hs0Gz4q132my4jFZFpHoh+nyImT+bxnZOQAJAt
         Xh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c06zpA8aeXEVo7bsgbGlPOO+xujWnv514iha8A3pDdA=;
        b=E8lvFueyJMGZLJ9i8+0qC8EdrMfpKX5o9U4PST+jyB49rjEsY+ZDnGY5JYAfLip4ry
         qSqi/3shEHnF8zHBV8hUSbQ2gGa7zofGvEgurbULadan13MSN/pjCthARDedsRpA67QU
         ybGF6bz1zIUR3Knpy11wIi9/SH5b/Dy+LdZfWtF3cCSq5rD61bce3M4+QDVN6dBrRQYv
         ez7bAhArm396/2lBin9EtVaBFpVWTJAqlSDy8t0tZRxQdYQrFayOOO3jmBk20z1UVX0G
         ahfVVoEWgypTjrCukthMFrmN88JlQSkRiQ11YKeDLOQiUKBmWb6CDK8Gx9tZb6n0kyL2
         9C8w==
X-Gm-Message-State: AOAM530PM40wkdASXQ9nyzRzjtSZggergHAclpY1ZTGoh9BYNiiWXd/P
        Mhil8U0xv+2DboJBFNKbBMM=
X-Google-Smtp-Source: ABdhPJxqz8nJcZnyJ5uhmuatbBRZTlir1FUwdDWofdoj9xauZbR/jWwd9+0WnSGjzZihjpCnlHuxow==
X-Received: by 2002:a9d:6a:: with SMTP id 97mr642957ota.314.1619722150397;
        Thu, 29 Apr 2021 11:49:10 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-a63d-9643-fc29-df2a.res6.spectrum.com. [2603:8081:140c:1a00:a63d:9643:fc29:df2a])
        by smtp.gmail.com with ESMTPSA id m25sm165026oih.15.2021.04.29.11.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:49:09 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v6 00/10] RDMA/rxe: Implement memory windows
Date:   Thu, 29 Apr 2021 13:48:45 -0500
Message-Id: <20210429184855.54939-1-rpearson@hpe.com>
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
v6:
  Added rxe_ prefix to subroutine names in lines that changed
  from Zhu's review of v5.
v5:
  Fixed a typo in 10th patch.
v4:
  Added a 10th patch to check when MRs have bound MWs
  and disallow dereg and invalidate operations.
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

