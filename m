Return-Path: <linux-rdma+bounces-757-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5883C3D9
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 14:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCB41F24AA6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jan 2024 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FAC55C30;
	Thu, 25 Jan 2024 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U7gPw+kw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CCE5024C
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jan 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189910; cv=fail; b=hKVGFnO7wQYXm5KJMYxTymvVJC8Ryd2INWVzuZ/4x+yrrbAaRUfOHeur471dUtMDRWTDykdHTCnLzwJer4UoY98YujACvmdOV5i+UO642r/7AIlJ/h6apDBdlh8tS9V6xUGaMzrRW0mAIXEvbNEn2oyci8F6yZGfYrCxFISPn8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189910; c=relaxed/simple;
	bh=VfVWIsYWHlHRDjV/5CKHFV1M5Sv3tRXaJOMxjnBL1gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GaWlr7wipFWuDoCf5iqPDTHaxBbJGMfSC8hW4Gm1+zM7aJcOv2020HG3WcJLFI+0xMzvNWVd/ccfsRoiwZ/KRzUCyHm6PgdcaVhDlBfHajJk3zsLGMVJuvYE9Tt9HQ7jfuA256NSOwHsh1EkI0w0rHOjFJS1IVX0HTGoUsMW0C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U7gPw+kw; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui7iDo78Xp/pBXuYAQJiqeZFaZ9/PAx6I4te8adLcThwyoc8BfLTFJhbFfMEJji+lkDlOSZLU1rOLk3Tvid9xcXzRGyJyl0jaAa6zcIDWuwOMGH2m9SMbpG6CMWYHGs0QarxJFCopXgxKGtchaaV5GDeG4OJEtRrVo2Kh+6ew1vtvi6J96PSwXBPNfsiUeHIGHpGfUTVyWYg98FRBqRHLDw2m3uNahTV9qB0osY6AifaUfwo0dJjhDRiUCo2m40lxTMRYKcWjXN8+JId/eq+pYADH0ezR+9dS8gXhvu61pbAKQI6Z8imxTw5MQT+i4kj1MpT8+3NWnwFkncNfPcLcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEuB9kVVocqctRSzfNXQ3x+Qd/j3W+fp7biENRFJhRE=;
 b=oUuep0kJPGpT+pQE9VRiVPquuFUxVglkbFgodTL4S9Azfc1eCfxluOnNHN2qQeAVjLefSUT+v6oxJMv1vrU/aHzPyJiOt7foEflBpXdlf8ODL4EGX2dKi41BHbhixmFAg53Va5dubuB3oOeqpdWyMOY3sfkOsh1vkXQge5hsLqpzJF+wd3FsdsPcJJh7zZCXHeSQodqoKcw0RNdWlC66d2+pMq4xk2i4fWWl0f0OEcMUVRbuqg7j9KIpB3+iH/Qa/esKHJPKXZE3hRz4to1xe38zsd/1Im64JhBo6UdYPEvsXclfXFIbRo24DWEuNhFzJA8coTY5hztZneL6bjZDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEuB9kVVocqctRSzfNXQ3x+Qd/j3W+fp7biENRFJhRE=;
 b=U7gPw+kw564sD+6kXTp+iulnXbKm4H6T//2qdttBVxe75svB4L9zdEMgpVEKvKSvVulHjt5esD0s1D7tENOz06bOMdZonLWLmVjeyfAiXhFYUSc9yzMyo06NpAxtcKzRe2APz4KfufkAALrCHhO5hg5PUklY0phUfY4I9ouQlfhTLAMvxehnMsKh4Ffe6mZ/+0GyDObk/d4XREwSvnySkSVBIsAAMJLUHoYuYmCoWHjDnXRUoKCkEMKlzF5Bz76TUIOUByzprzAHaAyZmJi2tiCnjteGCLBgSFcvVxd5bCU5w5Z583gH7C+gTnYFxy3vFmsCE/GK/vQyUkgzWXNupw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4920.namprd12.prod.outlook.com (2603:10b6:a03:1d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 13:38:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 13:38:25 +0000
Date: Thu, 25 Jan 2024 09:38:24 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Leon Romanovsky <leon@kernel.org>, Or Har-Toov <ohartoov@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>, Mark Zhang <markzhang@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Tamar Mashiah <tmashiah@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-next 5/6] RDMA/mlx5: Change check for cacheable user
 mkeys
