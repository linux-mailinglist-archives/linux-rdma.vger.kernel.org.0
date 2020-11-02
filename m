Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC672A3341
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Nov 2020 19:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725824AbgKBSqr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 2 Nov 2020 13:46:47 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:10447 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgKBSqq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 2 Nov 2020 13:46:46 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa054140000>; Tue, 03 Nov 2020 02:46:44 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 18:46:44 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 2 Nov 2020 18:46:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUgOIYGTm8fsZ0IfR8RQBu6ClHRZaxHNlXAqsoBhwx/REMf+F/jva7J0pMluZA3JCZGIZb0JP6x4SiSeCrwgDtvKZAlQRRGjiUmMDvz6kby5h2/yE2x93NZodBrfmv3Xxxh3T4LfgpKVaoQdJg2PmYueztoglROOofTyPjAUE9FCnZ6EG4SVt194DGcajwlkpfoOXK6igU/vfyVJt6lNqw0GWWUNCS4h+xHKlHND77FuiiXy7i0t3Stsfb06igp3uq6jliNjUa70bEdXJQhsM4KPIg91D4PevfIFOxD7QkFo4tYtI3wa0r2GGsyK5BquUTB8LVLu3g7F/xD1qTHuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USKQz+ICFIijerugs3ql4vezsLURmX1Q+sjt3jssYwA=;
 b=QrF8ay/vUyuvwOMrqKS/Ugxvf8J/GBlUcxHiEMGDJQMkLN224gSSdAZGjojEoFZ7KfkvqB/9HLDvCxsyKAKm7n+SD/tvNgy4a3etk7kVCRdIK3cgSI+QeekcwlLYgfUVXuey0vCFXqaCKHFYWfjY3vUvgEQyftaMbTHCkepKEHhRvetJXdkRB6HlJ1KWVdIK7YmknDGH1e/mXmDSb52WmPPASptGE7zShxArj5iNU2whgQSffbGqKMEXLeRKCiW0spdZbrJG47wEVfr89XaLHJKNy4nnBcEeRVCii6gvz4e7BhVbL+ZBBnSLFuuHupYGGnTp/6ytyZVh89NNdMNNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Mon, 2 Nov
 2020 18:46:42 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 18:46:42 +0000
Date:   Mon, 2 Nov 2020 14:46:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Adit Ranadive <aditr@vmware.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <pv-drivers@vmware.com>
Subject: Re: [Suspected Spam] Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix the
 active_speed and phys_state value
Message-ID: <20201102184640.GJ2620339@nvidia.com>
References: <20201028231945.6533-1-aditr@vmware.com>
 <20201029115733.GA2620339@nvidia.com>
 <e0a834a1-e5ee-4838-4718-d6ded1e954be@vmware.com>
 <38f4a89a-c443-2cb2-a3de-89481a86e192@vmware.com>
 <20201102180256.GG2620339@nvidia.com>
 <f8b16c37-14ef-5663-048c-75def55968b1@vmware.com>
 <20201102182714.GI2620339@nvidia.com>
 <14c28229-3a5e-88f4-f57a-eddbe7145231@vmware.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <14c28229-3a5e-88f4-f57a-eddbe7145231@vmware.com>
X-ClientProxiedBy: BL0PR02CA0085.namprd02.prod.outlook.com
 (2603:10b6:208:51::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR02CA0085.namprd02.prod.outlook.com (2603:10b6:208:51::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 2 Nov 2020 18:46:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kZeqm-00FSPU-L3; Mon, 02 Nov 2020 14:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604342804; bh=USKQz+ICFIijerugs3ql4vezsLURmX1Q+sjt3jssYwA=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=MLCMk78C7BZUsecSTMpUKfl2Q5Y0F9PCc+xDPGH5cVF1YGI9X7CW+FCaJjzonD2MW
         uyVYJfn4FlZrqrNbNb5DcXVVNFA+kiax5bFHINry6QgZU6RhbFI4HQaz1cxmK6ZS7L
         oM5+vnNuqmG2lG+klhTAYvSTLw3Z0ub5KM3jTegQmK6Gc5JsxWhoZ/SfTJwvgmxSMV
         nKcNMQHtZT/PttL/R+UQm27DZ1vGpQh11ShKnlnxiQQlOP/7256dlFpa5PkReSwhEq
         MXd1Cevw0cY+YppuH+rGuhsc20eHKUFq6AJV8KE1CIaNtMdaOAk89m+gmXtM7XHqAh
         TVvJyZZw5sKdA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 02, 2020 at 10:38:19AM -0800, Adit Ranadive wrote:
> On 11/2/20 10:27 AM, Jason Gunthorpe wrote:
> > On Mon, Nov 02, 2020 at 10:21:21AM -0800, Adit Ranadive wrote:
> >> On 11/2/20 10:02 AM, Jason Gunthorpe wrote:
> >>> On Mon, Nov 02, 2020 at 09:55:25AM -0800, Adit Ranadive wrote:
> >>>> On 10/29/20 9:16 AM, Adit Ranadive wrote:
> >>>>> On 10/29/20 4:57 AM, Jason Gunthorpe wrote:
> >>>>>> On Wed, Oct 28, 2020 at 11:19:45PM +0000, Adit Ranadive wrote:
> >>>>>>> The PVRDMA device still reports the active_speed in u8.
> >>>>>>> Lets use the ib_eth_get_speed to report the speed and
> >>>>>>> width. Unfortunately, phys_state gets stored as msb of
> >>>>>>> the new u16 active_speed.
> >>>>>>
> >>>>>> This explanation is not clear, I have no idea what this is fixing
> >>>>>
> >>>>> It seemed more clear to me in my head, I guess :).
> >>>>>
> >>>>> After commit 376ceb31ff87 changed the active_speed attribute to
> >>>>> u16, both the active_speed and phys_state attributes in the
> >>>>> pvrdma_port_attr struct are getting stored in this u16. As a 
> >>>>> result, these show up as invalid values in ibv_devinfo.
> >>>>>
> >>>>> Our device still gives us back a u8 active_speed so both these
> >>>>> are getting stored in the u16. This fix I proposed simply gets 
> >>>>> the active_speed from the netdev while the phys_state still 
> >>>>> needs to come from the pvrdma device, i.e. the msb the of the
> >>>>> u16. I also removed some unused functions as a result.
> >>>>>
> >>>>> Alternatively, I could change the u8 active_width and u16 
> >>>>> active_speed to reserved now that we're getting the active_speed
> >>>>> and active_width from the ib_get_eth_speed function.
> >>>>
> >>>> Jason, did you have any comments on this or did you want me
> >>>> to just send v1 with an updated description?
> >>>
> >>> I still haven't figured out what this is fixing.
> >>>
> >>> Is 'struct pvrdma_port_attr' some kind of ABI? If so why isn't the fix
> >>> to revert the type?
> >>
> >> I can revert it but I thought that it had to a u16 based on the IBTA, no?
> >> Or does that not apply to device-level stuff?
> > 
> > You didn't answer the question, it it ABI to some kind of FW interface
> > or something?
> > 
> > *HOW* did two fields get overlapped onto a single u16?? The compiler
> > won't do this..
> > 
> 
> It is an ABI to the device for port attributes. The device gives us back
> this structure for query port verb. The response from the device is
> memcopied into this pvrdma_port_attr structure. So both the bytes 
> representing active_speed and phys_state from the device are copied 
> into the single u16 in this structure.

So it is ABI and it shouldn't have been changed, point at the stuff
that made it ABI and revert the structure layout change..

Jason
