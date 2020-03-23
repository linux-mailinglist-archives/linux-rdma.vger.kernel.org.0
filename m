Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FA818F3A2
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2020 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgCWL2G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Mar 2020 07:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbgCWL2G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Mar 2020 07:28:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 501F3206F9;
        Mon, 23 Mar 2020 11:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584962886;
        bh=93NYenk8ojVDz3sbRwUUBMs/JT5oLNI9JE4lWCt3GxQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LzphApIAUCTGIe3EP8ILZEr2EVwiHI8osN2QtK5rOp+0GMZFwsxeN2XHtkppYDNma
         w2g6KKzenclGmlmFYbKzzElmeKRT55a/vBQ9nMILuMa9VtreWZNNXEOcv8EyqphM2A
         GnCLW9bFIepIvxa2d5NheGCAGKH9APS9PbfF1Myo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Zhu Yanjun <yanjunz@mellanox.com>, Amir Vadai <amirv@mellanox.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>, linux-rdma@vger.kernel.org,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next] RDMA/rxe: Set sys_image_guid to be aligned with HW IB devices
Date:   Mon, 23 Mar 2020 13:28:00 +0200
Message-Id: <20200323112800.1444784-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjunz@mellanox.com>

The RXE driver doesn't set sys_image_guid and user space applications
see zeros. This causes to pyverbs tests to fail with the following
traceback, because the IBTA spec requires to have valid sys_image_guid.

 Traceback (most recent call last):
   File "./tests/test_device.py", line 51, in test_query_device
     self.verify_device_attr(attr)
   File "./tests/test_device.py", line 74, in verify_device_attr
     assert attr.sys_image_guid != 0

In order to fix it, set sys_image_guid to be equal to node_guid.

Before:
5: rxe0: ... node_guid 5054:00ff:feaa:5363 sys_image_guid
0000:0000:0000:0000

After:
5: rxe0: ... node_guid 5054:00ff:feaa:5363 sys_image_guid
5054:00ff:feaa:5363

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Zhu Yanjun <yanjunz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/sw/rxe/rxe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 0946a301a5c5..4afdd2e20883 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -103,6 +103,8 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_fast_reg_page_list_len	= RXE_MAX_FMR_PAGE_LIST_LEN;
 	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
 	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
+	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
+			rxe->ndev->dev_addr);
 
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 }
-- 
2.24.1

