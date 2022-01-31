Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6514A520F
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Jan 2022 23:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiAaWKF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Jan 2022 17:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiAaWKF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Jan 2022 17:10:05 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A4DC061714
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:04 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id m9so29502872oia.12
        for <linux-rdma@vger.kernel.org>; Mon, 31 Jan 2022 14:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b//fAhA6dxaqxR6KAU73euTb/3yk1M0fIYJ1+9d2VjU=;
        b=EHzWwG7J1BcY72fooFq00pVxi/MepeXoPESXF4ACnMI285ffwrO2gfL1hTCQXRD1u/
         a8FaRYtppwe/YCMwA2VAtPT7BkYWT9pWsFPU2t+DV6LUMAlHH/KwSYZrD5IOfNfQbB1k
         JQrztdCqfygTZGB+LcM1ZBgcwGp9VIPmfTlqLA/77KU/+loRquopLcbNY2cCxhqbKAJf
         WpT9J+RPrH0mZ+TruXmABNrc60nvlolFsTOn7C1dLmE4ikLV/KhpVjh5DzUxNCS5JeW+
         HtcqlsC3R5mPkgYObJB0u5XF6KnkXjHpuNIo+PRCoYO+7WD3Qk5YtjhpHqMY9Ng6Q7sU
         ONFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b//fAhA6dxaqxR6KAU73euTb/3yk1M0fIYJ1+9d2VjU=;
        b=WVvKWTAguUGA1e/VYpIXhefg/okp+YEfeITUhVgKXAiL/4FqLSv3uRLUtmNlCznEjF
         tLPa57i9AH09EKhjSrab2wm0xtvOv25U6MqZbGu22Oot0lpAw45BmOLHIqWxMvKyWE8n
         Uh0xrpztB2SXh6Asrc317/ahIHswrp+uceKdyMFrpwmdZaG/HeLgRG6xH7dQMtyxXzNI
         P1jC9vF1rZHswCDW2gUatwpuCnkMTJT30pkZpG3dpxi709m/F2Hg+CkWO1nYEeA65fiZ
         me6b19tegW1oaG8LaqJtTbFtRiY1ukMrgtHWHehiKG/YrJYRHASoleSlEr0PDdN6KBoT
         thSg==
X-Gm-Message-State: AOAM531vCCpOIicN4KVxCcOGq6Kez4Qx5yq+/8ZDxWvjrAcCiPc3qZDY
        W/ZG+A8emf/Re/Z9HYDAWhc=
X-Google-Smtp-Source: ABdhPJyYdU7ISYqyfKdxLIsgr7gDjdP/+Bvf6Q4eX1yMua4mPhX6+cAHnDeX6KNWEYHbw8mjVpyrog==
X-Received: by 2002:a05:6808:1781:: with SMTP id bg1mr19651957oib.191.1643667004210;
        Mon, 31 Jan 2022 14:10:04 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-5c63-4cee-84ac-42bc.res6.spectrum.com. [2603:8081:140c:1a00:5c63:4cee:84ac:42bc])
        by smtp.googlemail.com with ESMTPSA id t21sm8304929otq.81.2022.01.31.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:10:03 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 00/17] Move two object pools to rxe_mcast.c
Date:   Mon, 31 Jan 2022 16:08:33 -0600
Message-Id: <20220131220849.10170-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series separates the mc_grp and mc_elem object pools from
rxe_pools.c and moves their code to rxe_mcast.c. This makes sense because
these two pools are different from the other pools as the only ones that
do not share objects with rdma-core and that use key's instead of
indices to enable looking up objects. This change will enable a significant
simplification of the normal object pools.

Note: the independent implementation takes references to multicast groups
and also to pointers stored in the red-black trees holding the keys. The
reference handling code is moved to be adjacent to the code that manages
the pointers.

This patch series applies cleanly to current for-next.
commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07 (tag: v5.17-rc1,
		origin/wip/jgg-for-rc, origin/wip/jgg-for-next,
		origin/wip/for-testing, origin/for-rc,
		origin/for-next, origin/HEAD, for-next)

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
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

Bob Pearson (17):
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
  RDMA/rxe: Replace mcg locks by rxe->mcg_lock
  RDMA/rxe: Replace pool key by rxe->mcg_tree
  RDMA/rxe: Remove key'ed object support
  RDMA/rxe: Remove mcg from rxe pools
  RDMA/rxe: Add code to cleanup mcast memory
  RDMA/rxe: Add comments to rxe_mcast.c
  RDMA/rxe: Finish cleanup of rxe_mcast.c

 drivers/infiniband/sw/rxe/rxe.c       |  21 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h   |   3 +
 drivers/infiniband/sw/rxe/rxe_loc.h   |  28 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 684 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_net.c   |  18 -
 drivers/infiniband/sw/rxe/rxe_pool.c  | 137 ------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  40 --
 drivers/infiniband/sw/rxe/rxe_qp.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  | 104 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  31 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  25 +-
 11 files changed, 614 insertions(+), 496 deletions(-)
 rewrite drivers/infiniband/sw/rxe/rxe_mcast.c (86%)

-- 
2.32.0

