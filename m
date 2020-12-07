Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D242D19FD
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 20:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgLGTqq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 14:46:46 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:5877 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLGTqq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Dec 2020 14:46:46 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fce867d0000>; Mon, 07 Dec 2020 11:46:05 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Dec
 2020 19:46:04 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 7 Dec 2020 19:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INcbwn3LTpyRYJ5ifpuoX7tbhGjBRg2D0CywPD4vlBq2JCTcLOKo+zU6bKrXL0kCyCdL45BsZbspxVlgjPfh9uFX9RPg20xpailzeeLREbnt1K2V4DK6KNkfV/lVayRra0F7XT+3ONF0uECaKVyYjflbpwhK2c9K+sGd5+HCY+VDE3rDwMI429RMoZI2Ctedyqtuxjd7IG9ItXBJy3VUH31tmvpR31ReYjYixa8gSFCtYCZ7R4L/sEKR9yP2q9/+s8PkFRUXwCD7fLxqW9ibpMqOx5rmrSWy9JBA/34aWWZEBZYF+F0fH9/Si5z1gbdPrFChPjHFfPmtZLMcKazFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lg/42DcldbZG9mBToOsz7dSGb1mt3xyDZpRUGNgKdA=;
 b=CnEMcSkaPEuDxtgzwZrkycXYWbCnOYTqXjbsIoa05/cGdqQ0ZcyuOCgVQMA20pC++SYbWAmTmKWnvsO+3jnGFsWVdZJPV7gbWU0DbQjS0tFgXaRcIy9OKR2OprEiMgv+vu272qSqUpZfNiNGHQrpJGj51w23sV6vs+Jz5MCdn7f1uQLmyjZXumZNgPVivYteBVJ7pNrtJ6/AcjRB46XeN9J+bDBSF9VmVqlkcjOS9YY9UFtXGirNR6b+G3nDqWwMydPMGBq1GKlCO0+XnHAuJobgXPyKPlgEF5s4GFvAhbPOvaBltPRiooi+mLvb5zRet4b0Vs38fYpbWLjXbs5/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3739.namprd12.prod.outlook.com (2603:10b6:5:1c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 19:46:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 19:46:03 +0000
Date:   Mon, 7 Dec 2020 15:46:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
        Divya Indi <divya.indi@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Moni Shoua <monis@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Ursula Braun" <ubraun@linux.ibm.com>,
        Xi Wang <wangxi11@huawei.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <target-devel@vger.kernel.org>
Subject: Re: [PATCH v5 02/16] IB: fix kernel-doc markups
Message-ID: <20201207194601.GB1773945@nvidia.com>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
 <78b98c41a5a0f4c0106433d305b143028a4168b0.1606823973.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <78b98c41a5a0f4c0106433d305b143028a4168b0.1606823973.git.mchehab+huawei@kernel.org>
X-ClientProxiedBy: BL1PR13CA0258.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0258.namprd13.prod.outlook.com (2603:10b6:208:2ba::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Mon, 7 Dec 2020 19:46:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kmMSP-007RUz-5K; Mon, 07 Dec 2020 15:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607370365; bh=9lg/42DcldbZG9mBToOsz7dSGb1mt3xyDZpRUGNgKdA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=fk0Iq+PF7ZjSEtzHMMwR6YJe75J+ryn3hidtBgQkmWX0k7aQYU4TnZoj2rWklj+tU
         zyFGvjb7YcaQxyx//1a57Zl9mTg8NvASeAS/hUqwQcSmKz35+JT2ZDahzrag5z3vPf
         gaqZcnoF8BKdSFaO9GSOYKd3+8eK4RoCt/xK4Jwb2pfQxIQmM4az013pX8c6y13rq0
         eP2nw85YI6iRhKf70du96XmQRSKOe/e08lgRFrrKSXW+GLA0QgZVe6U73ovN7X6VKI
         7feVbPDtKClztluzZfgy2nkScxPYYowgsBcIHkInr+wIxDWNP7sEScNIF9CX+1W42J
         mSwnF9dso0CzA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 01, 2020 at 01:08:55PM +0100, Mauro Carvalho Chehab wrote:
> Some functions have different names between their prototypes
> and the kernel-doc markup.
> 
> Others need to be fixed, as kernel-doc markups should use this format:
>         identifier - description
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/infiniband/core/cm.c                         |  5 +++--
>  drivers/infiniband/core/cq.c                         |  4 ++--
>  drivers/infiniband/core/iwpm_util.h                  |  2 +-
>  drivers/infiniband/core/sa_query.c                   |  3 ++-
>  drivers/infiniband/core/verbs.c                      |  4 ++--
>  drivers/infiniband/sw/rdmavt/ah.c                    |  2 +-
>  drivers/infiniband/sw/rdmavt/mcast.c                 | 12 ++++++------
>  drivers/infiniband/sw/rdmavt/qp.c                    |  8 ++++----
>  drivers/infiniband/ulp/iser/iscsi_iser.c             |  2 +-
>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h     |  2 +-
>  .../infiniband/ulp/opa_vnic/opa_vnic_vema_iface.c    |  2 +-
>  drivers/infiniband/ulp/srpt/ib_srpt.h                |  2 +-
>  include/rdma/ib_verbs.h                              | 11 +++++++++++
>  13 files changed, 36 insertions(+), 23 deletions(-)

I've taken this to the RDMA tree, thanks

Jason
