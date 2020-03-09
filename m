Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC717E87F
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCITcH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 15:32:07 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:41381
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbgCITcH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Mar 2020 15:32:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+wgGjY9kFZ8e4OvunNdKdgRvoG+OfLiBCIxNw8CimPoVWRKZNfQie/gd3b0ZYZuwtrvxNP0brxNN3LV7ZWvqGKHvuw6/92a1lsj7ocM7+01TMCdvrYOa329Ulopv/iuNHfd7mBFnxQEyP+WEHg8Xdos2lHB30IKw9AjJfAXX2fht6qljH0wGhSAMeQWGBS7k5u2Wg0lI8iI/ONi+tJTWyIpgKV0sdvs3He04H2mWw3568QCSO6pq31VTJN5+jpRlgppLykV732ksz1Gsq1PPAa4W2dYpQDAmXLcdjarHYnoEafUQM6eF0pTP2ERU/LFCv8eLcmkqVzL3jPPdl4L2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy3CBpJF9NzfElNsQhnEnxozM58XzgSKERLiW84wYhg=;
 b=oaP8otAwRsPawA4Vdm20ZdbAv7YOLXqjDo1MDGLKUY/ll16vq4M5QaaMiw07AukQjaNgETFE49iYCyjqTSs40JeTUCmR8Hb/V++jj2agUrCg2giyTum9MfVlaxw2162FRK45G4cxDPv8uRSWTXVkh8w3oE2BOZQaEEL+Xw6+x/XIDM1tarSKOSnRkHXj6KCjEI9zvSOJyXOPe2J4SP1CDAuUSxxelpdV3z/ASzLN6gfe4/yADwSzT3djbt5z9kiPYMsLc7z+W6hpvP2HFwG8S+4xUwD4p66/+C2XKq1bmWtAakpKwYvw8X8dNRb5EASIhN1Dnrw1kFlDLXQyKyAhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy3CBpJF9NzfElNsQhnEnxozM58XzgSKERLiW84wYhg=;
 b=Neh8PMwqOIvXkU94LvKk6oKYArJvUMpgGTvzuJovMOOP9nnFFLcjn+uympbORXWSK5t8le6yAgl+oQ9IS721NGvNTHsUXFf/abHKCz9S8VjZ94wo/lBxB0pGyUr0ZTKbR55qsTXCUM9H0+QVL6lJ6WCq+a3CuHwLHV0UPOvbh8k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB5118.eurprd05.prod.outlook.com (20.178.11.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Mon, 9 Mar 2020 19:32:04 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 19:32:04 +0000
Date:   Mon, 9 Mar 2020 16:32:00 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-rdma@vger.kernel.org, Parav Pandit <parav@mellanox.com>
Cc:     syzbot+ab4dae63f7d310641ded@syzkaller.appspotmail.com
Subject: [PATCH rc] RDMA/core: Fix missing error check on dev_set_name()
Message-ID: <20200309193200.GA10633@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MN2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::42) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by MN2PR15CA0029.namprd15.prod.outlook.com (2603:10b6:208:1b4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Mon, 9 Mar 2020 19:32:03 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jBO88-0002nC-HD; Mon, 09 Mar 2020 16:32:00 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0d3e921-2cbb-4bed-87fb-08d7c4608bdb
X-MS-TrafficTypeDiagnostic: VI1PR05MB5118:|VI1PR05MB5118:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR05MB51180C3165F403042D4F60B4CFFE0@VI1PR05MB5118.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(66946007)(26005)(33656002)(36756003)(1076003)(4326008)(81166006)(81156014)(66476007)(6636002)(9686003)(8676002)(66556008)(9746002)(316002)(2906002)(9786002)(6862004)(8936002)(5660300002)(186003)(52116002)(478600001)(86362001)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5118;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sn6aqel9QstA9jWy8k2hf3uMjFbZg2hKzmvyyN3oEMIJra+B02NirMxtJYWVJ3u3V0SQRW42Ifz7+B6iTtENl/bD6lcv3V4V9SjY8jL58r4mNueSEoD/wZraX0si2uDRP2V1KpeQK7KwRTxd/xSctHFzHNV43PCH21I/ypRL8Mo9XECiF02nnqFUr71pRYHqjpy7Vx9EAKVO32+NR4vBs3SXI3aaXag4sMknan1l9p1JKpgMdr88CPX7rp44T9fb2ZSysElIypmOch5r30EBMwzMzEoKNm9gOIChlEhmcmK1XATsKTqqxxUdg7IPl79Po5XIoKvxSG3WSVyqaBeMA/rwvsf9RbRbbL05d0OjT9RE6ccnfT70/EfNWpNlZzKNLj29ALavyCxkej/DhLGE2FwWQZUQYuGZ8fmdajVvyg5akc/dGpnU3iOPbEDHmqXoDJ/DMJ8k86pkfNhoxUgPv0kvjN8NfWtkqkbdzLE2c4Jy9MzIJUNfZKorIeu1ZsU3
X-MS-Exchange-AntiSpam-MessageData: GJZTEQuWI6uFhw0K6qVaIZWxUpOZCKe8dK2kgJiSkisBtFig2TIqaBVLkI+ByIdxlwZ3xJmZgns3wcS+91xeR2NCwQ4dOp+JewZnLHneCL5ARPW9UD6tzjRZ6o+mu5B5xRmghbxQEBbM1vKNgHFOrQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d3e921-2cbb-4bed-87fb-08d7c4608bdb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 19:32:04.1747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t2XP+NW5pFOMeUSoIyQIt1hLxBENbnC59VN4N6xId09P6oOY4DR2eehh1UKiecL6h9Lt9cyigNiWLzRv7R7kaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5118
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If name memory allocation fails the name will be left empty and
device_add_one() will crash:

  kobject: (0000000004952746): attempted to be registered with empty name!
  WARNING: CPU: 0 PID: 329 at lib/kobject.c:234 kobject_add_internal+0x7ac/0x9a0 lib/kobject.c:234
  Kernel panic - not syncing: panic_on_warn set ...
  CPU: 0 PID: 329 Comm: syz-executor.5 Not tainted 5.6.0-rc2-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0x197/0x210 lib/dump_stack.c:118
   panic+0x2e3/0x75c kernel/panic.c:221
   __warn.cold+0x2f/0x3e kernel/panic.c:582
   report_bug+0x289/0x300 lib/bug.c:195
   fixup_bug arch/x86/kernel/traps.c:174 [inline]
   fixup_bug arch/x86/kernel/traps.c:169 [inline]
   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
  RIP: 0010:kobject_add_internal+0x7ac/0x9a0 lib/kobject.c:234
  Code: 1a 98 ca f9 e9 f0 f8 ff ff 4c 89 f7 e8 6d 98 ca f9 e9 95 f9 ff ff e8 c3 f0 8b f9 4c 89 e6 48 c7 c7 a0 0e 1a 89 e8 e3 41 5c f9 <0f> 0b 41 bd ea ff ff ff e9 52 ff ff ff e8 a2 f0 8b f9 0f 0b e8 9b
  RSP: 0018:ffffc90005b27908 EFLAGS: 00010286
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  RDX: 0000000000040000 RSI: ffffffff815eae46 RDI: fffff52000b64f13
  RBP: ffffc90005b27960 R08: ffff88805aeba480 R09: ffffed1015d06659
  R10: ffffed1015d06658 R11: ffff8880ae8332c7 R12: ffff8880a37fd000
  R13: 0000000000000000 R14: ffff888096691780 R15: 0000000000000001
   kobject_add_varg lib/kobject.c:390 [inline]
   kobject_add+0x150/0x1c0 lib/kobject.c:442
   device_add+0x3be/0x1d00 drivers/base/core.c:2412
   add_one_compat_dev drivers/infiniband/core/device.c:901 [inline]
   add_one_compat_dev+0x46a/0x7e0 drivers/infiniband/core/device.c:857
   rdma_dev_init_net+0x2eb/0x490 drivers/infiniband/core/device.c:1120
   ops_init+0xb3/0x420 net/core/net_namespace.c:137
   setup_net+0x2d5/0x8b0 net/core/net_namespace.c:327
   copy_net_ns+0x29e/0x5a0 net/core/net_namespace.c:468
   create_new_namespaces+0x403/0xb50 kernel/nsproxy.c:108
   unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:229
   ksys_unshare+0x444/0x980 kernel/fork.c:2955
   __do_sys_unshare kernel/fork.c:3023 [inline]
   __se_sys_unshare kernel/fork.c:3021 [inline]
   __x64_sys_unshare+0x31/0x40 kernel/fork.c:3021
   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Cc: stable@kernel.org
Fixes: 4e0f7b907072 ("RDMA/core: Implement compat device/sysfs tree in net namespace")
Reported-by: syzbot+ab4dae63f7d310641ded@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index f6c255202d7fd4..d0b3d35ad3e435 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -896,7 +896,9 @@ static int add_one_compat_dev(struct ib_device *device,
 	cdev->dev.parent = device->dev.parent;
 	rdma_init_coredev(cdev, device, read_pnet(&rnet->net));
 	cdev->dev.release = compatdev_release;
-	dev_set_name(&cdev->dev, "%s", dev_name(&device->dev));
+	ret = dev_set_name(&cdev->dev, "%s", dev_name(&device->dev));
+	if (ret)
+		goto add_err;
 
 	ret = device_add(&cdev->dev);
 	if (ret)
-- 
2.25.1

