Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32603558F55
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jun 2022 05:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiFXDzy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 23 Jun 2022 23:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiFXDzx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 23 Jun 2022 23:55:53 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9238D515A1;
        Thu, 23 Jun 2022 20:55:51 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AON+mDag33EU2n51+SN8rSLyRX161jhIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUDyGZMXzjUMqyJZjT1edFzOt7gox4OsJXTzd9kTVRv+3w8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14NFMp5yxS?=
 =?us-ascii?q?wYgOIXCheYcTwJFVSp5OMWq/ZeeeyXh7pTLkB2un3zEhq8G4FsNFYcG8+B+Gnp?=
 =?us-ascii?q?F9fEwITsIKBeZiIqexL+8TMFvi94lIc2tO5kQ0llkzDfEHbMlTIrFTqHi+9BVx?=
 =?us-ascii?q?nEzi9pIEPKYYNAWARJrbRLdc1hVNlIeIIwxkf3uhXTldTBc7lWPqsIf4Wfc5B5?=
 =?us-ascii?q?w3aDgdtHcEuFm7+09cl2w/zqApjqmREpBcoH39NZMyVr07senoM8xcNt6+GWEy?=
 =?us-ascii?q?8NX?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ADD9WE6xjrp2YTTTPNTqJKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="125670078"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Jun 2022 11:55:50 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 4B6094D68A22;
        Fri, 24 Jun 2022 11:55:45 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 24 Jun 2022 11:55:45 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 24 Jun 2022 11:55:45 +0800
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [RFC PATCH] RDMA/srp: Fix use-after-free in srp_exit_cmd_priv
Date:   Fri, 24 Jun 2022 12:02:53 +0800
Message-ID: <20220624040253.1420844-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4B6094D68A22.AE690
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

srp_exit_cmd_priv() will try to access srp_device by Scsi_Host like below:

 Scsi_Host                srp_target_port     srp_host         srp_device
+------------------+ +-- +--------------+  +>+----------+   +->+---------+
|                  | |   |              |  | |          |   |  |         |
|                  | |   |  *srp_host   +--+ | *srp_dev +---+  | *dev    |
+-+hostdata--------+-+   |              |    |          |      |         |
| | srp_target_port|     |              |    |          |      |         |
| |                |     |              |    |          |      |         |
| |                |     |              |    |          |      |         |
+-+----------------+---- +--------------+    +----------+      +---------+

But sometims Scsi_Host still keeps the reference to srp_host that is
possible released already. This could be happend if i frequently abort
(Ctrl-c) the blktests during it was running and then cause below error:

