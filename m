Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB9743420E
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 01:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhJSXa3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Oct 2021 19:30:29 -0400
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:10208
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229554AbhJSXa2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Oct 2021 19:30:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gktt5Rh69+JYfWjkTZNbM5W6SXrkJ1BfThqZvgU9CDQpldhf+VZAd8gP/dAUahsqwQI8WQAwmb+Aa9cpTI/rpN9yiHkwuJbZqzuwGWKd1WKeL4BMS3janbVs6TPEvPITE9EJvPro6tZYtuKp4Dmux4Puf2nU3Sume8SNUSzyuePJBQ0QwCQYQ8GADWCL18FjjoT16qDnTxp+v0KiMlagtCY4N10X2MhM/9qpJdvSfYFWfzTQK+xvAZ9iJmOgge04r5le7xfH14ZZEWK+cVbFx1NH1hxdz0Woq1u4owe8hOdxQwy/AuIC6WUG6xfGBEfJXdLkO9MLVdh+uP0JBQSbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBee0pehVk4ng4TTD4jXqsjwpcQ2hk65bQvrqC4pOsM=;
 b=mKxosR2aOOj5GWsa9/VpX2z7IdkF04G4FVuua/YJTleHQ8iEF3s2iRYPzBAmckrXmJaHMuJ3Myr6/HhZQmQ3dNgbqGjEs8wvPlWQXrt+1BwMVraROME4t+JfhNeUtVi7vvmUchFiIYQhBAt7KlTxWK+u2FjoIkihi4cicbxaQB2m+coFsYxynnaOXH9p4xuY8vntmn7lIfZGu3DZIM1fRs1hemXl5oNS3K1jGnvwF/mFJo0VSK9/q35Hd6sMN891uqpxDWqpVWBBz3jtflsuWoCz253YNhfwZkOis5vnObhTNfci4WvKfJAU56HjmW3PiQu5PcxRjh6F216klYItTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBee0pehVk4ng4TTD4jXqsjwpcQ2hk65bQvrqC4pOsM=;
 b=ZUNP2FlTSZRCwZR4+XsxLCZE/bp78Pv9G2WglxjCIvJfv3pwbZUWUmQYuPHOBikmZfg+sMl5UB36Br81rABZPpyvKtAsN3O29flh7Cqln/efLp8HWYHRYt1X62+689NLHGUbMNlO/sQ9LCjL+aIa/zoMShcorpTvaP0UrhdXO5fo7UoegpfFTEFbE2+TaJ/RzSL7LsUoOISWIEoI4aZRvYBTAQXCCPXhIB10Fe0vlgZtXg9leEWKQZRvklGHpKHY5Xuvm+gPf+ifDQNM0pqSk2lqIe2AnN2zglTiby7xVOiQEeF+9VkuDnx7ILfzim0iz2uE5NTYw9xpL/9AoN4EMQ==
Authentication-Results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Tue, 19 Oct 2021 23:28:14 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b%5]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 23:28:14 +0000
Date:   Tue, 19 Oct 2021 20:28:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc:     linux-rdma@vger.kernel.org, dledford@redhat.com,
        mkalderon@marvell.com, davem@davemloft.net, kuba@kernel.org,
        smalin@marvell.com, aelior@marvell.com, palok@marvell.com,
        prabhakar.pkin@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH for-rc] rdma/qedr: Fix crash due to redundant release of
 device's qp memory
