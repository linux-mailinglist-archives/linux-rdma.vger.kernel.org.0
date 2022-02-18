Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8794BAE9A
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Feb 2022 01:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiBRAg6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Feb 2022 19:36:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiBRAg5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Feb 2022 19:36:57 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6739421838
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:41 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id x6-20020a4a4106000000b003193022319cso1667615ooa.4
        for <linux-rdma@vger.kernel.org>; Thu, 17 Feb 2022 16:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3TybakanDNhOLYbgamBDhsny+WlXnVaRLmMbOcOiec=;
        b=qIAOW2G/wBgATGQehesHWoUwmgEJUcTf3PrTpW4TDiJfDbEtDeDvsA1fJBl5MWw+52
         ykrptqfTaQ/HMkxr4Divh0MgMtswO8Tn6rJJPLnQeGUpDjTCgdUSofSYFvPKcJ14JIbA
         +IWrNGvCX1kqVPe77lCdJ3x9VwqKL9zI4Nz/aqVyqz+8jbTFz2hvvrmSsoDOq/IY49nM
         Wr02hlODkW1CQSpyPTneGABKTQ2kSbXvFnrIA10r+/3bSc73NSSMKoz8Sxy9PA/txPda
         j38fYRDuOIJNTdXFu/3qIPOBSSOvEW81ZQ5ZhOk0bP5diXDoNbVtwScd9mfKk+rGhSSc
         G3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q3TybakanDNhOLYbgamBDhsny+WlXnVaRLmMbOcOiec=;
        b=XWmkbnri+TEEOB/WPqpDqIeFFKMyGxFHN5qOor/uWNN7OkSDc0wA5F0tAdILULlx6b
         gQJNXH3Ke8IuiY/x2DfMz/YIfl7Zx7SpzNUQUM59P98mGTRks0v+N6WC6UTKgo7VXrBT
         l8MJy1tigLUk/H1fbSgD63t9daNSomEGvyzhZEYDxl6LmuUZwCnXRbD8hwwxN5Aqtfmu
         CYpW7ggdnSnN+fpFrq8VNwABQagbhel0Y8beBQn8i+LuZ/wVwdWwjT4RabAgGUstG20/
         fjaGnAuQc4iMd6Q3zzHtunBc7x+zbXqHVnSKv6pmGwwAD/K+GVyMjm1aLd9GJrzU8pW5
         yngA==
X-Gm-Message-State: AOAM530LP4TAMjjkOr/n4rjEbQXauiiP7hSBIt4bwXCtemcHBfYnd3os
        LGotbSw2aaqbvupveqEwEI4=
X-Google-Smtp-Source: ABdhPJwuuLLPpdZfvVDC3IORzu84CeBcVNjTwWCNK2UYksIn4NXswQTQEtKYRcsDI6k7h33SlcvPBw==
X-Received: by 2002:a05:6870:2c6:b0:b7:2292:ee71 with SMTP id r6-20020a05687002c600b000b72292ee71mr2129170oaf.133.1645144600737;
        Thu, 17 Feb 2022 16:36:40 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-1772-15fa-cf3f-3cd5.res6.spectrum.com. [2603:8081:140c:1a00:1772:15fa:cf3f:3cd5])
        by smtp.googlemail.com with ESMTPSA id t31sm19698299oaa.9.2022.02.17.16.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:36:40 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 0/6] Move two object pools to rxe_mcast.c
Date:   Thu, 17 Feb 2022 18:35:38 -0600
Message-Id: <20220218003543.205799-1-rpearsonhpe@gmail.com>
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

This patch series completes the separation of the mc_grp and mc_elem
object pools from rxe_pools.c and moving of their code to rxe_mcast.c.
This makes sense because these two pools are different from the other
pools as the only ones that do not share objects with rdma-core and
that use key's instead of indices to enable looking up objects. This
change will enable a significant simplification of the normal object
pools.

These patches correspond to 08-11/11 of the previous version of this
series. The earler patches have been accepted.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v12
  Addressed issues raised by Jason Gunthorpe.
  Returned a warning if rdma-core fails to cleanup mcast memory.
  Split the 'cleanup patch' into more managable patches.
  Fixed an error in the rcu patch by moving the kfree and
  rxe_drop_ref(qp) to a call_rcu() routine.
v11
  Restructured the patch series to simplify it and make each patch
  simpler. Addressed some additional issues raised by Jason Gunthorpe
  in the review of that last version.
v10
  Corrected issues reported by Jason Gunthorpe
  Isolated patches 01-17 separate from the remaining patches.
  They will be submitted later
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

Bob Pearson (6):
  RDMA/rxe: Add code to cleanup mcast memory
  RDMA/rxe: Collect init code for mca in a subroutine
  RDMA/rxe: Collect cleanup mca code in a subroutine
  RDMA/rxe: Cleanup rxe_mcast.c
  RDMA/rxe: For mcast copy qp list to temp array
  RDMA/rxe: Convert mca read locking to RCU

 drivers/infiniband/sw/rxe/rxe.c       |   2 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 +
 drivers/infiniband/sw/rxe/rxe_mcast.c | 289 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_recv.c  | 107 ++++++----
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 +
 5 files changed, 298 insertions(+), 104 deletions(-)


This patch series applies to the current version of wip/jgg-for-next
base-commit: 3810c1a1cbe8f3157f644b4e42f6c0157dfd22cb
-- 
2.32.0

