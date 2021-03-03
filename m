Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B532C3C8
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Mar 2021 01:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhCCX7o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Mar 2021 18:59:44 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19966 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbhCCRXc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Mar 2021 12:23:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603fc5e60000>; Wed, 03 Mar 2021 09:22:46 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 17:22:44 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 17:22:43 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Mar 2021 17:22:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyGqvJf5315XGJ3hfugT/7DtWfIk/xuhLesAaBwmqiVM6+ihVQF9gwaejBk/2mslJR7camxbOjOVLkMxGhenFb67zz/HYTg4cD9z++j9fIj+1EDiHIQ/a0S/oLPF2AhWlC/E6uouyF616FlOSJwShIS5WpqIkeTXr5NusGBvrUm1XvmwZugOi+2HfZG1ntlOCf4MBxCMlzCEDz+zd3L9ECYW5va3XAzPf+GT43/mjgfqKzV+82/q8dgZw8XVuXa5pDJzp7n6RRHVSbCUpnBixX9Eu/9hNhfqdUHQDwYQH3HJ87eMbXWjkaL+CFeZf7r2xL1FgoEL9s8dh0kt8jTLEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2e6R/C8ZOjRryQI4cwzXwsw6pike1c728++lnFWjNEA=;
 b=A1juvSih+rhywG/p60x6PkLbOerUatiBcXdz9T5W+5GR8+2B3tud16dn4LsgPP83KX4UU2XXSQRZcNqxKGRCASWVFAlu5eBZzavCVi0ikxIDmMtPOEaFOLLgE6gdIXF3tWDy8SF/rXW/ng2r+ibWgmBOrRFxFAyodNh3u803l+i7JJQnyui+R58Rztj8MSAuHL0QJfDv0JMgh4jzOPrJKvNa9JjQ/PgOKj9ucwlShAAZUWdgxA+gmWZFPND0mM+lfoIfoNOY22Kb4a1hxSi1F/LPjnS0zaQSvzUnjkeSU2Szbz39cGcCYNWRWS0Vq7POXgeS7Z4CW2lvfglxu1zsQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 17:22:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 17:22:41 +0000
Date:   Wed, 3 Mar 2021 13:22:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc 0/2] W=1 compilation fixes leftovers
Message-ID: <20210303172239.GA1480968@nvidia.com>
References: <20210302074214.1054299-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210302074214.1054299-1-leon@kernel.org>
X-ClientProxiedBy: BL1PR13CA0481.namprd13.prod.outlook.com
 (2603:10b6:208:2c7::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0481.namprd13.prod.outlook.com (2603:10b6:208:2c7::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.13 via Frontend Transport; Wed, 3 Mar 2021 17:22:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lHVCp-006DHa-CJ; Wed, 03 Mar 2021 13:22:39 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614792166; bh=2e6R/C8ZOjRryQI4cwzXwsw6pike1c728++lnFWjNEA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=fJnltdO8UI9W4jJ5xuOFL+ivryfsrRHRASi2DiBUt/aFkJCrIfqqIWFDP/G8KoD0Y
         zVzDkoeag6gYa0q+dpstD6+3l1llE7t37YwJLJXiOZ9UTFwlHcCcDPNVnwZQUHPnOX
         m+hlu9YHT6HhCQ8WYuEFb0BnUK/Pkco+23PVBeLW0EEUQ3AElN0RxoTl+UE70riWFV
         /xp2YiGV5HBfVV6L8JPNO2uDGVGKEqsba88GLE8GNxFROF4moyUXUoDnZEqYNfDSyR
         any0/PeiJfBr7FD4Iii3PJqPkSKvkrZVLTc4yOcJdisOCMzi2F5sLkJZH+1IRHrGOD
         UL0RPAlxNvWRg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 02, 2021 at 09:42:12AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Two extra fixes that were missed in Lee's W=1 cleanup.
> 
> Leon Romanovsky (2):
>   RDMA/mlx5: Set correct kernel-doc identifier
>   RDMA/uverbs: Fix kernel-doc warning of _uverbs_alloc

Applied to for-rc, thanks

Jason
