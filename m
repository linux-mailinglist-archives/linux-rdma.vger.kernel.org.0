Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1072FAC2B
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 22:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbhARVCb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 16:02:31 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:55527 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388380AbhARVCE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 16:02:04 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6005f71c0001>; Tue, 19 Jan 2021 05:01:16 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 21:01:12 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 18 Jan 2021 21:01:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+7DHV22/7L8Pmc3nUw/buCPlFq7rdhjfpNZJ5KVmLX9V6eE+tDn72avsHa0ybsrhPD6CzzKbJuYkgKW26wTET/soxTZfyn4nLUZvKeiVXVNQtKf+bAUoGJHgbmhR75d33G/I616PLa8Xek1nugOMrTyjxkCDTH1gq0TAf34EB2oRhS4BAKLkaefXrOOZ28PAGJ6PyTEZ350UQygoG4BRRZcG++tFRtp8aoFX8dtjT5427bxRxuZ8VC6KCftTzguSMMQqhpy6zwArTJRyQH/FT9crHSuEayQmX27TxHJTTFMnjQpkNgSUO6Ctr/ylrLO6EErb6lRTbbimQQyJscoqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz70eeU7BktpAAyS3txpP8CEqJcRvv1tvXY3oYKyMWY=;
 b=IhGkIS1PzOoqmHj6VNPsp3B1YYF2h52KSDksXx3u8ugF589oHzfc58al5AMFEMAkZ0cLplUD86xYcxMopELt8ji0pAlIf7NLBLli9TV2HMbXEaxGmMQGTBTkQiNI8O4863DGEhIX1WQaFWqDMocDFVWqT2EtZyGAMnsfLs4MWL+OsomZndnghP/RqH9AH8iiL8J49tevemuMwRFs8kmYvbg6c7zXCqKy0Cgwaie9L0J5ggyIj+fivzaCLC9cZjrCTeA3FrKVpYvrQ6PdLYsH8HL0qxlKk7fKfTS+pFRHuP6LVQQafGhHFJsjlIyS72LfAgXsP+gecwdf0f3D/81TNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Mon, 18 Jan
 2021 21:01:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 21:01:09 +0000
Date:   Mon, 18 Jan 2021 17:01:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Create CQ with selected CQN for
 bank load balance
Message-ID: <20210118210107.GB797553@nvidia.com>
References: <1610008589-35770-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1610008589-35770-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR18CA0030.namprd18.prod.outlook.com
 (2603:10b6:208:23c::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 21:01:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1be7-003LUv-Ud; Mon, 18 Jan 2021 17:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611003677; bh=tz70eeU7BktpAAyS3txpP8CEqJcRvv1tvXY3oYKyMWY=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=EdtTqsLqxMNEvROuR6GH8kAwNk4+MgKcxS5v2+VwteY4+56y+Nbhb7w8v7Pbabo5m
         S/U/oV0bvjX3r26BQ5TaDO/0ApmmANn2e6JZRXyMASQ0xpndrBwzPj4feikjmPrITj
         wEi78ePXjwvbyP1Jn8fQT0Zo69RD7KMi7SRstwO2DNyAHt+3wrUOLAMNo51QFUVmHX
         SdoEw1/IprlElAWxCUlV6JadsNSAOxBJh3sekKnJ46P/i5EUpq3p+iH1ymQN64Gbwx
         TBrRwaTbb0IICd6Cz8wE6CpYP00hEFsB9rO4KiVvuv/sr5iYnH8oM+kj1Y9HrEfvds
         4ZJqIVBA0R0kg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 07, 2021 at 04:36:29PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> In order to improve performance by balancing the load between different
> banks of cache, the CQC cache is desigend to choose one of 4 banks
> according to lower 2 bits of CQN. The hns driver needs to count the number
> of CQ on each bank and then assigns the CQ being created to the bank with
> the minimum load first.
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1:
> - Change GFP_ATOMIC to GFP_KERNEL as there is a chance of memory allocation
>   failure, and change the spin lock to mutex lock because ida_alloc_range()
>   may sleep.
> - Link: https://patchwork.kernel.org/project/linux-rdma/patch/1609742115-47270-1-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_cq.c     | 115 +++++++++++++++++++++++-----
>  drivers/infiniband/hw/hns/hns_roce_device.h |  10 ++-
>  drivers/infiniband/hw/hns/hns_roce_main.c   |   8 +-
>  3 files changed, 105 insertions(+), 28 deletions(-)

Applied to for-next, thanks

Jason
