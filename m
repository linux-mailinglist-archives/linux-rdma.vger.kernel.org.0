Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17AF2C4261
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 15:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgKYOsJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 09:48:09 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:1994 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbgKYOsJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Nov 2020 09:48:09 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbe6ea70000>; Wed, 25 Nov 2020 22:48:07 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 25 Nov
 2020 14:48:01 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 25 Nov 2020 14:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U38v7LTkELZyl79xqz/v2sN4NYBfLWiLas2r0OYsZqvcR0qdIbHDLt5uLwSKO1sUCD/q3ia3/kEOI6olWykqsqHiuNbvZey5zpRM+do5yZgl+SELsjkWrh7JQAFrD4peGfBuDkAnsNswWyS6fNH37YSpQ816yZ+y7dtZKEaYmVI3Tn5OsRacWCGh5QQ3jfTBGZOrd2JCDuCYMElFVGvT1h+xjoDq8kizXndMbGYSXZ54yJu9W2GYZ6OJIVMLzjosGv2/7mXJjen5hpF9pAEG9/6JYcj5BBh3i+VTC9/xB5oQh1vOk6HciTv1I0jCS1Wm0s3aZRHssoYYd4ajg24SYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+GkdcQvxW4R5ydOg/M47MRYgXFEUHWBakyG/K7In54=;
 b=KbKywOVK5QEgG6YSKjmUtB/RETCYeb4z0M7vZDDBnd0g7dlImZF5QtO1epIlkPPzDKguULKHnUlTd4PgHF+rBKWJ5VTIcVKXm5ondt/cjhyA+W1b49e846SGU0t/T4D9tQZXIx54fHwQUoSJeqSzgNYXzZ1rDy+Po47Gkwfbxh1cCt8swqY/k/PSqaYghN+HzeX+wXnuIv6KSpURYITUp6lh8H1GLIAHw/xkCOhd17C/dSMDCFO/lXqHl9mjxZQ6m2ko8xFdB2iztrEgU5WyzhmQ80BTq/jrXBecZMpaAf+mFAhi/wIvuGsSiLRkpmUfCeSI2e4CCIVtypGkHuDOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3931.namprd12.prod.outlook.com (2603:10b6:5:1cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 25 Nov
 2020 14:47:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 14:47:57 +0000
Date:   Wed, 25 Nov 2020 10:47:55 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shiraz Saleem <shiraz.saleem@intel.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <stable@kernel.org>, Di Zhu <zhudi21@huawei.com>
Subject: Re: [PATCH v2 1/2] RDMA/i40iw: Address an mmap handler exploit in
 i40iw
Message-ID: <20201125144755.GA298008@nvidia.com>
References: <20201125005616.1800-1-shiraz.saleem@intel.com>
 <20201125005616.1800-2-shiraz.saleem@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201125005616.1800-2-shiraz.saleem@intel.com>
X-ClientProxiedBy: MN2PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:208:d4::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR04CA0004.namprd04.prod.outlook.com (2603:10b6:208:d4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Wed, 25 Nov 2020 14:47:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khw5L-001FXJ-Sk; Wed, 25 Nov 2020 10:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606315687; bh=e+GkdcQvxW4R5ydOg/M47MRYgXFEUHWBakyG/K7In54=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=TLyY6CCZSMZrgwTOmyVsXUhWMHHnVkEFQUPkg61lp8oMeostwpSj/maQ9pI3dK50+
         BJ4t0mbcu6cLrSJcfywmBbAR3lcyoYTxGxz8tpYe9kyoC0O5mzMiSvBs452mYBuaRm
         9M5sTOJLc072VPWoLa5a3/DU8CsVCelN6RILHimZQrkXhMZ6/KVKNfB4OeQtEeV+J1
         G2m+Kz2Mv+IOOOLGOPA5L+4ILl8HY+6o7RV+ptslaTyXE4s6SXeaCeOAHhszxrKx4X
         HtDOxwNMoWbfmxkjhNOrUYj+MYJuO81y2kpjqlf7kgu6uOg/H7JspWYaoaf/Csep3z
         GsFsZsdQkEt9A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 06:56:16PM -0600, Shiraz Saleem wrote:
> i40iw_mmap manipulates the vma->vm_pgoff to differentiate a push page
> mmap vs a doorbell mmap, and uses it to compute the pfn in remap_pfn_range
> without any validation. This is vulnerable to an mmap exploit as
> described in [1].
> 
> Push feature is disabled in the driver currently and therefore no push
> mmaps are issued from user-space. The feature does not work as expected
> in the x722 product.
> 
> Remove the push module parameter and all VMA attribute manipulations
> for this feature in i40iw_mmap. Update i40iw_mmap to only allow DB
> user mmapings at offset = 0. Check vm_pgoff for zero and if the mmaps
> are bound to a single page.
> 
> [1] https://lore.kernel.org/linux-rdma/20201119093523.7588-1-zhudi21@huawei.com/raw
> 
> Fixes: d37498417947 ("i40iw: add files for iwarp interface")
> Cc: stable@kernel.org
> Reported-by: Di Zhu <zhudi21@huawei.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw_main.c  |    5 ----
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c |   37 +++++-----------------------
>  2 files changed, 7 insertions(+), 35 deletions(-)

Applied to for-rc, thanks

Jason
