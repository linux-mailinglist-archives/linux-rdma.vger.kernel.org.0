Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097042779D5
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 21:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIXT7S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 15:59:18 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13899 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXT7S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 15:59:18 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6cfa890000>; Thu, 24 Sep 2020 12:59:05 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 19:59:17 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.56) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 19:59:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oL9H+ymyZ5jtkS1KJD4oeoRN8iQEwObqCC1EgHP/EcoTBNKEWSNLc+L/vCjcUX9QmE5nBL1QU44F+BmK+VOK7bi0rpUJw0Sl1YMLoQiJuDP+a6JkTuP6qMpwKrhZ4Cy0Zu0IA97NvwG8nsWctKUFezxAv01mx7UcSLyyx6jyzLu5ieX95OZUV7SwwnJnWGGkzTaqC5ubHwsqxOsbMYQClp55LU/D+OtnLMvlAhwHX/9cYEPrcyQk9MD6u8Yre5/Gn36gvq03dxJ7cpelLZ65SwMfIX3GxW+tcSUHGTYxUe7XM5lnqBZKVH905p6XFZlBKdRnrLov6NM3Gp/Fp7+qrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41uKt4238E5MxCpAVL4tMLTQxpW11+h1P6JmnRxeUcM=;
 b=VTKNEny+qMQ+ffEQK4YdYcvikTmPkTte0GlokL0P8+ffm9Uk8wKytctQEb5WziTsWOi9mF8BaSjQNYEqumFf/AIH5bzbBqEPSzb85KiCszV/bRzVihatvRGtJly8KOb8JobULsWU37TPbEU63g7X3ES3iww3aEGznvJi+WIaIZZXqRXQ6+fJlUHYY+HeFDN0ctAlgkO+K4X0M7CxVtAwuqFBuLrFcMY/W6SbsiFy5oYfpgeVXOpEt8eDMbTuSOPV4r5LxB9MheTz2du4XM75d+pTjtE6ffippJn2+NBuHnYlrydH9lMnBbcZ23VpvXf0bRBSTwQbk04YVQQgH8Y9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Thu, 24 Sep
 2020 19:59:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 19:59:16 +0000
Date:   Thu, 24 Sep 2020 16:59:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v2 11/14] RDMA/restrack: Make restrack DB
 mandatory for IB objects
