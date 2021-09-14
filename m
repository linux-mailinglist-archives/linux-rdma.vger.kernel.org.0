Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D34440B86C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 21:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhINT4H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 15:56:07 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:9749
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233162AbhINT4G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 15:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0IJGbGFtPNdwD/L4oBejWp9WShORWVCVyZX2rmQvP/cIGlM20Btu2i/z8/VTo81YI+a4tDSa65518u1UfzwF9rNTsoLTuRb9bwqaB7vH06gpyeH3kkj3tzNyE0LunPP/uqIITB1CtDVCf9mHqfUZjeQ3/Vt/z2ovq3twkgCigjgWRDRJpNjKm6uodMBCKeDKsT2o5Y3ERVFNp4kqdX6bHQQX0ejogxZPcCJDYGE+JhtJD+UcweR1adV5IyZVYT/ZbdhnFKr7qDpPwLDozxaSv5bMP7m39d3pj1FOUeoZzo+xjn48ZcavmogC12VfxYuOJjrKowYtIzxJrT9xp6BVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=QQ/R4mMrVJXlG1xk9S0bpocghLYcd5UVAcoN23OaNYY=;
 b=JZR6Fp2asFq77P8IaSjY4GoAFP+RO57uTRyLIGCxIQE0RR77NK99tRqK8hZpo0IJHvZ8OGBMtCSVxgwRZi4ney2tvkSSXikJMlPdrUlEti8y5+5rujyHlcn3ONBlBkk93C/8aVY/iINBYlfNZNKQwRQ/Nhwc80C+3m8JSvu9+aqAfnfxw1uwYirrEfzZ0DFJIFB3PlkKf47sdA32dXpCbTBfpy2moaS+YF1fRLDUV/I80CTaBd6+HldaAvgnMEqd4RjEQ2PSOvLe61tUCO6IeRTSlYYtDVaZef0ZB51g4vxcN9idSZUbHJE2KBUTkpStOiO7nNFJwXl+8Bn+rpd6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ/R4mMrVJXlG1xk9S0bpocghLYcd5UVAcoN23OaNYY=;
 b=TcrZFbyEGsdOVpYin2aTI2i+LkPH+qgT9a2F2+sovRLjdnYTWt/qSnN4CD93yScJrmzuFaM0IiRwzoSFzl5fOwrWZg982EBKLP4NoRKm51WPeDs2Bhk25GCl4IR34xsOkAwHlhP7ZgNyXTrY+8o/n3IwShSnRGN//MQScMNP5PTk1y4nEgslKEWsoKQzjuboPeKvFiwTnmDeJVlHboHeirUtzhuzLMuw5hI0uJrXN9egibh31xfJ6lHPW3hRK6QcSOXAj9SpmkiM6OBnGFyelXHbc4qn8KAV98Mu+R0eR4Kb1jvSr2mgcRYhYTxEboGV6TWuz1/73ow23rPQ5tM+vQ==
