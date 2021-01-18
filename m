Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590CB2FAC42
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 22:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394109AbhARVKi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 16:10:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6372 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388952AbhARVBn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jan 2021 16:01:43 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6005f7080000>; Mon, 18 Jan 2021 13:00:56 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 21:00:51 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 18 Jan 2021 21:00:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idxbNQIglTpZ0PqcO0Q/Q778cBNt7vMcmGJsKjU/I06gy9suVBQ73AHtwwldNO4yU/FAYhZR7rLkEmazEGhN2+CmHlVdXkypc6PNdlrytluYW+1TTS90roiTmmd3w7dW2CLR7JeG+FqxSbmi920NXi2yIQCPoAM6RN1crf43NdT5N88RPxKD4RPIFI4gStZNoMnnXbgy264ox8EMyPCJyUTHZOSonfFcrKqy3/fMzJwNE7/ESpJ5KIpbS0S6nb0DRZiyiDLZVmYA8AwIRnRMt1ArJ7Smpmd6XhjHPBFSHgHqmhVvfHP5KuR0KVWXR7hqzY5SChAjp8N3Z5VOlYRGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4TSUMRTFgxnk9IHmK5ztL2pWdWAI1PvbBr8+iY0ev8=;
 b=Kafn9tHth6QS53vnklyfo5w1GUWNZxJyYVbCeU+nQ1pfh4Z9krtQo3kb/V+XM7xQ0ZKbiSRTxJG6U4IrLRq4cQ/98fWDsoMMNZtpxPKeLkKRPCjHxAJWG794Ra7VRXIbhSKCrF5VXhyXK0QVin/RClbe2SyMdVSXR3sAsp4Vr84Jtq3F2o/R2B1hn87XtXGJ4N+sZBNp3SHoghJBN3S5R/VHaN5aB4W7mBVGLwFjfQ+oN43wxwpDjH1R82gM4xSgIdBJr1WMaFzYr0FRuqsA2yYzjhCjAy/aiHJ1/gYGhv+Kf+hkXEURiB9hs0VS1X6rTxD3+n+QO9vfU4iMG2utEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Mon, 18 Jan
 2021 21:00:50 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 21:00:50 +0000
Date:   Mon, 18 Jan 2021 17:00:48 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/nldev: Return an error message on failure
 to turn auto mode
Message-ID: <20210118210048.GA797553@nvidia.com>
References: <20201230130240.180737-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201230130240.180737-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0535.namprd13.prod.outlook.com
 (2603:10b6:208:2c5::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0535.namprd13.prod.outlook.com (2603:10b6:208:2c5::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend Transport; Mon, 18 Jan 2021 21:00:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1bdo-003LUY-1U; Mon, 18 Jan 2021 17:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611003656; bh=i4TSUMRTFgxnk9IHmK5ztL2pWdWAI1PvbBr8+iY0ev8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=fYvU91a2k5ZMTMz2aK74ZLEh0D2G6k7WHM4T2v1yFgIMcR87mem+r7NHdh3hNX9vh
         TF3621YD6U7EU5ihAcAz9L0zvCUENcOwfcOHuYhCPnFkABZfi/Gjys89HnkEuQcBNC
         a8xe0rZa48Iyo6nka0nIAl3XqTpG5a/DOICF6Lm4xit0PL4mArlEPCMAwh7l9x2IZE
         9iGh82lOtYeM6JMX+ZSEDUTIGOK9MB2Nq0oqhdhUu94fD9ZgxveomM6ZqSYxDUAHgw
         Ga/VnRkV6UNkru/vC62/rG/nVMBTPB+S6TsHByBsLU+gjmd3J6z1q5NzFjphuKzoPw
         Un34W1LTVDx7g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 30, 2020 at 03:02:40PM +0200, Leon Romanovsky wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> The bounded counter can't be reconfigured to be in auto mode,
> in attempt to do it, the user will get an error, but without any
> hint why. Update nldev interface to return an error message through
> extack mechanism.
> 
> Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/counters.c | 62 ++++++++++++++++--------------
>  drivers/infiniband/core/nldev.c    |  4 +-
>  include/rdma/rdma_counter.h        |  3 +-
>  3 files changed, 36 insertions(+), 33 deletions(-)

Applied to for-next, thanks

Jason
