Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E5626319D
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgIIQVK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 12:21:10 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:32981 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730790AbgIIQUE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 12:20:04 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5900930000>; Thu, 10 Sep 2020 00:19:31 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 09:19:31 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 09 Sep 2020 09:19:31 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 16:19:31 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 16:19:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMnht3cFDIrwYYPCIH5eYXk3JvCvYrcQSetg6L7I/yGuSuzTymD8q61YzHrE0fLPB0xoMMFNFBTK2c+aasNzt/o21fB3MPyWptvRn/Z81+fKwgxa39dy6YfkHiANPGSRPrlWVSSso+o/FJ/K+HiuDiVvuqVqKjSwmdaxjsc5+kRYFDlpZ5lds1si0zCQtVjfbQw0UvLQ/EyE4CUZwESlYlPfN1Agl0P6RgYLTq/iDx7SX/fuC0rDVGLaMVI4txyQh4nFaHUREhe1fTUX23OGEYE+hueJouKO4p2Qm7vtHdZaowWzQVSDr/oF+qmnpY9SbnET1WEb/l+ybkszR0qLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCb0+awrTP86J8/SNGhRWzk4r2aNApWZkDD/TFYwiPs=;
 b=law8P76wjYr/sDLhD4zljp+pbKlWcG9PU5AXqjMMyDcY+A5U4gGTsYPe1iNB2h0fNXCfd370MzU+hEom2GFhX6Lgq3F1VtIkSjyYqWN9n9D/NVU1rU/8llEAKzTlR8cvPM9SbLbop8ywfwwTkBwoR8cYfqEh3Y72uHtxsWb4JWEZFQjuKmYhBUZdud+JlxkmhLoJRbYWdE7vQJpK9pymtJwkn+mLVgNYEjGcLmMgOU0r5hAo3cFsj0V/LRf7jPReOnBZBt7Qq3gflOIpP7tad2uS0JktVNQRsRPu1SUwL9ExYc0tupwEW/LwpZ3kVBs5OaSvHKbOsoPG4fagSpt3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 16:19:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 16:19:28 +0000
Date:   Wed, 9 Sep 2020 13:19:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/core: Change how failing destroy is
 handled during uobj abort
Message-ID: <20200909161926.GA834651@nvidia.com>
References: <20200902081708.746631-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200902081708.746631-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:c0::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:c0::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend Transport; Wed, 9 Sep 2020 16:19:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kG2og-003V8p-EN; Wed, 09 Sep 2020 13:19:26 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b1767b1-70bc-4441-e56b-08d854dc1fc8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-Microsoft-Antispam-PRVS: <DM5PR12MB17544372E4F66B9F52ADAB07C2260@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mu06WVN8RUjGO9w0fOxdtXtbcNpyI2h9ZLuQuvaTO2lmpD6eiNRL1fYO3QvYnXvXs7xqjhegfgTd1wntcRchphQuk2OW/zjKzRKt0LmEkjPUiL/v+gb7UVNoe+Xk2dG+z/YX9ufxTMrCwuUNcTqlEffdLPK9VAMmIVJlC0KuMKVyCmzqxn/tToU1jpzMEQERHSxZ1g2Fe0mETigklwO8pLQI/Meh6wHF4V+GlTTryKjBHaqo185cL/dNWsv9JCaOjIcLETMJC1pXEzbOydH2jgK+yBOvsY6WlPjuQOn3qEgvZOSLHaiMnYJV+qFdboFap7TQnmsutF2zJgK2UHooCrqu4R3o2xmF9nDwsyhuGQ799kpBsnoHCQZkYff9FF8N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(8676002)(86362001)(1076003)(36756003)(186003)(426003)(5660300002)(83380400001)(26005)(2906002)(4744005)(9786002)(9746002)(316002)(4326008)(6916009)(66946007)(66476007)(66556008)(478600001)(33656002)(8936002)(2616005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OFWqjaz8fgTNbqlSAdHFU6pC1SQ0S8YSSWgrNbOA+CuBE4AfyRJp/BZhRmWbpw2wRLKXPX+Esn+Gk5fZRk5nzM80EkbOnBDPsvcGGlTi8VNYadCaXSiG4RpAEF+3ComQuhKWqLFakY7iBAvvhItcv/oZmb5XeDGsFlMq9hmU4weGHYo3yF1kH4yLDuiiO7wANIVwJbIiksgmzASmp4f5jOGZbY1ExjjkJE6p93Ehel6UryC8peDbzs/IJJh1zEYk5U8mk23hwJ/K1W3c8lcayLmgiSUfbOS/pWt5jjUSz1qyYgNfZ56CRVyQDDCLVWvx7gXo0n+nlponmoCmbA0Y+BIkl0Up80iWHDX+pURu0fo+gagTaE0WMaYXsyZ3WV1mWTeDGDLtKd2EWF7XoeWHqugwslsjJpg3MoxXIVK+KRhOpuAwbe6IGWhT7PmfNEoJr4lZBZ5p7PNzbG6YO5Kh9mLYZx2S3mF3AbSsDLd2CxEap3pDsfwO1WE+TXvRYexP41txjPw30bIq1Pl+XrajCOM27P9h1w1GOTxSzWdARGs41Nv3y14RpG4nWe9KzfaNRmIUeY/nzivW2UlM7Gb3cR/9F9h5TrBwdHXvBVbxGKvjlyleY04HlfluBaGlrozXhte4vm59Q+p2vg6j/vH0fw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1767b1-70bc-4441-e56b-08d854dc1fc8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:19:27.8151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFxB0rqU79w5DfSEDMGPrJFHlIdXf/DSnR8Ewu9TxBO4cZxCz4D8lSqLXI86fHju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599668371; bh=OCb0+awrTP86J8/SNGhRWzk4r2aNApWZkDD/TFYwiPs=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
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
        b=E5FH4D+1IiDQcC70Idcu3k/YddG5xqsNQZp8TackDtzf712pwWHMX0wy1TIA1GtLD
         h8IIQRrO0jhQC1wrKoi1TfAI84ociOSn1CbGlEuKgRQeroTa9bUAD3tNqoX+V59yAP
         6Pzhd5r/a7iJqwsq5mSRPErafStHOfty15j+xp2ActxiAuhx8Mf7o+cvtlnmtIwdhc
         brGAhKIwwzyMfKd+tLa0KaD1OOeMKnDEuCEYak0vZ9ihjjJTY8TVXVVUlSVaQj43kt
         gIgpoO0lLOWyZBc7kQDSM00zHjirs4GChogt8A0At26yH89pYjdVzYmW5Jnp5NrR0v
         Kd3nA4JsJ2pow==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 11:17:08AM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Currently it triggers a WARN_ON and then goes ahead and destroys the
> uobject anyhow, leaking any driver memory.
> 
> The only place that leaks driver memory should be during FD close() in
> uverbs_destroy_ufile_hw().
> 
> Drivers are only allowed to fail destroy uobjects if they guarentee
> destroy will eventually succeed. uverbs_destroy_ufile_hw() provides the
> loop to give the driver that chance.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 30 ++++++++++++++---------------
>  include/rdma/ib_verbs.h             |  5 -----
>  2 files changed, 15 insertions(+), 20 deletions(-)

Applied to for-next

Jason
