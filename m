Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DA390B9D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 May 2021 23:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhEYVkC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 May 2021 17:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhEYVkB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 May 2021 17:40:01 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5636C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:29 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w127so27848717oig.12
        for <linux-rdma@vger.kernel.org>; Tue, 25 May 2021 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=joBW7ooPOnWQ9XBYJKEGBSdINm6mTef6YMUxipMqFK0=;
        b=B4HYvJfCI1PiHLS7X7j8Und9RW+0N+ACPEeGiLfHj+dThPRgfQggUWE9uoNMNFmn8H
         S2QZPsY8YroKOs+OfzH5yQivENWa2XSop2+gHejSdsN4QspT9GKDPnChUzwK1I8OLs/2
         pClf/5AgiPBlNDqmTi4KT5kDUIin1NQaaa9BZvRid4b/DpkuQQqZF6DZCtarRXeAE7SA
         TY86cvsWFZ6qyPAnXQUHANUezHEn4awzFmcrEmDyGDdhVC84TEJBa4sVTe8rnNhZEa6C
         Yz8PAMB8vebPRcpuUFOnu6d6K+BSDl9hRedTX5SECBMkvOweTxQemrXAG0fDW5ZDcTqt
         WoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=joBW7ooPOnWQ9XBYJKEGBSdINm6mTef6YMUxipMqFK0=;
        b=qrX8QYO/8UN+YLeVET4l651ROGP/py1h05x9EzWWpOWKhqOHS/MGpi+oXI0BGGseNG
         0XB0seiKtV6MaptQfDWDfYSGXMnV86UkM2SakaxVZaNd5X6iLsrw3HngZF5mZljD67Gs
         yAay9AKd2Ft0tMJTgkqkMZV5/hdFtH1rJ4RlOYQAfRdBNo+b3Vq2AC9+wBbZaxK24kfg
         ErnLvxgJ69nJTHs20tlmKogVxZUM4rL9ZdGxFwRgsEmW8RVGRT9xN6wah6UDO1eMeFx9
         vZU73GjP8ggGRTtk3lRu5NQ1pWODcf6+f9AsKZ4hbZLK9oVhFY6EvVlYA0wEbvXqdo5l
         nYig==
X-Gm-Message-State: AOAM533xCYaJymNIQiOMrsWyyoBGrBgM3oAKFP5RTZhQg+MS8w/ovLPh
        j9vEPHAaszed1pJc/FdcaW4=
X-Google-Smtp-Source: ABdhPJw3tywdqMxGWlVoCWHT86LUQtyHw3Lo5M26WkAamJMztjJtCu1ugmvHvxU7unRYOx3RJzw8lA==
X-Received: by 2002:aca:42c6:: with SMTP id p189mr276053oia.36.1621978709104;
        Tue, 25 May 2021 14:38:29 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-e4a4-ac6f-8cca-71ad.res6.spectrum.com. [2603:8081:140c:1a00:e4a4:ac6f:8cca:71ad])
        by smtp.gmail.com with ESMTPSA id f6sm3523376otb.64.2021.05.25.14.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:38:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 00/10] RDMA/rxe: Implement memory windows
Date:   Tue, 25 May 2021 16:37:42 -0500
Message-Id: <20210525213751.629017-1-rpearsonhpe@gmail.com>
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
v8:
  Dropped wr.mw.flags in the rxe_send_wr struct in rdma_user_rxe.h.
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

Bob Pearson (10):
  RDMA/rxe: Add bind MW fields to rxe_send_wr
  RDMA/rxe: Return errors for add index and key
  RDMA/rxe: Enable MW object pool
  RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
  RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
  RDMA/rxe: Move local ops to subroutine
  RDMA/rxe: Add support for bind MW work requests
  RDMA/rxe: Implement invalidate MW operations
  RDMA/rxe: Implement memory access through MWs
  RDMA/rxe: Disallow MR dereg and invalidate when bound

 drivers/infiniband/sw/rxe/Makefile     |   1 +
 drivers/infiniband/sw/rxe/rxe.c        |   1 +
 drivers/infiniband/sw/rxe/rxe_comp.c   |   5 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  36 +--
 drivers/infiniband/sw/rxe/rxe_mr.c     | 126 ++++++---
 drivers/infiniband/sw/rxe/rxe_mw.c     | 343 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
 drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
 drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
 drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
 drivers/infiniband/sw/rxe/rxe_req.c    | 104 +++++---
 drivers/infiniband/sw/rxe/rxe_resp.c   | 111 +++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c  |  15 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  48 +++-
 include/uapi/rdma/rdma_user_rxe.h      |  10 +
 16 files changed, 702 insertions(+), 184 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
-- 
2.27.0

