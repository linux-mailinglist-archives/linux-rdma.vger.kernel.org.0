Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5734F1F20
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Apr 2022 00:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbiDDW3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 Apr 2022 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349068AbiDDW2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 Apr 2022 18:28:20 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A848517FA
        for <linux-rdma@vger.kernel.org>; Mon,  4 Apr 2022 14:51:25 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-de48295467so12391115fac.2
        for <linux-rdma@vger.kernel.org>; Mon, 04 Apr 2022 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gbDuMRvkbtiQrzkp3EEsLjYJh7ICysq0v7cSHQK7ZC4=;
        b=CdHjb+YRsQ7JaP2B5Sgr8ieywBW6lv5XvLKYBA2C2dRAMFJqIm2y3AtnmJ1yb7ugVK
         kPZT6Xj1f0Q2sxQ9pyBDKEY7k1+sFBg4k+f2ZT1GEDjvtkkO0jKvafeaxKESL9VOGgYr
         QHbumWCbFFwg4K/VtYStJAi+lcPPWdtEOWuYNgKBlmSYkba0BFB7EF8aN4EKiRqTUnIJ
         uimRRlL6hmdYBL3aRCuuwncPrVX2sCA0WnGIQYG9vrzisdo8XfhXpUktma867PYnKXlh
         k5PSBTtlkMqFXBECEQ6bd5HFBoApjhSxckE4Apl1TXhiFpyZrY4LdVOBSQ9auEtUCp3M
         bPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gbDuMRvkbtiQrzkp3EEsLjYJh7ICysq0v7cSHQK7ZC4=;
        b=rkWJm7sI+PbLH/I3gcHNAb9cS/gUZS5542ed7bnQFv9BquAeg8SuFVAX6E4Mh9eyO0
         RgWNvaWxAZYLd6TtfL4XhYNBwhFnHOXP3tVoP94doMxmk68ubayHR+FQy1U4+rXnpbBN
         XxMN7jTYTalBCT2pLGT49HskyLE5e9EbGkoDWOJthlGiUn37ofDcs+8buPysOL41K2Df
         zXVqP3wvfFbKtnEGUzQXZVg6duH79OZptJDYUL4DfKAQBq92qEUO+NP2ZCIhdI5f1eRc
         Gi1Y7s0zV9ut4JI18MfyXYTmnerpa8filvbQwHF0ILuJbpmNrqJz0+hDb2WGLxA8aEfo
         l6xA==
X-Gm-Message-State: AOAM533t8McQMv8rbNQzW+Dfxkx8Z+6f35GbnMMWFcWMjlGw+Pb2DQTh
        rSP8ita8ZvsEdyx8rkalGfE=
X-Google-Smtp-Source: ABdhPJxB+CB4rFh4ZSVKUVO2/Zp6ZKw+dya28YaskBQSNcdNOZrxmNUJaJYUuwq9fQ+ciuIpbkjuUw==
X-Received: by 2002:a05:6870:c892:b0:de:5f75:d8 with SMTP id er18-20020a056870c89200b000de5f7500d8mr137636oab.133.1649109084749;
        Mon, 04 Apr 2022 14:51:24 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-349e-d2a8-b899-a3ee.res6.spectrum.com. [2603:8081:140c:1a00:349e:d2a8:b899:a3ee])
        by smtp.googlemail.com with ESMTPSA id e2-20020a0568301f2200b005cdafdea1d9sm5226441oth.50.2022.04.04.14.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 14:51:24 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 00/10] Fix race conditions in rxe_pool
Date:   Mon,  4 Apr 2022 16:50:50 -0500
Message-Id: <20220404215059.39819-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
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
destroying objects.  This patch series
 - Makes several minor cleanups in rxe_pool.[ch]
 - Adds wait for completions to the paths in verbs APIs which destroy
   objects.
 - Changes read side locking to rcu.
 - Moves object cleanup code to after ref count is zero

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
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
 drivers/infiniband/sw/rxe/rxe_loc.h   |  17 ++-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  12 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  61 +++++-----
 drivers/infiniband/sw/rxe/rxe_pool.c  | 157 ++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_pool.h  |  11 +-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  22 ++--
 drivers/infiniband/sw/rxe/rxe_req.c   |   3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |   3 +-
 drivers/infiniband/sw/rxe/rxe_srq.c   | 129 +++++++++++++--------
 drivers/infiniband/sw/rxe/rxe_verbs.c |  68 ++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 +
 12 files changed, 325 insertions(+), 162 deletions(-)

base-commit: 3123109284176b1532874591f7c81f3837bbdc17
-- 
2.32.0

