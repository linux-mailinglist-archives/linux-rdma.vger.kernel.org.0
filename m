Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913752631DC
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbgIIQ2y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 12:28:54 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15457 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731110AbgIIQ2q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Sep 2020 12:28:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5902920003>; Wed, 09 Sep 2020 09:28:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 09:28:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 09 Sep 2020 09:28:46 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 16:28:45 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 16:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TyOyPgzV0cIodI9wAjAP6A2YxdJWYQbKL61ql4oHEHkh4sagzhhLkA5QKkWTa9Akh67bsyierdzLb08d26Whrz/zvY/1/76pclb+zdy2MlPx5Apc6e0Dx3tXZ2SHe0sXraeLnALT67Ye5Aq2OJ38hIVFSIUl0BsRvi3Nrou9ERMWJ4R5LUcl3SyFDmh2bmEer5qG1RZys6CGW0dQWUO+Qxbt/7kiBI4Tx52CF9dywSyrPFldMS0uqEeW9p6sSWfchPEJKBr91v5ueBDLR7XXEdIrAIzZD+GVkG7wDz5mDUlfA43rcvzdVb0RwwDkLbuBp4+WYV9POlsmtUY6uYE13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcqgSw+577kKu8wMBSn8AInlx7Y+xRiVMuot9rR1tMo=;
 b=jJ1C7Fg/HHXUBRyONXTnT4f6LUMlCDvOthe2geDFb3uAWvFwD78AcHe3+p1rX5G8eMRu3tFjCEw1KlhuWFkQki4nnZsSpoL80y9ghxgDMS+Wsh1JsTWGXMH7gWG+erKsfXYS3SmVNoQrnJBVjh3ZxI6o0aHZQ/k0ydVEBmTrkYbRE65h2CulqubQz4MEM4bIBrISApucVtLCO0V0pPz/YQbZP5qhl3tU/IMDi/8AJAOPCxGNeYmUFmkGEln//dIzo6zdwQz/T7WcrluAYuYEvKTUvwQnQGVhsYo//JViBS4gL1O3uADx0kuGc0Yd8J9PqFHvAnY3yeUN06whHY4wbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 16:28:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 16:28:44 +0000
Date:   Wed, 9 Sep 2020 13:28:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
CC:     <danil.kipnis@cloud.ionos.com>, <jinpu.wang@cloud.ionos.com>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <leon@kernel.org>
Subject: Re: [PATCH v2] RDMA/rtrs-srv: Set .release function for rtrs srv
 device during device init
