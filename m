Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3E40B76A
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 21:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhINTDG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 15:03:06 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:24097
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232113AbhINTDG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 15:03:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW8SeBGI+ioNV44vIXTlXoMo0NxwXSX/RC75VKKpqC3Jxte2YXSXDXj1YUK/Ktpb3SsePRfRDsb7ZXHnrFGX8ISyW0GhT2/RVY3rBbKPKQJ4bFVkZnEwRMsdoEkolX/BweetSA3MPTb5uOrrnbJth+2pmUadJqH4KudDm/f/dg0eMp30we8AVMZhNAfTrjOHV9QJRIvGXCt0c8jGlmEU3Bm2E7l9ZqtOfhWP2RlSb+TTFlJv+6vi69fqx8yv6zd8RcPu7yiN68NTPKM7mt2aGC3g0ZgtfFGMEmaDMu0KlZVIxGFTylK251V3eItfBUh6G6tmx5Z2flNThG3SkJRHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2Dt/FTSZiY26OuKNQzQBSfszyaVPU3yyol4ZmXuA/Hc=;
 b=UngJ5nwuvXLtzUulo01OORQsY47PFtCQU7Saz/dtVykrX+b89pvfrpK/ZkDlqZ7Xp4RaTG2MNdL7cryZzz4+xtqU4MJ94TRzGBnxxl+NAtDVaC+jhJXhPKv7+3P5ImNH+UVbXk3cueDm5N9x+dKAsyzyJyXN6R41UZtqA/Eprk445uagkY96FDV8HPvo/lgwVPRYxw1HtIOfpcy0n1zJ8m9gwrvroW2M6Z6SxuMaXB1sHKaix8A4nrK3krPBpbEQ8TICXSABtB4OsrrWMx3qwuyqg0a9wb0JsF2VGW+baOy57mKJaXtOFTY14rgIDsvDi6mq7gxH36Ln/r2t80Vj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dt/FTSZiY26OuKNQzQBSfszyaVPU3yyol4ZmXuA/Hc=;
 b=KH2fr4vEh5Rh+UHZLLPwpoL8CFWx+M5J2BWlWuZK5oXYB0CUyTRTrvdTUObqTcJ5Gx4AvHEpFb4mHxMRB0L+Hdz0nhPze9F0xo2G1PFP1nl6eSqqFT8OOnWkBqr4x1DqbA958xjGUEQIsa1jISsuPgbCkR1xlDC5VD4B61hMeGCxOLGaXlFWoOF4Illy1c7YpmfnfNAnl+60daYpxZfaU8iQ+rbUgrqXvf2LR/yRGZMyJ+xAbJ/Me0UjEe1/k4XykUgXOAYbjSfxKE86IuB3CX0KSbVjhalBgFKWcMRO9PBApx+4WNoZc4zJ5HOf0seQuykPYkbR22PTJIwPEOCByQ==
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 19:01:47 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 19:01:47 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     linux-rdma@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH rc] IB/qib: Fix clang confusion of NULL pointer comparison
Date:   Tue, 14 Sep 2021 16:01:46 -0300
Message-Id: <0-v1-1b789bd4dbd4+14b16-clang-fix_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:208:32d::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0057.namprd03.prod.outlook.com (2603:10b6:208:32d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 19:01:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQDgg-000ben-CZ; Tue, 14 Sep 2021 16:01:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb09697-1159-48c1-938b-08d977b219f0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50627389DA000D09995B1C33C2DA9@BL1PR12MB5062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MZd8EAQi35qgZNqVGjZWjnHVUrIJz7opS0B15X4umv9vThdQxC1/Md9ICbAlnrX9ZpcxX1GtGReMh1aueNL7GNCZsDrebgcXsr67FNUBKsqPPoqt4oe/Yb5EYU4gqDtvaCbCXsOVLkEKiv43WT4rQEBWs/eurOUsVw6gH6TSm3eoND8gsWTNH8hU+7DfQ3OZXMQaekLGSQX0y4kOveh7nGQ7L/cWw7s8lhoped2l6hxV1LEmlsjYwhkKspwDhsA/UvmIG0kC9Qz5GgD5/gOb7XmM7aSAzrGDaLjF+cBBSnKXHPAk7r/pyckFjVEDb7P4JgF8P0B6I/ngRvEtHoQG9HAdacfCCXxJgy3fOIxD/4G7OO4f56BtkjnVR1kFu9p88aFA3qCNtVGgsfU+d3Va64Kzv3+gZ7dAyh+RmMWulUU5N0Cjb3gx9EwAuLwl3MnoCCknW3MfTjq9YG8mWII5tbFo28vTshE0/Ulpv8Ez3VldHx79TTI6OjQzfLUDPYlZJay8gF/cXvA0i6CwQaF+XIcRWIC8QOgYxgteBm8KbiNxSS5gDKFSp6b2gwm/zRI+0nNbG06lZFoluUbz0We/n1AGe5420ZbiH+w1+a8oUWp2i8CQanTXIA0YwHwq8lv3stQuI96413geBWwPAZzgwpsbJYKa1iXxmY+OmenaBn+5BJRYpnrYfjPGZRowpSlC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(9746002)(9786002)(83380400001)(66476007)(66556008)(5660300002)(316002)(38100700002)(8936002)(2906002)(426003)(478600001)(186003)(66946007)(26005)(2616005)(8676002)(4326008)(86362001)(6916009)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2TFBspYHcCcZf2T2LwjY+4UjOiiFTg/S4ewge/WDpgkFYPrPA1H6aMvFirl8?=
 =?us-ascii?Q?vCxf6eNGm9ahPExKNeUQuhEMhlQKBvbZ96SkxwZH9tB822h8nNC3ZQOVNIAb?=
 =?us-ascii?Q?hWhV5tT5E354EoB9zX2x3afkX4KOKoWbQbMF0ZqwGLcnx3Y8Qmh54PwHrhvt?=
 =?us-ascii?Q?GLlsa64V2Bs4LNx9tjEhqo+6GEpuIn6X1ivnhyNW2yqUXplhk8O27CcFNme9?=
 =?us-ascii?Q?w/MW602zHXgcPP6x2mVoJwp0e63NgEK1DaH6/hZVz9tdeuEcBJ/m/zxxPvag?=
 =?us-ascii?Q?P3OHMMjpkDPI0V4gywrsULe+iBzlpcKUlVZsIWtBWeUTK1bLUpQ2jDQXaKTc?=
 =?us-ascii?Q?InVHYrC0GCyqkwTMdicJ0z9aAtH7x6MiVE337873RHiz+N3CWu89Z5FmfWem?=
 =?us-ascii?Q?brQu8Hl8gJFMUqrY2RwaktPoN8SvhOZwMzUJRUUv89MQQzZv8xXMwwatetse?=
 =?us-ascii?Q?D77kREjWj/mbbQkNAzWyA2vq8+iLdDYGhvYMNhxB60DMOZfQf1k8uxHvXYkc?=
 =?us-ascii?Q?2ztn6lGfnPrhKhMQk2Q09nigJf47v/8NfLaV4w2ArmvBGypSiQWVeCYMk2zK?=
 =?us-ascii?Q?pt/FqMny2QKkuA4eyNdieYsjjDkhzDkwGgAs+1mI6gMGe0ZBzyh0PATky2/5?=
 =?us-ascii?Q?CT1SkkhakYs2+iz0Omgcz0UWeFLpzNbGxtX/o8Guw/hlBW5jQ+3wuWakYvyk?=
 =?us-ascii?Q?gf4UgB4p5LXROPM4Tpla/HxQLkAPMEpRlMukjByNTIi++BGX6j0nRDHUoU/B?=
 =?us-ascii?Q?iXUTV+XKuPdqEnBsmRNzzCjO1tzGs7oprJDlJ2Afl2tTpggfT+vBsCBG7YOD?=
 =?us-ascii?Q?eITXuAuYt3beHYLIke3i0qbRep83TAG6D6tgQRgcKx0tTsI6O6xrX33LTOrX?=
 =?us-ascii?Q?50UOoUjMVkmQRJLHiDCMYfVXvLavQFK9MlUlg66xdbt3IMbL99bFNYaBDcDk?=
 =?us-ascii?Q?Rt1kCnKR9xYn0xyNI/WUoQnShc0qjuEQk1nvjw74CUU1AufvlZXPOdZPVFZK?=
 =?us-ascii?Q?L16VFNmZJcgSrrHXeJA4IRm9yzv988oZ1Z2WA5Dm2bAXZn4/kZtYb43BN2pq?=
 =?us-ascii?Q?K4A6l14cc9BQbqsW3UC/sObTnk7Zm5Ax92hrEF4e5K+zm2aDRzROTbsjl00s?=
 =?us-ascii?Q?aQ0K20qM4vPBeXQkKw6h8EPK/YbVOyMQYhRS9LEJ64iBWKO4AH+Uw+SUkzZb?=
 =?us-ascii?Q?vo4lJw2UK4p3ipzlVuIvwcOJrSAQaVbMyNxh5uPD4vA2xlPJJCzLMIQNYrMT?=
 =?us-ascii?Q?UIQby5kMhzsKaMllYVlrSK/nhIDYxg2XT/Vf56hwVLY043PM/YX6YFnZ7q1E?=
 =?us-ascii?Q?Hjat1JQElfdyrK0oviVPTv8V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb09697-1159-48c1-938b-08d977b219f0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 19:01:47.4180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaBdTfRQy2mIrIhcYC+A0SLtY4+U717TJXK4Ay7P41Qq6Ptei/u3cTbGlKYp1Kho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

clang becomes confused due to the comparision to NULL in a contexpr context:

 >> drivers/infiniband/hw/qib/qib_sysfs.c:413:1: error: static_assert expression is not an integral constant expression
    QIB_DIAGC_ATTR(rc_resends);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/infiniband/hw/qib/qib_sysfs.c:406:16: note: expanded from macro 'QIB_DIAGC_ATTR'
            static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \

Nick found __same_type that solves this problem nicely, so use it instead.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/qib/qib_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hopefully third time is the charm here..

diff --git a/drivers/infiniband/hw/qib/qib_sysfs.c b/drivers/infiniband/hw/qib/qib_sysfs.c
index 452e2355d24eeb..0a3b28142c05b6 100644
--- a/drivers/infiniband/hw/qib/qib_sysfs.c
+++ b/drivers/infiniband/hw/qib/qib_sysfs.c
@@ -403,7 +403,7 @@ static ssize_t diagc_attr_store(struct ib_device *ibdev, u32 port_num,
 }
 
 #define QIB_DIAGC_ATTR(N)                                                      \
-	static_assert(&((struct qib_ibport *)0)->rvp.n_##N != (u64 *)NULL);    \
+	static_assert(__same_type(((struct qib_ibport *)0)->rvp.n_##N, u64));  \
 	static struct qib_diagc_attr qib_diagc_attr_##N = {                    \
 		.attr = __ATTR(N, 0664, diagc_attr_show, diagc_attr_store),    \
 		.counter =                                                     \

base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.33.0

