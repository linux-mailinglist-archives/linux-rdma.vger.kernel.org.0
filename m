Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0995353825
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Apr 2021 14:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhDDMzW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Apr 2021 08:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhDDMzW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 4 Apr 2021 08:55:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B3C061756
        for <linux-rdma@vger.kernel.org>; Sun,  4 Apr 2021 05:55:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x16so8670357wrn.4
        for <linux-rdma@vger.kernel.org>; Sun, 04 Apr 2021 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T3qEaaar+5aK8CBlB8rHFlEgdqEChsG5ClL+Hh3GHwk=;
        b=qs6KiaRK7TuJxxhdge1ADGPjaxqKQos2eh0iUil2GuksXQtQ95AoVruavn2OWmW4IW
         jQMV7gp3nHTq6BDki6+FgwSD8GnUJKB8S6FnLdCGPo1UmONJyqAoOVG4JnU3ac1bbpaQ
         E62GOaf4GCE0YMOlW0YtY19rpj7m5e+1kSHwxIjx7sysYOC+S2S7BGxycUzUIMID1G2z
         /PKm8rM1LmzM0w/cz8p+lUrnAcvPyyCMDBiCN+g08PhynOXQWLreAOs2L5UZhiVgP+OA
         EfW1MFb+TU4nIbGf+r6Rt8JHxQhvO86g/zq1MpYMrt+G8OhBAAtlqUQk/qBjKcVtpD8V
         DD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T3qEaaar+5aK8CBlB8rHFlEgdqEChsG5ClL+Hh3GHwk=;
        b=QCaFGx8kKgI33nDZsr1cH4smI2qNdFFCmivDuVDIlJFQn0fpSEWRgJDsERLS2S7Ghq
         awrgOwkFGMfspFjNkkJFi0hxlmLsovLTsNXlgdeshBOCV46HjFN002VOq94R2GDRxM51
         4i/H/9KzvP7vY6RJQyzP+VCO1rXmm1+86dR/U5lBfDxcM2zYAMEloC7XqoK+ygJqUPNc
         DvqfJbhb9kPJHmgR5xdcCF6Yvo2AZLSkM7OaVs2spNegf0uJBYcBQgf/NDMvCkvpLMXg
         8xvfLpb+02z0MOWk1uHTWQYJUyHMM3LAHPvl1XuY1si5PNqHcU713pjmWoNdrrRcxuy7
         zbxA==
X-Gm-Message-State: AOAM533zpyAl9ru0GcU52GwjENUSKw80ssjuMgX5Gw4q3DCqRYkxNXTE
        sYPQkoi/sVk7fgi28M2llvau6I+ju68HhA==
X-Google-Smtp-Source: ABdhPJzMI/c5b/TS6U5Bc5U+eRDi2yWnqq0qHXWd34I9NftDDHfA61BWHL8NiDqNj6JvTGwRdzMndA==
X-Received: by 2002:adf:e603:: with SMTP id p3mr24856589wrm.360.1617540916169;
        Sun, 04 Apr 2021 05:55:16 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-180-8-191.red.bezeqint.net. [79.180.8.191])
        by smtp.gmail.com with ESMTPSA id s9sm21198351wmh.31.2021.04.04.05.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 05:55:15 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/qedr: Fix kernel panic when trying to access recv_cq
Date:   Sun,  4 Apr 2021 15:55:01 +0300
Message-Id: <20210404125501.154789-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As INI QP does not require a recv_cq, avoid the following null pointer
dereference by checking if the qp_type is not INI before trying to
extract the recv_cq.

BUG: kernel NULL pointer dereference, address: 00000000000000e0
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 0 PID: 54250 Comm: mpitests-IMB-MP Not tainted 5.12.0-rc5 #1
 Hardware name: Dell Inc. PowerEdge R320/0KM5PX, BIOS 2.7.0 08/19/2019
 RIP: 0010:qedr_create_qp+0x378/0x820 [qedr]
 Code: 02 00 00 50 e8 29 d4 a9 d1 48 83 c4 18 e9 65 fe ff ff 48 8b 53 10 48 8b 43 18 44 8b 82 e0 00 00 00 45 85 c0 0f 84 10 74 00 00 <8b> b8 e0 00 00 00 85 ff 0f 85 50 fd ff ff e9 fd 73 00 00 48 8d bd
 RSP: 0018:ffff9c8f056f7a70 EFLAGS: 00010202
 RAX: 0000000000000000 RBX: ffff9c8f056f7b58 RCX: 0000000000000009
 RDX: ffff8c41a9744c00 RSI: ffff9c8f056f7b58 RDI: ffff8c41c0dfa280
 RBP: ffff8c41c0dfa280 R08: 0000000000000002 R09: 0000000000000001
 R10: 0000000000000000 R11: ffff8c41e06fc608 R12: ffff8c4194052000
 R13: 0000000000000000 R14: ffff8c4191546070 R15: ffff8c41c0dfa280
 FS:  00007f78b2787b80(0000) GS:ffff8c43a3200000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000000000e0 CR3: 00000001011d6002 CR4: 00000000001706f0
 Call Trace:
  ib_uverbs_handler_UVERBS_METHOD_QP_CREATE+0x4e4/0xb90 [ib_uverbs]
  ? ib_uverbs_cq_event_handler+0x30/0x30 [ib_uverbs]
  ib_uverbs_run_method+0x6f6/0x7a0 [ib_uverbs]
  ? ib_uverbs_handler_UVERBS_METHOD_QP_DESTROY+0x70/0x70 [ib_uverbs]
  ? __cond_resched+0x15/0x30
  ? __kmalloc+0x5a/0x440
  ib_uverbs_cmd_verbs+0x195/0x360 [ib_uverbs]
  ? xa_load+0x6e/0x90
  ? cred_has_capability+0x7c/0x130
  ? avc_has_extended_perms+0x17f/0x440
  ? vma_link+0xae/0xb0
  ? vma_set_page_prot+0x2a/0x60
  ? mmap_region+0x298/0x6c0
  ? do_mmap+0x373/0x520
  ? selinux_file_ioctl+0x17f/0x220
  ib_uverbs_ioctl+0xa7/0x110 [ib_uverbs]
  __x64_sys_ioctl+0x84/0xc0
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f78b120262b

Fixes: 06e8d1df46ed ("RDMA/qedr: Add support for user mode XRC-SRQ's")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 0eb6a7a618e0..9ea542270ed4 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -1244,7 +1244,8 @@ static int qedr_check_qp_attrs(struct ib_pd *ibpd, struct qedr_dev *dev,
 	 * TGT QP isn't associated with RQ/SQ
 	 */
 	if ((attrs->qp_type != IB_QPT_GSI) && (dev->gsi_qp_created) &&
-	    (attrs->qp_type != IB_QPT_XRC_TGT)) {
+	    (attrs->qp_type != IB_QPT_XRC_TGT) &&
+	    (attrs->qp_type != IB_QPT_XRC_INI)) {
 		struct qedr_cq *send_cq = get_qedr_cq(attrs->send_cq);
 		struct qedr_cq *recv_cq = get_qedr_cq(attrs->recv_cq);
 
-- 
2.26.3

