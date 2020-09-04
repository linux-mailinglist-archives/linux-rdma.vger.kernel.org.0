Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6339B25E3D3
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgIDWmc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:32 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:55313 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgIDWmZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:25 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c30001>; Sat, 05 Sep 2020 06:42:11 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:11 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 04 Sep 2020 15:42:11 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:11 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9wuQFVbBQ1seJsMEhT98SJbFQvpKfs+nSf07cSeKoeV0nb7dSnBDFng4xMwJDZ6uZ3/tY5UDoIMlDeTSMhnLqWKERiYSqVKXci0JLXVkxxU+PRgT28sFAfTIDu4e4G485hd0Lay9krwvT+5PUyE+X73YoBq4g9Uz1m3cE5fQZ1omvYx9Py2eXIa/qoEQgyqVEEM6hKZ2AwS/p/Edm4XnJmiOmW55M0rpTvYvVpxhWxKPfog/FyaeEfG1mfKQ8zz2Co8bNp4xrcByEyTklqecW1Xm8/gKR7SqZvbTX0jn/o3pDJAWNxEdPVbqlng/t9jgIT/HE2lW8IpA5Hnt5QBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW0VYGSVThf84oKF/6nm80GT9yWZZ06eVYiLNvsdpfI=;
 b=kMHr2fR5Z5tDeYBk5eGV/Pe155g0CYvpfhJlJef3u33GsjfPa4kbI1VVsKQCgWKQdOOhE9IIpSnQBfC4q5MeFIjHgfwQDnkAyIyJG8g9DWH8c2iJ1Xd+RiuFbHnhY807EgkW9IDg3Hioi+7rfmNNtBiJf2WMoRpHKziAEzCE7vU4BodgRo0rz8GNSkIW5bvH1gQe4fxZgKHatT8OS5absGkZ/i9lgkU7I9+sybaBd7AQrCEq/edAF+C6+/Vf8ZzPAUwm8jDUN/JuhIFGWbbsEtCpLzIIr04Wl+xX49sbFWoCoWcwa5PjiQfauMsm+IftR2WGCQUI6Id8HrLN4Jru1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 22:42:07 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:07 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "Doug Ledford" <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "VMware PV-Drivers" <pv-drivers@vmware.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 05/17] RDMA/umem: Replace for_each_sg_dma_page with rdma_umem_for_each_dma_block
