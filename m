Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B2C2ED639
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Jan 2021 19:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbhAGR7x (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 Jan 2021 12:59:53 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5092 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGR7w (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 Jan 2021 12:59:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ff74bf00000>; Thu, 07 Jan 2021 09:59:12 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 Jan
 2021 17:59:08 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 7 Jan 2021 17:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOwgnLQL/S6SUmpV5acThmczkdwV1aDEjglyv6UEzcdNSy2iCQjY3Ja82C81sJR3R7BsXLFZQ0++msBvYSorX9DpNw68I6mRivhZVHF2YuVlxKlI9sj1WPsqfzhGDtsBj0Z3sYvqh1VhJncD8metIIXaO13SKNuya9WamInfKonCpF44CsAhWaPLdfXHAm9ZYGkKSrjjIcDB2kmtNw3jlGiHmWnZTsKyL8+fVBHRoz/d+X3fmTRv9vg5IQE15k9gauJxbGlo0n6cIQWsmnos6e4Zp6Z4w6tkueukqCGCRpdfUrKCZ2UbNJDtqDaeeNu/CmT1Ga9lP6ZI3gYBqXYeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KjAM85x+piAZ6or0m1j29JhijHwFOZzBh4cwyUxNmw=;
 b=i2jGQDpDWO4P+ldNRmGNBTjru5atZwZ6Vc6B4nZBoX9i+pzzOGA4OyN+pG/Wk76vZxzCZTrkcPnaWyAXqs/BrtvDnetUAQS4lQ99aPB1b2yUOsxdROtmaWe2zZTk+52w8Q68JKfMCZRjBZYTIXf36i2HxCHa1HOP8TRc24qT4H9CvzOSHUrWJi/nmhU/ndIHVx7rDMnE8MDtKDAojiEj9TluhmbecwaHkVeSwU7lrocUBKQrVk04KiwR6NvBEVQ3vpoPKYOY2CTueXLDQ++O2o9JFrNpCCw6329a5NJLoM2CYYoNasmDrRTS9mqY7K87gewmdp+ySSQYhV6dzSiiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 7 Jan
 2021 17:59:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.008; Thu, 7 Jan 2021
 17:59:07 +0000
Date:   Thu, 7 Jan 2021 13:59:05 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
CC:     <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] sw/siw/siw_main: convert comma to semicolon
Message-ID: <20210107175905.GA903712@nvidia.com>
References: <20201214134118.4349-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201214134118.4349-1-zhengyongjun3@huawei.com>
X-ClientProxiedBy: MN2PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:208:fc::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR02CA0023.namprd02.prod.outlook.com (2603:10b6:208:fc::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Thu, 7 Jan 2021 17:59:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kxZYv-003n7M-I7; Thu, 07 Jan 2021 13:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610042352; bh=9KjAM85x+piAZ6or0m1j29JhijHwFOZzBh4cwyUxNmw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=MtrVVgylBM2ft0nIcxRjpi8nzSIEjRLhlPsbaCbjXp0EqfwSdxMUoWr1Ys2zl2mO1
         ChffuVLBw9Z84Xz4LyBxBG2yBSIlicobcE3TiJAhA0xTIkNvbnM2KNTiORCOrTzW4P
         Qtz/Rioso3atg0Zlalb+LSLzPpCdbC+dXrA5xc+Vi/R27ANyKq3FGUum1EAvFjj1OY
         DhjjVyaBzTsEkoDpVSK933K9eLUdf7AcoCFc7R9jyGU4MrUM4QOnVVNkZ2zOiIbi2D
         nOeAVgOii7A6pEObdhMKBvQinJMvwkcDEgLYpxq3ysFlHgVuQl3dZv4R1sVPkYtO6N
         BDe1nV90XJBRQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 14, 2020 at 09:41:18PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/infiniband/sw/siw/siw_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I squashed these all together, applied to for-next, thanks

Jason
