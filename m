Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F254D987F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Mar 2022 11:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346987AbiCOKOV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 06:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346966AbiCOKOT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 06:14:19 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D416FDEC5;
        Tue, 15 Mar 2022 03:13:06 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AcasoT6AYyMHbBhVW/ybiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fUwfs1joi12FWnzNJWm/VPfnfYjf8e95wboyzoxsGupOAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkHhcwmj/3auK79SMkjPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9TiieJntJwwdNlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSnskY/EWoeeZSZS4mYnJp6HcSFP22/hnFloxO40A9854BGh?=
 =?us-ascii?q?P8boTLzVlRgKShfCnwujjErFEicEqLc2tN4Qa0llkzDjfAukrR4jORari5cJRw?=
 =?us-ascii?q?zoxwMtJGJ72a8MfLzgpcxXEZxxGP0w/CZQikePujX76GxVEr1ecvrhx7HLUyQV?=
 =?us-ascii?q?9wrvsGNvTZtGOA85Smy6wom/B+Uz6DwscOdjZziCKmlqlhubVmiX/cIQMFbG5/?=
 =?us-ascii?q?7hhh1j77mkZDBodVXO9v/i1i0f4UNVaQ2QI/S8GsaE27EG6CNL6WnWQpH+Cow5?=
 =?us-ascii?q?ZWNdKFeA+wB+Cx7CS4AuDAGUACDlbZ7QOsM4wWCxvzFOMlvv3CjF19r6YU3SQ8?=
 =?us-ascii?q?vGTtzzaESoaIkcQZCIcQE0O6rHeTCsb5v7UZo87Vvfr0ZuuQnetqw1mZRMW390?=
 =?us-ascii?q?75fPnHY3nlbwfvw+Rmw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Axn0yL6ybkLhUPKcsEOErKrPwQr1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uE/Bw+PrDoB1273TJYVUqNk3I++ruBEDoexq1yXcf2+Qs1NmZNjXbhA?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122648106"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Mar 2022 18:13:03 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8BF0A4D16FD4;
        Tue, 15 Mar 2022 18:13:00 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 15 Mar 2022 18:13:02 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 15 Mar 2022 18:12:58 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <zyjzyj2000@gmail.com>,
        <jgg@ziepe.ca>, <aharonl@nvidia.com>, <leon@kernel.org>,
        <tom@talpey.com>, <tomasz.gromadzki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <mbloch@nvidia.com>,
        <liangwenpeng@huawei.com>, <yangx.jy@fujitsu.com>,
        <y-goto@fujitsu.com>, <rpearsonhpe@gmail.com>,
        <dan.j.williams@intel.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH v3 0/7] RDMA/rxe: Add RDMA FLUSH operation
Date:   Tue, 15 Mar 2022 18:18:38 +0800
Message-ID: <20220315101845.4166983-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8BF0A4D16FD4.A0EC9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey folks,

These patches are going to implement a *NEW* RDMA opcode "RDMA FLUSH".
In IB SPEC 1.5[1], 2 new opcodes, ATOMIC WRITE and RDMA FLUSH were
added in the MEMORY PLACEMENT EXTENSIONS section.

This patchset makes SoftRoCE support new RDMA FLUSH on RC and RD service.

You can verify the patchset by building and running the rdma_flush example[2].
server:
$ ./rdma_flush_server -s [server_address] -p [port_number]
client:
$ ./rdma_flush_client -s [server_address] -p [port_number]

- We introduce new packet format for FLUSH request.
- We introduce FLUSH placement type attributes to HCA
- We introduce FLUSH access flags that users are able to register with

[1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
[2]: https://github.com/zhijianli88/rdma-core/tree/rdma-flush

CC: Xiao Yang <yangx.jy@fujitsu.com>
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

Can also access the kernel source in:
https://github.com/zhijianli88/linux/tree/rdma-flush
Changes log
V3:
- Just rebase and commit log and comment updates
- delete patch-1: "RDMA: mr: Introduce is_pmem", which will be combined into "Allow registering persistent flag for pmem MR only"
- delete patch-7

V2:
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

Li Zhijian (7):
  RDMA: Allow registering MR with flush access flags
  RDMA/rxe: Allow registering persistent flag for pmem MR only
  RDMA/rxe: Implement RC RDMA FLUSH service in requester side
  RDMA/rxe: Implement flush execution in responder side
  RDMA/rxe: Implement flush completion
  RDMA/rxe: Enable RDMA FLUSH capability for rxe device
  RDMA/rxe: Add RD FLUSH service support

 drivers/infiniband/core/uverbs_cmd.c    |  17 +++
 drivers/infiniband/sw/rxe/rxe_comp.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h     |  48 +++++++++
 drivers/infiniband/sw/rxe/rxe_loc.h     |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c      |  36 ++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c  |  35 ++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h  |   3 +
 drivers/infiniband/sw/rxe/rxe_param.h   |   4 +-
 drivers/infiniband/sw/rxe/rxe_req.c     |  15 ++-
 drivers/infiniband/sw/rxe/rxe_resp.c    | 135 ++++++++++++++++++++++--
 include/rdma/ib_pack.h                  |   3 +
 include/rdma/ib_verbs.h                 |  29 ++++-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   2 +
 include/uapi/rdma/ib_user_verbs.h       |  19 ++++
 include/uapi/rdma/rdma_user_rxe.h       |   7 ++
 15 files changed, 346 insertions(+), 13 deletions(-)

-- 
2.31.1



