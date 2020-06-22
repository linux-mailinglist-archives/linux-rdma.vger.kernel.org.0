Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA13203E9C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbgFVSB2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 14:01:28 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10973 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgFVSB2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 14:01:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef0f1cb0000>; Mon, 22 Jun 2020 11:00:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 11:01:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 22 Jun 2020 11:01:28 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 18:01:18 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 22 Jun 2020 18:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2Row5R91QC4oAGx/kDw93Xfyx8CNvfRnZ1EQoLi7jCdLvXrLw9ZCv5NskEPJxTZgh43aBsN8WsA5m5FxcIhM9Opq45AZK32VqxhyRVVniYaXaZ73SmaY0Z0Jd02mqErFNUJJ6MNuHztwZk9tDkjpec927dXErWANA7K5mNb1vNdlrHMfH/KoRydCdvcVjhgFJhNzgTHGI8kdO8yKv0SKzhJd7wnMNnRpiqRuah8eilip0Fn00XgRTQ8vREnt5IduOoG5lM/kZ1X86GtOdtYE5gg9dW/lPBJGxC1SDgUjGn2pGIcVEgG98CAJbdk0Bw+g3tK99u5CCKx/ZPiaHRgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HQpsSA824KEqXYSXPT0FiBBjshqXu3jEDkKm3Iwwvg=;
 b=L8NT4HzvlBf6ZaHG3xoGkp2aJpXdbpZJp3MlakyBxQ18uVG91rlKKgOjX4OLpoclLxePDfkaWUuTIexvcwZQvBAUuyoPZ1rkyNfKN1pBIkeYCCmicf+b7JvMhSYpLy6bKIB17NaZlO/fZ0nqSW6cO563MZ3lL1Z/8kzvQV/16R0wHNN3SPWOdOp3WUuUVlRo8hnxLI5zN2B31ekpuFTrEANfmyKRzVHyKmw9e62XKsKkErenWMS3/2pGCKKG0uoZKDF3fZi/t7jvozipoMa8MhVyp21XjVm2McIr4RjMgAj1/1/9dZwwu+sqGj1AUuXxYH0onWONrHViUDPH56tPVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 18:01:17 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 18:01:17 +0000
Date:   Mon, 22 Jun 2020 15:00:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Shay Drory <shayd@mellanox.com>,
        "Jack Morgenstein" <jackm@dev.mellanox.co.il>,
        <linux-rdma@vger.kernel.org>, "Maor Gottlieb" <maorg@mellanox.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH rdma-next 1/4] IB/mad: Fix use after free when destroying
 MAD agent
