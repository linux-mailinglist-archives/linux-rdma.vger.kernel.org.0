Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B467D62B4F4
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Nov 2022 09:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiKPIUg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Nov 2022 03:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiKPIUY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Nov 2022 03:20:24 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EB8C2F;
        Wed, 16 Nov 2022 00:20:22 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="95718099"
X-IronPort-AV: E=Sophos;i="5.96,167,1665414000"; 
   d="scan'208";a="95718099"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 16 Nov 2022 17:20:20 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 96692D6478;
        Wed, 16 Nov 2022 17:20:18 +0900 (JST)
Received: from kws-ab2.gw.nic.fujitsu.com (kws-ab2.gw.nic.fujitsu.com [192.51.206.12])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id C2A06BCB68;
        Wed, 16 Nov 2022 17:20:17 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.226.45])
        by kws-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4ECE723401D1;
        Wed, 16 Nov 2022 17:20:16 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        Bob Pearson <rpearsonhpe@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Mark Bloch <mbloch@nvidia.com>, Tom Talpey <tom@talpey.com>,
        tomasz.gromadzki@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>, y-goto@fujitsu.com,
        linux-kernel@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [for-next PATCH v6 00/10] RDMA/rxe: Add RDMA FLUSH operation
Date:   Wed, 16 Nov 2022 16:19:41 +0800
Message-Id: <20221116081951.32750-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27266.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27266.006
X-TMASE-Result: 10--19.334500-10.000000
X-TMASE-MatchedRID: iooG+Wyw6IMtKcX/Bb98eqoXHZz/dXlxXs5nqGvDCfPfghYDxv+lXaJf
        gPmvd/XOMlTzREHxnco2l9wtp/y6ssIRMxauaS3UPKN38CLPK0FzNCdGumZsSeCbuVI7hVbLmPM
        vFiO40LDP253/19/EzfQ6JrmXjZ0m5VojSP95QA8pDEdiwJzEaVvh1cEykiSGagYFlT7hblHEBp
        jowVhUR8txEIgX3T5MEbtwIm1ojqUf0H3tYJmWPTBgCmbnj9JmxZpjHSMI6w6kob0Y35+HFB6sb
        AY1dG02b+SLxu/s2gUUIrvjaprIPeC1b7ItfNpSLG6gc1cSnZyhHrZE2+S86xEwRXB+SwEtSikP
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

Hey folks,

Changes in V6:
- rebase to for-next(v6.1-rc1)
- add Yanjun's reviewed-by except "Allow registering persistent flag for pmem MR only"
- minimize pmem checking side effect # Jason
- return EOPNOSUPP if HCA doesn't support flush operation

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
CC: Tom Talpey <tom@talpey.com>
CC: "Gromadzki, Tomasz" <tomasz.gromadzki@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: linux-rdma@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Can also access the kernel source in:
https://github.com/zhijianli88/linux/tree/rdma-flush-v6
Changes log
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
  RDMA/cm: Make QP FLUSHABLE
  RDMA/rxe: Enable RDMA FLUSH capability for rxe device

 drivers/infiniband/core/cm.c            |   3 +-
 drivers/infiniband/sw/rxe/rxe_comp.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h     |  47 +++++++
 drivers/infiniband/sw/rxe/rxe_loc.h     |   1 +
 drivers/infiniband/sw/rxe/rxe_mr.c      |  58 +++++++-
 drivers/infiniband/sw/rxe/rxe_opcode.c  |  17 +++
 drivers/infiniband/sw/rxe/rxe_opcode.h  |  16 ++-
 drivers/infiniband/sw/rxe/rxe_param.h   |   4 +-
 drivers/infiniband/sw/rxe/rxe_req.c     |  15 +-
 drivers/infiniband/sw/rxe/rxe_resp.c    | 176 +++++++++++++++++++++---
 drivers/infiniband/sw/rxe/rxe_verbs.h   |   6 +
 include/rdma/ib_pack.h                  |   3 +
 include/rdma/ib_verbs.h                 |  20 ++-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   2 +
 include/uapi/rdma/ib_user_verbs.h       |  16 +++
 include/uapi/rdma/rdma_user_rxe.h       |   7 +
 16 files changed, 362 insertions(+), 33 deletions(-)

-- 
2.31.1

