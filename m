Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9C38CECA
	for <lists+linux-rdma@lfdr.de>; Fri, 21 May 2021 22:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhEUUUg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 May 2021 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhEUUUg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 May 2021 16:20:36 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15AFC061574
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:12 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id c196so12601870oib.9
        for <linux-rdma@vger.kernel.org>; Fri, 21 May 2021 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8DWv28DaYf62bi4qy771wvTA9aLY7fDBxxnLJ0/eQrg=;
        b=LCwIqpYb9EMSHWHaGX92bcE7dBQUQrvE9K7QdVt5oWpqbLbW5XcteuVRdU80U0mgZs
         ZAyCw/tKVpeLpKu7qn6ARu1L+Q+eBHhsz1Fhn0/sry7OOEQk27DG4SlTtIrEaGV0/W3H
         0CNRQ+yz+AbcZsmf/4EM8XZiBKue2txwyGeYdUERIXz3uUrfTSCWBVZFzzaMvvHDgJy/
         4p3ITeLkzdcB4nhP461XmW6akt8Gc6POiFCcsGORyqXp8k81FoUShSBEdXmQlxaEvsc0
         eb9Mp3gZrB50MBUISc11PYXkJQ+gmtLRQp04RJlAgTiRpq1XGbljOAt0xtGF7W4CKMjP
         ZnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8DWv28DaYf62bi4qy771wvTA9aLY7fDBxxnLJ0/eQrg=;
        b=H9vuEBRc5qrZHlZXlZyvvMpQPB1L+SI8FZuD9kZ/f2XElibRz3itEc2CJn8QzmG5ZN
         G5tOFs4aVluLcuEyTik3ucQP/B82KUq207LKad9OuyabYTj75vNoJr7UpK9IiiypDPNS
         jzVsyzeDWKabtQm/A5bld28gZveD5FDLxP6XTMfdxILOMpKuYU6sZtieU8t1t2kM1mPB
         tCnE+RoUqqbAZ720qf3sNw4C8jIugGkphWnuZWD0a5j1UDM8t6ioiiLTDXxSTXLg6Qlh
         MC21ur6glcUHmamDMS27krBB3F+IBB93a7uaGX9WRS7/zobkA6Kqfs9phpuPeHLfe3E3
         zaFg==
X-Gm-Message-State: AOAM5336Qn9Co5y5gDB285ChgZ2+Zfzl5j5HSVMzqIhljbk8ctJInrvD
        eVbV1/klx1i/Y+mgvrL0Tn0=
X-Google-Smtp-Source: ABdhPJwahwVqRq+jkETiA7eBnwYC/GKsL2evgKgfKeNk4T6bAQ9tX8ugfncCfZbrmidGoWQRftZfJw==
X-Received: by 2002:aca:b605:: with SMTP id g5mr3465985oif.127.1621628352379;
        Fri, 21 May 2021 13:19:12 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-7300-72eb-72bd-e6db.res6.spectrum.com. [2603:8081:140c:1a00:7300:72eb:72bd:e6db])
        by smtp.gmail.com with ESMTPSA id z9sm1376721oog.25.2021.05.21.13.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:19:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 00/10] RDMA/rxe: Implement memory windows
Date:   Fri, 21 May 2021 15:18:15 -0500
Message-Id: <20210521201824.659565-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches implement memory windows for the rdma_rxe
driver. This is a shorter reimplementation of an earlier patch set.
They apply to and depend on the current for-next linux rdma tree.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v7:
  Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.
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

