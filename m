Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC11222A8B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jul 2020 19:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGPR7R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jul 2020 13:59:17 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7034 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPR7Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jul 2020 13:59:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1095380000>; Thu, 16 Jul 2020 10:58:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 10:59:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 Jul 2020 10:59:15 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 17:59:11 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 16 Jul 2020 17:59:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi8W7Fra2q6XJ5sy8VB9ljkfMd2VF2eC+rl8avj2q4b5wfqi/sEvpjaxVBQK4AxxtYK/4h6saHsAgWYNao26usT49OjpmmsKlQL4z3EgAQZQRUGqXzZaUW0EC7B1v1Vb14MsEvDHyci+JcZcG9kGgDmRzfUcjv5Vvr/+i+1CYGzEsfJhOTCtlRDDc672yZUktiIkGP7BuPcQDpZ+6LeruRdoKkVh5TsgBVqGM7vI0xJRoZUA6BvGOstt8vUvsZH+fVjZgVry+AM4cl3zgJDkLk0i2OCc8ESTo2Nc8dGGYVDEsdSBddoHCyWiardZHUknqmEbvF0exTfe508kwGuVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLifo1I/AoNHkPgmna9paZe/JH7ralTcpJd73FUjUdU=;
 b=aIXBFROyFQKqTQRlewKp8wFF3mKcmAyHmi3R5EIj7QOEemFMN4iWOI9UgOUU3OViqoC6n7u3RiEfKvT6c9ocN+9cVC6wPmDmn+//Xq467EM40QOQCm1WbvvdkPEez0iZ0Pqv9odNtBYD6Qb8NSGMCc8v1/wKVIhguUeyf+efo8PDa3T+FgzisuyxPEPrn65aeK5u22sGhyEz4ZTnz/U+1a8yhZakuh7hHj8ld3+VbvUDutGhsEKsWNlxTR2C3mcZldNG4b+FoRhtX7XWnh8ULccvujBV1rAYFUZrQJ8RItROqrgxxY66zI1rliNG03gb0v4c3byp9vHq3wzA0hPLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 17:59:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 17:59:09 +0000
