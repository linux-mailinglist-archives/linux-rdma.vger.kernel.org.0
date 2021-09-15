Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA940C785
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 16:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbhIOOf3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 10:35:29 -0400
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:50368
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236855AbhIOOf1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 10:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKVzf0i2NOqhzNl9XyPQfPSy/AtA5Wpy8l2/ezVe1ZqnpVGK5E/Qs21PkdCfl5jv0ZK0VuON71czg0TXK2VYyen0/3eBZNS42KSqF97jt08OiJmUCG4HH8X8NniXK49kNBhq4nZmHvwL5VrN1k0aUXklmGp6+2WEIyZAmGD7JseUWLB3OTz5CTs5h7DTWUR69S/TTzemqF7ByNFltUR/FR0HGmbq2Z99aUBI5qLgco23uif1bAOZcrU0np4GMBS9yqa/a/l8jBinRTa/au3qPfE6BCzEgBHfZELtZUjeO0+Ibnle0bZPSvSSMCDVtu/3LsKOJiZonjKuT4s125MC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pXC0BqL+iEYlaSewSVEwiE6x/6tdOQLnmyXaCCcN51s=;
 b=EHLeRs5jGsiCnDhkGNXfijMJIJJ3W+RluDXGZt+l53iX+7W4luuzRHMd03N1HNKQIyfv4zi44BbXqPLOLHS3Io04g/0eQ7KyAOspC4eeITIWy5NJgf2eNsAOilVQ2cftXatOl+Pp7TlOH16AldHOyYQfsbvDyVYpnGvkBjLdSQfuhXbhaNrzwlvTidbGJH0stCEpBcBF7Uapwd9DBOI55ocohoJy/HRt3oN2eBi+TVamPnWqOEEe14sYySEnErJYsSoyDNFOI4QkGX63dkoQfNqWustFoQpfY1ZdPqC/kHyKzFN5iK9u8XdvLxMnIm53yhYIGwIQc6u0k/+frrJ+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXC0BqL+iEYlaSewSVEwiE6x/6tdOQLnmyXaCCcN51s=;
 b=qGpwzVECuy9Zflf2djR4gk8D1W0BQO/HGgzZK+kIyIMWa43yx9RF60XhFrZCl6gEKle/F9UQqNYIPaXKyvjWpG7YuHeJ4OVymSrJZBggiPzXvu9pUFIU8IEEmZ87Y+Q76bsZJ+oEmBd6dUkYjQSw7uu+3eRebEjqZJDj2/eY7hryH61Gyjn8nVx12GKPIYDM+G55pJ4BEusLQzLjyezDOEKD+uARf2H7pZgOyWy5m1udr4S7l1UZL0vIDp6UYcoKU7yH01PiswsUuj2YPzbPPCBB2NVm9Cg7uxtyFx6xwrtUbRFW5/aYuGciYDiDMNaLUxTdaWWqqHFvFWrcnFudBw==
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 14:34:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 14:34:06 +0000
Date:   Wed, 15 Sep 2021 11:34:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: v5.15-rc1 issue with the soft-iWARP driver
Message-ID: <20210915143404.GL4065468@nvidia.com>
References: <ccb9ee03-4aaa-2288-3d2f-ce01f550a609@acm.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb9ee03-4aaa-2288-3d2f-ce01f550a609@acm.org>
X-ClientProxiedBy: YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0055.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 14:34:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQVzA-000vMh-Mj; Wed, 15 Sep 2021 11:34:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42a7d047-160f-406a-1e49-08d97855df3c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5237:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52374B2D29D387D7574804C2C2DB9@BL1PR12MB5237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d62PjsZ2hYgathELtfgVfEbzJ8eT1vpTrpw/qnZnwGXroLEFu4e+LNXsBnLZ/GGNBaKbXgmwfegpca0H5vjhirGiNqSTFc2WVcfoh86Ld98hEzhjZyqcrL2AaUXjrINxa05PoWi6iF3jClUHdWLjfc3YDKqZKhzxwWdN35cM3xPqujH40w43NqZRuyhDJn7hEb76SM/S2v+WtYZOkgjY++zlqF8PFAN9kvar8bsIXiH6Cc6qjaJ1lG7G25OMUmINhGbvIlriIm14PSjS+MZT+tuWO44dueoAWNcmO36jCkCiTWPeCDZUMUL6FPNMWAFNxPefD4xPJcMw3eg1Yycat4BX4qhdGTdyFgmC/ArJRnA3BTbsVr/10WHmxrT5A0EfqeRy33l/JILJMGi7bl7ZIAxsImzF4+PwLIjdDt6/QvGONxcWF0Wstz9u8Ao+FxdMYPtDSUpcHt9vCaz6VFh1wTaBKLtYudDuGzVnjwDO8ORR8Ne9JTkLkMdPBS/1Rhwd4TTCw3PUs6V64igSJjECEQJnjyVfYUKGVwJPlDhzM/urL0HTFrUQeGoLcJaJNeY50OXVfRZZ/o7X5TLSUEEzWavw1GGCXK8ZtE3Waumco6dedWK3sDS/dj6xfHWmS6b+LwcjjKhWuqkVYKSWIgDVllUEIUIh1GGiyglERNKOyY6Ypf2yl6uphIuAT5Z7lvtsLfh8vlHCVuQ0zdPBuwdOxLuF6S+PvBYValyTQiUGSik=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(2906002)(5660300002)(53546011)(86362001)(33656002)(66476007)(9786002)(426003)(9746002)(83380400001)(66946007)(38100700002)(26005)(966005)(2616005)(8676002)(6916009)(186003)(1076003)(36756003)(66556008)(8936002)(478600001)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M6SUaNy7Zp9nCT9wqzFdTKh30NqLc/KjQeV3r2PMjRgdpazwvT63tFwPOlTP?=
 =?us-ascii?Q?miR+LMB2qI/xGf4SKvAETAzOSlZ9ek1cDvvGcuGQZtzV7n4ZuKl30xNTrrHG?=
 =?us-ascii?Q?pcFg9LHy037+CT4bNO/wcMF8N0nFW52RRDsQo0WhSSFt056BlBUGSCdo9XO7?=
 =?us-ascii?Q?Gkbr/xCDyCprorjqHVr1pN4rak2ZZz6Hbw6uzRnk6oMo+PEzYHTthEFUZMWu?=
 =?us-ascii?Q?2k44leqv+Mhf/g2rE1DbQ+kF170hLurpCOkx1Ugsg6j6PCa7Q94ECcRWgJrt?=
 =?us-ascii?Q?jm73E03FQfFo8LTTu5rWbrPSEyOPRP7q1jNqsZjDUrxGM5jh3UwEj5cpJqWb?=
 =?us-ascii?Q?+dIQduahN4SHqb4J/DOxrE360NSv7Jwo3sxQwY2fPnIA8QsIKtdqNnKlfQLd?=
 =?us-ascii?Q?NUwSXdPvn1Sz5+9OlCAx5gAniUpQ4UsYkxTWdnrMWMyFJ0DTI9FUMXUcApVI?=
 =?us-ascii?Q?Cw0QvMtH0dVtGYNgOGwEags2R2PWQtdZ/aAEHq9TsMZurcx4L52EsVoTUjAa?=
 =?us-ascii?Q?4f1ilGiiTrkP/pXP1UIr/ObO614YY11T6LbUq4WCRnXlWAwQvyn7faxW2wli?=
 =?us-ascii?Q?Sl2BitZY0Zo6njSjMJfcnt9ImfR3BBBitqSVSRHQtuEz7VqYb+6YvNyjG4Mn?=
 =?us-ascii?Q?5NdG06CcirdEv1Pz7fAiCbmjMl/hNMBMTk2Ld92gycARlJ7mW1gsYdbhWqMJ?=
 =?us-ascii?Q?hMh+A+fkczhIaWVZ6oseufAeeS3VCyARH9AIPURRAd25v+ZqwiLYewZq/AY/?=
 =?us-ascii?Q?El5Lq77Bl0qpwKX424q3e40K16ZIcxMsGM6X0tyHtwDJMG7xU8LphnTa/5VL?=
 =?us-ascii?Q?RFiGzhFXFPLYQA/qRcrJBNILzw9BHLRm3TVeqZArVSbu6bpJQ25z584jUS6O?=
 =?us-ascii?Q?PB3H/l7PUYnSgB1W6L/v6Bzu60vVnxRX51XE/pc9OznnF4nm4BVijIp85GhL?=
 =?us-ascii?Q?bbmeEWTzKlW5Y2mOtbd5llWEXRCHqsGul/wwilkWlUjaN/yfjRpkbaeYFTe+?=
 =?us-ascii?Q?UKfD5SQOR3dRkYN9E8x58Qqo5XSiRbMXOJcCMZbIvfJgGDa+WSd6kdZbOTZX?=
 =?us-ascii?Q?VB9VEdqcL0mljoXC6EaTX5V7Sf85SJA4QlaUyrHdTSnz/26lnlLm7kXDY8yj?=
 =?us-ascii?Q?W09tHkuFoCZEzSpLxIH2WhlTd/2HOXcnPIyLaPMJfKiEhPAa8jT8QlFOFcRb?=
 =?us-ascii?Q?MXKHsWCv4oCiJqxj5pGoKyISeAa4p2PqF1t6chpPpLe4jXKOuFBsN+IeRIi5?=
 =?us-ascii?Q?BHSZBG6ACBqMMOrCyLNQzRZR9VvsNBuQFYhOivuyFrfoGRjyUHV/zrUVKe3s?=
 =?us-ascii?Q?aMrGuLZrNuxXyNGMNp1AvFQN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a7d047-160f-406a-1e49-08d97855df3c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 14:34:06.5474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ut3H47SxiJm07UUF05UXjlD6AcWJgfkMMFS2BPKdorw8D5QGXCz2czHG1xkbL8Qk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 09:54:27PM -0700, Bart Van Assche wrote:
