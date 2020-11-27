Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC82F2C6A1F
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Nov 2020 17:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgK0Qt0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Nov 2020 11:49:26 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13015 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgK0Qt0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Nov 2020 11:49:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc12e180001>; Fri, 27 Nov 2020 08:49:28 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov
 2020 16:49:21 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 27 Nov 2020 16:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UE8EDQuFZLkbBz5tqdQjn2QkCw5rFlw5y58nSLJtn9Wwqzc8qUMC0BRtuHoqV/t1wcEVl6NNyXlCL23cuuf0xzy3cg/ZsVNlo9bOdmUjY8BBpJKC/1gCWZRdiUug11VGGKZhnt3ncroL+W2TiY+SvBOexCqIPA2VTNn3JyoDh+QFgCZZA8uwRuljnh9GAluBel/bkrjsaU0DaowMmVWPsDEmiLnKCvwpe3qn4bAvM4v/Y06nWBcA5X7XQ7HUdo/+RZilHAJquaaAP6eXUucwksJOYNIjmD47nMy3wO4ut/phzq7QTxI4SnrngbDWETPWUmZmT4VMxZQU++laGym5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVZrGtt3Lgf8BXfRjtRlVcpobfgSwuG2IwgA0ndNzDc=;
 b=M6tngJs7Caejltu9a73LcErpTJyfaOvTmRDv19K1d3m/t+GyVXgWTVYnOwvDYVqsQ4b/+6/eSlKPQI4TYv4V0ELLAxyPoUsmxai22h8pr0Vs3XjhjZiIL+/BK+LFcLn7j/CL5tzF3Sl+GKbsow9+G79ryflWUhlnrT9EZ4v+pJX3qyJzFTVQ0tncYGOnJ0al+gEwl7WAanA9hbocGWcIJgzo+XvXOAS0EueAWcvF+cF6CQYEQGl0UtY3hqsD7IEECCRbkWIZXyP3p9s1KrFgk/MO4ACVQHq6iv9+oyyhgDGunvkEh69cclyC50cDHa8/S8DdLT1NMPmqqzDH0FyAuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4618.namprd12.prod.outlook.com (2603:10b6:5:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 27 Nov
 2020 16:49:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 16:49:19 +0000
Date:   Fri, 27 Nov 2020 12:49:17 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next] RDMA/hns: Create QP with selected QPN for
 bank load balance
Message-ID: <20201127164917.GA675120@nvidia.com>
References: <1606220649-1465-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1606220649-1465-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:208:160::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:160::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9 via Frontend Transport; Fri, 27 Nov 2020 16:49:18 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kigvt-002pdl-JV; Fri, 27 Nov 2020 12:49:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606495768; bh=EVZrGtt3Lgf8BXfRjtRlVcpobfgSwuG2IwgA0ndNzDc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=kM+DGerXyRyHdFsZwwJJ0tMk9pjXmqZgF+EXS0nR/aMT4l4k5NKs/lky0Qa9TIA6B
         xF/3poa3YUbAZRmawmv+7lvFXBLiUtoGRFP/DSpPlwyC3vsJ+z6Y2DWSMj8we70Gd5
         zHNFVJV3FN7tKItwiACjjAGfqYtvRVEIVeaaZ3+0j96HdYesmErG19KHXUv+oTyvot
         UWDuQWyUXZkin5dhyrdApSpGJX+x2eJsKEeF/+EWv4si2645pLt5yHchFtuiqDt7a0
         WHDmnHxwfJWnlBeE6NvEKllnUkfclLQQkAe12JFjf/2WjNn9xBVq84djjWfngS67a5
         FrQfri9Z0afqA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 24, 2020 at 08:24:09PM +0800, Weihang Li wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> In order to improve performance by balancing the load between different
> banks of cache, the QPC cache is desigend to choose one of 8 banks
> according to lower 3 bits of QPN. The hns driver needs to count the number
> of QP on each bank and then assigns the QP being created to the bank with
> the minimum load first.
> 
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---

Applied to for-next, thanks

Jason
