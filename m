Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA68C405E2E
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Sep 2021 22:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245624AbhIIUrb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Sep 2021 16:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhIIUra (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Sep 2021 16:47:30 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BACC061574
        for <linux-rdma@vger.kernel.org>; Thu,  9 Sep 2021 13:46:20 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id j11-20020a4a92cb000000b002902ae8cb10so984095ooh.7
        for <linux-rdma@vger.kernel.org>; Thu, 09 Sep 2021 13:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7tQeun2L4MGCukgq/vyhQSgRQZg82+y9KRqFYHtvTM=;
        b=ICLeWnuIVbSqUcbnTOKyGjRts9o89qr7o1WABFkVA8M9WGKx4xn0EmYTm0jvM4ZnHv
         /3abAR+oCSTfVBFDBMtxwn5uzDouWmQr5kr4LtGUgGZIQqVzY5a2A4JFsaXCvEnMG1Wf
         Lhn5NDMpS2P3JEoeRTvtjmKgVZcFt6UEOFLcBsQ0uuw3BM5zXBbTaHQJd3MHm4IEwy39
         EN+7ut7ez4f7bu7iXdWvuWwYWBdiTQoNcTDGc9rJSzu6dCTRYA2FBlhXvldvwyEz49+9
         Ebi1isbuptG099vhucKidnLXq2osClrw/Aft7zlxoSOVCroUIWNMM/u5d4/4YSxOezz3
         p7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c7tQeun2L4MGCukgq/vyhQSgRQZg82+y9KRqFYHtvTM=;
        b=BFlvP8rgK2CIqWrSRhBkQiNQfU+vPE4SmVYfX6uyb5VrwqrDfGFNg7C4Ep6MrS2CUG
         VmN1bwjCJQBXT9evwndL/5jJVVtxYPNnauQVJvSKya7UBl4W4iTsUym24u6w6DOJWwaa
         uZPpQPqa9p2NFahaHz7BZ+NvTFkGqBxysG8KHIc6h6CKBXEtkoJ+5OWq2m77rjUgj2aX
         tfF65pDuU52lGDZAdNVmURmsMzmRrHwSmhZMefPB4uT5THSECCKKY/jdHkIyoiaqc3sL
         ZVxxhHU889opWPY5xe0GSuIPNUWTigxRMeUZcEj1HkyEa31xyMB/xschcT4fh6fGdDnV
         8tlQ==
X-Gm-Message-State: AOAM530BxAPmf9ac0RnhHl1K9QB7QyOQzpkDPtSvabGBdXM9yxRggefC
        kbjW7B66ySZ8j2VweCEJaYw=
X-Google-Smtp-Source: ABdhPJxp2wnASVbA69v+SFQNrmsZJksN/NgWlhFSOv7qqTXkNIJ2yK2eGR3LuLZku97bTu1teLuksA==
X-Received: by 2002:a05:6820:16a8:: with SMTP id bc40mr1452440oob.63.1631220380102;
        Thu, 09 Sep 2021 13:46:20 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-a0a5-b98f-837d-887f.res6.spectrum.com. [2603:8081:140c:1a00:a0a5:b98f:837d:887f])
        by smtp.gmail.com with ESMTPSA id i9sm719892otp.18.2021.09.09.13.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:46:19 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        mie@igel.co.jp, bvanassche@acm.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v3 0/6] RDMA/rxe: Various bug fixes.
Date:   Thu,  9 Sep 2021 15:44:51 -0500
Message-Id: <20210909204456.7476-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches implements several bug fixes and minor
cleanups of the rxe driver. Specifically these fix a bug exposed
by blktest.

They apply cleanly to both
commit 2169b908894df2ce83e7eb4a399d3224b2635126 (origin/for-rc, for-rc)
commit 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac (HEAD -> for-next,
	origin/wip/jgg-for-next, origin/for-next, origin/HEAD)

These are being resubmitted to for-rc instead of for-next.

The v2 version had a typo which broke clean application to for-next.
Additionally in v3 the order of the patches was changed to make
it a little cleaner.

The first patch is a repeat of an earlier patch after rebasing.
It adds memory barriers to kernel to kernel queues. The logic for this
is the same as an earlier patch that only treated user to kernel queues.
Without this patch kernel to kernel queues are expected to intermittently
fail at low frequency as was seen for the other queues.

The second patch is also a repeat after rebasing. It fixes a multicast
bug.

The third patch cleans up the state and type enums used by MRs.

The fourth patch separates the keys in rxe_mr and ib_mr. This allows
the following sequence seen in the srp driver to work correctly.

	do {
		ib_post_send( IB_WR_LOCAL_INV )
		ib_update_fast_reg_key()
		ib_map_mr_sg()
		ib_post_send( IB_WR_REG_MR )
	} while ( !done )

The fifth patch creates duplicate mapping tables for fast MRs. This
prevents rkeys referencing fast MRs from accessing data from an updated
map after the call to ib_map_mr_sg() call by keeping the new and old
mappings separate and atomically swapping them when a reg mr WR is
executed.

The sixth patch checks the type of MRs which receive local or remote
invalidate operations to prevent invalidating user MRs.

Bob Pearson (6):
  RDMA/rxe: Add memory barriers to kernel queues
  RDMA/rxe: Fix memory allocation while locked
  RDMA/rxe: Cleanup MR status and type enums
  RDMA/rxe: Separate HW and SW l/rkeys
  RDMA/rxe: Create duplicate mapping tables for FMRs
  RDMA/rxe: Only allow invalidate for appropriate MRs

 drivers/infiniband/sw/rxe/rxe_comp.c  |  10 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  25 +--
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
 drivers/infiniband/sw/rxe/rxe_mcast.c |   2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    | 267 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_mw.c    |  36 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_queue.h |  73 ++-----
 drivers/infiniband/sw/rxe/rxe_req.c   |  35 +---
 drivers/infiniband/sw/rxe/rxe_resp.c  |  38 +---
 drivers/infiniband/sw/rxe/rxe_srq.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  92 +++------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  48 ++---
 13 files changed, 305 insertions(+), 335 deletions(-)

-- 
2.30.2