Date:   Thu, 16 Jul 2020 14:59:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yuval Basson <ybason@marvell.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH v3 rdma-next] RDMA/qedr: SRQ's bug fixes
Message-ID: <20200716175907.GA2653867@nvidia.com>
References: <20200708195526.31040-1-ybason@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200708195526.31040-1-ybason@marvell.com>
X-ClientProxiedBy: MN2PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:208:120::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0024.namprd10.prod.outlook.com (2603:10b6:208:120::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Thu, 16 Jul 2020 17:59:09 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jw89z-00B9KQ-VV; Thu, 16 Jul 2020 14:59:07 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d4a211e-88af-4cf8-de85-08d829b1f059
X-MS-TrafficTypeDiagnostic: DM6PR12MB3834:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3834176D848CFE9F8785A75CC27F0@DM6PR12MB3834.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vt/tuDjlxxC8Hnfz6jTizn0jb+6zpJZwujXbAX7pxPpj+7zyinH9wzwGoX/vpkRq3nHK6jloEfe1ggOQep1RF9NhLcmrZm7F79uYho9pncVJHpUJGk5gwxDopkDkVo2jLfcaEFJRF/rIsOgHwLUu6Qc1xFVNvEoUXvy65Nrdv//i+VWRf7ZH3A+DkuzQ2gbevJVV2nQFalHS40fyAVARHnuRuxIHaU17ur355w3OwKC6E0eMHZ5WHynN8jitWMmr/j/YcW1AaGddSDl3mRarCwPf0VXHwSoTYPBppEOTfdxJryqMla4SEznigNzZGT/G5rwzlBYAkZXZG7q7jrXBJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(8676002)(1076003)(36756003)(66476007)(426003)(186003)(316002)(33656002)(2616005)(26005)(66946007)(4326008)(66556008)(2906002)(86362001)(9746002)(83380400001)(9786002)(5660300002)(478600001)(8936002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mEOoHzbomLrS5nGoLg4G/9xF62InuRDNhK0dlS+KbA383xA7YEeTiyvJ4BsqptiJ2i6qWddNNII9ZmghFT97vELAvRFRTVX8yyLmGd7fVZCCz3DXi0h832HZea1kG1mitTwEt3vPBmaah2cwhb7yE8oWYpRTaRmIogSOax/ue7hDdNfARGbYJHi9WWGkRGIhFQxjlHErSrmuNh/6YVt1VRfHovdw+6Gx/j4HIimA86gSHdd1A9UyIFyxyQvenm3R9VHtNOkzVNLUwzQxHCWMUybhbww937OFPrWb44DOwCHhaYI2ZrNcJJm4XflPp4yLoyaSLK82V9P7kDfomnCE/jvHmigxWvjvopZD/ldpKt9JlyFcdlIs4rdGvdvPySGsTLefJJfX5uGoOui97rgGJIAQ4Fp+D7Q2TsILD1YFuSwjpMkwSEgIXsoY6jmgLTMQoytxbVwwhPn2gzELyb6mpkzgOIFrt0d2kk9IDO/INKs=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d4a211e-88af-4cf8-de85-08d829b1f059
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 17:59:09.4744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xsXPGksDCbw5jNo/oR5UXjOPOwUm/SUYY5S1lbxBxgm1hmDiXH4nQNE6on9m+Q9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3834
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594922296; bh=nLifo1I/AoNHkPgmna9paZe/JH7ralTcpJd73FUjUdU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
        b=EnxjfCPu47Bku03zH5EtNwn8HgLSHt0daUmlYVIxgUikNSFGdNh8eaO7FA1nfYhYO
         p7d32vpt6EEpgreI7aakz8+9+6VmlqPbrCDEqsP9qSAY5zZEfK+JfKNjg1O2pEZSxm
         ONf5uK4SvTopytNGCW7vvRckTx1ro2La2HAIoCULZ3/lMUmBmFxru9Va74pnceBJ+d
         GzKUNbTM6J3moYny9wtY2ApFGl2kEihVnKdSXzb51KVPW2e6nURwQeLOPOKFS/wknT
         y3eCF5PlYMxp3hMAcNd76IErIo6Lyh+Kf4cmSzgYUPFeBy7OUFgsL05hSjjP8yEO0t
         NuudVZJeqDkAQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 08, 2020 at 10:55:26PM +0300, Yuval Basson wrote:
> QP's with the same SRQ, working on different CQs and running in parallel
> on different CPUs could lead to a race when maintaining the SRQ consumer
> count, and leads to FW running out of SRQs. Update the consumer atomically.
> Make sure the wqe_prod is updated after the sge_prod due to FW
> requirements.
> 
> Fixes: 3491c9e799fb9 ("RDMA/qedr: Add support for kernel mode SRQ's")
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Yuval Basson <ybason@marvell.com>
> ---
> Change in v3:
>  *Replace changelog
> 
> Changes in v2:
> * Change barrier() to dma_wmb()
> * Remove redundant dma_wmb()
> 
>  drivers/infiniband/hw/qedr/qedr.h  |  4 ++--
>  drivers/infiniband/hw/qedr/verbs.c | 23 +++++++++++------------
>  2 files changed, 13 insertions(+), 14 deletions(-)

Applied to for-next, thanks
  
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index 9b9e802..444537b 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -1510,6 +1510,7 @@ int qedr_create_srq(struct ib_srq *ibsrq, struct ib_srq_init_attr *init_attr,
>  	srq->dev = dev;
>  	hw_srq = &srq->hw_srq;
>  	spin_lock_init(&srq->lock);
> +	atomic_set(&hw_srq->wr_cons_cnt, 0);

I deleted this though, it is redundant the memory is pre-zero'd by the
core code.

Jason
