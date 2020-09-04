Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA82C25E3D0
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIDWmY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:24 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:19849 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbgIDWmU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:20 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c90000>; Sat, 05 Sep 2020 06:42:17 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:17 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 04 Sep 2020 15:42:17 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:12 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S202TeE6LxoArj/pcpfxISVu4RaOOJ0+nRj5fmdtqmBBk8zkaeNQY9F0tDQot+pxpQn7yH8jOMyZFvFvo11MNHZKdqpwYRYWiJfbo2v02tmYA11vx5QzYKXSmWvzdsGGjqLpLVh9Fb5gqcMhayMK04N0V9t8dV9B0hkmJm/9WneuYHHvOGArs0lw2rvxT2rCHtVwc8XPQhhc4u6Hyp66ArrLJPcO75nDeHxTWVQ120oFnAM156CDw5bUypx8dgSy190kSAfvBFzuLroMqqFlKoJMU4vPRf/qoWxUn7PsTnUb7hanM85zahAGP3SzN/kC/+RrkzIoGxLlAoYbyoWI/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TigaYwxJvEBZQqjvGv/rOIfMzzjp+V0cB+2nhDYtIQk=;
 b=N3KXVYsF8Rjkm3MPYJhad2fKY+fhc4SOk4IIe2FjutoK38oi/MeVQ0Du/L+Z6Zuz2d4oyofYNWAXsiH7vn5Ekq99ETuUXnZdiVFXaCz1z6iHHtckTdF74DQS5kf89yxi09px24k1Nqi5xHQdSr57wbbfLvcAaxOLI69sFjvij+mKtv8BkndG1SIlx1Worpx5LiDIlK5CQC3WJk0XUov1l8QDEBuZWnH4fQVZkPVpNQmA8hiItzyLUHDXYxwJAW2sWkdH36Lxx0enLnp9GbDa6+a0rNrbhLsfAfw8vFsiZ4mD/4siLqV2q2/vd1EMqqb2rVkuDf60GttBTVPtF18rOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 22:42:08 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:08 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Faisal Latif <faisal.latif@intel.com>, <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Henry Orosco <henry.orosco@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 08/17] RDMA/i40iw: Use ib_umem_num_dma_pages()
