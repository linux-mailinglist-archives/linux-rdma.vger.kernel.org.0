Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF6547CD2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Jun 2022 00:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiFLWfS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 12 Jun 2022 18:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiFLWfQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 12 Jun 2022 18:35:16 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5769F2252E
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jun 2022 15:35:14 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id u8-20020a4ae688000000b0041b8dab7f71so918829oot.7
        for <linux-rdma@vger.kernel.org>; Sun, 12 Jun 2022 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4AXGX9kZGJmjBAa2k/kOzYO3L3hcomxsWtijtlwCXk=;
        b=Nb3J+ScbohC5KkqaYD5MqAbbpCe4qShdORbbb2GD4my/U4+AJqiLoBrqIS+qgqVlQR
         hszpwONzcJ2hfPc7hS5FA4ZNTMcDkEypAeuBXXEt8Ce9E605A+LqPshdzKAl9XzGxAhQ
         l3k9h5dsOVM22UOFqcmEhO8skZdXj4tM+RxWqLo96auYPWcyjsDpRp36vOmvA35d77qT
         EXD86jBkJwTL0M7DnizWvZWyfKIPW/Aw5tAPejUmY9k3z1Ae6vJvgaBhWmEXczeix6jx
         V4JVRXTd/cxOjWAg30lwbf7ol0t677FzG1gZ0AVqFpGamIQ3FPmtkaUlAGmPx7sl5t91
         +aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j4AXGX9kZGJmjBAa2k/kOzYO3L3hcomxsWtijtlwCXk=;
        b=4n1JqyO4srfAj5WNukVnUsvWO6yBeRtRSVi8wZGyRMrew2zibZOM4qOlDH/kxYzJXw
         pOQdQUztovlHSsqplVX+vJ5kOpUhwpjR9COPUpsxZ1VbQD7dlDu7M4jBY2PDjqR3vdjH
         NH887W3LubK55N/9BYWBFx+jwR/Gf1nfyzilyRRS5mlBz7KnHHmAGdVYax/M3QBndTCa
         SLz5hLAp9ciLdFNcxAE14vzWK/suT15FM3er1dmpWkDLmhbFf0zOBgPQpC7ZHj7lrxYF
         XjvgztnKDB0ipzSVK/wNsOZblu1h7lRillh9hJ3QWigjZdYr9lhpDK0NPfJ+Pi0OPJab
         nTjQ==
X-Gm-Message-State: AOAM531+u7WqaouiRrXyjnHVV6vj4AINwnXLW9qccxMCcQlYNGVZRiYe
        T8jglZ8z//a5d3UkNRQCeRQ=
X-Google-Smtp-Source: ABdhPJxi7X4fsMfcgUpM6mFR83iQQ4/bMbH1W/FHi1SZbfR1gFP2iQJwa+Dohv7bqaGlKzPl0qGm7g==
X-Received: by 2002:a4a:e787:0:b0:41b:7367:3587 with SMTP id x7-20020a4ae787000000b0041b73673587mr16521093oov.11.1655073314268;
        Sun, 12 Jun 2022 15:35:14 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id y185-20020aca32c2000000b00326414c1bb7sm2562421oiy.35.2022.06.12.15.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 15:35:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, frank.zago@hpe.com,
        ian.ziemba@hpe.com, jhack@hpe.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v16 0/2] Fix race conditions in rxe_pool
Date:   Sun, 12 Jun 2022 17:34:33 -0500
Message-Id: <20220612223434.31462-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are several race conditions discovered in the current rdma_rxe
driver.  They mostly relate to races between normal operations and
destroying objects.  This patch series includes the remaining two
patches of the original series.

Applies cleanly to current for-next after the two oneline patches
submitted by Dongliang Mu that fixed an error in the error checking
code from xa_alloc_cyclic().

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v16
  Addressed some issues raised by Jason Gunthorpe.
  - Added if(sleepable) might_sleep() calls.
  - Dropped the stray fence patch that got in there somehow.
  - Left the timeout for AH cleanup. We can drop it later if
    it isn't needed.
v15
  Rebased to the current for-next branch of 5.19.0-rc1+.
  Adds support for RDMA_AH_CREATE/DESTROY_SLEEPABLE.
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

Bob Pearson (2):
  RDMA/rxe: Stop lookup of partially built objects
  RDMA/rxe: Convert read side locking to rcu

 drivers/infiniband/sw/rxe/rxe_mr.c    |   2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 102 +++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_pool.h  |  18 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  39 ++++++----
 5 files changed, 133 insertions(+), 32 deletions(-)


base-commit: 61414011df6607415c14805dabf0687663090e0a
-- 
2.34.1

