Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D42325E3CB
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIDWmR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:17 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:30453 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbgIDWmL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:11 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2bf0000>; Sat, 05 Sep 2020 06:42:07 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:07 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 04 Sep 2020 15:42:07 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:07 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFL0LoR3kfn73DQGrC5NheUK8khfJN+g+j96yvVptJ7rhWpFKyvu8OTrhzxTQfe0q6pTDnpjXONFt4173zfhnQIWHpg7khJ4kDmkdxx9+B06mdwUJxBoJ4a5cnsYFa27eDyQFvEgnujcQtAc7mPFEMlxqUKBAW88eX9hKgS9g/Gg99Q93hTRlatI0BqyRYfUgxRZ+HxSGURTm6EASaCE0B5td5G84wkZrKzZakEWsnXZ65L48vo+t4XThUqQIOt2WpGVQrJvQljRQXTQa9V2ak1KfqkOaexu2p0vYd5MQwNQbb55xgTo2XMAp3kJU37UFMCsYNVWrW3acqM7WY++Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dn++izHGouDs5Cs8xCtu2rE36czqn7AL0Zwc4kUV6Q=;
 b=D6ARxjc3Fm4CtkqlBEXmSBk3fw8YM+kkxo9TBuN0Wt2JLBx2qZ0/ur50MZTiA23EocipCg+ObY9d+LsbsWP2SdbzjQL6jaZufy9T1bNr5ZdBw45hYmtNx+K4XKeZp15MpumJH9G2KHt4sHRiYdBDuG9EjRaqPSnk6UZuJ6/zZ8J84l3VBUAYAEH+VEDkwe/Tnt63sOXI+MOXK+HknZXeFa49yICWZTKRCUCHBfrn3FxcXTg27UTcdZae9QVm7bvDj+jwbvTO7bGflfGiYH7FJ6ofnN0lT4krtzloxm18Au5cOFzQgvaQnQn0g0oZH4Btg3dW758IBsogQ2t4BI0T4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Fri, 4 Sep
 2020 22:42:05 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:04 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: [PATCH v2 14/17] RDMA/pvrdma: Use ib_umem_num_dma_blocks() instead of ib_umem_page_count()