Message-ID: <20211019232812.GA4135767@nvidia.com>
References: <20211019082212.7052-1-pkushwaha@marvell.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019082212.7052-1-pkushwaha@marvell.com>
X-ClientProxiedBy: BL1PR13CA0096.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::11) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0096.namprd13.prod.outlook.com (2603:10b6:208:2b9::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.12 via Frontend Transport; Tue, 19 Oct 2021 23:28:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mcyWi-00HLuv-4P; Tue, 19 Oct 2021 20:28:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70f63042-5dfc-4c1b-4737-08d993581ed6
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:
X-Microsoft-Antispam-PRVS: <DM6PR12MB5550C0301663EC28ED8706F6C2BD9@DM6PR12MB5550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YvG6AUohECWxlWUUFmFuGfX4OfO9AE1mjz/XHDHVBB084E6mpXJLpDAX7B1awvwJm3ASPmxMcLC20a5kWcO6n8wGW4FqFVzK9mf7dZFPLnmubc8hWA0CK03d1PnBHVnxm8cJfEMEqW4e3MmpdgfEs9o22MMVjTvStqb8FOnnR2Xk46JGwvUJdvk3MiJh+T3j+Mme+/kE/LGfQgFGI26bv7OI7XefBQY3irXsdbThwq2IelXR0hZsi7gGKhLgmstIiMJaVkckjsj8y+JlOVOz78E4mk9HFd/sVrFju3LBkzaqJVualDwVnM3uFFxg6kRXQEx6+LrXySkt4P62duaTuZDQCebvP6LMucslWg18ENawl7sPtTGQMIOgmh7SFFUPsDaQ1xDHKKes7+fKjVegciUSkkGOzfRN3Fy/uzGi5iEN+HlJ0/JmEwjRQjLcWNESrXvubHkL719A3YqCwdUvN3jFAOIjd/ENc0Qad+FfDFwzNW2aBiDwBXNaYMhffpsUqc+nocWeuwCwDdo+veSBnaoozIFjOkdfOymMxYRCOmKG0W0BBbW0fJX5Gb+11WuF2NJtwIP6zIBUd6xXI+i0Us8kQTucXLFmHNaFE8F5SzIq7rl6uHs9fBdOpeZNCm19vncL9YqEhtyLQ9V8Wlalw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(2616005)(426003)(4744005)(9746002)(9786002)(38100700002)(1076003)(36756003)(6916009)(508600001)(5660300002)(66556008)(66476007)(33656002)(8676002)(4326008)(186003)(7416002)(26005)(8936002)(316002)(66946007)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yHknbJg8AjLWJlE4emOKpoxQ+w8FNMiu6iUqFZe2fII12y000Pq+zw0/VGRV?=
 =?us-ascii?Q?ohpLH9AhuENn6AiFl3PsEaYWxim1nvxQl0bnYe/BBTxpmKADT6QP2+f5vH1D?=
 =?us-ascii?Q?saOZV4/iX4ATYpHWSvVJ85hrbAWWqPhw2MKwzsp1jmOii4v/EM80vEIaFgga?=
 =?us-ascii?Q?1kEZOLEsgOwz8F0679V7uPx1hEnm14vAePUgBWEdi9fuu3CtclgmOaMAosLQ?=
 =?us-ascii?Q?ubAA7liaCgbBqgHmc8P/ELg0Z1Z9hDn9JVA9zZVF2W8cNVrLLv8p99CLVQYP?=
 =?us-ascii?Q?L/zLIvIkV3Jy33awmpC0s2xQooyFlF11W8oGLZBU/ITwaLMWpvaHAu5FwKFG?=
 =?us-ascii?Q?ZvAdqcO1sbjX3TUlX79ItEsriW/z8UeEZPPIs6IXfA8hShL5HDu2v8G9hw+R?=
 =?us-ascii?Q?7xwdYa/uLZEYq4sPJwQYuO1dYaK2UeQBS5L9p/A8Ayor17B+YGWATC6DaFAs?=
 =?us-ascii?Q?ovtkoptNw/4py5By7RqRCUHKX6o7nlTqPYx9NbqGrGf9J7r4haVVyS1cIcGM?=
 =?us-ascii?Q?5+k1xndXmX6Jfp9pFOuoF5XHO8/OirqYQprbIJErDKXdDHurlqvmJ7iWSatH?=
 =?us-ascii?Q?t7t3OhgW5Z/2bwO//gY0SwymPv+cL/cdccNi8iQq33SRcEUqhIn1ACSJjZiq?=
 =?us-ascii?Q?AnfVdP9vzoeMsQCo72byGHL8b01SNOehKKwVxLfrlXAR79Zg82AqXOwimrTj?=
 =?us-ascii?Q?QmRs/E8QMyHXVXIsUMKNqGe7roaLhuSwuA8wxws2kywv87JmLX3jrA87N3Mk?=
 =?us-ascii?Q?qpuB459n5//xNxAjIliopVhIrGVrwk3OSATBf5TF2r91niPx0ygT3XZ99CEg?=
 =?us-ascii?Q?UgxiCgDkOPBVADrpuPv3tvSYhwfyrZrgXi4QrLhmZPsPd0jIjZdR2c6uVLms?=
 =?us-ascii?Q?Hwmd5hJa5pGHcXkUR7eiQIZ92oSQUQF2PteDDbLaGPakqbOMmKMwPz6GAdaQ?=
 =?us-ascii?Q?noiid5nCE6qWaHc7REDLuVcamdrKK4QQhFEtoDJ2PFF5TmZeieVray6MDOCn?=
 =?us-ascii?Q?59M/7iP1py/QyYcf1vd/i4afqxt0lNd8owkcWQNYSoKh58o5EP0m6Duqzv5T?=
 =?us-ascii?Q?8xrEMXPkoLWM068T6lER7+hDPDLlmOndIH1JTlQ5EfCZQHx/3ETLhBbQF/Jz?=
 =?us-ascii?Q?9dm/8bY1G/fgw74wFZPzcSGQPwigpGbJ651htV7lzWF8yHZjNc4JJ5K5XKHS?=
 =?us-ascii?Q?Ar9fmR9VNBwYkPkG47ICZrDSt4ZuAK+ydC61fLO8nHOG+NpzxE9VhPACov40?=
 =?us-ascii?Q?9Q6QUJG9fBLwvS7UXOY6HI1GG65h6V8A2AISFl8HbK05TTt0SooJKR4ySEA0?=
 =?us-ascii?Q?P3/LfSzGZDI7m5aRJVXQXm1XtbJX4vlRMP7XaSzW63w58Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f63042-5dfc-4c1b-4737-08d993581ed6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:28:14.1504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HduNB9htwhwIAJ6ZEqlnuY0fnkHgCVMe/pJreks3v95TBTBXBuv8HHcm1GZIdQQs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 11:22:12AM +0300, Prabhakar Kushwaha wrote:
> Device's QP memory should only be allocated and released by IB layer.
> This patch removes the redundant release of the device's qp memory
> and uses completion APIs to make sure that .destroy_qp() only return,
> when qp reference becomes 0.
> 
> Fixes: 514aee660df4 ("RDMA: Globally allocate and release QP memory")
> Acked-by: Michal Kalderon <michal.kalderon@marvell.com>
> Signed-off-by: Ariel Elior <aelior@marvell.com>
> Signed-off-by: Shai Malin <smalin@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/qedr.h       | 1 +
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 2 +-
>  drivers/infiniband/hw/qedr/verbs.c      | 5 ++++-
>  3 files changed, 6 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
