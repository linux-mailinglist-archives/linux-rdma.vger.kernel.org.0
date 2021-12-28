Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84589480728
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Dec 2021 09:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbhL1ICV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 28 Dec 2021 03:02:21 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10151 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235480AbhL1ICU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 28 Dec 2021 03:02:20 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ATb3WjqySw/xM+GBJoOt6t+dpxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDsl0WRRxmJOWjrTaKuCajT8c9giYYq+/RkPupaEmNZrHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmjPjSHOqkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhm9FjyNRPtJW2Y?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQfqeGafiTn4aR/yGWDKRMA2c5GFlk7NJcD/eB3GWx?=
 =?us-ascii?q?m+vkRKTRLZReG78qk0bCpW+s23px7BMbuNYIb/HpnyFnxCfcvR5/cTqPS6NlX9?=
 =?us-ascii?q?Dctj99DHLDVYM9xQT5ucxnBYxRJNX8XFZshkebujX76GxVcpVWTjak6+W7eyEp?=
 =?us-ascii?q?2yreFGNPVc8aNQ8F9mFiZqmPPuW/+B3kyMdabzjGF2nSyh+POlGXwX4d6PLm58?=
 =?us-ascii?q?ON6xV6e3GoeDDUIWlah5/q0kEizX5RYMUN80i4vq7UisVanS9DVQRK1ujiHswQ?=
 =?us-ascii?q?aVt4WFPc1gCmPxaX88QeUHmVCRTcpVTCMnKfaXhRzjhnQwYyvXmcp7dWopbum3?=
 =?us-ascii?q?u/8hVuP1eI9dDRqifc4cDY4?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ABNWW7ahTgUFlMvUEn7QlIOF3OHBQXjAji2hC?=
 =?us-ascii?q?6mlwRA09TySZ//rOoB19726TtN9xYgBGpTnuAtjifZqxz/FICOoqTNOftWvdyQ?=
 =?us-ascii?q?mVxehZhOOIqVCNJ8SUzI5gPMlbHZSWcOeAaGSSk/yKmjWQIpIxxsWd6qC0iaP7?=
 =?us-ascii?q?x3dpdwtjbKZt9G5Ce36mO3wzVA9bHoA4CZbZwsJGogCrcXMRYt/+KWICW4H41q?=
 =?us-ascii?q?b2vaOjcRgbHAQm9QXLqTup7YTxGx+e0gxbcx4n+8ZazVT4?=
X-IronPort-AV: E=Sophos;i="5.88,241,1635177600"; 
   d="scan'208";a="119657408"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Dec 2021 16:01:53 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id A1FE24D15A20;
        Tue, 28 Dec 2021 16:01:46 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:48 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Dec 2021 16:01:46 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Dec 2021 16:01:43 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liweihang@huawei.com>, <liangwenpeng@huawei.com>,
        <yangx.jy@cn.fujitsu.com>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [RFC PATCH rdma-next 00/10] RDMA/rxe: Add RDMA FLUSH operation
Date:   Tue, 28 Dec 2021 16:07:07 +0800
Message-ID: <20211228080717.10666-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-yoursite-MailScanner-ID: A1FE24D15A20.AF2ED
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey folks,

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

Below list some details about FLUSH transport packet:

A FLUSH message is built upon FLUSH request packet and is responded
successfully by RDMA READ response of zero size.

oA19-2: FLUSH shall be single packet message and shall have no payload.

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

CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Zhu Yanjun <zyjzyj2000@gmail.com
CC: Leon Romanovsky <leon@kernel.org>
CC: Bob Pearson <rpearsonhpe@gmail.com>
CC: Weihang Li <liweihang@huawei.com>
CC: Mark Bloch <mbloch@nvidia.com>
CC: Wenpeng Liang <liangwenpeng@huawei.com>
CC: Aharon Landau <aharonl@nvidia.com>
CC: linux-rdma@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Li Zhijian (10):
  RDMA: mr: Introduce is_pmem
  RDMA: Allow registering MR with flush access flags
  RDMA/rxe: Allow registering FLUSH flags for supported device only
  RDMA/rxe: Enable IB_DEVICE_RDMA_FLUSH for rxe device
  RDMA/rxe: Allow registering persistent flag for pmem MR only
  RDMA/rxe: Implement RC RDMA FLUSH service in requester side
  RDMA/rxe: Set BTH's SE to zero for FLUSH packet
  RDMA/rxe: Implement flush execution in responder side
  RDMA/rxe: Implement flush completion
  RDMA/rxe: Add RD FLUSH service support

 drivers/infiniband/core/uverbs_cmd.c    |  16 +++
 drivers/infiniband/sw/rxe/rxe_comp.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h     |  52 ++++++++++
 drivers/infiniband/sw/rxe/rxe_loc.h     |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c      |  63 +++++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c  |  33 ++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h  |   3 +
 drivers/infiniband/sw/rxe/rxe_param.h   |   3 +-
 drivers/infiniband/sw/rxe/rxe_req.c     |  14 ++-
 drivers/infiniband/sw/rxe/rxe_resp.c    | 131 +++++++++++++++++++++++-
 include/rdma/ib_pack.h                  |   3 +
 include/rdma/ib_verbs.h                 |  22 +++-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   2 +
 include/uapi/rdma/ib_user_verbs.h       |  18 ++++
 include/uapi/rdma/rdma_user_rxe.h       |   6 ++
 15 files changed, 362 insertions(+), 10 deletions(-)

-- 
2.31.1



