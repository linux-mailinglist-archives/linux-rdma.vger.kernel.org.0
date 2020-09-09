Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25381263591
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 20:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgIISGq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 14:06:46 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4770 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIISGm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 14:06:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5919980000>; Wed, 09 Sep 2020 11:06:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 11:06:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 09 Sep 2020 11:06:29 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 18:06:11 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 18:06:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goth0M67/ompWU6FZw5fCsnMbQIqzrPIE2g+30S+5E0h/vx5CKeQ8EMUaoYITPItUsUMm5RpDQnQtv/YjNT8EPKOQSXwTSmOcG7GE9lF5Iwa2saAnbTarzAGZGduIZGWRMD6GKXiOwCuPW6TLPO3R2ubIfmRR8H/GO2vbTKhXVSP4yCx+DHzS25+Fi8/qALUhKKqS1xwmUvL/b44mWitvGhLaxDprVXUCpy2bDjh1MGbOnyA2CHEEGtqscNjXB9YQLIhdkLgio89UqTA5zoRUG6KkiDBUI+q4LCXlhF2nyRyJGX/IEjRYVJDYKJu192v20mSgnCRG2edkPLoBSc0BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+xMi+Lwn5djf+38tmi+p3fEwjfJp8TkN6f2A3gn0pU=;
 b=aKt1YKdssP8yMSoRCSC7Nye18Vvj0DGZqW2sYBgCjeWqs5H6d0isllbLVafdDFZWqWIJ4gUPJWeDxbDrca55VSKNL48TX4SRNfr1SewwnWAk6CsbxY9pDmf/0YDYsryQZabcAsPQT+8w3uSm5cKL0sHudRLpQYwfSMNNPBiFhDLnb7svIETXRaFXDDJhOrP0peQ+WEN8hLMXpThqvHWHGkoZa0ZTGykzCEQOnbzpIzaptNN88CcL4yJ2fgunkXpubcPrPg6pwii69kTCAUsMVDEbYvmsYC+RMb9Y/r1OAh/8yXtvj6pIRs6udyGOy6Obvz7PAp2ojAys7MIaJtomkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 18:06:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 18:06:09 +0000
