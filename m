Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D313114D2
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Feb 2021 23:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbhBEO3f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 5 Feb 2021 09:29:35 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18698 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhBEO1B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 5 Feb 2021 09:27:01 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d67ac0000>; Fri, 05 Feb 2021 07:43:40 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 15:43:39 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 15:43:22 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 15:43:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLPc14JRGk9osdF8al+KQrI6xvqk184p+bySjZkgaUF/RkrYFWnI6qujcksa8p1ZKZmioqjt3tGEDjVJbPRyjCfoNslAR4LJGEkjvifneX+jrvfJu73Z8ZxnmtmSlPS5+PwEpLrfJ9ATfWWFKxfm2jVmPbMmTRCZj0OTMvymag3kRWCvCx4JtOy5ZQ6MC/PytQgN9dwTtcmvqxS74vzRHuenyrkcmreV5kdE+jw0v6habxFxu5G4ow/dWyAPvRFXEq2jt00yuimElcfhiV7UoTBhC2fYAwQbkpW74skBfR6Mhe/GF/roD7AxyWWhktrLXCBGyxzuNvSaNbGz2P+bWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5nvQcFjkPrpkYsoHOqqaQBVuitGxCjp6YMX41Wo4c4=;
 b=SvFR2h7NJwBbVvDyDetCHgJqpICqhQutiejRlv5BxZ2wfQhQu9ERjBOgwqO5LJv6jd8h3fKVAO7omHpA+wcpvLYr80lhENS7QSmEBcohF6yeMiW55YDmA+lSWPPB0QoSklZIyuwPesx6QAx/WlV0PkJdGMS5o+oaPeukUQ+WkEyAe3OFLV0UqIVpiTNFAGaoxraGoqeTgTWl7KQBW0kCAs5BRZoTHhr+K4FN29YoYcZTE+t5eR3QVtqnlH8b3gaIPZs7IBnFfrL2a4sZrxULXRE1IHvwIxNYlxIJtYd80Afv4hZj6+8RzvMiJUbU5NivZfZrdDrUt8LXIlwuua3wOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2938.namprd12.prod.outlook.com (2603:10b6:5:18a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.27; Fri, 5 Feb
 2021 15:43:20 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 15:43:20 +0000
Date:   Fri, 5 Feb 2021 11:43:19 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        "Christian Koenig" <christian.koenig@amd.com>,
        Jianxin Xiong <jianxin.xiong@intel.com>
Subject: Re: [PATCH v16 0/4] RDMA: Add dma-buf support
Message-ID: <20210205154319.GT4247@nvidia.com>
References: <1608067636-98073-1-git-send-email-jianxin.xiong@intel.com>
 <5e4ac17d-1654-9abc-9a14-bda223d62866@nvidia.com>
 <CADnq5_M2YuOv16E2DG6sCPtL=z5SDDrN+y7iwD_pHVc7Omyrmw@mail.gmail.com>
 <20210204182923.GL4247@nvidia.com>
 <CADnq5_N9QvgAKQMLeutA7oBo5W5XyttvNOMK_siOc6QL+H07jQ@mail.gmail.com>
 <8e731fce-95c1-4ace-d8bc-dc0df7432d22@nvidia.com>
 <YB1mw/uYwueFwUdh@phenom.ffwll.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YB1mw/uYwueFwUdh@phenom.ffwll.local>
X-ClientProxiedBy: MN2PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:208:c0::45) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR05CA0032.namprd05.prod.outlook.com (2603:10b6:208:c0::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Fri, 5 Feb 2021 15:43:20 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l83GR-003stn-60; Fri, 05 Feb 2021 11:43:19 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612539820; bh=o5nvQcFjkPrpkYsoHOqqaQBVuitGxCjp6YMX41Wo4c4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=HTPX+FAfWdlJeqzvHloI7vH2Xllwt9hSqHi/4sWqWnSMyUdDklCHJ1VbLxOjJSDsr
         e/iLDK9lIcWzUasXO8bllcnVbalrPlSxFAMnBsVY5+0f6NBtOEsvFtNp7hnLBRTQO1
         WF3aTB3QRG8TCfpcBaUCianxQU/MfDv6lQuCQHZvvtMNaY2McaRCN65RfaJKwHoD/M
         7sIGCRmAMSZlLx8HD15QMZyu0dKGtOhCKVGLDNly4CAZSX5Z+cVcCCuSBMwaeQgRNa
         D/GsQ1tNnKE403JXSIKBWsBreOaut0QC8uBH3GAz/9OiShQL+ClhshKMWxJSc8Du6p
         NnYpJ9FcNH50w==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Feb 05, 2021 at 04:39:47PM +0100, Daniel Vetter wrote:

> > And again, for slightly older hardware, without pinning to VRAM there is
> > no way to use this solution here for peer-to-peer. So I'm glad to see that
> > so far you're not ruling out the pinning option.
> 
> Since HMM and ZONE_DEVICE came up, I'm kinda tempted to make ZONE_DEVICE
> ZONE_MOVEABLE (at least if you don't have a pinned vram contigent in your
> cgroups) or something like that, so we could benefit from the work to make
> sure pin_user_pages and all these never end up in there?

ZONE_DEVICE should already not be returned from GUP.

I've understood in the hmm casse the idea was a CPU touch of some
ZONE_DEVICE pages would trigger a migration to CPU memory, GUP would
want to follow the same logic, presumably it comes for free with the
fault handler somehow

Jason
