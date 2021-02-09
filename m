Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1FE2314500
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 01:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhBIAlr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 19:41:47 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2716 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhBIAlr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 19:41:47 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021da230000>; Mon, 08 Feb 2021 16:41:07 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:41:06 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 00:41:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWhZV9uJq8gAhw4x/4OeilSqLHloCfcCeGN3dAs3meqAfusMSB9sfCWJUgop96yHvzWPuTOVpLGRGtK4ysOhQ1lff3+bnhHFa1RyFziSyHH7MB8Yt1XI83jyViNi2XbaX4lrGDdbmP67MKjl+V/76qmhBR0vTZObrOeCaW+WT7FShIoB9pK54TQeZDw0V+8pvMOfNoYwS+04ZiSE6WE/3PX/jGk9Kky2OMDPt4/LnLBidmU574xuKoeztdKA4zDKuV3s7jNpFA4WwcP+coWQKmjRVuAVSAUByJQw+5kORCs5qyOe2sJFMPsfPzP/ulSmoz5AjWq6sCFSyDIUXdvVpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPGK2ECGxKYfepWI0D9PNmeI98WdhiIiyzYLUd9xFck=;
 b=gMv/aG1+HasYufkz22mwy/xqhdcdpyxXQh5CmtFeimCvyZA8OvPE3965tIfjiO8IpK4fPRBb3bH/6AIu7ONF2etkuZ4097oGhJji1KwlhPrLEw/FyH2PaLu3ECPwPVIRkMhxGYEKaGSQT5O/fxpf7xEYIkXSYnFIXr6IQL8GT7kCK3FasKP7veD0nIziKQ5OysvX4UWknO7fUhyMDW4mn7S9JHmFYkbbR9vFTbxlIES/AAEpfVApRHG0uE+c/aPejh3o2zliQD4u/RLp3gjDtPkd0WvJK/1FVIaGqgN5A9s3dZhuNl3V2y05Kjrt1TzPNzd73BpdKJN23w/h9MM/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2811.namprd12.prod.outlook.com (2603:10b6:5:45::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Tue, 9 Feb
 2021 00:41:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 00:41:05 +0000
Date:   Mon, 8 Feb 2021 20:41:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix checkpatch warnings
Message-ID: <20210209004102.GA1248548@nvidia.com>
References: <20210205230525.49068-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210205230525.49068-1-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0140.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0140.namprd13.prod.outlook.com (2603:10b6:208:2bb::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 00:41:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9H5S-005EoZ-Ne; Mon, 08 Feb 2021 20:41:02 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612831267; bh=WPGK2ECGxKYfepWI0D9PNmeI98WdhiIiyzYLUd9xFck=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=AuIDdFYloX0OsdxtZI+PfLWW5j0m7jBKBeXIRHVc1hD3M2igoTtfXgq35YPkyMaN6
         xZ4eS6AYr+zcG8VaQxUWr+CLUL+4wmVTqTMSsRojTLScKU6gZFauUAgaO+Cqpu3swx
         OsypEyX8mT1m0NW2sc1dA3DhmEBd8d7qyShMEdqxIuMUSM8oq7l8s1RgYJmivDOy9Z
         kb6JqCJLXh5EqfvWvfKnkpXy44QoWI5btiU4ghuVB9LVkR2/p80dOAd6tRwhn23d8x
         avsHX7ekvmi2bCdv67TJCs0ULNaHySJsLPKk0zrt36Hdin0TUdMSPIHCZeRXvQDCD8
         4MKr8f+FFEW+g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 05:05:26PM -0600, Bob Pearson wrote:
> checkpatch -f found 3 warnings in RDMA/rxe
> 
> 1. a missing space following switch
> 2. return followed by else
> 3. use of strlcpy() instead of strscpy().
> 
> This patch fixes each of these. In
> 
> 		...
> 	} elseif (...) {
> 		...
> 		return 0;
> 	} else
> 		...
> 
> The middle block can be safely moved since it is completely
> independant of the other code.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c    |  2 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 16 ++++++++++------
>  2 files changed, 11 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason
