Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0CA368274
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Apr 2021 16:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbhDVOaS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Apr 2021 10:30:18 -0400
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:56672
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236396AbhDVOaR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Apr 2021 10:30:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZe+0N4Q2OzSGldUi4bilCPhoMK7ymJFB7OEaSgmmmvbRY2gi/iEBJu/4etoZ4wmzcfbMJvi9z6nuxNJLPV33ogL5gtDCKn4P2JlVGzk8RZo3VmpZwfkYp+rcTCRNC40XmjFWjMCbz4wQYrpObiLtGoBIrdTLAjcGHXobu5ACNLWRELA5UgG+HlrXZAAdMoQ6i8QZoxoMhXXHo9Nc5fMcUpMes5cUfnKman42+j6XIFpNfAaFmuU6BTDqcbUd284CnKb97zAp+eKR3C2Yxr7S8QV1Jic46W6RjuVVOh28Z69MtmVXlCqcUqN9nbIha5tCEifQkIaRy0GisQEuFdGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9ZVameWPrd5vYGZCKpCTVDKoR/IUulZpPIMjAy+plQ=;
 b=gIiBJ7iE+J1gzi9z9r7XkpN4omMmRI3KnmjTclS24wmLPyxgA3k3TSixx6owsyJWCi3UblKe1cg6rLLGccVFRzsmuX4D0iRJpPcqs3/NksZxWTS3Ry83T3LZJWfq8AdcpUK2Q/TSSVtUntZE/MWapGt8dsDBFLhnMz5S+AuR+9bPW62FXTbeQ7Qom8rPZ4kEEYsaZmxuEpbKhlL/geSRfVA8VpYK/j+7QPTefmQdUU1kDt68zTogAvtn8wFFkvfdHte/J6Z0WP/rzoHPcxA0INNbBvQUbTueu1xyP6mCGZyYmfhobiHbKSnMZ/A+wSKhpOIwdmaLys1lVJBn4q+BrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9ZVameWPrd5vYGZCKpCTVDKoR/IUulZpPIMjAy+plQ=;
 b=rxQbZGb7qavIji8Y/B5v3eY8CyUpz9GqEKoahwmGAoA47m56Wlo2DYsom55PT9UJWX23f0FS8RQ8qdQPFHH0WCo9Svp8P7yC2n5lw2lKokqvmY/g6I9Q86QNcaK1mjpMmjU2/wvKeh8J5nK30G4wu9/5mptF2Cz/ebvVHUMNTb7LGbXei5MWL7fnwpK13P+lzWog5fgehoZC6wVHRmNCGC5SobfXtsfokN8XjEmxjEx5SN6voxk9XfQzhOf8SS6VbXLvVXBp5k/dmbvUgZnxekXgi83ZAz8toCwmUxr894oZymAiuWNOw5jGimaY/PMZDLGTZCTkRKkGsrXYmbWr3w==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 14:29:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 14:29:41 +0000
