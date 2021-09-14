Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C485C40B8D3
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhINUR0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 16:17:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232545AbhINUR0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 16:17:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D22A6112E;
        Tue, 14 Sep 2021 20:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631650568;
        bh=bQuXuadugMPq2p+gOELbPrJSItCsb8DjM1vt4IuwMX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jzV1T7OulM4aA9kbhHUQiXqKnCGVibM+0hk6onpqF2G7PILh57swo2Ag7yaV3/+Ff
         2LcrD2LXLagahvxnJO3MYUOvjLEwOS92bYr3sDJELVE6LzFsRreBS+7NJwOGDOsVlg
         0R+iGNtf5Gp6PwCAjaHbajSP73ZT7X2mejQRkEAdiynB4qWVzEN1drwVLj+i8wMqjp
         fPzwuixeyEPgCKVkoEOwi0cl+rKAu6VpObd4jfv5FznqjefN9t+oZUOnY2elrb87YI
         mW4X2s773POZz697usRexOKeie0w+9NMomwoBnsESeQ0WcGXT9JHkDSFyRavTa1dy/
         46c9+N0dnRrmA==
Date:   Tue, 14 Sep 2021 15:16:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        Felix.Kuehling@amd.com, Shaoyun.Liu@amd.com, Jay.Cornwall@amd.com,
        andrew.gospodarek@broadcom.com, michael.chan@broadcom.com
Subject: Re: [PATCH] PCI: Do not enable pci atomics on VFs
Message-ID: <20210914201606.GA1452219@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631354585-16597-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 11, 2021 at 03:03:05AM -0700, Selvin Xavier wrote:
> Host crashes when pci_enable_atomic_ops_to_root is called for VFs
> with virtual buses. The virtual buses added to SR-IOV has bus->self
> set to  NULL and host crashes due to this.
> 
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
>  #8 [ffff9a94817139c0] bnxt_qplib_determine_atomics at ffffffffc08c1a33 [bnxt_re]
>  #9 [ffff9a94817139d0] bnxt_re_dev_init at ffffffffc08ba2d1 [bnxt_re]
>     RIP: 00007f450602f648  RSP: 00007ffe880869e8  RFLAGS: 00000246
>     RAX: ffffffffffffffda  RBX: 0000000000000002  RCX: 00007f450602f648
>     RDX: 0000000000000002  RSI: 0000555c566c4a60  RDI: 0000000000000001
>     RBP: 0000555c566c4a60   R8: 000000000000000a   R9: 00007f45060c2580
>     R10: 000000000000000a  R11: 0000000000000246  R12: 00007f45063026e0
>     R13: 0000000000000002  R14: 00007f45062fd880  R15: 0000000000000002
>     ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
> 
> AtomicOp Requester Enable bit in the Device Control 2 register
> is reserved for VFs and drivers shouldn't enable it for VFs.
> Adding a check to return EINVAL if pci_enable_atomic_ops_to_root
> is called with VF pci device.
> 
> Fixes: 35f5ace5dea4 ("RDMA/bnxt_re: Enable global atomic ops if platform supports")
> Fixes: 430a23689dea ("PCI: Add pci_enable_atomic_ops_to_root()")
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>

Applied to pci/enumeration for v5.16, thanks!

I fixed the extra space and rewrapped the code comment so it fits in
80 columns.

> ---
>  drivers/pci/pci.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index aacf575..d968a36 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3702,6 +3702,14 @@ int pci_enable_atomic_ops_to_root(struct pci_dev *dev, u32 cap_mask)
>  	struct pci_dev *bridge;
>  	u32 cap, ctl2;
>  
> +	/*
> +	 * As per PCIe r5.0, sec 9.3.5.10, the AtomicOp Requester Enable
> +	 * bit in the Device Control 2 register is reserved in VFs and the PF
> +	 * value applies to all associated VFs. Return -EINVAL if called for VFs.
> +	 */
> +	if (dev->is_virtfn)
> +		return -EINVAL;
> +
>  	if (!pci_is_pcie(dev))
>  		return -EINVAL;
>  
> -- 
> 2.5.5
> 
