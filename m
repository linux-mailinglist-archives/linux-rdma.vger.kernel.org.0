Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D71999056
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 12:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbfHVKFD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 06:05:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42465 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731906AbfHVKFD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 06:05:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id p3so3322501pgb.9
        for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2019 03:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=buRDql8emwiysdz4gORt+6Wa+hRdhTDWLjS9jyElB2s=;
        b=flt5x1H57ZPtqF6t/arkWkksEvzS+jd/sumAIn9dCz0yl2OTqhExiOXQeoCqZ1j8K5
         bQb1G5xDRj8QoT/85XWxqDXbnfa5qhUq7O4aJY73Xbhi1Z84wzPR3NT9oUlpRoCSxSYz
         w4UTwFYSkKkdV0y6skhRg86Qy904du9pmcbA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=buRDql8emwiysdz4gORt+6Wa+hRdhTDWLjS9jyElB2s=;
        b=DPqNqtFENEDIEYCP8YftBVTuMCINoep7Gc4R57nVXeu0lWy0YBPp9a/MJZ5NZfZtFW
         FbUrtIvgCU92/DfXfXydyKEe+IyoC0Ztxr+yYO29FKcN2wO2rYQhBJHk4OkrQNbZXUEZ
         2TLxGgr+bDu6yYdxeoP8VPBdIX5pizSxd2/gP6iUP/1of0Aqk2pRTh3DUPk0cFod82W3
         saogjvleDL5mcaPJtNHcS64RxWMFglkkQT52YT0dy4WRKBKbKaT7Vn7nT2P8ztsf4LJ2
         XkvYjXYLfz2R+fzqk4cYyQb0TquOSmZymeC/ZWT56wVIKjQqDhAwuGLlWLdECzr7Ye5b
         nJNQ==
X-Gm-Message-State: APjAAAX3kHwPZ1/5mOaAod4kts5N3MWwCvMAlX0R9F9f9Ua+mw/kld3L
        GLlisMFEkvAVa64m1ErrFERmeg==
X-Google-Smtp-Source: APXvYqz0Ox16MpOF9VpzafA4UumfsOUueU8Gfbf4bNpYSRQmNWQjQID+EQBGVURdA/OEga8oeQtGTQ==
X-Received: by 2002:a17:90a:234e:: with SMTP id f72mr4611883pje.121.1566468301857;
        Thu, 22 Aug 2019 03:05:01 -0700 (PDT)
Received: from dhcp-10-192-206-197.iig.avagotech.net.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 2sm7041836pjh.13.2019.08.22.03.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 03:05:00 -0700 (PDT)
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-rc v2] RDMA/bnxt_re: Fix stack-out-of-bounds in bnxt_qplib_rcfw_send_message
Date:   Thu, 22 Aug 2019 03:02:50 -0700
Message-Id: <1566468170-489-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Driver copies FW commands to the HW queue as  units of 16 bytes. Some
of the command structures are not exact multiple of 16. So while copying
the data from those structures, the stack out of bounds messages are
reported by KASAN. The following error is reported.

[ 1337.530155] ==================================================================
[ 1337.530277] BUG: KASAN: stack-out-of-bounds in bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530413] Read of size 16 at addr ffff888725477a48 by task rmmod/2785

[ 1337.530540] CPU: 5 PID: 2785 Comm: rmmod Tainted: G           OE     5.2.0-rc6+ #75
[ 1337.530541] Hardware name: Dell Inc. PowerEdge R730/0599V5, BIOS 1.0.4 08/28/2014
[ 1337.530542] Call Trace:
[ 1337.530548]  dump_stack+0x5b/0x90
[ 1337.530556]  ? bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530560]  print_address_description+0x65/0x22e
[ 1337.530568]  ? bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530575]  ? bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530577]  __kasan_report.cold.3+0x37/0x77
[ 1337.530581]  ? _raw_write_trylock+0x10/0xe0
[ 1337.530588]  ? bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530590]  kasan_report+0xe/0x20
[ 1337.530592]  memcpy+0x1f/0x50
[ 1337.530600]  bnxt_qplib_rcfw_send_message+0x40a/0x850 [bnxt_re]
[ 1337.530608]  ? bnxt_qplib_creq_irq+0xa0/0xa0 [bnxt_re]
[ 1337.530611]  ? xas_create+0x3aa/0x5f0
[ 1337.530613]  ? xas_start+0x77/0x110
[ 1337.530615]  ? xas_clear_mark+0x34/0xd0
[ 1337.530623]  bnxt_qplib_free_mrw+0x104/0x1a0 [bnxt_re]
[ 1337.530631]  ? bnxt_qplib_destroy_ah+0x110/0x110 [bnxt_re]
[ 1337.530633]  ? bit_wait_io_timeout+0xc0/0xc0
[ 1337.530641]  bnxt_re_dealloc_mw+0x2c/0x60 [bnxt_re]
[ 1337.530648]  bnxt_re_destroy_fence_mr+0x77/0x1d0 [bnxt_re]
[ 1337.530655]  bnxt_re_dealloc_pd+0x25/0x60 [bnxt_re]
[ 1337.530677]  ib_dealloc_pd_user+0xbe/0xe0 [ib_core]
[ 1337.530683]  srpt_remove_one+0x5de/0x690 [ib_srpt]
[ 1337.530689]  ? __srpt_close_all_ch+0xc0/0xc0 [ib_srpt]
[ 1337.530692]  ? xa_load+0x87/0xe0
...
[ 1337.530840]  do_syscall_64+0x6d/0x1f0
[ 1337.530843]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1337.530845] RIP: 0033:0x7ff5b389035b
[ 1337.530848] Code: 73 01 c3 48 8b 0d 2d 0b 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 0a 2c 00 f7 d8 64 89 01 48
[ 1337.530849] RSP: 002b:00007fff83425c28 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[ 1337.530852] RAX: ffffffffffffffda RBX: 00005596443e6750 RCX: 00007ff5b389035b
[ 1337.530853] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005596443e67b8
[ 1337.530854] RBP: 0000000000000000 R08: 00007fff83424ba1 R09: 0000000000000000
[ 1337.530856] R10: 00007ff5b3902960 R11: 0000000000000206 R12: 00007fff83425e50
[ 1337.530857] R13: 00007fff8342673c R14: 00005596443e6260 R15: 00005596443e6750

