Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFCB2CB203
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 02:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgLBBD2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 20:03:28 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:26397 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgLBBD1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Dec 2020 20:03:27 -0500
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6e7b60001>; Wed, 02 Dec 2020 09:02:46 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 01:02:42 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Dec 2020 01:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkCz2QE16H94rvj4jaPY2AvivRcU8g15xffJBRkuvPlWRNn6iAickWNkqweDNtJZRKylWrZfuhjd4/FobdUySI43KOr56OBMrWfiqBHmev5PSfkOlXW/ITIb1zqWF4Sa2tZIWZMdhqnWqUl7YB0phcG7PaXNeRH1PheZh9cMEK8VZN4P0MtqJjAQUS6e3/b8jDK20cSqOZc48eTmgfXvhIRUDrVnKkZ1BNH/TjGOKK6oSUM/d9u3uDK2IQBc/GjAPuixxxBsf/LQ2AjklWqa/9F1C7PQe48R0Th89jMYUsaXX9xZTmN8o6FqHNSSrPA23o5eqEQ3uT/4diFm8lOmQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9l+TjoLutHYxPb04yuPaz2v64kAhOtHwkxVwuX+X1Mo=;
 b=KMswO1IQxDM5He/PMo5orPipJ4NroA7tUlrwD8KQMvS5g54Cp7V41vnUNgGB447FHf7d3/vAmCd0jedIQL4PwumqTQqyAO1JL3I9V6NJIjmZd1uUGiYh13Ou4KuYYQbhizifn2MI/AQYF09RvWoQq7zCZMUS3D7CvOMmVkLQOfYxSPuoP1LHwfkoDwdwCVT5aFOzOGmBY4DsuAbQGRXe2asUwP/DKjAuKIqeFLTw8QFnVqeYlBQL8N5CH1VY7+qPKCA2Xfuy97NerQ/x2HCGacemho+8c0FYcdEoOLWmhOgxjx/WmNDEo5EN9DcyuOuUe7fhbCEuOACNR9YwUxB/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 01:02:40 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 01:02:39 +0000
Date:   Tue, 1 Dec 2020 21:02:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next 0/3] RDMA/hns: Fixes for calculation of sge
Message-ID: <20201202010238.GA1149969@nvidia.com>
References: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1606558959-48510-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR12CA0031.namprd12.prod.outlook.com
 (2603:10b6:208:a8::44) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0031.namprd12.prod.outlook.com (2603:10b6:208:a8::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 01:02:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kkGXW-004pAX-G0; Tue, 01 Dec 2020 21:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606870966; bh=9l+TjoLutHYxPb04yuPaz2v64kAhOtHwkxVwuX+X1Mo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=fBr8YpfjOvDO8Spk1Nv+mGnpOBin6ZucfNPuYKIIblsw8ciSIS9TLE6wbo1nGm8jp
         PkVCKltRqFX7oQ060BCMhdkNLnd+8lUIZWxqWnmP2FIIfUufumhaWtzi1XHFWQefok
         x3rBGltMCMhJiBmeWoi4GfJza5Xet7zZdKmQSNKy7Xga6hLfns2LZDj+xdXxVjl6ZX
         qH4kOdFt2h2IDFWZY8Eqy7sVaAOHWgFsf+YwiuWAhawjtIocy8X8O9hglR5U84H72W
         rFJosLuceNOUdSTlQrvi/brUTSfV3tp4D+R7i2dySJpSTYEmry5Z8auzm8ycLPFt+K
         9Ttazv8XFNnUQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 28, 2020 at 06:22:36PM +0800, Weihang Li wrote:
> There are two issues with calculation of extended sge, one is about page
> alignment and another is about the 0-length sges. Then, the path #3
> refactor the code.
> 
> Lang Cheng (1):
>   RDMA/hns: Fix 0-length sge calculation error
> 
> Weihang Li (1):
>   RDMA/hns: Refactor process of setting extended sge
> 
> Yangyang Li (1):
>   RDMA/hns: Bugfix for calculation of extended sge

Applied to for-next

Thanks,
Jason
