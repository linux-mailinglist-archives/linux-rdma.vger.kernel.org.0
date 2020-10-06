Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A56285169
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Oct 2020 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgJFSNz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Oct 2020 14:13:55 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1510 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgJFSNz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Oct 2020 14:13:55 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7cb3ab0000>; Tue, 06 Oct 2020 11:12:59 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 6 Oct
 2020 18:13:29 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 6 Oct 2020 18:13:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFiydxhkbiGihay0uOLYoFnAZaYD4GCgMNIIEBlzy6gfOVakFvjIM8GT7NzZFSQgjHztgPyEAnGX7S/BnTHyF1goKjoo8I4FO4rCC0hBNvD+V6V4tdNHxy74cUznTADG9+f5y5aDknWuyeL8/drWreWWRN7rYVPZH1S3oWutH35cQaBuA4UR7B6gEsV4fYAaylOXtCgG+3Gp/tJs1U6JgYLSJ+ZShE6x0jKjYZeiO3tuzmQoZNfOKOjo/0GD1BEP4h1gotGbdNXANPHkW5ea1B7s7JqdOQjtlQ7NLbzp+b1gjVA9aBQH3vx7u02pQ3CEAaRJl3eEpoHUEloKdEppTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN9bcjQpMCu5gXWf1XQtUdsDTRckUHk475r4klOBPeM=;
 b=eb5zNeUH+AVKbH/dNJLJSOcHCJi5OikdTUyRPiXamPoxMJvCxQ+aAfeYC8NdKZg+KyOIVtjANX3o6lZwwo5SsD8oMcwWSjrhIqA6uD73YfHIWImn33fSjw+DPN9OIFrWfMopj8sxyfyd0xtBFbASyNc/rhAIhvTGZijvv+eRqpFOVmSdABMeZ1EJl/I+KvfmqGvvBmw9jE7lAg70AR9/4pKLgUny7S53jDn115Zal61fS/uPtYCke9p5w1xoIMCnlms7CmadOQmtNq3DijSfuaPSwXXfAmBq9b8fNNZUYW4xDHAxM5MSC+QynBDyYI4y+3ZQtSRAZSFlI/R34rToTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 6 Oct
 2020 18:13:28 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 18:13:28 +0000
Date:   Tue, 6 Oct 2020 15:13:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
CC:     Adit Ranadive <aditr@vmware.com>, Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Doug Ledford <dledford@redhat.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Weihang Li <liweihang@huawei.com>,
        "Marciniszyn, Mike" <mike.marciniszyn@intel.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Lijun Ou <oulijun@huawei.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Yossi Leybovich <sleybo@amazon.com>,
        "Somnath Kotur" <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH 07/11] RDMA: Check flags during create_cq
Message-ID: <20201006181326.GM4734@nvidia.com>
References: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <7-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
 <dae8db3a1d134141bdd6dbcca5564433@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dae8db3a1d134141bdd6dbcca5564433@intel.com>
X-ClientProxiedBy: MN2PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:208:23b::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0022.namprd11.prod.outlook.com (2603:10b6:208:23b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38 via Frontend Transport; Tue, 6 Oct 2020 18:13:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kPrSo-000ch7-HQ; Tue, 06 Oct 2020 15:13:26 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602007979; bh=mN9bcjQpMCu5gXWf1XQtUdsDTRckUHk475r4klOBPeM=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=YGPy+ReUDn2KMxnIFP4USSgMgMsonqqTIv/CEsoy0YonD9URAHGKJGeGAoePS/34U
         hCPQ69f0vLKmptabNo2iAP2CsBX/l+71USjW2eQVG9IoTBCimWvtr2R/odWrhcZW1w
         nzq+qrdMq0a9Rv8GOv52x/jMoph9FTDAWbrySM/8JT6Pm6xsVEPh8v23LhLAF8/594
         0+iko7PagM1w1py/Odwy4QC5Nwl/dvmnHj0TL4cs8rejKOAKhPMsX0exKZFnkcJ6zw
         k2DavJuQHxe4ztCCbZWui0lljgPXkgvkhe6dSg7MW++aEVMpPCwwCutltR6eg7wbs6
         PIdKZmejyDnBQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 06, 2020 at 06:04:29PM +0000, Saleem, Shiraz wrote:
> > a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> > b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> > index 26a61af2d3977f..4aade66ad2aea8 100644
> > +++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
> > @@ -1107,6 +1107,9 @@ static int i40iw_create_cq(struct ib_cq *ibcq,
> >  	int err_code;
> >  	int entries = attr->cqe;
> > 
> > +	if (attr->flags)
> > +		return -EOPNOTSUPP;
> > +
> 
> I am slightly confused.
> So these flags are set for drivers that support the extended create CQ API?

No, the flags can be set by any user or kernel program creating a
CQ. The driver must ensure it supports all requested flags.

Omitting the flags check was always a mistake because an in-kernel ULP
could attempt to use them - luckily none due today.

Jason
