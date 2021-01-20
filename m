Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EFD2FC5C0
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 01:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbhATA0w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 19:26:52 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8501 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730882AbhATA03 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 19:26:29 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6007788a0000>; Tue, 19 Jan 2021 16:25:46 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 00:25:45 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 00:25:41 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 00:25:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laJOd+26KlX9/1QoXmpsAdkmkTJ9IY/IfT8M9zKiNdMWGUo3KzFrJ+0sq4FMbEedYimt+03nBpg7NfddttH2QKnIM7X4Bf/cp9gz0geNRVsLFGv9RoY0sersHAY0eVlFNVXLDzazODfuhHxmLKxFVR7jDbODxC/u+K+mqYsK/rfkRNBKvS67VJd+5RBm5jgZSRVp7RUIwCM2mlOaHzdAzfm0DPaHVNvydRPfiC+wXOEgTSOCGXSM68Iw/vOjo+yFscsgh48D3EH7AhFVArMKT6ea+jcIhjxCzCiJ8soz0OAd9zKhJX4IbzBytMuzgvKv9wRGrQ4zfc55sk/LWVEzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpj7NewQeVJGlGALkReLW9ilGJuG+H1LBnsT+kE0MP8=;
 b=CwLUPOZ3xrzsyqwfDI2/Q6TLz2WY5zAVLk09qulzXmG4TIcVGVgANzKmPTiUs13SoLH5K8Fct+uMelFYRZO5R5PcsjGO3db5IAs/0QRglVfnfHo2v0KVHYaO88HiVT5KH26CxOkA/lmgfPxX1J5LobJ5y/1ze6jrGnWiWXwrggUG8usSCaAwN3hbsca44jWlJk/l/douAGFNdlRYmQz+uMmwUhAjqhAMjnO6lewHfzRPV0rkPAyR7XddryffoN3uwDtC0Ez/t0FvFndUdyZcl0ASNAzfjVmY5lxS5HteFia/l7n0N5SCGUabMc1Jgko91vqg5AAyZPxXf3oZuQoMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Wed, 20 Jan
 2021 00:25:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 00:25:38 +0000
Date:   Tue, 19 Jan 2021 20:25:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH for-rc] RDMA/hns: Use mutex instead of spinlock for ida
 allocation
Message-ID: <20210120002537.GB963641@nvidia.com>
References: <1611048513-28663-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1611048513-28663-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:208:a8::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR12CA0016.namprd12.prod.outlook.com (2603:10b6:208:a8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 00:25:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l21JZ-0042iA-4i; Tue, 19 Jan 2021 20:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611102346; bh=tpj7NewQeVJGlGALkReLW9ilGJuG+H1LBnsT+kE0MP8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=f1RtqrPdbono+1/JhUGnWiBEJQkACL1WvEiu4a/V+VyOk6vn6Kf61btHCw3moSvfy
         HL5q9RyKIRyS0tNidEViaVnmLGe0V6aQAx/Fv2FpVCJUrlt6p5p3FJxA727ostJPAT
         r3l9kv65+ZdztGbNp6V06ZC/higSAKpdnwGISGERFMYYisfv7c+1k3J5n0i4bJeB0U
         hrJ39rlGL7GxAw+DvDPVh+T8xOit4i/zpa/w8HQowad89rXCl7wPAB5nX+hCn0gHoX
         dVd0/EZ1Yug/CydvKlC40OA73TKiyElfsP+5WCtE+JeAouEVZ7fPQxmtP7mGBjERhL
         BouZAUEiEtgkA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 19, 2021 at 05:28:33PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> GFP_KERNEL may cause ida_alloc_range() to sleep, but the spinlock covering
> this function is not allowed to sleep, so the spinlock needs to be changed
> to mutex.
> 
> As there is a certain chance of memory allocation failure, GFP_ATOMIC
> is not suitable for QP allocation scenarios.
> 
> Fixes: 71586dd20010 ("RDMA/hns: Create QP with selected QPN for bank load balance")
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  2 +-
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 11 ++++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)

Applied to for-rc, thanks

Jason
