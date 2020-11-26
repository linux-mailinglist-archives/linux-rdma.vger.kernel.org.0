Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80C72C5CBF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 20:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgKZT5c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 14:57:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:10676 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbgKZT5c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 26 Nov 2020 14:57:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc008ab0000>; Thu, 26 Nov 2020 11:57:31 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 19:57:32 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 19:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRilVfBfG9W69witeUPCQ7Qqz+nQr1oX5+1S/CWlBrETS10dYsAHJmBRQXoXOyLmVFw6cH/gPPYjxGyt4nVIfGgyj5JOAoZWVKEFZJ/iwodoXoa9MNobyio1Dbz2YtyKXe8/hmRhoC0WXMtL6yEfnyULWLaNRyrqES849F/Rnd5lARCiKRD1bMiqUVjMp4T1tdMGq80KuOcMTfVuZXUXkfFlX7OZ+t3r46z5lPsFpL1sexDgEhkUWSyAeEs/giEQNGBuzCIw/JX9YBDGYcjr3CWI94/IeOieEoZ8H2fOuzsZKHdaYVAiOMxddToDB+7jk8tcT7FHAzS5OOD63fAVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxYPE3E+sHPNK6dNop/OBMCGP+HNdTG/C1gYcO0AZpA=;
 b=QavF20GOZLBwQFCOyvIBzBsK+akXOGMcSaXZ3Ic6lY26ixM69qMg4VfVG2pIgj6fLAWIIMiqnb42LCbw5BtpGLxTyccNp7YNTZxOK/YOeMAp7VLKgTik0vLLifcCX7rwAkeVNPbxoAlQkaOXBhKeX8xbGlZvfYijJrG5xs//KRRsLDdQpsGwSKDBZlmAMGxO4D6jssyAfIHVF/ZCQi3vY77zQqGGNAxpxu9dhvQH6t44tGLcI70Hm5ikslr0KVhMLvMx63WdP78gw5iVqZBwRMCphocRdyqHcDNUEBHbLWeeqoqRLEgLiFrjisYnjMpoC0nIvfgxyGBnDNfXYSsSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 19:57:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 19:57:31 +0000
Date:   Thu, 26 Nov 2020 15:57:29 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Silence the overflow warning while
 building offset mask
Message-ID: <20201126195729.GB557094@nvidia.com>
References: <20201125061704.6580-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201125061704.6580-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0201.namprd13.prod.outlook.com
 (2603:10b6:208:2be::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0201.namprd13.prod.outlook.com (2603:10b6:208:2be::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9 via Frontend Transport; Thu, 26 Nov 2020 19:57:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiNOT-002Kwi-9E; Thu, 26 Nov 2020 15:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606420651; bh=VxYPE3E+sHPNK6dNop/OBMCGP+HNdTG/C1gYcO0AZpA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=MU/VPFfTkC7HjqUE45V7w4NjI/2Wm55OMwdRUDApS+gaVgx2kmHmZYcw7H/ZDSVV8
         o5YC5aESQwbGcJIwECNkz8Y5dGel4EFu5pNaOcKhNiQjSpJ06pgiAAJbv+ioGColEF
         I4z7IZOUguhv58+NwyNlFRJjYp8W7F/Tz4ezbXK+B/lKoMFjp0l+USlCSg3HOL/5ca
         sLPmdp/fLuVnwF/eUgob1hzId2W/3mG7097dl5wK4wZLLNsYrQK64adkfV11pIq+mG
         LZaHWhhXiq+MHrLadoix0U/BuG0wZtkooLcdrvVCzx+yExI3kIFC+iO8+KrU0VDeRf
         v+vF5v9ATYhlg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 25, 2020 at 08:17:04AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The coverity reports "Potentially overflowing expression ..." warning,
> which is correct thing to complain from the compiler point of view, but
> this is not possible in the current code.
> 
> Fixes: b045db62f6f6 ("RDMA/mlx5: Use ib_umem_find_best_pgoff() for SRQ")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