Message-ID: <20200909162842.GA868842@nvidia.com>
References: <20200907102216.104041-1-haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907102216.104041-1-haris.iqbal@cloud.ionos.com>
X-ClientProxiedBy: MN2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:208:23b::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0027.namprd11.prod.outlook.com (2603:10b6:208:23b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 16:28:44 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kG2xe-003e2C-Un; Wed, 09 Sep 2020 13:28:42 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4675e5a4-836c-42b6-2e1a-08d854dd6b86
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0106371E937934F0858B6FB4C2260@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBsAfVacbArxi+UtH6qGPo8yxeaak/e5arKOVP2/iFR2s5oXbW6+htWW/2CUxoJ1W0dreaJvSIFWDovq+08z2FJRRPmUODJ5LlzIIuxHC9ewxEDQ/uWBYDKAvRmVCh4eYOL0N7fpoGclPCfsM6HoI4/Z/Ho9JKSaICgSXNqfzgmNKqgHsV/hsivveYbYbef7LA/HS6TF+2ZH+yv1H3iZEM3iTKdW0IHaxeJ3ygR5ONSPfYj+EWyYjszMiV+bDPbm/2c2yZUL+Mk9Jbrj3cGZ2YRSnxtjZoHTySqZEUT2hXIcva6IRPZVrbukb1752AaT3X12s03vwnfb0i5MoX94N2acwEp4YPUubXsDgMohNMBICzxrXJ2w1dKa/rxbFkYkXBkNIMmtI8PxIJRhDb8JpRftSpv76UDZZKTIahGqq3H9vE4WjTqZm70iPFG7dXyhIqEstwmniwqDD6TYijUU+4TVEKb3rGWRTTVIAhbeoCjjT9vkNA+fTkUTbpXduiwHueNCAVtPbueWUSb3Qzte9H51BKqd3qGpJ0YEG7ypdsQuWl7w4QHeNuuiEM+6pyv7Dw9QtiSd0cFTNYVS147yym+xh34LO5c/O+7IkvS5pJSP6HmwTakgeMZDZrLhEeGm9jJOHnTO2VTXUtdxD2TPflKH3gTUHpnCtlgX85dGj32mJsWv1EejcYhfXs79IJQeK5Ag/KDX9Ad0/0hr57IZ6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(6916009)(8936002)(33656002)(4326008)(83380400001)(2906002)(86362001)(36756003)(478600001)(2616005)(9746002)(9786002)(426003)(316002)(66476007)(26005)(66556008)(5660300002)(8676002)(66946007)(1076003)(186003)(27376004)(142923001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: 4PyToGrFmxHMRwOP7+W5JvjMuP+EMCdjvok72Cy9hnpLIBfPpwxiKR0oX/nbWZk4qRh7Vt8AjcKneNIvW9rGo74naLmkQN2710RrDXoJdyDYjEjtS1PiZjPfhIMo5g6/ZwRzvVFGraE7wcpdDcxZc9TiuGq0ckqGXA5sqI72ddAGnhaMtI/3U9KFZT7FQW/S9W4DWakioLxMw04152itx2/2P+GCSo6m2TQahSPRY49B4f8WS4t8GmaOy+Js0Q08jgMeHc++rfI86VmBQjqMhsKPSq8eUxTg/jn9q/pmheN6sOerKonzlXyqRdRkIZkLTaVh2Oo78ONK4ezYq89ETajaaM1LwnRTbdlrS3r+7CqbFrhXTaebQcLS3YAWiIAugV6rs5sKOO3V0qRAIp5Lq6EvWMH92qbH9hH2uhcPESymMuV+0Oen95uwx2D7FUFsQoxlnZXebyzy3PxscX5L7jKzHjBBHjIClsXsd7iEN0NrWvTWVTZip0kXq3ZH+BupjpL8k5B71nITsRps//2Hg4qX6RlvVlE7sqo1ieM42OgQZN7dVvGP7iEbdgrTiN8ddymrAwNg3KhJGCg6XZymhKD/+jtygPlp8F5rvpMVFPKuu+dzzFDsRhAJU5vS0JGr9JXLZxh3Zv8LhnWa67LPIw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4675e5a4-836c-42b6-2e1a-08d854dd6b86
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:28:44.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qoEerF0mlXhtquGWOU6s+Wtfo4zQo6ADgDMZe0KkmUtEVQgU0kxkP6zFudlq57X5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599668882; bh=ZcqgSw+577kKu8wMBSn8AInlx7Y+xRiVMuot9rR1tMo=;
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
        b=EB4UQbKQfNpyMoy/6jvBSd03MMO7Clp6B8U9sRzu55Fsx7uud03fm0xejnmCYjG7E
         3Vs2N20mUuJkBgP8NR4fnSQR86XYm+hSEDNi9El3PR99xYwe0M4oqnzL+F1GeH+GLS
         YL60atpTByp9d/jk3lzGYuFetfNJ6GM4WHcbBXpY01KWYqD9zNTkJ7CuOq+h55jfhW
         A9xsYxdCoUjH0mro/DUCi9uvElhLXDNKjzXWMoIX74/7a51Cej+h1EMb7CN7xiNSN9
         YbO8WEYTSBkSR/B+OTyROfksmGwLFo84YikgM3OMgs1wjQt5wAdG3txtUxUjuqolQf
         RYYUQNUJXw5UQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 07, 2020 at 03:52:16PM +0530, Md Haris Iqbal wrote:
> The device .release function was not being set during the device
> initialization. This was leading to the below warning, in error cases when
> put_srv was called before device_add was called.
> 
> Warning:
> 
> Device '(null)' does not have a release() function, it is broken and must
> be fixed. See Documentation/kobject.txt.
> 
> So, set the device .release function during device initialization in the
> __alloc_srv() function.
> 
> Fixes: baa5b28b7a47 ("RDMA/rtrs-srv: Replace device_register with device_initialize and device_add")
> Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
> Change in v2:
>         Use the complete Fixes line
> 
>  drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c | 8 --------
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c       | 8 ++++++++
>  2 files changed, 8 insertions(+), 8 deletions(-)

Applied to for-rc thanks

Jason
