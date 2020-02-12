Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B29315A1F1
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 08:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgBLH1I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 02:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgBLH1I (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 02:27:08 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6CFD2073C;
        Wed, 12 Feb 2020 07:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581492427;
        bh=hK073K+SwyrKYjKY2M3MatVvIa7OTGYiMJ1AsFBK4UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v8A0hCMFv+fNvC68m5aVQpWOWhWDAHF66aM60HaOa50lYs2VTeyz8lGp8FCoyWbJ5
         2dhMaGkIjCss/xB1sybIWh0KPIHUKxZnzgetIkikHrHTv7dzX0ciPl+bDc9QFSqfLH
         19vATUoBoejlptWxWMgoNsRO7j0MYYs4g57jznOY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Daniel Jurgens <danielj@mellanox.com>,
        Erez Shitrit <erezsh@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Maor Gottlieb <maorg@mellanox.com>,
        Michael Guralnik <michaelgur@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Valentine Fatiev <valentinef@mellanox.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Zhu Yanjun <yanjunz@mellanox.com>
Subject: [PATCH rdma-rc 8/9] IB/umad: Fix kernel crash while unloading ib_umad
Date:   Wed, 12 Feb 2020 09:26:34 +0200
Message-Id: <20200212072635.682689-9-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200212072635.682689-1-leon@kernel.org>
References: <20200212072635.682689-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yonatan Cohen <yonatanc@mellanox.com>

When unloading ib_umad, remove ibdev sys file 1st before
port removal to prevent kernel oops.

ib_mad's method ibdev_show() might access a umad port
whoes ibdev field has already been NULLed when rmmod ib_umad
was issued from another shell.

Consider this scenario
	         shell-1            	shell-2
	        rmmod ib_mod    	cat /sys/devices/../ibdev
	            |           		|
	        ib_umad_kill_port()        ibdev_show()
	     port->ib_dev = NULL	dev_name(port->ib_dev)

kernel stack
PF: error_code(0x0000) - not-present page
Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
RIP: 0010:ibdev_show+0x18/0x50 [ib_umad]
RSP: 0018:ffffc9000097fe40 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffffa0441120 RCX: ffff8881df514000
RDX: ffff8881df514000 RSI: ffffffffa0441120 RDI: ffff8881df1e8870
RBP: ffffffff81caf000 R08: ffff8881df1e8870 R09: 0000000000000000
R10: 0000000000001000 R11: 0000000000000003 R12: ffff88822f550b40
R13: 0000000000000001 R14: ffffc9000097ff08 R15: ffff8882238bad58
FS:  00007f1437ff3740(0000) GS:ffff888236940000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000004e8 CR3: 00000001e0dfc001 CR4: 00000000001606e0
Call Trace:
 dev_attr_show+0x15/0x50
 sysfs_kf_seq_show+0xb8/0x1a0
 seq_read+0x12d/0x350
 vfs_read+0x89/0x140
 ksys_read+0x55/0xd0
 do_syscall_64+0x55/0x1b0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9:

Fixes: e9dd5daf884c ("IB/umad: Refactor code to use cdev_device_add()")
Signed-off-by: Yonatan Cohen <yonatanc@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/user_mad.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
index d1407fa378e8..1235ffb2389b 100644
--- a/drivers/infiniband/core/user_mad.c
+++ b/drivers/infiniband/core/user_mad.c
@@ -1312,6 +1312,9 @@ static void ib_umad_kill_port(struct ib_umad_port *port)
 	struct ib_umad_file *file;
 	int id;
 
+	cdev_device_del(&port->sm_cdev, &port->sm_dev);
+	cdev_device_del(&port->cdev, &port->dev);
+
 	mutex_lock(&port->file_mutex);
 
 	/* Mark ib_dev NULL and block ioctl or other file ops to progress
@@ -1331,8 +1334,6 @@ static void ib_umad_kill_port(struct ib_umad_port *port)
 
 	mutex_unlock(&port->file_mutex);
 
-	cdev_device_del(&port->sm_cdev, &port->sm_dev);
-	cdev_device_del(&port->cdev, &port->dev);
 	ida_free(&umad_ida, port->dev_num);
 
 	/* balances device_initialize() */
-- 
2.24.1

