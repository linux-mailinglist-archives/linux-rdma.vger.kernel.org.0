Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E736C205F61
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2020 22:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391314AbgFWUc1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jun 2020 16:32:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:4712 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391310AbgFWUc0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jun 2020 16:32:26 -0400
IronPort-SDR: vkLQJvPca6avnIqXv0dofFUjaCtQLh8R0n7CfEIYtM0I6bnLr1tcYXdm8UqkEjbZO9xJSusG2C
 picH8K878qVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="205719808"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="205719808"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 13:32:26 -0700
IronPort-SDR: nFyW5RCtl1mc75P85R/+FzEsrguA3LMo2wRB8GWy74iPysiGwaBG7GgqS7zvMf/3wWkBJglNXm
 bNii7WzBYS0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="319259525"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Jun 2020 13:32:25 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 05NKWPhL056457;
        Tue, 23 Jun 2020 13:32:25 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 05NKWOqS107417;
        Tue, 23 Jun 2020 16:32:24 -0400
Subject: [PATCH for-rc 1/2] IB/hfi1: Restore kfree in dummy_netdev cleanup
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Tue, 23 Jun 2020 16:32:24 -0400
Message-ID: <20200623203224.106975.16926.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200623202519.106975.94246.stgit@awfm-01.aw.intel.com>
References: <20200623202519.106975.94246.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

We need to do some rework on the dummy netdev. Calling the free_netdev() would
normally make sense, and that will be addressed in an upcoming patch. For now
just revert the behavior to what it was before keeping the unused variable
removal part of the patch.

The dd->dumm_netdev is mainly used for packet receiving through
NAPI. Consequently, it is allocated with kcalloc_node instead of
alloc_netdev_mqs for typical net devices. A a result, it should be
freed with kfree instead of free_netdev that leads to a crash when
unloading the hfi1 module:

[32200.283994] ########### Unload/Load : Unloading HFI driver on
phwtpriv58.ph.intel.com #########
[32200.455609] infiniband hfi1_0: removing VNIC client
[32200.565845] hfi1 0000:05:00.0: hfi1_0: hfi1 netdev freed
[32200.572643] BUG: kernel NULL pointer dereference, address: 0000000000000000
[32200.581028] #PF: supervisor read access in kernel mode
[32200.587330] #PF: error_code(0x0000) - not-present page
[32200.593614] PGD 8000000855b54067 P4D 8000000855b54067 PUD 84a4f5067 PMD 0
[32200.601899] Oops: 0000 [#1] SMP PTI
[32200.606346] CPU: 73 PID: 10299 Comm: modprobe Not tainted 5.6.0-rc5+ #1
[32200.614292] Hardware name: Intel Corporation S2600WT2R/S2600WT2R, BIOS
SE5C610.86B.01.01.0016.033120161139 03/31/2016
[32200.626704] RIP: 0010:__hw_addr_flush+0x12/0x80
[32200.632310] Code: 40 00 48 83 c4 08 4c 89 e7 5b 5d 41 5c e9 76 77 18 00 66 0f
1f 44 00 00 0f 1f 44 00 00 41 54 49 89 fc 55 53 48 8b 1f 48 39 df <48> 8b 2b 75
08 eb 4a 48 89 eb 48 89 c5 48 89 df e8 99 bf d0 ff 84
[32200.654441] RSP: 0018:ffffb40e08783db8 EFLAGS: 00010282
[32200.660901] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
[32200.669422] RDX: ffffb40e00000000 RSI: 0000000000000246 RDI: ffff88ab13662298
[32200.677997] RBP: ffff88ab13662000 R08: 0000000000001549 R09: 0000000000001549
[32200.686508] R10: 0000000000000001 R11: 0000000000aaaaaa R12: ffff88ab13662298
[32200.695085] R13: ffff88ab1b259e20 R14: ffff88ab1b259e42 R15: 0000000000000000
[32200.703627] FS:  00007fb39b534740(0000) GS:ffff88b31f940000(0000)
knlGS:0000000000000000
[32200.713263] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[32200.720278] CR2: 0000000000000000 CR3: 000000084d3ea004 CR4: 00000000003606e0
[32200.728865] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[32200.737386] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[32200.745976] Call Trace:
[32200.749298]  dev_addr_flush+0x15/0x30
[32200.753989]  free_netdev+0x7e/0x130
[32200.758450]  hfi1_netdev_free+0x59/0x70 [hfi1]
[32200.764043]  remove_one+0x65/0x110 [hfi1]
[32200.769130]  pci_device_remove+0x3b/0xc0
[32200.774121]  device_release_driver_internal+0xec/0x1b0
[32200.780404]  driver_detach+0x46/0x90
[32200.784982]  bus_remove_driver+0x58/0xd0
[32200.789970]  pci_unregister_driver+0x26/0xa0
[32200.795309]  hfi1_mod_cleanup+0xc/0xd54 [hfi1]
[32200.800844]  __x64_sys_delete_module+0x16c/0x260
[32200.806513]  ? exit_to_usermode_loop+0xa4/0xc0
[32200.812054]  do_syscall_64+0x5b/0x200
[32200.816655]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 3584adcd8898 ("IB/hfi1: Use free_netdev() in hfi1_netdev_free()")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/netdev_rx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 63688e8..6d263c9 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -373,7 +373,7 @@ void hfi1_netdev_free(struct hfi1_devdata *dd)
 {
 	if (dd->dummy_netdev) {
 		dd_dev_info(dd, "hfi1 netdev freed\n");
-		free_netdev(dd->dummy_netdev);
+		kfree(dd->dummy_netdev);
 		dd->dummy_netdev = NULL;
 	}
 }

