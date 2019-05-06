Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D19E1538D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfEFSUn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 14:20:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36774 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEFSUn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 May 2019 14:20:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id a17so1766038qth.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2019 11:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=psHYvlJdY8jfUHW/bsnF8hDSPurtDNyOgUTr0xyRHd4=;
        b=Ku7XhhVyMS84trjQ3hjP724IibHYJ5qrrKkIp9dFNij3R8hNc4v/fOF6zv17Zhe2hY
         RHnXCq+ndAoQpdCeZl0GO3TvftjO0oFaQY+snj/p0g63hlhKYebuGKU/AxIk+nF+NPBI
         FkLDIKV/+6TPDR3yKf7wVYTENzAc6jDXe2751v2HrRlLBOlRGP3zx0gSlL2rxCC7/NcC
         t9RdTZeY2x80mkMukliNe+IF1hyXgIx8M1X8MdaLEcf1J/bdUrG73d1mKHxMkfqpAavE
         JgF63GbTH7fDdDLONMI5cs1EqKQm858r3PMNSSUDT8AOJt1VvyBeUmKkWrFxXU0iHin3
         /9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=psHYvlJdY8jfUHW/bsnF8hDSPurtDNyOgUTr0xyRHd4=;
        b=XsLi/WMghjzrhPKc37C/Wj8qAQNUdoteza9UKtgNBFS5drS2PA7+CNYddoLxWhypx0
         xqAJOf/HgNztI2vAeQo4Pzk2dyedwcJHXPJTaSRrC8jIQy1I1p5KxqV73aAFwuBYZz/O
         lNwudJ0/c6y8r/en1SaLAaYzbRrf//dewmQp8dw+b1y5BntbaW1MkvO85oO21Ies9UhJ
         KvlBUiFr9if02kmNb2kaIeuLfZDa2Vq1izt9QAjectUGsaGtXiAYIwRUbvs/oLpxbnt+
         TzMX5/ilAWrQV20H5QNdUIOS427pHeW0hZUZtdE82PdbxpS52AP6GrkpUHJTBdgMkpHL
         ODMQ==
X-Gm-Message-State: APjAAAXgodhLEoG7DlioY+XXlO5lNjYY3mE/CoSs4Eq767FsKitAM3Eq
        ynqz3mviyQfHMk+7x2Fxx+Cg7g==
X-Google-Smtp-Source: APXvYqxzn06cGjgWtE1HGRXQJHvdTDKMchBUxkQaZawaD+JSUgvzncPuhkvCFr98AVSg1290uq/LIw==
X-Received: by 2002:a05:6214:327:: with SMTP id j7mr8296859qvu.53.1557166841780;
        Mon, 06 May 2019 11:20:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id d8sm3726191qtd.2.2019.05.06.11.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 11:20:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hNiEC-0006sj-7o; Mon, 06 May 2019 15:20:40 -0300
Date:   Mon, 6 May 2019 15:20:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next v7 00/11] RDMA/efa: Elastic Fabric Adapter (EFA)
 driver
