Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB3BF2999F6
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 23:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394886AbgJZWzE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 18:55:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15214 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394885AbgJZWzE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 18:55:04 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9753cc0000>; Mon, 26 Oct 2020 15:55:08 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 22:55:03 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 26 Oct 2020 22:55:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2mxZiLY9qs5vd+ch90cWV7/1hUhvw7cIRQKNdaNLHVaMrKw8XfNyOlVcxOZuyu1iMaKnCeoav6DI84Id0RbqBdv9vPkIX5qR19XPnW2sVujLx0Fs6m0xV/09ejZ3MnX0O5Q296kUU8mGV9/nO6fMENKhWbNk0RtgjGbKldjVKHZLZBXAVyNPgzEyo7lqcaOYe2oU99F+1qa2h6edFwsOI2g73Vog8fEMSBiR0jrd0EjHHVG9yJWEAeVR2gJJNByLloPrpvzsNH+OtDtBobtst1sn0d3sK09R3O58VMnWQmMb3HtaPYUlpKjDd0suuQMuskziOWVzNV1mkNKrCRMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H69dbHhG/k/Y5cAzLva6gR5uHaZUphun0pkvJKhQeWY=;
 b=TUGsFFUr6KY/INwIBrFn0u1duqvvuiAKPSVLgsQwBCfyMT2wI1s5y+HA+qcGEtlDKiQrS+Z9R/8qgbA/LxQarPG5XdQmmH5/OAbOtk+JNjLRSF2528Up3jqx4kvAjAGKaMjmyu06wd4MOuMpq+QthXZMASmBjmfKBGJaHtd7ZDJ8OrC2q38zT5yQYLZuXWHYrLDj/bBGeCTuOLPkRVoy/1CDABnbJihPKHT5l+tH3XCPA/HI1wtzMc98QClvGLNY8hcp5lgMmGnhEaabgup5++VzgZIS+Kse9WPzALLJ+j60sjlOu9AFgNdjGspkv6lh3cvjtvPl7BNZmhZqslSGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Mon, 26 Oct
 2020 22:55:01 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 22:55:01 +0000
Date:   Mon, 26 Oct 2020 19:54:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-next 0/4] RDMA: sprintf to sysfs_emit conversions
Message-ID: <20201026225459.GA2152135@nvidia.com>
References: <cover.1602122879.git.joe@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1602122879.git.joe@perches.com>
X-ClientProxiedBy: MN2PR22CA0017.namprd22.prod.outlook.com
 (2603:10b6:208:238::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0017.namprd22.prod.outlook.com (2603:10b6:208:238::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 22:55:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXBOF-0091ta-HQ; Mon, 26 Oct 2020 19:54:59 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603752908; bh=H69dbHhG/k/Y5cAzLva6gR5uHaZUphun0pkvJKhQeWY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Wy1ERsjVmRHE1nhLah6omYzPJOLytXxth5AxzFQgN0REuFyLV9s+wHydQ3llXyi6J
         lkxsHI5V8P9flHoGD6bf41V42Mq35sysyXJ7eKeP6hB3lQyJiroyljhVglKTzMYDuU
         aetCH+aprNfUi1c059e2MkfbGp6x+xtpSQv7FJLD17QKggJ3dmL2OZEqX0yobcAql2
         DyxC4DG3IKtcMO5UyhuDjXFOY4qDid5VyE03ovdzElbdatr+3Z8B4I1SvuQcUuWFiQ
         +m2q9cfpsXvSlI5hUp2InMZpAmjzlyTrvN1BUijPwE81mzk15ITawPANfJ+1s2tmEd
         Pg4VviGP2Ggtw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:36:23PM -0700, Joe Perches wrote:
> A recent commit added a sysfs_emit and sysfs_emit_at to allow various
> sysfs show functions to ensure that the PAGE_SIZE buffer argument is
> never overrun and always NUL terminated.
> 
> Convert the RDMA/InfiniBand subsystem to use these new functions.
> 
> The first 2 patches exclusively used coccinelle to convert uses.
> The third and fourth patches were done manually.
> 
> Compiled allyesconfig and defconfig with all infiniband options selected
> no warnings, but untested, no hardward
> 
> Overall object size is reduced
> 
> total size: allyesconfig x86-64
> new: 8364003	1680968	 131520	10176491 9b47eb	(TOTALS)
> old: 8365883	1681032	 131520	10178435 9b4f83	(TOTALS)
> 
> total size: defconfig x86-64 with all infiniband selected
> new; 1359153	 131228	   1910  1492291 16c543	(TOTALS)
> old: 1359422	 131228	   1910  1492560 16c650	(TOTALS)
> 
> Joe Perches (4):
>   RDMA: Convert sysfs device * show functions to use sysfs_emit()
>   RDMA: Convert sysfs kobject * show functions to use sysfs_emit()

First two applied to for-next

>   RDMA: manual changes for sysfs_emit and neatening
>   RDMA: Convert various random sprintf sysfs _show uses to sysfs_emit

Will probably do these two later this week/next

Thanks,
Jason
