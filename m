Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A229B6DC3A5
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Apr 2023 08:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjDJGnu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Apr 2023 02:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjDJGnn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Apr 2023 02:43:43 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176692D6A;
        Sun,  9 Apr 2023 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1681109018; i=@fujitsu.com;
        bh=4cYvlyImJig+3PsNpJOM0kOmh8zSDTANyqqOA8qFK9o=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ACGymuscUKaNZuKVvZbv+Mr7q7ojEnxrDwMItz0uwmsQeTAowFI2pVJ7pOm2jniE3
         ReDK/Z4cbNV+KiKWO0FJS4eQ/CCjrdeA654lxO6YesNqL8B4jjLBs5TJYBFBW4Yjey
         c+ehOYtpKQi+UvYSr3JPxjMTNz2a6HmT9J/ZhzwzdCvdHKSn8WqRORhnvXcruwN2eG
         SrDS13OjQOhv9X0i495P15CYdpO+VUNxTBQJPMmiGP0ePavJCUj3DTm2DlTj0O8dyo
         w/eoX/m4UeC3UGnghI5/n7Hs/+nLQSfUdjTSTDDvmVdmNf8/qkr8nzJKUkoWaD5eq6
         RFn3VWgoINvqg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleJIrShJLcpLzFFi42Kxs+FI0pXcYJx
  i8Gwim8WNaXIW205vYLeYOeMEo8XbTVNYLKb8WspscXnXHDaLZ4d6WRzYPU6/ucPksWlVJ5vH
  woapzB6fN8l5bP18myWANYo1My8pvyKBNePzxO/sBTsVKxZNn8bewHhUuouRi0NIYCOjxKmPh
  5ggnCVMEudWv2TvYuQEcvYzSkztrgOx2QQ0JO613GQEsUUESiUOt+0Dq2EWSJKYd/stM4gtLB
  ApsXdxNxOIzSKgKvF/7jYwm1fAUeJf80swW0JAQWLKw/dg9ZwCThINrRdZIXY5SlxZ38gIUS8
  ocXLmExaI+RISB1+8YIboVZQ40vmXBcKukGicfghqpprE1XObmCcwCs5C0j4LSfsCRqZVjKbF
  qUVlqUW65npJRZnpGSW5iZk5eolVuol6qaW65anFJbqGeonlxXqpxcV6xZW5yTkpenmpJZsYg
  bGRUsz0bgfj8r6/eocYJTmYlER5u7iMU4T4kvJTKjMSizPii0pzUosPMcpwcChJ8H5fAJQTLE
  pNT61Iy8wBxilMWoKDR0mE98QyoDRvcUFibnFmOkTqFKMux4YHB/YyC7Hk5eelSonz/loHVCQ
  AUpRRmgc3ApYyLjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5p0EsoonM68EbtMroCOYgI7g
  cjEAOaIkESEl1cD0MnqfTtQazuZdupusrplwhtqckjDP3pEiYDNh09vSR8q+rVeOrX9XI+udn
  LC5U3FxoNyZqnQpplsuqgrycxP+lBSeOHvtzJHibsf+/jLRE6ITOAUlbNW+3a9eeshN0NrdY8
  FmkwCl/BBm6U+bqrdFXVXTOBRv/rL26082BqZY3xXt/3880JeZm/x19+R1X/40VXeWfi4591k
  xlPHVgylHt5i/nR3ONn37tSNzlpr8cvqum7LMgvuR/rF7fSulG2dnW+z2mD3lt/HrC11MK+xa
  MqMf2c1ZrTbpz73JR24zr4x6Jn5ayuaj7QrBG6szaidsfup/NLm25WO+rq1LWKTLfebwO6XuS
  dPPhjpbns9VYinOSDTUYi4qTgQAMVHzWpQDAAA=
X-Env-Sender: lizhijian@fujitsu.com
X-Msg-Ref: server-12.tower-585.messagelabs.com!1681109016!187050!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.104.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7574 invoked from network); 10 Apr 2023 06:43:37 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-12.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 10 Apr 2023 06:43:37 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id A91CD1CD;
        Mon, 10 Apr 2023 07:43:36 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id 9D5E71C7;
        Mon, 10 Apr 2023 07:43:36 +0100 (BST)
Received: from 31d618797ed9.localdomain (10.167.226.45) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Mon, 10 Apr 2023 07:43:33 +0100
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     <haris.iqbal@ionos.com>, <jinpu.wang@ionos.com>, <jgg@ziepe.ca>,
        <leon@kernel.org>, <linux-rdma@vger.kernel.org>
CC:     <guoqing.jiang@linux.dev>, <linux-kernel@vger.kernel.org>,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH for-next 3/3] RDMA/rtrs: Avoid use-after-free in rtrs_clt_rdma_cm_handler
Date:   Mon, 10 Apr 2023 06:43:04 +0000
Message-ID: <1681108984-2-4-git-send-email-lizhijian@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
References: <1681108984-2-1-git-send-email-lizhijian@fujitsu.com>
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

