Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AAE3AD238
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Jun 2021 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhFRSgF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Jun 2021 14:36:05 -0400
Received: from mail-bn8nam11on2071.outbound.protection.outlook.com ([40.107.236.71]:32257
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229945AbhFRSgF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 18 Jun 2021 14:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b47YbsaVsOqiyO8HXOAt22Q4/rffO9z8YGX5/0k9CX72kwIUaqocqLrUMyZRtVgWCoe/MzvDBie1f34NVc2wzP1LjGozn/uXW0zTbWce1Aye+NLhVi7u864FSo4JXUzVcA1tXctDvweLBkAK1wbAbsVyOQQ/F3kFtpDn/PIKDAnkcfsl0EGo27APJakmmHQweyGzREeus85e+xqM+JTep3BySFten6Ts5TSd2mfNGMvbuG/tkJRCXb+1fosLFyWU7q0HN5B2Qur94zb0si7hmVIBrcIuYCE4k5V4ND9dKMLh8EDX2x1vPQ6Np5TsF0fusBt9uiiqhxXmDnzxR7w1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0aIcW/yDi+CxgAsJUAqawy4bcO3zYOcd8d4pgxCxsE=;
 b=aoW6G99F7/Z4tGRaAVXppkEn5vplxr01WT3XgKlJAkp3CMPC3EKxLYr1BC/RJddKC0l1aFok2gLpeaTbfIOQaANwyJGdRmQUiKO6XnB6gOcT+Dbjtul7wJOdSM2d1QoQD7T/cEaCfBDd2JqyzsAb1q6I4BCxf6ccnEpA56kDrLl+aoF4qouSj/96ejLulD5EFYIDFF8BNO/wiRfYFf2rHYY9QBR9ZuZibb/RowJ1BnR4utw9qEZtxuoeWs95jOBYqwLFRnv3TUKtxZV5dMfIvX6qf6asphF/r2EsHUWqW+MTCFGZQdKb/zGiFpiOIU49tdOJIiLt+6U/DJ55O2NoMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0aIcW/yDi+CxgAsJUAqawy4bcO3zYOcd8d4pgxCxsE=;
 b=miuPZnWzkAhz25aBDA8KuNAuf8anmuLeq70NzHM7lcxdvwxNBremaH3Isd9ufkkJqpjCW3o9TYPbwDj5IQCvnZPkMVUSvfC9CsJOU2GbHMRkDAdrF5+FgqxEd+Id9BtYas93bMiDllOVn7R8vtCXfvbanAylw28DZfNDZfi1snX2A3pMSkMk8VxvvF5hoTqHD/26JV0qfotyxj50nlUIcAtAVvXWkcBAkZeH7GFO3PheLy+aCnbPX29tDKh7DkPxmM5b8KeXfAysnCB2TLUroCEnAI0jE/LkKcpvtdGifewapu9cTAdL44V+2mL4HwWnxHsA5N18agUa/PSf9t2dOQ==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 18:33:54 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 18:33:54 +0000
Date:   Fri, 18 Jun 2021 15:33:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v3 for-next] RDMA/hns: Clear extended doorbell info
 before using
