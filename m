Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8A31A1EA
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 16:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhBLPlE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 10:41:04 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4193 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhBLPlC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 10:41:02 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6026a1660000>; Fri, 12 Feb 2021 07:40:22 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Feb
 2021 15:40:21 +0000
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 12 Feb 2021 15:40:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA4lyUflNLTDYQTMBvY3br8EB8g7Hq3PvJ2LvdEM2fLFPlmUhSrmsUr50Fo6zX4CudN9u7jeaVXQ54gYjG9mLnOcnftO5PtQB5W0bBjmqToBJGtmJH3RWhLLMwgzZp9dPXXq1PrWxBlKjlADt7JZQ2QNrde8VnfF6UdA35zvJ/143xVE6OgRW96FVHdctQuNdJH8NTt2FHhleRU41hCw24D5oHvupsF9/o41DFhkptaXsXUpV75chte8c7367NeNIXQp6gUWkGLb7JXRD2q9MaH4IpL7kueHSwXyCH00wEaWLz+HbGa/j5GC5QhdBG1c+LY+JbK27AOFrKIZXSOreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32emJ40BXMN8xKwIB2lGUlEQQ+6bENlLldZeDWOzPwU=;
 b=Mvc9yrnFhbiojx5E3Xh1e015LFRziY1780+vBZBrIRqqlpQle94xu7c8dOiCvA0jin6K9EyEC6YH9qa6M5m1os5Hb5pg75O8eXOAGiweYz3i62Nl9WfKUAP1QBsKlg5V19jZi1h2dAlKFg3d/fTcaJcI+sK1OWS2+GMqrnRp+9SqXZzS0wUgvzv4s3EdtmbZR+jLMCyErxc6hvdW6AQbLV9vp2yyAAMwH/uNvJmLHLmzcm66ViddtaHrox8xeIleTyh5E8sd0qIKgpCYGJu+dA9PTj89uPPcGicbDKmWrsE3mUB0O4BMVj4QjeHFK8fGCsdxvpLVwMxfbdulJQGrIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 12 Feb
 2021 15:40:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.030; Fri, 12 Feb 2021
 15:40:21 +0000
Date:   Fri, 12 Feb 2021 11:40:18 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Remove unused pkt->offset
Message-ID: <20210212154018.GB1716976@nvidia.com>
References: <20210211210455.3274-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210211210455.3274-1-rpearson@hpe.com>
X-ClientProxiedBy: BL1PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::12) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0127.namprd13.prod.outlook.com (2603:10b6:208:2bb::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.12 via Frontend Transport; Fri, 12 Feb 2021 15:40:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lAaYM-007CjY-Jo; Fri, 12 Feb 2021 11:40:18 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613144422; bh=32emJ40BXMN8xKwIB2lGUlEQQ+6bENlLldZeDWOzPwU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=iO4QX4lMpHToCM0Aqynq3JHHyBZtxW34pzt5ySSLUyC4i23eax1NXYieHH4Fu3hqY
         jiqJS0BUWpiWaEUyK4Ef6jdbTZGHQRxxPC04uzLFq7auk+UowWDkRI7ZONeaQFIMhX
         gE+4hvswe3Op2piQNTXoHownlXhxIYIo+YqKpY7PiFIOstbUSd/OdGwwMW6OTOYFiT
         avO4bvwwGELZM84MbSmVD+6m5WfIH95dmU35SGRkfGj2uvzXQRB7Vx3TmU15X5ogCs
         aPnHcgj9ARwsxBiR6mqBe/fXwLFr2FqNP9++Med2THrnUSH0SuXg3Ckoe5YCcmHNIv
         A1ob2IJTJGfaw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 11, 2021 at 03:04:56PM -0600, Bob Pearson wrote:
> The pkt->offset field is never used except to assign it to 0.
> But it adds lots of unneeded code. This patch removes the field and
> related code. This causes a measurable improvement in performance.
> 
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_hdr.h  | 178 +++++++++++++--------------
>  drivers/infiniband/sw/rxe/rxe_recv.c |   4 +-
>  drivers/infiniband/sw/rxe/rxe_req.c  |   1 -
>  drivers/infiniband/sw/rxe/rxe_resp.c |   3 +-
>  4 files changed, 90 insertions(+), 96 deletions(-)

Applied to for-next, thanks

Jason