Message-ID: <20240125133824.GM1455070@nvidia.com>
References: <cover.1706185318.git.leon@kernel.org>
 <4641d8f79a88b07925cab0d8cd1ffc032a9115ef.1706185318.git.leon@kernel.org>
 <36037101-dd46-d956-4555-d02eeb04dd0b@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36037101-dd46-d956-4555-d02eeb04dd0b@hisilicon.com>
X-ClientProxiedBy: MN2PR15CA0013.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d50fc2-94c3-4df7-3172-08dc1daae7e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G1PlEgjIYfPofcKyKgXl1IXIfafmlaRuqkO3+sI37USHW0UxSKKdFEbeaq+IkY7lYyYZlxfozPmlULw43R/rEAfnxr7j5M97ZQiugUOWXfGY2RzwTHEMgQ6DweHW6JoUbnOnMrcg+trvU75cZqU5e27V67qXfQgFr3Aq+Svx4uqaBJyIN5gg7e5pNSq9hP2tqagreoU0Ru++V1VQL7AlNolt6469irLwDztzUwOuWqIdNWY+mmMdEwDWr6okPKzNiKsqN2lvBZjFNZxhWV/mXspbIn+VSF8vXWDn9+ssSUNwZS3TkJVa4YJ3hz2/VIxE+TKmWLS7ymrYt8IQMDbgjcX7+eov4UUw7R8KMkfAmTVL5QFpbx2ZirPDj+jY7XSULKBviQDjd+eXJ7KTqsfm5iTbpV4MPhv17Wc7zIABtYmxJfuTFK+aBPyBT3AGV6kBdDoDmvmQWuggacZapy2AjsEFTixc30HKRM8XdAdY69rTReYZIxWNtP1YRUcJcN/XR0SuT2k9s9ThVTS4OKCVOgR1thuYw/hnIbw+Xd6a1dYjXZlveh2wQtngOUgRELVA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(41300700001)(83380400001)(8936002)(4326008)(8676002)(6486002)(478600001)(66946007)(86362001)(66476007)(66556008)(54906003)(6916009)(316002)(5660300002)(2616005)(6512007)(107886003)(1076003)(36756003)(2906002)(6506007)(53546011)(33656002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SHABbeSqIDjGigF8+vA/kGzqQhFKKTSEKwKJlEGNeSPX0uS4GN3MpHdi2h/K?=
 =?us-ascii?Q?cDJ6/IYAomkwMfICuJ75MNWdekTglbjIrYH4rocC41Fux/J657F6rYWYluFH?=
 =?us-ascii?Q?bO0FGuvz4fZoQSCSwgod5Y+RhdwyyXUgbSngErDzJfZGENU8pkcseV20nA6k?=
 =?us-ascii?Q?wp3jGCyPCr5x1PbqtGm0oWwI3aYC9UuYLm9n3iG4wtyafdjdzFCPNgcx43yp?=
 =?us-ascii?Q?Ww2yZy7nVEYJoDq+5lQCaRCPa/+ubMws1MicrFcUqBd4wbMrW5jTP14GoelW?=
 =?us-ascii?Q?wmH0pCMfqNqbMSqXqdWZJCd8cTAHV2P/jg0FBD/26PDf55mXJoLN/mi60k00?=
 =?us-ascii?Q?sht1wbjD9KRQrUAxV1YTkRdDD9NENC332DvvfsKfG6nJkmPKlxFhfoj57ajM?=
 =?us-ascii?Q?VpPKlkCDLADYFEHFi3EwnCTlUerPrzkM4h03mozU5YK7D+o7M7jl18XDH3dq?=
 =?us-ascii?Q?Y+VM4mlCl5wwwJKL+1LB0kqGulqf0xZiFcA1FndHTGEnHPqxpxG+Ht7hAPbQ?=
 =?us-ascii?Q?B5+ggdO+EhUiqDD27Gf3JnHIPJ286k3yCtwwnmy8HxXWxHfu6ORsORtBOVGG?=
 =?us-ascii?Q?pu3sko630RgMFvNETHzqoPEInr3t/dRUE4JkWqP4QNU9s7b3aallHpnlwvjJ?=
 =?us-ascii?Q?QAJSHli1Bc55bqjHxIgmVSuu8beTCOI3d7bvfsomHRd5V281BqMShtgjALDC?=
 =?us-ascii?Q?q2Ok9K9zXd+mwb72H2xRCMLzkIzVSRVXo82F+hfZJAy9xSMLbsysO9zXY8BZ?=
 =?us-ascii?Q?h6UribK5I7+4dyxIQ87p2j1/jW7E5mTYjxOX+db0xZUzW7TV6mjmD+0kZBkQ?=
 =?us-ascii?Q?AkEqTwhJKO8APpcOcgveiZ7z/ajZxAStvSsiJ6yYZcgh72jXsdIFj1SBfnKJ?=
 =?us-ascii?Q?lCesbAiachx7YwaFNOmn69eFaNCBPKLEsMCZinzG90abtUgDFkezYKM6v0Vz?=
 =?us-ascii?Q?vA0/3oebpH06QaVl1yUbGZSQK/tciIMyzSJWcR9JF8aoz9RLbOGSNLnb5Qas?=
 =?us-ascii?Q?kT8nUEBS9yMLhB+TdPJlORnXgMA5XFmw91cmIRO0Bb1CXtccNgltcY0vn+MO?=
 =?us-ascii?Q?bzfe7wF0C036O6AaWnA29Mi5CmwCkPgWmdB8scXeZhU/O/nCWhiNODI45CBg?=
 =?us-ascii?Q?H5PFYB36/epYm1XyIZgriN5I1Z/WJDEcAuNztf3WaYFgI64nHsvKJHbHUdN6?=
 =?us-ascii?Q?aBgxPyAuBAsO3A05vYgKHa+9yNyBfxqLwDvbq9Ab8zBBqiuxqZiNYTI2Y4xs?=
 =?us-ascii?Q?djIdN/AooFoqkfrE5oTdf9IC+Zztxh2XPVhkzB3c3/dnF2+btAPNIoI0tMQ2?=
 =?us-ascii?Q?XDcGp3GD64ifqKsbUfFlvN4aub211FSQ6SjRMGCGTZx/yuqDpcu0IEt0pSHY?=
 =?us-ascii?Q?7furunQ9HPfDm1G7Nxv/n65GAda9if+Tpon1MhZTBB3qDj48vQAERZUOgqwY?=
 =?us-ascii?Q?RDCQ9mwrQ1BvQm5A1LcXPlFeWprO/DbOD84M2YPZehHm/xDL9BN4nhTg3K9z?=
 =?us-ascii?Q?JJLrHb3ckvAqEPU8RpWdmtf6NO51YhJU6mue62ecVdzqPdVPJwwBHWYJ+smB?=
 =?us-ascii?Q?gnCY3rfw1s+NBLgNIeW/AACl3t0YrtSwcYnRhPlF?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d50fc2-94c3-4df7-3172-08dc1daae7e3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 13:38:25.2824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: doz4HSsAUBQOru4jIYvqNRcJX4s5yifgUHDV2dFBRQ8ldhKOmfA/bGKkPpe8Adp2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4920

On Thu, Jan 25, 2024 at 08:52:57PM +0800, Junxian Huang wrote:
> 
> 
> On 2024/1/25 20:30, Leon Romanovsky wrote:
> > From: Or Har-Toov <ohartoov@nvidia.com>
> > 
> > In the dereg flow, UMEM is not a good enough indication whether an MR
> > is from userspace since in mlx5_ib_rereg_user_mr there are some cases
> > when a new MR is created and the UMEM of the old MR is set to NULL.
> > Currently when mlx5_ib_dereg_mr is called on the old MR, UMEM is NULL
> > but cache_ent can be different than NULL. So, the mkey will not be
> > destroyed.
> > Therefore checking if mkey is from user application and cacheable
> > should be done by checking if rb_key or cache_ent exist and all other kind of
> > mkeys should be destroyed.
> > 
> > Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
> > Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mr.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > index 12bca6ca4760..3c241898e064 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -1857,6 +1857,11 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
> >  	return ret;
> >  }
> >  
> > +static bool is_cacheable_mkey(struct mlx5_ib_mkey mkey)
> 
> I think it's better using a pointer as the parameter instead of the struct itself.

Indeed, that looks like a typo

Thanks,
Jason

