Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7634A299997
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 23:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394012AbgJZWYs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 18:24:48 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12782 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394009AbgJZWYr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 26 Oct 2020 18:24:47 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f974cb30001>; Mon, 26 Oct 2020 15:24:51 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Oct
 2020 22:24:47 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 26 Oct 2020 22:24:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4p2mA7YfiDUreDlgMyDU15AYjlcWehF0pyrvKDHjsKEli2K7YWfhkcL3J6jJiX4bj3JDyX14h84kFQpimFh+qeZUvAXHyrH0FwV5cSOpHIvhcp1053kVWAwckh/JvhxunwwN+RJTxux2ogf/kw3iMaZn2yRCOLGUkpSAfobjFxiTVuInn2qzeUxTWrT/5IG/6z/VsCN9LWLQyUItcYftYirDH4AlqcZ7e7l+cDSs5dOWTraopLtJkGzUzzsMFRvOksRHOTE4U/J+6TODvrcXErFArd1+PimnmXDpZsoSNB0JDtDZYooHi7k08uxnC3j7OSG5uEkwEIzlUxVf3grtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUsziEzhu3LGGCLpZ1R47C8JU/DZbDGJU20cPu6a8zw=;
 b=nm5uUitkOiy3Vr3k6E2gZ2LQeUu673l+LAKlbjq1emtPJOUAjaVTeiJpQNoLX59bCqrQME3nqYEmWlY/sJJBIAlo8IV0Nsa18fNU2DuYt8CNExlqEflbfUBaDCq+QDdKJPf71zTy5f/uzwlbQ8R+yaoeVH/OkSpbaQr1TaMxvqp2ezW3E9sSPOr+ydzKQZbTvVlYp5dkIr/xAUywurYCyHqRlLrGJo/Kz8wiBgOgsOryPlzdyPU1EvoT2PEU54hz3BQAqbriQl8PzBIa7mlt5fGVBH9iF2+zOuMYkxk2zOcgvJuNd31uj6LO6gto3SHnu6aTYz4gn+Y76ZKkkK5odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 22:24:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 22:24:45 +0000
Date:   Mon, 26 Oct 2020 19:24:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] RDMA/rxe: Fix small problem in network_type
 patch
Message-ID: <20201026222444.GA2066862@nvidia.com>
References: <20201016211343.22906-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201016211343.22906-1-rpearson@hpe.com>
X-ClientProxiedBy: BL0PR0102CA0032.prod.exchangelabs.com
 (2603:10b6:207:18::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR0102CA0032.prod.exchangelabs.com (2603:10b6:207:18::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 22:24:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kXAuy-008fhr-4u; Mon, 26 Oct 2020 19:24:44 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603751091; bh=XUsziEzhu3LGGCLpZ1R47C8JU/DZbDGJU20cPu6a8zw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=ZflLFqUDz8u26alPiNykusFHWmUdH8+wM7zXaXfX8hCgvpfvLy5A104cof5/K6ZQI
         CemlVtaxgXsoOduQ5AHzh9iqiD0esHFEvjOD9yY+5OMj7VRQGIzmJnZiiKheqBzDzz
         wRQd/mVD1D/RPDNhtp7ENBAsj6LskeDOcHP4JNpKmCc5XY8TTCvM4D8t6e7OFgHgdG
         it40Or6h/abZqlz2CH3QYiWy28wqhIY/03wxJP+WsDUd0M8d/NQopGvRV0aQQWrMAh
         yKRdPkp9cYVCBb83BbOJSr14Upc2IzBv17lupWc8cA3VubO/LdoBGsrjrO+fT7I2FJ
         SjRTipyTxDuBA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 04:13:44PM -0500, Bob Pearson wrote:
> The patch referenced below has a typo that results in using the wrong
> L2 header size for outbound traffic. (V4 <-> V6).
> 
> It also breaks RC traffic because they use AVs that use RDMA_NETWORK_XXX
> enums instead of RXE_NETWORK_TYPE_XXX enums. Fix this by transcoding
> between these enum types.
> 
> Fixes: e0d696d201dd ("RDMA/rxe: Move the definitions for rxe_av.network_type to uAPI")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_av.c  | 35 +++++++++++++++++++++++++----
>  drivers/infiniband/sw/rxe/rxe_net.c |  2 +-
>  2 files changed, 32 insertions(+), 5 deletions(-)

Applied to for-rc, thanks

Jason
