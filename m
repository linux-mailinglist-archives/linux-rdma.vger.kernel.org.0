Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F97A290DAB
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Oct 2020 00:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391055AbgJPWZV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 16 Oct 2020 18:25:21 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:20017 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390264AbgJPWZU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 16 Oct 2020 18:25:20 -0400
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f8a1dcf0000>; Sat, 17 Oct 2020 06:25:19 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct
 2020 22:25:19 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 16 Oct 2020 22:25:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuTseBgmLfShrNSUrH+CkcW8ROta8CGYJiCRUsk79fNJBMVSNkVEwH9GI4bteKZ+3NkcHcm2M14GUPYWVHOXzsMT6eDjXHWkmlCEcgsIgc24HxbbzcAwLLo6uZqBGFh4z/uPM6I3WkzPRHz7W9b6uTNyEd8kaA62R6UGaOSWbmMXzfOQmz3TaMRFsc2QlwKOr1H7nbTeVYBxtzCCDpOAQx6VQR63F1m1ozojSsw7D/OzgrJC0+/d09XJOWiMPlHSEkHnBXhl3cOnx0RnIdoPurCJdQd5H++bhiktrkTO/2fFbyPUgHWO+pMulKky+ysgTBbHNYRPZTRKXkfZOIdMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkOPMe7qbr5DdSdctHUM9xcZY8NsaPCuypziT+4tnts=;
 b=CubOT2v/dzkk5p1m0KMMBxKOKii+2/k2/bKi4nOMJvm/ioaNNxMe5M9pOojVT1bQmcqfqJCZ/3ML/BK+PLzWi4It2vCaemDciRT442/UAntYjcN8cqCd2N4psazAO2+EGfq0UjH62Ib45svddzVzwgvRJcZ7OA0JXA4bzO+klLltNiB4qZM+3gxqIs/aFh4r0W1RpVO3BIHI6SBrVW3x+v6Po/462spkGjibcr+K3p+PAdR1OGwhlrWDcYW2rW/06JQJREOPDW+oxg7L063NeA6q8g1VnnP3CbdFYR8CvI+RqD9XYBCNcEkn1stCop8vQNHxrPlp9MVK3ffAbStN3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3210.namprd12.prod.outlook.com (2603:10b6:5:185::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.27; Fri, 16 Oct
 2020 22:25:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3477.020; Fri, 16 Oct 2020
 22:25:16 +0000
Date:   Fri, 16 Oct 2020 19:25:14 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
CC:     <zyjzyj2000@gmail.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearson@hpe.com>
Subject: Re: [PATCH for-next] provider/rxe: Support UD network_type patch
Message-ID: <20201016222514.GU6219@nvidia.com>
References: <20201016212459.23140-1-rpearson@hpe.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201016212459.23140-1-rpearson@hpe.com>
X-ClientProxiedBy: MN2PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:208:160::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:160::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.7 via Frontend Transport; Fri, 16 Oct 2020 22:25:15 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kTY9y-00124f-Km; Fri, 16 Oct 2020 19:25:14 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602887119; bh=MkOPMe7qbr5DdSdctHUM9xcZY8NsaPCuypziT+4tnts=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=iJf3z0sXRDsx5KXppz1rlFYtkQlc8WJwcQfyAqK6bO6+J6BlvCxvV9TPqzlRNZcvs
         x4+UlDpJ7qHJYqdcWulkIHhJSZs4FGDY3c13UQmRHTE+uSAzaehoGgtzXsU3NzNyFN
         +n++wa6GD4XX69imaH5U60hoaseGRlweF0eVNaraby/zMPJE66CrYOEZySCgcEO7mI
         y/gVPxQo3Yr45zf0izqwHh6ZkBJ5CoOB5NgshogIr2+HlMI+NmAHF/BiIphiY/FHMq
         1IClSU4lhR4cXx+w6C37BlotT/OYxDS31ciZxDeAgy+6g7ub0FRvTyBe2ahLeTHFdJ
         kfkN/33GglfGw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 16, 2020 at 04:25:00PM -0500, Bob Pearson wrote:
> The patch referenced below changed the type of the enum to be returned in
> send WQEs to the kernel. This patch makes the corresponding change to the
> rxe provider. Without this change the driver is not functional.

?? The enum values didn't change so it should be functional, right?

> Reference: e0d696d201dd ("RDMA/rxe: Move the definitions for rxe_av.network_type to uAPI")
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>  kernel-headers/rdma/rdma_user_rxe.h | 6 ++++++
>  providers/rxe/rxe.c                 | 2 +-
>  providers/rxe/rxe.h                 | 6 ------
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel-headers/rdma/rdma_user_rxe.h b/kernel-headers/rdma/rdma_user_rxe.h
> index d8f2e0e4..e591d8c1 100644
> +++ b/kernel-headers/rdma/rdma_user_rxe.h
> @@ -39,6 +39,11 @@
>  #include <linux/in.h>
>  #include <linux/in6.h>

Updating kernel-headers/ requires two commits the first is made
automatically by the kernel-headers/update script which keeps
everything in sync

Jason
