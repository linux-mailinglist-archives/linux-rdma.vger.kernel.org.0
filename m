Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58076879E0
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 11:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBBKMd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 05:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBBKMc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 05:12:32 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFA971980;
        Thu,  2 Feb 2023 02:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1675332749; i=@fujitsu.com;
        bh=Xwlzw8ZkVc8qFjT2/kbyQQc8iQPR/+H0cWkF6AvYxx0=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=DyuzyjkCF1P1XOL0wCAR+F2a5geSAvjATXOaFpor0IvQqITTqtTbpMPlbf42SM7Kk
         1FJ5Qk3mLFG5E3NPm35+TEqOYDLK/oLoV/n0wGfTMyJhb8M6wWOlLdmLSmhlKJZlfD
         nboV54O0S+j3Dwh6LAfzWgrvVAVZAWohYREM090LCYzaQSx9JOm6nuPrzDBY3pa8Ta
         hpPzZFuJUjDpMvBzOQLWtZve80VBVO4eLncm0T8A3a8GpcnhpAOlR6gWYTj8/HlwOw
         rSb3sHMM/sJ8V/VBVsmbp7pG5ItEIm3+UTi2kKfc634y8NHbopiz0T7UF1GtgCn+VN
         MbWi+sU1s/ATw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRWlGSWpSXmKPExsViZ8ORqNvTczv
  ZYNk9PYsb0+Qstp3ewG4xc8YJRou3m6awWEz5tZTZ4vKuOWwWzw71sjiwe5x+c4fJY9OqTjaP
  hQ1TmT0+b5Lz2Pr5NksAaxRrZl5SfkUCa8adtx/ZC9oVKz72TGFsYDwv08XIxSEksIVRon/Jc
  hYIZwWTxPbpB9ggnAOMEptWtDN2MXJysAloSNxruQlmiwgESSxd85oJpIhZoJVR4kjTJGaQhL
  CAh8TLqfPBilgEVCSezZrOCmLzCjhK3Oj4wgJiSwgoSEx5+J4ZIi4ocXLmE7A4s4CExMEXL4D
  iHEA1ShIzu+MhyislWj/8gmpVk7h6bhPzBEb+WUi6ZyHpXsDItIrRtDi1qCy1SNdSL6koMz2j
  JDcxM0cvsUo3US+1VLc8tbhE10gvsbxYL7W4WK+4Mjc5J0UvL7VkEyMw2FOK1eR3MB7u+6t3i
  FGSg0lJlPdx9+1kIb6k/JTKjMTijPii0pzU4kOMMhwcShK85zuBcoJFqempFWmZOcDIg0lLcP
  AoifBuB2nlLS5IzC3OTIdInWLU5djw4MBeZiGWvPy8VClxXs8OoCIBkKKM0jy4EbAkcIlRVkq
  Yl5GBgUGIpyC1KDezBFX+FaM4B6OSMO9VkFU8mXklcJteAR3BBHTEXeubIEeUJCKkpBqYBJpO
  RWksTQs4IVe/53naHb0nVd8m7ZV9uN+t++WUvecSH7RPfsEZnCurZp3c1flCfNLxNQdLS/+Hi
  Mk0ZNzV0Loo8rStcLqDSGXXLBsDPqnDz3xn/002f9wde/U+Q9Or049WGf1uW/dfdNm3dY+MDU
  QLI4OPq9REt358dXeCgSVjbtTVOtYmfb/73HZl93nfhC7L5hNh2+PEkjFtetsL7qLAiIRnU7o
  +23FLXN/p/WZ6X6Xxyd/M907/k1O5zOWm1/JwckLFyfCylOe/LOvPPeRq9gxwNE/bIfap6MZF
  mVM5XkEcOssj/6fcPprw3YMn1zBNsIs19tyuYNEeyz3tJ+csvuxyXjL6Bv/bB8+UWIozEg21m
  IuKEwEnRDrgfQMAAA==
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-3.tower-548.messagelabs.com!1675332748!96102!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25528 invoked from network); 2 Feb 2023 10:12:28 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-3.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Feb 2023 10:12:28 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 6927D100198;
        Thu,  2 Feb 2023 10:12:28 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 5C527100188;
        Thu,  2 Feb 2023 10:12:28 +0000 (GMT)
Received: from f81be4a9964a.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 2 Feb 2023 10:12:25 +0000
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>,
        <linux-rdma@vger.kernel.org>
