Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E72A444D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Nov 2020 12:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgKCLcH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 3 Nov 2020 06:32:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727323AbgKCLcH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Nov 2020 06:32:07 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-rdma@vger.kernel.org
Subject: [Bug 210021] New: IB/rxe: build error due to unmet dependency for
 CRYPTO_CRC32 by RDMA_RXE
Date:   Tue, 03 Nov 2020 11:32:05 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo
 drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Infiniband/RDMA
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: fazilyildiran@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: drivers_infiniband-rdma@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cc cf_regression attachments.created
Message-ID: <bug-210021-11804@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210021

            Bug ID: 210021
           Summary: IB/rxe: build error due to unmet dependency for
                    CRYPTO_CRC32 by RDMA_RXE
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.4.4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Infiniband/RDMA
          Assignee: drivers_infiniband-rdma@kernel-bugs.osdl.org
          Reporter: fazilyildiran@gmail.com
                CC: dledford@redhat.com, fazilyildiran@gmail.com,
                    leon@leon.nu, paul@pgazz.com
        Regression: No

Created attachment 293417
  --> https://bugzilla.kernel.org/attachment.cgi?id=293417&action=edit
reproduce.tar.gz

Attachment (reproduce.tar.gz) content:
 - sample.config: Config file to reproduce the bug.
 - build_out.txt: Output of Kbuild including the error messages.

When RDMA_RXE is enabled and CRYPTO is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for CRYPTO_CRC32
  Depends on [n]: CRYPTO [=n]
  Selected by [y]:
  - RDMA_RXE [=y] && (INFINIBAND_USER_ACCESS [=y] || !INFINIBAND_USER_ACCESS
[=y]) && INET [=y] && PCI [=y] && INFINIBAND [=y] && (!64BIT [=y] ||
ARCH_DMA_ADDR_T_64BIT [=y])

Building the kernel fails due to this unmet direct dependency issue as follows:

[...]
  LD      .tmp_vmlinux1
crypto/crc32_generic.o: In function `crc32_mod_fini':
crc32_generic.c:(.exit.text+0x8): undefined reference to
`crypto_unregister_shash'
crypto/crc32_generic.o: In function `crc32_mod_init':
crc32_generic.c:(.init.text+0x8): undefined reference to
`crypto_register_shash'
drivers/infiniband/sw/rxe/rxe.o: In function `rxe_dealloc':
rxe.c:(.text+0x102): undefined reference to `crypto_destroy_tfm'
drivers/infiniband/sw/rxe/rxe_req.o: In function `rxe_crc32.isra.17':
rxe_req.c:(.text+0x219): undefined reference to `crypto_shash_update'
drivers/infiniband/sw/rxe/rxe_recv.o: In function `rxe_crc32.isra.7':
rxe_recv.c:(.text+0xeb): undefined reference to `crypto_shash_update'
drivers/infiniband/sw/rxe/rxe_verbs.o: In function `rxe_register_device':
rxe_verbs.c:(.text+0x117d): undefined reference to `crypto_alloc_shash'
drivers/infiniband/sw/rxe/rxe_mr.o: In function `rxe_crc32.isra.3':
rxe_mr.c:(.text+0x13b): undefined reference to `crypto_shash_update'
drivers/infiniband/sw/rxe/rxe_icrc.o: In function `rxe_crc32.isra.0':
rxe_icrc.c:(.text+0x26): undefined reference to `crypto_shash_update'
Makefile:1077: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Steps to reproduce the bug for v5.4.4:
  1. wget
https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O
~/bin/make.cross
  2. chmod +x ~/bin/make.cross
  3. tar -xvf reproduce.tar.gz # sample.config and build_out.txt
  4. cp sample.config path/to/linux-source-v5.4.4/.config
  5. cd path/to/linux-source-v5.4.4/
  6. ~/bin/make.cross ARCH=x86_64 clean
  7. ~/bin/make.cross ARCH=x86_64 olddefconfig # unmet direct dependency
warning
  8. ~/bin/make.cross ARCH=x86_64 # should have a build error

The output for the steps [6-8] can be found in build_out.txt.

The build error happens as follows: RDMA_RXE selects CRYPTO_CRC32.
CRYPTO_CRC32 selects CRYPTO_HASH, and CRYPTO_HASH selects CRYPTO_HASH2.
When RDMA_RXE selects CRYPTO_CRC32 without accounting for its direct
dependency (CRYPTO), CRYPTO_CRC32 gets enabled but it does not select
CRYPTO_HASH thus CRYPTO_HASH2. Consequently, the required functions
such crypto_unregister_shash are left undefined, causing the build error.

Thanks,
Necip

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
