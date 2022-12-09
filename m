Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3186483B0
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Dec 2022 15:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiLIOXH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Dec 2022 09:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLIOWr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Dec 2022 09:22:47 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C757A1B5
        for <linux-rdma@vger.kernel.org>; Fri,  9 Dec 2022 06:21:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzpgIIoLx9ppewD4KdaPNeE8/+fq23Tlc+WMUKfGMQcvQEyW4G2wuzBZZTy6MF3hWEV1LhbI1WaQtgQLJ+2Czj/5kvJUC4y3nn2lljc/5jGJo58C+UpJSMnv6c7sYymWEKV6LBAZe2ftknjlSIfaOq5Vd6NP94JNGB2VzR/i4Pw+1UHJPRE7N1Pj050gOqLuS+8YPaPPtWkRqzM7qTDyZQlD3uD1f3az4M6zzxfA5q1syCEcuaVu4c4Exb2mEuhMrA+W0/PsyAoGitzcUpHLk7jWw81H1pP9kmnDXHbAsyQivaAf9u3bmJOxHYxNcZjAadN5njqnOEfUIZAGReqfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2hy3+JLvC39N71sD49JsoMMLCXWwGvHYp8kbZYOBFk=;
 b=ZVqQM3uBkmAqHrMGEp9jIrFsiVHWAbHAKASSD7EMsGP7r71Q9pLyZG+MzsH7h+4WgoPYdKFRdudQWeCp+mqlB6j3h92XceVBECJfe5Q027RQk7bfNCbar9ZKZoQCEmYvKft6fIhpNyLxcNwvWUxDnRp0Z1YFHIJBJJ39D9/EMUmMjcv3ux8eNKXY3Yhs9P4EV1uGtg8tTTG1akgN0pAuP8Jv6kBFpkr92vVB2onVyC37+xPfx3bSwdG+4EZhNcdZmOnqklpLiw3v5uGp4bTfi4YuuRZ8NqW7XUkVkwde8CoAq5wMGGZZk2aKDtL8kHQ+YR7XLyUW2/nhiAi02sMvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2hy3+JLvC39N71sD49JsoMMLCXWwGvHYp8kbZYOBFk=;
 b=kIkJAB6Q6bOhkpdmtK+WLuVCdn6wCExL4Vg+deaycglVf5unQRD02xgxjzrLYeaVvIFsFkg1oU763TlLWqS4HP/5Y997AwrBAKOy/GdOjP0ls3jHzewV412p/Hfr7v8grzd87iFe1V8blIo8fpQtNafxHUtikS23+DBjQ4GF6akxmV2RZLDQZLCSWjxVus7t3EgbRarIk4ilHqd6al006/oXgvViXk7Vqa+Uypz7O4uL45LcT8VyS+tEkpOPMaiK3Y8tcsqid2fRK8jmvpfx0x4my8/kbvmyWCYqfPUI62BubHdovbndqRb8qwsJ4vzw1tl9JUTHMyHeR/mX0p7Nbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Fri, 9 Dec
 2022 14:21:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 14:21:57 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     linux-rdma@vger.kernel.org
Cc:     Leon Romanovsky <leon@kernel.org>,
        syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com,
        syzbot+8d0a099c8a6d1e4e601c@syzkaller.appspotmail.com,
        syzbot+a1ed8ffe3121380cd5dd@syzkaller.appspotmail.com
