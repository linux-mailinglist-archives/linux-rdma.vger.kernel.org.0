Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1429D5C2
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 23:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgJ1WIa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 18:08:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:21216 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730240AbgJ1WI3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 18:08:29 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9998e10001>; Thu, 29 Oct 2020 00:14:25 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 16:14:20 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 16:14:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9YjXH6D+YZtBWnZDeWbyskTvnJ+7uxf6stBWIJrgZjpf/TjxCGALCUdiOTHIhZsCD8rEEp0D5LeNkkeoi1KZuGe3ZXHkjFmVynz8p4zhK+yBfe3Q7eSTheeZSrdjoFtrAZ7jDvm+dxeWuPwVnLB5m6Uc3yoptpAF1rnXNDYPGTUc0nTgtPouyo3WidkIMgXRuqWi1ATGsUfZn5mrwRY5uukQ84RwPS+li7eEslm7tIQAwmYCJEDmXCL8vgAyr9GD6b0hOcoSUJiSTGE65eziPbmFt47gvHwuyaVEF0Qsceyqss8bP57zTdOrm46IetNdvK8+Y7QbwsT4rcr7JKCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FodnSLkUqYPKcn6H28iEOROPVyf+iFNaAoYv1ux0KCQ=;
 b=UPQhTooAudDIqFMHVNoitGNS0voMGuN//47uihOM9s6G34IqGMt56iwQs6dP4Xk5Koi7lGLKhmgOlJTj5cpToVH5vByGiam7xWZRiEq9K/TGGxtoYDjTcZmfkeU+fdVKL/zfLowj2FTSD+DksMxMDpcgD8ziseGayY4Z2tTqhQg2KiOU1BLhba07xCsKzv+Rt8mNDkirooR4AAfSlXI5tGTaaSRMyBXz0EFV6sZmSSdpsldMb5tG/e3qeSWcnqS7+i2fTz9rvJGxAs7ixIJ/kelnnCj0qsSnU5kSZjOshwyWSedMIhPK5xgEmJFLq+1o1xdsts5Mjcm8RMjCxzFD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 16:14:18 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 16:14:18 +0000
Date:   Wed, 28 Oct 2020 13:14:16 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next] RDMA/hns: Support owner mode doorbell
Message-ID: <20201028161416.GA2438029@nvidia.com>
References: <1603195493-22741-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1603195493-22741-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0014.namprd07.prod.outlook.com (2603:10b6:208:1a0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 16:14:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXo5Y-00AEG1-Dm; Wed, 28 Oct 2020 13:14:16 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603901665; bh=FodnSLkUqYPKcn6H28iEOROPVyf+iFNaAoYv1ux0KCQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Nm732gxpjrVssQ9tgCTiE/MWFjridHnDl1PJeqa5i+RCN4A6w9sg7fFXvgKl9BiBr
         lRTJFD4K9WeWCkGbFN5gvcO4OCr4YifArT05LYFbcOex7c1a009cxiz1RAleJhow4n
         kDXn+D3f4mJYMVxGIzp7h0qzcXAu6TBSLKepQeERvf1i9rBkSI2zHC6jh+mHlQchcx
         N09nnNhhGF6lKlvz+Eik6mI5ubzpPVs+vAcpxexTLTFcq5p9sJfe9bRr6p/El0CO5R
         pd65RZuAUKkWnRG4gpFMbC++ETBavdID47YS17mPUM7RjPwvfNODnTyNnEWigwKVFI
         0qpkZKctxbG6A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 20, 2020 at 08:04:53PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The doorbell needs to store PI information into QPC, so the RoCEE should
> wait for the results of storing, that is, it needs two bus operations to
> complete a doorbell. When ROCEE is in SDI mode, multiple doorbells may be
> interlocked because the RoCEE can only handle bus operations serially. So a
> flag to mark if HIP09 is working in SDI mode is added. When the SDI flag is
> set, the ROCEE will ignore the PI information of the doorbell, continue to
> fetch wqe and verify its validity by it's owner_bit.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes since v2:
> - Replace wmb() with dma_wmb().
> link: https://patchwork.kernel.org/project/linux-rdma/patch/1601199901-41677-1-git-send-email-liweihang@huawei.com/
> 
> Changes since v1:
> - Fix comments from Leon about the unused enum.
> link: https://patchwork.kernel.org/patch/11799327/
> 
>  drivers/infiniband/hw/hns/hns_roce_device.h |  4 +++-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 28 ++++++++++++++++++++++------
>  drivers/infiniband/hw/hns/hns_roce_qp.c     |  3 +++
>  3 files changed, 28 insertions(+), 7 deletions(-)

Applied to for-next, thanks

Jason
