Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEECC2B0AA6
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgKLQqk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 11:46:40 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:48220 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbgKLQqj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 11:46:39 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fad66ee0000>; Fri, 13 Nov 2020 00:46:38 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 12 Nov
 2020 16:46:38 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 12 Nov 2020 16:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz0cyj8bYFOYF85qIEsY+Yh55bLLUpfBmqKf8TJULhFu+Mk6HsPR0DTtPg3oJA+O74qGNgavbJfjcQFMhM5uVabYLot01GpL0BRPeJk5CdmKAYSM54/czElw45cfQ+8yIKZyckD8ekCYmP2YTzLgLSGg3PyR0hwSutEXwpKWmmc0E0h/SN0YnDUTeEFEU1qH8w+6ThefiMUcfM2ANlsD6sCdjmeefZBajv8ojqhpYp7HxRM6phpPzsZBEdcZ34uxo0KZt9lGz1NHmqjCvQB/olZ92SH9cLaojMHYmMGWXFzveqVYJl/scf+yf+ExE7IiHaJc2j2+4AkJLRtk/td5RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sfAr+xkv7/SVXYVYVUFOI4Z9rzMq3BLsPV7CykTexU=;
 b=YshhgmkquBNvs+AICuxnKpu6EV6Qyf09pNa+npeqv2+t0wpeCvS6GThDgWfcp9XahDT/NztGYN1GHczh8WM4RS/IpBa3XuaqU2CS185Y7/MHCeydwUwuemOx6j9xb6YB1tdXDiudlmq+v9hQn+ocnRHWy1uULs8kPOjY13sAGGede5Y8+qCYhVGKn0LslPFO5URp5EgTkVeI58VEQZwSNLFFJacSYsUQB2e5BVJmq3MwVBN+hnJmYI5g9CsP49isdcAasVTd7YFExV88gi8UDlbyElmSX35e5IyZ18WeW//RKNfPLwJd1kzeIt7fGfIuugxRqwt0a821i9NW4Spa6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Thu, 12 Nov
 2020 16:46:23 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3499.032; Thu, 12 Nov 2020
 16:46:23 +0000
Date:   Thu, 12 Nov 2020 12:46:21 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mthca: work around -Wenum-conversion warning
Message-ID: <20201112164621.GA917484@nvidia.com>
References: <20201026211311.3887003-1-arnd@kernel.org>
 <20201112155709.GA894300@nvidia.com>
 <CAK8P3a3Vq4K_pJWCEutvua5GijAL5mgzrCZC-sXWxz4MAOTThg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Vq4K_pJWCEutvua5GijAL5mgzrCZC-sXWxz4MAOTThg@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0180.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::35) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL1PR13CA0180.namprd13.prod.outlook.com (2603:10b6:208:2bd::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend Transport; Thu, 12 Nov 2020 16:46:23 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kdFjp-003qzb-N5; Thu, 12 Nov 2020 12:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605199598; bh=0sfAr+xkv7/SVXYVYVUFOI4Z9rzMq3BLsPV7CykTexU=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=B34V/UAPA3/tPUbhVXNVrRA7bwYta/PSoM8hrJLGXrs2VCJ+wQS3s/KkrHjD4HdIw
         IhKpn8AQeCC1oEzlxHo/IBrUi/osboKCOnD0Yaapbx4V+AC7WHUU9jFNod+uneDdZV
         z0Zc7UkdqH1+AXPE3qVb++XUrC20DLkyoKbLqKfMcrhSaxPdrNnr/ELNVyb+C1s4yO
         rsg2FF/C9UVimXPzvI1pN7qGNnnETSA1K6cHXLvxmAytFigHo+qepD9qZCNLhKwO0/
         hOKqTXhIpSemzVNyteNJz+s9VLQiJgXGkK1PRz3gmrJAySn5Q50PmzTBV9cV4DjsWX
         82T6SzNvQwJIQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 05:45:00PM +0100, Arnd Bergmann wrote:
> On Thu, Nov 12, 2020 at 4:57 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Mon, Oct 26, 2020 at 10:12:30PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > gcc points out a suspicious mixing of enum types in a function that
> > > converts from MTHCA_OPCODE_* values to IB_WC_* values:
> > >
> > > drivers/infiniband/hw/mthca/mthca_cq.c: In function 'mthca_poll_one':
> > > drivers/infiniband/hw/mthca/mthca_cq.c:607:21: warning: implicit conversion from 'enum <anonymous>' to 'enum ib_wc_opcode' [-Wenum-conversion]
> > >   607 |    entry->opcode    = MTHCA_OPCODE_INVALID;
> > >
> > > Nothing seems to ever check for MTHCA_OPCODE_INVALID again, no
> > > idea if this is meaningful, but it seems harmless as it deals
> > > with an invalid input.
> > >
> > > Add a cast to suppress the warning.
> > >
> > > Fixes: 2a4443a69934 ("[PATCH] IB/mthca: fill in opcode field for send completions")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >  drivers/infiniband/hw/mthca/mthca_cq.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
> > > index c3cfea243af8..319b8aa63f36 100644
> > > +++ b/drivers/infiniband/hw/mthca/mthca_cq.c
> > > @@ -604,7 +604,7 @@ static inline int mthca_poll_one(struct mthca_dev *dev,
> > >                       entry->byte_len  = MTHCA_ATOMIC_BYTE_LEN;
> > >                       break;
> > >               default:
> > > -                     entry->opcode    = MTHCA_OPCODE_INVALID;
> > > +                     entry->opcode    = (u8)MTHCA_OPCODE_INVALID;
> > >                       break;
> >
> > This code is completely bogus, sigh
> >
> > Is this OK as far as the warning goes?
> 
> Yes, I'm sure your patch fixes it and it makes more sense than my version.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Okay, I'll revise it, thanks

Jason