[ 1337.530885] The buggy address belongs to the page:
[ 1337.530962] page:ffffea001c951dc0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
[ 1337.530964] flags: 0x57ffffc0000000()
[ 1337.530967] raw: 0057ffffc0000000 0000000000000000 ffffffff1c950101 0000000000000000
[ 1337.530970] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[ 1337.530970] page dumped because: kasan: bad access detected

[ 1337.530996] Memory state around the buggy address:
[ 1337.531072]  ffff888725477900: 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 f2 f2 f2
[ 1337.531180]  ffff888725477980: 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00
[ 1337.531288] >ffff888725477a00: 00 f2 f2 f2 f2 f2 f2 00 00 00 f2 00 00 00 00 00
[ 1337.531393]                                                  ^
[ 1337.531478]  ffff888725477a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1337.531585]  ffff888725477b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1337.531691] ==================================================================

Fix this by passing the exact size of each FW command to
bnxt_qplib_rcfw_send_message as req->cmd_size. Before sending
the command to HW, modify the req->cmd_size to number of 16 byte units.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
v1 -> v2: Instead of passing the exact size as separate argument to the function,
	  use the req->cmd_size field to pass this information.

 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  8 +++++++-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h | 11 ++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 48b04d2..60c8f76 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -136,6 +136,13 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 		spin_unlock_irqrestore(&cmdq->lock, flags);
 		return -EBUSY;
 	}
+
+	size = req->cmd_size;
+	/* change the cmd_size to the number of 16byte cmdq unit.
+	 * req->cmd_size is modified here
+	 */
+	bnxt_qplib_set_cmd_slots(req);
+
 	memset(resp, 0, sizeof(*resp));
 	crsqe->resp = (struct creq_qp_event *)resp;
 	crsqe->resp->cookie = req->cookie;
@@ -150,7 +157,6 @@ static int __send_message(struct bnxt_qplib_rcfw *rcfw, struct cmdq_base *req,
 
 	cmdq_ptr = (struct bnxt_qplib_cmdqe **)cmdq->pbl_ptr;
 	preq = (u8 *)req;
-	size = req->cmd_size * BNXT_QPLIB_CMDQE_UNITS;
 	do {
 		/* Locate the next cmdq slot */
 		sw_prod = HWQ_CMP(cmdq->prod, cmdq);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 2138533..dfeadc1 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -55,9 +55,7 @@
 	do {								\
 		memset(&(req), 0, sizeof((req)));			\
 		(req).opcode = CMDQ_BASE_OPCODE_##CMD;			\
-		(req).cmd_size = (sizeof((req)) +			\
-				BNXT_QPLIB_CMDQE_UNITS - 1) /		\
-				BNXT_QPLIB_CMDQE_UNITS;			\
+		(req).cmd_size = sizeof((req));				\
 		(req).flags = cpu_to_le16(cmd_flags);			\
 	} while (0)
 
@@ -95,6 +93,13 @@ static inline u32 bnxt_qplib_cmdqe_cnt_per_pg(u32 depth)
 		 BNXT_QPLIB_CMDQE_UNITS);
 }
 
+/* Set the cmd_size to a factor of CMDQE unit */
+static inline void bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
+{
+	req->cmd_size = (req->cmd_size + BNXT_QPLIB_CMDQE_UNITS - 1) /
+			 BNXT_QPLIB_CMDQE_UNITS;
+}
+
 #define MAX_CMDQ_IDX(depth)		((depth) - 1)
 
 static inline u32 bnxt_qplib_max_cmdq_idx_per_pg(u32 depth)
-- 
2.5.5

