Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279EF48419C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 13:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiADMV7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 07:21:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57052 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiADMV7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 07:21:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31C226127D
        for <linux-rdma@vger.kernel.org>; Tue,  4 Jan 2022 12:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10CCC36AE9;
        Tue,  4 Jan 2022 12:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641298918;
        bh=OhHqHVVqHWzizp1IiXNBfa5EdgbZjAGRfXTn68Z6azY=;
        h=From:To:Cc:Subject:Date:From;
        b=JncInV/NffatHTwvwqEOjsZ9QSBfAx6zy5RNb5IKdpkfh+gt8DP5YVdZRBShIHmx6
         wRhohnyB8MzWI4rbIVNNDzsyte+53CmQG8qXbitFjKn8SeaMpufgllY/PoXnnPlKqf
         MY4/EA++iDcKgGbj84Jjrn242a+7vrIgA3PmeSYRqU6gpYD9KMEY+K3sRlhKSHXQvE
         eSpdmQHr2qcaxqaWygY7Img9N3mSlbyYG+sXaZleQ2lfshzMexOeTCfRz4fcKsBT/B
         ni+JZLtc2Oo+6cTMOYhfXatQJRM01e4fcHGsqxdRiRC1dYq+UtlIEk5JwQF4avwDxX
         QHQXFXFWyHtuQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        syzbot+6d532fa8f9463da290bc@syzkaller.appspotmail.com
Subject: [PATCH rdma-rc] RDMA/core: Don't infoleak GRH fields
Date:   Tue,  4 Jan 2022 14:21:52 +0200
Message-Id: <0e9dd51f93410b7b2f4f5562f52befc878b71afa.1641298868.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

If dst->is_global field is not set, the GRH fields are not cleared
and the following infoleak is reported.

=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:121 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
 instrument_copy_to_user include/linux/instrumented.h:121 [inline]
 _copy_to_user+0x1c9/0x270 lib/usercopy.c:33
 copy_to_user include/linux/uaccess.h:209 [inline]
 ucma_init_qp_attr+0x8c7/0xb10 drivers/infiniband/core/ucma.c:1242
 ucma_write+0x637/0x6c0 drivers/infiniband/core/ucma.c:1732
 vfs_write+0x8ce/0x2030 fs/read_write.c:588
 ksys_write+0x28b/0x510 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __ia32_sys_write+0xdb/0x120 fs/read_write.c:652
 do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
 __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
 do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
 do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Local variable resp created at:
 ucma_init_qp_attr+0xa4/0xb10 drivers/infiniband/core/ucma.c:1214
 ucma_write+0x637/0x6c0 drivers/infiniband/core/ucma.c:1732

Bytes 40-59 of 144 are uninitialized
Memory access of size 144 starts at ffff888167523b00
Data copied to user address 0000000020000100

CPU: 1 PID: 25910 Comm: syz-executor.1 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
=====================================================

Fixes: 4ba66093bdc6 ("IB/core: Check for global flag when using ah_attr")
Reported-by: syzbot+6d532fa8f9463da290bc@syzkaller.appspotmail.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_marshall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/uverbs_marshall.c b/drivers/infiniband/core/uverbs_marshall.c
index b8d715c68ca4..11a080646916 100644
--- a/drivers/infiniband/core/uverbs_marshall.c
+++ b/drivers/infiniband/core/uverbs_marshall.c
@@ -66,7 +66,7 @@ void ib_copy_ah_attr_to_user(struct ib_device *device,
 	struct rdma_ah_attr *src = ah_attr;
 	struct rdma_ah_attr conv_ah;
 
-	memset(&dst->grh.reserved, 0, sizeof(dst->grh.reserved));
+	memset(&dst->grh, 0, sizeof(dst->grh));
 
 	if ((ah_attr->type == RDMA_AH_ATTR_TYPE_OPA) &&
 	    (rdma_ah_get_dlid(ah_attr) > be16_to_cpu(IB_LID_PERMISSIVE)) &&
-- 
2.33.1

