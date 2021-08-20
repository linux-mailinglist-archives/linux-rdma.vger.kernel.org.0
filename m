Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894083F33B4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhHTS1n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 14:27:43 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:22529
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229512AbhHTS1m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 14:27:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP1PZHUfto/uFy6Z4cp8Ky3HicHv+O1x/aeSPozluEcT/2efizkqSCiac+ejv5OTQABecsrg9vNK4UNAmiuh9wwgUCE7qL3R2AgV2wDzfuhUPvQQwYJkxxk1660A7WgTjzDywBo6QRUHPwVFF3d2Ld7E3zO9uhz2EMjumiikzDN9Msx+5ILYH/Iwe1BJV9OljZO1ld+REit+yV9InYk1jhyfHK5IO6gBrF7VPbf6OOR3u5qkHQPd2pWr24rwdZ298DX9IkTj9blTTmAwWfNxzmyLUEDCbWzcmRbyJJWq8HuA+MQN/ij/ardAHi7t+KwJWz1OlG4CnetTCD9pDmJA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBeykyJwYxCv5Swq7r+1195BXZHxmxw7rLBM/q9Y9P8=;
 b=drNrdwDGW+xbQY/cf+nmlA7YH9PcGBbT7eGb4lybRd35bqJ9Rw+dfZXJN5eUcNdTdfHX1GynJZH8v+fFo+NpcztiqHCAOw1c0ey4RWhMg3cyzPvp0H5dGTuwI8ANJnWIUlR8klwzKClw3Myb8HcRCQrzTpt6RGdYqeoEmvb5Iquyihu0oOEfKsDPbmak+VGtH+jabaVyuodBY7cJfh65Rrg2Vh7w1trJuDVgl5GvrepW4F70Ky4kzPmNv02XUQVqneT0xNPvlYVcksUR7PRgWSiSK/fkHwjcT32Wyo/oDBWyO+y4l4qmOFalf0e0+0Jmldeu4eEx2aOsb8tw0Xmjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBeykyJwYxCv5Swq7r+1195BXZHxmxw7rLBM/q9Y9P8=;
 b=La9XSfVRrSsWQ9bkU2pDJdxlypbfnh/r8JSXDpwP9M98zNvtgysI3spiiHL/U0heYsEX6VGLfDoUJnVM2BE2R/eR10LvUCvyWewUsdlahJ3iBBAIlYIFG5Me/GCVVldcsGXgPHeWRaF3eKZtdiHD3QWN9cbQQPggSe23pKFrcv4jTs7ofUjJgtTLuKZepdwPVBtIHHHHz2fiKDG45khrTMjIq2BVSzKucDK8t4hqEotnoJxPl80ztLyfay38w/+dAFC49yj5JaiTEaS37/wlJCezZuHIGCA27lbj19mwg4F3/1dymiWTBt/b7GinnDrxQlhr7IO+ZmjTSOSckBkxrg==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 18:27:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 18:27:03 +0000
Date:   Fri, 20 Aug 2021 15:27:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 4/4] RDMA/efa: CQ notifications
Message-ID: <20210820182702.GA550455@nvidia.com>
References: <20210811151131.39138-1-galpress@amazon.com>
 <20210811151131.39138-5-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811151131.39138-5-galpress@amazon.com>
