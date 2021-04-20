Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C5D36600E
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 21:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhDTTKl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 15:10:41 -0400
Received: from mail-eopbgr750050.outbound.protection.outlook.com ([40.107.75.50]:54927
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233617AbhDTTKk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 15:10:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipX951OY6KV/yQUBaVt3w7Ks3bMARlgNSTHSSWlIoU6Pfz8oo14ZATwEPpd+5AflD2lXMqk4vHb0yxKYyHbCd8MkK0LnQCdc6tzchQBPRwR4QGNQAOek3xaXz4rxsEsP3uKTXe9DWI4VQpj/zRCz5zq0rDkBqv/XasS/6ElliYBaNxLh+mic5DiuRqaDmtjLRhap5fs8OT4+fECP1AN+ZruOUnQgsyN1KM4nyQEQgwDD8rVpLKZt6vvbCpNGolpz3/GLGjsEdBExDFoSQOunz6S/5my2gEfy2rstRYnht6dlg7yPOpRvQ36dNK1n0wa8G9WRxVPDl85nZtiT+AAceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcMqKTnMvL5HUIKt8WMlcLiKXXBeESjCfK+pfs4DHek=;
 b=Dn28QNE4CSMdrUYpWvqrB5IC1EQwo0WDiaeyK9TWsVxeqZiZkgbdiL7APVznL4rfTcsbQbQTzrmNHgXIL+lPcc5/MC4ss8MvpCRrOYcOOgfrElIOka8eihYb3emYp+xJf34zaTJ9L3P139+en1VsPt7ALUkDxPG+2RKSypW1WZSlM9zdZHQf6cpJBVGhLWcJg93UFyjI+f47Rgrm8bbVYkUsATLjSxuzKfPDpzyRtTdA6aWkbHPM9F7s0WbUi72AQ08uJQISU5HaG5JODuezDYb+G1SncOfqmyyQA5NF9HVn2bY26+EYDYCNbWcbEficObShF8EXxN5y8eRndvV7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcMqKTnMvL5HUIKt8WMlcLiKXXBeESjCfK+pfs4DHek=;
 b=UA0X8AAZxO+ELAo+6PZw0uKtAULxtRxo7Fg07ISQ4qeicwJk+29hNg55WDEYjyxjnzwaSHyh+lDjngzG9KzzX2F8dCNVYwfhxEELlM+T30cuOzKDeOmOwVj3kXguQkHc//L6rH++voJy/Gs/dGD9vdAkdnbQ9NLisPCZk22LPMMJXgMomFxd1mJkrxTsNEM+Q30z0QViTphbxki9/ZDk8KQuQF31thiiLdun1VBKa+ISI2A0GjeN98QVujMsQO7RoXmzi5zS07yfu2szBpzNy16hvn9ertxk0KIgWFlZAK1UKy3YKAEJRi0CbMPKlWcFt9Dpcv3XxN2waJNG59VAIw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2485.namprd12.prod.outlook.com (2603:10b6:4:bb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 20 Apr
 2021 19:10:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 19:10:07 +0000
Date:   Tue, 20 Apr 2021 16:10:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        Sindhu Devale <sindhu.devale@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] i40iw: Fix error unwinding when i40iw_hmc_sd_one fails
Message-ID: <20210420191006.GC2185150@nvidia.com>
References: <20210416002104.323-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416002104.323-1-shiraz.saleem@intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:208:32d::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0033.namprd03.prod.outlook.com (2603:10b6:208:32d::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 20 Apr 2021 19:10:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYvl8-009AUR-ES; Tue, 20 Apr 2021 16:10:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd19ad27-9d19-4700-f27f-08d9042fe94c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2485:
X-Microsoft-Antispam-PRVS: <DM5PR12MB248566073256275822DA2D92C2489@DM5PR12MB2485.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awZ6Zsl39c+4FDXyKsD+klUJzINiwRuteeXojlHDaWS4IjukOIFdZ6P/ywAYvYyMKxN70mFF3lxSO/VXTI+B8eJXSI36MkDRBH4J8eTEXNYfqimHcrsQKSekh1POHqVC7ntnVcqWqzVxd/J6QsWf+jgpY0pyc2WfNVchYlyAdLrbWP3Hhr8nUA033S2MHpjI/4wXXmL4eqwku6qMEnBc/Q6EC8ddmH4dnf9khY6M1JNA3KE4YkTpJdW7/sFL2QeqVVG+1kuoemqZ/HgMBDspSpDKbU9ykGTHGXf62230U8A5WBp2IyFr47a9kfN2O2SJ4yBMzRkyaA6iYPsnulWdYQbvPDKTBkUzvcEo4PhLrwzqryGuIsms+O7osHbW2T4YTGGJowiqzCc8gXWcwGMiOSVbRTqkNZs5/guSVC0FekPflE7K5mIEzYlgNmpdy9zx8SeZwGHIv5Z4S4dfFUVH+dqM9hAuvGtJxkinppK/YLZOfriUSQN4ujhGrO9hqGaf9LpyLbnL/V3BYX0x+Y4Lc3exqcau3OUsyK/RVfEsSVZv+AMhditmNhlwTyIIP3bB0ULejRwrsPe2OTNTXM/7h5JO+20wJIeIOA3AFMjX6wn9fmnaGAcUUGpDMTS1k/M4xBYQPO6nIreqaq1MZzstMnIlqngyuj8l/m40TmClR14IRcJvbtExvTBmt3W8clhF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(36756003)(66476007)(4744005)(1076003)(33656002)(38100700002)(6916009)(66556008)(54906003)(86362001)(186003)(426003)(2906002)(9746002)(4326008)(478600001)(26005)(5660300002)(966005)(2616005)(316002)(83380400001)(66946007)(9786002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tJI0/SdEKJi+WjD/5ee1d6xcpEivhQnuyqkDfEi1XeEV9dzJEL7jO7AJizAc?=
 =?us-ascii?Q?MlDdfUyFLTXOQqUzv9HPn4Y7cMJqoPSrX1pVdTi6vbPYdiRL9nhnZmrTV+LE?=
 =?us-ascii?Q?+triH09taC7D4EFhSOrIKqqALyfl3M4smpFp2ZxjBbv6APBR5EZYS1Bm8GVn?=
 =?us-ascii?Q?j3krrz6f7TDp0nJKe13FN5jIhA+FcKkT2feBCg3GcFK05AqRL0LD95WuIkVO?=
 =?us-ascii?Q?vvnUD4uwyJFu0cUvux8DIT7XBGlKnRsTqeubd9pZn6SazzEaXOEX1YhaA6L5?=
 =?us-ascii?Q?IafC8ARGnTrBAf5GCTaMT9eB0b1CpsZoWo8iiDMEgbFUDdxR3GRNY7a9BBS+?=
 =?us-ascii?Q?As8oxfTTsPPyrEYGgqt6uhJ6k/rPhj0qQduMH8byRQFYXVHPnMZsDo0JN4zY?=
 =?us-ascii?Q?a1i99iT+ihu0YSjRlbr3kmn6+CiB/om636ZBNEkOHcOmBWq2U7YK8HMcStFz?=
 =?us-ascii?Q?z4QMpdtI+kbfMWvK5W2zOv4wdC4ke8t2lhDCQOlJOB8bLmrIkaOL4lZ83F5J?=
 =?us-ascii?Q?a1ubHvKLt59FPvn7uwjRlGEDYsXWsn1+Iwa/T3RAlGgl6kG4St9gbip00Xhr?=
 =?us-ascii?Q?Xdpk/Nm4NnLggMr/z/07TZ8cRIAeAv1eR2zn3Wn2Q5+xrMyKtJUxWdP308FN?=
 =?us-ascii?Q?nP3HVAD+Ut3fALjR02pcgAtFaeJhGIetaKx9a8PYZyUuqHi8VW7VQPD+UxRl?=
 =?us-ascii?Q?A9qiO6nEmO5LAYb12GO8ep3L/ffUD+VQ8CI2bXsbPFkC4h+r0TigH1K+2f9B?=
 =?us-ascii?Q?gX8MH855NnqQsMM+pvp4qGeSk4zW2zV8t29I5YHlFsUB+F1ujPdlzWyYjCR/?=
 =?us-ascii?Q?1c2R2mvbu4H4Yhf2dKPe4B4AjtYqDyEk6MeRptDDnPoFYjpCDdk/mcsi6LYd?=
 =?us-ascii?Q?x3YL06KIO30lj2+QkjPAsgHbFrI9dn9UEiOF6FCbdegfi9btfFOVlAiOfCh+?=
 =?us-ascii?Q?L5N7Kx2L+8YVAEMZS3e0eoqdikc/LKDmtmE9Y6NI8didmk2uNElgxwgOG2Mh?=
 =?us-ascii?Q?87rmqhCNunfvp9uH7imArGm7pTCKa1k0TGKgwZdhahVMzZ/c2hgPBYnhMUo2?=
 =?us-ascii?Q?b5iXC8vsws2Xrk8Hm0RrqB91QGZUZIbFwl4sKaVK2KHmH9FeF9LEOpFYr1qI?=
 =?us-ascii?Q?g5K2Ix76N/nofzclcCGZmUl3AvTWweoOhE8C/IU/n0QZH58rsW46ePKf/2zb?=
 =?us-ascii?Q?4AGMu8rz2fePoovR5ADzI/3jiJKUSIrMxavPnDYfQ9+jumO3eXe9EoUf1vCZ?=
 =?us-ascii?Q?/h2fvCOOKsNi9soAs6phBheb1v2oWv+dZjxhsiGNqMdCqhI3tdYt6ek30FmS?=
 =?us-ascii?Q?utnIXr+GT3v465yn6J4UnVoAniOyKMsvfS/gkp7rZPouiQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd19ad27-9d19-4700-f27f-08d9042fe94c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 19:10:07.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EmU1wEdVuy3xWjToGBbrHnBJeheHCfJClpATI/a1F6xGKLbfXl64A+bBA7fdQYnm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2485
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 15, 2021 at 07:21:04PM -0500, Shiraz Saleem wrote:
> From: Sindhu Devale <sindhu.devale@intel.com>
> 
> When i40iw_hmc_sd_one fails, chunk is freed without the
> deletion of chunk entry in the PBLE info list.
> 
> Fix it by adding the chunk entry to the PBLE info list only
> after successful addition of SD in i40iw_hmc_sd_one.
> 
> This fixes a static checker warning reported in [1]
> 
> [1] https://lore.kernel.org/linux-rdma/YHV4CFXzqTm23AOZ@mwanda/
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sindhu Devale <sindhu.devale@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_pble.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

I added a fixes line an applied to for-next, thanks

Jason
