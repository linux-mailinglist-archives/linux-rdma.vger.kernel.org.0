Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D781625A263
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIBAoH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:44:07 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4744 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgIBAoA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:44:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eeac00000>; Tue, 01 Sep 2020 17:43:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 01 Sep 2020 17:43:58 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:46 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R55j42qEoaLL6717sxaAK41J39cosUAIiG34VyBHPJvwLPchUWmf5WfEIyzKNc4rPNEvDGAyK5RC4kIMYrpzp76KosertfmYYccwItpewt4W9bCMEq2VqNCZfCJkL5f/84kqTLyJWZBJy6L22e429RgVQUP3cV/iJY/6+0EQmLMpWLswZa20e0hIE0SRpayq0OG2qcoq8G5sHP4oDI5DHVlVaNqTkiM+sZ5WhcLh2Oa0g7w+pgAxwdUn9eD9041KmnkzIyDKm90qVBGcKE0TGUwTVYg/e/KPDF6yhqk1N6Toh9ivMNaZd0SxsHUjGF1ISzwb1uPW/SW+rFjSaz2weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugEiHByo2YYyO5mKFfIDBSjXEXoPtQ7E+bIuhnvhThE=;
 b=YoHR3NOmge6ghYePRK7KEY2So4mv0Y3+p9wAgKlkRpGmi8+VFYyplcKRCfTSpxLuvmrUPJ+34111rz9rSRbrQir9s/kyd4TJWDhlYOasoJ81R4/9JSMjMUMNIUQeTEXgheGpnfvZyUKIRpE9KrBXCCfhgRJjh1npHql3fqBuiQxuUuo91NGDMh1SZDEJ6hPt6532TFCrFKiywd42k3aDE3UHcKfUiyEdJ9zv+Y9qgjZ5KMYmunS3L1NalweNahuft0xyNYdcMOTwXfNbnopZgj/d4QKm6jC9MoICqQqLhwyYqJjdETuq9IkYiXS7xQrH7385BuKiWx4/pf9P9ZrSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:45 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        <linux-rdma@vger.kernel.org>, Weihang Li <liweihang@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Lijun Ou <oulijun@huawei.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        "Yossi Leybovich" <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH 04/14] RDMA/umem: Add rdma_umem_for_each_dma_block()
