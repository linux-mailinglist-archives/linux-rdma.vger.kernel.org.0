Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C7D4033CC
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 07:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345858AbhIHFau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 01:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237726AbhIHFap (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 Sep 2021 01:30:45 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725C0C061757
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 22:29:38 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so1439459otf.6
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui89jQhj7o9d7yKAiqRZOqSFIKfMB4KGPTQKBGGzJ/Q=;
        b=b3rJYSAz/Jhk9Ud3oANcKJrAamL1Mb1PqcqLaapWzQqAjGyLYJ7ckyk9p2lS1NS4YU
         HgugHwgu3aN5XjZQCslfZzbt39e8uVfdfyu9SMmFMDana2f1TXbrY/EY3lkf5sKP9qYp
         gaEKNwqhm35xMXSVgrzCRdiUCnSDhmhBcG9VoVNQyoOwVbjuhQNviemuapmZ2H2RxLJQ
         l+pdXGnrjqhtZmoJn1uNOW2bXsSrulQzhQdEEjVPYlIBFQtWhpq7HDrA5//i8mM+Ioku
         zjS7VlRHFf28fDvgw+ZJtkRUipHSJcQwjKXTjuJ6FoPUaenwnxt6C0KHBXqb86KQPlVR
         v/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ui89jQhj7o9d7yKAiqRZOqSFIKfMB4KGPTQKBGGzJ/Q=;
        b=I9PUYVGFTq0YsB7kyk1rN6q75SMgTAgVGWabUFDRkDaKz7A+FIMgE+kI0CEy4xwCaS
         7e5yWMrerXLChyAOnSjWEP5yUS2Xn3IXVH7AJYh5qD/Tm1lNAQvB0jDdUCHIhqN5RkhC
         hvkEpB6ZjS1gRxMsSdysgCZ/4tcHqkYNNVqKwY4aAotzz8uWN0r3WUFo8KkVonR+Tsfi
         +3wyTj8//4If1DYJFOequxTIfabJ0c5luMmt5OoZEf92DGdkNrpqoZCC4lF5W7rDHDRg
         Arm2Ad3E52JTojl+nX32zAcx0ZZ/sydq0SOActFCMNHhpZXqH+A/GPUoIKJ1PbOI5Gnz
         XqEw==
X-Gm-Message-State: AOAM531TxhshGGMiW1h+L5i9RPaJgZC5+0lQyNncWafULUyxd0712kwS
        Kk+2rV4l/14itSTqCGpEcFY=
X-Google-Smtp-Source: ABdhPJy1decxZ5WOkMYcIT0wVPQ6DbUW7A/n2tqN/Sifb3oLr9Qa3o97JQzu5cc2EJhIXATgnwoj3g==
X-Received: by 2002:a9d:7dd4:: with SMTP id k20mr1658999otn.68.1631078977865;
        Tue, 07 Sep 2021 22:29:37 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-4049-a9c6-d3dc-35fa.res6.spectrum.com. [2603:8081:140c:1a00:4049:a9c6:d3dc:35fa])
        by smtp.gmail.com with ESMTPSA id bf6sm281183oib.0.2021.09.07.22.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 22:29:37 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/5] RDMA/rxe: Various bug fixes.
Date:   Wed,  8 Sep 2021 00:29:23 -0500
Message-Id: <20210908052928.17375-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently some blktest test cases fail to execute correctly.
This series of patches allows these test cases to pass and implements
some other related changes.

The first patch is a repeat of an earlier patch after rebasing to
for-next version 5.14.0-rc6+. It adds memory barriers to kernel
to kernel queues. The logic for this is the same as an earlier patch
that only treated user to kernel queues. Without this patch kernel to
kernel queues are expected to intermittently fail at low frequency.

The second patch is also a repeat after rebasing to for-next version
5.14.0-rc6+. It fixes a multicast bug.

The third patch separates the keys in rxe_mr and ib_mr. This allows the
sequence

	do {
		ib_post_send( IB_WR_LOCAL_INV )
		ib_update_fast_reg_key()
		ib_map_mr_sg()
		ib_post_send( IB_WR_REG_MR )
	} while ( !done )

to operate correctly since now the changes to the local copy of the keys
only happens at the final post_send. The same fix is applied to MWs
since they need to synchronize with IB_WR_BIND_MW work requests.

The fourth patch creates duplicate mapping tables for fast MRs. This
prevents rkeys referencing fast MRs from accessing data from an updated
map after the call to ib_map_mr_sg() call by keeping the new and old
mappings separate.

The final patch cleans up the state and type enums used by MRs.

Bob Pearson (5):
  RDMA/rxe: Add memory barriers to kernel queues
  RDMA/rxe: Fix memory allocation while locked
  RDMA/rxe: Separate HW and SW l/rkeys
  RDMA/rxe: Create duplicate mapping tables for FMRs
  RDMA/rxe: Cleanup MR status and type enums

 drivers/infiniband/sw/rxe/rxe_comp.c  |  10 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  25 +--
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
 drivers/infiniband/sw/rxe/rxe_mcast.c |   2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 269 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_mw.c    |  36 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_queue.h |  73 ++-----
 drivers/infiniband/sw/rxe/rxe_req.c   |  35 +---
 drivers/infiniband/sw/rxe/rxe_resp.c  |  38 +---
 drivers/infiniband/sw/rxe/rxe_srq.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  92 +++------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  48 ++---
 13 files changed, 307 insertions(+), 335 deletions(-)

-- 
2.30.2

