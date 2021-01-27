Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC303050B2
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Jan 2021 05:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhA0EWW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Jan 2021 23:22:22 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5703 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403977AbhA0ARr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Jan 2021 19:17:47 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6010b1030004>; Tue, 26 Jan 2021 16:17:07 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Jan
 2021 00:17:07 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 27 Jan 2021 00:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaHSHt5ZVKfjbIYsUu6n666SWwlk7+5xnSaLSjX6iivVnf7o4LD6z5vzoUJQEm7S+ml63YUuf1+cso+UOnYz+NIyFj5y0e/T7LHwj+Oje0BklcYuXO0qMTQMVtgNyUuAQJXeggFvSgYWmPKWOKi3Hw+P7pUpVZZ7KmlQYP2x7tk06vGB/Hix4vB00apYnVjwmSdqWptTAr0JZGQZSPGT90BWno8MslbNaSThajeQ6McC8Dp3sMS+ola+pG29QVSEDX1QgmW9ZfNY/sgeVM0lQpDQug/YIlI6CuQ0VuNihtwIT1LDeJyGrPbWRJSE/Y1vmdJ0HQgxZYv0IViG8GWQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PbKEnbGM1MadKXxB5H6c915pRLhi+5F5SU5p92jeKY=;
 b=YJ8+PCxFbzSpdv2tI0SOi/UCgpTTsjgsvho8GtvucjllVaZU5HsWA6mBGScIxo/uHzl00KfJ0KmV6GkzReiUCISY6VPwZvS4Gy+w+Sh2fmt0VRNgbkQQ3e+d/0LDNELxwYJYR/CktYxgsqXSvrsn3s7SAmmMaAzjC/fG8E7btanoVqMk7M6NDpgm1mt3N6X5aioPQcLbMdexOFBT6aSyyJZZgHfNz5oDZFrwt+43uQtR87GKy75fbEhbR8ikR7QCntox0c7XfwvFoHMqTvjfsYtlfxDsuwwLFUSucZP32T2XLKFyFK3d9uQZK7DB2/n/J2ovP5aRcYF9FceKmy5pKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Wed, 27 Jan
 2021 00:17:04 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 00:17:04 +0000
Date:   Tue, 26 Jan 2021 20:16:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
CC:     "dledford@redhat.com" <dledford@redhat.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "valentinef@mellanox.com" <valentinef@mellanox.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Manjunath Patil <manjunath.b.patil@oracle.com>
Subject: Re: [PATCH] IB/ipoib: improve latency in ipoib/cm connection
 formation
Message-ID: <20210127001642.GJ4147@nvidia.com>
References: <1611251403-12810-1-git-send-email-manjunath.b.patil@oracle.com>
 <20210121181615.GA1224360@nvidia.com>
 <CO1PR10MB45162B7BD3F61C91C0867213CFBD9@CO1PR10MB4516.namprd10.prod.outlook.com>
 <6F3F22D0-2E85-4505-9179-2D2699EA2E2E@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6F3F22D0-2E85-4505-9179-2D2699EA2E2E@oracle.com>
X-ClientProxiedBy: MN2PR16CA0038.namprd16.prod.outlook.com
 (2603:10b6:208:234::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:208:234::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 00:17:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l4YVm-007HS7-5z; Tue, 26 Jan 2021 20:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611706627; bh=7PbKEnbGM1MadKXxB5H6c915pRLhi+5F5SU5p92jeKY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=U6iHaXtADyI87oMHX3AEN1BORwyKlGNSyV5xZpoMTvH0RRg89HtqgcN1adFm+1BbY
         NG9bF2d++prD0Vg5nC0v8Pd+0D7epGmeNvuwRMm/zLjSgbQlTwu//BZS0UbDb+EreD
         nhFn6vaqXlWvvAqjVZfeHOhxPATVYbkg9rJ70vbgSR8VBkSGdmY7jE6TOaIwTLMJ0K
         NfKXqJY9uVMGWhvM2Ml+kMKXHGF8IHOg1Dh5M1zSy0JL8omVjlCsAa7p3PziKarrg4
         69mpKPqvTTc50MfoXytVr/fn4PxAU1Avdt2LuW9f9xBc7oeNGPEYXReRLHOAu6TeLH
         9+1uCHXM7J6TQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 26, 2021 at 08:28:18PM +0000, Haakon Bugge wrote: 
> >>> @@ -1122,7 +1123,8 @@ static int ipoib_cm_modify_tx_init(struct
> >> net_device *dev,
> >>> 	struct ipoib_dev_priv *priv = ipoib_priv(dev);
> >>> 	struct ib_qp_attr qp_attr;
> >>> 	int qp_attr_mask, ret;
> >>> -	ret = ib_find_pkey(priv->ca, priv->port, priv->pkey,
> >> &qp_attr.pkey_index);
> >>> +	ret = ib_find_cached_pkey(priv->ca, priv->port, priv->pkey,
> >>> +						&qp_attr.pkey_index);
> >> 
> >> ipoib interfaces are locked to a single pkey, you should be able to get the
> >> pkey index that was determined at link up time and use it here instead of
> >> searching anything
> 
> Isn't possible to:
> 
> # ip link add DEVICE name NAME type ipoib [ pkey PKEY ] 
> 
> ?

Yes, and each new netdev that spawns has a fixed pkey that doesn't
change for the life of the netdev

Jason
