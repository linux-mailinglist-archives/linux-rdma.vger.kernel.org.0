Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53537595E03
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Aug 2022 16:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiHPOEe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 16 Aug 2022 10:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiHPODy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 16 Aug 2022 10:03:54 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4C9626E;
        Tue, 16 Aug 2022 07:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PTdrB03UYO1oQlx4JgyTxR0V6JiF8yjwZWEAXTJzd24eGxWCiHZf/8yVQCdeno/+T9iqkdG6/5FQR5q9lx5YhyvEnI1UGVCWGMP74hIdcfE+wHAlAEuimVTivJm0HgSniHoGlkAIuIk0nT6+UuriK/mhrsG1FJ3FwC4+7lsekHAVVU6FMMgvV1S9PQ9ReLOaMWRc1/WortQmNECkxQGRKNT11PV0FRFvm/Bp9sLIxQJvZbeJgIALCVPud/FSTplXUKaz5CY8NM2uf9I1BaXUul1ah/Swp09yZ2rTUluiIvpsaFoNvpXMvenRGtShyKGXts/MW9B0OneTzAS/6yMqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlBcDnmQJ+NwEwVcwoDQ1Gk/1Vlnb3wLvFV7V7BtCEg=;
 b=XNRfdCq7NYE3Un7E6e1QWeduCJPBLpfOS+xpRp6D5XJNx6cTA2eyYn3JSvdOnef/MrmZ5RBjhPBpHzt6FgNVCS2CNJKN2r4dWkb9L+r6fhIDVCyf2GxQxIkv31Ad6E6q/MFSvc5x6v17/WZaMf0O4HfYScFdQyupsNE/R806xKasxJzIDTOXVsjp9z4DfQlDVzApdM+kkM4/PK5C6KD5JsdIFMDQBdbdxJIx9gAgXA0LbN25GcbelvLvmeWz4+XBIc7WwnAphfKTn3sCInn+kes2gacLrJ2saaJ1anxXMiWYRJHg91Wxf2eKzun5i/OTkPJbL8oqeoSet1SpTefs7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlBcDnmQJ+NwEwVcwoDQ1Gk/1Vlnb3wLvFV7V7BtCEg=;
 b=NHG+1mZTKprGwZe7uMnPZtoXSzpEvbKhY+E5I2X2ggWcKVYj4xSrl8WgqYuR21HPKXa6VMeYPOKOmzle51mgJoel3DeONxQtAJJp1kZyZIHBIjPQ7K3/osrFzIr2WMoedRuhVKhWSiFWzIP2FDxxhQojOMUfbNUBjMfZdzPNUZCJ2izhlS3Sv63E3H37gfwlsM7NulsoKd4vIjGfRiM9PaVuRvWRJbi9Bwama7iHQ8QWBeJsbpKF7g+8Dt8wJsAFcuIDL39zFfS4JXKyFpvuzTzodiWANPt4OK+8mZM+7wmC31Zs5CO1jsq0MsC1C+91ygP+VejlB94CKE14lv5CXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW2PR12MB2521.namprd12.prod.outlook.com (2603:10b6:907:8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 16 Aug
 2022 14:03:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 14:03:21 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     linux-rdma@vger.kernel.org, Oded Gabbay <ogabbay@kernel.org>
Cc:     =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rc] RDMA: Handle the return code from dma_resv_wait_timeout() properly
Date:   Tue, 16 Aug 2022 11:03:20 -0300
Message-Id: <0-v1-d8f4e1fa84c8+17-rdma_dmabuf_fix_jgg@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0345.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a76fb67-4aa2-49ad-4289-08da7f9013ec
X-MS-TrafficTypeDiagnostic: MW2PR12MB2521:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcEJm++lA8BmDaQepHaeeD8r06ewbICnOPbwjDy1wK6/4z6HVDLxLxboecVlZ+wzMa/cVW8GZNs865NS3NtgyFp3dM+ycehM0L7ILIviGo7vdquWgaDVSI+cC3rF/UTwT5NBMplYovTxxrspHpIXZ5rRDnDP60/iV2Z9zeEKofEJFyo3Y3OytWNtVjWFDKIAcQOOaEEGVKB0Op4z6YRPWfykWwBT34+lCVZKRQCZpL8gob/xPiTrRfJ9Z+OKzSHkQAkA1eAFQw6mrO2EVATWrLiJGlyMeKbIMvs9ZeiYjlteYvwGa63IOAo5bqEjLdKleOVd4AIx0NbwY3KqGR2ow8HDgKBBWBJJhnOYwb5V7qgP6sIVW0fpv6FBHaDadusBO3FizrOahmgsUJ2ljYJzTIcW0CFQU54lFZfVfElVrZh0rT3hl+I++eCYmtzIwuY8xY1UYWYTw6xTmSnM++Sr6CbkCuLUaDnGbKJbMlcqDQna65b9ILmLSTg6PgfajumSKJhJZs2FmkBwqy4t77S2v6GryURtH4qEU2QK7NyXCjrcWy/XxvPimeRQCVGld0XHqMieWn5Yz4Nrjxskwh8t2ShVbMmefHGcFmYzVRYJ6/u4Ge91zQJ3NXQXgXBE4mk+Yr3GrR/82DJC8zYSUgpbC3orR/tkW/j3DgjNHFcPz7VZIkniF8sYpN8969U56iEwl4LHjzBlCTddf6KjL56FnwcxCGhkZ1olgx9THCsYznkECzPv+IcSI9ryY0KtlTnqxiJFLXNP42ckfGmNmTP6RJn1moV7oVng/CJkqd6kVkE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(4326008)(2906002)(26005)(2616005)(6512007)(6916009)(54906003)(8936002)(6506007)(86362001)(41300700001)(107886003)(6486002)(36756003)(478600001)(83380400001)(186003)(66476007)(8676002)(66946007)(66556008)(316002)(5660300002)(38100700002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AHqd79eEd+Eo+Y51VZdJam+A5AMA5n8nmO4MBTIxlG+njvapRg0jyDLbdkbh?=
 =?us-ascii?Q?NoYBrRD1ikyCWvZmy+5MCJ+WluvjEQR7ts8idmtrmSiFrfVaOvncfGZrBRdr?=
 =?us-ascii?Q?C8bVatKCNwUWKANsblwA/vXJEjeUEkQbEasfv/3LOIQC1vqt7mW+BKFBL906?=
 =?us-ascii?Q?SjyTrNg+ddOzSYDd0cG8HkbTbq7iIzJPw4b1eRCfVNrX/L9W18zwlEOjvqUQ?=
 =?us-ascii?Q?v8/p7REkGF+zqJ7KCv8mdCt3/EJIK00UwReo+8GYPQi644+MrWPcSo60Fr1j?=
 =?us-ascii?Q?wVIp124Ia3/gUcR+P/aVsYECRnnh6NHxKDqMZ9TPH+OeBnhHFpUFrcUe6rSR?=
 =?us-ascii?Q?NCTDPNG+4dg9zbfpzwdAJjI0PFvzCVGj36SMuISQlPlpcIr53OtK6N6QQGe/?=
 =?us-ascii?Q?tIdw82KTiLCEAvp8/ecU9e/ABgx5sXLeonjufjuOPsBBQQe+Q8OkLnwRyMUC?=
 =?us-ascii?Q?/8Qo5TWOkTt0IltKSm388WB1/XZBw1UMhlUkSYc1kP+1kC5lCvj0X7foCQpF?=
 =?us-ascii?Q?4QbCO+Pb0qio3RZHVRWnQk9ybqNjuBrPECuV/lO6r7e40cTka9b45b0yGyCK?=
 =?us-ascii?Q?JD5Zp7BszeICDHsUmAo2HJAzGOU47aV5FLCMOlzsxPibfSzioQk95RFR1Amo?=
 =?us-ascii?Q?MXNMabtmVn7xZQPZ3pJDYMIY7sqZQeaGhB8s50jyMDD00fHWCnhJ2rK8rwTt?=
 =?us-ascii?Q?/Jmza7oq+9pysa/pskE/pdva3H7j1b3WAlVLW0KjBlvFe+H1iXWo2+rz/Ufr?=
 =?us-ascii?Q?l4B66EJOo+Jyd3fDqwFdXmbYXIR7hCp6LSI00y28R3YjToSjZBLNZ3UMV/i2?=
 =?us-ascii?Q?seiMImWVvD+41e/kBs/z6h8ZGd6nA9/ubDV6ZFB2HbM/ZxAAeN3RjYfTdt0z?=
 =?us-ascii?Q?cVomQVoDtt5nWgh1c71EkBfGLCqvhYRkNLRXfwTQEzmOQS63tlRryJZ3wt9T?=
 =?us-ascii?Q?nLJI3pPl8EfzM0wBK/8Lr4+IvCBwuWBQB8qa1Vty0BHHweTbTjI+GopTHMz+?=
 =?us-ascii?Q?O1AWRQ7TPrw/hGOEmfYC+k2x8I3J7/G4RqCu+wETMs69UuriXIzNisIEx14d?=
 =?us-ascii?Q?909sM8vEkQWx511oo9zaUh0FdsQZLspG2Uh3CTvj8WTl9FMEfIwy9Dh8J72i?=
 =?us-ascii?Q?KOXEk/q4mMHN+X1lMDsvkGTM8E0mgmIDGIuttvrbQn9cmHgVPKXUETCdnWtp?=
 =?us-ascii?Q?DMjpXPUgYWU+cn3jNvsrtfHE8HIDWLV/e0yu5plUeF4Io6jzMqUyWqsX71YU?=
 =?us-ascii?Q?ZLihixEqD2w1Azm19AbLr/LWeNQqxJQ7IMcnVW8LhXfByO/rOXBInIfQyzH4?=
 =?us-ascii?Q?Fa6AhuzdrMV1pqAnjjCY/juAFNcJ42YX/Pxl0JvBMBkd5MGVrBuSlq5oggIK?=
 =?us-ascii?Q?s/XVvR/rJIYG5e78xUC8OFU2JHV5ctUV4UcQpIbU4DdGIFijH/avRDfdKWNV?=
 =?us-ascii?Q?BW8mxgNPTlT7xVNNu6x0o1pDXAuiGFPo8hdGY5EyqeS0cHFGJ97SnHm7qHzG?=
 =?us-ascii?Q?EwoX8HdEDwaaihv56RDjPZT4eqolm5uwdzbhjbQFwPss8xolJWhdHgcpBMdk?=
 =?us-ascii?Q?V1hHy+CCH9/bP8jRzGUwS8SZq5XOQVwRDfIqb3Di?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a76fb67-4aa2-49ad-4289-08da7f9013ec
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 14:03:21.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyr8/i59he+G20SaLnj0fZ6DdvtdNXZQLqEhQvt6ih5FqpYMXHUDRbSIn4vN0Kyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2521
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_umem_dmabuf_map_pages() returns 0 on success and -ERRNO on failure.

dma_resv_wait_timeout() uses a different scheme:

 * Returns -ERESTARTSYS if interrupted, 0 if the wait timed out, or
 * greater than zero on success.

This results in ib_umem_dmabuf_map_pages() being non-functional as a
positive return will be understood to be an error by drivers.

Fixes: f30bceab16d1 ("RDMA: use dma_resv_wait() instead of extracting the fence")
Cc: stable@kernel.org
Tested-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Oded, I assume the Habana driver will hit this as well - does this mean you
are not testing upstream kernels?

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index fce80a4a5147cd..04c04e6d24c358 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -18,6 +18,7 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 	struct scatterlist *sg;
 	unsigned long start, end, cur = 0;
 	unsigned int nmap = 0;
+	long ret;
 	int i;
 
 	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
@@ -67,9 +68,14 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 	 * may be not up-to-date. Wait for the exporter to finish
 	 * the migration.
 	 */
-	return dma_resv_wait_timeout(umem_dmabuf->attach->dmabuf->resv,
+	ret = dma_resv_wait_timeout(umem_dmabuf->attach->dmabuf->resv,
 				     DMA_RESV_USAGE_KERNEL,
 				     false, MAX_SCHEDULE_TIMEOUT);
+	if (ret < 0)
+		return ret;
+	if (ret == 0)
+		return -ETIMEDOUT;
+	return 0;
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_map_pages);
 

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2

