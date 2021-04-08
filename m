Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A057358F57
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Apr 2021 23:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbhDHVlP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Apr 2021 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhDHVlO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Apr 2021 17:41:14 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A32C061760
        for <linux-rdma@vger.kernel.org>; Thu,  8 Apr 2021 14:41:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id x2so3726472oiv.2
        for <linux-rdma@vger.kernel.org>; Thu, 08 Apr 2021 14:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3baxRvLP6h0Vm69jMsRf1pJEpcHr4Y6XbpPg4+y1po=;
        b=kzkMs4az6ZZK74gB2AMSX5UGzrxinrQ3E9On5dZj1usRcbY/9kZQTSYBlhTascevCb
         6yalnOLxJH13xdE30f1cdiZlAal5RlLXAfnXDNhoaHibhqDwicorXE9QtZgm+EuT5twc
         UjYQNrEoCJFO/mGKXTwBFRRrK0S3EPfJ4VAW9nQ9xPnUCSR71LMnQhp7uqQxqrjwwdrH
         L4YMrWNAJRupZ2WVPgFMwP8zGtTmy7tvuaFzILgFNTME8pFIT7TOBJPRZTzuyr+Cpxx2
         USWPksqYt1C0xl6mGdp/leMG9XaK7IUM6irLxz/+ntLJhNM/z05fBzzwKf95jsFay2Dg
         9Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3baxRvLP6h0Vm69jMsRf1pJEpcHr4Y6XbpPg4+y1po=;
        b=RmkzjSbtcBx/+1AqBkq8aWr2YKeAYPGuqipp1uQV58/7ruzkE7vCGNN7zEl+xWv6bC
         l2V+ZGtNoAQhQ7KYiPfxkLCR6UHEe9/YxtfExts/EJnTIOCwYcTiUPPMiYOGMkT5GW04
         fJwMKdEmDsIAZUd62oiamJsOJEQzbfv8tTDdFWPhQlwsJvW7nxFGBlO5H5/HtMybHdkU
         3iuw5xl1H9JorepklNBdz8TTMqMDH5V5nY5F/pyKmdXi0Lj9stnGe/GPqzq239+Unfd5
         BPnduxZoe2ODVG9gXJYsJoM5jAc7FWCvzanHSePTAiJRBv4ullomsbOYJwtq9tMIt4T+
         M4NA==
X-Gm-Message-State: AOAM531YMUTz2q/MPrCMf5CSzzcmvSIe3jPUHjCOn0uOAHcm3/vUUrsu
        tzJ/E+apRTMJriqmPanwIMGPKjIfC4M=
X-Google-Smtp-Source: ABdhPJwpUCcJzWNBDj1QN0N/sGDqUFqruIEa+JLm5qUaLFqi8lAgEip7DoxuceDF4n5NzMqP+y6Idg==
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr7930195oie.4.1617918062603;
        Thu, 08 Apr 2021 14:41:02 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-9d4e-47e2-9152-a38a.res6.spectrum.com. [2603:8081:140c:1a00:9d4e:47e2:9152:a38a])
        by smtp.gmail.com with ESMTPSA id r22sm147372otg.4.2021.04.08.14.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:41:02 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     jgg@nvidia.com, xyzxyz2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH for-next 0/9] RDMA/rxe: Implement memory windows
Date:   Thu,  8 Apr 2021 16:40:32 -0500
Message-Id: <20210408214040.2956-1-rpearson@hpe.com>
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

Signed-off-by: Bob Pearson <rpearson@hpe.com>
-- 
2.27.0

