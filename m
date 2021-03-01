Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95729328C66
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Mar 2021 19:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbhCASvX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Mar 2021 13:51:23 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12470 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240638AbhCASsp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Mar 2021 13:48:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603d36df0001>; Mon, 01 Mar 2021 10:47:59 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 18:47:58 +0000
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Mar
 2021 18:47:56 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 1 Mar 2021 18:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXZgn9M8m7ICpZrRenYRVQ4g10QGI5FhUVVf2XT5YA05gTr6xOI2emC6CV2mrrwhruq0EuQvt+HnLsBrmulXiKBcVquNl3hXl6DJw1amTJUXTCcTk8+uM06E4IEYfR8Pc5UI4+si6eia0UbsTZ8PbctN2EJjtkME+72yRginBy/6wdS6OSmc4Vewk1GaKtDyR62v66xB1eopPh18n+CD03DhXi375fZ1+rqjbzdgBmueJFBVVXUEV1EVK0YpFji6LK4Q6tXrkcZWF+Q6mTt++NGHyfaVC4Qgd71otvLgpi3Uzn1bDGpk5OqyCJi9MaHzWQDnS7spj/NCgAJjdvFycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ/UNJAiv1R8wx9qKzPHkP6I2AYkS9cs3lkvcucWcdc=;
 b=A4+9fc0jY0cUhGovwrC97mllD5g1MDAhkFk1oFkvQao1e1mJxUNt2VRzWVBVCI4sjFNYOmDHsCWkLCWKSh/h7SMh35DtL45GgNATg6uL8f9kE46cT+5+8fb6gnPClvx9AGNydXIW2GzQmG7ptgoDdLDlrc3LW5Y0wg4ZNp2HoeibsoU8k/s0fgj3uRX67Id3c6NIEa+vc/9IOLt+f4ic9E3DsxLptQQfEEHIdLqPbAGM+CFqsyzo4Ol+/v/C7FU/EoyOJahu7wT8jcBTQz5dH4m989WzmEDb+UxMV9SWKqcuq0xBP4yYVI2ZnzT8zIu7QON/Yo3as+OM0jX/jU90qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4009.namprd12.prod.outlook.com (2603:10b6:5:1cd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Mon, 1 Mar
 2021 18:47:52 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3890.026; Mon, 1 Mar 2021
 18:47:52 +0000
Date:   Mon, 1 Mar 2021 14:47:51 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Maor Gottlieb <maorg@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/cm: Fix IRQ restore in ib_send_cm_sidr_rep
Message-ID: <20210301184751.GA745887@nvidia.com>
References: <20210301081844.445823-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210301081844.445823-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0044.namprd05.prod.outlook.com (2603:10b6:208:236::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Mon, 1 Mar 2021 18:47:52 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lGnaB-003835-IB; Mon, 01 Mar 2021 14:47:51 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614624479; bh=KJ/UNJAiv1R8wx9qKzPHkP6I2AYkS9cs3lkvcucWcdc=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=V5DEIBhG/xvmcK6PRBnIaKAV9XRESMVMOau87GIgAKq47gG0fg1Xgj8kcKS/gA3G1
         vWw8pN99HsuyK2Vj6QmCpxSvNWIcFrM1EpW3XrMFQsb3zb8JXM6JxAI7ZLFKbopPIK
         hFbZm7yjCmVDih4xM8KF7/jnhlfk4lh2QfY7AzIgrkBKKPRWj4EQsRqsw2kRhW1Dty
         smrbfIbznVYkHM4VdPbMjQhwyJzA9XJ4/Bzsd/PhWwopmLvd/5pRAbUztsvsBs+orv
         ada/iuyr0lDBvv1fIC7i8YoooWXT3xoFEdHtf6yScNHZDR1/1M3sRYWFMCGYs/DS2q
         X8786/UVxQy8g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 01, 2021 at 10:18:44AM +0200, Leon Romanovsky wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> ib_send_cm_sidr_rep() {
> 	spin_lock_irqsave()
>         cm_send_sidr_rep_locked() {
>                 ...
>         	spin_lock_irq()
>                 ....
>                 spin_unlock_irq() <--- this will enable interrupts
>         }
>         spin_unlock_irqrestore()
> }
> 
> spin_unlock_irqrestore() expects interrupts to be disabled
> but the internal spin_unlock_irq() will always enable hard interrupts.
> 
> Fix this by replacing the internal spin_{lock,unlock}_irq() with
> irqsave/restore variants.
> 
> It fixes the following kernel trace:
> 
>  ------------[ cut here ]------------
>  raw_local_irq_restore() called with IRQs enabled
>  WARNING: CPU: 2 PID: 20001 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x1d/0x20
> 
>  Call Trace:
>   _raw_spin_unlock_irqrestore+0x4e/0x50
>   ib_send_cm_sidr_rep+0x3a/0x50 [ib_cm]
>   cma_send_sidr_rep+0xa1/0x160 [rdma_cm]
>   rdma_accept+0x25e/0x350 [rdma_cm]
>   ucma_accept+0x132/0x1cc [rdma_ucm]
>   ucma_write+0xbf/0x140 [rdma_ucm]
>   vfs_write+0xc1/0x340
>   ksys_write+0xb3/0xe0
>   do_syscall_64+0x2d/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Fixes: 87c4c774cbef ("RDMA/cm: Protect access to remote_sidr_table")
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
