Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE0525A25F
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIBAn6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:43:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4716 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgIBAnu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eeab80001>; Tue, 01 Sep 2020 17:43:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:50 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:49 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQx4p0FXrKLHpsNfBJcEyPD9rWVisSE/rMTHOV847omWIygO5TN2DFdDOVDyDk53RpEpN5erOwbQNNk6djKw7zX0aU98Wusg/O53d6hMlM16YF0T0kX5HfGK0o4nDPR7uKikyT9cOMkPqsiUHi/SG+1JEwdiuAjIIR2Rpv37lf+HSchXHBRgciJUWWtjjHxQucE/o7Y9j0vy3S7cnfAtSW9ZofcGR/VI0W7rSF9A9d2xczaWuOtkPcK3dJvyHxzAoGzrYBCXIfB+zCbr46OoGw5OqhyvF4uvRn7skmmJUE/AhfzeWyEANubv1m1xym11q5jzcB3+NgKp8knzipuoww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I06pZmKJMjk8aO8cjmg3Cal0vlqXJMN5VF3cvapwauU=;
 b=PxPU2W2TdhrW3+gCqfr6822JgGeeCw34TY+tpdhmGWQHV6nnl1LqXu/qEZIDpbD86lNi/Nq01IBW5Ffy7OIXRZenC8JNoI92lrZUhYgl/BJiokzS9N4UTv46CMMEuAii82XYIRmiCjrnIo0JdgE+QJ4fuA9/REV/2XhVUVnVtIFeZ1gRrCVlIfVOjB9dxYP1ZzA+h//f8eeYkN8/G/z3clhCOawWOcd0jrtyTzbGZsQOah7BZ4TUc3Vd2l+/0/LyXJefdo08vajG9BUOZNT9mUXDtdRum7FVwalqLVONy9kq6/b+iU34JDRy+rXcUHshxgMFDHBziYkxk1x28STl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:48 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 11/14] RDMA/ocrdma: Use ib_umem_num_dma_blocks() instead of ib_umem_page_count()
