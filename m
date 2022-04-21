Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D395094B3
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 03:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383662AbiDUBn6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 21:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383654AbiDUBn5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 21:43:57 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B817B765E
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:09 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r8so4100846oib.5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 18:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6sYhpIzGhcE/4rOoUGq7qrWYNeNG1cT32D4XgmbJ8Hg=;
        b=nu0sihbbW2dEsQpy9uNLtGbTovXssDqBhJ7r103Tnv2EaFRqsdWv4igQaUli+rvul5
         jNZcp0xfv115TYY+j/ceGAn76YbfW6V5FGatfijuKuhsA9NiKfc6A+HB35JHhQAVy3vp
         yf1p3xRXPfY5XntxXkIPbSUIF+DE/xKbiJqq8AJD6g8BbJXBolQuGFcGnqXkIoWSoYee
         Gm3N5VzdAKIIlQc6TH2qjS+6tgYg94nlaD5o86h3gmQ0DjJR4TLkIRfzwvcnBt+elSfW
         Pd/vnduGb6JTgZjcQJ7PngCQz/MMwQcNssmM0yFtr+GXCKiR7YnspA8dAvtLxgbQNuzx
         T0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6sYhpIzGhcE/4rOoUGq7qrWYNeNG1cT32D4XgmbJ8Hg=;
        b=sUGAbaqoL+y5aRbvzlWvGThJixOaMOoeMj4Yb19hmpiaRaRV6lnAZAogc4AppPJ4/D
         T8RX2392hPosEyioHOfrydhj1bh4OSu7KstHV4SxS1jWqmE//pRCI3S/UynT+7MJSFFG
         lfxAKSm85prE7T8qyuV0isSXSrhb9LWnQD7MsmUKYS87CNKLOVXBaw/u693n3YGjIntU
         hctJVu8LjM73v3j49UJiyKD6HD5W4BengD1metI1qeCN6LzyMzMMu2OTV4IhupShh6BK
         V0KOTCJXJELHzFYWYYigFEA2MrwITqxA3UXiGUTzzQLgl04WDgKGEG95/G7O6gS0dE8X
         nJ7Q==
X-Gm-Message-State: AOAM5336Aba2RCKh5cw3v4C0YprImBImoyR6fstHJI6OhMdAazX1Y9uF
        sday0f6c82DJZ8Hl2lrsdzw=
X-Google-Smtp-Source: ABdhPJzvFC/zZfDmPJTzmv2XeQbFTJNYz1yfm57nOPRAD+onx1c0OamSdgJ5Hn6G8TInP5LNbPC17g==
X-Received: by 2002:a05:6808:d4c:b0:322:e7de:fffe with SMTP id w12-20020a0568080d4c00b00322e7defffemr2332623oik.107.1650505269074;
        Wed, 20 Apr 2022 18:41:09 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-c7f7-b397-372c-b2f0.res6.spectrum.com. [2603:8081:140c:1a00:c7f7:b397:372c:b2f0])
        by smtp.googlemail.com with ESMTPSA id l16-20020a9d6a90000000b0060548d240d4sm4847710otq.74.2022.04.20.18.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 18:41:08 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v14 00/10] Fix race conditions in rxe_pool
Date:   Wed, 20 Apr 2022 20:40:33 -0500
Message-Id: <20220421014042.26985-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
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

There are several race conditions discovered in the current rdma_rxe
driver.  They mostly relate to races between normal operations and
destroying objects.  This patch series
 - Makes several minor cleanups in rxe_pool.[ch]
 - Adds wait for completions to the paths in verbs APIs which destroy
   objects.
 - Changes read side locking to rcu.
 - Moves object cleanup code to after ref count is zero

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v14
  Rebased to current wip/jgg-for-next
  Removed patch 3 as unnecessary
  Waited for resolution of bugs in rxe_resp and some locking bugs.

  Note: With rcu read lock in rxe_pool_get_index there are no bottom
  half spinlocks from looking up AH or non AH objects to conflict
  with the default xa_lock so no lockdep warnings occur. The rxe_pool
  alloc functions can hold locks simultanteously with the rcu read
  lock so it does not have to prevent soft or hard IRQs.
v13
  Rebased to current for-next
  Addressed Jason's comments on patch 1, 8 and 9. 8 and 9 are
  combined into one patch.
v12
  Rebased to current wip/jgg-for-next
  Dropped patches already accepted from v11.
  Moved all object cleanup code to type specific cleanup routines.
  Renamed to match Jason's requests.
  Addressed some other issued raised.
  Kept the contentious rxe_hide() function but renamed to
  rxe_disable_lookup() which says what it does. I am still convinced
  this cleaner than other alternatives like moving xa_erase to the
  top of destroy routines but just for indexed objects.
v11
  Rebased to current for-next.
  Reordered patches and made other changes to respond to issues
  reported by Jason Gunthorpe.
v10
  Rebased to current wip/jgg-for-next.
  Split some patches into smaller ones.
v9
  Corrected issues reported by Jason Gunthorpe,
  Converted locking in rxe_mcast.c and rxe_pool.c to use RCU
  Split up the patches into smaller changes
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

Bob Pearson (10):
  RDMA/rxe: Remove IB_SRQ_INIT_MASK
  RDMA/rxe: Add rxe_srq_cleanup()
  RDMA/rxe: Check rxe_get() return value
  RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
  RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
  RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
  RDMA/rxe: Enforce IBA C11-17
  RDMA/rxe: Stop lookup of partially built objects
  RDMA/rxe: Convert read side locking to rcu
  RDMA/rxe: Cleanup rxe_pool.c

 drivers/infiniband/sw/rxe/rxe_comp.c  |   3 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  17 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    |  12 +--
 drivers/infiniband/sw/rxe/rxe_mw.c    |  61 ++++++------
 drivers/infiniband/sw/rxe/rxe_pool.c  |  84 +++++++++++++++--
 drivers/infiniband/sw/rxe/rxe_pool.h  |  11 ++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  22 +++--
 drivers/infiniband/sw/rxe/rxe_req.c   |   3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |   3 +-
 drivers/infiniband/sw/rxe/rxe_srq.c   | 129 ++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  68 ++++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 12 files changed, 266 insertions(+), 148 deletions(-)


base-commit: b5a93e79df64c32814f0edefdb920b540cbc986a
prerequisite-patch-id: 376fbfd86efaaa87f16eec9b4000b2db2594d404
prerequisite-patch-id: 872b59d5187d9ffc2ef5bbca0c6b92148662a8cf
prerequisite-patch-id: 89ae7ec3782cb2bc6ed0861bd2df80fba5f24837
prerequisite-patch-id: 98b76b1e695ea473644df0ae427539c4593b36fb
prerequisite-patch-id: deac497973b5842e6838196f509f5315afef1521
-- 
2.32.0

