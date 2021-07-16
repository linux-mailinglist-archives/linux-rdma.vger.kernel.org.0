Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A849E3CB86F
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jul 2021 16:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240103AbhGPOLC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Jul 2021 10:11:02 -0400
Received: from mail-bn8nam11on2087.outbound.protection.outlook.com ([40.107.236.87]:17536
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232947AbhGPOLC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Jul 2021 10:11:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMyOw/mvGPlGKjDKYyNYZoWzjbVgdK3QEmIpUXcxEhBNeUtjs7hU4D5to0lgY8Zma3PLSkWVSHiYUeuKSHDBRSnMhaPEk60obdJYc6GCqgMAIFt97whPnqULcBHKrQihEGMFl09MapJMkEakFG1fOd/hiWQAH4fj0tzYCfMQoCQgUvgXiRX3bcwv1x1bpR/G0l4nHcSJ1fNRf6w0zadLfmnJXA6v83bYShELKeLLe1QDJFbPvITz0HfQKQ8UJo6Y9ZE5ews425ouPwHt1zkmkUseD38/AUTfo3WABOln9rT3L8l3RD+sbAqulyK/lmt/hlYaseCr9DpPG/psW1BC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUWXB1XOdhDFcfeiv6syrAQoAedxiguwBc8Ja/KWN0U=;
 b=Szhk1wD6j7W+0h7lqzVIKPiIqICzbcvD/r+D4eN81nO7oEp78sa8R3DbLCEgTHCUKGJhWTDOofDHF87puUM9XKt3wyg3urWc4Cs1OekbC6/zKxbZUNTaxyficXO7xE6/mepwHcFIGzL5Dbl34DF72INXdHby+ns7w+EauEtDzOfTB87GtOK/KkQgibrFFGMFe0w1uiTfJo85y/bD0E3lf5JIx1MaDOGRNclViMktJarX9/mYj1kDkKTZFbc66zfbQJvOi5c9Rh9CKLVqyB3eAw3r/u9UVpTC66j/nu2bXnJ9LOHuRNcY14WUQNZkOaOemcpUJ/mpU58GTCoEeYa3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUWXB1XOdhDFcfeiv6syrAQoAedxiguwBc8Ja/KWN0U=;
 b=NhXUJiD+D3OAtPLN4n1iqLZzivKCyUZFVSHO5kpkHtOuDIUjiVjX5HfxuxU07vG20X10oOkHt3ydwhIg59oEQ3ySWO1cxa73eVAbT/5hPKMkQ7sPpdRPGT3MJDRqnyP5Y/Qgsj9E4mKFzc+S/XC8cK4ktnL+sxYBXYRY2GMjxK7xPw9ufbT/azk2raLXALPzE3nB0XwpEEWJHQOV+xMCItL/l4y/3JUfhVyKfjjPToHWwm7dJptKRFGxGjf4lri9zqNBe3PQ2Iz0skiJinnQDWONq/gDj/SuOb+eDHqirXYvJelSLBDNbwJ9UB56lqyHsxnMPksLc99E+zWat6Lu3g==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5173.namprd12.prod.outlook.com (2603:10b6:208:308::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Fri, 16 Jul
 2021 14:08:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 14:08:06 +0000
Date:   Fri, 16 Jul 2021 11:08:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Anand Khoje <anand.a.khoje@oracle.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com, haakon.bugge@oracle.com, leon@kernel.org
Subject: Re: [PATCH v8 for-next 0/3] IB/core: Obtaining subnet_prefix from
 cache in
Message-ID: <20210716140804.GA752808@nvidia.com>
References: <20210712122625.1147-1-anand.a.khoje@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712122625.1147-1-anand.a.khoje@oracle.com>
X-ClientProxiedBy: BL1PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:256::28) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:256::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.10 via Frontend Transport; Fri, 16 Jul 2021 14:08:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m4OVY-0039qu-Lm; Fri, 16 Jul 2021 11:08:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5770605e-9a00-4f95-656d-08d9486321b8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5173:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5173C4DE4C9A167713259EB9C2119@BL1PR12MB5173.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RZ6In5tJylov48Cta3TBgzeJQ11na0PnM26fh16fCz1DkTwitkM4ccAoqj1FdDtCVFjM7v90P4o60B5cy+UgDH410WQKjUPpys/vTkH0sZBFyUQNryfDj1jqXzsJzxXZwgZ1YFoAeYML2htc7q+0tbJLocUsoKRZ+FStEMar74ADQsLWFuG8iY/Jo0uiphiMdj7lx+x2j2ZjwlCPgJ01RtbdNmgTc9uOzAEdZic9N8gnD1MhY31yyCOHUEZF7fVbv0K6OfoApkfVGko3k62Dp4LjSWD8CO2tp6FEH907PghLlQ4Dl1dicNPofK3wa1g7EmQkWceKMfOqGLQqG06nOb7J7kva54W62nz6uP4BVJag9ePdpQZw9ljcgf+yhbWbFNL4TFZOvfhsRJfN9uSNibgFAZdEAHoxghTlKN7JIr5LBTra5LMCb5CY+Vsuk8EV8sxS1fDyNC5dVIWgsLhYbk5msfpHPUWgAaeqp8I4N+UBhyIgXNtgupZXc7yy4FMoaSYi8oBczkAhFcIHx60HMDPGu1b4n+iQhfozk5QKOumDQCDOqLNqHv+iF4urOtSIdkZiP/D7HSAIy0ZvE93kWZNz3tFdwU75smMsvyd6/niJw6ylfG+AZvp7IpQ9x5GAadeJVeCDOq9RCMOhX08AiT0D6H8qm2EhOtus43QH9ytKdFDkZ+G55M64XAAkc76q+XjMq/6VUkxaTY3hnSI/Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(316002)(2616005)(6916009)(66476007)(66556008)(26005)(426003)(33656002)(1076003)(86362001)(38100700002)(2906002)(5660300002)(186003)(36756003)(8936002)(9746002)(83380400001)(4326008)(8676002)(9786002)(478600001)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DXGGnRfUpY2//yLy1vjQX/cz9HEYtEtBvlL8l5ddRX5u85s8jqWUxB8pDmCJ?=
 =?us-ascii?Q?1g6Xy20bAE8VxH8mE+Py6iIdI6XrXFnMFtJ4lqVspQU49RQ6sPslI3ZUmQHd?=
 =?us-ascii?Q?H+Tyk6VGdxZlqhcV/NhTOa5Nhn/a7idW9k5cIfgLxaJdUh0cqfPouxwkgqTk?=
 =?us-ascii?Q?pF33Q2b/62MMIXoKbpvprlRA0JWlYgd1V05y/zIX6xwTH0hTTr/DoY22nOrO?=
 =?us-ascii?Q?s8e5RGLJ63h5Ztjts3bIs1E9YtjV5/ajcaITCvsvq4CM8lqVkO58xXQlWEbr?=
 =?us-ascii?Q?7zOFeIExj2MZAOSt8zEKALmGac1vnCore4u3fxmJpFNQRVN+T2rSTRK8J8sJ?=
 =?us-ascii?Q?QABtlGWcPRRubNhIlJ8wUlYs7BU+o8libi2RjhPKhkftCCBQ8RenODYjnHsi?=
 =?us-ascii?Q?h7DT+umJxDIBSfZB+rycJ+BVFZu8WVUnAsbqC1xzKKNbmNgnI+VtDEBv67+K?=
 =?us-ascii?Q?1sbh0g9WY7+YXH6bLVAycDZD1vtqo2+El4aGpJHXdhpxiMI5zgsoHBrw82B/?=
 =?us-ascii?Q?q7BH5u5vvC/3dP7aiAlJ1TCnN+ldqt9cPAUigga1Y9PgwTG1AzlUWC8JrXkX?=
 =?us-ascii?Q?ALxdRHF912794emhs3uGBP1H8Ul4Q8Njv0TDsSp2Q/dCvW+iu+AUT+c6ji36?=
 =?us-ascii?Q?CYYbVAr2LSxkggQ9sW37Ak234nNOGyA1I47ZwMB03LEVaeRTC5uVmnE5CtKu?=
 =?us-ascii?Q?iS87819vGp7YusM6/dzCoDe/fjxqq04r70ybMTkhT7C+OCv7JBLofmYvBBN2?=
 =?us-ascii?Q?JCKD5wBqrRw/pEentdLGFrFx+YzuT8GAMKQ1uxoC2T/2Q81FeK81esCPyWHB?=
 =?us-ascii?Q?2DltCnubcLG8XmYGNqskwKlvqPYHIdKsVSxBLv69TilSXssIZcFT+9i7h45c?=
 =?us-ascii?Q?6rTlFZi7IOMVsu+EO9m52Nnrsn9EfuAu3s9vcEaF7Bm4+1Lt6vnWNzVJWgg8?=
 =?us-ascii?Q?QK52Ml++L1U6Tg0RfYYNd8TH8lqOtchU7Ca+V4gdJwBXuY93YTVdo+WSgHh2?=
 =?us-ascii?Q?euLmo8BqGagqBVph+aG2mwSUgTd3JKNC8IT6h7xu/TvApopsn0okZwAuGW4J?=
 =?us-ascii?Q?kswa8kuUNWI8Lws33sSIuxN26kcJustLyiqk8CdGvwX89jR1uF0+nyMQ5sJR?=
 =?us-ascii?Q?9OfrUB8CDU2aMWpW8OPMoBCnfbutS5DW1eJyfnZmDNGwtqbi8IZhJRew3AM0?=
 =?us-ascii?Q?XRSTf/dAooYNw8ikTKTVP2aCUlpfjaLU8Q2czXF5Kfqf2f+wG9mK3Us7J3Qm?=
 =?us-ascii?Q?UbSR5JU2JQdLqc91WRzBHUeWU9OYF2N6lQ+m9y/cgEnVgCTBLmM2nYK3rEeM?=
 =?us-ascii?Q?P7htNxO3XI2Ro1GzrxqyDVI2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5770605e-9a00-4f95-656d-08d9486321b8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 14:08:06.0543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jSrXE5t4CgbGDGgUJdrzx7WQ7ZJ8hdVIc8JKGM+LIb7yGxMeIFGiyTIY75/4ENY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5173
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 12, 2021 at 05:56:22PM +0530, Anand Khoje wrote:
> This v8 of patch series is used to read the port_attribute subnet_prefix
> from a valid cache entry instead of having to call
> device->ops.query_gid() for Infiniband link-layer devices in
> __ib_query_port().
> 
> In the event of a cache update, the value for subnet_prefix gets read
> using device->ops.query_gid() in config_non_roce_gid_cache().
> 
> It also re-orders the initialization of lock cache_lock of struct ib_device
> such that the lock is initialized before its first use in __ib_query_port()
> during device initialization.
> 
> Anand Khoje (3):
>   IB/core: Updating cache for subnet_prefix in
>     config_non_roce_gid_cache()
>   IB/core: Shifting initialization of device->cache_lock
>   IB/core: Read subnet_prefix in ib_query_port via cache.
> 
>  drivers/infiniband/core/cache.c  | 10 +++++-----
>  drivers/infiniband/core/device.c | 10 ++++------
>  2 files changed, 9 insertions(+), 11 deletions(-)

Applied to for-next, thanks

Jason
