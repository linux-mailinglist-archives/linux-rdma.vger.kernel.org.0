Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34946F3BB
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 20:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhLITTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 14:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhLITTL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 14:19:11 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC94C061746
        for <linux-rdma@vger.kernel.org>; Thu,  9 Dec 2021 11:15:37 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id d1-20020a4a3c01000000b002c2612c8e1eso1895318ooa.6
        for <linux-rdma@vger.kernel.org>; Thu, 09 Dec 2021 11:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtipYe+/xhkSJYCE8m5OLhHxAXsS7iVTOxgctNCYNfo=;
        b=Ll9vBoTQridUSFSoegKyfs6+4CwCG10NqMpn1+UKX4asXHJlty4Wl5l9Iv3NB8Uf0u
         xHb4VNTn3xbaY41gkfApZYclu82EGJ9MZztXYGXP8J1OPf4MjPtRbNtfB6NtdpinociM
         +kyaCpRNmvRGaUIxIJQVXIqgcjsFmZGskbMljDzVGDIE61j9ySL5uvjtSAXbjpr3bBIZ
         0SfgYqRYtgZsacL7+cVm39IJiRn8rNCdclNAw++r/hTDvzAEKW3Ug4AEl1sRaM7LJXxu
         B4q6/WphOvwieFVnCPDT+0V3Z+6T+X81MnhdQu6A62oCqDWtEoGR3bilTxphfnAwYFWy
         MdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtipYe+/xhkSJYCE8m5OLhHxAXsS7iVTOxgctNCYNfo=;
        b=zl/Oi09YzmpFGafIJ87CPZFwyRko51KeJ1Ysno19h7InT9EyP+Nwu/asus3fdMQE1N
         m/l+yDQqQ3nrRHj50PYLlr+FE3vaSt7+C/UHs3KCdhObC3IaXRSKfVsOUHDtTkeas/mN
         ekPlOtrOh2wdA6Js4p2Dq13hMlrqQ2clRMxc/vWO/dDqiKUEgEo7UKFrMgkQpdp10HKI
         gI4yB5CCKazm+6r+7Rb8VSsEYk7TOqV2I9b5gLdHOJkKKWfKIS2SmX0h/1ib1B8mbWdn
         zPkCjKoZ2HKp8DiSWc8Oyii30Y/cfo89W8oRof7jA3vjcInbQdGFbLhtCTG+ERbjdwTd
         q+cQ==
X-Gm-Message-State: AOAM533p4Gos6ZofefqCZ+2mngOQtUji+ldc0+W1EILoW1Sus21bpYLV
        Qwj8YrQjAbEwtfZWSHcAYyRLAj0KGz4=
X-Google-Smtp-Source: ABdhPJyZcDWd+5GKMh50svB5EyuVZNVGVInI/YAnJKmZ0SI1gSl4AoPGnIuI8wrkGbq/NI4WbJFRaw==
X-Received: by 2002:a4a:3042:: with SMTP id z2mr5250761ooz.47.1639077336728;
        Thu, 09 Dec 2021 11:15:36 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-9c23-089d-4ab2-4477.res6.spectrum.com. [2603:8081:140c:1a00:9c23:89d:4ab2:4477])
        by smtp.googlemail.com with ESMTPSA id h3sm117807oon.34.2021.12.09.11.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:15:36 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v7 0/8] RDMA/rxe: Correct conditions
Date:   Thu,  9 Dec 2021 13:14:19 -0600
Message-Id: <20211209191426.15596-1-rpearsonhpe@gmail.com>
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
commit 0a0575a12e31 ("RDMA/bnxt_re: Fix endianness warning for req.pkey")

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
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

Bob Pearson (8):
  RDMA/rxe: Replace RB tree by xarray for indexes
  RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
  RDMA/rxe: Cleanup pool APIs for keyed objects
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources
  RDMA/rxe: Minor cleanups in rxe_pool.c/rxe_pool.h
  RDMA/rxe: Replace rxe_alloc by kzalloc for rxe_mc_elem
  RDMA/rxe: Add wait for completion to obj destruct

 drivers/infiniband/sw/rxe/rxe.c       | 101 +----
 drivers/infiniband/sw/rxe/rxe_av.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  10 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c |  71 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    |   3 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |   7 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  17 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 507 +++++++++++---------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 110 ++----
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  55 +--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 125 +++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  72 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 -
 14 files changed, 489 insertions(+), 621 deletions(-)

-- 
2.32.0

