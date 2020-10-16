Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB2290A1B
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 18:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436521AbgJPQ5Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 12:57:25 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:28774 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436511AbgJPQ5Y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Oct 2020 12:57:24 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f89d0f30000>; Sat, 17 Oct 2020 00:57:23 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 16:57:23 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 16:57:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkyugQ1yhgP6qq3Qoo+t93JZK2mHwjKzTCG6c1EdMzOMBZEpMfxAoaI19NCTR4tE1kk9bId07GRjOOEKPMvpT/2v/1mVjU0zjEUk8xzaR2JqIuHJ6yZfv9g+FOitmT7hzEVSI/pH6bqbomNe+FsYSNLe1vFqKTSp8+1GZZg351e4IUBDIuHuh3RRgAIgVUEp4Q/w0rAmbQDGiDGzo6+VhDn81+yUznEYytdceeDBh7Vmyei8Lf+VWMiDUTi14kfO8hQ2WDxcsbVEjtPQoNMnj9O48SnIXjzlAUumlwLnB9g2aO3RnJ9zLKKq8LJ6xiNOB+B22XLiVQQ5s7/hBRLxZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81vxbQdok0qt5mSZmFmNgbJS5iXaI6ochjSSAoxnAB0=;
 b=T3Ss134rLa9acx+g8fvc50o2YjC8oseR7hvR0l5OwLgcS8d7rCZ/GYhZXHv7RGyjQZXcAFuhxJM2z1kB2Sm1LX702feduNhNUS5IvO5ZTFiH+qG5GdD7kwW1yXqozleBDg647OFp+GTDS+pRfyM8KmLHGSk7S16ZGH80QM9d4Fl5xD/GoCp/vdgcApedPo10Z5i7x46Yeg4TrqQHMkLKkUPpQrccA90s46GR4lktOiWOSLGrcix4xQALEuiPDw/SFobqepsFTz+RF8JoGgpcrWq4RkNbpcvEql5C6B2guHZeZdbfxwPuCvf7okV2m8G4ImoRpgmuhN33m/st5h4NsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Fri, 16 Oct
 2020 16:57:21 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 16:57:21 +0000
Date:   Fri, 16 Oct 2020 13:57:18 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Kamal Heib <kamalheib1@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maor Gottlieb <maorg@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v2 23/24] RDMA: add a missing kernel-doc parameter markup
Message-ID: <20201016165718.GA160472@nvidia.com>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <6b2ed339933d066622d5715903870676d8cc523a.1602590106.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6b2ed339933d066622d5715903870676d8cc523a.1602590106.git.mchehab+huawei@kernel.org>
X-ClientProxiedBy: MN2PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:208:237::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0041.namprd15.prod.outlook.com (2603:10b6:208:237::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Fri, 16 Oct 2020 16:57:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTT2c-000flH-R6; Fri, 16 Oct 2020 13:57:18 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602867443; bh=81vxbQdok0qt5mSZmFmNgbJS5iXaI6ochjSSAoxnAB0=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=qTojcscn8ezpz4jqHN5zePNBW7xqerbheI5VgS2LNF4hyWyTqJ/N2k9v/85BDe5F/
         4giEnbjpbZJOJcjmpH+w0uDcyTz7F//BbEfCOD5ffTVQ5t3o18LspH/I5IrCRKIHDb
         vdWmOshBpzXY+YRiZ6fznPm6ErjhDVx3Yk4/XczT2NxR+SkJ/EKXQhuMpv25RAW9Ix
         LC1uKxhKIzpVEmWrVcmkrPIffCGHqd5Pr3N6jLJjTOskAl1wRRySVaVfrtmJwwbRCt
         DXJ6T+71WvGNCS2UQCMBwf6nP7qELNi3uu1PAakBrkJDiIhOV+VM8EK3MDYihGS5p7
         xYYCqmNsfP0Hg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 13, 2020 at 02:14:50PM +0200, Mauro Carvalho Chehab wrote:
> Changeset 54816d3e69d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device")
> added a new parameter to ib_register_device().
> 
> Document it.
> 
> Fixes: 54816d3e69d1 ("RDMA: Explicitly pass in the dma_device to ib_register_device")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/infiniband/core/device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

This is in linux-next, not Linus's tree.

I've fixed it up in the rdma tree

Thanks,
Jason
