Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC70746A991
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 22:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350408AbhLFVSR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 16:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350418AbhLFVRh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 16:17:37 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CACFC0698C1
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 13:14:06 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id bk14so23817652oib.7
        for <linux-rdma@vger.kernel.org>; Mon, 06 Dec 2021 13:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QUQJGtdp3ZXVyn8GLBkigc5F+TLlG+uClDJqYg7GLYY=;
        b=ZHzpOlDmTlN8NM5uPYf3MZgxp7XMein2xj+VR3iDBwWUdOa7Hc9muqd3OFQBJhwm0/
         A8BGdrW8aB84jX6XbNAkhL1otrkP4llWoI0kHSyujaE9MffhHxF2968UljXshWqqV4/b
         /5q4nakh1+lz83ZKgA9WkQfxZYJBthqAKkeTOQEo9iQ+h1eSjZKTcuSbddqLn4r4vIJD
         yG0S8PR7N2gInj7jyiL4sDUQFm8+seAea5ga7aiocpoVt/2Su4QoEBK+rgoEbE/F40Yz
         5VTbrqX2wXMsRjUcX89hwa3J8UHpv4Bh9xUOx0xh1nqp0zr0sF5jEkTTv0b299lN1GU8
         qYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QUQJGtdp3ZXVyn8GLBkigc5F+TLlG+uClDJqYg7GLYY=;
        b=fbpqsHE1y+P3OUr3hIqNxPM/rakw2t/e0rclYlwZM98Ebt0dHO+GGe+/NJyQ3u1x52
         H+ibtwcMOW41vCbe33vPJVvmaS6Qm1tBi9BHGveqK9V2DbjHfe9+NK3z1E2EUvYNta9a
         grhyteWDcXlDW2kG19fsjIZemWn0PJm68PJ1+KU94++uTQfy94pTZEEnvNiejFq0Dug9
         tEqpjE2g96CBiOf+dl5AWW7VWeGusil4wFZDsY2fGh81/el+D6l4sFmSbFDsMgF8V63s
         J9eTF/JHk5L2BQ/6XopadXbRgweNQClFyAjs1xp2QaYNiUPuPuprtK/ITHhmcf+vIA0Y
         ynpA==
X-Gm-Message-State: AOAM531g9+IN26nSbfyGOwmUQ1qYV7FD05IBhbWaOtikjj9d4Nj7qNiE
        n4IyopI/uFu9TDStvTJE67s=
X-Google-Smtp-Source: ABdhPJyXth5jkz5aIWnYRcPE9bnrG6VTHanoksq8Ljkmfwj1e4y0MZ2eNYofnWLmgwGre9lIggHqEA==
X-Received: by 2002:a05:6808:1903:: with SMTP id bf3mr1175249oib.7.1638825245340;
        Mon, 06 Dec 2021 13:14:05 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-07ad-dbeb-c616-747c.res6.spectrum.com. [2603:8081:140c:1a00:7ad:dbeb:c616:747c])
        by smtp.googlemail.com with ESMTPSA id y28sm2819111oix.57.2021.12.06.13.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 13:14:05 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 0/8] RDMA/rxe: Correct race conditions
Date:   Mon,  6 Dec 2021 15:12:35 -0600
Message-Id: <20211206211242.15528-1-rpearsonhpe@gmail.com>
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
 - Simplifies the API for keyed objects
 - Corrects several reference counting errors
 - Adds wait for completions to the paths in verbs APIs which destroy
   objects.

This patch series applies cleanly to current for-next.
commit 81ff48ddda0b ("RDMA/bnxt_re: Use bitmap_zalloc() when applicable")

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
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

Bob Pearson (8):
  RDMA/rxe: Replace RB tree by xarray for indexes
  RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
  RDMA/rxe: Cleanup pool APIs for keyed objects
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources
  RDMA/rxe: Minor cleanups in rxe_pool.c/rxe_pool.h
  RDMA/rxe: Replace rxe_alloc by kzalloc for rxe_mc_elem
  RDMA/rxe: Add wait for completion to obj destruct

 drivers/infiniband/sw/rxe/rxe.c       | 101 +-----
 drivers/infiniband/sw/rxe/rxe_av.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  10 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c |  70 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    |   3 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  18 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  17 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 485 +++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 113 ++----
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  66 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 131 ++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  96 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 -
 16 files changed, 515 insertions(+), 635 deletions(-)

-- 
2.32.0
