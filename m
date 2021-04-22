Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250C236848C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhDVQOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbhDVQOV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Apr 2021 12:14:21 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46746C06174A
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:45 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id i16-20020a9d68d00000b0290286edfdfe9eso32033741oto.3
        for <linux-rdma@vger.kernel.org>; Thu, 22 Apr 2021 09:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iUWhUjVNBIbRCABpYkNYfOZULErEy0ciw2PqpdM2gc=;
        b=pM+jkt4aBNrZHv6kah7NgkICTJC748XeZLgzU9d1mM55WlLMLdRMw0yE1S4Zub1UBf
         OHAy8th686f/8KIsLT+36qcUziVgecWIYAkwisWs0t3Q95e483Qf5FmlP6AODjqnpAR3
         YjsZIP3Tfszaxf66yN+sDk4WDcHJf6F1dJ3Juu+X03pD+K+FCjFZskdMG0XyXdyf93yq
         tghhpHgwOBwEMOYWjYMV/vvyNpyZ91TGqQYW6u8Dtfqju7SSSjqTINiYvtoWlX85wRTA
         7P28DHDwf03VJKuj1h3o6fllMys5o6LXCKayih460TST0NSw8IrpVOSyCXljlLgwilnb
         frRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iUWhUjVNBIbRCABpYkNYfOZULErEy0ciw2PqpdM2gc=;
        b=Ng+eXjckmKw/C/PS0v/t0p6+d+KRl1F+4hmq6BtvURyqASRYwdG9AtEErh74J9FEUe
         Z1Ho0e0euiSnu4GX78oHcyRcSdLumS3eq1eil+0uvOmYDiQ6Wz1jKu8Qy+uUvwy/N06N
         Jbw6h7Ai+O0Fe3Dte7DlHrpTValfR2TMGEO/rXvA63nU4I667ylQKeCHwZfOi1EM5ge0
         jWXWOAioPoVBt7NQ4cFPpIiGkAltyf+qb9JfyxhG4DbsMxc+o1tmEZVGjEQ9UD9TL9RM
         22DOaY7S/agRO66gx8J4kBm9Sxj3EVnTy4H/CO55q8cetBLmr2L4BmxMD7xHcnYlWBgn
         aaPQ==
X-Gm-Message-State: AOAM530mx66/hYbiU8lQgHOpvezqbmlTBrCOsZdnu0LSH0a5ENe7paSP
        rvP/Bf7S5SKbgla24zEjTOu24G7fj5A=
X-Google-Smtp-Source: ABdhPJwd51Q+Y1K6BkywANTekUA9v49rk96Weu3QjgezFjXlbyyIM481AY74nw4WPsz/0W4NE46B5g==
X-Received: by 2002:a05:6830:1391:: with SMTP id d17mr3513502otq.58.1619108024691;
        Thu, 22 Apr 2021 09:13:44 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e336-c4b4-ca5e-5b3f.res6.spectrum.com. [2603:8081:140c:1a00:e336:c4b4:ca5e:5b3f])
        by smtp.gmail.com with ESMTPSA id s19sm707357otq.6.2021.04.22.09.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 09:13:44 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v4 00/10] RDMA/rxe: Implement memory windows
Date:   Thu, 22 Apr 2021 11:13:31 -0500
Message-Id: <20210422161341.41929-1-rpearson@hpe.com>
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

