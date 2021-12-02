Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1620D466D94
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Dec 2021 00:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241934AbhLBXYx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Dec 2021 18:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbhLBXYw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Dec 2021 18:24:52 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F2C06174A
        for <linux-rdma@vger.kernel.org>; Thu,  2 Dec 2021 15:21:29 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso1761466ota.5
        for <linux-rdma@vger.kernel.org>; Thu, 02 Dec 2021 15:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLhCqiPqYcPsLdBNkLghibZJjZiXeuWMiT0IM8E1RUY=;
        b=UutjpoKmJ2adUXhg3PRRfFgJfvy5XhtwpMUZJq8t63XgNmn1d/+AsQ4ghT0kTASXnQ
         dDAndIUeqtlzafud1pRIDlvBkLhAE3bscQ/shlM60+lRiC6QT/+ZPBtqps93IZdcTkDq
         wfJ/0jeh2M5VMBK3WTTi6WBCatniorz1fPFsHiouKj6DFXohiuGV626WeYXX18/iyBBU
         GamwMW0yu1LCdh8ti3g/3RMDIF7EkX4qzERhN2WsMpljn8sxMHCqBhEIJ/06Kf7Mnzxu
         9yAW+vJ2a1FMkQPnO65fsameO6xwswbT0nxbpyhqIMiRMMwqEor1Eh814w0Z6kkZXbiM
         OXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BLhCqiPqYcPsLdBNkLghibZJjZiXeuWMiT0IM8E1RUY=;
        b=tXozMaDcF0DeyNp3p8w4nvkZuiB7874z15yIRZueDaBZtdxblBFdW+qGGn/dr9zgt3
         VNvUMptOVSiKgvReS+0mVCIFMUBpDJryzrd6rn2EkAm7CepKB2r26wab/w+dY5Yf4tkg
         AnOYrj+abMkW72Lq95CD3E1UOgjvo9tl5lXKZY/D14Xl3arHB1tiJzTbB0md56z3BbTw
         nbbU4YyH0xuysv9Ul8SRRZ5r13ikXRdAb0qvTWKdd6GugiXkRtqppRk/hHdaZqzgM/D9
         eFw3zTE6WTgnKQgpTWMUReUrqSwRHFwMq5gL23UNfG3VSSfRSzPX7jrUwR+xTQusmt5B
         A8eg==
X-Gm-Message-State: AOAM532L4eFB9u/BZNv7pAgN4JXEKCgqRh3Y5H09Q/TduMl6U+SW5z4c
        bJHm9svNXJkGcpMFGGSTywQ=
X-Google-Smtp-Source: ABdhPJzm0DUfvqmCRlhVTy4w8p3o3r96JBH7YM14Mb84U727gnjZBMeS9agTn/jyRkN9XsbEfOQxYQ==
X-Received: by 2002:a9d:6ac7:: with SMTP id m7mr13766768otq.306.1638487288853;
        Thu, 02 Dec 2021 15:21:28 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-369f-9a20-b320-aa23.res6.spectrum.com. [2603:8081:140c:1a00:369f:9a20:b320:aa23])
        by smtp.googlemail.com with ESMTPSA id g7sm296425oon.27.2021.12.02.15.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:21:28 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 0/8] RDMA/rxe: Correct race conditions
Date:   Thu,  2 Dec 2021 17:20:27 -0600
Message-Id: <20211202232035.62299-1-rpearsonhpe@gmail.com>
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

This patch series applies cleanly to current for-next.
commit 81ff48ddda0b ("Use bitmap_zalloc() when applicable")

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
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

Bob Pearson (8):
  RDMA/rxe: Replace RB tree by xarray for indexes
  RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
  RDMA/rxe: Cleanup pool APIs for keyed objects
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources
  RDMA/rxe: Minor cleanups in rxe_pool.c,h
  RDMA/rxe: Replace rxe_alloc by kzalloc for rxe_mc_elem
  RDMA/rxe: Add wait for completion to obj destruct

 drivers/infiniband/sw/rxe/rxe.c       | 101 +-----
 drivers/infiniband/sw/rxe/rxe_av.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  10 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c |  70 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    |   3 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  18 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  17 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 473 ++++++++++----------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 113 ++----
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  |   4 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  66 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 131 ++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  96 ++++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 -
 16 files changed, 503 insertions(+), 635 deletions(-)

-- 
2.32.0

