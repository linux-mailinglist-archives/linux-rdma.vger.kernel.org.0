Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D486A7702CB
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 16:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjHDORq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 10:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjHDORp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 10:17:45 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6631BF6
        for <linux-rdma@vger.kernel.org>; Fri,  4 Aug 2023 07:17:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiQW+yPGpBCVrT4ouNC97lJfYLPhkDtn12uA3HXaDu+KIfA7Dfo1ybRzbVfeCF3ofcqaqLN14OXNWkwySUDLI2QuZpyFp/wnFQsLHm4DHtNSDExAR/LmwFGCHr3HCT1Oq7HnfQhkYYJ5HozYKZ5FMmrO6Z7hxGrqnu/M6xmShuHAhCHumLJ4Qmddt2ofpTUqFeSsd5iQZbZljuFEiUCODxsUW+IMkj3evAZjxOfzk7WGMfuF7Gsb0c/ht8dXIl29gqDNM8ubNhNLYvOUhiIi2KQfw2c6jCYd+oGw8i5HrnfLv6+PAaq4edIfaORqKixaKPaLIqJOwNjxTyqBnCdRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfOy0E2Rs7kfiVrkXXq8ZqRwgEc1FpqBOv+9kNCWH4E=;
 b=UwuDcrItygHmQlJeOwMx+0OfH+W8apxwx7AQWldNyKPgy8e7YcZbyAhpVCxn5tcvDgIcuOR6VJyZuE3Wf5VIiJ6UjiraatGuTaBxC4uCQgfOuibaNs/H2ppRs4a0KCQk14dsYC+z0igwagPbYFQ6DTAZiFIiNKXN9MBi0u9gMguSlDAv7VivoxtP/+SQYJRwiIIBfs48H5SSmLHdw4tWXr3nX+v7YPqDYjZLJgoXxpW71OJWrKKTX4qMdEdGBgqM107EEHGh2kY04CPni8jdKM9A88XB0TCXJOrc5eTOgKIRyE5lfi/fw6y/zt/3luE5O+v0qf3DQ2yBqC3LVSSsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfOy0E2Rs7kfiVrkXXq8ZqRwgEc1FpqBOv+9kNCWH4E=;
 b=pnybok0KBjfU2nBwdmWVUq38oSguC+5zBwbFFgbnAz5+WXvZFiCOf3IiYqvrS28TpNx+nvTI3gsAlvYQjVk86bGZ7PyCppFwvGUme5hPB022zSSoGOYy2M3KT9WAojC0waCYd1rIcjs12YWLyhz5NiYXGfjj0FISToHGLAW4ER1n7cbPNxlyhFobF+Jlf3ebOfgAs/Cel7p7IBpjJGyA/srqR+Pjxgp3PljVMCK7+2XCK5lfm/68p9aFCjy3Eq2Ji59lmbXrfNgEewUnsxohoxD59GKvAq1B2W2kp3HsQnFeCKObOxGETLx43rAnAq6V1criX5LrJ5wvIp7A3aTegg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ2PR12MB7847.namprd12.prod.outlook.com (2603:10b6:a03:4d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 14:17:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:17:37 +0000
Date:   Fri, 4 Aug 2023 11:17:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     leon@kernel.org, zyjzyj2000@gmail.com, jhack@hpe.com,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 4/9] RDMA/rxe: Fix delayed send packet handling
Message-ID: <ZM0IgLe3yv6bsEiB@nvidia.com>
References: <20230721205021.5394-1-rpearsonhpe@gmail.com>
 <20230721205021.5394-5-rpearsonhpe@gmail.com>
 <ZMf5qhbrgx0lBv20@nvidia.com>
 <f38c7db0-e613-f840-e979-76383460fd7e@gmail.com>
 <ZMf8H4GtL4EZKGd2@nvidia.com>
 <0cfb222c-ff48-daca-d512-3083878100fa@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cfb222c-ff48-daca-d512-3083878100fa@gmail.com>
