Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46EA2A6D09
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 19:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbgKDSn4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 13:43:56 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1659 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbgKDSnz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Nov 2020 13:43:55 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa2f66e0000>; Wed, 04 Nov 2020 10:43:58 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 18:43:55 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 4 Nov 2020 18:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6fuZzmgYsZM05Qh8B6+JdTYhR26tRQTOas00B8kybsIk6o169pZaQQBEI2Tzs2SahGwkIguaRmm56+FzCdnbvbItgIPAsK+MVf+z6xJkpvP0+1JlOgs6nAltB+yO8TCaSDEprRVB7judzgIDQykGldhDyqRhSRn+xD3CtjXsPShmx7v1Xus5r8WLoa5DPvUpdmY98yWbloyAiGXctnar16ips6iFY/pclTmD2A4L4Gm7dsCmOUOMj/0pnvPG5QOk1KxaO/lYOYpKrYr1suu/WwArBehv9DNV3GoazQ0/YpTPoWGZ08hF2lz49zT6QDKfWwzV1io6UYyPDvLOmrVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IahFMDQQa+wiFtnEplSk0mDmNzwyAM9wW6IuR6+I1o=;
 b=U5k5iqAqA+lZNsJZH8/PpZatu/TRkWVQME6Gb69bDhhCmtzTbVCJv1TrmcgBC6M4J5jcvqEqrDSx0vSoXyl+26W6Akbdor5NijMKH9+wR4Fr+ckGtybttgI4Voo3/aW30dARNTyLlKpgquEYdSt1hlHdiZVCs2mkqmE1pG68q4gSJ0TgTStNaNd8bxdTtamO4Qdhrif/4JH9CcFyrFFfm9PZMp2aLnCHse8Yhs+C1oC9W9fdhLLshA7k3siQ8qtAATUZ9nILRcp9klhsAtTFbtj84AK4Jva8m5ktJKxbtCWccs8y0vDrAMGfcUHawrEOm92UnDp1doVl8wz1xM0ZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Wed, 4 Nov
 2020 18:43:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 18:43:53 +0000
Date:   Wed, 4 Nov 2020 14:43:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Edward Srouji <edwards@nvidia.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: pyverbs test regression
Message-ID: <20201104184351.GY2620339@nvidia.com>
References: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
 <20201104000020.GU2620339@nvidia.com>
 <5a02bf4d-c864-124a-38ea-0911686737ea@nvidia.com>
 <20201104123634.GV2620339@nvidia.com>
 <f8921735-296f-ac9d-c3a4-e4475ab2f2c8@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8921735-296f-ac9d-c3a4-e4475ab2f2c8@nvidia.com>
X-ClientProxiedBy: BL0PR0102CA0068.prod.exchangelabs.com
 (2603:10b6:208:25::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0068.prod.exchangelabs.com (2603:10b6:208:25::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 18:43:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kaNl9-00GbFF-Pv; Wed, 04 Nov 2020 14:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604515439; bh=1IahFMDQQa+wiFtnEplSk0mDmNzwyAM9wW6IuR6+I1o=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=MAyNW8cSQrCXAnSiOoe3MLjewPFiEuR7U29Y01/osJ3hsSkpoGOhV8RAhAY6JmqvK
         u3ep9GiPPXqu+kLv7uI3ooLXI6g3u5yKI8kbXtQ6KEPauavm0uJTTYzPYyX/FHc63K
         zRXQDpXeLKiGYsu0hMWhobfjTvjdTWhUHMcpP0JbBmEGYus+DFfa309+67+2DBh1mX
         9uv4vLNCAmmz5TEu9LA+2sFZCZj7Xxq4zc+uAxfG7g84EEqbZ+CbXBx5qXQ9fUrR6T
         zYtke86UIPeZ8+aQ+BptUEIyXYrSZ4Sd5j+w66b6rOYhPA+thCSVuYUmxmqydWXfNa
         qOohpUeY0eKYA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 08:34:37PM +0200, Edward Srouji wrote:
> 
> On 11/4/2020 2:36 PM, Jason Gunthorpe wrote:
> > On Wed, Nov 04, 2020 at 12:40:11PM +0200, Edward Srouji wrote:
> > > On 11/4/2020 2:00 AM, Jason Gunthorpe wrote:
> > > > On Tue, Nov 03, 2020 at 05:54:58PM -0600, Bob Pearson wrote:
> > > > > Since 5.10 some of the pyverbs tests are skipping with the warning
> > > > > 	"Device rxe_0 doesn't have net interface"
> > > > > 
> > > > > These occur in tests/test_rdmacm.py. As far as I can tell the error occurs in
> > > > > 
> > > > > RDMATestCase _add_gids_per_port after the following
> > > > > 
> > > > > 	    if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
> > > > >                   self.args.append([dev, port, idx, None])
> > > > >                   continue
> > > > > 
> > > > > In fact there is no such path which means it never finds an ip_addr for the device.
> > > > That isn't an acceptable way to find netdevs for a RDMA device..
> > > > 
> > > > This test is really buggy, that is not an acceptable way to find the
> > > > netdev for a RDMA device. Looks like it is some hacky way to read the
> > > > gid table? It should just read the gid table.. Edward?
> > > GID table is not the reason. We need the netdev in order to get the IP
> > > address of the interface.
> > The GID table has a list of all the IP addresses of the IB device, and
> > all the netdevs that provide it
> 
> Then how can you get the IP address via verbs API(s)? AFAIK, the gid_entry
> does not hold the IP addresses, you can only get the subnet prefix, don't
> you?

IIRC the GID encodes IPv6 as IPv6 and IPv4 as an IPv6 mapped address

Jason
