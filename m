Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D66EBC3D
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Apr 2023 03:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjDWB1b (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Apr 2023 21:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDWB1a (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Apr 2023 21:27:30 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E0310E2;
        Sat, 22 Apr 2023 18:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1682213247; i=@fujitsu.com;
        bh=q8VRNeqr3EzQLYWmemAVzstBD0W+cAm/QdJIUQrLxOs=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=aSBjJlGrF+mkkCk+0LdlH8rMxJNKRRdqZ65YCqyN4OCDI+PvyDkSUyTMDeIS2i1H0
         Jpjarf4+ywBAWyhTl3qHN/J4ubuXXfeNf83wyLzV1GCVUlC9wRTxL9Z0HGR2pxBFEg
         SfROSGP4Jzu2TLjAhtKAJP0geTzhSU1voG8Uw78zftkMoXiij6Gcww1BU95QpEcdB1
         pFW8w4JNVbSpYpGzpvgvmridzipOtCLoVpu/WgkpCvZOQ2Wpne8/NYnUMLKHW4seY4
         nL4I5R6NW/ptwgXQ5+qoIKwoEtZR5Klqi9O4lQlR8qXr/X+QvIsCdgl7AGTOlueIei
         P88A6R/cpQeEg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRWlGSWpSXmKPExsViZ8ORqFvb6ZJ
  i0HiV2+LGNDmLbac3sFvMnHGC0eLtpiksFlN+LWW2uLxrDpvFs0O9LA7sHqff3GHy2LSqk81j
  YcNUZo/Pm+Q8tn6+zRLAGsWamZeUX5HAmnH/dhtLQTNnxYolM1kaGNewdzFycQgJbGGUmHRyP
  pSzgknixLZLbBDOAUaJ5TufsHQxcnKwCWhI3Gu5yQhiiwiUShxu28cOYjMLJEnMu/2WGcQWFr
  CXuLFsHiuIzSKgKnH59nMwm1fAUeLKuR6wGgkBBYkpD98zQ8QFJU7OhJjPLCAhcfDFC6gaRYk
  jnX9ZIOxKidYPv6BsNYmr5zYxT2Dkn4WkfRaS9gWMTKsYTYtTi8pSi3RN9JKKMtMzSnITM3P0
  Eqt0E/VSS3XLU4tLdI30EsuL9VKLi/WKK3OTc1L08lJLNjECgz2lWKljB+P1nX/1DjFKcjApi
  fK+2O2QIsSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC92ObS4qQYFFqempFWmYOMPJg0hIcPEoivF
  vLgNK8xQWJucWZ6RCpU4yKUuK8UzqAEgIgiYzSPLg2WLRfYpSVEuZlZGBgEOIpSC3KzSxBlX/
  FKM7BqCTMqwcyhSczrwRu+iugxUxAi3dxgy0uSURISTUwuevwLF8z659/0LfmyafVDnO+vZrd
  eZFDgM3ZUeZk45PZG9NTz0qG3lx33Krcz2ZK2YKtluv2XotW2GxdyPx/iV/A5Nkrn+2sfaV2a
  vLmvC+Kt8s+RKas8E50mnmRnY1hTt/Txu1if85m2i/UXHrj102dsOtBZ+u5nly6KnZgO3vbRR
  m+WD+2Jb8/Hlm29YWS2fSGObEafze/zX97rEnL4XbHoa1dm+d9MeiMYv7P9kru0Jsn8XJiwbw
  NH2q4jgtk+XV9EE7rkBI93r1+78eDceZd8oGHLsheZ/EJ/vb0vdns+ToN1tpHayxO7JT2TQ36
  clhtQc8ECfdeZa9J2x4fVTlWvWbf5Cf3ajdGan8IvqvEUpyRaKjFXFScCAB9YHZ+cQMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-20.tower-565.messagelabs.com!1682213245!159966!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.105.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1217 invoked from network); 23 Apr 2023 01:27:25 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-20.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 23 Apr 2023 01:27:25 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id D7C4C100226;
        Sun, 23 Apr 2023 02:27:24 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id CAF6B1001BF;
        Sun, 23 Apr 2023 02:27:24 +0100 (BST)
Received: from d3e152dc4f88.localdomain (10.167.226.45) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sun, 23 Apr 2023 02:27:21 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <guoqing.jiang@linux.dev>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next v2 0/3] RDMA/rtrs: bugfix and cleanups
Date:   Sun, 23 Apr 2023 01:26:49 +0000
Message-ID: <1682213212-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

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

