Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7BD2B0B71
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 18:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKLRlq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 12:41:46 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13242 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgKLRlq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 12 Nov 2020 12:41:46 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad73d40000>; Thu, 12 Nov 2020 09:41:40 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 17:41:44 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 17:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMAgl96/ARc5dlF6fQ63XDemxq3kK5H9gwej0ov8Is/X9Oy3rgGPAnkrqH8+eI+PGinzOKYoSiSZy+OOK996v74amIf2N5DKPp+0SEwaW4Zo8FK7b4JHk5TUWeMFKKENr6JWmhpGEatojcuBOODIcPty4cQRhD7jUxMMtvGY1PSAlEyJbP6//HNnx/n56OFS1ZIIA6d4CbbKHQtZ9Cb1rUo+pAAjLgGExPMRsOj0UA3yneAez3MEJk3lJ7DOSH5/gr/bZuDlIg7zfZkyKs4G67VClXDZFRN3Md0q165Hx1Avoa3P8akDCmN9m8xuqGV8v9/8r9fS/Hefa/0D7rGODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtaJc1nr8oErvJx7z8jX6M4evmxq3fS0ZO9zpnKBgqc=;
 b=BkP8BkS8PjQaV+wlvS3/gWh5IjbAqWjzQr/i6gjB08QvRKQ2pXw/rpB7f2cYD81otkCWm0uf+8TzBxHdKIGdSSjuL2bxo5KIQqCZ6KrhKmEWRo+of/f8CB+t0s+hioofMs42DSnknbsc6mFcIVKhIsqimG8vrmLEmsScJJAroisTUgOxdmWNzGAyuAOnsPyBJKPIVKDYSTUJHG5uHF69WUi6PjDw1v4ri82HeT2FsrmCEC5Ne84+qN5EfV33IkTSTSglx30yo9oZDShYucQsZUFzuyVz+izVMqTaseGHih5BWRu+llMFuLTiMBntW52viGtO7pRSzEOEfcRRNsK2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 12 Nov
 2020 17:41:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 17:41:41 +0000
Date:   Thu, 12 Nov 2020 13:41:39 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Fix double free of the pointer to
 TSQ/TPQ
Message-ID: <20201112174139.GA950009@nvidia.com>
References: <1605180582-46504-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1605180582-46504-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:208:160::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:160::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Thu, 12 Nov 2020 17:41:40 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdGbL-003zBW-Oh; Thu, 12 Nov 2020 13:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605202900; bh=PtaJc1nr8oErvJx7z8jX6M4evmxq3fS0ZO9zpnKBgqc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=NFBqeGpPoF1RgYoV1yQnI6jJzckk7b29J+8dUTZRrtTvy/MMIWrdK6pifNGcTAT5h
         9tbc4xQrn5O8zrM8G9mbhWMbfqTj68TWe0cpl9ejiGSeyylR45qNQY4DsJ8urK5LwZ
         x1RTLGbG+re5R/Ed5os3UmsrQm1pYJFz/aEtLMRTsk7WziS8fabMjyDWIiCH770DUe
         vHxswc5Q4S2IUVOjDtYLmKYv2qkEKJMnVpd8i072kiv/9bknpQIGtXph+cG/sujQq7
         U4RzTEUa+fGYyN299BocnHQb+IOvgmetQm6Rqbm8Mu7meAjX2rhuO1VXXQE57ARM8s
         ZtnZKU/dWmbUA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 07:29:42PM +0800, Weihang Li wrote:
> A return statement is omitted after getting HEM table, then the newly
> allocated pointer will be freed directly, which will cause a calltrace when
> the driver was removed.
> 
> Fixes: d6d91e46210f ("RDMA/hns: Add support for configuring GMV table")
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next, thanks

Jason
