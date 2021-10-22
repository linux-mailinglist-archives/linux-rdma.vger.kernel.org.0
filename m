Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21E1437E7C
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 21:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhJVTVu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 15:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhJVTVt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Oct 2021 15:21:49 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 565FAC061764
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:31 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so5599902otr.7
        for <linux-rdma@vger.kernel.org>; Fri, 22 Oct 2021 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/k00/7o6IqNnRe2DZRXH+Qr17VOpy0aoTbLEF1c9yE=;
        b=EraHquTPSNsrSUF3c7GMRj5HVdrISPrbJ0eDNWF6SgfTJpclAHr5v55jiXPt1HM71H
         vw7mDPFUR/QNo/xlQcpBfx0X011zmUz9lbfnjoxmTFBa6FRBgtb/d4PHXEdRcrMnH0wg
         HBuFHddYGBZ04Hyd3BCnmiRfdKWCMU+9j8a+fvGM8VVxr1uSqphzlVsCYzuFbvU7pdUx
         +N5tvzz67Y8jUtIzBdPPvb22AJEtVdG4pcUWW9CIJ2LcPgfIa2zhCHjRZkW/EHl6u5Xa
         Ig2UWGunSgaKtlS9b6S+c5bEdIs4/++kTxsIrj23pQABxGi4sYQCTEDKFWDDTXU9MVMu
         HQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f/k00/7o6IqNnRe2DZRXH+Qr17VOpy0aoTbLEF1c9yE=;
        b=42Yj9vEcd67vPhpugfCfmr2PKJx1bksM8Y6EedQLNdr7UQlfbqffOAD5pxzgXWxEp4
         7uESdQcqZJeC1NF4+U8qY7luN2q+6UkEkieXeComLwUSHmE5Pxbzze6olLq743cO4FTl
         4jJ9eEONLXSP4Tk0FK4zUrp1FrKRZOzHP8Mgipdi8503T3vhpsclASpqpCTkAGUse3+U
         GBr7EGoYVChANa4LulwLImzC+NdjK2vO0OFu/BQl8Cpxzxe4mUp/f/pwGfterb95vdIn
         dUVhE35B4hoHznNNd8ZI0l9p42cQLY39I/uihWj6Sfi+hCqQ/lC+khSPx2KDC5SDzl0x
         XZDg==
X-Gm-Message-State: AOAM530Yf6MyZgDqrKJCk6TJsXXPx++tEZ/+UX9gKVlh3Hnh7JTZDx5y
        bi8+u4gCWgzH/y9j6fNS0wwcStDDJOk=
X-Google-Smtp-Source: ABdhPJw0fM0kbVdIl44g6VVfnlnVUsZcb2Bvu1F2Qj3V6fKDy4LvgKOJJsPLiza0DtcKiD0Qy1IMcg==
X-Received: by 2002:a05:6830:43a5:: with SMTP id s37mr1416385otv.246.1634930370745;
        Fri, 22 Oct 2021 12:19:30 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-bfc7-2889-1b58-2997.res6.spectrum.com. [2603:8081:140c:1a00:bfc7:2889:1b58:2997])
        by smtp.gmail.com with ESMTPSA id bf3sm2246594oib.34.2021.10.22.12.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 12:19:30 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 00/10] Correct race conditions in rdma_rxe
Date:   Fri, 22 Oct 2021 14:18:15 -0500
Message-Id: <20211022191824.18307-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are several race conditions discovered in the rdma_rxe driver.
These patches correct them. They mostly relate to races between
normal operations and destroying objects.

This patch series applies cleanly to current for-next.
commit 71ee1f127543 ("Merge brank 'mlx5_mkey' into rdma.git for-next")

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v3
  Changed rxe_alloc to use GFP_KERNEL
  Addressed other comments by Jason Gunthorp
  Merged the previous 06/10 and 07/10 patches into one since they overlapped
  Added some minor cleanups as 10/10
v2
  Rebased to current for-next.
  Added 4 additional patches

Bob Pearson (10):
  RDMA/rxe: Make rxe_alloc() take pool lock
  RDMA/rxe: Copy setup parameters into rxe_pool
  RDMA/rxe: Save object pointer in pool element
  RDMA/rxe: Combine rxe_add_index with rxe_alloc
  RDMA/rxe: Combine rxe_add_key with rxe_alloc
  RDMA/rxe: Separate out last rxe_drop_ref
  RDMA/rxe: Rewrite rxe_mcast.c
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources
  RDMA/rxe: Minor cleanup in rxe_pool.c

 drivers/infiniband/sw/rxe/rxe.c       |   8 -
 drivers/infiniband/sw/rxe/rxe.h       |   1 +
 drivers/infiniband/sw/rxe/rxe_av.c    |  24 +-
 drivers/infiniband/sw/rxe/rxe_cq.c    |   9 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  19 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 210 ++++++++-----
 drivers/infiniband/sw/rxe/rxe_mr.c    |  11 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  28 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  39 +--
 drivers/infiniband/sw/rxe/rxe_pool.c  | 408 +++++++++++++++++---------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  84 +++---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  55 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 125 +++++---
 drivers/infiniband/sw/rxe/rxe_srq.c   |   8 +
 drivers/infiniband/sw/rxe/rxe_verbs.c |  67 ++---
 drivers/infiniband/sw/rxe/rxe_verbs.h |   4 +-
 17 files changed, 653 insertions(+), 457 deletions(-)

-- 
2.30.2

