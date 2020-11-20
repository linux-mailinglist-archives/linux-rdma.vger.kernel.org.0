Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0387A2BB6CF
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 21:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbgKTU2z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Nov 2020 15:28:55 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7156 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730330AbgKTU2y (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Nov 2020 15:28:54 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb826fb0003>; Fri, 20 Nov 2020 12:28:43 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Nov
 2020 20:28:54 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 20 Nov 2020 20:28:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GThzPNrW7v3Esa4ew/15QeDJIh81HNWn7VvxfsH+ulbe3+45hPgrr3H6MStGLdPTPE7yF0ibq2PgOUvqLyQ3H7ZJc63h39nNuI0L17VUxC6POVyKx16Wgp0uXjCGYIckWNJi+l3Xny4YPzQSjJ+fTsvzx73/cEUWNaJvTvENxNJtuHoD127pkYeVX2khEIFRbPkkPnM7Fzzr19lBS0TqXaEIfbiP4KMZxuavxorQam9finb7ckebx8kAruHY4+XYjEvlvLlt/rG5688E3Jwv9gXU7Iezfi8yZbSAmVKhhuhDSzw9/V6dHUCGYVk/4vFzgrHG+kvYGomFhpRXiQ1iZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcTVagKS0DGuqV6n+Gpyu6UA0TYp0RVlZ3ao0+6TwnQ=;
 b=cpi6H3h3qPfNnf63ZK/8Hd/vVMYFtx7YcocWc+SBlPspPLyDHWGeE8VrEzBn7qODMcFBrYFBWR5++lIn0FgomQh/AQZbhg3pN6izBTmtbi0WrPh00LytgdH5ULj93w1smzp62J2+mdkasFsSITYN0a09KiO8w15NpbytoWDerMZY6cb2BR5w01tWzARcEOSxVZrj6p8mGn8m9Snv9QYW41NL619giQ9/X/6w0TRGtPPdOVU5Bto2CD1QjhgEr5Lh3BZSrzOxAg9Yz+0eHibKhjp3G/PGiPa9CMwcbKggHIXtMyS6VYGP+x4fN7Lvf0sgl7uzCEq+bY6epIbYPF7NBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 20:28:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 20:28:53 +0000
Date:   Fri, 20 Nov 2020 16:28:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>
CC:     <linux-rdma@vger.kernel.org>, <bvanassche@acm.org>,
        <leon@kernel.org>, <dledford@redhat.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: Re: [PATCH] RDMA/ipoib: distribute cq completion vector better
Message-ID: <20201120202851.GA2139582@nvidia.com>
References: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201013074342.15867-1-jinpu.wang@cloud.ionos.com>
X-ClientProxiedBy: MN2PR14CA0006.namprd14.prod.outlook.com
 (2603:10b6:208:23e::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:208:23e::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:28:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kgD1X-008yda-3U; Fri, 20 Nov 2020 16:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605904123; bh=wcTVagKS0DGuqV6n+Gpyu6UA0TYp0RVlZ3ao0+6TwnQ=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Zg3f1MVUhCXEhuc5xMBDnb1Kd8ZXN5uYKwceB6/QCTgYrfjwKpPFkusIANs4Rfgp9
         +dlX/VoUqjSzM/jhiBKMGqJuJL/6BzqWqGi33766gTRMO5/giEeVhCx4sqxn5kX1S2
         eA3Ep6b9MG5HKGIEr3MI8m9cpuaHKOsa0dvl4vJiW4kIA654Ial9R6sIKl3dbWkZin
         2zpiV92bXPcs9GYGKjhR/Lh6qyUYd6iLJVwUoycFdE+thuA0a80ed/eIFx5oEkGQGu
         LppEutocjLH8Az5tfXBXW3Rqs6DnG+dKg+7oUP6TaSbhyD0xUPIfwAV3rT0crFhN57
         C8wrs28R0A+/Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 13, 2020 at 09:43:42AM +0200, Jack Wang wrote:
> Currently ipoib choose cq completion vector based on port number,
> when HCA only have one port, all the interface recv queue completion
> are bind to cq completion vector 0.
> 
> To better distribute the load, use same method as __ib_alloc_cq_any
> to choose completion vector, with the change, each interface now use
> different completion vectors.
> 
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
> ---
>  drivers/infiniband/ulp/ipoib/ipoib_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for next, thanks

Jason
