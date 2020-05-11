Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E201CDFE9
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgEKQFk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 12:05:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:42580 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbgEKQFj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 12:05:39 -0400
IronPort-SDR: TtDd4M+PMU/SKHJZbv9KVVcwCEzVzspSIctz5hTq0xPgCLNAR3CW/eN2CvUQF20wgKfJv7liZo
 SaGGcrqY0JhA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:05:39 -0700
IronPort-SDR: +M/FMV2S+bIxPh0Zaxk6j6pQoC9ZqratJeaPUy38aOSJsXUst5C09aYkBBucwOa3GWQJoTr7R3
 Cw+YQOTKWQmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="408965921"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2020 09:05:38 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 04BG5btV061640;
        Mon, 11 May 2020 09:05:37 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 04BG5ZEA174028;
        Mon, 11 May 2020 12:05:35 -0400
Subject: [PATCH v3 for-next 00/16] New hfi1 feature: Accelerated IP
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 11 May 2020 12:05:35 -0400
Message-ID: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This patch series is an accelerated ipoib using the rdma netdev mechanism
already present in ipoib. A new device capability bit,
IB_DEVICE_RDMA_NETDEV_OPA, triggers ipoib to create a datagram QP using the
IB_QP_CREATE_NETDEV_USE.

The highlights include:
- Sharing send and receive resources with VNIC
- Allows for switching between connected mode and datagram mode
- Increases the maximum datagram MTU for opa devices to 10k

The same spreading capability exploited by VNIC is used here to vary
the receive context that receives the packet.

The patches are fully bisectable and stepwise implement the capability.

changes since v2
----------------
*Rebased ontop of latest rdma/for-next

Changes since v1
----------------
*Fix incorrect parameter to xa_find() in patch 9
*Address Erez comments and try to hide opa from ipoib in patch 7
*Fix some typos in RB lines

---

Gary Leshner (6):
      IB/hfi1: Add functions to transmit datagram ipoib packets
      IB/hfi1: Add the transmit side of a datagram ipoib RDMA netdev
      IB/hfi1: Remove module parameter for KDETH qpns
      IB/{rdmavt,hfi1}: Implement creation of accelerated UD QPs
      IB/{hfi1,ipoib,rdma}: Broadcast ping sent packets which exceeded mtu size
      IB/ipoib: Add capability to switch between datagram and connected mode

Grzegorz Andrejczuk (6):
      IB/hfi1: RSM rules for AIP
      IB/hfi1: Rename num_vnic_contexts as num_netdev_contexts
      IB/hfi1: Add interrupt handler functions for accelerated ipoib
      IB/hfi1: Add rx functions for dummy netdev
      IB/hfi1: Activate the dummy netdev
      IB/hfi1: Add packet histogram trace event

Kaike Wan (3):
      IB/hfi1: Add accelerated IP capability bit
      IB/ipoib: Increase ipoib Datagram mode MTU's upper limit
      IB/hfi1: Add functions to receive accelerated ipoib packets

Piotr Stankiewicz (1):
      IB/hfi1: Enable the transmit side of the datagram ipoib netdev


 drivers/infiniband/hw/hfi1/Makefile            |    4 
 drivers/infiniband/hw/hfi1/affinity.c          |   12 
 drivers/infiniband/hw/hfi1/affinity.h          |    3 
 drivers/infiniband/hw/hfi1/chip.c              |  303 ++++++---
 drivers/infiniband/hw/hfi1/chip.h              |    5 
 drivers/infiniband/hw/hfi1/common.h            |   13 
 drivers/infiniband/hw/hfi1/driver.c            |  231 ++++++-
 drivers/infiniband/hw/hfi1/file_ops.c          |    4 
 drivers/infiniband/hw/hfi1/hfi.h               |   38 -
 drivers/infiniband/hw/hfi1/init.c              |   13 
 drivers/infiniband/hw/hfi1/ipoib.h             |  171 +++++
 drivers/infiniband/hw/hfi1/ipoib_main.c        |  309 +++++++++
 drivers/infiniband/hw/hfi1/ipoib_rx.c          |   95 +++
 drivers/infiniband/hw/hfi1/ipoib_tx.c          |  828 ++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/msix.c              |   36 +
 drivers/infiniband/hw/hfi1/msix.h              |    7 
 drivers/infiniband/hw/hfi1/netdev.h            |  118 +++
 drivers/infiniband/hw/hfi1/netdev_rx.c         |  484 ++++++++++++++
 drivers/infiniband/hw/hfi1/qp.c                |   18 -
 drivers/infiniband/hw/hfi1/tid_rdma.c          |    4 
 drivers/infiniband/hw/hfi1/trace.c             |   42 +
 drivers/infiniband/hw/hfi1/trace_ctxts.h       |   11 
 drivers/infiniband/hw/hfi1/verbs.c             |   13 
 drivers/infiniband/hw/hfi1/vnic.h              |    5 
 drivers/infiniband/hw/hfi1/vnic_main.c         |  318 ++-------
 drivers/infiniband/sw/rdmavt/qp.c              |   24 +
 drivers/infiniband/ulp/ipoib/ipoib_main.c      |   22 -
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c |   12 
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c     |    3 
 drivers/infiniband/ulp/ipoib/ipoib_vlan.c      |    3 
 include/rdma/ib_verbs.h                        |   82 ++
 include/rdma/opa_port_info.h                   |   10 
 include/rdma/opa_vnic.h                        |    4 
 include/rdma/rdmavt_qp.h                       |   29 +
 include/uapi/rdma/hfi/hfi1_user.h              |    3 
 35 files changed, 2784 insertions(+), 493 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/ipoib.h
 create mode 100644 drivers/infiniband/hw/hfi1/ipoib_main.c
 create mode 100644 drivers/infiniband/hw/hfi1/ipoib_rx.c
 create mode 100644 drivers/infiniband/hw/hfi1/ipoib_tx.c
 create mode 100644 drivers/infiniband/hw/hfi1/netdev.h
 create mode 100644 drivers/infiniband/hw/hfi1/netdev_rx.c

--
-Denny
