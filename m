Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43D830C967
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Feb 2021 19:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhBBSRN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Feb 2021 13:17:13 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18787 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbhBBSPP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Feb 2021 13:15:15 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601996870000>; Tue, 02 Feb 2021 10:14:31 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 18:14:30 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 18:14:28 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 2 Feb 2021 18:14:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gq7OSbVV792r5DkwdC7zycuLQJZDBaOA4K3H6jjrSrFwm+rEkMu2+ryj8CT0cpVBA9pf767RMXZ+d2v+sAAqMtMGj7Zb1kxmsVNkv0AYzq7PgrLNc4wwk4P/Npa/3GJ5+VPf68nKwAsADzZsi+/H6jYbNM59xe613psdbrfjtNdsR1o8xesBkfkk/tEApW+gZD4bx/80Cxc7Hj1i9uaGG0Rjb3PdpBH1mBri9HBBpoJBMwo7K7mwNVoJ9XsY4IJNX88Z0PRHN+6tNNQNG5WmFtkBsP64JaxcMLqU6D1dcFrvM5k3LsvEeNxel+NIE1aUFY5WjKBRjR6RK2JKn21WoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYTlhvQmtm37/wEK1tXoni+MO6pZPt5MG+9V1kScfDI=;
 b=PUwtszw74ThgfM01PSbtwS6YBFAG3rga4JzkPkyLktpNt4uBwPDYNj+201zLmwS2+rZfBRJKszYlZvhPIfsYWTS08d8gyXI2GPpKOOa5N/h5YiPVt4QHIGJvuXa47srpUaNVIXRFtxhDpVwieusNefIeUuZrBUCcgsNveRMGmd5gGV2Ncmqwukj8Jt8yfQAygAN3FWAmI9FnD53w0Bae/icj0AUXXqpnosfz2XPkwsS4Y973HDN226p7br6Rx5LjRo73McAdfCXcU9NQXvWQb2t09TN81GO8/Nhg10mK1765BvlhZetGOWn7l/nkqchMMmJ0hQWgQ/QvlyPHh8x8ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 2 Feb
 2021 18:14:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3805.025; Tue, 2 Feb 2021
 18:14:26 +0000
Date:   Tue, 2 Feb 2021 14:14:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Parav Pandit <parav@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next 05/10] RDMA/core: Introduce and use API to read
 port immutable data
Message-ID: <20210202181424.GA639633@nvidia.com>
References: <20210127150010.1876121-1-leon@kernel.org>
 <20210127150010.1876121-6-leon@kernel.org>
 <20210202165000.GA621786@nvidia.com>
 <BY5PR12MB432200DF13C2C7E2F62E947CDCB59@BY5PR12MB4322.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BY5PR12MB432200DF13C2C7E2F62E947CDCB59@BY5PR12MB4322.namprd12.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:208:256::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:208:256::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.13 via Frontend Transport; Tue, 2 Feb 2021 18:14:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l70C0-002gXf-SM; Tue, 02 Feb 2021 14:14:24 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612289671; bh=TYTlhvQmtm37/wEK1tXoni+MO6pZPt5MG+9V1kScfDI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=pQpPaNRBMNw8kLQV72KOyGc98//RU/acIo5YChbrRlsGo8D1KORimEoaa78bl7wz+
         IwZeTeYRaEVRGAbhyTUMP6K/+x8DFiWEbJHBiE49pTnx/J4CKdhk+DGra5svw1JzaY
         6xpN4/UA6AT3X/R4iIWsw0er5VpZcoHXFvK8/htb6wzIrEps5SqhHHiWuyIbUhMOCB
         R49tW5W4GiYylvEeYhYJd1UsAfZAbsZF8cv63nVadaTwC+ghuf3LPoPZTMmBDJ5az4
         naMTn8hDWo11k3jCnxpAxUY3Z8JFktsu1kx76vK8hm3WNHAomreAc+VeYHXyVmtf4o
         GPIdS2gohNOGQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 02, 2021 at 06:05:48PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, February 2, 2021 10:20 PM
> > 
> > On Wed, Jan 27, 2021 at 05:00:05PM +0200, Leon Romanovsky wrote:
> > > + * ib_port_immutable_read() - Read rdma port's immutable data
> > > + * @dev - IB device
> > > + * @port - port number whose immutable data to read. It starts with
> > index 1 and
> > > + *         valid upto including rdma_end_port().
> > > + */
> > > +const struct ib_port_immutable*
> > > +ib_port_immutable_read(struct ib_device *dev, unsigned int port) {
> > > +	WARN_ON(!rdma_is_port_valid(dev, port));
> > > +	return &dev->port_data[port].immutable; }
> > > +EXPORT_SYMBOL(ib_port_immutable_read);
> > 
> > Why add this function and only call it in one place?
> > 
> A helper API from core helps
> (a) to cut down mlx5 ib per port data structures and code around it
> (b) it also avoids the need to maintain such driver internal data for large port count (which is not done today)
>
I mean why not just access the pointer directly, is isn't in a private
header or anything

Jason