CC:     <jgg@ziepe.ca>, <leon@kernel.org>, <guoqing.jiang@linux.dev>,
        <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2] RDMA/rtrs: Don't call kobject_del for srv_path->kobj
Date:   Thu, 2 Feb 2023 10:12:01 +0000
Message-ID: <1675332721-2-1-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
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

As the mention in commmit f7452a7e96c1 ("RDMA/rtrs-srv: fix memory leak by missing kobject free"),
it was intended to remove the kobject_del for srv_path->kobj.

f7452a7e96c1 said:
>This patch moves kobject_del() into free_sess() so that the kobject of
>    rtrs_srv_sess can be freed.

This patch also move rtrs_srv_destroy_once_sysfs_root_folders back to
'if (srv_path->kobj.state_in_sysfs)' block to avoid a 'held lock freed!'

A kernel panic will be triggered by following script
-----------------------
$ while true
do
        echo "sessname=foo path=ip:<ip address> device_path=/dev/nvme0n1" > /sys/devices/virtual/rnbd-client/ctl/map_device
        echo "normal" > /sys/block/rnbd0/rnbd/unmap_device
done
-----------------------
The bisection pointed to commit 6af4609c18b3 ("RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files")
at last.

 rnbd_server L777: </dev/nvme0n1@foo>: Opened device 'nvme0n1'
 general protection fault, probably for non-canonical address 0x765f766564753aea: 0000 [#1] PREEMPT SMP PTI
 CPU: 0 PID: 3558 Comm: systemd-udevd Kdump: loaded Not tainted 6.1.0-rc3-roce-flush+ #51
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 RIP: 0010:kernfs_dop_revalidate+0x36/0x180
 Code: 00 00 41 55 41 54 55 53 48 8b 47 68 48 89 fb 48 85 c0 0f 84 db 00 00 00 48 8b a8 60 04 00 00 48 8b 45 30 48 85 c0 48 0f 44 c5 <4c> 8b 60 78 49 81 c4 d8 00 00 00 4c 89 e7 e8 b7 78 7b 00 8b 05 3d
 RSP: 0018:ffffaf1700b67c78 EFLAGS: 00010206
 RAX: 765f766564753a72 RBX: ffff89e2830849c0 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff89e2830849c0
 RBP: ffff89e280361bd0 R08: 0000000000000000 R09: 0000000000000001
 R10: 0000000000000065 R11: 0000000000000000 R12: ffff89e2830849c0
 R13: ffff89e283084888 R14: d0d0d0d0d0d0d0d0 R15: 2f2f2f2f2f2f2f2f
 FS:  00007f13fbce7b40(0000) GS:ffff89e2bbc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f93e055d340 CR3: 0000000104664002 CR4: 00000000001706f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <TASK>
  lookup_fast+0x7b/0x100
  walk_component+0x21/0x160
  link_path_walk.part.0+0x24d/0x390
  path_openat+0xad/0x9a0
  do_filp_open+0xa9/0x150
  ? lock_release+0x13c/0x2e0
  ? _raw_spin_unlock+0x29/0x50
  ? alloc_fd+0x124/0x1f0
  do_sys_openat2+0x9b/0x160
  __x64_sys_openat+0x54/0xa0
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd
 RIP: 0033:0x7f13fc9d701b
 Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
 RSP: 002b:00007ffddf242640 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f13fc9d701b
 RDX: 0000000000080000 RSI: 00007ffddf2427c0 RDI: 00000000ffffff9c
 RBP: 00007ffddf2427c0 R08: 00007f13fcc5b440 R09: 21b2131aa64b1ef2
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000080000
 R13: 00007ffddf2427c0 R14: 000055ed13be8db0 R15: 0000000000000000

Fixes: 6af4609c18b3 ("RDMA/rtrs-srv: Fix several issues in rtrs_srv_destroy_path_files")
Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: Call rtrs_srv_destroy_once_sysfs_root_folders in condition to avoid
a 'held lock freed!'
---
 drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
index c76ba29da1e2..5adba0f754b6 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
@@ -312,9 +312,8 @@ void rtrs_srv_destroy_path_files(struct rtrs_srv_path *srv_path)
 
 	if (srv_path->kobj.state_in_sysfs) {
 		sysfs_remove_group(&srv_path->kobj, &rtrs_srv_path_attr_group);
-		kobject_del(&srv_path->kobj);
 		kobject_put(&srv_path->kobj);
+		rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
 	}
 
-	rtrs_srv_destroy_once_sysfs_root_folders(srv_path);
 }
-- 
1.8.3.1

