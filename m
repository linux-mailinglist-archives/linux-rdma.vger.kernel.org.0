Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC14C4CCA86
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Mar 2022 01:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiCDAJa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Mar 2022 19:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiCDAJ3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 3 Mar 2022 19:09:29 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588D34739D
        for <linux-rdma@vger.kernel.org>; Thu,  3 Mar 2022 16:08:42 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id z8so3024570oix.3
        for <linux-rdma@vger.kernel.org>; Thu, 03 Mar 2022 16:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+gNaJxQBk0jLzr7mZw0z5iuagCvhM0uqik3av28nKrc=;
        b=MXrjRpl/y5885i4hDCXDe7TMFu6V+4WykIoAknQKJ6S/EyLlZv3ah8HuvY9WRyWCPi
         REr2woDx9o+1jPSVW5hg2JQPXk427HQdK5PIxdqOblNsSEWeK9cL7QMwQhwqzOMYwnEC
         yAMMhmCZKt9iVcgeDD7yH16xf+azOWpCwtppRksv5e2nyTuCtPMIvZV54FEcK3eIgeC9
         ve7DJo/momqfe35vBOVW3GZTs7R5nGJV3glPpFvoq70IMgbB6Dx71gmNJWC9JLCnHH4O
         IQJnD/SPah9IiJFX3ZSGLN2Ie5S7cU/aqKNCH/yIQxDUTpvgihaJyMlulIzWy1k4ufYF
         DOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+gNaJxQBk0jLzr7mZw0z5iuagCvhM0uqik3av28nKrc=;
        b=sSc8ubjVNGgD4XQxM/HDfQK34O75VYYQdkNp7TnIIg8+Vg3nGAcJRCdE7h7vaVCaHR
         bHtEk/iF62z33SnBaoD6zsE8B7cvDLovqMZXRfBrIhBCVfkyTxqrYCVNWktV28u3eYtD
         2OBAE/WWzYDUmhyThhBsbo70XmEci0dZEeWqpzHgSKgeAvNGkTDVtqyjRZG14LPYmrdW
         bKjMc08wkbQWTSPLTIa+agneP3C222YIcj7AMLi/B66pATgCfaqAGGI6LkD5+Ek1Tzbj
         BS1bBBQoxGqNFKZP3ufPFzXsrLYEKXBtM/Mmk8OYlOoDxFQJ0Wgr15YqOlr0JuC9G6Xg
         oYJQ==
X-Gm-Message-State: AOAM532KFtdiNG/mLc+gVbnhFEDCRO7MelWKW18NOHwzwcDLY3Z71PEa
        8m1U99qyAtIiLFtxLFu0D2LYlvQgdK8=
X-Google-Smtp-Source: ABdhPJw2cEC72Cx5ydR48d4HAlEIjev5wryTiuL9wRHMTuMERZHYfYRZVthlVN1lQyixuUDhS0G/3Q==
X-Received: by 2002:a05:6808:1183:b0:2d4:5eeb:1ca3 with SMTP id j3-20020a056808118300b002d45eeb1ca3mr6851743oil.8.1646352521540;
        Thu, 03 Mar 2022 16:08:41 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-4a4e-f957-5a09-0218.res6.spectrum.com. [2603:8081:140c:1a00:4a4e:f957:5a09:218])
        by smtp.googlemail.com with ESMTPSA id n23-20020a9d7417000000b005afc3371166sm1646469otk.81.2022.03.03.16.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 16:08:41 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 00/13] Fix race conditions in rxe_pool
Date:   Thu,  3 Mar 2022 18:07:56 -0600
Message-Id: <20220304000808.225811-1-rpearsonhpe@gmail.com>
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
v11
  Rebased to current for-next.
  Reordered patches and made other changes to respond to issues
  reported by Jason Gunthorpe.
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

Bob Pearson (13):
  RDMA/rxe: Fix ref error in rxe_av.c
  RDMA/rxe: Replace mr by rkey in responder resources
  RDMA/rxe: Reverse the sense of RXE_POOL_NO_ALLOC
  RDMA/rxe: Delete _locked() APIs for pool objects
  RDMA/rxe: Replace obj by elem in declaration
  RDMA/rxe: Move max_elem into rxe_type_info
  RDMA/rxe: Shorten pool names in rxe_pool.c
  RDMA/rxe: Replace red-black trees by xarrays
  RDMA/rxe: Use standard names for ref counting
  RDMA/rxe: Stop lookup of partially built objects
  RDMA/rxe: Add wait_for_completion to pool objects
  RDMA/rxe: Convert read side locking to rcu
  RDMA/rxe: Cleanup rxe_pool.c

 drivers/infiniband/sw/rxe/rxe.c       |  88 +----
 drivers/infiniband/sw/rxe/rxe_av.c    |  19 +-
 drivers/infiniband/sw/rxe/rxe_comp.c  |   8 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   5 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c |   4 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  17 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  42 ++-
 drivers/infiniband/sw/rxe/rxe_net.c   |  23 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 461 ++++++++++++++------------
 drivers/infiniband/sw/rxe/rxe_pool.h  |  75 ++---
 drivers/infiniband/sw/rxe/rxe_qp.c    |  38 +--
 drivers/infiniband/sw/rxe/rxe_recv.c  |   8 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  61 ++--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 149 ++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.c |  89 +++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 -
 16 files changed, 540 insertions(+), 548 deletions(-)


base-commit: a80501b89152adb29adc7ab943d75c7345f9a3fb
-- 
2.32.0