[  952.294952] scsi 9:0:0:1: alua: Detached
[  952.298232] ==================================================================
[  952.298235] BUG: KASAN: use-after-free in srp_exit_cmd_priv+0x27/0xd0 [ib_srp]
[  952.298254] Read of size 8 at addr ffff888100337000 by task multipathd/16727
[  952.298258]
[  952.298263] CPU: 0 PID: 16727 Comm: multipathd Not tainted 5.19.0-rc1-roce-flush+ #78
[  952.298268] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-27-g64f37cc530f1-prebuilt.qemu.org 04/01/2014
[  952.298272] Call Trace:
[  952.298281]  <TASK>
[  952.298283]  dump_stack_lvl+0x34/0x44
[  952.298303]  print_report.cold+0x5e/0x5db
[  952.298317]  ? schedule_timeout+0x1c4/0x210
[  952.298329]  ? srp_exit_cmd_priv+0x27/0xd0 [ib_srp]
[  952.298343]  kasan_report+0xab/0x120
[  952.298356]  ? srp_exit_cmd_priv+0x27/0xd0 [ib_srp]
[  952.298370]  srp_exit_cmd_priv+0x27/0xd0 [ib_srp]
[  952.298384]  scsi_mq_exit_request+0x4d/0x70
[  952.298394]  blk_mq_free_rqs+0x143/0x410
[  952.298406]  __blk_mq_free_map_and_rqs+0x6e/0x100
[  952.298413]  blk_mq_free_tag_set+0x2b/0x160
[  952.298419]  scsi_host_dev_release+0xf3/0x1a0
[  952.298427]  device_release+0x54/0xe0
[  952.298438]  kobject_put+0xa5/0x120
[  952.298451]  device_release+0x54/0xe0
[  952.298456]  kobject_put+0xa5/0x120
[  952.298461]  scsi_device_dev_release_usercontext+0x4c1/0x4e0
[  952.298468]  ? scsi_device_cls_release+0x10/0x10
[  952.298474]  execute_in_process_context+0x23/0x90
[  952.298483]  device_release+0x54/0xe0
[  952.298487]  kobject_put+0xa5/0x120
[  952.298493]  scsi_disk_release+0x3f/0x50
[  952.298500]  device_release+0x54/0xe0
[  952.298504]  kobject_put+0xa5/0x120
[  952.298509]  disk_release+0x17f/0x1b0
[  952.298516]  device_release+0x54/0xe0
[  952.298520]  kobject_put+0xa5/0x120
[  952.298526]  dm_put_table_device+0xa3/0x160 [dm_mod]
[  952.298559]  dm_put_device+0xd0/0x140 [dm_mod]
[  952.298592]  free_priority_group+0xd8/0x110 [dm_multipath]
[  952.298602]  free_multipath+0x94/0xe0 [dm_multipath]
[  952.298612]  dm_table_destroy+0xa2/0x1e0 [dm_mod]
[  952.298645]  __dm_destroy+0x196/0x350 [dm_mod]
[  952.298676]  dev_remove+0x10c/0x160 [dm_mod]
[  952.298709]  ctl_ioctl+0x2c2/0x590 [dm_mod]
[  952.298751]  ? table_clear+0x100/0x100 [dm_mod]
[  952.298784]  ? remove_all+0x40/0x40 [dm_mod]
[  952.298820]  ? __blkcg_punt_bio_submit+0xd0/0xd0
[  952.298828]  ? __rcu_read_unlock+0x43/0x60
[  952.298838]  dm_ctl_ioctl+0x5/0x10 [dm_mod]
[  952.298870]  __x64_sys_ioctl+0xb4/0xf0
[  952.298784]  ? remove_all+0x40/0x40 [dm_mod]
[  952.298820]  ? __blkcg_punt_bio_submit+0xd0/0xd0
[  952.298828]  ? __rcu_read_unlock+0x43/0x60
[  952.298838]  dm_ctl_ioctl+0x5/0x10 [dm_mod]
[  952.298870]  __x64_sys_ioctl+0xb4/0xf0
[  952.298877]  do_syscall_64+0x3b/0x90
[  952.298884]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  952.298890] RIP: 0033:0x7f1d7f4654eb
[  952.298896] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 b9 0c 00 f7 d8 64 89 01 48
[  952.298903] RSP: 002b:00007f1d7de21558 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
[  952.298912] RAX: ffffffffffffffda RBX: 00007f1d7f682050 RCX: 00007f1d7f4654eb
[  952.298916] RDX: 00007f1d6c016730 RSI: 00000000c138fd04 RDI: 0000000000000005
[  952.298919] RBP: 00007f1d7f6be2b6 R08: 00007f1d7de1f2b0 R09: 00007f1d7de1f200
[  952.298922] R10: 0000000000000001 R11: 0000000000000206 R12: 00007f1d6c001100
[  952.298925] R13: 00007f1d6c016760 R14: 00007f1d6c0167e0 R15: 00007f1d6c016730
[  952.298930]  </TASK>
[  952.298933]
[  952.298934] Allocated by task 16887:
[  952.298939]  kasan_save_stack+0x1e/0x40
[  952.298944]  __kasan_kmalloc+0x81/0xa0
[  952.298948]  srp_add_one+0x32a/0x540 [ib_srp]
[  952.298961]  add_client_context+0x23b/0x300 [ib_core]
[  952.299043]  ib_register_client+0x1d5/0x220 [ib_core]
[  952.299123]  0xffffffffc0a60149
[  952.299125]  do_one_initcall+0x84/0x280
[  952.299132]  do_init_module+0xdf/0x2e0
[  952.299136]  load_module+0x2b9e/0x2c90
[  952.299139]  __do_sys_finit_module+0x111/0x190
[  952.299143]  do_syscall_64+0x3b/0x90
[  952.299147]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  952.299152]
[  952.299153] Freed by task 17289:
[  952.299156]  kasan_save_stack+0x1e/0x40
[  952.299160]  kasan_set_track+0x21/0x30
[  952.299164]  kasan_set_free_info+0x20/0x30
[  952.299169]  __kasan_slab_free+0x108/0x170
[  952.299173]  kfree+0x9a/0x320
[  952.299177]  srp_remove_one+0x114/0x180 [ib_srp]
[  952.299189]  remove_client_context+0x8f/0xd0 [ib_core]
[  952.299269]  disable_device+0xee/0x1e0 [ib_core]
[  952.299348]  __ib_unregister_device+0x59/0xf0 [ib_core]
[  952.299429]  ib_unregister_device_and_put+0x3b/0x50 [ib_core]
[  952.299509]  nldev_dellink+0x126/0x1b0 [ib_core]
[  952.299592]  rdma_nl_rcv_msg+0x1cc/0x310 [ib_core]
[  952.299673]  rdma_nl_rcv+0x172/0x200 [ib_core]
[  952.299760]  netlink_unicast+0x36b/0x4a0
[  952.299770]  netlink_sendmsg+0x3a9/0x6d0
[  952.299774]  sock_sendmsg+0x91/0xa0
[  952.299783]  __sys_sendto+0x16f/0x210
[  952.299788]  __x64_sys_sendto+0x6f/0x80
[  952.299792]  do_syscall_64+0x3b/0x90
[  952.299795]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  952.299801]
[  952.299801] Last potentially related work creation:
[  952.299803]  kasan_save_stack+0x1e/0x40
[  952.299807]  __kasan_record_aux_stack+0x97/0xa0
[  952.299812]  call_rcu+0x41/0x580
[  952.299816]  rht_deferred_worker+0x552/0x700
[  952.299830]  kthread+0x167/0x1a0
[  952.299835]  ret_from_fork+0x22/0x30
[  952.299839]
[  952.299840] The buggy address belongs to the object at ffff888100337000
[  952.299840]  which belongs to the cache kmalloc-1k of size 1024
[  952.299844] The buggy address is located 0 bytes inside of
[  952.299844]  1024-byte region [ffff888100337000, ffff888100337400)
[  952.299848]
[  952.299849] The buggy address belongs to the physical page:
[  952.299850] page:000000005d3ee749 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100334
[  952.299857] head:000000005d3ee749 order:2 compound_mapcount:0 compound_pincount:0
[  952.299860] flags: 0x100000000010200(slab|head|node=0|zone=2)
[  952.299868] raw: 0100000000010200 0000000000000000 dead000000000001 ffff888100041dc0
[  952.299872] raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
[  952.299874] page dumped because: kasan: bad access detected
[  952.299876]
[  952.299876] Memory state around the buggy address:
[  952.299878]  ffff888100336f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  952.299882]  ffff888100336f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  952.299885] >ffff888100337000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  952.299887]                    ^
[  952.299889]  ffff888100337080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  952.299892]  ffff888100337100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This patch is mainly to report the use-after-free bug. It seems the proposal
increasing the IB device's reference count is a bit ugly. Feedbacks and
ideas are very welcome.
---
 drivers/infiniband/ulp/srp/ib_srp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
index 6058abf42ba7..5981a0ea7a19 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -979,6 +979,8 @@ static int srp_exit_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 				    DMA_TO_DEVICE);
 	}
 	kfree(req->indirect_desc);
+	/* pair with get_device() in srp_init_cmd_priv() */
+	put_device(&ibdev->dev);
 
 	return 0;
 }
@@ -1006,12 +1008,14 @@ static int srp_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 				     target->indirect_size,
 				     DMA_TO_DEVICE);
 	if (ib_dma_mapping_error(ibdev, dma_addr)) {
+		get_device(&ibdev->dev);
 		srp_exit_cmd_priv(shost, cmd);
 		goto out;
 	}
 
 	req->indirect_dma_addr = dma_addr;
 	ret = 0;
+	get_device(&ibdev->dev);
 
 out:
 	return ret;
-- 
2.31.1



