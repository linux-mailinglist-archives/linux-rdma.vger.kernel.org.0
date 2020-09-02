Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9812B25A264
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 02:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIBAoG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Sep 2020 20:44:06 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4735 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIBAn6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Sep 2020 20:43:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4eeab80004>; Tue, 01 Sep 2020 17:43:36 -0700
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
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 00:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0TPgMGGpqXIF4K64wEMp9hnBPVFK99ADeONYY45F92NeKNwbSx93PieYFB37CPZIx2mVF2NahyfqLsq0UpGBn6S4hjoDhXPN5ewyMbmaOcVBtEmps/qk3qYtj9laTXEfew+8oSx5RbT9QckoMa55UFQJwJDAi9I6tQTF4I7zQycvUzmSJT8Mz98OjYN7XKhn+GymMIMq8wCCa3XV+W0xmYT3mGXtQ01msijSDhsJ10PBGi6J/bcwA6jo9I1zPRre4fwY/LMRRkkCkC8CxKI4G6c0qaIw7u9koRwp2IPaESXq8lACi176jrBX/1pMlDBCMpFjrZ6yJP7TPiwAjz9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhmfE/HiS+k2qms0Kvgb64G5sK4eBYV1UYXzls1MxUM=;
 b=dqWBTG+yNqPIP5PGoaqRAJYqjUkJDEX8btSEm59sZ2x4/0LowTaZRdZwMWAxlKUIXZ0tJSgdI7FjukER1Y6hguT5f98v9IsxRYD/1QPA8nLNqi7Huqtvhw2ifZDuiED2h0AzXCbKmfQHt6ocCbMpEVSqdgZZeDMRSAhbUU8iNhLhJ8GhzAItDq7OSQK3ILoQ8LepDww/QirdZaalSDfKaiZ/ksj2wt8Ef4kPhckjo2/Q0drbNxXQK/mb1uuaFETtije5lKAMNOwciexKskS69bvnhllt6KZNViPjJ64aWYMipqVmSBUl2jxL9sCeUI6Z5mKn+qBkz1FBVWksk54BTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
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
To:     Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: [PATCH 08/14] RDMA/qedr: Use ib_umem_num_dma_blocks() instead of ib_umem_page_count()
Date:   Tue, 1 Sep 2020 21:43:36 -0300
Message-ID: <8-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0031.namprd19.prod.outlook.com
 (2603:10b6:208:178::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR19CA0031.namprd19.prod.outlook.com (2603:10b6:208:178::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 00:43:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDGsJ-005P1K-4G; Tue, 01 Sep 2020 21:43:43 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2636fcc0-d32c-4962-3b58-08d84ed93f17
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB38347A1CBDC54262199CB9C7C22F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 215R+ooY/yQNPcpfMbVpt5WN16tu+04mpYpC3RmhnOqz3hTadbEeTXUsb1w7gVE1I93w/ZyALZxE1PhGudN2vAxsYM0PcID0xhczLYbt5+G2slS+Hq7TbhIo2MZGEYrWANiLqzs6pX8bCKQ/KYJeyBVhp0kiWaMd2aF1Hod83LammfgiTvzm5dU11xPIVsn4O8G1jwIdj5zRuHVfgVvHIRKczFGSU01Phj/ZsiWeEJtTR17SIZqAynD3PuPl/Cl5EsllBrmz7TnKIdZ24lMo1vUdwspCKmd3Ygf03qh+rwy1mIYnbAzNUUUfzYYNqc8MxrmMCNrmRE2hqP/qZ34mH/isZOKJl0nxt80A3DtIHPI/eCB5facgu4AUq6Z12gEb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(8936002)(26005)(86362001)(426003)(8676002)(9746002)(9786002)(2616005)(6666004)(186003)(83380400001)(66556008)(66476007)(316002)(478600001)(66946007)(110136005)(2906002)(36756003)(5660300002)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: v4o/CQogpfF1Z7VWSPRpvjsWlrTGgWID5UjRWNKtw5Z4fDFUeCuzya8bnm61ixAzn3WyWjQqjLK3R7tSRp9Nftqkdl0SwncoZc9JOqabzqfiSfupdl+7E9ug2lFOyKAd7F5Ps8iQ14g4tdVVdSM9Ii+yQsizzD9r3k4ptaM139/vajcA27EWjhPRvdUU7AQs+5QaEew13fHTZE2gVmQ4onCBZrZfxBbix2xdIOqwdR6TNL69v46PsdN47KEa8tzAj8XL81vp2rh9yMEWq8hPQq0VfpRkBg57Hd2TZSTO+rqOoVkL7tArGWAh++wWc/CS+EYfUK9yOGC2g13TjqEN51Ri+kDUTRd+Ea5ABO9LN6q4DuVaEI/w/USiBhwO9bV1sH5rbIIPmdlPRax/BMT3ihYtMs5/P73o7UJdvGxqXjgLSyVtiYfoGUrqt20KIztjENMKDy4vcXIfck6WsVsJYDniIODEJOLBwnHDbNzp8NuebOr+Us59yL17LSI0IoaH3o8JjqA6djDz4uIqeeudJxQmxZH+OwaNCnju9c2ghofA9PDdEjRycLeOhUSJMZgkOnE6rDG9EDNAvVT/gkXeCSJYOBxUvgzJYUQ+tLpPMqkBljCGSsys6GIo0el9FP3+eXUiLyasY4oRTspHkNbo3A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2636fcc0-d32c-4962-3b58-08d84ed93f17
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 00:43:44.9530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WxrYFrvb5G0ffEl4exlTDMKIR7PW1ArONGqT7wzp7Wu9hk6K/VH5Y1ifw6F6t8+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599007416; bh=5dbYUNX/ew0HqNUaPH6y7tSfRdzYx58LKfzpkcEocVU=;
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
        b=GQSrw27qW1ge0kAlWE/fZkjRUKpljvBTmaQUQScc6lsl6m9A7OfqcFmIL/n3pLHyo
         9RmXOYwYumFBnNcB/apY4JRFWdtPgWKOBgbxy5NB9HtapKNrPGOXo9UgwORrgCBSOF
         hoUs2ZdwW5G/562m34A2LWMkEJKaL/8Zireqbbtm64vdsZfqlWVg0+gT1HcJMM537+
         6CPpBPxvlSxSycq3BGATXOk0nx1u52BSuUyjD9WGPud+zxVCPnZ93G8r2oGZywRYDt
         q0mAtl/Yvswe85IhbdLZCBAFQJaKzDL/ewPj72HQVATPZDaf1HmfCzt4cyxeAm4Zg6
         JvFRNnM1PZ/YQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The length of the list populated by qedr_populate_pbls() should be
calculated using ib_umem_num_blocks() with the same size/shift passed to
qedr_populate_pbls().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/qedr/verbs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qed=
r/verbs.c
index cbb49168d9f7ed..278b48443aedba 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -783,9 +783,7 @@ static inline int qedr_init_user_queue(struct ib_udata =
*udata,
 		return PTR_ERR(q->umem);
 	}
=20
-	fw_pages =3D ib_umem_page_count(q->umem) <<
-	    (PAGE_SHIFT - FW_PAGE_SHIFT);
-
+	fw_pages =3D ib_umem_num_dma_blocks(q->umem, 1 << FW_PAGE_SHIFT);
 	rc =3D qedr_prepare_pbl_tbl(dev, &q->pbl_info, fw_pages, 0);
 	if (rc)
 		goto err0;
@@ -2852,7 +2850,8 @@ struct ib_mr *qedr_reg_user_mr(struct ib_pd *ibpd, u6=
4 start, u64 len,
 		goto err0;
 	}
=20
-	rc =3D init_mr_info(dev, &mr->info, ib_umem_page_count(mr->umem), 1);
+	rc =3D init_mr_info(dev, &mr->info,
+			  ib_umem_num_dma_blocks(mr->umem, PAGE_SIZE), 1);
 	if (rc)
 		goto err1;
=20
--=20
2.28.0

