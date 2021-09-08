Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4159403CDE
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Sep 2021 17:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349590AbhIHPwy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 8 Sep 2021 11:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235678AbhIHPwy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 8 Sep 2021 11:52:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 453FC61132;
        Wed,  8 Sep 2021 15:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631116306;
        bh=KQoBKUPb391/DfBQinu6feapZI9eFoOJs0UohXDSL30=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X9VSWjNj1mSvc1h6VxPvRSVVfjbiA0Mm8l5JlVAEvReaDThGpN2ihmbbCVxaUBqEb
         htmfan5bi3gSru5f53ne4KVE+zeOBZMbeM7TQ6dhjKE9dgoI2fFxSWPgI6ENmUkmHL
         t+JqbiaSOYRQEH1kpB1M4wDOf7CIDN3nPvmCThlUfCA8sPa4kmcOMcvW1NlnLiApTw
         qEH698zb6mdrGmhSZsp8zAndajizepSlxdd6s6mAvVJxtDUuOw1FbxfOb+prj8yXqn
         0Y9HW+fFf5BAjp4pavD0kia5QnKJz67Hh/dXentTtwtBuMo1ih0cOw+ZUxa5ntLEpC
         d1LXBcyzgTMLg==
Date:   Wed, 8 Sep 2021 10:51:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Andrew Gospodarek <andrew.gospodarek@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: crash observed with pci_enable_atomic_ops_to_root on VF devices.
Message-ID: <20210908155145.GA867184@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW1hjkCkOOKynC+fGCk+Qo4xHMkxakw21sPEtV27k9T+MA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

[+cc Devesh, Jay, Felix]

On Wed, Sep 01, 2021 at 06:41:50PM +0530, Selvin Xavier wrote:
> Hi all,
> 
> A recent patch merged to 5.14 in the Broadcom RDMA driver  to call
> pci_enable_atomic_ops_to_root crashes the host while creating VFs. The
> crash is seen when pci_enable_atomic_ops_to_root is called with
> a VF pci device.  pdev->bus->self is NULL.  Is this expected for VF?

Sorry I missed this before.  I think you're referring to 35f5ace5dea4
("RDMA/bnxt_re: Enable global atomic ops if platform supports") [1],
so I cc'd Devesh (the author).

It *is* expected that virtual buses added for SR-IOV have
bus->self == NULL, but I don't think adding a check for that is
sufficient.

The AtomicOp Requester Enable bit is in the Device Control 2 register,
and per PCIe r5.0, sec 9.3.5.10, it is reserved in VFs and the PF
value applies to all associated VFs.

pci_enable_atomic_ops_to_root() does not appear to take that into
account, so I also cc'd Jay and Felix, the authors of 430a23689dea
("PCI: Add pci_enable_atomic_ops_to_root()") [2].

It looks like we need to enable AtomicOps in the *PF*, not in the VF.
Maybe that means pci_enable_atomic_ops_to_root() should return failure
when called on a VF, and it should be up to the driver to call it on
the PF instead?  I'm not an expert on how VFs are used, but I don't
like the idea of device B reaching out to change the configuration
of device A, especially when the change also affects devices C, D,
E, ...

Bjorn

[1] https://git.kernel.org/linus/35f5ace5dea4
[2] https://git.kernel.org/linus/430a23689dea

> Here is the stack trace for your reference.
> crash> bt
> PID: 4481   TASK: ffff89c6941b0000  CPU: 53  COMMAND: "bash"
>  #0 [ffff9a94817136d8] machine_kexec at ffffffffb90601a4
>  #1 [ffff9a9481713728] __crash_kexec at ffffffffb9190d5d
>  #2 [ffff9a94817137f0] crash_kexec at ffffffffb9191c4d
>  #3 [ffff9a9481713808] oops_end at ffffffffb9025cd6
>  #4 [ffff9a9481713828] page_fault_oops at ffffffffb906e417
>  #5 [ffff9a9481713888] exc_page_fault at ffffffffb9a0ad14
>  #6 [ffff9a94817138b0] asm_exc_page_fault at ffffffffb9c00ace
>     [exception RIP: pcie_capability_read_dword+28]
>     RIP: ffffffffb952fd5c  RSP: ffff9a9481713960  RFLAGS: 00010246
>     RAX: 0000000000000001  RBX: ffff89c6b1096000  RCX: 0000000000000000
>     RDX: ffff9a9481713990  RSI: 0000000000000024  RDI: 0000000000000000
>     RBP: 0000000000000080   R8: 0000000000000008   R9: ffff89c64341a2f8
>     R10: 0000000000000002  R11: 0000000000000000  R12: ffff89c648bab000
>     R13: 0000000000000000  R14: 0000000000000000  R15: ffff89c648bab0c8
>     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>  #7 [ffff9a9481713988] pci_enable_atomic_ops_to_root at ffffffffb95359a6
>  #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at
> ffffffffc08c1a33 [bnxt_re]
>  #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
> #10 [ffff9a9481713a78] bnxt_re_netdev_event at ffffffffc08bab8f [bnxt_re]
> #11 [ffff9a9481713aa8] raw_notifier_call_chain at ffffffffb9102cbe
> #12 [ffff9a9481713ad0] register_netdevice at ffffffffb9803ff3
> #13 [ffff9a9481713b08] register_netdev at ffffffffb980410a
> #14 [ffff9a9481713b18] bnxt_init_one at ffffffffc0349572 [bnxt_en]
> #15 [ffff9a9481713b70] local_pci_probe at ffffffffb953b92f
> #16 [ffff9a9481713ba0] pci_device_probe at ffffffffb953cf8f
> #17 [ffff9a9481713be8] really_probe at ffffffffb9659619
> #18 [ffff9a9481713c08] __driver_probe_device at ffffffffb96598fb
> #19 [ffff9a9481713c28] driver_probe_device at ffffffffb965998f
> #20 [ffff9a9481713c48] __device_attach_driver at ffffffffb9659cd2
> #21 [ffff9a9481713c70] bus_for_each_drv at ffffffffb9657307
> #22 [ffff9a9481713ca8] __device_attach at ffffffffb96593e0
> #23 [ffff9a9481713ce8] pci_bus_add_device at ffffffffb9530b7a
> #24 [ffff9a9481713d00] pci_iov_add_virtfn at ffffffffb955b1ca
> #25 [ffff9a9481713d40] sriov_enable at ffffffffb955b54b
> #26 [ffff9a9481713d90] bnxt_sriov_configure at ffffffffc034d913 [bnxt_en]
> #27 [ffff9a9481713dd8] sriov_numvfs_store at ffffffffb955acb4
> #28 [ffff9a9481713e10] kernfs_fop_write_iter at ffffffffb93f09ad
> #29 [ffff9a9481713e48] new_sync_write at ffffffffb933b82c
> #30 [ffff9a9481713ed0] vfs_write at ffffffffb933db64
> #31 [ffff9a9481713f00] ksys_write at ffffffffb933dd99
> #32 [ffff9a9481713f38] do_syscall_64 at ffffffffb9a07897
> #33 [ffff9a9481713f50] entry_SYSCALL_64_after_hwframe at ffffffffb9c0007c
>     RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f648
>     RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 0000000000000001
>     RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c2580
>     R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e0
>     R13: 0000000000000002  R14: 00007f45062fd880  R15: 0000000000000002
>     ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
> 
> Please suggest a fix for solving this issue. Is adding a NULL check
> for bus->self sounds okay?
> 
> Thanks,
> Selvin


