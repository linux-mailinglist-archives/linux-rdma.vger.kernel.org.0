Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC7D1901B0
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 00:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCWXOf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Mar 2020 19:14:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:35768 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbgCWXOe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Mar 2020 19:14:34 -0400
IronPort-SDR: nVKgdx6rfLM8RlVmrjv02pszifncOyrIre8U0b3sf/9dBaBe0YzNIFKql7pMlaNKUVUXSUVsYR
 3XksYbV8iSPw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:14:31 -0700
IronPort-SDR: YxqIF19vTvDTouhwl9GshlD5WnjXkmR7U3spah5sxn7wtR12LiGVcu7KkY7hxZmIe6kIv3x5jp
 SypBG8BWN0OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="357240685"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga001.fm.intel.com with ESMTP; 23 Mar 2020 16:14:31 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02NNETV9013894;
        Mon, 23 Mar 2020 16:14:30 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02NNER1m064334;
        Mon, 23 Mar 2020 19:14:28 -0400
Subject: [PATCH v2 for-next 00/16] New hfi1 feature: Accelerated IP
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org
Date:   Mon, 23 Mar 2020 19:14:27 -0400
Message-ID: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
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
