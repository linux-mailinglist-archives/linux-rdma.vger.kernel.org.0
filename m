Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65721425DB8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Oct 2021 22:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhJGUn0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Oct 2021 16:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhJGUn0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Oct 2021 16:43:26 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECEDC061570
        for <linux-rdma@vger.kernel.org>; Thu,  7 Oct 2021 13:41:32 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w10-20020a056830280a00b0054e4e6c85a6so45518otu.5
        for <linux-rdma@vger.kernel.org>; Thu, 07 Oct 2021 13:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHSEDkD/JekkEqO9kDkyGdw1tO+GA4NohQGHA7oSg8E=;
        b=HKti3fxPuPZXCxZDqsavC2Qx0DCtKTu+vcloIXaHiCkTZo/PGcgKU8lou5YCnFrSGS
         35zYTbHhhEP4/0rVgtj/0wSU6GbQLtqtHo8Wip7p0e3wh7ycD2l9Hv9hFVKD7/qv4oRY
         TzeRNd1HzlyGGjSyVYnxzlR+fK0G5NyB+EiqjMj6tLYIr6mog7fnKBqKT+OlJFs20nC0
         1WMTfmInAag8vuVS8WZR1oVHxIKmTG6cOV2DOHf86KL7In+YtJuvovGb8ZtsHVFrRR2g
         SgwCGHzG6IaMGcIh0lxhzEdB8r0ikVKNj0QxZq2isijk60D+fYcCRofiTcSYdyX37D15
         TC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHSEDkD/JekkEqO9kDkyGdw1tO+GA4NohQGHA7oSg8E=;
        b=Ja3Lk9KqnneHhWHyLAZwM2Cl7GxcpbB1hDX4xbob/w7bcjAgRzzR1kSGJADpEfkRgv
         kfiPUpeaV9eSFRHsXDUTGRNqI6fUWezrZ95nUoav/87cOvCjF935yI+YLnzWio/SAPLp
         sgKjrP5GchNF96e5lF8HWgl9H2+cRhdFTYGIXnJEzq6QALQOO6L53S/89fha/z62rSc3
         yJcEBan/De6o7QcvNY70cxQDvaReGhi/fnhvv+7p9nrt7BknCvDm5pzIvqK83eNufBIg
         TPAeBVdCFmLt47yT6cDMrBaHes5pVxaEhZBZfGngvrjbi99nXP+hD/SYF1Xdd2WDydmZ
         rcLA==
X-Gm-Message-State: AOAM530wwZFaTcpWNX4vsU8Zh4YzPOhhixXFwkg8sLq9l38WFjZSm4tc
        JWu+Hy7SDEPwlRS8K/n8WRCw3DW6wSg=
X-Google-Smtp-Source: ABdhPJx2EcdqnMkbDjX/4v6BmjeHKyaPqOA/rPjCgjRv9KLv9T0InkXAKIWmbSjJgMhWz5+rQYGLkw==
X-Received: by 2002:a05:6830:310d:: with SMTP id b13mr5727522ots.120.1633639291403;
        Thu, 07 Oct 2021 13:41:31 -0700 (PDT)
Received: from ubunto-21.tx.rr.com (2603-8081-140c-1a00-1259-16f0-10f5-1724.res6.spectrum.com. [2603:8081:140c:1a00:1259:16f0:10f5:1724])
        by smtp.gmail.com with ESMTPSA id f10sm71607ooh.42.2021.10.07.13.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:41:31 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 0/6] Replace AV by AH in UD sends
Date:   Thu,  7 Oct 2021 15:40:46 -0500
Message-Id: <20211007204051.10086-1-rpearsonhpe@gmail.com>
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

This series of patches is rebased to
    commit: 286dba65a4a65a6d5de011767061f6ffa6e10389 (for-next)

---
v6:
  Rebase to 5.15.0-rc4
  Reduced the max number of AH objects from 1M to 32K.

v5:
  Rebase to 5.15.0-rc2+

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

