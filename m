Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213862F3A42
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Jan 2021 20:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393152AbhALT0I (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Jan 2021 14:26:08 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1965 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392189AbhALT0I (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Jan 2021 14:26:08 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffdf7a80000>; Tue, 12 Jan 2021 11:25:28 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 19:25:27 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 12 Jan 2021 19:25:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZdBNZZ2R3fT2B+LA0N9BJakMJ+uEhfSWPDuVYU8nIZr/rAaoOPt7RPCXx/EuFk9M1VXdlCJesKvFLmEpnvH7yK5Sov+94W2LorBIulEuP6YW4gToWy+xODtUUXqii49aPHySoOvM7iPAcwO1v58/zkd4kTv7NiYItaX7tWT5lrHvt0ZxgRfehv4d/jDkhsFMO6JzZYFSkvIevEtnPAy7+zvfeyT6Qzr5gMCgZMPljcRH7DS/CJLWXos2cKwPjX6ywN8hdoCH3ak8FsQk10u8AR8OAfLGmbSrliQv6fgCygca2ZtXaoUAZJC2f4T1GN/Tc3YmabCsK4m8YmqvCdPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cT86yUCBYAMKz5yz/SYaqiFAUtQLJ5mLcDLMME/vBdo=;
 b=DWJ4lkRQMPwkldAoJ+Qf/LnYyUDZ5UG+OY8LaxWfNqTrSgRzWxh3zhRHMCIzG6DNWrdbeOo2SxE0WdCIgyXvSMv9QCWXVLr9Bf904G1PImFjuPjdJ6kBjQfc3nGRlVJkO7r9JjjRt7BmEOUdzTLoVaLgiYn/mclLkAGQgKfwnkOYxrtwFN1mGc0oHBH/uZRUF+ciZdKQ5YRgcTDwDuiBBHuEvnSBvw8rc4ZfVdIF07r/nWpNhvkT5MHXS0S7A0EWTUO3jrklUcA8iM9hys7AE6t8xqBGqlV9VKQJinGjzhxLc1VvRsRweC2+dIg4FHZv80UOuACX5OwJ9fkMlOkl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 19:25:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 19:25:26 +0000
Date:   Tue, 12 Jan 2021 15:25:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc 3/5] IB/umad: Return EPOLLERR in case of when
 device disassociated
Message-ID: <20210112192524.GA17254@nvidia.com>
References: <20201213132940.345554-1-leon@kernel.org>
 <20201213132940.345554-4-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201213132940.345554-4-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:207:3c::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL0PR02CA0026.namprd02.prod.outlook.com (2603:10b6:207:3c::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 12 Jan 2021 19:25:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kzPIC-0004XA-HD; Tue, 12 Jan 2021 15:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610479528; bh=cT86yUCBYAMKz5yz/SYaqiFAUtQLJ5mLcDLMME/vBdo=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=OnLBMCy7Mv6hwdGTEb7+PtmJ30TBqZ7Ijz1Px37erRkBi4ekYU0tSjuO9Nw0nfELG
         OkRjhs7mXzYa9bBL5aqqSuOsFkMByN2GVm7ee8TKmh0arcTKITWXikQNhT58soWBfI
         OzW+rxVmX+ID7OhmLM4hxlOwne2ZcJBc+hbxuYuZ4jB7OfLxNpRh6KGnoK7dv2GFv4
         4G/vmeMBekw9Uo7OalAHDdpePeiA4cr4rivr5vfqtK6IlJFcG0HOoK7Wz8Eha8hZm0
         pAv/ZjI4LqvOc+JQshQW6f+LJ3yRtw9sh4efLRNkeAr2ZJHm8QrRUKV6yqL/t0xerv
         01X3ScnTf1vHw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Dec 13, 2020 at 03:29:38PM +0200, Leon Romanovsky wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Currently, polling a umad device will always works, even if the device
> was disassociated. Hence, returning EPOLLERR if device was
> disassociated.

Grammar:

    Currently, polling a umad device will always work, even if the device was
    disassociated. A disassociated device should immediately return EPOLLERR
    from poll() and EIO from any read()/write(). Otherwise userspace is
    endlessly hung on poll() with no idea that the device has been removed
    from the system.
    

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/core/user_mad.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
> index b671d4aede77..6681e9cf8a18 100644
> +++ b/drivers/infiniband/core/user_mad.c
> @@ -653,10 +653,14 @@ static __poll_t ib_umad_poll(struct file *filp, struct poll_table_struct *wait)
>  	/* we will always be able to post a MAD send */
>  	__poll_t mask = EPOLLOUT | EPOLLWRNORM;
> 
> +	mutex_lock(&file->mutex);
>  	poll_wait(filp, &file->recv_wait, wait);
> 
>  	if (!list_empty(&file->recv_list))
>  		mask |= EPOLLIN | EPOLLRDNORM;
> +	if (file->agents_dead)
> +		mask = EPOLLERR;

This also needs to trigger the recv_wait when agents_dead is set in
ib_umad_kill_port()

Jason
