Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7295629DC37
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Oct 2020 01:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgJ2AWa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 20:22:30 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1413 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388925AbgJ1WiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 28 Oct 2020 18:38:06 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9974000000>; Wed, 28 Oct 2020 06:37:04 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 13:36:58 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 13:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIfsedMlepF03f8bBeRcMaxZ+uBi9Yv8gABviYlBqzPEDOuIq1Rs/+dWp0YaVmXGXaZvmLM9HA+nShivdUYCnm+IZwzXUJqtpV4B7dMqjaTrcfFQHKLyn+4HvDoemwsnwpAnRL/TkCwlZJA58FfqkmsBimzQmk+qFGKJ7E69KThCYX6rDtfjw0omMgmo7ohlh4Ds3nq7u4lstrGWTcZJWKD/hZQ4Yf+j+8C/y1smCqRLzacJ2UOZ52lDRo6E22AnF+Uub1utBY5dWzH7hnOrCoKDm2qdgW8bEu525NoURsGmekprS7glPyhz7/sER9MY8aTKytKdoJXfsZWcxxTFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWYPqkdQYaeS95prtlTHwmBlGmr1ICvL1xj/cnB5WhY=;
 b=StJ78FIUNoIxfoG8xrKdT8MVmgM3P7Elhj12IUmqta1Ig/ivOXfXWH4QL12uFSS9fThzjL1WIDtFwkktSZy9Ws1lKEpQNZ8HtKjRkT2CW74BZQbjmKWUDTtDHscgHp1zExQv3a/LgOdUsiDCsoRinXwr1Q3FpKy/WWeyl1Ii1ArExqACCwbcR7h4lAVZoA38lkz0ZpzMfqXlnkCl0WOEw92xLd8Av8aUN0Z8e/gtCyeqyCUV/4lSPvoDBCzV/zDdfvcZ9CrVZuI0EGYg/hqhQLWYC2PVayTY1xQOlrS4kgNMTx4OMm+QW6ELG3dDM+XsY1rTTGzwnyZp12of91fMOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 13:36:56 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 13:36:56 +0000
Date:   Wed, 28 Oct 2020 10:36:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe fixed bug in rxe_requester
Message-ID: <20201028133655.GA2414028@nvidia.com>
References: <20201013170741.3590-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201013170741.3590-1-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0283.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0283.namprd13.prod.outlook.com (2603:10b6:208:2bc::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend Transport; Wed, 28 Oct 2020 13:36:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXldH-00A82L-8u; Wed, 28 Oct 2020 10:36:55 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603892224; bh=nWYPqkdQYaeS95prtlTHwmBlGmr1ICvL1xj/cnB5WhY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=GxkVbv62ZGk5/6r6BEQOws7ta0C+SvWKTh8k3/cS2birq8wdzPTRzOvlvSxK1S93l
         jWmM+Uj2zMSkyuO9MpyIQ7ppGojGxloKFgK82ebjUvL7iasUmmYW2lVIPTQXtEwM77
         NLH2iOPtvxnCBWyPcCxH1lILyqxmERZv5TPEG2eK8oOsMwky/YN79w2kuIokacZ/w4
         U/sFHBReh+A8Z+2U+ZLrYsqIzza5dhb8UudQzJVkzrS9NnMLJYC8GOFhfBvX8iZIiV
         EgcnK1YK+b3hWX8/xrDx+l52cW7n+a85L8B3IiBy02Ivf0pYzWnXrSJ9KkLFwFmDxd
         Eg4EQwlDrLJAg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 13, 2020 at 12:07:42PM -0500, Bob Pearson wrote:

> Subject: Re: [PATCH for-next] RDMA/rxe fixed bug in rxe_requester

Missing : and vauge subject, more like:

RDMA/rxe: Compute PSN windows correctly

> The code which limited the number of unacknowledged PSNs was incorrect.
> The PSNs are limited to 24 bits and wrap back to zero from 0x00ffffff.
> The test was computing a 32 bit value which wraps at 32 bits so that
> qp->req.psn can appear smaller than the limit when it is actually larger.
> 
> Replace '>' test with psn_compare which is used for other PSN comparisons
> and correctly handles the 24 bit size.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE (RXE) - The software RoCE driver")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>

Applied to for-next, thanks

Jason