> Hi,
> 
> If I run test srp/015 from the blktests suite then the following appears
> in the kernel log:
> 
> ==================================================================
> BUG: KASAN: null-ptr-deref in __list_del_entry_valid+0x4d/0xe0
> Read of size 8 at addr 0000000000000000 by task kworker/u16:3/161
> 
> CPU: 5 PID: 161 Comm: kworker/u16:3 Not tainted 5.15.0-rc1-dbg+ #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> Workqueue: iw_cm_wq cm_work_handler [iw_cm]
> Call Trace:
>  show_stack+0x52/0x58
>  dump_stack_lvl+0x5b/0x82
>  kasan_report.cold+0x52/0x57
>  __asan_load8+0x69/0x90
>  __list_del_entry_valid+0x4d/0xe0
>  _cma_cancel_listens+0x49/0x230 [rdma_cm]
>  _destroy_id+0x4e/0x420 [rdma_cm]
>  destroy_id_handler_unlock+0xc4/0x200 [rdma_cm]
>  iw_conn_req_handler+0x335/0x370 [rdma_cm]
>  cm_conn_req_handler+0x546/0x7d0 [iw_cm]
>  cm_work_handler+0x419/0x480 [iw_cm]
>  process_one_work+0x59d/0xb00
>  worker_thread+0x8f/0x5c0
>  kthread+0x1fc/0x230
>  ret_from_fork+0x1f/0x30
> ==================================================================
> 
> I think this is a regression. This happened with commit a17a1faf5d3e
> ("RDMA/cma: Fix listener leak in rdma_cma_listen_on_all() failure").

