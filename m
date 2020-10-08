Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A32C287B90
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Oct 2020 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgJHSVD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Oct 2020 14:21:03 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:10353 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgJHSVD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 8 Oct 2020 14:21:03 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7f588c0007>; Fri, 09 Oct 2020 02:21:00 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Oct
 2020 18:20:58 +0000
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 8 Oct 2020 18:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gticIQNvEwCJSzvhtIYAzbHNXFyEbDOTFjap8nJ2C+GPDtwCK1rJNhgR2agLkEkd/+cyQtOo5+SHdSS6HwUXGZd+rx4yYAGc0dl6xV+00gtB8rges4ojhYdxWHrfGZ3mCUAom/BRAgF226drmBxG25647VFW1VSlVBDmb+mwWckoH5nWvkgsCKsxc2psV7RP2lQbYJkQs1UbaQdwgK2E/3520ZlcogjUcF8gprZsQCeEU4liZVqdJ5qqoMGCXUtYxWO1IDX9eax0dQJEG6WPEsdax4V2XC6Qmxaqs+jobK7rNJ3CfkLrJyigAoKA2CKSUe9TunIltzan7FF1Euy0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj1KD+NuD60F5OaIg2wl6LNEDJEzBW5v7qXlEWz0aGA=;
 b=agQRpqHt4AkLQrfKKJ+dUq8y6md5IUFglXoOnmwEV0VxF3R7eiByxxtQvwqIaJv8CoYljDLEEbNy6VEiXNZbTIQR7QA8hywgAtJk64/ZYra1wQrU3T6UWYfaSMaWV9UoT6igRtE/9iLl/4rOsoiK9sLnIyLyDZgJCOg2yOng4CMia2Pw069Ba4aUyy1n1ylwVhR5Dd+ylNDABQXEovzOMTgeKN4y+BePKJn2ea5QMK69mSDS37OqsPaC5k0svhVBGw+WcBt+nTkTQbwdOEz9USO0TYlryHk9fgOAw5+ftNFef/hLw11PjQ0Ei1MBpaaQJkdtlJanDt5haYFkUgrvqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1146.namprd12.prod.outlook.com (2603:10b6:3:73::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 8 Oct
 2020 18:17:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 18:17:49 +0000
Date:   Thu, 8 Oct 2020 15:17:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [likely PATCH] MAINTAINERS: CISCO VIC LOW LATENCY NIC DRIVER
Message-ID: <20201008181748.GA374464@nvidia.com>
References: <f7726a1873f14972f137f64a4d6cd35e530c6c95.camel@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f7726a1873f14972f137f64a4d6cd35e530c6c95.camel@perches.com>
X-ClientProxiedBy: MN2PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:208:238::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR22CA0008.namprd22.prod.outlook.com (2603:10b6:208:238::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 18:17:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQaU8-001ZS7-0h; Thu, 08 Oct 2020 15:17:48 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602181260; bh=Zj1KD+NuD60F5OaIg2wl6LNEDJEzBW5v7qXlEWz0aGA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=lm6ebONhzXZxTjg2WhLBFhX3KPfEfmn+sbzxF6jVtQA5xPMJ6ntE/Ei/LSq2X71yx
         C++ISQAhtZ4PFdfDyfdfrHc3hUZmzJuxZQ8GxYSnjP+nd2u5VlmtIx6I3eFMpQquRt
         C3ke2jrNfCe7hAfCdTZncCbrdgBOlaJZ//fHyYnrBM6bhqJk3/ozVmZLsWC3LK+NdN
         EVVZFl7T7Ay3jw34LP1ixerWQwXaa0t9l4iaPX9e3/jYrEtyTcwfWvJ/w+K8Rr1c8u
         jXnGO0ESE3Ac39BC1SXNVqrTrAwyBVOZXOVcw/jw0hd5xj8KlarNAa5nk0cyiU2L62
         v5dUUDIMcvkZw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 07, 2020 at 07:46:54PM -0700, Joe Perches wrote:
> Parvi Kaustubhi's email bounces.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Christian Benvenuti <benve@cisco.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