Subject: [PATCH] RDMA: Add missed netdev_put() for the netdevice_tracker
Date:   Fri,  9 Dec 2022 10:21:56 -0400
Message-Id: <0-v1-e99919867b8d+1e2-netdev_tracker2_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0160.namprd03.prod.outlook.com
 (2603:10b6:208:32f::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: a9da5d95-f490-4532-dd0b-08dad9f0ba61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JbNt673KjWGsfuuQeEA/0GQW1pA8c9hWGwdEDIkSyiaDcrCfcTuXXgWpDBpyhei2eOQfpgTBOQf/FLvX98s009gyDFPBZx4VX4TbT+Wz1Yy7mVfwc4GgmfWKlXnfMjDhvs8Ds7ViIisjl1jwsE2HNK11Cu0oHaeJ7KEMsCzNYc1xxcrFtBnMuROYriKSGCo1+Almx9p3/jOrxnzvZ6sWoVGFOYW/yAgPkA+tK3r3UBw0A88wm0KgAh60KpPF41JlO51tTS4eLHr5pRHgMtEqZ/BDA02Ix0xZPs8tn0s9Eq20WFlBS9ekt1aQ7mNJTvSNKuplobaYutLHrF7EleljV+Ptewbe6CYjO1bOgtXugYPltlOERMgVz+qVOpIEr71QEisf2f8v7EY4hs1DoaJouPyeu3NWVzXbpPBpfTL76eb5X4xNWgbN9dsYyz7Du2C66WlxeGKH+o+eVRoNBomwB/bs09CQi62/WRUC4lxbbFST4aq12WEWtPSFTJoUAFjReKM0EJrCYCjGzkjDWpv2wRfN94skiSUxR6AzNfYwAHlBh7fkYZNWSMKGXQA5KjTduSg+wnvsBvyNEzG6Wa3A48wKLCyuT7u9EGlOodo11lGD8bBjVGKD8oQveunmg2bK5q9JQ8H/0zH5CeoXF9uh1rZ2Vq6lgJENYitLDx4qaqcsnE/amOYaxmvExuc4Cuf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199015)(2906002)(86362001)(186003)(2616005)(6506007)(36756003)(5660300002)(6512007)(26005)(8936002)(38100700002)(478600001)(6486002)(41300700001)(83380400001)(66556008)(4326008)(66476007)(66946007)(316002)(45080400002)(6916009)(8676002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCuoHiF+p1rbNvQ17jyFMKW3/XaXn6hYSt38JVZ0EuaE765D1aR+/yEc1bpM?=
 =?us-ascii?Q?8kszHPuFhLzlroxvCdREbQb1dR5knGnq/RQOSPb7xrN5JvuFZhLJA0/A480u?=
 =?us-ascii?Q?jtMKX4XO65dtCCJJ57ywb927V2beHDyX1JGa29pAr+pj/LpgMtdVYzQrMXhq?=
 =?us-ascii?Q?4onHTKb0lGPpMHsltv/QDqSONk5Kh9GZptZl++vGid/lTjS4AjTrU+LLJryG?=
 =?us-ascii?Q?D8yTz0XKm4/4j7YmHVGOKgb5XY2PSENq2jV76/fGCWn0SDzWNkjyOigG+bW7?=
 =?us-ascii?Q?1tCqmmLgvfX+CveVgsuU8kqrYAPmNDvhDSBMOdGEgXsAJ1ujNUfzjTWq0ujv?=
 =?us-ascii?Q?vLJ5o8hNMj9riaQwK1gCgBUlART06d+jrU2YE7LLlh4Y7ykaBktjEsMEgOk8?=
 =?us-ascii?Q?KWpAzKOgP464tBG9ra/cUYS98UIIzdsq907cxAsa5V4SeMkEwaaMYdZDz2XE?=
 =?us-ascii?Q?G/NGkkDI4BJC7dwmYqBGw1LAIi2tPATN1kJIpro34pgu6m51nVM2+kdHP9dq?=
 =?us-ascii?Q?DnbCN2EvH2Uuvar/JO5cDBiiQjYcdLHEsTbbigkkC4RmwcsvI/lN8OhS0obT?=
 =?us-ascii?Q?V/X3J1DS8P19lqCWAmOdIUV6ySDOwxK+qq9zI7CXvuHLWVmzwHMcdqf2/eyY?=
 =?us-ascii?Q?5qs+y4ccy+VuBA2e6hYoROkFgmkIAoTnY2G/BM3mwwK31LXjOPd0j+wecFcx?=
 =?us-ascii?Q?ifSRngrERWkQbxa+kuaeTKOBx5WlnfQc1nNGwqVa6R066Q9ZIOfXlG+lTuAm?=
 =?us-ascii?Q?aKGuou1vqmCCGRxYjPF8MqZ3KbHshXBcYNF+aUUAzyR1h9wmbSw2sUmpOoJz?=
 =?us-ascii?Q?F/1QcG2elemMmFHId8FMuoSMAxG+JNsSuo0z3Mese1D1V4sG2xpdETcCVfcB?=
 =?us-ascii?Q?FwrRpART35OknvLPteyuwD1dYM3Dt9T+iYIvuIATDPjbv+OwyT6FCCkOs6bn?=
 =?us-ascii?Q?YKLcKo1scWJkcFh1r8UFUKKPZAj7emU/wS05kykHE0Euo2hOaLOzAgM654Ou?=
 =?us-ascii?Q?taF2sV+CPABnnyt3jAf+VyabNs1M5qeKnEEBYX9jEoYqVKDGby3T3aFDGJSZ?=
 =?us-ascii?Q?ysI9wDGamPfKVSFe9uymgatOfil+vXeMKEBPzM0y3TQh3D4U9+qlY9AbjskX?=
 =?us-ascii?Q?x1dOXgCKavxpYBl9D9ABeCs4lQfb1d53B+TNnyevat2CRupOv9af43hUyPOS?=
 =?us-ascii?Q?+vWTm5iMw1P1ZWn+lbBS1IyLMSVw6rFL0Zj76toy5ahaRhYLdWtjDPtwHQLX?=
 =?us-ascii?Q?SoVoOjvS823es1yufxOSQ12SZSx/6UyfVz1SOme8bszztbRyjvIuxKe5Lw/O?=
 =?us-ascii?Q?9lYZrnKf3lNhPqmOfOM6k321uuM5Rg1mKGL0v3cCnxQp5tn2It/k8iWEtGHQ?=
 =?us-ascii?Q?RdTWenfsRRSA3umv2J7SEezXz6wps/l5SFJmeb+kdi3L39J74w1Pn4j1MdgQ?=
 =?us-ascii?Q?IN1zYmC0mZ27S4lYK8mJQqXdn/A4Fcis0aiHBUOIYMdhH5s3aSlRZMsUaAu5?=
 =?us-ascii?Q?W69t2x2Qx2BNF33YrPgrmbnn8xPtpSSljpS8UctFkwBH4FRe2ZjuWa+EdtZh?=
 =?us-ascii?Q?xE+MfkTvEjzPMPXcQAw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9da5d95-f490-4532-dd0b-08dad9f0ba61
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 14:21:57.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wL3lplfYn4/jRblKQF0Mt5Py/O2ipAT+IX56LwlL0iv2Q6TRL1Am1irEDC/P+4yz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The netdev core will detect if any untracked puts are done on tracked
pointers and throw refcount warnings:

  refcount_t: decrement hit 0; leaking memory.
  WARNING: CPU: 1 PID: 33 at lib/refcount.c:31 refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
  Modules linked in:
  CPU: 1 PID: 33 Comm: kworker/u4:2 Not tainted 6.1.0-rc8-next-20221207-syzkaller #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
  Workqueue: ib-unreg-wq ib_unregister_work
  RIP: 0010:refcount_warn_saturate+0x1d7/0x1f0 lib/refcount.c:31
  Code: 05 5a 60 51 0a 01 e8 35 0a b5 05 0f 0b e9 d3 fe ff ff e8 6c 9b 75 fd 48 c7 c7 c0 6d a6 8a c6 05 37 60 51 0a 01 e8 16 0a b5 05 <0f> 0b e9 b4 fe
  +ff ff 48 89 ef e8 5a b5 c3 fd e9 5c fe ff ff 0f 1f
  RSP: 0018:ffffc90000aa7b30 EFLAGS: 00010082
  RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  RDX: ffff8880172f9d40 RSI: ffffffff8166b1dc RDI: fffff52000154f58
  RBP: ffff88807906c600 R08: 0000000000000005 R09: 0000000000000000
  R10: 0000000080000001 R11: 0000000000000000 R12: 1ffff92000154f6b
  R13: 0000000000000000 R14: ffff88807906c600 R15: ffff888046894000
  FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007ffe350a8ff8 CR3: 000000007a9e7000 CR4: 00000000003526e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   __refcount_dec include/linux/refcount.h:344 [inline]
   refcount_dec include/linux/refcount.h:359 [inline]
   ref_tracker_free+0x539/0x6b0 lib/ref_tracker.c:118
   netdev_tracker_free include/linux/netdevice.h:4039 [inline]
   netdev_put include/linux/netdevice.h:4056 [inline]
   dev_put include/linux/netdevice.h:4082 [inline]
   free_netdevs+0x1f8/0x470 drivers/infiniband/core/device.c:2204
   __ib_unregister_device+0xa0/0x1a0 drivers/infiniband/core/device.c:1478
   ib_unregister_work+0x19/0x30 drivers/infiniband/core/device.c:1586
   process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
   worker_thread+0x669/0x1090 kernel/workqueue.c:2436
   kthread+0x2e8/0x3a0 kernel/kthread.c:376
   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

So change the missed dev_put for pdata->netdev to also follow the tracker.

Fixes: 09f530f0c6d6 ("RDMA: Add netdevice_tracker to ib_device_set_netdev()")
Reported-by: syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com
Reported-by: syzbot+a1ed8ffe3121380cd5dd@syzkaller.appspotmail.com
Reported-by: syzbot+8d0a099c8a6d1e4e601c@syzkaller.appspotmail.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index ff35cebb25e265..4d4f71f9728e13 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2201,7 +2201,7 @@ static void free_netdevs(struct ib_device *ib_dev)
 			 * comparisons after the put
 			 */
 			rcu_assign_pointer(pdata->netdev, NULL);
-			dev_put(ndev);
+			netdev_put(ndev, &pdata->netdev_tracker);
 		}
 		spin_unlock_irqrestore(&pdata->netdev_lock, flags);
 	}

base-commit: 682c0722addae4b4a1440c9db9d8c86cb8e09ce5
-- 
2.38.1

