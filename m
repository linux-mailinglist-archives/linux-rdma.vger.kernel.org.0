Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC80B314439
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 00:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBHXoR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 18:44:17 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3097 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbhBHXoM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 18:44:12 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021cca20000>; Mon, 08 Feb 2021 15:43:30 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 8 Feb
 2021 23:43:26 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 8 Feb 2021 23:43:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVWu6G6xFR62HYL7PAkbehT6W15iAmKPG1lhLey5mJ0B+dQnmJh+MHgovSnrTZke/xkIB5n0Qo3aGfK/AiErVoKUm8qbQ3CjEt4Ei+qPrbN71sWG9uya/hgf9/Yv1+Sh7Cjp91WgpDrlRKRAbYdy5dwZCEZ+iUhReQAmz+q7cE4gEVRHi02TSujW72CGLgisc7VC62IZ7br8tl8lAUXUGG3hQwfh5ww+H/Kd5XlV6TUKFKGMdleGxIzhhAD47D261wEREqzPlhDouw3BuVSioMScju/F13hYlGImD5rHXcVC9IsxvNtXX/3w/Bp3HFq0PpbdD4+9PfvnxrDU3MOjDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSuizd0p4dOT/darDqS3s7i3oDFkXMMOloHdsgS/AEo=;
 b=FQfve2xAZSV9ReAu56ttKibj7nsNy3EdriP3+J50u6fUM2iZE6sZDwozhsRasmYqJrSk8tORNERvNePec9ZcW+ec1M5ezSTWxOb9epng5ruguMpISfZBjLtufDRlGUswLirTdI9+9cAWlJVDhdVIFKXfY62CfIgB2GAZq+Ml8Lyx2f52gBYsLyeFJJqzYyuLaCyVTYB/tXlDA66nWork3W5AuQy5pQAz1/wNXaS5XuvjMwB0pk7QXlvrJMh1bn6RYyPw98FBob9tB2WKRlvU0RjdPXDJhHJRyatDhMNoLlvSgNhNQY4mVA72zUlL6qUqnNLmkK9l6Mw63/BYowTzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 23:43:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 23:43:25 +0000
Date:   Mon, 8 Feb 2021 19:43:23 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@openeuler.org>
Subject: Re: [PATCH for-next 00/12] RDMA/hns: Several fixes and cleanups of
 RQ/SRQ
Message-ID: <20210208234323.GA1225977@nvidia.com>
References: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1611997090-48820-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BLAPR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:208:32e::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0135.namprd03.prod.outlook.com (2603:10b6:208:32e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend Transport; Mon, 8 Feb 2021 23:43:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9GBf-0058wj-KR; Mon, 08 Feb 2021 19:43:23 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612827810; bh=fSuizd0p4dOT/darDqS3s7i3oDFkXMMOloHdsgS/AEo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=dmTLzxNE1cbeByTjEatoa0B/cJdtsSfustC18Hak5XozG1n45jBqh9+zSUjnQdfQy
         wUijquOnf6Y2vPRvwyN0i2ikvOqiTXumpKep3gDA/n4Wsqivnw0vhm/FAVhx4ik+Qb
         XMjr3NTlz7aSdqOQXU55uAFolEYPp82kr/x3adjRZbpCQYpZ32qShZ95D+M4pDVBH7
         KELGluRaNIRHa4QvK0nw1TeZ7esT77Ts9sPv7zqUg9X4FL+7KsYiv5yeoWEJZXaVpD
         7j4Ia/Fu4RVyDsLy469omEJdT3ndySmmdk0Zx1H31s+rHbFhC/nVk63DScio6wATam
         tB9btIPDYv9tQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Jan 30, 2021 at 04:57:58PM +0800, Weihang Li wrote:
> There are some issues when using SRQ on HIP08/HIP09, the first part of this
> series is some fixes on them.
> 
> In addition, the codes about RQ/SRQ including the creation and post recv
> flow are a bit hard to understand, they need to be refactored.
> 
> Lang Cheng (2):
>   RDMA/hns: Allocate one more recv SGE for HIP08
>   RDMA/hns: Use new interfaces to write SRQC
> 
> Wenpeng Liang (8):
>   RDMA/hns: Bugfix for checking whether the srq is full when post wr
>   RDMA/hns: Force srq_limit to 0 when creating SRQ
>   RDMA/hns: Fixed wrong judgments in the goto branch
>   RDMA/hns: Remove the reserved WQE of SRQ
>   RDMA/hns: Refactor hns_roce_create_srq()
>   RDMA/hns: Refactor code about SRQ Context
>   RDMA/hns: Refactor hns_roce_v2_post_srq_recv()
>   RDMA/hns: Add verification of QP type when post_recv
> 
> Xi Wang (2):
>   RDMA/hns: Refactor post recv flow
>   RDMA/hns: Clear remaining unused sges when post_recv

Applied to for-next, thanks

Jason
