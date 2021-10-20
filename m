Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C45E94355B1
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 00:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhJTWJm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 18:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhJTWJl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Oct 2021 18:09:41 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101ECC06161C
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:27 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 34-20020a9d0325000000b00552cae0decbso8305247otv.0
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 15:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBe94x8aJwGfQ41oWTJDuj+ExbYkukKgGi25LOjKXcM=;
        b=ekG/NgzMlhfFAJ6tttqW7oOGNhW2PWSSlQRpc8aeppwAAGLk8VyH0XXSg1DwMT8u5N
         ONkjKOo7Yge864Z/xsM5tBMGAbNERUtVlTDDjBoV3WlzPJO+pxno/dQZVUg62yWiewOq
         ArctipwNEuEOhdyDC9Ra/ahPf/w5ESxs+XpjAd/Elgc1NOnD7+5QWKg4Coj6gFIr9HKU
         xyqaFx2Wg/04e06e1OSWUkm2PGMuUZqyBmdxnzrGxJ3Dp8tL4OpWoWOMyYTuSqdIFOL1
         r5rFPLFXBkPacty9G/Gh0FbFfWwI2RuR9iLg95Cfm8aj6r/x2tec/uGy9slCv6W0F3Gv
         bPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBe94x8aJwGfQ41oWTJDuj+ExbYkukKgGi25LOjKXcM=;
        b=looGrDirc79ClYj6MSnquJSs36aSsRY6i+EJBmOKENlu1Qd6s0nbXXNHAMbuGrW5E1
         zh+aNN2yDlAkup6RIu1L8zEQ2hY1sdKQug6CviBy4d6UcYpbbIseTZcAyzCGFasj+dBS
         AtaGZ6zzNzBL7OwwE2MXk5MKNlZeJI4p5aIYaFnKG87Nribq/CLboUibanKyloPAuCYF
         gQNEPfdP9DnGoQBPIrspsRyCyPyx2/d0HLNlrq78dp7Kq8IMBqPy8JX86IJOHrAh57d5
         KWDTvdlZrnnEgWm90HrBVZi9oMvGwm+IwBv5qGN40h47u7kLm0/txJrKkRKcOhZYKwXy
         IBKQ==
X-Gm-Message-State: AOAM532NmmUJk534eXk/rAx4z5vjVZEO5XBGQ7ySmCkJRCsyufNTYhV2
        JO0fymo58LQtGrFI1VXhhH0=
X-Google-Smtp-Source: ABdhPJzP6/YiiW9JKs34ienvgD/iMR5Vj/8ACWRv+5L35z7k6OpOPsLJioD0NpNr08SQy4wwLTPo/w==
X-Received: by 2002:a9d:1b7:: with SMTP id e52mr1500790ote.352.1634767646486;
        Wed, 20 Oct 2021 15:07:26 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-8d65-dc0b-4dcc-2f9b.res6.spectrum.com. [2603:8081:140c:1a00:8d65:dc0b:4dcc:2f9b])
        by smtp.gmail.com with ESMTPSA id v13sm725050otn.41.2021.10.20.15.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:07:26 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next 0/7] Replace red-black tree by xarray
Date:   Wed, 20 Oct 2021 17:05:43 -0500
Message-Id: <20211020220549.36145-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This series of patches starts with some minor cleanups in rxe pools
and then replaces the red-black trees used to lookup rxe objects from
indices with xarrays. The change over is made in small steps starting
by adding xarrays and then convrting red-black trees to xarrays and
finally deleting the original index code and renaming the xarray code
to take its place.

These patches apply cleanly to current for-next branch after the
"Correct race conditions in rdma_rxe" patch series
	commit ed0d7445ed4651f4171c38d9446dc43c823ad32b
applied to
	commit ac0fffa0859b8e1e991939663b3ebdd80bf979e6 (origin/for-next)

Bob Pearson (7):
  RDMA/rxe: Replace irqsave locks with bh locks
  RDMA/rxe: Cleanup rxe_pool_entry
  RDMA/rxe: Add xarray support to rxe_pool.c
  RDMA/rxe: Replace pool_lock by xa_lock
  RDMA/rxe: Convert remaining pools to xarrays
  RDMA/rxe: Remove old index code from rxe_pool.c
  RDMA/rxe: Rename XARRAY as INDEX

 drivers/infiniband/sw/rxe/rxe.c       |  86 ++-------
 drivers/infiniband/sw/rxe/rxe_comp.c  |   8 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |  23 +--
 drivers/infiniband/sw/rxe/rxe_loc.h   |  10 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c |  10 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |   6 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 266 +++++++-------------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  53 +++--
 drivers/infiniband/sw/rxe/rxe_qp.c    |   6 +-
 drivers/infiniband/sw/rxe/rxe_queue.c |   9 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  11 +-
 drivers/infiniband/sw/rxe/rxe_srq.c   |   6 +-
 drivers/infiniband/sw/rxe/rxe_task.c  |  18 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  29 ++-
 drivers/infiniband/sw/rxe/rxe_verbs.h |  22 +--
 16 files changed, 185 insertions(+), 397 deletions(-)

-- 
2.30.2

