Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFE2FAC34
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jan 2021 22:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbhARVGi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jan 2021 16:06:38 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:52516 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390359AbhARVD1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 18 Jan 2021 16:03:27 -0500
Received: from HKMAIL104.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6005f76f0000>; Tue, 19 Jan 2021 05:02:39 +0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 21:02:39 +0000
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 18 Jan 2021 21:02:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2aex2xFFLt6WMKh9If/0/oIYJx0lYMbSYj9nS/STz5Ab8DVNQyKiibLOIUj/CSU2ZxNKgw9fObXRdc/B3LM3tg2nO1EhfgARMAURPtdwyYJKWuLK096lkLwXlusZR5mSnQwQ7atMWc2bKb5wWFrGsubUfyfRLQ0pfLU5ufWBBifPjUmyaQr09OJWgGYnCUUyOj0nIXfMlTa0vyPg0B74RafLp1E1CHIeWcqosIixYsOFgzU5LK6UFFYuFTRrl4YCSJmRGlqBxXmXcMuoGOKr3X65F7J0Zi/7IT86gqqIJlG5vLojOE3hQ3uvBm3ee5B+wErE6R7GhGGn/K1502Dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5jJoggtnCxW01YO8Mb7PWJXK2bvdTeRv+TyfkkqpBI=;
 b=VilGt7+53En9/E6a3zmFPGbm5NUk7XR3B/EGz9ADGH46ZhKyJqX53Gez6zWJeCaaAyo3QJZd0Im9EiqBMX2pvkUEYithdUhyMGIVckY3wH7cDCb7RhEYM12zqJ5Hw+YArvpAXRH7EFgt+lE8lKb+PbL/AQ3m9Z4StavK8kdDk2G4pTJdXHCbM1MWgwhCt5aPD7LqL0IZHUa9O99rB96haddZUIS1hSF0iavLoWZq7+ToSvtgSsfTCzGLRSD76t2mdjR6Xp9qT5CnaQJ3vOY1kJLWyPlebluh3jHdxUynI6x4+pZq3IyOUcpgqAa4mBMYTmy4i/8YWwxcArW9HXugXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Mon, 18 Jan
 2021 21:02:36 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::546d:512c:72fa:4727%7]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 21:02:36 +0000
Date:   Mon, 18 Jan 2021 17:02:34 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <leonro@nvidia.com>, <sagi@grimberg.me>, <oren@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH 1/3] IB/isert: remove unneeded new lines
Message-ID: <20210118210234.GD797553@nvidia.com>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210110111903.486681-1-mgurtovoy@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0110.namprd02.prod.outlook.com
 (2603:10b6:208:35::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0110.namprd02.prod.outlook.com (2603:10b6:208:35::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 21:02:36 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l1bfW-003LWK-Ka; Mon, 18 Jan 2021 17:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1611003759; bh=I5jJoggtnCxW01YO8Mb7PWJXK2bvdTeRv+TyfkkqpBI=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=hmT3VtY9e7cBLCao/Mp7igxw4DKNQIJGu7Ck7TJAj4hhJKTJO63LmwHNpBFxZb3+7
         xc4HX1o0ABkqlDrGPUM84HW7jY+6ViilpVWf5oNyx+FGe+eubieByNZaKcIcWLPjJM
         gRAcgsTNlusTPZu4Gp2mCWQfDpQwNpp03XB31LqVcGSQ32zwqun6dl/qGmnfUFUqwd
         qg0uM71WDkOOB/uCdsIg2fg+5Xix4mb+6yZNUTY1fTqtCNSWVfVZeMCg+IfPHpbi36
         pV2BU8dAellC6yfgSYhclnDGgAVuT/FEbgholxf1WoqcQHY/ryECfcO2fXmBkwb533
         4/+v7SBPDHbdw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jan 10, 2021 at 11:19:01AM +0000, Max Gurtovoy wrote:
> The Linux convention is to have only 1 new line between functions.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 2 --
>  1 file changed, 2 deletions(-)

Series applied to for-next, thanks

Jason
