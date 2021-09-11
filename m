Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265A14075FD
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Sep 2021 12:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbhIKKFi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 11 Sep 2021 06:05:38 -0400
Received: from lpdvsmtp09.broadcom.com ([192.19.166.228]:58022 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235443AbhIKKFh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 11 Sep 2021 06:05:37 -0400
Received: from dhcp-10-192-206-197.iig.avagotech.net.net (dhcp-10-123-156-118.dhcp.broadcom.net [10.123.156.118])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E8AC980D6;
        Sat, 11 Sep 2021 03:04:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E8AC980D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1631354664;
        bh=C//DGv3jc+2arzWZ0l0mbjBrEbpJGqWGmA5Z4sxdPZs=;
        h=From:To:Cc:Subject:Date:From;
        b=iEIIXXEtLx8kXqZPvipPFKm0YJn2W46E+nP6c/w9pSWR/Pn/+Y7ZT3Y4LP3QdL7T6
         WXQMOBSIVZi7WQ57F5bYfzgbQa/IcFDSogr+2PWnhDJE+Is34vuBbJX6WI4I5Us+sZ
         QUrN7YyWDSE4BxhOufbp0o/Byj6wJoqwktY0YzLs=
From:   Selvin Xavier <selvin.xavier@broadcom.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Felix.Kuehling@amd.com, Shaoyun.Liu@amd.com, Jay.Cornwall@amd.com,
        andrew.gospodarek@broadcom.com, michael.chan@broadcom.com,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH] PCI: Do not enable pci atomics on VFs
Date:   Sat, 11 Sep 2021 03:03:05 -0700
Message-Id: <1631354585-16597-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Host crashes when pci_enable_atomic_ops_to_root is called for VFs
with virtual buses. The virtual buses added to SR-IOV has bus->self
set to  NULL and host crashes due to this.

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

AtomicOp Requester Enable bit in the Device Control 2 register
is reserved for VFs and drivers shouldn't enable it for VFs.
Adding a check to return EINVAL if pci_enable_atomic_ops_to_root
is called with VF pci device.

Fixes: 35f5ace5dea4 ("RDMA/bnxt_re: Enable global atomic ops if platform supports")
Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index aacf575..d968a36 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3702,6 +3702,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
 	struct pci_dev *bridge;
 	u32 cap, ctl2;
 
+	/*
+	 * As per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable
+	 * bit in the Device Control 2 register is reserved in VFs and the PF
+	 * value applies to all associated VFs. Return -EINVAL if called for VFs.
+	 */
+	if (dev->is_virtfn)
+		return -EINVAL;
+
 	if (!pci_is_pcie(dev))
 		return -EINVAL;
 
-- 
2.5.5

