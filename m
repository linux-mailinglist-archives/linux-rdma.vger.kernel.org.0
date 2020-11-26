Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CF2C4BFE
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Nov 2020 01:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgKZAYy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 19:24:54 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:38243 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbgKZAYx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Nov 2020 19:24:53 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbef5d30000>; Thu, 26 Nov 2020 08:24:51 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 00:24:50 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 26 Nov 2020 00:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkqYdsARjPlMtc+kCVdhWJietu2Tzyd3a1owGTvTcXhPhq8l7t9QUo3PBb80KT4QEH1sY17tZ69pxpvZdS9JjCnfdxGnTck/kyXIZpTFWFLq1pW2E9HX70coqwCBjlJykh67h3YdV87p6dGRGCu72u0DjEBMnguMiwUQu50jucsKiodZJmNA4/wTxrZxSnOJyrxj6ZjtO2+eoSBmOApwJZz7ZPWgPp1Zp2k7wpVYN10uDFjjY0UxPxOiZKqZjYywGuy5sLnsn1VX86xXKnqAfGUasS5+HCbO90eIHXcjtHzcMPg85O2+0ZMIXJGTQIvojr73zAiAID9XuMyRz18f4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ6ALnO5MkK7BJFFpElp9tzekyM622rXfmGqhFcvWFs=;
 b=isBQ85m/kmbSDU4v+elMJm4BqcYXEjuh9pzkpmmHtp29sz3IwKpRiwUkccTjyDtJ+ieVicKq5SxYYp82bzrFy1QEswJITjAPLG3W41f6qghd1lhki53wtIgZ/qU0z8X81oC7MdgRyt3YAQGdiZYeAdhWDtqd0lb8RDhSboCkueXrb5AMmUWoVI+2E90z6pZGKm1s2rmMbivoQPzbXjIIBwT/NaKvZhqdIFu6vPqYdXwESI9Tm/8sPj9UeyNsZgrr5XOhMNNfWFYLlWuLesGPZsRwf53sD/vgfrgnDI7Gp4xnC2GxSAH4zhOZfOa78eaFloj8e+df2y08d9hKa0jWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2741.namprd12.prod.outlook.com (2603:10b6:a03:62::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 26 Nov
 2020 00:24:48 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::7503:d9f2:9040:b0d7]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::7503:d9f2:9040:b0d7%7]) with mapi id 15.20.3589.030; Thu, 26 Nov 2020
 00:24:48 +0000
Date:   Wed, 25 Nov 2020 20:24:44 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     syzbot <syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com>,
        <dledford@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <parav@mellanox.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: possible deadlock in _destroy_id
Message-ID: <20201126002444.GA343793@nvidia.com>
References: <0000000000004129c705b45fa8f2@google.com>
 <20201118133756.GK244516@ziepe.ca> <20201125064832.GB3223@unreal>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201125064832.GB3223@unreal>
X-ClientProxiedBy: MN2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:208:a8::21) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0008.namprd12.prod.outlook.com (2603:10b6:208:a8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Thu, 26 Nov 2020 00:24:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ki55Y-001RSW-3t; Wed, 25 Nov 2020 20:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606350291; bh=EJ6ALnO5MkK7BJFFpElp9tzekyM622rXfmGqhFcvWFs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=FCztdZ/aoBfyNsLRxRd5o36WeSHPYe+UCaRmoCp0b63aDP8D62L2Ql+c7IvzrWCDm
         36kiGX1UVpSSZ1uQcl8H/7C9c2CFsWMw0vEJv+N2Onm5Rwp272MQ8f5SwUe52Te6RJ
         Hkw+pJ8Wi5cKs2EbkMTjl7cfuFAJR9OvIdHZKe01YvSE6+6Bnb1hnOJLQe1bavkucN
         0Ab0saSzmX8/SW2ZNT6sJO/cpdipGBpTmdvVRYRgIL72u89kjbWbwGYFPHxGlR75kZ
         R2Raoa6LvbkmkGWtEiLhKRtHMkK4rLzyOtYSVnGRWj1M2c5TRY7qPWej2Ol1wEFuOG
         RUa6xxJ6NLVJA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 25, 2020 at 08:48:32AM +0200, Leon Romanovsky wrote:
> > commit c80a0c52d85c49a910d0dc0e342e8d8898677dc0
> > Author: Leon Romanovsky <leon@kernel.org>
> > Date:   Wed Nov 4 16:40:07 2020 +0200
> >
> >     RDMA/cma: Add missing error handling of listen_id
> >
> >     Don't silently continue if rdma_listen() fails but destroy previously
> >     created CM_ID and return an error to the caller.
> >
> > rdma_destroy_id() can't be called while holding the global lock
> >
> > This is quite hard to fix. I came up with this ugly thing:
> >
> > From 8e6568f99fbe4bf734cc4e5dcda987e4ae118bdd Mon Sep 17 00:00:00 2001
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Date: Wed, 18 Nov 2020 09:33:23 -0400
> > Subject: [PATCH] RDMA/cma: Fix deadlock on &lock in rdma_cma_listen_on_all()
> >  error unwind
> >
> > rdma_detroy_id() cannot be called under &lock - we must instead keep the
> > error'd ID around until &lock can be released, then destory it.
> >
> > This is complicated by the usual way listen IDs are destroyed through
> > cma_process_remove() which can run at any time and will asynchronously
> > destroy the same ID.
> >
> > Remove the ID from visiblity of cma_process_remove() before going down the
> > destroy path outside the locking.
> >
> > Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
> > Reported-by: syzbot+1bc48bf7f78253f664a9@syzkaller.appspotmail.com
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >  drivers/infiniband/core/cma.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> >
> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

Okay, applied to for-next, thanks

Jason
