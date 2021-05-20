Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9719338B436
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 18:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhETQaf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 12:30:35 -0400
Received: from mail-bn8nam08on2057.outbound.protection.outlook.com ([40.107.100.57]:30944
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231980AbhETQaf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 12:30:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZUHdQF8xIpp6kfuIIhEiQ0iHEOqWGOH2VzscoFH73t5BsQiHtZ+udAOH0Z1AR7+mNKR5b8O9KWasz6O4z/UD1uHe76Up5V8YvHSvFhUDcZWFIdmZ7ndRZj35AGSk6vqW4tFJNT9SS8RU8aqXSbZWENIzYYFk1UjtB3hoEgGkuweq3k20RTXj7bInohATbItR6qY/HAvYgJq5cZku0cLCm/hbZxDPuzm1rSM/4c0oQe5yhjYMBBldi8sMrzaxT4ZN/4/7faa8poAB+lPETrYNnE9l/pR9MNQdGleX8hq88uWnNFfFtAAOh1OIcE5HCCxTgwYJbudRIp1Eec6j8ATCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCTDLWYngKwf+cagXi/9pPSqhJDDhwf235MPTvq8kXc=;
 b=S3U8zfBYWNgQajC2eF9TaZplnU1rWzayWXRgo0PeuBziR4PZj8AHo429D8v7Wrm302l4jWkoZOUasBNGTzOK32DpyJzi3ZaMaGCX3D1QZXc8RlhGnsOFEI6uHZ2sogZfdZWQ+zyMK4NZpRLUKDFoRl6SJE9lRzjbt7T9ktkGACldmxOyju+rjanxR7K0Ym+hBWBTi5O6AibqhZsxRB/suGpo2BuUUv5MB+STsM1kFHigJBbIyMP7MmJ3NXDuzaAXngv8by2g01rt/5qEAGM3RqeHLuJXNW3As9OcIUKhQp9eOXmZ959OkWzd4VB2CxLiskzqV02KbAAL5U0K6mrTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCTDLWYngKwf+cagXi/9pPSqhJDDhwf235MPTvq8kXc=;
 b=ZfbIQVddmgx9kdjlP0l3fU9RnFgmozzEbBeFMajXg0KRMZBa8LBImdT/f2chYKs8DgcUnKRr1EczfHWpm8vounGQwR6WXq6RwRbOD5RyQLL2oQNoFZWd8EKZIRVXLM8Kc6a/UXhoHhwCzk2Bkp6FmEm60vd8ExluG/H3VXVNlhoreHL/Mli51usvqqjIPxj7LoKFuKB3mhENwlCP8314mtd5jhRbn4AEIeM68ybwsyx0HeRllU/iLpC+/8Jvr8mpEu9kk1vhAlF9zhzfJfXED+IockxZAvO5aClJt3cxBtHZ2MEkguE5trsfNEhjWmxjgywxEOkAnRZD04MLUbKLCg==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 20 May
 2021 16:29:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 16:29:12 +0000
Date:   Thu, 20 May 2021 13:29:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 01/13] RDMA: Split the alloc_hw_stats() ops to port and
 device variants
