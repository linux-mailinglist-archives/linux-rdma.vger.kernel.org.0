Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670E1360023
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 04:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhDOCz3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Apr 2021 22:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDOCz2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Apr 2021 22:55:28 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56A4C061574
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:04 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id y23-20020a4ade170000b02901e6250b3be6so2590338oot.5
        for <linux-rdma@vger.kernel.org>; Wed, 14 Apr 2021 19:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tLcfSlgxrXUi90RRjno4hVCSokvC8NAcUYeejW79RM=;
        b=vR2Sy6twjbC3MoD9L9muEIciZC63w5V8t33pxD4lfRSfzhIV5Zym3uRPMQY0/vmnGZ
         kbzzItRnzuAyP+t3lWdigmGXJIfO0fcuGui5wMwgZ0gyMn+f93R0IdwBrkf44FHS+k20
         qx/pD4v25xOC1mhQrO7zo/teXzJ9u53HUPVpvEEMjy6ZEXgpbRX2iphMII5SAWcyPfcX
         OiodGMpqoZ4CXJJhjWTvMw+nMnQISAlAL2YcQ1yot+D7ywWY/Ik1KSaJfr5G/zHAiHFG
         SU/fKWcxaNITvV3cdBFsAwPQI9/G0uwE4QRdIIbuNX5s/cfugI4QBoEx6AK93L59pBU7
         PNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/tLcfSlgxrXUi90RRjno4hVCSokvC8NAcUYeejW79RM=;
        b=hxFK2iIxPiMmFyAB1l5GGUokCVgujrCFwlFbB9Yw6wJdG3o7ABoOCVh0h0mDdUh6qW
         pYvjXEPJWW6bh3gvuigXqnz2niQK/xZmsrwPbbm9PIvSAiboB4lgmsPW3UZ0LOZJ1ECW
         19IQy8GdztNxO6kZyJbrIFVt+AqiiD1hPgc3JSEggYxRCWyBa7tkIf7dRKsXjXzOuRLI
         6AXvsgRGb/r5zkH0hs91E1qRJvY7d+HTn1ZoECM8mIeVB/iJKMKWQTZAnDzOSXCph0jC
         0TwkIAOGg4U+g0n2H+mKRXJKr4c74cnpA037t+hDFIcNe/Q4+TXd43Q+MkF+Yb4ZIvyF
         kPLA==
X-Gm-Message-State: AOAM532Qb/B9MYwHK6KxvlM2LDlo2M8uUlZBk8T3F1CbFinBL0sJ8rxm
        CbV2sH07xVRStP97HWd8F14=
X-Google-Smtp-Source: ABdhPJyK/25suHIec23evn3VQaEWNPgND1hELgkhv/mE6kCsFAQ/WSuPW0OG6+VvpTh2dqkXeiSnIg==
X-Received: by 2002:a4a:b305:: with SMTP id m5mr952455ooo.76.1618455304379;
        Wed, 14 Apr 2021 19:55:04 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9ee3-9764-577f-477e.res6.spectrum.com. [2603:8081:140c:1a00:9ee3:9764:577f:477e])
        by smtp.gmail.com with ESMTPSA id q22sm361801otf.72.2021.04.14.19.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 19:55:04 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next v2 0/9] RDMA/rxe: Implement memory windows
Date:   Wed, 14 Apr 2021 21:54:21 -0500
Message-Id: <20210415025429.11053-1-rpearson@hpe.com>
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

