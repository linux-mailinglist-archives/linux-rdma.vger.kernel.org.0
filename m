Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B94743D358
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Oct 2021 22:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbhJ0U5f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 27 Oct 2021 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240812AbhJ0U5f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 27 Oct 2021 16:57:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5A9C061570
        for <linux-rdma@vger.kernel.org>; Wed, 27 Oct 2021 13:55:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s14so3398479wrb.3
        for <linux-rdma@vger.kernel.org>; Wed, 27 Oct 2021 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IW2eGfdIHmDCqJ5qCfXqkepVtjSNDX1Q5BfyH0jo9dc=;
        b=fddbyTsU7njwVYzzZ30bjXlqd86PMy5tBgUQlcHa0hSLqFaKDhQBjXoljCHw6og+OE
         zM35omHQkMcTIzh5k0aI3AGPPIw+J08T8gspAwkNmPU0ykmXY122hNpxYmFRAYI56Mq0
         QL/6BzDKb6dvu3qt09ruOq+WMg0hPCbNQ3XTiDFKCIGw3tDGbKRzOHcfsIO+TkvpPDxF
         bXliZwyFuBdhEFA3/8uTrP7yJ1ghfayrgf86P57HlFbOdMYpfMH4kN9IVDs/tkV7q1Cu
         DGAOaziOiBBh9syzB6boLj28WKwS+QiEdCN/tzFozrwZ62EaCLCgXbnilbrEqN7kNZRu
         VZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IW2eGfdIHmDCqJ5qCfXqkepVtjSNDX1Q5BfyH0jo9dc=;
        b=Au7QsNdKnHShe65+XcRKyeEQQkmIFz+msZsrqyWjsgu5mDokf5DpW5Y7ffIS3IfQUP
         37w5Kze+HndpyZQi7LKEvdU93Dl5I9gppnQ1OWX1tdt+ClEwH74JeewEFdP2NF2mgFJD
         PeSrTzylJj6ZyY99iDHpHR02rTKX+OUDjNvM0LgqMCYNymEsI8z4VqlCoYHFW0GoU2pu
         giqBDeaK53XjuuA4NfTgPViPuf0NbZ0VfJvx+S2RVWsAFq5GCDrvKp19m3TK4Qi3nXAa
         pG8lyYyCZ9Lg0SnmWejs89a/yyYvJvwARsaTBRkpT0l8N/fKmKEHMr/X5BN2oFLa7Lo7
         xYug==
X-Gm-Message-State: AOAM53221AefJYnrJQqVVoPMvGF/sI0ENtSUZPzdbkw2t5+CpRZ/K1S0
        60iy0BIUI7fysOobmDQ3M3FHFkzvuWsfAQ==
X-Google-Smtp-Source: ABdhPJw1I5wuPqaLbet/xKI1maMM1Tb7MCQKnAmtjZGlEVR5Fb/GygdYy7zlRyHKdJH/Gegirw1lfg==
X-Received: by 2002:adf:f091:: with SMTP id n17mr15105789wro.351.1635368107829;
        Wed, 27 Oct 2021 13:55:07 -0700 (PDT)
Received: from fedora.redhat.com ([2a00:a040:19b:e02f::1003])
        by smtp.gmail.com with ESMTPSA id f8sm905208wrj.41.2021.10.27.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 13:55:07 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Aharon Landau <aharonl@nvidia.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/bnxt_re: Fix kernel panic when trying to access bnxt_re_stat_descs