Date:   Thu, 22 Apr 2021 11:29:39 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <20210422142939.GA2407382@nvidia.com>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
 <YH+yGj3cLuA5ga8s@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH+yGj3cLuA5ga8s@unreal>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0125.namprd03.prod.outlook.com (2603:10b6:208:32e::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 14:29:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZaKp-00A8v7-Hu; Thu, 22 Apr 2021 11:29:39 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ebb6b17-bc50-4948-fe4e-08d9059b1128
X-MS-TrafficTypeDiagnostic: DM6PR12MB4497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4497E985BEA907D9CF5DE4F8C2469@DM6PR12MB4497.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsKWP30FnPkGuNfHQK3FZLNGdHMAnzDmTZ4pkNR1/m5vw5OsV3r7IrNLwR6YFK5PYc4/6INtONSBhvKxsXR6myORPOBvsOcz365YZAs4WHgDJVksF2liLRWfXq9qHyfPe4rcNvSfgh3zl0gNhKaar+hGHHtru2lGcVQXavukCbPUMMDchJ4Pl5fSANtDidoW9fCqaLFCSOKXn/wwVFBLWs5VIls5RDXCaURaDnBoRvVWl2DW3HhmvS0rlhxbQIVj4lg6yhsWVLd+YxL01vXcyU0NxXmrl3gWuE1FNg9alY5BjeUQ6SGaUGC7TEfr0Myq3SUuGdBMog23RiyjM/MNA22DF5mh4n65u7GbggPj8m1TXCfx2wHWD0fGK8uGJkkD0z8XF0FkZopfMSfIFXPR3G5rVMYZRwQ3OcP8bCGKR46xgLWtic8wR/CsJzWTinULbDcpYNzh82iuVoMHpBLlO8Eg2rj2XLPTngfmygoJ2Sd08x4zn2MOHFo5fjMuqzXGCJI3olOBIo66JkZTxmdoZodkS4XihhcRwWTPoguRW4iSb62Kp4IQyiDD9Pa428OMxrgcyMj1v/9l/EUCm2NFuCv/xCcYyeZf3gg8oyR2mSg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(26005)(33656002)(86362001)(66556008)(9786002)(1076003)(186003)(2906002)(5660300002)(4326008)(426003)(9746002)(8936002)(38100700002)(478600001)(36756003)(66946007)(83380400001)(8676002)(66476007)(54906003)(6916009)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KZxU2Lt717I7NzPgz8OPeNUjUJph0UJaB9ogMgFQpWfwfLYfcmDNKxJKQ5dw?=
 =?us-ascii?Q?QwJLTeT3vVCE8FrsCA2TW7uiq6Lf4uO2LPU4+YH3dziw9mz30KiWr2DNyNHa?=
 =?us-ascii?Q?dL+Cc8o+F2b4K/U2J1JvMFdLzJQ027aC/CRU2uIZrB/rnzwJbXtvPzYxLaF+?=
 =?us-ascii?Q?SIriJGK4WLuNgR101fcgf3MJCVLYkYj4BG57+n9RSnx/JYXA4tVCoGv4ryLx?=
 =?us-ascii?Q?AvJ89OCmpNirQh1YHarLDgIAKGjwoelwIVp2POvsxws57Zpv2ZQhlaglY9JR?=
 =?us-ascii?Q?ccqQvtfz+sjbPJhXdLRjCrrzklXi8WvnAO0sq+YLyE0ryBwVRHtMhemB5NR2?=
 =?us-ascii?Q?XtCNGjGdtcf4xSjbshx+cCMiB7hOzWGd//qQIg0vnYdcVB6qnySUcf3UET/j?=
 =?us-ascii?Q?o/ii+cx+vzG6QF/wyskzIIWm5eMz9nykLEJEEWSdpUjRABHhbtfk65/ThKDI?=
 =?us-ascii?Q?pSINyohQtMzpY+CntNbPbNV2OTP9ZkLcioIJzqi9QpLHHXbWnPBsZmO7sonG?=
 =?us-ascii?Q?xs/1gWOpbxEwvoXansLlAunNzHURyKvpOzeLsLvmKXhIKQq98fTrkQreqjee?=
 =?us-ascii?Q?ZZcJthPHMIsOAkYhaQKmnBo6//eEp4QR2MnjcvRuq1FkSPGlh6bEjBj8JMV+?=
 =?us-ascii?Q?X0WjKDz+d4T62HAf2EdxqwlSEccumH0h2u4P3Fqk9A0jx3fllP3wevDFYfj+?=
 =?us-ascii?Q?7xlTxtOsVvqs9jBHzuJPyisWxVJUq0wU4y7BsDAKlVkKSG+vdDr3cKbdOCYC?=
 =?us-ascii?Q?+3FJ7pdE3yC6hJsWqAn21OyzrVvZ+mfiebfbsPdBN/UZJoffK/KjgT2KqLyv?=
 =?us-ascii?Q?u+XQzxcHyJPCBbqtteqcdtaFs8FTS8wCDoe/IaK68nWOTc4Zk+GQ4xihhi2j?=
 =?us-ascii?Q?zbZec/7N9HnGAVWZ8a2/kWOhNsx6gDus6+jIRyQKUJc5exBg6z8hpzi4LOgS?=
 =?us-ascii?Q?7GpaR+30lmCK5+DID7dcByOs/yKEDGydorngi16tptDNaWpYrFlEvK22cWeR?=
 =?us-ascii?Q?o/Z/ts2RYoexH6CLxg55i0AGrJTwrreoVelqwuwULPmyn1+mNzQrR9mnkM//?=
 =?us-ascii?Q?epmQZsQYtloNGV+r1tt7NbyU8oQSXxbhOrzE7AZN2RNgxaTtXZFigHBYa/pv?=
 =?us-ascii?Q?CIeRNowJo3ka69kNxgjE1AUDE6dPEdSY4lW8pGafC8sx1G2PF21DOYas8tKp?=
 =?us-ascii?Q?Z8PYlrM9GpI7FRmekh0cRl/PNVuqPxzL1p11yjbYix2qEMd0DuOvDs86B0Oj?=
 =?us-ascii?Q?pKz/TW5RGXOHbUwKRwEIhosXgB0+rnQnJUniUZg7UQreBRZejNAZYS7bpb82?=
 =?us-ascii?Q?AHf9hmZ9vYkk6kmKcEBGWLgT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebb6b17-bc50-4948-fe4e-08d9059b1128
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 14:29:41.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K4I+T0Y+3esEUKZIgp2rVbPdafeb/0YkPLE66yrBeKVCUorfCd5HVMGlpsPzA+wb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 21, 2021 at 08:03:22AM +0300, Leon Romanovsky wrote:

> I didn't understand when reviewed either, but decided to post it anyway
> to get possible explanation for this RDMA_RESTRACK_MR || RDMA_RESTRACK_QP
> check.

I think the whole thing should look more like this and we delete the
if entirely.

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 2b9ffc21cbc4ad..479b16b8f6723a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1860,6 +1860,7 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 				iw_destroy_cm_id(id_priv->cm_id.iw);
 		}
 		cma_leave_mc_groups(id_priv);
