Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24FB25E3D7
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgIDWmf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:35 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:33066 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgIDWma (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:30 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c50000>; Sat, 05 Sep 2020 06:42:13 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:13 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Fri, 04 Sep 2020 15:42:13 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:09 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNdKxZoNkI/lts2tf4XdNLdIGYxbW+YhQOdExo8ty1QS0XO4SYYerIfJ6UzAIcC98Zv/iU2xSD05AlM+SDe6XKODOXs7bvPgbq7J8oLn8iMnkrRzHmwENBq+vgd2cmxL6U0Z5jhY7a9OsPZ4WgYdl9XPmbzwN945RxyNOBpWl4CfTT+A1xTtZBrW/pM0VMgLpTUKsFrI2BZmSTrb0FvoDKwc7lnlgdqx9TDaoqv8840j7L/i1QHgyiQZZ3PbAuIwmLsytlfk3Fl7xJcqxIoICbhxZXXHvk/rvE3PNgNsjxSKn62El77SfYj4oLYkuZUcD3PiTgIbGK9ASoFP9PY1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giitQZMY89i+b77dK3w5npwF6FrFWKig3IPRepa88No=;
 b=ilftIGi3O6eI2F/EmhbQZCpy+XN0nuujxLY+HoU10aGjmH2DPtCqW5t5Mpv2ZPYNFPulkCjHy7fOMfk0tx4CU1L8IUaP+jieYaWYkpVSRjbL+1cpvyqWm21iDZ+1RHetr6KkOosmQoll7dk573CFb5IP/R2ObtVyAIBubSXtIx0m5CJFMZHGMwSmgDGC7KzxD1c4y445x49E6LSMvRSSeol1EoGAA1g9wbEBvl/YzOLZhcz0/V5OzDA1U5P9hpps31DFRmJMdnjF0tIqImcm7thRZ99MRcZio9mLaKdTNidTHqYH9Lie92SpOiK6wXdxGxmMkuMfZsqs2ecSvaBoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2856.namprd12.prod.outlook.com (2603:10b6:a03:136::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 4 Sep
 2020 22:42:06 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:06 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Firas JahJah <firasj@amazon.com>,
        "Gal Pressman" <galpress@amazon.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: [PATCH v2 07/17] RDMA/efa: Use ib_umem_num_dma_pages()
Date:   Fri, 4 Sep 2020 19:41:48 -0300
Message-ID: <7-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:207:3c::30) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:207:3c::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Fri, 4 Sep 2020 22:42:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCO-1j; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9798ef20-7bb9-4c49-e3fd-08d85123be9e
X-MS-TrafficTypeDiagnostic: BYAPR12MB2856:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2856098BFFB0A772889CFD03C22D0@BYAPR12MB2856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQ8ETT93Nel+s7/Tc5ETpDApGGhe/ECf/PVSBKPkx4wAFzvu0OdAQRIyJC1xOAczc+sC4VasShHKqijiTdMOt/NiQQswAna7yOTLHB0BU5BUCfBXgZ3AdmvdCkzhI8FuyPR6lmegbEb0DeHTcuze2/E2Mbc34/dQPCLW4uYWOyOSJlcRx7lYp0qEx9NiSZ1oLeid+3Zx2gS5nFxrq+rB5z+Ey/g5ovyXtpfRWZkPrVidTETW6fCJ0jLIn/Bjd1fm67iSNa1mgmq4zFtK6Vqz16ozy5+YpBykKIqYFCLyErqxiE4ziRm9T8TRTiq2o0ffqDEJ/YlJoGPqP/O4noTN1YpqoqhwoxQpWqfwOICQrcBJSHtnptBXWHw6LUEEK0ie
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(36756003)(4326008)(6916009)(8936002)(8676002)(9746002)(86362001)(9786002)(5660300002)(2906002)(2616005)(66476007)(26005)(186003)(478600001)(83380400001)(6666004)(426003)(316002)(66556008)(54906003)(66946007)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pCvMXcjTLMLCKIW6ra2d9627ZSfJm7c/ccq/JSHXmRmxyrXVAwp9g6ZDOnrOMpljqb1YiwXoHMskA9OlJcTjskK0zOjM33GoBRmJh7jNEKDt97b6mQMCX+w8CYH3eslPYZIHdISZA0Dkf/Rfpy/rTG3+u77RDflzPfJ0VmzsyOptD5CTN3qJGp50aCqhnrHW8dC4hjSCpKDUcO96Sipy1A3lL+g2tJZnwYSPyzhGjFZLqfPnjn1PYLeyX17VSLM4lVTjkgSDaC35I9sbNYfIDm8aUmeoCQJgPcxf+f3Azaz7BRg/byBt+pXbVNhWak8M+ERl2mufhf1Qw/ijG3U9qxeqEQt8PJIxAWRzeGid7w4Mz5RrkObbp+e1N2GsupFraHeLQ3dUbMtiP2RKv7JczquK+0ljzqb00t472R/v62s60PxVmENN7QcSh59TERv+mtKg2GCNqBwH8UbPHhtCAnTLvUY23I9qqlA9sd7UCEJrXhFOwzk0jFVXufxqD6Od8FKIP/kLRM4xdViakq6yslp9F0A+Ntm/ZXBlcVkKGMuD9FSSv+sJX4xM7GyTYWM7l5rOL+MrwBiNpwwCNuMcTlLen6RxTBAm8mN7biLG4KWgLk+iEnvWgVe/8QZhMfoR+jZtVsig4n7vGBgC8bej1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9798ef20-7bb9-4c49-e3fd-08d85123be9e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:03.9922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWF0BLCHjedm8JZAMuP0TOi/JSlPAALIPv/K8NJKZ6dlp1FvUaDJYab2WLM0qMKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2856
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259333; bh=5sP45arY4Epqu8L54pHgZwqZurQIs/hxdCsem5yJ8so=;
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
        b=GZO3Tr/3wf3v/qqxTpTAwjcfCb2SlF7c/wDV2zF3NuahMPulHBw5VZhsqhAT3SZoz
         uAl6v2DxRFjLGEtpNINSgHjMEaBnemNqlcj51o1PltUpJn5T6DzrvFvoybFZCaIKBk
         2CnGZ0wpgFYFQfsQYTac4twvuulvjcefpddojn/LRoCRBdpB3oLHHD40EtMeAjlqEg
         2sck6DHPzRFsvxUyKvtnEfnwOppc1LhjOJLcgaBY8m+X+wvxdQ1MlT4KjkLavcfJQh
         IcHaDuS3cq3mnKMjkSkFW0gkttI0jpKPnQrRNBo8p6qsUNr8c2JNP3kCbq2WOyd7Xq
         D2MFeQaNzWyVw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

If ib_umem_find_best_pgsz() returns > PAGE_SIZE then the equation here is
not correct. 'start' should be 'virt'. Change it to use the core code for
page_num and the canonical calculation of page_shift.

Fixes: 40ddb3f02083 ("RDMA/efa: Use API to get contiguous memory blocks ali=
gned to device supported page size")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/efa/efa_verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/=
efa/efa_verbs.c
index d85c63a5021a70..72da0faa7ebf97 100644
--- a/drivers/infiniband/hw/efa/efa_verbs.c
+++ b/drivers/infiniband/hw/efa/efa_verbs.c
@@ -4,6 +4,7 @@
  */
=20
 #include <linux/vmalloc.h>
+#include <linux/log2.h>
=20
 #include <rdma/ib_addr.h>
 #include <rdma/ib_umem.h>
@@ -1538,9 +1539,8 @@ struct ib_mr *efa_reg_mr(struct ib_pd *ibpd, u64 star=
t, u64 length,
 		goto err_unmap;
 	}
=20
-	params.page_shift =3D __ffs(pg_sz);
-	params.page_num =3D DIV_ROUND_UP(length + (start & (pg_sz - 1)),
-				       pg_sz);
+	params.page_shift =3D order_base_2(pg_sz);
+	params.page_num =3D ib_umem_num_dma_blocks(mr->umem, pg_sz);
=20
 	ibdev_dbg(&dev->ibdev,
 		  "start %#llx length %#llx params.page_shift %u params.page_num %u\n",
--=20
2.28.0