Date:   Wed, 27 Oct 2021 23:54:48 +0300
Message-Id: <20211027205448.127821-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For some reason when introducing 13f30b0fa0a9 commit the "active_pds" and
"active_ahs" descriptors got dropped, which lead to the following panic
when trying to access the first entry in the descriptors. Avoid this by
return the dropped hunks.

 bnxt_re: Broadcom NetXtreme-C/E RoCE Driver
 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] SMP PTI
 CPU: 2 PID: 594 Comm: kworker/u32:1 Not tainted 5.15.0-rc6+ #2
 Hardware name: Dell Inc. PowerEdge R430/0CN7X8, BIOS 2.12.1 12/07/2020
 Workqueue: bnxt_re bnxt_re_task [bnxt_re]
 RIP: 0010:strlen+0x0/0x20
 Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 31
 RSP: 0018:ffffb25fc47dfbb0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000008100
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 00000000fffffff4 R09: 0000000000000000
 R10: ffff8a05c71fc028 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff8a05c3dee800
 FS:  0000000000000000(0000) GS:ffff8a092fc40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000048d3da001 CR4: 00000000001706e0
 Call Trace:
  kernfs_name_hash+0x12/0x80
  kernfs_find_ns+0x35/0xd0
  kernfs_remove_by_name_ns+0x32/0x90
  remove_files+0x2b/0x60
  create_files+0x1d3/0x1f0
  internal_create_group+0x17b/0x1f0
  internal_create_groups.part.0+0x3d/0xa0
  setup_port+0x180/0x3b0 [ib_core]
  ? __cond_resched+0x16/0x40
  ? kmem_cache_alloc_trace+0x278/0x3d0
  ib_setup_port_attrs+0x99/0x240 [ib_core]
  ib_register_device+0xcc/0x160 [ib_core]
  bnxt_re_task+0xba/0x170 [bnxt_re]
  process_one_work+0x1eb/0x390
  worker_thread+0x53/0x3d0
  ? process_one_work+0x390/0x390
  kthread+0x10f/0x130
  ? set_kthread_struct+0x40/0x40
  ret_from_fork+0x22/0x30
 Modules linked in: bnxt_re kvm ib_uverbs dell_wmi_descriptor rfkill video iTCO_wdt iTCO_vendor_support irqbypass dcdbas ib_core ipmi_ssif rapl intel_cstate intel_uncore pcspke
 CR2: 0000000000000000
 ---[ end trace b4637e4c4e3001af ]---
 RIP: 0010:strlen+0x0/0x20
 Code: 48 89 f9 74 09 48 83 c1 01 80 39 00 75 f7 31 d2 44 0f b6 04 16 44 88 04 11 48 83 c2 01 45 84 c0 75 ee c3 0f 1f 80 00 00 00 00 <80> 3f 00 74 10 48 89 f8 48 83 c0 01 80 31
 RSP: 0018:ffffb25fc47dfbb0 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000008100
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: 0000000000000000 R08: 00000000fffffff4 R09: 0000000000000000
 R10: ffff8a05c71fc028 R11: 0000000000000000 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ffff8a05c3dee800
 FS:  0000000000000000(0000) GS:ffff8a092fc40000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000048d3da001 CR4: 00000000001706e0
 Kernel panic - not syncing: Fatal exception
 Kernel Offset: 0x400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
 ---[ end Kernel panic - not syncing: Fatal exception ]---

Fixes: 13f30b0fa0a9 ("RDMA/counter: Add a descriptor in struct rdma_hw_stats")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/bnxt_re/hw_counters.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/hw_counters.c b/drivers/infiniband/hw/bnxt_re/hw_counters.c
index 78ca6dfd182b..825d512799d9 100644
--- a/drivers/infiniband/hw/bnxt_re/hw_counters.c
+++ b/drivers/infiniband/hw/bnxt_re/hw_counters.c
@@ -58,6 +58,8 @@
 #include "hw_counters.h"
 
 static const struct rdma_stat_desc bnxt_re_stat_descs[] = {
+	[BNXT_RE_ACTIVE_PD].name		=  "active_pds",
+	[BNXT_RE_ACTIVE_AH].name		=  "active_ahs",
 	[BNXT_RE_ACTIVE_QP].name		=  "active_qps",
 	[BNXT_RE_ACTIVE_SRQ].name		=  "active_srqs",
 	[BNXT_RE_ACTIVE_CQ].name		=  "active_cqs",
-- 
2.31.1