+		rdma_restrack_del(&id_priv->res);
 		cma_release_dev(id_priv);
 	}
 
@@ -1873,7 +1874,6 @@ static void _destroy_id(struct rdma_id_private *id_priv,
 	kfree(id_priv->id.route.path_rec);
 
 	put_net(id_priv->id.route.addr.dev_addr.net);
-	rdma_restrack_del(&id_priv->res);
 	kfree(id_priv);
 }
 
diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 15493357cfef09..1808bc2533f155 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -176,6 +176,8 @@ static void rdma_counter_free(struct rdma_counter *counter)
 {
 	struct rdma_port_counter *port_counter;
 
+	rdma_restrack_del(&counter->res);
+
 	port_counter = &counter->device->port_data[counter->port].port_counter;
 	mutex_lock(&port_counter->lock);
 	port_counter->num_counters--;
@@ -185,7 +187,6 @@ static void rdma_counter_free(struct rdma_counter *counter)
 
 	mutex_unlock(&port_counter->lock);
 
-	rdma_restrack_del(&counter->res);
 	kfree(counter->stats);
 	kfree(counter);
 }
diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index 433b426729d4ce..3884db637d33ab 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -339,11 +339,15 @@ void ib_free_cq(struct ib_cq *cq)
 		WARN_ON_ONCE(1);
 	}
 
+	rdma_restrack_prepare_del(&cq->res);
 	rdma_dim_destroy(cq);
 	trace_cq_free(cq);
 	ret = cq->device->ops.destroy_cq(cq, NULL);
-	WARN_ONCE(ret, "Destroy of kernel CQ shouldn't fail");
-	rdma_restrack_del(&cq->res);
+	if (WARN_ON(ret)) {
+		rdma_restrack_abort_del(&cq->res);
+		return;
+	}
+	rdma_restrack_finish_del(&cq->res);
 	kfree(cq->wc);
 	kfree(cq);
 }
diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
index 94d83b665a2fe0..f57234ced93ca1 100644
--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -854,6 +854,8 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
 	struct ib_ucontext *ucontext = ufile->ucontext;
 	struct ib_device *ib_dev = ucontext->device;
 