Message-ID: <20210618183353.GA2061939@nvidia.com>
References: <1623392089-35639-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623392089-35639-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR01CA0030.prod.exchangelabs.com (2603:10b6:208:71::43)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR01CA0030.prod.exchangelabs.com (2603:10b6:208:71::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Fri, 18 Jun 2021 18:33:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luJJR-008ePp-7g; Fri, 18 Jun 2021 15:33:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 233a6ec7-44ac-4eea-cb94-08d93287a062
X-MS-TrafficTypeDiagnostic: BL1PR12MB5110:
X-Microsoft-Antispam-PRVS: <BL1PR12MB511075D1FBF795EEB051511EC20D9@BL1PR12MB5110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hGaQ6qYBn4bqZv5lY80+Ud8ZxBYKxIzbo3+ghPS+TopT5/LRa3Lvvkz10QrOLk44lFdF/xQcWCW2Wl81vEKBunNbX1jwQSsfb6i8JTUc9qdXNl1T+JxWdVom/sGM7XaObZjxczjhaaC856VEjueDeLrL9f3nvcxRpziGUvQnMuN5186JriHt+ZfHYbTleK7auGb157whFzq5YJPhQoguB3PixfiTv3Y1oIYLX/ofSgy7cxWWduj3H2XELaTs+Nb2ZSpvn9Kto0kQKGpgYSti/AJoA1m7kCT1wMsBNr8+y9dcAKLCOwjAMxggJZ7J/EuX8coKdosDl2m5DyXnIchZw4FS8UEhkSF4Wi7BCRgQkrg9+4UqnpaRkxEiLEl8SyzuiCGhAvGiG2HbyO6H185SQSK/kDxta2+KaRGrCicD6uM1niqK8f7+jMne+EYo9XhXmmjRx37FRTTwns3JfQBv74D9gGOoww93x0Ggom50s9Ddfn5D3nbYZbRC//TvA7nYger/FEvK1yYtGqYCg7lLenmpzB0ZzmJ6bbINfN/w4QUhnXFr0noiyKbVtJkbzYVhGxDDj3LUQU9OVbUK/OSWoz44RBtqEACytAZ9jLg9MU3mInDhv8dFZZJ0+itCvXtVgL33KNWKcOqibnCNu46OAAIqkcyprGzxUzEQftK5VpCYNcw2ZAMgB4t4qr+OazMY/YzOdhpz/pHhGwIqrBhz+2G5br12fMwFoEijZINWLfD0zTuq9hdEz42GzAxAPRyC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(5660300002)(478600001)(4326008)(186003)(9746002)(966005)(38100700002)(26005)(66476007)(66556008)(2906002)(36756003)(1076003)(8676002)(8936002)(66946007)(86362001)(33656002)(426003)(9786002)(2616005)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZpOznDuBW16LKs9KPXFFRywtatAdFGZ0isOOcb3WM/TXrpXJzUij/NtUt/lD?=
 =?us-ascii?Q?0nXmXT6AoNS45Hw1eq/v7DZGCG8OOUwH4ckvn+G4Tl2qc/r+IE5OIEQYfMZR?=
 =?us-ascii?Q?cpLPnyko7T75aLmZyMOAFyJ6G1KK9WoE0z+7RkNdVDAVVkHZwxoKx9UPm4U3?=
 =?us-ascii?Q?wYZNPbFtKGn4eTixhLQxpf8g1VhosRJURYqJNDS0hGjyNiNHQScFTjGp+hqc?=
 =?us-ascii?Q?fRzztSZPU1SuaEUNCTljUn37GpQ9mNZJcD4Lo5ogS35VCOkWQpVHQwCTky9+?=
 =?us-ascii?Q?K+dJZUJWyBnjibzolFuYV+NxyeF6/jTQKwyOFTSqpMNaNMIsHD3DBRQpI4hT?=
 =?us-ascii?Q?4kzk7Yx85ASueeAPBmcTh69QJCIa7YjWWVdtrjfUiiRtitMRisD50sl5A/C9?=
 =?us-ascii?Q?0YcxOFLsX3TZoEJhIojL0xAE+RJvmZF9OMON0kb0tDLAJXkIWRbbpPBOcOIa?=
 =?us-ascii?Q?2gNwbhyp+22uk80JNuR5h9bqtHX+4GY0bU0M26HmIvFQUX5cVanYv63pfF77?=
 =?us-ascii?Q?GMnv2Wn2qMdcajxYk6WDdywiUihYJJ+t5GihiuRVom3DalxGYjiymL7KEdBK?=
 =?us-ascii?Q?JO7sUT4/sNCPsYNrfsPL1eyVLPZ03A4VH6tkONtFYM9pX4qZnMYn1cpjV8TI?=
 =?us-ascii?Q?K+XG0/cxxtKrau72X8LWUbp7X9eIz6cp9gv24vkmzPrrapKPl/i++W9X9/F0?=
 =?us-ascii?Q?vqvTQhapfXf8xtVjES0UZt6g35eckwZ6fz0KumMf0uEhsjDCQOERAu4IUF3a?=
 =?us-ascii?Q?NwO+cPBI65FqOrSzy7haGg0DnvrU7wxvjjOxT0nlQiwcAMKBqgVJMoUPSBPg?=
 =?us-ascii?Q?7eF8/si5gBTUzokN9ivpXQpNcHm8OhoHe1ryYzjmiiJ6gTTn8Fv/d6MCc86R?=
 =?us-ascii?Q?AxO0T4KeSA91jeDjTRw5rto0DtMCD6Wj52hcW5/eMz+ghfvFP7tu5wMr3c5J?=
 =?us-ascii?Q?NhEEnJJ4EhA7d6skCacNPr11JODC1cOPB7bUMWMnL53w1UvhNCxOkCYTnT4D?=
 =?us-ascii?Q?wQGskmrOD8G0J1bU9TOAFIz0uX+AgNSEwz3ldQEjV7Fu6E0q9jCvANW7ol0m?=
 =?us-ascii?Q?41kJp8BMMPz+mdl4YxygrOPlMCoSaOgezPw71QtJ6rQlJVwzYkfilQbhGOnD?=
 =?us-ascii?Q?4vVQjISgz5UMquy2KESsfGMO2RqT0fL7RQNgQftSbI0N1mvuCW6RSv+qctec?=
 =?us-ascii?Q?uTFvmWjvRI+zhwSe9FmWjAiIfulk+IEjCtmuyniB2F+kDTWJynd1ANMaOYvz?=
 =?us-ascii?Q?eZ9EYJ7+Y/6f7PId0YVl1AGL3EQRpNEQKvw7xM4Wo/qs5eRNF+6G9qEgpY/S?=
 =?us-ascii?Q?lJrH9oEq+QiluRURFc1hPSbZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233a6ec7-44ac-4eea-cb94-08d93287a062
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 18:33:54.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzXbaCvbqNFK0ZBUeSr3eeXMfUxTaPn4VOex7okhm4tkrZwz33U2qtJnQzP9iAMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 02:14:49PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> Both of HIP08 and HIP09 require the extended doorbell information to be
> cleared before being used.
> 
> Fixes: 6b63597d3540 ("RDMA/hns: Add TSQ link table support")
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changes since v2:
> - Clear ext doorbell list info before get_hem_table().
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1623323990-62343-1-git-send-email-liweihang@huawei.com/
> 
> Changes since v1:
> - Add fixes tag.
> - Add check for return value of hns_roce_clear_extdb_list_info().
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1623237065-43344-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 21 +++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 +
>  2 files changed, 22 insertions(+)

Applied to for-next, thanks

Jason
