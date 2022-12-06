Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41FC6443E5
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Dec 2022 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiLFNC5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Dec 2022 08:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbiLFNCT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Dec 2022 08:02:19 -0500
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFA7BCE;
        Tue,  6 Dec 2022 05:02:16 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="78294247"
X-IronPort-AV: E=Sophos;i="5.96,222,1665414000"; 
   d="scan'208";a="78294247"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 06 Dec 2022 22:02:13 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id D0912D4330;
        Tue,  6 Dec 2022 22:02:12 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id F2FD6D9488;
        Tue,  6 Dec 2022 22:02:11 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id AE092234090F;
        Tue,  6 Dec 2022 22:02:10 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>, yangx.jy@fujitsu.com,
        y-goto@fujitsu.com, mbloch@nvidia.com, tom@talpey.com,
        tomasz.gromadzki@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
        Wenpeng Liang <liangwenpeng@huawei.com>
Subject: [for-next PATCH 00/10] RDMA/rxe: Add RDMA FLUSH operation
Date:   Tue,  6 Dec 2022 21:01:51 +0800
Message-Id: <20221206130201.30986-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27306.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27306.007
X-TMASE-Result: 10--18.880700-10.000000
X-TMASE-MatchedRID: iooG+Wyw6IM8HZsl9oOV8Do39wOA02LhZLeVqspIPkdk55TPiguhpQl+
        HyAcPie7eYUpRWZq07pynoTP8fAVKoCoSWHZmQrDCtzGvPCy/m6u2GmdldmiUBPiIPO2d8g5bNN
        GUMZTc/NrrJtu7aXv0XdNoXv6UJm+5L19EARK0Hu+yqBsn+iUg/3/XRTBCRDstkHYqyu7kCPhq7
        9AxpFYjOdo//33TCNrsUZQrAsB6FRKQhXDXm7aNnnlGDzIJIlryiKgKtIyB4pffSkyb6LPSIVD0
        TJVgsKEbyJyCxc6wOabZUf6o9ihJeC1b7ItfNpSLG6gc1cSnZyhHrZE2+S86xEwRXB+SwEtSikP
        5EIJEGTE7gW9Nmz5nELIYTs8DylFcAD14WP1J9ieAiCmPx4NwJuJ+Pb8n/VxvCaAzkS8BHs4BrA
        Twm8horxAi7jPoeEQftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changes in V7:
- rebase to jgg-for-next(Atomic Write applied)
- patch-09: enable FLUSH QP attribute for supported device only, and remove RVB # Jason
- patch-04: pr_debug -> rxe_dbg_mr # Jason

Changes in V6:
- rebase to v6.1-rc1
- add Yanjun's reviewed-by expect "Allow registering persistent flag for pmem MR only"
- minimize pmem checking side effect # Jason
- return EOPNOSUPP if HCA doesn't support flush operation

These patches are going to implement a *NEW* RDMA opcode "RDMA FLUSH".
In IB SPEC 1.5[1], 2 new opcodes, ATOMIC WRITE and RDMA FLUSH were
added in the MEMORY PLACEMENT EXTENSIONS section.

This patchset makes SoftRoCE support new RDMA FLUSH on RC service.

pyverbs tests and blktests(nvme over RDMA and srp) are tested.

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
https://github.com/zhijianli88/linux/tree/rdma-flush-v7
Changes log
V6: https://lore.kernel.org/lkml/20221116081951.32750-10-lizhijian@fujitsu.com/T/
V5: https://lore.kernel.org/lkml/20220927055337.22630-12-lizhijian@fujitsu.com/t/
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

Li Zhijian (10):
  RDMA: Extend RDMA user ABI to support flush
  RDMA: Extend RDMA kernel verbs ABI to support flush
  RDMA/rxe: Extend rxe user ABI to support flush
  RDMA/rxe: Allow registering persistent flag for pmem MR only
  RDMA/rxe: Extend rxe packet format to support flush
  RDMA/rxe: Implement RC RDMA FLUSH service in requester side
  RDMA/rxe: Implement flush execution in responder side
  RDMA/rxe: Implement flush completion
  RDMA/cm: Make QP FLUSHABLE for supported device
  RDMA/rxe: Enable RDMA FLUSH capability for rxe device

 drivers/infiniband/core/cm.c            |  13 +-
 drivers/infiniband/sw/rxe/rxe_comp.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h     |  47 +++++++
 drivers/infiniband/sw/rxe/rxe_loc.h     |   1 +
 drivers/infiniband/sw/rxe/rxe_mr.c      |  58 ++++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c  |  17 +++
 drivers/infiniband/sw/rxe/rxe_opcode.h  |  14 ++-
 drivers/infiniband/sw/rxe/rxe_param.h   |   2 +
 drivers/infiniband/sw/rxe/rxe_req.c     |  15 ++-
 drivers/infiniband/sw/rxe/rxe_resp.c    | 160 +++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h   |   6 +
 include/rdma/ib_pack.h                  |   3 +
 include/rdma/ib_verbs.h                 |  18 ++-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   2 +
 include/uapi/rdma/ib_user_verbs.h       |  17 +++
 include/uapi/rdma/rdma_user_rxe.h       |   7 ++
 16 files changed, 352 insertions(+), 32 deletions(-)

-- 
2.31.1