+	rdma_restrack_prepare_del(&ucontext->res);
+
 	/*
 	 * If we are closing the FD then the user mmap VMAs must have
 	 * already been destroyed as they hold on to the filep, otherwise
@@ -868,9 +870,8 @@ static void ufile_destroy_ucontext(struct ib_uverbs_file *ufile,
 	ib_rdmacg_uncharge(&ucontext->cg_obj, ib_dev,
 			   RDMACG_RESOURCE_HCA_HANDLE);
 
-	rdma_restrack_del(&ucontext->res);
-
 	ib_dev->ops.dealloc_ucontext(ucontext);
+	rdma_restrack_finish_del(&ucontext->res);
 	WARN_ON(!xa_empty(&ucontext->mmap_xa));
 	kfree(ucontext);
 
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index 033207882c82ce..8aa1dae40f38a7 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -315,11 +315,49 @@ int rdma_restrack_put(struct rdma_restrack_entry *res)
 }
 EXPORT_SYMBOL(rdma_restrack_put);
 
-/**
- * rdma_restrack_del() - delete object from the reource tracking database
- * @res:  resource entry
- */
-void rdma_restrack_del(struct rdma_restrack_entry *res)
+void rdma_restrack_prepare_del(struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_entry *old;
+	struct rdma_restrack_root *rt;
+	struct ib_device *dev;
+
+	if (!res->valid)
+		return;
+
+	dev = res_to_dev(res);
+	rt = &dev->res[res->type];
+
+	if (!res->no_track) {
+		old = xa_cmpxchg(&rt->xa, res->id, res, XA_ZERO_ENTRY,
+				 GFP_KERNEL);
+		WARN_ON(old != res);
+	}
+
+	/* Fence access from all concurrent threads, like netlink */
+	rdma_restrack_put(res);
+	wait_for_completion(&res->comp);
+}
+EXPORT_SYMBOL(rdma_restrack_prepare_del);
+
+void rdma_restrack_abort_del(struct rdma_restrack_entry *res)
+{
+	struct rdma_restrack_entry *old;
+	struct rdma_restrack_root *rt;
+	struct ib_device *dev;
+
+	if (!res->valid || res->no_track)
+		return;
+
+	dev = res_to_dev(res);
+	rt = &dev->res[res->type];
+
+	kref_init(&res->kref);
+	old = xa_cmpxchg(&rt->xa, res->id, XA_ZERO_ENTRY, res, GFP_KERNEL);
+	WARN_ON(old != res);
+}
+EXPORT_SYMBOL(rdma_restrack_abort_del);
+
+void rdma_restrack_finish_del(struct rdma_restrack_entry *res)
 {
 	struct rdma_restrack_entry *old;
 	struct rdma_restrack_root *rt;
@@ -332,24 +370,22 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
 		}
 		return;
 	}
-
-	if (res->no_track)
-		goto out;
+	res->valid = false;
 
 	dev = res_to_dev(res);
-	if (WARN_ON(!dev))
-		return;
-
 	rt = &dev->res[res->type];
-
 	old = xa_erase(&rt->xa, res->id);
-	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
-		return;
-	WARN_ON(old != res);
+	WARN_ON(old != NULL);
+}
+EXPORT_SYMBOL(rdma_restrack_finish_del);
 
-out:
-	res->valid = false;
-	rdma_restrack_put(res);
-	wait_for_completion(&res->comp);
+/**
+ * rdma_restrack_del() - delete object from the reource tracking database
+ * @res:  resource entry
+ */
+void rdma_restrack_del(struct rdma_restrack_entry *res)
+{
+	rdma_restrack_prepare_del(res);
+	rdma_restrack_finish_del(res);
 }
 EXPORT_SYMBOL(rdma_restrack_del);
diff --git a/drivers/infiniband/core/restrack.h b/drivers/infiniband/core/restrack.h
index 6a04fc41f73801..87a670334acabe 100644
--- a/drivers/infiniband/core/restrack.h
+++ b/drivers/infiniband/core/restrack.h
@@ -27,6 +27,9 @@ int rdma_restrack_init(struct ib_device *dev);
 void rdma_restrack_clean(struct ib_device *dev);
 void rdma_restrack_add(struct rdma_restrack_entry *res);
 void rdma_restrack_del(struct rdma_restrack_entry *res);
+void rdma_restrack_prepare_del(struct rdma_restrack_entry *res);
+void rdma_restrack_finish_del(struct rdma_restrack_entry *res);
+void rdma_restrack_abort_del(struct rdma_restrack_entry *res);
 void rdma_restrack_new(struct rdma_restrack_entry *res,
 		       enum rdma_restrack_type type);
 void rdma_restrack_set_name(struct rdma_restrack_entry *res,
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 2b0798151fb753..2e761a7eb92847 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -346,13 +346,16 @@ int ib_dealloc_pd_user(struct ib_pd *pd, struct ib_udata *udata)
 	 */
 	WARN_ON(atomic_read(&pd->usecnt));
 
+	rdma_restrack_prepare_del(&pd->res);
 	ret = pd->device->ops.dealloc_pd(pd, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&pd->res);
 		return ret;
+	}
 
-	rdma_restrack_del(&pd->res);
+	rdma_restrack_finish_del(&pd->res);
 	kfree(pd);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(ib_dealloc_pd_user);
 