Date:   Fri, 4 Sep 2020 19:41:55 -0300
Message-ID: <14-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 22:42:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCp-8r; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe2ca13-ae04-4e4e-9d32-08d85123bdfe
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2806E45976BA0E7C3FACC195C22D0@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wELI5z5ai1Z+Dn42gbt8DujEayKT4bt1upaOFaNiDOoL7MJ6sXQa08PzacErlEBvZ8LyyAto6TlMi8Hzwq1EzFpU/9XlPvyOd9oX1TeBTKHMqpllBntxdsS/LjykK6s2FaJqxU/KfZg1cZYVR0j/YLmaGe7ZiRwuD+jxvgvHrXGmRHQQ+z+9KethZyFNUmriaY2y3+RqCnChvDkidtYy8dGtoHw/+UAzf0SZ4+HpKeQxUZQwYZuazT3sGKGZq3mEOnZN6+PKCogem3iZ84ysCTFNF3p8wWDMvjSB7y8+k1ARoBXuQLp2m4pnmIw/pWw7Du3Jhfc8Y95HkFPv011yrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66556008)(26005)(66476007)(6666004)(110136005)(8676002)(186003)(316002)(83380400001)(426003)(2616005)(9786002)(478600001)(36756003)(9746002)(86362001)(8936002)(5660300002)(2906002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MBxUqWNFD/WinrG16vacABqSlLR0djgUrxJCcFxIvq58BoKnJy+UDyCh4ZElRuzFdvqdaslEkeD/hNLTVRq1ip6gj+E9MuZ2nGNsW8IIslOFYFP+EjfjWhL3BXzOrwUQWwYzfqSVqNWOLmQpJE8UnnlzpvNJzwXS8Z8Ntz2BAjhGVaGtfmm9lQfTHIMGsuY3y0BI+mPmUFoX4Sv9rFruT9fjWqjJVt0LWIgSnWCFhh/IjkXgIUktCcp+0ISZ5jilv2PKll7DzgX/yh3byWPzxRFp3yny98Veh9MG0hBHnaHG//FByCR7l0Bm937Ex0rxtIFom94RY4TDbP48J40/8L6axe3bJEezlLd6cV5AVtKuLKTvuTlEr9BpeoTOebfkVEOZZyphGowX1Z+sS+pzYGORxZTlN+mChV2CDOJs0vTe0PjPxtxF9hslquWbF49syURhZi06Y4HvOF41VeQf7q1uQ6i2UKkCzE8nEOpdNPwwBdIoFkzOvCwGmWHOQtzlVX9CWY1TSrHUTMVccIOHfyvrl2uLU7f1TcBlbBym2OsoW/Ggp1J5tBzsLjWeXv1VEcJnxwOL5eHqEE+JTfZX778ZpLI429v721hZs4p1BR59ArdUDy9571kGS3o03kgeFdzpXWb/YHUryJE+xo24BA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe2ca13-ae04-4e4e-9d32-08d85123bdfe
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:02.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7dys09Vol4786RABa4Xz3h8L2fbsyXw/2RqFA25T+/+abbnYhp8WC4fEDsR1WAi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259327; bh=JZvu/USViSfOQ9PQd/NNfFOW1LUbomcaYRCUiZt1Dm4=;
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
        b=cRhECy2GF7E3nOWOCgFu5shxEQvLafNCqFHXF7yZI21rizR5vJUA1tbkd7/LqIkL3
         PkeMVfnd0gMwb0i+XxQKh1e/0D5YYVvRf3fHTq8z3rrzcI6onGR6WauW/L78tacOxr
         /VquA3YcxXGpxnPdL1sDjkBmJJzqaxDCOuBXPtlN+PFW3Mp4Q1ki1qoI5BxnXECktJ
         UAO7uv0gfk3vPiiTW0fxRqYvk1HlswtBpis2rg7O2TL0uT8yMli8gUg6PwEibbj1/3
         0VbXilx8/Q8fFUdlZ/OKFBKUsI9cORFC8T7VnyosIYLcCajfUKl59HnstS+d3JE7vx
         nizRBn7SQ7WVQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This driver always uses PAGE_SIZE.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c  | 2 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c  | 6 ++++--
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c b/drivers/infinib=
and/hw/vmw_pvrdma/pvrdma_cq.c
index 01cd122a8b692f..ad7dfababf1fe1 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_cq.c
@@ -142,7 +142,7 @@ int pvrdma_create_cq(struct ib_cq *ibcq, const struct i=
b_cq_init_attr *attr,
 			goto err_cq;
 		}
=20
-		npages =3D ib_umem_page_count(cq->umem);
+		npages =3D ib_umem_num_dma_blocks(cq->umem, PAGE_SIZE);
 	} else {
 		/* One extra page for shared ring state */
 		npages =3D 1 + (entries * sizeof(struct pvrdma_cqe) +
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c b/drivers/infinib=
and/hw/vmw_pvrdma/pvrdma_qp.c
index 9a8f2a9507be07..8a385acf6f0c42 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c
@@ -298,9 +298,11 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
 				goto err_qp;
 			}
=20
-			qp->npages_send =3D ib_umem_page_count(qp->sumem);
+			qp->npages_send =3D
+				ib_umem_num_dma_blocks(qp->sumem, PAGE_SIZE);
 			if (!is_srq)
-				qp->npages_recv =3D ib_umem_page_count(qp->rumem);
+				qp->npages_recv =3D ib_umem_num_dma_blocks(
+					qp->rumem, PAGE_SIZE);
 			else
 				qp->npages_recv =3D 0;
 			qp->npages =3D qp->npages_send + qp->npages_recv;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c b/drivers/infini=
band/hw/vmw_pvrdma/pvrdma_srq.c
index f60a8e81bddddb..6fd843cff21e70 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_srq.c
@@ -152,7 +152,7 @@ int pvrdma_create_srq(struct ib_srq *ibsrq, struct ib_s=
rq_init_attr *init_attr,
 		goto err_srq;
 	}
=20
-	srq->npages =3D ib_umem_page_count(srq->umem);
+	srq->npages =3D ib_umem_num_dma_blocks(srq->umem, PAGE_SIZE);
=20
 	if (srq->npages < 0 || srq->npages > PVRDMA_PAGE_DIR_MAX_PAGES) {
 		dev_warn(&dev->pdev->dev,
--=20
2.28.0

