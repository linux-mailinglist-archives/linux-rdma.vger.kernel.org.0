Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4F2FC5FC
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 01:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbhATAlf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 19:41:35 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:9426 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729850AbhATAle (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Jan 2021 19:41:34 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60077c150001>; Tue, 19 Jan 2021 16:40:53 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 00:40:51 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 20 Jan 2021 00:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkD98D2g4B5Fh0juZxGAktnjnbZQS5pliyVbntxYCOVhXraYgNLZIZSDLINxNbGYo2pwYVIrI+o6j1qDiiVSaagGkbJ0fqd/1Uqu/oI6i2Y7EvPQJLJ8ASlrIYp8DyOtOFwOziAt7/S7lPNEaiwCXfBhVT+s9oBW95KZKTgyqFdcbA3bJWSz//GRzdejc1dK2cjnwhx0biZG7rh4DtFwvb81vswbW1LJKmHrpjnGsekdDUkr1a3BZlYCM0SXrm28kFYkrOJ6d/L3jRp0XmGpueBFkFqEcovhRFP/KFJxmSNldUCpm4EeSb68yPjmSWAQSs+pr4HYa42IZ4mEd6TVBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpcKyjqLBVUUF0xXDaC2sM/qMgY3677qf4q7YDB8tL4=;
 b=dC+Lnu1huRjY6//go2O9cKt4VPrT7jBxqECqHTTstMeh45ZXBCU9g2/nTCAr3ekdHcf3mGZoJMFEgPU0lmgVydjD9eQ+L1SVGLdQc11NRGYnaY46H6gv7J8ZEWZHqAmWzPcwZHWLYr9WUEdEuZ3DbnrbcmaLxsx2kCtUhgiFOlHrbNR8UXGnk+QWQn9XrP1GaP1bNNxRKPzgcfiqQQluCcL8FroBc48fgBGOXAGK/LjEfzeTpxYz8mbrpVQt/6c/2pop4crSWIGp0ku2dAH5Bm+NT1bc9BfejnDp+eWRRDgM11LewwwZTHsWkgFQ7/mxVJFYRrikVZwfnfqXK/B4EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3932.namprd12.prod.outlook.com (2603:10b6:5:1c1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 00:40:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 00:40:48 +0000
Date:   Tue, 19 Jan 2021 20:40:46 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Doug Ledford <dledford@redhat.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Intel Corporation <e1000-rdma@lists.sourceforge.net>,
        Leon Romanovsky <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH 00/20] Rid W=1 warnings from Infinibad
Message-ID: <20210120004046.GA1022538@nvidia.com>
References: <20210118223929.512175-1-lee.jones@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210118223929.512175-1-lee.jones@linaro.org>
X-ClientProxiedBy: BL1PR13CA0169.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::24) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0169.namprd13.prod.outlook.com (2603:10b6:208:2bd::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.7 via Frontend Transport; Wed, 20 Jan 2021 00:40:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l21YE-004I1W-Kx; Tue, 19 Jan 2021 20:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611103253; bh=EpcKyjqLBVUUF0xXDaC2sM/qMgY3677qf4q7YDB8tL4=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=M2OCEUEUw1hDUtrIj/knE9JLDPTghT/n37iZCYJoFLm6oHa4ihwvWCXqrqTF+PNri
         Zc4R7R5jF/q6QKkMa/NLArDNavXzy9ltdh01dinC3SDrFe6E60nMwvPQa4crcGzcZO
         asV8AW5tbZKl76V6ON07UuTm6sIpvGEkL5Gq2cvPwqK6RuiagJ5/q4x7o0Bb92hVSC
         87BhAjxwpUV0R2qzIMWhijWYllGVMxD3pIdgxJRBhHVptxUgGZbx7HbblwEJ61FAkA
         ay8UVMjeTcK3ixWqtE+5pfmyM3HxGSbBDR6PZUN+KovJk6vTIOJMgPSBrXFVZNcixS
         Z8CofXWquVQSQ==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 18, 2021 at 10:39:09PM +0000, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This is set 1 of either 2 or 3 sets required to fully clean-up.
> 
> Lee Jones (20):
>   RDMA/hw: i40iw_hmc: Fix misspellings of '*idx' args
>   RDMA/core: device: Fix formatting in worthy kernel-doc header and
>     demote another
>   RDMA/hw/i40iw/i40iw_ctrl: Fix a bunch of misspellings and formatting
>     issues
>   RDMA/hw/i40iw/i40iw_cm: Fix a bunch of function documentation issues
>   RDMA/core/cache: Fix some misspellings, missing and superfluous param
>     descriptions
>   RDMA/hw/i40iw/i40iw_hw: Provide description for 'ipv4', remove
>     'user_pri' and fix 'iwcq'
>   RDMA/hw/i40iw/i40iw_main: Rectify some kernel-doc misdemeanours
>   RDMA/core/roce_gid_mgmt: Fix misnaming of 'rdma_roce_rescan_device()'s
>     param 'ib_dev'
>   RDMA/hw/i40iw/i40iw_pble: Provide description for 'dev' and fix
>     formatting issues
>   RDMA/hw/i40iw/i40iw_puda: Fix some misspellings and provide missing
>     descriptions
>   RDMA/core/multicast: Provide description for
>     'ib_init_ah_from_mcmember()'s 'rec' param
>   RDMA/core/sa_query: Demote non-conformant kernel-doc header
>   RDMA/hw/i40iw/i40iw_uk: Clean-up some function documentation headers
>   RDMA/hw/i40iw/i40iw_virtchnl: Fix a bunch of kernel-doc issues
>   RDMA/hw/i40iw/i40iw_utils: Fix some misspellings and missing param
>     descriptions
>   RDMA/core/restrack: Fix kernel-doc formatting issue
>   RDMA/hw/i40iw/i40iw_verbs: Fix worthy function headers and demote some
>     others
>   RDMA/core/counters: Demote non-conformant kernel-doc headers
>   RDMA/core/iwpm_util: Fix some param description misspellings
>   RDMA/core/iwpm_msg: Add proper descriptions for 'skb' param

Looks Ok, applied to for-next, thanks

Jason
