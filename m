Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1A938B368
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhETPnH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 11:43:07 -0400
Received: from mail-co1nam11on2073.outbound.protection.outlook.com ([40.107.220.73]:48960
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231852AbhETPnH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 11:43:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nseJm+Z++DS1Y3fsXM6tKIfAhSTXg64nJKjBxP47vhtxCcFVc3W9ZzqnNYIF9eSnYdqP3dXukEQS4D1+3u8fRd5Qzjrx4n3hXA//OFLKAcCjAJ2qZdezqT82+CxBBrcnWMbrwJJo0S9OvLysbd7JO5FC0n3mBfsZrbOGdq+7zJheGoEqnraLT8xwvCe8ZTckK1f7z5xfddMCwBmIDS4ThDYH5OcYSqYLDHSNu250ZHlBy4mp6J68d4gU1Zib4tNHxUYWSyLKEpApK4jH2HE3os+Td+O1Y4se1FhRuELX5PUu7VV2ZYAfrn1+ic3juv1Xg+18jf0EysjLa/sPGCF6gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJo4eLJXfbG5ioQy2+8PFarnPAj07FRlEZrAu+Q3P5g=;
 b=RCc8eFCPiZwVBXViUeQjgO+mjMasqVIkJVVPRfSPaB3lJ7m1z54aw9DmlctmK+MNvC2+czbzpRxawmmoz2g5Yd46JTUmQdZvdOIncr3sm95UiwzP5ggJq6pNLE7gTDpcy8+JVmlFboI7iEcxCm6vRXYLTPBVYWfmAPT30PbXuljMrPRrnlNFRaH/UyAnJgmCaMdpVOR9jsALWp9FJ6dLTZWa0bb5fUkSkGmhucVaxrOSpAjIy6R2PmI40rV3foftxU/HNntLr0Sqiwskfis93SMFNQ+R8/qqYHqqYV9EBm8jaLTGAe13n8LoCdLuh8cjcLGuc9i1JoG9GCf7Y+cGIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJo4eLJXfbG5ioQy2+8PFarnPAj07FRlEZrAu+Q3P5g=;
 b=uimUOgp8hQWcnhLSFG1PQIn9MWHwmiz/TISreg4UDtks61WIild3e1I9kYvQBQpFqowCQ9G1PqAZ4+HUef2WKtp319/PjVxM/qodQUwxl5ABm4/zUIR4GTN/7m6bd7WhnMaHzb2G81PukbGW6FXx4UC1iLdUWaFVa/TUw3twdZv72hYNTxRRDtCFH96jl/P2sv6YyoAnPx3lPVjsSmpM+t2rlnGwMTjLawHPY5JFVWuq2uXlDX5iBQcOTIgO+3S1S6EFPAYYZzdhPqNnB9X7/Hg17SBKrRCz9GgJaU6FH82u4KQLhpsIh+inB4D2hpa5nraM+BoXGDw/SZkzbRIZyA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 20 May
 2021 15:41:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 15:41:44 +0000
Date:   Thu, 20 May 2021 12:41:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Refactor extend link table
 allocation
Message-ID: <20210520154143.GA2749689@nvidia.com>
References: <1621481751-27375-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621481751-27375-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0070.prod.exchangelabs.com
 (2603:10b6:208:25::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR0102CA0070.prod.exchangelabs.com (2603:10b6:208:25::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 15:41:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljknv-00BXKb-1k; Thu, 20 May 2021 12:41:43 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aaef31f-cfb2-42de-5308-08d91ba5c538
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2490:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB24907B8047DB1D0F89D287DEC22A9@DM5PR1201MB2490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjUWnScXk6C+zTAQCjcRrgKfcJMB0gqDPmwQfZVQPIj6eNAlV5OTb/68HmIt5Bm0XYBUJo5gFk6sUoj9uJ0mhK24VphxpEJCJ5i8+jBQaXCsjmFd79XW3jsPyNq8rm1mkBRow2HEQ+9BG6jy9Lehb/zRnoLJSIwqijrZULTnGVGAJw3wWsLVSOBphJJhPf4Q0LNB7Z5wx8BEHH5UqzRXMr3+1XT0fyVJHyHkOYoQwo5XehoXN1vjyQtBiPFsJESUBEbjVd9JkvOvs/Rh/H32gxaM7TswAxvF9rgcUpNdEAkg/LV8m+/X1b4cH8JCv0w1kd96OHIoY5fsujZH/3lIREfkIyxP+m+e4aEh93KxKfUaer+Yu/OvLTDkX9wBNGyyEfkfiKx2OIO5hsqCohbTz2ygoADKbll/1trJz5rJFMIheteKaYUtmcPWm2gz0VFQeIE5U6TrItbaDaMmmTEZayMmGZBngsqfyOXp8PSQkK7igP1OHZCtty0efZCW9cOBzI2mNhd6AHV7rOwXteaTnqmzZHvWgBrG65huQrsxIIOhV+C8eH05e4pobEXlKqiKsplgh3+aNvRUf+TerGvwYXFQEzK1F6bYSubgqSH/BKPhbfVlirN4qSiPZuwuUzBWuZM6qnTZ1C1LRzPiUUo5+C1ohRRzUwKvj1wu6oK8omZqEQP1uQobuFjI7Q6l8/Wc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(5660300002)(2906002)(4744005)(6916009)(966005)(86362001)(36756003)(33656002)(83380400001)(26005)(316002)(8936002)(1076003)(9786002)(9746002)(426003)(4326008)(186003)(66476007)(2616005)(66946007)(66556008)(8676002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?cXFmJuH3w77+z1VJhjQ1wWPwvzSV/453tsb2xgmyRF+1kA3xvEWT3iZmoPAz?=
 =?us-ascii?Q?HXSDvT45buJ7cyEOlIknNfDzaeMp/hxj0fTq6mLgbG53U9+iT8fV0Pigceg0?=
 =?us-ascii?Q?U21dUCVOWclB9OXxazTsFGaRMViJJsOe3saqH2C1MIPvr9qSs3ZHZ3EFychQ?=
 =?us-ascii?Q?hvFS8G2RJmc+OkUsz0j9VHT8tX2cGs60rYrelDLCOBXsrdNim0Bt1PQZ3g6N?=
 =?us-ascii?Q?/65xiyCpoTSeYlkhZmJHwy/rHxuvifheAr5LPFsoYjiVd3EiFoV0DdIc2ksj?=
 =?us-ascii?Q?gzRW+9dzKG2m2jl7WdVzbBrPtPwSIO19K0Up61vTZv/UMpVwCwIglbXf3RJd?=
 =?us-ascii?Q?5dChIoCOOYN08abSrTKf6xnPTH7Z0NKwvRH44z9KqZBs4361RC1n0fOgdujT?=
 =?us-ascii?Q?xEEmaZqdwMhbt/A/F+wZ/6Iygz8GK9dSYnRv0x7KCC2N/5CweFKDaN40XpGi?=
 =?us-ascii?Q?Woj2RiDbF+I7HKuXDZlOa+lWU3ENKfGCkIbF05nfD1rigQK0TYrXF505ob8c?=
 =?us-ascii?Q?0z8cpX4+QJPM+oAeoC2hyA7I2pd6IU9bo1915zu/q28FAqbq4wPNXdgL4n7O?=
 =?us-ascii?Q?azw7KNSfr9u2cabTpWDR2Dj4k0XirEYbd+uO4MZwAmxWHDtDp20sAairPwww?=
 =?us-ascii?Q?duXdH1tX2eTuRFFvdQE9kYy7WO/I7x8KPjsh6YldX6c31HwB7hI0NdTdjj44?=
 =?us-ascii?Q?T0pDCGXmzZGVcueK2otqmH3nAemK4PLmqf8ZXRxSbncPfM83okIjgqZgILqr?=
 =?us-ascii?Q?ib7etmTt5juXf2+wjlE2lEQQnJP43egMixvGsjQfAwNR7XvByaTllMlFI00L?=
 =?us-ascii?Q?Ds9C3nhpWU6ToeTIU3207gSX7HR9DvspISp6lJQyHeFmbH5EUzC2C6PqDxtL?=
 =?us-ascii?Q?T9UrOWezjDglp9tXdAKNjrGG1Htj+9bwcgyKx98d6NzhA04tDzus/QCtasyf?=
 =?us-ascii?Q?JkSZQKNoiSORqF9LrbmR4cpjxLgQ0Yri1abMoUfgfmJfshJVhnVDe4QDqpkU?=
 =?us-ascii?Q?/grvsOhiDRzCcu4R8VB930G4iHV5NOuzqDNqWhplkntvMmoeSKpEpMJDcl61?=
 =?us-ascii?Q?9ZtcPqq2gOqgYdM9zwdh/6zcxd/fMnWTTbY1esaqVxgmHGgWCbBJhqfnc6cu?=
 =?us-ascii?Q?z1CKj0QPVj8YzSNuTgpGVHrDBkJqApZCPY3rB5LdO8WqYcCPJKDYoqy1zcsO?=
 =?us-ascii?Q?Lx0D1Tar4vB33ytFHbTYwWkU3T5Vl30gdekObLfYA5Dfh1xTV/6C36SKJNKR?=
 =?us-ascii?Q?iv7frErsW7dTdKEK/Sgvi9ocW4QGRleu5zRgDZ45nk0eSro351gIQVol+Eie?=
 =?us-ascii?Q?NwcVVOeYB4C/frtO98o1jGkN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aaef31f-cfb2-42de-5308-08d91ba5c538
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:41:44.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WP+p55HgkJYHP6fAzJKpuNjKC96u2KSVs5zEbm3mcYFA6GV2h13XzkAaM0SyN9sB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 11:35:51AM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> The timeout link table works in HIP08 ES version and the hns driver only
> support the CS version for HIP08, so delete the related code. Then simplify
> the buffer allocation for link table to make the code more readable.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changes since v1:
> * Merge the first patch in the series into the second one.
> * Link: https://patchwork.kernel.org/project/linux-rdma/cover/1620807370-9409-1-git-send-email-liweihang@huawei.com/
>  drivers/infiniband/hw/hns/hns_roce_device.h |   3 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 255 ++++++++++++----------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  72 +++-----
>  3 files changed, 124 insertions(+), 206 deletions(-)

Applied to for-next, thanks

Jason
