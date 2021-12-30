Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9654B481BF4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 13:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbhL3MRv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 07:17:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:38440 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239064AbhL3MRu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 07:17:50 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A9/0XG6AZR6CgUxVW/97hw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fDADs1Txw0jVSyWIfDzuCPfvYM2Whe9Bxb4619ExQ7MWAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK49CMnjfnSLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9GgjOGj5Zz2f1DqJ6xV?=
 =?us-ascii?q?Rw0eKbLnYzxVjEBSnAhYPUfoOGvzX+X9Jb7I1f9W2H0zvx0F0YwPZUV0ulyCGB?=
 =?us-ascii?q?Ks/cfLVglcheGjvmkhr2hTexlitYgLeHqOp8SvjdryjSxJecvR5LeRePY5cJw2?=
 =?us-ascii?q?DY2m9AIEfvAD+IbZjVHagrBbxxGfFwQDfoWmOaum2m6aTFdoXqLqqctpWve1gp?=
 =?us-ascii?q?81P7qKtW9RzAgba25hW7B/iSfoTu/WUpcabSiJfO+2irErofycenTAur+zIGFy?=
 =?us-ascii?q?8M=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AmRq1Ca0YKAiHVhEiStZ5sQqjBI4kLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SL39qynKppkmPHDP5gr5J0tLpTntAsi9qBDnhPtICOsqTNSftWDd0Q?=
 =?us-ascii?q?PGEGgI1/qB/9SPIU3D398Y/aJhXow7M9foEGV95PyQ3CCIV/om3/mLmZrFudvj?=
X-IronPort-AV: E=Sophos;i="5.88,248,1635177600"; 
   d="scan'208";a="119750106"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Dec 2021 20:15:25 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 0AD674D15A20;
        Thu, 30 Dec 2021 20:15:20 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Dec 2021 20:15:21 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 30 Dec 2021 20:15:20 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.99) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 30 Dec 2021 20:15:17 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [RFC PATCH 0/2] RDMA/rxe: Add RDMA Atomic Write operation
Date:   Thu, 30 Dec 2021 20:14:21 +0800
Message-ID: <20211230121423.1919550-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0AD674D15A20.A701B
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The IB SPEC v1.5[1][2] added new RDMA operations (Atomic Write and Flush).
This patchset makes SoftRoCE support new RDMA Atomic Write on RC service.

I added RDMA Atomic Write API and a rdma_atomic_write example on my
rdma-core repository[3].  You can verify the patchset by building and
running the rdma_atomic_write example.
server:
$ ./rdma_atomic_write_server -s [server_address] -p [port_number]
client:
$ ./rdma_atomic_write_client -s [server_address] -p [port_number]

[1]: https://www.infinibandta.org/ibta-specification/ # login required
[2]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
[3]: https://github.com/yangx-jy/rdma-core

BTW: This patchset also needs the following fix.
https://www.spinics.net/lists/linux-rdma/msg107838.html

Xiao Yang (2):
  RDMA/rxe: Rename send_atomic_ack() and atomic member of struct
    resp_res
  RDMA/rxe: Add RDMA Atomic Write operation

 drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
 drivers/infiniband/sw/rxe/rxe_qp.c     |  5 ++-
 drivers/infiniband/sw/rxe/rxe_req.c    | 10 +++--
 drivers/infiniband/sw/rxe/rxe_resp.c   | 59 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  2 +-
 include/rdma/ib_pack.h                 |  2 +
 include/rdma/ib_verbs.h                |  2 +
 include/uapi/rdma/ib_user_verbs.h      |  2 +
 10 files changed, 88 insertions(+), 19 deletions(-)

-- 
2.23.0



