Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4610D307740
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 14:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhA1Nhu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 08:37:50 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14463 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhA1Nht (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 08:37:49 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012be050000>; Thu, 28 Jan 2021 05:37:09 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 13:37:09 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 13:37:04 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 13:37:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgcmtdizXojmFfMRy5uJySBC328rwOYHKwNa5NL2Z9aURj8GRs8JId6K35GYBglpU1thjXC84SJQ5gGx/KqOTX977rHJxC98P2hecCh8i7O7+h+WRAk2tY1rNd8vbIRjhwY9dCKz7qxVqlR5P4YRGh00H0YJATdUc+9nznU+mb0J0P+Z/2aC/aIUwJluJTySAhKWhjV1jQKwk+RZDcXaqJnm41uy86m+B/7VpmsNKfrnX/B6U2158/7oFbYNSckCHMUZWPosjUlydgf1Bpp34YWFbO15KVrR+cQXAdVIH7FmyVfSzY93Pi2+LOK78s+NPbHgZUhiYm4zehKeUEppBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQgrRZ/FJFVUx9f3LU1Ik81psTNgT20uTkwFqUng2WA=;
 b=FCPq4q8gqBr80+595z7L+Cx0n6dpC+hbWIkMyqIoZOFyXhiHuVmeFTMKyjiNrsf1YP/2mlPXN83AY201ghY9haqRHqVNnCtXV9qikxchZ7/z1qoAcFm4qtg+fX9CbeAQoBTgIFu1o3YS6WFTWzMh/keGYbXPuicaLR7xAZfHa1lR0OtgZngdWqajBXLYl7OJ2wu1+9+1mmvjuutIUDUTPNvG0NIvDFz8xfQIXaZah+EExbuC98ZQ0SLLby2KfN6eyAhzQZUXVdabVqNDBgI7Car1nDr1OyTzoqisIG46KCVhYSxClyV0N1Qu/Cg9HBgFlhkdEanbIGA8GoufgUIoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Thu, 28 Jan
 2021 13:37:02 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 13:37:02 +0000
Date:   Thu, 28 Jan 2021 09:37:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 0/5] Add irdma user space provider for Intel
 Ethernet RDMA
Message-ID: <20210128133700.GE4247@nvidia.com>
References: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: BL1PR13CA0214.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::9) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0214.namprd13.prod.outlook.com (2603:10b6:208:2bf::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Thu, 28 Jan 2021 13:37:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l57To-00036N-Nn; Thu, 28 Jan 2021 09:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611841029; bh=uQgrRZ/FJFVUx9f3LU1Ik81psTNgT20uTkwFqUng2WA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=BwjeUHpuTnQTGnWdaHbokfe+eW2rqXkOKNBYM5VAzyHPKRNgCEI11p88xQgEsj1Bg
         Zk8/GjMpOF1ywmadwyhzrHzMn0AIARunrxElK74qW00KBhKLnQ6M+DU2IXgwzkQ1wP
         QMhy9rIwkWDmSB065MHkixC2tYLLRQFkbS+dIerzxjBZ3MhswKhdDU/SyZy8wEt3rY
         GKetcFAco3tFGwYGuLK1qUgheFSaU7yVKfh9HJudLQZrnYyXp746+cF3DpKmZtEaJ+
         jXWUoIwvq438ocAMF+k+Q4N1KIKqYvUoNUSMePWSVOrqChFYuFbZfsSyUjMW0aZCMi
         M19xpOCyjf0qA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 09:56:59PM -0600, Tatyana Nikolova wrote:
> This patch series replaces the current i40iw library with
> a unified Intel Ethernet RDMA library that supports
> a new network device E810 (iWARP and RoCEv2 capable)
> and the existing X722 iWARP device. The new library is fully
> backward compatible with the i40iw driver and is designed
> to be used with multiple future HW generations.
> 
> The corresponding irdma driver patch series is at
> https://lore.kernel.org/linux-rdma/20210122234827.1353-1-shiraz.saleem@intel.com/
> 
> Tatyana Nikolova (5):
>   rdma-core/i40iw: Remove provider i40iw
>   rdma-core/irdma: Add Makefile and ABI definitions
>   rdma-core/irdma: Add user/kernel shared libraries
>   rdma-core/irdma: Add library setup and utility definitions
>   rdma-core/irdma: Implement device supported verb APIs

Please make sure this passes pyverbs tests in both operating modes,
confirm this was done in the cover letter

Jason
