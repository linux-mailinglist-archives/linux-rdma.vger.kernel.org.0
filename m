Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F9276BB
	for <lists+linux-rdma@lfdr.de>; Thu, 23 May 2019 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfEWHNE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 May 2019 03:13:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39954 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfEWHNE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 May 2019 03:13:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id f10so4962598wre.7
        for <linux-rdma@vger.kernel.org>; Thu, 23 May 2019 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WouWHldll0pQpfHcB0kjtwl8nuFlSYGSdnKWunHRRR0=;
        b=Et/8A9jL/JwtDRunHqIhy+Gff1GQ/ZVSHCYhB5CleGOgkTU8Id7ccT9Nhu0gRAmDrg
         FNCRdpuNOpOf7MvJyqmZD9aNyIdTe1Gicptw9kSA8o8R25ubgJTgngUx4dLnhQnchWjQ
         LxYTj4Ario/jTCzxOyJHbfUffC5mrmSAPWl2C+9MDcQ/MarN++WLofMk7UtZ33HsdGbB
         KCuIxrJFV7/kvQ2EAMm33uJcbkzRO/IlpdcjWsJlDtuxlt3XfkoJzMSTcPGrDw+jMWl3
         mvZ464DofMVLYavSCu9MkNe1s6dqMO2ndOnt0euZP2BGEgwX/Y4NysOrbdVQtkByC3Lu
         AQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WouWHldll0pQpfHcB0kjtwl8nuFlSYGSdnKWunHRRR0=;
        b=cWyehbL5+HE8bYaFdkXszrzML8zQOoP/QuQovBv3NNriwKkL9HSFXC/0MbvAevIIO3
         9TUW93FvBLCiph4JgNmAodODfd5tDSjFXOly0RAIH61imJCWH6h3QiPyrpoZyFXiBkAb
         j6o83m1dMP4B6dHnQRGYpU33IbNewRARkMkC0wB1pTM2+0ka070B0dNInYxxlo+pL1hM
         lWDO40stViDnYdbOPwK5a4Xdw0vZS2DzjNYHV+LF429YDDv9mpfelgXyhZDFxxnUMc5Q
         3jlT03WqYWraBsMd5x2smCVitUQj1JBXGwoIZtmL5cEHCDq0TQFyr9rAgC9IpDkuh+UT
         qHDA==
X-Gm-Message-State: APjAAAW7cbEO8mefSI4J6LUF884YQssET+vOuhjohbVOTG867uPP9D+u
        TO2Olyxyi8Zf3/Jv73ZUwJCwUbNikxs=
X-Google-Smtp-Source: APXvYqxEXqeYNqwtODQd1emtwQC9Wrq+Za3nq/92SGJK08jLU1JraXYb3QHk2RcgHP5+0UZTd6AZPw==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr44673105wrq.199.1558595582022;
        Thu, 23 May 2019 00:13:02 -0700 (PDT)
Received: from kheib-workstation.redhat.com (bzq-79-181-8-139.red.bezeqint.net. [79.181.8.139])
        by smtp.gmail.com with ESMTPSA id t66sm13477693wmf.39.2019.05.23.00.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 00:13:01 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/core: Fix panic when port_data isn't initialized
Date:   Thu, 23 May 2019 10:12:51 +0300
Message-Id: <20190523071251.7931-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This happens if assign_name() return failure when called from
ib_register_device(), that will lead to the following panic in every
time that someone touches the port_data's data members.

All the functions that touch the port_data during teardown are called
from ib_device_release() except free_netdevs() that called from multiple
contexts, that's why the check had to be in both of them.

BUG: unable to handle kernel NULL pointer dereference at 00000000000000c0
PGD 0 P4D 0
Oops: 0002 [#1] SMP PTI
CPU: 19 PID: 1994 Comm: systemd-udevd Not tainted 5.1.0-rc5+ #1
Hardware name: HP ProLiant DL360p Gen8, BIOS P71 12/20/2013
RIP: 0010:_raw_spin_lock_irqsave+0x1e/0x40
Code: 85 ff 66 2e 0f 1f 84 00 00 00 00 00 66 66 66 66 90 53 9c 58 66 66 90
66 90 48 89 c3 fa 66 66 90 66 66 90 31 c0 ba 01 00 00 00 <f0> 0f b1 17 0f
94 c2 84 d2 74 05 48 89 d8 5b c3 89 c6 e8 b4 85 8a
RSP: 0018:ffffa8d7079a7c08 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000202 RCX: ffffa8d7079a7bf8
RDX: 0000000000000001 RSI: ffff93607c990000 RDI: 00000000000000c0
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffffc08c4dd8
R10: 0000000000000000 R11: 0000000000000001 R12: 00000000000000c0
R13: ffff93607c990000 R14: ffffffffc05a9740 R15: ffffa8d7079a7e98
FS:  00007f1c6ee438c0(0000) GS:ffff93609f6c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000c0 CR3: 0000000819fca002 CR4: 00000000000606e0
Call Trace:
 free_netdevs+0x4d/0xe0 [ib_core]
 ib_dealloc_device+0x51/0xb0 [ib_core]
 __mlx5_ib_add+0x5e/0x70 [mlx5_ib]
 mlx5_add_device+0x57/0xe0 [mlx5_core]
 mlx5_register_interface+0x85/0xc0 [mlx5_core]
 ? 0xffffffffc0474000
 do_one_initcall+0x4e/0x1d4
 ? _cond_resched+0x15/0x30
 ? kmem_cache_alloc_trace+0x15f/0x1c0
 do_init_module+0x5a/0x218
 load_module+0x186b/0x1e40
 ? m_show+0x1c0/0x1c0
 __do_sys_finit_module+0x94/0xe0
 do_syscall_64+0x5b/0x180
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 8ceb1357b337 ("RDMA/device: Consolidate ib_device per_port data into one place")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/core/device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 78dc07c6ac4b..788bd56b6694 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -472,6 +472,9 @@ static void ib_device_release(struct device *device)
 {
 	struct ib_device *dev = container_of(device, struct ib_device, dev);
 
+	if (!dev->port_data)
+		return;
+
 	free_netdevs(dev);
 	WARN_ON(refcount_read(&dev->refcount));
 	ib_cache_release_one(dev);
@@ -1935,6 +1938,9 @@ static void free_netdevs(struct ib_device *ib_dev)
 	unsigned long flags;
 	unsigned int port;
 
+	if (!ib_dev->port_data)
+		return;
+
 	rdma_for_each_port (ib_dev, port) {
 		struct ib_port_data *pdata = &ib_dev->port_data[port];
 		struct net_device *ndev;
-- 
2.20.1

