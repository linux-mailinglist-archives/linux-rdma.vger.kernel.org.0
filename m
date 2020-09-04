Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D729925E3CC
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgIDWmS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:12920 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgIDWmN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:13 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c00000>; Sat, 05 Sep 2020 06:42:08 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:08 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:42:08 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:05 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoGStxB7eKuekByvdgDr2d1IjEPvC8TjbGuDUQGVxltrdu/54yvbST9nboDmvXrO19rlVL6jpzbSO6NwOAi53c9/eKMk3BYUqKbutf09ULSRTbnxSvg8hyqj9WXlHUTawLVibwa/Mlavze6q/+69OL0fPfmA3IKdVRJtYB/9PKtwwVdXeAGwpGWPdsBb8XD0F+Gayjpa9b8VHgZR4g2007Sy9BrO6wrjm9I3Kt48SDssAyWwBHZj7/hum+xtgJI0xEKEr1uy85oXmXavR1ZcTX1ZtBSvWavN2RMyDYicNIJ6OtA62FbGrkI1K5vT7u6RLBdb/ATL4NvIAY1L93IOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7icTMrAHnoQ9jUwAeZ1FEGugWpgUKoGaxrIvSjRLkVY=;
 b=ZjWBZfcQYiv9o8k7bUP7YLyus4odzAUwSZbnhwmd9pUPkr90p7zipB/dVpl+q9wpw/xUDvmkGcR+ge7RbkoD7ndR2uC3WYVOBgTiLpFSDqEDeFqT0sG8fkcwdx+KpLfqBjMjDKTg6FjTkNy5LA1FvGGktrHFiS9iREs5GCfD0iGaUUFSL5uN50Q2gMgxgRe3N0g1Ei32+6Hwj25JRAeQiMTS6t+gsjvB8BtkZeVtVPjEUNm//B3KnC5BQfIk3iWX5CR19hI2pxjBAufmNJKwuTPaYDHoPLpaGk3/ludK0epi8Petzag7XkTaCjADWKJjUP2sA9xuxd/c3mxFQb+LPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Fri, 4 Sep
 2020 22:42:03 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:03 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
