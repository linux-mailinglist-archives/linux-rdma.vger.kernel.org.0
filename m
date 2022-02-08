Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414174AE3EF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386596AbiBHWYw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386859AbiBHVRQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 16:17:16 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF82EC0612B8
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 13:17:15 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id ay7so425604oib.8
        for <linux-rdma@vger.kernel.org>; Tue, 08 Feb 2022 13:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1WN6g3Wf1ED2+nYdneYmoe6mCk1BELm1ruAGFVJLi8=;
        b=i//IEf+B8D8+zaaTZme0PpT0s3jh9GBiM/nRL2jdIB6D+tVDl/fzjqmKvZK4dehYAm
         DrFDJlFb5HvtOC+JtQZ1ndmawi9Mq1bAe6lLohCk90miBuV1JzKWFLlYG/O7Phe6hPaO
         9c+TGWfm6ccC6fOO3UHtfAUp8NrWP0qwmXK3Q1CH/+ydR5FkJH5rhPOf74DLzbJe/eiZ
         HqdFaMiXowqsnx20FUNR6DWDKWVgASrONxau0xBiqbByXmGyOgO6j2dYnyZXopjGBsJU
         nGywOInLzF01voXzck0fbfVyoQHhjWtdBRcr/rPyMPEyTmLjdRs9hQwhANkleh6BTgWp
         qW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1WN6g3Wf1ED2+nYdneYmoe6mCk1BELm1ruAGFVJLi8=;
        b=kZx30MAISiX7KoR509eiffL9L0FSQMAA/THvIJYISZsFROAkLka4xyMMlgbl1eQ1IQ
         S87OMvW+Aa6Lxo7yPXXED7+jLiv3u8FUzNkfi9ZqN5me1qe0YdQUKXpgtJQ0GhCZi6GA
         UG9G83rioe+JT2eItnRaUaNIeVMTglJ1M7fvWrwBnIjmGKuQzSbFBTgGwfhJRbFF1qE7
         sTU886DfZ4XjUG1y7lbmz/b80DO0ZFADNxfe9INyHzSfcu0WEod3o0lw4LEO8CDFLFy4
         EURc5+nM66vzZp/86EWrkjrO3krwynTTuWmf3e7KFmNtdPCUbl11hhSO6YlilfbeCIqc
         jqzA==
X-Gm-Message-State: AOAM53020T7C/o6iWR7fAmI0Le5VvsaAo3C/+krgCAe9qdOgNwyjHPOR
        fVKIb3aX8ia44fermU6Ej+syyQ9jlQg=
X-Google-Smtp-Source: ABdhPJyaSKRhCFYeoAmqTYwfnUhyzI36P5VeoAF2F+gxcqDiuMRTg8oFiHW6rQ7d+vdeI18WGLilDg==
X-Received: by 2002:a05:6808:654:: with SMTP id z20mr1388954oih.143.1644355034105;
        Tue, 08 Feb 2022 13:17:14 -0800 (PST)
Received: from ubuntu-21.tx.rr.com (2603-8081-140c-1a00-2501-ba3f-d39d-75da.res6.spectrum.com. [2603:8081:140c:1a00:2501:ba3f:d39d:75da])
        by smtp.googlemail.com with ESMTPSA id bh7sm2145462oib.6.2022.02.08.13.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:17:13 -0800 (PST)
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v11 00/11] Move two object pools to rxe_mcast.c
Date:   Tue,  8 Feb 2022 15:16:34 -0600
Message-Id: <20220208211644.123457-1-rpearsonhpe@gmail.com>
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

This patch series completes the separation of the mc_grp and mc_elem
object pools from rxe_pools.c and moving of their code to rxe_mcast.c.
This makes sense because these two pools are different from the other
pools as the only ones that do not share objects with rdma-core and
that use key's instead of indices to enable looking up objects. This
change will enable a significant simplification of the normal object
pools.

This patch series applies cleanly to current for-next.
commit 0d9c00117b8a57a361b27f7bd94284c94155f039 (for-next)

Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
---
v11
  Restructured the patch series to simplify it and make each patch
  simpler. Addressed some additional issues raised by Jason Gunthorpe
  in the review of that last version.
v10
  Corrected issues reported by Jason Gunthorpe
  Isolated patches 01-17 separate from the remaining patches.
  They will be submitted later
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
  RDMA/rxe: Move mcg_lock to rxe
  RDMA/rxe: Use kzmalloc/kfree for mca
  RDMA/rxe: Replace grp by mcg, mce by mca
  RDMA/rxe: Replace int num_qp by atomic_t qp_num
  RDMA/rxe: Replace pool key by rxe->mcg_tree
  RDMA/rxe: Remove key'ed object support
  RDMA/rxe: Remove mcg from rxe pools
  RDMA/rxe: Add code to cleanup mcast memory
  RDMA/rxe: Finish cleanup of rxe_mcast.c
  RDMA/rxe: For mcast copy qp list to temp array
  RDMA/rxe: Convert mca read locking to RCU

 drivers/infiniband/sw/rxe/rxe.c       |  22 +-
 drivers/infiniband/sw/rxe/rxe_loc.h   |   4 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c | 713 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.c  | 137 -----
 drivers/infiniband/sw/rxe/rxe_pool.h  |  42 +-
 drivers/infiniband/sw/rxe/rxe_recv.c  | 113 ++--
 drivers/infiniband/sw/rxe/rxe_verbs.h |  16 +-
 7 files changed, 612 insertions(+), 435 deletions(-)
 rewrite drivers/infiniband/sw/rxe/rxe_mcast.c (67%)

-- 
2.32.0

