Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C1A2A6FCA
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 22:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKDVlH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 16:41:07 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:12088 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgKDVlH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Nov 2020 16:41:07 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa31ff10000>; Thu, 05 Nov 2020 05:41:05 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 21:41:04 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 4 Nov 2020 21:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihOMovb0EsGwDoiKB3JwlBI8UKScobgBxiaJH3MmrXfZgyyH0HBUy8n7dJ886vwrjMEP4nCE2iqDwmkbxGsoT6gCxsVKN8u20SFkBrlD3jXdwA1R3jUtvqxtXc8V+voZwfUZXbOZuWA91geElkeRCKaDAYwF+lRXz+EIwriB0plpELJ3CZhbwxDQQ5WQnWjkGsBPggP4HgNVmaPiCUCsGM8It5IZ9C5Amro3RLmWlr/6dOtehmNAT+lmdezJ7411Dgmi8rSJ/qPfKr3aDIAsfxuXeqkEp+NaJQIY0mIExQNEInshIOqSKcylFF6dfy10qklQzGKZDDgjGGsk++lsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6QcO8cmKwJRJD0Sbv6eR598p7/FBDeumalDt7XFAic=;
 b=AtuHkNuIRE0OUPg0yuZH9woLaw6sZ3WoNM48HGEV0GeNHHWy5cULBF0RHFdlGisciVYj+G6wnJCH/8fs/7qH0IPyEW0h0hzqQaU1hIt/M2B7vr+txpN+zzlvbJnKGSKIuPbkY9MdCZS2OeGSYiBSYuZ/d74xNDHdtS0G7OqMCastuQRN7MvsrODek/POVHT31qgQlWD5RicQCGimgd3tQIjMShgYWl953prX2zkbR8+hRHCRDeMz8PYtdg7A60Y1+2oxuZlEnWMkcR7WoxNxo9OSgeJ8DzmXUJg2xdIQP/aaYx0KTiq/AfPsIgL+lJzZ2shKTsduPaZRlTbg10XHZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2857.namprd12.prod.outlook.com (2603:10b6:5:184::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Wed, 4 Nov
 2020 21:41:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 21:41:01 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] RDMA/cm: Make the local_id_table xarray non-irq
Date:   Wed, 4 Nov 2020 17:40:59 -0400
Message-ID: <0-v1-808b6da3bd3f+1857-cm_xarray_no_irq_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 21:41:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kaQWZ-00GimS-Sq; Wed, 04 Nov 2020 17:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604526065; bh=Zj6s4TOwMCc7FUvB5J/sgSPsSpu62WYSTnw+sJuWI9Q=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=HAKe0MIBsZ/S+ZxQaaKy08hqx7DRh5Qyl7nndomvUGcPvNUEkiJT6enSaP7U1yjdV
         QzdpKAvAsWlVIubmBVLn7rVBWqedMiu/dqTeHKfEEY/x5iFGHhcMj3elIimcfIm7+E
         zisPPNsZpvJQeKKabPu2MmgdJ14W7rMy8Fup3+KzENDdSrfVjKZpuX2lLKOt6Mo4fK
         rA3K//b7cDvLNn9dXtL7XL/IAwOpyL3SRQ/jqBidX0sbeQQFKlrQbLHSM1hilYyhqo
         kobx4MUqn+A7uvFMTf8JdMAmBG/AS83vGh1sP3rU8tbpio5t7XV/IqnmmOsALGBwfn
         ePpyVgTvm8ftw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The xarray is never mutated from an IRQ handler, only from work queues
under a spinlock_irq. Thus there is no reason for it be an IRQ type
xarray.

This was copied over from the original IDR code, but the recent rework put
the xarray inside another spinlock_irq which will unbalance the unlocking.

Fixes: c206f8bad15d ("RDMA/cm: Make it clearer how concurrency works in cm_=
req_handler()")
Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/cm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 0201364974594f..167e436ae11ded 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -859,8 +859,8 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib=
_device *device,
 	atomic_set(&cm_id_priv->work_count, -1);
 	refcount_set(&cm_id_priv->refcount, 1);
=20
-	ret =3D xa_alloc_cyclic_irq(&cm.local_id_table, &id, NULL, xa_limit_32b,
-				  &cm.local_id_next, GFP_KERNEL);
+	ret =3D xa_alloc_cyclic(&cm.local_id_table, &id, NULL, xa_limit_32b,
+			      &cm.local_id_next, GFP_KERNEL);
 	if (ret < 0)
 		goto error;
 	cm_id_priv->id.local_id =3D (__force __be32)id ^ cm.random_id_operand;
@@ -878,8 +878,8 @@ static struct cm_id_private *cm_alloc_id_priv(struct ib=
_device *device,
  */
 static void cm_finalize_id(struct cm_id_private *cm_id_priv)
 {
-	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
-		     cm_id_priv, GFP_KERNEL);
+	xa_store(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
+		 cm_id_priv, GFP_ATOMIC);
 }
=20
 struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
@@ -1169,7 +1169,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int=
 err)
 	spin_unlock(&cm.lock);
 	spin_unlock_irq(&cm_id_priv->lock);
=20
-	xa_erase_irq(&cm.local_id_table, cm_local_id(cm_id->local_id));
+	xa_erase(&cm.local_id_table, cm_local_id(cm_id->local_id));
 	cm_deref_id(cm_id_priv);
 	wait_for_completion(&cm_id_priv->comp);
 	while ((work =3D cm_dequeue_work(cm_id_priv)) !=3D NULL)
@@ -4482,7 +4482,7 @@ static int __init ib_cm_init(void)
 	cm.remote_id_table =3D RB_ROOT;
 	cm.remote_qp_table =3D RB_ROOT;
 	cm.remote_sidr_table =3D RB_ROOT;
-	xa_init_flags(&cm.local_id_table, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
+	xa_init_flags(&cm.local_id_table, XA_FLAGS_ALLOC);
 	get_random_bytes(&cm.random_id_operand, sizeof cm.random_id_operand);
 	INIT_LIST_HEAD(&cm.timewait_list);
=20
--=20
2.28.0

