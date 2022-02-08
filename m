Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D5D4AE3F8
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Feb 2022 23:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386917AbiBHWY6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Feb 2022 17:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386309AbiBHUFf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Feb 2022 15:05:35 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3C3C0613CB
        for <linux-rdma@vger.kernel.org>; Tue,  8 Feb 2022 12:05:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNWORQ8yCT/fJzPf4gQdphuEDS5G+MXEChiDB0yo3MDwvpyS8xqNZO66KWAYEfeBOx4GB54RNsnwiQKmDhEjerQ95GzSUpb7Nj7hn0JNZlKTARlBqnWuZ28RoDqDrRwOIm4/awP96Jpb8L8JDcMDRGeNAOWSRqey8w/P/MUo8erJftZ8hSGhN7bQejNGZF9J+eqYwKGcR1H1NS/V/M5O3iisHu3v6frlrVm0i069u1qw+imcyiY770Ptj+fIuj1QsA0MrvxyzcAiZfMiL12lygU4jkShoH0Rqg/zgEFzvm9yHA90WgWxXjYZNEea4XTcUQmElhtCwZgISd4ZUvEhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZF367QhwqhHTtShSVoEKxZkJj6JrB3hUqpTZe69v+c=;
 b=QgCaFfUDoHV++V5uHxkFqbcUQ5GO55ZJ4AfHJJ/zwt1KtV8tH9r+/pol4S9FFZdA5IEtY6BMfKpD1sZfskzyORuknzmfzk8KEEyB9AAsuZ1znXE22VZdBwOcQjwDeS5gdsSTZDzsl0g05tH1bAry4Tv+WbVgwuuviMexbHD36cnj+CKFpoQGmZZiiX6eRG+xZ6FpzPNRN8gpOW6SrinxfcVr+zihJe28KLkW6GbJCTlVfD9VlAafJtZdAU+4xKUWQ5M458J51kZEXOTyO1dBjZF7itc9CY+/FfZD2DW9mqu817Gg74vI/zoeBsPqK5LM2j/J+/+BQN8XhxLGCEzOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZF367QhwqhHTtShSVoEKxZkJj6JrB3hUqpTZe69v+c=;
 b=kBbDhToOHWmHPTSqWohv2WDJDzuvogs5O+ccQzcso9B5vNGKicVTrOG9+Ww1Ba35PWm7RTfJhZU5fJ+2cnj/HqD+hnQvi2JobqGqCYkqBQ7F730jwraezNcvPq8+mjxGmLzdoKbn1Xu3ycSnyW80zw58C2yFVwDXc8B9VVy0ln2i6EOLy8y1oj/mKHvu6Tb+tkmPLYcKcoMQDCvaVU0ToDxvazbVQBx54lgomBpbsVU0WCdm3bCpuhKZFcqQ/1zK9Sxl/cc0dTc7Hh0M609HW8fYhAIOAXxD4LX4KOlUicrlNW2gI0IYc3Bzyru2u7tpPRB7FOuTpil2AO3ssAb32A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SN6PR12MB2656.namprd12.prod.outlook.com (2603:10b6:805:67::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 20:05:32 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Tue, 8 Feb 2022
 20:05:32 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: [PATCH rc] RDMA/cma: Do not change route.addr.src_addr outside state checks
Date:   Tue,  8 Feb 2022 16:05:31 -0400
Message-Id: <0-v1-83dba2d1b721+1c3-syz_cma_srcaddr_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0022.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::27) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a946e2cb-6be7-43c9-6fcf-08d9eb3e5c87
X-MS-TrafficTypeDiagnostic: SN6PR12MB2656:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB26568C532A97B1077EA43B07C22D9@SN6PR12MB2656.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbM/qPqtKttnI3qYiEaxBYXxNaQt1Wda0kMU9Ek9vLJW42RmmsVRrROpN43slnnO8ANy4cLrJtxOlxiIJXkCmo52fMr/I+NBfx3GapV1hFTaJ8DFStbtsAxSNLvcCdF68xZxCSwI58CEZnbfJZdnQGd5NH0y31XS9+rP402XuLg+IfCTGdAeZlg943zKMVhnUPgqZfud7Y14Zjrb4LytxvzRMqEXw7r/Pbj8waVBLbqMJftkQ6rI8YBfJr7WFAdy+bBN0E/ubpykPWWoS2MLxabtdnA2RV9bXa4voyR+8epaCnLWvIb3dSb4BjnRz9JJcYrlFicME6cmci7iE4nyB0z6LtpVJZDMvAcWctDf69qKrG6jnQKPKlZak5W9IlOby3yNj0wbv7DUXxqQjO5CNQme9Wtiq1vJbpSE68yQcIVy4oIjWb85CzBzo1LXW0wjpDu/u+U0vv/GeodSEYnQc92hrcH3JaBL+LWjdNj2yqnJ8ZiKtBnAjSzqBTSCaaVgQkmr5woACGj/i9Vg/7TO/JVHhm+2IGXWklR/xkLaIv9pRVqoLs/8wirq/d2UHxnH8Ti9b5tNS11hR5kcTS5HLC+N6nTHuib8AZYdVFJMvBi45A6SXfSeoObpZPUwhPKuyEGL7wBC8N9GMkv6EkzfQGHhwjZ2o77yrw7iars6pxMAsVcT2+GUJkZh4zgQDVT5NhrPSN9SGXpBoewz0fEkAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(83380400001)(26005)(2906002)(186003)(5660300002)(86362001)(2616005)(316002)(8936002)(8676002)(4326008)(6512007)(66946007)(6486002)(66556008)(66476007)(508600001)(6916009)(38100700002)(6506007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?guYWklouqnudVmGii4B4NPPovQ5W7CfDNeDKPhaMAnBpfZNePwep4I5e5XLW?=
 =?us-ascii?Q?XEnd+Q4B3VC4mm8680eCumu+V1+PJGxhEzUP6N4SKH81UEhWhFvJPHhFr9W9?=
 =?us-ascii?Q?NUH+LnJZi6+Mv8o+3dZNTZMQ7y59hWYsBybyvXu5mPW+gS9EiDKHY5q9ARTI?=
 =?us-ascii?Q?dzLSs7x9oj/cu66JKprLp6xOKcl9Vy4OQ3MHuufCiEG+sse+Xzv09Aa/BOMC?=
 =?us-ascii?Q?aSlnDwozEepT5nT9NqDnTHJocpU2Bo16Ixr5S6f6nZ8HZFTyGD3Cdg0XQV4x?=
 =?us-ascii?Q?/Cc4HgrqRQmqODm9g7+TM9EvZsORstmRbB4NQMD2v6wbZOf/i4VVpsfqT7HW?=
 =?us-ascii?Q?nSwDtYwVO4xpeI1kG9PBCm+XbWAnj9WFnwiahQMDJ+qDc8sWs/xz9Cw01IMB?=
 =?us-ascii?Q?xu/w9SzbNN+Iut/BVKRUIbD+GlhpaKeui5sCZANMO+z5cmdPFKHwe8ASTIPr?=
 =?us-ascii?Q?npusqZr+yERKnuVpSIuyXFyrnAIv0vSexSgRGZfwqo5TDNtSpmjFe4A/BS6w?=
 =?us-ascii?Q?0qQvvOjaXfgEVjmOC4uNvCakhRIENmzTWEsu/PmhkRP6aCuYqL4hddApHAUN?=
 =?us-ascii?Q?Kn8tfkCwRiUxsQpnYYFl5Fjmh26jvzIx9MYYx9ByBupZ6Idy5jnZFca4xm5K?=
 =?us-ascii?Q?WptnPzXADKlQbJum/dF81nUuASkZ0Ni2i3j3Wb9/qkyMvS42AtmEg1f7Wxtm?=
 =?us-ascii?Q?heBsWI6Kl1DzaVK5jjdmb01nilX++NWLFsN8cSvMlGANKV8PVpaQ+49WZgmx?=
 =?us-ascii?Q?Ykj9pPY+0ZMja+eQq0k2nFLYvd04cB/XymV3SdDIRiv8rsb5b9OzG36eXddz?=
 =?us-ascii?Q?FascdwhO4lIW+3yn1SEJmG71KQijVTY0Ely/Hn7iuhZkSYHkwepElqDqfht3?=
 =?us-ascii?Q?XsQEw5+Dw0OitDSfOhkxfds+pzCNOp56SMSbK26MfRareP/oY5xRHcDsv2NW?=
 =?us-ascii?Q?tvZ3yToDK1b7CtAvMmZoTEDO9l1pL9/aMTD26UhthOOcq2YlvFFczZEOBujF?=
 =?us-ascii?Q?4kIS/qtIkUNEYVQ8AiwUroIJuG1DUlhS1BfjYXFrz7zB2QjsN+RcIXEbhDx/?=
 =?us-ascii?Q?gJpBtXSgxKBIYJzJDLON3P2IN70UB9bfWpWvl9MPDwJPYjN7F3q6G9W4oKeQ?=
 =?us-ascii?Q?xIQpU1Yb37BtmEsYQKvD2aWnkYY1FwvPpoC+mLbsqSApk/75R5/GpdakMsh0?=
 =?us-ascii?Q?MS4D8gagE4kD4ajUv4Z0alLx4w0nHnX99ZMXmtyOFNk48UTGQERWqkhEMk+p?=
 =?us-ascii?Q?Wo4dn40nxUKlvekgr/9FUp37+pwZOcPXwCaB7Vz6q0c7FeqLVhemCeUR6LCG?=
 =?us-ascii?Q?VM8CjInCa5qHdohSygrqsZEjYOwA0HkulQuRjEIxyF9erW6QXXgVImk10Fnb?=
 =?us-ascii?Q?MhExnGPAmBSjB++zdBtKWB1ATdO6tJR4BWgoJtixKKqi0oygnQ1sNqugWDAy?=
 =?us-ascii?Q?NfOnzxD7G1f3nCHjtq+yLk6DatbUGVKTqHsi+tmI0yQxVLeXwZBknFL9uEZx?=
 =?us-ascii?Q?nXGIQS/rPEmMWnznpSwzSXwpE7vG9ZtDsr8rjWrxghj66n+uWyc7JKIJu0p+?=
 =?us-ascii?Q?z1gMQDfHRSLVq7vUwC4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a946e2cb-6be7-43c9-6fcf-08d9eb3e5c87
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 20:05:32.4390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZujiCBax+XsFNQxygfIaHVSAMJ1xxRPWAY1WFn0GQvHiWKpRSztGfSK/TcFsukoY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2656
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If the state is not idle then resolve_prepare_src() will immediately fail
and no change to global state should happen.

For instance if the state is already RDMA_CM_LISTEN then this will corrupt
the src_addr and would cause the test in cma_cancel_operation():

           if (cma_any_addr(cma_src_addr(id_priv)) && !id_priv->cma_dev)

This would manifest as this trace from syzkaller:

  BUG: KASAN: use-after-free in __list_add_valid+0x93/0xa0 lib/list_debug.c:26
  Read of size 8 at addr ffff8881546491e0 by task syz-executor.1/32204

  CPU: 1 PID: 32204 Comm: syz-executor.1 Not tainted 5.12.0-rc8-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  Call Trace:
   __dump_stack lib/dump_stack.c:79 [inline]
   dump_stack+0x141/0x1d7 lib/dump_stack.c:120
   print_address_description.constprop.0.cold+0x5b/0x2f8 mm/kasan/report.c:232
   __kasan_report mm/kasan/report.c:399 [inline]
   kasan_report.cold+0x7c/0xd8 mm/kasan/report.c:416
   __list_add_valid+0x93/0xa0 lib/list_debug.c:26
   __list_add include/linux/list.h:67 [inline]
   list_add_tail include/linux/list.h:100 [inline]
   cma_listen_on_all drivers/infiniband/core/cma.c:2557 [inline]
   rdma_listen+0x787/0xe00 drivers/infiniband/core/cma.c:3751
   ucma_listen+0x16a/0x210 drivers/infiniband/core/ucma.c:1102
   ucma_write+0x259/0x350 drivers/infiniband/core/ucma.c:1732
   vfs_write+0x28e/0xa30 fs/read_write.c:603
   ksys_write+0x1ee/0x250 fs/read_write.c:658
   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
   entry_SYSCALL_64_after_hwframe+0x44/0xae

Which is indicating that an rdma_id_private was destroyed without doing
cma_cancel_listens().

Instead of trying to re-use the src_addr memory to indirectly create an
any address derived from the dst build one explicitly on the stack and
bind to that as any other normal flow would do. rdma_bind_addr() will copy
it over the src_addr once it knows the state is valid.

Also, src_addr is never NULL in cma_bind_addr().

This is similar to commit bc0bdc5afaa7 ("RDMA/cma: Do not change
route.addr.src_addr.ss_family")

Cc: stable@vger.kernel.org
Fixes: 732d41c545bb ("RDMA/cma: Make the locking for automatic state transition more clear")
Reported-by: syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cma.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 27a00ce2e10120..f9b7b6f0703f58 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3368,20 +3368,24 @@ static int cma_resolve_ib_addr(struct rdma_id_private *id_priv)
 static int cma_bind_addr(struct rdma_cm_id *id, struct sockaddr *src_addr,
 			 const struct sockaddr *dst_addr)
 {
-	if (!src_addr || !src_addr->sa_family) {
-		src_addr = (struct sockaddr *) &id->route.addr.src_addr;
-		src_addr->sa_family = dst_addr->sa_family;
+	struct sockaddr_storage zero_sock = {};
+
+	if (!src_addr->sa_family) {
+		zero_sock.ss_family = dst_addr->sa_family;
 		if (IS_ENABLED(CONFIG_IPV6) &&
 		    dst_addr->sa_family == AF_INET6) {
-			struct sockaddr_in6 *src_addr6 = (struct sockaddr_in6 *) src_addr;
+			struct sockaddr_in6 *src_addr6 =
+				(struct sockaddr_in6 *)&zero_sock;
 			struct sockaddr_in6 *dst_addr6 = (struct sockaddr_in6 *) dst_addr;
+
 			src_addr6->sin6_scope_id = dst_addr6->sin6_scope_id;
 			if (ipv6_addr_type(&dst_addr6->sin6_addr) & IPV6_ADDR_LINKLOCAL)
 				id->route.addr.dev_addr.bound_dev_if = dst_addr6->sin6_scope_id;
 		} else if (dst_addr->sa_family == AF_IB) {
-			((struct sockaddr_ib *) src_addr)->sib_pkey =
-				((struct sockaddr_ib *) dst_addr)->sib_pkey;
+			((struct sockaddr_ib *)&zero_sock)->sib_pkey =
+				((struct sockaddr_ib *)dst_addr)->sib_pkey;
 		}
+		src_addr = (struct sockaddr *)&zero_sock;
 	}
 	return rdma_bind_addr(id, src_addr);
 }

base-commit: 2f1b2820b546c1eef07d15ed73db4177c0cf6d46
-- 
2.35.1