Date:   Tue, 1 Sep 2020 21:43:32 -0300
Message-ID: <4-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:208:23c::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 00:43:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsI-005P15-W8; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60186838-11a6-4ede-dbba-08d84ed93ed8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38343252C629E16E86ACEEB2C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKSibm56RPgdV9mxFBt2oK8S0YXbMDkofKc0WgwymR2OipFJaYsCDTAPln+VNt95bEl+D7b0mByahF840DyzGQdlsGNZWWrVRYNNk8dewyeAWyB+Oe0cBPKD69xqQrOnskB1OF+mOyHnQFaInRkUAbTAER2gCKX4FTPJrXZvZGcoVxOLfa6evRGTmAkb3ktdRx7i69yi0q3VuDRybTvDVFW+2sgSPwL083jRiGjuXLE0+I1AP3A1G1K+V+QoIkboT4XSjVVtUHC3hQdsfH8Mpe15Ca9VHriRpxTyiaF3KOd08f0rKHrFgOQtJGO/0S8J+cfFUuwmpDtYmMSTBVicFdfU9gDFHGUnwTen8tQtrpmgINrUuU7355Yg2xtbvKI3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(36756003)(5660300002)(7416002)(4216001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DeY0ajBNUSqf4hnR2lSOjZLewZSa5lthyKZUWeXfhoL80om8ya9u7jgBu1liKD7hr9Muu0H16xmB3kcqX+EaSgklGDFiaQvJ6136Ggq65v8NJiDe7KeAjK990CiXSuoxZ1km88y4DXF7ij+Jg449q13zbNTAd88qw5/jja10xdR8AjSIpC/ic1USYcekF+N2HhSUNOkMNrHzbspPjQkAANeA4e/AJQNIzN01PTxQYkw0B45d0pvuzP9PtxEFoBKjI3mhVH1M7mdBUiL/DjfY9jl99fjJ+xTbqgM6hUSb9KUt19j2jS8iOYRCwY+Iy2l4lSZpoGY362IjdwNqBGKi+SZcEtmDq+ZFzK64lh49ZEbZ7IRNPisXIZyx9Hi5nwb1Lr4UhgkC1c7ZHgK+VUNgxXCBRUwBB/MWLPuMRQl53M5I722J9Qb5xq9JT6dVhk0cElfMqLVrHxXEbLhmn8AOW20qwPHbiNjkMN9QDk66KOTRyjO7ZLbjkjfUBPATa3tYrqhhoQK0TP17rl83uFErjvmiPxliK05XAWBNvVYrDxf2Ey3WSVZuN+4LmNqt5xd8qCjXi3MRgNBzYA/GYDuMkR8UybDf/956LBbUvQ1bfTsoBSqUleULpf7G6DYvi5wlb3PwPTC/G6Gh+DnsRs+iGw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 60186838-11a6-4ede-dbba-08d84ed93ed8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:44.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHLcvNCV8KGjI6btDkWbH8fWQ6f32HFxdmhMkzctq8559orxJyKvOhr4LuAvuFQo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007424; bh=5ygfN42oEPydMocRVNOqhxPwuxzxUrHo5qejxS12HEg=;
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
        b=X6QzbQvUtten/lh+/K5ElUQM+0gOYRCzTxHmIWmAD07DUKM4wwfCraJifLQAxeIhY
         8Z5Ibf1bVzm2p4HWfrDypZh6tD1bdYiLIaZrUrz+iCMOB5q0p4g2p+tMB1bboe3hZz
         bbQEDbNKKlEMrOgd2YbACt19rUcW8mT+F5w+9EHSJSg0CvDQIZ5z7eUpDhby1JWAeT
         nmDCkd6XRPnJ5fB1v+JMevEt42VFmpNkRRm5M0qaoJzndKm4AbBLo+eCBNBArc3CFK
         shks94r/qXvUfcEhBKIea7Ailu3mwpjK9tBI5mKvWd1+pooqdpSBOrvJZg8OxylBj1
         5QCQ3Mj7e7iuA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This helper does the same as rdma_for_each_block(), except it works on a
umem. This simplifies most of the call sites.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .clang-format                              |  1 +
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   |  2 +-
 drivers/infiniband/hw/efa/efa_verbs.c      |  3 +--
 drivers/infiniband/hw/hns/hns_roce_alloc.c |  3 +--
 drivers/infiniband/hw/i40iw/i40iw_verbs.c  |  3 +--
 include/rdma/ib_umem.h                     | 20 ++++++++++++++++++++
 6 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/.clang-format b/.clang-format
index a0a96088c74f49..311ef2c61a1bdf 100644
--- a/.clang-format
+++ b/.clang-format
@@ -415,6 +415,7 @@ ForEachMacros:
   - 'rbtree_postorder_for_each_entry_safe'
   - 'rdma_for_each_block'
   - 'rdma_for_each_port'
+  - 'rdma_umem_for_each_dma_block'
   - 'resource_list_for_each_entry'
   - 'resource_list_for_each_entry_safe'
   - 'rhl_for_each_entry_rcu'
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c
index 5ee272d27aaade..9e26e651730cb3 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3783,7 +3783,7 @@ static int fill_umem_pbl_tbl(struct ib_umem *umem, u6=
4 *pbl_tbl_orig,
 	u64 page_size =3D  BIT_ULL(page_shift);
 	struct ib_block_iter biter;
=20
-	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap, page_size)
+	rdma_umem_for_each_dma_block(umem, &biter, page_size)
 		*pbl_tbl++ =3D rdma_block_iter_dma_address(&biter);
=20
 	return pbl_tbl - pbl_tbl_orig;
diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/=
efa/efa_verbs.c
index de9a22f0fcc218..d85c63a5021a70 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -1142,8 +1142,7 @@ static int umem_to_page_list(struct efa_dev *dev,
 	ibdev_dbg(&dev->ibdev, "hp_cnt[%u], pages_in_hp[%u]\n",
 		  hp_cnt, pages_in_hp);
=20
-	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap,
-			    BIT(hp_shift))
+	rdma_umem_for_each_dma_block(umem, &biter, BIT(hp_shift))
 		page_list[hp_idx++] =3D rdma_block_iter_dma_address(&biter);
=20
 	return 0;
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniban=
d/hw/hns/hns_roce_alloc.c
index a522cb2d29eabc..a6b23dec1adcf6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -268,8 +268,7 @@ int hns_roce_get_umem_bufs(struct hns_roce_dev *hr_dev,=
 dma_addr_t *bufs,
 	}
=20
 	/* convert system page cnt to hw page cnt */
-	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap,
-			    1 << page_shift) {
+	rdma_umem_for_each_dma_block(umem, &biter, 1 << page_shift) {
 		addr =3D rdma_block_iter_dma_address(&biter);
 		if (idx >=3D start) {
 			bufs[total++] =3D addr;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband=
/hw/i40iw/i40iw_verbs.c
index b51339328a51ef..beb611b157bc8d 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1320,8 +1320,7 @@ static void i40iw_copy_user_pgaddrs(struct i40iw_mr *=
iwmr,
 	if (iwmr->type =3D=3D IW_MEMREG_TYPE_QP)
 		iwpbl->qp_mr.sq_page =3D sg_page(region->sg_head.sgl);
=20
-	rdma_for_each_block(region->sg_head.sgl, &biter, region->nmap,
-			    iwmr->page_size) {
+	rdma_umem_for_each_dma_block(region, &biter, iwmr->page_size) {
 		*pbl =3D rdma_block_iter_dma_address(&biter);
 		pbl =3D i40iw_next_pbl_addr(pbl, &pinfo, &idx);
 	}
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 07a764eb692eed..b880512ba95f16 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -40,6 +40,26 @@ static inline size_t ib_umem_num_pages(struct ib_umem *u=
mem)
 	       PAGE_SHIFT;
 }
=20
+static inline void __rdma_umem_block_iter_start(struct ib_block_iter *bite=
r,
+						struct ib_umem *umem,
+						unsigned long pgsz)
+{
+	__rdma_block_iter_start(biter, umem->sg_head.sgl, umem->nmap, pgsz);
+}
+
+/**
+ * rdma_umem_for_each_dma_block - iterate over contiguous DMA blocks of th=
e umem
+ * @umem: umem to iterate over
+ * @pgsz: Page size to split the list into
+ *
+ * pgsz must be <=3D PAGE_SIZE or computed by ib_umem_find_best_pgsz(). Th=
e
+ * returned DMA blocks will be aligned to pgsz and span the range:
+ * ALIGN_DOWN(umem->address, pgsz) to ALIGN(umem->address + umem->length, =
pgsz)
+ */
+#define rdma_umem_for_each_dma_block(umem, biter, pgsz)                   =
     \
+	for (__rdma_umem_block_iter_start(biter, umem, pgsz);                  \
+	     __rdma_block_iter_next(biter);)
+
 #ifdef CONFIG_INFINIBAND_USER_MEM
=20
 struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
--=20
2.28.0

