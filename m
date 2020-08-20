Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717E424C7E8
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Aug 2020 00:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgHTWrO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 18:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgHTWrN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 18:47:13 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159EC061385
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id v21so140098otj.9
        for <linux-rdma@vger.kernel.org>; Thu, 20 Aug 2020 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vLBprnuZibWRTPeDxPxaxDePq08Wadcw0RshPzN+aB4=;
        b=a/zpLROBPw0nkxHZtbnYsFh2VvKhPaKy96L5O9mEq0/Sd4+yEfwn1au0qfT5MD5/Sw
         rBgtA4eJdZthFidm63nHxWfX6SiXtusb19iEe85uX72WiCnPqzYl67nCJYSdvqtaj6L9
         pWy6xU3GJXTDlmhPShUZj2VlDQBQt/3J3OMLVkXLZNynK7Rej2jaY5WNDTIrShe+LdNv
         P6tJlU5FgKQXozhmiokiRxfT4ymEkiwoGWQEIpT3b/n5IM6zG6xwFbdoZBYPjsPZNNi8
         pFqvCNwAFFVyHl44u1cVG1PLy54X0j8u5ZzB8NXXH1cMghrjp9UIgl1l4+wpZqwrgr0k
         ji+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vLBprnuZibWRTPeDxPxaxDePq08Wadcw0RshPzN+aB4=;
        b=bPOcKCfJeYwADuOIzGyFLtm7YgkDqPag9NyfQn86Y9yCWjVW9eR+YqcZiNG37TXQZX
         WMheuLk/6ULcTE0G3KhwIuHdOUMzCIvlJ+6Q/rhcVLBMi64BvR6HhDqvNTBG3LHIdCh8
         6TCzj48H17PnHtGhzYl4gXiyWTewBWro5k5rNvZRVAbScicPzXmYvwP1y4V5OTj53JwC
         G6HZC1ManFPiv+MycsyNeNVq0UtjV3DkdChv6DMfVN5lPKkGPCEEPKVAwQfptztAvprq
         mWtUDlBu22PpESgKSdI5qiQX/RrH7tNlZhMDdkbl2RjhBby5BGaYG29lONu9iQ8ioD0r
         BItw==
X-Gm-Message-State: AOAM532Jo5Gg4FjloAeg0SLbB/Qq54z+kWda2B3IlTYXTUGr6OWp6ZQ2
        WFCXPS1bcpwbf+yBqogJ/SzqPTcAQuATNw==
X-Google-Smtp-Source: ABdhPJwjkikzb2LnZYPWbMW+d/LQ4XYmKptqorllttg+pt0W8a8AT9qrLpyA63U5dx0MclkE+YExMg==
X-Received: by 2002:a9d:171:: with SMTP id 104mr12712otu.256.1597963632955;
        Thu, 20 Aug 2020 15:47:12 -0700 (PDT)
Received: from localhost ([2605:6000:8b03:f000:e2a0:5228:a0c3:36eb])
        by smtp.gmail.com with ESMTPSA id w22sm10043ooq.37.2020.08.20.15.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 15:47:12 -0700 (PDT)
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Google-Original-From: Bob Pearson <rpearson@hpe.com>
To:     linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     Bob Pearson <rpearson@hpe.com>
Subject: [PATCH v3 00/17] Memory window support for rdma_rxe
Date:   Thu, 20 Aug 2020 17:46:21 -0500
Message-Id: <20200820224638.3212-1-rpearson@hpe.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This set of patches implements the memory windows verbs, local and remote send
operations. Each of these has been tested at a basic level and regressions
tests have been run to see that basic rxe functionality is OK. The rdma-core
pyverbs memory windows test cases run correctly.

I would encourage anyone who has test cases for MWs to run them against
this code and let me know if anything crops up.

There is a matching patch for rdma-core the user space library that is required
to run user space MW applications.

The first two patches clean up checkpatch warnings for the existing rxe source
code. They can be used separately if desired.

