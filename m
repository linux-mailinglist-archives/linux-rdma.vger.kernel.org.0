Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915932F7A93
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Jan 2021 13:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbhAOMvU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Jan 2021 07:51:20 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:49459 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732268AbhAOMvT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 15 Jan 2021 07:51:19 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60018f9d0000>; Fri, 15 Jan 2021 20:50:37 +0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 Jan
 2021 12:50:36 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 15 Jan 2021 12:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=en+qSUjyg5ghnUWr0LouCG5Q60gTr2/rw+OuYrf76tQ9KZZiNa/33Fkz4LA15o2jZM4zkQEPIS3lDGkZUZBm0vLPhTCpSCrDFE1B688M1oUnakFxHl4DU2sFm68itQFTv5yID9ivmLYqjHbvI+w4f0c/GQQLhGIOjjf1BlW/U3qThW0wFmZpkNRXLXwaZzILZ3U9zyk/Hd/dK1QaXjarrE2ApvG7taMZY4Ar4q8bwHEAWqKu1KRqW2sLv0wzXM3xGrN7GVneNKMbSNKQyE5Tpz1subCdmJA3Y2kD9wWMjnwpCN/SwoxDUH52zxEF/JQN9FcpvxWitGErOrB3Uw/jTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U24hrGwf3XZksq03FOy/TgpoDVyi8SC2AbqPjZPGmJw=;
 b=cFl51ffgeBo8ZAGb/yyBv3Zji9PyVjcrsY2y+5hm/EurVVMfLJimbmaN/VmYtZ3PM/l+XFJOjK9yF/aitlO1RiwllTG1CswUCNImT4bMN/A5wnapaZFCFG0JUp1KTF2oX3VOtAG46b+c5ffIEo1FeW+138xnDx6QaZH4rSVWYL9+QtqE+SmXYXhZGUDkS5tolbmSiiYpM09x9ZjPuWDDspaHBX+7fVDL/Chb4YD+Gz6WtZWoFZ4wnZGnvsNg4vFDYlL4Fbplyg3EQMiUsIxKPDN+aBwGtStwX7keUo34FSDkJIPom927JkKsYgliIcQBt2I8UjGB6r/+ziFHl8OLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 15 Jan
 2021 12:50:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 12:50:34 +0000
Date:   Fri, 15 Jan 2021 08:50:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bryan Tan <bryantan@vmware.com>
CC:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH for-rc] RDMA/vmw_pvrdma: Fix network_hdr_type reported in
 WC
Message-ID: <20210115125031.GY4147@nvidia.com>
References: <1610634408-31356-1-git-send-email-bryantan@vmware.com>
 <20210114172359.GC316809@nvidia.com>
 <BL0PR05MB501015BAF25CADD722F5A9FCB2A79@BL0PR05MB5010.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BL0PR05MB501015BAF25CADD722F5A9FCB2A79@BL0PR05MB5010.namprd05.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0368.namprd13.prod.outlook.com (2603:10b6:208:2c0::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.6 via Frontend Transport; Fri, 15 Jan 2021 12:50:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l0OYh-001cEq-FQ; Fri, 15 Jan 2021 08:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610715037; bh=U24hrGwf3XZksq03FOy/TgpoDVyi8SC2AbqPjZPGmJw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=BTYeGlqNyF9/4hTw4k8L6kknfPp94xjKmfwrCD+d1oNH6Vz3WE/hdQo3ihhVcIufS
         nGa/cVwcCwwXmnq953nn7C5hLCWczltjwRvL2QGau0I1U6X49HQkMLT9c/FdmFydtm
         4QBf+cCb9OfF8+OLyiBQAMcxjO1u6e1GvgreDMUxsXbfNv/ltuSB75SeX46rYpl5+r
         xy7EasJyE+9b7RuBKuUS7YHbvd7GeG0PKGDjxToNtw67c8FCqqlEUAhNqxDWOkVFUU
         YeWDZb28QhDIIuZnJY4POsAUvWXN7PbRM9m5fx4P11LBwvTWUdyPwcZq5rv0NeDuiT
         KKadtRYjeCt2w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jan 15, 2021 at 04:58:58AM +0000, Bryan Tan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com> 
> > Sent: Friday, January 15, 2021 1:24 AM
> > On Thu, Jan 14, 2021 at 06:26:48AM -0800, Bryan Tan wrote:
> > > The PVRDMA device defines network_hdr_type according to an old
> > > definition of the rdma_network_type enum that has since changed,
> > > resulting in the wrong rdma_network_type being reported. Fix this by
> > > explicitly defining the enum used by the PVRDMA device and adding a
> > > function to convert the pvrdma_network_type to rdma_network_type enum.
> > 
> > How come I can't find anything reading this in rdma-core?
> > 
> > $ ~/oss/rdma-core#git grep network_hdr_type
> > kernel-headers/rdma/vmw_pvrdma-abi.h:  __u8 network_hdr_type;
> > 
> > ??
> 
> network_hdr_type isn't exposed in the userspace WC ibv_wc.

So this is "HW" API then?

> Given that the field is only in the kernel side, it didn't seem like
> we should add the new enum to vmw_pvrdma-abi.h either.

Well, the struct that holds the value is in a uapi header, so the
definition should be too. If you are defining HW data in uapi then may
as well define all of it.

Jason
