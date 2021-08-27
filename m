Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043AC3F9377
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Aug 2021 06:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhH0EQj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Aug 2021 00:16:39 -0400
Received: from lpdvsmtp10.broadcom.com ([192.19.11.229]:33180 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233903AbhH0EQj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 27 Aug 2021 00:16:39 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 9CAFA828C;
        Thu, 26 Aug 2021 21:15:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 9CAFA828C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1630037750;
        bh=l9TC0vQFA6jMtynQXYrqTKNEolpr2oGFKu8AfyqlfmQ=;
        h=From:To:Cc:Subject:Date:From;
        b=l8T2TTqaZpU5aLKXe4nSpNptZfBD/oIItx4UOF+d5WyHL1gI6zAM7AoR/hT89Bcly
         C0dpdTCwp9zC5RoctPd6ugOApEH06UklSyXDKC2sWB+xJXx0DEiF4yE3orDaVNtTz3
         KWykfKhUpOePHnsZwOG1oMeABTMT55wVdv+o6tyU=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc] RDMA/bnxt_re: Disable atomic support on VFs
Date:   Thu, 26 Aug 2021 21:15:38 -0700
Message-Id: <1630037738-20276-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Following Host crash is observed when pci_enable_atomic_ops_to_root
is called with VF PCI device.

PID: 4481   TASK: ffff89c6941b0000  CPU: 53  COMMAND: "bash"
 #0 [ffff9a94817136d8] machine_kexec at ffffffffb90601a4
 #1 [ffff9a9481713728] __crash_kexec at ffffffffb9190d5d
 #2 [ffff9a94817137f0] crash_kexec at ffffffffb9191c4d
 #3 [ffff9a9481713808] oops_end at ffffffffb9025cd6
 #4 [ffff9a9481713828] page_fault_oops at ffffffffb906e417
 #5 [ffff9a9481713888] exc_page_fault at ffffffffb9a0ad14
 #6 [ffff9a94817138b0] asm_exc_page_fault at ffffffffb9c00ace
    [exception RIP: pcie_capability_read_dword+28]
    RIP: ffffffffb952fd5c  RSP: ffff9a9481713960  RFLAGS: 00010246
    RAX: 0000000000000001  RBX: ffff89c6b1096000  RCX: 0000000000000000
    RDX: ffff9a9481713990  RSI: 0000000000000024  RDI: 0000000000000000
    RBP: 0000000000000080   R8: 0000000000000008   R9: ffff89c64341a2f8
    R10: 0000000000000002  R11: 0000000000000000  R12: ffff89c648bab000
    R13: 0000000000000000  R14: 0000000000000000  R15: ffff89c648bab0c8
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #7 [ffff9a9481713988] pci_enable_atomic_ops_to_root at ffffffffb95359a6
 #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at ffffffffc08c1a33 [bnxt_re]
 #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
    RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f648
    RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 0000000000000001
    RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c2580
    R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e0
    R13: 0000000000000002  R14: 00007f45062fd880  R15: 0000000000000002
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

To avoid system crash when VFs are created, enable atomics only for PF now.

Fixes: 35f5ace5dea4 ("RDMA/bnxt_re: Enable global atomic ops if platform supports")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 4678bd6..04d5c7d 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -129,7 +129,7 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
 	rdev->rcfw.res = &rdev->qplib_res;
 
 	bnxt_re_set_drv_mode(rdev, wqe_mode);
-	if (bnxt_qplib_determine_atomics(en_dev->pdev))
+	if (!BNXT_VF(bp) && bnxt_qplib_determine_atomics(en_dev->pdev))
 		ibdev_info(&rdev->ibdev,
 			   "platform doesn't support global atomics.");
 	return 0;
-- 
2.5.5

