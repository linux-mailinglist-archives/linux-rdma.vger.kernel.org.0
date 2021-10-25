Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240B8439DA2
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 19:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhJYReR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 13:34:17 -0400
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com ([40.107.92.56]:65143
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231220AbhJYReQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 13:34:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiQuscgSYB3aDQ59P6o6z1zSPkFUb76bSE0Oj3m/f49FmqYUZSPlTTI7/OR+a63i/1AJ0qr548PuBWDdBv59WoPE+GOJNrC2vlPtfJFhZX5VD4KGrYqy9fNK2O0RC6RghRTss3sx/QSZv+Y0yL+TEY8+A/YZDZbbjRtUx5ViI3ZZTGBJptTpFFt3cpXzRXgOrOq3CkXYZ8PcvyoBVxx8qbTw00+edrlCws6deTf4nPvcfKLfZFDhkX+AdJekhnnKH8ajt6SY6djJGBD2rMtxYLaRkIic2kVQpPYxoobPesXYxlaQofWPDillDIsmzrRzJwNfX5X7cJYKLhc3BsYmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8+a7Eivhso5KMRDrQvtzcrO7NEI6jlAUCGEsG355PA=;
 b=auGitxpzugAGHYIcd8yhZc29sW8yI9HOkZzCZpQ6W0QtmPUIQIcmNK2ndMloF4WeW3bzzp3HDlHwD+XzXG2wM6YpOoLCL/FrH3mXvbFXkAH75Iiyc8iUDUQdOBehGco7wVWH7TweRB3yWVbc3NbfmMAwnplOMl/0hvmvpsPs7mE4Kg+I0zu559i7G0tv3hOW54SsI5K/kCwdywgZFKWZVxMMlt/Y6JSvzMbqMfFfrG5AEocUO/quOhFPrCS0F9bfi6tssCbg8fQuTcZhxf5CmSqa3J8dnXVhTPMc8Yu5kjESGU7t8v69YxYiH50jcBo6HMISlkVBgAlFfIMKnHgS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8+a7Eivhso5KMRDrQvtzcrO7NEI6jlAUCGEsG355PA=;
 b=E5ATakx522zaDXMa2zx6cv74Z5EiYFO2zhXEBSgjppiNOIgM8P0KM/mceAa+23jD29xkVD6URAX9/L5HQZMdatEpiU87NqGyvBbZnHC90MNQAAa7WiGjbvgC/n62a0TAXovn6T40w8eyxl8fIOif+nF2mxQTo5SKaU9QI7mxDmklyU/Pf2CsnHZgo6z8uLooFHh9azm9xlYWWx9LvxvR3qbVQYlisoX4wYIhgAI39jFgQCVK51GbdkAuW9gOhJJz0PGJt5q8bXA6uDHShS4nu7u6ein92DynbqmuKjw5oh1IdjuCkiTwB8oP1okkyaZZebyQwN2qoKSXAp2gz3oWZA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5240.namprd12.prod.outlook.com (2603:10b6:208:319::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 17:31:52 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:31:52 +0000
Date:   Mon, 25 Oct 2021 14:31:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, Alaa Hleihel <alaa@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RESEND rdma-rc] RDMA/mlx5: Add dummy umem to IB_MR_TYPE_DM
Message-ID: <20211025173150.GA396793@nvidia.com>
References: <e13b7014857ea296285ee5cfcdaaada9007f6978.1634638695.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13b7014857ea296285ee5cfcdaaada9007f6978.1634638695.git.leonro@nvidia.com>
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 17:31:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf3p8-001feu-AO; Mon, 25 Oct 2021 14:31:50 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b82c73d7-846b-4a76-0917-08d997dd5524
X-MS-TrafficTypeDiagnostic: BL1PR12MB5240:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5240CD416176E0179D23A604C2839@BL1PR12MB5240.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqzP0AbwkSXDnF9CmoZ7qw2O8Xn/iEo8udmxlAa5uPEuem2h69vSrrdoYFj1YUa8A4DwFrG9nBAb03AdW9nU59g0XMf8qWnx8gPz8vviVEhDQNrwl+IhLtwoX/i/J5sCchYtKl/eiC39VRmlPxB3xagYY9GIJGBs70uh105q1GeQuhuZObptLaUCDh8S8bDicPVkFBubqMm3lXrx3cncWSsaCNu34HTg1b+WU3EuUXzfq1DLlIvn6Ex/LeDDVFkW/kfAHxQNNK1bJoSWoIyVaQp3kFaWf/3r8Sy06dnExwNVUNbMDeCDqNe9lubncpBfpVF8SCiRxDzjWhNe8U0Gj4HlzniqdwNYRNRLAcgGFG09j6HO6dt+Ky2YHVbt1/YluEEq210i6QsB7kO+eeN8jx3i/pcq2q0xudKMp8nJX4pHdVEHZ80WuSzT0qyAGW7mZhna+f5jSR1YXeB+7Q/8mFjBMWGcV6Tkhr5RC0t13D05bgLYGsiVcl/aCoDfe5Bj5Q1KfMw08TnVsRmH3qE0elK3YFVheDjypMXQ+lhfnsM0FgBUuTSrRaslEqur3tzk8+VU5H5j6Is475XNtPXXAS9sfjJXlr1LceiGUerrGH2/SF3Op9nny+PtyHyhp02ehX4rEZqnsHzzyffM2U8lz1YWObYqAmUChllDV+Atb7QKVyARYdfTG9P9bLD4r2NVpB13jCbMLn/McTF65dFaS/+TlvpQSxKWCUuY8f1yJQuog+1qhndhbKUBCD1GMbTfqEjSxAG2jRHq3JPKjc79tA9NgDzddEYiTFBtKgIORq4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(1076003)(9786002)(9746002)(66556008)(36756003)(4326008)(66476007)(66946007)(8676002)(54906003)(38100700002)(26005)(186003)(508600001)(86362001)(33656002)(426003)(966005)(8936002)(2616005)(316002)(2906002)(5660300002)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Drpkwej4BNPI4cGVamytcmHdfKCKpbXYz7WWBpTA2qbjYnblcSbSNssy5pMr?=
 =?us-ascii?Q?2aU/VADf+wT1/kQXIK1ytFatQrQffJTLto/I0h9pXUQ4DKvAi4GwFKkj/52H?=
 =?us-ascii?Q?LPq4F5i4JsX+goEQV/waJFcalpmVyFM9DanbYy5VNHqEAQCoiyAk8qyORUms?=
 =?us-ascii?Q?J2uBOqeVN0+wBvQZSKImNYCMU7QuKJjxCsLuSjkPMLeb1uSqL7ZQjLWh3QLi?=
 =?us-ascii?Q?m6Etimgc2xka4ZVMqniT00bI0RV7vbkphyOryoZlM+0mkG7mhCWuJ2c3mjar?=
 =?us-ascii?Q?TJt6tQVWe4rVIswBcBFbZMArYJO4tT84UhXvJuY19mzZiT2aEg8DHdrETg0/?=
 =?us-ascii?Q?thkb1+BdsTEmRjx1FC7zzkFuADx+MzAdo4oIxpXPsOE6PY97pLoY7WkyVZd+?=
 =?us-ascii?Q?QaUPtZWVQZElxOvcFllv3cpSlRNLN0OLbooXZ8kimqwD2YQhsgm9VHmKFynE?=
 =?us-ascii?Q?pZcZL670rM7z4VJUdQZALvrq8mYIjZOM/vxUSXZsv6VuCq1jnV1IVpvFCJTN?=
 =?us-ascii?Q?Exkj9QOLzx9aeu8bn9X7EYGhySH0vnE/7FUFdtV35tMWjHcjKnb/CoN2NZh1?=
 =?us-ascii?Q?gAa2nHBVP/lndDpigLyAhRJb+LDiPR1w8DXSE31p5knVFl/U7WgvKJ49De/i?=
 =?us-ascii?Q?Ukzm8xKXx2Pd5TP3tBK51J/KSJBtxzKRHgjmhkSOmy62iYpikWSDCpWenuLA?=
 =?us-ascii?Q?9bDgkBFXvcn2QxzNAmoVyOjMA4FnpWKyR4YfQ5a1tc2lid879NYjlM3R0a55?=
 =?us-ascii?Q?3AC7/l9GCsBX+oQegCxrCjNyK9byXoN4nVrMd6HLkqUPccwUoY4AzdlPbzFh?=
 =?us-ascii?Q?NYqwKVBQ1Uf0oirwLPzii/fGqheAKlNUMAHQ1NaI/sz4Xba9DaSfYZ19h7dw?=
 =?us-ascii?Q?m43vk+JZDVuvcKC5mFljvWUZeqrRpNbeYoWW378sDNql7coQC/wd7hNHQc3B?=
 =?us-ascii?Q?tbCfCqFjsp5pfxCcCKrnynBBCwnr+scy+d94SApv7dm4EQlO0NMYKq9v9ipk?=
 =?us-ascii?Q?zwAhBRvX3caVo+OhpMnzpmmP0Aub+6pY0yZ7YUgr/fAVwRvssAL1h83fJ1B6?=
 =?us-ascii?Q?ec8XxHiP/2ZD3IJiC7MO6XEWYkyvMfucpcxRq/tUvV9jZ2fqApsuqBa9MbxX?=
 =?us-ascii?Q?r2TCrBtYNvB2OnkfamthMe3jdK8npMLQHEx7TJLZyqgkemSZrjJyKuErO26S?=
 =?us-ascii?Q?jqO6iica3hW6rAR0vaZwkvf0FZyaTBlotztdvP35ftVjbowyOHyYIA6iqmyP?=
 =?us-ascii?Q?5V9uHrcnEN/JKSJo1v5K4WrhHrpEXXYWFUnQfuG+yvQXM6FIoAfdP7gYXbbK?=
 =?us-ascii?Q?+n+rn6WCmzU21/VbwNl1mRj05CT6TfRojtM4ziqlbH9HwyiYzHDeXd095Yqq?=
 =?us-ascii?Q?QKa3vT81kssv1nL8yD00Tmqt5QTnR6xRLuhvudjz7drFq3qA2Vce6WSirPnp?=
 =?us-ascii?Q?6P4n3YvLcCVwMm5K3wLMo8Dg/kJ7IsCkjcJE7bVISnts+9oWWDbg0UG8YDzs?=
 =?us-ascii?Q?3TVD2cQCPSA2RjQE1FOFbkf/lqCw86gO9GT90vh9m/yZKOZnI285vE95T61X?=
 =?us-ascii?Q?cBDRETlX8z3RzMXvXeA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82c73d7-846b-4a76-0917-08d997dd5524
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:31:52.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Z7ErXszkbqXP0/L7crBma33UmyUHDCwBluJ4iaYF3bXxuSsXult7qsTyNRP6p5M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5240
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 01:23:13PM +0300, Leon Romanovsky wrote:
> From: Alaa Hleihel <alaa@nvidia.com>
> 
> After the cited patch, and for the case of IB_MR_TYPE_DM that doesn't
> have a umem (even though it is a user MR), function mlx5_free_priv_descs()
> will think that it's a kernel MR, leading to wrongly accessing mr->descs
> that will get wrong values in the union which leads to attempting to
> release resources that were not allocated in the first place.
> 
> For example:
>  DMA-API: mlx5_core 0000:08:00.1: device driver tries to free DMA memory it has not allocated [device address=0x0000000000000000] [size=0 bytes]
>  WARNING: CPU: 8 PID: 1021 at kernel/dma/debug.c:961 check_unmap+0x54f/0x8b0
>  RIP: 0010:check_unmap+0x54f/0x8b0
>  Call Trace:
>   debug_dma_unmap_page+0x57/0x60
>   mlx5_free_priv_descs+0x57/0x70 [mlx5_ib]
>   mlx5_ib_dereg_mr+0x1fb/0x3d0 [mlx5_ib]
>   ib_dereg_mr_user+0x60/0x140 [ib_core]
>   uverbs_destroy_uobject+0x59/0x210 [ib_uverbs]
>   uobj_destroy+0x3f/0x80 [ib_uverbs]
>   ib_uverbs_cmd_verbs+0x435/0xd10 [ib_uverbs]
>   ? uverbs_finalize_object+0x50/0x50 [ib_uverbs]
>   ? lock_acquire+0xc4/0x2e0
>   ? lock_acquired+0x12/0x380
>   ? lock_acquire+0xc4/0x2e0
>   ? lock_acquire+0xc4/0x2e0
>   ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
>   ? lock_release+0x28a/0x400
>   ib_uverbs_ioctl+0xc0/0x140 [ib_uverbs]
>   ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
>   __x64_sys_ioctl+0x7f/0xb0
>   do_syscall_64+0x38/0x90
> 
> Fix it by adding a dummy umem to IB_MR_TYPE_DM MRs.
> 
> Fixes: f18ec4223117 ("RDMA/mlx5: Use a union inside mlx5_ib_mr")
> Signed-off-by: Alaa Hleihel <alaa@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> RESEND: https://lore.kernel.org/all/9c6478b70dc23cfec3a7bfc345c30ff817e7e799.1631660866.git.leonro@nvidia.com
> 
> Our request to drop that original patch was because mr-->umem pointer is checked
> in rereg flow for the DM MRs with expectation to have NULL there. However DM is
> blocked for the rereg path in the commit 5ccbf63f87a3 ("IB/uverbs: Prevent
> reregistration of DM_MR to regular MR"), and the checks in mlx5_ib are redundant.

That logic in the core code is bogus and should be deleted.

It is perfeclty fine to use rereg to change the access flags on a DM
MR and mlx5 now implements that.

So let's not go down a path that blocks it.

Like this instead:

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e636e954f6bf2a..4a7a56ed740b9b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -664,7 +664,6 @@ struct mlx5_ib_mr {
 
 	/* User MR data */
 	struct mlx5_cache_ent *cache_ent;
-	struct ib_umem *umem;
 
 	/* This is zero'd when the MR is allocated */
 	union {
@@ -676,7 +675,7 @@ struct mlx5_ib_mr {
 			struct list_head list;
 		};
 
-		/* Used only by kernel MRs (umem == NULL) */
+		/* Used only by kernel MRs */
 		struct {
 			void *descs;
 			void *descs_alloc;
@@ -697,8 +696,9 @@ struct mlx5_ib_mr {
 			int data_length;
 		};
 
-		/* Used only by User MRs (umem != NULL) */
+		/* Used only by User MRs */
 		struct {
+			struct ib_umem *umem;
 			unsigned int page_shift;
 			/* Current access_flags */
 			int access_flags;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 221f0949794e35..997d133d00369d 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1904,19 +1904,19 @@ mlx5_alloc_priv_descs(struct ib_device *device,
 	return ret;
 }
 
-static void
-mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
+static void mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 {
-	if (!mr->umem && mr->descs) {
-		struct ib_device *device = mr->ibmr.device;
-		int size = mr->max_descs * mr->desc_size;
-		struct mlx5_ib_dev *dev = to_mdev(device);
+	struct ib_device *device = mr->ibmr.device;
+	int size = mr->max_descs * mr->desc_size;
+	struct mlx5_ib_dev *dev = to_mdev(device);
 
-		dma_unmap_single(&dev->mdev->pdev->dev, mr->desc_map, size,
-				 DMA_TO_DEVICE);
-		kfree(mr->descs_alloc);
-		mr->descs = NULL;
-	}
+	if (!mr->descs)
+		return;
+
+	dma_unmap_single(&dev->mdev->pdev->dev, mr->desc_map, size,
+			 DMA_TO_DEVICE);
+	kfree(mr->descs_alloc);
+	mr->descs = NULL;
 }
 
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
@@ -1978,7 +1978,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 			return rc;
 	}
 
-	if (mr->umem) {
+	if (udata && mr->umem) {
 		bool is_odp = is_odp_mr(mr);
 
 		if (!is_odp)
@@ -1992,7 +1992,8 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (mr->cache_ent) {
 		mlx5_mr_cache_free(dev, mr);
 	} else {
-		mlx5_free_priv_descs(mr);
+		if (!udata)
+			mlx5_free_priv_descs(mr);
 		kfree(mr);
 	}
 	return 0;
@@ -2079,7 +2080,6 @@ static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
 	if (err)
 		goto err_free_in;
 
-	mr->umem = NULL;
 	kfree(in);
 
 	return mr;
@@ -2206,7 +2206,6 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
 	}
 
 	mr->ibmr.device = pd->device;
-	mr->umem = NULL;
 
 	switch (mr_type) {
 	case IB_MR_TYPE_MEM_REG:
