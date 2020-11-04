Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BB42A6474
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 13:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgKDMgm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 07:36:42 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11774 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbgKDMgl (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 07:36:41 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa2a0540000>; Wed, 04 Nov 2020 04:36:36 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 12:36:36 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 4 Nov 2020 12:36:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idYQhKYzDlhjy9YXzu9wWGJv3POQjvKLgq9yRy6DCONOAZqBmSv68bvpct+GJIn/36KWVm7gwwz8GbYIyeKOEYPHjwl9dXM884X0IhsVjZTtQ+dP1L9bEU/5gUciKLDYRwUVh42Mp3HfgPWK3CBZuKBcv4w0Ch09qxNg0UfMSfVOh3rmAbfpCrrJgO4ZSJ5mPhFW8KBRCGzAo2WoOmd1p7km0RgryoS2d0xWNXi9CiLC+PgBuamHYoeognWZSSlTgsErgvzKqoEEgX53Wi3ilw09PyfJKK4cpEYpJojsgPA8P1tqsFV/Te4RYFp4ZWnhEKGtVvYHsz8EKsFiaZx1pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqdqNFTUr3vROf+ZFG/g6tUTy6YcxCYPt1hi7ldRSXo=;
 b=KQ/Ob/QakipNufji5Mi5qWSnPm1WLQzBzF26Yxs+eNwuIi5pZI4SCWoh5hzjOQkyfT30BLZ2nUGd6VP+5dWZra+U7otFnPKfXZZ97wIP28F+8eDaPMw757vcg1gUhhbXyutowiXTBSnEcZMbVbREZ2lP/LoxdDKXXLcDP0u4lGNdxmuIvpfSZ0e5EEAOUuJR2dd4YDwWk/kaXBkpOmpWj1zjY4WHSyrVrRoADs43Jj71qBrr/cSzraxKO7hl7XSXFxUB7pwi0UcgzzkJatkbXDt9t/5Ued55DIa/e2mPh3KJUoumIi3kQJAYsBCTHDjkKKUgGySmp0wPETfUBKcSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3401.namprd12.prod.outlook.com (2603:10b6:5:39::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Wed, 4 Nov
 2020 12:36:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 12:36:35 +0000
Date:   Wed, 4 Nov 2020 08:36:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Edward Srouji <edwards@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: pyverbs test regression
Message-ID: <20201104123634.GV2620339@nvidia.com>
References: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
 <20201104000020.GU2620339@nvidia.com>
 <5a02bf4d-c864-124a-38ea-0911686737ea@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a02bf4d-c864-124a-38ea-0911686737ea@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0050.namprd16.prod.outlook.com
 (2603:10b6:208:234::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:208:234::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 12:36:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kaI1i-00GTz0-Jy; Wed, 04 Nov 2020 08:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604493396; bh=HqdqNFTUr3vROf+ZFG/g6tUTy6YcxCYPt1hi7ldRSXo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=VVLD+3FlPa5rrHfqYs2AcEarFjzhEYtbVWwLIUIHPpqNiu+pvBA/8PL1dPI2sTYtv
         MqSq1odxVhuM5y5aO9UsTInEjTTdzDcCUJ9hfvpGu57jOkHJJK5RmKIVp5jknF13+K
         3uwmt6WHlPnyDml16UdxYL8WPED04KINRa6K3RRNz2LlWhqRSmmhvnBhb+vP9J6OAm
         wK2fgZHwT6vZM0tmlm2aRlO6hhYJbooqzFujmTYIT9jGb4k4bx1Pf6MYhkkblGvJjn
         +tuTDns5uRwxO4/JIogHgFO8MdPbhxG3p4Wwhw3qHUIxpCwBBfHaGv8GqYMQCMQC1s
         lgQED5ACitx4w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 12:40:11PM +0200, Edward Srouji wrote:
> 
> On 11/4/2020 2:00 AM, Jason Gunthorpe wrote:
> > On Tue, Nov 03, 2020 at 05:54:58PM -0600, Bob Pearson wrote:
> > > Since 5.10 some of the pyverbs tests are skipping with the warning
> > > 	"Device rxe_0 doesn't have net interface"
> > > 
> > > These occur in tests/test_rdmacm.py. As far as I can tell the error occurs in
> > > 
> > > RDMATestCase _add_gids_per_port after the following
> > > 
> > > 	    if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
> > >                  self.args.append([dev, port, idx, None])
> > >                  continue
> > > 
> > > In fact there is no such path which means it never finds an ip_addr for the device.
> > That isn't an acceptable way to find netdevs for a RDMA device..
> > 
> > This test is really buggy, that is not an acceptable way to find the
> > netdev for a RDMA device. Looks like it is some hacky way to read the
> > gid table? It should just read the gid table.. Edward?
> 
> GID table is not the reason. We need the netdev in order to get the IP
> address of the interface.

The GID table has a list of all the IP addresses of the IB device, and
all the netdevs that provide it

> > > Did something change here? Do other RDMA devices have /sys/class/infiniband/XXX/device/net?
> > Yes, some will
> 
> Nothing really changed in this area lately (in pyverbs / rdma-core tests).
> 
> RXE can also have a netdev here if it's linked to one. E.g. by doing "rdma
> link add <rxe_devname> type rxe netdev <net_devname>"

No it can't, this is the "parent" device and ib_device can never be a
parent of a netdev. rxe should have no parent.

Jason
