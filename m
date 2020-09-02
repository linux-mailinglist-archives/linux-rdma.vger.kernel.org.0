Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA99825A25E
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBAn5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:43:57 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19894 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgIBAnt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eea960001>; Tue, 01 Sep 2020 17:43:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:49 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:48 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJB719uaebYCw8BqkNjQIpOQDaWfsCKZRw2BbYqLpcufIU/HR4r1AmJ60aLBG0UwDTkeLYKFwIXvWSq7BOaNOr2CyzuWRt7nqGY5r7gDkHG3L0G1qbxVEm24HplcLa4BT7/ZgsksgzqowhhCXqHaUyL7LxlKwy7W7NxVWT2Zi1z5pzVO5laDxplE+ne3jHGn+QxBcZSERyocjUe19Fn23gruj5OZwFgAx4LDJOIu66JA/BMTpoUpR8+J2X2s0X+UVNXx6imrKCpDej1tLACdOIur7JQcATNZ5ZGlQCYG28vcIrhbBi+4/J3bWS7/IsjCmucLTC1cqZS1IBRigFyI7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dn++izHGouDs5Cs8xCtu2rE36czqn7AL0Zwc4kUV6Q=;
 b=mAYupNPErL9llU0Y/RCC+eQfHtWLKRdd+QNg3MedcH1vI9XI6J3uxvuvV4MqBgogQYZJDxLseLNenS2ydnt6k0iAf1UiU32PsU9yTzaxMijqKJJ3BOFWUqdLKTqThzh4fuQsNrvO2HQLFrlLLnHYNUfo8dO0AqjE5eYkpIR0I/QVIXLm02Zy3aprZz92etvThI+o1WDcx6v5OoV5OoWIB2JS6BHhkEIxYUdAgkGguw5eojR9nzRky1Vv6bVcprkwPmSkzAczRknU+gvnMcm0j5iNUcONeGaerFIYTi+unrZRZsR4q1B4BvchdDx4UMmUuft/zRd8RFrXUhW3GUuIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=nvidia.com;
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
To:     Adit Ranadive <aditr@vmware.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: [PATCH 12/14] RDMA/pvrdma: Use ib_umem_num_dma_blocks() instead of ib_umem_page_count()
Date:   Tue, 1 Sep 2020 21:43:40 -0300
Message-ID: <12-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
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
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P1a-9a; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da4c6a26-172b-47e8-0ee4-08d84ed94028
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38346E7BCC5BE9AD7D6E8A19C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECI74tg8ievgWd37HMYEh95trdkOYVuXaxvikoyKluPGs2gQOYD3NJCfq5wj+k62dfRLykMPvUlxTMBwPvCN3Q1a0JberMsqP1g5FanWoP69prxdp/36WKZu30nrDjqkBnGRWxjHcb+2YGnHq8JxdXqRsns8IzdeCj0Qhheq44M6n5QWnfq9jFLHOPBzZisoUQBIBHgW53312Vyr9So87KDuJiBIRl+RFogn3J8EGS3Wa9TEQga1Dc9BKbTe+wppKt0qq5gsXWTgYIlUNdjLWffqi5vxhf6uPsqNxfc4flvzwe5GttXd03APo5Yo5qe3zZ7J7U6HCfJ3M/5FVXmATw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7PeZbFNMMVm5eFJAJY3qnb0CqYpFl8VFVsjBZUw69SaBXveNjp4H6sDvrKcWoKaG0e8dOVzh1lF09BxUlI2L0m/lRT3X2h25y5Yl+b+zZwJB0y6gVyeHv86UJsil4dXwJBZRRKX4W/camEMEGJxuQd+jBbr5VOavx3yOak7L59YDsKX5DG9hZyY6iWgqQ+VqELczLEVZYmErYmnBdb+bu98ipNDR8642AT5QAVLwMG6F9bEGPZZiEieGWDn+WSbIrvk/MlY/C8/o6lqV6ZLsVWNs6hSNLNoKsGVhlJzlVmrQEjCkhIhiLflTrPaqekH5kewXKTi+VTYb92zkDLsFKtcu+buPNVLP/J7c9Qhoggdra0UxnVaZKC40dmR7miX0NDoPOMjW6iGdVp1mFAwR+scBSVIRY0WSnwiavP9JospvOP9uY6CWIdap0toyLOCWdgFVYuphwmOBC601aLkzU5uEVSN/uA+csmQ20HaQZNUh/ubjQDcaN0VQ4abzrog1rF5b+OKNBRu7LSk1UgZ6bF0BtJoeRtxzVIcSAKIhNwuOdIA4O+QWAlhsahJnsWLRdkZB7Zh0F2Ax0ALIAARSs184UFK2vTcx/h8HnSDvfW+MRuVoFaSd1CoWVmjkzMPX69SRiSKstniqnGg7qfkcsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: da4c6a26-172b-47e8-0ee4-08d84ed94028
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:46.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqqDTTA9ULrTTmeq0EBBtu3fEDKF59J13chUUnl2AuV099t6u1vzoL5EV1XA1MCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007382; bh=JZvu/USViSfOQ9PQd/NNfFOW1LUbomcaYRCUiZt1Dm4=;
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
        b=rqUrFau+iEt10cBSiWVJ6YVBxmjStcL3dhwV3ylWG52e1NWYzfuc8jnqoQwNk71jp
         pSIW/+lkmCmsysi+u4xIu+Xfvl38/hwd8psW6UIoWq3URsKRZGBre9U04u24MkHZI7
         t0d4qO99juMEOGTp5HXcS/l5ADXPHWRLDs55GvwC3Cfv2JrrboaF6RDySZ705h2fEa
         CCK1rM965vJxRtMHfsrPpFEiQnV1XKEkHwCLM0j7z6vFn35bWOnY8bLNhpEdv5Z946
         LI3MWk3YaliqsdqgZEp5jAUfFeAlLXFYnkzXtI4PFrd73XDKbN/Gr9KKY/O35kCZEH
         X5CIF67/YJ4TA==
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