Message-ID: <20200924195914.GQ9475@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-12-leon@kernel.org> <20200918233152.GF3699@nvidia.com>
 <20200919090928.GC869610@unreal> <20200924195001.GP9475@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200924195001.GP9475@nvidia.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: BL1PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:208:257::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0052.namprd13.prod.outlook.com (2603:10b6:208:257::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.15 via Frontend Transport; Thu, 24 Sep 2020 19:59:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLXOc-000Xkj-GR; Thu, 24 Sep 2020 16:59:14 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e53a1fc-b216-4dbd-e6a0-08d860c450d6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1755:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1755AE5B17713A9441E357DAC2390@DM5PR12MB1755.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: te1XMl4jfI/yjFcqo9l3kwsDcyJXSvBDRZTYWWLLobJIuokEtAt/d9w5FnQRk5p8TRaGfCO8Ch6Q49Vk66hU7hLmGv+zlyhGCo9YCbqrLUW+Iusj+hqi+T/JSWhOf2tx0Xg0fcgkGCVmEUACPW4Fa9dZfCOaMOPfVvj0bgBb2l+d3FeeUJs4gkVjKkTx7aJ19xM1iuyPRvtsyMuvaJPX4qkJCWRknJWJCd5sDxgT3N7SXj9GQ5Ju3jPvwa9HINATmd7pb6ViNcr+unvwBBQzX/gf9QYBNzEmZlEFEUF/GFBmfc2xI5CFm3KansV0h+MBJMhx0AWPnEWohCNDx9sAkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(107886003)(66946007)(2906002)(186003)(5660300002)(478600001)(83380400001)(26005)(4326008)(33656002)(426003)(2616005)(86362001)(1076003)(6916009)(8936002)(9786002)(8676002)(9746002)(66556008)(66476007)(36756003)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ioNpY4wmEiSYb1haflTImd9e5dSucKdCDujHrxA7c2q3DGNQnC4qRjsMc3nYDzzUAKssw+CbIxjYP5oYvphcxuzZv0eo0Qw9ki5xmbCqXRud3fylR3saYFWLrhKZUzEwxelNiJHVVuWl+b7dUU99Esq/dEYzhfqv07eeFzAR5FZWy6etL7KcEyH6Qwq58omxYdCOwnTG2qtCq2msco4JauXnuYnUCP4a7U0IeH/vMQHT1lCGWVdZNQHEftD4Bxnzwb65++tMAnXTkRBAhWiGzKTZxSjAxtWVL/NSTFmArHo6iPFZl8nFvtrmN3wDajvNbKpMCbJ2bMzOezX0BJzlxLs/N9KZFaDplWCEx1Go+eBrd66dK5ohAozGIjwRQVzj3VEyEgszAlky8a9IApXu9mUhXRlApnnqd0QslqLDGD6fLT4GsNvD38rII+u4Gu+w2GlQnHBEOfURI5dX2lvgLx5ehjGhFT1KUHJ4Qy47Po4ZpoaEo/GRhtppxQn/Cw6nv4tgykkOzaQNb3gADubI5mx+wELsHjoJVO+XDy7pXsdjNxNepf6IWg6IcWYB7XdO+zFqOy3a1gEutsplB2MAaSRUdEDGZYmtUCDivVVpttFqVR7aJ6N4iEwwSLoFaDM06Qv5tSmqFMKB5dgn3ej1rQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e53a1fc-b216-4dbd-e6a0-08d860c450d6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:59:16.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ewC5FUoVeKc4q6Iwov7nIez8xBqLlIHiCNcyJWdkzBukQ6/1Itlz9f1lzPPxL0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1755
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600977545; bh=41uKt4238E5MxCpAVL4tMLTQxpW11+h1P6JmnRxeUcM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=r/pYpIk5zc8pVWCGiRO9C/jK73KPFpkAJn4m3xTsdKd4WZSK/JWlaL6oXxnTdOmI3
         5lDgWErL++rXtMNMB17VuNgD3agiTEE9IkCUZyH3aMuOj7FP6YvkzZ+z1wk5vUVa5V
         k9JvpeuixC7LvOzX55CV2IruJacfFOWC8Cy7AO8iS0+MTcyOojjBkhcn7HuLxjYsLG
         /vFFLGSWXdvQh0f2Mnc/XQk9SdGkoY+t5KWRRV15d4VWucuM9AB18HhFLjCiyxTV/F
         2RcSdvb4iAylpUplQCeELgc5SihDJOHpLkedZizz5X06McbFd8XUv5MbRyJplUTIQ/
         KGHeag2KkMWPg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 24, 2020 at 04:50:01PM -0300, Jason Gunthorpe wrote:
> On Sat, Sep 19, 2020 at 12:09:28PM +0300, Leon Romanovsky wrote:
> > On Fri, Sep 18, 2020 at 08:31:52PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Sep 07, 2020 at 03:21:53PM +0300, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > >
> > > > Restrack stores the IB objects in the internal xarray and insertion
> > > > where can fail. As long as restrack was helper tool for the
> > > > debuggability, such failure were ignored.
> > > >
> > > > In the following patches, the ib_core will be changed to manage allocated
> > > > IB objects in restrack DB for the proper memory lifetime. It requires to
> > > > ensure that insertion errors are not ignored.
> > >
> > > Why? This looks like it is all about removing valid, not sure what the
> > > kref has to do with it..
> > 
> > This DB is going to be main source of all HW objects and their memory
> > allocations. We want to be sure that everything there is valid.
> 
> Not really, what has happened here is no_track replaces valid. valid
> used to mean the entry was in the xarray, now no_track means the same
> thing. The patches in between had both because of how the conversion
> ended up
> 
> This commit message should just explain that valid is no longer needed
> and no_track now indicates if the entry is in the xarray or not so
> destruction knows what to do.

er I mean the message of patch #14

This commit message should explain that this adds error handling for
the rdma_restrack_add(). As far as I can tell this isn't strictly
required as a failing add could just set no_track and things would
still be fine.

Jason
