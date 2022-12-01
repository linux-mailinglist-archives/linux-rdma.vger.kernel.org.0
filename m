Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0F763F2FB
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 15:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiLAOhh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 09:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbiLAOhg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 09:37:36 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A21BD2
        for <linux-rdma@vger.kernel.org>; Thu,  1 Dec 2022 06:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669905449; i=@fujitsu.com;
        bh=9xIXe7Ce0FoKzl/ERZZL7me/pd0XUULhi/ql+h826Ys=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=kTJlsVba03CXtcotWhmFEvd8CPFQgRTfWcOlAjicgcU5Ooz90hGBbZZcUoz+Z9Mq4
         aCGc6GFq4jqW1KWd6p0sFz6z9N11oqA71oj2gXlGL6jk+QFgeIZcrRYyI0i71b6Hk1
         YXep5idKRvikpXGgNO39tc2u+4WsYBj11Z0A5MUCCCjpjx7IRJIuoVDk/67VnNzZRq
         +XJuyjBavAjng+kuYzKwmtx8eB3qly+GieuYzKFSg+KM3C3GzHo1wfGcktueux2+eq
         QME7xUlNOKUbH22U3AOTo9leumTK5NtMSa4R9yeTIeGTvmUui3KL55kdC7qshhBAOr
         OThxk+gJVqRIw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRWlGSWpSXmKPExsViZ8MxSVdjT0e
  ywb+ZihZX/u1htJjyaymzxbNDvSwWX6ZOY7Y4f6yf3YHVY+esu+wem1Z1snn0Nr9j8/i8SS6A
  JYo1My8pvyKBNWP2iZXsBfPEK549/MjawHhDuIuRi0NIYAujxOJVL9khnOVMEvOP72OFcPYxS
  nQf6mTqYuTkYBNQk9g5/SULiC0i4C2x48YJZhCbWaBe4vDRTYwgtrCAjcSVPX+AbA4OFgEViZ
  41CiBhXgFHiY3/74KVSwgoSEx5+J4ZIi4ocXLmExaIMRISB1+8gKpRlGhb8o8dwq6QmDWrjQn
  CVpO4em4T8wRG/llI2mchaV/AyLSK0aw4tagstUjX0EQvqSgzPaMkNzEzRy+xSjdRL7VUtzy1
  uETXUC+xvFgvtbhYr7gyNzknRS8vtWQTIzCgU4rZVu1g/LXsj94hRkkOJiVR3urOjmQhvqT8l
  MqMxOKM+KLSnNTiQ4wyHBxKErwndwLlBItS01Mr0jJzgNEFk5bg4FES4eVdD5TmLS5IzC3OTI
  dInWJUlBLn7dkFlBAASWSU5sG1wSL6EqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3m3bgKb
  wZOaVwE1/BbSYCWhxpFgbyOKSRISUVAOT5fvcrqVfSuP+3jrBuWi+/YNWn1fRX/tNdj3KOHM4
  pbT5p9xV/7s+m1fq3eRL3bommTG24uTjTYJxV+ZpXChwLXT40tOnx/C7Otd+4p3zttE6OX1zp
  FV3Tvz+ac/is3+X7favv7nnmVGfgrNs38sXCZn2jBzNHHnlW744CRu827q6NcaS+cLPRNfd5l
  o5lbPfPqj/VTzz3tpcqx7XJXJ5RZJes95Nty1dtCa5plN+V2qd44myy0++Fy2y1eF80PZuAa/
  glGqWrjXlbN17Fr1kmZzzPmbBsbU/+xQ19r2T1qn4HszUeOzo1+uFFoe/1bqv0jDZs3JLaIi2
  90P3iuvPftXYLDsleX4tU8Lc6Ce6SizFGYmGWsxFxYkABNeTHmMDAAA=
X-Env-Sender: yangx.jy@fujitsu.com
X-Msg-Ref: server-5.tower-591.messagelabs.com!1669905448!125702!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22161 invoked from network); 1 Dec 2022 14:37:28 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-5.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 14:37:28 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 1FC481000D7;
        Thu,  1 Dec 2022 14:37:28 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 130661000C1;
        Thu,  1 Dec 2022 14:37:28 +0000 (GMT)
