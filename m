Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A429E40B519
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 18:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhINQoV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhINQoK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Sep 2021 12:44:10 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40C1C061574
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:42:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id h133so19853860oib.7
        for <linux-rdma@vger.kernel.org>; Tue, 14 Sep 2021 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAx4OwiOg2GOmKrHldXySA00x4zR8vAEigybmxCgIdo=;
        b=UE7pT6gWcxK0wq0NONPxc7mVXk0Ayhmgt10dryZUQzTSKrrUBycGbODSzVRmvoQwON
         cnj0iWL19WrFnU/xtCzJdxHXAQ5tHS22jwsv53OZEZAvKFs2HzERveEW8CK/0j8rqANL
         +Q/RWkix0P4Ls3eOaasUFMQTgyBmWLagqj9N+U3qS1XlD4lV2hUr9VcjwOIluQfFNVnA
         T9mhUsZFoo+FlDFppy0J4IvJOT0UVZrJIdxRYZjtfRO1aKK4VF0Wwb2UTA0yfFmDwjGY
         JRGZwrCXce+TLaDSSOZxMEr7i8pyp/KApDqqwX+qZUgqHaK/ul8qhYcQzg6cHFjJ+30/
         7bHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iAx4OwiOg2GOmKrHldXySA00x4zR8vAEigybmxCgIdo=;
        b=ivN/4oe3T7aFpvEzW2lpJQvvSjWKJnOmOFcLfAQRewa4fODFLyn7kJW82kQwB2vaoL
         PaArQ31ehsgo8ScGG2xnYDR4g/ki/szvUNYHLliTbpG2h8HKjpb38Uxnqhp2uG1W0CWq
         ZqJ10p7Ag/gQ9km0WgBm0VASgbmWV0Oos/cavd8nszU5Rrmy/Dwg16bX3FXxhWwqszdc
         6UtPROUEDafuteeg6m2gVqmUxF5Eo0qxlMBEOmsPixPDqNZjvBN7gDZ9AeBYwr5DodO9
         omDHaEB2hx7o9IgjgU56b6UjQi0b3XMBEoEog/6tNWPMok/AGTL4IVyVe3uSk8RGxXwf
         GhgA==
X-Gm-Message-State: AOAM530WJJk3tGfr5kB3noC/5CSO5S0Vd9Z2Mk2dstvRVRLMpNnVo/jQ
        XGXovdwSN4bQswKCfgbZQLk=
X-Google-Smtp-Source: ABdhPJxMiiSAvdqTJbzhcGgoYyGWcXknXxbH55KSgVjRFs65qOQUeXApPBEgnS48R/SbKrL1tJS4lw==
X-Received: by 2002:a54:458f:: with SMTP id z15mr2128092oib.42.1631637772295;
        Tue, 14 Sep 2021 09:42:52 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-61e3-00cf-5364-0046.res6.spectrum.com. [2603:8081:140c:1a00:61e3:cf:5364:46])
        by smtp.gmail.com with ESMTPSA id k1sm2850263otr.43.2021.09.14.09.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 09:42:51 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org,
        bvanassche@acm.org, mie@igel.co.jp, rao.shoaib@oracle.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-rc v4 0/5] RDMA/rxe: Various bug fixes.
Date:   Tue, 14 Sep 2021 11:42:02 -0500
Message-Id: <20210914164206.19768-1-rpearsonhpe@gmail.com>
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
commit 1b789bd4dbd48a92f5427d9c37a72a8f6ca17754 (origin/for-rc)
commit 6a217437f9f5482a3f6f2dc5fcd27cf0f62409ac (origin/for-next)

The first patch is a rewrite of an earlier patch.
It adds memory barriers to kernel to kernel queues. The logic for this
is the same as an earlier patch that only treated user to kernel queues.
Without this patch kernel to kernel queues are expected to intermittently
fail at low frequency as was seen for the other queues.

The second patch cleans up the state and type enums used by MRs.

The third patch separates the keys in rxe_mr and ib_mr. This allows
the following sequence seen in the srp driver to work correctly.

	do {
		ib_post_send( IB_WR_LOCAL_INV )
		ib_update_fast_reg_key()
		ib_map_mr_sg()
		ib_post_send( IB_WR_REG_MR )
	} while ( !done )

The fourth patch creates duplicate mapping tables for fast MRs. This
prevents rkeys referencing fast MRs from accessing data from an updated
map after the call to ib_map_mr_sg() call by keeping the new and old
mappings separate and atomically swapping them when a reg mr WR is
executed.

The fifth patch checks the type of MRs which receive local or remote
invalidate operations to prevent invalidating user MRs.

v3->v4:
Two of the patches in v3 were accepted in v5.15 so have been dropped
here.

The first patch was rewritten to correctly deal with queue operations
in rxe_verbs.c where the code is the client and not the server.

v2->v3:
The v2 version had a typo which broke clean application to for-next.
Additionally in v3 the order of the patches was changed to make
it a little cleaner.

Bob Pearson (5):
  RDMA/rxe: Add memory barriers to kernel queues
  RDMA/rxe: Cleanup MR status and type enums
  RDMA/rxe: Separate HW and SW l/rkeys
  RDMA/rxe: Create duplicate mapping tables for FMRs
  RDMA/rxe: Only allow invalidate for appropriate MRs

 drivers/infiniband/sw/rxe/rxe_comp.c  |  12 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  25 +--
 drivers/infiniband/sw/rxe/rxe_loc.h   |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c    | 267 ++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_mw.c    |  36 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c    |  12 +-
 drivers/infiniband/sw/rxe/rxe_queue.c |  30 ++-
 drivers/infiniband/sw/rxe/rxe_queue.h | 292 +++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_req.c   |  51 ++---
 drivers/infiniband/sw/rxe/rxe_resp.c  |  40 +---
 drivers/infiniband/sw/rxe/rxe_srq.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  92 ++------
 drivers/infiniband/sw/rxe/rxe_verbs.h |  48 ++---
 13 files changed, 438 insertions(+), 471 deletions(-)

-- 
2.30.2

