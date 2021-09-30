Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900D341D261
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Sep 2021 06:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347908AbhI3E26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Sep 2021 00:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbhI3E24 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Sep 2021 00:28:56 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CEAC06161C
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:14 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id w6-20020a4aa446000000b002b5795cca03so1462022ool.6
        for <linux-rdma@vger.kernel.org>; Wed, 29 Sep 2021 21:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Doxsi1NwF6uhRcXu8/ygPwhxRbZfcNOjPEVp8rMEbXE=;
        b=O+QdNCtMh/iDhNYKaI4sWcbxp2YjC3h12HsH/+eawwFfJEthIeZjO6C9Zjj67QgAj/
         6cd9jPK0XqaabUDw0KqaVX8jG2Bc60fFbjPT5IQMSVE+cq/jOUmBFoYoeld5ZDsA//E+
         GT8b1OnGYgqNySmFc5nsP6MHakIwnEXUvC2PI49EJMMbuTOB0njTCJCYho8f4Ahw6WTW
         NFkGcYxzq+LXkpCTPyiS00G5VY6WnR+6DKXpH/v0oZTKbcZPlsu/Qun49q2MRidsviz2
         d+KB13W6Id/oGZge/ZrN2yZYc5dG2XkYZ6GLugXeyqtHAzH8MirGuFEES816a2/bZSCW
         D4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Doxsi1NwF6uhRcXu8/ygPwhxRbZfcNOjPEVp8rMEbXE=;
        b=iFFl0mW2N8bhcwMVxX4wXjgjQtQnohJKTR7WNSl64x+rVoxyTQrUQ7K5s9Yn93Kx+x
         jmq2vzzMAD+JU5744JDc2xVC8ODnoJ/qEm8JTvntloIIcnlxDl8JqICxTMc8bHiB3srH
         zn4U1saVocbzts51Oh7s4kXtSQ26PZ9mJR47YlJe174FMwsKLow00H4XMDiRhycB4KXt
         7rVfX8wo4RPI1Ojc+z6VXOuzR/ECV7BXhC3HLYcIBYIWYdOJMIeZ6KwCbiRRp8aC9jmr
         bVdLkG0Auyc+qR6QFcQGqwwBknoqm2O7zzdsHqdE0EEvBsYRtCJcABl4aPQVX3YrIb7V
         7AEw==
X-Gm-Message-State: AOAM5332kfWtPjSRhLBfB7zqJjt3l+iwK9p5DtfP30TOJVgoVM/DA4pB
        /pJLl/a6x/tM5dxCDgGPHEo=
X-Google-Smtp-Source: ABdhPJyvf5tPKuFu9ULEoC38oGl0OVLbjKntnj8H88EGt2eZBpvbnype18X+rPTzVGuJfu1ojbvxQA==
X-Received: by 2002:a05:6820:17a:: with SMTP id k26mr3060776ood.37.1632976033895;
        Wed, 29 Sep 2021 21:27:13 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-48b3-0edc-a395-cab0.res6.spectrum.com. [2603:8081:140c:1a00:48b3:edc:a395:cab0])
        by smtp.gmail.com with ESMTPSA id a23sm373661otp.44.2021.09.29.21.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 21:27:13 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 0/6] Replace AV by AH in UD sends
Date:   Wed, 29 Sep 2021 23:25:58 -0500
Message-Id: <20210930042603.4318-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently the rdma_rxe driver and its user space provider exchange
addressing information for UD sends by having the provider compute an
address vector (AV) and send it with each WQE. This is not the way
that the RDMA verbs API was intended to operate.

This series of patches modifies the way UD send WQEs work by exchanging
an index identifying the AH replacing the 88 byte AV by a 4 byte AH
index. In order to not break compatibility with the existing API the
rdma_rxe driver will recognise when an older version of the provider
is not sending an index (i.e. it is 0) and will use the AV instead.

This series of patches is almost identical to an earlier version
but rebased to 5.15.0-rc1+. It applies cleanly to

    450f4f6aa1a369cc3ffadc1c7e27dfab3e90199f (for-next)

v4:
  Rebase to 5.15.0-rc1+

v3:
  Split up commits into smaller steps.

v2:
  Rearranged AV in rxe_send_wqe to be in the ud struct but padded to the
  same offset as the original preserving ABI compatibility.

Bob Pearson (6):
  RDMA/rxe: Move AV from rxe_send_wqe to rxe_send_wr
  RDMA/rxe: Change AH objects to indexed
  RDMA/rxe: Create AH index and return to user space
  RDMA/rxe: Replace ah->pd by ah->ibah.pd
  RDMA/rxe: Lookup kernel AH from ah index in UD WQEs
  RDMA/rxe: Convert kernel UD post send to use ah_num

 drivers/infiniband/sw/rxe/rxe_av.c    | 20 +++++++++++++-
 drivers/infiniband/sw/rxe/rxe_param.h |  4 ++-
 drivers/infiniband/sw/rxe/rxe_pool.c  |  4 ++-
 drivers/infiniband/sw/rxe/rxe_req.c   |  8 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 39 ++++++++++++++++++++++-----
 drivers/infiniband/sw/rxe/rxe_verbs.h |  8 +++++-
 include/uapi/rdma/rdma_user_rxe.h     | 10 ++++++-
 7 files changed, 79 insertions(+), 14 deletions(-)

-- 
2.30.2

