Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC53251934
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Aug 2020 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHYNIC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Aug 2020 09:08:02 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2462 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgHYNIA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Aug 2020 09:08:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f450d210000>; Tue, 25 Aug 2020 06:07:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Aug 2020 06:07:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Aug 2020 06:07:59 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Aug
 2020 13:07:41 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 25 Aug 2020 13:07:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsLEtLbd2vFExSBJCdeY3VY9JHGSubmZ5YOC0PeFK3L0H7zAEdwb8smBoll3ou523vvgCG8JFEYSH+SoXBe0EyIkv+1EeY2yMPHH5pLhoR+Og475QxjEzQhZRPi1FJbNbdydsjOeTSUpKCIJ9UT8PLlycBy/5hz45jL88tlex7rjQQFuNjokv4SrFYYWuTZQWAwembYjIoj6ZwmszURlrXOUr1DX9Q5ncMfOsMKxP1sUTBlNSLYSCGptzWzy7ihTGbnHtitqn8IiTO1JQgfWnhSwa0kdO+eDKhU+LghCh0V+Iohw2wcvi8ZZFPNs5AHLsSIvLqCTPxkBx9VV2hjYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Q1RM4O4sqpJk1R3AUUrtPbQzQBzZRjd1JT1+15NKDw=;
 b=RiPe1bR1pYqHcG7XkAEqC4I8h6s1aRM0iEl+p8VxoZgpgP5aLfNySV6wXOOykYC4Tg3Spe/0/IM9x9Cj4tfhWvv4412qh3kCJ9YpVsLGp5WJw9A6YORZ9+ins5hL86b0ImmNoQcbIQ03G1Cy+o07hwxPKy4HGtVtxTcge2zlc79Nyk3fuIW7pQkneARK3MvHIrS6+ROrpwwivSxhRmIZL6DODwzdZKlAc/YnFW0OvPVQHkG9tWYPRN/aBWh1yNyCRwr2gsPZVi0qaeto+X/cIaBFgqNAybNZDfWxxxatp4Wu//UUsh85j9zYTaG9qpymOL64pyKXRVdcsg8s9rKE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1754.namprd12.prod.outlook.com (2603:10b6:3:10f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Tue, 25 Aug
 2020 13:07:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Tue, 25 Aug 2020
 13:07:38 +0000
Date:   Tue, 25 Aug 2020 10:07:36 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Lijun Ou <oulijun@huawei.com>, <linux-rdma@vger.kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        "Parvi Kaustubhi" <pkaustub@cisco.com>,
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
Subject: Re: [PATCH rdma-next 01/10] RDMA: Restore ability to fail on PD
 deallocate
Message-ID: <20200825130736.GQ1152540@nvidia.com>
References: <20200824103247.1088464-1-leon@kernel.org>
 <20200824103247.1088464-2-leon@kernel.org>
 <10111f1b-ea06-dce5-a8be-d18e70962547@amazon.com>
 <20200825115246.GP1152540@nvidia.com>
 <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <110cc351-f8f1-8f88-3912-c4dae711b393@amazon.com>