Message-ID: <20200622180051.GA2896631@mellanox.com>
References: <20200621104738.54850-1-leon@kernel.org>
 <20200621104738.54850-2-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200621104738.54850-2-leon@kernel.org>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR20CA0050.namprd20.prod.outlook.com
 (2603:10b6:208:235::19) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR20CA0050.namprd20.prod.outlook.com (2603:10b6:208:235::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 18:01:16 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jnQkV-00C9YQ-Es; Mon, 22 Jun 2020 15:00:51 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5baf1662-197d-4b07-f022-08d816d64262
X-MS-TrafficTypeDiagnostic: BYAPR12MB3527:
X-Microsoft-Antispam-PRVS: <BYAPR12MB352706EB6BE99C218104A63EC2970@BYAPR12MB3527.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QASi6Sa//BBtKWACzVkouLJ4wFyV0obk0ZWSq5wKb0yCS7MkBowngN2oGYmdItUj4AQJMm/6S3L/Dm4W5d8rR+ShQ2rvsPN/s9XF/6ndNrOp3lB4o+1vf1uFZch1OvRCK8w4GNhKytJZaG+f8+qaTeRRXw8b48DJb5rvVET6Dnwp3HDvGIx8FsJkbU51yZT6GOsqkelH0qIAXPft7J6IpwNnWhYhfqhFGB97/0CJb8g5BEb6OzfuJEDjyRMfae90s5afpmhtcm4AJugnAveU6dVT3Df2Muhoi1dgSZqwS9OqQWzcOFvNdNGFHkwEVNqFii2mvTf7jpuFPNB6GiYEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(346002)(396003)(376002)(26005)(1076003)(186003)(5660300002)(426003)(6916009)(478600001)(86362001)(33656002)(9746002)(9786002)(316002)(66476007)(66556008)(54906003)(66946007)(36756003)(83380400001)(4326008)(9686003)(2906002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zOOrhGZqnUBt72CwQXkyvIa5bCANdgNiSfpKgMGs0PFRlv3OjKq9skJPMgsLXNIJlYm723tWwaQDbYpAzkvTUyeQi+8Rxt4JRV+nMRYYlSU72/tpWda+rjXxwhsZpf9tpNEIIlDZ6rjFh6b7v1P8YmM95sFY1ESFnoA/C7qUjHHn2U7S9eo/17n1/ghdrvOmKJN04uLGm4GY3tELVgRMDIr3wFg7RixhyzieV+Sbeb2iVvfCBrtF7K74lN1LF2mnv3BC2hynZogUkNRWfftEF6D00x0impHraWuzAq4pQI2rQXTqBbx0YR+N8xz+s26rE3Mjp1zAL70gSc1+WqeU6Yn7I6zlZRefnW5tvVX1OhnThJ2IfUIbYBPY6wnySOwBpz4yfMWF6nuwizPkalXQ5BlG6ZM9Twj5oSB+RPlHECy039i1fhM0rRzyug5OatgiObZs96ff9/IqcUBBe40+w7Fts1XeDJWAialSU52EG7knh1ynwb58PWyL5csOlfSG
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baf1662-197d-4b07-f022-08d816d64262
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 18:01:17.0784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSZLDGXHieTDs6WnxQz+9SmJWjASsHsq/PUEgXDvdLyPX7ibQrd0R5MEniVhHiJh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592848843; bh=3HQpsSA824KEqXYSXPT0FiBBjshqXu3jEDkKm3Iwwvg=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=GfLtPGzcEbqnDn08jrdHOFHmcIWCFmi7PUEVn8Qppd5m95Pzo6u++y7tUZi8oItAc
         sswJPP7iN85TzqTzmE7XF4ks33455k96vy8oeQINeYFcdF24gqHBJC+vTGMeOxiwej
         QTHHfDq1sGk8wvu9z4eR8ku6S5S7eN09Udj42aRQxdUdsWUdhTaWT1IZRkwuzhl4s6
         Wxu65H/HLZ7sdLZwYDngARDFIElII3fBjsuOno/nKQc+rRBDz7HElG6PVkyF4NuPor
         yLjZMKHb+fCRmK/SxGAdfOrxESd9FWZOdASVAdsP0VRxwyO8SIKNh2yZdzWSKULwQ1
         /dEx+5xjDK5FA==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 21, 2020 at 01:47:35PM +0300, Leon Romanovsky wrote:
> From: Shay Drory <shayd@mellanox.com>
> 
> Currently, when RMPP MADs are processed while the MAD agent is
> destroyed, it could result in use after free of rmpp_recv, as
> decribed below:
> 
> 	cpu-0						cpu-1
> 	-----						-----
> ib_mad_recv_done()
>  ib_mad_complete_recv()
>   ib_process_rmpp_recv_wc()
> 						unregister_mad_agent()
> 						 ib_cancel_rmpp_recvs()
> 						  cancel_delayed_work()
>    process_rmpp_data()
>     start_rmpp()
>      queue_delayed_work(rmpp_recv->cleanup_work)
> 						  destroy_rmpp_recv()
> 						   free_rmpp_recv()
>      cleanup_work()[1]
>       spin_lock_irqsave(&rmpp_recv->agent->lock)->use after free
> 
> [1] cleanup_work() == recv_cleanup_handler
> 
> Fix it by waiting for the MAD agent reference count becoming zero before
> calling to ib_cancel_rmpp_recvs().
> 
> Fixes: 9a41e38a467c ("IB/mad: Use IDR for agent IDs")
> Signed-off-by: Shay Drory <shayd@mellanox.com>
> Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
> Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/mad.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc thanks

Jason
