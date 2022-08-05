Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3F158A741
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Aug 2022 09:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiHEHjw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Aug 2022 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbiHEHjv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Aug 2022 03:39:51 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9FB1181F;
        Fri,  5 Aug 2022 00:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659685188; i=@fujitsu.com;
        bh=cFW/dO6jKmwqqaTZfst0R3A1GQJIB1O7LYPtK4wlqHw=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ebwSo39K6wvDykpEcnq3lZGGHH+q12fAU5AhHRI/PlymP/P1uAW/tp1HZk5wFxYM1
         xqv6UqS5J5JZXqcnuVAHtp2tPcilYmhEPbTRUOiX++fLEpwC5WQJI3yrkCnXzCGCP7
         kdQZSFt3Sa9iarsCxkatmHgUCKUg+B2DPdkfZRx0mKyM3Cyxi1575N8nLu8dhhEAf1
         U2wc3uOMqSeNTNj39yxnSGNycERbi20Vpfk2FJHEXoSVgnJok3ba7pNGZLR95yUB01
         YS8gSXr3IHDzSwDJb9pIB5wdJHcO/+rjGvJmagBCF31Mi/GbnwMqnPzy4RpAPNIPtv
         imw1qJMbzLZQw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileJIrShJLcpLzFFi42Kxs+FI0nU++Sb
  J4NlXDou53+Uspk+9wGgxc8YJRospv5YyW5z762dxedccNotnh3pZLD5MPcJs8WXqNGaLU79O
  MVn8vfSPzeL8sX52Bx6PnbPusnu0HHnL6rF4z0smj02rOtk8epvfsXlcfnKF0ePzJjmPrZ9vs
  wRwRLFm5iXlVySwZkx/KlSwUaFixvJdzA2MvdJdjFwcQgIbGSW+/7zDCOEsYZJYMW8PG4Szn1
  HizvKtrF2MnBxsAhoS91puglWJCHQySjzqPwZWxSzwm0lic8cvdpAqYQEriduT+5i7GDk4WAR
  UJLYtFwYJ8wo4Smz5vBGsREJAQWLKw/fMEHFBiZMzn7CA2MwCEhIHX7wAa5UQUJKY2R0PUV4h
  MWtWGxOErSZx9dwm5gmM/LOQdM9C0r2AkWkVo3VSUWZ6RkluYmaOrqGBga6hoamusYWukaGRX
  mKVbqJeaqlueWpxiS6QW16sl1pcrFdcmZuck6KXl1qyiREYRSnFald2MO5Z9VPvEKMkB5OSKO
  +542+ShPiS8lMqMxKLM+KLSnNSiw8xynBwKEnwBp0AygkWpaanVqRl5gAjGiYtwcGjJMK7DqS
  Vt7ggMbc4Mx0idYpRUUqc1wgkIQCSyCjNg2uDJZFLjLJSwryMDAwMQjwFqUW5mSWo8q8YxTkY
  lYR574FM4cnMK4Gb/gpoMRPQYq7/r0EWlyQipKQamOwtP7g+FeWRdz/bkstofUNGyu2S+sZjw
  R17dRdcm9XvcL2/dnfnF5aL/3SvSfg+/F8UdtbqZUOKZtPqpNT9WnIHt5b+3/BT1TDt9i/Zc+
  ZCyj/7XGYzPrJLUhPY53VX+NCMtoXXp8xkkcwvNuI8kW7lUS/wmf2rKdsz32J3wTN7C6Yc+Kv
  vnbPC1vzKprVbPKYm8Wt2idjOvehwacbSms6GgNIDuS4vRb57v14+M+nAWe2WA8zvJdxkGuv8
  5rE2OT3xEP568dj/qqJNOoWTtPcf2eQq5XopJGPHpbr60nlxW332+L7fYeRrxL71XvrBsjnFy
  xedVZ61L+mj/DvuWQqzLVac/n87t5f75Smxb0osxRmJhlrMRcWJAFs1MjedAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-15.tower-548.messagelabs.com!1659685186!27928!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32381 invoked from network); 5 Aug 2022 07:39:47 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-15.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 5 Aug 2022 07:39:47 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id C11E61B1;
        Fri,  5 Aug 2022 08:39:46 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id B49CE1AD;
        Fri,  5 Aug 2022 08:39:46 +0100 (BST)
Received: from 4084fd6ad2a8.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 5 Aug 2022 08:39:41 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@fujitsu.com>, <y-goto@fujitsu.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>,
        Tom Talpey <tom@talpey.com>, <tomasz.gromadzki@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>,
        "Wenpeng Liang" <liangwenpeng@huawei.com>
Subject: [PATCH v4 0/6] RDMA/rxe: Add RDMA FLUSH operation
Date:   Fri, 5 Aug 2022 07:46:13 +0000
Message-ID: <1659685579-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
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

Hey folks,

It's been a long time since the 3rd, in the meantime, some RXE regressions have
been fixed by comminity. So It'd like to post my 4th version. feedbacks are
very welcome :).

Thanks.

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

This patches do:
- Make memory region support FLUSH access flags
- Make HCA/device support FLUSH capabilities(placement type attributes).
- Implement new packet for FLUSH request.

[1]: https://www.infinibandta.org/wp-content/uploads/2021/08/IBTA-Overview-of-IBTA-Volume-1-Release-1.5-and-MPE-2021-08-17-Secure.pptx
[2]: https://github.com/zhijianli88/rdma-core/tree/rdma-flush

CC: Xiao Yang <yangx.jy@fujitsu.com>
CC: "Gotou, Yasunori" <y-goto@fujitsu.com>
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
Li Zhijian (6):
  RDMA: Allow registering MR with flush access flags
  RDMA/rxe: Allow registering persistent flag for pmem MR only
  RDMA/rxe: Implement RC RDMA FLUSH service in requester side
  RDMA/rxe: Implement flush execution in responder side
  RDMA/rxe: Implement flush completion
  RDMA/rxe: Enable RDMA FLUSH capability for rxe device

 drivers/infiniband/sw/rxe/rxe_comp.c    |   4 +-
 drivers/infiniband/sw/rxe/rxe_hdr.h     |  48 ++++++++
 drivers/infiniband/sw/rxe/rxe_loc.h     |   2 +
 drivers/infiniband/sw/rxe/rxe_mr.c      |  23 +++-
 drivers/infiniband/sw/rxe/rxe_opcode.c  |  21 ++++
 drivers/infiniband/sw/rxe/rxe_opcode.h  |   4 +
 drivers/infiniband/sw/rxe/rxe_param.h   |   4 +-
 drivers/infiniband/sw/rxe/rxe_req.c     |  15 ++-
 drivers/infiniband/sw/rxe/rxe_resp.c    | 149 +++++++++++++++++++++++-
 include/rdma/ib_pack.h                  |   2 +
 include/rdma/ib_verbs.h                 |  19 ++-
 include/uapi/rdma/ib_user_ioctl_verbs.h |   2 +
 include/uapi/rdma/ib_user_verbs.h       |  14 +++
 include/uapi/rdma/rdma_user_rxe.h       |   7 ++
 14 files changed, 302 insertions(+), 12 deletions(-)

-- 
2.31.1