Currently, con will be destroyed when wait_event_interruptible_timeout()
returns ERESTARTSYS. But the in-flight event handler
rtrs_clt_rdma_cm_handler() could be rescheduled/wakeup which
may cause a use-after-free.

    WARNING: CPU: 0 PID: 14766 at drivers/infiniband/ulp/rtrs/rtrs-clt.c:1687 rtrs_clt_rdma_cm_handler+0x620/0x640 [rtrs_client]
     Modules linked in: rnbd_client rtrs_client rtrs_core rdma_cm iw_cm ib_cm rdma_rxe ib_uverbs ib_core libiscsi scsi_transport_iscsi crc32_generic udp_tunnel dax_pmem nd_pmem nd_btt virtiofs crc32c_intel nvme fuse nvme_core nfit
libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_mirror dm_region_hash dm_log dm_mod [last unloaded: ib_core]
     CPU: 0 PID: 14766 Comm: kworker/u2:3 Kdump: loaded Tainted: G        W          6.2.0-rc6-roce-flush+ #56
     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
     Workqueue: ib_addr process_one_req [ib_core]
     RIP: 0010:rtrs_clt_rdma_cm_handler+0x620/0x640 [rtrs_client]
     Code: 00 0f 85 5f fd ff ff 4c 8b 23 41 bd f4 ff ff ff e9 95 fb ff ff 0f 0b 4c 89 f7 41 bd ea ff ff ff e8 75 c8 92 ec e9 4b ff ff ff <0f> 0b 4c 89 f7 41 bd ea ff ff ff e8 60 c8 92 ec e9 36 ff ff ff e8
     RSP: 0018:ffffa4ef41cdbc60 EFLAGS: 00010246
     RAX: 0000000000000000 RBX: ffff9372c394e600 RCX: 0000000000000001
     RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffffad634277
     RBP: ffffa4ef41cdbd00 R08: 0000000000000000 R09: 0000000000000001
     R10: 0000000000003ff3 R11: 0000000000000000 R12: ffff9372c3164800
     R13: ffff9372c3164800 R14: ffff9372c394e640 R15: ffff9372c5219020
     FS:  0000000000000000(0000) GS:ffff9372fbc00000(0000) knlGS:0000000000000000
     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
     CR2: 00007f35bb7d5de0 CR3: 0000000020c2a006 CR4: 00000000001706f0
     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
     Call Trace:
      <TASK>
      ? mark_held_locks+0x49/0x80
      ? lock_is_held_type+0xd7/0x130
      ? cma_cm_event_handler+0x49/0x200 [rdma_cm]
      cma_cm_event_handler+0x49/0x200 [rdma_cm]
      addr_handler+0xf1/0x1e0 [rdma_cm]
      ? lock_acquire+0xca/0x2f0
      ? lock_acquire+0xda/0x2f0
      process_one_req+0x43/0x170 [ib_core]
      process_one_work+0x274/0x590
      worker_thread+0x4f/0x3d0
      ? __pfx_worker_thread+0x10/0x10
      kthread+0xe7/0x110
      ? __pfx_kthread+0x10/0x10
      ret_from_fork+0x2c/0x50
      </TASK>
     irq event stamp: 1432669
     hardirqs last  enabled at (1432683): [<ffffffffac508eb2>] __up_console_sem+0x52/0x60
     hardirqs last disabled at (1432698): [<ffffffffac508e97>] __up_console_sem+0x37/0x60
     softirqs last  enabled at (1432518): [<ffffffffac48c985>] __irq_exit_rcu+0xc5/0x120
     softirqs last disabled at (1432509): [<ffffffffac48c985>] __irq_exit_rcu+0xc5/0x120
     ---[ end trace 0000000000000000 ]---

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 4c8f42e46e2f..760a7eb51297 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2074,6 +2074,7 @@ static int create_cm(struct rtrs_clt_con *con)
 		rtrs_err(s, "Failed to resolve address, err: %d\n", err);
 		goto destroy_cm;
 	}
+again:
 	/*
 	 * Combine connection status and session events. This is needed
 	 * for waiting two possible cases: cm_err has something meaningful
@@ -2083,10 +2084,15 @@ static int create_cm(struct rtrs_clt_con *con)
 			clt_path->state_wq,
 			con->cm_err || clt_path->state != RTRS_CLT_CONNECTING,
 			msecs_to_jiffies(RTRS_CONNECT_TIMEOUT_MS));
-	if (err == 0 || err == -ERESTARTSYS) {
-		if (err == 0)
-			err = -ETIMEDOUT;
-		/* Timedout or interrupted */
+	if (err == -ERESTARTSYS) {
+		/* interrupted,
+		 * try again to avoid the in-flight rtrs_clt_rdma_cm_handler()
+		 * getting a use-after-free
+		 */
+		goto again;
+	} else if (err == 0) {
+		err = -ETIMEDOUT;
+		/* Timedout */
 		goto errr;
 	}
 	if (con->cm_err < 0) {
-- 
2.29.2

