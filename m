Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF7D5EBA20
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Sep 2022 07:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiI0FyL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 27 Sep 2022 01:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiI0FyJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 27 Sep 2022 01:54:09 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BEE96FF9;
        Mon, 26 Sep 2022 22:54:07 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="68849850"
X-IronPort-AV: E=Sophos;i="5.93,348,1654527600"; 
   d="scan'208";a="68849850"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 27 Sep 2022 14:54:00 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 05EC1D4323;
        Tue, 27 Sep 2022 14:54:00 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1BD4DDD772;
        Tue, 27 Sep 2022 14:53:59 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id BA55B11403D7;
        Tue, 27 Sep 2022 14:53:57 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, liangwenpeng@huawei.com,
        tom@talpey.com, tomasz.gromadzki@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v5 00/11] RDMA/rxe: Add RDMA FLUSH operation
Date:   Tue, 27 Sep 2022 13:53:26 +0800
Message-Id: <20220927055337.22630-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27166.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27166.005
X-TMASE-Result: 10--19.540800-10.000000
X-TMASE-MatchedRID: +WRSeMlL01ItKcX/Bb98egEaayJtYZNtmVj8JQ7DUDtSfunLi592Rgcs
        lYpo5iSTCqIlUwwPgeySOtPh0WaTDg8rYO92b9NmRcGHEV0WBxBh0Eb5uGGI1NgJ+YNQuvvy8FS
        rkmy6/FLiW59TZPEcroGXHuWb31FDfnzmcpBzOrsAPmNKDWsW0DFVRYZezcLzdb3jzU/+DLeETM
        jf6aTOJwC4Pm07ddT5iBHCzYIC7N9LpE3dx4HTsKzGfgakLdjawMc7ZZ8e7/dqBgWVPuFuUcQGm
        OjBWFRHy3EQiBfdPkwxio9hGLQilfoLRFtw/0CmMGAKZueP0mbFmmMdIwjrDraqD80oqmE5MuTw
        baqEJZPDKKXtpTQT/hQiu+Nqmsg94LVvsi182lIsbqBzVxKdnKEetkTb5LzrETBFcH5LAS1KKQ/
        kQgkQZMTuBb02bPmcQshhOzwPKUWPaFHMfVTC4BRFJJyf5BJe74Zwin5MxS/6C0ePs7A07QKmAR
        N5PTKc
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hey folks,

Firstly i want to say thank you to all you guys, especially Bob, who in the
past 1+ month, gave me a lots of idea and inspiration.

With the your help, some changes are make in 5th version, such as:
- new names and new patch split schemem, suggested by Bob
- bugfix: set is_pmem true only if the whole MR is pmem. it's possible the
  one MR container both PMEM and DRAM.
- introduce feth structure, instead of u32
- new bugfix to rxe_lookup_mw() and lookup_mr(), see (RDMA/rxe: make sure requested access is a subset of {mr,mw}->access),
  with this fix, we remove check_placement_type(), lookup_mr() has done the such check.
- Enable QP attr flushable
These change logs also appear in the patch it belongs to.

These patches are going to implement a *NEW* RDMA opcode "RDMA FLUSH".
In IB SPEC 1.5[1], 2 new opcodes, ATOMIC WRITE and RDMA FLUSH were
added in the MEMORY PLACEMENT EXTENSIONS section.

This patchset makes SoftRoCE support new RDMA FLUSH on RC service.

You can verify the patchset by building and running the rdma_flush example[2].
server:
$ ./rdma_flush_server -s [server_address] -p [port_number]
client:
$ ./rdma_flush_client -s [server_address] -p [port_number]

Corresponding pyverbs and tests(tests.test_qpex.QpExTestCase.test_qp_ex_rc_rdma_flush)
are also added to rdma-core

[1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
[2]: https://github.com/zhijianli88/rdma-core/tree/rdma-flush-v5

CC: Xiao Yang <yangx.jy@fujitsu.com>
CC: "Gotou, Yasunori" <y-goto@fujitsu.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Zhu Yanjun <zyjzyj2000@gmail.com>
CC: Leon Romanovsky <leon@kernel.org>
CC: Bob Pearson <rpearsonhpe@gmail.com>
CC: Mark Bloch <mbloch@nvidia.com>
CC: Wenpeng Liang <liangwenpeng@huawei.com>
CC: Tom Talpey <tom@talpey.com>
CC: "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: linux-rdma@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Can also access the kernel source in:
https://github.com/zhijianli88/linux/tree/rdma-flush-v5
Changes log
V4:
- rework responder process
- rebase to v5.19+
- remove [7/7]: RDMA/rxe: Add RD FLUSH service support since RD is not really supported

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

Li Zhijian (11):
  RDMA/rxe: make sure requested access is a subset of {mr,mw}->access
  RDMA: Extend RDMA user ABI to support flush
  RDMA: Extend RDMA kernel verbs ABI to support flush
  RDMA/rxe: Extend rxe user ABI to support flush
  RDMA/rxe: Allow registering persistent flag for pmem MR only
  RDMA/rxe: Extend rxe packet format to support flush
  RDMA/rxe: Implement RC RDMA FLUSH service in requester side
  RDMA/rxe: Implement flush execution in responder side
  RDMA/rxe: Implement flush completion
  RDMA/cm: Make QP FLUSHABLE
  RDMA/rxe: Enable RDMA FLUSH capability for rxe device

 drivers/infiniband/core/cm.c            |   3 +-
 drivers/infiniband/sw/rxe/rxe_comp.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h     |  47 +++++++
 drivers/infiniband/sw/rxe/rxe_loc.h     |   1 +
 drivers/infiniband/sw/rxe/rxe_mr.c      |  81 ++++++++++-
 drivers/infiniband/sw/rxe/rxe_mw.c      |   3 +-
 drivers/infiniband/sw/rxe/rxe_opcode.c  |  17 +++
 drivers/infiniband/sw/rxe/rxe_opcode.h  |  16 ++-
 drivers/infiniband/sw/rxe/rxe_param.h   |   4 +-
 drivers/infiniband/sw/rxe/rxe_req.c     |  15 +-
 drivers/infiniband/sw/rxe/rxe_resp.c    | 180 +++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h   |   6 +
 include/rdma/ib_pack.h                  |   3 +
 include/rdma/ib_verbs.h                 |  20 ++-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   2 +
 include/uapi/rdma/ib_user_verbs.h       |  16 +++
 include/uapi/rdma/rdma_user_rxe.h       |   7 +
 17 files changed, 389 insertions(+), 36 deletions(-)

-- 
2.31.1

