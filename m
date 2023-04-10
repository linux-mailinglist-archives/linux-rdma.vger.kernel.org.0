Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18D96DC39F
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 08:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjDJGnc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 02:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDJGnb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 02:43:31 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB842D47;
        Sun,  9 Apr 2023 23:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1681109008; i=@fujitsu.com;
        bh=lz2fI0gpznOYEVET54zSAl1n0IRovlfLa0r/idjEk1w=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=d1pHysgimmoV7X2JKFbYJgttT37v7dBF8WSiO73AKPlDXgKiWCdRobdlDUtQEfRxf
         VSHlNayFMFudbyl3eaWlzmH+DAOeT0RZeFoFv2UfDmJoNRgfTHeRCYID6M4HDcBEJM
         sdREHTD/Mt4/S1MQUlmAd9ZvVmNKG3U7S67p7XwRkISycRutW7ebseyMC7AClLda0z
         zy4ysVPlGOSVgRA9KMkzrB15MBbfDjHAnLE686/PKJV12SMfKxVh5+CIxSS5rePtUx
         xs4B8IR3q9db5D9MwCyLV4ZN1ydGODP0BrOi+GG8s1LVDZnktaW+kUcUCl3OJeS6gv
         dj40sry45YI3Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRWlGSWpSXmKPExsViZ8ORpMu/wTj
  FoOsmq8WNaXIW205vYLeYOeMEo8XbTVNYLKb8WspscXnXHDaLZ4d6WRzYPU6/ucPksWlVJ5vH
  woapzB6fN8l5bP18myWANYo1My8pvyKBNaOrMbhgPVvFvol7WBoY57J2MXJxCAlsZJTYP+EqE
  4SzhEmiubmZDcLZzyix7VgfUIaTg01AQ+Jey01GEFtEoFTicNs+dhCbWSBJYt7tt8wgtrCAmc
  S0pm1sIDaLgKrE0hc/WUFsXgFHiUN3t4DNkRBQkJjy8D0zRFxQ4uTMJywQcyQkDr54wQxRoyh
  xpPMvC4RdIdE4/RBUr5rE1XObmCcw8s9C0j4LSfsCRqZVjGbFqUVlqUW6hmZ6SUWZ6RkluYmZ
  OXqJVbqJeqmluuWpxSW6hnqJ5cV6qcXFesWVuck5KXp5qSWbGIHBnlLM/HIH44m+v3qHGCU5m
  JREebu4jFOE+JLyUyozEosz4otKc1KLDzHKcHAoSfB+XwCUEyxKTU+tSMvMAUYeTFqCg0dJhP
  fEMqA0b3FBYm5xZjpE6hSjopQ47691QAkBkERGaR5cGyzaLzHKSgnzMjIwMAjxFKQW5WaWoMq
  /YhTnYFQS5p0EMp4nM68EbvoroMVMQIu5XAxAFpckIqSkGpiyPNO7uE/+2jFF1XGe9n/Z49Pr
  Zm2ueMh1r4yvlV3+sZDoI/fIl/++v2+Nca5t298jkyh/6twku+Pp2TqX/phlvt5xdlXBm8k3K
  wxflc26fzXvv7nNjfdvZ/geffWtQv991OQTpxXmz09NyaoOWLjppvbjGueoiIyvi10fMAlols
  7dLCDoESpZu8nUv+fKLaND2Qd2+KvPX+i8PnPrhv3PF+7U9P/EebX30r4l/puU/Tf3cN1a8W7
  qrb8ua/ln7xUUXPpRutSlPmLF8sY/aztCuJ0KX5y+ssqm+uO+Tby35hy7vdnfuDdx9gax6NkK
  0RGf3h79+EhJcYtT7irDtYfM1q273RF15gp7Xl3B0fbrH5RYijMSDbWYi4oTAbC+cRdxAwAA
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-12.tower-587.messagelabs.com!1681109006!373208!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1604 invoked from network); 10 Apr 2023 06:43:27 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-12.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Apr 2023 06:43:27 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id A320C1CD;
        Mon, 10 Apr 2023 07:43:26 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 97C791C8;
        Mon, 10 Apr 2023 07:43:26 +0100 (BST)
Received: from 31d618797ed9.localdomain (10.167.226.45) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 10 Apr 2023 07:43:23 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <guoqing.jiang@linux.dev>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 0/3] rtrs bugfix and cleanups
Date:   Mon, 10 Apr 2023 06:43:01 +0000
Message-ID: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It's trying to fix 2 issues caused by the following script which
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
  RDMA/rtrs: Fix rxe_dealloc_pd warning
  RDMA/rtrs: Fix use-after-free in rtrs_clt_rdma_cm_handler

 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 19 ++++++++++++++-----
 drivers/infiniband/ulp/rtrs/rtrs-clt.h |  1 +
 2 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.29.2

