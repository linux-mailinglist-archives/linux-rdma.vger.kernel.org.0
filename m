Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EFF6ED97D
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Apr 2023 03:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDYBEj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Apr 2023 21:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjDYBEi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Apr 2023 21:04:38 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A993E6;
        Mon, 24 Apr 2023 18:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682384659; i=@fujitsu.com;
        bh=FMaqm65I6znwkEfqLF7qaD9JB/kh1YaaVo2inzzcgVI=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=jCtkZBr/Sl8Hte/EqYxAoeO9QvVeYsG3FvJpNoQZ+XeSYfHmnmlVARPeH7bTguEor
         2//KgsgkAwn94SYRfZFcu5e9VpQFd1co9vvFhT8uonZ2pAVgr3if0Fd09qx+krAjWf
         UqORIktTG2K9foiD98gMMezO+pp07Y5KIoXKaw9EYeTGovNgCNWbGA6zZgwP3SrNee
         OydFmDo2ivy1kHbV9FjLX0AGrYmfPhYxb+1STqxa2Ed5IM52K/LcBBhCXhaKEjdS1e
         xzTLdwDHUWV1N+aGHArfDVuse5Ib/UP6DXKcrZNxKvMpe3gp+iDke7DdwvK6gVvsgY
         +Ql+QEZ84unyw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRWlGSWpSXmKPExsViZ8ORqCuk7p5
  i8OUOq8WNaXIW205vYLeYOeMEo8XbTVNYLKb8WspscXnXHDaLZ4d6WRzYPU6/ucPksWlVJ5vH
  woapzB6fN8l5bP18myWANYo1My8pvyKBNWNj9zHmgrWcFUfvzWZvYDzD3sXIxSEksIVRYm7bD
  ShnBZPEhr3vmCCcg4wSm2f/Zuti5ORgE9CQuNdykxHEFhEIkli65jVYEbNAK6PEkaZJzCAJYQ
  F7iYX3bzCB2CwCqhJblp8Fa+AVcJQ4M/McK4gtIaAgMeXhe2aIuKDEyZlPWEBsZgEJiYMvXjB
  D1ChJXPx6B6q+UqL1wy8WCFtN4uq5TcwTGPlnIWmfhaR9ASPTKkaz4tSistQiXQu9pKLM9IyS
  3MTMHL3EKt1EvdRS3bz8opIMXUO9xPJivdTiYr3iytzknBS9vNSSTYzAgE8pTj62g3Hyrr96h
  xglOZiURHm5wtxShPiS8lMqMxKLM+KLSnNSiw8xynBwKEnwxiq7pwgJFqWmp1akZeYAow8mLc
  HBoyTCu1QJKM1bXJCYW5yZDpE6xagoJc4rqwqUEABJZJTmwbXBIv4So6yUMC8jAwODEE9BalF
  uZgmq/CtGcQ5GJWFeBgWgKTyZeSVw018BLWYCWryL2wVkcUkiQkqqgUmkfs8Ji2MHxRtv8v+y
  fjDD8NNPPTfWZwvvLJvWEbXcJqdaeJsXO8d+j18fhPUPemkc3ijbHVE581GJ25zYNQ/E/p2a2
  7myhsdeX7fZZlWt1vUbobMey1q2xWe+Kf0+8bhPjovER9F0oRS5M4yX/D3WrlqwaD7fxSfb7i
  /5eHHzUd28NI4j2xX2nC09vGQ+z8Stb+9IGl2aMDeu+gUTw43dq27W/rg9sbEnvOd3gfT2+4q
  2r51r2acVJuvq35/1pWFnxkfbm4k71m7b9L41ZF91bJkX59vJjuJPZ3wxbNl2YlakKcel3jnu
  CSu/f3OSlcpsC1/N8v6H1sr0j3fZd8sE3ROyPfbleZGVWuS2K2salViKMxINtZiLihMBOPyzd
  HMDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-12.tower-728.messagelabs.com!1682384657!373578!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15694 invoked from network); 25 Apr 2023 01:04:18 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-12.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2023 01:04:18 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 7EEA810019D;
        Tue, 25 Apr 2023 02:04:17 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 723BC10019C;
        Tue, 25 Apr 2023 02:04:17 +0100 (BST)
Received: from 0819309620d6.localdomain (10.167.234.230) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Tue, 25 Apr 2023 02:04:14 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        <linux-rdma@vger.kernel.org>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>, <guoqing.jiang@linux.dev>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v3 0/3] RDMA/rtrs: bugfix and cleanups
Date:   Tue, 25 Apr 2023 01:02:40 +0000
Message-ID: <1682384563-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.234.230]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

V3:
 - minor comments fixes and add tags

V2:
- Add new patch2 to fix a memory leak
- rewrite original patch2 to patch3 by refactoring the cleanup path instead of
  introducing a new flag
- Drop original patch3: RDMA/rtrs: Fix use-after-free in rtrs_clt_rdma_cm_handler
  The problem it tried to addressing doesn't appear after the new patch3
  where it adjust the cleanup order

It's trying to fix 1 issue triggered by the following script which
connect/disconnect rnbd frequently.

# cat rnbd-self.sh 
#!/bin/bash

/root/rpma/tools/config_softroce.sh eth0
modprobe rnbd_server
modprobe rnbd_client

while true;
do
        echo "sessname=xyz path=ip:<server-ip> device_path=/dev/nvme0n1" > /sys/devices/virtual/rnbd-client/ctl/map_device
        for i in /sys/block/rnbd*/rnbd/unmap_device
        do
                echo "normal" > $i
        done
done

Li Zhijian (3):
  RDMA/rtrs: remove duplicate cq_num assignment
  RDMA/rtrs: Fix the last iu->buf leak in err path
  RDMA/rtrs: Fix rxe_dealloc_pd warning

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 56 +++++++++++---------------
 drivers/infiniband/ulp/rtrs/rtrs.c     |  4 +-
 2 files changed, 26 insertions(+), 34 deletions(-)

-- 
2.29.2

