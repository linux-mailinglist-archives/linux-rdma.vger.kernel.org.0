Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463BA59B2D5
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Aug 2022 10:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiHUItU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Aug 2022 04:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHUItT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Aug 2022 04:49:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AC324F25
        for <linux-rdma@vger.kernel.org>; Sun, 21 Aug 2022 01:49:15 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="276266519"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="276266519"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 01:49:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="637791432"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2022 01:49:13 -0700
From:   yanjun.zhu@linux.dev
To:     jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Subject: [PATCH 0/3] Fixes for syzbot problem 
Date:   Sun, 21 Aug 2022 21:16:12 -0400
Message-Id: <20220822011615.805603-1-yanjun.zhu@linux.dev>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In the link:

https://syzkaller.appspot.com/bug?id=3efca8275142fbfdde6cf77e1b18b1d5c6794d76

a rxe problem occurred. I tried to reproduce this problem in local hosts.
Finally I could reproduce this problem in local hosts.
The commit ("RDMA/rxe: Fix "kernel NULL pointer dereference" error") tries to
fix this problem.

After this syzbot problem disappeared, another problem appeared
when qp->sk failed to initialized.
The commit ("RDMA/rxe: Fix the error caused by qp->sk") tries to solve
this problem.

When I delved into the source code to solve the above problems, I found
that the member variable obj in struct rxe_task is not needed. So the
commit ("RDMA/rxe: Remove the unused variable obj") removes this
variable obj.

After the 3 commits, in locat hosts, the whole system can work well.

Zhu Yanjun (3):
  RDMA/rxe: Fix "kernel NULL pointer dereference" error
  RDMA/rxe: Fix the error caused by qp->sk
  RDMA/rxe: Remove the unused variable obj

 drivers/infiniband/sw/rxe/rxe_qp.c   | 16 ++++++++++------
 drivers/infiniband/sw/rxe/rxe_task.c |  3 +--
 drivers/infiniband/sw/rxe/rxe_task.h |  3 +--
 3 files changed, 12 insertions(+), 10 deletions(-)

-- 
2.31.1

