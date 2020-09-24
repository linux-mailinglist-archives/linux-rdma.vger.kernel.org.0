Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C184927705D
	for <lists+linux-rdma@lfdr.de>; Thu, 24 Sep 2020 13:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgIXLzt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 24 Sep 2020 07:55:49 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8333 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgIXLzt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 24 Sep 2020 07:55:49 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f6c89370002>; Thu, 24 Sep 2020 04:55:35 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 11:55:22 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 24 Sep 2020 11:55:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYCImhlTpGtDtgcQb9O806baLSQQXOBvV+z7y4sKicn9cIFHkDhgz6h+gnotGVqxTta0xGA/4nljF1r7IQl92gtp1K+KdLVL8QPtSuEfEnpWtFEEHMciPLwJLs61IKroFGY8nTmY7ROs1+R1ctQBMmQp6GeQOX2LN7Kt8JouI5QmZrW4htVXInRuVdoqnqJyx4AeRA8mxbZcH6dmD4mkVkKmtA3ND7h4lqowv8f/zXc0ydZ2quWq2/eUVm0GXFqijMRpQ5IQ+N2l4Dl0oH2wVHheL9Bx5Z6WR0GzOJhJ0yDwSJk+b7RTOVgNrSKbzXlaEoO1mzhSZw6tgYc3BACfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=odyOUe8z0c6nMVkk/Pgjn8/X8U3UaJPLBJg8vbzKflE=;
 b=DWCIgrqQdQxNRWFlS709qzu21kc07YezmKGu3McnhnAfyz4wXfuown9sKa1MfXHzXPgalylm0wU4b89l7lMd1tPXyJ8ImetiYGyjBmmi08CAy0a5SVQC+K/r88wRSp7AVU1yEyD1XPQHc6s9Zum6LX7b32WDom6JBNCSATo+tL1I2h25RL38QKVpU7UkHsz0V63zhaCmYoS4fsBTQdd2quafsTMH/E99bf44sU+AP7ZlTDe94If9/yJgxJB/aLarbR79nQKqFalpmqiC/Xyh+IzyadbrFA6rJc+kDvNNFX2zac4qU3XozQ7tD9KXEKFX1xyTPm10xINlp8cSq96yLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 11:55:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 11:55:21 +0000