Date:   Tue, 1 Sep 2020 21:43:39 -0300
Message-ID: <11-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0026.namprd19.prod.outlook.com
 (2603:10b6:208:178::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0026.namprd19.prod.outlook.com (2603:10b6:208:178::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.20 via Frontend Transport; Wed, 2 Sep 2020 00:43:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P1W-8V; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 320e5f57-e265-4fe3-05ee-08d84ed9402c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383414659DC395AA04C165B8C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygbVhNaeHZi08IMAINT1DBgCLykPtQN1Mb7ml6b17bn0uitJ5L876O13lsGLP+/odVfxU9GZr9oNS15v4yEXXAZ/zfsuBxboIc/Z31/2NvU1jI96jxKwclj2oAoPps+bm1u2BMdq8J+UwIRfne2ePs/Ofs/76SgejYZxMwbe3TeB9reXY+hAC59HOA+cdeJd9McgZu0EESIgx6LayMxxRTWHz/Ub/TCh/lYzO0k5ft0Nhu0MlDHjDqhpJt/NNBVzRGFJ93tkTkOBvJ6K3JDE7wCF5Yc0VSMVNOeyjcq6WLTcdbV0Ef/oUBaLxjKn/eMyK4bN40fWdzvYIkbN7SyI4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QPSnC8yH0gn4IZ4+AzyKAKLcHKso9Mrhl0MCkvf0Jvneg3jFZnIWODa1FH6HWnxxXahHWTuG0uFLNNpyOJt4J5/7UJN8HD/sdAUiyCm4jk9kiYcQP6XAFlDO7X+DKr7JWKzqzgL06oNFW5YeWxz75fQrPY082bQlgZPyrp92N+rdXgJmptZxD0nJN4LUkTmhjaJWLHy3EnO884mJpBo6hrLXN8GSVNuUzl/bRlv89jmOpTvZ8QnWxgZ0iDxQUrSl7DexM2muWqB+C6frIbx8KPZWhNfK8AVUt2amNXX26PphEflr1zPI22ENEqXLePgVyCqxdlghMIK2RWxcypvvQTq6uTg22aEtuDDiRitCSmz27suho0Nv4Qe5ncMwF/IiV/SIjt+NfpeZD2+TlGN0dMD2XMPYM/N+4YB9khDJW8Dvd308KYoPL/PUEiRfPVCUxSFCfGLuALEWUs1uSyNxKKTZXJ3lDIV0J7lzYq0eL26gE/Pe1RQ2K2hjZmqjmKRD9T9DvUs6xvV7vzqW23XlbEfBIWx/6NNjyiWCV6V6fLKwrj4g6bdcT5uEVMbTWKVfNfmPZ5KndEehqvN7WTP4GoOzOixfXOsi+++VEdv5npN7iZYvuZYSCBvNF+43tO/7yPxLWo4cMs3LEr9tMh12TQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 320e5f57-e265-4fe3-05ee-08d84ed9402c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:46.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99vjZEbaSAedefXYqowqTbCfO+xVd/ojz7zOY4WbQBvLc/6246tQDobKirLLw2um
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007416; bh=TX4gBUTPsysUkIr4WJSznIJcI3otuK3NY0secWOa/Yk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:Subject:
         Date:Message-ID:In-Reply-To:References:Content-Transfer-Encoding:
         Content-Type:X-ClientProxiedBy:MIME-Version:
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
        b=RIAe0BuZcdHz5/pMqyCh0bFYryEBZt4v2ClYo73Boo4uz4kioN56wfJvRWsnM+1ik
         1zI3LRzWWOj1uP9HCGf4ALLm8F82zR4BJ0WxtCXauSqvEQAIOdR+WvNRyzqCHYvHHo
         qVUM+rCxClx0ZSDeuwd0s/vWbH3Cv8Xc2DZ8tFZ90OqM7jEWpMWCMOJYPCTEd01Pg/
         lROAxCewevPOaYHKHn2vESR3WwHs8pRhgCFf0FTkBG520NOuCTBOpMwGtrcpXqRA+W
         3KxGTmzHJK03CDK1NCgjYZteNcFGwJ75Ji1ZAGw7ckMAS3xt1eLRQbRKEs6cwerlob
         GnDgn3TCyBR9g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This driver always uses a DMA array made up of PAGE_SIZE elements, so just
use ib_umem_num_blocks().

Since rdma_for_each_dma_block() always iterates exactly
ib_umem_num_dma_blocks() there is no need for the early exit check in
build_user_pbes(), delete it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c
index 933b297de2ba86..1fb8da6d613674 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -810,13 +810,12 @@ static int ocrdma_build_pbl_tbl(struct ocrdma_dev *de=
v, struct ocrdma_hw_mr *mr)
 	return status;
 }
=20
-static void build_user_pbes(struct ocrdma_dev *dev, struct ocrdma_mr *mr,
-			    u32 num_pbes)
+static void build_user_pbes(struct ocrdma_dev *dev, struct ocrdma_mr *mr)
 {
 	struct ocrdma_pbe *pbe;
 	struct ib_block_iter biter;
 	struct ocrdma_pbl *pbl_tbl =3D mr->hwmr.pbl_table;
-	int pbe_cnt, total_num_pbes =3D 0;
+	int pbe_cnt;
 	u64 pg_addr;
=20
 	if (!mr->hwmr.num_pbes)
@@ -831,13 +830,8 @@ static void build_user_pbes(struct ocrdma_dev *dev, st=
ruct ocrdma_mr *mr,
 		pbe->pa_lo =3D cpu_to_le32(pg_addr);
 		pbe->pa_hi =3D cpu_to_le32(upper_32_bits(pg_addr));
 		pbe_cnt +=3D 1;
-		total_num_pbes +=3D 1;
 		pbe++;
=20
-		/* if done building pbes, issue the mbx cmd. */
-		if (total_num_pbes =3D=3D num_pbes)
-			return;
-
 		/* if the given pbl is full storing the pbes,
 		 * move to next pbl.
 		 */
@@ -856,7 +850,6 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u6=
4 start, u64 len,
 	struct ocrdma_dev *dev =3D get_ocrdma_dev(ibpd->device);
 	struct ocrdma_mr *mr;
 	struct ocrdma_pd *pd;
-	u32 num_pbes;
=20
 	pd =3D get_ocrdma_pd(ibpd);
=20
@@ -871,8 +864,8 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u6=
4 start, u64 len,
 		status =3D -EFAULT;
 		goto umem_err;
 	}
-	num_pbes =3D ib_umem_page_count(mr->umem);
-	status =3D ocrdma_get_pbl_info(dev, mr, num_pbes);
+	status =3D ocrdma_get_pbl_info(
+		dev, mr, ib_umem_num_dma_blocks(mr->umem, PAGE_SIZE));
 	if (status)
 		goto umem_err;
=20
@@ -888,7 +881,7 @@ struct ib_mr *ocrdma_reg_user_mr(struct ib_pd *ibpd, u6=
4 start, u64 len,
 	status =3D ocrdma_build_pbl_tbl(dev, &mr->hwmr);
 	if (status)
 		goto umem_err;
-	build_user_pbes(dev, mr, num_pbes);
+	build_user_pbes(dev, mr);
 	status =3D ocrdma_reg_mr(dev, &mr->hwmr, pd->id, acc);
 	if (status)
 		goto mbx_err;
--=20
2.28.0

