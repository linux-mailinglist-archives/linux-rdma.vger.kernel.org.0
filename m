Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66C22C633
	for <lists+linux-rdma@lfdr.de>; Fri, 24 Jul 2020 15:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGXNTv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 24 Jul 2020 09:19:51 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:55970 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgGXNTu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 24 Jul 2020 09:19:50 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1adfef0000>; Fri, 24 Jul 2020 21:19:47 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 24 Jul 2020 06:19:47 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 24 Jul 2020 06:19:47 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 24 Jul
 2020 13:19:35 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 24 Jul 2020 13:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCQWlDHtGsU7UpRsY1eQbdL/l2Az8Eg42dzUEp3vfezfL1AstAto3GDuW9NDS3g1K3LevRPnPdeT9K8eLMpF2knc4IQVW2iLAowE2YbwolH6nUrAf8eiuZr60KZG2AIE9HqaAn3vVOUYPvLu2ffNdPCTizhDzBEdMevKqFF0CYaSRGUjKD5kr+DRKVMreLFV0OWOvWvCD8smdrjIyTWGkFfdxpszogFLd4sJfg+CDC8HgwxieEg7zmzdyJSiSFbsc/ZlYoLghbnjXR1KApJpiVyRKDuYXxKH5yt0bNtJJR+AmNFqSLW6xZjxhW/xn6gMHce9A7etexMgQbvhwj9sYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klmFCg1UEeHBjwtNoFws9AeA7FAxpkNp+WhxACwRgXU=;
 b=fDKgJk4derQkSDhMsrur3mOs2CWasXwryFBSB6idUTBZKyH+yZytacfOmupeUO/6G7hwEe8ctPU2cEdYSv+oBt7HOvCILBgQ7LLfsRGlLSgeM8yZV0MHaVz3mgkRZpwDpnCnzZHpcP1EONvDzUM2O5y1x2rGFajQynzS1Es9aW7kLrUvqLWuUSkK0MnfJ27cim0p5Skt5kjyHpqcDLilqppp9SsvWZvfcPo5r9tMxYCf5fhqXy6lti0J5tdebCq1SlgHD6GmIjBplovq3lqugYQTcJLK4bV2kkcd3RH5BxWuXgXwV1URPiKw8a9ty8B00/+y76mDDO0W+OMeRJbeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Fri, 24 Jul
 2020 13:19:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 13:19:31 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leonro@mellanox.com>, <linux-rdma@vger.kernel.org>
CC:     <syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com>,
        <syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com>
