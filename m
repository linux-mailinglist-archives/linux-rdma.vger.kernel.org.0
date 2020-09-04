Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD22325E3CF
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgIDWmX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:23 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:57018 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgIDWmT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:19 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c20000>; Sat, 05 Sep 2020 06:42:10 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:10 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:42:10 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:08 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0mHfdhmYFtXBR5ArfWpTEWnnohA67E9gc/R8WHHONn/D1nR3ayiNOsXpzwx+/NiStVJVOD5ic+zQPNM4fj+c4PHrxZ5/cjF1bMyMXM8YDpvm9X/3Z/rTRo0Wzjpnda8m+f6PUtwCLQ+welxFKm2eaSV9oFsDnHEKclmMinZRrJMqq/KEUuPB5hwMAsPvHCunktROMXwhBZZRNqi+Cxjmm4xZpX1SfJRP7iattidhxrsyjRSuihOIV3uI8XW1uQtrCm9gaN2YxKKVqDvX13cbNoGShRwxi9vXLNVo4W7sj929qNNPIq8o90sPpgIwPR2bR3cUP2QIvoW8rusoFk45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtP+9dzmVEQIg2BjmMqTEmQzK/UU3apz+HyQkmWI2p0=;
 b=LRICUdIHXwn3ZGA35Nr/UCgNFnAeTnr0KvyMkm1HalzUbhMDUosXhQfnbHPx9Q1040Fhq8Et/0warj2WlPV9sQ/1X1DDEnGkoefCKCb5l+Zmmlt5KaJa4lfzu8rH3rfjsoN4bs9VoDFQCYrLf8Kxhg1VODW2Usv9GITnbPd7NVpzBVIXsfoA/JMVncUo/fEqEd8mtNM3vFPMLrIU+invTyVgS12XmZj/4OUJZfTIw46Dl7PELTDWrss5BhqSZquhjrCueItNIOQuo6kB+ixW70sqoKJ8md3yAaoCbhfv6LDeyh3K69ETm15TjONJQeVjjHYAvLSi3ftAP/YJXaw97w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 22:42:06 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:06 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH v2 13/17] RDMA/ocrdma: Use ib_umem_num_dma_blocks() instead of ib_umem_page_count()
Date:   Fri, 4 Sep 2020 19:41:54 -0300
Message-ID: <13-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:207:3c::34) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0021.namprd02.prod.outlook.com (2603:10b6:207:3c::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 22:42:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCl-82; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35895dcd-d249-447f-f1a1-08d85123be1e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR12MB28562724F7CEE7DD2BD29CA0C22D0@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISj60HXOBSswx/6lnilOlR0apOSBCp1UzQv4U9nkUb454yJVRLzhkmR2LZE9jN2gsLo2UO8P29KYwk1JzWVMJwlLnP3eIY/QKCGoZHW074ZECu4Yewx7KOiVA1M+Ym1fiRdlzrD883zzuxq96t0jH6YCjQdyCPoBa4CTcededKAYLhtVkxRRgEI2LQ5LaO1U/VCVC9vEn4ICp1/x6KPimsAfRqJu72OpzRqd7TY15zpvFLnWddmEjJFMz1H1603YfeNwXmRLTLJCq6u7k6Dhkqm32arIzPKhIj/geRMCPUepCpIx6W5HmDtF3BzHtf2lsXcaOO88dcbm2M3YshdMTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(36756003)(8936002)(8676002)(9746002)(86362001)(9786002)(5660300002)(2906002)(2616005)(66476007)(26005)(186003)(478600001)(83380400001)(6666004)(426003)(316002)(66556008)(66946007)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4N8kUfnsfWcEXydYPxXDlbcxKpC51OOqe84qyKhoKaVVD8pTNiqilnJ2kJ6YP1oYAac5sUWuWM7OzNSoFBhrl97w602ZKD3qcujUP6ZPq/HWBZFaT48r3f1pkswj+BcGfVOSnz6Y85lpeF8jTSBwpcI6oPIRWsZNFpOmYkCotA5jggX3vJS+LGiIGv9qxzDdx+erl9NIYPxzdHARbp/0KGcGhKsnPAxyIDE5nrkdUDdUoC6WrC0LPhYX/EV5Xta8jNRryOxiFwn+/c6WQF94MPeqnPxG7mCOQglWJiRXS5bA9ceUEN+U+WMHw0U/WS2Pdl337XPdu97zDbez5e1agQKyYQo4nE9DOckU/VpVJbqjE2k74RUO9R7rRPTewIVo39VKPfENXpICnNgnRsJJ6dihbAUWXuwbnGwgwxKRZBiL4N2T0ca2tVzP4D0E6o3Zi1rwivY0E4BLfQoIKXDdLn+5mKa61PH+sHdaOCJP0s8Z6qVqGpEYUwRJXqkyky8KeYmd2vQocZsBVxgdfuC4RUkXhF/xIN+D9segRe8cUhs6S+RVtnJok66v39GYosykjtQxBv27iXUce8NhzJSP79pY96+7O/ztyeNJ80RcrG/a9XGiNgiJSv51nJaJy0WYSVmIDU8R0TqMVsWWGUMshQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 35895dcd-d249-447f-f1a1-08d85123be1e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:03.2696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBe5++c2s7iQn7Icqa3DKTcjxvek58fffVAMH8StjAJdW76eDlx6hDfGPaJKjIFk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259330; bh=2yDF311buzQpmn8URkhHzX1v09sc+kqfHKxyvPUL3Cc=;
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
        b=oMQM2I6IYy1SLyP1oPyz4PdLcN2lqdLGhRcCjwqlRTJ8fqiv14CQK4lHVw0ppFnST
         BD624tCQDSnJ2aiyRadFXEBP9MiZ3z1MJCElgYkUQDsuiUdCu6jwRRbU08OLEeFcNQ
         WBjwD41oBWohJ1PurZ5E1dxB4EuAalWWsru14HehmMvhFg/IiUFpXe0mOELO5HvzQR
         fhif41EQZ0j2G0tfNk8TyMOuZaDATuFlGnvtQMUa78LDYgPN7RCSqfWgv9UNIzzgal
         y3Qc7Qx074dr6EvBCEHZgPAZfFxdSpQ+TyGHKeOM4uG6/JD1lHWiuciopmD3SnB9bY
         4mTZXYnLsnDDA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This driver always uses a DMA array made up of PAGE_SIZE elements, so just
use ib_umem_num_dma_blocks().

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

