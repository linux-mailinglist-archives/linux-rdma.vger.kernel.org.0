Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3655E31450B
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Feb 2021 01:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBIApZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 8 Feb 2021 19:45:25 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7385 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBIApY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 8 Feb 2021 19:45:24 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6021dafc0000>; Mon, 08 Feb 2021 16:44:44 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 00:44:43 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 00:44:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwA6rsjcZ7qiVBLDzPyr5s2KsYX5X1UWCHMbcZnG6cBx6DwbnyNvKoz97ufCWEux0FmXL6sDcEqLzZ/HyP1s1UNq8HAFwPyCLw8WI1BQBJwABEOwXuG8ge2S/SGnMIGMgFjPLpTDbelYL4KyoNGkNee7sYjcWBZWX2jXETrPEq+c+ztrytpWAu2sjvEOEFYpDaP11Tsq131H3ohfQ8/U+88aSrMOWqCI/Ihs4YP4DC/PJUHdDltd+jN5OYh7Fp3FOuYYBVe7NRR7UIRSrxZ/pzK8mk53kHoJvwNvQ0ZV59bs5jlDsupFrD9hCcB8HQZbcUf5fOnECZbaSeRPFinqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sC7voFPyQ0Vmce/DS7E5s2IK+uMdtCFTdmflxIClRCM=;
 b=A/7bgl4SkKXkhy3qkNaPQC+RFoEW/79/AmqpCTY1EiQLCAgu5LZic6r9WLnJGn4Ox+ulrhm+wXjUVBD6k1i4Sh3FRf+5KtsEqzFTvJ22a9M5l13m39gtZFWnm/bk3rAs8SHaNLSlYpeugc4H5Kb4n8MXFz/yHw/Ng1Tv2mCQN1iqWhs4HmrtzdCrxT7vcQNektU4MhGxWTkYe0uBUwuAF+ZD030vsFvDhCOm6upIJtgJoWartgI4Cfx+qhf5aNL9DjmOlRQVju8TElKFYHLBrfULfVur6Ov+O6AFNLwvp+XJ2QK8tz64aP9LslWo5/3P5UEt8n1y7x8PYfZiixvNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Tue, 9 Feb
 2021 00:44:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 00:44:42 +0000
Date:   Mon, 8 Feb 2021 20:44:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH] RDMA/qedr: Remove in_irq() usage from debug output.
Message-ID: <20210209004440.GA1255903@nvidia.com>
References: <20210208193347.383254-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210208193347.383254-1-bigeasy@linutronix.de>
X-ClientProxiedBy: BL1PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0112.namprd13.prod.outlook.com (2603:10b6:208:2b9::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Tue, 9 Feb 2021 00:44:42 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l9H8y-005Gjw-Oo; Mon, 08 Feb 2021 20:44:40 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612831484; bh=sC7voFPyQ0Vmce/DS7E5s2IK+uMdtCFTdmflxIClRCM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=RRQirrlb5NOtN4ML7beJeW1Ej9cmvumlpTlNURuJYsexNfKGO9Dqu+P9L7Ix1DlFi
         QHoVItNvvF1X6fK/8RXMHT3pAEXs2qpxGPKVwMdZSDSs8KX8Xc8l/XMZ9dw6RTSyCr
         5WxHDu/3xF2l9bguD+J/9wCLnBt6m/o+MRvsCo1xgTB2L3saBomeL7NchM8Wpi86B/
         nXyXTBdcvh1CyiOIbU7SLqs6Sj4UOQuLgDy7xX3kf0M111xod/VOJVK7coDon0uwtM
         dpZ+wwt4EwUu4gbw+W/I5hxNqt+FdLToyjKHt+tHKR3hAnUWnTMBSa8WQp0BX9xUaH
         Zp18J+Wwl+EFA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 08, 2021 at 08:33:47PM +0100, Sebastian Andrzej Siewior wrote:
> qedr_gsi_post_send() has a debug output which prints the return value of
> in_irq() and irqs_disabled().
> The result of the in_irq(), even if invoked from an interrupt handler,
> is subject to change depending on the `threadirqs' command line switch.
> The result of irqs_disabled() is always be 1 because the function
> acquires spinlock_t with spin_lock_irqsave().
> 
> Remove in_irq() and irqs_disabled() from the debug output because it
> provides little value.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/infiniband/hw/qedr/qedr_roce_cm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