Authentication-Results: ucloud.cn; dkim=none (message not signed)
 header.d=none;ucloud.cn; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5362.namprd12.prod.outlook.com (2603:10b6:208:31d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 14 Sep
 2021 19:54:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 19:54:46 +0000
Date:   Tue, 14 Sep 2021 16:54:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tao Liu <thomas.liu@ucloud.cn>
Cc:     dledford@redhat.com, leon@kernel.org, haakon.bugge@oracle.com,
        shayd@nvidia.com, avihaih@nvidia.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.liu@ucloud.com
Subject: Re: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all()
 failure
Message-ID: <20210914195444.GA156389@nvidia.com>
References: <20210913093344.17230-1-thomas.liu@ucloud.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913093344.17230-1-thomas.liu@ucloud.cn>
X-ClientProxiedBy: MN2PR19CA0017.namprd19.prod.outlook.com
 (2603:10b6:208:178::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR19CA0017.namprd19.prod.outlook.com (2603:10b6:208:178::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 14 Sep 2021 19:54:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQEVw-000erv-T4; Tue, 14 Sep 2021 16:54:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea749cee-c2b9-418d-f4cb-08d977b980c3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5362:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5362E618793474AA5054C2E5C2DA9@BL1PR12MB5362.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQyzLEk7peESjSym5LA2YCOVI8WfTUM4El7LXE8XbeTTej2Z/L20NuDrgi0s5GA5WtDsfF47Y29/Poy2RTBRGZmfSr+HuITRIwdXeB8TZ9mu5aIooWry9mNmnhIjBhZv61QWS8ZGILbg9WzTaHxS/GyvfkbIPdzXa7X8aRaaedfAGIAlavdLpOVc07m2hDgBZJNo3kEAzC/PI9GvONXPGQ9BF0/AKFKFIVJL5WV36VAAESLqtqnMJkoqTzwOEOURU4tT+zwMIbj4qAY/OMwPGnp7jMJW+npGG4+42FA00oRxvSz/3wtS5lzeufkXgaRgIVIAVvRybNm2FK1ivhuUr0zBZs88psR8FxqlLqwwCzFE3ya5727pLN3ATKGAO79K4B6usS41UfWw3zqYr2UL7IVks9qGSdv/a5+CzVlgpp8NmVI2ji/9jXXKrroKDJT8BtHZ6fMh9IVfFzGJ5Ko0oZTRC5pwoSl+GXRE2nApuENilTl4B4OO4Q22zQzdOs2fJWgCxSTHrCSUuW6km4wrdZ6HPlzfcqYY85e5PET5BrVdqiq9uFAZfozzDnhm4/mX3aAj4eKd1CmkCdQyeHA73bOEKoXdBaasE+3PgGDXF+3lEj1AEK53d3sgdGt7W/jjuELtl/rnjJy8u6cFFxRGClVZMJbdFFFErICOiL2eKxy679fGdg0dcrodoITQTyKDTdiA8R4Sj4sQx01MsxQBHcGPPROBMo808jFAxYPI2CNBrppFtFTkpQWJFMjtVT5Pu9bMU1bI0PFC67KAOy1kqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(66476007)(66946007)(966005)(1076003)(66556008)(26005)(36756003)(316002)(5660300002)(6916009)(8936002)(186003)(8676002)(53546011)(38100700002)(2616005)(9786002)(9746002)(426003)(83380400001)(4326008)(478600001)(86362001)(2906002)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lI1YN3J1o3DSbS4hAtot7toxTbdnYntI7Ob87PRaVJLnTlZLZnHdQY8hJ6pr?=
 =?us-ascii?Q?2DTHUt+Yk6RFS2iiSf0LCRJ2Gsz3OABBbn6hqdSbY4cZSsPeYqOmlb6ynb3a?=
 =?us-ascii?Q?ZyA66ArerMIJr6LR3hjNH4PPBkhdZDATZPTz8af3zQUlaNHgh1sNmWXLZJWo?=
 =?us-ascii?Q?pYz0s2Z6m9ICauJdcPDNAUEwJURuH6nc7R6YzPt0y8oBh4IceDXvbz+CSGFP?=
 =?us-ascii?Q?bjgaoJImNFDuZTDWCzlro7vqa5hL9fIlpv8TJo/FpBZUezkM63TZHKNjlNL/?=
 =?us-ascii?Q?a7PF7JPqSUY+6sOH4qG1Dqd2n174sHoQpndkowgANST7hOeqRveudoep28lQ?=
 =?us-ascii?Q?mQlG+oziGVRH8e6vzK88Zrk9ASEoZi1I76Ys7Aqp1bPk3NXbp5hMDUtqS16C?=
 =?us-ascii?Q?pSwyqtCojrvnDcobDR5xkK7T4Neaghqy0Kkpolqt5NXCSfmbs9zD1N7VkGiY?=
 =?us-ascii?Q?U9A5gk7PkdddaqiXdIa4A+SQDXu1Vn65EJLHyFkq5sG488QLp7vTA2KDizbn?=
 =?us-ascii?Q?AySkBjWraFKYlUcTH4Elf2DLciHqsczPBzWGMte1YxYJjC6GYJJrkEDhkXw9?=
 =?us-ascii?Q?k2G+lzPmdXChlC7DqX/EpFvp/P2y+addav72+rK1cQ2bPqb80C0GgAFRK7Aa?=
 =?us-ascii?Q?N4iTPiqqdvn4QH60dI09x4XKaiTf8yHSpXzX89oV6v4Nm+Ni3OgePe0FSEfH?=
 =?us-ascii?Q?eUPjEQzpJTMje8oP9+fngTcltdwAJ1a7tDerSbtVAVrUsWvq0gCyRVHK/Muk?=
 =?us-ascii?Q?Lk/NmSOvWcWwAkC3R4AXODTIMA2/85LzJ7VtNTZIgK4ZgcAvFjHLTKyEnpw0?=
 =?us-ascii?Q?+3SjY6rM/eivIKOPzgb2JNYRSgIsAox50t3p468xtwsal0TuhxYW7+EDFV+C?=
 =?us-ascii?Q?/Ldy0FxYd+HsWq08I2L3II93J4gtRAJebnKHbeISQOqyL2HYmFybAYDtfMhe?=
 =?us-ascii?Q?m2bR5ys3RbrMesvRdsAWxrMvq/l14Zotnl1JGaCrGVz2rNsgdWLYrNcy/yhR?=
 =?us-ascii?Q?c8KCU1aZoHY9CHY7bWBQxHpPWV1SBI+0BK9Xufsbt3qyjWsTNKmhDV8C/wRu?=
 =?us-ascii?Q?/fVJvg7Ij7v86p7Nq8TPp9dn3ORD0YfxlH1/ePTGMSjvwaDjDRnoKGtai1C9?=
 =?us-ascii?Q?gU9W/xIChokvFE/lUucmsjOp0pVHpt0EmYolVQehIYNsVVNI8VcyyFzCkglc?=
 =?us-ascii?Q?SsTvbY/+hkth0B/4NktUy72Kx263K3q50WzntAaVF+mlRzCioujx8uelYWSO?=
 =?us-ascii?Q?5wJlNduzCEZi+Sl7bEjEVz/0LNbpVYarTJvRLX6dttHdYbDtDcmzY4Sg7EIB?=
 =?us-ascii?Q?3IgqUNzwnY4snGQOc8w7Nqtf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea749cee-c2b9-418d-f4cb-08d977b980c3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 19:54:46.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hz6s5k4pubUBAKDou398O6JTdx4vZzw9itLeu+bi0Ea26kAfO1hbX1zJj2qO8xDz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5362
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 05:33:44PM +0800, Tao Liu wrote:
> rdma_cma_listen_on_all() just destroy listener which lead to an error,
> but not including those already added in listen_list. Then cm state
> fallbacks to RDMA_CM_ADDR_BOUND.
> 
> When user destroys id, the listeners will not be destroyed, and
> process stucks.
> 
>  task:rping state:D stack:   0 pid:19605 ppid: 47036 flags:0x00000084
>  Call Trace:
>   __schedule+0x29a/0x780
>   ? free_unref_page_commit+0x9b/0x110
>   schedule+0x3c/0xa0
>   schedule_timeout+0x215/0x2b0
>   ? __flush_work+0x19e/0x1e0
>   wait_for_completion+0x8d/0xf0
>   _destroy_id+0x144/0x210 [rdma_cm]
>   ucma_close_id+0x2b/0x40 [rdma_ucm]
>   __destroy_id+0x93/0x2c0 [rdma_ucm]
>   ? __xa_erase+0x4a/0xa0
>   ucma_destroy_id+0x9a/0x120 [rdma_ucm]
>   ucma_write+0xb8/0x130 [rdma_ucm]
>   vfs_write+0xb4/0x250
>   ksys_write+0xb5/0xd0
>   ? syscall_trace_enter.isra.19+0x123/0x190
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/cma.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

I'd like to see a bit more than this, I reworked the patch slightly
into this below. It is in for-rc so let me know if it busted up. Thanks

From a17a1faf5d3e2e19a75397dfd740dbde06f054c3 Mon Sep 17 00:00:00 2001
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
lock during error and reorganize how destroy_id works to be directly
sensitive to the listen list not indirectly through the state and some
other random collection of variables.

Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
Link: https://lore.kernel.org/r/20210913093344.17230-1-thomas.liu@ucloud.cn
Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cma.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 86ee3b01b3ee47..be6beee1dd4c5e 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1746,16 +1746,17 @@ static void cma_cancel_route(struct rdma_id_private *id_priv)
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
-	list_del(&id_priv->list);
+	list_del_init(&id_priv->list);
 
 	while (!list_empty(&id_priv->listen_list)) {
 		dev_id_priv = list_entry(id_priv->listen_list.next,
@@ -1768,6 +1769,20 @@ static void cma_cancel_listens(struct rdma_id_private *id_priv)
 		rdma_destroy_id(&dev_id_priv->id);
 		mutex_lock(&lock);
 	}
+}
+
+static void cma_cancel_listens(struct rdma_id_private *id_priv)
+{
+	/*
+	 * During _destroy_id() it is not possible for this value to transition
+	 * from empty to !empty, test it outside to lock to avoid taking a
+	 * global lock on every destroy. Only listen all cases will have
+	 * something to do
+	 */
+	if (list_empty(&id_priv->list))
+		return;
+	mutex_lock(&lock);
+	_cma_cancel_listens(id_priv);
 	mutex_unlock(&lock);
 }
 
@@ -1781,10 +1796,6 @@ static void cma_cancel_operation(struct rdma_id_private *id_priv,
 	case RDMA_CM_ROUTE_QUERY:
 		cma_cancel_route(id_priv);
 		break;
-	case RDMA_CM_LISTEN:
-		if (cma_any_addr(cma_src_addr(id_priv)) && !id_priv->cma_dev)
-			cma_cancel_listens(id_priv);
-		break;
 	default:
 		break;
 	}
@@ -1855,6 +1866,7 @@ static void cma_leave_mc_groups(struct rdma_id_private *id_priv)
 static void _destroy_id(struct rdma_id_private *id_priv,
 			enum rdma_cm_state state)
 {
+	cma_cancel_listens(id_priv);
 	cma_cancel_operation(id_priv, state);
 
 	rdma_restrack_del(&id_priv->res);
@@ -2579,7 +2591,7 @@ static int cma_listen_on_all(struct rdma_id_private *id_priv)
 	return 0;
 
 err_listen:
-	list_del(&id_priv->list);
+	_cma_cancel_listens(id_priv);
 	mutex_unlock(&lock);
 	if (to_destroy)
 		rdma_destroy_id(&to_destroy->id);
-- 
2.33.0