The third and fourth patches are a prerequisite for the rest of the set but
are independant and add some WR and WC opcodes to ib_verbs.h and ib_user_verb.h.

The remaining patches implement the memory windows extensions.

Bob Pearson


Bob Pearson (17):
  rdma_rxe: Added SPDX headers to rxe source files
  rdma_rxe: Fixed style warnings
  ib_user_verbs.h: Added ib_uverbs_wc_opcode
  ib_verbs.h: Added missing IB_WR_BIND_MW opcode
  rdma_rxe: Added bind_mw parameters to rxe_send_wr
  rdma_rxe: Added stubs for alloc_mw and dealloc_mw verbs
  rdma_rxe: Separated MR and MW objects.
  rdma_rxe: Added mw object
  rdma_rxe: Extended pools to support both keys and indices
  rdma_rxe: Implemented functional alloc_mw and dealloc_mw APIs
  rdma_rxe: Address an issue with hardened user copy
  rdma_rxe: Added bind mw API stub
  rdma_rxe: Give MR and MW objects indices and keys
  rdma_rxe: Added stub for invalidate mw
  rdma_rxe: Added functional bind and invalidate MW ops
  rdma_rxe: Implemented read/write/atomic access to MW
  rdma_rxe: minor cleanups

 drivers/infiniband/sw/rxe/Makefile          |   1 +
 drivers/infiniband/sw/rxe/rxe.c             |  33 +-
 drivers/infiniband/sw/rxe/rxe.h             |  31 +-
 drivers/infiniband/sw/rxe/rxe_av.c          |  31 +-
 drivers/infiniband/sw/rxe/rxe_comp.c        |  39 +-
 drivers/infiniband/sw/rxe/rxe_cq.c          |  31 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h         |  31 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.c |  31 +-
 drivers/infiniband/sw/rxe/rxe_hw_counters.h |  31 +-
 drivers/infiniband/sw/rxe/rxe_icrc.c        |  31 +-
 drivers/infiniband/sw/rxe/rxe_loc.h         |  88 ++--
 drivers/infiniband/sw/rxe/rxe_mcast.c       |  31 +-
 drivers/infiniband/sw/rxe/rxe_mmap.c        |  31 +-
 drivers/infiniband/sw/rxe/rxe_mr.c          | 385 ++++++++---------
 drivers/infiniband/sw/rxe/rxe_mw.c          | 431 ++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_net.c         |  33 +-
 drivers/infiniband/sw/rxe/rxe_net.h         |  31 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c      |  42 +-
 drivers/infiniband/sw/rxe/rxe_opcode.h      |  32 +-
 drivers/infiniband/sw/rxe/rxe_param.h       |  42 +-
 drivers/infiniband/sw/rxe/rxe_pool.c        | 165 ++++----
 drivers/infiniband/sw/rxe/rxe_pool.h        |  69 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c          |  34 +-
 drivers/infiniband/sw/rxe/rxe_queue.c       |  31 +-
 drivers/infiniband/sw/rxe/rxe_queue.h       |  31 +-
 drivers/infiniband/sw/rxe/rxe_recv.c        |  31 +-
 drivers/infiniband/sw/rxe/rxe_req.c         | 154 +++----
 drivers/infiniband/sw/rxe/rxe_resp.c        | 196 +++++----
 drivers/infiniband/sw/rxe/rxe_srq.c         |  31 +-
 drivers/infiniband/sw/rxe/rxe_sysfs.c       |  31 +-
 drivers/infiniband/sw/rxe/rxe_task.c        |  31 +-
 drivers/infiniband/sw/rxe/rxe_task.h        |  33 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c       | 114 +++---
 drivers/infiniband/sw/rxe/rxe_verbs.h       |  97 ++---
 include/rdma/ib_verbs.h                     |  16 +-
 include/uapi/rdma/ib_user_verbs.h           |  11 +
 include/uapi/rdma/rdma_user_rxe.h           |  50 ++-
 37 files changed, 1233 insertions(+), 1328 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_mw.c

-- 
2.25.1

