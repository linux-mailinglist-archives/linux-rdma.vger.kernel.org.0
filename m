Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C36D41630E
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 13:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEGLsB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 May 2019 07:48:01 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:48890 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfEGLsB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 07:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1557229678; x=1588765678;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nBe0KSUCsY58JVyS0HBE+v4A3oVqKPg2S5aRwz2knrA=;
  b=VfPXtohZtwoeum3O3dRcsq7Cms+R40ZbbEvVvyexUloTROHn4t92FOHK
   dnwSMcnUotEkj/N465hvnfz0QjtSkAltZtMFO/V0cgEi7Sw2Y6Hu+dhWu
   5F4WEQpoRV7h7Ezg+NnKEnn7yiRMkVHq0G93Vc+X700jML7CejtJpzwLB
   U=;
X-IronPort-AV: E=Sophos;i="5.60,441,1549929600"; 
   d="scan'208";a="765068081"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 May 2019 11:47:56 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x47Blnls001391
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 May 2019 11:47:54 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 7 May 2019 11:47:54 +0000
Received: from [10.218.62.23] (10.43.160.175) by EX13D19EUB003.ant.amazon.com
 (10.43.166.69) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 7 May
 2019 11:47:46 +0000
Subject: Re: [PATCH for-next v7 00/11] RDMA/efa: Elastic Fabric Adapter (EFA)
 driver
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Doug Ledford <dledford@redhat.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Alexander Matushevsky <matua@amazon.com>,
        Leah Shalev <shalevl@amazon.com>,
        Dave Goodell <goodell@amazon.com>,
        Brian Barrett <bbarrett@amazon.com>,
        <linux-rdma@vger.kernel.org>, Sean Hefty <sean.hefty@intel.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Steve Wise <larrystevenwise@gmail.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
References: <1557079171-19329-1-git-send-email-galpress@amazon.com>
 <20190506182040.GC6201@ziepe.ca>