X-ClientProxiedBy: MN2PR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:208:239::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ2PR12MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dd4216-c38f-4197-f674-08db94f58e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUT1IgeJB9XvswzOxKeG+gTb5lJY6Sa4fOehiZnMuK+kPEbjCr6MqZhPkoFkNaw7QUs2ySbxyPALF8Irj6Ey8/iX956eRVkAX6Etq5k4yAfU3cdaW97JyeuLgoX85WicEMIfEfaR1lLKISS7EbfxEKmXtBxdHKxJH4gOtxtX73K+tuzhmUW9LXQpe6dZ5mTLO1pl1oah9rLbEMv+j84k4xlmG+ab6Rcn/uYnMqQf/fgLMpgvG+O3jiuVYe90IEbZeL1XtdaiPZlevaqbVocWao0zdUfzdkTX2nBkT1lJSXc4RDEMSkrRPuBxdp+eQOmEQX38jQm30vWe4K8uVxsjOvNt9Aia9uyqDvU9RS6RC5QOD3gmb+Ga9C3Nn0mjuP+gcEN0IzH+DGmoPU6O438V7gPwzp0mmHO2/DAvjQvDtlgCYj+xJMaOtfNs2FI761XK+H+M6S00boz3JlzaDo62am0myzvyMqEcROltXxMnNR2Z2X/q/ymv93fFdSaloBG740ro26c+lxX9ZTl+zV/kMW7pF8LSxnkvnnXPd6FatWzzfEf+hiFYkwDBVhal845o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(1800799003)(186006)(451199021)(8936002)(316002)(478600001)(6512007)(2906002)(2616005)(86362001)(5660300002)(53546011)(26005)(6506007)(8676002)(6486002)(36756003)(41300700001)(38100700002)(6916009)(4326008)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UHC+Pg/xuhYz790q2dsSN+bChkEV+nteRZ3VZULzyYtN4+2q+UcPH0zbrx8Z?=
 =?us-ascii?Q?WYE3pEBGJ4C884LpPHkWFzqppWISv1miVGbm+7X2/xP6dv/ZKW61uruV2MBB?=
 =?us-ascii?Q?WE3gQE6OfJf4aLPZGy4XNhOVSJUHwQv7wnEeB99wL64v7dn4WSNZSR0Lk2XI?=
 =?us-ascii?Q?69AX4oA67iFNHoDGHhI6pHO7gHDP2FaPv0pw05QWJTGzou5EvW0a/zkywUI6?=
 =?us-ascii?Q?QDMtsxUpWY/PGn6fhimjM1EN9enlqy16K7vA1P3VfFX0Eu2oJ5In+uIthI1L?=
 =?us-ascii?Q?3OBoF4bzD0WxH8bAFUMY2NQXcALpQqE9XmHsYG9g0NIGfXkkx0c1Fi52RAPt?=
 =?us-ascii?Q?GedsHOH+xNlkFGMB5b0zWGmSvktTCRn+dcP49fbTXXVm737MkCJDDuQXbj97?=
 =?us-ascii?Q?GskyckFfmV0xHO5TcfKv8GE8L0PvlMClLhpBV4qlbnqIQ3g1JNTW9f3O7xbG?=
 =?us-ascii?Q?BBAihh4tFlQuVYY+xFSSRgPc9i3SU4D8tg9Cyk0d385WtWyAY6M3ZSMyXWWK?=
 =?us-ascii?Q?uwl4u16UQPrmJBojqJT15rSIyvix43y+N2Fa9jwxEJU5b7Emfwl4eU9HoCv+?=
 =?us-ascii?Q?EXB7VcJsucNfhgIlLMvOKwHN8J5Ky8xBkJanpIqUjKsjvTJNb/+oPbniYRfa?=
 =?us-ascii?Q?L8p/eN26c8Syv5dfDPP35HmS+uFqaeXGf/3+Mm8nCLcpRzQiu2KbShHbtoOr?=
 =?us-ascii?Q?Q1wan8SFQvbxx8szRTihEdO7BzvjIYJqKKz2yYUV+6kHxDTZz4gnOYtvtICh?=
 =?us-ascii?Q?W12kK6EGLfCUN8ncIt9agpIZ0NVMaiMRJ3FaYbCI/2rotzofm4++Rfg7q63G?=
 =?us-ascii?Q?zuAwhMCuLib7FafbJAl49T7BFI6yBvE9D7HNG0KBAv++Hchv1FpH7U+HBnta?=
 =?us-ascii?Q?inxBZyQXSuz83js45DO78SkavIsOrZ2erNyVybBYtya1bS3G/5EGnw8QnnLQ?=
 =?us-ascii?Q?L2wR2ZXbBIyVChVcTJ7H8Uli6xLMe+Rix8xOHq5xk3RVcfjHTWTKKnRUUl+7?=
 =?us-ascii?Q?yEWAgvlSpauZzN8YZsA6hzFJko+qJAN4dMOLiAIYLMAC1ND+2FFd++HSo3iv?=
 =?us-ascii?Q?Yr9Yy75q3A8vucqaCUkOVxicuoIggLFzu9JcoF0wZN2YYuAtKF3c6mj+y6AS?=
 =?us-ascii?Q?945XRzYxldNagrYte1P9YEr6LyujWrXzzpxkicqWPNz7HkNrJdpAqtp4tLAo?=
 =?us-ascii?Q?YzYB2MClYgNSoqxiZIRvzZZFee1RatqsBCuZNonpzzQH+uWgaPGU32MuHXnt?=
 =?us-ascii?Q?hJgeNe3cpwVw4ABQfWIfwLh2oquTz4fVvV8UuD/v3hbT8XosE+K7a8nmrkIJ?=
 =?us-ascii?Q?EBS/uvapqcuB83VrGmaRHHARJXJClc64jeB7bpap2fNraSENSIIj9ksvdMFt?=
 =?us-ascii?Q?RRNA6KgdaNFcl0BqwNtarE60Jyt/urKQR1BB0HvfLWay0iebJAfhsu+PfG9G?=
 =?us-ascii?Q?X40qsxDyS2Q9CnJy4RKLP69qyWzECeskkwWPsv/zWGVtM04lfyQ0JVpNjqcZ?=
 =?us-ascii?Q?iX+JAymUhBhkbYi0jbMWGB4AuzEWxz6QeAa4K5flSXhgiDO47sH4u0b7qI8D?=
 =?us-ascii?Q?kDqhZRNCPAznEcW831eKtaDBaAlOraU2JAa00M5A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dd4216-c38f-4197-f674-08db94f58e06
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:17:37.5509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUAkfw/acthxVJx9SjTkAtMRNrX2SXbiBIUCWcF5z5H06PVlGiGycNllNB8COfMI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7847
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 01:33:15PM -0500, Bob Pearson wrote:
> On 7/31/23 13:23, Jason Gunthorpe wrote:
> > On Mon, Jul 31, 2023 at 01:20:35PM -0500, Bob Pearson wrote:
> >> On 7/31/23 13:12, Jason Gunthorpe wrote:
> >>> On Fri, Jul 21, 2023 at 03:50:17PM -0500, Bob Pearson wrote:
> >>>> In cable pull testing some NICs can hold a send packet long enough
> >>>> to allow ulp protocol stacks to destroy the qp and the cleanup
> >>>> routines to timeout waiting for all qp references to be released.
> >>>> When the NIC driver finally frees the SKB the qp pointer is no longer
> >>>> valid and causes a seg fault in rxe_skb_tx_dtor().
> >>>>
> >>>> This patch passes the qp index instead of the qp to the skb destructor
> >>>> callback function. The call back is required to lookup the qp from the
> >>>> index and if it has been destroyed the lookup will return NULL and the
> >>>> qp will not be referenced avoiding the seg fault.
> >>>
> >>> And what if it is a different QP returned?
> >>>
> >>> Jason
> >>
> >> Since we are using xarray cyclic alloc you would have to create 16M QPs before the
> >> index was reused. This is as good as it gets I think.
> > 
> > Sounds terrible, why can't you store the QP pointer instead and hold a
> > refcount on it?
> 
> The goal here was to make packet send semantics to be 'fire and forget' i.e. once we
> send the packet not have any dependencies hanging around. But we still wanted to count
> the packets pending to avoid overrunning the send queue.

Well, you can't have it both ways really.

Maybe you need another bit of memory to track the packet counters that
can be refcounted independently of the qp.

And wait for those refcounts to zero out before allowing the driver to
unprobe.

Jason