@@ -1085,19 +1088,22 @@ int ib_destroy_srq_user(struct ib_srq *srq, struct ib_udata *udata)
 	if (atomic_read(&srq->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_prepare_del(&srq->res);
 	ret = srq->device->ops.destroy_srq(srq, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&srq->res);
 		return ret;
+	}
+	rdma_restrack_finish_del(&srq->res);
 
 	atomic_dec(&srq->pd->usecnt);
 	if (srq->srq_type == IB_SRQT_XRC)
 		atomic_dec(&srq->ext.xrc.xrcd->usecnt);
 	if (ib_srq_has_cq(srq->srq_type))
 		atomic_dec(&srq->ext.cq->usecnt);
-	rdma_restrack_del(&srq->res);
 	kfree(srq);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(ib_destroy_srq_user);
 
@@ -1963,31 +1969,33 @@ int ib_destroy_qp_user(struct ib_qp *qp, struct ib_udata *udata)
 		rdma_rw_cleanup_mrs(qp);
 
 	rdma_counter_unbind_qp(qp, true);
-	rdma_restrack_del(&qp->res);
+	rdma_restrack_prepare_del(&qp->res);
 	ret = qp->device->ops.destroy_qp(qp, udata);
-	if (!ret) {
-		if (alt_path_sgid_attr)
-			rdma_put_gid_attr(alt_path_sgid_attr);
-		if (av_sgid_attr)
-			rdma_put_gid_attr(av_sgid_attr);
-		if (pd)
-			atomic_dec(&pd->usecnt);
-		if (scq)
-			atomic_dec(&scq->usecnt);
-		if (rcq)
-			atomic_dec(&rcq->usecnt);
-		if (srq)
-			atomic_dec(&srq->usecnt);
-		if (ind_tbl)
-			atomic_dec(&ind_tbl->usecnt);
-		if (sec)
-			ib_destroy_qp_security_end(sec);
-	} else {
+	if (ret) {
+		rdma_restrack_abort_del(&qp->res);
 		if (sec)
 			ib_destroy_qp_security_abort(sec);
+		return ret;
 	}
 
-	return ret;
+	rdma_restrack_finish_del(&qp->res);
+	if (alt_path_sgid_attr)
+		rdma_put_gid_attr(alt_path_sgid_attr);
+	if (av_sgid_attr)
+		rdma_put_gid_attr(av_sgid_attr);
+	if (pd)
+		atomic_dec(&pd->usecnt);
+	if (scq)
+		atomic_dec(&scq->usecnt);
+	if (rcq)
+		atomic_dec(&rcq->usecnt);
+	if (srq)
+		atomic_dec(&srq->usecnt);
+	if (ind_tbl)
+		atomic_dec(&ind_tbl->usecnt);
+	if (sec)
+		ib_destroy_qp_security_end(sec);
+	return 0;
 }
 EXPORT_SYMBOL(ib_destroy_qp_user);
 
@@ -2050,13 +2058,16 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata)
 	if (atomic_read(&cq->usecnt))
 		return -EBUSY;
 
+	rdma_restrack_prepare_del(&cq->res);
 	ret = cq->device->ops.destroy_cq(cq, udata);
-	if (ret)
+	if (ret) {
+		rdma_restrack_abort_del(&cq->res);
 		return ret;
+	}
 
-	rdma_restrack_del(&cq->res);
+	rdma_restrack_finish_del(&cq->res);
 	kfree(cq);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL(ib_destroy_cq_user);
 
@@ -2126,16 +2137,19 @@ int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
 	int ret;
 
 	trace_mr_dereg(mr);
-	rdma_restrack_del(&mr->res);
+	rdma_restrack_prepare_del(&mr->res);
 	ret = mr->device->ops.dereg_mr(mr, udata);
-	if (!ret) {
-		atomic_dec(&pd->usecnt);
-		if (dm)
-			atomic_dec(&dm->usecnt);
-		kfree(sig_attrs);
+	if (ret) {
+		rdma_restrack_abort_del(&mr->res);
+		return ret;
 	}
 
-	return ret;
+	rdma_restrack_finish_del(&mr->res);
+	atomic_dec(&pd->usecnt);
+	if (dm)
+		atomic_dec(&dm->usecnt);
+	kfree(sig_attrs);
+	return 0;
 }
 EXPORT_SYMBOL(ib_dereg_mr_user);
 
