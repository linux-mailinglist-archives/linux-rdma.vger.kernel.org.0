Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC65504C7D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Apr 2022 08:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiDRGP1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Apr 2022 02:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiDRGP1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Apr 2022 02:15:27 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 604EB17AB7
        for <linux-rdma@vger.kernel.org>; Sun, 17 Apr 2022 23:12:49 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A2tIxOqPDveINAh3vrR0nlcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQC83D4j0jQHzjYdXWGOP/3fZTCmKo9xOojk90lXupOHm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yEmjfjQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/mjyPkMA3ysRlu4GyS?=
 =?us-ascii?q?BsyI+vHn+F1vxxwSnslY/Eaou+cSZS4mYnJp6HcSFP22/hnFloxO40A9854BGh?=
 =?us-ascii?q?P8boTLzVlRhGZjqSpzbO9W8FtgNguKI/gO4Z3km1nyDjCH7ApW5fGSqnY5t5w3?=
 =?us-ascii?q?TEsi8QIFvHbD+IIYDxtcRKGcR1SElMWDo8u2uulmBHXcTJXgFSLpKY26i7Yywk?=
 =?us-ascii?q?Z+LzsNsfFP8aGQMx9gEmVvCTF8n7/DxVcM8aQoQdpWFrEavTnxHu9AdxNUubjs?=
 =?us-ascii?q?KMCvbFa/URLYDV+aLdxiaDRZpaCZu9i?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A4YTucapOvYj1PeoQ9c7QuuMaV5rDeYIsimQD?=
 =?us-ascii?q?101hICG8cqSj+fxG+85rsSMc6QxhP03I9urhBEDtex/hHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekIh+bfKlbbehEWmNQz6U4ZSdkdNDTvNykAse/KpBm/D807wMSKtIShheLl?=
 =?us-ascii?q?xX9rSg1wApsQljtRO0KKFFFsXglaCd4cHJqY3MBOoD2tYjA5dcK+b0N1J9Trlp?=
 =?us-ascii?q?nako78ex4aC1oC4AmKtzmh77n3CFy5834lIlVy/Ys=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123644283"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Apr 2022 14:12:48 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id CF1174D16FDF;
        Mon, 18 Apr 2022 14:12:46 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 18 Apr 2022 14:12:49 +0800
Received: from localhost.localdomain (10.167.215.54) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 18 Apr 2022 14:12:48 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <yanjun.zhu@linux.dev>, <rpearsonhpe@gmail.com>, <jgg@nvidia.com>,
        <y-goto@fujitsu.com>, <lizhijian@fujitsu.com>,
        <tomasz.gromadzki@intel.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v4 0/3] RDMA/rxe: Add RDMA Atomic Write operation
Date:   Mon, 18 Apr 2022 14:12:41 +0800
Message-ID: <20220418061244.89025-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: CF1174D16FDF.AA63D
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
[2]: https://github.com/yangx-jy/rdma-core/tree/new_api_with_point

v3->v4:
1) Rebase on current wip/jgg-for-next
2) Fix a compiler error on 32-bit arch (e.g. parisc) by disabling RDMA Atomic Write
3) Replace 64-bit value with 8-byte array for RDMA Atomic Write

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
 drivers/infiniband/sw/rxe/rxe_opcode.c | 19 ++++++++
 drivers/infiniband/sw/rxe/rxe_opcode.h |  3 ++
 drivers/infiniband/sw/rxe/rxe_param.h  |  5 +++
 drivers/infiniband/sw/rxe/rxe_qp.c     |  4 +-
 drivers/infiniband/sw/rxe/rxe_req.c    | 13 +++++-
 drivers/infiniband/sw/rxe/rxe_resp.c   | 61 ++++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_verbs.h  |  2 +-
 include/rdma/ib_pack.h                 |  2 +
 include/rdma/ib_verbs.h                |  3 ++
 include/uapi/rdma/ib_user_verbs.h      |  4 ++
 include/uapi/rdma/rdma_user_rxe.h      |  1 +
 12 files changed, 103 insertions(+), 18 deletions(-)

-- 
2.34.1



