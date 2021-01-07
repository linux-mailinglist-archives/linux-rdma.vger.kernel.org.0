Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA902ED649
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 19:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbhAGSCX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 13:02:23 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19299 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGSCX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jan 2021 13:02:23 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff74c870000>; Thu, 07 Jan 2021 10:01:43 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 18:01:42 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 18:01:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpjJETDxv+1jyapFn5AND9pUIjkJKrnB9MN7MXCvlaKIDuDNtXThHPrjVAvB9P7P37G/4d/6secZSQBWtmx7s3eilRm91tEcfKIHhM13JfcYAejIywSyqMeY77BfDoArvgGx6Hz7WZsIfGHb5hP12cFWO++9dIE31rKc23wkj3+EVV8L2+ILWEkAmDDUnhXPd5lwSWuKwkF6ZBw8NsjbYc8yaSoiX9Z37391ccsEFz0VKePUjbyVqmoTJfYOLAoFqZTW1t18bFZE0Zyc1VK+ECAtAi2nTXprnkHPX+5nNXJ01xlKGN77KnQOfd0FPFpnG7k/70vFEw5g5QmzqVzbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2+krggaJerRDLkTNkPJd0CrQ6g7delh1DgOE+QfRy8=;
 b=YhUWgN9RkwlDoX9fa7T1VTb+/SdwVevqbTG827h5Rgs+fNoodS3RF9dmDU4gCGnrPPFcTBg/So08ZTYvrH7nFpeqvbUaiUU0KZwjrYE56O3p2gRGB4iuEPC4idi/KzteLQo0tlTCxClOXkz/Ka1/u25YeMzslF2Bs8I1wvgl+r8GUvbNhHMiFyl46jm6WfBypuGu2f+G74qyvuEipt3Nno3vKmXP+6IqQfzPc/0zdJhLMdSavbsrMFH0nIyxJuz9qUzSp5JNEv9pvlPlZTcCmTfWGPE4cVdVj+EpWaaWhRsUJ3luvCO787/NiPk7loT+OFkSU10AOG+OF5I2ga/8zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 18:01:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 18:01:41 +0000
Date:   Thu, 7 Jan 2021 14:01:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <trix@redhat.com>
CC:     <mike.marciniszyn@cornelisnetworks.com>,
        <dennis.dalessandro@cornelisnetworks.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IB/hfi1: remove h from printk format specifier
Message-ID: <20210107180140.GA904155@nvidia.com>
References: <20201215183509.2072517-1-trix@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201215183509.2072517-1-trix@redhat.com>
X-ClientProxiedBy: BL1PR13CA0401.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0401.namprd13.prod.outlook.com (2603:10b6:208:2c2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Thu, 7 Jan 2021 18:01:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxZbQ-003nE9-1D; Thu, 07 Jan 2021 14:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610042503; bh=b2+krggaJerRDLkTNkPJd0CrQ6g7delh1DgOE+QfRy8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=iJ+bXuZ92iDllSKAZ1RzfOcOJ8LnKVTTcniZt+WNfqROt0g2zFqxklfOixNxbf1A+
         oFjvX1qJM9RCjSFplFDLC+bhQSk7sSSVH6NLguT/3A5nJzTljbcl78X7tZdh3xtbFG
         j2wYbBJbMkT0lripgbwXYdLlrXHLH8SHPI1H+yAImq2+KklWjEtryc+NJLFkrn82US
         B3NPrVAwTvM5cG4/+em8eYv/8eUPTqIvuI6PZcH+P1cFznE1FgBgcmtOMWJnVunbRV
         FCDa322ncsX3jEkOma/ouBJ8jFmxZe/eZjxnm+DSqGpoEKHTWl5h9VWRmYldF0TvcE
         t9OKctgvk6siA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 15, 2020 at 10:35:09AM -0800, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> See Documentation/core-api/printk-formats.rst.
> h should no longer be used in the format specifier for printk.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> Acked-by: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> ---
>  drivers/infiniband/hw/hfi1/sdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
