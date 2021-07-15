Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B40C3CA4DD
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jul 2021 20:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhGOSDf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Jul 2021 14:03:35 -0400
Received: from mail-dm6nam10on2065.outbound.protection.outlook.com ([40.107.93.65]:5761
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236602AbhGOSDf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Jul 2021 14:03:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyWn5se46YpHxOUlFXueQeg9N9Fal+XAjHwUxm0PwLp4XYLnyZo4xd4AoN7GWv35Q3WOIjsSUJYkKzcYDkFgFwwpbEqOIYNWcANFLvFQiX9ZVThl5VqxjuMJq+CS2g1T7JKErupdfofb16dmJDFhG5bWBuo/O1BV5wCoB4Q87HBD1004hsRl1qgppH/HE3Dvznh6HwdMiQTc77A8pktiQ4fcLHiOglXv2pua717aReGUCK+roKcVlHFEgvY35kwFmeF8SUpOCr3HatrH62/PXjk5FkQ791UYK2dXlxn2ChryIsWzzdevJOba3KXXJx+yyYxM26CSfS0X1FBu4u/7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL6XjyBQWgalKKGdEXNDDW7kY9nyX8LV0cQHnS9qj0Q=;
 b=gfR6LMSq1okF3Q3IVM4dN+2F8SEDmWS6Rq7nbQfLPmvIeis1yq4FlVr1seh9O/667lx3FmZOl0Yy4G2OYJLgebV6hojiYf/7Y6XhlYc0YQGu2jhNn6pWKqozDb3AFCuijRyv1eQsXD+ISQ44jvfoZQebXK9TRMSdjnSiA5aPFH1R6l+77NlGyl0MLvETRSUZeK3JQJkwjLaynliX2Lz/XQIU7DKL+yPYYYqsyewgYSAQjCbumlzloaVo4uE5yvS8zKzJ89UHDt+0D3vCzdmdYS9z9wQ1Evn5qHTGf5vjUToEvCVdP+peNENi0wn+FtLrDOBxDn6y7wI1teKkQ1qCAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tL6XjyBQWgalKKGdEXNDDW7kY9nyX8LV0cQHnS9qj0Q=;
 b=QRwvyGWLHFfVKZ3nGnpFzZh/x5z7sNEFbUY/4FLLrZyMrGMWaL1cmHTl5Gg4ThQBomLv7DI+5sWOXWC6tdnSQTmKgzgQ4UPiDRnTcFv/SHEH+9g01cxpFC7MmGLks8htfLNnATsjQrJaznDbX8L+ZUoKgSnZQkOhRB+FEFZJYOf7s2T6hDkI+Twy5eBqIEyAcH1+hK8XksZCC3ELg6QdTt7x5UNDXny4EKW8aC5DX+vZHjQBC1bQQQYRChHiBIpfmPZoaOjJZvlSIhjBBnD1AmQYNjMemADMmO/Juk+OaytYriVkdcu/DYjL46XTUAkLXtDktc3SOv3DQHW7fAI8pw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 15 Jul
 2021 18:00:37 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%5]) with mapi id 15.20.4331.024; Thu, 15 Jul 2021
 18:00:37 +0000
Date:   Thu, 15 Jul 2021 15:00:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     ira.weiny@intel.com
Cc:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kheib@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] RDMA/siw: Remove kmap()
Message-ID: <20210715180036.GA667398@nvidia.com>
References: <20210622061422.2633501-1-ira.weiny@intel.com>
 <20210622061422.2633501-4-ira.weiny@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622061422.2633501-4-ira.weiny@intel.com>
