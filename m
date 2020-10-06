Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410082852B8
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 21:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgJFT5R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 15:57:17 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:2157 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJFT5Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 15:57:16 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7ccc1a0000>; Wed, 07 Oct 2020 03:57:14 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 19:57:11 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 6 Oct 2020 19:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3JaJs71AmHNyeefFtO6CQSttK5OCQTjdUpFSsYO+N1qfeil+6VjFXjUWMKEaOwKD29/R7O/Bx6jv6c7TQtwCyC57qPbzlksrZ+dY9DnwN3o6hP2Xz5ymPdDCkLDVHYFYe2j+UvkRP52u72yhhD7lLPkdmMb0TbLZ6ba0XjTLdXQrA/Af9Wp0Drsvwo2XeXoc/LG7U0l4cErwbPsl65Dq+hzPlrpTCEw7ACEnINQsCpT1PxdudWrHpp08UAL+y3kV8TY2YeivrpXFKDkwrFh0VQKSKDt/Ss5RxbwSzwsputK/iudSrE4Npz4SOiQPzeAc9/triaohKpOf5j3oD5ZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIQgotZjbgtbePDGBorQQND4hYGxHZ/sSx6mYy8MD+g=;
 b=VYGdEYKDFdLtL5TUx/gXrvXkFoqO4E5PLgdHPMeNcdvbIFY0PYc/U2Zs9Uz78snVJz8GspJfXBO/wK67XxbxueVJC0am5NLd/lTk08At7/aOJ9CqI/OcCGKb9Mx+jhDtj3yXgte3NBrtI/+l9UVOAJ0ylXlAyhLUy9ogOscwIr73flQBuFDvpEy2oo3aLwmiaQQSNoMbASc30DSh0JbYy0eILHwT+BOTpk2y1IDlxJ6tL7Pgg5iqDnENrfPui8gwjhOA+1GzIvVHDsAJaFmykrTFzZhnhakJOrVFK6sKQHFYLOH+p39W9WPgv4K3MP9iF4rEfgJ13hxKNqT04byhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Tue, 6 Oct
 2020 19:57:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 19:57:09 +0000
Date:   Tue, 6 Oct 2020 16:57:08 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Colin King <colin.king@canonical.com>
CC:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        Eddie Wai <eddie.wai@broadcom.com>,
        <linux-rdma@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] RDMA/bnxt_re: fix sizeof mismatch for allocation
 of pbl_tbl.
Message-ID: <20201006195708.GA165314@nvidia.com>
References: <20201006114700.537916-1-colin.king@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201006114700.537916-1-colin.king@canonical.com>
X-ClientProxiedBy: MN2PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:208:15e::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR17CA0016.namprd17.prod.outlook.com (2603:10b6:208:15e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Tue, 6 Oct 2020 19:57:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPt5A-000h0z-4q; Tue, 06 Oct 2020 16:57:08 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602014234; bh=QIQgotZjbgtbePDGBorQQND4hYGxHZ/sSx6mYy8MD+g=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=m83MtDrOJBM+LxwGBAfahMXTwjGrRYOL/AE9RMIw7ua9+LNdsEqcW+HR4TQOtB/mk
         WoJPCRSkaWdf0rSG6yu0JZYTwDgrZD23IDsZOqpBVBtX6SyBhoghswQ8q3EBlVLy9e
         kgzuEiCxs6Rq0bgvh2pVboX0oeFmgyHZIvbEg6Dq5Q7DXZyTzxM5TLyUyM0LA+P39b
         tjziR0lQ8aMJ5ZB8P5ejnuBelaIpJmm4YMtEVuJO4RlCLpYuxDKFIK/BzYTm9wT40s
         pPui35YWVVI7U7OE8CXxyagYyY9ZD5qxPeoVHmQuDLYXT8LClswZF7BN1+GW/rK+QH
         LJkTyHF5QXWxA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 12:47:00PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> An incorrect sizeof is being used, u64 * is not correct, it should be
> just u64 for a table of umem_pgs number of u64 items in the pbl_tbl.
> Use the idiom sizeof(*pbl_tbl) to get the object type without the need
> to explicitly use u64.
> 
> Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
