Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94694288D67
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Oct 2020 17:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbgJIPzw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Oct 2020 11:55:52 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:3251 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389135AbgJIPzw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Oct 2020 11:55:52 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8087fb0001>; Fri, 09 Oct 2020 08:55:39 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Oct
 2020 15:55:30 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 9 Oct 2020 15:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZsbxsA5eY2sX/xdWmW275njqti6E101x53u69iW6eBXsVvp+4mk9klpps4N7+TGK5opyZ00Mo3apadnP8WprO2CWOvtaJOZOo5dNJxKYP6aH02SZVkU4kzCXYvOtES276Ieus83tcrH/4nVr8FwuEjedEYF9fGst5WKzhW8IevtthIULsQU+d5trDg6YzEdXj47r3WdoLMjwAtQ+04ZArLtCzCg6s4vkB5STIAmBVVQnK5Z/m4JVqTkNdSdpJyrNcBDoIKgiV7UJHhgTrA8fsqYNXCZKmOVo29YtrdfVtBchBLfZgLRmFOqw2YAiEp72ZzPofzCZCiMCroImzPbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzXQu215Yccmvq9faV+1OzuM4fnF082DBXzk7I6cb64=;
 b=ZMT/AnclJJ9utNXb9vCB/Wf4v2zPqe0ie77gzug49g+NvBlCWpH2+uaQ7PwM/N0kdE9NfRa3b0tEdJPs35ngtqVy46aO0VN6F9LBa1VSy+4TF84Isz6ai1vaGxyPM1m2TCbLviiLfhkk/qWjXSeL5e0owiN/TbISRBnP9H8h4ul29OKro1l9XD8Hgs0nDA+dxEXDq5X2urw46NMiug7aqXs0zRRPCgQsOEaqkZsQ2GE8ZmMJW7xEEQ/Pg+nu3rnPJQiTNLUFLBO2iubIxPp4O1wZqiAnleNzo+HtR+Ua54iQqctHwqX148aYIN3GIql/kq9uGUJMJKZ/BbPPBbK80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 15:55:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3455.026; Fri, 9 Oct 2020
 15:55:28 +0000
Date:   Fri, 9 Oct 2020 12:55:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        "Gal Pressman" <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parav Pandit" <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next v4] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20201009155526.GA540955@nvidia.com>
References: <20201008082752.275846-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201008082752.275846-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR01CA0014.prod.exchangelabs.com (2603:10b6:208:71::27)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR01CA0014.prod.exchangelabs.com (2603:10b6:208:71::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Fri, 9 Oct 2020 15:55:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kQuju-002Gjq-Cq; Fri, 09 Oct 2020 12:55:26 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602258939; bh=yzXQu215Yccmvq9faV+1OzuM4fnF082DBXzk7I6cb64=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=c77HUX7+BiwWZbBofh7er2my9Icjfgt2Pr48XgeIIMGECb48dRikDDrYGwxJAqYDS
         CH5wzUPZ9k1U+eRfA79ztbyFoHR/vyPopH+BNvCB3kauxOJG582imljPswGw43p6zY
         0CbVP9WB+Kpym0/EE+RGrUIdAhAp5DR3kW2nKmTw0eci+v1QXG970k5hvNPIVKZioL
         b7vZf9koSXOg2W8sUFk3BKTWybaRxC3M5GOBZ7YO3V7XbELhrcjnvtcB6dZ21a1ZqI
         TSyYYBagNp7h2C63qxNxJTxQrFON6GJ5OecVJtS2Alan/MZWuN4TTA8SE5SXBN33oP
         srnYgf7YB0gdg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 08, 2020 at 11:27:52AM +0300, Leon Romanovsky wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> The code in setup_dma_device has become rather convoluted, move all of
> this to the drivers. Drives now pass in a DMA capable struct device which
> will be used to setup DMA, or drivers must fully configure the ibdev for
> DMA and pass in NULL.
> 
> Other than setting the masks in rvt all drivers were doing this already
> anyhow.
> 
> mthca, mlx4 and mlx5 were already setting up maximum DMA segment size for
> DMA based on their hardweare limits in:
> __mthca_init_one()
>   dma_set_max_seg_size (1G)
> 
> __mlx4_init_one()
>   dma_set_max_seg_size (1G)
> 
> mlx5_pci_init()
>   set_dma_caps()
>     dma_set_max_seg_size (2G)
> 
> Other non software drivers (except usnic) were extended to UINT_MAX [1, 2]
> instead of 2G as was before.
> 
> [1] https://lore.kernel.org/linux-rdma/20200924114940.GE9475@nvidia.com/
> [2] https://lore.kernel.org/linux-rdma/20200924114940.GE9475@nvidia.com/
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> Changelog:
> v4:
>  * Deleted dma_virt_op assignments and masks in rvt, siw and rxe drivers
> v3: https://lore.kernel.org/linux-rdma/20201007070641.3552647-1-leon@kernel.org
>  * Changed hardcoded max_segment_size to use dma_set_max_seg_size for
>    RXE and SIW.
>  * Protected dma_virt_ops from linkage failure without CONFIG_DMA_OPS.
>  * Removed not needed mask setting in RVT.
> v2: https://lore.kernel.org/linux-rdma/20201006073229.2347811-1-leon@kernel.org
>  * Simplified setup_dma_device() by removing extra if()s over various
>  * WARN_ON().
> v1: https://lore.kernel.org/linux-rdma/20201005110050.1703618-1-leon@kernel.org
>  * Moved dma_set_max_seg_size() to be part of the drivers and increased
>    the limit to UINT_MAX.
> ---
>  drivers/infiniband/core/device.c              | 65 +++++--------------
>  drivers/infiniband/hw/bnxt_re/main.c          |  3 +-
>  drivers/infiniband/hw/cxgb4/provider.c        |  4 +-
>  drivers/infiniband/hw/efa/efa_main.c          |  4 +-
>  drivers/infiniband/hw/hns/hns_roce_main.c     |  3 +-
>  drivers/infiniband/hw/i40iw/i40iw_verbs.c     |  3 +-
>  drivers/infiniband/hw/mlx4/main.c             |  3 +-
>  drivers/infiniband/hw/mlx5/main.c             |  2 +-
>  drivers/infiniband/hw/mthca/mthca_provider.c  |  2 +-
>  drivers/infiniband/hw/ocrdma/ocrdma_main.c    |  4 +-
>  drivers/infiniband/hw/qedr/main.c             |  3 +-
>  drivers/infiniband/hw/usnic/usnic_ib_main.c   |  3 +-
>  .../infiniband/hw/vmw_pvrdma/pvrdma_main.c    |  4 +-
>  drivers/infiniband/sw/rdmavt/vt.c             |  6 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.c         |  9 +--
>  drivers/infiniband/sw/siw/siw_main.c          |  8 +--
>  include/rdma/ib_verbs.h                       |  3 +-
>  17 files changed, 52 insertions(+), 77 deletions(-)

Applied to for-next thanks

Jason