Date:   Fri, 4 Sep 2020 19:41:46 -0300
Message-ID: <5-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0017.namprd17.prod.outlook.com
 (2603:10b6:208:15e::30) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0017.namprd17.prod.outlook.com (2603:10b6:208:15e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 22:42:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP8-001vCF-UB; Fri, 04 Sep 2020 19:41:58 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f9509c1-9b33-4931-59b6-08d85123bed3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2856933D10ECDE83E26DC1ACC22D0@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NQ1AsjM+Hve3wK19rHGYuB8WJ3WPYPnjEkTfZwuncGTsbHOUhpg+efsPA1Osz2eJnpFO7/mTQCJ/Tw4zCMHZe5L2GzJSGotaq4vsa4+9tRxmrnw5NpoZY2uYkzTd8L362UxQ1F7FJ7VOqhBYyf+m4PLN2JP89OzBLNABpN3ayhpmOWbOI9ekuassyVLoqJ4Fp7bOfD9V/SSqkUfQ274OJ4bk219nbuUlRSj2Xr8oF6TnsmZMT5FZzQlSXZzVZt634fpffVMLCEyzPVm3RFPPLoZXeMSVY5oKDRiLyM1KKWnD6eGb8Hhdr5u/H7hLRlIwj4lN2rC4986R7RSAfmVjc61tY/wHBdiKJ4essC5wn6BjQ6XuY3ZlStbqWrHMYYT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(36756003)(8936002)(8676002)(9746002)(86362001)(9786002)(5660300002)(2906002)(2616005)(66476007)(26005)(186003)(478600001)(83380400001)(6666004)(426003)(316002)(66556008)(66946007)(110136005)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1UxOSB8zP8p9098A+OujOgF78JXNwSzVy/eC+5pikF1GZ2ioWlkf7LSMEZECoV5aqnIKHY4vRU6vUdJvtSX0FjdBTS2LXu5x+AMril/zmGYj9eix1FzV/vCCyBjhiStQGktgCuqEJSeAtCb1yAo8punWpngr5Eg0lyN5wFTjpthF3NLATszLSCu1mzq5A/H2cu/N7JOAI2a+bpeTJIbouAEtodGLmRNGmm16ZERQ8OxRyN9+LW0PVeC8wwVjEmz1TtkAHztl9NpYTpBGZ6M0fcCpIysUMtQ6YRHeWheAQE/vIn0wIW/S0MNxIToEbfEo/5DuUhzOTFWmZHXf+v9pretLyaHF+s159cBgcUmQN/BC5+8rzddv23S0tPqwGQ6g7DkZr7AHNrI2T6rYIQyYtpa68le+OWGBKvF6OE+Spd/X3LkwNTVUaiGWpxvGBE1lHdf3Oo4LoXi4Y6JNL7BCDEsPoPhgFX3PttWOCtDRWjBR2l7FFLUCz3ubaAuc2NyoIENBc/tcse3Bgls6HLHMJ8dtNwA4FwgUloqpFPzd917W+v+BF6eQCW35Mjk3UMbhwm6FScSksfAuea1u7Dl016KEwRZ6DJObXfaBHcjuNDDNkoX8TZid2+tGslrRTBJnJa0dCpiw03NOE57EKfoJsw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9509c1-9b33-4931-59b6-08d85123bed3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:04.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BAJOSoto/ydveFf8+I+9K7DvhVtPdRgNYWJl4ymZhdy0l/aXtpRxEJqgOMUJIsp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259331; bh=bmUtxrzFMiAf2jFyxtS+c0Tdfq8lu2dqe86kmaH/5Pg=;
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
        b=UHjqEZ4zRN8OokRJTre0zZ9Z8Xxch5p1lb74fDUTd5C0WUmdMZWvgFZwARZTVArI+
         8iMNCmql4Q8fvQnrX/PJkunOvRBC8mmCa4MFklQqfs0VpzMTLHti9D8F7taW/ynaAD
         LSAWuIRtuRFC4OhFz4ZMskveSZfZJHtPUFWZc3SVYZPb1LoF38nE1Q4Z3XPP4L86HR
         tEg3WMuIRhSMDV+fC3c7PVVi5p5tcYZbyQ6rUXYTjVDVCPL8Aw/UDhrKMum+Q+OLiZ
         n1Bg+E6fdceWkt8C04xvuU5W8Rn8xugCtisFZV4CdNGSJg36MpgSyCJQMKRzGeizZM
         zX7r9aumhvDKQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Generally drivers should be using this core helper to split up the umem
into DMA pages.

These drivers are all probably wrong in some way to pass PAGE_SIZE in as
the HW page size. Either the driver doesn't support other page sizes and
it should use 4096, or the driver does support other page sizes and should
use ib_umem_find_best_pgsz() to select the best HW pages size of the HW
supported set.

The only case it could be correct is if the HW has a global setting for
PAGE_SIZE set at driver initialization time.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/cxgb4/mem.c              | 6 +++---
 drivers/infiniband/hw/mthca/mthca_provider.c   | 6 +++---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c    | 7 +++----
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c | 9 ++++-----
 4 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb=
4/mem.c
index 73936c3341b77c..82afdb1987eff6 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -510,7 +510,7 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 st=
art, u64 length,
 	__be64 *pages;
 	int shift, n, i;
 	int err =3D -ENOMEM;
-	struct sg_dma_page_iter sg_iter;
+	struct ib_block_iter biter;
 	struct c4iw_dev *rhp;
 	struct c4iw_pd *php;
 	struct c4iw_mr *mhp;
@@ -561,8 +561,8 @@ struct ib_mr *c4iw_reg_user_mr(struct ib_pd *pd, u64 st=
art, u64 length,
=20
 	i =3D n =3D 0;
=20
-	for_each_sg_dma_page(mhp->umem->sg_head.sgl, &sg_iter, mhp->umem->nmap, 0=
) {
-		pages[i++] =3D cpu_to_be64(sg_page_iter_dma_address(&sg_iter));
+	rdma_umem_for_each_dma_block(mhp->umem, &biter, 1 << shift) {
+		pages[i++] =3D cpu_to_be64(rdma_block_iter_dma_address(&biter));
 		if (i =3D=3D PAGE_SIZE / sizeof(*pages)) {
 			err =3D write_pbl(&mhp->rhp->rdev, pages,
 					mhp->attr.pbl_addr + (n << 3), i,
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infinib=
and/hw/mthca/mthca_provider.c
index 9fa2f9164a47b6..317e67ad915fe8 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -846,7 +846,7 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd=
, u64 start, u64 length,
 				       u64 virt, int acc, struct ib_udata *udata)
 {
 	struct mthca_dev *dev =3D to_mdev(pd->device);
-	struct sg_dma_page_iter sg_iter;
+	struct ib_block_iter biter;
 	struct mthca_ucontext *context =3D rdma_udata_to_drv_context(
 		udata, struct mthca_ucontext, ibucontext);
 	struct mthca_mr *mr;
@@ -895,8 +895,8 @@ static struct ib_mr *mthca_reg_user_mr(struct ib_pd *pd=
, u64 start, u64 length,
=20
 	write_mtt_size =3D min(mthca_write_mtt_size(dev), (int) (PAGE_SIZE / size=
of *pages));
=20
-	for_each_sg_dma_page(mr->umem->sg_head.sgl, &sg_iter, mr->umem->nmap, 0) =
{
-		pages[i++] =3D sg_page_iter_dma_address(&sg_iter);
+	rdma_umem_for_each_dma_block(mr->umem, &biter, PAGE_SIZE) {
+		pages[i++] =3D rdma_block_iter_dma_address(&biter);
=20
 		/*
 		 * Be friendly to write_mtt and pass it chunks
diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniba=
nd/hw/ocrdma/ocrdma_verbs.c
index c1751c9a0f625c..933b297de2ba86 100644
--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -814,9 +814,8 @@ static void build_user_pbes(struct ocrdma_dev *dev, str=
uct ocrdma_mr *mr,
 			    u32 num_pbes)
 {
 	struct ocrdma_pbe *pbe;
-	struct sg_dma_page_iter sg_iter;
+	struct ib_block_iter biter;
 	struct ocrdma_pbl *pbl_tbl =3D mr->hwmr.pbl_table;
-	struct ib_umem *umem =3D mr->umem;
 	int pbe_cnt, total_num_pbes =3D 0;
 	u64 pg_addr;
=20
@@ -826,9 +825,9 @@ static void build_user_pbes(struct ocrdma_dev *dev, str=
uct ocrdma_mr *mr,
 	pbe =3D (struct ocrdma_pbe *)pbl_tbl->va;
 	pbe_cnt =3D 0;
=20
-	for_each_sg_dma_page (umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
+	rdma_umem_for_each_dma_block (mr->umem, &biter, PAGE_SIZE) {
 		/* store the page address in pbe */
-		pg_addr =3D sg_page_iter_dma_address(&sg_iter);
+		pg_addr =3D rdma_block_iter_dma_address(&biter);
 		pbe->pa_lo =3D cpu_to_le32(pg_addr);
 		pbe->pa_hi =3D cpu_to_le32(upper_32_bits(pg_addr));
 		pbe_cnt +=3D 1;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c b/drivers/infin=
iband/hw/vmw_pvrdma/pvrdma_misc.c
index 7944c58ded0e59..ba43ad07898c2b 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_misc.c
@@ -182,17 +182,16 @@ int pvrdma_page_dir_insert_dma(struct pvrdma_page_dir=
 *pdir, u64 idx,
 int pvrdma_page_dir_insert_umem(struct pvrdma_page_dir *pdir,
 				struct ib_umem *umem, u64 offset)
 {
+	struct ib_block_iter biter;
 	u64 i =3D offset;
 	int ret =3D 0;
-	struct sg_dma_page_iter sg_iter;
=20
 	if (offset >=3D pdir->npages)
 		return -EINVAL;
=20
-	for_each_sg_dma_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
-		dma_addr_t addr =3D sg_page_iter_dma_address(&sg_iter);
-
-		ret =3D pvrdma_page_dir_insert_dma(pdir, i, addr);
+	rdma_umem_for_each_dma_block (umem, &biter, PAGE_SIZE) {
+		ret =3D pvrdma_page_dir_insert_dma(
+			pdir, i, rdma_block_iter_dma_address(&biter));
 		if (ret)
 			goto exit;
=20
--=20
2.28.0

