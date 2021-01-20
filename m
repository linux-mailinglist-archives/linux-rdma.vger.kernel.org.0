Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CCF2FD725
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 18:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbhATReS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 12:34:18 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6148 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbhATRZe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Jan 2021 12:25:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B600867600000>; Wed, 20 Jan 2021 09:24:48 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 17:24:47 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 17:24:45 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 17:24:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJozRSANPYLZWtZagPQ+WbZJDkZthIevyxhOIUXieunQG6Y1mJ3UlPYyUujo2Q7YhaK7owgKIbpDoYjmYb27ha3sYPzRmq6sH3Rz2GyInsLkCADAB73USbpznxJHWy0M85h7Mn6wFtNLoy6FUQPwyfp4ukoum/oleUoJtd5awDUhCShX3GKxybCbeipVxySF1K09kDjImZgP9wHUGY9AcIMIoIEq/k4M7zLRywT2z4fJSq14cE/jYlou2i3ekRu3vAiL8BAYEXOp2lV9gq3/ARLfUpIbGiviTMqRUosF+6FB79jNgJCKSaJiTqppS5UTzWscn/FNAIw/7fgda+x6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZK3TvjmAXZGxCH23bJXHRfw73teOnwsChL0u/Ew4O+g=;
 b=MLgdidWYKwhtpVEERvdGsiGK1aIxHfffwKyhCSUWz9oHM4cPASh9uUI7yXKQbf+9oxIYun2ize+E7raemvA9880sBwgZC8eDItFdOHlSY5FhGJJX+SBxWFxVXjYOEPVTTRPm9M+bgKrHRSCRuoGg9IVGbQuo3H02YDg42/nPZM8moRda8/9QDV7ily12+hZiea8vAX6UEw3h7LB5NgnMo/hXUxkI2xSCeyz1YkFToz6Qi92ldSsinwOY4n52DFQtakU/z6kZtf/drlz+jRAPZM7Nk2D7Vmhf3wUs9PLA69d9ILyWZ46vozRL9JVbt/T4jTmMO8JnakkJAezfpvgTHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Wed, 20 Jan 2021 17:24:43 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 17:24:43 +0000
Date:   Wed, 20 Jan 2021 13:24:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <mwilck@suse.com>
CC:     <linux-rdma@vger.kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>,
        "Mohammad Heib" <goody698@gmail.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Subject: Re: [PATCH v2] Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
Message-ID: <20210120172441.GA1099203@nvidia.com>
References: <20210120161913.7347-1-mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210120161913.7347-1-mwilck@suse.com>
X-ClientProxiedBy: BL0PR03CA0017.namprd03.prod.outlook.com
 (2603:10b6:208:2d::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:2d::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend Transport; Wed, 20 Jan 2021 17:24:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l2HDl-004byp-Ih; Wed, 20 Jan 2021 13:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611163488; bh=ZK3TvjmAXZGxCH23bJXHRfw73teOnwsChL0u/Ew4O+g=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=QdaI7310CwZ0mIYydqfyiQU3wv/BuGNSix//O3ywrEapPRmcQIqkqMinW5r0ySqiF
         UEUxj8KxioGMnfSQNVQNc9VgJlC+ozqf+wpmPIRqGENfVKFHESzld7n0Z94mBm8ZN6
         L0qoX+bqO5yZKyOYgGKwe0+yyHkI5u/hB2V+TBSJJMtuhNQr8sSDB6U6qeZAFh2cJn
         DcDazfmueYMC1UVM07JBpyAIsehioT1G4h9GwNoYxbl7JVcQc3Oi957H2joXMplz0l
         mV08h8VWihM4AiCzlySa8FW+WJTpllD9AYQj02CTZ4Jz92D4DyjK7eoJY0ffrPskA8
         ElBCAJySn4amA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 20, 2021 at 05:19:13PM +0100, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> This reverts commit b2d2440430c0fdd5e0cad3efd6d1c9e3d3d02e5b.
> 
> It's true that creating rxe on top of 802.1q interfaces doesn't work.
> Thus, commit fd49ddaf7e26 ("RDMA/rxe: prevent rxe creation on top of vlan interface")
> was absolutely correct.
> 
> But b2d2440430c0 was incorrect assuming that with this change,
> RDMA and VLAN don't work togehter at all. It just has to be
> set up differently. Rather than creating rxe on top of the VLAN
> interface, rxe must be created on top of the physical interface.
> RDMA then works just fine through VLAN interfaces on top of that
> physical interface, via the "upper device" logic.
> 
> I've tested this mainly with NVMe over RDMA and rping, but I don't
> see why it wouldn't work just as well for other protocols. If there
> are real issues, I'd like to know.
> 
> b2d2440430c0 broke this setup deliberately and should thus be
> reverted. Also, b2d2440430c0 removed rxe_dma_device() (which is
> indeed not necessary), but not its declaration in rxe_loc.h.
> 
> Fixes: b2d2440430c0 ("RDMA/rxe: Remove VLAN code leftovers from RXE")
> 
> Cc: Zhu Yanjun <zyjzyj2000@gmail.com>
> Cc: Mohammad Heib <goody698@gmail.com>
> Cc: Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h  | 1 -
>  drivers/infiniband/sw/rxe/rxe_net.c  | 6 ++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c | 5 +++++
>  3 files changed, 11 insertions(+), 1 deletion(-)

Applied to for-rc, thanks

Jason
