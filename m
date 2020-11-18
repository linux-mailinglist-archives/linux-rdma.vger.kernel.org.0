Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF9D2B7DE7
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Nov 2020 13:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgKRMxq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Nov 2020 07:53:46 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:52047 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgKRMxp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Nov 2020 07:53:45 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb519580001>; Wed, 18 Nov 2020 20:53:44 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Nov
 2020 12:53:44 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 18 Nov 2020 12:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j47HFOrT999x6d8RvLWmc8ZeO3p11SxJad3btNsgn76xiqYqpvarfJijAQrKH/d570dR8M7i7E+O+1M+vHB9WBl421HM/Dxd0j/Av91Ag7vdqIaWfrNUPQ+LdwEsOmhPtlWOs9iRH3Ea2POVrt3ffxRw1NzS8ci3GTOsUiMt/cWgd1XRF4mG02SxKCTMAV3pAWHrPIcq8OgZn+qVY7yxZXappK+w+xRYofOxZEBpD2qYvLy+Uj2ngAPFHZSaampovhmX2DSdiaXaEVVw4EPXzdN4gqwdVokIOQaAAHiTZQkBq9g8TQN22tzfl/4sB/1ZIhGQWXviKUOMN9JkGnYANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bXRgTQ577zvBbvw7P9/oRcSYcOrekdgmyxpvGwqmx0=;
 b=Pr8a0EEZjk56AL/CNU4CKAGlb0WespbX6nS6vYbWsNdFeseL3kf6UwmxL90P8/qhA3P46rADuKq94KzX6sMKR+CDn51LtytoD7ElG92o9bK8uglGDidwJPdRE1LLoWlatoAZknroGU2CQgx2FJ7VIIqSB9F+I2OwLQI69/QdRGCm6rHjEz+9X2n6s3jZhvJZjpttDZ6FziQXc/yyUuHNkDVhakLmUANS7HSfDZalX++E7++HDGRVYg/gVxhjntHWGIx8kkSJjK9ccmsnFguzwPgzSSrXBkKYxl1X6jSPxHLiX6yTIsmTAReJtk7wYXT3CHsxLtpr347uzlZlCPM1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 18 Nov
 2020 12:53:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 12:53:42 +0000
Date:   Wed, 18 Nov 2020 08:53:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     <linux-rdma@vger.kernel.org>, Bob Pearson <rpearsonhpe@gmail.com>
Subject: Re: [PATCH 8/9] verbs: Remove dead code
Message-ID: <20201118125340.GZ917484@nvidia.com>
References: <8-v1-34e141ddf17e+89-query_device_ex_jgg@nvidia.com>
 <c78be7ca-7a04-6a7e-5a55-06a2dd58e947@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c78be7ca-7a04-6a7e-5a55-06a2dd58e947@amazon.com>
X-ClientProxiedBy: MN2PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:208:236::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:208:236::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.16 via Frontend Transport; Wed, 18 Nov 2020 12:53:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kfMxw-007g7Z-Hn; Wed, 18 Nov 2020 08:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605704024; bh=7bXRgTQ577zvBbvw7P9/oRcSYcOrekdgmyxpvGwqmx0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=WmEAjDcPMLkKMP6+dsqLR2Jor3gJa2pMUhk6d9gzQNh4Q+tRT8U4NsSdcznq2glYF
         zbMS9DWkZs2ITwBLz2jQsqgWIkOHxWVXP69MWZPIMoYr+3sHnjEFmgVOmrK1RHt/KC
         LmprWmvWXHB9hMXiATbqd1UEL2b8/LTRuDuRfeC8gFqB5k+5IDEylZpYkO6WwMgs3a
         T39zxVpuPOiYt2oYW7471kxYM+5cdVgFRbHKz0uvZL0T1gyPregqpbpBJcblCFffgA
         deJrJ3RsI1/JemOF5c9GWpX6wmGkzMDIUOHtJeFsvAHlP5izMN7//Lqyzpvx7OmgNR
         y67xtokLWuLwg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 18, 2020 at 02:46:05PM +0200, Gal Pressman wrote:
> On 16/11/2020 22:23, Jason Gunthorpe wrote:
> > Remove the old query_device support code, it is now replaced by
> > ibv_cmd_query_device_any()
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Shouldn't the legacy fallback in ibv_query_device_ex() be removed as well?

I thought about it, and yes we could convert that into a real function
call and remove all the junk

But if we do that it causes a symbol ver dependencies and if we are
going that far then we should really just do all of the
verbs_get_ctx_op() inlines and be done with that mess entirely.

This would mean anything linked with a new rdma-core would not be able
to load on any of the older ones..

I've been saving that gem for some future adventure since it seems to
cause some general pain. It would be good to couple it with some other
verbs.h clean up as well

Jason
