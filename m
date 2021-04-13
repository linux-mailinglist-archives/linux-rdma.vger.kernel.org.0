Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D54735E47A
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Apr 2021 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347084AbhDMQ7d (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Apr 2021 12:59:33 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:8929
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347071AbhDMQ71 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Apr 2021 12:59:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMPtITdTIktxFm3fSdPY3EdWYj1kO85bPEbJ6BF8+KFGGqjYqECLDEmfS5qLfOJ3p60kCtQFoUDwVZekhTuq2jwZx4kPKrgsim3RrXet8Z6QlhE/TzZOurKaVABrbWeG7TmS7956WERkck9QauFVJT2CGsCxYHA7KYdOCITK/zR4koPLkbbESYrk3SksrPswz0nb1kSpEqCFrD/1vpQjEBt5o12UOM8TTkqYTVZ0wtwphLvcSzxCYmJyo/pMpwBKHzi3RdNfznwZSlojiKSzQwz4wTAVWrFASZfqwDCsbD4oJCMElyN3hdD1SqfWrI6eiQ2JAFuMEDQAAVjlrnc3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGuvG+8l6Li2MBKNVqAomAtDieK0iMgMJRwf53gUl60=;
 b=IuT8l+2KM91+tKFjCGhj0TadBNWG69WZimZCT92t2w63YJU5rWlMjw1NWG7Aoe4Zig9zJXuo6EucHGTrBBYd1S3uaGgvQpnU1CcZELAKnUYy/fy0ELxvAQUr5vqK0uI+rqaigofd4AfMcJ3uzObuhYelX8YBg3qFEOKVPwRmmX/V7wtHxEbg0tw8Fpvy9SQjk+9W1JC0bswIOQFyi/ea9XiKiCfgGW0vuoc8ZEom460VQ4AD0SOu9AJhoswv0xh5ur31YAxXVUDKvqIzwlnXoLNTIYgpCQ8bg6wQQibDBYNWbVKCPc2URi+Bfqx54qDLgqGcOMvbG2OWmP8OD+QsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGuvG+8l6Li2MBKNVqAomAtDieK0iMgMJRwf53gUl60=;
 b=g+KlHa6rU+mbl0bvqecc+wvNILz+17IRNS0rVTIMJscnxwSZsBOuyReSaMzF85CCLiVKCAFm0oUz+492EUDKH9c2YH0VO0KyGUYz8a9YjOoI8z/regRoxZo9GuzM1NRWkDgsTawHSDM5y9TEEFUj1XZDHM6cYq/M6UM41ieRdGggVohEFGvv7F2UWkWirTiUG6pi3qoFf6s+EFw+iW88mCTKksAhR/JuVuztz12cdCn8v0KEs4LjLWgM5mzqpJsBGhKXJSfbAkXQj3bdfUoPyEhNEg2pjFofOZDg0AAzMC8pXBrCRly33Zf21B3CSg0Bs5Ljx9Yei9SZYiLh2w8UKQ==
Authentication-Results: cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;cornelisnetworks.com; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 16:59:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 16:59:06 +0000
Date:   Tue, 13 Apr 2021 13:59:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     dennis.dalessandro@cornelisnetworks.com
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH for-next 10/10] IB/hfi1: Rework AIP and VNIC dummy netdev
 usage
