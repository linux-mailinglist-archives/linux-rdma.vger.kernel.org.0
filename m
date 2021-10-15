Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6139742FE37
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Oct 2021 00:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbhJOWgC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Oct 2021 18:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhJOWgC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Oct 2021 18:36:02 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B35C061570
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:55 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso26404otl.4
        for <linux-rdma@vger.kernel.org>; Fri, 15 Oct 2021 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xskp/o7QW00xPsVaG9NEVhHHdvi+7sg4x+byGi20wIE=;
        b=WBmJE84nSEXUwd0yoylky2hQ2pyGitD6HK+MXf3d9MGl4p7Do4Ry5a1yc4jk3EAM+E
         uitjnFp8MM/OW9PjNID9NWt5G66QutPRWS5XgWmvUB4g58+dV7PfhkgrvHuEl8Y9cTYS
         6d7O8mQia/4l3LRMF9CLB+IImzDFMI79z2dcqbjkLRTphF7yH98+TbLjtbFZOiLEeFeU
         Hp+7lamypI8v/xpi7ovNOlyVkVrbUOmZnCWUN9OzSUqfPMH/PLFG6qI/mcQ5dVLWqnzn
         +xmC3FrvpB4BthZ7T2N2dbM1BP4jqMJmi0T4IICw8PE2Szus2tY9Z30sp9dJbS8e7XB3
         7M7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xskp/o7QW00xPsVaG9NEVhHHdvi+7sg4x+byGi20wIE=;
        b=3BiybwYFbEh7s+cHRzsrzpL60PzDfHNHdfWopGg5q2kgbm+xh1JH7RTRxZ1b7lZWZV
         uU7nHco+0HKKgJQIRzUiJQlxijNPH5M9CkJBSnoWxHADeCRYYeiqGlkzPjo2L2UKfxXV
         t416pe5Nu7hXL2KiIkBY2K9ONPPFYetg93ivKn5FmTtrbeBz2ekE40f7lS+H6iwnK9W2
         LUi1GwLp8OQTrCNItzwzoKBYKuDmHJ27zHdtCpno02CrZ6JgRBfHcJ8XP9Mo93s7z2eJ
         2QVkVQCzWvkvTQp1MvkeJ5qMO7s8aAPJNS7ZJ5jCS2xb1vIJKCj38W1Ntf3LE0CxP4c6
         oWAQ==
X-Gm-Message-State: AOAM533TvhWK0jE+Ts5pfM1haIRLrqq1Zv9u1rwFTVHWCqr2HhUKWmYn
        050bp74ykMush9ORfSIMrnvoiYEjv6s=
X-Google-Smtp-Source: ABdhPJwieAmdV/bFv8xlX99Lc5O8N3qJUDyEqu5vxFRNRj1QDPpH1HXY2Ztlm94D3AY4JTGlPCtlMg==
X-Received: by 2002:a05:6830:43aa:: with SMTP id s42mr10614368otv.136.1634337235006;
        Fri, 15 Oct 2021 15:33:55 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-191f-cddf-7836-208c.res6.spectrum.com. [2603:8081:140c:1a00:191f:cddf:7836:208c])
        by smtp.gmail.com with ESMTPSA id v22sm1193896ott.80.2021.10.15.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:33:54 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v2 00/10] Correct race conditions in rdma_rxe
Date:   Fri, 15 Oct 2021 17:32:41 -0500
Message-Id: <20211015223250.6501-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are several potential race conditions discovered in the rdma_rxe
driver. These patches correct them. They mostly relate to races between
normal operations and destroying objects.

This patch series applies cleanly to current for-next.
commit 3b87e0824272414cec79763afef6720c7c908c44 (for-next)

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v2
  Rebased to current for-next.
  Added 4 additional patches

Bob Pearson (10):
  RDMA/rxe: Make rxe_alloc() take pool lock
  RDMA/rxe: Copy setup parameters into rxe_pool
  RDMA/rxe: Save object pointer in pool element
  RDMA/rxe: Combine rxe_add_index with rxe_alloc
  RDMA/rxe: Combine rxe_add_key with rxe_alloc
  RDMA/rxe: Fix potential race condition in rxe_pool
  RDMA/rxe: Separate out last rxe_drop_ref
  RDMA/rxe: Rewrite rxe_mcast.c
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources

 drivers/infiniband/sw/rxe/rxe.c       |   8 -
 drivers/infiniband/sw/rxe/rxe_av.c    |  24 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |   9 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  19 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 210 ++++++++++-----
 drivers/infiniband/sw/rxe/rxe_mr.c    |  11 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  28 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  39 +--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 374 ++++++++++++++++----------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  86 +++---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  11 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  55 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 125 ++++++---
 drivers/infiniband/sw/rxe/rxe_srq.c   |   8 +
 drivers/infiniband/sw/rxe/rxe_verbs.c |  65 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.h |   4 +-
 16 files changed, 611 insertions(+), 465 deletions(-)

-- 
2.30.2