Subject: [PATCH] RDMA/cm: Add min length checks to user structure copies
Date:   Fri, 24 Jul 2020 10:19:29 -0300
Message-ID: <0-v1-d5b86dab17dc+28c25-ucma_syz_min_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 13:19:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1jyxbl-00F263-IW; Fri, 24 Jul 2020 10:19:29 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7491f29f-2ba1-4921-d738-08d82fd43336
X-MS-TrafficTypeDiagnostic: DM6PR12MB3930:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3930F2F25157FE3AE84BB8A5C2770@DM6PR12MB3930.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJm33N90RsOP4NiNPgkuc5bXFdKuVtibtLADXRuZdjSJl1520P3NEfRe5S1jWvg8dw/NvU1OwVpZ1/oqdJU8kU6PI1sj8+Unpz3z3kf2356zFRhBo244iBcNUbQLQkEMldbthIwiZ0MOcGSGlEkxfGMgFQNsLz+qWyiIAUJD52tE/we4XIAdOmGQqbvG1t/zgqvfcQp2jp9SrDVkJtM6/FaawUIcRZrwS2Ck+uSubLiAEN454Fsr7xz4noz/yeKnjMBM1EXhbSjEgERkTWJsta2++FbMl6CkksUEK4xvp/A01WYrid5qyDsizB1PNKPRgd0SKe0KtMzcQiqFLC1iXWaNNv9P76MgPIqEs7q8rBREYcnMKKHRPXoPZ0R96Bd9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(186003)(83380400001)(5660300002)(66946007)(2616005)(66556008)(66476007)(8936002)(26005)(36756003)(316002)(478600001)(426003)(9786002)(2906002)(86362001)(8676002)(4326008)(9746002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oajP3aIDtY1esaYaMoNy9M9UHpoQOJUkeC+GFgFphcnUeDo1oHgVjyB+MSGO56l1DonNh1PohiZKi7xYt+C84kYG/wTqvRKBCNJG5gpATUEA/b/8CzHa5KRhJpjcWsoQ41dPopbPhogn4MQ1lmhjruMnxZrrVFbfoGHmeQDvL39+ox3OmHjXi1qCSC1LrRgsb0424Yh0X1liJb1nJOaj9tHpuUyLx+if60x1ZRcjSbgmTf9oEpJA7ftUeRcE1zRQKjHgSb20sftJV++JMBEhuuOigm3Krj3VwaEIjccmPyBTUZ0vXLAoAArn5rhKX1W3XAV/qCSCzx95r0ZZsItqqRPzuMU2nSdWzMrJo774ut6Z/xVsPzvHHqr+yYDGWl3CkcDZqAMYRf3SL5gPXa2ilSSuaEvlxON5EUMVlAYa6ajdn2ANpmobF3fGF22SnzzgBHKvZp6t7TxpCxmRo1NGO0kr70nSbBoA0S6FZJ1qCK4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7491f29f-2ba1-4921-d738-08d82fd43336
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 13:19:31.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWl2c5uBm0xlbWB7MH8OvOuTYS6+w+1UpOdMqO7i9cG6LsW5SJy9LMgRCLGrfOb8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3930
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595596787; bh=E08luXr5+YEw6LaMTfMR6Ve3xPZzxx0gUoMroG8H2lM=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:CC:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=GycYHmyhIYqd/48V38k3Q0yrinYHABCNLGH5MRKx42wPSKohG93gttAEI5rCqKEtu
         EY+6wi4XuXE8TxTtVVgDZgVGgbmo2Cx5Jxwa9UBcG3yB7IxBbKpK99hhobWa2p5r63
         5/l7X2h4YJn8GZszZIi2wwaBAjpW05cropp+u2PT9DHbyqO12Je6CRbOmf/5VhQ41S
         flyNJ+pm0yR8JKCq3g5EhU7V7aaLE1vHti7qPZ4jWqsykurRjb/9BIEmpFgxwRQpCz
         AHtP1YKleH+gjTbsbSVmsNc6XVcazpQLJNigQECx+Izx/xLITZSxHn6lhwSL+RpQxc
         7YrTNypmUHWEw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

These are missing throughout ucma, it harmlessly copies garbage from
userspace, but in this new code which uses min to compute the copy length
it can result in uninitialized stack memory. Check for minimum length at
the very start.

  BUG: KMSAN: uninit-value in ucma_connect+0x2aa/0xab0 drivers/infiniband/c=
ore/ucma.c:1091
  CPU: 0 PID: 8457 Comm: syz-executor069 Not tainted 5.8.0-rc5-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/01/2011
  Call Trace:
   __dump_stack lib/dump_stack.c:77 [inline]
   dump_stack+0x1df/0x240 lib/dump_stack.c:118
   kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
   __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
   ucma_connect+0x2aa/0xab0 drivers/infiniband/core/ucma.c:1091
   ucma_write+0x5c5/0x630 drivers/infiniband/core/ucma.c:1764
   do_loop_readv_writev fs/read_write.c:737 [inline]
   do_iter_write+0x710/0xdc0 fs/read_write.c:1020
   vfs_writev fs/read_write.c:1091 [inline]
   do_writev+0x42d/0x8f0 fs/read_write.c:1134
   __do_sys_writev fs/read_write.c:1207 [inline]
   __se_sys_writev+0x9b/0xb0 fs/read_write.c:1204
   __x64_sys_writev+0x4a/0x70 fs/read_write.c:1204
   do_syscall_64+0xb0/0x150 arch/x86/entry/common.c:386
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fixes: 34e2ab57a911 ("RDMA/ucma: Extend ucma_connect to receive ECE paramet=
ers")
Fixes: 0cb15372a615 ("RDMA/cma: Connect ECE to rdma_accept")
Reported-by: syzbot+086ab5ca9eafd2379aa6@syzkaller.appspotmail.com
Reported-by: syzbot+7446526858b83c8828b2@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/ucma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.=
c
index 5b87eee8ccc8b6..d03dacaef78805 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1084,6 +1084,8 @@ static ssize_t ucma_connect(struct ucma_file *file, c=
onst char __user *inbuf,
 	size_t in_size;
 	int ret;
=20
+	if (in_len < offsetofend(typeof(cmd), reserved))
+		return -EINVAL;
 	in_size =3D min_t(size_t, in_len, sizeof(cmd));
 	if (copy_from_user(&cmd, inbuf, in_size))
 		return -EFAULT;
@@ -1141,6 +1143,8 @@ static ssize_t ucma_accept(struct ucma_file *file, co=
nst char __user *inbuf,
 	size_t in_size;
 	int ret;
=20
+	if (in_len < offsetofend(typeof(cmd), reserved))
+		return -EINVAL;
 	in_size =3D min_t(size_t, in_len, sizeof(cmd));
 	if (copy_from_user(&cmd, inbuf, in_size))
 		return -EFAULT;
--=20
2.27.0

