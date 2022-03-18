Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6BE4DD29D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Mar 2022 02:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiCRB4z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Mar 2022 21:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiCRB4y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Mar 2022 21:56:54 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2BD2405A9
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:29 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id j83so7528918oih.6
        for <linux-rdma@vger.kernel.org>; Thu, 17 Mar 2022 18:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PFW8uzzWNyNDnMqerZ55amLh962e/6oXJe4Y+uHZh8=;
        b=Ec0vB1KLy0CBd3tkb8hQH9guEiV5qSZHwpHFJvP2MhEhFGo2NRQmecPYl6w1cHD2ZQ
         hnpYC0s84BNxPwbSAK+rHs0vQqI4jhoAemrsOcugnbyqCWdmhK8/8zeXwyJwZT4AxOgT
         iaaePkeK6XeE34Sqgs1xJP6bUh0ZaQgoDVELXFKuX05oabI9y5tAAaO0ibCNgRTb2kO5
         fssByewDXQtNAVvJ6bjZa3Gkuwe71bJjpPbVFewI+3hkDapMDk+tZYYEJY+s5CbP0DUl
         FlVvW8gkTKho5V86DWe8RkT3MzyM+vcoDUWBDCQj3i6uhm6b41v8RWBMvPlrt0j+eGYC
         4xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1PFW8uzzWNyNDnMqerZ55amLh962e/6oXJe4Y+uHZh8=;
        b=oBJPcgTVZIHkkOujVM1qUVS0XH4YEUEx69Fsn6yeqkC9KyK/3FfJDD/ePAq8TZqj0o
         Rl1FGDlwDs4RRfIx3ZAGxwnv8MrblKi8u9d7fyzjsXEeSaDdcUHGw67MS+p7tLTHzCBU
         C0huJTjea6u/NgVeRkxS38O05z2Oi+3STba9va4qlqpWcuSSrqhRA7UIgnOcd4lEHLNT
         J0Qxmvwuy9EEZmg+vcnws3IVh9W37daN5neIAFHsMluk7G9So2qAPRtxMkeW6lWmkvJc
         Aj5MKNyyAzZeOw+8YL/OhAIX0kYzzZSXXa26NLDrXHtMLHcCDOUjHbZtlFRJa7oIAPMX
         pI2g==
X-Gm-Message-State: AOAM532yJCGjKylGwmTPWMSb26JpJ88UKR/rnusmUWoFJIbcwV9hLMVG
        SEyxo68+VhVjfNtV2Am37mI=
X-Google-Smtp-Source: ABdhPJwf+C9n0l7q9GkGn9jzfgV6avDd6tEzU9T/21v7aAaEvhgXnIC7ktBT0zck3wQ0vTfkc4Kw5A==
X-Received: by 2002:a54:4502:0:b0:2d9:a01a:4c01 with SMTP id l2-20020a544502000000b002d9a01a4c01mr3499563oil.296.1647568528813;
        Thu, 17 Mar 2022 18:55:28 -0700 (PDT)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-257e-2cb6-0a79-8c62.res6.spectrum.com. [2603:8081:140c:1a00:257e:2cb6:a79:8c62])
        by smtp.googlemail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm3292878oaf.10.2022.03.17.18.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 18:55:28 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v12 00/11] Fix race conditions in rxe_pool
Date:   Thu, 17 Mar 2022 20:55:03 -0500
Message-Id: <20220318015514.231621-1-rpearsonhpe@gmail.com>
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
 - Adds wait for completions to the paths in verbs APIs which destroy
   objects.
 - Changes read side locking to rcu.
 - Moves object cleanup code to after ref count is zero

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v12
  Rebased to current wip/jgg-for-next
  Dropped patches already accepted from v11.
  Moved all object cleanup code to type specific cleanup routines.
  Renamed to match Jason's requests.
  Addressed some other issued raised.
  Kept the contentious rxe_hide() function but renamed to
  rxe_disable_lookup() which says what it does. I am still convinced
  this cleaner than other alternatives like moving xa_erase to the
  top of destroy routines but just for indexed objects.
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

Bob Pearson (11):
  RDMA/rxe: Replace #define by enum
  RDMA/rxe: Add rxe_srq_cleanup()
  RDMA/rxe: Check rxe_get() return value
  RDMA/rxe: Move qp cleanup code to rxe_qp_do_cleanup()
  RDMA/rxe: Move mr cleanup code to rxe_mr_cleanup()
  RDMA/rxe: Move mw cleanup code to rxe_mw_cleanup()
  RDMA/rxe: Enforce IBA C11-17
  RDMA/rxe: Stop lookup of partially built objects
  RDMA/rxe: Add wait_for_completion to pool objects
  RDMA/rxe: Convert read side locking to rcu
  RDMA/rxe: Cleanup rxe_pool.c

 drivers/infiniband/sw/rxe/rxe_comp.c  |   3 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |  16 +--
 drivers/infiniband/sw/rxe/rxe_mr.c    |  13 +--
 drivers/infiniband/sw/rxe/rxe_mw.c    |  62 ++++++-----
 drivers/infiniband/sw/rxe/rxe_pool.c  | 155 ++++++++++++++++++++++----
 drivers/infiniband/sw/rxe/rxe_pool.h  |  14 ++-
 drivers/infiniband/sw/rxe/rxe_qp.c    |  22 ++--
 drivers/infiniband/sw/rxe/rxe_req.c   |   3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c  |   3 +-
 drivers/infiniband/sw/rxe/rxe_srq.c   |  21 +++-
 drivers/infiniband/sw/rxe/rxe_verbs.c |  73 ++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h |   7 ++
 12 files changed, 273 insertions(+), 119 deletions(-)

base-commit: 3197706abd053275d2a561cfb7dc8f6cfaf7d02c
-- 
2.32.0

