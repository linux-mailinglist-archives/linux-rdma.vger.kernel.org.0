Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893CB53E907
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Jun 2022 19:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239461AbiFFOSU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jun 2022 10:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239793AbiFFOSQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jun 2022 10:18:16 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FB730F4F
        for <linux-rdma@vger.kernel.org>; Mon,  6 Jun 2022 07:18:11 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e5e433d66dso19280590fac.5
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jun 2022 07:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPKVGfp9r5lfwUaPhfDn7ISJKr8QLIaqI55Bkqu/2Ik=;
        b=dudH3jjjPJKkLLcAETTo1w4MriJuoXxXAhFy1Y1d0rk9f7X0p3drNbVkho0gsno88q
         h2kkqzUV7sW+WnjJo+OJcCu2qAAGjfc9UHTFUq4vh4460ieN4a8wbg4gKiLNWl300jWj
         WbbhJfd4bM6vd3iA4KKq7EzmMD6zIGHmL6O2gfcXRQlI2t+5NEOaobbvMcvnsmtI/fK4
         xPQxgnFDns7Lo+Sa4TncmwaXFZUN+7the/qmAI8wUxOBLBUNC9YJwu/3hqkKt87mYunY
         tmI6R1Ec2HVB52wXHg6aGOUHNYioqySPl0vLtIoT9W+ESACHUzCJpORM6xd8pwl926Wm
         J41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPKVGfp9r5lfwUaPhfDn7ISJKr8QLIaqI55Bkqu/2Ik=;
        b=xBZnj0YU7sCTZxpHtwCwG7fGiXF7qBVk5QLwQ+C6TBMiTRJP4T38eH9jJrN8h1bt88
         mg7ADwco92C3QMvMFKMPjGw6ajzv9B9O8ZOGUt1rnz7qjTOOZzf25P0vvoG6LKr+GZQC
         Ia4gBtnrJ48joKBAgL8OzaV9piO5UVPXiZnNatKCtZw7Tq2IzEFZBvFy99lI+NDA0Ho5
         rLinU1E0orVIVZiKxygyjpmvKEE9Nhm8Qw9uS2yZiOISpVaMgaqOWiyNXlboQ1wIFv1x
         942Zwi+Z2uqRMjYie+T2vRmM/7tMksslfvu+xLy/ghpmkpmhhOU3Q7fsIxKHteHew6Mu
         B7hg==
X-Gm-Message-State: AOAM5322PoOt/CFcx+6IRG6MpI4XgAk8q/EExykjqhgc3TSHB93K5xPp
        90UgpykZclRc9dYyOXPOQ9c=
X-Google-Smtp-Source: ABdhPJystE23J/BFusGv1u1txcPWaguyR6rjnzIbr6NonWmUbdACfXdngrCBVDHKMN2UiyBnJyWK/Q==
X-Received: by 2002:a05:6870:c38f:b0:e5:f2c4:acc9 with SMTP id g15-20020a056870c38f00b000e5f2c4acc9mr30632749oao.173.1654525090500;
        Mon, 06 Jun 2022 07:18:10 -0700 (PDT)
Received: from u-22.tx.rr.com (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.googlemail.com with ESMTPSA id gz9-20020a056870280900b000e686d1386dsm6710097oab.7.2022.06.06.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 07:18:10 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org, frank.zago@hpe.com, jhack@hpe.com
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v15 0/2] Fix race conditions in rxe_pool
Date:   Mon,  6 Jun 2022 09:18:02 -0500
Message-Id: <20220606141804.4040-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.34.1
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
destroying objects.  This patch series includes the remaining two
patches of the original series.

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v15
  Rebased to the current for-next branch of 5.19.0-rc1+.
  Adds support for RDMA_AH_CREATE/DESTROY_SLEEPABLE.
v14
  Rebased to current wip/jgg-for-next
  Removed patch 3 as unnecessary
  Waited for resolution of bugs in rxe_resp and some locking bugs.

  Note: With rcu read lock in rxe_pool_get_index there are no bottom
  half spinlocks from looking up AH or non AH objects to conflict
  with the default xa_lock so no lockdep warnings occur. The rxe_pool
  alloc functions can hold locks simultanteously with the rcu read
  lock so it does not have to prevent soft or hard IRQs.
v13
  Rebased to current for-next
  Addressed Jason's comments on patch 1, 8 and 9. 8 and 9 are
  combined into one patch.
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

Bob Pearson (2):
  RDMA/rxe: Stop lookup of partially built objects
  RDMA/rxe: Convert read side locking to rcu

 drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |  4 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 97 ++++++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_pool.h  | 18 +++--
 drivers/infiniband/sw/rxe/rxe_req.c   | 37 ++++++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c | 39 +++++++----
 6 files changed, 160 insertions(+), 37 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.34.1

