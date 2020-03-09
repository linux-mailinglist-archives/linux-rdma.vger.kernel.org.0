Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C78317E821
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 20:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgCITQ5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 15:16:57 -0400
Received: from mail-db8eur05on2041.outbound.protection.outlook.com ([40.107.20.41]:6165
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727455AbgCITQ5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Mar 2020 15:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=En7hzW1sTFF//1jJE5EUdhj0zCo37DCjF5GdvtX8sMm+5cXIlZBJ0+00KRZu60XroRXlWcKXrmHydUqZxJu9XZ6qyf9uRvrTDcGLTJkNHUZnH6cNWNoLxmeTIOFJJPUDncWeLW98KKls5Mh+iz540W6+48wDxSOusWzBiz6qylMHjgCaunFZ9PFdV9RLdONKYCGInCRH+aTIHFGBduYmNCwbPcflFZwtqkRroOco9/mZ+CyhP/VBVFRC7nooiSfgWpRXDKNUfamlGQDBXBEGSHpphPalWjNpmK6xTeufEetbPLONDGn/rX0nNvlaDVwRw8suWG4JlFxMAup6YdaKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwWFfx0I1w45oT5MlQf4pzKc3xx2H88EUeMnrVsnwew=;
 b=TWsCp1j35uBpvYX8kQ1UJF4PoUqPtcLsForYlWMgzglN+07NjhZVdPhqx5dEewxL3gsCHjfmS4+XKeN2orpHtRjFmYoADiQDk3z+4LTyN3IMv2kHpzTZ4X8tEip6/jRBzXWoZgdI8SDI7SnJUy3nktzermgfWEYD/5cbpy1AmNk1jEvrM5hBbw1vMh8a0GJfzda0gAml53RLX18hp+E58o/yjvndETn1baRvzYui47QFXLq7fv8YjZG5nTdm4UhnmKA2S81YnQNO0wuZi2s4U6VqvEETo61vOmExavV1SavOIr+u/uV6gYIerPOh3hG51g7RnoN0dmXjDZ5GgkC96g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwWFfx0I1w45oT5MlQf4pzKc3xx2H88EUeMnrVsnwew=;
 b=uCY23kCBjrsN61q1t/szT9x3rpyk+f/p+OzpVXphlLP/uhPmx5ZJLIjlpsqlz4ri4EHSvYWs3KyKIEq+GaQ2qSV5aWeJK7b6SHHSiZU/B7hbrldEKkFWvTStI9IQUeqogA5a0vpAApfd7XiLvZRQpwtHZyTJhVL5Rn6i89RTmPk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (52.133.14.15) by
 VI1PR05MB6223.eurprd05.prod.outlook.com (20.178.122.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.15; Mon, 9 Mar 2020 19:16:53 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::ed46:4337:c1cd:1887%7]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 19:16:52 +0000
Date:   Mon, 9 Mar 2020 16:16:48 -0300
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com
Subject: [PATCH rc] RDMA/nl: Do not permit empty devices names during
 RDMA_NLDEV_CMD_NEWLINK/SET
Message-ID: <20200309191648.GA30852@ziepe.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BL0PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:207:3c::32) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:44::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.68.57.212) by BL0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:207:3c::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Mon, 9 Mar 2020 19:16:52 +0000
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)     (envelope-from <jgg@mellanox.com>)      id 1jBNtQ-00082M-U1; Mon, 09 Mar 2020 16:16:48 -0300
X-Originating-IP: [142.68.57.212]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d4c9eb1-b3e1-48c3-0923-08d7c45e6cb8
X-MS-TrafficTypeDiagnostic: VI1PR05MB6223:
X-Microsoft-Antispam-PRVS: <VI1PR05MB62237B93149377ACFB3D9440CFFE0@VI1PR05MB6223.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(66556008)(66946007)(36756003)(66476007)(26005)(33656002)(86362001)(186003)(2906002)(81166006)(316002)(8936002)(1076003)(8676002)(81156014)(6916009)(52116002)(5660300002)(478600001)(4326008)(9686003)(9786002)(9746002)(24400500001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6223;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sgAH5ozuFesCX9v5qs6SQsSg3Ox4rtQphl2QuvMuxfxq/Ld0kCIzha0gPHxGrDkZxg5wkWdXRUcg9SdHWb9ZhCgRx6koya/5haz4WpDulQl8oENQG7H5SzRumiQ8ngTJFVdRcwRX/34+cN6cK+7b/G+9QjJO6/5dIGPjA8K+T7rNa6+kcCxKQ3WtKUePjt3SGiwIfm4F5YvyUovuAvmAzfx5qmr8wM6siLzC0Rsvib6lRq2l9PeNalkZS3NjX9vU3TdzrhsTQY8sHt/PogQx8VM/GkIIXkpToSQzehQd877Y577KyArgjQSYuYsFnDUC5D/5IJB20vgc5v4nMY1gK7LbKofX8xxrhZdpZLfRUysPqkpHOv04ZchTa79orp3rAgp61JboYcX5mNKehp6M/qpejs9mn1kpgik7hae8IMXs3roBzbRx4XOYuVuim9uWFR3TkzmnaU+X2e9Whh5d0rAzEamHjPPHshap4yLySfWPc9qdXf/PAzgXZWQA19T
X-MS-Exchange-AntiSpam-MessageData: 7Vt6CxBe17dUW8jVascApcKEdqnyYqgrVay4gpNF9fYd+CWRw0cQgCprTt+AAC/AXsEc/gc2NS66juAonIdH4WxwcNUsUBGrTv8lt+1OlqEQhEkLKsTUYgFDUuLbKU0VT7dlJTPdfMiZy4Cf12zT6g==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4c9eb1-b3e1-48c3-0923-08d7c45e6cb8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 19:16:52.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wmq9Du3EmMBt+BCUU3iBAQ8fMorn/vXKekxhkkoMPnLXcBY6wfCQrsGQrW+BjN7fBIbRrzJn1XOxOYAQ1+cSEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6223
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Empty device names cannot be added to sysfs and crash with:

  kobject: (00000000f9de3792): attempted to be registered with empty name!
  WARNING: CPU: 1 PID: 10856 at lib/kobject.c:234 kobject_add_internal+0x7ac/0x9a0 lib/kobject.c:234
  Kernel panic - not syncing: panic_on_warn set ...
  CPU: 1 PID: 10856 Comm: syz-executor459 Not tainted 5.6.0-rc3-syzkaller #0
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
  Code: 7a ca ca f9 e9 f0 f8 ff ff 4c 89 f7 e8 cd ca ca f9 e9 95 f9 ff ff e8 13 25 8c f9 4c 89 e6 48 c7 c7 a0 08 1a 89 e8 a3 76 5c f9 <0f> 0b 41 bd ea ff ff ff e9 52 ff ff ff e8 f2 24 8c f9 0f 0b e8 eb
  RSP: 0018:ffffc90002006eb0 EFLAGS: 00010286
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffffffff815eae46 RDI: fffff52000400dc8
  RBP: ffffc90002006f08 R08: ffff8880972ac500 R09: ffffed1015d26659
  R10: ffffed1015d26658 R11: ffff8880ae9332c7 R12: ffff888093034668
  R13: 0000000000000000 R14: ffff8880a69d7600 R15: 0000000000000001
   kobject_add_varg lib/kobject.c:390 [inline]
   kobject_add+0x150/0x1c0 lib/kobject.c:442
   device_add+0x3be/0x1d00 drivers/base/core.c:2412
   ib_register_device drivers/infiniband/core/device.c:1371 [inline]
   ib_register_device+0x93e/0xe40 drivers/infiniband/core/device.c:1343
   rxe_register_device+0x52e/0x655 drivers/infiniband/sw/rxe/rxe_verbs.c:1231
   rxe_add+0x122b/0x1661 drivers/infiniband/sw/rxe/rxe.c:302
   rxe_net_add+0x91/0xf0 drivers/infiniband/sw/rxe/rxe_net.c:539
   rxe_newlink+0x39/0x90 drivers/infiniband/sw/rxe/rxe.c:318
   nldev_newlink+0x28a/0x430 drivers/infiniband/core/nldev.c:1538
   rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:195 [inline]
   rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
   rdma_nl_rcv+0x5d9/0x980 drivers/infiniband/core/netlink.c:259
   netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
   netlink_unicast+0x59e/0x7e0 net/netlink/af_netlink.c:1329
   netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1918
   sock_sendmsg_nosec net/socket.c:652 [inline]
   sock_sendmsg+0xd7/0x130 net/socket.c:672
   ____sys_sendmsg+0x753/0x880 net/socket.c:2343
   ___sys_sendmsg+0x100/0x170 net/socket.c:2397
   __sys_sendmsg+0x105/0x1d0 net/socket.c:2430
   __do_sys_sendmsg net/socket.c:2439 [inline]
   __se_sys_sendmsg net/socket.c:2437 [inline]
   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2437
   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Prevent empty names when checking the name provided from userspace during
newlink and rename.

Cc: stable@kernel.org
Fixes: 3856ec4b93c9 ("RDMA/core: Add RDMA_NLDEV_CMD_NEWLINK/DELLINK support")
Fixes: 05d940d3a3ec ("RDMA/nldev: Allow IB device rename through RDMA netlink")
Reported-by: syzbot+da615ac67d4dbea32cbc@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/nldev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 37b433aa730610..7147a4e49167db 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1514,7 +1514,7 @@ static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	nla_strlcpy(ibdev_name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
 		    sizeof(ibdev_name));
-	if (strchr(ibdev_name, '%'))
+	if (strchr(ibdev_name, '%') || strlen(ibdev_name) == 0)
 		return -EINVAL;
 
 	nla_strlcpy(type, tb[RDMA_NLDEV_ATTR_LINK_TYPE], sizeof(type));
-- 
2.25.1

