Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4B1277045
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 13:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgIXLuO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 07:50:14 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:19053 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgIXLuO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 24 Sep 2020 07:50:14 -0400
Received: from HKMAIL102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6c87f20000>; Thu, 24 Sep 2020 19:50:10 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 11:49:45 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 11:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku+iTMY6+ta5xmPqN2cMm29/ODR7oQ+CSMedqlNGX3mHDsIrkppIYiFbg1JtT37UadQrXGmrx34Avgi1z8W1zP/bIAXtE8YA0Pfe1v1cPiFU7KMICYopDwIcROdCm8pE+CmAgUROp5HJIlvitUVtzvti3Lp33/dLjsA3dGF7GqSizlUwSECBb7JPBL4Jni6oOvDjQPi/+8cGjFSpveU4popN5GblBvRbR3j1/fKwBG7EoJHY3+jVHa6Ildv76+GqAo8fp2PZKEeFzofkaKAENqpD3lNzLfuEUzHACoQJHhiWfK+OBneOzPZzYVTGqp5S/5y0/LziyyYsV1WGt4wpaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbiIKSVRV9lAo+IrlgK8tTEYw9BME9KvoTynMqGg+xM=;
 b=FvVrOAFrvL0/T3mH69vKy2Pz5Dqiz9fKVck2Di6b8aGQaDuieeH+zMEY4NHFvZk0VRQEQhIahVIcARm9H7aGacDR9ImAjaXj1PJowlS2dcodrXHZIAsXqGcWISFUjaqfFbK/v/0LaQ1c+kW+SkmUVD78hnRnXVJGCdYMjSvLFXIAou6X18kPQ/549NJ78sB5QcXqIypHzNo97f3DP0PLUBjWOrVg2a4IWA/4cSEQeervHnyQzsyiTHXXpj7mB2vdh5D2l8GhkwBFKe3TQwtoYGW8sZCS4KutDMndi+Xsod9eXr9s9Begdzt/37OOdSOOSy9DyoJOs1al6bzFzCGTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 11:49:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 11:49:42 +0000
Date:   Thu, 24 Sep 2020 08:49:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>,
        Christian Benvenuti <benve@cisco.com>,
        "Dennis Dalessandro" <dennis.dalessandro@intel.com>,
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
Subject: Re: [PATCH rdma-next] RDMA: Explicitly pass in the dma_device to
 ib_register_device
