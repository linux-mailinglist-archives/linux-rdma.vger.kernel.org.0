Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A533FD916
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Sep 2021 13:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243893AbhIAL6P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Sep 2021 07:58:15 -0400
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com ([40.107.223.62]:18848
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241703AbhIAL6P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 Sep 2021 07:58:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcRzYFmlsj3kSZz8yE5VkXyZCoKKNOWsVxbvqV9I+TydbIrTcU8uAwE9dxoGhMqrn8FYdBV31QyvoVWwD1lALHJAEOfEEHonBkS5HgXcjN5aSXWxMmH2ki8bs+eev60QDm9NZPYLnMfdpAxfJuPoKQl6CNOezicw8NQcubpDyRqDx+VTd7+ZxUTLvB8UCUFIOUBFpCiW8Bg6mjc9b0ZuYnqC+6Ru1UISNtZcQaxe6uZSDFfQUi7/iWputsQK5vLqKKeQhD7mD20vdCTBTRPrtCJlAK/14OA7wgi/DaiMLphHjocu3nybV6t4tFxj0ruwi/jJRsEyLX9xSbimjukDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BlGfoBJWRwsz4T3cVeV17YRm+t8HZ6MXTXYhmzWTZT0=;
 b=biBzK8BTuksAdB/LGypsHcNqAP+RGnEdJ65yy//b/tFBXGc4O3D6rph+Osb8zru0v+iJqWXMx84wQBvL6zZUQqI6r3iDJMzuUgYwc4skCEvTWsPlMaim+ySTdKzmiXn10fwTPa+iWJR7WNhvyTL0IKAbWUATdjJ0ddDr8nTJelMyT1j5r+L84WU3hO2SZGbISuVsYxCFU2rMXqa1wY4tstcNLSEojPv5hbfB0Z4xowi7Imh42STczmHUp1EPXLQzhJRJj9ToQhFa/2qKWMPSlI05Oo5jGOIqsh/oaKJG6UabwlA3ckoIzS0n7RnZ3uIexEAnD1GYy0u5z/geR16O+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlGfoBJWRwsz4T3cVeV17YRm+t8HZ6MXTXYhmzWTZT0=;
 b=FZUzxOzY55RkfYX7Atfm4GcsNLIfP5Q6fz/s2wBDtWKyM71+ZeibkXx0fShhSGolMh2b31VgujWx3eBZjxH+Ze/6SfnNtjHELSKJTXsqMPZMaoZEzBXsCbi8sxYdtoippUrLWzSS+pJRHlMjKNTBiGImTJ+hIf/uyjNDIOE1+KLwNqx+o9qAJ5ysWZWDivxuGYPznkpupxXFDq7aGz3neDaabbbB3OEl510LQBgG45NeUhusu68te533m5l4lyKR84gcsDHuQo1mk/VPBgR3qnlz/ehwURA2xXRl2h+oIBMbWhRx382cock27HcLWEeK7/SHx8KNf0OOLvtLX4+LPQ==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 11:57:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4478.020; Wed, 1 Sep 2021
 11:57:17 +0000
Date:   Wed, 1 Sep 2021 08:57:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
Message-ID: <20210901115716.GG1721383@nvidia.com>
References: <20210811151131.39138-1-galpress@amazon.com>
 <20210811151131.39138-5-galpress@amazon.com>
 <20210820182702.GA550455@nvidia.com>
 <7a4963ea-f028-e787-a5ba-fabf907c6d6b@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a4963ea-f028-e787-a5ba-fabf907c6d6b@amazon.com>
X-ClientProxiedBy: BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 11:57:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mLOrk-007m5y-75; Wed, 01 Sep 2021 08:57:16 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a8eee9b-30cf-461a-b2e8-08d96d3fa4f3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5064092894825BF5E5BCA709C2CD9@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPUy4UqcSJQW1y/RgN6IExakuIHbw5ECAg9wO1tqrXPBtTjL9XTw3SqU991nj+7SaYPDMlDd0Tlh4wiuk8+ZcELS+jekhtk5b//6oAKfSURU9wzTkSnpPwTa1BcwJsolmI8A6R/7UCzQzA91DSymxysaJS2OHPqO0htBzeCT1+7coFnvipiGcHKewGsx0lefeXwVc/A4QFaI9iU+4132O9FhCptIiWwYRIx+0LF29cwiEUXS78tdBKjpVEZXikHHRtiXjMJIaefyLe+opd63wYc6kzUMBuoX3lbU8Y+/JbBIgRf0BgYAvCCOkn7y3yK9WllyBuYZ9VeW1ppqq0YKZvTsYKYfeFlRWLzBeWDwSuvTlf7BhwpdJYs/3AqYEDEWcVuAo4hVTRSee4MAK2K6+AGba4Mhk7gvzKQl7F8/OBnD3BXlpcfyualnPQGec51+/cLjhRyLCqRZcmQ+lN+xZEmp6iviriSbCAXp4a0tNts2iDXgHMi4vMvggEhBZzGU2TkoHRG5j0Z/FnqZ7+vHz3LlRCCY6cM0PMbjOultruxtFY8jQI0yUnyhxQChyX1kSz7WthuR2n0nb39h5O0S78efK/fz4ff4/VUpm7dLSLh3isdLIej11evWeAQLNoy1t/TYhdYp5PiUMlr4DEyoP84FRxQ+UxVk3ZSbD3NUupKJw9v3aivsXXe1AFgCGqu66+0y0RgyiqcngeKua99CoJKrWb1OWwgmVIVbahem0lzbNooyQeoSnfB2GNDQv4S+ayxIQ0FrTS/qK75t+kdjxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(54906003)(1076003)(53546011)(2616005)(426003)(38100700002)(9786002)(86362001)(316002)(8936002)(186003)(36756003)(9746002)(8676002)(5660300002)(966005)(2906002)(83380400001)(33656002)(66946007)(66556008)(66476007)(6916009)(478600001)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K6I1XeOitlxLIXe56q3WpE5NWTmLZ0L15SIY74o9FlG0xtRKNvgXyszILHjq?=
 =?us-ascii?Q?/TgJuxHPXbMWzg41B1o49zqkZYMbcxhQ/untr4mn9PC7GNtu4F1+4T2LihAW?=
 =?us-ascii?Q?MfAvBrhfpEnTz6S2dXFqTHDKO/1mVYStJ4r/qRjM0+PoOvuZQ/vYCc7hX8w5?=
 =?us-ascii?Q?JEXBGeWXI1nCsuImEBgq+Oc1tsOWeg+F+qzOd1aWpNQZ0kx802xIeKwJsNwT?=
 =?us-ascii?Q?QzWW+X1+2nfP4eJoRrA+/8ntp2XOHGXwIH1gyjr2kQuoTHFbMdvPu/yD9TpL?=
 =?us-ascii?Q?BCmZ6B37i2rwR2BWYVqUU0B8Ore5pEpxMtFYPWfi6JwHufkFcywIi0hrs2N2?=
 =?us-ascii?Q?dpmM5C3FN8ZMDTZVZafRGBPI78TDNiyUn6MlxUHNIUUUvBeW2JnGIUhXueXB?=
 =?us-ascii?Q?J6tmDeZRfittmgMUkoW7SBXQYhRMVKeiX2vafnjSeqsa+YgEeYEIt10UtyyV?=
 =?us-ascii?Q?bwxFapteOsM5DrLhZxSSaVJC7GIgEB0NVn+gqggHbzGlXXGJhOypjeDvYBYh?=
 =?us-ascii?Q?svkzcInYfe+qZqoI9dfbGETq2RWXOGga6A3dXnDJXt6WxCtkRVpuwp0iZrvE?=
 =?us-ascii?Q?z4kasCvlkrf9glmAbagU6vub1E1WNXYwiMKHsOQGJnL6k04u3rVs5pl+h5nf?=
 =?us-ascii?Q?211wvGBmpzbTA3i26W2zqT/N6ZDcX7RJdOkUt66vMm2AHMa0qeXvpAOmfVl/?=
 =?us-ascii?Q?62JXmN4dje0bMyCGeKK/iQ2zCHXK1XTlEhv6dyzJwUHskBQ4SrXeMmbY5P/3?=
 =?us-ascii?Q?zF7BI94OsVEq+T1TtMPVifkcLnwYsrmG8Uv4cbauN3/QJqnipCyFVRJSLzRn?=
 =?us-ascii?Q?vFWrlaF2wzJaDTCoZGx448Oc1MN63ct5nFD50V/LvS3U3LVt0PdEDJamv+j6?=
 =?us-ascii?Q?nkarvCTW+nWq5RItXOEyd1ZXxfb7NTxOCL0f4sFqZPuxJSLoQsblfloqMe1h?=
 =?us-ascii?Q?CZniLwQaRUJECJNtffTPezPwyHsurVEqZvyD8Lj+bTivGNi6aStosUaD06Ny?=
 =?us-ascii?Q?TfKP6eFT0hJmxSsQ5QJ7IqaKIH3zNmyYz6E0/PadQOo5NfyBUetN8sG7hIc7?=
 =?us-ascii?Q?D6vtbKQlJEMFDFqhEiT9SwdGePFizZdPgTYg1WYYQqwylw/g6m4+qZBUzBrJ?=
 =?us-ascii?Q?EE/KZzCcm6mE5rFBoRvPrTUZPxnyed7jjgPYrbhbV9ObKKcid1rei8E9ctmz?=
 =?us-ascii?Q?9oYg/0CixgWHdlAgcR6e5Zdwm7Wa2OZEjVwBo0wdBwDEmPs2JGDLHrIABjjI?=
 =?us-ascii?Q?Zo41JHiUj0Hl2NIr5rn/vy31bqb0utFG44GKRYwUAWHCHj4ek09s631DcAjh?=
 =?us-ascii?Q?zuR6Lyzd9VPKlqxTcJcW8/sP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8eee9b-30cf-461a-b2e8-08d96d3fa4f3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 11:57:16.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMPTp/4ABNzdxR3fVcf/o2NV0qKdHixLIKCiz3NDLTmMHy+QsjuwNKK9Ngnv3CEw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 01, 2021 at 02:50:42PM +0300, Gal Pressman wrote:
> On 20/08/2021 21:27, Jason Gunthorpe wrote:
> > On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
> >> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> >> index 417dea5f90cf..29db4dec02f0 100644
> >> +++ b/drivers/infiniband/hw/efa/efa_main.c
> >> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
> >>  	pci_release_selected_regions(pdev, release_bars);
> >>  }
> >>  
> >> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
> >> +{
> >> +	u16 cqn = eqe->u.comp_event.cqn;
> >> +	struct efa_cq *cq;
> >> +
> >> +	cq = xa_load(&dev->cqs_xa, cqn);
> >> +	if (unlikely(!cq)) {
> > 
> > This seems unlikely to be correct, what prevents cq from being
> > destroyed concurrently?
> > 
> > A comp_handler cannot be running after cq destroy completes.
> 
> Sorry for the long turnaround, was OOO.
> 
> The CQ cannot be destroyed until all completion events are acked.
> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/man/ibv_get_cq_event.3#L45
> https://github.com/linux-rdma/rdma-core/blob/7fd01f0c6799f0ecb99cae03c22cf7ff61ffbf5a/libibverbs/cmd_cq.c#L208

That is something quite different, and in userspace.

What in the kernel prevents tha xa_load and the xa_erase from racing together?

Jason
