Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A776825A262
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgIBAoG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:44:06 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4731 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgIBAn4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eeab80003>; Tue, 01 Sep 2020 17:43:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:50 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:48 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b48v7oHBai1Ul3xqPYHS1aQTYqMM94d/plLEgSHJqZdjcJN5cRlntpubjBzpd+s9I5XpdvJJHcchtpGywQp5uA5LFAToJrLRtpO0PePjird53RO3A3kKB8Qr663v4Hjlv6F//WU6/AggR0OORaRtW8NGSg3Z1SL1gI2JgmscrRNddan53XzJW2T0uA4fvMx5nDBejb/AT9f6cVGRd4ExWPWaQPvBL06WzBlHLBdsCDwhgaxF8eQ4cIF7TYtaOkhmKOU5Tvcx3cSW6WoddVrroJTMLoGtUFOqVpGdm1t1LVHer6uAjpozo7DlYxkXg4RU7hlRdHUufvLcUdLJVE02RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jUvCXx+Iuwl5XIrrKSahRj8d1etFUYM3AfjOZigSdg=;
 b=KSpnbSeN0uis0mTanbGP4J5AT+hvnZgrwYwe57eEFtQM/7A4bbVn9q0/w4gDfioVicLpqxgiiUfSTPWWGmc62kQm1C1JPvbp/PUDa1qgp1uTyS4IVVPim6WIpO+/nmHNK2AMFu/pL0yuRenBYoFQ82pHi/UYM4GmiczvUDaNqHV8xKAvDEn5F1alfC689PA8CthVcrJOZXukYFDkbkpxPBbotD0p9HxN4oE28oNkx461wxt09ZTQwRPWnHKVoJWZ7LLrLKecm3tudkB6h3PcMI36+GGidb/HDoQuhd/r2UqJDTr94yLvBF+EMu8RPg9kfcluFQWC2QcVLKpiTr+UbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:47 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: [PATCH 07/14] RDMA/qedr: Use rdma_umem_for_each_dma_block() instead of open-coding
Date:   Tue, 1 Sep 2020 21:43:35 -0300
Message-ID: <7-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:208:23c::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:208:23c::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 00:43:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P1G-3E; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be0fb61b-6530-4b03-3443-08d84ed93fc0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834E2647E343F487E0D37BBC22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 99A//UN9kkcZ8fJGaKgU/xzUP4Xu8dGxWtVAPQohUWpWPBjxLhKpy4T7R8U5/NAeFVA+lz819wBhWNTNBMeg0BpyYRY+2ADjByXIZFizkUVNNlFQ3vP4dH6DFFFYWSPI0anD9vtUVF/iVLu/sRzGAGkxUQp+GuQZw6PsgbGKC4g6n5Dm6ueuWuumcXP+U0AdnJfFzjqZhGqbBFXeiN3U/6WjDHcGWk6hrXmG91awfZdZoDhM1DLbZDXd0gYzbebjryUhBHFoKUl7l//E25XM2ziawpFPC6JjtDqIXDK1Hoq8vrHav7Ksn1Tnz7FaB+Dq/1KFm5NIks4L6Clzq4Vq8LlYHGmQxAfeD+U8Akd+zHuBE4GCbPXIV2EmeKuevSLl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(36756003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YFpY32uLWKnnAXJti6DnCvQF03M2ESjCTMi6lQp42JZj1/u+5reWX+cnlWx1dQpO0zIl8Tpiy1n2LIiuo9XVeSmQkZeNT8fM7QFPZtvq3LGb/CySBMwa7JygYc8swvY17bgcFS27DL9LgTXReDMvP7Xh2aBsRA5BZ6uDFYeIZZ7qrdMi2gxn1TswyDS0GWFi2PedOePtAjjAy+nEBFXHmHQZu26r70A62MUQ89p5BepZ0RVIhJOzp8l4BTJR5pAM4ytjz70apkPUgb9eLkDPaaTFAEh51vGO5te6RieWXGQCpkNjoXAya0dpWMXyw4m7/exFJfA+eMUwiWLK7uIupVgmL+kl36ICPGjDXlPoBzqNzjDPXdUyqhQ6Fk6PFu5f3yBRfqySqHZSzd3FsxJYXP12OhJ1FCgXGVBx1j3d6jNyIZYLQlLZMNZ3T+Z/qdakPxIDD4Yn6aYgHWTTXnMRHKlnVxCVpZsEvcT/n9gYypUvTOoGwEdN7rNyAiPAdSCDZ6Kr02I3JqTKTMhRKN+z1o9zHUvIntY5xYTsI3iNaGVZmcPAyh3vpaqunySPfzMexzQDWv1PobPNoTOq4MwmyAWZdBHJtZqmPEh9gJ/my0GXEs7sasMOofdm+CTtXY/YGmD0hpn9s2PwVXPZhZq5Bg==
X-MS-Exchange-CrossTenant-Network-Message-Id: be0fb61b-6530-4b03-3443-08d84ed93fc0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:45.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jkcPVel4eG8Vi+a/KfraJ/ZP3PSEK97GWAHFA2/MRcHcaBp8lF3KoVSB6yPWCQB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007416; bh=YavJfwtlVVWmDXVat2JsqU5c0OFnfgYgc3/yCx+fJtA=;
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
        b=W7IdbSmm1vvsFqL+3CDdfpXZ3lKsRVp73E2dlSNIpv7ENzgZ4HoMb+V2zT7OH6HAV
         4nV1tgof1lalL2LWHsHWN+Ywj9eRmry9wFPYuelU+svc7/rN5SphmaMyZeVgHaPCv+
         EmBgHkP+v0G5giGTmf7qDc78byJWtTg7r+BzaBWX0hRW5WjsOJYIEC4MK/nWQ1r6mv
         XRsOXMDNr+gHKvh+SlVvW+uLgzctaOh6yr8ObDPioIZNnQ0P9/CQGNyMViCgXp3Xm4
         gnM+AIC6jMCXVJXPH6lqu6MNLg6Rs6wxVm4Ok672zFtE/XIK+YRIY4BRlwVQGVOUqq
         yIXolcoRNJ3Jg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This loop is splitting the DMA SGL into pg_shift sized pages, use the core
code for this directly.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
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

