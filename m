Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5A27D413
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Sep 2020 19:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgI2RCH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 29 Sep 2020 13:02:07 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:41099 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgI2RCF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 29 Sep 2020 13:02:05 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f73688b0000>; Wed, 30 Sep 2020 01:02:03 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 29 Sep
 2020 17:02:02 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 29 Sep 2020 17:02:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHYXjU9bRN7gExctldVh+efMVb+zh6di6yXb/wDp3I2NViVGMl02GkJtaVPsvX3o0YE1te03Cn9iB8cjjktexuDOIJPd+NoHKBQzl8wJiMLBg7TuHwDPQ08FDDEUnq4tlzdnK1u2arkR179AjbbUE0YdLxoNliFhAZchKV9+4G/42Tp0nOXWWTKLItF1/ln6bVTto37WL7iy/Ow+Ncy1tt1kPBEZALaegkaVFiJmqU2zs7YqUgHPruJhqzbcvICNP5kHRyuiQzqcdVzVHUWINHvJOkEAgmmvhn5+vpVvRWnS9LYcH7VpX4xg6j68akWZoSX+8m4NPFlBbkUIfYwumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYLQj27KayHGmVS9AKc27P5U6vfzvOyyAJ21BqjYIig=;
 b=OSDAOt/TbPyJKZaIV12+2JdNX3ahKM58y+rGJmd9lE19gBiVAfVCIm3Wp8Oug5MGUqh3ZQM6qWv3LbtrWcN0BBWJR63j5tJNPdJ+JT6T6sC3csmvjamQDXHkRFEHFCNn1ig+k/fvry+ySWNa4EoMWLCcJM0ObGKYs75P0K5R0ZE04xDSO5VGejULoYxjQE6w4RHp1p0X+7YIu0qsPa9uQKhTNx6E8NvshE7/r2vB34kqmpvpMTzr5swjx/m3MzSW/Xpo/kQ0cOnj2VamkkbfSBMOMfHYNAzE+q6CEHLjvobN3pd3FBSg6eSPIGBdaamCKdP8vAKgiVJ+zl3jbfbCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Tue, 29 Sep
 2020 17:02:00 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 17:02:00 +0000
Date:   Tue, 29 Sep 2020 14:01:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2 for-next] RDMA/hns: Remove unused variables and
 definitions
Message-ID: <20200929170159.GA761702@nvidia.com>
References: <1601371934-40003-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1601371934-40003-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL0PR02CA0085.namprd02.prod.outlook.com
 (2603:10b6:208:51::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0085.namprd02.prod.outlook.com (2603:10b6:208:51::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 17:02:00 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNJ0p-003CBY-1q; Tue, 29 Sep 2020 14:01:59 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601398923; bh=WYLQj27KayHGmVS9AKc27P5U6vfzvOyyAJ21BqjYIig=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=KWDoWBZnfJLoij+7FTReJ0ltVYIWL+QALz7OHIXvDeQvweoc44U8c+U1SmjhLJ1ye
         bSZ6alRB0ZeE9yeSz9CixaLhSsYkS0VxMJM5mghxRrRjA86oT8giD6zAKqM7RUa10j
         Oi+X3fnkjLXAHPA1BtK30Wx86R24TWoXNdKdcumjcRqjyLC+CbBEvUJ4ZckvFXpUIP
         AUjBuiJkS+oEqfAtxQE023XJ/07+E0/LJr63ox6Y0iDyL0iI0HI9LMUFuu+hsTiR91
         T9PyZ/VQ7HMcNKBjZeblwdQ2NzvRu8L7DVp1sD+owiMZqIlGua5IPZjY25iME4oykk
         S+cF2S8jZFziQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 05:32:14PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> Some code was removed but the variables were still there, and some
> parameters have been changed to be queried from firmware. So the
> definitions of them are no longer needed.
> 
> Fixes: 2a3d923f8730 ("RDMA/hns: Replace magic numbers with #defines")
> Fixes: 82e620d9c3a0 ("RDMA/hns: Modify the data structure of hns_roce_av")
> Fixes: 82547469782a ("IB/hns: Implement the add_gid/del_gid and optimize the GIDs management")
> Fixes: 21b97f538765 ("RDMA/hns: Fixup qp release bug")
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v1 (https://patchwork.kernel.org/patch/11802025/):
> - Add fixes tag for related patches.
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h | 8 --------
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 2 --
>  2 files changed, 10 deletions(-)

Applied to for-next

Thanks,
Jason
