Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019F1443C4D
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Nov 2021 06:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhKCFGM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Nov 2021 01:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhKCFGM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Nov 2021 01:06:12 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B67BC061714
        for <linux-rdma@vger.kernel.org>; Tue,  2 Nov 2021 22:03:36 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u191so2052024oie.13
        for <linux-rdma@vger.kernel.org>; Tue, 02 Nov 2021 22:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43YulKGDuwOlKDs9ebXRIDh1ck1fJZ+juQVsZK7fUk0=;
        b=kIKmYJJq4zuC+TEpA6rIlxPW81yvpum3M8vOlWJKzraqpYh2YAaQQN/6WJu6wbY7hQ
         ZPHleblfroIQ2JbJC7tYvq5Bubp7id8G8Z2yBIAprASkqSm73AlPXnIcezXSnwVavif+
         sr2FAqPatEGYEItieyNxTUqkSMYUuViVnQ9F++z53jAYwReyqAMYhNvdvMkR871o8XYA
         DdUPhet73KCn8nErTkIY1CNjDBnu1Cyr5oY3yMpXPkCUFR854r7L3RiZsXab3gcK8A36
         6Lctmgwut5DopJpMSWCNhCmKii2us7lDziTLkaDIxeVgTqexZB8fqj3o6YJJqGm32zrk
         GbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43YulKGDuwOlKDs9ebXRIDh1ck1fJZ+juQVsZK7fUk0=;
        b=ZEEM5Yq0xIs2bUKnmQ1GQLE+dh30yhpDcZJgG4bP8vDICLZIRFJRqnp0vXjgrtRBsZ
         OEmiH+OMw8/zbrAtn+5sWqcDhlZVi5Elz/oHEhEb/7wCpW+ZqN4F8k8VvZSITypTlpf9
         zXwf0s+I7PEc4sOZgN5L6s9mQLU3I1g4hlP/OzFcmkO1hFrnoVnLWlWge4GjpcjHX07e
         S5kJhn8toDpOx1XWIZ3rpQgOeRp56BYeY2i7XiVwE2FM5H7Eh7oR3y3dIKVk8RohNnIC
         zNl4xZhsbuKqnANleRCXGMZECVFk9McT/gxt99uU6L8qd/LfPY6XE5iFPkT1Q5Qcrxdk
         8kwA==
X-Gm-Message-State: AOAM530yKKuc7yvRomAxtjHd2GuLgmY+OpIuFmYckPeJl6XFDzBtNhZ7
        afafAdVj4DB6NgQ1CoAZlc4=
X-Google-Smtp-Source: ABdhPJyKh7/ZwxtwOXVNmwQGG2FIb+d3Q8dtVQW5X+mZhQqYFzc5wEryvXDApLw26nY+rlSzkvtkug==
X-Received: by 2002:aca:58d6:: with SMTP id m205mr9201929oib.126.1635915815606;
        Tue, 02 Nov 2021 22:03:35 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-b73d-116b-98e4-53b5.res6.spectrum.com. [2603:8081:140c:1a00:b73d:116b:98e4:53b5])
        by smtp.gmail.com with ESMTPSA id r23sm274990ooh.44.2021.11.02.22.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:03:35 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 00/13] Correct race conditions in rdma_rxe
Date:   Wed,  3 Nov 2021 00:02:29 -0500
Message-Id: <20211103050241.61293-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are several race conditions discovered in the current rdma_rxe
driver.  They mostly relate to races between normal operations and
destroying objects.  This patch series makes several minor cleanups in
rxe_pool.[ch] and replaces the red-black trees currently used by xarrays
which have better atomic behavior.

This patch series applies cleanly to current for-next.
commit 6a463bc9d999 ("Merge branch 'for-rc' into rdma.git for-next")

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
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

Bob Pearson (13):
  RDMA/rxe: Replace irqsave locks with bh locks
  RDMA/rxe: Cleanup rxe_pool_entry
  RDMA/rxe: Copy setup parameters into rxe_pool
  RDMA/rxe: Save object pointer in pool element
  RDMA/rxe: Replace RB tree by xarray for indexes
  RDMA/rxe: Remove #include "rxe_loc.h" from rxe_pool.c
  RDMA/rxe: Remove some #defines from rxe_pool.h
  RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
  RDMA/rxe: Replaced keyed rxe objects by indexed objects
  RDMA/rxe: Prevent taking references to dead objects
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources
  RDMA/rxe: Protect against race between get_index and drop_ref

 drivers/infiniband/sw/rxe/rxe.c       | 100 +-----
 drivers/infiniband/sw/rxe/rxe_av.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |   8 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  24 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  25 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 167 ++++++---
 drivers/infiniband/sw/rxe/rxe_mr.c    |   7 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  25 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  17 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 479 ++++++++------------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 129 ++-----
 drivers/infiniband/sw/rxe/rxe_qp.c    |  16 +-
 drivers/infiniband/sw/rxe/rxe_queue.c |   9 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  |   3 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  66 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 125 ++++---
 drivers/infiniband/sw/rxe/rxe_srq.c   |   2 +-
 drivers/infiniband/sw/rxe/rxe_task.c  |  18 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  73 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  23 +-
 20 files changed, 542 insertions(+), 793 deletions(-)

-- 
2.30.2

