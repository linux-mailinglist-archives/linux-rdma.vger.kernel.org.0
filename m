Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D74D242891
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Aug 2020 13:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHLLPB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Aug 2020 07:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgHLLPA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Aug 2020 07:15:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AAFC06174A
        for <linux-rdma@vger.kernel.org>; Wed, 12 Aug 2020 04:15:00 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f12so1614169wru.13
        for <linux-rdma@vger.kernel.org>; Wed, 12 Aug 2020 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tsxv/bhnV0/y7Dl+QxJkO0cCc38hF+OOCr7UlqYNsXw=;
        b=Q9Fww4N7veutTa1AVnGEKdmHNJY9i+Y1piK9IZ0S6804B8fFY/D8BiyLXk/3GXLBGi
         04lAJvulY//utulumSnc61EUd2P6Fq4m79jTgbpDWrpZoAmKHSCBxUSib+nm0Io/AsFr
         otXuIS3sjRq5wa/y6wx7FEAh0GHANDb88+eqPFNFum0XMs6jmZWXaQ+yvjuUdgVqTs1O
         oB2iMeNApfBTkRAH1WVzbCQYL9b/ewkuUMUNnRS9Zkqt9oWMs7jBbbzBg25VKDYldbbk
         UdKxJzjTQdLNRCeXTqKs+In/6ClEpZYmOD7DZCPiIjqobPVnRgIe3ODGhuGXaYhr5UT3
         w//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tsxv/bhnV0/y7Dl+QxJkO0cCc38hF+OOCr7UlqYNsXw=;
        b=W6LUvcjVmD6QRBSyFIFS4d4M5IhvHtaPS9Yc31sBwTus7mxePVDNesUvTCf+oQFpbm
         epHEbaevMjm/n/wGtwvSUeNn0zHqWI5W2V1MwKA4mMuGWneP+QA7tzw2iNyRIeHHw/xP
         PsOsZ27UOjsw7LDtky/Zts9dU1LeTf5bgwVJkFgllUBZvaE2drAPTRYLH1d9zrW2lEmh
         il+byWPfvyv0o8yq7UehtSGXDsOHWyj/iH6GeMGvIlowYSrDtpZ2dwMX5tY9WolR/++9
         y8C8UUmnqd3IYpvEXu/XsKUXE4xAVIvWYtXbWSiQ2Sp0fHL9m/J7DaYoYDjUXWMFz+Pq
         9kIg==
X-Gm-Message-State: AOAM5331XPkexuS6WCGRlRXGCpeUzzyOEMebLAX1r8yrAGGIEyzfcg7G
        jbZP+0czV7uLzQVHGO/qoo3xagY1c08=
X-Google-Smtp-Source: ABdhPJyQa6rokaW7VU8AgCSQdFeGPBkv8zKofqJf6klNw8PbgwxRDh2/cTjLQ7M+/nH7otAUOtBNcA==
X-Received: by 2002:a5d:4d4b:: with SMTP id a11mr32812232wru.230.1597230898063;
        Wed, 12 Aug 2020 04:14:58 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.6.87])
        by smtp.gmail.com with ESMTPSA id g70sm3423997wmg.24.2020.08.12.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 04:14:56 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/rxe: Fix panic when calling kmem_cache_create()
