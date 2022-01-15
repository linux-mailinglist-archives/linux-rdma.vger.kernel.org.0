Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45E248F4BF
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Jan 2022 05:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiAOE34 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 14 Jan 2022 23:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiAOE34 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 14 Jan 2022 23:29:56 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47009C06161C
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 20:29:56 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 60-20020a9d0142000000b0059103eb18d4so12484077otu.2
        for <linux-rdma@vger.kernel.org>; Fri, 14 Jan 2022 20:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlbi89xfW++8QLpoo+3fwLxug0wl4UQuei4BhYBa6gw=;
        b=O86kJO7RrSPCZfXODQR4MzSYEcG4HPxCGfwFE3mjjCZlS9i3b6jE6Wj+S32ifIAUXc
         yBbfUiTIO3ylRn+dQDbixzbAwb5WaqrDgFHUZgmoYA3/oH4Zs9/4mMrCq2SWrNPFif2e
         tbKkctI27YQx8ztxLcLfa1QhkBdKZkVp73lTOVauL6gh6oLCe1YXWHWlEjOnEmbVnuZl
         nNg9DA1itZojn88W6Vt3JNhNPPdMsksbEFycT6Je0d3c0NQfUta3QUWE6QCXiyjvwxiJ
         vQmoapSi9WKpPcLf1A+NjdgmQ93L3SX6FJ+q1smIbN1BxJGA3nu2bMRrG9vilvyessTH
         Mlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qlbi89xfW++8QLpoo+3fwLxug0wl4UQuei4BhYBa6gw=;
        b=FNzrHLuW0X377tCE7+txn0vgyEmj8zM4Xm9tGLaMaH8IpE1iy5kg26czr4ZNKNbLrg
         5APTU2/5/ztuAxhwnqDYk5SE2wxJtczTntuyf3tno12+s8Uv4hu6L62jqZK1RJwCgjmX
         /uKSdW9HwWtT6wB+ykd0zXK0nOzyjfTyzivWp2rRqOtzsXtWOJC2GEb1rSQ/+F7D4B+H
         0kMJWFPM4dwXquf8s3rhl1J5tskp6gzwOpEqQ6kEuqHSk1Tju1m5gTco5b1c1FLprDVd
         vHM+4A+lpX7k3pGGTx97fsRK6asfZaO0adXZG1ZPljqK3MkWKJiXB7ALToT/HklF72xH
         Slhw==
X-Gm-Message-State: AOAM530R2ITIfCGtjX+jylwlj2cyeoQ61vk1nypTFFztyh0fqz4v5mwv
        g++qzC6hVWgmugfZ4p9lFkQ=
X-Google-Smtp-Source: ABdhPJwK7q6kH6odXoPhGl2v0F/205I2CS6L8tURFq7NPS04IaZGt7VSaMbs5kM4UdlWcuzzKUy0XA==
X-Received: by 2002:a9d:490c:: with SMTP id e12mr8860359otf.90.1642220994524;
        Fri, 14 Jan 2022 20:29:54 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id k8sm2757515oon.2.2022.01.14.20.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 20:29:54 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 0/4] RDMA/rxe: Correct race conditions
Date:   Fri, 14 Jan 2022 22:29:07 -0600
Message-Id: <20220115042910.40181-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are several race conditions discovered in the current rdma_rxe
driver.  They mostly relate to races between normal operations and
destroying objects.  This patch series
 - Makes several minor cleanups in rxe_pool.[ch]
 - Replaces the red-black trees currently used by xarrays for indices
 - Moves the red-black trees used for keyed objects to rxe_mcast
   which was the only use case.
 - Corrects several reference counting errors
 - rebased to current for-next

This patch series applies cleanly to current for-next.
commit c0fe82baaeb2 ("Merge tag 'v5.16' into rdma.git for-next")

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v9
  Following a suggestion of Jason moved all the key code into
  rxe_mcast.c and separated these objects from the pools.
  Tightened up locking to make changes to ref count and xarray
  atomic with each other.
  Combined things to just for patches.
  Dropped the 0008 patch from v8 as not really necessary.
v8
  Fixed an additional race in 3/8 which was not handled correctly.
v7
  Corrected issues reported by Jason Gunthorpe
Link: https://lore.kernel.org/linux-rdma/20211207190947.GH6385@nvidia.com/
Link: https://lore.kernel.org/linux-rdma/20211207191857.GI6385@nvidia.com/
Link: https://lore.kernel.org/linux-rdma/20211207192824.GJ6385@nvidia.com/
v6
  Fixed a kzalloc flags bug.
  Fixed comment bug reported by 'Kernel Test Robot'.
  Changed type of rxe_pool.c in __rxe_fini().
v5
  Removed patches already accepted into for-next and addressed comments
  from Jason Gunthorpe.
v4
  Restructured patch series to change to xarray earlier which
  greatly simplified the changes.
  Rebased to current for-next
v3
  Changed rxe_alloc to use GFP_KERNEL
  Addressed other comments by Jason Gunthorp
  Merged the previous 06/10 and 07/10 patches into one since they overlapped
  Added some minor cleanups as 10/10
v2
  Rebased to current for-next.
  Added 4 additional patches

Bob Pearson (4):
  RDMA/rxe: Move keyed objects to rxe_mcast.c
  RDMA/rxe: Replace RB tree by xarray for indexes
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources

 drivers/infiniband/sw/rxe/rxe.c       | 104 +-----
 drivers/infiniband/sw/rxe/rxe_av.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  24 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 436 ++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_mr.c    |   1 -
 drivers/infiniband/sw/rxe/rxe_mw.c    |   4 -
 drivers/infiniband/sw/rxe/rxe_net.c   |  35 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 498 +++++++++-----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 109 +-----
 drivers/infiniband/sw/rxe/rxe_qp.c    |  15 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  |  28 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  55 +--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 125 +++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  38 --
 drivers/infiniband/sw/rxe/rxe_verbs.h |  30 +-
 15 files changed, 716 insertions(+), 805 deletions(-)

-- 
2.32.0

