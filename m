Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0843C30A68F
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Feb 2021 12:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbhBALas (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Feb 2021 06:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBALah (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Feb 2021 06:30:37 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EBFC061574
        for <linux-rdma@vger.kernel.org>; Mon,  1 Feb 2021 03:29:54 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i9so12874129wmq.1
        for <linux-rdma@vger.kernel.org>; Mon, 01 Feb 2021 03:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwU3gycYpWhx2soRrUEq/AES4Fmg5jvCJzfHjO9KvpU=;
        b=cmbocREqLw3FYuIk+SnOedNn2dI2OVXbrwqW0NY6PPERqI+ONmlmkjio7QguZFjB7h
         lQ13VSEZte/gL8eSKdkHKjvRGCTQGBHj6e76LTRV9T05Gz0qeY4OB5QlwForsQxElmxG
         znMUhI1eLLhdRogV00U7h9W3XNc0uNBVsxVNuXykqTDcaZO7NVklr39gNI07vlQGVlMs
         ORsnQtuWS+IYc96suzO+BVbvxe7G06fX2yLetMzv2hK8d8uoCrDJebzPcgH6D3K/az6Z
         MbFv0YeiUoVYOSKAWY9A6yi6nxUNAE2HoKiW2Ok23i/3Co+6lfjKS43CSV0lGuDHPJm8
         n4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kwU3gycYpWhx2soRrUEq/AES4Fmg5jvCJzfHjO9KvpU=;
        b=NUeETluc+42dhkrBgT2/fEBvA5lx8niDxDYruDkAZons8Mo2828ONTd67B6zG10uxm
         tVpR3T9qdwv1CBvh/TTu2p1e5+TdaJB2heDs1Q0ojhyENRsb1QZGmYJag6DWTr0Rki+W
         FjIPupjuDfDYOePgdX2WS+m5uw+OXcrjTwcGa+DuH682wt4ViSLtWfyT8ruyMbH4TMke
         uYf86pZZxkpvFRc6xW6ChbqOCAqhuGwXcS/6S+lDBI0LWBlW94bv7hCEN1Orena8mFIu
         KoJJ1Bnr9nadYBlpTnyOYy8jgtmB+ntp0xKhPqtnECWh9gIYCZoTVKwXYdbjzJjTTjRR
         FbhA==
X-Gm-Message-State: AOAM53232pu3IYWWJH/BOzoSR+9JGy+2I/5LO4OSvFubcHJ/iePjQUGV
        BD/Bs4AljGANi46jpQVwISJlIygsfuVB2Q==
X-Google-Smtp-Source: ABdhPJyCyZ0vSGW4JGdt2ZICxWJolGqJoTUs2Xsex37FHzRjQDq69CPzDQ0VD+viKpSX20ekbsJW0g==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr14645217wmj.149.1612178993254;
        Mon, 01 Feb 2021 03:29:53 -0800 (PST)
Received: from kheib-workstation.redhat.com ([77.137.152.100])
        by smtp.gmail.com with ESMTPSA id e11sm26577826wrt.35.2021.02.01.03.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:29:52 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/siw: Fix calculation of tx_valid_cpus size
Date:   Mon,  1 Feb 2021 13:29:22 +0200
Message-Id: <20210201112922.141085-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The size of tx_valid_cpus was calculated under the assumption that the
numa nodes identifiers are continuous, which is not the case in all
archs as this could lead to the following panic when trying to access an
invalid tx_valid_cpus index, avoid the following panic by using
nr_node_ids instead of num_online_nodes() to allocate the tx_valid_cpus
size.

Kernel attempted to read user page (8) - exploit attempt? (uid: 0)
BUG: Kernel NULL pointer dereference on read at 0x00000008
Faulting instruction address: 0xc0080000081b4a90
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
Modules linked in: siw(+) rfkill rpcrdma ib_isert iscsi_target_mod ib_iser libiscsi scsi_transport_iscsi ib_srpt target_core_mod ib_srp scsi_transport_srp ib_ipoib rdma_ucm sunrpc ib_umad rdma_cm ib_cm iw_cm i40iw ib_uverbs ib_core i40e ses enclosure scsi_transport_sas ipmi_powernv ibmpowernv at24 ofpart ipmi_devintf regmap_i2c ipmi_msghandler powernv_flash uio_pdrv_genirq uio mtd opal_prd zram ip_tables xfs libcrc32c sd_mod t10_pi ast i2c_algo_bit drm_vram_helper drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops cec drm_ttm_helper ttm drm vmx_crypto aacraid drm_panel_orientation_quirks dm_mod
CPU: 40 PID: 3279 Comm: modprobe Tainted: G        W      X --------- ---  5.11.0-0.rc4.129.eln108.ppc64le #2
NIP:  c0080000081b4a90 LR: c0080000081b4a2c CTR: c0000000007ce1c0
REGS: c000000027fa77b0 TRAP: 0300   Tainted: G        W      X --------- ---   (5.11.0-0.rc4.129.eln108.ppc64le)
MSR:  9000000002009033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 44224882  XER: 00000000
CFAR: c0000000007ce200 DAR: 0000000000000008 DSISR: 40000000 IRQMASK: 0
GPR00: c0080000081b4a2c c000000027fa7a50 c0080000081c3900 0000000000000040
GPR04: c000000002023080 c000000012e1c300 000020072ad70000 0000000000000001
GPR08: c000000001726068 0000000000000008 0000000000000008 c0080000081b5758
GPR12: c0000000007ce1c0 c0000007fffc3000 00000001590b1e40 0000000000000000
GPR16: 0000000000000000 0000000000000001 000000011ad68fc8 00007fffcc09c5c8
GPR20: 0000000000000008 0000000000000000 00000001590b2850 00000001590b1d30
GPR24: 0000000000043d68 000000011ad67a80 000000011ad67a80 0000000000100000
GPR28: c000000012e1c300 c0000000020271c8 0000000000000001 c0080000081bf608
NIP [c0080000081b4a90] siw_init_cpulist+0x194/0x214 [siw]
LR [c0080000081b4a2c] siw_init_cpulist+0x130/0x214 [siw]
Call Trace:
[c000000027fa7a50] [c0080000081b4a2c] siw_init_cpulist+0x130/0x214 [siw] (unreliable)
[c000000027fa7a90] [c0080000081b4e68] siw_init_module+0x40/0x2a0 [siw]
[c000000027fa7b30] [c0000000000124f4] do_one_initcall+0x84/0x2e0
[c000000027fa7c00] [c000000000267ffc] do_init_module+0x7c/0x350
[c000000027fa7c90] [c00000000026a180] __do_sys_init_module+0x210/0x250
[c000000027fa7db0] [c0000000000387e4] system_call_exception+0x134/0x230
[c000000027fa7e10] [c00000000000d660] system_call_common+0xf0/0x27c
Instruction dump:
40810044 3d420000 e8bf0000 e88a82d0 3d420000 e90a82c8 792a1f24 7cc4302a
7d2642aa 79291f24 7d25482a 7d295214 <7d4048a8> 7d4a3b78 7d4049ad 40c2fff4
---[ end trace 813d4c362755dcfc ]---

Fixes: bdcf26bf9b3a ("rdma/siw: network and RDMA core interface")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/siw/siw_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
index ee95cf29179d..41c46dfaebf6 100644
--- a/drivers/infiniband/sw/siw/siw_main.c
+++ b/drivers/infiniband/sw/siw/siw_main.c
@@ -135,7 +135,7 @@ static struct {
 
 static int siw_init_cpulist(void)
 {
-	int i, num_nodes = num_possible_nodes();
+	int i, num_nodes = nr_node_ids;
 
 	memset(siw_tx_thread, 0, sizeof(siw_tx_thread));
 
-- 
2.26.2