CC:     Michal Kalderon <michal.kalderon@marvell.com>
Subject: [PATCH v2 09/17] RDMA/qedr: Use rdma_umem_for_each_dma_block() instead of open-coding
Date:   Fri, 4 Sep 2020 19:41:50 -0300
Message-ID: <9-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:208:160::43) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0030.namprd13.prod.outlook.com (2603:10b6:208:160::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.8 via Frontend Transport; Fri, 4 Sep 2020 22:42:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCW-3q; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2ad40b1-a540-4560-c275-08d85123bd9f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:
X-Microsoft-Antispam-PRVS: <BYAPR12MB280688DB8AE070A79E0D24CFC22D0@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x41rWn3kH15qSytdJ64cYO23KcKRYcfYQIs2B/dZXn2HyOppeaaDe8VHpcURGXp3x8CXf9dgI7tySWep8Z/g9zcmlrxYYFAzCR1L5mW4KwAy2f6FAn9Ocqtvtg6unc6VhxxI5FvydvmCLpWo0tS6gaBYmfuUA8zyZb1qnRx3ppN4oEFoJkn7pTGv9az5SvCY26ZeMfhpFtg4rZdxAhyUuoET6x69RcW09p0F9fxSoxEdUTOY2BnLuKjReBjHNxcCeFlGsCLI0nIwiek4IgqMFi+7Q5vxfQHO7N2fGi3vblN2SFyi3Zt7SE07O44TyCLq//wjv3ljp5P0MD6Q2Ae1MZipMogVzar5hXY9chY4YSAZAiT8i14XCoPi6wxxdyE6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66556008)(26005)(66476007)(6666004)(110136005)(8676002)(186003)(316002)(83380400001)(426003)(2616005)(9786002)(478600001)(36756003)(9746002)(86362001)(8936002)(5660300002)(2906002)(4326008)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zvB4+sB+jmiMic8NHA6RRNF4YpYFRGuYLNzSE25IaxeUxHXW9+ukJK8y0L+Ji5en0Ft95EXSvshey8KlQNeaLlyZHlBKO4JbjjCZpENcc/i5k5fqBTGN66kE++Ds6aqBJcWL3ZRRJNfLprgH32Rf4nadCdZQ4bUIAbri4AhfcCmrrayZ5HOQEFLsq/iJFLuDkFePiHh2bMzLx7s/Gdi3xvSqAq/k7tSWnipZJ5tP1EJ4UZZz3ioBTFQpltRlT/vR0UuWHjoLai6yij1T0G47H38R7qSa+w1pml0nowWnDZInyCIsYtc95IDkU1FI+PJCe16hAPSHfPlowkf5J6IYIau3uv8tw5pz2n69A06WkGkxOy3IFAQacltKvsXwxnjakwRZlIzJ+h4p7KCz71hoo5cY77KirGQyMfaxS91cXt0fMv5PHxk1b99HAF8UKcvaUO7/tluJyKX9FYn3eMgLbdS/XBhb7UIzU+s20bPmVvZiZopM3QJJfucf+X/M2W4dfa+GB3/NJrGcucpjdseWEE/kcDjcHq03TILfG1vpEGn7P7JQparDHV08UijUHC0LtA4NkAWNpf1mxf6wJYvBFlpAXqHUgsgvWDwFQTJB2oM8TTjsTSKft4WBN1NwOj+yYdmkc5cD41iZ6JOt6Q2xkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ad40b1-a540-4560-c275-08d85123bd9f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:02.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsAeaKGeQlMDK5GkP0oFs5DZwvaHtUqLgP6gDNsSzHSNZgAskb4WDAT6jxS5zxln
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259328; bh=iIh8nXFWRGrA1GmIFAq4hJ7Dz/6/m7dhzG6+bSl+AXo=;
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
        b=qJKph0Ns8yQieudGvDl4ytYM9xBMe/lURHVnRmdtM6H9+fi6kfLQ0V2h5YWBxjna/
         4WhlDn5+OfztbHdyeAPvotz9Jmb528AMQvkdqCBfBBIwga9vLDdqbA3C2kIXGBzu+A
         1vfbyhL973VEisohJqfYEnLEbFveHy+bL2C+3Wt2EyekMxe0GAfg+j52fbRpg/4zf5
         ldN039Y+bCluLfm0HSMIlwmyheHRxMELxIIK0tSdN60mlV/5G7Br8x/l46KsuK4ne9
         zUf9Wzcx4Xt/RX23a8RdaXdVSJ1uezlKZu6R2UNL9unyQ70PrTp/X+Or2pDorxD+Em
         eHPLiOKQxbWRg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This loop is splitting the DMA SGL into pg_shift sized pages, use the core
code for this directly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 41 ++++++++++++------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qed=
r/verbs.c
index b49bef94637e50..cbb49168d9f7ed 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -600,11 +600,9 @@ static void qedr_populate_pbls(struct qedr_dev *dev, s=
truct ib_umem *umem,
 			       struct qedr_pbl_info *pbl_info, u32 pg_shift)
 {
 	int pbe_cnt, total_num_pbes =3D 0;
-	u32 fw_pg_cnt, fw_pg_per_umem_pg;
 	struct qedr_pbl *pbl_tbl;
-	struct sg_dma_page_iter sg_iter;
+	struct ib_block_iter biter;
 	struct regpair *pbe;
-	u64 pg_addr;
=20
 	if (!pbl_info->num_pbes)
 		return;
@@ -625,32 +623,25 @@ static void qedr_populate_pbls(struct qedr_dev *dev, =
struct ib_umem *umem,
=20
 	pbe_cnt =3D 0;
=20
-	fw_pg_per_umem_pg =3D BIT(PAGE_SHIFT - pg_shift);
+	rdma_umem_for_each_dma_block (umem, &biter, BIT(pg_shift)) {
+		u64 pg_addr =3D rdma_block_iter_dma_address(&biter);
=20
-	for_each_sg_dma_page (umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
-		pg_addr =3D sg_page_iter_dma_address(&sg_iter);
-		for (fw_pg_cnt =3D 0; fw_pg_cnt < fw_pg_per_umem_pg;) {
-			pbe->lo =3D cpu_to_le32(pg_addr);
-			pbe->hi =3D cpu_to_le32(upper_32_bits(pg_addr));
+		pbe->lo =3D cpu_to_le32(pg_addr);
+		pbe->hi =3D cpu_to_le32(upper_32_bits(pg_addr));
=20
-			pg_addr +=3D BIT(pg_shift);
-			pbe_cnt++;
-			total_num_pbes++;
-			pbe++;
+		pbe_cnt++;
+		total_num_pbes++;
+		pbe++;
=20
-			if (total_num_pbes =3D=3D pbl_info->num_pbes)
-				return;
+		if (total_num_pbes =3D=3D pbl_info->num_pbes)
+			return;
=20
-			/* If the given pbl is full storing the pbes,
-			 * move to next pbl.
-			 */
-			if (pbe_cnt =3D=3D (pbl_info->pbl_size / sizeof(u64))) {
-				pbl_tbl++;
-				pbe =3D (struct regpair *)pbl_tbl->va;
-				pbe_cnt =3D 0;
-			}
-
-			fw_pg_cnt++;
+		/* If the given pbl is full storing the pbes, move to next pbl.
+		 */
+		if (pbe_cnt =3D=3D (pbl_info->pbl_size / sizeof(u64))) {
+			pbl_tbl++;
+			pbe =3D (struct regpair *)pbl_tbl->va;
+			pbe_cnt =3D 0;
 		}
 	}
 }
--=20
2.28.0

