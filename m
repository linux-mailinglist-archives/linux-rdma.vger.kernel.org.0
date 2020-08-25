Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED1251EED
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 20:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHYSRT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 14:17:19 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:15077 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYSRS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 14:17:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4555350001>; Tue, 25 Aug 2020 11:15:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 11:17:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Aug 2020 11:17:17 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 18:17:14 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 25 Aug 2020 18:17:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyd+QBxQs9Ov0zPc6m7vUElfk0H33+kCdwRlGuwvW96dfjp11OtRUIEecbbbNGY27Hu6jimf1xbsrEmmaYaWJEKIzJbqWr6rB+A8tgHKo1DkpDebIUfMB8yMOCPkjGduU5K1AUqI+7zN5tqttnNn/aemAD8tNL6YKrYlTMyjXFqV2pJ+5XwQlMVShZVYST/sqg/WPyLEiVL50R/CloTIjB5FAx8O6BxVdA1k1OvcykOehXnOpaz+SKYvzfBf4Ehs9vwmFHgL3G/NIGHqisfQQuOqd7qNt9F0P8pVq1Pl5j30aOA0t5eMQesg0uLzAirFPJyIzwSl9kq1yOo2rLr28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1QfaN+Si0c9WUuWwVuU1uIqaKOGGPmw1/gqLPUB7T4=;
 b=llzAnGjdrs1x5w/kpbQ9VFz2EVoDykt2M20ZW+oabzcqq2zqyIAP9ncBJcrFsKpK/lloyhiOk+JEzoL3uMFahf70Yuzf76SVTYNbrggCwlD+Uadk7uM7slyPUU53S9QinY+vXNKkYhSuS7RiEYK4ak3tPp3Vd4n1WHVh4kURBfEf7sKSjNrmLr4Oa8UEMgyjUP4cnV+SQLfmClLz07nLYLpETUZhuEH0qHV3uTfP/CjVD9iRtPilTKIrOuV+8qUBE/H6Y0aNlTiF6IumIWquyJRLwD3Sv4VyCpisY9wMz1fAg7c5AeoQWIJ94T8bNetIoYcuS9pXmORxvF8dpL0Nrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 18:17:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 18:17:13 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH] RDMA/umem: Fix signature of stub ib_umem_find_best_pgsz()
Date:   Tue, 25 Aug 2020 15:17:08 -0300
Message-ID: <0-v1-982a13cc5c6d+501ae-fix_best_pgsz_stub_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:217::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BY3PR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:217::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Tue, 25 Aug 2020 18:17:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAdVM-00Etnc-Ov; Tue, 25 Aug 2020 15:17:08 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb543c3-d87c-40ab-3593-08d84923172b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2812C2AB00151206D38BBD1CC2570@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ItVyo6vwNYkwPA2C/51doDA2qePycBYVFNE2Rw6ACR8UOGIbkuc74Nl0BxyTr4CuPRrzLy13U9iUUMDOe/MG3pvP2Jl+FnOW9icOegvQChH3eZEuLRzhPmWlKXBRDMO3+qRmRIgBb1nW85ybUWvfjG1KHt/MP+N0zXknCXpdbSP+uf2Wq2hledB583s4boANhjjT+7uUJQchTeTnrQ99VmqRjFgkiJ9dpz75KXevDuUCXv5tpEkCTe918L0xxMt3Qax5fkYbJpI8t/mZ8MoeFY5s8nSyiBZ97sWw6c7njdsXPFmkSq9ILsS9jYdS6wJ95ImFWSZNBtCiR1uNpcHN4pnRME0IsDiONZGSAYVZXBOTRNTXp4u8aqH5tSDTGdCk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(186003)(316002)(8676002)(36756003)(2616005)(426003)(9786002)(4326008)(5660300002)(6916009)(9746002)(8936002)(4744005)(26005)(66946007)(66556008)(2906002)(66476007)(83380400001)(478600001)(86362001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1t6HPaVKYnjfZFD9TnekcutxM563Sso7H77XFwzZWKdVEPtIK4tQqqF5tfd6vA4zcjZZ1jwUQlbsW0rE4eAIqPU+/zUSRy77yPNczSUD8GQ3XSQO8nZHXZ9LiyANwFPHaMmMsDve48thq6VMXsdROJOJa5MP1sodpYakuWiua4O98S3K45V5VeZ089O8T19iBZFCSPU1QQ7oLvMxTeL1SlfCWKYEwKgigUoPA7KONvXChHpBYHnuHHfqK8V3DE1sFw1CMkjwejCyn0VKkkdUJ/PSK3ZMyGf2lC+DSwEFHimGCOzAdDWAzKfU3c0IHL0mE60bqhSPG7wMedz9+zHc74tBI36YEfZlkJjCXqJlAyF4pwbFgNwveDCP3fyBvZu1XoXg0oxo0CJPwnJTD24VGMz5fVJc2NONvSyQbXrwsoweOgYbz12Grbdro/VOB7S7xFd3XgvFV4HcHtMwxv9FTT2wgmK68d+oGaAMSgz9FFqBnI+BvE/seTn5ugLFL1VjrlBMt+8OQyOYgtKr9FjCvbTfZqXl1YtZdPwPQ5Ah2Aybs1+9cr3aFbzddcGZ+23yAa/WdPdDzfZkFVXKVbNuWgZvBVKHN8VY3qw+Iqyoy3H2vTpW0QtAfL2xqLVZJzy7uIOw7gTHfGlNPQZhqtAOTg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb543c3-d87c-40ab-3593-08d84923172b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 18:17:13.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H562ORHln3zaq0pE72hHcQTi6MDzZC27VzRygOIxDMHfnB5bxOnK04MNpgCbiky1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598379317; bh=z15yaGUnUq/UvN5++5vHkjolE9tO9qC74KbyXg3NWdA=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:CC:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
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
        b=itDiHJq5ddlWVtJI8w1fgwSM099of41wSQxbAn9wmfkHXvR07T9qcnIzbP0dUgx/3
         PVLpkG0YCxpNN5SX6gd2zYnk/1tEB9wUh9XpGQBKA6gQoUq+XiPo7WDllTDnNBCO2Z
         5iyiZ8WC1ApFwBNkhde6Lfr+yHf9U1KdESjry0KaLeADrMVj81wWWyruo/tIjPARo9
         Yn9l20MW3x1D2Noqc0FaGNocnoZIdmVbn/LcMJlwJcPx7h+J8Ill2vCs2PECH8bVt2
         SniSEv6tH3Y/snzOikXe24Bmq4wSeXf1hXdMZCBDI3KcEIrujhXwVIcDOBTzk1onqC
         FrxCQjhfxvkVQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The original function returns unsigned long and 0 on failure.

Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page=
 size in an MR")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/rdma/ib_umem.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 71f573a418bf06..07a764eb692eed 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -68,10 +68,11 @@ static inline int ib_umem_copy_from(void *dst, struct i=
b_umem *umem, size_t offs
 		      		    size_t length) {
 	return -EINVAL;
 }
-static inline int ib_umem_find_best_pgsz(struct ib_umem *umem,
-					 unsigned long pgsz_bitmap,
-					 unsigned long virt) {
-	return -EINVAL;
+static inline unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
+						   unsigned long pgsz_bitmap,
+						   unsigned long virt)
+{
+	return 0;
 }
=20
 #endif /* CONFIG_INFINIBAND_USER_MEM */
--=20
2.28.0

