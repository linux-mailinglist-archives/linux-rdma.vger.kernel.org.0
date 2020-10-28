Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7520829D2CF
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 22:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgJ1VfL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 17:35:11 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:11845 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgJ1VfK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 17:35:10 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99732d0000>; Wed, 28 Oct 2020 21:33:33 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 13:33:28 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 13:33:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck/wuCJEDTtJGfLj+hJiGD7cpCk7mJHek5bANWji2uvCZbBE2nWXlZPcphb7fcaRnuZ2SoW4FuJpLBYwBlMMl/8M/qTtKyjlaYK29Bn9cCPMFwydRQb5yCOnOV8w64kQgQ26tv7eJpkdaMcie5BMCiVnyLIwlFvuhpeChYZkYuZQYdog4zM4GeWiapVEyWfBi3NdGLhJU4Qs1SIj4GiaeRt2IRReIE5Mo8WoGPms8PtNamEpZjTwJ4aZfs6t+CKtkHvbTTlep9mf2w/LNtqY4VFcMakurfHgPHl0qfwEvJAM0xgJ4mnkGjnVWQ9pPkwnzzkY+778qLYVsBjdrao4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Psxsz9YuMQF8C6dHzvkuZjnpYRrloQUZ+WbtQ6jXfBg=;
 b=YcFtLLrxfliDzl+/a/LjBjvyj1E3gAIBoh27I1JyA4vkjeGRonFbDHSKgXDjqaBkNv1dcWDggc5OdKz0BYqgJZZCI6szoGrhPXKsjCTHdGu4iOAmlNf87U0AT3DjbROWF/dsS56LNC5JS7J8aVcnMK/bzhQfdILE41gVUoqB2tsFnKSgKIwkJGNMqDbD27RveqzLlmMCg92tA9QnN/SE6B+5aSnv3sbwKrGkWEodwIUkh79ZsooG/B8maNHvDRRJekFCuTwknYWzJpLIjXM8ukTDWzol6/08JmNZF/yJbz4etRazDnJGdfallSlb40KY7NUa3mMTij1AnBRjXIEhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 13:33:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 13:33:24 +0000
Date:   Wed, 28 Oct 2020 10:33:22 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>, <maorg@mellanox.com>,
        <parav@mellanox.com>, <galpress@amazon.com>, <monis@mellanox.com>,
        <chuck.lever@oracle.com>, <maxg@mellanox.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: Fix error return in _ib_modify_qp()
Message-ID: <20201028133322.GA2410517@nvidia.com>
References: <20201016075845.129562-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201016075845.129562-1-jingxiangfeng@huawei.com>
X-ClientProxiedBy: BL0PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:207:3c::47) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0034.namprd02.prod.outlook.com (2603:10b6:207:3c::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 13:33:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXlZq-00A76G-Df; Wed, 28 Oct 2020 10:33:22 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603892013; bh=Psxsz9YuMQF8C6dHzvkuZjnpYRrloQUZ+WbtQ6jXfBg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Z+xFWBa8k8DuW3ZGy0gsgxTtIE8HGH8ZB9U+k0eIdcDiiPRZaAWXGtyuNIwzAmvhp
         IEqsTyFMAVBtk7zUELD9toWKxaf3DVgRHtY3bJn4DaK+/UvUmHLZDgK1gpdLnQvFsp
         aBsv26idm//P5hY5/9xizJVfdH0Gvp3GPCgwR0m8EB+m0rT/DU9XoffsDNEzr4s2A4
         XcohJdMxzYqN0vVTVpR6a7fzTB+GxqgaN9RstIvd9OyPlAxsEnZh//MIUs9aoPpJIA
         8aOSv8M/j+ZKHzoumzuE5DxfUmb6eMKH5YnSgWq2c0PuG5CMIcKTmp60V26gLjb1E1
         EXcb+NaEstR5Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 03:58:45PM +0800, Jing Xiangfeng wrote:
> Fix to return error code PTR_ERR() from the error handling case instead of
> 0.
> 
> Fixes: 51aab12631dd ("RDMA/core: Get xmit slave for LAG")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
> ---
>  drivers/infiniband/core/verbs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
