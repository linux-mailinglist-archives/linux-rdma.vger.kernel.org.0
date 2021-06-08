Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692E539EDA7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 06:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhFHE2V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 00:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFHE2U (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Jun 2021 00:28:20 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADD0C061787
        for <linux-rdma@vger.kernel.org>; Mon,  7 Jun 2021 21:26:13 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id d21so20333126oic.11
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 21:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDB3hz2aC7MBG67WcCitihPXqPtoZlfKndZ5yLDs02U=;
        b=P2cTYxOEo35FcohfrPl2wVhKkCHrHtxLZ6cEkSxp23KUXuUwCf0TkoAaD5x/Erjvg/
         0PUDiaikdRAtWKWT3cibbLF0Z/9UIOvTnzVteOyMGD5f06qpgf+l89l+xUQ5wylqxjnh
         KviMLJUJp1ncW41LjU8hGwVOwUYF8rYxfHC03SYbRDo6V8i+xW/BIynJXaN0VHFnMRoq
         tSFclR5+vayRhvqDZ3YOyvr0KZNNqWaa+7Izi7slRnuLAuhlI9jUrqVj8jTUvCwvV4fO
         JVEIdIq2NC3fS8W4OOO8dKVziNuDWgcUmJONdIZ4wvms5OuFLa9Cb9m+QKvBOrMs5NEm
         CKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDB3hz2aC7MBG67WcCitihPXqPtoZlfKndZ5yLDs02U=;
        b=c9fQ8+8ILfN4ttzoFyI0Q9bREe3fVENlMKuysM6SI2asyrM/Jw6F5wYM9PfQZGjklr
         Ku+erdrGOGemL1YR3gTTc0bh6GETrxMneKmtGhgGf2cb7mmyeLx+kfmr3FM61VJTjslL
         ZX0SKsagWtxYKLJJ93czNBauaNqkqiDTjbbncxWW//l2YPyuas0wlElojHhR3zMVX5jU
         Q4UrrbXVqHZMt/B4nEeBqMBIERr+TrHJKMpHwi/5GZyWZzkjpY1jq6gHJGyQKH9NCBqW
         +yLu3RO56et23PtcmhkLCfBlR60lRJKG8QZSLlow8jCrQboFL6qMT6+BEIc2nP+ZJiXv
         FQXA==
X-Gm-Message-State: AOAM5329TNAwyTKWd5FXtD1F/IRJv2GADKio04Uo4AmSPzLj60Ks+X3C
        kRHC4ejS1Dm1ZhcmEl+IGAc=
X-Google-Smtp-Source: ABdhPJynUA6N3uN85/Y7vKxEkiIFvDBtSn0IhNgQv/KiSXUJBZCgZ4FfoAN7+/0s4rSU5dr0ks7KLA==
X-Received: by 2002:a05:6808:f0b:: with SMTP id m11mr1522050oiw.12.1623126371813;
        Mon, 07 Jun 2021 21:26:11 -0700 (PDT)
Received: from localhost (2603-8081-140c-1a00-cb25-4f27-0965-41cc.res6.spectrum.com. [2603:8081:140c:1a00:cb25:4f27:965:41cc])
        by smtp.gmail.com with ESMTPSA id p9sm2827118otl.64.2021.06.07.21.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 21:26:11 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, monis@mellanox.com,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v9 00/10] RDMA/rxe: Implement memory windows
Date:   Mon,  7 Jun 2021 23:25:43 -0500
Message-Id: <20210608042552.33275-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches implement memory windows for the rdma_rxe
driver. This is a shorter reimplementation of an earlier patch set.
They apply to and depend on the current for-next linux rdma tree.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v9:
  Fixed error return from bind MW local operation.
v8:
  Dropped wr.mw.flags in the rxe_send_wr struct in rdma_user_rxe.h.
v7:
  Fixed a duplicate INIT_RDMA_OBJ_SIZE(ib_mw, ...) in rxe_verbs.c.
v6:
  Added rxe_ prefix to subroutine names in lines that changed
  from Zhu's review of v5.
v5:
  Fixed a typo in 10th patch.
v4:
  Added a 10th patch to check when MRs have bound MWs
  and disallow dereg and invalidate operations.
v3:
  cleaned up void return and lower case enums from
  Zhu's review.
v2:
  cleaned up an issue in rdma_user_rxe.h
  cleaned up a collision in rxe_resp.c

Bob Pearson (10):
  RDMA/rxe: Add bind MW fields to rxe_send_wr
  RDMA/rxe: Return errors for add index and key
  RDMA/rxe: Enable MW object pool
  RDMA/rxe: Add ib_alloc_mw and ib_dealloc_mw verbs
  RDMA/rxe: Replace WR_REG_MASK by WR_LOCAL_OP_MASK
  RDMA/rxe: Move local ops to subroutine
  RDMA/rxe: Add support for bind MW work requests
  RDMA/rxe: Implement invalidate MW operations
  RDMA/rxe: Implement memory access through MWs
  RDMA/rxe: Disallow MR dereg and invalidate when bound

 drivers/infiniband/sw/rxe/Makefile     |   1 +
 drivers/infiniband/sw/rxe/rxe.c        |   1 +
 drivers/infiniband/sw/rxe/rxe_comp.c   |   5 +-
 drivers/infiniband/sw/rxe/rxe_loc.h    |  36 +--
 drivers/infiniband/sw/rxe/rxe_mr.c     | 126 ++++++---
 drivers/infiniband/sw/rxe/rxe_mw.c     | 343 +++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.c |  11 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h |   3 +-
 drivers/infiniband/sw/rxe/rxe_param.h  |  19 +-
 drivers/infiniband/sw/rxe/rxe_pool.c   |  45 ++--
 drivers/infiniband/sw/rxe/rxe_pool.h   |   8 +-
 drivers/infiniband/sw/rxe/rxe_req.c    | 104 +++++---
 drivers/infiniband/sw/rxe/rxe_resp.c   | 111 +++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c  |  15 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  48 +++-
 include/uapi/rdma/rdma_user_rxe.h      |  10 +
 16 files changed, 702 insertions(+), 184 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c
-- 
2.27.0

