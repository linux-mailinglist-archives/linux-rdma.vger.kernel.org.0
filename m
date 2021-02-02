Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953A130C390
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Feb 2021 16:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbhBBPWl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Feb 2021 10:22:41 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12978 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhBBPWB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Feb 2021 10:22:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60196dec0001>; Tue, 02 Feb 2021 07:21:16 -0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 15:21:16 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 2 Feb
 2021 15:21:14 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 2 Feb 2021 15:21:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Imr8l03ETBN/x4qPi2fl+uO0CIOMt/e6n8Myt5wscrAWs3sDf8/whEJ+/ROifIQ3oiYmuJEaecUNwfiBG1EH6lGoOEkK7QNh+dxARxjjBrjdSGbqknu+1HIT68gO1MC779ilpCptm7Kg/RFxYArAgTVyxtYVMhG+cu/OhEckEMu/3oQOQwlHkLnpYFEkzZ3Ypr0k6B+aHbb6eyM/X68xAi9h9a6nYlQef0iXB+2T+r1DeXNIuXH7XC9glzmRVQRutzdK4ammIGMPpkZsugdAbs6YClzO5YP6tc3pTqA5Q9VpPlH3PWdrhXb+CG/ZMPsa/ucUKiIhwDTRYYJzNqCmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Et2Gr31MBoQ7d2Nf3+cdQcXOU+/1zCpWMIdjhCH3LwA=;
 b=TSwz3AxVBSYEVUjuTXmLpiqphM/wv+bV8H/Oou7lbVBGXhTpl1hmH0D+ZRRpelC7lxexR3jOAQf5T/jd7Wej4ODFHcxfN4ifp7zw0DtNGhy1xe0n1I3hOcnQTzeXGMVX6cuI5AkBMnB8JW4DNEYopUQ2WMyxGP38vP7mlq0usTIQkfW+sbCPzi+w+tzVwPlXj3rhEkzjskotjHtq1nLXRXw9mQbogj1w6mI4HqCdlv1pRk0nWbJJvkSKt8lVxO1a1h0HcoyUSaBIqEkHM1dv41NSBr87SHBOBk3pFrjUQt2SfTumkxOJDK2PgAjYFzd0Hpf17xcBpMj9+y9BoILaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16; Tue, 2 Feb 2021 15:21:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3805.025; Tue, 2 Feb 2021
 15:21:10 +0000
Date:   Tue, 2 Feb 2021 11:21:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Parav Pandit <parav@nvidia.com>, <linux-rdma@vger.kernel.org>,
        Mark Bloch <markb@mellanox.com>
Subject: Re: [PATCH rdma-next 07/10] IB/mlx5: Return appropriate error code
 instead of ENOMEM
Message-ID: <20210202152109.GA617190@nvidia.com>
References: <20210127150010.1876121-1-leon@kernel.org>
 <20210127150010.1876121-8-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210127150010.1876121-8-leon@kernel.org>
X-ClientProxiedBy: MN2PR16CA0007.namprd16.prod.outlook.com
 (2603:10b6:208:134::20) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR16CA0007.namprd16.prod.outlook.com (2603:10b6:208:134::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 15:21:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l6xUL-002aZk-CN; Tue, 02 Feb 2021 11:21:09 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612279276; bh=Et2Gr31MBoQ7d2Nf3+cdQcXOU+/1zCpWMIdjhCH3LwA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=nAXJxr2AxvPAEjM/SuHCCZg5KTS5+DLpL83pFrmv3MM+sbd2jI5sq2G3EmWi1Qcf2
         hF9roy8bQbwTSml0kn4oAx5+Ww8XISj9Lty10ZOEkE3vnXQYvmEzS0S2iD1n4KUIwH
         I5UjrPAjWonMOWf48/LKr9q1s2o06DRTenFvAsFi6YtogQNg7wolByqdSckzJARl8W
         mbq4ZDCojP79m3mgkkQ15waHLxZIVrC+6OPKlFXLujQsSIOvFJCNIYoJ9QQqWfb0L1
         TojD0vPJwmBsFLE+Ibg2gtKbrb/31KwpDZXDVTlpDo3MWtYAcynMZyNp/wZnf2MoRg
         YKllGGWbM1CCw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 05:00:07PM +0200, Leon Romanovsky wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> When mlx5_ib_stage_init_init() fails, return the error code related to
> failure instead of -ENOMEM.
> 
> Fixes: 16c1975f1032 ("IB/mlx5: Create profile infrastructure to add and remove stages")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>  drivers/infiniband/hw/mlx5/main.c | 3 +--
>  drivers/infiniband/hw/mlx5/odp.c  | 4 ----
>  2 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index ad7bb37e501d..9e8b4d591138 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -3952,8 +3952,7 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
> 
>  err_mp:
>  	mlx5_ib_cleanup_multiport_master(dev);
> -
> -	return -ENOMEM;
> +	return err;
>  }
> 
>  static int mlx5_ib_enable_driver(struct ib_device *dev)
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> index f4b82daf1e22..a1be8fb2800e 100644
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -484,10 +484,6 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
>  	}
> 
>  	xa_lock(&imr->implicit_children);
> -	/*
> -	 * Once the store to either xarray completes any error unwind has to
> -	 * use synchronize_srcu(). Avoid this with xa_reserve()
> -	 */

It is not wrong to remove this comment, but why is it in this patch?

Jason
