Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A82A32F4
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 19:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKBS1S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 13:27:18 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:12607 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBS1S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Nov 2020 13:27:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa04f890000>; Mon, 02 Nov 2020 10:27:21 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 18:27:17 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.55) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 18:27:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/P+MegQ9Is9yPuQM8DpMyEjIo78n/n7oS3xW1pklOFpSLfumQLkEKps84qCVnxl5e7SdPxPDomr2nkbnky1rrc7xaidWLMYF1yYn1VVq194v4+MJpyJktouda5UE0UWv1RFEIQRSHhh4tgKBNO+QcvhdUv58Gii6srNcBgtRvGA7ig4UF0Pe9KtANAhP53bZgJvfsNEMmGAn4tnwWfmIHmLWuHW7nEjkOPLoaTNHOKJgjw2ih4CRIHP3JDxnnql3pJqCHxXM43+9OotoWbCzgCG5EupqUyTNOSc6aZc4lAkCs0ilhuG+eZBmnhbtxkE2Oiemo0Q6ivdrKHwpUZgmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzqmt8H7fLURy/w8sNeo7/r5MackP2m8sKnwxQhO4so=;
 b=k8W4Ml52l6zrK4V1M8PKd2qa7RxYF9IiSGbZUIg0iNZl3Tno3N1fal6PRQfgn3Z3enOTpNlUvP37e5I3njXbdSO+Geoz68Y/8gKwvsgwqzEAwX6TaWiqZUJkcs+8uvF2FbM1lBogFLeptMuq1yWwIQcM5ZacnAJpzkySQNbTGKNiBeC05jbFTBPxlAHd8kIKVee/GlwBIlBB6exoyiXWPT8XSi3tKoO6TN7dxdxqpDeOzTasA0xv+8WY+KFqXIAWkmDbdZlDZ22qYNAySZIeEOpQM+01Ff0h6D5wVrVxySH/kQpr1gO6PMf3TTqfDjyF0YZ1bJvQ3NkER3j//XhHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 18:27:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 18:27:16 +0000
Date:   Mon, 2 Nov 2020 14:27:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>
Subject: Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the active_speed and
 phys_state value
Message-ID: <20201102182714.GI2620339@nvidia.com>
References: <20201028231945.6533-1-aditr@vmware.com>
 <20201029115733.GA2620339@nvidia.com>
 <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
 <38f4a89a-c443-2cb2-a3de-89481a86e192@vmware.com>
 <20201102180256.GG2620339@nvidia.com>
 <f8b16c37-14ef-5663-048c-75def55968b1@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f8b16c37-14ef-5663-048c-75def55968b1@vmware.com>
X-ClientProxiedBy: MN2PR10CA0019.namprd10.prod.outlook.com
 (2603:10b6:208:120::32) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:208:120::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 18:27:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZeXy-00FQop-UO; Mon, 02 Nov 2020 14:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604341641; bh=fzqmt8H7fLURy/w8sNeo7/r5MackP2m8sKnwxQhO4so=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=a13QtC9dme/i9P2GV/h4sJ/gDYodaAw0d2O3hcOulV40rAXRYjp/t5bX6gqKUsrwY
         h8Ya6Y6Nxz9Z+xyVQrW1QUGAz2oxTZFcBXQHJIUnXGNvKEjDS1v++hKy3VXgDgbB/0
         i0qtqoKMAlPOi/zNOQO8QsSGXQnxGw37jQXzPC9km0Lq+3u+4GYyrvmSoFxeDiCeas
         jQSkHX5i4TYj17x8q4L8t3zDTfZdSk/zZk/qVapj8+X1fs61YZkwced7hVsx4HQAZQ
         87+XTpA7DzQGOCCcST2DbWAAdJF7abJaatD28NHzPEOafGvPGGTmi9klPGNuATps18
         cEIleJ4bQOCGA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 10:21:21AM -0800, Adit Ranadive wrote:
> On 11/2/20 10:02 AM, Jason Gunthorpe wrote:
> > On Mon, Nov 02, 2020 at 09:55:25AM -0800, Adit Ranadive wrote:
> >> On 10/29/20 9:16 AM, Adit Ranadive wrote:
> >>> On 10/29/20 4:57 AM, Jason Gunthorpe wrote:
> >>>> On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
> >>>>> The PVRDMA device still reports the active_speed in u8.
> >>>>> Lets use the ib_eth_get_speed to report the speed and
> >>>>> width. Unfortunately, phys_state gets stored as msb of
> >>>>> the new u16 active_speed.
> >>>>
> >>>> This explanation is not clear, I have no idea what this is fixing
> >>>
> >>> It seemed more clear to me in my head, I guess :).
> >>>
> >>> After commit 376ceb31ff87 changed the active_speed attribute to
> >>> u16, both the active_speed and phys_state attributes in the
> >>> pvrdma_port_attr struct are getting stored in this u16. As a 
> >>> result, these show up as invalid values in ibv_devinfo.
> >>>
> >>> Our device still gives us back a u8 active_speed so both these
> >>> are getting stored in the u16. This fix I proposed simply gets 
> >>> the active_speed from the netdev while the phys_state still 
> >>> needs to come from the pvrdma device, i.e. the msb the of the
> >>> u16. I also removed some unused functions as a result.
> >>>
> >>> Alternatively, I could change the u8 active_width and u16 
> >>> active_speed to reserved now that we're getting the active_speed
> >>> and active_width from the ib_get_eth_speed function.
> >>
> >> Jason, did you have any comments on this or did you want me
> >> to just send v1 with an updated description?
> > 
> > I still haven't figured out what this is fixing.
> > 
> > Is 'struct pvrdma_port_attr' some kind of ABI? If so why isn't the fix
> > to revert the type?
> 
> I can revert it but I thought that it had to a u16 based on the IBTA, no?
> Or does that not apply to device-level stuff?

You didn't answer the question, it it ABI to some kind of FW interface
or something?

*HOW* did two fields get overlapped onto a single u16?? The compiler
won't do this..

Jason