X-ClientProxiedBy: CH0PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:610:75::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:610:75::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 18:00:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m45f2-002nd2-6Y; Thu, 15 Jul 2021 15:00:36 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a673c74-b743-4246-0bc8-08d947ba7337
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5508FA0B28ACFDA90FE4F96FC2129@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeBINtlq7fUqowcxLPhG6bU1ZZZiyZmF5iRsVi/nGBQUc19Kt/QorssN762nrtJGqCi2/L8h4lPWuqfH7hn+PWVIEXbG4Cazw+X8hETaz3VXVNXHpuv3mbjQn9mzJkhALgBG4zeuwe8ttPBbgwZyCTuXHKePucm+TB8hoDpg5OIBI9sn+GbgISyQ6hxOZy2HwLIV0QgLCasa3jgX2IPr+2SlJV40of+jF2GjXFPrvE4o6j5aUapsgp6Bwbg6tvh3okJqHmycXuQr1DNsQrARufSdAAJF7j2Fj+CGqO3FmnqoEEKNJztdrO+bwHrGgdlBe2nwkoEcml/eIlEQ4uwi0Ve+zA8+rsYaI0+Rmf6wv1Rx0Zqp2AvcYGe1SpAHzsWeOEcTPKEG/4Dgfml2GQm1JGmf9qrTeePkDv8ztaZm19xhdGoYcfA1WRvgYAuuP6XsHXtzZ88AviKNMjVJiI7/UR1Oa1rbKtAR4hxqZLF2JQaSwtIM+Q0yuqzOnWQv1QbYp60YOjy/Sw3FPD6bQUJ7wzY3s/2qS3G+ba7+wjtTvwHuyN7NsUzXNA5C8CqEGzunbZR0Y0P8Xhr7oM33pmzPdd85wqT2il52q8yKbAhNYyNiYulBhc6jjrHCtxfT4He5ILbv/gE3yt/K+wxBUsq9zwN66zUc8zpGYWVQQoQTImwiSSykRB/op8I8asCcuInrGjQ/9U8dWV5pFwnuMTP3dLZaKWpO1oros0umyCNK1DKE+3ktG//XW7nEgSPhB2VXg/Lm7b4QxW5HMQSxCLdzJtAlqLX9Ujw6JlJyWpEoyV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(54906003)(86362001)(966005)(478600001)(316002)(1076003)(33656002)(26005)(83380400001)(5660300002)(186003)(426003)(66946007)(66476007)(66556008)(9786002)(9746002)(7416002)(36756003)(6916009)(8676002)(2616005)(2906002)(8936002)(4326008)(38100700002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1mM+Q61dCrNCJEnFnD2Ipmyw79juSsbZl+xXM/JGMdfqvkFRpsWfvg9Ol4FZ?=
 =?us-ascii?Q?LS42Yz0xsFJHT3gZDx1yVsDi2poXC15YRUAFS28ffQITMTbHF29l260ITEVx?=
 =?us-ascii?Q?nf16TKvkU+F120IaF60Taf3zdiPCvf5C0smiGA6V34vTPE4La2WMkRGwpYTJ?=
 =?us-ascii?Q?zVBNOpMZZebJpdTfXT/dXbjRlxgmS/BRZsd+Zz0IP/auncAxJ4VoVlH+74AI?=
 =?us-ascii?Q?2b/WjT/ARvzLlixCp3nI2ubjvd+E7ZQwT6G8a19ojeMSOgsPHoCKohuZpWye?=
 =?us-ascii?Q?b8xj+7T3gA7M2wduu3ZgSunpqXe5UvrO8x2REZNtBJqFgK45OlE+Dl9/ZZN1?=
 =?us-ascii?Q?h2G5VXdgzkbVzhu0onPX66C6ycgQisg+Db+ge0O5XWftL4ArK+M6R/PaL6hH?=
 =?us-ascii?Q?QP07bI0YDhmLq0ZvQURpAofV68/iq/xuRJC7M0JXP7q0JHX994qYhwJ8a3RZ?=
 =?us-ascii?Q?jZC0VxYoIqKZyO5Nv4CIRHufFTQoIDpzKh2XAizEuP0CagdxuArcn0yRNm7q?=
 =?us-ascii?Q?55nFeHBZQBp3fL2zbzsN2ZEdx74cvhYB9s5Au68uuWHcF0vHzmZvDVq2ATO4?=
 =?us-ascii?Q?PPl3MUdTdEKU7Tb2jLlVCxdUIUT69WrOhMPuqeZ/B33VTj4CfrWdy/HMYxpZ?=
 =?us-ascii?Q?hclwpqXX9tG5ag5Dk29nF/paNaNGnsSrt1YLh4Mv8xILmbY3EPOQYxST1IJF?=
 =?us-ascii?Q?DgMshfhvnzUJtwvtDmi04+QTMIGIrW6FZ+nfeYoBEhhZplumLpc6VFxmKjGH?=
 =?us-ascii?Q?xBQpXfZKCTc1AP5LfNKy/P0r7TXYWxICHwS9QnY+4DvC6nNRVbANuP/x40QX?=
 =?us-ascii?Q?yp/T1vpg6FRKFBYfKZHLn8If56MHAnK/9nlvIsNzdukVKwLuDVYNvjR2Ng9L?=
 =?us-ascii?Q?aicOiASaE5P7lm0xRa/tLYcjb+RjLyXzDSD9onJ1dTqqwIXij3HuV/YFIu/h?=
 =?us-ascii?Q?A7ytif5LUEcTuAUgQwYzoZ25Kp63RxM/8OZQA9x+nXOJRhXIW18yZkvayYKA?=
 =?us-ascii?Q?cRjVBeu/WLn3/1NY6H+bM/f6vfHYuvGwvGcv7yDEj4hxKHma+47X6RoOtK/Q?=
 =?us-ascii?Q?Kz73RfeL4uqrMEhx8fLYykDLFjMgIkzaCHpxM8YjfFmWn1lyEZdqN147uqCe?=
 =?us-ascii?Q?yk8IsOwHpvEdH8KitPfFHayvTz9HZYq9rf4uemud78wirFHN6GJXZ/VeZr95?=
 =?us-ascii?Q?QTnyxj4jA0xqRN8mt7Vtea/kZUVb/0iV5qaVq66yMdxMMa/PV1Xm7CuvZRxd?=
 =?us-ascii?Q?fLO3F5FLh5/bS2KSa2nKrOa7tXzNxQTJj0n3Dc9x5XbWKFsiUEqoP7yIJXnJ?=
 =?us-ascii?Q?8SnfFvY3LFiDuihCf0S9unVN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a673c74-b743-4246-0bc8-08d947ba7337
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 18:00:37.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bq596kjoM5wUPEpL9srypMelpHjzqVav3ag7Zn8B1M/oK3SeTtj6CefmEMtbpEYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 11:14:21PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> kmap() is being deprecated and will break uses of device dax after PKS
> protection is introduced.[1]
> 
> These uses of kmap() in the SIW driver are thread local.  Therefore
> kmap_local_page() is sufficient to use and will work with pgmap
> protected pages when those are implemnted.
> 
> There is one more use of kmap() in this driver which is split into its
> own patch because kmap_local_page() has strict ordering rules and the
> use of the kmap_mask over multiple segments must be handled carefully.
> Therefore, that conversion is handled in a stand alone patch.
> 
> Use kmap_local_page() instead of kmap() in the 'easy' cases.
> 
> [1] https://lore.kernel.org/lkml/20201009195033.3208459-59-ira.weiny@intel.com/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/infiniband/sw/siw/siw_qp_tx.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Applied to for-next, thanks

Jason
