Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB325E3CA
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgIDWmP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:15 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:44044 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgIDWmJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:09 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2be0000>; Sat, 05 Sep 2020 06:42:06 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:06 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:42:06 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:04 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdtIpmvjtnsY3ZhYz2fu+KeeRLkvEfVl0e3OAyxmYqKO2QjgU1e2E6g0+EpaHYJn1RYNXo7O/YG1pQ39IXV9qqf0ea8HciCx/0hFCORTP/NzgBlM3oJDhFjcQK4mZ51qqpgscRPktbG4rhIB1jzVUXMAjonNxNV1yRdgRXwJ9IrUQYC3YsSSTsU8+vMH+tpxDVEa5soK9pf7dLIZEdHxKAtYdFNRciM5n+wqvGArfm3PJEoZymQcy8NJOWJnr/MyEypEqBvJ2rxFnw+Nb9LYAva8UG7VOUghAd1GxX19c4Tjn3gaF/IhXxq+ah28rvSI2Dz10YwIebxVNmfojcWvLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/UbOXpXA302TPxzBEWcqkxR/LSBKG8cgcPd///qEBA=;
 b=hqC0vM1aBRffOUFT+4bPDYhdTKFb2mJLo5km+DmbOFItGylbRxMDW5oGaro/FTFILc6kMFCi/O1zNgegT+mWqj1RHO64uVF0IBaOtQWPYCLpztKzOl836sDBDSJsnmJJeqfWdkMGoxap8n/vWBQ6zRuvaoFb77QmC8FG4+Bv4dW71UiC0iGLwjyanG/fhnWlzC9KbtzivAEo+dfVtUWKYjbNhmGCZS3OyR+GA57GUlUb34g1JnF5wd98fJriNGS5GdgvVd0A0M30XKp0Qe1H3CG1dzfHmLtavUGPpRxzQpA/FL6LLOsJ9MMkzSOqUeJzhscCROmwM8HT6PWdxFJvzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Fri, 4 Sep
 2020 22:42:02 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:02 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 01/17] RDMA/umem: Fix ib_umem_find_best_pgsz() for mappings that cross a page boundary
Date:   Fri, 4 Sep 2020 19:41:42 -0300
Message-ID: <1-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:160::39) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:160::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.9 via Frontend Transport; Fri, 4 Sep 2020 22:42:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP8-001vBz-Pn; Fri, 04 Sep 2020 19:41:58 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fd7ce16-c789-4b4b-00eb-08d85123bc99
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2806AAF6B204890D3FC775B6C22D0@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6ZSEofuS03SLsv6hDouG6/g0oul3+ADjtbKPVbnLKG2daAvAYJQGvyIQH3N/Tx2bTmRM405Lv9odFFdXWfUJs3L278FnGGWcoiPDwUes4knHjwJVEIICgD+ZmihvrtJVSjuYN/WIFT35ZtY2YtauCvz9980fYbJuu1EtRjX4sp+7N1+BKJYUa4Ax/fdr8f1Ybf1Z8tPdkwNxpNz5mX/x6ak9OqZdZpQWjSEozZAX6X+ApxJhStBvuuFpU1RutCKmyhazOZLKczhCDyuMMgwMpSdWKwK48qko/lUJJ7ZxoAvwkbTF13oQqJQ9WvFenIH2e6jnP+a3qEIWHFTGEmCOtzReWTaNN09k5skzljLOvkShG/8PQEB/e7vix2r9L20
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66556008)(26005)(54906003)(66476007)(6666004)(8676002)(186003)(316002)(83380400001)(426003)(2616005)(9786002)(478600001)(36756003)(9746002)(86362001)(8936002)(5660300002)(2906002)(4326008)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LdvpLq+FxSXWY8OLjrLqMNHsff1SpMmE8zXnNCowa8bnBVzuwS6IKzzGyr4RGOFZafPfMbH32Q3gX69xRTZewv46hVDLMenH81cFtQqVLf1HMXAE1at77l3k0CJ5GWzq57cmVbxtkLId5O+AK6wNIA7XV9rWZTC7xCZSjpRY3r5laRix57okrugckbIE0jhqbFiEsW9C2gnJZ5hPgs3n4cHIW4ALD5Rj06ArlM6GCbEMmu5XI8tjQI5ecZkIqDoUdeq0gJcX9+OBz2pO0rQZTpOTzASogg5qLQHQVsTefGJJqlB5EC6/VflAv6++scq6GZ7AqPzEb0pQ8+P5/SaALmmabQobensjduShlMhTwc50iDKjdD08mWY+Q3CPNa4E83/ICFhH9QG9tYSUrYRnSisAVDNyvdoOV27aaVsy7Dew2WOL5Hg2I39DGS3k9PnoS2j0fENF1opdB5OmWWpEogApQ9ZkDWVz1QXkInYAB28v6rac2J+2VnrqgHY1vrJXgZkJPjTM78WkQ3dVX3N4Ij/KHymLli8kqAt9I5GMoMRjpqJQLuKAx0SbukveZShUX0dgUeUm1dA2Xlxm0O7YCsna9fdYrrqJMA6ejp7Nz1pOd8B7VgT8W+QceZ4oJ8E4UuPGUmMHZnmos4TqeEDYwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd7ce16-c789-4b4b-00eb-08d85123bc99
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:01.0839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coCQD9+GWaHAQjcrccH3tVgBrJz9Uh39fVsc1hYkVhsI7fepi19NBgCiFNw5GqaM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259326; bh=xm2DZjBst7h+iENmbRBi3dU+4re0mmT2hZqJzLUSw3E=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:CC:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
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
        b=T43n2FfQt1Xzaur5LO7VMJCkhhDCMbtToFdQqzjap+/JZeR2zsn/VVKI/zAeMR/om
         NcicEWmpX4OT1XChlcvqIHBGwFDNxwy/GgdF6hcuQgCv8YVOQIuS5hnI45V4ONrN6E
         h8uSDPk7dnsunMTxpp7PLuGqy6l2TibHk067IZPpDJ3yghwuCXP4iW3zBSMy92JdyC
         XKGr6RUjBnnE9crYhC3kn9rreltsou4DdDRqEB6zoS01lSTce+3QqJ6jz2bVxUMj/f
         0nDpgEJkSq4PJ/mY+uG3RaQQByAgKGFEbNnPhu/q64LzX7wF8E+LQhjFha9/TJvEqX
         7tPJpp0Plf7Mw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It is possible for a single SGL to span an aligned boundary, eg if the SGL
is

  61440 -> 90112

Then the length is 28672, which currently limits the block size to
32k. With a 32k page size the two covering blocks will be:

  32768->65536 and 65536->98304

However, the correct answer is a 128K block size which will span the whole
28672 bytes in a single block.

Instead of limiting based on length figure out which high IOVA bits don't
change between the start and end addresses. That is the highest useful
page size.

Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page=
 size in an MR")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/umem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 831bff8d52e547..09539dd764ec05 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -156,8 +156,13 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *u=
mem,
 		return 0;
=20
 	va =3D virt;
-	/* max page size not to exceed MR length */
-	mask =3D roundup_pow_of_two(umem->length);
+	/* The best result is the smallest page size that results in the minimum
+	 * number of required pages. Compute the largest page size that could
+	 * work based on VA address bits that don't change.
+	 */
+	mask =3D pgsz_bitmap &
+	       GENMASK(BITS_PER_LONG - 1,
+		       bits_per((umem->length - 1 + virt) ^ virt));
 	/* offset into first SGL */
 	pgoff =3D umem->address & ~PAGE_MASK;
=20
--=20
2.28.0

