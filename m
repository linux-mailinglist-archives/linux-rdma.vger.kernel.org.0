Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5C15464E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 15:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgBFOf1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 09:35:27 -0500
Received: from mail-eopbgr40060.outbound.protection.outlook.com ([40.107.4.60]:37028
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727918AbgBFOf1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Feb 2020 09:35:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwgcDWwZRD32mMDps33Te0LlcQ7wiajK3pF1I4Q64bi3QaybDJDYvtqutLw1IcJ3h5qSz+hTNIN8V7BQeceRrndyMOZXuKa/Z6s2sxcrSx/OHgMWuGmFmRicYlnjrURA+BsRYCzM5B/lMy7pzbcMVMG5Gd0OrsXQIZavJDtelRCtWCUW/sDpKtBDGgIIFWyVfaJqhwqoQFBilY3B64blRjo5aHXPgrHObbturByT/qkQ1k6MAf3gFVhwp7TcYjXh+OnjezB0jZODs8oPIpGYOzC0K0XKoBSkfOub56eHBEEwi2Zvh+HW8KZXET5vOWu6qsv2xaZ7HfUkYIp+rBflEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4kAMfxPzTvQfHwjGMiM95IjpPHEZyE9ARG2oKE2seA=;
 b=WGCZEfLcV/kQFiVs+UzPO4yceCufZQ7UJjlaf2G11cPy4k+dKhEd2TFd/MIUWDIg5qZeJn/KV4ISURmIkfXS+Xm9iQ/Z0gfXSrPoIG9/VWOJD93qrPN+vWskMqUE5sWwCvCwgsi8XX68hh4wbH8MLBjYEU6wFDx0dHtFL+2pCBJ+/1JRVuDYKZkhuczpd5AHMGDONb5aNIFbSb4ujRjFE9geiQfJPcop/S6HoLmdKiWyWGsjO/Cm67/4l3IhFUnZwUhmX9Lm8Id/djyLjqxxE0Q5pUtD/kpxgOz3ZzS1/Aii81feGftQDa+as3M6tVU+TMLZhV+7tAHSbTKnbrOdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4kAMfxPzTvQfHwjGMiM95IjpPHEZyE9ARG2oKE2seA=;
 b=UB4wxoDFYlIMtM7tc6sXspFoPSnYZJIKqDipQ2pfI8PeRuihvE/PHKCMM5YbdxTJwNUDi/gONUb+KoiHl9jGGFznWCkxAVbThVI/WUTp4H/89OGGi0B9bMRTUGXa7HfgulTQ9yTMOUp2+RRaESCAMX6SzhqapPee/ZhLvu31KR8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com; 
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com (20.179.5.215) by
 AM6PR05MB4904.eurprd05.prod.outlook.com (20.177.33.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 14:35:21 +0000
Received: from AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0]) by AM6PR05MB6408.eurprd05.prod.outlook.com
 ([fe80::c99f:9130:561f:dea0%3]) with mapi id 15.20.2707.024; Thu, 6 Feb 2020
 14:35:21 +0000
Date:   Thu, 6 Feb 2020 16:35:19 +0200
From:   Leon Romanovsky <leonro@mellanox.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: linux-next: Tree for Jan 30 + 20200206
 (drivers/infiniband/hw/mlx5/)
Message-ID: <20200206143519.GH414821@unreal>
References: <20200130152852.6056b5d8@canb.auug.org.au>
 <df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org>
 <ee5f17b6-3282-2137-7e9d-fa0008f9eeb0@infradead.org>
 <20200206073019.GC414821@unreal>
 <20200206114033.GF414821@unreal>
 <20200206143201.GF25297@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200206143201.GF25297@ziepe.ca>
X-ClientProxiedBy: AM0PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::20) To AM6PR05MB6408.eurprd05.prod.outlook.com
 (2603:10a6:20b:b8::23)
