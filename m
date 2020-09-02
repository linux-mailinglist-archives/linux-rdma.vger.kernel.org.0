Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540F125A265
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIBAoN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:44:13 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:51207 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgIBAoH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Sep 2020 20:44:07 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eeacf0000>; Wed, 02 Sep 2020 08:43:59 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:59 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:59 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:57 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnjWO3WNRdWXzc/omjoRtBGuV6skaKa1MTrsX8OrDj3+cr6eIyaTjXfDDzmgQMsZ+zYzMBWiyAKBT008VQszL+6s1Bs0ru9VzSmzolBKOalydlJ160/HVu+w97SjuFwRjZbooZLigcaxf066peQdSzC5+b9pSLrLMNC+wliXBpU5LIFXisiSmkvfRX9CuhhH5Sf70haauCk37rNon+88Ps23XX81U2nfQ09iLLhq1JIUufsWO3m116J8OCFpVtcc9nC04bVXqv7asvSeKvTPjkUqYwdnN/iAlhNxuBeyDttYXf3Suui3y3eNf7Qf5nsvAxxKvx6JexwZ8zuiOEGrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW0VYGSVThf84oKF/6nm80GT9yWZZ06eVYiLNvsdpfI=;
 b=l1nch8Rf7Qu0g1BGMnRPAh6qVZUSWyjif5XXxOKgMCmbyHYaFPScfUrEw1z+npVkpZPzWdXPidpHWugpGMSWPJFbDGVCJ9/eZarCJ5GKxxLqO8KXA5PMS/l2c3oguyX4R7Qb7X9lSfpYFqeZ16RLmhtGZHnAwPO8IzO2M2TMQYIEkD7npknw/zPTVI21Xgy69D8+U3XbSB9+P1Jpsg1okLs9HDrPP3BxY2W+yDSV1iiLn3MKk9lbUOyEUHDb9p30HF95DAtlBmnIeArtttO5hUSC9085vFDUdD3mT3qs0RAsw4mbdJIG3B5YLuehGJIKrEa2eGYVAo7jd7U+BtUauw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vmware.com; dkim=none (message not signed)
 header.d=none;vmware.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:55 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        "Doug Ledford" <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "VMware PV-Drivers" <pv-drivers@vmware.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH 05/14] RDMA/umem: Replace for_each_sg_dma_page with rdma_umem_for_each_dma_block
Date:   Tue, 1 Sep 2020 21:43:33 -0300
Message-ID: <5-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0006.namprd15.prod.outlook.com
 (2603:10b6:207:17::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR1501CA0006.namprd15.prod.outlook.com (2603:10b6:207:17::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 00:43:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P18-1R; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e49a49a7-8990-427e-f8ca-08d84ed94534
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834DD2AAB7A5071DC63D6CAC22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJ/12yiNX5vR+lg2WuuWnu0CZJHPnrbz4bwdQoX+ZzVxflipY+IpxLbVbYkY2yXbW380icD4muxGZCTCx0OLtf8oGlUEw9EFlBTGCcaKftXsNSlvZnpGN1oqlwqb+ajjomYZuoDqJ+u2oMJ3L3LwCB+6WDD6z95aGJogRkyHvZpm0Dnh0n3r2ynX2c5WsgkbSjNfpD9GHSl1hQbSXZleBWd70TnIIpUzkWgiILFYzzUk9oMH5eZ0gRqsY3Qebc1geP0QJ51uELq0EkYuB49G7Nt96QGFbUne08W99zRmyFYM9eH7NGu4nsn6uQxfr5GB1zKOlpK9gcVqmRKwXDtbU6uEeomcC4z2WaAMxwAzR/fYEdprw/mFIDq6ymP4hlQP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(36756003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DsyfWl6hQqABhlsLIT4nHyl6J9FDrEWNpjyvl02sOuasEK1zJC9Cg/ndk1ll8iEWDfb6PiNPfb6NA7n1CVGR4H9eY8kST9DJ8puZshdIIlYrBj27rN/f7M2ZVSPeLI5zqDR1eZSYzHUotNyQVNXH10zE/osdiiJgNA/jU4Mkz+ujonVSdVjF6l1ndXN3PE/HMG1ArxyAV+8+hKnoYm3xDmCIxqyPmpVdVA0r5xiZt1P97ndXfqY1bdZ2fwIALDw9PRSzIRR6Oeja6tGSL/rbXYYooYvjk2Z8Bn5FvUrm7FBisM07YrKSlPYKqdkFtJhuCDGCDKiomU6xpLpU22YaJ31lCWB3mW4pwnB4xKGEIxhX/eff1rCcLKROMVnXDIDQ/mB9/WCuMgKe+HiqEpeObUIrPqf/sdqW5aQqU0L1rgOftsP2Yp5lo6S3ANMcMsoSCyI7u3sgzRdB91L1+LX3pmPgL/og/fda+LPDSKj36wCPaabpI/Nu6B/8nXN8tI1iTUScUftP/TU024IsnDeG1Dx9TA5gQQccY+mxrAF1/wB9DHJ8HYCh6miyHVWxp3i/34T/5B+M1+CUS5JJJ/VWWNeCngoiVKXS7yhXt9SZyrTzud0kh2bRezYtz/HjJ1NefPpNRxzZe0/9q8gkfWKovg==
X-MS-Exchange-CrossTenant-Network-Message-Id: e49a49a7-8990-427e-f8ca-08d84ed94534
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:55.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VmCb4IXn6OKCIj9z5wW28+6TKJaXOWPmRjWrbssT/GxGuFR71BHzSpSqiSIkUJY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007439; bh=bmUtxrzFMiAf2jFyxtS+c0Tdfq8lu2dqe86kmaH/5Pg=;
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
        b=CYLAG87gFkHDbBNvxDk+vd0Dl6Pjg2D/AbyKHd54g3KvxhfupvIFjGb6y7cl5Nfoe
         H4eiLqb7yZFMw/NJnCzuTSPdwIrP8dlBXkzKAyu+r5e+M7XnGjDx9qTxb9/jgVX17y
         KilELsVzmLIcIRoopYVG/tYXmgZQW6lqfH7+At+h7w4DwKsk63Rkf4rS6VK3GNojZC
         b6cfK3n/3LKDtdriLk9KoITFkGNJOOmonxDJikcwintcsCeYquuiUZCFu6+bAKrMR9
         F9HKjB3+gRW1JdoVJPUOa9Dvnh7ybGozab8sTmekkmm4nEoz8ven/Q8ByFCTeqULHp
         5AJGvP2/CmnsA==
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

