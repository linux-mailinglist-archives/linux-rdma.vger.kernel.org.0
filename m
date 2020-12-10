Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492252D638D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 18:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392721AbgLJRab (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 12:30:31 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:65313 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392706AbgLJRaH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Dec 2020 12:30:07 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd25af30002>; Fri, 11 Dec 2020 01:29:23 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Dec
 2020 17:29:23 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Dec 2020 17:29:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtlaCIdp8qFKu9XAse3s3JnaMmGEIOiTtWE2gUCByKBMrt60PtQtpB5azwfscSccNq01ZTatxGLQ8PMmdIDvuPVb3D8PcOBP1c78K9Jg+4TAniHzVQPZZCdpshO/vuttqe1Y3B4Sx0CDPfn4LhCIlKhPks8cbSC/RqQ3Bl/CCwTHfYGHD+MlSbWEvuUpG632k5ua61jdNkgY+R23cgdNKU3N3J7g1O6qdCK8QZVJceL+BgdsSEirbZeq//RDcqhXpzdFh21z7/DLn2tg3x56YRFwruXmZ5mrFg+8MdhOINdWBhcmR1084yRAreq4noM1IRAqsMluZknEsE6n6m2/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EO9ztwA45eo6g7Cltq3LAVBknQQ3kqnmdS7c9x3Zc8=;
 b=Es7mRFqX53ipHF7D2tyoSRWS8AYUQqfdY8GGfl93U8lWz8li03bOzYii7Efth9cfBStef1E99CjYUYsV58ugcpuckHLgRF2Erwgg13TDNA5Yp9YqOKIMnUcJx3TpBaBS3WrgMlNnuBzCotSRl0fHlpK9x4sLCT9qrU2fGbg3EcK/ZxLPpBodmH1bTX+S4rtxLk+nBuiEU/NqRyDCqNMjlsKVKFRZqcbVU35igUtLp0Fclo1jN/Eh3UHGgkwDXBA2I9NdQci8qif/1DyX4HkqUS3PjStwVuvXnszuDcwENZU3x8z0syAoc7S4fFhxzvM+nm+wOb/oEbW+UVfxzIjARw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Thu, 10 Dec
 2020 17:29:19 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 17:29:19 +0000
Date:   Thu, 10 Dec 2020 13:29:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] MAINTAINERS: SOFT-ROCE: Change Zhu Yanjun's
 email address
Message-ID: <20201210172918.GB2117013@nvidia.com>
References: <20201203190659.126932-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201203190659.126932-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0323.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Thu, 10 Dec 2020 17:29:19 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knPkk-008skO-AT; Thu, 10 Dec 2020 13:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607621363; bh=6EO9ztwA45eo6g7Cltq3LAVBknQQ3kqnmdS7c9x3Zc8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=M4CyeiK+iB80zmcRrtBnyavfJHeO6vozdYGShVdfzXeV17Eerfpr6DDKhxQyCBiAm
         +s9I4UGj3fr3jPSFMpDjT01rBVyFju7Uo9vavPQlPFOcQBkx+qfvOHL0vh6bQs1Qir
         +gqyoSIzVtmsIPeOEpl7AFrWFWhWF6+7TU89S3dt7aJXDsoHlabqN1bH1s6RZ/ptYk
         2NIjIlsAw77Jlqmbuy2niHs4aUyzqAeRWagbAt4N+hFrfzGHmv28CGwPlLSiz3WY+4
         MoDXNcB7/I8y/G7ZoM4x0isqYVddWqA8ylH4gUgLCsU36EJjU2rpbb9lSd3eOh7jID
         jsmxLoiUdEaDQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 03, 2020 at 09:06:59PM +0200, Leon Romanovsky wrote:
> From: Zhu Yanjun <yanjunz@nvidia.com>
> 
> Change Zhu's working email to his private one.
> 
> Signed-off-by: Zhu Yanjun <yanjunz@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  .mailmap    | 1 +
>  MAINTAINERS | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