MIME-Version: 1.0
Received: from localhost (193.47.165.251) by AM0PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:208:ac::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.9 via Frontend Transport; Thu, 6 Feb 2020 14:35:20 +0000
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03bb7ec1-9b13-4037-8111-08d7ab11cb5c
X-MS-TrafficTypeDiagnostic: AM6PR05MB4904:
X-Microsoft-Antispam-PRVS: <AM6PR05MB4904B0EEC7D5E82F57F90CC9B01D0@AM6PR05MB4904.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(81156014)(5660300002)(54906003)(478600001)(33656002)(1076003)(316002)(6486002)(6916009)(966005)(8936002)(956004)(53546011)(66476007)(66946007)(66556008)(6496006)(81166006)(86362001)(9686003)(8676002)(4326008)(2906002)(26005)(33716001)(186003)(16526019)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4904;H:AM6PR05MB6408.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weE7GGCBXWN92RrX6Q8JNOkObPRRz4J9zXNEBR/IG6MZcvzRWzWbwrlu0crnVQvzGdX9IyQ1f+rV5iEZBzH+XFOrtH0r1UouAnVhA1jHVaotEO86cUskz/d2q8wPRIVP7PWOh5Snp+g/pz6fuuVqn2UxIK2wiqrnsSOPc15trIZhGfGmbzBVjY114Kum0HebSUKMocJMVx3OyjrvBwPwcGxnHQCD2XqduUNHqns2CoPGr3HEmTQWsNI4tb40ytfgmDw7UMZ8PLV0oinjJCJ4hhJ7GSI48SZRA1wgdtzm0BV7jHjfv54+vV/9E1b168nct447v90j4qHc17kMPmaayhWi496BbLIx2ikatpHQZRZ22UeIoxQEVw5O3HmM7gdItjgtfcSn3JaVBR6ho/Ui3fCW4NNvtNp2y5e3q0VnSi9QViv+hHqcfFzxT3z0yiwjvPFvl5rq9XKP45Wqu2l6ESY7KMxlgdL5CSNyCok/DyCEC7dcbcuf9vpTaOi+iWf5pgEvgu551LS2G78a6A+pzw==
X-MS-Exchange-AntiSpam-MessageData: j98p+KKh8L+WDpue832bxERTmDURES0tuqxcYItHQg0trnT7A3ed4QbMcKTwHMqFmS5URb2FpiVLDnNTt0rUqfjwShJ2otsvNHQKjnU8SVIUtvWGrsursDdyvWMnzyzSldLc60FStOWimwUGW/qFPg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bb7ec1-9b13-4037-8111-08d7ab11cb5c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 14:35:21.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/LUdzBWhI5LHiu/Ru3ilPa14lfgFqJ9ztZFSj8foi20zjtnR2fPX0+B3hUOQQDQXQQsxCkCF4MzENUGt/V73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4904
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 06, 2020 at 10:32:01AM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 06, 2020 at 01:40:33PM +0200, Leon Romanovsky wrote:
> > On Thu, Feb 06, 2020 at 09:30:19AM +0200, Leon Romanovsky wrote:
> > > On Wed, Feb 05, 2020 at 09:31:15PM -0800, Randy Dunlap wrote:
> > > > On 1/30/20 5:47 AM, Randy Dunlap wrote:
> > > > > On 1/29/20 8:28 PM, Stephen Rothwell wrote:
> > > > >> Hi all,
> > > > >>
> > > > >> Please do not add any v5.7 material to your linux-next included
> > > > >> branches until after v5.6-rc1 has been released.
> > > > >>
> > > > >> Changes since 20200129:
> > > > >>
> > > > >
> > > > > on i386:
> > > > >
> > > > > ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> > > > > ERROR: "__divdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> > > > >
> > > > >
> > > > > Full randconfig file is attached.
> > > > >
> > > > >
> > > >
> > > > I am still seeing this on linux-next of 20200206.
> > >
> > > Sorry, I was under wrong impression that this failure is connected to
> > > other issue reported by you.
> > >
> > > I'm looking on it right now.
> >
> > Randy,
> >
> > I'm having hard time to reproduce the failure.
> > ➜  kernel git:(a0c61bf1c773) ✗ git fixes
> > Fixes: a0c61bf1c773 ("Add linux-next specific files for 20200206")
> > ➜  kernel git:(a0c61bf1c773) ✗ wget https://lore.kernel.org/lkml/df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org/2-config-r9621
> > from https://lore.kernel.org/lkml/df42492f-a57e-bf71-e7e2-ce4dd7864462@infradead.org/
> > ➜  kernel git:(a0c61bf1c773) ✗ mv 2-config-r9621 .config
> > ➜  kernel git:(a0c61bf1c773) ✗ make ARCH=i386 -j64 -s M=drivers/infiniband/hw/mlx5
> > ➜  kernel git:(a0c61bf1c773) ✗ file drivers/infiniband/hw/mlx5/mlx5_ib.ko
> > drivers/infiniband/hw/mlx5/mlx5_ib.ko: ELF 32-bit LSB relocatable, Intel 80386, version 1 (SYSV), BuildID[sha1]=49f81f5d56f7caf95d4a6cc9097391622c34f4ba, not stripped
> >
> > on my 64bit system:
> > ➜  kernel git:(rdma-next) file drivers/infiniband/hw/mlx5/mlx5_ib.ko
> > drivers/infiniband/hw/mlx5/mlx5_ib.ko: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), BuildID[sha1]=2dcb1e30d0bba9885d5a824f6f57488a98f0c95d, with debug_info, not stripped
>
> You need to link to see it..

I tried to run full compilation but didn't see too :(.

Thanks for the patch.

>
> From bee7b242c2c6a3bfb696cd5fa37d83a731f3ab15 Mon Sep 17 00:00:00 2001
> From: Jason Gunthorpe <jgg@mellanox.com>
> Date: Thu, 6 Feb 2020 10:27:54 -0400
> Subject: [PATCH] IB/mlx5: Use div64_u64 for num_var_hw_entries calculation
>
> On i386:
>
> ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
> ERROR: "__divdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!
>
> Fixes: f164be8c0366 ("IB/mlx5: Extend caps stage to handle VAR capabilities")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 0ca9581432808c..9b88935f805ba2 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -6543,7 +6543,7 @@ static int mlx5_ib_init_var_table(struct mlx5_ib_dev *dev)
>  					doorbell_bar_offset);
>  	bar_size = (1ULL << log_doorbell_bar_size) * 4096;
>  	var_table->stride_size = 1ULL << log_doorbell_stride;
> -	var_table->num_var_hw_entries = bar_size / var_table->stride_size;
> +	var_table->num_var_hw_entries = div64_u64(bar_size, var_table->stride_size);
>  	mutex_init(&var_table->bitmap_lock);
>  	var_table->bitmap = bitmap_zalloc(var_table->num_var_hw_entries,
>  					  GFP_KERNEL);
> --
> 2.25.0
>
