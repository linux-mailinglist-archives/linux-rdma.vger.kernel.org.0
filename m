Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84858292705
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Oct 2020 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgJSMMU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Oct 2020 08:12:20 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6921 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgJSMMU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 19 Oct 2020 08:12:20 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8d82470000>; Mon, 19 Oct 2020 05:10:47 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 19 Oct
 2020 12:12:14 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 19 Oct 2020 12:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8cQ331dNC4xKqtCyF58PZgAyKRx5fEb1HaGANMh3IspevPYOxq8Yxm5djT+woFS0VU/x2S8nyzXol7KmDrZEXVhaQXZ/7W+UebRJYwKtRlQ+AxJbUorM+dX9ZJCVyI6Cma67/Y39ojZB8BE6Q9qNQTjLa0nxIZlVVfXZSwYy4cWyuGV+WD3OoBkYXq8Newd4Z7XM1iew3vfh1yCPp7OrkcNg+d9hXNqfMUB+zsZ9FsjAwzdE87/N3e9eAqu3MnNwgUSSVam4F3NfRQn+QXpF88w9s9EJD9sBiKIH5jVWpiUEi2YVUgfD+6eNsbK8gfZOnqAt/zfkU1CTVYNmmcz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7Goekc1I0phvgqL9/SAlEdHNSqYGq5Qn+9cpP1RjUA=;
 b=aftKo8I+XyyUZ5n5aMbY06dJoDEe4MZr17jky3iacdtzyuNlF+hv1EtaJ0vwPNxwInhkofyTpFmP6NzjMpPMrc/tFbtayluTD6/UuPCIOLvKOQrCc+iQ7JBoaZ4bPgPiQhKO4s9PM9w3tzmGX3j64m6qHeuRjlBm/3lMJn5bNvqRyvpGzrFzNnqAkRHsuUenXtzIFGjdV0tR7xK9+dawGqFTk1Ktc69UW98q9pONvXHw4qJfUxJa2l4K+bWSS7p5l6VDBi2458SLu0W+CQrt5z/5NIz5c2BuJuCizDFzE8Esdrl7EKxf9ECtk872SnFy84zLAfyPfZX+w6+hSyzUOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 12:12:13 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 12:12:13 +0000
Date:   Mon, 19 Oct 2020 09:12:11 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     "Ursulin, Tvrtko" <tvrtko.ursulin@intel.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Gal Pressman <galpress@amazon.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: dynamic-sg patch has broken rdma_rxe
Message-ID: <20201019121211.GC6219@nvidia.com>
References: <0fdfc60e-ea93-8cf2-b23a-ce5d07d5fe33@gmail.com>
 <20201014225125.GC5316@nvidia.com>
 <e2763434-2f4f-9971-ae9d-62bab62b2e93@nvidia.com>
 <63997d02-827c-5a0d-c6a1-427cbeb4ef27@amazon.com>
 <8cf4796d-4dcb-ef5a-83ac-e11134eac99b@nvidia.com>
 <20201016003127.GD6219@nvidia.com>
 <796ca31aed8f469c957cb850385b9d09@intel.com>
 <20201016115831.GI6219@nvidia.com>
 <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9fa38ed1-605e-f0f6-6cb6-70b800a1831a@linux.intel.com>
X-ClientProxiedBy: MN2PR01CA0013.prod.exchangelabs.com (2603:10b6:208:10c::26)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR01CA0013.prod.exchangelabs.com (2603:10b6:208:10c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Mon, 19 Oct 2020 12:12:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kUU1L-002HJW-Rg; Mon, 19 Oct 2020 09:12:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603109447; bh=c7Goekc1I0phvgqL9/SAlEdHNSqYGq5Qn+9cpP1RjUA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=aYhRkG9etqNTFwziHAc4PkDmG/qLHAOCx+JiCRSN1uDANegJzhv89U0Hdaf7kZ0th
         hDPKrAsdUJp0KEN9+L1QkfTwhbydSnYqEFQY+yiijuXBnKqhdCjA6VvVRO9U82YTM9
         lxdk++duVLkMT96Hpe4cvM0v5QqEtxClSe+3SVsuIUjVfEnbqZKdQL4oe5W2aaTDVb
         ojDgQeiox4YyfxE4fzRAzUYS3ryEOYaaoAeW6/RuVgomL9++34NtxH8vgP8N8FO8bz
         dCc9gshtsT94OxwKgfLQBogmSpJr2q8bjNTc2x0VWGBMV1ZVPN9Ds9yNI88+xVqPmC
         ghKlVUe08F6QQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 19, 2020 at 10:50:14AM +0100, Tvrtko Ursulin wrote:
> > overshoot the max_segment if it is not a multiple of PAGE_SIZE. Simply fix
> > the alignment before starting and don't expose this implementation detail
> > to the callers.
> 
> What does not make complete sense to me is the statement that input
> alignment requirement makes it impossible to connect to DMA layer, but then
> the patch goes to align behind the covers anyway.
> 
> At minimum the kerneldoc should explain that max_segment will still be
> rounded down. But wouldn't it be better for the API to be more explicit and
> just require aligned anyway?

Why?

The API is to not produce sge's with a length longer than max_segment,
it isn't to produce sge's of exactly max_segment.

Everything else is an internal detail

Jason
