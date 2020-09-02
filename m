Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2165525A25B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIBAnx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:43:53 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19888 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgIBAnq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eea940001>; Tue, 01 Sep 2020 17:43:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:46 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:46 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z82hgzF2ztkRdhaReFxllq2WgXrleSjRXbj+qL6Ec+E8/0ofLT5/6gkZWOGzF5dVNt5Mb3nvd3cAWoefSiAaoMvK81NmQLKyFHWohCACyuseHPJAdj/wI1yvVdF5N61Bx5Qwmp3VNmzDUllV7cK9tJlXpz0itu1mbr1SOAhqPCQDrMEow8dTNHfalS81CANfsmMWvqk69JumuweQkmnF+rQwg+drUdzX+sl9urqSqCfU5hRWipXGXnxJOyVbDv9SYisG6XB8KL1WHTFxQRixGBlU1UizSxpt3DXuq9Owp8ZF8eedf7lbKuTemnynj5POCNztsGnT6Wym4gqJk3kUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3oZx494bcUptm+8SBfS0m9Hp3++gQQQJ0HyKzifNBSU=;
 b=L1r1rBikzstPsR0M2nY3noYyL55U5tLJ6BSVTwfxJvvOF8jJytR7+sU7hxCtKMOAGuCDpOzkusy1LfjrT7+/HirbdY32tMw8qsScNQ1pnKmrJ+GW78GyfPPrqNUCn1e6SUmFpU6toKS2ThWBotCBahLB/ZZ3R/h4kNAE0BPBRE5mZGBXz6UWlYN5yVkDBmYFBryhXvJJEGtU6lUHJYybaDhNdttAohnkcalI5xzWXbLqn1AoYshRh842td5aTpkQ5iaA7Hxfeb0X/yGYHeshIt0lCH/NdY/thQvQBf1sijByFaqXehVUCFkRzkiusPBXLOPUh5caT/NW232UyNJQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:44 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: [PATCH 03/14] RDMA/umem: Use simpler logic for ib_umem_find_best_pgsz()
