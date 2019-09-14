Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 712EAB2ADC
	for <lists+linux-rdma@lfdr.de>; Sat, 14 Sep 2019 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfINJrq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 Sep 2019 05:47:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfINJrq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 14 Sep 2019 05:47:46 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 608CE20693;
        Sat, 14 Sep 2019 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568454465;
        bh=o1C1eO0XQdj1YbvGrXjBSYKylVEgbJNTPOZGcdRTRG0=;
        h=Date:From:To:Cc:Subject:From;
        b=SlFvsOvC8hnWCiNiFh1dPTLmNHt4DUC71thWfCK7ukAo8OmodVKQFCFggWrmQpDNE
         7yfj/ZwjookpdlbXK/bUOxzXXsHZb7odDaACo/6wQkxAeGRmZuAckeHm02reG3wJb7
         xWPpsTP2JOIEoW5wa3PJngDX0TqZLhV6BkIs5ml4=
Date:   Sat, 14 Sep 2019 12:47:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     RDMA mailing list <linux-rdma@vger.kernel.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        linux-mm <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: 4th RDMA Microconference Summary
Message-ID: <20190914094730.GL6601@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

This is summary of 4th RDMA microconference co-located with Linux
Plumbers Conference 2019.

We would like to thank you for all presenters and attendees of our RDMA
track, it is you who made this event so successful.

Special thanks goes to Doug Ledford who volunteered to take notes
and Jason Gunthorpe who helped to run this event smoothly.

The original etherpad is located at [2] and below you will find the copy
of those notes:
------------------------------------------------------------------------------------------------
1. GUP and ZONE_DEVICE pages. [3]
   Jason Gunthorpe, John Hubbard and Don Dutile

 * Make the interface to use p2p mechanism be via sysfs. (PCI???).
 * Try to kill PTE flag for dev memory to make it easier to support
   on things like s390.
 * s390 will have mapping issues, arm/x86/PowerPC should be fine.
 * Looking to map partial BARs so they can be partitioned between
   different users.
 * Total BAR space could exceed 1TB in some scenarios
   (lots of GPUs in an HPC machine with persistent memory, etc.).
 * Initially use struct page element but try to remove it later.
 * Unlikely to be able to remove struct page, so maybe make it less painful
   by doing something like forcing all zone mappings to use hugepages ioctl no, sysfs yes.
 * PCI SIG talking about peer-2-peer too.
 * Distance might not be the best function name for the pci p2p checking function.
 * Conceptually, looking for new type of page fault, DMA fault, that will make a page
   visible to DMA even if we don’t care if it’s visible to the CPU GUP API makes really
   weak promise, no one could possibly think that it’s that weak, so everyone assumed
   it was stronger they were wrong.
 * It really is that weak wrappers around the GUP flags? 17+ flags currently,
   combinational matrix is extreme, some internal only flags can be abused by callers.
 * Possible to set "opposite" GUP flags.
 * Most (if not all) out of core code (drivers) get_user_pages users
   need same flags.

2. RDMA, File Systems, and DAX. [4]
   Ira Weiny
 * There was a bug in previous versions of patch set. It’s fixed.
 * New file_pin object to track relationship between mmaped files
   and DMA mappings to the underlying pages.
 * If owners of lease tries to do something that requires changes
   to the file layout: deadlock of application (current patch set, but not settled).
 * Write lease/fallocate/downgrade to read/unbreakable lease - fix race issue
   with fallocate and lease chicken and egg problem.

3. Discussion about IBNBD/IBTRS, upstreaming and action items. [5]
   Jinpu Wang, Danil Kipnis
 * IBTRS is standalone transfer engine that can be used with any ULP.
 * IBTRS only uses RDMA_WRITE with IMM and so is limited to fabrics
   that support this.
 * Server does not unmap after write from client so data can change
   when the server is flushing to disk.
 * Need to think about transfer model as the current one appears
   to be vulnerable to a nefarious kernel module.
 * It is worth to consider to unite 4 kernel modules to be 2 kernel
 * modules. One responsible for transfer (server + client) and another
   is responsible for block operations.
 * Security concern should be cleared first before in-depth review.
 * No objections to see IBTRS in kernel, but needs to be renamed to
   something more general, because it works on many fabrics and not only
   IB.

5. Improving RDMA performance through the use of contiguous memory and larger pages for files. [6]
   Christopher Lameter
 * The main problem is that contiguous physical memory being limited
   resource in real life systems. The difference in system performance
   so visible that it is worth to reboot servers every couple of days
   (depend on workload).
 * The reason to it, existence of unmovable pages.
 * HugePages help, but pinned objects over time end up breaking up the huge
   pages and eventually system flows down Need movable objects: dentry and inode
   are the big culprits.
 * Typical use case used to trigger degradation is copying both very large
   and very small files on the same machine.
 * Attempts to allocate unmovable pages in specific place causes to
   situations where system experiences OOM despite being enough memory.
 * x86 has 4K page size, while PowerPC has 64K. The bigger page size
   gives better performance, but wastes more memory for small objects.

4. Shared IB objects. [7]
   Yuval Shaia
 * There was lively discussion between various models of sharing
   objects, through file description, or uverbs context, or PD.
 * People would like to stick to the file handle model so you share
   the file handle and get everything you need as being simplest
   approach.
 * Is the security model resolved?  Right now, the model assumes trusted
   processes are allowed to share only.
 * Simple (FD) model creates challenge to properly release HW objects
   after main process exits and leaves HW objects which were in use by
   itself and not by shared processes.
 * Refcount needs to be in the API to track when the shared object is freeable
 * API requires shared memory first, then import PD and import MR.  This model
   (as opposed to sharing the fd of the in context), allows for safe cleanup on
   process death without interfering with other users of the shared PD/MR.

Thanks

[1] https://linuxplumbersconf.org/event/4/sessions/64/#20190911
[2] https://etherpad.net/p/LPC2019_RDMA
[3] https://www.linuxplumbersconf.org/event/4/contributions/369/
[4] https://linuxplumbersconf.org/event/4/contributions/368/
[5] https://linuxplumbersconf.org/event/4/contributions/367/
[6] https://linuxplumbersconf.org/event/4/contributions/371/
[7] https://www.linuxplumbersconf.org/event/4/contributions/371/
