Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82B62C5CAF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 20:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405281AbgKZTox (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 26 Nov 2020 14:44:53 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:50220 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404872AbgKZTox (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 26 Nov 2020 14:44:53 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc005b30000>; Fri, 27 Nov 2020 03:44:51 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 19:44:46 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 19:44:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj84vb9vSwW6l7WVjR3TH9o0y0grYsnbadwkB6zQ0T+WEEwkzx+Q9pRyLSNvjflyH/XS+zWbMj2+Bg8NEWbyfX8Fc5GiEjs19Ge6harsg2zf/n4KPVM58M1lSz0MCperMSOf6w7DFhER2aVEL66iz4PHez+DYHYRaSoZqktkvI+Y5HTJFmXpM+x4h9o5pQsXUtrCqOa8c/rnkQ3tr3M8E/fzo6uuO7+Ntoxx27C1I7Dl8fyVJRstIfvh4EVNW5clpRasgn8gGbieSwpjwlBvZE9AcT4LTgtVoh6MziiNZaDPCjxTvrezfKGaAOM771eDAp3jriqMA5jk/KYvU3fKVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ2QmxqwLrL1oNJk7sSZOQfFi7TWvpwlAlnbOuE6Ap4=;
 b=NL5tTa8AG2BussfCGmI2u1ot+AqdgDmo0pbGsxNA01m29XvJb8bYs10KDSw265ZqfUOU9ViThUtOvvfGZWg39Vn6oBDZvsgPn9rYsjedaLbm4WzXQknbebG/So7vPHbttO9L0wry1lxeUpQgBRIceJKRMxuAlKWMdK0xo4b4hCf2H3/ZVFCsROB8pd1BqBwWLnSq7ILEHMfaeTpWFJ/7N3Bg1iELQZ4vh84briWn6TxF+uTFoaGcQ8j/WMO9RX+kHzLn+85gnNu1GVFp/EoeOqLATx3mIvw9zAJdVcbPA5FXxO7LvhsqSopDCItXsaC8OpnlIn9ZaY9abAwgiK/fNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4578.namprd12.prod.outlook.com (2603:10b6:5:2a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 19:44:44 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.024; Thu, 26 Nov 2020
 19:44:43 +0000
Date:   Thu, 26 Nov 2020 15:44:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next 0/7] RDMA/hns: Support UD for HIP09
Message-ID: <20201126194441.GA552360@nvidia.com>
References: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1605526408-6936-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR01CA0032.prod.exchangelabs.com (2603:10b6:208:71::45)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR01CA0032.prod.exchangelabs.com (2603:10b6:208:71::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 19:44:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kiNC5-002JiG-OX; Thu, 26 Nov 2020 15:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606419891; bh=iZ2QmxqwLrL1oNJk7sSZOQfFi7TWvpwlAlnbOuE6Ap4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=BgG2stmcv0d/4+EofD7k5tvcXt/VK9FqaeDh/qL6uLXRoFUlh8+dqVebjS0SOXk7Q
         iBedktBDB/+GCLCdhbiKj0J1caqOyoCHY1WODftw1ma0jalzePqezInpSATQdQGBwQ
         sBw/7yyxD+N+ugFyas+2cdmzDwEEbqeBUQo0qs3OYduOqtuOs8JFTqbn904PvOc87g
         uRSgHBwkYNiVkTZLGuKuMRcWljUbU88Usy76Au8FC9RGHKQye8mJQ9kEymOYGdJJPu
         oCR2zU/KQbZNuNStfdazmhfPt6qzGvTaBzIxx1DeKW4bEaOq5dC1qrfU+QMoguwozh
         YBykwyv0gYbVA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 16, 2020 at 07:33:21PM +0800, Weihang Li wrote:
> This series does cleanups on UD related code at first, including removing
> dead code, adding necessary check and some refactors. Then the UD feature
> is enabled on HIP09.
> 
> Changes since v1:
> - Don't allow HIP08's user to create AH and UD QP from userspace and add
>   .create_user_ah in #6.
> - Drop #4 from the v1 series which needs more discussion about the reserved
>   sl.
> link: https://patchwork.kernel.org/project/linux-rdma/cover/1604057975-23388-1-git-send-email-liweihang@huawei.com/
> 
> Weihang Li (7):
>   RDMA/hns: Only record vlan info for HIP08
>   RDMA/hns: Fix missing fields in address vector
>   RDMA/hns: Avoid setting loopback indicator when smac is same as dmac
>   RDMA/hns: Remove the portn field in UD SQ WQE
>   RDMA/hns: Simplify process of filling UD SQ WQE
>   RDMA/hns: Add UD support for HIP09
>   RDMA/hns: Add support for UD inline

Applied to for-next, thanks

Jason
