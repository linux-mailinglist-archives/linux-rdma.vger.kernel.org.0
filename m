Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80A42FBCEE
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 17:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbhASQvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 11:51:10 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5450 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731236AbhASQvB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 11:51:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60070dc90000>; Tue, 19 Jan 2021 08:50:17 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 19 Jan
 2021 16:50:17 +0000
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 19 Jan 2021 16:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjlCO1PHXk4EJRQaUPEgW2DnTfuDVuDePjS4uW64hyNp2R7VjcpkA/2goQVmIT0F6Aq0E784tPFwRMdznX0nD9b4IcZO78hIklTb8hOcNtKXgNELatR4V/sPYTqXH2cL2EPkVCdBPOZyGq3OfRC/llDfeq/2HL4CzLKjjIiEDIDcnsqqFZAB07j8iCbq3Tn7t8WDapOkZyCJi9QFrQt42AZqBWvm4AMno1dOlQuJM7DxWAzf1WqUzpgykHpYlRFTBr5J4Edqthrut/wGaWI/dNaYfCSpHk1s2ribw7IAiEjaZlmAV2t5dV/irHAp3EM59VI4bjXwDszMi3YEmKq4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+JTlu57P9gPnkJ3jUDTwD91tN5ghJrX/iVCJRHHT6E=;
 b=Kxwin+ycHE1IQDeqEGjpq9VOHtowwK3+S+y/j6hBBsW8AVT11WQPdvbQgu4yJZkoznO5oreBP3p8qY3iCUV2MOMv+j2NNwHM1YrfsOsQNRu6V3hAF+0t/jHiaEMeE1Ji3vWupObizJIigfB6F3++FSIXzp1Yph07hv2QLStS/6OFEYLS/yMalPspOn/fOUzdZiMUUupvFTKndtZMaTMHz3xkgpaHbQ/2P3itdFe6MGt2xuRsL845HNIFYPDM4MriUxz4/0Nt1WHbLbXXtCTmn29JwsTo9cofAfHUvoqNhjyvWq6qoXveN6dgcbFaIEmkeAGEoDxhVTdwT0pXtw26xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Tue, 19 Jan
 2021 16:50:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Tue, 19 Jan 2021
 16:50:15 +0000
Date:   Tue, 19 Jan 2021 12:50:12 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH mlx5-next 0/3] Cleanup around DEVX get/set commands
Message-ID: <20210119165012.GA906477@nvidia.com>
References: <20201230130121.180350-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201230130121.180350-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:208:d4::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR04CA0023.namprd04.prod.outlook.com (2603:10b6:208:d4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Tue, 19 Jan 2021 16:50:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1uCq-003npO-SA; Tue, 19 Jan 2021 12:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611075017; bh=x+JTlu57P9gPnkJ3jUDTwD91tN5ghJrX/iVCJRHHT6E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=oNnlU6ngDh2zgR56XwIfCxljhgAC0B3EiHw7wLoojQe+VOE1UOTNnnLqfk4dFhyDq
         C7+zgPChJHIoFRNZmu18FLLCDhxHYHjRtL/gdOcxbvhsId9Oo+dT0wNgctszjyV7l+
         OUJZ/PDoT1DsnKEeUp+xBqDKkYLcvUqSdzeG3F4CnvnNglrKTGIzBCTT8ufbhQoqfM
         5Z0ti2g27v6Hd/mnoukBn14el0DquD4UNTpuQuD0AdKvfae86yT4uH5ur/k8Sn2HOU
         GtqozPvQn6ElPT6undG44Xmt9CT2D9kS4iGrbOqzHnOBj7r0hIia4LvRYCd9gQU6Ut
         uGO06GbI64T0Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Dec 30, 2020 at 03:01:18PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Be more strict with DEVX get/set operations for the obj_id.
> 
> Yishai Hadas (3):
>   RDMA/mlx5: Use the correct obj_id upon DEVX TIR creation
>   net/mlx5: Expose ifc bits for query modify header
>   RDMA/mlx5: Use strict get/set operations for obj_id
> 
>  drivers/infiniband/hw/mlx5/devx.c | 201 ++++++++++++++++++++++--------
>  include/linux/mlx5/mlx5_ifc.h     |  12 ++
>  2 files changed, 160 insertions(+), 53 deletions(-)

Applied to for-next, thanks

Jason
