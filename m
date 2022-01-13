Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7CF48D09E
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jan 2022 04:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiAMDEu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jan 2022 22:04:50 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20052 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231833AbiAMDEu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jan 2022 22:04:50 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AYPvDp61kuELnF0JAwvbD5VRzkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJh2gh1zUCxjAZDDqDaPeJMWXyetxzadvg9k8B7ZfUmtU2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfjRHOKnYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2YltZ+2JNPpLS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/UdoOeacCHXXcu7iheun2HX6+92AUgsJooe+v56KW5?=
 =?us-ascii?q?L/P0cbjsKa3irm+WzyampDOZ2gcEqINvoPasevG1tyXfSCvNOaYHKRafX45lK3?=
 =?us-ascii?q?CoYgsFIAOaYa8cHARJtYxvoZQNONlYeTpk5mY+Amn76WyFRrEqYtOw85G275Ah?=
 =?us-ascii?q?w1qX9dcDZf9WiW8pYhACbq3jA8mC/BQsVXOFzYxLtHmmE37eJxH2kHtlJUuDQy?=
 =?us-ascii?q?xKju3XLrkR7NfHcfQbTTSGFt3OD?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AqSKLFazugxq1LMIm6jawKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,284,1635177600"; 
   d="scan'208";a="120300591"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Jan 2022 11:04:48 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id C2C824D15A4A;
        Thu, 13 Jan 2022 11:04:42 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 13 Jan 2022 11:04:43 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 13 Jan 2022 11:04:40 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>, <tom@talpey.com>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [RFC PATCH v2 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Date:   Thu, 13 Jan 2022 11:03:48 +0800
Message-ID: <20220113030350.2492841-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C2C824D15A4A.A6C09
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The IB SPEC v1.5[1][2] defined new RDMA operations (Atomic Write and Flush).
This patchset makes SoftRoCE support new RDMA Atomic Write on RC service.

I add ibv_wr_rdma_atomic_write() and a rdma_atomic_write example on my
rdma-core repository[3].  You can verify the patchset by building and
running the rdma_atomic_write example.
server:
$ ./rdma_atomic_write_server -s [server_address] -p [port_number]
client:
$ ./rdma_atomic_write_client -s [server_address] -p [port_number]

[1]: https://www.infinibandta.org/ibta-specification/ # login required
[2]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
[3]: https://github.com/yangx-jy/rdma-core/tree/new_api

BTW: This patchset also needs the following fix.
https://www.spinics.net/lists/linux-rdma/msg107838.html

V1->V2:
1) Set IB_OPCODE_RDMA_ATOMIC_WRITE to 0x1D
2) Add rdma.atomic_wr in struct rxe_send_wr and use it to pass the atomic write value
3) Use smp_store_release() to ensure that all prior operations have completed

Xiao Yang (2):
  RDMA/rxe: Rename send_atomic_ack() and atomic member of struct
    resp_res
  RDMA/rxe: Support RDMA Atomic Write operation

 drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 18 +++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
 drivers/infiniband/sw/rxe/rxe_qp.c     |  5 ++-
 drivers/infiniband/sw/rxe/rxe_req.c    | 11 +++++-
 drivers/infiniband/sw/rxe/rxe_resp.c   | 53 +++++++++++++++++++-------
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  2 +-
 include/rdma/ib_pack.h                 |  2 +
 include/rdma/ib_verbs.h                |  2 +
 include/uapi/rdma/ib_user_verbs.h      |  2 +
 include/uapi/rdma/rdma_user_rxe.h      |  1 +
 11 files changed, 85 insertions(+), 18 deletions(-)

-- 
2.23.0