Date:   Tue, 1 Sep 2020 21:43:31 -0300
Message-ID: <3-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0019.namprd18.prod.outlook.com
 (2603:10b6:208:23c::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR18CA0019.namprd18.prod.outlook.com (2603:10b6:208:23c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 00:43:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsI-005P10-Ux; Tue, 01 Sep 2020 21:43:42 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc408ff5-d820-4f81-cf80-08d84ed93ecc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834FED55E984AD86C6A14F6C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8HLRjuQS7JyN9Ss0Wa9eeX38SLUr6e3fMRshucLO7tzWzEmSaXrM7tyHxWyVLu1ZDvS4wcWMDDJDSSy3zR+mv7cJcTVjKgKqeajJbxgr/MxQiNubqxygelI+wu/k7VLwX24YJYQ6I/Ar3kuDBu/0dYA+E2LSHbx4ANrqBZ64wwKtIIreDiGkM8W4qdFarg8MVLfhd4gNU57I1Nt+Ev1M50iqTs29Ltfi3/PK7au1NZ3rU/t193awvDYa8wqe1CeUUlCWhUqn/CJBSy3ND3v6uQbHZDOClyw43GtsDydWoqoijIDx2Nx8QrN9dGc2tFwqhFTJcVwi8gsbDXnvprVgvS8lPp+PkYzxl1qljpiOfwMhM0OB/GaARFErzzpst4C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(2906002)(36756003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gkx3OH+4j0wDopxTc6k8AfqB4ziWKenaHBPfn7WGviT3fOvl1Ie1olT1cshptcUkitAPLPKl07Q2FU1Skj9Ha+25Cw+ELewLy7PF4LFfMQr7OlFFQ+IkC8eMKG0877fsFno4ZlYWQuBqV19rAiJHwTgNw0hnPE2ciUDpz845sl797ASc3TrlQpOkx5a9Lgy25aOH0FZarZB/5d4Me6QIGKew6DiHHaBouvbNbm8v167qlIcuNfyUlsxR/w/g+oUgaZR8vxY5dJhaFdZvNJwENS8gX0ekJxVoo5Qyum+K4Pmaup2sV3vKMIXnojLr6Wk4AZPYSx09WqlQSO2rQ57r6OhCx2EolHGH4kD0as9ZryEe0Sg6ONKIWdi99z1rDXXJ06LF8/VTWk79rFar82/52F5kYk1CkMti+4nqIWl/mq63FxkkkKgNp2vHtuTJdL4qmJHnktYn12jEmBzmfD7bXHiwdd7JdGNdV9zoGfPnY0C/vXmtuMe0szLOR+FHr3mArfwsXJT8d1l4ZCiAwD9dkQ8e5QipLRW1ScrkamKjErDu0SI9euKPuAId9JbaRxnxekL90iP7spPmBfSZHv4PvZOsYcgm1Hvlc3YxoKWDBmgNiawRduUjw1ZlbRGi1Y3jPeURK2xHcsExdsHLub5HNw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc408ff5-d820-4f81-cf80-08d84ed93ecc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:44.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgCb2KFefiIWs4kd+jbqBLx8T1/NDs/boxk7lQChKYwbq39j6dwcyV8s1YHdLlgz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007380; bh=81iPYS51s8fO36/zSQrQCIuLrSqY+nAkovNZ78JaQJc=;
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
        b=DqNwUr79jP2AWAEWrEn0Y5XMVHlEoMR5zIfSzB81+47RqnW2VHCt/YEOeAgq1nQL2
         v3nu60dVRqrG8ZgZkkGgA8iZXb30ZZrE+aNWPvJKBmzFdkuCwrn4accmm/iXEsUzUm
         +BUd/hSpzrn97IGVQFNrLJRPIcvqwu/1nlJgDAfL/DZEyJqk6HIePBKzjIPvVZBxe1
         OuuSEDflFlRsssA6iEp94/RzefdEufx9HKFVCX3367kzVKuvYe42fFL6G7a9+BetyJ
         UMLhKRXoTJFwdSlQ/FjE10gfwWJXiWpb2uzNx8GOxTZGuMXuOCpKSS2kGfHN5d11jh
         RCp+Baol3OtuQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The calculation in rdma_find_pg_bit() is fairly complicated, and the
function is never called anywhere else. Inline a simpler version into
ib_umem_find_best_pgsz()

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem.c | 11 ++++++++---
 include/rdma/ib_verbs.h        | 24 ------------------------
 2 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 7b5bc969e55630..f02e34cac59581 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -39,6 +39,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
+#include <linux/count_zeros.h>
 #include <rdma/ib_umem_odp.h>
=20
 #include "uverbs.h"
@@ -146,7 +147,6 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *um=
em,
 				     unsigned long virt)
 {
 	struct scatterlist *sg;
-	unsigned int best_pg_bit;
 	unsigned long va, pgoff;
 	dma_addr_t mask;
 	int i;
@@ -187,9 +187,14 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *u=
mem,
 			mask |=3D va;
 		pgoff =3D 0;
 	}
-	best_pg_bit =3D rdma_find_pg_bit(mask, pgsz_bitmap);
=20
-	return BIT_ULL(best_pg_bit);
+	/* The mask accumulates 1's in each position where the VA and physical
+	 * address differ, thus the length of trailing 0 is the largest page
+	 * size that can pass the VA through to the physical.
+	 */
+	if (mask)
+		pgsz_bitmap &=3D GENMASK(count_trailing_zeros(mask), 0);
+	return rounddown_pow_of_two(pgsz_bitmap);
 }
 EXPORT_SYMBOL(ib_umem_find_best_pgsz);
=20
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c868609a4ffaed..5dcbbb77cadb4f 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3340,30 +3340,6 @@ static inline bool rdma_cap_read_inv(struct ib_devic=
e *dev, u32 port_num)
 	return rdma_protocol_iwarp(dev, port_num);
 }
=20
-/**
- * rdma_find_pg_bit - Find page bit given address and HW supported page si=
zes
- *
- * @addr: address
- * @pgsz_bitmap: bitmap of HW supported page sizes
- */
-static inline unsigned int rdma_find_pg_bit(unsigned long addr,
-					    unsigned long pgsz_bitmap)
-{
-	unsigned long align;
-	unsigned long pgsz;
-
-	align =3D addr & -addr;
-
-	/* Find page bit such that addr is aligned to the highest supported
-	 * HW page size
-	 */
-	pgsz =3D pgsz_bitmap & ~(-align << 1);
-	if (!pgsz)
-		return __ffs(pgsz_bitmap);
-
-	return __fls(pgsz);
-}
-
 /**
  * rdma_core_cap_opa_port - Return whether the RDMA Port is OPA or not.
  * @device: Device
--=20
2.28.0