Received: from fcf4c122d5e4.localdomain (10.167.215.54) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 14:37:24 +0000
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <rpearsonhpe@gmail.com>
CC:     <leon@kernel.org>, <lizhijian@fujitsu.com>, <y-goto@fujitsu.com>,
        <zyjzyj2000@gmail.com>, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v7 0/8] RDMA/rxe: Add atomic write operation
Date:   Thu, 1 Dec 2022 14:37:04 +0000
Message-ID: <1669905432-14-1-git-send-email-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.215.54]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The IB SPEC v1.5[1] defined new atomic write operation. This patchset
makes SoftRoCE support new atomic write on RC service.

On my rdma-core repository[2], I have introduced atomic write API
for libibverbs and Pyverbs. I also have provided a rdma_atomic_write
example and test_qp_ex_rc_atomic_write python test to verify
the patchset.

The steps to run the rdma_atomic_write example:
server:
$ ./rdma_atomic_write_server -s [server_address] -p [port_number]
client:
$ ./rdma_atomic_write_client -s [server_address] -p [port_number]

The steps to run test_qp_ex_rc_atomic_write test:
run_tests.py --dev rxe_enp0s3 --gid 1 -v test_qpex.QpExTestCase.test_qp_ex_rc_atomic_write
test_qp_ex_rc_atomic_write (tests.test_qpex.QpExTestCase) ... ok

----------------------------------------------------------------------
Ran 1 test in 0.013s

OK

[1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
[2]: https://github.com/yangx-jy/rdma-core/tree/new_api_with_point

v6->v7:
1) Rebase on current for-next
2) Define IB_WC_ATOMIC_WRITE in order

v5->v6:
1) Rebase on current for-next
2) Split the implementation of atomic write into 7 patches
3) Replace all "RDMA Atomic Write" with "atomic write"
4) Save 8-byte value in struct rxe_dma_info instead
5) Remove the print in atomic_write_reply()

v4->v5:
1) Rebase on current wip/jgg-for-next
2) Rewrite the implementation on responder

v3->v4:
1) Rebase on current wip/jgg-for-next
2) Fix a compiler error on 32-bit arch (e.g. parisc) by disabling RDMA Atomic Write
3) Replace 64-bit value with 8-byte array for atomic write

V2->V3:
1) Rebase
2) Add RDMA Atomic Write attribute for rxe device

V1->V2:
1) Set IB_OPCODE_RDMA_ATOMIC_WRITE to 0x1D
2) Add rdma.atomic_wr in struct rxe_send_wr and use it to pass the atomic write value
3) Use smp_store_release() to ensure that all prior operations have completed

Xiao Yang (8):
  RDMA: Extend RDMA user ABI to support atomic write
  RDMA: Extend RDMA kernel ABI to support atomic write
  RDMA/rxe: Extend rxe user ABI to support atomic write
  RDMA/rxe: Extend rxe packet format to support atomic write
  RDMA/rxe: Make requester support atomic write on RC service
  RDMA/rxe: Make responder support atomic write on RC service
  RDMA/rxe: Implement atomic write completion
  RDMA/rxe: Enable atomic write capability for rxe device

 drivers/infiniband/sw/rxe/rxe_comp.c   |  4 ++
 drivers/infiniband/sw/rxe/rxe_opcode.c | 18 ++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 +
 drivers/infiniband/sw/rxe/rxe_param.h  |  5 ++
 drivers/infiniband/sw/rxe/rxe_req.c    | 15 ++++-
 drivers/infiniband/sw/rxe/rxe_resp.c   | 84 ++++++++++++++++++++++++--
 include/rdma/ib_pack.h                 |  2 +
 include/rdma/ib_verbs.h                |  3 +
 include/uapi/rdma/ib_user_verbs.h      |  4 ++
 include/uapi/rdma/rdma_user_rxe.h      |  1 +
 10 files changed, 132 insertions(+), 7 deletions(-)

-- 
2.34.1

