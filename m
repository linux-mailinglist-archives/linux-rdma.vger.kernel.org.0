Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D8B108A24
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Nov 2019 09:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfKYIj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Nov 2019 03:39:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51733 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfKYIj7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Nov 2019 03:39:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id g206so14158674wme.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Nov 2019 00:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nWm85geAm8QkOdDtHQwPIjdz6MlCOkq1CZjRdUm73Ho=;
        b=c5CoBM3w/yU4083JbhmuE6QMWQ5+kzQ5659gXLpkZ9YtXmIl+uQ9522+YH45E4T8S9
         t55BBjIAoIeqAjfETBYkH46zKB8Lktlt5q4QLHO9HSs8cJfk5fIHqWLUthfkbprBYVKN
         pq5eDWkrXe9MdMGREd2faUbdE9A0xMsVA4dp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nWm85geAm8QkOdDtHQwPIjdz6MlCOkq1CZjRdUm73Ho=;
        b=c3ycRCBfdb74UrPHmZTeBg7J8qGgn6cemXluc2/GB+RhGHEChKufBxrwbHUnNjTBYS
         0EjQ+yNejN0pcXNadWCRFB36BFZogDb/JA64adEgN7smjj6tePLZZoGkhOK3jiD1IQae
         Lw70nT/L7VRHtPPVhQXR2BQ1veOQHJ8N5GNj0rWPKKozHTZXXveNx9ZDOmJ2+2tTL8sC
         ipVTxzZdvy8KKlVpWcDoGKWIUBlmpPv0HFbdNFTAlmw7Uk9wxqxIF87WlEyk8TYXeW3J
         qisH6eqgsBBMTLWSw9HUbMaMMg13rmPPNfeDby3Nj1hudOGu9u7mS5IFbyat7BzgtYoX
         uO7A==
X-Gm-Message-State: APjAAAX+T6GlFDYEiXoCv3oRlADHQ8u8gP+43ysN8vekj4Z6E1qQCZ6x
        G5Wg34prxLxBFVZ1vamGa1kX9w==
X-Google-Smtp-Source: APXvYqz14yhuycBvqquKzYz9x7Ax5iaGoIeazz0dGNRZ9/LZ0eKhZieDnftLbuPa58ALi0/eSMa8Wg==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr22812281wma.148.1574671196554;
        Mon, 25 Nov 2019 00:39:56 -0800 (PST)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k4sm7996995wmk.26.2019.11.25.00.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 00:39:55 -0800 (PST)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/6] RDMA/bnxt_re: Avoid freeing MR resources if dereg fails
Date:   Mon, 25 Nov 2019 00:39:29 -0800
Message-Id: <1574671174-5064-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
References: <1574671174-5064-1-git-send-email-selvin.xavier@broadcom.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Driver returns error code for MR dereg, but frees the MR structure.
When the MR dereg is retried due to previous error, the system crashes
as the structure is already freed.

[45545.547748] BUG: unable to handle kernel NULL pointer dereference at 00000000000001b8
[45545.557020] PGD 0 P4D 0
[45545.560370] Oops: 0000 [#1] SMP PTI
[45545.564778] CPU: 7 PID: 12178 Comm: ib_send_bw Kdump: loaded Not tainted 4.18.0-124.el8.x86_64 #1
[45545.575211] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.1.10 03/10/2015
[45545.584202] RIP: 0010:__dev_printk+0x2a/0x70
[45545.589495] Code: 0f 1f 44 00 00 49 89 d1 48 85 f6 0f 84 f6 2b 00 00 4c 8b 46 70 4d 85 c0 75 04 4c 8b
46 10 48 8b 86 a8 00 00 00 48 85 c0 74 16 <48> 8b 08 0f be 7f 01 48 c7 c2 13 ac ac 83 83 ef 30 e9 10 fe ff ff
[45545.611538] RSP: 0018:ffffaf7c04607a60 EFLAGS: 00010006
[45545.617903] RAX: 00000000000001b8 RBX: ffffa0010c91c488 RCX: 0000000000000246
[45545.626416] RDX: ffffaf7c04607a68 RSI: ffffa0010c91caa8 RDI: ffffffff83a788eb
[45545.634929] RBP: ffffaf7c04607ac8 R08: 0000000000000000 R09: ffffaf7c04607a68
[45545.643433] R10: 0000000000000000 R11: 0000000000000001 R12: ffffaf7c04607b90
[45545.651924] R13: 000000000000000e R14: 0000000000000000 R15: 00000000ffffa001
[45545.660411] FS:  0000146fa1f1cdc0(0000) GS:ffffa0012fac0000(0000) knlGS:0000000000000000
[45545.669969] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[45545.676910] CR2: 00000000000001b8 CR3: 000000007680a003 CR4: 00000000001606e0
[45545.685405] Call Trace:
[45545.688661]  dev_err+0x6c/0x90
[45545.692592]  ? dev_printk_emit+0x4e/0x70
[45545.697490]  bnxt_qplib_rcfw_send_message+0x594/0x660 [bnxt_re]
[45545.704619]  ? dev_err+0x6c/0x90
[45545.708727]  bnxt_qplib_free_mrw+0x80/0xe0 [bnxt_re]
[45545.714782]  bnxt_re_dereg_mr+0x2e/0xd0 [bnxt_re]
[45545.720552]  ib_dereg_mr+0x2f/0x50 [ib_core]
[45545.725835]  destroy_hw_idr_uobject+0x20/0x70 [ib_uverbs]
[45545.732375]  uverbs_destroy_uobject+0x2e/0x170 [ib_uverbs]
[45545.739010]  __uverbs_cleanup_ufile+0x6e/0x90 [ib_uverbs]
[45545.745544]  uverbs_destroy_ufile_hw+0x61/0x130 [ib_uverbs]
[45545.752272]  ib_uverbs_close+0x1f/0x80 [ib_uverbs]
[45545.758126]  __fput+0xb7/0x230
[45545.762033]  task_work_run+0x8a/0xb0
[45545.766518]  do_exit+0x2da/0xb40
...
[45545.841546] RIP: 0033:0x146fa113a387
[45545.845934] Code: Bad RIP value.
[45545.849931] RSP: 002b:00007fff945d1478 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff02
[45545.858783] RAX: 0000000000000000 RBX: 000055a248908d70 RCX: 0000000000000000
[45545.867145] RDX: 0000146fa1f2b000 RSI: 0000000000000001 RDI: 000055a248906488
[45545.875503] RBP: 000055a248909630 R08: 0000000000010000 R09: 0000000000000000
[45545.883849] R10: 0000000000000000 R11: 0000000000000000 R12: 000055a248906488
[45545.892180] R13: 0000000000000001 R14: 0000000000000000 R15: 000055a2489095f0

Do not free the MR structures, when driver returns error to the stack.

Fixes: 872f3578241d ("RDMA/bnxt_re: Add support for MRs with Huge pages")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9b6ca15..ad5112a 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3305,8 +3305,10 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_udata *udata)
 	int rc;
 
 	rc = bnxt_qplib_free_mrw(&rdev->qplib_res, &mr->qplib_mr);
-	if (rc)
+	if (rc) {
 		dev_err(rdev_to_dev(rdev), "Dereg MR failed: %#x\n", rc);
+		return rc;
+	}
 
 	if (mr->pages) {
 		rc = bnxt_qplib_free_fast_reg_page_list(&rdev->qplib_res,
-- 
2.5.5

