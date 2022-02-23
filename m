Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA54C1F59
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Feb 2022 00:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiBWXIC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Feb 2022 18:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244062AbiBWXIA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 23 Feb 2022 18:08:00 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EBF419B6
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:31 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so832891oob.8
        for <linux-rdma@vger.kernel.org>; Wed, 23 Feb 2022 15:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeEjsUJZXmq6T4p3lE72hnbTLlGEcBDOQg2JKUDWVJE=;
        b=R15YJZHY7JyXrMW2VyiWnmtpmrbphR4IyE7OIzLdgpv2inVtfv+D+M1nTfXnDTiynu
         gBRmB/0QyWUxHXiTllbna4oHqGHlqrzyO+ePnxeacMNjnlmVwpPN7oE0GLXVcOJegut9
         5JU6pzrxUZudb3I1J0KP7iHGKwRk9TAVdCfq/l3YUALwjvP28lBuWmMBeotQt9AFwVXO
         p2lwY1g8ZFK5XygRKYfSmNcZs4RqFekr6mRQMyOk6Qo5IYAUxtVUSzDZd8uXaGwK0Sfo
         f1LceOgPXGxmbLlf4dQ9ZLE+aoMCEYeGEjW3KoztCU5vhc7klro4+edh4zyNdCGqzmjc
         mJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeEjsUJZXmq6T4p3lE72hnbTLlGEcBDOQg2JKUDWVJE=;
        b=FbhpSZnrDqjhNOAKQtiRGUhDiizq7hogEInhg7wBoMQEBvWaAODYWM14Robe7S43Ih
         CC1AaINInA+ejNtx+ZewPbi1QQ++BxtagIQWRPVGGmC57yRlTrL6q/imJOXMCIqVDzHQ
         Lkdy911+skC9rQxKyawZJgcCARIkj00rbWv4lODKF8dvAJgE062rJLR24vnKpNJAWELn
         xis5XNDEbnDIVWgp934jkI73/HvxGdkmg6jOhgT7fs+qQI3G+Uu0htPLNT80WhVggIEk
         FKqVR4itJlIZRPO4SM4ol3EqhGT2aah28Npadfg7AF3ff46o82PJIrz6qe6ehEw3elgr
         jfqg==
X-Gm-Message-State: AOAM533l1rNXT3P52pOW1r3IjEDDxpW/LtcK5vuhFTqEV0WIYXQndyOE
        5s4m1SA56lUsFS0ZF0t3aWsHzu3EwYs=
X-Google-Smtp-Source: ABdhPJxg0ITMbjoWdwKI/X/KXb+Odp0igAc4VN0ETfb2xZ6E76oWQz9JY3BA8yWww30EhwV9qafQ+g==
X-Received: by 2002:a05:6870:a40b:b0:d3:4785:c580 with SMTP id m11-20020a056870a40b00b000d34785c580mr5144980oal.221.1645657650724;
        Wed, 23 Feb 2022 15:07:30 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-809e-284a-c7bf-c6d9.res6.spectrum.com. [2603:8081:140c:1a00:809e:284a:c7bf:c6d9])
        by smtp.googlemail.com with ESMTPSA id y3sm505030oiv.21.2022.02.23.15.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 15:07:30 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v13 0/6] Move two object pools to rxe_mcast.c
Date:   Wed, 23 Feb 2022 17:07:01 -0600
Message-Id: <20220223230706.50332-1-rpearsonhpe@gmail.com>
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

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v13
  Addressed issues raised by Jason Gunthorpe
  Replaced rxe_mcast_cleanup() by a warning.
  Dropped _rcu from __rxe_init/cleanup_mca_rcu
  Restructured rxe_detach_mcg to simplify
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
  RDMA/rxe: Warn if mcast memory is not freed
  RDMA/rxe: Collect mca init code in a subroutine
  RDMA/rxe: Collect cleanup mca code in a subroutine
  RDMA/rxe: Cleanup rxe_mcast.c
  RDMA/rxe: For mcast copy qp list to temp array
  RDMA/rxe: Convert mca read locking to RCU

 drivers/infiniband/sw/rxe/rxe.c       |   2 +
 drivers/infiniband/sw/rxe/rxe_mcast.c | 237 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_recv.c  | 107 +++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |   4 +
 4 files changed, 256 insertions(+), 94 deletions(-)

-- 
2.32.0

