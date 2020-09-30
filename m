Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8B127F152
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 20:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgI3Sbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 14:31:40 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18757 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Sbj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Sep 2020 14:31:39 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f74cea50000>; Wed, 30 Sep 2020 11:29:57 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 30 Sep
 2020 18:31:39 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 30 Sep 2020 18:31:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XQUILY4uSIcxmfRJ0eNhdcry/QHCR5iRqKPC1I+YgO3/iPwCqwMIaO0At4SLB68DPpoTgNJOLGoWUpA8D9Mf19vd5+i+dju50Mzd1QoNWv7+SBijXPByuVqlApB/Yz0rJ3PfD92X9XFvoXNn1VJjQYhf2jOXfNnoUsIUGuGxfH+LRHuMY3v1ogQIDjomTlyp2k9Y1JejDFHTzGagWkpVY4zrMyEGbtOzOdL9kG9AaQwLmbyY6QeOFdWBRa6/F7oq5/vpJWY4BIY+bGIqTOb53z/DZN90J5Bvm9K1KtKaJm36uxgWXTUdkwdAXYOsn9dPXX46DT7N/LUFFG77wMXtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB2nvRdtDK8IaIifUGstgSGDWJX0GKZ02H7z/AWtzKI=;
 b=T/gluFGqPJqx5Jsv777VOqRHhhJbYQ+41zLaj4Jv4aIx2778DhnNDVQRcI3qx4S9JpU5dv8YtQKu0ssF4Aevp0sp2WEoi2RPexZW1FXgRyhV7Kp/S8yekI2YnCymG44nwsw4rGeI8o7IJ/V9tUjpfsFvn3ISxugSRmfHVrkY6c4nnjYF6eHhGkySuJOGyIyz7b06C0YOXEseFi3vJ/0OD35IWCrzQ0Bgw00L1FNSB0U89SPtyY3mW+PhGpAwVBiMO2dSUZbL28ejMznigtqeMw6JS3Tqd2UY25cQFKU4DlDso22npkHunal9EYtvs89/iqpqJum5OVPKHycM2e/ezw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Wed, 30 Sep
 2020 18:31:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 18:31:38 +0000
Date:   Wed, 30 Sep 2020 15:31:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Dan Aloni <dan@kernelim.com>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/addr: Fix race with
 netevent_callback()/rdma_addr_cancel()
Message-ID: <20200930183136.GA1031970@nvidia.com>
References: <20200930072007.1009692-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200930072007.1009692-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR20CA0050.namprd20.prod.outlook.com
 (2603:10b6:208:235::19) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR20CA0050.namprd20.prod.outlook.com (2603:10b6:208:235::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Wed, 30 Sep 2020 18:31:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kNgt6-004KTf-Iv; Wed, 30 Sep 2020 15:31:36 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601490597; bh=aB2nvRdtDK8IaIifUGstgSGDWJX0GKZ02H7z/AWtzKI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=gHTN+vZBqNlaz4TPu1EuZrWOyzjKF8GnutYRQI3jC0H2JEjwBJ/OBYOK6JTnZbWnc
         9NT2gIzE2HmFtIonl6xdD8XZ5PIpYBOuqYGRjc3jGbZj5cT5LBLf4Ml6Hc0XckPEoS
         9poZn2bqbReYTLzBAzISNzLeejSM+oeCLHtnVfbJZt9UbZx93Fr7c2WDR1ML86IObm
         2FzS9TQ8L0/VcPeW/gREOEqGxTcRAWGnCityxtY/Tx9kjQc5dWNGdIr0930ZMUxG/5
         K9TmavdJoCsrF7K11BZYsBJbxlMJVYZbhXX1FUDQ14NwQmwsyU5EPmE5B3Bm9x4PgO
         HWnfB+Sel8o5w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 30, 2020 at 10:20:07AM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> This three thread race can result in the work being run once the callback
> becomes NULL:
> 
>        CPU1                 CPU2                   CPU3
>  netevent_callback()
>                      process_one_req()       rdma_addr_cancel()
>                       [..]
>      spin_lock_bh()
>   	set_timeout()
>      spin_unlock_bh()
> 
> 						spin_lock_bh()
> 						list_del_init(&req->list);
> 						spin_unlock_bh()
> 
> 		     req->callback = NULL
> 		     spin_lock_bh()
> 		       if (!list_empty(&req->list))
>                          // Skipped!
> 		         // cancel_delayed_work(&req->work);
> 		     spin_unlock_bh()
> 
> 		    process_one_req() // again
> 		     req->callback() // BOOM
> 						cancel_delayed_work_sync()
> 
> The solution is to always cancel the work once it is completed so any
> in between set_timeout() does not result in it running again.
> 
> Fixes: 44e75052bc2a ("RDMA/rdma_cm: Make rdma_addr_cancel into a fence")
> Reported-by: Dan Aloni <dan@kernelim.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/addr.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Applied to for-next

Jason
