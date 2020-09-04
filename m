Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4BDD25E3D5
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgIDWme (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:34 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:23103 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgIDWm1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:27 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2cf0000>; Sat, 05 Sep 2020 06:42:23 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:23 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 04 Sep 2020 15:42:23 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:15 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjYMl7DpDRYJN0nXs8JFeTXQ2065AyPll/GeB57JJIaLTJmLiW8DtBtPFQhB5/FQL2eJqVqhV4Ip3ZZ/eRbZCyiyeSYyzn/4HmZ3lw6IXxauP8Z4hQeyAyhEVRMd3H4Ipqyh37+t9Ep3dA5agCfyMeI5vw3Yx6GHLuedahem92R6DQeJXGcEDowuGcsztyuHgHZstrmmB+fnxJOLDwYkpp/01XU+/PqXAEkEaX6UY/1gbwwBLFDrAV7D57G5vdfOwwfN0jhQY0ZN0cE3ftXWeGh9lW2+a8dNPFx8BHVBHdzMkjM2m48drNrll6Yqff1Q80N9P6ZZbW8u0WelB3TNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rv2/T8b/Q+FOdU8DYPpArF1TdL4VQTBfaa4HaMD/E7U=;
 b=kpye2K+O3a+ghC1pfKmY2bHWUlTrxAD2Q8/kVXm5YTYRACkEqkh8l5bxPxEWsTzZV9RqGqswimb3/uzKcjvD9CL1xZyYWkQro4k1/lIDl58aBuWHpYWjjLo4/vkNjYaw+dY2l6/0lum4XdPxMncy6bYT7XL4AuZji+aI1RQApWHNIur6GEWuMhMiv+eYUCSAQ3BJBVB8Iv+R7xlCicbUFCxcKDm5Pq0zBz4C4Gam7OseXbKkP3bAovznx1HLX8xLqN+qH7FH9tJaox8QSX0oXCA7EEZUPGtMc27NKXYd6zJFVyrewydYg8026HBQ9Qmo3KhEpMZWMTzG84lqSIMOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 22:42:10 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:09 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
CC:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 11/17] RDMA/bnxt: Do not use ib_umem_page_count() or ib_umem_num_pages()
Date:   Fri, 4 Sep 2020 19:41:52 -0300
Message-ID: <11-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:208:160::25) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0012.namprd13.prod.outlook.com (2603:10b6:208:160::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.8 via Frontend Transport; Fri, 4 Sep 2020 22:42:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCe-64; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7823992-87a9-433a-8561-08d85123c036
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR12MB28563C65A887D33F79DAA34CC22D0@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRWx9N/qtovUXz54OC3tcZSUd+1c2WL8ihgkjPeSTPNSegufwzJEP/j1pt/aoeXO3CwUv/LD86Wfb8Pd89b5mGCScbjqaC8EIGYSVntH2lfC7p7R4M99ELXAluu1q1OxYpa4Gyw1ZBhLTwTF2zI8+xDkJEjZQwFNeIKEHDFpFlvU0twcLbEb0ErihkhirU3FyOw5MFzepaTRNSgo0WT7BIRbhcZ3eNbusjp5uSYBT5z9e7soBFX8XpAbiOxE4UWHUYGFyHxO1lxD0v8OAKpJSZzQ5lXNpzWGEennYOVTyCQQrAAaM0ohCbSG0nw7cHLNo2b+pfzhAmBZg+nYL7utcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(36756003)(4326008)(8936002)(8676002)(9746002)(86362001)(9786002)(5660300002)(2906002)(2616005)(66476007)(26005)(186003)(478600001)(83380400001)(6666004)(426003)(316002)(66556008)(54906003)(66946007)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LRWuhlcQxR+lecwpHH/fv98oR2jwt85cXsjv0FnWxCd4xF6uEaZuk1LpyRfPorrClwWQEyVsAKNsC1jS25UYj+suwwseCFFTqgOHDf3PifyHPz6OQFktLngFy6YHfwD1CJl6/Rd3rB161K8oqFum2Zu5uq8c5steUPztPo6/X4eh2dZ9ST07TPQkwYYWDOr1pwTEKLvSwTHDbip4JXGcqk+y37osdU5VTx3vF0sYhjIvWuKE6Cobg70CW/4TG3g7tXEah4Jgv5GnnMTKhsH79WJ5eN8eTPJgvUs1UwFlOStmUAFpobFiPjYF1o+3430CgpqrRsAFUdVpActQ2gs1TAwQHoCi2bkVd7pdiOaCBtUK9Us/IRRV0+CQIGlCZixVo3/3Zr/4b/shNDBesaJ3Etip6QGRMrJ/7Rdd4tshaJvvDYw5jf503JYmHojUXVI5etNyIGWx5h1MIHSinVGoCi6VTHUjMEffKHVhErynH85sQRWwAyTD5o1FSMDnRXut32o2ciZhuOGudQk5SIOnh+fvyNqYmT6kq6cYMPkQWTpGFN/5tWVqPgmwTj9Jc5w/zYCqrSKYKsgN8KZTlGIv5xPxi4ZhWS8VBGm4OaamtYwOfs8PfNDhjc5UcphDXT4oSrbNEICtreZkySEKcrJVzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b7823992-87a9-433a-8561-08d85123c036
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:06.7446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0haVGWGh6gypGS1126MMhc1qOXiJdxBNRKUqZtbtz69m14FWo08VCEdSyZ6MUrr5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259343; bh=lSjACUtbbN9stT2cijJ27tRmYJzWXivJvOx4HBOMlYA=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:CC:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
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
        b=g7fb/RIf2NuSq5TW3vX9S9awg9tuUC8mSWTFbEltN70xVg7QsW1NuPrw+pgPIjqOW
         wVpafenIBQ2q8ItQp1mqLrSth3zSQ1qRyjanrULfQpmkN4PFIJB88fvBzZKFfBEj6E
         ytMi3ixvwVYzM6DvU3CB2N2RtKsJbHRFVEgyM+1xnzb9h/naqMNqSyLtkGu6dRyPzU
         E77HLhxL2zb1BXqbq17DP5P6Tli/LwWu7arD3tRrx3FbknOG/l4AytGqWi86Yu+zAD
         D745C2k+r7Bx5hrLyhSFVTLpJYvdGImxj37XJuI7JER0yAH+TadWW41UJfpScFllNs
         3a0KRwK852bLw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_umem_page_count() returns the number of 4k entries required for a DMA
map, but bnxt_re already computes a variable page size. The correct API to
determine the size of the page table array is ib_umem_num_dma_blocks().

Fix the overallocation of the page array in fill_umem_pbl_tbl() when
working with larger page sizes by using the right function. Lightly
re-organize this function to make it clearer.

Replace the other calls to ib_umem_num_pages().

Fixes: d85582517e91 ("RDMA/bnxt_re: Use core helpers to get aligned DMA add=
ress")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 70 ++++++++----------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c
index 9e26e651730cb3..9dbf9ab5a4c8db 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -939,7 +939,7 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rde=
v, struct bnxt_re_pd *pd,
=20
 	qp->sumem =3D umem;
 	qplib_qp->sq.sg_info.sghead =3D umem->sg_head.sgl;
-	qplib_qp->sq.sg_info.npages =3D ib_umem_num_pages(umem);
+	qplib_qp->sq.sg_info.npages =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 	qplib_qp->sq.sg_info.nmap =3D umem->nmap;
 	qplib_qp->sq.sg_info.pgsize =3D PAGE_SIZE;
 	qplib_qp->sq.sg_info.pgshft =3D PAGE_SHIFT;
@@ -954,7 +954,8 @@ static int bnxt_re_init_user_qp(struct bnxt_re_dev *rde=
v, struct bnxt_re_pd *pd,
 			goto rqfail;
 		qp->rumem =3D umem;
 		qplib_qp->rq.sg_info.sghead =3D umem->sg_head.sgl;
-		qplib_qp->rq.sg_info.npages =3D ib_umem_num_pages(umem);
+		qplib_qp->rq.sg_info.npages =3D
+			ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 		qplib_qp->rq.sg_info.nmap =3D umem->nmap;
 		qplib_qp->rq.sg_info.pgsize =3D PAGE_SIZE;
 		qplib_qp->rq.sg_info.pgshft =3D PAGE_SHIFT;
@@ -1609,7 +1610,7 @@ static int bnxt_re_init_user_srq(struct bnxt_re_dev *=
rdev,
=20
 	srq->umem =3D umem;
 	qplib_srq->sg_info.sghead =3D umem->sg_head.sgl;
-	qplib_srq->sg_info.npages =3D ib_umem_num_pages(umem);
+	qplib_srq->sg_info.npages =3D ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 	qplib_srq->sg_info.nmap =3D umem->nmap;
 	qplib_srq->sg_info.pgsize =3D PAGE_SIZE;
 	qplib_srq->sg_info.pgshft =3D PAGE_SHIFT;
@@ -2861,7 +2862,8 @@ int bnxt_re_create_cq(struct ib_cq *ibcq, const struc=
t ib_cq_init_attr *attr,
 			goto fail;
 		}
 		cq->qplib_cq.sg_info.sghead =3D cq->umem->sg_head.sgl;
-		cq->qplib_cq.sg_info.npages =3D ib_umem_num_pages(cq->umem);
+		cq->qplib_cq.sg_info.npages =3D
+			ib_umem_num_dma_blocks(cq->umem, PAGE_SIZE);
 		cq->qplib_cq.sg_info.nmap =3D cq->umem->nmap;
 		cq->qplib_cq.dpi =3D &uctx->dpi;
 	} else {
@@ -3759,23 +3761,6 @@ int bnxt_re_dealloc_mw(struct ib_mw *ib_mw)
 	return rc;
 }
=20
-static int bnxt_re_page_size_ok(int page_shift)
-{
-	switch (page_shift) {
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_4K:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_8K:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_64K:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_2M:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_256K:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_1M:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_4M:
-	case CMDQ_REGISTER_MR_LOG2_PBL_PG_SIZE_PG_1G:
-		return 1;
-	default:
-		return 0;
-	}
-}
-
 static int fill_umem_pbl_tbl(struct ib_umem *umem, u64 *pbl_tbl_orig,
 			     int page_shift)
 {
@@ -3799,7 +3784,8 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd=
, u64 start, u64 length,
 	struct bnxt_re_mr *mr;
 	struct ib_umem *umem;
 	u64 *pbl_tbl =3D NULL;
-	int umem_pgs, page_shift, rc;
+	unsigned long page_size;
+	int umem_pgs, rc;
=20
 	if (length > BNXT_RE_MAX_MR_SIZE) {
 		ibdev_err(&rdev->ibdev, "MR Size: %lld > Max supported:%lld\n",
@@ -3833,42 +3819,34 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_=
pd, u64 start, u64 length,
 	mr->ib_umem =3D umem;
=20
 	mr->qplib_mr.va =3D virt_addr;
-	umem_pgs =3D ib_umem_page_count(umem);
-	if (!umem_pgs) {
-		ibdev_err(&rdev->ibdev, "umem is invalid!");
-		rc =3D -EINVAL;
-		goto free_umem;
-	}
-	mr->qplib_mr.total_size =3D length;
-
-	pbl_tbl =3D kcalloc(umem_pgs, sizeof(u64 *), GFP_KERNEL);
-	if (!pbl_tbl) {
-		rc =3D -ENOMEM;
-		goto free_umem;
-	}
-
-	page_shift =3D __ffs(ib_umem_find_best_pgsz(umem,
-				BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M,
-				virt_addr));
-
-	if (!bnxt_re_page_size_ok(page_shift)) {
+	page_size =3D ib_umem_find_best_pgsz(
+		umem, BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M, virt_addr);
+	if (!page_size) {
 		ibdev_err(&rdev->ibdev, "umem page size unsupported!");
 		rc =3D -EFAULT;
-		goto fail;
+		goto free_umem;
 	}
+	mr->qplib_mr.total_size =3D length;
=20
-	if (page_shift =3D=3D BNXT_RE_PAGE_SHIFT_4K &&
+	if (page_size =3D=3D BNXT_RE_PAGE_SIZE_4K &&
 	    length > BNXT_RE_MAX_MR_SIZE_LOW) {
 		ibdev_err(&rdev->ibdev, "Requested MR Sz:%llu Max sup:%llu",
 			  length, (u64)BNXT_RE_MAX_MR_SIZE_LOW);
 		rc =3D -EINVAL;
-		goto fail;
+		goto free_umem;
+	}
+
+	umem_pgs =3D ib_umem_num_dma_blocks(umem, page_size);
+	pbl_tbl =3D kcalloc(umem_pgs, sizeof(u64 *), GFP_KERNEL);
+	if (!pbl_tbl) {
+		rc =3D -ENOMEM;
+		goto free_umem;
 	}
=20
 	/* Map umem buf ptrs to the PBL */
-	umem_pgs =3D fill_umem_pbl_tbl(umem, pbl_tbl, page_shift);
+	umem_pgs =3D fill_umem_pbl_tbl(umem, pbl_tbl, order_base_2(page_size));
 	rc =3D bnxt_qplib_reg_mr(&rdev->qplib_res, &mr->qplib_mr, pbl_tbl,
-			       umem_pgs, false, 1 << page_shift);
+			       umem_pgs, false, page_size);
 	if (rc) {
 		ibdev_err(&rdev->ibdev, "Failed to register user MR");
 		goto fail;
--=20
2.28.0

