Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF6430772A
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Jan 2021 14:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhA1NcF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Jan 2021 08:32:05 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13860 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhA1NcE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Jan 2021 08:32:04 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6012bcaa0002>; Thu, 28 Jan 2021 05:31:22 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Jan
 2021 13:31:18 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 28 Jan 2021 13:31:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myqEZNzgTgovpu+NiujLbECrIK98xoyiIsD0DHhJ0zs9hrTPz4iH/zNVwi9Twyuahf3iznc+/vcnoErgm3qKTuOIsMTgzC0Tbd2onnXPOJgM7RP9D6S44HxC55ddo1J2RRCgSQYz6AdB1kHm6Kpudw3QZUOiWz4fwFP9gNcZVG4Ck8E5ImepTNOdij2S/YbXbg4Ex4RxNWEemPV8gJXbvfvYDEw/3xiIFLPlVjVxqt7RIbTOScNG7dfG1KP/jBthmUnb4Vxq92MkDprme9vbfpb6T838pVCEVAQWFZ5auFThKD9KZQ9eZUmr9yslrF8VREyfBx35FEnXxBKpc3x77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFhEaq9oN3ebU2LWr10nUYkWgTc4u1CaVMql51/PINg=;
 b=KUA23RQEvQ5kpi4vhmJLEMwXuyMC2qw1iSVsxI+53j2U7baYwvpeQyRdw1u88oKRmr5aTjlFLVJejdVtDpfIurOExsO+w5j6PTaGSbm1zC/zc3BPZ0K9V+lWIgu6XHTxcUV4UCUsHhGxe6+U7cxTDdO5Ky0nPYddhUUHIlOBu9zneykg3qBpvS2xlWef42i18fSUOStBRzyTL7XtP5lDgFQ21j//FY+zT+opiprJZxEnG2Xd44fsM/r8faRkAWszpCga30KKhpw/Kc61uDMUF8NoJojFwueyVKztQXC8nmyG6SCB7EnsSI627XYsCQ+0uWYnuaPxKvH3xlvy3879rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2779.namprd12.prod.outlook.com (2603:10b6:5:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Thu, 28 Jan
 2021 13:31:17 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 13:31:17 +0000
Date:   Thu, 28 Jan 2021 09:31:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tatyana Nikolova <tatyana.e.nikolova@intel.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-core 1/5] rdma-core/i40iw: Remove provider i40iw
Message-ID: <20210128133116.GA4247@nvidia.com>
References: <20210128035704.1781-1-tatyana.e.nikolova@intel.com>
 <20210128035704.1781-2-tatyana.e.nikolova@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210128035704.1781-2-tatyana.e.nikolova@intel.com>
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0276.namprd13.prod.outlook.com (2603:10b6:208:2bc::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.8 via Frontend Transport; Thu, 28 Jan 2021 13:31:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l57OG-00032m-0i; Thu, 28 Jan 2021 09:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611840682; bh=cFhEaq9oN3ebU2LWr10nUYkWgTc4u1CaVMql51/PINg=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=o853NEEUw/GI1gyNAq5/mIXx1U+rBDZ+qydr44HMlETQbFIv4dYgsY/jvDmzcSPuP
         yRkw7o3j/sZZTCjxBRaHXGhP54E06hdH1Ifgf3KCrlLSL8n8owB7m8oafFHwXoV182
         TOJjqoMK+qO5od8lb3pu00NplRRyqukdkD3fp7dGGra+EF8UBEujrfftofC7uVWo2h
         JtSpz2TbxWpYw3Tz8nnhmajU60WeQ1S9hkaM9iceEu4yXAXvEP4XR0uVayF5YsTQd5
         PHbST0bPEQ/Q90+iTDJW+Ve661XtELIf/iUW8dhoPp83UTi0ZeQRyvTSHWgWPj68WS
         gRtJDAlzSYBfQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 27, 2021 at 09:57:00PM -0600, Tatyana Nikolova wrote:
> Remove provider i40iw and set up the environment
> for its replacement - provider irdma which
> supports both X722 and E810 Intel devices.
> 
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
>  CMakeLists.txt                            |    2 +-
>  MAINTAINERS                               |    7 +-
>  debian/control                            |    2 +-
>  debian/copyright                          |    8 +-
>  kernel-headers/CMakeLists.txt             |    4 +-
>  kernel-headers/rdma/i40iw-abi.h           |  107 --
>  kernel-headers/rdma/ib_user_ioctl_verbs.h |    2 +-
>  libibverbs/verbs.h                        |    2 +-
>  providers/i40iw/CMakeLists.txt            |    5 -
>  providers/i40iw/i40e_devids.h             |   72 --
>  providers/i40iw/i40iw-abi.h               |   55 -
>  providers/i40iw/i40iw_d.h                 | 1746 -----------------------------
>  providers/i40iw/i40iw_osdep.h             |  108 --
>  providers/i40iw/i40iw_register.h          | 1030 -----------------
>  providers/i40iw/i40iw_status.h            |  101 --
>  providers/i40iw/i40iw_uk.c                | 1266 ---------------------
>  providers/i40iw/i40iw_umain.c             |  226 ----
>  providers/i40iw/i40iw_umain.h             |  181 ---
>  providers/i40iw/i40iw_user.h              |  456 --------
>  providers/i40iw/i40iw_uverbs.c            |  983 ----------------
>  redhat/rdma-core.spec                     |    6 +-
>  suse/rdma-core.spec                       |    4 +-
>  22 files changed, 19 insertions(+), 6354 deletions(-)
>  delete mode 100644 kernel-headers/rdma/i40iw-abi.h
>  delete mode 100644 providers/i40iw/CMakeLists.txt
>  delete mode 100644 providers/i40iw/i40e_devids.h
>  delete mode 100644 providers/i40iw/i40iw-abi.h
>  delete mode 100644 providers/i40iw/i40iw_d.h
>  delete mode 100644 providers/i40iw/i40iw_osdep.h
>  delete mode 100644 providers/i40iw/i40iw_register.h
>  delete mode 100644 providers/i40iw/i40iw_status.h
>  delete mode 100644 providers/i40iw/i40iw_uk.c
>  delete mode 100644 providers/i40iw/i40iw_umain.c
>  delete mode 100644 providers/i40iw/i40iw_umain.h
>  delete mode 100644 providers/i40iw/i40iw_user.h
>  delete mode 100644 providers/i40iw/i40iw_uverbs.c
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 4113423..780800d 100644
> +++ b/CMakeLists.txt
> @@ -652,7 +652,7 @@ add_subdirectory(providers/cxgb4) # NO SPARSE
>  add_subdirectory(providers/efa)
>  add_subdirectory(providers/efa/man)
>  add_subdirectory(providers/hns)
> -add_subdirectory(providers/i40iw) # NO SPARSE
> +add_subdirectory(providers/irdma)

Just to be clear, a new provider will need to be sparse clean and pass
all the CI checks.

Jason