Gurk, this is a horrific mess, these list heads are multiplexing between
4 different roles depending on stuff. Thanks Bart

So let's go closer to the original patch:

From ca465e1f1f9b38fe916a36f7d80c5d25f2337c81 Mon Sep 17 00:00:00 2001
From: Tao Liu <thomas.liu@ucloud.cn>
Date: Mon, 13 Sep 2021 17:33:44 +0800
Subject: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all()
 failure

If cma_listen_on_all() fails it leaves the per-device ID still on the
listen_list but the state is not set to RDMA_CM_ADDR_BOUND.

When the cmid is eventually destroyed cma_cancel_listens() is not called
due to the wrong state, however the per-device IDs are still holding the
refcount preventing the ID from being destroyed, thus deadlocking:

 task:rping state:D stack:   0 pid:19605 ppid: 47036 flags:0x00000084
 Call Trace:
  __schedule+0x29a/0x780
  ? free_unref_page_commit+0x9b/0x110
  schedule+0x3c/0xa0
  schedule_timeout+0x215/0x2b0
  ? __flush_work+0x19e/0x1e0
  wait_for_completion+0x8d/0xf0
  _destroy_id+0x144/0x210 [rdma_cm]
  ucma_close_id+0x2b/0x40 [rdma_ucm]
  __destroy_id+0x93/0x2c0 [rdma_ucm]
  ? __xa_erase+0x4a/0xa0
  ucma_destroy_id+0x9a/0x120 [rdma_ucm]
  ucma_write+0xb8/0x130 [rdma_ucm]
  vfs_write+0xb4/0x250
  ksys_write+0xb5/0xd0
  ? syscall_trace_enter.isra.19+0x123/0x190
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Ensure that cma_listen_on_all() atomically unwinds its action under the
lock during error.

Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
Link: https://lore.kernel.org/r/20210913093344.17230-1-thomas.liu@ucloud.cn
Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cma.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 86ee3b01b3ee47..5aa58897965df4 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1746,15 +1746,16 @@ static void cma_cancel_route(struct rdma_id_private *id_priv)
 	}
 }
 
-static void cma_cancel_listens(struct rdma_id_private *id_priv)
+static void _cma_cancel_listens(struct rdma_id_private *id_priv)
 {
 	struct rdma_id_private *dev_id_priv;
 
+	lockdep_assert_held(&lock);
+
 	/*
 	 * Remove from listen_any_list to prevent added devices from spawning
 	 * additional listen requests.
 	 */
-	mutex_lock(&lock);
 	list_del(&id_priv->list);
 
 	while (!list_empty(&id_priv->listen_list)) {
@@ -1768,6 +1769,12 @@ static void cma_cancel_listens(struct rdma_id_private *id_priv)
 		rdma_destroy_id(&dev_id_priv->id);
 		mutex_lock(&lock);
 	}
+}
+
+static void cma_cancel_listens(struct rdma_id_private *id_priv)
+{
+	mutex_lock(&lock);
+	_cma_cancel_listens(id_priv);
 	mutex_unlock(&lock);
 }
 
@@ -2579,7 +2586,7 @@ static int cma_listen_on_all(struct rdma_id_private *id_priv)
 	return 0;
 
 err_listen:
-	list_del(&id_priv->list);
+	_cma_cancel_listens(id_priv);
 	mutex_unlock(&lock);
 	if (to_destroy)
 		rdma_destroy_id(&to_destroy->id);
-- 
2.33.0


