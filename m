Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BACFB3721E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 12:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFFKxv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 06:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfFFKxv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 06:53:51 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B9A20868;
        Thu,  6 Jun 2019 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559818430;
        bh=/gSP2lhNpSTkdeiWfkDtSEA/LdOyJxM9B0gPE6kezl4=;
        h=From:To:Cc:Subject:Date:From;
        b=bOv6LDS7gWVHcmKVT2kw/vYBRWlZ4S6JCQBCjgiNrqFFmBCX7avOJBaWjTzKf8pl8
         fi/leuwFWOfDIuVHJgbuGGXz0pWmNlVcAXECB9wsLVott7xHE7HxY4keFr/1njqkED
         z4/AaOmKy2Sc2mi+9z6wu6dd57jz6VsHzO4K8CKU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next v3 00/17] Statistics counter support
Date:   Thu,  6 Jun 2019 13:53:28 +0300
Message-Id: <20190606105345.8546-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Changelog:
 v2 -> v3:
 * We didn't change use of atomics over kref for management of unbind
   counter from QP. The reason to it that bind and unbind are non-symmetric
   in regards of put and get, so we need to count differently memory
   release flows of HW objects (restrack) and SW bind operations.
 * Everything else was addressed.
 v1 -> v2:
 * Rebased to latest rdma-next
 v0 -> v1:
 * Changed wording of counter comment
 * Removed unneeded assignments
 * Added extra patch to present global counters

 * I didn't change QP type from int to be enum ib_qp_type,
   because it caused to cyclic dependency between ib_verbs.h and
   rdma_counter.h.

----------------------------------------------------
Hi,

This series from Mark provides dynamic statistics infrastructure.
He uses netlink interface to configure and retrieve those counters.

This infrastructure allows to users monitor various objects by binding
to them counters. As the beginning, we used QP object as target for
those counters, but future patches will include ODP MR information too.

Two binding modes are supported:
 - Auto: This allows a user to build automatic set of objects to a counter
   according to common criteria. For example in a per-type scheme, where in
   one process all QPs with same QP type are bound automatically to a single
   counter.
 - Manual: This allows a user to manually bind objects on a counter.

Those two modes are mutual-exclusive with separation between processes,
objects created by different processes cannot be bound to a same counter.

For objects which don't support counter binding, we will return
pre-allocated counters.

$ rdma statistic qp set link mlx5_2/1 auto type on
$ rdma statistic qp mode
2/1: mlx5_2/1: qp auto type on
3/1: mlx5_3/1: qp auto off

$ rdma statistic qp set link mlx5_2/1 auto off
$ rdma statistic qp bind link mlx5_2/1 lqpn 178
$ rdma statistic qp unbind link mlx5_2/1 cntn 4 lqpn 178
$ rdma statistic show
link mlx5_2/1 rx_write_requests 0 rx_read_requests 0 rx_atomic_requests
0 out_of_buffer 0 out_of_sequence 0 duplicate_request 0
rnr_nak_retry_err 0 packet_seq_err 0 implied_nak_seq_err 0
local_ack_timeout_err 0 resp_local_length_error 0 resp_cqe_error 0
req_cqe_error 0 req_remote_invalid_request 0 req_remote_access_errors 0
resp_remote_access_errors 0 resp_cqe_flush_error 0 req_cqe_flush_error 0
rp_cnp_ignored 0 rp_cnp_handled 0 np_ecn_marked_roce_packets 0
np_cnp_sent 0 rx_icrc_encapsulated 0
link mlx5_3/1 rx_write_requests 0 rx_read_requests 0 rx_atomic_requests
0 out_of_buffer 0 out_of_sequence 0 duplicate_request 0
rnr_nak_retry_err 0 packet_seq_err 0 implied_nak_seq_err 0
local_ack_timeout_err 0 resp_local_length_error 0 resp_cqe_error 0
req_cqe_error 0 req_remote_invalid_request 0 req_remote_access_errors 0
resp_remote_access_errors 0 resp_cqe_flush_error 0 req_cqe_flush_error 0
rp_cnp_ignored 0 rp_cnp_handled 0 np_ecn_marked_roce_packets 0
np_cnp_sent 0 rx_icrc_encapsulated 0

$ rdma statistic qp show
link mlx5_2/1 cntn 4 pid 9829 comm ib_send_bw rx_write_requests 0
rx_read_requests 0 rx_atomic_requests 0 out_of_buffer 0 out_of_sequence
0 duplicate_request 0 rnr_nak_retry_err 0 packet_seq_err 0
implied_nak_seq_err 0 local_ack_timeout_err 0 resp_local_length_error 0
resp_cqe_error 0 req_cqe_error 0 req_remote_invalid_request 0
req_remote_access_errors 0 resp_remote_access_errors 0
resp_cqe_flush_error 0 req_cqe_flush_error 0
LQPN: <258>

Thanks

Mark Zhang (17):
  net/mlx5: Add rts2rts_qp_counters_set_id field in hca cap
  RDMA/restrack: Introduce statistic counter
  RDMA/restrack: Add an API to attach a task to a resource
  RDMA/restrack: Make is_visible_in_pid_ns() as an API
  RDMA/counter: Add set/clear per-port auto mode support
  RDMA/counter: Add "auto" configuration mode support
  IB/mlx5: Support set qp counter
  IB/mlx5: Add counter set id as a parameter for
    mlx5_ib_query_q_counters()
  IB/mlx5: Support statistic q counter configuration
  RDMA/nldev: Allow counter auto mode configration through RDMA netlink
  RDMA/netlink: Implement counter dumpit calback
  IB/mlx5: Add counter_alloc_stats() and counter_update_stats() support
  RDMA/core: Get sum value of all counters when perform a sysfs stat
    read
  RDMA/counter: Allow manual mode configuration support
  RDMA/nldev: Allow counter manual mode configration through RDMA
    netlink
  RDMA/nldev: Allow get counter mode through RDMA netlink
  RDMA/nldev: Allow get default counter statistics through RDMA netlink

 drivers/infiniband/core/Makefile     |   2 +-
 drivers/infiniband/core/counters.c   | 636 +++++++++++++++++++++++++++
 drivers/infiniband/core/device.c     |  11 +-
 drivers/infiniband/core/nldev.c      | 517 +++++++++++++++++++++-
 drivers/infiniband/core/restrack.c   |  49 ++-
 drivers/infiniband/core/restrack.h   |   3 +
 drivers/infiniband/core/sysfs.c      |  16 +-
 drivers/infiniband/core/verbs.c      |   9 +
 drivers/infiniband/hw/mlx5/main.c    |  86 +++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   6 +
 drivers/infiniband/hw/mlx5/qp.c      |  76 +++-
 include/linux/mlx5/mlx5_ifc.h        |   4 +-
 include/linux/mlx5/qp.h              |   1 +
 include/rdma/ib_verbs.h              |  30 ++
 include/rdma/rdma_counter.h          |  65 +++
 include/rdma/restrack.h              |   4 +
 include/uapi/rdma/rdma_netlink.h     |  52 ++-
 17 files changed, 1535 insertions(+), 32 deletions(-)
 create mode 100644 drivers/infiniband/core/counters.c
 create mode 100644 include/rdma/rdma_counter.h

--
2.20.1