Date:   Wed, 9 Sep 2020 15:06:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        "Gal Pressman" <galpress@amazon.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v2 0/9] Restore failure of destroy commands
Message-ID: <20200909180607.GA916941@nvidia.com>
References: <20200907120921.476363-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907120921.476363-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:208:239::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0004.namprd08.prod.outlook.com (2603:10b6:208:239::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 18:06:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kG4Tv-003r6c-EF; Wed, 09 Sep 2020 15:06:07 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e317b18-c812-4536-645d-08d854eb0789
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44512EA92CCB69F57D515FEAC2260@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ix8Z31UQkpRZ0Rry3chC0/0z4qtOws0joqGawI8jAFtDitX1PNdwhNO6cA59w7TpSSA8cBNgQEZ/TeiNsa7+PjUiKTuTpkbgu2j2o8pCUxi9UFufJO9m1mkNaPacbVflkTbwUuGQYIi+OoU+xa02j0q0ocVo4XWbPO+F9YmJ2zSKij93DFxoN/QJVfaX4SRdJAasXhc92e3KjSdPuMAZEfiq/1PT22X/ZJU97kAMdPlViXQjcQHvMkwP6WjC2xkzt4N+8lTqbimC/6CmgQwSC4I7EXEBydEaBlddeBCPnKCyFUT2czrvj/r+/K4jTG2t5smFHvB9myRYe7FJjW6QGw/TLQ0+SkdIjmp2h9/uoOiAbl4GXZ9NR3MMdazQbVE0XR0jari8GX1oum1Dgww9YyVjr9o+nBcGPsjsD6GfdYY110StHoNULpETC6l6WgtIoRBn9L5sySc5UDMlI6mGbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(1076003)(5660300002)(66476007)(66556008)(36756003)(66946007)(54906003)(426003)(2616005)(186003)(8936002)(8676002)(478600001)(2906002)(6916009)(86362001)(26005)(107886003)(83380400001)(33656002)(316002)(9786002)(966005)(7416002)(4326008)(9746002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MNgT5rEuxaycuQGkr+jc95MPXSOmtckgIIvIaMJTTCADDv1JMpWW6f9p8E40hkv8rjdR0InT9eJd67rWXCJKZm/KrBNrStQxhgPxJ7FmrFXeeUFooZiwMrpWKgwaazM4yoxOAXOQ0L58/VxNfTmZOnUAFhR9MSktx91tP1upMXY7ZsibuzBu3r01cxnYoU6QCd4BwRoaPfNDx5SS65wY0w2DWNzbTMrlJuuZ9wr/tK+gidv7Jy6DQgzyPCVy1slSd2/SloZeEORNgsrWTtKotF5gnkcVcI8tAI5jKY31Hbi71M7uuXud6F75gq1WhzZSLSfJwjIVoJPfbghHltblrsoOm2Jlj4QfmiFqUXjgF4wu7KG6kkYUEeSDOaB+Eg5mVLUFUQcvtzsXcFeX6iW4HPMK9WE5ZxNDni8361MmLmQdLt3jFAh5q0j+vHi4fOZ5rC7CnLQVxCPJUZMO53d1i1+BgkzCbjUEsmsPFz5y2h8xChfkauS2y/Lgy0RJ6zE6LDrNydjrqAvPmlr7sclqDVIb0ooCuG2DbV+LRJzfW+pHFSAZU7Ho8BF7PWyadu1JCrwnty+QzeBq9TTiJuUDjU6D16hKsqOJV9wEWrQlEU3VkcxSW9Ff6GU37oqiWQTKFUKtRQwc3mP9GWYPkmKBbg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e317b18-c812-4536-645d-08d854eb0789
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 18:06:09.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTj64H8JWIHZF+xv4Oy0PeBMgXX1aFzqyDRUJzwMUb1HK4+/aK/JYOO0znvChKe5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599674776; bh=W+xMi+Lwn5djf+38tmi+p3fEwjfJp8TkN6f2A3gn0pU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=PHvaiVZ2EEps3awGplJX+OAHr1VaovFRFyWFl6VzTHxC+ro9jpuz5WyVX0qSxgr3j
         iVVMm3lDPJ1WZvz5l2ckePCsOReBnO8VIo1P2KViFMQoxLtN9R+qwowh5PdLazGITq
         4Kwo9jnh82N8c8D3iNeZulV9ztTQKrwHIBdVgXlLxaWhoz3FG5iu6tvRBpVx/BBNLW
         lH9uU/rq37NvWR2eJTQfTV2erQte5YVhcxQwRoL3pYLUN//NvzV9Vm1dxqE4OG20KG
         6DJxITRSnzc2IXFy+N2Mt+GxqMxs5itECcaLpowKvU1+aswRittSV4iKZXRFSJ1PKY
         lznKUqktEgChw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:09:12PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Changelog:
> v2:
>  * Rebased on top of the 524d8ffd07f0
>  * Removed "udata" check in destroy flows
>  * Changed ib_free_cq to return early
>  * Used Jason's suggestion to implement "RDMA/mlx5: Issue FW command to destroy
>    SRQ on reentry" patch.
> v1
>  * Changed returned value in efa_destroy_ah() from EINVAL to EOPNOTSUPP
>  * https://lore.kernel.org/lkml/20200830084010.102381-1-leon@kernel.org
> v0:
>  * https://lore.kernel.org/lkml/20200824103247.1088464-1-leon@kernel.org
> 
> Hi,
> 
> This series restores the ability to fail on destroy commands, due to the
> fact that mlx5_ib DEVX implementation interleaved ib_core objects
> with FW objects without sharing reference counters.
> 
> In retrospect, every part of the mlx5_ib flow is correct.
> 
> It started from IBTA which was written by HW engineers with HW in mind and
> they allowed to fail in destruction. FW implemented it with symmetrical
> interface like any other command and propagated error back to the kernel,
> which forwarded it to the libibverbs and kernel ULPs.
> 
> Libibverbs was designed with IBTA spec in hand putting destroy errors in
> stone. Up till mlx5_ib DEVX, it worked well, because the IB verbs objects
> are counted by the kernel and ib_core ensures that FW destroy will success
> by managing various reference counters on such objects.
> 
> The extension of the mlx5 driver changed this flow when allowed DEVX objects
> that are not managed by ib_core to be interleaved with the ones under ib_core
> responsibility.
> 
> The drivers that want to implement DEVX flows must ensure that FW/HW
> destroys are performed as early as possible before any other internal
> cleanup. After HW destroys, drivers are not allowed to fail.
> 
> This series includes two patches (WQ and "potential race") that will
> require extra work in mlx5_ib, they both theoretical. WQ is not in use
> in DEVX, but is needed to make interface symmetrical to other objects.
> "Potential race" is in ULP flow that ensures that SRQ is destroyed in
> proper order.
> 
> Thanks
> 
> Leon Romanovsky (9):
>   RDMA: Restore ability to fail on PD deallocate
>   RDMA: Restore ability to fail on AH destroy
>   RDMA/mlx5: Issue FW command to destroy SRQ on reentry
>   RDMA: Restore ability to fail on SRQ destroy
>   RDMA/core: Delete function indirection for alloc/free kernel CQ
>   RDMA: Allow fail of destroy CQ
>   RDMA: Change XRCD destroy return value
>   RDMA: Restore ability to return error for destroy WQ
>   RDMA: Make counters destroy symmetrical

Thanks, applied to for-next with the changes I noted:

diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index b2381e01bf6345..35e5bbb44d3d8e 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -1031,15 +1031,14 @@ int mlx5_ib_destroy_cq(struct ib_cq *cq, struct ib_udata *udata)
 	int ret;
 
 	ret = mlx5_core_destroy_cq(dev->mdev, &mcq->mcq);
-	if (ret && udata)
+	if (ret)
 		return ret;
 
-	if (udata) {
+	if (udata)
 		destroy_cq_user(mcq, udata);
-		return 0;
-	}
-	destroy_cq_kernel(dev, mcq);
-	return ret;
+	else
+		destroy_cq_kernel(dev, mcq);
+	return 0;
 }
 
 static int is_equal_rsn(struct mlx5_cqe64 *cqe64, u32 rsn)
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 039f55fd067640..6dfdc13bc36395 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5092,11 +5092,11 @@ int mlx5_ib_destroy_wq(struct ib_wq *wq, struct ib_udata *udata)
 	int ret;
 
 	ret = mlx5_core_destroy_rq_tracked(dev, &rwq->core_qp);
-	if (ret && udata)
+	if (ret)
 		return ret;
 	destroy_user_rq(dev, wq->pd, rwq, udata);
 	kfree(rwq);
-	return ret;
+	return 0;
 }
 
 struct ib_rwq_ind_table *mlx5_ib_create_rwq_ind_table(struct ib_device *device,
diff --git a/drivers/infiniband/hw/mlx5/srq.c b/drivers/infiniband/hw/mlx5/srq.c
index 6789b8a6927467..e2f720eec1e18b 100644
--- a/drivers/infiniband/hw/mlx5/srq.c
+++ b/drivers/infiniband/hw/mlx5/srq.c
@@ -396,17 +396,14 @@ int mlx5_ib_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 	int ret;
 
 	ret = mlx5_cmd_destroy_srq(dev, &msrq->msrq);
-	if (ret && udata)
+	if (ret)
 		return ret;
 
-	if (udata) {
+	if (udata)
 		destroy_srq_user(srq->pd, msrq, udata);
-		return 0;
-	}
-
-	/* We are cleaning kernel resources anyway */
-	destroy_srq_kernel(dev, msrq);
-	return ret;
+	else
+		destroy_srq_kernel(dev, msrq);
+	return 0;
 }
 
 void mlx5_ib_free_srq_wqe(struct mlx5_ib_srq *srq, int wqe_index)
diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
index 1a707c2d364c1f..db889ec3fd48e8 100644
--- a/drivers/infiniband/hw/mlx5/srq_cmd.c
+++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
@@ -598,7 +598,7 @@ int mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
 
 	/* Delete entry, but leave index occupied */
 	tmp = xa_cmpxchg_irq(&table->array, srq->srqn, srq, XA_ZERO_ENTRY, 0);
-	if (WARN_ON(!tmp || tmp != srq) || xa_err(tmp))
+	if (WARN_ON(tmp != srq))
 		return xa_err(tmp) ?: -EINVAL;
 
 	err = destroy_srq_split(dev, srq);


Jason
