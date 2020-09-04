Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E95625E3CE
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgIDWmW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:22 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:48504 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726360AbgIDWmS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:18 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c00001>; Sat, 05 Sep 2020 06:42:08 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:08 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:42:08 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:03 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6hj4MJTnPYL5Mny0X2V7o0yljU0TqPHpSaIX4E9FHan2iPjYeZt3MuZfqIoqC6V+8w5Vht2vvDNT08GGNLyTGuYW670itiQfOVWr79lhf4LzPY9Yun8305p8gDUdF2YUVGgvrITuSVOFykVHmDtWDn1g6Q42M4jPf+cmK3fI0txcjwvmfPSyjTClCqXxBsrhfu/hg7Vor01qtCCFK5vCQCeSUgAxpKF6m74sJj5WOPYmBZtiz8eF58zXa4XT9MmRnL1+xubOxCttKG7S8Fla91GfXOkemL36z/u0zCmus5+NEqNUHDn3f4zFFkcU47W8kjOSkVNOQAsB2E6ch9NAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FutVtboNYTk/EFZt5ishUH41st+GLCvrWILRlcQNCIY=;
 b=bXLZEko0BdcL2yDSe6LxmZnUCoBYvHy1txmKYnATfyle1c91RiAI1vbbBwfhIHr0a9nz32GnS30UY033VMuE94SRzfy/jqFdNO9NcP3q5s/uN9C7JeYbuQl1NWi2e5zwGyPn44s/jCWMlD633HBxO7gBiX4S0zZZXybyu5Ue6bYkBQCd3Ix9jE5LVBnFwhpSlOZMf08U2P4RHSd6IOxEfWQLFzn8ZPnlsQRPHdu/84ddYsIet46/tr3hcLgCBBVFsDZHfTyVlbYM1RJ6q/IeK+Qh2ftqSyoH+ddal3Oez9/4R8d7sM55Nczir05rkFDIfAACIU01GtaA27lEtFgdaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Fri, 4 Sep
 2020 22:42:01 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:01 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@nvidia.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v2 02/17] RDMA/umem: Prevent small pages from being returned by ib_umem_find_best_pgsz()
Date:   Fri, 4 Sep 2020 19:41:43 -0300
Message-ID: <2-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:207:3c::31) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:207:3c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Fri, 4 Sep 2020 22:42:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP8-001vC4-Ql; Fri, 04 Sep 2020 19:41:58 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4186296-c9f0-4578-0412-08d85123bca9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2806632F785B89811F073FA4C22D0@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4tgf/+gH910lfcDlboM2r7du5FzIWbpQsVocuqt+kgjc+ZILLWUodTQw6U7qMSnZrEhT0Q4cn74THl2HqcCQDwVdvOTWF0hJ0fmVdzN74Nh9nKqYwepNnqVdng23dyQ+kZ0m9sf0J61Tjo1wQXZprukjgog1u2zUfDMCu8DDS9+ab/bFagqXRKR8ueEUpyrvh+YG+VAvaT8J5TSNpvW1jlhcRXSMpriRknO/+lHZqI5yRDbWIOz+KmGLpMmQCxHnpCu+kQUZIJalaju4/wOdnZnlx2Do50fDtMcCKD/RYYN8LyQlu3JvgdmBPfAT/1F1Wdqcg7TeoVWdDkUPrB7aqpj5BL2gAuYJpZoT6JLXeHPHFp+pjpd5QM7knd1V49b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66556008)(26005)(54906003)(66476007)(6666004)(8676002)(186003)(316002)(83380400001)(426003)(2616005)(9786002)(478600001)(36756003)(9746002)(86362001)(8936002)(5660300002)(2906002)(4326008)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4Ovax45qFz4y49iszlqFn3fMOZaGLPFDIKiHojBWPgqyh+YvC0r+N8WGBvYi85F8KgBXEiFOgr5afMmIerYo+t5Gs6Z8cDpt4TFe2tVRNv4tpE+/KAOPiFFjebnPerGJ+WPTizJioZRP4FaiEPJI1Qv8AHn4D6Rp5CRQqERYVXDVAxspIAcy+Q9A+omtNuA07Xq9e86Kcmf9sDv66Z4hTG+7d+Y0DWbGzmY2nKaKNzOaIf+y7J1shG0B6/hls/Sk5RDKvNE49PxnprOyFGkCNTmC+95qvxOrJDicpC3LWcVBjJKESvCz5vJzOFMK1WDyB6qQN/qTn0V+Sd84oT7w2kche9QNXcboC6Ji7Eql4e8/Ns1VHPqTH1QZ4s+3ZNOXn6oLqQ78pUNGdGstwdhBtCr+JnOxSdsiSzalOnxwfXpbdxz3TB70td0x41z81Sp3UFv3hG4InyGiSkWVbW/a1b51m7L0VqwVfGPVlIdNu0l4lFXCtIeQqfyT9g+XjERi01KdqkLcc0J+NBqiAVSYTkKIlutp2kpcepBBoVweddJAKt2TtB0/xeXCYtlaIOP1fdMihAtSOyLoOXxGUqeBZyy4LdKiaF4h9AoOWCiWm7QJLt2ZR/vzEMtxYBahIQlQefl4w6AG0WVvTO3h8HnPMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a4186296-c9f0-4578-0412-08d85123bca9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:01.0060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cgDq651sBUjy/Qc7PbDmvTWtzWLJTZfhYGbbh7Q6xEA0sXTfLsWQ1SyCKwzmUuBH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259328; bh=M5RRAXGa5FZ+Wn+kD8WKoopuG8Vz/6TxGxpInSvl6XQ=;
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
        b=BREdMAx6rJGxVAuEQdiHtmYEEJg69C3I6yrNYdWkZwqXoMwEPPkIe1QXxfehwxsKq
         P85xvK1xRlHHAhETvIGK/KgPZip+2v+4e+GzrGMXKezoUKdKkBydk1lINUX06wZE69
         JKiR+RdoLqHjxk01rXgzOlJWHWGYXLwAWhuZjvsVFpeu27DdFpyQ+xOci/OVJHYcUa
         B7NFkXqj6nVMGOtKfSAKjQXwnnEMtjld2Q+wgbVBP4iNNF61wSFBTHt1IbwHMNwtlG
         PmefaIdxhknrDI01NkeW6lmGw0GrDE3RFJgI+YlCBYDj0FxgKBjhYvZ+D+8oxG4vN2
         TXKgTBr2L+7lA==
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
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/umem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.=
c
index 09539dd764ec05..1d0599997d0fb5 100644
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

