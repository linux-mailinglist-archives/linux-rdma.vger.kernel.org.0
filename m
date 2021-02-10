Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E819316E7F
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhBJSZE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 13:25:04 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6586 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbhBJSWy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 13:22:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602424470000>; Wed, 10 Feb 2021 10:21:59 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 18:21:58 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 18:21:55 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 10 Feb 2021 18:21:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKHcUstYCRqvqHKYQjdXJeSaBaMEZkhpQ41QVwP4IOsk0L6JeXjdZAIlkOkXa5XeYC/N1g05LdpQoEVTTnnAwZOhCTycCROSKQNVEBV51dDLxxTFPmV7v8r/A43ik32X4TBs40yDXsvn0PmsmHZsab72OCke49HALO3AUFKxKyEoW7pWGD3kBaY51jo6aAh9/4OvUivo5pEh0vtrMvqv2Z+ojiJWIjzfjs7H0+G08bHFHKLcCy5sIpuob6IQusAGDlBApG/JZu2sVKF36Bnn8nYzZgM6/Tw9WWF0gBWTxuAD2H+TIO4dcHjd9TR2YYx58BMEpPPo6DR55HDNIIBKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxX7Pzg8y2DsfnPBAhoJgKbINqTpx/eDLSvpdTrGyIw=;
 b=N5rmVutEPgci4aaKfC7TB0dbZnBNtjS2c3zO40BO2YYydK+GyV24uDXJmca/Ik5PVnNmNOafCyo9l6FjaC/7MCxZ1h3oKv6Do6OLNVQMV+/yMbSr/eM9EqDNzvUH4/9oKmZRtOBCBraXQxZ9QJlnuP+EMZyeCdNZEhoImwI/ZPZvkjsXHgW5XrxmHXf5X9aiafEo7mz4mztiYERwacIABltJRcdFM4YCJLg8a6VfuLvZoaWA1nycVGKjInDiWVDU7D8bLwVbiGxY2Naq0Qt0QFPaQ3T3eIKSVDnA7TvHOXJXnX74b8wacorTvZOJ6Az0jwFXbDYn7buv9m82EzWWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.26; Wed, 10 Feb
 2021 18:21:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 18:21:52 +0000
Date:   Wed, 10 Feb 2021 14:21:50 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     <mkalderon@marvell.com>, <aelior@marvell.com>,
        <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DMA/qedr: Use true and false for bool variable
Message-ID: <20210210182150.GB1470084@nvidia.com>
References: <1612949901-109873-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1612949901-109873-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-ClientProxiedBy: MN2PR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:208:fc::48) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR02CA0035.namprd02.prod.outlook.com (2603:10b6:208:fc::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 18:21:51 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9u7a-006ASR-Oz; Wed, 10 Feb 2021 14:21:50 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612981319; bh=AWULQz6G59wup+rf+snjWP6zT2Sm19u/cEacDt8bp5o=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=J2Nju+eAbUCk+1aT9Alfc1P0TLGlzHSnF4JIcQrcXayv98dwm9eKD3QZ/LYY0Ctrz
         xQ7FxpLsndYFUoZshDjxSAwnnavsXYuaeRqS1tTXJn91otXepuaHpv2YTj85gMMl5E
         nFgzwP3HTQELf7eCE5cgLHxx/MZQ9A1tyVDViwwr2rRGrGIjacfpXxG2R8XwDKaXER
         v70647FU77XZ5LPX0oSLhz4oKKlBiUbHvRt/dZ9iFecTJ7iL22ksa3fqu1LTZQiXJG
         u1DjguyOFq3TW0SuykyHPG2lbEuM9DKBNEfKkJdWAvKYd41SjyO6M+1Yo7EuMdRLA7
         QWThYrGcYAK9w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 10, 2021 at 05:38:21PM +0800, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
>=20
> ./drivers/infiniband/hw/qedr/qedr.h:629:9-10: WARNING: return of 0/1 in
> function 'qedr_qp_has_rq' with return type bool.
>=20
> ./drivers/infiniband/hw/qedr/qedr.h:620:9-10: WARNING: return of 0/1 in
> function 'qedr_qp_has_sq' with return type bool.
>=20
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Acked-by: Michal Kalderon=C2=A0<michal.kalderon@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/qedr.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
