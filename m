Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C832280B6F
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 01:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgJAXvC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Oct 2020 19:51:02 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:5084 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgJAXvC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Oct 2020 19:51:02 -0400
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f766b640000>; Fri, 02 Oct 2020 07:51:00 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 1 Oct
 2020 23:51:00 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 1 Oct 2020 23:50:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSwDz32SDtjCwvgrZDBrY5HdmecQoxxsNF2H7h62IW1BiZvleGmvELLU4Q8+LlYLFwwaT/RjsjseOlXB/TZ3Uv2eKAIt12hSlSi4Tj2tB3mdBKMtL3d/f+MKie+SxoLNOD1l5C7hJENJKwh1hpzsDabXvpgeNgIRo4wSIYDQar2LWCZNCFpMQ9uDW8ZspJ0pTQYhSMM2zAJekkq1aS18MpWbnAXuPVYDBrfR/OmFkI/RdfFz7LAWrW0HlxhCXABRyjudqaWWoI1NImT8PpUWnOEuL3bT+WAivqYp5B/9vuC/ugtO/IAB7zRXMLek870IVzT0amX5kbDrpJ/lZ4PDEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTXeI9jYiue74uhAdaSk/3Y+whJeaxpqMjFRL9uZp0E=;
 b=DT/QPoB98aOgcwxiZxsfsDbodQeh6/1BiDUAUdPYmBEcmPCO4jvyski0xZwtrhnXxy8/7kge/OVLBzijyKEqV10gHEn98x7BKiMKDYlRIc26Pdxh1wDlocoNsmGz2fqB/Y3uSwccPCjbcD+Nj55F8Psad3PT2mUV5MJVcdowwZ9SF3UeEkfkt2amCLOVqJkyA/77f/JrBIfHQiDGnOui1OIfgDxsfyS94n+EUxpxBkm9EKZyTH52iOJE/+Wlt3ylnBPWtavFg6RKKSL8FLGMJ8jQTPLHHUSbR3mYSxwuzBTX2UlyWzVbEVhu+ki9L3IDCCX/EaFEYnWLgVs/so6ttQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Thu, 1 Oct
 2020 23:50:57 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 23:50:57 +0000
Date:   Thu, 1 Oct 2020 20:50:55 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alok Prasad <palok@marvell.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <mkalderon@marvell.com>
Subject: Re: [PATCH rdma-next] RDMA/qedr: endianness warnings cleanup
Message-ID: <20201001235055.GA1209456@nvidia.com>
References: <20201001100959.19940-1-palok@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201001100959.19940-1-palok@marvell.com>
X-ClientProxiedBy: MN2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:208:a8::26) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:208:a8::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37 via Frontend Transport; Thu, 1 Oct 2020 23:50:56 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kO8Lf-0054dw-Q6; Thu, 01 Oct 2020 20:50:55 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601596260; bh=VTXeI9jYiue74uhAdaSk/3Y+whJeaxpqMjFRL9uZp0E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=FTseTMfzM4JDeQwAYwDxUGH0Y3ERKmPLnjpb+xsp+28TnVCXpXbKoqeHGv0O5No+X
         /pNAsSg4UWBIotf3rKTbdzHuNWmi4bUWGtfn60BEvzN5q1ZHj5bjfgFfpsYkLNzAB5
         /qBegRFAsd10oCj42aEVQcRMapP4tsYp6Go4M59tj3VdICUASuWJtNf6JdF5YGrGxQ
         T4MZf7R2r1VlIBGtVhZuxI9w8hCr5n+ugpll7zMMibleiqzkrJrRlZNCajWtj49UrU
         P/fBRfYpYfbQ/ZdBMmt+zlOw5xM0BM0FgP+TyyhUqnfpQY5u05C3JnlLLXY4u7rCGp
         llcRlUXRkxp5Q==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 01, 2020 at 10:09:59AM +0000, Alok Prasad wrote:
> Making a change to fix following sparse warnings
> reported by kbuild bot.
> 
>  CHECK   drivers/infiniband/hw/qedr/verbs.c
> 
> drivers/infiniband/hw/qedr/verbs.c:3872:59: warning: incorrect type in assignment (different base types)
> drivers/infiniband/hw/qedr/verbs.c:3872:59:    expected restricted __le32 [usertype] sge_prod
> drivers/infiniband/hw/qedr/verbs.c:3872:59:    got unsigned int [usertype] sge_prod
> drivers/infiniband/hw/qedr/verbs.c:3875:59: warning: incorrect type in assignment (different base types)
> drivers/infiniband/hw/qedr/verbs.c:3875:59:    expected restricted __le32 [usertype] wqe_prod
> drivers/infiniband/hw/qedr/verbs.c:3875:59:    got unsigned int [usertype] wqe_prod
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: acca72e2b031 ("RDMA/qedr: SRQ's bug fixes")
> Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Michal Kalderon <mkalderon@marvell.com>
> Signed-off-by: Alok Prasad <palok@marvell.com>
> ---
>  drivers/infiniband/hw/qedr/verbs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next

Thanks,
Jason
