Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BBC4780A6
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Dec 2021 00:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbhLPXd7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Dec 2021 18:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhLPXd7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Dec 2021 18:33:59 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119DC061574
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:33:59 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso747159otf.12
        for <linux-rdma@vger.kernel.org>; Thu, 16 Dec 2021 15:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4EoVI4wbDp+Xh1ABLCqXuYVNWMuY10tUCeJgHGHBtE=;
        b=CHA/ALmZIZsg4iVncxnQMfAgLItTB762nxnihkLq6MO79EbughqodlhWTVGjqDgCVv
         OdKdTR0P6DVkR3hutqf5JdXSm8umRP1syw1B5OlUJxIh9SJZ8vc8vXmIOcKjWPAfbdSp
         gWk+BKMeCrRu5JCHTybXKVfMOGYSAgixMSkWYnEj0spm5qnlIxw39Z2eouV5QZbaz3S0
         U8Lqg+PgNDHlnmK9xhe97kGqd/1jTyBAvqiW4JuzQ0xVent8mZThzINeVcUR/xzBLT5o
         DcAC88yjf0XEVGycdyL2LZSduuQqIkv4bjWDx1ikVldHakTqR8xt5wuhYn68ZAwwWQwE
         7JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F4EoVI4wbDp+Xh1ABLCqXuYVNWMuY10tUCeJgHGHBtE=;
        b=bmcrEVidhyFTC0zmE1KxW4GeOiBauIdYKB8jj/wra+fEDf5tpoaiQ1jpWM9eMgdfTj
         gACb+b+aoagmE7uIgz0AB9RebpIAwhupsukR1nQJdsoRWRDwvKn26Iodrm20JfzDyXxW
         pB5HGNrq8+ddiunCWLUTuMuTSESxAzwJ1rOfUfavW7bkktCmgFM5+vj2uyy68s8XBy13
         5nLqoDGyghWWFwYy4Y9WZEKnnG8b77IZ1iWZmTmuGt4Sd4zjbJSVjbanhJ1m6clUymMG
         NL2afpRe51xUyit6bPq8UlVo6nST2GV9AYKENTL8vL+rrbkfGgXpMwCGQUcIHRreG+Is
         mhnQ==
X-Gm-Message-State: AOAM5311bxNiv93N3tt/p1x2kh7Mg/mHWss+OmB+CLUAaSIbcI6TuZ9J
        vhV+Yvqr9lbLRLT8M5YlgaI=
X-Google-Smtp-Source: ABdhPJwcWZpkurs407MAnBvDojxnNM+NqXc15/5ygC2lkkk1KtmUHS7yzqi2ftEc+gIuyMFofPC3tg==
X-Received: by 2002:a05:6830:1447:: with SMTP id w7mr322777otp.199.1639697638502;
        Thu, 16 Dec 2021 15:33:58 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-ec41-d089-dfdb-6fb5.res6.spectrum.com. [2603:8081:140c:1a00:ec41:d089:dfdb:6fb5])
        by smtp.googlemail.com with ESMTPSA id w19sm1253888oih.44.2021.12.16.15.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 15:33:58 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v8 0/8] RDMA/rxe: Correct race conditions
Date:   Thu, 16 Dec 2021 17:31:54 -0600
Message-Id: <20211216233201.14893-1-rpearsonhpe@gmail.com>
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
commit c8f476da84ad ("Merge branch 'mlx5-next' of
	git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux")

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
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
 drivers/infiniband/sw/rxe/rxe_mcast.c |  76 ++--
 drivers/infiniband/sw/rxe/rxe_mr.c    |   3 +-
 drivers/infiniband/sw/rxe/rxe_mw.c    |   7 +-
 drivers/infiniband/sw/rxe/rxe_net.c   |  17 +-
 drivers/infiniband/sw/rxe/rxe_pool.c  | 529 ++++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_pool.h  | 110 ++----
 drivers/infiniband/sw/rxe/rxe_qp.c    |  10 +-
 drivers/infiniband/sw/rxe/rxe_req.c   |  55 +--
 drivers/infiniband/sw/rxe/rxe_resp.c  | 125 ++++--
 drivers/infiniband/sw/rxe/rxe_verbs.c |  72 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |   3 -
 14 files changed, 515 insertions(+), 622 deletions(-)

-- 
2.32.0


