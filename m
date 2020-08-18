Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3324875F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 16:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHROZZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 10:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgHROZX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 10:25:23 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF94C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 07:25:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so17181146wme.4
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMffhREIHo6iRhkBTIlnTIWU2sSlzmxeayEOEAG+V+Q=;
        b=Rk36AyqpTD/+OYMWuzeL2TJQtlVDnbB+OOuqYnLI1R/NPfNSxkvjOi8nORVOJ33FPE
         lf4ufcNvZP0k858aS5ZMg4T/cxYk905FeF8lVqMjFdGGD8Xro1F5BHf6XK38ZwvG0kqc
         Uhw6p4TcmTz2C1UTkd3eeCUIC/crgkla0KapFoHPV9zARCkr6r4PE61bwoOMqqboDiFi
         oqdql9ySMS8p9l6SnypJXN4Tx8X+w7nYJciQHmnUygKKopvVSpbPFahGBO2pPLyIfiEH
         ZK23zXnIhuN/G0m7Ls+7nZHWgBuAJj8cZXvXKL/ZiPG3uvCFfcIT0DmVZuDqQTtIRp4U
         E1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LMffhREIHo6iRhkBTIlnTIWU2sSlzmxeayEOEAG+V+Q=;
        b=MgOHsykGlRDImBY8pJVe4CTg+WYcy0WXm6BBZWfzPRM5FattHpm6cLO5QWhA4pjfmP
         agQeEfb7Vruo+KxaWbSEe5ckb8sndIP55jus34v4FIMGdZ9gIUK3W1gIvPJuwZqmUMnJ
         K8dlCM4VG6OFM4OmZtWpbW5EWnqwOmmcGXuaW/mcUxxCMovuVOV0iNXxE2AF1DIdfAIC
         0A2njW21JD9crdqvtshhQ0yzHnkIQPkIMenZfZ88tedQkVei3pTSLaJ914M6+CBJtpau
         AzxAW5xBDBEB4VVD8Kepw8DOK8aabjR9ntYjpJQ3nT2q8iilV3NK2me9uXjWPQANT9xz
         eNJg==
X-Gm-Message-State: AOAM530zrvmYLI7bDWrN/gNyIAniM4vAimbUuY0PR2YrM1gUv1YaxZC2
        2gVRjEOGAesePWsjQ8XHA1kx5Sm0hXo=
X-Google-Smtp-Source: ABdhPJxJp/8qN8qh7JMJUiPJfVsEyAOBucT4pJGSq9HJ/giQuF1zHVta3WenKVpr7bOQcE1biasDnw==
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr221650wmb.16.1597760721920;
        Tue, 18 Aug 2020 07:25:21 -0700 (PDT)
Received: from kheib-workstation.redhat.com ([77.137.115.29])
        by smtp.gmail.com with ESMTPSA id 3sm116825wms.36.2020.08.18.07.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:21 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH v2 for-rc] RDMA/rxe: Fix panic when calling kmem_cache_create()
Date:   Tue, 18 Aug 2020 17:25:04 +0300
Message-Id: <20200818142504.917186-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To avoid the following kernel panic when calling kmem_cache_create()
with a NULL pointer from pool_cache(), move the rxe_cache_init() to the
context of device initialization.

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
v2: Call rxe_cache_init() from rxe_init().
---
 drivers/infiniband/sw/rxe/rxe.c      | 14 +++++++-------
 drivers/infiniband/sw/rxe/rxe_pool.c |  3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 5642eefb4ba1..c80f7c183957 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -252,6 +252,13 @@ static int rxe_init(struct rxe_dev *rxe)
 	/* init default device parameters */
 	rxe_init_device_param(rxe);
 
+	/* initialize slab caches for managed objects */
+	err = rxe_cache_init();
+	if (err) {
+		pr_err("unable to init object pools\n");
+		return err;
+	}
+
 	err = rxe_init_ports(rxe);
 	if (err)
 		goto err1;
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
-- 
2.26.2

