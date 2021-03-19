Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB92341D83
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Mar 2021 13:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCSM4n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Mar 2021 08:56:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:4853 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhCSM4i (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Mar 2021 08:56:38 -0400
IronPort-SDR: HkmtEUu+0eHGH5g4BF3recpOe4SMqnSPq8vUiwyJjtf/2AejL3/aIt8t3w+PxPwvXheQUkB9gd
 FqBAToY7NIvQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="209910276"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="209910276"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 05:56:38 -0700
IronPort-SDR: M5NVqRYOMauslQmcloRZQW2ZZ+In3zDaqgHJ0fWZbYNImEjMDbmzXh7dz7y+Nm8LrVn8looK+0
 9B1KqKfke1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; 
   d="scan'208";a="450851694"
Received: from phwfstl014.hd.intel.com ([10.127.241.142])
  by orsmga001.jf.intel.com with ESMTP; 19 Mar 2021 05:56:35 -0700
From:   kaike.wan@intel.com
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org, todd.rimmer@intel.com,
        Kaike Wan <kaike.wan@intel.com>
Subject: [PATCH RFC 0/9] A rendezvous module
Date:   Fri, 19 Mar 2021 08:56:26 -0400
Message-Id: <20210319125635.34492-1-kaike.wan@intel.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

RDMA transactions on RC QPs have a high demand for memory for HPC
applications such as MPI, especially on nodes with high cpu core
count, where a process is normally dispatched to each core and an RC QP
is created for each remote process. For a 100-node fabric,
about 10 GB - 100 GB memory is required for WQEs/Buffers/QP states on
each server node. This high demand imposes a severe restriction
on the scalability of HPC fabric.

A number of solutions have been implemented over the years. UD based
solutions solve the scalability problem by requiring only one UD
QP per process that can send a message to or receive a message from any
other process. However, it does not have the performance of an
RC QP and the application has to manage the segmentation for large
messages.

SRQ reduces the memory demand by sharing a receive queue among multiple
QPs. However, it still requires an RC QP for each remote
process and each RC QP still requires a send queue. In addition, it is
an optional feature.

XRC further reduces the memory demand by allowing a single QP per
process to communicate with any process on a remote node. In this
mode, each process requires only one QP for each remote node. Again,
this is optional and not all vendors support it.

Dynamically Connected transport minimizes the memory usage, but requires
vendor specific hardware and changes in applications.
Addtionally, all of these mechanisms can induce latency jitter due to
use of more QPs, more QP state, and hence additional
PCIe transactions at scale where NIC QP/CQ caches overflow.

Based on this, we are here proposing a generic, vendor-agnostic approach
to address the RC scalalibity and potentially improve RDMA
performance for larger messages which uses RDMA Write as part of a
rendezvous protocol.

Here are the key points of the proposal:
- For each device used by a job on a given node, there are a fixed
  number of RC connections (default: 4) between this node and any
  other remote node, no matter how many processes are running on each
  node for this job. That is, for a given job and device, all the
  processes on a given node will communicate with all the processes of
  the same job on a remote node through the same fixed number of
  connections. This eliminates the increased memory demand caused by
  core count increase and reduces the overall RC connection setup
  costs.
- Memory region cache is added to reduce the MR
  registration/deregistration costs, as the same buffers tend to be used
  repeatedly by applications. The mr cache is per process and can be
  accessed only by processes in the same job.

Here is how we are proposing to implement this application enabling
rendezvous module that take advantage of the various features
of the RDMA subsystem:
- Create a rendezvous module (rv) under drivers/infiniband/ulp/rv/. This
  can be changed if a better location is recommended.
- The rv modules adds a char device file /dev/rv that user
  applications/middlewares can open to communicate with the rv module
  (PSM3 OFI provider in libfabric 1.12.0 being the primary use case).
  The file interface is crucial for associating the job/process
  with the mr, the connection endpoints, and RDMA requests.
  rv_file_open - Open a handle to the rv module for the current user
                 process.
  rv_file_close - Close the handle and clean up.
  rv_file_ioctl - The main communication methods: to attach to a device,
                  to register/deregister mr, to create connection
                  endpoint, to connect, to query, to get stats, to do
                  RDMA transactions, etc.
  rv_file_mmap - Mmap an event ring into user space for the current user
                 process.
- Basic mode of operations (PSM3 is used as an example for user
  applications):
  - A middleware (like MPI) has out-of-band communication channels
    between any two nodes, which are used to establish high performance
    communications for providers such as PSM3.
  - On each node, the PSM3 provider opens the rv module, and issues an
    attach request to bind to a specific local device and specifies
    information specific to the job. This associates the user process
    with the RDMA device and the job.
  - On each node, the PSM3 provider will establish user space low
    latency eager and control message communications, typically via user
    space UD QPs.
  - On each node, the PSM3 provider will mmap a ring buffer for events
    from the rv module.
  - On each node, the PSM3 provider creates a set of connection
    endpoints by passing the destination info to the rv module. If the
    local node is chosen as the listener for the connection (based on
    address comparison between the two nodes), it will start to listen
    for any incoming IB CM connection requests and accept them when whey
    arrive. This step associates the shared connection endpoints with
    the job and device.
  - On each node, the PSM3 provider will request connection
    establishment through the rv module. On the client node, rv sends an
    IB CM request to the remote node. On the listener node, nothing
    additional needs to be done for the connect request from the PSM3
    provider.
  - On each node, the PSM3 provider will wait until the RC connection is
    established. The PSM3 provider will query the rv module about the
    connection status periodically.
  - As large MPI messages are requested, the PSM3 provider will request
    rv to register MRs for the MPI application’s send and receive
    buffers.  The rv module makes use of its MR cache to limit when such
    requests need to interact with verbs MR calls for the NIC.
    The PSM3 provider control message mechanisms are used to exchange IO
    virtual addresses and rkeys for such buffers and MRs.
  - For RDMA transactions, the RDMA WRITE WITH IMMED request will be
    used. The immediate data will contain info about the target
    process on the remote node  and which outstanding rendezvous message
    this RDMA is for. For send completion and receive completion,
    an event will be posted into the event ring buffer and the PSM3
    provider can poll for completion.
  - As RDMA transactions complete, the PSM3 provider will indicate
    completion of the corresponding MPI send/receive to the MPI
    middleware/application. The PSM3 provider will also inform the rv
    module it may deregister the MR.  The deregistration allows rv
    to cache the MR for use in future requests by the PSM3 provider to
    register the same memory for use in another MPI message. The
    cached MR will be removed if the user buffer is freed and a MMU
    notifier event is received by the rv module.

Please comment,

Thank you,

Kaike

Kaike Wan (9):
  RDMA/rv: Public interferce for the RDMA Rendezvous module
  RDMA/rv: Add the internal header files
  RDMA/rv: Add the rv module
  RDMA/rv: Add functions for memory region cache
  RDMA/rv: Add function to register/deregister memory region
  RDMA/rv: Add connection management functions
  RDMA/rv: Add functions for RDMA transactions
  RDMA/rv: Add functions for file operations
  RDMA/rv: Integrate the file operations into the rv module

 MAINTAINERS                                |    6 +
 drivers/infiniband/Kconfig                 |    1 +
 drivers/infiniband/core/core_priv.h        |    4 +
 drivers/infiniband/core/rdma_core.c        |  237 ++
 drivers/infiniband/core/uverbs_cmd.c       |   54 +-
 drivers/infiniband/ulp/Makefile            |    1 +
 drivers/infiniband/ulp/rv/Kconfig          |   11 +
 drivers/infiniband/ulp/rv/Makefile         |    9 +
 drivers/infiniband/ulp/rv/rv.h             |  892 ++++++
 drivers/infiniband/ulp/rv/rv_conn.c        | 3037 ++++++++++++++++++++
 drivers/infiniband/ulp/rv/rv_file.c        | 1196 ++++++++
 drivers/infiniband/ulp/rv/rv_main.c        |  271 ++
 drivers/infiniband/ulp/rv/rv_mr.c          |  393 +++
 drivers/infiniband/ulp/rv/rv_mr_cache.c    |  428 +++
 drivers/infiniband/ulp/rv/rv_mr_cache.h    |  152 +
 drivers/infiniband/ulp/rv/rv_rdma.c        |  416 +++
 drivers/infiniband/ulp/rv/trace.c          |    7 +
 drivers/infiniband/ulp/rv/trace.h          |   10 +
 drivers/infiniband/ulp/rv/trace_conn.h     |  547 ++++
 drivers/infiniband/ulp/rv/trace_dev.h      |   82 +
 drivers/infiniband/ulp/rv/trace_mr.h       |  109 +
 drivers/infiniband/ulp/rv/trace_mr_cache.h |  181 ++
 drivers/infiniband/ulp/rv/trace_rdma.h     |  254 ++
 drivers/infiniband/ulp/rv/trace_user.h     |  321 +++
 include/rdma/uverbs_types.h                |   10 +
 include/uapi/rdma/rv_user_ioctls.h         |  558 ++++
 26 files changed, 9139 insertions(+), 48 deletions(-)
 create mode 100644 drivers/infiniband/ulp/rv/Kconfig
 create mode 100644 drivers/infiniband/ulp/rv/Makefile
 create mode 100644 drivers/infiniband/ulp/rv/rv.h
 create mode 100644 drivers/infiniband/ulp/rv/rv_conn.c
 create mode 100644 drivers/infiniband/ulp/rv/rv_file.c
 create mode 100644 drivers/infiniband/ulp/rv/rv_main.c
 create mode 100644 drivers/infiniband/ulp/rv/rv_mr.c
 create mode 100644 drivers/infiniband/ulp/rv/rv_mr_cache.c
 create mode 100644 drivers/infiniband/ulp/rv/rv_mr_cache.h
 create mode 100644 drivers/infiniband/ulp/rv/rv_rdma.c
 create mode 100644 drivers/infiniband/ulp/rv/trace.c
 create mode 100644 drivers/infiniband/ulp/rv/trace.h
 create mode 100644 drivers/infiniband/ulp/rv/trace_conn.h
 create mode 100644 drivers/infiniband/ulp/rv/trace_dev.h
 create mode 100644 drivers/infiniband/ulp/rv/trace_mr.h
 create mode 100644 drivers/infiniband/ulp/rv/trace_mr_cache.h
 create mode 100644 drivers/infiniband/ulp/rv/trace_rdma.h
 create mode 100644 drivers/infiniband/ulp/rv/trace_user.h
 create mode 100644 include/uapi/rdma/rv_user_ioctls.h

-- 
2.18.1

