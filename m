Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7415242C841
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Oct 2021 20:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJMSET (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Oct 2021 14:04:19 -0400
Received: from mail-mw2nam08on2073.outbound.protection.outlook.com ([40.107.101.73]:9537
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229967AbhJMSES (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Oct 2021 14:04:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daOhCjwY9lil/B3nVqmilPmNqMGlcrn4yB68qbKHIGRdFdjDlza/wQsqvhgupgbknXqFvm07i82CdH+/YSMt/96KrlBzNt1LcL8tmdoBQasUhvg8vqiEzVxXJjU2js8ZzX6whaPRoGYV2CF4l5RiZb5Yb57QdO1VCXyjhZE/Mo9W2NCUbnFoeCQ13VLmcdHkkz7p1FZK3CffxiCfZN8eg2tqZU5m45A34A7kzO02P1uIWmkeqZuKRpw1URCQb2VchZspY4xEV6H/yz2Qx7Kwr1hVEaJKELXGmmYgLP52QmHEGXKc7M1lqZxn9buUcw4b+48Hu/6DuLkueOd1lDwOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IfhtIToSJYQsLenmsUyORadkXbuHCgrO41x4VC5PfM=;
 b=mdgXnM+pDFcI5MKE/tu+gePk6XuSVwKwk1NcuZqZXnSKTZpjqAc8ngPqLSeFn6Mtd4P91+DH2CS6bP5WubpQMNkfk7pntezWKuftl41NfsQ0AzTMBSzAl9TPQ/brqrfqCsFnCDhxGzKmQuieljEkvGt9Z4QXm6FL5BLFLHq269B2YM4tvzyXNdoxQhWjVXRL5gLDSB9vOT5KcRQmN8jRnh9vtkhlY7UhQHczmegZ5VVs2xJtmU/S5HQEf1rHiuy+cECn+yYxJ1sI+RuG7ywh2I6hnTi+ok3MfjXUkcXHc4HffLFKDdq7ZBSkoQrTjLmxzJwBS7/QWFjWsaa00J4fng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IfhtIToSJYQsLenmsUyORadkXbuHCgrO41x4VC5PfM=;
 b=ALevIxI7Fpbh1aSMjTmU/IktIBcCva68ulLnOuyOyQNe/3ai9LwmS4VGu1NjNSv0iicj9UH4uUHJvczrkEAYBvYlNUp6iqXMLle3PCv0QMamhxBP2pz3i75VOk07Xl9/HoGI1R2Q2lIiKB1XwOOzUsc+yL/qki1LklYnGQWkg+vdz8wtaZjwscX/irNLP0frc91iSmUsgJI4VQQpTHShX/nMDGmLU2xVUZNp4nw9pYSeeKvkNEYBxFxyxySJjZfKq5drVER0yhT+NCJo3siOp8uB7OPeCi2+DrvkuwHtrG3MM6IkoZop3in7z343h/hJNumbydNkAshai8QPQ59vlw==
Authentication-Results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 13 Oct
 2021 18:02:13 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%6]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 18:02:13 +0000
Date:   Wed, 13 Oct 2021 15:02:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>
Cc:     "leon@kernel.org" <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/mlx5: unify return value to ENOENT
Message-ID: <20211013180212.GL2744544@nvidia.com>
References: <20210903084815.184320-1-lizhijian@cn.fujitsu.com>
 <20210928170846.GA1721590@nvidia.com>
 <a7e08316-221d-554b-b853-7f58a7fcdbd1@fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7e08316-221d-554b-b853-7f58a7fcdbd1@fujitsu.com>
X-ClientProxiedBy: BL0PR02CA0074.namprd02.prod.outlook.com
 (2603:10b6:208:51::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR02CA0074.namprd02.prod.outlook.com (2603:10b6:208:51::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 18:02:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1maiZw-00EcQX-MH; Wed, 13 Oct 2021 15:02:12 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 395663d7-dbcf-4c4c-b933-08d98e7395b0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50641BB13307F464BC9A5648C2B79@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNrKhvvsvqVcYeftx1Kp2c3sAiGiMU/SylVpWoCFF4/I/c5GgS19XjRE9gnCl5DLY+IBgGQTV8UlCBd4MpeoP+8E/9xZUcY2CvOEANaXXbI6WR7YmTCwABO9M0Rj8mJX9VZWimQrt9lID0ubZ8R0B9lEmW0Sxgzmq3NjffXVg0Xi19lxCAMxhUUEOA8rSi+jVyq7G9k2d7YHdT52i2xS5HH2853T5p/qTHE+RIPLuFbh2pdMIIeBbn/a0PG2xhNBfkOavMOtjyk7Z9yuA7z/HpBGdyD+KWJz0pm6IhIJHAMgY64CzYG2vIIcrhUBm5nefKPPUU7awxSicjZt1F4//6VYIexnJAwk0o2kFEZrkiLG9AOTBtFNFkwv1f+5GqX4ivE6xbRNBeUPCAIXdc8+p57+wbG990s8OK15phh7fluXXXF5xmmlgxTptJ8NDpoGARWZELzhS+QEiE7Yt0dblQVqktwNtpeV1yXIBEH7z2nUji4LXzNBe+jEWyeWVKo8ryexOyRxVyhqO1f80INyrq0NX+v/cTslhlOSxETGi2l2wSdB44KIh12sS/Oe7QC+j/PGGSkZdK7cHwbeUgVImDQI4ozCuGfdlFPrJOvA9dBZHrm7t6CHlwTwIVxzAOTk0ycarZHRS0ZFOD+nxcjdRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(86362001)(8936002)(186003)(83380400001)(2906002)(38100700002)(66476007)(33656002)(66556008)(53546011)(8676002)(6916009)(66946007)(54906003)(26005)(9786002)(9746002)(426003)(4326008)(2616005)(36756003)(1076003)(508600001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzFGUWxtdDA5Ly92Y3lsaVNjMlhHNGFiM0RqbXJjODVCMXdaNmpvbjN0ZjVZ?=
 =?utf-8?B?QiszZGdqcnhoV2I3MDF6TStOVHRmZ0FOT01ubjVvT1ltb3pyTHBhU3hJWGRT?=
 =?utf-8?B?T3ZZVkUxd2M0aUY4UE16aHN0NXN6VmFlMmREU1BRK3F0Y0JpdUJIWElvYkdi?=
 =?utf-8?B?MWQ4dUZybzNZcHhFTTRVcUEyV1VheVVGMXdnR2UvMWNjNmlxTitHdFBoak9E?=
 =?utf-8?B?andyd3QrTE02UHNWV1FOSDhuNzNEZkdKNmNBNGkzTjV1c0didGhsQktUeDI5?=
 =?utf-8?B?Tkx5TU9NcHhMVkZkdWhtb0JUSFZGd2hvZVdrN0d0dWhoY2FFbDdMMVVOcTZm?=
 =?utf-8?B?UmJjOWszRGlGVWJpYVRVZndpMko1dE9XaWpNbzFya29FVW5TeHZZbTZsWnRG?=
 =?utf-8?B?MWJ6WWtQVW14dkhDdENyMnc1MnJ2MksxcUptdk5aU1YzNDEyWlVRWld4b1ZV?=
 =?utf-8?B?QXdYVTZaaFgzVGRya1phSklqWnRsNmduclhuQkxOTTBzZlM3UU9EUVY1NGxM?=
 =?utf-8?B?d09sZFR4cmdLb1hRMDZGbWRucjF5UDhWcDBqTE0wN055cXVjWUQ4bzJ1VUFv?=
 =?utf-8?B?ZjBEY1FoTTFZWWZqSDA0T2xaSWdlZ1o3MEwzMXBncWlRRHJHK3Fha3hOYTh0?=
 =?utf-8?B?NFBUL1BZRGQwNW4xajJaNTdUVzIrSUJBWjZmaktwK01pNDBoajBSak5aWmV4?=
 =?utf-8?B?MTJnN1ZjTlRXcjMxalhCQnBNcnZPcHpWQW51bmNCWXl6eG1MQ3VFMlBYb3JH?=
 =?utf-8?B?SzBCRmt4aWtydnlKUXJqbTg4dTRGUm5aaVhQb0xHeWZlTmlpc1E0OXdQNmZp?=
 =?utf-8?B?enpEN2RNNlIwY1RpNGxaQlJvSjQ3NFdkYURVczNiaFhDeStTK2RPclkvZ0xD?=
 =?utf-8?B?OHFHODB6ZGRDbStnYjRNT0ZhRWV4RmhpTStjdTdVS0s3Wm5qSEJmcFplcXNs?=
 =?utf-8?B?cm1nSkR2dXlnL2Q1SVp6alBKRzNnSzE0elB6S3o2K0lVb1phUzJ0eENxbTBL?=
 =?utf-8?B?dXBEbWFzUzd0Y2o2dTFuV2hhZkpicXhtbks4QW9vcDNadHhHTW9oMFdWUEJH?=
 =?utf-8?B?SE5CTEM4YXRWdXFNZXAwMzF0MnFzM20xaTNaMG40eTVHN3B3WjFCOEhsaEQr?=
 =?utf-8?B?M0xXcldQQjMwTXljeDg3blkwY0hDVm1SM1BnMGxPTDJKTjBPcWdHdmlqajBr?=
 =?utf-8?B?cUpoTWRQbmhqZlY3TXN6SFByRW5ZbG5hL2gzYzF4T0F6TnJYUUxxN0s5MVds?=
 =?utf-8?B?V21VYTNDd3VkblR2Qzc3RE9hQjdXcGlmdnpMVGhTMi9ybC9jMjBDd3dhaVds?=
 =?utf-8?B?NXlFZ3BBeFUvRmdMTDYrZU5TKzcvQzgxVFBSK0FKS2ZYRVNYWkU3d1U3NjZ3?=
 =?utf-8?B?S0RiUTJqWXZVMGVSUU5lSG1PUTdOTXIxOW1hSW1hSWJSNkF1Q245VUd4dHpm?=
 =?utf-8?B?TFNnNFEwNzZaVVZZNUhWZHRyU3JhOWVNN0pySStmSlcveHZ2R1pFbTR1T0dE?=
 =?utf-8?B?cy9ucG1kb1lTWFVPcUo2Mkg5UDB1UWx0b29kYmlCWGVQZVAxK1RlMjZuRk1r?=
 =?utf-8?B?Y2NqRVFiK3ltYzBiQ1BqVjAwb3VZOG81RzU2UjRtVEkxeUlWSFdNekpKbCtN?=
 =?utf-8?B?eVZhMk4weTR4c1piM2RDdkVNdTdDZHF5RUhsdlJrZFk3RlBlakdDcTRjWk5o?=
 =?utf-8?B?a2QvblY4S2JMWEJSdWtNclVzVEVJb1oxUG11M01VQXJUZzh6TFRQUWdzbEQr?=
 =?utf-8?B?L3VjZjA3d05nS1ZJZWs0bHcrOUlqNndMMlJvVE9GektYcmhRTkovRWVqeVBj?=
 =?utf-8?B?QmZEWitTTXF1M2d5U296UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395663d7-dbcf-4c4c-b933-08d98e7395b0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 18:02:13.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CXC3hT3lsygf7r0txfo36k3NIY3mCF8RZX7X8nGzSrBZjig7CPxxZ6Slw8p/ajHL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 13, 2021 at 07:26:49AM +0000, lizhijian@fujitsu.com wrote:
> Hi Jason
> 
> When update the ibv_advise_mr man page, i have a few concerns:
> 
> 
> On 29/09/2021 01:08, Jason Gunthorpe wrote:
> > On Fri, Sep 03, 2021 at 04:48:15PM +0800, Li Zhijian wrote:
> >> Previously, ENOENT or EINVAL will be returned by ibv_advise_mr() although
> >> the errors all occur at get_prefetchable_mr().
> > What do you think about this instead?
> >
> >  From b739920ed4869decb02a0dbc58256e6c72ec7061 Mon Sep 17 00:00:00 2001
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Date: Fri, 3 Sep 2021 16:48:15 +0800
> > Subject: [PATCH] IB/mlx5: Flow through a more detailed return code from
> >   get_prefetchable_mr()
> >
> > The error returns for various cases detected by get_prefetchable_mr() get
> > confused as it flows back to userspace. Properly label each error path and
> > flow the error code properly back to the system call.
> >
> > Suggested-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >   drivers/infiniband/hw/mlx5/odp.c | 40 ++++++++++++++++++++------------
> >   1 file changed, 25 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> > index d0d98e584ebcc3..77890a85fc2dd3 100644
> > +++ b/drivers/infiniband/hw/mlx5/odp.c
> > @@ -1708,20 +1708,26 @@ get_prefetchable_mr(struct ib_pd *pd, enum ib_uverbs_advise_mr_advice advice,
> >   
> >   	xa_lock(&dev->odp_mkeys);
> >   	mmkey = xa_load(&dev->odp_mkeys, mlx5_base_mkey(lkey));
> > -	if (!mmkey || mmkey->key != lkey || mmkey->type != MLX5_MKEY_MR)
> > +	if (!mmkey || mmkey->key != lkey) {
> > +		mr = ERR_PTR(-ENOENT);
> >   		goto end;
> > +	}
> > +	if (mmkey->type != MLX5_MKEY_MR) {
> > +		mr = ERR_PTR(-EINVAL);
> > +		goto end;
> > +	}
> 
> 
> Can we return EINVAL in both above 2 cases so that we can attribute
> them to *lkey is invalid*  simply.  Otherwise it's hard to describe
> 2nd case by man page since users/developers cannot link mmkey->type
> to the parameters of ibv_advise_mr().

kley is valid in the 2nd case, but points to the wrong kidn of object
to prefetch, hence EIVNAL. Eg it is a MW or something.

> >   	mr = container_of(mmkey, struct mlx5_ib_mr, mmkey);
> >   
> >   	if (mr->ibmr.pd != pd) {
> > -		mr = NULL;
> > +		mr = ERR_PTR(-EPERM);
> 
> EINVAL is better  for compatible ? since man page said EINVAL in this case before.

Referencing a valid lkey outside the caller's security scope should be
EPERM.

Jason
