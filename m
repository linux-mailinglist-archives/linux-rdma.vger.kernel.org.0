Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C1225AAAB
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Sep 2020 13:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBL7a (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Sep 2020 07:59:30 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:38475 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBL7Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Sep 2020 07:59:24 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4f89180001>; Wed, 02 Sep 2020 19:59:20 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Sep 2020 04:59:20 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 02 Sep 2020 04:59:20 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Sep
 2020 11:59:16 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Sep 2020 11:59:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FX7Ubek2T3bwd4pRZ+xuZswnD/V58TVOD2YN3O/JcIY/j7HTtTuM9J3e/1E4pvSi53dYG2bRua+tDzpneCryMSY436+3mblf9xgY2zcyCx0Pebz4AUAMSh3QLidmRCmPD91qFHHtQblAEGeujsgIXuoJ4H0rflKTAQjxTFM5A28xDrTPr3bCViOXmfd5J1GnDx6uKVsidfycM/Ru8H+I/TTM1lH0XA2hPJwGPUq6Ur+oL0FkrgnbbgFxTtwKlH4FXxKm45an1qTg4r6W9ZTLCIPcPi6NDDLje3331gxCzpVDNyOV/m9pWmp/H7g41Blof9RA1CwBGZh12B7kDUm0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ad9w9htOFt3pYq9cPDDenkEDWM/TQmfMaD89XB8OiUE=;
 b=g6Ani5WPUIgeo2o9ou+yxUWGLvMn6LW6MeLNYfgmY+kc48GMiwjA5+0pOeDaoh0c/Xa1Ny3eL9e2QjWUvHDCElSREuYrWc6sje52Vqmg10prEgY/5E/lDGq5JFn860Mkr3zbrC84MLUjfrKcfnvKS0vh3cmQt/g/fgaeBHqut7oGg12b2lhvNQXSE80ovDkMynGiVENNFNFYxBNy2AN+VvLyVDZJY2tsk7coVZNBvlLiMBkUPfYmqGSrueXVAgc9GnXRQY0TYLZmhLMNw6wvW9XkaAH1hpDegzTSDKO7WavkMZWr0Exm57HFHiKkcWXtYRHuksWljTz0KdTm3/G1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.22; Wed, 2 Sep
 2020 11:59:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 11:59:14 +0000
Date:   Wed, 2 Sep 2020 08:59:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Shiraz Saleem" <shiraz.saleem@intel.com>
Subject: Re: [PATCH 02/14] RDMA/umem: Prevent small pages from being returned
 by ib_umem_find_best_pgsz()
Message-ID: <20200902115912.GQ1152540@nvidia.com>
References: <0-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <2-v1-00f59ce24f1f+19f50-umem_1_jgg@nvidia.com>
 <20200902115119.GH59010@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200902115119.GH59010@unreal>
X-ClientProxiedBy: BL0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:91::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:208:91::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 11:59:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kDRQ0-005cXo-Rt; Wed, 02 Sep 2020 08:59:12 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb9a8ec6-eb27-4ebd-7d4d-08d84f379cb4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44998CD3958A6CCE5DB3FC88C22F0@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/401xblEDA9JqzWkoTDWNhM7hNOWBndYpKlwtAlK0FuszDwmOafY1lOlIgF9TiAnVOLVfdN1A8Ps9FQqc8cBciMGGHxJmEtdmyQ1yAtG4Y5aMJsDyWPMfBXYFj0Fzj9bwV6QOInoCVwvXE5gi/gO/Ekj9WSiwOvCb+LvH9SA9w21jFKrSZVHWzeeHdYd26oXaC2R2FFGmdI41Iczsg7ArpE9De7XEiJeGy/SXcM3sPkSrZENcuGWQ1+LOazP4/7TOwSKgA+i8W9SlfKl80bYVHHJC574rGh8Ca4fBEp5REhSlEOZlHF8amkpekal5ak0aJEEh9KLiOnYkFrbldQbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(66946007)(186003)(6916009)(9746002)(8676002)(9786002)(2906002)(5660300002)(26005)(33656002)(66556008)(66476007)(8936002)(54906003)(4326008)(86362001)(2616005)(426003)(83380400001)(1076003)(316002)(36756003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZwR7247ueh03J9HWi5R/2EuXVEs1/A+YY7P56l9tfgmW29XZQQJYDUn8ErM1WoedjUcFGSzAVTzVMSkbuaPqR+K85ShuPrhjt56L0656rpk/RJsAeSYK/eowNQO2fJiL1fvuz98azBwKTmziV/V8i/Jx4v8FY6SHhRQniaX/NkyhvhPhzsPr2RiAgZnJ1NM+Fx8YYdQ67S0Vv44EA1Z8fbPuUNR6eMwFCCsh7FqaokftGoCmMLGoyjE3cqPBvKin2jO3tvvbtimCQFR9ylCC0o4Uc/LLf2ZCNY4CRJsGAvEnPHM9dXigUqvXdU17+NVU1JYte0DCcOlIG4pA3BhXpjvpn5Rf8ioAgTcdHyRPRyg5Zr0LVTSdX5eozPv8YYD4RguT971GasU8Jpy1P7JniGE5SdZL3q7+snDKf5lZHN6XUM9oOS1YggeBALwKwQoesYZzdMCeYjU5wkd/5KnKhcG9ZVXpt/tEsPjqH5wzpyK8PvSvwsmywlP7r0rdnIf6+2+ujCTWKFCy/tebAvJN4GN7mQQWz6D5egN88+0huij7Y0654VhxcGE0/JXfsbAKYH2KXASP+DmTo0icuqjk2/B1A5H7oHS/Gy8OQL+cXcw7MHy5zcmIv2npwXe4FXWBe54JjdJuZJWSpKHNWjC1PQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9a8ec6-eb27-4ebd-7d4d-08d84f379cb4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 11:59:14.5793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XnmNhCOmM5ITpLE8M0BSxYNIHUusoFOPxqlxS8bN+2eZ5B7lzY536wUHZZ+QYxA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599047960; bh=ad9w9htOFt3pYq9cPDDenkEDWM/TQmfMaD89XB8OiUE=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
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
        b=cSvzR4znpY4EdfaEwAf8uDK0zZDlrXqLrrCVVVwMIppN819aYrbbMxn0jqATKlqqh
         hUzbyoNYiTqUQg4pUO+PvLUdLn3a2QG+FuetPqIu6jTWlRGcJTYsvCMl7quR0q3+RZ
         s/6lZe0zcznU8smiPSmEBuQeYtzztm1NRkTv7PtEDL48Iqd5E7igoABSYbH30wt0Rp
         ufFvIlFE52VuOsesLmq1TffTN/N5Z9MqV+bF9zy0VqIB0AvCww2BqAHady3fzeGWmx
         /8454iERi6UVOF0acXD3atV3Y5+N969R5uFFbhDomjHrfuqtJhpJBuXr+0FKhg2vA8
         C80h5E9oaDC8Q==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 02:51:19PM +0300, Leon Romanovsky wrote:
> On Tue, Sep 01, 2020 at 09:43:30PM -0300, Jason Gunthorpe wrote:
> > rdma_for_each_block() makes assumptions about how the SGL is constructed
> > that don't work if the block size is below the page size used to to build
> > the SGL.
> >
> > The rules for umem SGL construction require that the SG's all be PAGE_SIZE
> > aligned and we don't encode the actual byte offset of the VA range inside
> > the SGL using offset and length. So rdma_for_each_block() has no idea
> > where the actual starting/ending point is to compute the first/last block
> > boundary if the starting address should be within a SGL.
> >
> > Fixing the SGL construction turns out to be really hard, and will be the
> > subject of other patches. For now block smaller pages.
> >
> > Fixes: 4a35339958f1 ("RDMA/umem: Add API to find best driver supported page size in an MR")
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  drivers/infiniband/core/umem.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> > index 120e98403c345d..7b5bc969e55630 100644
> > +++ b/drivers/infiniband/core/umem.c
> > @@ -151,6 +151,12 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
> >  	dma_addr_t mask;
> >  	int i;
> >
> > +	/* rdma_for_each_block() has a bug if the page size is smaller than the
> > +	 * page size used to build the umem. For now prevent smaller page sizes
> > +	 * from being returned.
> > +	 */
> > +	pgsz_bitmap &= GENMASK(BITS_PER_LONG - 1, PAGE_SHIFT);
> > +
> 
> Why do we care about such case? Why can't we leave this check forever?

If HW supports only, say 4k page size, and runs on a 64k page size
architecture it should be able to fragment into the native HW page
size.

The whole point of these APIs is to decouple the system and HW page
sizes.

Jason
