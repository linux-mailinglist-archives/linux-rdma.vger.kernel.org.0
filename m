Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA052852A4
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 21:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgJFTqa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 15:46:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:55135 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJFTq3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Oct 2020 15:46:29 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7cc9930001>; Wed, 07 Oct 2020 03:46:27 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 19:46:24 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 6 Oct 2020 19:46:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQbNuI/TS5P21CNHuwm/qeLqUACF8K9Ia3KBiHrC8DsMMwmy0JhGGKOhiu3k8V8rK0Kxw4+rLAuVNJR2ffgn2OEecGizlCtAkIYHtEBBiZvQIv00YVKIKk3A14eKXQv6TyiPg3PwARsWX45mQyKXRtMTYvkYgiQS2zZ8sSQytEnpqBZ8CVAAlHckH7Ia16fOb74XE3Ps4vYtCEI6jqkS5pg2UnAnegtszqpjzM+Oh697tnYQzJyBPtwT4nq2c4qTyeazsSLkEA8YXJF9p37tB27CMh/VqgxTn6yrZ5VMxCr21V0DKB9cAgCERQdWCoTFFlgx2PeO66GAa9+tYerc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X63s8k5wpma8KEvkJBdzGKPvuxgFKtgkFwHnpb8gho0=;
 b=YCF9zNbJ5Q8d0bhPEKEi/O8/5mO8JLs7XuYYu5NgV4lDCqazGejfdyYCtRD3Vk262gfHbf5exKr8efTYbNejLKS5vNthbwiXodADpAyess+sZOabkmd3k/GdHp9hyxdRbXNoQ+c/qzXWhkipkdBUdewFQ2g8K/6U0yqLCA5Jbvoh45XAZgzAIt5QafzxIlZa150HKD8BeICHacvKpM861PYzQj/Bxp86wdB0uw5/l5XODTLL2wQ+f1nsINWlvuT/WvWNTCHwgjWtCzn59utiIjOPtuXX71iAjx4VmvDY3FFMTyP4Bx8ae/Kbbn4+t4fr7lbLa5ggWF9er81Fmjfvww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 6 Oct
 2020 19:46:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 19:46:21 +0000
Date:   Tue, 6 Oct 2020 16:46:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH] RDMA/bnxt_re: Use rdma_umem_for_each_dma_block()
Message-ID: <20201006194619.GA161168@nvidia.com>
References: <0-v1-b37437a73f35+49c-bnxt_re_dma_block_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-b37437a73f35+49c-bnxt_re_dma_block_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR07CA0027.namprd07.prod.outlook.com (2603:10b6:208:1a0::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38 via Frontend Transport; Tue, 6 Oct 2020 19:46:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPsuh-000fw6-Ju; Tue, 06 Oct 2020 16:46:19 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602013587; bh=X63s8k5wpma8KEvkJBdzGKPvuxgFKtgkFwHnpb8gho0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=HlEzKsK8yq92nhXSkv4k5MMuh3f3pTEb4XLyooPBkJBHWq5xkFJea68eY1XRFOCfG
         WPNKz6hFmdkU0xG0qJBVe1EQc599gPRXIYWAVrKyN/Gqy8hK1TAdPObKKDY1TQMebt
         CwUsrxfb2ewY0D2tBXSQoATkqr7En6KK3M0qRmt6jgqpKhWNm6oiGguYgO2TXWlpuR
         0cdkegq4A00FQfOxYQiWgTinO46BurwpvkuP7SocFny1JanLCy0IIsMaJmz3sEDBSi
         vV1uO99EuQ3BmkjjQQQLWFrpsdSOEcjhHs2/MEoS4MjbTUsHJH/4Fjt45DM6ZEft3K
         nr9eZgSno1z0A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 29, 2020 at 09:24:35PM -0300, Jason Gunthorpe wrote:
> This driver is taking the SGL out of the umem and passing it through a
> struct bnxt_qplib_sg_info. Instead of passing the SGL pass the umem and
> then use rdma_umem_for_each_dma_block() directly.
> 
> Move the calls of ib_umem_num_dma_blocks() closer to their actual point of
> use, npages is only set for non-umem pbl flows.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
> Tested-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c  | 18 +++-----------
>  drivers/infiniband/hw/bnxt_re/qplib_res.c | 30 +++++++++++++----------
>  drivers/infiniband/hw/bnxt_re/qplib_res.h |  3 +--
>  3 files changed, 22 insertions(+), 29 deletions(-)

Applied to for-next, thanks for checking

Jason
