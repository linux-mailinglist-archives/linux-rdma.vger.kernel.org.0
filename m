Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC225E3C9
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgIDWmJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:09 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:65190 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728098AbgIDWmH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:07 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2bc0000>; Sat, 05 Sep 2020 06:42:04 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:04 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:42:04 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:04 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APzj8n3k9m/betCMe1k5K2jlMik3FSPZDyPm0eB6hSdVAUUNjAOfjCXF3QhsDQWco7fDZqDELdSJ9VT9I8LxnWWlIdxSuh/UIcnD2yaQ+INVJ/K14mew2oG3Eg+YOBvuSci8cvI4fWeNvCyBl2Of+K3c+qaEz4UvP/t4rfn1T87mynamnU5Z7uTU/CRQF6ScBMr9hRIgWGvBFZLUKt1h3+xQtSB5901FYuI7iRmipkqeFxYx2cQEt/Su5xxqk7BSoH/qOA5iy/vHeJnE8Jc1Nf3NtKk6ympIneXyptRjAJbwXoudGLKYh9XtNZYNeDFgusT65guwpvhErVqE6FV0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53zrpZr+2Bp1LtMts7gstfGPV5t4KE1YTqVw+rH3p3E=;
 b=ShQdki5z0M9QMF3mxYnxxC0DC0+LNbOvg4V7GOp5NKxN3JFWtHV9o82UhI72jhVGFJuu5/8VXoS4zfE7y8qM3emopDk0kHMXHLh77gPFy7PxdmgJ4J/PnV+pSBHkubRu1sO5u8K9vEZ0LkUu1jVR7N5KMl7YIyCNRRYwk/kfJLYFtnAnO+Bk67yv3/COlUWkD9sFCx9W3cYDmvFOBoy9TpmjyOnY0DIXXsAo9t/tXM/uAhorau5VEd0Gd45XvrokAZOCjWBI0B41so6V+kclOMhE+tIR9W2sORLPAcj4qQnO/t756WueLZqo3XwqtpB69EISpwFZ/v4fT4LKPBfusg==
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
Subject: [PATCH v2 03/17] RDMA/umem: Use simpler logic for ib_umem_find_best_pgsz()
Date:   Fri, 4 Sep 2020 19:41:44 -0300
Message-ID: <3-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:208:15e::24) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:208:15e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Fri, 4 Sep 2020 22:42:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP8-001vC7-Rs; Fri, 04 Sep 2020 19:41:58 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37e65c17-f280-44ba-a18b-08d85123bc97
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2806E8A2A86A6CF24C95AE9BC22D0@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6zAfP7FpjyMHmqJhVNJiOfzeRdyy1yWDX25ZzFbZ4R0C9sOiDula/W0+yF5mUle0nJeH0tO0Vji/yq0S3EMsWwhPhnlV8v0+OlmE/EIOTOUiWbXAZiZqwwej7YpXndym1Ygym7WJnpVbGsVt2izakyfC6K8U+T7NwHR3JdMwSeHOedvyBXWmdx5dk4E7bucpGh7A2Wf+w7RbZrOzv14A5R4CYwG423kRpe9dJPd5UkXTi85ukNz+XVjgR9I7BzcxGc/B7VAsZCNbEQU1aCFtOrPF/THybz/YLh2SNjJVDOvfLJcQgunl9DFtUxJv2PED7QqcAsmqFBem3ClTuSblQD4xQikM3mwcQiyXf//zeFDkefPGFMC4gHd7zriEp7af
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66556008)(26005)(66476007)(6666004)(8676002)(186003)(316002)(83380400001)(426003)(2616005)(9786002)(478600001)(36756003)(9746002)(86362001)(8936002)(5660300002)(2906002)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /Yx6V/I1RX6vX/RZQwyUejzblCjHskDiyP49AAp17NxXQTzV8rEJJF6oggNdWFCpChPUV14f2Mo6dGkkiPlT0d0lomvRaWSm3Q3gabUh+yw/BuYCu5Q8E3zKjSY5roZ4vXwMiydRe5DJDsG9eM3C3ajR6RiEI6+uBu7WkgWqdgppjVzXTH5ZEdehbXTgLAxv2ovS8Kuc8/KqXPAmiH1AR2Fzy6NufGeCmcRewNtpPrPUl0YR6xbH1dTKvUHZa4z2/HbUTBx+mD8YxV1UWHEJP4fICeTs1BrokzIw462FbXJAfqA9uPvs9LtZNhQxQEytBdJQ9qMloRzw4k8vdVqnZ5r1VpVt6+qJuslTxHE0FPcVK9dBQT+jaNEvg6WQ7MR6L5a4daVMEFik1RoAXf/VejVrvo0LccwIEBP6kk7LzZB7zcHmMCx70ZKWMM+4QDn6EsYeHFK5NkqnieZRvVhsdV6nA8zYcKRlMMmAnXStkEuHCszlNS1Cmuhct1maNaIASkDvtLfTlp/F7wro+mj7Nyf4LnKqiMZVT4K5Xs9jj3MXUMsRJxyYCTJRKzfYV89u8nPS8sd3OBw4wY7YdHL4mzC4jQDefd1qAJYHOqBv5nq0kL7h6GmW5EVnDAeh92DKKSRWwzA2u9277PYvSj47pw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e65c17-f280-44ba-a18b-08d85123bc97
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:01.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJEPai8R+jgBs5E8LSWlxaLTsRlB6mglMMMlPVURDKeM2F4aijjPXU4RntS8nOHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259324; bh=1/TQv4WtqZ9tyx1b3Au+IIG4Xx6F+j09BTSiG0txYxw=;
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
        b=kfwdm7bZhAlgc+FYJrVFj2MyfQVo0ebbiPA5DJt2U7KvqvUHbP4+LKg6JCEFP5uxK
         F1Jwti4+IkDWjlIwpH5o7Jdo2v2rBpTeUTaAzNl7mzfiZXEcx4cn1HixjMjA6Pfa8S
         IDUs6TdSA0CqVm3dthzoVN598j5eoxnMM59hRBxMTKk/A9JBo/UjaJYUKhgGn9kHYN
         qfgNqsMJc/Tq0N39gjMiymgNGj8kEnflK19oXkNa0IXsEATmj0cJC3ZdlQ6Y1zlp/9
         8ySlcAEbRZND72WyNz+2axtIlLgbHjmyXniymIYz7sCOvMGqFdX7sxRqxkU14+vSj8
         GWBl925lEfZlQ==
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
index 1d0599997d0fb5..fb7630e7aac3a7 100644
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
@@ -186,9 +186,14 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *u=
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

