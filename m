Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A562B4FE6
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Nov 2020 19:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKPShV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 16 Nov 2020 13:37:21 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:28830 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgKPShU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 16 Nov 2020 13:37:20 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb2c6de0003>; Tue, 17 Nov 2020 02:37:18 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 18:37:18 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 16 Nov 2020 18:37:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIjus0kZR28Q3f4cHt9O9lnmVU6ZRLwz8F2LMyOd+68ICBwPSHI7B8FuPWa6BNYpYy5tNVxohPeC2FXeJvjEM263vafZUQ0T03q+9D9NmOoh0sIcWe0Gh52ANBeHxCX97wXci7d3bRtAomhJ+nXF1NfbatEKxeO4K7Cspgmbsai5H5K+7DKtChqhfDh1KX2oYN1lOnwE10UQ1XDbfLJLdmjTHA8g+Z2Ea3DT+LS7LaiP1VaIMBKJY8c37pUcZ+NLLA4XUkSwiEUcZhqKrxkPxGAo8rZMutWSoHowDUnDqp98QgOUfhQTpDkVEvZNCa6GTookjwPY+woq61RbmpBWcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt2v53qA2CxlF8QLLa+7aAT6lghYxKIMCfWSg3As8aA=;
 b=htmsxvb4hzc2OGiS15mUa1UpIce4ZmBn0Wz1cTPRW+3KqOZeL5+9OJAhxAAO+4CmgQphvYdX8BCBSZSJ/5fvFK70VSLGY2f9cQEpVY+FjsnsB7T4xNdYMTfvS24jrJymmPf/J4WjvO+JliJ2nyfkXbC619uSJK+xT+opUaVB7TKZxiiOYvxhwtKgXqiVHeCXGisjLQaKpTwoawUBZNx8MWI9PY5UmPGPtf8UsBNmmFjcwy5+inomdAFtNJgXGaKsqNcq7CaFxIGt+I+0ugt5yr3pV+hAdooMtYWFjUc2QroyedrQk5RKdUGqgMy0N57XKNohjGYH3xFBSbGJnjhk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4780.namprd12.prod.outlook.com (2603:10b6:5:168::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 16 Nov
 2020 18:37:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 18:37:16 +0000
Date:   Mon, 16 Nov 2020 14:37:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH wip/jgg-for-next] fixup! RDMA/counter: Combine allocation
 and bind logic
Message-ID: <20201116183714.GA1526424@nvidia.com>
References: <20201116062901.539483-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201116062901.539483-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:208:e8::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0018.namprd20.prod.outlook.com (2603:10b6:208:e8::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend Transport; Mon, 16 Nov 2020 18:37:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kejNK-006P6Z-Fm; Mon, 16 Nov 2020 14:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605551838; bh=dt2v53qA2CxlF8QLLa+7aAT6lghYxKIMCfWSg3As8aA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=kw0rw4pNdP8xZUYsVXmL1hxMcYRjc8AhyQUyPfkYg7/Y09zKuWS5IHbC90DxUG3Xq
         HO0P455n4Hlq9sfR4q8PBr6TBu7xmkQScghw0YADvV6N77OODIj0D1MheJQVFbrt4j
         Yj1b3PxXNaUKSXgEWFxXa8Z8LtDdLa/t79ZGeipg7KuWNRyqZzG1p9NHgAOq6jJfVw
         IcMZU/TMxUcKiGLNnnJOqS98GgWV5W9l9Q13jitlsxkDdYEzEtv8xCPrNjrvuKVPhv
         AgFQg1YHMRX3ZFphFI9nO69HIzGDxGHbHqDDcxcIalLgsk97bj7Y6UbyCAS6DdnM5i
         wHg2gpK0QhulQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 16, 2020 at 08:29:01AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Jason, please squash this fixup to kbuild report I got tonight, Thanks.
> 
> --------
> Failure in __rdma_counter_bind_qp() will cause
> to mutex_unlock(&port_counter->lock); call again.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/counters.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Ok, done

Thanks,
Jason
