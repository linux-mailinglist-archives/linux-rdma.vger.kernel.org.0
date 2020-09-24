Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD52779A7
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIXTqX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 15:46:23 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2919 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIXTqW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 15:46:22 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6cf72e0000>; Thu, 24 Sep 2020 12:44:46 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 19:46:22 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 19:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIoJpqIBOBEzAf1MbTjbaR+pkWnvoY+cp4F3Dzjdn0qsaeh4loIbfy+bFKPmSysbaiaejZ3lNct+L9rvLJaaBmvnK9CtlTv1oXUoRUG2Q0L93I90M8sHC4ScdRmLbVWO0fwEp7ZJHlrRQTOtYs+1fk4C8V3tQABxr10B/IwYNgoY83fQNYGP5wbCi8tdwpi33kQysbudsJ7KVclTl8BRFWQEqBne4ucxPi8uCaLRmVIK0VG5PzkPAh+l5G7bb1hxvZX+a5AGnaoR2bid/PCbctUCpVLpCSckfIpvlqarD8Vy8tK9n7bqNzsfiZUYWiu/+P3+wkUTGWWHe9Yoxxn31Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6yj2cNhBYqxZCzV71tlw+abs3Zt9zgqcZ9WdRmdRqM=;
 b=XVV585FmoZUHOe1wJYVfsq6D5mMwqZHZkZtZW1yB9QxowxD9Ng61x4qQpY4S/50/Xk56X5eigd083wOU3usCjPe6NzbEmiVlB4uOu9XUuZSjcw8oX2P3DOdi5in1MjssaQ4JOiAUCpcgQ++ayDu+cqi/rCcBKw08Q/oskLUqSTjKcYeC8hVNMeoIGnTsHuy6DGShrIIzxeMnaDa7dSGSXt5Bg42tzhPus1utMnIDCAd0d5v74t24+h2oe4E1S3uT6WjzwDyAj4d4kIzynZNjFDXlpvENjycjD3Po/3jXaFJZgTYJwRvVRweIEzD6BR8lDsIhKH5qWXOgoVbfLkrcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Thu, 24 Sep
 2020 19:46:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 19:46:21 +0000
Date:   Thu, 24 Sep 2020 16:46:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2 07/14] RDMA/cma: Be strict with attaching to
 CMA device
