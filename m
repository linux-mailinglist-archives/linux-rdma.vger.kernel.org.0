Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F72D6399
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Dec 2020 18:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392712AbgLJRbj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Dec 2020 12:31:39 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11569 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392714AbgLJRab (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Dec 2020 12:30:31 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd25b090000>; Thu, 10 Dec 2020 09:29:45 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Dec
 2020 17:29:45 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 10 Dec 2020 17:29:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCbr7wogg5X+Yd539Igho5jaJXYSYQWv8zTaHjJDT5iRfqljmNbAVmwquVV4A0IDsTuskNJXMGsRlI1oa/x9otIF4w1ZFJYL2eyUGazqdibHUxorFWAtrWg8bCUsyG1Tjd97nFzkFKLXl6VOTAAHMlbx83lLX23lyx/8cs8OVef5Keb6yZinqYXvoE4tBvC19GyLBe5eETW5MzTcgO0a2Q/3icFoY84BfXJ9HmubG1I/I9AkiqRbqvsPK7M7yO2105I6aD96iK2fNDc1Kax7vfbAnTmk/46R6LCqpD7sDnN7kdqvykTDB/FBdTKxfKPaKC6alTXJGWT3FldzuXMayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijhB3/xMnWFMU6pv3I+YOoyRHDzZS6DgitkxaOu5XE8=;
 b=mF4wVkMK07m35pJ/mwaeQqd7jkhTwAYA+cc6TC+rycwQvZVN/uDZh85nmn4JLsgx8oMRrzpCNytGZKK1qdZuphqjxmDnEN+boQEEvotXU9X3L+NBV9hWrXSS65LS429+ieMCGY3swe2ylAluMAC2pDPeL2Zu8HuV9LeHOTP4YKau93Rg0gCZej6j281u0dO3Z60LKoU9s9kWYroiceKph/qqpPx9p1scMJrP6wPwgkVurQ/KbZR3loOFMzdvUMkrze1v+psq4S84aPQimeBbVQtCK1J5I5VnwqMvwTcbXjIL5udnHgEBqo+j4HiNSPI7hHsJNTntVcx5nEk/ikvvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0107.namprd12.prod.outlook.com (2603:10b6:4:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Thu, 10 Dec
 2020 17:29:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 17:29:43 +0000
Date:   Thu, 10 Dec 2020 13:29:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] RDMA/restrack: update kernel documentation for
 ib_create_named_qp()
Message-ID: <20201210172941.GC2117013@nvidia.com>
References: <20201207173255.13355-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201207173255.13355-1-lukas.bulwahn@gmail.com>
X-ClientProxiedBy: MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0064.prod.exchangelabs.com (2603:10b6:208:23f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 17:29:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1knPl7-008slJ-ND; Thu, 10 Dec 2020 13:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607621385; bh=ijhB3/xMnWFMU6pv3I+YOoyRHDzZS6DgitkxaOu5XE8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=cawpmPkB6QKhHtOu7b4VSHF1zZpcmhJ7vu/RAZmL6K+BBO3wFzKnWZicAU00ZM+9b
         TIxX2OtRvk5S5j+16vj19c1exo42/AR4RhY6gd+d+LowLIeX5XoMFkHmB4z+GKTIVp
         /q9ciTKa1h9WYqR6aafV9JcIRrItmQrJh0hRkMS1sm9uT8Tixqregq9Avi8SfRfsmK
         9wnijmUL/pmC2PNOu4ztKL04l6oZ28+M2z+/16HNlxJ+tFkNeqQnR8HDa6o3PRUNMz
         lpJGXaAr4htqdiYKVLtN9eKtq3pyxIsExWCy52ie+sid1C5ps1bAq+qwBZGVwj18jT
         o00mHnCKWVsqg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 07, 2020 at 06:32:55PM +0100, Lukas Bulwahn wrote:
> Commit 66f57b871efc ("RDMA/restrack: Support all QP types") extends
> ib_create_qp() to a named ib_create_named_qp(), which takes the caller's
> name as argument, but it did not add the new argument description to the
> function's kerneldoc.
> 
> make htmldocs warns:
> 
>   ./drivers/infiniband/core/verbs.c:1206: warning: Function parameter or
>   member 'caller' not described in 'ib_create_named_qp'
> 
> Add a description for this new argument based on the description of the
> same argument in other related functions.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/verbs.c | 1 +
>  1 file changed, 1 insertion(+)

Applies to for-next, thanks

Jason
