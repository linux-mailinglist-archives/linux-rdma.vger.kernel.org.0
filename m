Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F495274684
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 18:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIVQWe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 12:22:34 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3792 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVQWe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Sep 2020 12:22:34 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6a249b0001>; Tue, 22 Sep 2020 09:21:47 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 22 Sep
 2020 16:22:10 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 22 Sep 2020 16:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oj8789WTQqfj6prckorfFLIc7FWIa6YJHqjMF/YEvENVuE+jMSmf7EUVHibRugrUNn4AVNuMvrI4znACjXiCGt1InetwmKxziXGOVKcOV7nHeg/YKZa+6d3/e9X1j+ji635gx4b9EFkqBti604C+7XNQb+1MOgq2BkKS4Cbl3QWsTsXVFum12iAfih5//9HQAwb9b8sd8SMm2wI72FmE5ML1pjG3iu/7LiWNSJpkdwfa/2mW9zQheveIRlruoOkWebVC8Dq/PxSihGDV9cSmByZkdYcj4BP5e4NHN5qXPgsEeOJomAbhuSpK3qOUCtHrtg/k3Za5g+doFUT8bnzovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXGraDeMGHnjemisXxyaxvEAT8gEvKFqeufXN26448E=;
 b=IMx7ZnaVTKkzpiIChq20Vd9SXBMwMzKkapmmuRkBwKXEHtSwKtRELYA6dM/WsRPjDt5vj7Qb7wh5BvLCfXObDqCCV7JO3wo9QJDPzcT8ga4k6tR2CGE907RqxVk/GZ1iAvl8x6WyCVfnQlZRk8/gglmzGJNoKv2oFp6T26czqI2/m8ETqu0WRbIaVz1bUg6/FUMtk56vCcGnzsPYMGnkk4F/bT48/a0ZHvJJxpQmW6y9hEGZk+E2PQ5syLvc9BHmkjJKrwLTJIP/YcrBESRPYfX4JDGA4I0AMbyZ5027+3OhSNu+OAfEenxzWS5McXKZYkD2Kg1lX4SHmyhOaDDANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: zurich.ibm.com; dkim=none (message not signed)
 header.d=none;zurich.ibm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3401.namprd12.prod.outlook.com (2603:10b6:5:39::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Tue, 22 Sep
 2020 16:22:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Tue, 22 Sep 2020
 16:22:08 +0000
Date:   Tue, 22 Sep 2020 13:22:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Gal Pressman <galpress@amazon.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Parav Pandit <parav@nvidia.com>,
        Parvi Kaustubhi <pkaustub@cisco.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <yanjunz@nvidia.com>
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20200922162206.GD3699@nvidia.com>
References: <20200922101429.GF1223944@unreal>
 <20200922082745.2149973-1-leon@kernel.org>
 <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
 <OFE5279622.4F47648E-ON002585EB.004EEBC0-002585EB.004EEBDA@notes.na.collabserv.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <OFE5279622.4F47648E-ON002585EB.004EEBC0-002585EB.004EEBDA@notes.na.collabserv.com>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:208:23b::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:208:23b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Tue, 22 Sep 2020 16:22:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kKl3O-0034xg-JZ; Tue, 22 Sep 2020 13:22:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2a31c42-e8eb-4c96-963c-08d85f13a68e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3401:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34013F803A5CBBB003EDD225C23B0@DM6PR12MB3401.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3LWQS6+L2o+5lZkOBN7ANtlKMwvNtwfTUSdzH1ymKIR3UbwfYa//fwci5vaQR8/aZl1oXimPwAdn190mtTZ3ruugMo2SbSVLZWrYgJWjME15WynL5U4YdOQqEqS+sT3bDW6MiOvbSuFleleco0xSFNhYtq6/fFjT2gD2Mn+87YzssjMpLem5pO8u1CnP9seB105uSnWe5bdBNVE1iLSkv+lzrHde5jtgeDnQH+e4YaNMKqfo9kIvWGNND0ZRvXtSEupl/FXTVUGhJJCf5oIRJfr3dYhSu4veLGQ/BNMBgYi+4vQiDQfjSXOfI3t3CdVaDp6EAWszozPwzjFFe/uTWdcX1cUDZBdYJRw5Ya9HhTo6bQ6xB39cK9bZUt/U05a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(4326008)(478600001)(316002)(1076003)(66946007)(66556008)(66476007)(107886003)(86362001)(8676002)(8936002)(5660300002)(6916009)(2906002)(7416002)(2616005)(36756003)(426003)(26005)(186003)(33656002)(9746002)(9786002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r2r4x+5miD96qiFkTLRAVIhaeoCEmy2wgLtyPdG7MeDgLeWqrfZS9eksmVczmZbANSmvXyAA2oOYFUwIQhJqQ60SdhB4tSTDBElqBAWAgu7kNuyrP3o17mS3ZTYuhvjCQvlyj0ifnlRQ07GXgq8UVdKg6jKLGAUY+Ipix1DcQ4gZVETchx7+HuDWd8fQJOqhYKIa5pDefAXz5uUU2qLkPQQ2GEobLHuXn/wabdZkYVLniyGra1EQdwUFD8PpYA78A4NP3RKUc0ic6/VmCnKSC5jqmhwdKkJrGm4N9ZrMzpDuyP6QkJfVkNmh/xGd4Kv77EUmjlIi3i2llIxnWk/kKSttALfFuo9g9IvWxldLGcVXD0oH7CedQtUcbwtxrW42spkVdF/teIJ7hrJxS3obcFpggHz+7XNzBwcZhT88hIzjhhaKUXE3NRZ/+UrV9EIs5DK2Fb8+H/uvv7eXh0LqS62bhclg02DIzcuqEDyVi+qnuKbKsH+DSLgRs4ik51o7e1Vp6T1Y0gJFxJy+lT+dnQ7ae3lhhWY3OGotKskpqZ0zvzQO4UgpMeKK38UWIgVgKYg8NkCX0dLU3geyOPJM+L886nDJ6QIQ3yDNqmQ4cksbfFlMBpMIImOlqm2YkU0+cXOHlHIAZObV0ZVsZDvQqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a31c42-e8eb-4c96-963c-08d85f13a68e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 16:22:08.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iEDG1p87MNw4g3G6SniMKEiHbxPhl8v3W0FT2YVHR0vkTkqlopdvCkCxSVgdG3Rc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3401
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600791707; bh=cXGraDeMGHnjemisXxyaxvEAT8gEvKFqeufXN26448E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:
         Authentication-Results:Date:From:To:CC:Subject:Message-ID:
         References:Content-Type:Content-Disposition:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-MS-Exchange-Transport-Forked:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=A/Jk7jkkxKWqMPkkyqRi1CgYV/LwrTXaSjmNdkXUmJ3B8ZFwWUCsLdQVuI2d3mh6g
         b8s7XHnRYicv74nCDqQEjXqcfHz1gMP5LY+lDHQSsJGvYbZjdQUaOhZXoFP4DRCGUb
         vhR7nxdexddfBxyDbNJ4e4kj7JEq4JnxXx8T3FRD09DK+k6zGBdU7HNCdj7/aFTQZv
         xEu3A46CA9U2uq4cHL8g5rz8bBzTX/oCzh9lLt9zETEbrAnii3VGVI7kDivVFR+Wdm
         NlUDY5lzbI1MRzXyDW8ZQc0JnU3myiUOwGXu1/W3uEXizrf0IDcVidakrmgPr7PyU+
         /ynBQhtlj4ggQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 22, 2020 at 02:22:01PM +0000, Bernard Metzler wrote:
> ...
> 
> >> >diff --git a/drivers/infiniband/sw/siw/siw_main.c
> >> >b/drivers/infiniband/sw/siw/siw_main.c
> >> >index d862bec84376..0362d57b4db8 100644
> >> >+++ b/drivers/infiniband/sw/siw/siw_main.c
> >> >@@ -69,7 +69,7 @@ static int siw_device_register(struct siw_device
> >> >*sdev, const char *name)
> >> >
> >> > 	sdev->vendor_part_id = dev_id++;
> >> >
> >> >-	rv = ib_register_device(base_dev, name);
> >> >+	rv = ib_register_device(base_dev, name, NULL);
> >> > 	if (rv) {
> >> > 		pr_warn("siw: device registration error %d\n", rv);
> >> > 		return rv;
> >> >@@ -386,6 +386,8 @@ static struct siw_device
> >> >*siw_device_create(struct net_device *netdev)
> >> > 	base_dev->dev.dma_parms = &sdev->dma_parms;
> >> > 	sdev->dma_parms = (struct device_dma_parameters)
> >> > 		{ .max_segment_size = SZ_2G };
> >> >+	dma_coerce_mask_and_coherent(&base_dev->dev,
> >> >+				     dma_get_required_mask(&base_dev->dev));
> >>
> >> Leon, can you please help me to understand this
> >> additional logic? Do we need to setup the DMA device
> >> for (software) RDMA devices which rely on dma_virt_ops
> >> in the end, or better leave it untouched?
> >
> >The logic that driver is responsible to give right DMA device,
> >so yes, you are setting here mask from dma_virt_ops, as RXE did.
> >
> Thanks Leon!
> 
> I wonder how this was working w/o that before!

I wonder if dma_virt_ops ignores the masking.. Still seems best to set
it consistently when using dma_virt_ops.

Jason