Message-ID: <20200924194619.GO9475@nvidia.com>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-8-leon@kernel.org>
 <20200918232619.GA450933@nvidia.com> <20200919090340.GB869610@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200919090340.GB869610@unreal>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR01CA0034.prod.exchangelabs.com (2603:10b6:208:10c::47)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0034.prod.exchangelabs.com (2603:10b6:208:10c::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 19:46:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLXC7-000XbV-D5; Thu, 24 Sep 2020 16:46:19 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a2442a1-a42b-4522-1b71-08d860c282a3
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-Microsoft-Antispam-PRVS: <DM5PR12MB244034748AFE2594B0225D0BC2390@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6668RBXdhyRSHBBi7Vz/P969qY9gj+yrJfRfuiRI9X7PoBqupQ42c7MsTWvQwR+0FM37VgB1sxW8W/UR2oEVeQicwfoIhuRTh/ZAn8slvE43iZn9KLMr3onnC+tCAgEgzlwEpWfyMIWW1Lk16KvXYkYGzRQbfm1INMHmPdGwIFV+tmLrsuHth/mPREQzHCmqyGwrYx51KaCztyxQWnKmAbTmA4yTRoj1+2L0PZKUNVtKqS0k3EytxlDTgeIwzTYrCZ2kJPLUt+QdsJ7EX+uU8NKmF1YVXhJgVRw8UiNVZpQ1q5o1xIz9Vvsj88MF7Skd/n6b178iw/j1pRl3V549sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(186003)(66946007)(2616005)(316002)(66556008)(36756003)(66476007)(9746002)(26005)(83380400001)(4326008)(33656002)(9786002)(5660300002)(8936002)(6916009)(478600001)(1076003)(426003)(86362001)(2906002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 301cU97RuiUjQeCj3cn0zaNpMgVX2S2F0XoLNJZNW4zYcnFAhisYq5+QiSb+Uh28mV0QGOjC1bPh/v88vaG7QJfAxwapy5P5D426eIC6EwwBwdrXKq750mjV81x+6uj+Iec8vEJvq+Mtg/d0Gi7fBxmq662FCeXJxUpZpiAv+BeFvKwB+0bZrEQYEavrQf3S+xZRiBGWYXw2mBdrbIH4ZxI2EPc11o8CifW8As5G+K+KvpWeSb2wtT2idDzpx+ml7CE3LJsU/3jzKo/rTVAQn6lGtJ5GVRz46QQCb9frh9dczdGMuPkdSZpxthZXgiXLlzWKsJFWr2Np///a1+OiD8sNlx5D67ddmBdS2SFt3aIjpoWGUcIKg82KhYw6D84Z04uzEcw9dvF8AzlOD0RD/6JewAF/uer+CDP1R8QkwVFzMRJThgQQrUreTObIrDX9WlrqVX8x3z3mIKkHTDPUrZEVZV8L964Xrv45cMKD+GZtJAnfq90Y+VVgmwxnsZUY+pHPA/jXRc71yhj7+YmPmXoGxFJ8K1X/CQ1/hf4ZudMEsblNrzPOd+4sH1VMhEWvOOi+tMyXqmleAWO1tcn9lgI9OMf28clRKe6kPwO22pc31Gi2ttCJ72AQbrOjSiEvd48HNiRRNeqrvH6KlCmcOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2442a1-a42b-4522-1b71-08d860c282a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 19:46:20.8612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WbvAKfGUub6o1tBAiVBRM5X7mwxUcNjB+JLD10g6NBE0r1Zbqr8TIRY5+GKmzCx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600976686; bh=N6yj2cNhBYqxZCzV71tlw+abs3Zt9zgqcZ9WdRmdRqM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Supu1dmXv+N5gxsKnXiRc6II3heWcb3/9aKyvoPwuLpYqBl+awmA3ujfcrHi03jJp
         yTqMsjx0imXmlrhnTazFbckinwvt5ssLscVjcdWFiY6Lh2hwWfSKBxzb6u35x3tEcJ
         8G2HdysBTgFF22rhtKxFCpJN2dGfm6wVi1Z3smL9IPZ6aOoy9W1IsF1PRR6sYwm3xM
         sWXrMy1DMkY4UFKfsciPx3XIx4ZXo3EZ9VPFhpdgccxAVVh5fspnzfOoiy8awOTHMC
         ImQ7fk51na3Op2a11SIszGX7WR917JlJbSOLFdO34LHTl1h4rdkWw+LAb10daHuS7r
         P/1Y19b13miZg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Sep 19, 2020 at 12:03:40PM +0300, Leon Romanovsky wrote:
> On Fri, Sep 18, 2020 at 08:26:19PM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 07, 2020 at 03:21:49PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@mellanox.com>
> > >
> > > The RDMA-CM code wasn't consistent in flows that attached to cma_dev,
> > > this caused to situations where failure during attach to listen on such
> > > device leave RDMA-CM in non-consistent state.
> > >
> > > Update the listen/attach flow to correctly deal with failures.
> > >
> > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > >  drivers/infiniband/core/cma.c | 197 ++++++++++++++++++++--------------
> > >  1 file changed, 114 insertions(+), 83 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > > index 3fc3c821743d..ab1f8b707a5b 100644
> > > +++ b/drivers/infiniband/core/cma.c
> > > @@ -458,8 +458,8 @@ static int cma_igmp_send(struct net_device *ndev, union ib_gid *mgid, bool join)
> > >  	return (in_dev) ? 0 : -ENODEV;
> > >  }
> > >
> > > -static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
> > > -			       struct cma_device *cma_dev)
> > > +static int _cma_attach_to_dev(struct rdma_id_private *id_priv,
> > > +			      struct cma_device *cma_dev)
> > >  {
> > >  	cma_dev_get(cma_dev);
> > >  	id_priv->cma_dev = cma_dev;
> > > @@ -475,15 +475,22 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
> > >  	rdma_restrack_add(&id_priv->res);
> > >
> > >  	trace_cm_id_attach(id_priv, cma_dev->device);
> > > +	return 0;
> > >  }
> >
> > This commit message doesn't explain this patch at all. This is adding
> > a return code to _cma_attach_to_dev because some later patch needs
> > it. This should also be ordered directly before the later patch
> >
> > > -static void cma_listen_on_dev(struct rdma_id_private *id_priv,
> > > -			      struct cma_device *cma_dev)
> > > +static int cma_listen_on_dev(struct rdma_id_private *id_priv,
> > > +			     struct cma_device *cma_dev)
> > >  {
> > >  	struct rdma_id_private *dev_id_priv;
> > >  	struct rdma_cm_id *id;
> > > @@ -2491,12 +2500,12 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
> > >  	lockdep_assert_held(&lock);
> > >
> > >  	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
> > > -		return;
> > > +		return 0;
> > >
> > >  	id = __rdma_create_id(net, cma_listen_handler, id_priv, id_priv->id.ps,
> > >  			      id_priv->id.qp_type, id_priv->res.kern_name);
> > >  	if (IS_ERR(id))
> > > -		return;
> > > +		return PTR_ERR(id);
> >
> > And there here it is fixing already missing error handling, seems like
> > it could be two patches
> 
> I don't think so, it is "visible" only after I changed cma_listen_on_dev() function return type,
> which is an outcome of _cma_attach_to_dev() change.

If the first patch adds this missing error handling to
cam_listen_on_dev, then the 2nd patch adds new error handling to
_cma_attach_to_dev() it would be much clearer what this is all about.

Jason

> Thanks
> 
> >
> > Jason
