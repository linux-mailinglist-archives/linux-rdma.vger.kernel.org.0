Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB145232357
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Jul 2020 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgG2R2t (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Jul 2020 13:28:49 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:11039 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2R2s (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Jul 2020 13:28:48 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f21b1cd0000>; Thu, 30 Jul 2020 01:28:45 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jul 2020 10:28:45 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 29 Jul 2020 10:28:45 -0700
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jul
 2020 17:28:45 +0000
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 29 Jul 2020 17:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsKttUl9Y85gYn1F4zl1yvUDVdGWYCXcX6G3W6wBwQZ7R/dA/9aZtdthZh/D5sxsXbdyiGN2EiEftnltWIWl3+IkQqUMoKqFMp25bLHdBEmMqUshc2IaPoZFgLaOhno2rdr5XiUDbHZLEvF8D3aQDcQnJg8XVpTS5EIDl3424u4QvPkr82LZlYicF7L+vC0frB1IPBu2iWmp8W8rJs+x2tjqS56N+KM77hkAWg2SaCbvNjZsumkaS2N9kccWZxjsgC0sTyX+nF80TiUDEWFt07P0/kzlHTQIeLeWYJ3je3Jt1NHO2ZcTsuZSfMZYajxtEnqMfi5yvfinXKCVGBgrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdFlqSypuT7/qc2MoLKimM+FZriz78NTpm+yVNjINOo=;
 b=SYZUYcaRWo8VJvTL90wQ1t6bF8mTIqVrO9orPoWReJi0ni7s57EF+OZjSKPGze8XbKuaUQQsQu9InFChQcTswXiPTaTMj5Xe5f9e+YN55cugQ4skddFBeaAdKJAAkO6xiIYfAkJ6kMEjY6DG//p055/EvRgKVo3mYqAnmm/sDnFN7ghUTHJeIecQBQsc7iYFmTW+QH0vfl+6O4jy+CKsabewzIAOsaG1W/K5Q3AlzFURESALH6GKzhfm5UnLhjQzohRj1LVm0xmiiuaK0ylvXAi2BqWJjdplzHWxYUwSKrmgN+ff22TulW0+uoVVhzC7kWKohAhoKUafDM78nYE6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3401.namprd12.prod.outlook.com (2603:10b6:5:39::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 29 Jul
 2020 17:28:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 17:28:43 +0000
Date:   Wed, 29 Jul 2020 14:28:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
CC:     <danil.kipnis@cloud.ionos.com>, <jinpu.wang@cloud.ionos.com>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <leon@kernel.org>, <bvanassche@acm.org>
Subject: Re: [PATCH 0/3] Number of fixes for rtrs
Message-ID: <20200729172841.GA255468@nvidia.com>
References: <20200724111508.15734-1-haris.iqbal@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200724111508.15734-1-haris.iqbal@cloud.ionos.com>
X-ClientProxiedBy: MN2PR15CA0051.namprd15.prod.outlook.com
 (2603:10b6:208:237::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0051.namprd15.prod.outlook.com (2603:10b6:208:237::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend Transport; Wed, 29 Jul 2020 17:28:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k0psf-0014T4-48; Wed, 29 Jul 2020 14:28:41 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7bbc507-7112-4efe-421b-08d833e4d713
X-MS-TrafficTypeDiagnostic: DM6PR12MB3401:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3401086627F6E9B1BB8B8547C2700@DM6PR12MB3401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zutmINqQ1MtWYFIC1kEyjylospIFU5hrD4TU1NdOgGUwVra1+u7p+pzoDHYw4VvMDxNgS9AzZ9bblCLtTtSh4LuHOvD3LwATLPCu4cZusbmQHs1A/pScTz36ImLD5GaOoaLTqCj9ScRYJrJCKXiVVT+boOP8HEAYFY8GMBFznb7/m28k4QVuPj90ak1TaigVBhRphSlVMKnP1EhN7XLln1CDqrW6W2px/tZ2kzH8EqH+kzY0iBwNEbeJ35DYWAi3mDFpMXiZ+CT9EbqeuRg4bHD6K63btntt3f+WkcNVRWv7g4G7n1gX5ecPHlfO22I/VCnUo7EVG0e5qKFeLXUPqvIGf8qwaANNPjC4rvcACAs+7qvE97+w0Bdp7jNCwLtI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(478600001)(5660300002)(36756003)(66556008)(66476007)(316002)(66946007)(9746002)(186003)(2906002)(426003)(1076003)(4326008)(2616005)(9786002)(6916009)(8936002)(86362001)(33656002)(8676002)(4744005)(26005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qnus9UciYKlM1BfiNCWNtVQ+iWL4JS7C2kUdtfSRVUhJ0CeABiP3Na4noPEj2P06naaQWiTy67jMDpk3VOCeKZIaKIN91hsCJl0RIqwJmmgENqa0CBfM8EdUDMzfsC2WDgYB7CA+e8dicpXUcLUGwIMMFFwEh/TQUJ408L+/gfCA1L8S2kxYF45DWOX3Jk7/HuJWJ/0jobDDBbMByk17MRY5XLpi+6izWrRrznxAuCGG3tbS1+7NsvAXAam5lM6Xoko9fodzRXkpvvtrDQZmIPQJry3o/YCFiO1TDMp85q9nJ89OYGnft8OXB1pGVaJH2H7bKo1Wq+oI8/Hz2LhtFji9+8t+Hb+BmakTxHiKdbBlVg1doac/yOW8aSN3fajLwQf2F51MO9J9x3kve4xTBpLlAWw4auyxB3QJVZNuUdBULr+CW4VxuS0JmUFnAR6ZU1fAJDuopqZURnLGlW7P3615KmqjQn2AzGJqost3BR0=
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bbc507-7112-4efe-421b-08d833e4d713
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 17:28:42.9357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBldxC1TAi5GK3PcS1E8O1tTo7+fbP2ZOtfdhn3nGm9EqFD/hEGxJOdiXYN+buN6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3401
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596043725; bh=IdFlqSypuT7/qc2MoLKimM+FZriz78NTpm+yVNjINOo=;
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
        b=C58u3rY/j/5vHY1c8pmYWbl/g9IhzmJzjclM4b4CNT1szbxSph+jDA7zRkcKjBobz
         rt6wAvVn0YYYdEtcWs+wNGAK0kBzaD+pl0T03GWn352jqCOjx00S5yofwPTpWoAPTj
         h72KHqC3z2flb3zuI1LLuEBeimFRCl4JT6CL1KpotiLjPnE6vg1pKTzb38NgTk8jkd
         iI+zQtB6TxbrsqQOWukUvtpCZ4H9QkjAODWeJA+4py2SI441xvssMxDvd3qHejidUU
         yuju5zQth3Hce1xb+bQQIqY07dxzuxvq/NoSVFTTU84li3ueis/IeARJQUURQmAG/l
         3VvsM8OOdkg0Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 24, 2020 at 04:45:05PM +0530, Md Haris Iqbal wrote:
> This patch series fixes a number of issues discovered while testing
> 
> 1) RDMA/rtrs: remove WQ_MEM_RECLAIM for rtrs_wq
> 2) RDMA/rtrs-srv: only call put_device when it's in sysfs
> 3) RDMA/rtrs-clt: add an additional random 8 seconds before reconnecting
> 
> Regards
> Md Haris Iqbal
> 
> 
> Jack Wang (2):
>   RDMA/rtrs: remove WQ_MEM_RECLAIM for rtrs_wq
> 
> Danil Kipnis (1):
>   RDMA/rtrs-clt: add an additional random 8 seconds before reconnecting

Applied to for-next, thanks

>   RDMA/rtrs-srv: only call put_device when it's in sysfs

Needs more work

Thanks,
Jason
