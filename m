Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23CE248E29
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHRStZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 14:49:25 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2913 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRStY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 14:49:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3c22a60000>; Tue, 18 Aug 2020 11:49:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 11:49:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 11:49:23 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 18:49:23 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 18 Aug 2020 18:49:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQMo1AwM/7iCe2TOa6UpiYy2uONO8rI3i6Z4h55y1N3tq/c6jhPendaa3d/V5b0iAj22lNUkCCE6HpJAwuLBpijX55l8MLT8TnPkgggutylsqQf+0ckbLoIaXAvxgYC7FAlYu2nNTs0i9KiTm2mpRlwE480OUwoT8GW4en+u6cWGjBgKQsSMsNHWrF+leRgZva6Ub/FMBKT0y+csXGvRH6vbrg+4gbwBzPHTTwa36ZZzxvn6+oPGG+J2GM8AB7k7AhRQKqu3x9MUBnRr4WopLSBWV1VhpZQRw+XVzLVV1mw5taiSBB3u7ehlVGDRK2aqV+5swg5LcTSgxcTIDUM9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5eObAtXTPo0xyoE4OH7YhSpM464VAwDkL9fR5gx/Q8=;
 b=nfz0PUIG6PtTM6NRPhMgty38hsWlEjNKe90zX0raapFYRHD+UHrcX7YzdHnKppVnF445xxziTBjEcr1WFfsPXF/wdr11huakgIxV5iN/6F0V7yhzT4hSSeDIDO36NGvg7hQu7FkRfDgzPHtpDB2Gr8ljJrP03ysX7THLN2udWda3bde3kqjxbScZxVUwHPpbUnVsVehidZyeZFpRCcUZOdOLQcGNgDc7zkfpOc9KChJCySkYTm9ui88dlwftb9VPuo2HLjQX7Jl7D9W/y981M6Oqn/Q8MCwfUWCue+QuwLO4wSbIz45gh0LiZlosM44+lynk+W5GFtKIvtfhLCcd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1660.namprd12.prod.outlook.com (2603:10b6:4:9::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.23; Tue, 18 Aug 2020 18:49:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 18:49:22 +0000
Date:   Tue, 18 Aug 2020 15:49:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cm: Remove unused cm_class
Message-ID: <20200818184921.GA2068870@nvidia.com>
References: <0-v1-90096a98c476+205-remove_cm_leftovers_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-90096a98c476+205-remove_cm_leftovers_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:236::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.16 via Frontend Transport; Tue, 18 Aug 2020 18:49:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k86fh-008gDV-AT     for linux-rdma@vger.kernel.org; Tue, 18 Aug 2020 15:49:21 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9f338d4-15f3-4f64-109a-08d843a76c18
X-MS-TrafficTypeDiagnostic: DM5PR12MB1660:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1660EF64A5EC0BF70ECDC089C25C0@DM5PR12MB1660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96MBmCj8SOv1Z1efVIbe6A+WI3OWPZeNrYMiAZgn1prStjbuR4VBWXvCF9Qv6++bKnoOaayBOCz+GOj9W72vKy98faWYspX8YGEMWwk07V8XcmFDVebFJmMIld+em1UNO0ur4jtQh1+kZ2uf1wQEtO5iQa6zzFadTjZCOmWhQWFwJjAOXmnpEH5jiYeC+mfr+M3qrSl5s8kxtMjwhDh5XaXF+YEh8EeVJ8piNGxPVGx78EXNoGXMPAdnKN1zOsGL5M2i0HkIP4tqHGQEytmhHAhm8BSNtitUSTFNeUS33zlMKlt3kYv+HtmxW/SZWcjYPLin/wSlg66sMjRnx1VbQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(6916009)(9786002)(2906002)(33656002)(5660300002)(66556008)(426003)(8936002)(8676002)(66946007)(1076003)(66476007)(4744005)(2616005)(26005)(86362001)(9746002)(83380400001)(316002)(478600001)(36756003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZzzQFUJmVFqWN31NzcqezBfw9SyKLUhmsuVM1znDzyoDVj0f1UFudh9d/aC6XWmXAM2oy1rSLeFDaQKUfMPqyc1dOTBkMI5SK8xim4kuYT9r2ndrPvLCsk+OmAMqbPj37oMsiwjrDk+N2IZ6ibfchqSWyxkS4oxSqzbFixWxk3LMg4g6uAKttBSbjiz5lyBGET6RSl316yieHZpkJk7OCwTJfFb9jkYszGgGomjtuPrebKSjR6Vy7DMMf00/CzPa/nwsgT+VgXBUxkbzZAoxaNsHiuFk797ZSrXKz+7Dy6itwO/K/ck/CLLAh5LViGVo1Vo9mKZwP2erviXhsw/0cPrQtNTBAPjF4i9BKsRsVwZpC72Bv7gFv/E44ljhpX7eI+EjIb+zhqBDvIp6P/oNc5ZE2kYC1P+KICsykg6fjvvYy6jKNij1gOJLIY4UpaGJ2jb1YZ6ieLopqeDbbGyWDVt9N+hc5lnLa0y4HMi290PDj1gF1uOwBGl+z/YJe7BygtdHiuUTzHOkqmIt7luEkihdhPpHDP7jkwzaKYdm6L7DOSIlbfgfRaeKU/kL9SAW2WKL4ndfZvYZ4B5Zc7FqN3Znzln8x3/YcCAWPb84V/9yEcIr70nSn5tNzweZq7E4o0VMnU5ki5zfVoLPevRv3Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f338d4-15f3-4f64-109a-08d843a76c18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 18:49:22.6979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qVD8/rKPWX58DT0PGHiZ8bAwVytx5hVpe2V+JMSAGMkLMT6LSH2XEUAnB5elmXf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1660
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597776550; bh=f5eObAtXTPo0xyoE4OH7YhSpM464VAwDkL9fR5gx/Q8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:
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
        b=UinIIwNwrNphTe8+vXFuQnousiaYowkkqKcn6bUpB1M+hMp0heJ7yb6W7ZYbBSYIV
         y13LTFLp89V5RGAlh1xe6CYg2nRTMXL4BkUUnW6JXMf2ndU7C/JS4a8dMxHBRRTepw
         jIzxgOKhW6fh8NPfA+p1SfH9PPSzkEVYOgdZRr3rfTpXm8rH2pbHVB3x/BTP+ra9RQ
         fQktkSsgfoBKfzp+8JCN4ktiMsJRuHyNHuWrtGJTG794WcKm7EF1NKcU0hTcDQKJAh
         fLWY3kkwhTwyTMib9zbleF73Ft0/bSmjF7AUaBb++Hm9TU020TTKnEHYdc178RMCYj
         GZo8ms8mWEHqw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 05, 2020 at 02:28:52PM -0300, Jason Gunthorpe wrote:
> Previous commits removed all references to the /sys/class/infiniband_cm/
> directory represented by the cm_class symbol. Remove the directory and
> cm_class.
> 
> Fixes: a1a8e4a85cf7 ("rdma: Delete the ib_ucm module")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../ABI/stable/sysfs-class-infiniband         | 17 -------------
>  drivers/infiniband/core/cm.c                  | 24 -------------------
>  include/rdma/ib_cm.h                          |  3 ---
>  3 files changed, 44 deletions(-)

Applied to for-next

Jason