Message-ID: <20210413165904.GA1320285@nvidia.com>
References: <1617026056-50483-1-git-send-email-dennis.dalessandro@cornelisnetworks.com>
 <1617026056-50483-11-git-send-email-dennis.dalessandro@cornelisnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617026056-50483-11-git-send-email-dennis.dalessandro@cornelisnetworks.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:208:1a0::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 16:59:05 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lWMNU-005ZuJ-KH; Tue, 13 Apr 2021 13:59:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe2f4dfb-6c3d-4849-2dea-08d8fe9d728b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01062C613A17140729C17524C24F9@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0H8E42sKJvahqKNf3vNwvRhcY5Sf3yOj9lZ/RqhtpZl7jK2C8TmhEo2Yeecuaj9VF3Uy56/UD/xZehldSZ9Ldkvf/1+uBNWWCbkU+E3NWahn3dmw6kzbOGy7PokG2/P6vumJu+2oK3UyaQIH1FVa9bRo+iMWjVOaJYuk3i487yrXVBza4+H/EAr9ttopeOL0GwSgcY8G5z7raJTG/IGBfJ9o4VmsxVToLuMVuZjAUVSBStewTVPEZidNgHCf+gcMF4h5iRXcbwh0pgZWDzoJ75vTYx4tgS8uVcFyoJnrqo03dFkvdZVPH+nqOS/6oFM1vJMdfSXdbFpG9r4HY/MyCva80EndzdWDftUqOxjtJiV+Lf5qpRo1DoeN4vdD7QuSvpCS/HPw+UJAJaChempbVbiX7XrWGUY3foxuSfjWlT670y6NPafj6U07oJUJMCaKEw+rwxpZF5tI0G0QZwXE6JFIGNstK7iZmVgB81udBxWM1BgTXmNhVIxQQyiHzmLY+q2SRJyC74NmzCTU2/Z501h2M9zkoZWkDmU5MV6mZaI3tc84/6j+yN7oOmPi9UOQ4Ztgr+mN35wzjm/XCx0fS+JF1UpYLaXe+V/YXt4UieM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(86362001)(38100700002)(8676002)(8936002)(4326008)(66556008)(36756003)(9746002)(9786002)(426003)(6916009)(1076003)(33656002)(5660300002)(66946007)(186003)(316002)(2616005)(26005)(478600001)(66476007)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?A5H5iJUP20AkbQXPx62zCCt04PQudFtvJoLtX/wHbYdWh/GJ6uwU2BlQ5RID?=
 =?us-ascii?Q?wJEdhqkS3OBK60zmCTHQ2YA9AqJ8njoFGYJ3oBxGz6qzKe8m6ibBoEwYczN9?=
 =?us-ascii?Q?yxqPFdl14kgDb+Yu90mRaIWQw/OL2TlhV2lCDGf8eDck4jIgsEVKabnJvDKS?=
 =?us-ascii?Q?b6Dh3U7SNgI894z176Tm41Q6RcAyvYAxSEAtIXhMtRdDPEnnEuFO6FrfGLcB?=
 =?us-ascii?Q?yqBGv5DkZYJSjXDh62PLVF89ziSSSEsR84+ho5SoXEcfS4LelN5K9Mzs/cnA?=
 =?us-ascii?Q?mrxDG5n8GaMEjrtGXshHk5rUV4b/JJmyYX6lcE677kdlzZmrB200eNAM8VTV?=
 =?us-ascii?Q?0r8yZGqqH35O+AqBcnkIjrDPX33058NNyNB3/ChJUXT4rxBfkHw7O48GwIyA?=
 =?us-ascii?Q?z/YWRAhsh/6muN4cY4782ED8WhJyXYAhd5HeIGhrVJVqWTs9dRvZjTdnmxf2?=
 =?us-ascii?Q?6cbpnReclele+tVx0SFeb6UcrSbm+S1C5igKVS6RhWKzsn1Rug+2I6Tl4m6b?=
 =?us-ascii?Q?IBXMFb+a6bxlFGc9sD5ag1JIqa6V0tB1IV0a8lv5DK60O79mhQwIx5nzi/tc?=
 =?us-ascii?Q?AYJ9YBWd5lly01UctrmkSNGfxQSUnAn0Weu4JrhZrWM37gBObNnjO1ExVoph?=
 =?us-ascii?Q?XWJxerjPj2/Sc53wW0ApdMx49fhiCxUOFKAtTHadxNL2OZFHZ6RuPst7e86l?=
 =?us-ascii?Q?ozU66NyQssAmLJs1VvJ+Yw4uoa9MKe/mkf/Ljor46w2q6hmOZovq+B30edoJ?=
 =?us-ascii?Q?NjBDlsU/ObRt/hhWUnpzK8cJuBKgjommOdofjhy8iaypWU6tZpvkZNkx4I7a?=
 =?us-ascii?Q?/HChjazeBuTB4ZmXbbwz6HyNPWv7QWRzLlVse+4bKo6sBXQcHH3UZUL/HtsR?=
 =?us-ascii?Q?cZa8X0hd6eVw+T3CKUxdmHXAx1NlqbiSu2EfSpIpZLsl41yXIVap1AvXR9Fk?=
 =?us-ascii?Q?mDZ36hQQXXg+WHzJrJnnWvgkQcanZJ+VdVhTDFpy4TT1FyvA4E546mDZBUof?=
 =?us-ascii?Q?nweqIeimqC5s9/SLRmoLYAZ1ZXU6H+2jGx9Y6GnqRivxlAE8K7YdU/GZeDNk?=
 =?us-ascii?Q?0CJcH4ww/55R41kgo2Ku2HI+xoxAQiFJ/AVdF49pgN0KRlx1ZB8FD1i+sQYp?=
 =?us-ascii?Q?m4URtDqxNrhAliUWTLDjA8+imRWBCblYKX9rmQINuyRjffLJKz4tialhGsCH?=
 =?us-ascii?Q?spRypE6ra/8RHXPWwhDTi5R2RQs73EEwnCeZCYpDDL5yXrm3LrlSHFKlXMhQ?=
 =?us-ascii?Q?LEHW+FCynFft0L2mNEWmau6FUbkSI0eeXxrolv44L2c2kEvXt8cbN4QHuSMy?=
 =?us-ascii?Q?ZVCItWlkfuoGKFgoVsoguO6e5gqB8RX1a9fNtpB5v+CluA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2f4dfb-6c3d-4849-2dea-08d8fe9d728b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 16:59:05.9368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7ig7JWt1SsQfmhP5tDVNPlVU4W7J/EZgAyJqLX/hbNmddn+NqoNlt2LTOsyx+Wd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 29, 2021 at 09:54:16AM -0400, dennis.dalessandro@cornelisnetworks.com wrote:
> From: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> 
> All other users of the dummy netdevice embed the netdev in other
> structures:
> 
> init_dummy_netdev(&mal->dummy_dev);
> init_dummy_netdev(&eth->dummy_dev);
> init_dummy_netdev(&ar->napi_dev);
> init_dummy_netdev(&irq_grp->napi_ndev);
> init_dummy_netdev(&wil->napi_ndev);
> init_dummy_netdev(&trans_pcie->napi_dev);
> init_dummy_netdev(&dev->napi_dev);
> init_dummy_netdev(&bus->mux_dev);
> 
> The AIP and VNIC implementation turns that model inside out and used a
> kfree() to free what appears to be a netdev struct when in reality, it is
> a struct that enbodies the rx state as well as the dummy netdev used to
> support napi_poll across disparate receive contexts.  The relationship is
> infered by the odd allocation:
> 
> 	const int netdev_size = sizeof(*dd->dummy_netdev) +
> 		sizeof(struct hfi1_netdev_priv);
> 	<snip>
> 	dd->dummy_netdev = kcalloc_node(1, netdev_size, GFP_KERNEL, dd->node);
> 
> 
> Correct the issue by:
> - Correctly naming the alloc and free functions
> - Renaming hfi1_netdev_priv to hfi1_netdev_rx
> - Replacing dd dummy_netdev with a netdev_rx pointer
> - Embedding the net_device in hfi1_netdev_rx
> - Moving the init_dummy_netdev to the alloc routine
> - Adjusting wrappers to fit the new model
> 
> Fixes: 6991abcb993c ("IB/hfi1: Add functions to receive accelerated ipoib packets")
> Reviewed-by: Kaike Wan <kaike.wan@intel.com>
> Signed-off-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/chip.c      |   6 +-
>  drivers/infiniband/hw/hfi1/hfi.h       |   4 +-
>  drivers/infiniband/hw/hfi1/init.c      |   2 +-
>  drivers/infiniband/hw/hfi1/netdev.h    |  39 +++-----
>  drivers/infiniband/hw/hfi1/netdev_rx.c | 177 +++++++++++++++++----------------
>  5 files changed, 108 insertions(+), 120 deletions(-)

Applied to for-next

Thanks,
Jason