Date:   Wed, 12 Aug 2020 14:14:47 +0300
Message-Id: <20200812111447.256822-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To avoid the following kernel panic when calling kmem_cache_create()
with a NULL pointer from pool_cache(), move the rxe_cache_init() to the
context of device creation.

 BUG: unable to handle kernel NULL pointer dereference at 000000000000000b
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP NOPTI
 CPU: 4 PID: 8512 Comm: modprobe Kdump: loaded Not tainted 4.18.0-231.el8.x86_64 #1
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 10/02/2018
 RIP: 0010:kmem_cache_alloc+0xd1/0x1b0
 Code: 8b 57 18 45 8b 77 1c 48 8b 5c 24 30 0f 1f 44 00 00 5b 48 89 e8 5d 41 5c 41 5d 41 5e 41 5f c3 81 e3 00 00 10 00 75 0e 4d 89 fe <41> f6 47 0b 04 0f 84 6c ff ff ff 4c 89 ff e8 cc da 01 00 49 89 c6
 RSP: 0018:ffffa2b8c773f9d0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000005
 RDX: 0000000000000004 RSI: 00000000006080c0 RDI: 0000000000000000
 RBP: ffff8ea0a8634fd0 R08: ffffa2b8c773f988 R09: 00000000006000c0
 R10: 0000000000000000 R11: 0000000000000230 R12: 00000000006080c0
 R13: ffffffffc0a97fc8 R14: 0000000000000000 R15: 0000000000000000
 FS:  00007f9138ed9740(0000) GS:ffff8ea4ae800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000000000b CR3: 000000046d59a000 CR4: 00000000003406e0
 Call Trace:
  rxe_alloc+0xc8/0x160 [rdma_rxe]
  rxe_get_dma_mr+0x25/0xb0 [rdma_rxe]
  __ib_alloc_pd+0xcb/0x160 [ib_core]
  ib_mad_init_device+0x296/0x8b0 [ib_core]
  add_client_context+0x11a/0x160 [ib_core]
  enable_device_and_get+0xdc/0x1d0 [ib_core]
  ib_register_device+0x572/0x6b0 [ib_core]
  ? crypto_create_tfm+0x32/0xe0
  ? crypto_create_tfm+0x7a/0xe0
  ? crypto_alloc_tfm+0x58/0xf0
  rxe_register_device+0x19d/0x1c0 [rdma_rxe]
  rxe_net_add+0x3d/0x70 [rdma_rxe]
  ? dev_get_by_name_rcu+0x73/0x90
  rxe_param_set_add+0xaf/0xc0 [rdma_rxe]
  parse_args+0x179/0x370
  ? ref_module+0x1b0/0x1b0
  load_module+0x135e/0x17e0
  ? ref_module+0x1b0/0x1b0
  ? __do_sys_init_module+0x13b/0x180
  __do_sys_init_module+0x13b/0x180
  do_syscall_64+0x5b/0x1a0
  entry_SYSCALL_64_after_hwframe+0x65/0xca
 RIP: 0033:0x7f9137ed296e

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe.c       | 14 +++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.c  |  3 +++
 drivers/infiniband/sw/rxe/rxe_sysfs.c |  7 +++++++
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 5642eefb4ba1..60d5086dd34d 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -318,6 +318,13 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
 		goto err;
 	}
 
+	/* initialize slab caches for managed objects */
+	err = rxe_cache_init();
+	if (err) {
+		pr_err("unable to init object pools\n");
+		goto err;
+	}
+
 	err = rxe_net_add(ibdev_name, ndev);
 	if (err) {
 		pr_err("failed to add %s\n", ndev->name);
@@ -336,13 +343,6 @@ static int __init rxe_module_init(void)
 {
 	int err;
 
-	/* initialize slab caches for managed objects */
-	err = rxe_cache_init();
-	if (err) {
-		pr_err("unable to init object pools\n");
-		return err;
-	}
-
 	err = rxe_net_init();
 	if (err)
 		return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
index fbcbac52290b..06c6d1f835b7 100644
--- a/drivers/infiniband/sw/rxe/rxe_pool.c
+++ b/drivers/infiniband/sw/rxe/rxe_pool.c
@@ -139,6 +139,9 @@ int rxe_cache_init(void)
 	for (i = 0; i < RXE_NUM_TYPES; i++) {
 		type = &rxe_type_info[i];
 		size = ALIGN(type->size, RXE_POOL_ALIGN);
+		if (type->cache)
+			continue;
+
 		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
 			type->cache =
 				kmem_cache_create(type->name, size,
diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
index ccda5f5a3bc0..d0af48ba0110 100644
--- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
+++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
@@ -81,6 +81,13 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
 		goto err;
 	}
 
+	/* initialize slab caches for managed objects */
+	err = rxe_cache_init();
+	if (err) {
+		pr_err("unable to init object pools\n");
+		goto err;
+	}
+
 	err = rxe_net_add("rxe%d", ndev);
 	if (err) {
 		pr_err("failed to add %s\n", intf);
-- 
2.25.4

