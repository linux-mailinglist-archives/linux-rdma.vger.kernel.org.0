Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1125A261
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726064AbgIBAn7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:43:59 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4730 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgIBAnz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eeab80002>; Tue, 01 Sep 2020 17:43:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:50 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:47 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgVPOlUsG2zyqgO5X1IAsHvlqR5Ab3WK5U3kIcTj2FJx08qEBtcJRvOdBkHIFh6YbhP1bDriugEjV+S62ig3elr4K1hC2042CQ1woZuv2u8Rpi46LolR4IAZ8ViuYhR//h3+6G9iJQRo8RD7+MfP8F66520zCC0ncbwqKjEbtyPfBKHicOJuuF0XytsWnUDrkf9dUfZydJbl9lFAX4EAhPEzS4SvI3h227Vzj5v4nwnWY6hFx6F4H3gMV5tBMgAwSRoaP5tx7cwuYDFsAPu+UdTzzI+Q6hHgMVzsdIM3sA8JqB1W4IeDcxlIxZzZLHbhgIisyH6QcORYpcV0wrCJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTgkhrMQltTW0THSS3ThQVETG4k+1r5/RWd66yIhIZ8=;
 b=RDIlfaa8JzeSb8ye2VG5YqpvvqaqfgQNpGWIIJgZ+cucswU+gpSwOpknCSjAfFAlPa8D5mLKaKW57vhc1bXJhbNKoPdUUtb4S5/ERXlG/CNS3RhQPbErScIifTjUmEqnrRS6eELx6/zKbV1ijnl6OFsXFGKmioXtSNWIrvnLPx+WdXWXhaeXzqZ3oYqa6az+DmT68FuAlno8fdD1TC9uR6oaHQtDOVDpVgccMkU44+oNBD2vg+UzJ6F++LS3N68UuqpbwL4IlYh+zeMRvbq4glaNFk0McUN5WrGi+7uHkuu/LhMRrgKLV8iW4xaajemCfRcmJldusirsbrpbvi2ygQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:46 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
CC:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 02/14] RDMA/umem: Prevent small pages from being returned by ib_umem_find_best_pgsz()
Date:   Tue, 1 Sep 2020 21:43:30 -0300
Message-ID: <2-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR22CA0028.namprd22.prod.outlook.com
 (2603:10b6:208:238::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR22CA0028.namprd22.prod.outlook.com (2603:10b6:208:238::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Wed, 2 Sep 2020 00:43:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsI-005P0w-Ta; Tue, 01 Sep 2020 21:43:42 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05d26dc2-0e47-4d3a-4bd1-08d84ed93fa4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB383459A77EE1D92502F9D401C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIwqHciu+NVLgbN5ntOGk48wpDXo7Jrtp152gCDiVfAwpIAThPgrIWhI2XM/sNCzmCzXTLQjY9Clo9g4pm0hxzvb/Pw4pKFldIh8VNJpr+YMU28uMv7DMGpMNa8eVTzhU9QqJT5xbiQR/XUa6E4QiHKl+EOKXiYIDeSV/4IIQp2Yk0j2bB78R/tJW4Ugn5wq3X052cz33JTTvnLgds8ouxZVSwuOEas4AnQqLfXEEsBJzUbar+cXtZLZJccVAUyehev6G82LHmTUVX010FpaC9jNfTugJWxooJRawtON+SgxdE/Mhnp48EVkPT8sxrf9f/86fIJT7ML8+Qi3K1VKbj7zuB9sBJDY63BYK8eVEK5Q+qqeSl9QzaCNUxuV0jC8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(2906002)(36756003)(4326008)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XoHYx3rgFgJigu0Js9sCxm6/3rif9EwTz9LkPSiDrFcTvvIOXo0lPZdEzUKQ6d08rtqKR0X+4qM0jDTvU0fBth8YjkUbuqSS6lGcqQjmZoojYIEfZQ4CJLTwiovjwFw2UHV28bJEhsXDcEzr/R7fEds45HUz0rtJGtH5jl9RFYRjRmKULtU/H2G3YiRj14Mpr4Q69BW4n/19x+tgpI95khqWjQ3LSGxycvYgr/EXSrG1gb7BPWidQfNuopI1fRU1pmDpVJ4jSQ9EAaawMmqbWR9kjm/FmvzVwtpcj5qgSTbEWKZnElYQl9Ox2KDuTBthYXaB14XdXVgJrF8iMzoolFEsogInimN/ngALogt/FBQHZ5RGRUgf6Re824B53JgTulCqLLEziL81H8JxrmFD3sboQtAYbRXuNxvaIM+xuVmw+pESvZAWlU+tcE3FRsNrtHKnDjrmR9UvKnj91BRBTSjJuzA91PIxmKsfqyAhGHE8kK6WqF6tUqMIxma0pyDvRYhOxfHIB4oBteNge57igc1cfY4nCxuG6LFzeOfsrggjWYun21P4KzSfxfKEofGAFmAFOVYZ8Inq2rPrvNlC0jhIMpjZyKv9owFDtFC2OcgdPe8S4qxxeUY1LOdDLkEKU2i3PwIUJo3fdeE1qflvNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d26dc2-0e47-4d3a-4bd1-08d84ed93fa4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:45.7695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRKLCnWJLalpM/4//IZs7vwHF0KF+WdRnzIpAsgOAuNmH4ifInsgXwqiekovFoU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007416; bh=QvG1lJVILdwqSee3muynQ49ud7q7spIZ6ACPgDyYbUM=;
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
        b=YVswzPeOLTV3ESEc0lCTGobFESj3an/Zwjfk7HfDp5AJOIgcwUsYko+wv41+Irfqf
         ijLLbJqWUQZfk8PWqH49RrT9VQJnccQZYAOe+SxVMUKFnNImJLc3kRib7AtF4fCqgg
         TZ7Ydnfk6/tpuQpLze4GnjGwAPHiJNIjJ7MpIiTRy/phazO+B19IHAwB4GgZ3Se3+r
         hGBqbKktHZrfyiOBMphh8cXlh2krafC6CGw5XvyXTUn68/1mwYPjp8Vrks9n0u99Lg
         XMakPuqRzs5oiTewB7tqG4mUK9mFFjEsd7mcLGhTUD3HuTdpFKbqp+/BIaMWh9cyiy
         iB5o1wuK9DPHQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

rdma_for_each_block() makes assumptions about how the SGL is constructed
that don't work if the block size is below the page size used to to build
the SGL.

The rules for umem SGL construction require that the SG's all be PAGE_SIZE
aligned and we don't encode the actual byte offset of the VA range inside
the SGL using offset and length. So rdma_for_each_block() has no idea
where the actual starting/ending point is to compute the first/last block
boundary if the starting address should be within a SGL.

Fixing the SGL construction turns out to be really hard, and will be the
subject of other patches. For now block smaller pages.

Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page=
 size in an MR")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 120e98403c345d..7b5bc969e55630 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -151,6 +151,12 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *u=
mem,
 	dma_addr_t mask;
 	int i;
=20
+	/* rdma_for_each_block() has a bug if the page size is smaller than the
+	 * page size used to build the umem. For now prevent smaller page sizes
+	 * from being returned.
+	 */
+	pgsz_bitmap &=3D GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
+
 	/* At minimum, drivers must support PAGE_SIZE or smaller */
 	if (WARN_ON(!(pgsz_bitmap & GENMASK(PAGE_SHIFT, 0))))
 		return 0;
--=20
2.28.0

