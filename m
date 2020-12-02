Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E52CB1D7
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Dec 2020 01:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgLBAzb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Dec 2020 19:55:31 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:30690 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbgLBAza (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Dec 2020 19:55:30 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc6e5d80001>; Wed, 02 Dec 2020 08:54:48 +0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec
 2020 00:54:48 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 2 Dec 2020 00:54:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUSB6NwV4HDSRI1OFn/x8e92IJm7HB18HakDrAaV2L1iRC2tB0ZixMeS9xVZ5YIRdKrcSVTWevghHJkWQT37v75bywYRGDywyyuGa/PtA4t+oWWLZBJPrEtKrTs+i1szXV3c23NP5E1lB/Pg9SzixSd02aPqzEUYZZkmUTGNzuFPygahRzAsHHA53PChzJzBj0dkgxHL7c2a/WoR9pWFlZ4ioQND77CwI8/1rL4qfWhXSxViZYUn+GE7eG0GRSuIgZJ6R3gY7qk5g0DU7Z+LI5fYgqG3QKy1w6wVJjs4ukuBeAWWLGd7Bt9/sBE0fyzHDirx5YNr0+9fFokT0j2ILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+UYHahRA5p6DLXIzobmfNa6XgudwYSIT6ZaZo+3RXE=;
 b=no2d7kVa7VOmVPB6m+QIwIoNoQ/OICmBRg+Gd2CsRekAs9nZ03jElNhX9qkzAEF+4vVyAuevBuGgnE5qY14q9zDmqgjQixhiGSXb4RZbpLPVrJZJ5vV9GtQ5Y3eOWOPedFpJh+qqzLGLSbHk/nK+WUQXMy+KJyexJNrf8sMF8+HYQ0BTw8XzUnTT8XZPOJmcAyem466P9sZgEwRR6DRgSx87Brpmhy6ctYkDDujMPylph9WuY/nUJV2grsYtBD5YKxyAk5uH73LSjnJ29Rnkxg8qGrFQ4dQ1Q1MXuuFd7Z96oneLlMrg5JdJIbsA1e2og/s23FbEggm9IQtrkpL6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 2 Dec
 2020 00:54:45 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1ce9:3434:90fe:3433%3]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 00:54:45 +0000
Date:   Tue, 1 Dec 2020 20:54:42 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Firas JahJah <firasj@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-rc] RDMA/efa: Use the correct current and new states
 in modify QP
Message-ID: <20201202005442.GB1142498@nvidia.com>
References: <20201201091724.37016-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201201091724.37016-1-galpress@amazon.com>
X-ClientProxiedBy: BL0PR1501CA0013.namprd15.prod.outlook.com
 (2603:10b6:207:17::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR1501CA0013.namprd15.prod.outlook.com (2603:10b6:207:17::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 00:54:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kkGPq-004nEd-Ey; Tue, 01 Dec 2020 20:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606870488; bh=W+UYHahRA5p6DLXIzobmfNa6XgudwYSIT6ZaZo+3RXE=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=Pe6TRhmoHpB8+YC9wcp5CNMXu/ob9vpIQlf2nOkBhDtkBNT1yEcXGqANjiyYEwkjZ
         LxXJ/jo/3yalRZe5g7AnqxblS0a4U+pCBVDuv5+X3uhD63JWtBJ+A0iRI4vuVd55ou
         n+icMnt4uzxyQU9yizadqqIx26PPfwoxgGTM+oimrCaWwbwS4XuFe49+UTVchnzKdr
         3KsHjsphoBWQRLrwzuKWAh9GMOXxzzQI2cWDaPgPnjuw8xfw62k/C22OOfzRzfYutH
         TLm0vZIHQIz7lLSWF1aSCBEuhinnleoLuaIHNdL9v6Q6NjWBrGd0ROu2I0TN0JxbpW
         MvjbphBU7r5Kg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 01, 2020 at 11:17:24AM +0200, Gal Pressman wrote:
> The local variables cur_state and new_state hold the state that should
> be used for the modify QP operation instead of the ones in the
> ib_qp_attr struct.
> 
> Fixes: 40909f664d27 ("RDMA/efa: Add EFA verbs implementation")
> Reviewed-by: Firas JahJah <firasj@amazon.com>
> Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
> Signed-off-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/hw/efa/efa_verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
