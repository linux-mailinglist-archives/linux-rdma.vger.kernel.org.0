Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED26251C08
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 17:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHYPSS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 11:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHYPRs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 11:17:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A68C061574
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 08:17:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 83so2811186wme.4
        for <linux-rdma@vger.kernel.org>; Tue, 25 Aug 2020 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VvrGTVai5q1KEnc2nBuxU/mmelbDzXMEsJbVUzD0hA=;
        b=RqTvOQI1fGK+Um/Ru3QiP1P4TA+ac6h1ffR9TJUdrYK49Qp+LSdmSp68wgPmhfbkO5
         kTHq/jYdcv5iDu2JrwVDFV+q+BMagYCMHdVWHIcmT5fONlTXdMMF8CbFJWgnPzXctV6q
         NyzRCw83qh3KWmyGuLcuUs247NaLqYQxG9FRF3nYX4FkZi5PL9Ro8pQPLVkRs8PkNxH3
         ixOFgZEO5OheCUsU+KA7vs+XkCRwDBUxox6m5a++8U0Ik2tUNAXwJxHebXrSkvwHhKd2
         XRmAgC2jFABDaXzx3DmuaxqaiVKZX2IWxQdc7PJ4ZTYNW4kiom5HkT8WBlzQTzZn8xh0
         3NZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7VvrGTVai5q1KEnc2nBuxU/mmelbDzXMEsJbVUzD0hA=;
        b=gST0esCNxTBc+/TCmCcRe4hTg5aBDPSwE8WlYBDIEW+GB+HTc+3cKs43w5N55XNRWy
         WcmuuRCA9dZiCcVR5zlhWOY2xXoVeywFbSiUvppDrAI/lsCqv0c/Ycn1clba5vtq9gt5
         0hviQghofMbe135Et0qnHlNUwbA+tZHEbPd+mi2Dl8FgB0bdP9sHOT2lEs84twNIlU0X
         wMSFru626fcYt78nkVSATiK+LgpDbJcYIHFLTrkstchYh/70o9KKFYeIftvPT7ktLu0L
         2auOShBTLAv9i68FyiXZ06DY4Ri7CYeLht5lWWs0okLofP/4dKwt+4hkdEVCuimYHqLm
         mcTQ==
X-Gm-Message-State: AOAM530xPrWIDLiKBhAOyXwnafXv2FdycFb3K2MvjSAfxKQeXmZGInzR
        /bYE1J/abnL35XRqF6iRnJd8o1O63S4=
X-Google-Smtp-Source: ABdhPJwvGFy/ffyPJM88zODD51E2qo9iV7AgBI5T7xKtGuXokGPJAdfUt+mHGqAI8ZW7jIUZBSGXkA==
X-Received: by 2002:a1c:f20e:: with SMTP id s14mr898020wmc.23.1598368666017;
        Tue, 25 Aug 2020 08:17:46 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([37.142.0.228])
        by smtp.gmail.com with ESMTPSA id k24sm6146211wmj.19.2020.08.25.08.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 08:17:45 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH v4 for-rc] RDMA/rxe: Fix panic when calling kmem_cache_create()
Date:   Tue, 25 Aug 2020 18:17:25 +0300
Message-Id: <20200825151725.254046-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To avoid the following kernel panic when calling kmem_cache_create()
with a NULL pointer from pool_cache(), Block the rxe_param_set_add()
from running if the rdma_rxe module is not initialized.

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
 drivers/infiniband/sw/rxe/rxe.c       | 4 ++++
 drivers/infiniband/sw/rxe/rxe.h       | 2 ++
 drivers/infiniband/sw/rxe/rxe_sysfs.c | 5 +++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 907203afbd99..77f2c7cd1216 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -40,6 +40,8 @@ MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
 MODULE_DESCRIPTION("Soft RDMA transport");
 MODULE_LICENSE("Dual BSD/GPL");
 
+bool rxe_initialized;
+
 /* free resources for a rxe device all objects created for this device must
  * have been destroyed
  */
@@ -315,6 +317,7 @@ static int __init rxe_module_init(void)
 		return err;
 
 	rdma_link_register(&rxe_link_ops);
+	rxe_initialized = true;
 	pr_info("loaded\n");
 	return 0;
 }
@@ -326,6 +329,7 @@ static void __exit rxe_module_exit(void)
 	rxe_net_exit();
 	rxe_cache_exit();
 
+	rxe_initialized = false;
 	pr_info("unloaded\n");
 }
 
diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
index fb07eed9e402..cae1b0a24c85 100644
--- a/drivers/infiniband/sw/rxe/rxe.h
+++ b/drivers/infiniband/sw/rxe/rxe.h
@@ -67,6 +67,8 @@
 
 #define RXE_ROCE_V2_SPORT		(0xc000)
 
+extern bool rxe_initialized;
+
 static inline u32 rxe_crc32(struct rxe_dev *rxe,
 			    u32 crc, void *next, size_t len)
 {
diff --git a/drivers/infiniband/sw/rxe/rxe_sysfs.c b/drivers/infiniband/sw/rxe/rxe_sysfs.c
index ccda5f5a3bc0..2af31d421bfc 100644
--- a/drivers/infiniband/sw/rxe/rxe_sysfs.c
+++ b/drivers/infiniband/sw/rxe/rxe_sysfs.c
@@ -61,6 +61,11 @@ static int rxe_param_set_add(const char *val, const struct kernel_param *kp)
 	struct net_device *ndev;
 	struct rxe_dev *exists;
 
+	if (!rxe_initialized) {
+		pr_err("Module parameters are not supported, use rdma link add or rxe_cfg\n");
+		return -EAGAIN;
+	}
+
 	len = sanitize_arg(val, intf, sizeof(intf));
 	if (!len) {
 		pr_err("add: invalid interface name\n");
-- 
2.26.2

