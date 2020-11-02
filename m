Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A202A327B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 19:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgKBSDE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 13:03:04 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:12244 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgKBSDE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 13:03:04 -0500
Received: from HKMAIL103.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa049d60001>; Tue, 03 Nov 2020 02:03:02 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 18:03:02 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 18:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbBzfnOW8HsdcJA3BuCFzXfx4Dj6sYNdqKQeXqTY8qyam/Xyl7Z/Xo9wI5YKjtQQjeRACBSoVj+zVFkFytNYaGFC1PdyKf4OYGxb093Tw2KVN7Tmj0nlZi3HFsLH0N5PiQjwZWbLUYrviHBqnr2QSppVVDX3wAYe/BU09u1xydhlwFu/W5tSe8PCY6lsuAA7Mbwtc9WmNeOH0ZLLXS/9MGwkOYJ2rwp903BQWT1MceNnmiJcUHbdj5Lzy3S6r+5rvLRQuDjWgd/e/dYhrBSHi+iPWvCUn541T9sq4KfvXr+rxAQPa1Rhq7iS89DlapMcQpPHy1zSH643OCrTkBz5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntGjGTPx/Jn8SN8ISW648QshLbO+MpbqCbQ37vE5P5Y=;
 b=QS2n0XykYrHMOfToP5eutmbqVbHV1CFtMN0ZTCNVfY0eBLl21UXB5JAemEDWqkks7cteBbl0l200zvmMYJGB++DR5RqkkFF6VOhJb9/uJidXxy92wIrV9waEBjvuGVOFuBiauucKKRX6eVBtdZ0tIF1pnTOGXe8lgWfwXA8c8oSQ3pTWClmXw8WjvDBJOfjP9aPZe31jHzmz+YMSm8J/wUcfB2Jw541cttYDRHChE8/Xad+jQfGdjhjqrREu92574qy4WVm0baIFixq8KBEV5bGwPmdObHwQwd322oyQXgYgtl95bIapMYt/rFSW0U+txYbSms1bbKepE3aQHUVKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 18:02:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 18:02:58 +0000
Date:   Mon, 2 Nov 2020 14:02:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>
Subject: Re: Re: Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the active_speed and
 phys_state value
Message-ID: <20201102180256.GG2620339@nvidia.com>
References: <20201028231945.6533-1-aditr@vmware.com>
 <20201029115733.GA2620339@nvidia.com>
 <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
 <38f4a89a-c443-2cb2-a3de-89481a86e192@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38f4a89a-c443-2cb2-a3de-89481a86e192@vmware.com>
X-ClientProxiedBy: BL1PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0145.namprd13.prod.outlook.com (2603:10b6:208:2bb::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Mon, 2 Nov 2020 18:02:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZeAS-00FQ8d-QN; Mon, 02 Nov 2020 14:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604340182; bh=ntGjGTPx/Jn8SN8ISW648QshLbO+MpbqCbQ37vE5P5Y=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=dw4NqbbWS/59or/dkkgtcsw5qNgGoDfSxe+4tfpYZ2Vuq7UE1jbAumYGG8rLmBGcu
         vFVj46bCfNw+MGaI0kOrGaddqcrdg/bUDpFbfpRMat5DakB6QMT4TUJu7WPFCbesbx
         yp7bPgGacB6hmRcT22A0WCvVqFkvCqAH84C2Qq1zVDFYOoR8Ih8pL2XfeYElN+cq52
         NRfEUORzxeRdEPJp5rMj/WqXc1LbnwvlbeZVcov31Ow4ld4+cIv4kSqJKNLf0wCFoz
         B/e2eaNqABl8SKqA32BntneN/0uhR6p+4reNE5KPSk7ICAUXSTWdVU88jdoxzOTCkG
         BqcGaEWAA00uQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 09:55:25AM -0800, Adit Ranadive wrote:
> On 10/29/20 9:16 AM, Adit Ranadive wrote:
> > On 10/29/20 4:57 AM, Jason Gunthorpe wrote:
> >> On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
> >>> The PVRDMA device still reports the active_speed in u8.
> >>> Lets use the ib_eth_get_speed to report the speed and
> >>> width. Unfortunately, phys_state gets stored as msb of
> >>> the new u16 active_speed.
> >>
> >> This explanation is not clear, I have no idea what this is fixing
> > 
> > It seemed more clear to me in my head, I guess :).
> > 
> > After commit 376ceb31ff87 changed the active_speed attribute to
> > u16, both the active_speed and phys_state attributes in the
> > pvrdma_port_attr struct are getting stored in this u16. As a 
> > result, these show up as invalid values in ibv_devinfo.
> > 
> > Our device still gives us back a u8 active_speed so both these
> > are getting stored in the u16. This fix I proposed simply gets 
> > the active_speed from the netdev while the phys_state still 
> > needs to come from the pvrdma device, i.e. the msb the of the
> > u16. I also removed some unused functions as a result.
> > 
> > Alternatively, I could change the u8 active_width and u16 
> > active_speed to reserved now that we're getting the active_speed
> > and active_width from the ib_get_eth_speed function.
> 
> Jason, did you have any comments on this or did you want me
> to just send v1 with an updated description?

I still haven't figured out what this is fixing.

Is 'struct pvrdma_port_attr' some kind of ABI? If so why isn't the fix
to revert the type?

Jason