Date:   Fri, 4 Sep 2020 19:41:49 -0300
Message-ID: <8-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:208:15e::17) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0004.namprd17.prod.outlook.com (2603:10b6:208:15e::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Fri, 4 Sep 2020 22:42:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCS-2t; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1baba601-dfe3-4ca9-51b4-08d85123bfb9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2856175FCB1BFB91AAA1A88DC22D0@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vthwxRrvfAnsBtdJ1dX99ptezCkQDBOJyg0aEpNzv1MnnMQXOiEas/iAXcfrjugQ6zDKUbd60HdBplPoeWaj89pFxKcaEz8oMMueMqhjsgr7pbXVXQzu+ysOOuLbdtoPE3CODoC/YHMYIZ87wk8xuAIKAjlErGrSiS/v23AkM2TjydZR4d1aKm/48wT8Ccc6GuU6u2vN0AGKZYi2qFo2BWbpxEEdZjYIpeIT4fOd3H2lEM5aanmLuUO2qKTy2AbolpIGyhi+8T00pyPWvNNhEv+MNYOiKZrLq7OqJI4Pj/ZM5NkmQgpZjMtOPEW2PxvTjTOBSrsyMBR8etXL7aC/IGwvK2UHK2f6n4xlXlOEXq4Zf+gymQMNdJMrry0uVNhk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(36756003)(4326008)(8936002)(8676002)(9746002)(86362001)(9786002)(5660300002)(2906002)(2616005)(66476007)(26005)(186003)(478600001)(83380400001)(6666004)(426003)(316002)(66556008)(54906003)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7KLV3OvF+opzEj+96beOOIjhmZdKh7v9i6zdFVklyRl2GjQvUNA1RpCnCiY+AgvHzIkLblbrlMDRiRCQE3PrSZeISPDC4eyMup0I34aqiHkgRVMXaL+K4TilJ8qXEQd/DHNyOMR07yFMYG4RR1ObYh0rNBqLwpzBjdmQhS54sCTa7nFx0GQXEFehokU29mVRMQh2HbKe7SjE9Mai0clY+srOARGFk1l1miGaaQT38Roq5K5aWsdfDgsinsagOOHCpdCqvpBS/0pltLiThoxmSp7LU5h0HtqVr/tk6XKMddyTJIoTtgY3V9ze0w6tEQ3Y8QeVwGX0K973DLEBfgTUBB1yZpnv6QlZsDs4pC5PBhYdSJTw/ClmgJDVG/Wjqtlz4FiEVwf8UeB9ktvL7n2pxnzabDtZpdaKZGeSKKES5Bv6Lc+1BbshYXCN6J4orf+yfxJS7tSJqYIwMjWw118H1AW9vOyLnVdp7R3fR7y1kF33K++J/QL9kusEhY8MwJmUNG1mnGGaIzSAlceAv8vkTjeHvAPtDpVz3SbXRFecF5em9CuSDVwtmCKqVtZA9VmRjom8GeubHxXTKPc2aEfvh7aGwEo5E2R7lHBgS4bnq89nzY84QxRBd+LfLWbfJpuA8vryx9Kmasj3WjxFM3QO0g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baba601-dfe3-4ca9-51b4-08d85123bfb9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:05.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CK3qeO705X7lBmQ83vHSU3tPDJvd2YMRjdNoUrtaVLIFgecH0vOCZhTIJAGLBVAX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259337; bh=Y9LfiPRq3vkqGDn/3lZekeuVnterUlXjF1IFDPrP/ME=;
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
        b=pjZuX9XaAcpxx/+FIF+ve36dTL1hzrv0GVAKSUEOdWiLHitmlkc9BJVITka1X9ybw
         UVglhHTe6fl/dRY6IubyPUuLv53UP0qlq3vyDUAUT6REyI28s5BhTbeJOJYYNHKbhD
         QW+utIusgk5eAMhM7Ck+js0J098fr+FCF1i5L9drzKRFrFGMolt9jAc3qe2zoQxum3
         xAkhh6eOM15sm5u26aIrYvtpqofJs4eQDCTAeBCNc0gVYUZTBGWpdkH684DZV8NvRE
         IYuGPmtpSFQcGZa9hqhdSVeeMv04znGJQik+/RoRm+A+gUl0I5SRldB0w9WagvZigP
         XYrrpKhL5+LnA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If ib_umem_find_best_pgsz() returns > PAGE_SIZE then the equation here is
not correct. 'start' should be 'virt'. Change it to use the core code for
page_num and the canonical calculation of page_shift.

Fixes: eb52c0333f06 ("RDMA/i40iw: Use core helpers to get aligned DMA addre=
ss within a supported page size")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index beb611b157bc8d..ebfece162f98a4 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1743,15 +1743,12 @@ static struct ib_mr *i40iw_reg_user_mr(struct ib_pd=
 *pd,
 	struct i40iw_mr *iwmr;
 	struct ib_umem *region;
 	struct i40iw_mem_reg_req req;
-	u64 pbl_depth =3D 0;
 	u32 stag =3D 0;
 	u16 access;
-	u64 region_length;
 	bool use_pbles =3D false;
 	unsigned long flags;
 	int err =3D -ENOSYS;
 	int ret;
-	int pg_shift;
=20
 	if (!udata)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -1786,18 +1783,13 @@ static struct ib_mr *i40iw_reg_user_mr(struct ib_pd=
 *pd,
 	if (req.reg_type =3D=3D IW_MEMREG_TYPE_MEM)
 		iwmr->page_size =3D ib_umem_find_best_pgsz(region, SZ_4K | SZ_2M,
 							 virt);
-
-	region_length =3D region->length + (start & (iwmr->page_size - 1));
-	pg_shift =3D ffs(iwmr->page_size) - 1;
-	pbl_depth =3D region_length >> pg_shift;
-	pbl_depth +=3D (region_length & (iwmr->page_size - 1)) ? 1 : 0;
 	iwmr->length =3D region->length;
=20
 	iwpbl->user_base =3D virt;
 	palloc =3D &iwpbl->pble_alloc;
=20
 	iwmr->type =3D req.reg_type;
-	iwmr->page_cnt =3D (u32)pbl_depth;
+	iwmr->page_cnt =3D ib_umem_num_dma_blocks(region, iwmr->page_size);
=20
 	switch (req.reg_type) {
 	case IW_MEMREG_TYPE_QP:
--=20
2.28.0