From:   Gal Pressman <galpress@amazon.com>
Message-ID: <f9265bb4-4e78-b20a-81ec-56ed1dc45893@amazon.com>
Date:   Tue, 7 May 2019 14:47:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506182040.GC6201@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.175]
X-ClientProxiedBy: EX13D12UWC003.ant.amazon.com (10.43.162.12) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 06-May-19 21:20, Jason Gunthorpe wrote:
> On Sun, May 05, 2019 at 08:59:20PM +0300, Gal Pressman wrote:
>> Hello all,
>> The following v7 patchset introduces the Amazon Elastic Fabric Adapter (EFA)
>> driver.
>>
>> EFA is a networking adapter designed to support user space network
>> communication, initially offered in the Amazon EC2 environment. First release
>> of EFA supports datagram send/receive operations and does not support
>> connection-oriented or read/write operations.
>>
>> EFA supports Unreliable Datagrams (UD) as well as a new unordered, Scalable
>> Reliable Datagram protocol (SRD). SRD provides support for reliable datagrams
>> and more complete error handling than typical RD, but, unlike RD, it does not
>> support ordering nor segmentation.
>>
>> EFA reliable datagram transport provides reliable out-of-order delivery,
>> transparently utilizing multiple network paths to reduce network tail
>> latency. Its interface is similar to UD, in particular it supports
>> message size up to MTU, with error handling extended to support reliable
>> communication. More information regarding SRD can be found at [1].
>>
>> Kernel verbs and in-kernel services are initially not supported but are planned
>> for future releases.
>>
>> EFA enabled EC2 instances have two different devices allocated, one for ENA
>> (netdev) and one for EFA, the two are separate pci devices with no in-kernel
>> communication between them.
>>
>> This patchset also introduces RDMA subsystem ibdev_* print helpers which should
>> be used by the other new drivers that are currently under review (irdma, siw)
>> and over time by all drivers in the subsystem.
>> The print format is similar to the netdev_* helpers.
>>
>> PR for rdma-core provider was sent:
>> https://github.com/linux-rdma/rdma-core/pull/475
>>
>> Thanks to everyone who took the time to review our last submissions (Jason, Doug,
>> Sean, Dennis, Leon, Christoph, Parav, Sagi, Steve, Shiraz), it is very
>> appreciated.
>>
>> Issues addressed in v7:
>> * Remove unused list field in mmap entry (Jason)
>> * Protect mmap xarray operations with a lock (Jason)
>> * Outstanding comments will be fixed in follow-up submission
>>
>> Issues addressed in v6:
>> * Remove BUG_ONs from __dynamic_ibdev_dbg
>> * Remove redundant udata checks (Leon)
>> * Remove rdma_user_mmap_page usage
>> * Remove umem->page_shift usage
>> * Make efa_destroy_qp_handle function static
>> * Misc prints cleanups
>>
>> Issues addressed in v5:
>> * Adapt to subsystem verbs API changes
>> * Remove unnecessary 'do ... while' in ibdev_dbg (Jason)
>> * Use a non-macro implementation for ibdev_dbg (Jason)
>> * Use for_each_sg_dma_page() in umem iterations (Jason)
>> * Remove unused enum value EFA_ADMIN_START_CMD_RANGE (Leon)
>> * Don't assume the sg element offset is zero (Jason)
>> * Cherry-picked Shiraz's new ib_umem_find_single_pg_size() work, encountered
>>   some issues, debugging with Shiraz off-list. Will convert to use his work once
>>   solved.
>>
>> Issues addressed in v4:
>> * Add RDMA subsystem ibdev_* printk helpers (Leon, Jason)
>> * Use xarray for mmap keys (Jason)
>> * Use module_pci_driver macro (Jason)
>> * Remove redundant cast in efa_remove (Jason)
>> * Avoid unnecessary use of pci_get_drvdata (Jason)
>> * Remove unnecessary admin queue sizes macros (Leon)
>> * Remove EFA_DEVICE_RUNNING bit (Leon, Jason)
>> * Remove incorrect comment in efa_com_validate_version (Leon)
>> * Keep lists sorted (Jason)
>> * Keep efa_com_dev as part of efa_dev instead of allocating it (Jason)
>>
>> Issues addressed in v3:
>> * Use new rdma_udata_to_drv_context API
>> * Adapt to new core ucontext allocations
>> * Remove EFA transport/protocol/node type and use unspecified instead (Leon, Jason)
>> * Replace stats lock with atomic variables (Leon, Jason, Steve)
>> * Remove vertical alignment from structs (Steve)
>> * Remove license text from ABI file (Leon)
>> * Undefine macro when it's no longer used (Steve)
>> * Fix kdoc formatting (Steve)
>> * Remove unneeded lock from reg read destroy flow (Steve)
>> * Prefer {} initializations over memset (Leon)
>> * Remove highmem WARN_ON_ONCE (Steve)
>> * ib_alloc_device returns NULL in case of error (Leon)
>> * Remove redundant check from remove remove device flow (Leon)
>> * Remove redundant zero assignments after memsets
>> * Remove unnecessary WARN_ON_ONCEs from create QP verbs (Steve)
>> * Remove redundant memsets (Steve, Shiraz)
>> * Change all non-privileged flows error prints to debug level (Steve, Leon, Jason, Shiraz)
>> * Remove likely/unlikelys from control path (Leon, Jason)
>> * Fixes to reg MR indirect flow wrong PAGE_SIZE usage (Jason)
>> * Use decimal array size in ABI file (Steve)
>> * Remove redundant comments (Steve, Shiraz)
>> * Change efa_verbs.c to GPL-2.0 OR Linux-OpenIB license (Leon, Jason)
>> * Replace WARN in admin completion processing with WARN_ONCE (Steve)
>>
>> Major issues addressed in this v2:
>> * Userspace libibverbs provider is implemented and attached for review.
>> * Respect the atomic requirement of create/destroy AH flows using the new
>>   sleepable flag [2].
>> * Change link layer from Ethernet to Unspecified (Proprietary EC2 link layer).
>> * Use RDMA mmap API.
>> * Coherent DMA memory is no longer mapped to the userspace, streaming DMA
>>   mappings are used instead.
>> * Introduce alloc/dealloc PD admin commands, PDs are now backed by an object on
>>   the device. This removes the bitmap used for PD number allocations.
>> * Addressed the mmap lifetime issues:
>>   Each ucontext now uses a new User Access Region (UAR) abstraction.
>>   Objects which are tied to a specific UAR will not be allocated to a different
>>   user until the UAR is deallocated (on application exit).
>>   DMA memory will be unmapped when the QP/CQ is destroyed, but the buffers will
>>   remain allocated until application exit.
>>   The mmap entries now remain valid until application exit and allow for reuse
>>   of the same mmap key more than once.
>> * SRD QP type is now a driver QP type (previously was IB_QPT_SRD).
>> * Match UD QP Infiniband semantics, including 40 bytes offset, state transitions,
>>   QKey validation, etc.
>> * Move AH reference counts to the device (previously was in the driver).
>>   When creating more than one AH with the same GID, the same device resource is
>>   used internally. Instead of keeping the reference count in the driver (and issue
>>   one create AH command only), each AH creation is now passed on to the device
>>   (accompanied with the PD number).
>>   This allows for future optimizations for AHs that are no longer used by a
>>   specific PD.
>> * Removed all stub functions, which will mark EFA driver as a non-kverbs provider [3].
>> * Replace all pr_* prints with dev_* prints
>>
>> [1] https://github.com/amzn/rdma-core/wiki/SRD
>> [2] https://patchwork.kernel.org/cover/10725727/
>> [3] https://patchwork.kernel.org/cover/10775039/
>>
>> Thanks,
>> Gal
>>
>> Gal Pressman (11):
>>   RDMA: Add EFA related definitions
>>   RDMA/efa: Add EFA device definitions
>>   RDMA/efa: Add the efa.h header file
>>   RDMA/efa: Add the efa_com.h file
>>   RDMA/efa: Add the com service API definitions
>>   RDMA/efa: Add the ABI definitions
>>   RDMA/efa: Implement functions that submit and complete admin commands
>>   RDMA/efa: Add common command handlers
>>   RDMA/efa: Add EFA verbs implementation
>>   RDMA/efa: Add the efa module
>>   RDMA/efa: Add driver to Kconfig/Makefile
> 
> I've tentatively applied this to for-next, pending your ack of my
> changes.

Thanks!
Other than the minor fixes I posted the changes looks good.

Acked-by: Gal Pressman <galpress@amazon.com>
