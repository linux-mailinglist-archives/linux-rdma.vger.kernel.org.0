Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17170316E79
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Feb 2021 19:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbhBJSY5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 10 Feb 2021 13:24:57 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6561 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhBJSWx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 10 Feb 2021 13:22:53 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602424330000>; Wed, 10 Feb 2021 10:21:39 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Feb
 2021 18:21:36 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 10 Feb 2021 18:21:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fstok6FMI8kGQMe74EAEcaYvLpuymrcn/X7ekRbXXfC+Lv7hFi1DPf0bYBle6tIED3ip4UpM2lRHpBXi4FUKEqykquDK0PZzDrsXeG9zocFcY7oVr33R/n221XKXcBkLQx0j0CCOgI+xpyoxgiDGC35IQl0ICFmCo/o9BIsJ3dVVDO6ZJDsfzrikcvIKyBSdTn7iKE3sMB0DWkBzlek3WeKA6k15aWqkwndlabx2T79b1+PQJTosVwKVmmX2mNW79SICSnD5n/sL+RuazArtuh78iqTu4bgNuqMG3KrkKbtfbb+U/sPXp5hg+nV+gqfytPBKmiuzAL1MGDcVC1LoxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dfsYfIeZ2KvMygJAQLBDA9dHYxsbCBBnYPWEvFihZE=;
 b=YheuaSPtbPprPjQDKSpC996w1uSgw9t7jp9eQ7JO+Bw8wTLSqLSOl1fmSMPwCXhSIO/IoLwungd2MEeHwWaDUKex2lSQWB/cdW1jQU3IGgE3ujdZTJeVkSb1ag7o9afcMQchTlXCKObidJnycZ2ymZgqajHPri76K08KiPPKAvgoNtQY2DWFP392AmRr6lgZfXg1x8munkDGt1smNUu8Ez3/sRGzF6vHLJBKQVTkuBZ3NEyl7C3WM/S25jiedsO/gJNG7KL4ujvaIBukPFinUcyaRiV5dNcvMUaQCEe/uYKR4/SJYAiQZ4gmUWEXE1ui8N6BjyrA9H+AcegXAV330w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2937.namprd12.prod.outlook.com (2603:10b6:5:181::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 18:21:35 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 18:21:35 +0000
Date:   Wed, 10 Feb 2021 14:21:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH v3 for-next] RDMA/hns: Adjust definition of FRMR fields
Message-ID: <20210210182133.GA1470084@nvidia.com>
References: <1612924424-28217-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1612924424-28217-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:23a::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:23a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 18:21:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9u7J-006ARl-UP; Wed, 10 Feb 2021 14:21:33 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612981299; bh=5dfsYfIeZ2KvMygJAQLBDA9dHYxsbCBBnYPWEvFihZE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=RYWTfhufE3X239jM7mjmg+16FUcpB4Mn76Mt/20RlE6HfsCdcSTSy7Sa7wkj2QRl9
         uZ+uJsTLeiRYZFzPEwpW6IFAVF0asUDt2nJ/jfBISRr9qIWZ/GoS4dtjJc6kNPu/JE
         34aWBEeev7r4QoiflkvvmsCuU12rcLcOIe0y5CT4hDw5AeRHlyfupRyoC1crFmJxN5
         VwIrx/8DUKNaWDN0H1v9UC6xv1RkUF2FrrudrEPPtak1um1g4LQYhYzzznExtZmN7N
         SLORz+xK49YsejRuzvHIH4qp3C1nc+UomDBAT/mwBKGzZ/jW7qb/2QDF/7NwkgmZA9
         CwiFr73sMg0rw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 10, 2021 at 10:33:44AM +0800, Weihang Li wrote:
> From: Yixing Liu <liuyixing1@huawei.com>
> 
> FRMR is not well-supported on HIP08, it is re-designed for HIP09 and the
> position of related fields is changed. Then the ULPs should be forbidden to
> use FRMR on older hardwares.
> 
> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> This patch is one of series "RDMA/hns: Updates for 5.12", the others have
> been applied.
> 
> Changes since v2:
> * Aovid setting IB_DEVICE_MEM_MGT_EXTENSIONS for HIP08 or older hardwares.
> * Link: https://patchwork.kernel.org/project/linux-rdma/patch/1612859923-44041-1-git-send-email-liweihang@huawei.com/
> 
> Changes since v1:
> * Add check for HW version and rewrite the description.
> * Link: https://patchwork.kernel.org/project/linux-rdma/patch/1612517974-31867-6-git-send-email-liweihang@huawei.com/
> 
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 45 +++++++++++++++++-------------
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h | 12 ++++----
>  drivers/infiniband/hw/hns/hns_roce_main.c  |  3 +-
>  3 files changed, 34 insertions(+), 26 deletions(-)

Applied to for-next, thanks

Jason
