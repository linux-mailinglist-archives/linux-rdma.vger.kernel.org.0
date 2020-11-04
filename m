Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F962A5AD7
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 01:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgKDAAY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 19:00:24 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18825 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729763AbgKDAAY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 19:00:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa1ef170003>; Tue, 03 Nov 2020 16:00:23 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 00:00:24 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 4 Nov 2020 00:00:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlntbAxWeJwRBUAFCmlJquVRdgaSkjcfebEZBYT1PZOVRh4sQcSFWxioR6e9P9CNIbH8yls1Uep//iISbVA/+R8BuJs2BSHCAImEav55bIOCx96WmmHTRgHEGto8f2na2kSzr7arUl/n5aJ0Cn69ZfIzgYW+15AGSqHQtO7fpo6MQXlNkLIZYJIuhw/hG63ZY/q/1ESYcSsvDkQ4dKRjySBmBCvuYIUW0fTc9y0ga6u9aK9j9/Ykj08vk/OvRHQy7IKmxeQ3rAXHoNVdk3gOsfCJc7KOg2A6SLQ7fbh4kOP8FZuH4bVLO0qPXxK2CyE/XsMylrWC5V/RraCMYI8aJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=af3hyzghuvcZ4Zq8wFRwNeJrfuiKyIS9rG9piJsIxPY=;
 b=dWBV840Ahtuh0jhh3qJwbODlfr7o5dXHWM5hCG/PCF6cwGnH9W/vd8OXz3eIt78wdsYO8TS0NeI07jcmtNW/OouuAd2BNplD8ZNJnkjC616LyOw3H0XcCTBGbo7H3kUgWUr4Rr9z143oiks0dihbZ0PXSBG9UzIyxZFuavlo33cd2OzFmKqk3erezXy4adGBWn9APji6lfGMgR7D+xUkouP5tBiRHEJYFWWkUCz225LUY+ws8RxvxRNw85o2Rvp6OGiPv6SNtO4v05ia3XZZkkh60+xgiL7hpttMrnNBocyUThBUgzpJjm32fC7ixIY2K0XS8wXSN1yLwUkTp7IEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4973.namprd12.prod.outlook.com (2603:10b6:5:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 00:00:22 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 00:00:22 +0000
Date:   Tue, 3 Nov 2020 20:00:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Edward Srouji <edwards@mellanox.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: pyverbs test regression
Message-ID: <20201104000020.GU2620339@nvidia.com>
References: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
X-ClientProxiedBy: MN2PR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:208:239::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR08CA0012.namprd08.prod.outlook.com (2603:10b6:208:239::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Wed, 4 Nov 2020 00:00:22 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ka6Ds-00GJir-Qb; Tue, 03 Nov 2020 20:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604448023; bh=af3hyzghuvcZ4Zq8wFRwNeJrfuiKyIS9rG9piJsIxPY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=bN+3yTeLczsroE+v2UzPHkAONxYAGfewXt1Ra3JfOTnj8vaM7TvlRCoAA2Db+Yhm/
         omx3DsXfpIiRgTKBjaiG8SBlEYOUQIQb5wK6lOTuSuKQjXD3BOG7CFHSCMh8eX/Fq1
         gAxnGdK9/mwX3/x0KdUFXrGb/GC+/hf0qZUHmvTvxV7XSo3+013Wp5XSxPTsn+ShZK
         2m79XPbgL/zogvCOQq0WomZMWi4v3CgYsc/f/pq81SpfxJxhM543YyK4vvsTJtw6eR
         PwxZm4uAS0hOkV6AnAvcy3jcdxOBSEwurofqhaodqN2KY1ppywL5CsCVtoycxuKDYv
         WIdmtk62zEI3A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 03, 2020 at 05:54:58PM -0600, Bob Pearson wrote:
> Since 5.10 some of the pyverbs tests are skipping with the warning
> 	"Device rxe_0 doesn't have net interface"
> 
> These occur in tests/test_rdmacm.py. As far as I can tell the error occurs in
> 
> RDMATestCase _add_gids_per_port after the following
> 
> 	    if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
>                 self.args.append([dev, port, idx, None])
>                 continue
> 
> In fact there is no such path which means it never finds an ip_addr for the device.

That isn't an acceptable way to find netdevs for a RDMA device..

This test is really buggy, that is not an acceptable way to find the
netdev for a RDMA device. Looks like it is some hacky way to read the
gid table? It should just read the gid table.. Edward?

> Did something change here? Do other RDMA devices have /sys/class/infiniband/XXX/device/net?

Yes, some will

Jason