X-ClientProxiedBy: BLAPR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:32b::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:32b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 18:27:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mH9EM-002JE3-8T; Fri, 20 Aug 2021 15:27:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef9cee16-8ad5-4fd3-631e-08d964081b50
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5061790D6B774190B380767AC2C19@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KshG1ZVGHuLaK6qdMyh8m7t93MaW9tdXcHynmemN8HUCc1Ootq3MbfLIKTQlrSDsNH5CJTKw9vHM0lLYnaXB41gQ5Sr7jN39qWohbFd5AmmrPkcx4kM1IlSUN3vBjYp48p49gjfiEJcopfjkBqIpOWvWwezf6hVVK3+oed9QvBGSv/44BudNrD1mIWSKEtIokbaIq4Xe+i8DzqQqHP8+rybftY8GB2lVisDxif7TM1Cdc54H3BVJEnmClzpK+b2O6rmg6ca7nRRjc0UTfxHX1dQnFAbPBX6SSzH9yVgCGsJqOKIMhdf9Xl5wKhUu8htxWSgUxSQvXlXO1MKR3KIr90+cQEN/GzAS9uv//J+5qWZ7WzwwNGcIDV6fRIgWf9RL/Gzb6wVR9G/4wvFFJ/preonTYgBMbCKIfJLQTAnH07D9b2heF5vtKn+Q2bvlVOMhger+5i4OSGCnCqvjzKEZzsj+OkqRtFpwT4nGx9lH0N8j7DSXaJTzklNdHylICtGUsG9ALnguXEwXt0Ay3UuM1hFiwH1g+vl9NrX9xPgKBjwlE4CT5i9rtb48BGIoI2Y6oQp0CbuNIC1jF8C0UdXqlInxpPmKRa3FDwlPj2r0ROZxN03LU9jFpqjefQGKAk9/+EgciJ1FtJGCGSdhsjtq26js8psMaavTVZS5vMKy6DA2yLSTqiyMNA7Nmp70CoJ2KHknXf4hrEwN9a0wfhC5aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(66946007)(426003)(478600001)(1076003)(66556008)(66476007)(186003)(54906003)(2616005)(38100700002)(5660300002)(36756003)(316002)(8676002)(26005)(33656002)(4326008)(8936002)(6916009)(86362001)(9746002)(9786002)(2906002)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F1Xw3nMiZFLWjjpnU9Ho8JWm14mkNAZS3tHCYa2P3K0QWgH8SruuMnzquKBD?=
 =?us-ascii?Q?vL9UwEy/oWJ+RqdyfpxQ7rUG99pcWDvrWh067+fClKWZ2hrlCeoxmUnkhsjM?=
 =?us-ascii?Q?aMMhz91ysuKLP3+Q2i2TUQSE6hpxv1e1Q4TD/rnAgNkH0ufhe443bAICu+h5?=
 =?us-ascii?Q?Fjsy9dYCT3in3VAvCN7XnxTaVYK5ZpFKUxhxMGOP3lJOwWUofJt47jcbeYrq?=
 =?us-ascii?Q?lFEWK0SLzv7TuI+GDg/nu1tPNK1+R642x1jwCY/Qp8QZyvTbYJmQW3Vy6U/l?=
 =?us-ascii?Q?LCjckCQtgM/oVM/H2ON5WOOEQNeY6qJkLYulKNpbhQtVmmIZWd5f34ZdX5s2?=
 =?us-ascii?Q?o1rYUzSvmbNBtYUQMCiIUKUDivp91xqBqtijjRcFGbAdXIXiEZt1A+Kg+yJA?=
 =?us-ascii?Q?EHpsgXbyJbdpnOdoEKc1gyRpyKsswvSv7wsRS8B/UYG9tw6CcIyuP4eKaujs?=
 =?us-ascii?Q?BgZbKpa8LbyJt+qrvQfLSdG1O1rk6/v3Uv4TmrGy4AuUGl1Bg3VBEZ047eCP?=
 =?us-ascii?Q?ARxw2fT4Ei8RptShlVSkzySkNp8nWCp3w2Fra1Z53/1Ks7OCQGUyJokC1Wee?=
 =?us-ascii?Q?8aFgm/3IEaCYQyYLyx0dD0dA9bKXPx+7sXmjDv18yOVwJ0N/S+wDkpigEiIv?=
 =?us-ascii?Q?UcDnH3OCBl3vZMtBD3ddXjAnkY0P0UoOEEy00ZM9dV1i1SZ04nXotRRUOkJG?=
 =?us-ascii?Q?FHgCiqBx3K5jXvZJbWPatfzESThAmu5rPyxJh49FjHASVcN0pd/i9Y3EWGps?=
 =?us-ascii?Q?tySDN6LknbHLj5q8rwmUeTQV8KiwnZiKKxKKY32Z73S85dLfQ2eovzLUSTvN?=
 =?us-ascii?Q?JuM0DNFlSr2W09rLSFXPe5vTp3QctV+725+k2PQda9rlP+5ZcfGty1W6MpHu?=
 =?us-ascii?Q?HhDch/Tn+EIbnIIfUZztn7v3wMc6APEWtV6uZ2D3UkEeYKv+fXAk1JaHiIh6?=
 =?us-ascii?Q?oRSc4gl7tkTkAD7lU5+ggpCYCTYvUIG7S8BJ8xSeCpRoya/TROfsq1sf+J1z?=
 =?us-ascii?Q?S0+BPCKKDr213odcEyRYVJ4Vgq0LF2HsIHkFi+rpe1Dui2Sj6u/n6K6tJOBM?=
 =?us-ascii?Q?SjWgJ5PuVBMljERnb6hUyzRWOshIYAxtWg992pT97Co1tAvGaqQgk5K+FWWd?=
 =?us-ascii?Q?G2oMFFpTnLxbtY8wRgLAHLkfUPXBVavK9ThWVY1JIxHUrXmcI4gTVMRdo/Tl?=
 =?us-ascii?Q?CS9FWl3WDACLLUn0Ass+J0XoeP6EgzYQil1BIiY229dwN157XIkJuvA1Lfqg?=
 =?us-ascii?Q?/qwpERtI4dSuCgI8bLAlGe3NHcLROw831yppIEE0I+jvK/QGoGsCcly1mPRS?=
 =?us-ascii?Q?CA56x7nVm4HpfYDePNDu0Ucv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9cee16-8ad5-4fd3-631e-08d964081b50
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 18:27:03.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sAydtk7lU9Cdb0mfvklYz5dOBVHIbzMhyt9kFKZA47d5VqWWfj43hMqtKnHSc00
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 11, 2021 at 06:11:31PM +0300, Gal Pressman wrote:
> diff --git a/drivers/infiniband/hw/efa/efa_main.c b/drivers/infiniband/hw/efa/efa_main.c
> index 417dea5f90cf..29db4dec02f0 100644
> +++ b/drivers/infiniband/hw/efa/efa_main.c
> @@ -67,6 +67,46 @@ static void efa_release_bars(struct efa_dev *dev, int bars_mask)
>  	pci_release_selected_regions(pdev, release_bars);
>  }
>  
> +static void efa_process_comp_eqe(struct efa_dev *dev, struct efa_admin_eqe *eqe)
> +{
> +	u16 cqn = eqe->u.comp_event.cqn;
> +	struct efa_cq *cq;
> +
> +	cq = xa_load(&dev->cqs_xa, cqn);
> +	if (unlikely(!cq)) {

This seems unlikely to be correct, what prevents cq from being
destroyed concurrently?

A comp_handler cannot be running after cq destroy completes.

> @@ -421,6 +551,7 @@ static struct efa_dev *efa_probe_device(struct pci_dev *pdev)
>  	edev->efa_dev = dev;
>  	edev->dmadev = &pdev->dev;
>  	dev->pdev = pdev;
> +	xa_init_flags(&dev->cqs_xa, XA_FLAGS_LOCK_IRQ);

And this is confusing too, since the above is the only reference and
doesn't take the xa_lock why does the xa need to use LOCK_IRQ?

Jason
