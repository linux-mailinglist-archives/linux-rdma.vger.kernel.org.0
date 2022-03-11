Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130814D6101
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Mar 2022 12:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiCKLyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Mar 2022 06:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343558AbiCKLyD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Mar 2022 06:54:03 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A569D42EE7
        for <linux-rdma@vger.kernel.org>; Fri, 11 Mar 2022 03:52:53 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AuY5VSaBDxUwRBxVW/7vhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBgLvgG531zUHymdOC2/TO6yJZ2f9LttyOt/noRgFv5KAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9GgjOGj5Zz2f1DqJ6xV?=
 =?us-ascii?q?Rw0eKbLnYzxVjEBSXsjYfwfpO6vzX+X9Jb7I1f9W2H0zvx0F0YwPZUV0ulyCGB?=
 =?us-ascii?q?Ks/cfLVglbwqKwf27wbSqYuhqmsknasLsOes3pnZlxCrLS/k8RpXKT7fJ5PdZ2?=
 =?us-ascii?q?is9goZFGvO2T9sQbzhyalLSYwBnPlYRFYJ4kOq27lH9fDJwrkyUqas+pWPUyWR?=
 =?us-ascii?q?ZzL/oGMbcfsSHVINemUPwjmbH+XnpRwsWMdW31zWI6DSvi/XJkCe9X5gdfIBUX?=
 =?us-ascii?q?NYCbEa7nzRVUUNJEwDg56TRt6J3YPoHQ2R8x8bkhfFaGJSXc+TA?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACL7gpK+LkOo16Qf2uF5uk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122549149"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Mar 2022 19:52:52 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id E199D4D169E7;
        Fri, 11 Mar 2022 19:52:48 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 11 Mar 2022 19:52:48 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 11 Mar 2022 19:52:49 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, <tom@talpey.com>,
        <ira.weiny@intel.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v3 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Date:   Fri, 11 Mar 2022 19:52:44 +0800
Message-ID: <20220311115247.23521-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E199D4D169E7.AB35A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The IB SPEC v1.5[1] defined new RDMA Atomic Write operation. This
patchset makes SoftRoCE support new RDMA Atomic Write on RC service.

I add ibv_wr_rdma_atomic_write() and a rdma_atomic_write example on my
rdma-core repository[2].  You can verify the patchset by building and
running the rdma_atomic_write example.
server:
$ ./rdma_atomic_write_server -s [server_address] -p [port_number]
client:
$ ./rdma_atomic_write_client -s [server_address] -p [port_number]

[1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
[2]: https://github.com/yangx-jy/rdma-core/tree/new_api

V2->V3:
1) Rebase
2) Add RDMA Atomic Write attribute for rxe device

V1->V2:
1) Set IB_OPCODE_RDMA_ATOMIC_WRITE to 0x1D
2) Add rdma.atomic_wr in struct rxe_send_wr and use it to pass the atomic write value
3) Use smp_store_release() to ensure that all prior operations have completed

Xiao Yang (3):
  RDMA/rxe: Rename send_atomic_ack() and atomic member of struct
    resp_res
  RDMA/rxe: Support RDMA Atomic Write operation
  RDMA/rxe: Add RDMA Atomic Write attribute for rxe device

 drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 19 +++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
 drivers/infiniband/sw/rxe/rxe_param.h  |  3 +-
 drivers/infiniband/sw/rxe/rxe_qp.c     |  5 ++-
 drivers/infiniband/sw/rxe/rxe_req.c    | 11 +++++-
 drivers/infiniband/sw/rxe/rxe_resp.c   | 55 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  2 +-
 include/rdma/ib_pack.h                 |  2 +
 include/rdma/ib_verbs.h                |  4 ++
 include/uapi/rdma/ib_user_verbs.h      |  2 +
 include/uapi/rdma/rdma_user_rxe.h      |  1 +
 12 files changed, 92 insertions(+), 19 deletions(-)

-- 
2.34.1



