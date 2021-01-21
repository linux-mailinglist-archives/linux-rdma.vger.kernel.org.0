Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7152FEC81
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Jan 2021 15:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbhAUN6h (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Jan 2021 08:58:37 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13212 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbhAUNhZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Jan 2021 08:37:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6009835a0000>; Thu, 21 Jan 2021 05:36:26 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 13:36:24 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 13:34:50 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 21 Jan 2021 13:34:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1vGDpraKTRyqKwYfbItOpz4eA/x5tplt4/hUfSC7jHQnsS0wGvvVLLxucClSX2TLHGsR1pngQxy7Sdg9mk56rMt3qQcGSKfejMGyvBpCiLSuPsfl/pjlZ/e+b6I82RUTi2EDT67bHAZno0eZOevyHf0mExllgCHBQTKrtXPpxxjpJ4HyLHFj/PXiNFGdHStUwiqxoO86tKgV6gB4DovaDIDRYCW5flgtfHAU+bLy2xAYHova8daV1xSP/XkmPV9CIbBGsvT30c+xYiYwUpBEkcImlCTf4LB4VWqPg6dc0wZIbsNX5cJZyYaCOidZEv15SVdelwn2DDZlS++StOm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guo2P6J3eqnfPg9EnRnhCvBNzCaaV+qppcDpqlwdvAU=;
 b=oQ6BBfk3bMK3D9iHwgsHYxst/J6YT1p7P4KU/JFrpcnu5knkA9s8ULDmtai0t/bCRRoq72r43puFyrUw4eFeUHUJEswqHNq1ZvRdIfgaeiWO9rr7hWoojd57ghrF9GAc5OIG0bwc1LGPDLiai1RfetCxaUL+Ay591hW1SdwVtLJ/AWfexe/fKb0tBLJFHNGhTR4nDHUr1SmKT2CpY8Hwjxt5D1Tszg3K4aZr5SaLxEdYE3mGd0B7amB33aCxuf/kKGtNx0shNXuZZbYuozVZkcRkFgLAaf3P78spp8SgJG8MEbB39xymGkXfH1QojGMOfErXV/nj1U8+dkOTYige9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3116.namprd12.prod.outlook.com (2603:10b6:5:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 13:34:47 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Thu, 21 Jan 2021
 13:34:47 +0000
Date:   Thu, 21 Jan 2021 09:34:45 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     liweihang <liweihang@huawei.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: Re: [PATCH RFC 1/7] RDMA/hns: Introduce DCA for RC QP
Message-ID: <20210121133445.GY4147@nvidia.com>
References: <1610706138-4219-1-git-send-email-liweihang@huawei.com>
 <1610706138-4219-2-git-send-email-liweihang@huawei.com>
 <20210120081025.GA225873@unreal>
 <8d255812177a4f53becd3c912d00c528@huawei.com>
 <20210121085325.GC320304@unreal>
 <96d7fb7db36e4bce8c556d0de5c8f961@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <96d7fb7db36e4bce8c556d0de5c8f961@huawei.com>
X-ClientProxiedBy: MN2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Thu, 21 Jan 2021 13:34:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2a6n-0051Sy-UC; Thu, 21 Jan 2021 09:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611236186; bh=guo2P6J3eqnfPg9EnRnhCvBNzCaaV+qppcDpqlwdvAU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=FG/miWmWuJDn/kz2lhIjsfb4sMzc8Y97iFyGWW+2aeW2bjFhB/U/Wzc5CAwHzxBUj
         LRRshJ34XsojZ3q9QS9UY2+lQvp4ehM3D5HmuF0tFtTjNKsUw1lH5Q22lXN96FEuh9
         NA/wPDFEPQidse3+zhcp6/xo0S18vJWnlQBCzxmC0TdPVVCG8ynVPrar6NJsS9yhVl
         Ewlr9RGLbHgeD04GqNTFcGmyFQPy81CgF4T14QHjOrrBKQqDJSqgrlxd8ckI3JrBxQ
         bV0pfLn5y22ybyJ+gNr1SgLDPuIDxvUo7kfuS3xtqqk7OFPJI+4ffKt9JzMQKy/aMQ
         kqulL1NVd1OoQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 21, 2021 at 01:33:42PM +0000, liweihang wrote:

> We need to allocate memory while spin_lock is hold, how about using GFP_KERNEL or
> GFP_NOWAIT?

You should try hard not to do that. Convert he spinlock to a mutex,
for instance.

Jason