Date:   Thu, 24 Sep 2020 08:55:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Bernard Metzler <BMT@zurich.ibm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        "Ariel Elior" <aelior@marvell.com>,
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
Message-ID: <20200924115518.GF9475@nvidia.com>
References: <20200922101429.GF1223944@unreal>
 <20200922082745.2149973-1-leon@kernel.org>
 <OFA7334E75.E0306A27-ON002585EB.003059A0-002585EB.0031440E@notes.na.collabserv.com>
 <OFE5279622.4F47648E-ON002585EB.004EEBC0-002585EB.004EEBDA@notes.na.collabserv.com>
 <20200922162206.GD3699@nvidia.com> <20200923053955.GB4809@infradead.org>
 <20200923183556.GB9475@nvidia.com> <20200924055345.GB22045@infradead.org>
 <20200924061325.GC22045@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200924061325.GC22045@infradead.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: BL0PR0102CA0051.prod.exchangelabs.com
 (2603:10b6:208:25::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by BL0PR0102CA0051.prod.exchangelabs.com (2603:10b6:208:25::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 11:55:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kLPqI-000J0v-Nz; Thu, 24 Sep 2020 08:55:18 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e8c101c-cb63-4fae-b3a1-08d86080b6a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43402FAAC69D18A67FD11045C2390@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYA8ERaJhZY+B1msBIId3xxaymbTf4jKnUC1w9ELeNN0+BADA2IVycw7i7HiN1i7bbNotWVNJxT/H6me3cG1O/XyYjZ4/w6SY31tY4DTWSYZY1juOZYuhsNYL7wI10EDgeNNzj/cuI0XcxX02Gw5XHbaybnBFD3whyx9YXezXJXnpcJF4Gst0Oi3w5B6rLR1/KX3cKxahrifJj0twYsbfkbc/gljRw2Th/oY5G/dMTkSxJ2Wzvh8pVkQocaN3GgmykWXwq/sf+dJUGaNMigTPKfx45+t+2gVy7MYMqHANZo6uJmSG5BqQfRWmC0bUQUOyrW/QNI7BCrSz11FlFyDY+MZm/TUE/qmERRmYut67HEk5GGwy5WW7TnQihFzxF4K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(7416002)(6916009)(4326008)(107886003)(36756003)(26005)(478600001)(54906003)(2616005)(186003)(316002)(83380400001)(5660300002)(33656002)(2906002)(86362001)(8676002)(426003)(9746002)(66946007)(66556008)(1076003)(66476007)(8936002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jYcCwb3tgS4jdHBA7xjbnvMdmOScEjgszUZRe+ceFS3uDBcnumJL/jApVV9vZtFgvJy0Cnq16qWswYiK78NZT1wjrf4lmOAJwJ8YTbQ3jtRUDXHJflA3UV90sgVkX1OmPk4k8SS90uZ7u4oNhsJb+2Zo/Z9QmiHM07BiBRB6MEKp0RqQCB8BWCHPASinIgE9LpSkoZ4zjc59uxaw0ql8hkcPCbU0Sw1sLnby0rRmFM4AB5wCfdYmzKyKYedulkvivvtPNu50x953vNeNwh+JshKRhSpQJ20X7psNSNgl7FSnDpO5kVrxnyHk7SeeU34hxvfPLpdzaSCVFfBT+NfBuaIajpmMN+yF6rzNXpnlyP3sqzFU6iqt5YORxvA/+2Fs4ieOBcRkLPXeXYX+B70VCjwZthX+dQ1pVGUEy0Lu7ep7BrxQNzxbu8JWlF+pU8QO+2m9RC8eerHxXPXf0AxBkud9Y19SJd94YjTCQoSbwArKIl/2QrAAVOzjeZndem9oLIW34QAteBAEVCvm1Cj87SKKvpijyYNPzLs88jRTf8JkAanxhvwkUO6hh2lOPHe1QEX4pyLyAyesJ9uhihLaz/sj2sh4Yi1DTINtU3xKuF55Qpcn4oJu8qy9QWNiVOeHaRDQkN8uKJHP+pkCuGRadQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8c101c-cb63-4fae-b3a1-08d86080b6a4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:55:21.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iby5r3s0TlTxRiFvQtBJi7dUFRxGVRSYzGgOGxsSAB+EkKPLCO9yTGw4eA/tXdcr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600948535; bh=odyOUe8z0c6nMVkk/Pgjn8/X8U3UaJPLBJg8vbzKflE=;
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
        b=dAIvj/JUn0BRR6VX0MyQsepigrFBdgmp2rIroDfIT9toC1wJe4HKvTHDZtzS059B6
         AJA17gBzcRCSoUE82HI3cjOrhgmS/k8kwkWcP5RZeaF1EwJbUAA2GZ7xPAT8oASefq
         wG3SISW++3FNnFl0gkRL8TYCviiTdlkVxDOHwyObuZYq9MNg/vrh/N4MM6R7wpgh/L
         MDtFQG82ZS4d8HtPWinS57QIgzWoXcQR/3qAOX3Qt3ZHTzNXdWfy3XxAFGMo+bFP2o
         ZBDIZjFDKgsSTkBNnVcCLRSt9WYYGhV73j2zy+5KcnikYBDByubhkvNv0FfRxPH+it
         6q20jaOyZkvMA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 24, 2020 at 07:13:25AM +0100, Christoph Hellwig wrote:
> On Thu, Sep 24, 2020 at 06:53:45AM +0100, Christoph Hellwig wrote:
> > Because it isn't DMA, and not we need crappy workarounds like the one
> > in the PCIe P2P code.  It also enforces the same size for dma_addr_t
> > and a pointer, which is not true in various cases.  More importantly
> > it forces a very strange design in the IB APIs (actually it seems the
> > other way around - the weird IB Verbs APIs forced this decision, but
> > it cements it in).  For example most modern Mellanox cards can include
> > immediate data in the command capsule (sorry NVMe terms, I'm pretty
> > sure you guys use something else) that is just copied into the BAR
> > using MMIO.  But the IB API design still forces the ULP to dma map
> > it, which is idiotic.
> 
> FYI, here is the quick patch to kill of dma_virt_ops on top of the
> patch under discussion here.  I think the diffstat alone speaks for
> itself, never mind the fact that we avoid indirect calls for the
> drivers that don't want the DMA mapping.

Yes looks reasonable, I can't recall why things went in the other
direction.

> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bf66b0622b49c8..f2621eaecb7211 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -556,15 +556,6 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  		return -1;
>  
>  	for (i = 0; i < num_clients; i++) {
> -#ifdef CONFIG_DMA_VIRT_OPS
> -		if (clients[i]->dma_ops == &dma_virt_ops) {
> -			if (verbose)
> -				dev_warn(clients[i],
> -					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
> -			return -1;
> -		}
> -#endif

We still need to block p2p for any of the non DMA devices. We can't
pass a p2p sgl into SW devices, they will try to memcpy from the MMIO
__iommem which is not allowed.

Now the check changes to !ib_device->dma_device in the callers

Jason
