Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84C225E3D2
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Sep 2020 00:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgIDWmb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Sep 2020 18:42:31 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:20502 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728116AbgIDWmV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 4 Sep 2020 18:42:21 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f52c2c20001>; Sat, 05 Sep 2020 06:42:10 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 04 Sep 2020 15:42:10 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 04 Sep 2020 15:42:10 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 4 Sep
 2020 22:42:05 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 4 Sep 2020 22:42:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvXssbY9skEOPUgYJgcrASHjEiNucEo5MVpqKn4Dztq3cERBdIDI6lIL1gdT4oP2TE7xGRJS9wM/4svdL5nhsxtguYTM8cIEF264S+JdlljzRy6tW3M9EJZfMoLo32XMqFEHf3KvG+ub/6Lne7aqqKJzNzPqskcKrb4nyIgPvPUvHpnaMMU5/CaReWwx4reZj/Y77mcai2ZqMJhmsb9dSD0QZKqAosKoh5ezFUMD89PmKZNttvvVyBA1i+SYz2t+Olni8z/q8JTelnlIl9Fsln34h7e6Zt1wF59i+lYC7e3YwyGQ/75/AIID+e4crSQdZNLd4rsFI6QirbXM1mm8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7c04WC3o2eLVhtwACSJGPMYcNRjdtWY65CCqcFkl6Os=;
 b=JVOodibClnfPOIRUZc/cBfBOOaUWjRdhtOeqQGDObgKrn2wL7dL6JqQiGksw73mflwUjMdI/sYG/ISp5mXmN2vd4LSHGAAREPp7vhfTJSnjE5tiIzn3d6WawnufTEDPNTkt/9TortDz349bfrakC5ewFYzUPWA7Kzy1DBqzBDyOM9nOTs4Z5bGTYGd2A4uBFKJ8sS/yCMhNhOqiTRgjVht/EKhu0vfNkQUp41cgeSD3mQUI59o9QBZdhrkChYRpdwQzsHZeHluiDLJDtJL5cNXG63k7RzgIfWUfSk6pfg5VaKxrtemt61e+9e/y78CDqi/08gYp9qQN37YDgpiMDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2806.namprd12.prod.outlook.com (2603:10b6:a03:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Fri, 4 Sep
 2020 22:42:03 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3326.025; Fri, 4 Sep 2020
 22:42:03 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
CC:     Michal Kalderon <michal.kalderon@marvell.com>
Subject: [PATCH v2 10/17] RDMA/qedr: Use ib_umem_num_dma_blocks() instead of ib_umem_page_count()
Date:   Fri, 4 Sep 2020 19:41:51 -0300
Message-ID: <10-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
In-Reply-To: <0-v2-270386b7e60b+28f4-umem_1_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:208:160::42) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0029.namprd13.prod.outlook.com (2603:10b6:208:160::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.8 via Frontend Transport; Fri, 4 Sep 2020 22:42:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kEKP9-001vCZ-58; Fri, 04 Sep 2020 19:41:59 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5e45a9f-5d0a-457a-c275-08d85123bd9f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2806:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2806B6793FB098854FE9D36EC22D0@BYAPR12MB2806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRKy1WJNRHxfVJz4qDVEVqJda9er8WBfTsilwmdciAMB7joRvu2d4g465eiT4b7wXZ5meJ+9m0vlWz0JImQ8+GDF/jb/+mU2C+gTj7Hy2iHuIoJPAmc3I3b6wJtxFY2VvySZ9SofmcjXvO7JygPhn79xAkA6XrpUGGHLDX+IEOrfjKXVN21Y6S2ho84Wkl+/In44dqBHSeMQDaHq83GkKjZWwkwxrSEVF2NCs9K4eyy29HZruLGETGiy57LrN8xrGjRcufh6lri7N9zb9md51btTo4XT1d+xaavvrEY5zHV2Ma7xpkG7Xa414wezI0enunavAClQ8nMVUW7eCJcqWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66556008)(26005)(66476007)(6666004)(110136005)(8676002)(186003)(316002)(83380400001)(426003)(2616005)(9786002)(478600001)(36756003)(9746002)(86362001)(8936002)(5660300002)(2906002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qwBtRRxKwJ9ZokEuMb/2SW2u8vEATP8HD/bVeZg0qMjviBWosduWFUtKJgjKAhfDmNcmCeSl960q1S7muSrDpks6wif0FxuGmq4nVfSmR+16f+GPpjPuYv6KNo44GbheesGsdou97rlr12H3Y4fCgtikV86Ftc+syYf4Z7SsJYKQ41O0QwgcjKXYhezzN96ainYGslQlpj2kBP+YChLAYn0Kn/PbkPAm3BRlp+LNOdUqI4EEvLkge7kN/CeAnZbU6dwG9huKGShklE8BJOBpw8FZ9RfjIJ065C3AZyLmVTE5JGiTZJKmd/uGzkoUU9G+HjLQV9V4qpUHeppewY4v6s5WS1qfcz5S7l7YDmP7upmFPdYvOt5fOZYEdoSNfIUt7ufENAa7gkiaUEVGvgKLVNRe1WAAyK81RN+2L3xUWdKN25+rG7gQ2Qo7/dgVrYjwINfdCyklWXYPbp+tWuqCOO4PV+OpwH9sO34Ml7iUKtwjbDKqlcv6TQYu9X8q6nmpyvlSTBQAfOtRcVkvhmkQ8QJhPYM1O1ArIwdc0I6ByhOQunVh99sgL9rRQ60dEfubrAkst/EuzHB7IT4Lvf1qzkwK3p1vlaFIyAF5RjG0L2lwyLnl5+XgTJ/kDW9Py2QBCInIOxXgnmeR83laitpHKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e45a9f-5d0a-457a-c275-08d85123bd9f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 22:42:02.3302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExGEVYpxwatgs21twYKhcbGZQ2sAWIVmFHTp7bsU6mUGF6HrK7zNe0EwPNaAoPe4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2806
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599259330; bh=3bhMv1rv/dc+Mxiw8T/sjYSqIdaqZoUhcMwOB2y8rGk=;
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
        b=hn+eWeIzNlS40lIUWaa+HynC+0YKyOKdSZaCFnL2mDrBT5oX6rPhOY3Q9vx2lKhXM
         k/XV4UEgOmWf9BnZerHVu3tgJYzvTnL8Cmt6u5G6/T61GLE69WLPMhkzkwoJlnFehr
         9dUpfCq4u0ZyS8ArtQsUoTmMUttzQyTcICREhV+hRrhBOwzN9BuZLSaRX4h14Bke3k
         72kbr6ljxGLkdzc5f0C51pJM5PmNBBz2H1XaA0CUvMKmQ0tq+N8ml9SN7LMqvTb9Db
         1oS4zAxpdqBJFueQmF62o6IPa3W61NkvwpjFqPPtIelLvOBRMbyCcQbsU0842UKRSd
         Nu/jCe0OAi0aw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The length of the list populated by qedr_populate_pbls() should be
calculated using ib_umem_num_dma_blocks() with the same size/shift passed
to qedr_populate_pbls().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
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

