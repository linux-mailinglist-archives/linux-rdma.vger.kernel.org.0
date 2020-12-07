Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309392D1AA1
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 21:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgLGUhG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 15:37:06 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3361 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLGUhG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Dec 2020 15:37:06 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce92490002>; Mon, 07 Dec 2020 12:36:25 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 20:36:25 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 20:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGtEfcDLs8q6QdQRc9B5tJkoCUNpGLiCrW5G2coSyIBjwfJ4QgyBufN6ul0nE41H5iL6UaYHFkPxV/D/9agvGT8SLLy8Fco3B/HN+/mXrJFpjfx7TGP10e9r45fIJ34bq+7lLDL+nF3xpqEdjEbmiKfWrnSjrQJ0h8KN4jl6O9Qqh4htoYVB0EEAk3qXm7TCdUlEjA21ll+JI3t+38TZET3THwdAh/LkwUeItbF03sA3kABEFwx4/PYXgDkGUESLv64ZO5j0DSdf5xRSsVWswT71UUwWFOnSy7LT2vOqQNecrmnPKtOkOHLcxC4IJyExBGgUVi6Z8Q/w0b/WxKSVeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO0mGoNiHTq5VZ9qyuxh5CTz0WnfFYuV7MnmEK78TWE=;
 b=PfEBTM/413LdWslDERGXbI2B2p3+XHzfbi6yNUG0isHhkErLy791168IZYxPrHKnDXUCEG9bz2Yy7Bld1N7NUSeSnhOwNU+F/n5QmyDTCt4cX0MNekypIY0tMUc7l1/f0QI3kWrZiU774HiHYwmtrfWSy1IwEymGY1M66ML8oPHfSr3R4ubA+g8UBFfbzJYwCexe0PmHLBE6gU3rsC6CgwiYJmsZQGVQzmxzn7afy8q7So78QyucKh3U6GvNsYBBbOz2PYvn2cuqAVfEiLbijW0IDE6O2I19PkR2xbfxW9YyVYjaf1Ytq5y5Lbax0vrYU27thCq4ZNkekzhvsn6YoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 20:36:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 20:36:23 +0000
Date:   Mon, 7 Dec 2020 16:36:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Avihai Horon <avihaih@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH for-rc] RDMA/core: Fix empty gid table for non IB/RoCE
 devices
Message-ID: <20201207203622.GA1826363@nvidia.com>
References: <20201206153238.34878-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201206153238.34878-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:208:1a0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Mon, 7 Dec 2020 20:36:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmNF8-007f8D-3N; Mon, 07 Dec 2020 16:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607373385; bh=LO0mGoNiHTq5VZ9qyuxh5CTz0WnfFYuV7MnmEK78TWE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=VrZ8kNmdun/BoS84nbDRacqDdMKNAGCqNC3GqtvgX1DL5rnNYBu54h7vkRpJNU3zL
         UXCSwCP6Z0yRvLHWmRMJMf+Jf1PL99iWtcKTYQVdwjC0ZimUyJSEOXjKucxydv2NM9
         PDhCJg/v23hCVv63bK0jutXpjdrgvbdnWT72h5dazfntK3uunKXz5AQkb2/AUG4SPJ
         vOjEJPmTVSNCHgfdt60AQmodfUvxi5LNVAna2IoEPH0xFLrx9luPReWZ/hyKXvMa/L
         tEcDLoeLoZ+thIOSBIvdg7nkuXAxXeLI32u9+aA2UqzmpYpWtHtuCNrYe4FlnXDiN2
         UDYvqfSN2D5HQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 06, 2020 at 05:32:38PM +0200, Gal Pressman wrote:
> The query_gid_table ioctl skips non IB/RoCE ports, which as a result
> returns an empty gid table for devices such as EFA which have a GID
> table, but are not IB/RoCE.
> 
> Fixes: c4b4d548fabc ("RDMA/core: Introduce new GID table query API")
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/cache.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied to for-rc, thanks

JAson