Message-ID: <20210520162910.GY1002214@nvidia.com>
References: <1-v1-34c90fa45f1c+3c7b0-port_sysfs_jgg@nvidia.com>
 <b39b0550-6602-be80-7343-349a6f6f30a9@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39b0550-6602-be80-7343-349a6f6f30a9@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR0102CA0011.prod.exchangelabs.com
 (2603:10b6:207:18::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR0102CA0011.prod.exchangelabs.com (2603:10b6:207:18::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 16:29:11 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljlXq-00Bdfv-Iy; Thu, 20 May 2021 13:29:10 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2351238e-36d4-4661-04d8-08d91bac6672
X-MS-TrafficTypeDiagnostic: DM6PR12MB4483:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44838B39E8401EB9FA9F53A1C22A9@DM6PR12MB4483.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLV1mCaLmcXFk3Hi5TAm4L0uKpeRdBWwyFOpbJg6yrKUDfFyPrOmXDjczpquwWR5tIfUwPZfeSM30+pRMYfnxp+AGcayIMLZfWtejbEhic+/yJ5q+o5FhKVsgw+v3mV3ktLeh5tV/fhXHfm07plzjEriMlQfEeO3xxgXoiptf3qWizWO5Nma7y4xKikseEPKt5tzaPcG36w0SycvBDsH5dHuzMP0Y+U21qWFq53LCkY9pxHFaSqGLFKUa5+624DZZfWNOHJDmCqaBIBKedKeElASTQxmDN0GO/FUysT+TlRwMwfL47HkLJsyOjnrezT35A6ps21hePUG82ri6dF4fe/x/3ils2XubMJUNyeI+wfQkcKn61SqsHruVf+evG5ZTLKbnFohQRKnjOm8FjoAPkWygxrLL2meJH5uHGY6jrKaJIYo/wvrhR+vVFUYaIyui/hk33Zx8afeF8xQV/VYAgke+yRKd9Qfgv1WdLVCE2Jx3T9EXj6Ks3+4djdm5o6Nsj9vLAGPxVFHeNBHcHMgrSHDOF2GTraixH0arTZgNTni1uK+J9nDHNbeVa/JTyJlhtmMlk0sSiCsBKhygfQ7qcSXLkdxccRachA9+VZp9Ig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(316002)(4326008)(36756003)(66556008)(1076003)(186003)(9746002)(6862004)(9786002)(8936002)(66946007)(8676002)(66476007)(37006003)(54906003)(2906002)(86362001)(33656002)(2616005)(53546011)(5660300002)(426003)(478600001)(38100700002)(7416002)(26005)(6636002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?9NAMXpp7c1bGmcKgR2BHkKDsiNCUAC4y2uXU+1KWpuW+mNCfIi6Zmg17/YLA?=
 =?us-ascii?Q?nDRv04sTD7d+yVV6wXdiTmUGe6WvmssxM1ICff/JEXO7+DkuCOlR6QkGs9yZ?=
 =?us-ascii?Q?YRBB7jTzNeVzXpULax17rT2OaLrwyChMfkWE/ft6xzlG7Tqb7Omz6HMZSsQV?=
 =?us-ascii?Q?iTkwF0H26Khc73hDJd8bgsEOj74dIXeQoakgdAhuq9+XxIklzw5cRRtngY5u?=
 =?us-ascii?Q?7yQhvbJNoB18sJjdNofncxEKYyL0KQqbl1A+ZnWxk6q1V88DfHZYyoZ+dqIm?=
 =?us-ascii?Q?JixpPJywXW3plUoHbEwEEPitfVtWm128nJwEsphaX6Fc937QfNKuVkLHCB3H?=
 =?us-ascii?Q?n3f3LrPpx94EteAnIByPkkJholImsR6NnG1kM0QpvgKCGsHmznuukMTkcxIZ?=
 =?us-ascii?Q?XYb8F+eh+czCsmyhv8mdXd7rBkQNttWhalN1AxdVTwiI7jI/f16VrRMZ8hT9?=
 =?us-ascii?Q?HXpX1MrJQcTzPSxBLfO7niO9sihZhKzTDe87yIMQnjV1fqkf5j4PU6HU7+QD?=
 =?us-ascii?Q?kOCWlIgaa0qYDZgPaPRKIz8/usaValBKQjlTzIO9ZqI4MjhagQn6i+Anqm0F?=
 =?us-ascii?Q?kmCHOZBasspGPovnz6DA9wr1vFhsAY1RLY/cpJkf2ItPAMb+dZR6Ivxq6/Ff?=
 =?us-ascii?Q?THBFeMwbT5wHpRX/z9SmgZ93W7Q/HT7dYy+wlriwefFxR5yfK/OZHtKWfkwj?=
 =?us-ascii?Q?uXW9liVY5Wd3uJQARKgDykkHuQ2Y5IIIN56nCqMTCKAQMOg6Bx3hJlghKTLj?=
 =?us-ascii?Q?UBxfY0Er9LbJwk8Nhit1KUJHSX/2H6D6GZeQ1wRwT4dNSC3rtESZcKNJs5Fo?=
 =?us-ascii?Q?oidiR0RNY/hhlQtkHBTIhHhm3+prAjiisNc404Ze93BWMUvywGesbri3C2a3?=
 =?us-ascii?Q?98P6phnbLrCazI7xYi+amh9R2DfgyC/LIRtwlGBBGgxtHyBxWJ/X0GJVTPDm?=
 =?us-ascii?Q?PGvAAd+RXcGANwCxSDkPY+xFsuLlZze/kDoDpoH6W+Iubs3wAvzz9xtx0/7z?=
 =?us-ascii?Q?wK7cvGyxwADtG4KKrG26Qbu7NYjMxuwoqiVNSlNoEWQpgI2tQtVL9wMLDakp?=
 =?us-ascii?Q?4LoEWDTGqrlo5sO3aS+G7VixIt9i3rKa+CJ3r43+57Xoj4ttqXRTbyJA5a49?=
 =?us-ascii?Q?q1/1cKBzrUyZhBcAZO/WfS+TQGdOKH7k1g5nQl1gpm9/YfVFH72NcvjMtGds?=
 =?us-ascii?Q?cy4hlDBJTXwTxFzZzsxV4o+7u/nxaghsDRv/cMvHFmuB6XxPYG8AmlR3S/mC?=
 =?us-ascii?Q?AMAq+sJEndKEfUpsn7WeZUVFqq8K1sbYsepX8j+HmYa2p50KBxmjsFLawHcF?=
 =?us-ascii?Q?v0OWlNOweh7xCp5XTt/LKUk4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2351238e-36d4-4661-04d8-08d91bac6672
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 16:29:11.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+cgi5x0UQca0ON/pG9+lm/MxYGRW+hjOeB/Nsnix7W8Og66M2/gz+ugOKNqTvZr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 18, 2021 at 11:49:57AM +0800, Mark Zhang wrote:
> On 5/18/2021 12:47 AM, Jason Gunthorpe wrote:
> > diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
> > index 05b702de00e89b..29082d8d45fc4f 100644
> > +++ b/drivers/infiniband/core/sysfs.c
> > @@ -981,8 +981,15 @@ static void setup_hw_stats(struct ib_device *device, struct ib_port *port,
> >          struct rdma_hw_stats *stats;
> >          int i, ret;
> > 
> > -       stats = device->ops.alloc_hw_stats(device, port_num);
> > -
> > +       if (port_num) {
> > +               if (!device->ops.alloc_hw_port_stats)
> > +                       return;
> 
> Do we need this "if (!device->ops.alloc_hw_port_stats)" here?

Not really in this patch, one of the next patches needs them near
here, but there isn't a good reason to leave them in this patch at
this point.

> > index 3f1893e180ddf3..c0f01799f4a0b9 100644
> > +++ b/drivers/infiniband/hw/cxgb4/provider.c
> > @@ -377,14 +377,11 @@ static const char * const names[] = {
> >          [IP6OUTRSTS] = "ip6OutRsts"
> >   };
> > 
> > -static struct rdma_hw_stats *c4iw_alloc_stats(struct ib_device *ibdev,
> > -                                             u32 port_num)
> > +static struct rdma_hw_stats *c4iw_alloc_port_stats(struct ib_device *ibdev,
> > +                                                  u32 port_num)
> >   {
> >          BUILD_BUG_ON(ARRAY_SIZE(names) != NR_COUNTERS);
> > 
> > -       if (port_num != 0)
> > -               return NULL;
> > -
> 
> I'm not familiar with this driver, but if port_num must be 0 here, does it
> mean this is per-device not per-port?

Yes, I switched it, though the actual counters look per port to me.

Thanks,
Jason
