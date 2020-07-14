Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945AE21F673
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2020 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgGNPtp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jul 2020 11:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNPtp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Jul 2020 11:49:45 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C781122464;
        Tue, 14 Jul 2020 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594741784;
        bh=Ulz6kftsIf17MgM1f0YQJELfS5NjvEeQg+27bJIWgUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EaQlvs/TC2yUjHJK6smf4ynxhvgNy5wlI9WFj7L3BfuTU4CDzmYYc6S17Kw23RlD1
         ane48ARw0DttiT5GA+ADF+3szgTdBi3G/NGuj6uqbXK7TbOGD28k/kXcKTsDcmnQ/H
         L4Vbv6eXEAxcd1xgmuHjECuy9pqpSHzJy0jUhojw=
Date:   Tue, 14 Jul 2020 10:49:41 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Saheed Olayemi Bolarinwa <refactormyself@gmail.com>
Cc:     bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/14 v4] PCI: Remove '*val = 0' from
 pcie_capability_read_*()
Message-ID: <20200714154941.GA396741@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714110445.32605-1-refactormyself@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 14, 2020 at 01:04:42PM +0200, Saheed Olayemi Bolarinwa wrote:
> From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
> ...

> Bolarinwa Olayemi Saheed (14):
>   IB/hfi1: Check the return value of pcie_capability_read_*()
>   misc: rtsx: Check the return value of pcie_capability_read_*()
>   ath9k: Check the return value of pcie_capability_read_*()
>   iwlegacy: Check the return value of pcie_capability_read_*()
>   PCI: pciehp: Check the return value of pcie_capability_read_*()
>   PCI: pciehp: Make "Power On" the default 
>   PCI: pciehp: Check the return value of pcie_capability_read_*()
>   PCI/ACPI: Check the return value of pcie_capability_read_*()
>   PCI: pciehp: Check the return value of pcie_capability_read_*()
>   PCI: Check the return value of pcie_capability_read_*()
>   PCI/PM: Check return value of pcie_capability_read_*()
>   PCI/AER: Check the return value of pcie_capability_read_*()
>   PCI/ASPM: Check the return value of pcie_capability_read_*()
>   PCI: Remove '*val = 0' from pcie_capability_read_*()

1) Let's slow down on posting patches.  We need time to think and have
a conversation about where we're going, and waking up to dozens of new
patches every day doesn't help.

2) This series claims to have 14 patches, but only 3 made it to the
list.  I don't know if the others were rejected for too many folks in
the cc: list or what.  If you only updated these 3, we will still want
the full set of 14 posted because it's too hard to collect 11 things
from v3 and 3 things from v4, etc.

  $ b4 am -om/ 20200714110445.32605-1-refactormyself@gmail.com
  Looking up https://lore.kernel.org/r/20200714110445.32605-1-refactormyself%40gmail.com
  Grabbing thread from lore.kernel.org/linux-kernel-mentees
  Analyzing 4 messages in the thread
  ---
  Thread incomplete, attempting to backfill
  Grabbing thread from lore.kernel.org/linux-rdma
  Grabbing thread from lore.kernel.org/lkml
  Grabbing thread from lore.kernel.org/linux-pci
  ---
  Writing m/v4_20200714_refactormyself_pci_remove_val_0_from_pcie_capability_read.mbx
    [PATCH 1/14 v4] IB/hfi1: Check the return value of pcie_capability_read_*()
    ERROR: missing [2/14]!
    ERROR: missing [3/14]!
    ERROR: missing [4/14]!
    ERROR: missing [5/14]!
    ERROR: missing [6/14]!
    ERROR: missing [7/14]!
    ERROR: missing [8/14]!
    ERROR: missing [9/14]!
    [PATCH 10/14 v4] PCI: Check return value of pcie_capability_read_*()
    [PATCH 11/14 v4] PCI/PM: Check return value of pcie_capability_read_*()
    ERROR: missing [12/14]!
    ERROR: missing [13/14]!
    ERROR: missing [14/14]!
  ---
  Total patches: 3
  ---
  WARNING: Thread incomplete!
  Cover: m/v4_20200714_refactormyself_pci_remove_val_0_from_pcie_capability_read.cover
   Link: https://lore.kernel.org/r/20200714110445.32605-1-refactormyself@gmail.com
   Base: not found
	 git am m/v4_20200714_refactormyself_pci_remove_val_0_from_pcie_capability_read.mbx

