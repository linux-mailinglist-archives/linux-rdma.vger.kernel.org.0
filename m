Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7729449ED7D
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jan 2022 22:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240849AbiA0ViH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jan 2022 16:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiA0ViG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Jan 2022 16:38:06 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10E3C061714
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:06 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso3896233otj.2
        for <linux-rdma@vger.kernel.org>; Thu, 27 Jan 2022 13:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HYLH3LmXJ18wCeap6OAXdNn6ABHS5m0QW5rmDdhF6xo=;
        b=A5ljkkjCbTKJH/RYdhO/80nwmLj5BYhV9NItpXWXW4DLnUI3OVOCpZ39Ce580zk3bf
         uu8Pg/07dlksTzOM1QL+1LR2OeJ908+Y/yvv0WMfGWT8WD700o19FyTE0JcNJlRopWcd
         kTREwv56XojCh5QM8vmMn8OihUNNqZZCbiumsFoZJjQBQJ2Jn2IA/RFfJtk6xrBDF9CB
         lahGA+MxJ387H8aPy8zXzSAPIevsgmby20f1gHIaDpLBGLNIPbSTnNEY5spHYh9SEdU8
         cFr//dqOErogkpAi9oUWjFfImvk59LxjFFQ6fgMKufyvmjOxyyf5kgJCvCf4cm7uEgGn
         rSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HYLH3LmXJ18wCeap6OAXdNn6ABHS5m0QW5rmDdhF6xo=;
        b=PMiBxw8CrI8HWgxqRygBeUXd8Wy6kBB5rJS5d0ss5MB950FHuPhZnXOnLCaVjXL5SQ
         4WiBuY4en4290gKT9KYtQerr0FFMeDKYttMqbrno3fFovZHSwdDDGA9783dzPLFbK9g8
         WZAEcUc0rw1pPeqMueJKev6NcvyAjumotfAeb0Qf6fsRFOXGTX3Rs24Yu1q0B0Pvqrlm
         FivV5t048EZacJAs0/UBGFuy7BLSdtx5+hTOnFEmxGXCijDjKj87M0oisNlHHHh9IAXU
         KyVQBN6CMxcSVigSjJsISfoShp7JeQ8dRCCRtFumZoOTBU5gn8dGQbxECMMy4FncgD80
         2a4Q==
X-Gm-Message-State: AOAM532XQ7d0mnXrS+KHctHQB0A49Y5h3Aym6o2F0c0dynrdop4sdk7j
        JHPbDPayDRyJ4Fwr0einB1k=
X-Google-Smtp-Source: ABdhPJxfor/vuG3CctKhn81OYWX8sXmmHZio1HgFeZ1n45G8K5woluV4rAwF2RawyWr39tztx/AdHQ==
X-Received: by 2002:a05:6830:555:: with SMTP id l21mr3246330otb.54.1643319486007;
        Thu, 27 Jan 2022 13:38:06 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id v32sm3994677ooj.45.2022.01.27.13.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:38:05 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [RFC PATCH v9 00/26] 
Date:   Thu, 27 Jan 2022 15:37:29 -0600
Message-Id: <20220127213755.31697-1-rpearsonhpe@gmail.com>
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

The patch series has been changed to RFC PATCH instead of PATCH for-next
because I have little experience with rcu locking and would like
someone else to review this code (in 18/26 and 24/26). RCU locking
should improve performance at large scale but this has not been tested
yet.

This patch series applies cleanly to current for-next.
commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07 (tag: v5.17-rc1,
		origin/wip/jgg-for-rc, origin/wip/jgg-for-next,
		origin/wip/for-testing, origin/for-rc,
		origin/for-next, origin/HEAD, for-next)

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
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

Bob Pearson (26):
  RDMA/rxe: Move rxe_mcast_add/delete to rxe_mcast.c
  RDMA/rxe: Move rxe_mcast_attach/detach to rxe_mcast.c
  RDMA/rxe: Rename rxe_mc_grp and rxe_mc_elem
  RDMA/rxe: Enforce IBA o10-2.2.3
  RDMA/rxe: Remove rxe_drop_all_macst_groups
  RDMA/rxe: Remove qp->grp_lock and qp->grp_list
  RDMA/rxe: Use kzmalloc/kfree for mca
  RDMA/rxe: Rename grp to mcg and mce to mca
  RDMA/rxe: Introduce RXECB(skb)
  RDMA/rxe: Split rxe_rcv_mcast_pkt into two phases
  RDMA/rxe: Replace locks by rxe->mcg_lock
  RDMA/rxe: Replace pool key by rxe->mcg_tree
  RDMA/rxe: Remove key'ed object support
  RDMA/rxe: Remove mcg from rxe pools
  RDMA/rxe: Add code to cleanup mcast memory
  RDMA/rxe: Add comments to rxe_mcast.c
  RDMA/rxe: Separate code into subroutines
  RDMA/rxe: Convert mca read locking to RCU
  RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
  RDMA/rxe: Delete _locked() APIs for pool objects
  RDMA/rxe: Replace obj by elem in declaration
  RDMA/rxe: Replace red-black trees by xarrays
  RDMA/rxe: Change pool locking to RCU
  RDMA/rxe: Add wait_for_completion to pool objects
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources

 drivers/infiniband/sw/rxe/rxe.c       | 107 +---
 drivers/infiniband/sw/rxe/rxe_av.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h   |   3 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |  33 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 678 ++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_mr.c    |   2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  11 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  35 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 798 ++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 233 +++-----
 drivers/infiniband/sw/rxe/rxe_qp.c    |  29 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  |  98 ++--
 drivers/infiniband/sw/rxe/rxe_req.c   |  55 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  | 125 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  54 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  26 +-
 16 files changed, 1159 insertions(+), 1147 deletions(-)
 rewrite drivers/infiniband/sw/rxe/rxe_mcast.c (86%)
 rewrite drivers/infiniband/sw/rxe/rxe_pool.c (67%)
 rewrite drivers/infiniband/sw/rxe/rxe_pool.h (73%)

-- 
2.32.0