Message-ID: <20200924114940.GE9475@nvidia.com>
References: <20200922082745.2149973-1-leon@kernel.org>
 <20200923053840.GA4809@infradead.org> <20200923183409.GA9475@nvidia.com>
 <20200924054907.GA22045@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200924054907.GA22045@infradead.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: MN2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:fc::41) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by MN2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:fc::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 11:49:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLPkq-000Iug-4L; Thu, 24 Sep 2020 08:49:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1056a5ef-d0a3-4320-7c0a-08d8607fec6e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43409DA9B13CC246F21F3FACC2390@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+rJ2XVqVXEZOmqak4tgT+DuwVWlK3b1zCev/zEPhNtTn1PMZgPxrOa8SqQXtOmUMdJSTAzDSs5aPwf1kVREecoK2kdWtGNsVIMcspFYD6rkdXkTLpSQmZ9kwPrEB9Ev2MiGh6s4HNx1+t5ZnuK0pjH0+Y0gzvvEXp3CIBg2zfrHA9Imo7ICRaMUhSiWQNynoIt87LLLm2WDn2LaV4A5oznqL9fgNPOdDOGHa1cMl5RetJex0/M+WUX++bTBdxwVattSCIApfQAwIQJYfXcLXaYKdI88BbWDscGskLfED5FVWcQMZQ6Gzg9e7svs3a0MlJQxFVI/GGsOsOO0eBVN8250uMQhbF4qmCqYPXvJK8W5H9/mT6sTUOD/s8VBV2pU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(7416002)(4326008)(107886003)(36756003)(26005)(478600001)(54906003)(2616005)(186003)(110136005)(316002)(83380400001)(5660300002)(33656002)(2906002)(86362001)(8676002)(426003)(9746002)(66946007)(66556008)(1076003)(66476007)(8936002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0pfwaS7jw00COYnKK7kGEGz5QLsSBVkemjfb9yZWG9JphhuN67XC4SoGM438eRc9iXzFc3Kh74t+morpa/gVThRNU4zzPGZztgYOaCuy1Z/GMtsqu2obqyPoVBvHwhCApdlmcXo0jQ/XMD80I8UeV+zhW8yOXSlYfNC7YFfenS3k6XrqRh7rOBPD7cg4bMb2tiMuKM4QrxrQzORnJNwbpYOfJqCG2/mKoEpymS4cTog63eRV8QWmLujIxkvGpbpYaH2QGkuEYXzBgSApJUgUb5QDAfppUduSiUeZ0m9qNy6UXvkpRUmrzQooLFvgdCEv0UCjcRlcvzDT4qXlfu9SU3Ud9lQ77J98qkwscuAGXBBHcMDvXnSdQtDjQmZvgu52KGvoeV4B20YLZRJo2/jIhkYhdUuscOBrsvXOHvf/kci4CK0m0sszs7S6bIclLZbCfuCBzfN+XMMSEivsT+plzVJaRD8ZUO1wbeZHq7d9isxyyAp0bzu84upXwnyTqSopnThlBVd751BBzQSVzAwu0wz1HGHMTeovXFX52Xa052zat7wRB2LKejkqds4k5VD16EaOdung2JroK1MhS5y+M9oIDNqqqGbYnW8I/Ff/K0VBLQVuhfPdx/aFC9hngIQYB0MaiWsE+g/zyzgCRhxSUw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1056a5ef-d0a3-4320-7c0a-08d8607fec6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:49:42.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQgYd2W6bhbZTAUZxpU9xIDWYevghuxqWvE4CY5VMCy1pMuq5oknrmLXKvr1LxJv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600948210; bh=TbiIKSVRV9lAo+IrlgK8tTEYw9BME9KvoTynMqGg+xM=;
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
        b=jNppwx7bTmGiGZm30W307aCVx0gb6d1KnINXR02leFz6JBeuzWyLfo5HTacN3pFJo
         Pd3HjZcSpemkB6SLOdLr151OTVV5QJHUW4Oyl0MTUf3ZeNc4aObVvmdqzhscKphPz5
         cXgs40LDsm55N+L/laTYM1j6jM4pl+3NjVQFSEustppk+yyPYUGgCExlSmsjO7Ao37
         bSWQqTAuyO1n6SVbHPPCMX2dAs3gEonXFAdBTuyj0on2UhRqlNmz5o3fzmvi4WEkQZ
         /jRAw9zV6/8D1QWq/tgcIhA3vGYRqeJItgJ0/aEjolJ104CU3SYYRPL0jG7//NINlv
         OrKlErrtpOX9A==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 24, 2020 at 06:49:07AM +0100, Christoph Hellwig wrote:
> > > > +	} else {
> > > > +		device->dev.dma_parms = dma_device->dma_parms;
> > > >  		/*
> > > > +		 * Auto setup the segment size if a DMA device was passed in.
> > > > +		 * The PCI core sets the maximum segment size to 64 KB. Increase
> > > > +		 * this parameter to 2 GB.
> > > >  		 */
> > > > +		dma_set_max_seg_size(dma_device, SZ_2G);
> > > 
> > > You can't just inherity DMA properties like this this.  Please
> > > fix all code that looks at the seg size to look at the DMA device.
> > 
> > Inherit? This is overriding the PCI default of 64K to be 2G for RDMA
> > devices.
> 
> With inherit I mean the
> 
> 		device->dev.dma_parms = dma_device->dma_parms;
> 
> line, which is completely bogus.  All DMA mapping is done on the
> dma_device in the RDMA core and ULPs, so it also can't have an effect.

Oh. Yes, no idea why that is there..

commit c9121262d57b8a3be4f08073546436ba0128ca6a
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Fri Oct 25 15:58:30 2019 -0700

    RDMA/core: Set DMA parameters correctly
    
    The dma_set_max_seg_size() call in setup_dma_device() does not have any
    effect since device->dev.dma_parms is NULL. Fix this by initializing
    device->dev.dma_parms first.

Bart?

> > The closest thing RDMA has to segment size is the length of a IB
> > scatter/gather WR element in verbs. This is 32 bits by spec.
> > 
> > Even if a SGL > 32 bits was required the ULP should switch to use RDMA
> > MRs instead of inline IB SG.
> > 
> > So really there is no segment size limitation and the intention here
> > is to just disable segment size at IOMMU layer.
> > 
> > Since this is universal, by spec, not HW specific, it doesn't make
> > much sense to put in the drivers.
> 
> What if your DMA device is shared by non-RDMA functionality such
> as a network or storage device which would like an even larger limit?

This limit should be the largest possible, if we can go higher here,
then lets go higher. UINT_MAX?

Hopefully nobody needs lower in the multi-function case

Jason
