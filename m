Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B22F4C4F27
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Feb 2022 20:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiBYT7C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Feb 2022 14:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbiBYT7C (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 25 Feb 2022 14:59:02 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732C610BBE3
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:29 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id ay7so8415683oib.8
        for <linux-rdma@vger.kernel.org>; Fri, 25 Feb 2022 11:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9wHD7cW6WlVvjHg9LDwl1TSSmGAhbIaQCacfEQcIx8=;
        b=B/aJdi0gbOo9pQ09V5xCS8WnG96r1snoQDZyjqMkZaIQJrUWqqqbU5QONv2qNYmPg7
         k8UsJsn6TKnLQVu121XVd7MYk+I+wCIPrX1BuyVgC/eJa4qKXEx7/BibdsboP72FLnPD
         ufUStqvpNdD+srq6TYOlqpuX4psKzc6iD23IqpnuQfmUm0NP6QuzI4vH84AmHWdCi2nQ
         gPRXipAvW7lfRPPxyUuaIdUeaS9ApDrk3KqdTOi4+OivaTjZW14DXSz4VxZ4rwoXihyu
         4CKoMN6vl8BuhDeK/0Tv9hRQj9txYJmt5iu3uK3bqoXgEcoFT4zEB4lz6Lvegt8Z7/EC
         4kpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9wHD7cW6WlVvjHg9LDwl1TSSmGAhbIaQCacfEQcIx8=;
        b=TSPpWlOaoAvbmGfGXrUlIOfgskQCeZy4UqKBQEGbqMEjdKaZ8o6jaug5vU1mgj6R7s
         Vsk9/pXepMXeqVXuKpQafCacjRlme0jHKZ3be+Az1XsDc5kYsMs+27QzVA2xuPshjTaN
         W7UZ0KZ3GbG5mNb5olnfrTjGwTHsTVBTnz75PRndBehp0u3WV9k0j2IhWWB3/yxiK92m
         AgiRTjOfRdDboo8MXU9HgMkjK+M9tMDb0NWkkTLSlXZcpwvf8zuw67Q3UFkAJx3VzYPb
         QttqFtxMvyi0h9Y5sZtFlm4ydrtZbxq7mzk50NAKWq4NveQWRBAvaQj5XXypCNMvCRtx
         zIvQ==
X-Gm-Message-State: AOAM5333naZaYrhfri+dUHIcULok1DPC9qT8doYFFN5UMYU22B3+P2k6
        ZtjV3aAskI3EMvcrN/zcHz4=
X-Google-Smtp-Source: ABdhPJyuNlDhzLtU2ZxMMDWPCdAZlfFINRII1SQx2q55etbTGqJSuMjhG6SWziDXqq2n2HwrNg/FUQ==
X-Received: by 2002:aca:ac8b:0:b0:2d5:2e1c:2b07 with SMTP id v133-20020acaac8b000000b002d52e1c2b07mr667971oie.77.1645819108776;
        Fri, 25 Feb 2022 11:58:28 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-bf76-707d-f6ed-c81c.res6.spectrum.com. [2603:8081:140c:1a00:bf76:707d:f6ed:c81c])
        by smtp.googlemail.com with ESMTPSA id e28-20020a0568301e5c00b005af640ec226sm1578424otj.56.2022.02.25.11.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:58:28 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v10 00/11] Fix race conditions in rxe_pool
Date:   Fri, 25 Feb 2022 13:57:40 -0600
Message-Id: <20220225195750.37802-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are several race conditions discovered in the current rdma_rxe
driver.  They mostly relate to races between normal operations and
destroying objects.  This patch series
 - Makes several minor cleanups in rxe_pool.[ch]
 - Replaces the red-black trees currently used by xarrays for indices
 - Corrects several reference counting errors
 - Adds wait for completions to the paths in verbs APIs which destroy
   objects.
 - Changes read side locking to rcu.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v10
  Rebased to current wip/jgg-for-next.
  Split some patches into smaller ones.
v9
  Corrected issues reported by Jason Gunthorpe,
  Converted locking in rxe_mcast.c and rxe_pool.c to use RCU
  Split up the patches into smaller changes
v8
  Fixed an additional race in 3/8 which was not handled correctly.
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

Bob Pearson (11):
  RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
  RDMA/rxe: Delete _locked() APIs for pool objects
  RDMA/rxe: Replace obj by elem in declaration
  RDMA/rxe: Replace red-black trees by xarrays
  RDMA/rxe: Stop lookup of partially built objects
  RDMA/rxe: Add wait_for_completion to pool objects
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources
  RDMA/rxe: Convert read side locking to rcu
  RDMA/rxe: Move max_elem into rxe_type_info
  RDMA/rxe: Cleanup rxe_pool.c

 drivers/infiniband/sw/rxe/rxe.c       |  87 +----
 drivers/infiniband/sw/rxe/rxe_av.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   5 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  13 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  17 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 453 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  74 ++---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  55 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 125 ++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  55 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 -
 13 files changed, 462 insertions(+), 456 deletions(-)


base-commit: 3ac3107872b8dd4b5c4c1b598fcbc24983cd009b

Patch applies to current wip/jgg-for-next with or without the last
two (5-6/6) patches in the multicast series.
-- 
2.32.0

