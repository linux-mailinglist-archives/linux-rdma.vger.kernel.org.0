Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF0129D5C5
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Oct 2020 23:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgJ1WIi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Oct 2020 18:08:38 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:24373 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgJ1WI3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Oct 2020 18:08:29 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f99988a0000>; Thu, 29 Oct 2020 00:12:58 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 16:12:57 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 28 Oct 2020 16:12:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhHaEEMjnFIAUPTWod1a81ZOGJW98Y/4WrLEh32U/RK6AdBwggeWaXxugpPRalQ03JOQOcelX7tfGEOxtWeXb3LLNR9WH1RvK4GfZQOIHJyQYQi+DkW0SwaP3NlqJQXkusIbGfEtJW1BP5xYz8pULr7i/skzPUAnxPosqTq7eUkaOriGUnhxpHSeoukz6QKorymmrewB7/1zi3+2FwT+FXMfN4Alyoysoo2ZYIgM3b3abV/PdYPfazwNxrlaKOrmTqa5tomURFocKouuKkAsWwgc3bJ1DfkUwyRI7DJ9Sf2Ut9GyJqfpZ+flPNGIqGQGZC3QW9vGsHkW11Xb2lMzlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxKMLgGXgHoPSB0kxA6jBQoCX5EBSSdgxjg5G03ahFs=;
 b=J3UoYztvM5o2NqHcODr3+dZX8JSA/zOZeUXnya8p+OPkW9uYYp7uMXG5HGebu0STV6UwVtofls+9Y2ukqSdCYVrxsOYtAliGlB3I4CAM624RX7kmTD5+y7AqLNy5kbEucwIQw/AAnVCpO+PyvqQQx6JtLq746OzRA+EIWznQ4VAzl18Mw41Ah2iKuZuJFOrfq+Tkhs1zhQ8CoJGLkRJIA8tEHzPo+vR0a53o/pcjsc20saLsSNwo28oCmei5yPFBBfZBno904dnq3JuHnES2aHQsWF6C3qRBr/ocFPoIXAViX5N+t/MqypqgIU3P+c0rDuQveAlrnBhT3rK6qLkwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 28 Oct
 2020 16:12:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 16:12:55 +0000
Date:   Wed, 28 Oct 2020 13:12:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     <sagi@grimberg.me>, <krishna2@chelsio.com>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <oren@nvidia.com>, <maxg@mellanox.com>
Subject: Re: [PATCH v2 1/1] IB/isert: add module param to set sg_tablesize
 for IO cmd
Message-ID: <20201028161254.GA2437800@nvidia.com>
References: <20201019094628.17202-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201019094628.17202-1-mgurtovoy@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:207:3c::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:207:3c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 16:12:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXo4E-00AEC1-2E; Wed, 28 Oct 2020 13:12:54 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603901578; bh=OxKMLgGXgHoPSB0kxA6jBQoCX5EBSSdgxjg5G03ahFs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=QVwMTLNViQoruEDkHUBmmmId6uxq6xIOYd86VUSU/FctMd6vYKNbYFp2l6+48Izic
         tryQlaCL7zsfMHTd3gEL+WFgJJQb1zeGw5/i4FQG8ChK/a63obl8qOKkSTSbKiJ/Gv
         iCsnPBytmHRUrswqBXFdQMMXWO890QMgOexbPz137PHuIptVM2J6pry2cHSfKlYGBE
         X4ZXj/6lhHqFYCsSutTscgzzqVisviWm62bh3k413YrA3Fjesxwu8Am1B+uJFEiSyb
         B3+Lh9b9hhDQdhhd4xAf0zu+FjXeirP1Dt0AB4SRrvTCGDvckxkEMozjmAYXU8tknc
         u1UIKo2+MtZRQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 19, 2020 at 12:46:28PM +0300, Max Gurtovoy wrote:
> Currently, iser target support max IO size of 16MiB by default. For some
> adapters, allocating this amount of resources might reduce the total
> number of possible connections that can be created. For those adapters,
> it's preferred to reduce the max IO size to be able to create more
> connections. Since there is no handshake procedure for max IO size in
> iser protocol, set the default max IO size to 1MiB and add a module
> parameter for enabling the option to control it for suitable adapters.
> 
> Fixes: 317000b926b0 ("IB/isert: allocate RW ctxs according to max IO size")
> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> 
> changes from v1:
>  - added "Fixes" line (Sagi)
>  - renamed ISCSI_ISER_SG_TABLESIZE to ISCSI_ISER_DEF_SG_TABLESIZE (Sagi)
>  - added "Reviewed-by" signature
> 
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 27 ++++++++++++++++++++++++-
>  drivers/infiniband/ulp/isert/ib_isert.h |  6 ++++++
>  2 files changed, 32 insertions(+), 1 deletion(-)

Applied to for-next, thanks

Jason
