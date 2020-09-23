Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4C9275FF4
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Sep 2020 20:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWSes (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Sep 2020 14:34:48 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:10040 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWSeq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Sep 2020 14:34:46 -0400
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6b95430000>; Thu, 24 Sep 2020 02:34:43 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 18:34:19 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 23 Sep 2020 18:34:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mowqNedM7jZwf1T7I3IFvQNdLSvAQsQgk721E+QB9AXofhDsMYskniMR54GfiGbZnpIV4LPKPxsVAYcWDcfZRTBsw96ciPHkcbw6jlCMZifKy6u494sGbL2fA7DEqWWnPp/DvWMYrNlYQbyEn/G3gSvKFY3Diqj8t0+ENH8J1DaEfVfit1CCW1VPSrsENaxkGrkss1owsi60sZtZvLxsIpZkczWzJrdNuSvZajP3vleB65Vraj0+O1CeW9W0uvVjbEndRmM0jU4Gr9E6rL4e2aBESidz+Xnk9CqVigOVbJqM1vM5T3NxSmcvnHhf15QycJsg6ATSRDg2mcTdBWu0SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Mn0xyIlBFeWV1K7ty8godwy+x8+7EIicroz8BXWc/0=;
 b=HcVY7wikRZ+jqbWDOxvgTG0VFY7fwbVNeeXqnRQbksZ5EReCnWbNdcla72t6LSfjLGznHqU2wph9bPjyZSU6R87qeB1f9i6BRXLHE7h5vQUoz2+p0qcZ0Jv0tlzUKB8mU5mmd0Q/adceylnNoXzFmMPjHaICFIA3VzjR0AOHqQq2OFB/mUQRvI0HlNxlElRbaJ66hUDeULqZensb3AQ8rz7j61vB2L6wQmeAeXIAYBO74EHpOvO1tazI3wso6xRjXxB14cjlYPz1ilQpcdG4zODqDkUyBb8G7nH7rT1cY/34GhUQq/Bj1mcweOMAMnM782Cdja5ZfZqTamGN8gGKtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 18:34:10 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 18:34:10 +0000
Date:   Wed, 23 Sep 2020 15:34:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
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
Message-ID: <20200923183409.GA9475@nvidia.com>
References: <20200922082745.2149973-1-leon@kernel.org>
 <20200923053840.GA4809@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200923053840.GA4809@infradead.org>
X-Originating-IP: [156.34.48.30]
X-ClientProxiedBy: MN2PR15CA0048.namprd15.prod.outlook.com
 (2603:10b6:208:237::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 18:34:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kL9aj-0007WX-7p; Wed, 23 Sep 2020 15:34:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eff38d3b-b318-41f6-861d-08d85fef4344
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114F56D959A21F9F36723F5C2380@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYj9+waQwzEr2O/Zui86icggFsE3zpflrkQE0MOOFXGArYvJ8TWDcvBJB6n5kepvn7ew3p/VToYvruucfUD4NYgXKVTuV/Kvzmi4nfk/C7P5cPdbTrnSaa7/m+UrIkgkiUEzZNXKy2KjvqvY99Swb7uaXRfFOBilYnFNXu3NWnPSsNXXccJyeMfObgst2Z4i4TYLyCV649C5cj5Z7qlvKv11nrc0XdKdmxKIBqr1cHjVnpYjpX4i45zECD58Ss4W5Hob4kjZVtj4uFoYSPEjtqpjmERmeGn0g1sv9nxTccJR4TGhOObYLkT3W9Wu3arLa9se6dVUiKOSCpqeFk/ugg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(478600001)(7416002)(83380400001)(33656002)(54906003)(36756003)(86362001)(26005)(8676002)(186003)(9746002)(426003)(2906002)(107886003)(66476007)(4326008)(9786002)(66946007)(2616005)(1076003)(66556008)(5660300002)(6916009)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: QWgBGxUGhC3X5+YL9QHg79/MpPr2+CMMsnrZiptgVhuotGKEHvKwKHKe6lVgTbESbvPT514gC9+J7cKW5y7sx5II8bWuN2EuXuLv3Amvhmv23fmeVmgOLfVjhmMjg/CGF83Rkj62o+OU9pSRNWrjjTVrOBqN+oEeYtpyJe+kwlsty3lnTSMwRuFkP1pm1DRBovkrFe7MxbR9pyjfnnEPj5/q6YF2oaxUVW/lgXieoChIJCELNUjM73C7HPvP5+VCr/jpFWlV9KziOYRvobdsToDzEmfay6MudAGqYEkz3PoceCXKEFzUg3vhzvPTbEPxQMd9R/3rfRwyehR0QRoCtUy1UkwJNZI4xUBpE33MaPfAn6UM44MdJgxgTHzCv1GM8JPp+J3r+wdfjZHWZ6JTL+Cx5sQuUMQwIv2/YzEIOpaPJKNmZrYOcyBEglyY+ALti1dG1eFNDW8OSmmhWoE2TbGf892mHRVdlmhRZKfEcSR1ZNocUt/ZiYAG9bFCNXkv3Qlil14hzlAHhhQVIzsOakZtofyL/2qDNuCrb8dt79KzoCrdIKFlWgEUte8ythRvieLfOFxWbzuDo+YSTi69zi5Rg805X+7nGqb+n0FvtP2MRz/Nhl6TWu6rQVegQ8DYuMBJwgfqL/AfOih4xo6dfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: eff38d3b-b318-41f6-861d-08d85fef4344
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 18:34:10.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLiIaqxIrVeTLookEGvLxABUXUzRiMgTi8Te/Oed7nIbG96/yO/zZj1xjnd7wpWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600886083; bh=1Mn0xyIlBFeWV1K7ty8godwy+x8+7EIicroz8BXWc/0=;
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
        b=qSD08YzvemME/gatlrER0TFgVD+u6fpe4TgJb2NLSg2/+D472Xd9hyyhq0PVmbLrP
         jMtLbGboQBZvefxEnyRI2lkiFX7k/BHZQSzGZ44mOYbmaujwaOwJGBLSgcWmsyIxpW
         aIupApe6BTASGw9tHj7h23667+bETdA5RGX8w6a/e9ml2Q1phdsGYKYbOsrmsBKaHo
         3GbZrz5Jib0lXouuUAr9d7IJqc5iB9quLcyhhz1wpZSo8jkblFCrFY+qpQWqEHT25S
         sdpiHAY6Ul19B1SOZ+0UK46xn1LH4wXTGZqcCpFSstQgzWYUeESCIUWzM8UhLN4DJl
         N8G3dSW5akCZA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 23, 2020 at 06:38:40AM +0100, Christoph Hellwig wrote:
> > +static void setup_dma_device(struct ib_device *device,
> > +			     struct device *dma_device)
> >  {
> > +	if (!dma_device) {
> >  		/*
> > +		 * If the caller does not provide a DMA capable device then the
> > +		 * IB device will be used. In this case the caller should fully
> > +		 * setup the ibdev for DMA. This usually means using
> > +		 * dma_virt_ops.
> >  		 */
> > +#ifdef CONFIG_DMA_OPS
> > +		if (WARN_ON(!device->dev.dma_ops))
> > +			return;
> > +#endif
> 
> dma ops are entirely optiona and NULL for the most common case
> (direct mapping without an IOMMU).

This is the case where:

 +		dma_device = &device->dev;

device == struct ib_device we just allocated

The only use of this configuration is to override the dma ops with
dma_virt_ops, so drivers that don't do that are buggy. A ib_device
itself cannot do DMA otherwise. This should probably be clarified to
just fail if !CONIFG_DMA_OPS

All other cases should point dma_device at some kind of DMA capable
struct device like a pci_device, which can have a NULL ops.

> > +	} else {
> > +		device->dev.dma_parms = dma_device->dma_parms;
> >  		/*
> > +		 * Auto setup the segment size if a DMA device was passed in.
> > +		 * The PCI core sets the maximum segment size to 64 KB. Increase
> > +		 * this parameter to 2 GB.
> >  		 */
> > +		dma_set_max_seg_size(dma_device, SZ_2G);
> 
> You can't just inherity DMA properties like this this.  Please
> fix all code that looks at the seg size to look at the DMA device.

Inherit? This is overriding the PCI default of 64K to be 2G for RDMA
devices.

The closest thing RDMA has to segment size is the length of a IB
scatter/gather WR element in verbs. This is 32 bits by spec.

Even if a SGL > 32 bits was required the ULP should switch to use RDMA
MRs instead of inline IB SG.

So really there is no segment size limitation and the intention here
is to just disable segment size at IOMMU layer.

Since this is universal, by spec, not HW specific, it doesn't make
much sense to put in the drivers.

> Btw, where does the magic 2G come from?

2G is the largest power of two that will fit in a struct
scatterlist->length or the ib_sge->length.

Jason
