Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8A822F436
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jul 2020 17:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgG0P7k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Jul 2020 11:59:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9476 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgG0P7j (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Jul 2020 11:59:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1ef9910001>; Mon, 27 Jul 2020 08:58:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 27 Jul 2020 08:59:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 27 Jul 2020 08:59:39 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 Jul
 2020 15:59:37 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 27 Jul 2020 15:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMZyRx3jFrk3laGeWPVgSSH5bLVeSwLkQduAxWI9HmuH65ZZ/V/emGkVdHQ+MmP088Eo0IBMbDaepp6/Ge+2RNF7GsOKj5RbVMOUThHZVJ6p2BWRc+5PUxWu5isYpXDaxCy4ZvfH/izMD0F3OzCcv/WKRJqD1dKdw7eBE31dN3rcmk8OPXK6VnFt5TXUJcC7PhDYHWqFT/lNfw0jYGa2C73bjJqOjAI/G2xwI8LALXyywfepEscZnB+L3Vm9R0IqJbecWrlgs736o6eHvWWf4RALHkLnnlCgQLQZAovGAOByTiZNf11Wy8sqJWsf5711sPya2h7V9xzph+B7jGQoRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPMONdCB4k0jTgFefoe6hJgx8IsbMBCthvowVcECkLs=;
 b=PcA7LCAQm5EUQyJiTyZtNfoPiQFt0gA0cDr/IVOdFyAoaFOaK9qqMiLWPgNllEfk2UiouubS/HGX8HnNXjKMHpEg5UVD+WyhZFuFtodUAJMF7zgrVfJyrdmhdGoOntAGr6pMCYL5ldRjXWwrAasNUKJX0hsjf1JulQDytu4aByFFq/9Wh7v4es5yBlEZIa8Wop2k/n2QX/O6EL/FE+SK4PiQ+QjSuAGCn+CLQHNj4fKDpb39P7KDhxVQhbjcjerWJLtRcrPrQB6XAbLsRBA3biH/NA3JPDmICEr92x4QqTsghB2U/bDEQcf/ZdqiUbiV9u4ajPYCsivvAYs5FCADvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3306.namprd12.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.28; Mon, 27 Jul
 2020 15:59:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 15:59:34 +0000
Date:   Mon, 27 Jul 2020 12:59:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Li Heng <liheng40@huawei.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix return error value to negative
Message-ID: <20200727155932.GA59082@nvidia.com>
References: <1595645787-20375-1-git-send-email-liheng40@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1595645787-20375-1-git-send-email-liheng40@huawei.com>
X-ClientProxiedBy: BL0PR0102CA0002.prod.exchangelabs.com
 (2603:10b6:207:18::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0002.prod.exchangelabs.com (2603:10b6:207:18::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend Transport; Mon, 27 Jul 2020 15:59:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k05XI-000FNW-Cx; Mon, 27 Jul 2020 12:59:32 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875b502c-8560-4175-40d4-08d832460e45
X-MS-TrafficTypeDiagnostic: DM6PR12MB3306:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3306C86A587ACD9F829967A7C2720@DM6PR12MB3306.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0j/iyRBXQSdEuzgRLImx/a1uM+7pXTLS6PBb+ucXCwMWpLf+7AxNG0tMNNDlCv0QAjMitfx3COF7Rhvhzh0KsiJdeAbXFfLJv8o9K9n77BAKHOxwog6twd7ZuqXURlCXOb1M3S8XuRcJjHZGiEd/rnHMYPhZEFAMmZ241pz7x2fx3mBlPhFDafixuKcW3SnTypDpiYMz0YY+ml8KEZnW49CtamCixBdbMVPSPkm4EEv/SSl3xZWFqel4hGPp22EWHBijNkmpRU2HR8IH+s+Bc4E6LoZnErRyguz3Tq2pIySZLlkeRvWn9AFz8OJO3X7KIJj4uuf216su1gjHgFWqGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(36756003)(8676002)(316002)(26005)(9786002)(9746002)(6916009)(4326008)(66946007)(1076003)(5660300002)(66476007)(66556008)(33656002)(478600001)(83380400001)(4744005)(186003)(86362001)(426003)(2906002)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 570YEBe5gelOVzJL0gmQMo5v29en78zcxz0Dt51JI4znmyR1z2C3+l+1FiImW7zXQ4DGGMCwA5GIZqBNjIgPd6+tyIAjyX2SW8/SoRumymvO6dPF8uuUJwKSsd/vf3HMMfJHJi7H3X3NspeVaPlkgsM6E04y14SsnWOYItBrvqSrFKcL48v5ewsScDrbJhgd6SYiuFXR39DvK6IK4R51sNuwGoZblGbpd4ehRTlKDy9eDcqXLv40GzJR/N6UBvYL6n6LDuCMfRcfpgTR1E4Ya/V/6TZ9BG6VgWlyb0bPV5p+KPZgYuwF/sQJQu3ehrmSyu54H3AxI4VQ2saIfLuTiVsoLrDxFkATE0Kf88441HEkynyA/PsMdaWRteU10gAifq1DiADMWJqv+WIBBEyPZizfAdywcJxyuicxYVwNCKLgIKaLtP/lyzRYmSlY5rnAg1bTLVV6UDfZXjdtyzxWbCpC9P32PiLuUYscoFLrHms=
X-MS-Exchange-CrossTenant-Network-Message-Id: 875b502c-8560-4175-40d4-08d832460e45
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 15:59:34.4152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pgxt/52jCy4nTb41HeU95oNDtd2nNFpb5IGds2DuB8kyH3D4otHMnIuS9GIg9vje
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3306
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595865489; bh=NPMONdCB4k0jTgFefoe6hJgx8IsbMBCthvowVcECkLs=;
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
        b=pDLVBEBbUrFa7lhcPmXpDY2ZviIsX8f5yfjHZsKD/+m69uk+WEP6a4y6ygTRiB5Ur
         4zbQtYxRD7vkMblyp+90etq6B4gNZK/BtZ1/ZnyLpah/ppOgmLUzcUwAbBbIrFlI2J
         NyU1m2s0chr308sDfMJoAASUSGxPUnu2NIflyHrOurv6gYTrxh1u635oD15p20uEqi
         WfXwQe/PL7t9Zjz2JqQOqyHj+FacTM7VIoQoPyyoLfW59EeOIWGEJuGLS12VwynuuV
         fjeqyd6Ri52Kjky1dEXjjnf7zczvRElTPco7MVEO/cPudYmN2mLqsITaNHDV+mTYzG
         0gNG/K7iGMQ8A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jul 25, 2020 at 10:56:27AM +0800, Li Heng wrote:
> Fixes: 8d9ec9addd6c (IB/core: Add a sgid_attr pointer to struct rdma_ah_attr)
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Li Heng <liheng40@huawei.com>
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> ---
>  drivers/infiniband/core/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
