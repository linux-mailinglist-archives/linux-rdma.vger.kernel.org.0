Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926F729D5BE
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 23:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgJ1WI2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 18:08:28 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:20949 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbgJ1WI2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 18:08:28 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9968930000>; Wed, 28 Oct 2020 20:48:19 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 12:48:15 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 12:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0Qr1LGZDirL/pBknilQXMn8/TFvZVfOk0D9P+s939+TKQhzkhUTQZvRizYOhiwUGDWEfQJtOxqMeVwqlfYvIxtZJHgmUZF4nteayum6IiaCqBl7Pt39+UqeEIs6LCLeko7DMIszBFqaHeCXOUe4Tj9fihjufq6ZKr7xu4aDpTitoTa2k08XqtXZIwpftGWD1RfSsTMB6PTUdi7qPf6iG1eqnB6WZPdlMtX/DTzMFkI7AK2tILpgXepQFYhDGDjhu6Er60VYwpCIYRsX51WKW2MJh4KnJcbNRgd8IMFzCYibL7av/7dXveeJ1aYe9lsL+ORlNiAYH/JhoMdyMJEwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghyZTfiJrbLH8htT9lWbfxGAcGH+4Pglq2ExrRrKRJU=;
 b=bH/wQiIdg/8U2VZqG8QjHC1lAQ7JGnH29haRfegKwz933rdzCaCYSgxqFO0Urzpaao6qyTQbo4I55VRex8WbEPVr88w7GFAKK6KjsjOmGKIN+utoiZv1GIFUh5ogbE4sQcQ0C1DctJVwieV78GZkNJcsPPhkwHN8XwGVE4NPkvR/vaeAfXDkiQjY6fiFNWdfUpvS/4uuX5v9mGm3wdz8s+ii0dnYQuoYD1+GKsmk905BH9UTk5hYpG/uQvsj08aTGv+amri6fUk4yiy+JMckGSS2sF8TWH5CuFrANUgt4FfgCoVrrNoju+zoPQlNiB92vpHe8AJ3l3sFgtI1Z2AJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4041.namprd12.prod.outlook.com (2603:10b6:5:210::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 12:48:12 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 12:48:12 +0000
Date:   Wed, 28 Oct 2020 09:48:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alok Prasad <palok@marvell.com>
CC:     <dledford@redhat.com>, <michal.kalderon@marvell.com>,
        <ariel.elior@marvell.com>, <linux-rdma@vger.kernel.org>,
        Igor Russkikh <irusskikh@marvell.com>
Subject: Re: [PATCH rdma-next] RDMA/qedr: Fix memory leak in iWARP cm
Message-ID: <20201028124811.GA2394084@nvidia.com>
References: <20201021115008.28138-1-palok@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201021115008.28138-1-palok@marvell.com>
X-ClientProxiedBy: MN2PR18CA0024.namprd18.prod.outlook.com
 (2603:10b6:208:23c::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR18CA0024.namprd18.prod.outlook.com (2603:10b6:208:23c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 12:48:12 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXks7-00A2pF-4S; Wed, 28 Oct 2020 09:48:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603889299; bh=ghyZTfiJrbLH8htT9lWbfxGAcGH+4Pglq2ExrRrKRJU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Xn7gcv5w8YynQHmNPj2XTLTkPbRl+iXpNx24iLpLvU8whk8KVAfeTKFB4HJtB1TAd
         ynoNmlRARJqUnGonECIZn7lQKyUZt5E9Lo91PdtJMI7PFwYBK99ZkwVPJmS/Hj7ua0
         wguGb4sfoJNbpCpVNl5OaRQtHtdxNBsPYQj0Gv/P+8bqpEUy43VvNMLNbVbEPBZMoG
         K4FtosohozJX8iAtn88FZPFpYBigy/nr8OZVKkro/mUdLZT0iYgE+rQaF80Jz+tyUe
         ArCC5Y+oxXKumKGKck0zM9OOTTrwpHH4AB+IpxSPadCHPzEOR+3cUjd4f739qkF65x
         VbRYrDhZ4aVng==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 21, 2020 at 11:50:08AM +0000, Alok Prasad wrote:
> Fixes memory leak in iWARP cm
> 
> Fixes: e411e0587e0d ("RDMA/qedr: Add iWARP connection management functions")
> Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
> Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-rc, thanks

Jason