X-ClientProxiedBy: MN2PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:208:237::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 13:07:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAYfo-00EXof-S2; Tue, 25 Aug 2020 10:07:36 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9836fa4-8fe3-4086-cd77-08d848f7d762
X-MS-TrafficTypeDiagnostic: DM5PR12MB1754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB17546B1AD23266D6DD77B688C2570@DM5PR12MB1754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQiAOVhzGY2yU2CJpTP0I+wsec4yLTyJv8ajA6WtTKDbZJkLStvqIL0rqSEaMgrzgnnQ6cbJ/XFh9C2Lis4Fd4KXRgS+eC0ysHglcxAspkk9f9qDB/Q2bUYRMxTWyUHgXglu+aOmquj+zPKCwTU4n7dqkklWH3qOzHTbqbdo46CPb1IwWah7AQELvUDXdLC7qfMEXdl7XP6re8UJ7kUiJj25ui2/1GRA7m+nSgYNPh1pkt/JsQ5Ilfo78XrLh11xCHKg1wLZ4YqlkyreStnRmfgE428TCDA7AC/HUNQDX/p9vJhzKGwMKqWLKaIbCTWxV9K2fCXGoX0Fsi+wv7DVHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(2906002)(2616005)(53546011)(1076003)(478600001)(33656002)(186003)(83380400001)(26005)(9786002)(66556008)(9746002)(316002)(8676002)(6916009)(5660300002)(66946007)(8936002)(66476007)(107886003)(4326008)(86362001)(54906003)(426003)(7416002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ahJTxgyx1wwTIqmDwFVJAm682C32bVxvNUpUu4gzHi6n64Jy7/WtXajcPjxG7ngULooMACZeLSG6iP91A0EUmAKmvNwucGj5ottSBj+uENSkT+kkZd89+2zv4R9YlkkFaUMOgOgh4TmQCq4JgZRgYjqLE9kp3GzUZ1jpQVxiqT0V0RVRr2sWMspFVbk0za5Jjph1w9n7NRewJHnkETGc8WkWsYaBy/uDpSjXGZKzRFYDzSJ1uLxx78IRQO4/SnRFOQ9/wV1OUPlR2vuRycPrBZQNU7j1PEdYbk/LLeh6l9DDRimTZ1VFI8L01vnjBB/GcjJbjS0T5WbkSZmOoaEgngcxJ7kTjafB/5XSNo6XXyPiuVeRL1P7/DVOyQXAbw8wD0uHNgtxO4BWP6lngXjFlRp5akaJizojes68JD7aEdAe3dhvDXMWsSKOD/CgyL9g2J5dWNhOz2K4LWkteev8vjdRN0Rzeuw8cWVQng0ioCZElZyckusJla1fbSpzXsQG44codUQxMYSOmsuswoN5HlamJGAVv/rjpPae8hZ0veKLEtwL3UC2WRbyOfEt8UCy4pocVa39RTQS8/UPhSeKySMvzfnmF+kUvnmiTg03xleqMNVwIxlOO9V5jYolENlbwScDMdcJPQk7ANqhqTOFAA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a9836fa4-8fe3-4086-cd77-08d848f7d762
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 13:07:38.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pnAMZ9YTwRFSO3uEZjon+r6JM173/hkGgohwLKJP6SFcNSFG8eMG1D3f8DIYHoej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1754
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598360865; bh=8Q1RM4O4sqpJk1R3AUUrtPbQzQBzZRjd1JT1+15NKDw=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=ATB8P63lqbiSsSvKpNJ26KtsalySnR2tyFOqQCeM+Q5yWqSlRqWEpZI1OAqlStS00
         Ub8sEwKTuNvGXJ9yKUpbT3+8s/0J/G9CIBKuVbbrb9qfXY5DXPlcPbBvhat3+LddLr
         C9/I6Hyx4Oz6XxugjrcarF/ye/fHBqiFUg4e858Fxlwawk4cHvHe73N+CcPaGRQR5t
         1ryJWY8An+yA2LinwJBnNT+ksYybtjinG5ODTPQAsspowemAqS5rTxx8/x1+yYCaFk
         vFwBEAf9mMqFKEmZS/tvHAJftm3kNwRyANAtMtsJ4Uz9TuCHJc60stEpHKHGC1fiRY
         HXpMaQk/TtS7A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 03:12:07PM +0300, Gal Pressman wrote:
> On 25/08/2020 14:52, Jason Gunthorpe wrote:
> > On Tue, Aug 25, 2020 at 11:13:25AM +0300, Gal Pressman wrote:
> >> On 24/08/2020 13:32, Leon Romanovsky wrote:
> >>> diff --git a/drivers/infiniband/hw/efa/efa.h b/drivers/infiniband/hw/efa/efa.h
> >>> index 1889dd172a25..8547f9d543df 100644
> >>> +++ b/drivers/infiniband/hw/efa/efa.h
> >>> @@ -134,7 +134,7 @@ int efa_query_gid(struct ib_device *ibdev, u8 port, int index,
> >>>  int efa_query_pkey(struct ib_device *ibdev, u8 port, u16 index,
> >>>  		   u16 *pkey);
> >>>  int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> >>> -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> >>> +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata);
> >>>  int efa_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata);
> >>>  struct ib_qp *efa_create_qp(struct ib_pd *ibpd,
> >>>  			    struct ib_qp_init_attr *init_attr,
> >>> diff --git a/drivers/infiniband/hw/efa/efa_verbs.c b/drivers/infiniband/hw/efa/efa_verbs.c
> >>> index 3f7f19b9f463..660a69943e02 100644
> >>> +++ b/drivers/infiniband/hw/efa/efa_verbs.c
> >>> @@ -383,13 +383,14 @@ int efa_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >>>  	return err;
> >>>  }
> >>>
> >>> -void efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >>> +int efa_dealloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
> >>>  {
> >>>  	struct efa_dev *dev = to_edev(ibpd->device);
> >>>  	struct efa_pd *pd = to_epd(ibpd);
> >>>
> >>>  	ibdev_dbg(&dev->ibdev, "Dealloc pd[%d]\n", pd->pdn);
> >>>  	efa_pd_dealloc(dev, pd->pdn);
> >>> +	return 0;
> >>>  }
> >>
> >> Nice change, thanks Leon.
> >> At least for EFA, I prefer to return the return value of the destroy command
> >> instead of silently ignoring it (same for the other patches).
> > 
> > Drivers can't fail the destroy unless a future destroy will succeed.
> > it breaks everything to do that.
> 
> What does it break?

For uverbs it will go into an infinite loop in
uverbs_destroy_ufile_hw() if destroy doesn't eventually succeed.

For kernel it will trigger WARN_ON's and then a permanent memory leak.

> I agree that drivers shouldn't fail destroy commands, but you know.. bugs/errors
> happen (especially when dealing with hardware), and we have a way to propagate
> them, why do it for only some of the drivers?

There is no way to propogate them.

All destroy must eventually succeed.

> > If the chip fails a destroy when it should not then it has failed and
> > should be disabled at PCI and reset, continuing to free anyhow.
> 
> How do we reset the device when there are active apps using it?

The zap stuff revokes the BAR mmaping, it triggerst device fatal to
userspace and that is mostly it for userspace..

It is more complicated for kernel users

Jason
