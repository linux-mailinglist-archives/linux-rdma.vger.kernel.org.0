Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551ED3DF1E3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Aug 2021 17:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbhHCP5G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Aug 2021 11:57:06 -0400
Received: from mail-co1nam11on2062.outbound.protection.outlook.com ([40.107.220.62]:48480
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237063AbhHCP5F (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 3 Aug 2021 11:57:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k84bCnSQ16dBoS4g1uuxSFt4p95uxFKSfJ2JQYXMA280iD2TPFPi4BDI6xuyaGDEjiKeYRKirwra927rveuqVFEJoBvrsbeLnt8i+ODsNc2NUIeCSjzdGKMKYLynOndohh6svhwvG4SLjuP88DmeCp7Acy85P5k5VrkhzGs871l1S11cBaBFgXSdDgkcBw5xNLSwpCFDY63YNdktQVvUc+LuAzkE6SDNldS2yvND+fyjp9cAU643uFuKVspYe6FVZhq2jIFqinvLhLI8aCpe8izRgpwWuKRdz3ZmNzqa4xkBjFNcwsJK1gYMpsU4KBzqlBtMtXayUvwPur2eC7isGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGS5vjcQfuG1w4tKrxcOpob448tZoG9kXWJMJxWTMQs=;
 b=RarCVqmxMDrBWh+5zBepE2LNFNotnp/8VuC5DNXnoWp4YpQmL6ybnWEUOXLEkAV99uju5rhRDzH0H+n5aLz5gChY8MFtuhqkytG/sDO0Yehj91JCnrSvDT+SJnltqGXKxFvBHFpQEQqbuok2fucf8GbVdSzfmhve0Sgt1vIvqTR64FvVQoUm/THVNy/WH/clQe9Zs8w+oH9t7W8LXOZPh5UQP+Ec+BpAhm6jeMgwAG7S4Xbl7QaX+E05MAcRkuKUnw0p5WZF51nddKCuAV1pJXYOOI/k8hRShkSt76mudar5c8jbbzJfK3AtS/ZNxlehJJfbes45EwwfUW/bglJC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGS5vjcQfuG1w4tKrxcOpob448tZoG9kXWJMJxWTMQs=;
 b=CYbBIQTspe4ks0YXh8n7kBWTDlIak3WiVYvu4Kxr3C8lndkc5JF8qjTHUgkwnBE0HD7RSBrRwiyWqbmBo8p42sL4ZquJGMFp8hsTNpK48nPgpsN/3yGnmCuig9v9KMScbstaRFBle+f4IMp7SWS9bBu8gEgYqtD9K+6xlJjphOxH4oXFCworRDuUyhYx4XSM9zTvN4/oGGRMZRMRaHw1o3yew+Wczb2yvb+kfI6KZH/3vRfAfV7q8ug//UCtWbQ+ljAg/xzZLM/zD14LryweR0tEUx/3QwtlyFQflI1wnx2QFrSnpRp6OlSP3PiNtt9LZSyodezoScpMFkRb6OVp/A==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5537.namprd12.prod.outlook.com (2603:10b6:208:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 15:56:53 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 15:56:53 +0000
Date:   Tue, 3 Aug 2021 12:56:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Delay emptying a cache entry when a
 new MR is added to it recently
Message-ID: <20210803155651.GA2886223@nvidia.com>
References: <fcb546986be346684a016f5ca23a0567399145fa.1627370131.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb546986be346684a016f5ca23a0567399145fa.1627370131.git.leonro@nvidia.com>
X-ClientProxiedBy: MN2PR10CA0032.namprd10.prod.outlook.com
 (2603:10b6:208:120::45) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR10CA0032.namprd10.prod.outlook.com (2603:10b6:208:120::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 15:56:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mAwmh-00C6r2-EO; Tue, 03 Aug 2021 12:56:51 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baa3ab95-f4b2-4e90-9d34-08d956974f91
X-MS-TrafficTypeDiagnostic: BL0PR12MB5537:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB5537E61F2BB722BAA9545AD9C2F09@BL0PR12MB5537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:422;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qco2bCCgT0YVNgBEIt1UIYTt9ckRs1hrSxVSaNdpwJJccmaHAacoKRdKnpXlFLIEIu8QiHVAkXyLtO98diVmaRl2zYGnzGZFEteu9vsAwUFdLZc1YbQTrOcMOtH9wVaDxet9YR0AbPxMYYGMSqp2bG2p1pT4077Y7oH3b9gISw1AuGCGW4V/DFyPcunkJYg3NgvtbeZ7nFbh6lqiucdch7V14zyd4fFDi6QckiKtpZ1CK7eOhU6O7Rxcdqa9xAts33vTeXH9Oq8cYfQ41/w77S4Q4PUbb286qezGiNX4EB0oxBcv26xQC+xzdnHz4TLzHXURIvOyzoGRKT5AzPp77azQyKypam2bp/NolmOsT7GUHOvVT/p8zo0/Q3zMgjO63fJi8IS9GDsmiUVTgCvCw88WneAk5xCF7n1leMgFI2HGh5J/88CidWlskR5hNAUq0LFQ0kVPsKiv+SjUP/rmW3AlyK+oju1B9WAPdJFSRigpQyGe/QiS5ezxb572xzqae5J0JcfZ1vojP6X2p5m9DoAIvPCtQsiHfX4iGzoy7tOG5qjfqwpZK9yP2DnlrectjRQjKyTCL/SXSclcOYBHijErnuCnhHzCggZn9EJEVUWh3nE5WQZtsLFNAlvGkiUyHxiNL68IVxGigx8VHmsHLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(107886003)(2906002)(6916009)(1076003)(2616005)(426003)(38100700002)(54906003)(9786002)(4326008)(86362001)(316002)(186003)(66476007)(66556008)(8676002)(4744005)(8936002)(66946007)(33656002)(36756003)(508600001)(9746002)(83380400001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Imq3pv0m4LDt+wWmYyx9ZnF55BRVa1rerg8vBppUFwxnKl2a7KM9Iv8BV4Vm?=
 =?us-ascii?Q?Xc7gycgBQahol2p7JLaLRCYHQ1udjYMd/yq3x75+iHosNc7i9U9J7w+D11/5?=
 =?us-ascii?Q?cL2cikyk4AaZbAoNwO1bBNrIid/lO7EapKuOlME9EmojtakrWUk0fnz9kOZw?=
 =?us-ascii?Q?2xOCDZ7wpY9ZIuZrZ8ZCJxRESeCodAMsfkc3aoccMy+KLcRJihnPyabSggC1?=
 =?us-ascii?Q?S79/fC5mZXNyBTY9AQ67QopMvH9cs0Izg0HzkQFzRoh9e1L0aQwyKNR3jbLi?=
 =?us-ascii?Q?Jq5QcLrBzE/uzbpRdKrpbMD5Clwa/cEdDb7MnJTqigI2nN5k/x5u+3ZirSPi?=
 =?us-ascii?Q?yL1t6FQPTAloM8b5VY+17rPg2mu2SGJnET2wmFxfBv74+wV5XHJgeXBOU7ag?=
 =?us-ascii?Q?uykkEGecOTgogLakb13IpzJnr4ma3fdkStGSkbN8kSKOpfM0svxt/yRnYw90?=
 =?us-ascii?Q?eP17TYRZSYUvnJwMFQWdE15lFGR/S418lf8RASmjYaGAWK3tPNRPZVfcD95O?=
 =?us-ascii?Q?RFf/ibURb8GQmfXtugokyC07hX6RNZXljQyhGJMLkZ/R2XMvY+eb/pS1lsJ6?=
 =?us-ascii?Q?HWNAzs/+B2ZfHTpnU+dEkb+4s99YWE3zgJ91ztb9d5q4h55Szk9VajYglzSO?=
 =?us-ascii?Q?yMoGy6ztO96T1+BOkR0a0yVCSoulnQ0Wv+Oj1ZeOopsRVoDL42t3nZvPZU28?=
 =?us-ascii?Q?SNDugwwf1AYSNeyzXEzwWVz27i3dUDJmljKRJbQFvsUc5lonLCUAUVLGG8g1?=
 =?us-ascii?Q?h8aZOPVFycd8AuS0i7QamYyvhYLDiziZgB0UcucsowomFwQ6xShzleHN4HH5?=
 =?us-ascii?Q?ODnZCUznLba7a9I7EA9cfbzsZ4HYBKaDq/A9xbyIFimmzh74J746ckFCceV3?=
 =?us-ascii?Q?hTKfjpAYbp7LUCu2h7WhQXoT4B0mrnVL8Zmk1jL7R+hW3ZGc+wkdpbBqH0S4?=
 =?us-ascii?Q?VDcc80+ttnAeQkivJa5M1Fyq3FycyMgcaFW1f+YseDgNZieRYi0z/bTv/jnF?=
 =?us-ascii?Q?PTeIGt9+eR6daJq6w4/v7PPP6lmFvuEEEYeiZrZR14x0ONWqdyJsKtIfwJPJ?=
 =?us-ascii?Q?XmH/5Kftgk43tR+xXnYGAENENytAddKliBH0Whs97jJVtYQzRhTirKWIBUr5?=
 =?us-ascii?Q?VXfVzwn0nF8UlMjkmlIPh7hKTL4jiq5rNTDvrZH5jSuy1rULDcOWrBvc1hOT?=
 =?us-ascii?Q?uyq5rptQ9oj56BTidqcNa8paMD8gBn42+7J/bWAetxOTGu5k59snhdxzAMEY?=
 =?us-ascii?Q?y4yxMzQfCUIVHGvVY4jY7eP04a+DVVtgPPYoXo5vKimLWx58XNHY2e3yVqYi?=
 =?us-ascii?Q?W8N/3LYSozoDsQKSV3TXWqSv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa3ab95-f4b2-4e90-9d34-08d956974f91
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 15:56:53.4227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CXjXZlBTOcegEzbGUHBAAR3KTWigTlvdEErOv+expXY1kZPnDQ+zZlaUuR6Xm5S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5537
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 27, 2021 at 10:16:06AM +0300, Leon Romanovsky wrote:
> From: Aharon Landau <aharonl@nvidia.com>
> 
> Fixing a typo that causes a cache entry to shrink immediately after
> adding to it new MRs if the entry size exceeds the high limit.
> In doing so, the cache misses its purpose to prevent the creation of new
> mkeys on the runtime by using the cached ones.
> 
> Fixes: b9358bdbc713 ("RDMA/mlx5: Fix locking in MR cache work queue")
> Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
