Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F103E49AE5D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jan 2022 09:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447550AbiAYIsO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jan 2022 03:48:14 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7819 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1452020AbiAYIow (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Jan 2022 03:44:52 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A5iW8n68CIB3TXe/bR6pTDrUDj3+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUoi0zcCn2sZXz+GM/iKMTP3fIolbYqz8kIHvZ+Eyd4wTVdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQH+ChULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt9Rw2tVMt525T?=
 =?us-ascii?q?y8nI6/NhP8AFRJfFkmSOIUfoueXeink75H7I0ruNiGEL+9VJFsuMIQC4eFxAXl?=
 =?us-ascii?q?D3fMdITEJKBuEgoqe0qO5WPhu3Jx7dOHkOYoevjdryjSxJfInSJbMXKjM/dJe0?=
 =?us-ascii?q?x8wm8lREPeYbM0cARJjZRKGYVtQO1MTCZs7h8+pgGXyd3tTr1f9jbYw5mHI3kp?=
 =?us-ascii?q?+yr/oOdbHed2iRMNJk0LerWXDl0z9DxYcHN+S0zyI9jSrnOCntSr7UZgVErmQ8?=
 =?us-ascii?q?OBrjFyagGcUDXU+UFG/pvK5okigWt5eIgof/S9GhbQ18WS3R93lUgz+q3mB1jY?=
 =?us-ascii?q?YWtxNA6g55RuLx678/QmUHC4HQyRHZdhgs9U5LRQu11mUj5bzCTlmmKOaRGjb9?=
 =?us-ascii?q?bqOqz62fy8PIgcqZyALZRkE7sHu5oo65i8j5P4L/LWd14WzQG+vhWvR6nVWuln?=
 =?us-ascii?q?atuZTv43TwLwNq2vESkD1czMI?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZnrBea7FoelC/nwwxAPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.88,314,1635177600"; 
   d="scan'208";a="120839365"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Jan 2022 16:44:26 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 5C0594D146E6;
        Tue, 25 Jan 2022 16:44:26 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 25 Jan 2022 16:44:26 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 25 Jan 2022 16:44:23 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
        <yangx.jy@cn.fujitsu.com>
Subject: [RFC PATCH v2 0/9] RDMA/rxe: Add RDMA FLUSH operation
Date:   Tue, 25 Jan 2022 16:50:32 +0800
Message-ID: <20220125085041.49175-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: 5C0594D146E6.AEF68
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey folks,

I wanna thank all of you for the kind feedback in my previous RFC.
Recently, i have tried my best to do some updates as per your comments.
Indeed, not all comments have been addressed for some reasons, i still
wish to post this new one to start a new discussion.

Outstanding issues:
- iova_to_addr() without any kmap/kmap_local_page flows might not always
  work. # existing issue.
- responder should reply error to requested side when it requests a
  persistence placement type to DRAM ?
-------

These patches are going to implement a *NEW* RDMA opcode "RDMA FLUSH".
In IB SPEC 1.5[1][2], 2 new opcodes, ATOMIC WRITE and RDMA FLUSH were
added in the MEMORY PLACEMENT EXTENSIONS section.

FLUSH is used by the requesting node to achieve guarantees on the data
placement within the memory subsystem of preceding accesses to a
single memory region, such as those performed by RDMA WRITE, Atomics
and ATOMIC WRITE requests.

The operation indicates the virtual address space of a destination node
and where the guarantees should apply. This range must be contiguous
in the virtual space of the memory key but it is not necessarily a
contiguous range of physical memory.

FLUSH packets carry FLUSH extended transport header (see below) to
specify the placement type and the selectivity level of the operation
and RDMA extended header (RETH, see base document RETH definition) to
specify the R_Key VA and Length associated with this request following
the BTH in RC, RDETH in RD and XRCETH in XRC.

RC FLUSH:
+----+------+------+
|BTH | FETH | RETH |
+----+------+------+

RD FLUSH:
+----+------+------+------+
|BTH | RDETH| FETH | RETH |
+----+------+------+------+

XRC FLUSH:
+----+-------+------+------+
|BTH | XRCETH| FETH | RETH |
+----+-------+------+------+

Currently, we introduce RC and RD services only, since XRC has not been
implemented by rxe yet.
NOTE: only RC service is tested now, and since other HCAs have not
added/implemented FLUSH yet, we can only test FLUSH operation in both
SoftRoCE/rxe devices.

The corresponding rdma-core and FLUSH example are available on:
https://github.com/zhijianli88/rdma-core/tree/rfc
Can access the kernel source in:
https://github.com/zhijianli88/linux/tree/rdma-flush

- We introduce is_pmem attribute to MR(memory region)
- We introduce FLUSH placement type attributes to HCA
- We introduce FLUSH access flags that users are able to register with
Below figure shows the valid access flags uses can register with:
+------------------------+------------------+--------------+
| HCA attributes         |    register access flags        |
|        and             +-----------------+---------------+
| MR attribute(is_pmem)  |global visibility |  persistence |
|------------------------+------------------+--------------+
| global visibility(DRAM)|        O         |      X       |
|------------------------+------------------+--------------+
| global visibility(PMEM)|        O         |      X       |
|------------------------+------------------+--------------+
| persistence(DRAM)      |        X         |      X       |
|------------------------+------------------+--------------+
| persistence(PMEM)      |        X         |      O       |
+------------------------+------------------+--------------+
O: allow to register such access flag

In order to make placement guarentees, we currently reject requesting a
persistent flush to a non-pmem.
The responder will check the remote requested placement types by checking
the registered access flags.
+------------------------+------------------+--------------+
|                        |     registered flags            |
| remote requested types +------------------+--------------+
|                        |global visibility |  persistence |
|------------------------+------------------+--------------+
| global visibility      |        O         |      x       |
+------------------------+------------------+--------------+
| persistence            |        X         |      O       |
+------------------------+------------------+--------------+
O: allow to request such placement type

Below list some details about FLUSH transport packet:

A FLUSH message is built upon FLUSH request packet and is responded
successfully by RDMA READ response of zero size.

oA19-2: FLUSH shall be single packet message and shall have no payload.
oA19-5: FLUSH BTH shall hold the Opcode = 0x1C

FLUSH Extended Transport Header(FETH)
+-----+-----------+------------------------+----------------------+
|Bits |   31-6    |          5-4           |        3-0           |
+-----+-----------+------------------------+----------------------+
|     | Reserved  | Selectivity Level(SEL) | Placement Type(PLT)  |
+-----+-----------+------------------------+----------------------+

Selectivity Level (SEL) – defines the memory region scope the FLUSH
should apply on. Values are as follows:
• b’00 - Memory Region Range: FLUSH applies for all preceding memory
         updates to the RETH range on this QP. All RETH fields shall be
         valid in this selectivity mode. RETH:DMALen field shall be
         between zero and (2 31 -1) bytes (inclusive).
• b’01 - Memory Region: FLUSH applies for all preceding memory up-
         dates to RETH.R_key on this QP. RETH:DMALen and RETH:VA
         shall be ignored in this mode.
• b'10 - Reserved.
• b'11 - Reserved.

Placement Type (PLT) – Defines the memory placement guarantee of
this FLUSH. Multiple bits may be set in this field. Values are as follows:
• Bit 0 if set to '1' indicated that the FLUSH should guarantee Global
  Visibility.
• Bit 1 if set to '1' indicated that the FLUSH should guarantee
  Persistence.
• Bits 3:2 are reserved

[1]: https://www.infinibandta.org/ibta-specification/ # login required
[2]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx

CC: yangx.jy@cn.fujitsu.com
CC: y-goto@fujitsu.com
CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Zhu Yanjun <zyjzyj2000@gmail.com
CC: Leon Romanovsky <leon@kernel.org>
CC: Bob Pearson <rpearsonhpe@gmail.com>
CC: Mark Bloch <mbloch@nvidia.com>
CC: Wenpeng Liang <liangwenpeng@huawei.com>
CC: Aharon Landau <aharonl@nvidia.com>
CC: Tom Talpey <tom@talpey.com>
CC: "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: linux-rdma@vger.kernel.org
CC: linux-kernel@vger.kernel.org

V1:
https://lore.kernel.org/lkml/050c3183-2fc6-03a1-eecd-258744750972@fujitsu.com/T/
or https://github.com/zhijianli88/linux/tree/rdma-flush-rfcv1

Changes log
V2:
https://github.com/zhijianli88/linux/tree/rdma-flush
RDMA: mr: Introduce is_pmem
  check 1st byte to avoid crossing page boundary
  new scheme to check is_pmem # Dan

RDMA: Allow registering MR with flush access flags
  combine with [03/10] RDMA/rxe: Allow registering FLUSH flags for supported device only to this patch # Jason
  split RDMA_FLUSH to 2 capabilities

RDMA/rxe: Allow registering persistent flag for pmem MR only
  update commit message, get rid of confusing ib_check_flush_access_flags() # Tom

RDMA/rxe: Implement RC RDMA FLUSH service in requester side
  extend flush to include length field. # Tom and Tomasz

RDMA/rxe: Implement flush execution in responder side
  adjust start for WHOLE MR level # Tom
  don't support DMA mr for flush # Tom
  check flush return value

RDMA/rxe: Enable RDMA FLUSH capability for rxe device
  adjust patch's order. move it here from [04/10]

Li Zhijian (9):
  RDMA: mr: Introduce is_pmem
  RDMA: Allow registering MR with flush access flags
  RDMA/rxe: Allow registering persistent flag for pmem MR only
  RDMA/rxe: Implement RC RDMA FLUSH service in requester side
  RDMA/rxe: Set BTH's SE to zero for FLUSH packet
  RDMA/rxe: Implement flush execution in responder side
  RDMA/rxe: Implement flush completion
  RDMA/rxe: Enable RDMA FLUSH capability for rxe device
  RDMA/rxe: Add RD FLUSH service support

 drivers/infiniband/core/uverbs_cmd.c    |  17 +++
 drivers/infiniband/sw/rxe/rxe_comp.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h     |  52 +++++++++
 drivers/infiniband/sw/rxe/rxe_loc.h     |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c      |  37 ++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c  |  35 +++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h  |   3 +
 drivers/infiniband/sw/rxe/rxe_param.h   |   4 +-
 drivers/infiniband/sw/rxe/rxe_req.c     |  19 +++-
 drivers/infiniband/sw/rxe/rxe_resp.c    | 133 +++++++++++++++++++++++-
 include/rdma/ib_pack.h                  |   3 +
 include/rdma/ib_verbs.h                 |  30 +++++-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   2 +
 include/uapi/rdma/ib_user_verbs.h       |  19 ++++
 include/uapi/rdma/rdma_user_rxe.h       |   7 ++
 15 files changed, 355 insertions(+), 12 deletions(-)

-- 
2.31.1



