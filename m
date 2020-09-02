Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B625A25A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIBAnt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:43:49 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19887 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIBAnq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eea940000>; Tue, 01 Sep 2020 17:43:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 01 Sep 2020 17:43:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 01 Sep 2020 17:43:46 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 00:43:45 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEtQZtk+EPEhYfR4Dv5DbT7dJG+u6uLsteiG7JVPCiIEv/OTrKYFchbCdjvJMbyDDrySLaTVJnA8rwOGPe+HDE2bbXtb3rsCpme+AoYbrHceIEIYef/GDGOjqAvUEjYubDJ39fHLLlWO5twujD0RIb8iPxrffYu5LmQDGqtvVJ7IyqR0L3/6bwO8ZJ7gtwkicRunvBuDjJwV0cmPn82lg4wb0KWiLRzgd7t9CTKivc2uXnj0kFRHVR1YZzTzUYE8iV9k27Af5Gmj78amNToSz5rl7UZN89odRjIFnH6YqVyHW0ytUPjL9IZJ42FjU7WSZ8CBTyl/Ht/1rjcQD4QlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SVsiczsrf7qHCLOm8C6KAquXodR9O0JPdkh5DFRqhs=;
 b=Bku4rONN81kVFISRo/0+2x52YgZ9ms5nETmMppM+5n68OmxewEUBB3JYHUvG2IcZtZ/9BFW2iCXyiyErzKyjzLOz+6U3ote+6Cp4qe+ngld6wjgVz0kBDRNCOs23PMUADPY3foamjUqxEEZ6ecyHRBMXZrGnolavpKUQQXTjsmdQz8dkzYI3OGyCkt/f81lme2XjoD3MY53INg3eKoJO1zSibFUR+cpqr1xruztg1uP9GWQsLz5SIyQY99vigV11Xl6wDSn35LOoZ5c3mKyV9qxLORWQSiBhlc9RtE8EzIFodT8xop26DSqhC/j/yyGV4DlnC+GJUu6FkdC+U8apQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 00:43:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 00:43:44 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
CC:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH 01/14] RDMA/umem: Fix ib_umem_find_best_pgsz() for mappings that cross a page boundary
Date:   Tue, 1 Sep 2020 21:43:29 -0300
Message-ID: <1-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0035.namprd19.prod.outlook.com
 (2603:10b6:208:178::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0035.namprd19.prod.outlook.com (2603:10b6:208:178::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 00:43:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsI-005P0s-SW; Tue, 01 Sep 2020 21:43:42 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6aad2ac-8260-4078-9ce0-08d84ed93eb7
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834766604B506A6F2B3A82AC22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: donNGCbHORN1QA+8KI2nuvScPeH5WtlbtZt/t1x76z/yvl0h8qTp2/QdMc0riNM9o5EnazxHflP/nfTaSulJbEm9ZDjJaMuoYnfF3GUHEcQNC5NiRAOsXBFkTd6vnoXMxin28QGKOfTbjptsbnJsnSCefvA7FnHaGYuuKqfzI05yzP5pKbCtxXP7/JbtO7TMC9jVMWqjCJwyNnYzaN3X71N09jV6dQxUqD2LQFIIVFH8VxaVND1V08svxXILUjrBbAvySwkT+crG8sFn8eqneKdN/a1TUgEJoY7FE/M3vKvzC25gXEZbPLAnvS7L7D1wwOHq+B4BZV04VRLeasv1n0m08yoc3ml9sUaJOFhsqQbVj6JjSlLLihmMeT/XfKUr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(2906002)(36756003)(4326008)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 46k4HoHIODhFYCvU3mlrz+uguErA1FVQaI9lNwjwI5IjZBxXRzsqHyS5eCqMxpfS9+vxiz2Ad2JJskS7aLwHPtg72Ga7bIWr1r63uBShqO+dQxo90yyMfVpCi3jJu/3eg1h87fbTtoDXcXSbARaAXRlKOPvmWTHWY8SYhRLpFW06ATlGbWCzFavrJodrTm2RpltYAj+b31LLUhiL8mJ0lKXKZRpkYe9+cN9Z3uVjudHKZXkLVPlktRDLQlNkNCuY6DdQ8ReQN4YqL/nXV8PcBf1hoevLBeef/ORwH3/bYFGSFpSYeocXATh+jCQHuDI8o+wGwz4BF0ET22c7UJfkBhmKh7p+30qURv3uKxy1XM6aHA7WKFtanYTtTYoREGGgKr+ZoHg0fGBBkQeEUJDUJII6h02BQA6cqlm9e06fc5DHwHazpTotI3RdZlEIhw+EkoUfz855t9uXxdBIUwwoVcCofEcif7iY8hIyRGgjhWpLPHaMfPbFux/WGrDPoR2JiR1GN8JRwLyPNUW0q/VuWE4VhgSdCuT07r+snKX9Saf50a2UuYiQXiTwnC6xpLrwGHST3QDtkF2nqC2pCr6SS2uxAlyDKdzVj8Lci0u52NvEdpfIlxFTK2ogmL/Ih4WIGFzDQcyTjrKq/RwtfxtKOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f6aad2ac-8260-4078-9ce0-08d84ed93eb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:44.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWcAbNlWwhSZFWATjOio5riWPLz7o9ndU01TDNSs/1cWrFaKiDLypY2hOyZj4KfS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007380; bh=aajdUvGG+xx/rYkiEYkiq6w44LO6MPnf4GzKdUfmbG4=;
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
        b=Y7cZtCMW5sgKiOA2EQpAs3QLoBpotGBL9koQKnn3+ibB5zjYevrlRIT05jJXme0DO
         iO1SSsuK8zA6GQVIBfzFWCxhjssjyLQVSTJFDaKdW7GCvRLfeyRbyxrRRLK1naT4Qj
         PkF646evRIIbOeAgKQ/R6qBYN3CYvcviJinT9ryO3Ba5xG6DlrDA1V93aH63k6ZK6n
         d2VwdSIwzV/WkHZhbOAfUOM67or/C5ZJLeATi5fDHXP0XHrIHH5Z+CbsxGQ6ebtCyR
         NiAK82CmOVr68ROsPEy6v7d5savDY+oIlAWq4TWGUSffN4wZGS1KVaZ2S1Yg5IeC21
         avlHWR7YZr/TA==
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
---
 drivers/infiniband/core/umem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 831bff8d52e547..120e98403c345d 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -156,8 +156,14 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *u=
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
+		       bits_per((umem->length - 1 + umem->address) ^
+				umem->address));
 	/* offset into first SGL */
 	pgoff =3D umem->address & ~PAGE_MASK;
=20
--=20
2.28.0