Message-ID: <20190506182040.GC6201@ziepe.ca>
References: <1557079171-19329-1-git-send-email-galpress@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557079171-19329-1-git-send-email-galpress@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, May 05, 2019 at 08:59:20PM +0300, Gal Pressman wrote:
> Hello all,
> The following v7 patchset introduces the Amazon Elastic Fabric Adapter (EFA)
> driver.
> 
> EFA is a networking adapter designed to support user space network
> communication, initially offered in the Amazon EC2 environment. First release
> of EFA supports datagram send/receive operations and does not support
> connection-oriented or read/write operations.
> 
> EFA supports Unreliable Datagrams (UD) as well as a new unordered, Scalable
> Reliable Datagram protocol (SRD). SRD provides support for reliable datagrams
> and more complete error handling than typical RD, but, unlike RD, it does not
> support ordering nor segmentation.
> 
> EFA reliable datagram transport provides reliable out-of-order delivery,
> transparently utilizing multiple network paths to reduce network tail
> latency. Its interface is similar to UD, in particular it supports
> message size up to MTU, with error handling extended to support reliable
> communication. More information regarding SRD can be found at [1].
> 
> Kernel verbs and in-kernel services are initially not supported but are planned
> for future releases.
> 
> EFA enabled EC2 instances have two different devices allocated, one for ENA
> (netdev) and one for EFA, the two are separate pci devices with no in-kernel
> communication between them.
> 
> This patchset also introduces RDMA subsystem ibdev_* print helpers which should
> be used by the other new drivers that are currently under review (irdma, siw)
> and over time by all drivers in the subsystem.
> The print format is similar to the netdev_* helpers.
> 
> PR for rdma-core provider was sent:
> https://github.com/linux-rdma/rdma-core/pull/475
> 
> Thanks to everyone who took the time to review our last submissions (Jason, Doug,
> Sean, Dennis, Leon, Christoph, Parav, Sagi, Steve, Shiraz), it is very
> appreciated.
> 
> Issues addressed in v7:
> * Remove unused list field in mmap entry (Jason)
> * Protect mmap xarray operations with a lock (Jason)
> * Outstanding comments will be fixed in follow-up submission
> 
> Issues addressed in v6:
> * Remove BUG_ONs from __dynamic_ibdev_dbg
> * Remove redundant udata checks (Leon)
> * Remove rdma_user_mmap_page usage
> * Remove umem->page_shift usage
> * Make efa_destroy_qp_handle function static
> * Misc prints cleanups
> 
> Issues addressed in v5:
> * Adapt to subsystem verbs API changes
> * Remove unnecessary 'do ... while' in ibdev_dbg (Jason)
> * Use a non-macro implementation for ibdev_dbg (Jason)
> * Use for_each_sg_dma_page() in umem iterations (Jason)
> * Remove unused enum value EFA_ADMIN_START_CMD_RANGE (Leon)
> * Don't assume the sg element offset is zero (Jason)
> * Cherry-picked Shiraz's new ib_umem_find_single_pg_size() work, encountered
>   some issues, debugging with Shiraz off-list. Will convert to use his work once
>   solved.
> 
> Issues addressed in v4:
> * Add RDMA subsystem ibdev_* printk helpers (Leon, Jason)
> * Use xarray for mmap keys (Jason)
> * Use module_pci_driver macro (Jason)
> * Remove redundant cast in efa_remove (Jason)
> * Avoid unnecessary use of pci_get_drvdata (Jason)
> * Remove unnecessary admin queue sizes macros (Leon)
> * Remove EFA_DEVICE_RUNNING bit (Leon, Jason)
> * Remove incorrect comment in efa_com_validate_version (Leon)
> * Keep lists sorted (Jason)
> * Keep efa_com_dev as part of efa_dev instead of allocating it (Jason)
> 
> Issues addressed in v3:
> * Use new rdma_udata_to_drv_context API
> * Adapt to new core ucontext allocations
> * Remove EFA transport/protocol/node type and use unspecified instead (Leon, Jason)
> * Replace stats lock with atomic variables (Leon, Jason, Steve)
> * Remove vertical alignment from structs (Steve)
> * Remove license text from ABI file (Leon)
> * Undefine macro when it's no longer used (Steve)
> * Fix kdoc formatting (Steve)
> * Remove unneeded lock from reg read destroy flow (Steve)
> * Prefer {} initializations over memset (Leon)
> * Remove highmem WARN_ON_ONCE (Steve)
> * ib_alloc_device returns NULL in case of error (Leon)
> * Remove redundant check from remove remove device flow (Leon)
> * Remove redundant zero assignments after memsets
> * Remove unnecessary WARN_ON_ONCEs from create QP verbs (Steve)
> * Remove redundant memsets (Steve, Shiraz)
> * Change all non-privileged flows error prints to debug level (Steve, Leon, Jason, Shiraz)
> * Remove likely/unlikelys from control path (Leon, Jason)
> * Fixes to reg MR indirect flow wrong PAGE_SIZE usage (Jason)
> * Use decimal array size in ABI file (Steve)
> * Remove redundant comments (Steve, Shiraz)
> * Change efa_verbs.c to GPL-2.0 OR Linux-OpenIB license (Leon, Jason)
> * Replace WARN in admin completion processing with WARN_ONCE (Steve)
> 
> Major issues addressed in this v2:
> * Userspace libibverbs provider is implemented and attached for review.
> * Respect the atomic requirement of create/destroy AH flows using the new
>   sleepable flag [2].
> * Change link layer from Ethernet to Unspecified (Proprietary EC2 link layer).
> * Use RDMA mmap API.
> * Coherent DMA memory is no longer mapped to the userspace, streaming DMA
>   mappings are used instead.
> * Introduce alloc/dealloc PD admin commands, PDs are now backed by an object on
>   the device. This removes the bitmap used for PD number allocations.
> * Addressed the mmap lifetime issues:
>   Each ucontext now uses a new User Access Region (UAR) abstraction.
>   Objects which are tied to a specific UAR will not be allocated to a different
>   user until the UAR is deallocated (on application exit).
>   DMA memory will be unmapped when the QP/CQ is destroyed, but the buffers will
>   remain allocated until application exit.
>   The mmap entries now remain valid until application exit and allow for reuse
>   of the same mmap key more than once.
> * SRD QP type is now a driver QP type (previously was IB_QPT_SRD).
> * Match UD QP Infiniband semantics, including 40 bytes offset, state transitions,
>   QKey validation, etc.
> * Move AH reference counts to the device (previously was in the driver).
>   When creating more than one AH with the same GID, the same device resource is
>   used internally. Instead of keeping the reference count in the driver (and issue
>   one create AH command only), each AH creation is now passed on to the device
>   (accompanied with the PD number).
>   This allows for future optimizations for AHs that are no longer used by a
>   specific PD.
> * Removed all stub functions, which will mark EFA driver as a non-kverbs provider [3].
> * Replace all pr_* prints with dev_* prints
> 
> [1] https://github.com/amzn/rdma-core/wiki/SRD
> [2] https://patchwork.kernel.org/cover/10725727/
> [3] https://patchwork.kernel.org/cover/10775039/
> 
> Thanks,
> Gal
> 
> Gal Pressman (11):
>   RDMA: Add EFA related definitions
>   RDMA/efa: Add EFA device definitions
>   RDMA/efa: Add the efa.h header file
>   RDMA/efa: Add the efa_com.h file
>   RDMA/efa: Add the com service API definitions
>   RDMA/efa: Add the ABI definitions
>   RDMA/efa: Implement functions that submit and complete admin commands
>   RDMA/efa: Add common command handlers
>   RDMA/efa: Add EFA verbs implementation
>   RDMA/efa: Add the efa module
>   RDMA/efa: Add driver to Kconfig/Makefile

I've tentatively applied this to for-next, pending your ack of my
changes.

Thanks,
Jason
